##################### CS 699 TERM PROJECT

dataset_orig <- read.csv("/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/metcs699_Project_Assignment/project-2018-BRFSS-arthritis.csv")
dataset_orig <- as.data.frame(dataset_orig)
View(dataset_orig)


### DATA PREPROCESSING

# havarth3: verify that there are not cases that are out of interest, which are
#           BLANK (=not asked or missing), "9" (=refused), "7" (=don't know, not
#           sure)
table(dataset_orig$havarth3)

## Verify missing values
nrow(dataset_orig) #11933 tuples
nrow((dataset_orig[dataset_orig=="?",])) #14830 tuples --> something wrong (duplicates)


dataset_before_split <- dataset_orig
nrow(dataset_before_split)

# replace blank values with 'unknown'
dataset_before_split[dataset_before_split=='?'] <- 'unknown'

# CHECK VARIABLES ONE BY ONE

# x.aidtst3
table(dataset_before_split$x.aidtst3)
dataset_before_split$x.aidtst3 <- ifelse(dataset_before_split$x.aidtst3==9,
                                         'unknown', dataset_before_split$x.aidtst3)

# employ1
table(dataset_before_split$employ1) # OK
dataset_before_split$employ1 <- ifelse(dataset_before_split$employ1==9,
                                         'unknown', dataset_before_split$employ1)

# income2
table(dataset_before_split$income2) # 907-'77', 1117-'99'
# --> '77' and '99' take mean value (income is usually skewed)
nrow(dataset_before_split)
dataset_before_split$income2 <- ifelse(dataset_before_split$income==99|
                                         dataset_before_split$income==77, 
                                       'unknown', 
                                       dataset_before_split$income2)
x <- dataset_before_split$income2[dataset_before_split$income2!='unknown']
barplot(table(x))
# data is skewed --> assign MEDIAN to unknown
dataset_before_split$income2 <- ifelse(dataset_before_split$income=='unknown', 
                                       median(dataset_before_split$income2), 
                                       dataset_before_split$income2)

# weight2
table(dataset_before_split$weight2)
# --> 7777, 9999 'unknown'
# --> values >9000 turn to imperial
dataset_before_split$weight2 <- ifelse(dataset_before_split$weight2==7777|
                                         dataset_before_split$weight2==9999,
                                       'unknown',
                                       dataset_before_split$weight2)
dataset_before_split$weight2 <- ifelse(dataset_before_split$weight2!='unknown'&
                                         dataset_before_split$weight2>9000, 
                                       round(as.numeric(dataset_before_split$weight2
                                                  [2:4])*2.205), 
                                       dataset_before_split$weight2)
boxplot(as.numeric(dataset_before_split$weight2[dataset_before_split$weight2!='unknown']))
# slightly skewed --> use median ??
# dataset_before_split$weight2 <- ifelse(dataset_before_split$weight2=='unknown', 
#                                        median(as.numeric(dataset_before_split$weight2
#                                                          [dataset_before_split$weight2
#                                                            !='unknown'])), 
#                                        dataset_before_split$weight2)
# View(dataset_before_split[dataset_before_split$weight2=="776",])

# height3
table(dataset_before_split$height3)
# --> 7777, 9999 'unknown'
# --> values >9000 turn to imperial
dataset_before_split$height3 <- ifelse(dataset_before_split$height3==7777|
                                         dataset_before_split$height3==9999,
                                       'unknown',
                                       dataset_before_split$height3)
dataset_before_split$height3 <- ifelse(dataset_before_split$height3!='unknown'&
                                         as.numeric(dataset_before_split$height3)>9000, 
                                       (((as.numeric(dataset_before_split$height3)-9000) / 2.54) / 12 - (((as.numeric(dataset_before_split$height3)-9000) / 2.54) / 12 - (as.integer(((as.numeric(dataset_before_split$height3)-9000) / 2.54) / 12)) * 100)) + round(((as.numeric(dataset_before_split$height3)-9000) / 2.54) / 12 - as.integer(((as.numeric(dataset_before_split$height3)-9000) / 2.54) / 12))
                                       ,
                                       dataset_before_split$height3)
