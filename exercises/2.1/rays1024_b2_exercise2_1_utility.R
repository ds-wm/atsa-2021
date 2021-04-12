# Merge a list of dataframes
merged <- function(DF_list){
  combined <- Reduce(function(x, y) merge(x, y, all = TRUE), DF_list)
  combined$result_time<-strptime(combined$result_time, format='%Y-%m-%d %H:%M:%S')
  combined[order(combined$result_time),]
  if (length(combined)==13){
    combined<-combined[-c(2,3)]
  }
  return(combined)
}
# Remove duplicates
deduped <- function(DF){
  deduped <- DF[c(as.integer(rownames(unique(DF[,2:11])))),]
  deduped<-deduped[-c(which(deduped$voltage<=2600)),]
  return(deduped)
}
# Convert units
calcSwp <- function(rawWP){
  a=0.000048
  b=0.0846
  c=39.45
  if (rawWP<591||rawWP>841){
    calWP=0
  }
  else{
    calWP=-1.0*exp((a*rawWP*rawWP)-(b*rawWP)+c)
  }
  return(calWP)
}

calcVwc <- function(rawSM){
  a=0.00119
  b=0.401
  
  if (rawSM<337||rawSM>841){
    calSM=0
  }
  else{
    calSM=a*rawSM-b
  }
  return(calSM)
}
# Aggregate by time
time <- function(DF,minutes){
  temp<-merged(list(data.frame(),DF[1,]))
  timed<-merged(list(data.frame(),DF[1,]))
  empty<-DF[1,]
  empty[1,2:11]<-NA
  t0<-strptime("2010-05-29 07:00:00", "%Y-%m-%d %H:%M:%S")+minutes*60
  for (i in 1:nrow(DF)){
    if (difftime(t0,DF[i,'result_time'],units='mins')>=0){
      temp<-merged(list(temp,DF[i,]))
    }
    else {
      df<-data.frame(t(data.frame(colMeans(temp[2:11]))))
      df$result_time<-t0-minutes*60
      df<-df[,c(11,1:10)]
      timed<-merged(list(timed,df))
      temp<-merged(list(data.frame(),DF[i,]))
      temp<-merged(list(temp,DF[i,]))
      t0=t0+minutes*60
    }
    while (difftime(DF[i,'result_time'],t0,units='mins')>minutes){
      empty$result_time<-t0
      timed<-merged(list(timed,empty))
      t0=t0+minutes*60
    }
  }
  return(timed)
}