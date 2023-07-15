##################### CS 699 TERM PROJECT
### ATTRIBUTE SELECTION

# TRAINING DATA
reduced_training <- read.csv("/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/project-training.csv")
#View(reduced_training)
attach(reduced_training)

reduced1 <- data.frame(x.age80,
                       diffwalk, 
                       x.rfhlth,
                       x.hcvu651,
                       pneuvac4,
                       x.exteth3,
                       chccopd1, 
                       employ1,
                       x.phys14d,
                       diabete3,
                       havarth3,
                       colnames=T) 
#View(reduced1)

reduced2 <- data.frame(x.bmi5,
                       x.ageg5yr, 
                       employ1,
                       diffwalk,
                       genhlth,
                       x.hcvu651,
                       physhlth,
                       pneuvac4,
                       rmvteth4,
                       x.rfhlth,
                       havarth3,
                       colnames=T) 
#View(reduced2)

reduced3 <- data.frame(diffwalk,
                       chccopd1,
                       x.rfhlth,
                       x.age65yr,
                       chckdny1,
                       x.hcvu651,
                       employ1,
                       diffdres,
                       cvdcrhd4,
                       pneuvac4,
                       havarth3,
                       colnames=T) 
#View(reduced3)

reduced4 <- data.frame(employ1,
                       pneuvac4,
                       diffwalk,
                       rmvteth4,
                       diabete3,
                       genhlth,
                       chckdny1,
                       persdoc2,
                       checkup1,
                       chccopd1,
                       x.age.g,
                       x.rfhlth,
                       x.phys14d,
                       havarth3,
                       colnames=T) 
#View(reduced4)

reduced5 <- data.frame(diffwalk,
                       lastden4,
                       chccopd1,
                       cvdinfr4,
                       qstver,
                       qstlang,
                       x.age.g,
                       x.rfdrhv6,
                       x.rfhlth,
                       x.phys14d,
                       x.mrace1,
                       x.casthm1,
                       havarth3,
                       colnames=T) 
#View(reduced5)

write.csv(reduced1, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-training-dataset-1.csv', row.names = F)
write.csv(reduced2, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-training-dataset-2.csv', row.names = F)
write.csv(reduced3, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-training-dataset-3.csv', row.names = F)
write.csv(reduced4, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-training-dataset-4.csv', row.names = F)
write.csv(reduced5, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-training-dataset-5.csv', row.names = F)

detach(reduced_training)


# TEST DATA
reduced_test <- read.csv("/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/project-test.csv")
#View(reduced_test)
attach(reduced_test)

reduced1test <- data.frame(x.age80,
                           diffwalk, 
                           x.rfhlth,
                           x.hcvu651,
                           pneuvac4,
                           x.exteth3,
                           chccopd1, 
                           employ1,
                           x.phys14d,
                           diabete3,
                           havarth3,
                           colnames=T) 
View(reduced1test)

reduced2test <- data.frame(x.bmi5,
                           x.ageg5yr, 
                           employ1,
                           diffwalk,
                           genhlth,
                           x.hcvu651,
                           physhlth,
                           pneuvac4,
                           rmvteth4,
                           x.rfhlth,
                           havarth3,
                           colnames=T) 
#View(reduced2test)

reduced3test <- data.frame(diffwalk,
                           chccopd1,
                           x.rfhlth,
                           x.age65yr,
                           chckdny1,
                           x.hcvu651,
                           employ1,
                           diffdres,
                           cvdcrhd4,
                           pneuvac4,
                           havarth3,
                           colnames=T) 
#View(reduced3test)

reduced4test <- data.frame(employ1,
                           pneuvac4,
                           diffwalk,
                           rmvteth4,
                           diabete3,
                           genhlth,
                           chckdny1,
                           persdoc2,
                           checkup1,
                           chccopd1,
                           x.age.g,
                           x.rfhlth,
                           x.phys14d,
                           havarth3,
                           colnames=T) 
#View(reduced4test)

reduced5test <- data.frame(diffwalk,
                           lastden4,
                           chccopd1,
                           cvdinfr4,
                           qstver,
                           qstlang,
                           x.age.g,
                           x.rfdrhv6,
                           x.rfhlth,
                           x.phys14d,
                           x.mrace1,
                           x.casthm1,
                           havarth3,
                           colnames=T) 
#View(reduced5test)

write.csv(reduced1test, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-test-dataset-1.csv', row.names = F)
write.csv(reduced2test, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-test-dataset-2.csv', row.names = F)
write.csv(reduced3test, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-test-dataset-3.csv', row.names = F)
write.csv(reduced4test, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-test-dataset-4.csv', row.names = F)
write.csv(reduced5test, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced-test-dataset-5.csv', row.names = F)

detach(reduced_test)

nrow(reduced1)
nrow(reduced2)
nrow(reduced3)
nrow(reduced4)
nrow(reduced5)
nrow(reduced1test)
nrow(reduced2test)
nrow(reduced3test)
nrow(reduced4test)
nrow(reduced5test)