# CM TO FT&INCH CONVERSION (Format YXX where Y is ft and XX is inches from 1 to 12)
# cm=170
# inches=cm/2.54
# ft=inches/12
# ft
# decimal=ft-as.integer(ft)
# round(decimal)
# ft_n_inch=(ft-decimal)*100+round(decimal)
# ft_n_inch
# ft_n_inch=((cm / 2.54) / 12 - ((cm / 2.54) / 12 - (as.integer((cm / 2.54) / 12)) * 100)) + round((cm / 2.54) / 12 - as.integer((cm / 2.54) / 12))
# ft_n_inch


# children
table(dataset_before_split$children)
# --> change 88 to 0
# --> change 99 and ? to 'unknown'
dataset_before_split$children <- ifelse(dataset_before_split$children==88, 0, 
                               dataset_before_split$children)
dataset_before_split$children <- ifelse(dataset_before_split$children==99|
                                 dataset_before_split$children=='?', 'unknown', 
                               dataset_before_split$children)

# veteran3
table(dataset_before_split$veteran3)
# --> change 7 and 9 to 'unknown'
dataset_before_split$veteran3 <- ifelse(dataset_before_split$veteran3==7|
                                          dataset_before_split$veteran3==9,
                                        'unknown', dataset_before_split$veteran3)

# blind
table(dataset_before_split$blind)
dataset_before_split$blind <- ifelse(dataset_before_split$blind==7|
                                          dataset_before_split$blind==9,
                                        'unknown', dataset_before_split$blind)

# renthom1
table(dataset_before_split$renthom1)
dataset_before_split$renthom1 <- ifelse(dataset_before_split$renthom1==7|
                                       dataset_before_split$renthom1==9,
                                     'unknown', dataset_before_split$renthom1)
# sex1
table(dataset_before_split$sex1)
dataset_before_split$sex1 <- ifelse(dataset_before_split$sex1==7|
                                          dataset_before_split$sex1==9,
                                        'unknown', dataset_before_split$sex1)

# marital
table(dataset_before_split$marital)
dataset_before_split$marital <- ifelse(dataset_before_split$marital==9,
                                    'unknown', dataset_before_split$marital)

# educa
table(dataset_before_split$educa)
dataset_before_split$educa <- ifelse(dataset_before_split$educa==9,
                                       'unknown', dataset_before_split$educa)

# deaf
table(dataset_before_split$deaf)
dataset_before_split$deaf <- ifelse(dataset_before_split$deaf==7|
                                      dataset_before_split$deaf==9,
                                    'unknown', dataset_before_split$deaf)

# decide
table(dataset_before_split$decide)
dataset_before_split$decide <- ifelse(dataset_before_split$decide==7|
                                      dataset_before_split$decide==9,
                                    'unknown', dataset_before_split$decide)

# flushot6
table(dataset_before_split$flushot6)
dataset_before_split$flushot6 <- ifelse(dataset_before_split$flushot6==7|
                                        dataset_before_split$flushot6==9,
                                      'unknown', dataset_before_split$flushot6)

# seatbelt
table(dataset_before_split$seatbelt)
dataset_before_split$seatbelt <- ifelse(dataset_before_split$seatbelt==7|
                                          dataset_before_split$seatbelt==9,
                                        'unknown', dataset_before_split$seatbelt)
dataset_before_split$seatbelt <- ifelse(dataset_before_split$seatbelt==8,
                                        'not applicable', dataset_before_split$seatbelt)

# employ1
table(dataset_before_split$employ1)
dataset_before_split$employ1 <- ifelse(dataset_before_split$employ1==9,
                                         'unknown', dataset_before_split$employ1)

# hivtst6
table(dataset_before_split$hivtst6)
dataset_before_split$hivtst6 <- ifelse(dataset_before_split$hivtst6==7|
                                          dataset_before_split$hivtst6==9,
                                        'unknown', dataset_before_split$hivtst6)

# hivrisk5
table(dataset_before_split$hivrisk5)
dataset_before_split$hivrisk5 <- ifelse(dataset_before_split$hivrisk5==7|
                                         dataset_before_split$hivrisk5==9,
                                       'unknown', dataset_before_split$hivrisk5)

# pneuvac4
table(dataset_before_split$pneuvac4)
dataset_before_split$pneuvac4 <- ifelse(dataset_before_split$pneuvac4==7|
                                          dataset_before_split$pneuvac4==9,
                                        'unknown', dataset_before_split$pneuvac4)

# alcday5
table(dataset_before_split$alcday5)
dataset_before_split$alcday5 <- ifelse(dataset_before_split$alcday5==777|
                                          dataset_before_split$alcday5==999,
                                        'unknown', dataset_before_split$alcday5)
