### cleaning up the three text matching tables and making a nice user friendly website display


#read in the tables
onetbgt<-read.csv("ONETxBGT.csv",header=T)
onetva<-read.csv("ONETxVA.csv",header=T)
vabgt<-read.csv("VAxBGT.csv",header=T)

#purge the columns we don't want to display
head(onetbgt)
onetbgt<-onetbgt[,c(2,3,5,7,8)]
head(onetbgt)
colnames(onetbgt)<-c("ONET SOC","ONET Certification","Confidence of Match","Burning Glass SOC","Burning Glass Certification")
onetbgt<-onetbgt[,c(1,2,3,5,4)]
#purge the rows where ONET SOC == ONET Cert because those are "generics"; size was inititally 10776 rows
onetbgt<-onetbgt[onetbgt$'ONET SOC'!=onetbgt$'ONET Certification',]
# now has 8226 rows

#remove SOCS
onetbgt<-onetbgt[,c(2,3,4)]
onetbgt<-onetbgt[!duplicated(onetbgt[c(1,3)]),] #finally, 1381

head(onetbgt[order(onetbgt$`Confidence of Match`,decreasing=TRUE),])
onetxbgt<-onetbgt[order(onetbgt$`Confidence of Match`,decreasing=TRUE),]
write.csv(onetxbgt,"onetxbg.csv")
hist(onetbgt$'Confidence of Match')
nrow(onetbgt[onetbgt$'Confidence of Match'>0.4,])





#playing
onetbgt<-read.csv("ONETxBGT.csv",header=T)
confbysoc<-onetbgt[,c(5,7)]
confbysoc$SOCGroup<-substr(confbysoc$SOC,1,2)
boxplot(confidence_cert~SOCGroup,confbysoc,xlab="Occupational Group",ylab="Confidence of Match",
        main="Confidence of Credential Match (BGT to O*NET) by Occupational Group",col=c("#282c4c","#E87404"))
abline(h=median(confbysoc$confidence_cert),col="red")
