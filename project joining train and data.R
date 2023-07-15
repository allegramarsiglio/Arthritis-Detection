# TRAINING DATA
reduced_training <- read.csv("/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/project-training.csv")
#View(reduced_training)
attach(reduced_training)
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
                       validation = 0,
                       colnames=T) 
detach(reduced_training)
# TEST DATA
reduced_test <- read.csv("/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/project-test.csv")
#View(reduced_test)
attach(reduced_test)
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
                           validation = 1,
                           colnames=T) 
detach(reduced_test)
reduced4_validation <- rbind(reduced4, reduced4test)
nrow(reduced4_validation)
write.csv(reduced4_validation, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced4_validation.csv', row.names = F)

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
                       validation = 0,
                       colnames=T) 
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
                           validation = 1,
                           colnames=T) 
detach(reduced_test)
reduced1_validation <- rbind(reduced1, reduced1test)
nrow(reduced1_validation)
write.csv(reduced1_validation, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/reduced1_validation.csv', row.names = F)