dataset_before_split$alcday5 <- ifelse(dataset_before_split$alcday5==888,
                                       0, dataset_before_split$alcday5)

# diffwalk
table(dataset_before_split$diffwalk)
dataset_before_split$diffwalk <- ifelse(dataset_before_split$diffwalk==7|
                                          dataset_before_split$diffwalk==9,
                                        'unknown', dataset_before_split$diffwalk)

# usenow3
table(dataset_before_split$usenow3)
dataset_before_split$usenow3 <- ifelse(dataset_before_split$usenow3==7|
                                          dataset_before_split$usenow3==9,
                                        'unknown', dataset_before_split$usenow3)

# diffdres
table(dataset_before_split$diffdres)
dataset_before_split$diffdres <- ifelse(dataset_before_split$diffdres==7|
                                         dataset_before_split$diffdres==9,
                                       'unknown', dataset_before_split$diffdres)

# diffalon
table(dataset_before_split$diffalon)
dataset_before_split$diffalon <- ifelse(dataset_before_split$diffalon==7|
                                          dataset_before_split$diffalon==9,
                                        'unknown', dataset_before_split$diffalon)

# smoke100
table(dataset_before_split$smoke100)
dataset_before_split$smoke100 <- ifelse(dataset_before_split$smoke100==7|
                                          dataset_before_split$smoke100==9,
                                        'unknown', dataset_before_split$smoke100)

# rmvteth4
table(dataset_before_split$rmvteth4)
dataset_before_split$rmvteth4 <- ifelse(dataset_before_split$rmvteth4==7|
                                          dataset_before_split$rmvteth4==9,
                                        'unknown', dataset_before_split$rmvteth4)

# lastden4
table(dataset_before_split$lastden4)
dataset_before_split$lastden4 <- ifelse(dataset_before_split$lastden4==7|
                                          dataset_before_split$lastden4==9,
                                        'unknown', dataset_before_split$lastden4)

# diabete3
table(dataset_before_split$diabete3)
dataset_before_split$diabete3 <- ifelse(dataset_before_split$diabete3==7|
                                          dataset_before_split$diabete3==9,
                                        'unknown', dataset_before_split$diabete3)

# x.psu
table(dataset_before_split$x.psu) #oK

# physhlth
table(dataset_before_split$physhlth)
dataset_before_split$physhlth <- ifelse(dataset_before_split$physhlth==77|
                                          dataset_before_split$physhlth==99,
                                        'unknown', dataset_before_split$physhlth)
dataset_before_split$physhlth <- ifelse(dataset_before_split$physhlth==88,
                                        0, dataset_before_split$physhlth)

# menthlth
table(dataset_before_split$menthlth)
dataset_before_split$menthlth <- ifelse(dataset_before_split$menthlth==77|
                                          dataset_before_split$menthlth==99,
                                        'unknown', dataset_before_split$menthlth)
dataset_before_split$menthlth <- ifelse(dataset_before_split$menthlth==88,
                                        0, dataset_before_split$menthlth)

# hlthpln1
table(dataset_before_split$hlthpln1)
dataset_before_split$hlthpln1 <- ifelse(dataset_before_split$hlthpln1==7|
                                          dataset_before_split$hlthpln1==9,
                                        'unknown', dataset_before_split$hlthpln1)

# genhlth
table(dataset_before_split$genhlth)
dataset_before_split$genhlth <- ifelse(dataset_before_split$genhlth==7|
                                          dataset_before_split$genhlth==9,
                                        'unknown', dataset_before_split$genhlth)

# dispcode
table(dataset_before_split$dispcode) #OK 
 
# chckdny1
table(dataset_before_split$chckdny1)  
dataset_before_split$chckdny1 <- ifelse(dataset_before_split$chckdny1==7|
                                         dataset_before_split$chckdny1==9,
                                       'unknown', dataset_before_split$chckdny1)

# iyear
table(dataset_before_split$iyear) #OK 

# fmonth
table(dataset_before_split$fmonth) #OK 

# imonth
table(dataset_before_split$imonth) #OK 

# iday 
table(dataset_before_split$iday) #OK 

# persdoc2"  "
table(dataset_before_split$persdoc2) 
dataset_before_split$persdoc2 <- ifelse(dataset_before_split$persdoc2==7|
                                          dataset_before_split$persdoc2==9,
                                        'unknown', dataset_before_split$persdoc2)

# medcost"   "
table(dataset_before_split$medcost) 
dataset_before_split$medcost <- ifelse(dataset_before_split$medcost==7|
                                          dataset_before_split$medcost==9,
                                        'unknown', dataset_before_split$medcost)

# checkup1
table(dataset_before_split$checkup1) 
dataset_before_split$checkup1 <- ifelse(dataset_before_split$checkup1==7|
                                         dataset_before_split$checkup1==9,
                                       'unknown', dataset_before_split$checkup1)

# exerany2
table(dataset_before_split$exerany2) 
dataset_before_split$exerany2 <- ifelse(dataset_before_split$exerany2==7|
                                          dataset_before_split$exerany2==9,
                                        'unknown', dataset_before_split$exerany2)

# chcocncr" 
table(dataset_before_split$chcocncr) 
dataset_before_split$chcocncr <- ifelse(dataset_before_split$chcocncr==7|
                                          dataset_before_split$chcocncr==9,
                                        'unknown', dataset_before_split$chcocncr)

# chccopd1"  "
table(dataset_before_split$chccopd1) 
dataset_before_split$chccopd1 <- ifelse(dataset_before_split$chccopd1==7|
                                          dataset_before_split$chccopd1==9,
                                        'unknown', dataset_before_split$chccopd1)

# addepev2"  "
table(dataset_before_split$addepev2) 
dataset_before_split$addepev2 <- ifelse(dataset_before_split$addepev2==7|
                                          dataset_before_split$addepev2==9,
                                        'unknown', dataset_before_split$addepev2)

# chcscncr"  "
table(dataset_before_split$chcscncr) 
dataset_before_split$chcscncr <- ifelse(dataset_before_split$chcscncr==7|
                                          dataset_before_split$chcscncr==9,
                                        'unknown', dataset_before_split$chcscncr)

# asthma3"   "
table(dataset_before_split$asthma3) 
dataset_before_split$asthma3 <- ifelse(dataset_before_split$asthma3==7|
                                          dataset_before_split$asthma3==9,
                                        'unknown', dataset_before_split$asthma3)

# cvdstrk3" 
table(dataset_before_split$cvdstrk3) 
dataset_before_split$cvdstrk3 <- ifelse(dataset_before_split$cvdstrk3==7|
                                         dataset_before_split$cvdstrk3==9,
                                       'unknown', dataset_before_split$cvdstrk3)

# sleptim1"  "
table(dataset_before_split$sleptim1) 
dataset_before_split$sleptim1 <- ifelse(dataset_before_split$sleptim1==77|
                                          dataset_before_split$sleptim1==99,
                                        'unknown', dataset_before_split$sleptim1)

# cvdinfr4
table(dataset_before_split$cvdinfr4) 
dataset_before_split$cvdinfr4 <- ifelse(dataset_before_split$cvdinfr4==7|
                                          dataset_before_split$cvdinfr4==9,
                                        'unknown', dataset_before_split$cvdinfr4)

# cvdcrhd4
table(dataset_before_split$cvdcrhd4) 
dataset_before_split$cvdcrhd4 <- ifelse(dataset_before_split$cvdcrhd4==7|
                                          dataset_before_split$cvdcrhd4==9,
                                        'unknown', dataset_before_split$cvdcrhd4)

# qstver
table(dataset_before_split$qstver) #OK

# qstlang  
table(dataset_before_split$qstlang) #OK

# x.metstat
table(dataset_before_split$x.metstat) #OK

# htin4"     
table(dataset_before_split$htin4) #OK

# wtkg3"     "
table(dataset_before_split$wtkg3) #OK

# x.bmi5"    "
table(dataset_before_split$x.bmi5) #OK

# x.bmi5cat"
table(dataset_before_split$x.bmi5cat) #OK

# htm4"      "
table(dataset_before_split$htm4) #OK

# x.age.g"   "
table(dataset_before_split$x.age.g) #OK

# x.raceg21" "
table(dataset_before_split$x.raceg21) 
dataset_before_split$x.raceg21 <- ifelse(dataset_before_split$x.raceg21==9,
                                        'unknown', dataset_before_split$x.raceg21)

# x.age80"   "
table(dataset_before_split$x.age80) #OK

# x.race.g1"
table(dataset_before_split$x.race.g1) #OK

# x.ageg5yr" "
table(dataset_before_split$x.ageg5yr) #OK

# x.age65yr" "
table(dataset_before_split$x.age65yr) #OK

# x.rfbmi5"  "
table(dataset_before_split$x.rfbmi5) 
dataset_before_split$x.rfbmi5 <- ifelse(dataset_before_split$x.rfbmi5==9,
                                         'unknown', dataset_before_split$x.rfbmi5)

# x.chldcnt" "
table(dataset_before_split$x.chldcnt) 
dataset_before_split$x.chldcnt <- ifelse(dataset_before_split$x.chldcnt==9,
                                        'unknown', dataset_before_split$x.chldcnt)

# x.educag" 
table(dataset_before_split$x.educag) 
dataset_before_split$x.educag <- ifelse(dataset_before_split$x.educag==9,
                                         'unknown', dataset_before_split$x.educag)

# x.incomg"  "
table(dataset_before_split$x.incomg) 
dataset_before_split$x.incomg <- ifelse(dataset_before_split$x.incomg==9,
                                        'unknown', dataset_before_split$x.incomg)

# x.rfdrhv6" "
table(dataset_before_split$x.rfdrhv6) 
dataset_before_split$x.rfdrhv6 <- ifelse(dataset_before_split$x.rfdrhv6==9,
                                        'unknown', dataset_before_split$x.rfdrhv6)

# x.rfseat2" "
table(dataset_before_split$x.rfseat2) 
dataset_before_split$x.rfseat2 <- ifelse(dataset_before_split$x.rfseat2==9,
                                         'unknown', dataset_before_split$x.rfseat2)

# x.rfseat3" "
table(dataset_before_split$x.rfseat3) 
dataset_before_split$x.rfseat3 <- ifelse(dataset_before_split$x.rfseat3==9,
                                         'unknown', dataset_before_split$x.rfseat3)

# x.drnkwek"
table(dataset_before_split$x.drnkwek) 
dataset_before_split$x.drnkwek <- ifelse(dataset_before_split$x.drnkwek==99900,
                                         'unknown', dataset_before_split$x.drnkwek)

# x.rfbing5" "
table(dataset_before_split$x.rfbing5) 
dataset_before_split$x.rfbing5 <- ifelse(dataset_before_split$x.rfbing5==9,
                                         'unknown', dataset_before_split$x.rfbing5)

# drocdy3."  "
table(dataset_before_split$drocdy3.) 
dataset_before_split$drocdy3. <- ifelse(dataset_before_split$drocdy3.==7|
                                          dataset_before_split$drocdy3.==9,
                                        'unknown', dataset_before_split$drocdy3.)

# x.smoker3" "
table(dataset_before_split$x.smoker3) 
dataset_before_split$x.smoker3 <- ifelse(dataset_before_split$x.smoker3==9,
                                        'unknown', dataset_before_split$x.smoker3)

# x.rfsmok3" "
table(dataset_before_split$x.rfsmok3) 
dataset_before_split$x.rfsmok3 <- ifelse(dataset_before_split$x.rfsmok3==9,
                                         'unknown', dataset_before_split$x.rfsmok3)

# drnkany5" 
table(dataset_before_split$drnkany5) 
dataset_before_split$drnkany5 <- ifelse(dataset_before_split$drnkany5==7|
                                          dataset_before_split$drnkany5==9,
                                         'unknown', dataset_before_split$drnkany5)

# x.racegr3" "
table(dataset_before_split$x.racegr3) 
dataset_before_split$x.racegr3 <- ifelse(dataset_before_split$x.racegr3==9,
                                         'unknown', dataset_before_split$x.racegr3)

# x.race"    "
table(dataset_before_split$x.race) 
dataset_before_split$x.race <- ifelse(dataset_before_split$x.race==9,
                                         'unknown', dataset_before_split$x.race)

# x.urbstat" "
table(dataset_before_split$x.urbstat)  #OK

# x.chispnc" "
table(dataset_before_split$x.chispnc)  
dataset_before_split$x.chispnc <- ifelse(dataset_before_split$x.chispnc==9,
                                      'unknown', dataset_before_split$x.chispnc)

# x.llcpwt2"
table(dataset_before_split$x.llcpwt2)  #OK

# x.llcpwt"  "
table(dataset_before_split$x.llcpwt)  #OK

# x.rfhlth"  "
table(dataset_before_split$x.rfhlth)  
dataset_before_split$x.rfhlth <- ifelse(dataset_before_split$x.rfhlth==9,
                                         'unknown', dataset_before_split$x.rfhlth)

# x.dualuse" "
table(dataset_before_split$x.dualuse)  
dataset_before_split$x.dualuse <- ifelse(dataset_before_split$x.dualuse==9,
                                        'unknown', dataset_before_split$x.dualuse)

# x.imprace" "
table(dataset_before_split$x.imprace)  #OK

# x.hispanc"
table(dataset_before_split$x.hispanc)  #OK
dataset_before_split$x.hispanc <- ifelse(dataset_before_split$x.hispanc==9,
                                         'unknown', dataset_before_split$x.hispanc)

# x.wt2rake" "
table(dataset_before_split$x.wt2rake)  #OK

# x.ststr"   "
table(dataset_before_split$x.ststr)  #OK

# x.strwt"   "
table(dataset_before_split$x.llcpwt2)  #OK

# x.rawrake" "
table(dataset_before_split$x.rawrake)  #OK

# x.phys14d"
table(dataset_before_split$x.phys14d)  
dataset_before_split$x.phys14d <- ifelse(dataset_before_split$x.phys14d==9,
                                         'unknown', dataset_before_split$x.phys14d)

# x.ment14d" "
table(dataset_before_split$x.ment14d)  
dataset_before_split$x.ment14d <- ifelse(dataset_before_split$x.ment14d==9,
                                         'unknown', dataset_before_split$x.ment14d)

# x.hcvu651" "
table(dataset_before_split$x.hcvu651)  
dataset_before_split$x.hcvu651 <- ifelse(dataset_before_split$x.hcvu651==9,
                                         'unknown', dataset_before_split$x.hcvu651)

# x.totinda" "
table(dataset_before_split$x.totinda)  
dataset_before_split$x.totinda <- ifelse(dataset_before_split$x.totinda==9,
                                         'unknown', dataset_before_split$x.totinda)

# x.denvst3" "
table(dataset_before_split$x.denvst3)  
dataset_before_split$x.denvst3 <- ifelse(dataset_before_split$x.denvst3==9,
                                         'unknown', dataset_before_split$x.denvst3)

# x.prace1" 
table(dataset_before_split$x.prace1)  #OK
dataset_before_split$x.prace1 <- ifelse(dataset_before_split$x.prace1==77|
                                          dataset_before_split$x.prace1==99,
                                        'unknown', dataset_before_split$x.prace1)
# x.mrace1"  "
table(dataset_before_split$x.mrace1)  #OK
dataset_before_split$x.mrace1 <- ifelse(dataset_before_split$x.mrace1==77|
                                          dataset_before_split$x.mrace1==99,
                                        'unknown', dataset_before_split$x.mrace1)
# x.exteth3" "
table(dataset_before_split$x.exteth3)  #OK
dataset_before_split$x.exteth3 <- ifelse(dataset_before_split$x.exteth3==9,
                                         'unknown', dataset_before_split$x.exteth3)

# x.asthms1" "
table(dataset_before_split$x.asthms1)  #OK
dataset_before_split$x.asthms1 <- ifelse(dataset_before_split$x.asthms1==9,
                                         'unknown', dataset_before_split$x.asthms1)

# x.michd"   "
table(dataset_before_split$x.michd)  #OK

# x.ltasth1"
table(dataset_before_split$x.ltasth1)  #OK
dataset_before_split$x.ltasth1 <- ifelse(dataset_before_split$x.ltasth1==9,
                                         'unknown', dataset_before_split$x.ltasth1)

# x.casthm1" "
table(dataset_before_split$x.casthm1)  #OK
dataset_before_split$x.casthm1 <- ifelse(dataset_before_split$x.casthm1==9,
                                         'unknown', dataset_before_split$x.casthm1)

# x.state"   "
table(dataset_before_split$x.state)  #OK

# havarth3" 
table(dataset_before_split$havarth3)  #OK




nrow(dataset_before_split)
colnames(dataset_before_split)

View(dataset_before_split)


# SAVE FILE 
write.csv(dataset_before_split, '/Users/allegramarsiglio/Desktop/BU/CS699 Data Mining/Term Project/preprocessed_data.csv', row.names = F)




