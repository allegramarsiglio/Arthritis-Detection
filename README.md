# Arthritis-Detection

### Introduction
In this report I am going to build and test classification models on part of the 2018 BRFSS Survey Data prepared by CDC. This dataset contains data collected from noninstitutionalized adult population (≥ 18 years) residing in the United States, which is surveyed on health-related risk behaviors, chronic health conditions, health care access, and use of preventive services.
The questionnaires are composed of three parts. First, there is a core component, which includes questions that should be administered by all states and includes both demographic questions (such as type of employment, income, marital status,…) and questions about current health-related perceptions, conditions, and behaviors (such as health status, health care access and alcohol/tobacco consumption). Then there are optional BRFSS modules which states can elect whether to include or not, containing questions about specific topics such as diabetes, sugar-sweetened beverages, excess sun exposure, and cancer survivorship. Finally, there are state added questions, which we won’t take into consideration because they are independently developed and tracked by each state and are therefore not included in the above-mentioned dataset. 
The sampled version of the 2018 BRFSS Survey Data I will consider for this project has 11,933 tuples and 108 attributes, with each tuple being a person who participated on the survey. Each attribute represents an answer to a survey question. I will consider as the class attribute the attribute called havart3, which answers the following survey question:

“(Ever told) you have some form of arthritis, rheumatoid arthritis, gout, lupus, or fibromyalgia? (Arthritis diagnoses include: rheumatism, polymyalgia rheumatica; osteoarthritis (not osteporosis); tendonitis, bursitis, bunion, tennis elbow; carpal tunnel syndrome, tarsal tunnel syndrome; joint infection, etc.)”

In the sample I am considering, the attributes can take on just two values: 1 – Yes – and 2 – No. In other words, the value of 1 means that the person was ever told to have some form of arthritis, rheumatoid arthritis, gout, lupus, or fibromyalgia. 

### Data preprocessing
A fundamental step to begin with when analyzing a dataset is data preprocessing, which consists of improving the quality of the data so to have a more efficient and smooth mining process. Measures for data quality include accuracy, completeness, consistency, timeliness, believability, and interpretability of data. In my analysis, I will assume most of these measures were already assessed by the CDC when publishing the data. In particular, I will assume that the data is consistent, trustable, timely updated, and mostly correct. Therefore, my major task in this data preprocessing phase will involve verifying data completeness and interpretability. 
The first thing to be noticed in the dataset is that it contains many uncomplete/missing data. I will fill in each blank data with the global constant “unknown”, so to make data more consistent and easier to understand. Once I will get rid of all the missing values, I will further proceed with the cleaning of data by inquiring each attribute one by one.
After a careful inspection of all attributes and their related cases, I could determine that some major adjustments were necessary before starting with the analysis. Here is a summary of the cleaning process I developed:
1.	Many attributes had “Don’t Know/Not sure” or “Refused” values: for the purpose of this study, I grouped them all together as “unknown” values, together with the blank values.
2.	Some numeric variables (e.g. attribute “children”, answering the survey question “How many children less than 18 years of age live in your household?”) were assigned a numeric value (e.g. 88 for the attribute “children”) to indicate the “None” response. I substituted the coded value with “0”, so to give the possibility to find an average number of dependent children (of <18 years) per adult.
3.	The attributes “weight2” and “height3” had values in both imperial and metric measures. In order to have uniform values, I used conversion formulas to transform metric values into imperial. 
4.	Following the first adjustment, the “income2” attribute had approximately 18% of tuples listed as “unknown”. To overcome this incompleteness, I decided to fill in these missing values with the attribute median value of the remaining tuples.  

### Training and Test Datasets
Since the main purpose of this research is to both develop and test different classification models, I will divide now the preprocessed data into a training dataset and a test dataset. I will assign approximately 66% of tuples of the initial dataset to the training dataset, and I will use the remaining tuples to test the models. 

### Attribute Selection
In order to build classification models, I should choose among the 108 available attributes which of these are the most pertinent for the analysis. In order to do so, I will use five different attribute selection methods, which I will describe below. 
1.	Correlation based feature selection: consists of selecting those attributes whose correlation with the output class is higher. For my model, I will use the Ranker search method and I will select the first 10 attributes ranked by correlation. 
2.	Information gain based feature selection: consists of selecting those attributes whose information gain, or entropy, is higher. For my model, I will use the Ranker search method and I will select the first 10 attributes ranked by information gain. 
3.	Gain ratio based feature selection: consists of selecting those attributes whose gain ratio is higher. For my model, I will use the Ranker search method and I will select the first 10 attributes ranked by gain ratio.
4.	Learner based feature selection - Wrapper selection: consists of evaluating attributes from a learning scheme and selecting those highly evaluated. For my model, I will use the wrapper with the J48 classifier with the Greedy Stepwise (forward) search method, and use the attributes automatically selected by it. 
5.	Correlation based feature subset selection: consists of selecting those attributes that have higher individual predictive ability and lower degree of redundancy (in other words, attributes that have high correlation with the class while low intercorrelation). For my model, I will use the Greedy Stepwise (forward) search method, and use the attributes automatically selected by it. 

Using these attribute selection methods, I created the following subsets of data:
•	Subset 1: 
o	Attribute selection method: Correlation based feature selection
o	10 selected attributes: {x.age80, diffwalk, x.rfhlth, x.hcvu651, pneuvac4, x.exteth3, chccopd1, employ1, x.phys14d, diabete3}
•	Subset 2:
o	Attribute selection method: Information gain based feature selection
o	10 selected attributes: { x.bmi5, x.ageg5yr, employ1, diffwalk, genhlth, x.hcvu651, physhlth, pneuvac4, rmvteth4, x.rfhlth}
•	Subset 3:
o	Attribute selection method: Gain ratio based feature selection
o	10 selected attributes: {diffwalk, chccopd1, x.rfhlth, x.age65yr, chckdny1, x.hcvu651, employ1, diffdres, cvdcrhd4, pneuvac4}
•	Subset 4:
o	Attribute selection method: Learner based feature selection - Wrapper selection
o	13 selected attributes: {employ1, pneuvac4, diffwalk, rmvteth4, diabete3, genhlth, chckdny1, persdoc2, checkup1, chccopd1, x.age.g, x.rfhlth, x.phys14d}
•	Subset 5:
o	Attribute selection method: Correlation based feature subset selection
o	12 selected attributes: {diffwalk, lastden4, chccopd1, cvdinfr4, qstver, qstlang, x.age.g, x.rfdrhv6, x.rfhlth, x.phys14d, x.mrace1, x.casthm1}

I used Weka-3.8.6 to perform the attribute selection, and Rstudio to create the training and test datasets for each subset. 

### Classifier Algorithms 
Now, data is ready to be processed and I can start building classifier models. On each of the 5 subsets of data I created, I will use 5 different classification algorithms to generate prediction rules on the training data. The classifier models I will build, and ultimately test, are the following:
1.	Naïve-Bayes: predicts class membership based on Bayes’ Theorem and assuming class conditional independence. It computes the conditional probability that a sample belongs to each class given that sample, and predicts that the class label of the sample is the class giving the highest probability. 
2.	Boosted Tree: constructs a predictive model by building a large additive decision tree that is a sequence of smaller decision trees. Each tree adjusts weights based on the misclassification of the previous one.
3.	Neural Network: applies flexible functions to inputs, which are assigned weights in each connection between the input layer, the output layer, and the one or more hidden layers that are in between (network). The network learns by adjusting ways in an iterative  and backpropagated manner.
4.	Support Vector Machine: a predictive model that finds a decision boundary called hyperplane that separates tuples (which are the support vectors) into classes.
5.	Bootstrap Forest: constructs a predictive model by averaging the values predicted by multiple decision trees that use a bootstrap training set drawn from the full data. 

I am going to apply the algorithms using JMP Pro 16. 

### Testing and Evaluating the Classifiers
After having generated the prediction formulas with each classifier model on each of the subsets, I will apply these rules on the test datasets and, based on the results, I will assess each classifier’s performance. I will evaluate each model by using the weighted average over the two classes of each of the following performance measures: TP rate, FP rate, precision, recall, F-measure,  and MCC. Finally, I will choose as a best model, the model that presents the best performance measures.

### Models Summary
If I compare each classifier model with the other classifiers in classifying one subset at a time, the classifiers that has overall the best performance is the Support Vector Machine. However, the performance of the other four classifiers differs substantially across the five different subsets. Indeed, some classifiers that are performing very well in some subsets are also performing much worse in others. For example, the bootstrap forest produced the one of the best performance measures for subset 5, but at the same time resulted as the poorest classifier for subset 2.
By comparing the 25 models all together, the classifier that seems to perform best is the Support Vector Machine. I would not say there is a worse classifier, but one thing to note is that the Naïve-Bayes returns the greatest false positive rates.  
The latter comparison also allows to notice how the attribute selection technique may have a strong influence in the models’ performance. For instance, subset 2 contains the poorest measures overall, while subset 1 and subset 4 perform pretty well. With this regard, I would also like to underline that the Neural Network model could not classify all tuples in subset 2, while its performance was good across most subsets. 

### Best Model
The model that gave me the best performance is the Wrapper attribute selection method with a Support Vector Machine algorithm. To recap, the Wrapper method selected 13 attributes, which are: {employ1, pneuvac4, diffwalk, rmvteth4, diabete3, genhlth, chckdny1, persdoc2, checkup1, chccopd1, x.age.g, x.rfhlth, x.phys14d}. Below you can find the results produced by the model.

Confusion matrix:
	Predicted	 
	1	2	Total
Actual	1	649	720	1369
	2	289	2399	2688
 	Total	938	3119	4057

Performance measures:
Class	TP Rate	FP Rate	Precision	Recall	F-measure	MCC	ROC  area
1	0.47406866	0.26785714	0.69189765	0.47406866	0.56263546	0.41109761	0.7663
2	0.89248512	0.21110299	0.76915678	0.89248512	0.82624419	0.41109761	0.7663
Weighted Avg.	0.75129406	0.2302542	0.74308635	0.75129406	0.73729167	0.41109761	0.7663

ROC curve:
 
![image](https://github.com/allegramarsiglio/Arthritis-Detection/assets/92153587/51861257-6eae-4e98-87ac-5d863ae90e3f)


### Discussion
Before examining the models, it is important to specify that, in the dataset we are using, a class imbalance problem is present, since the main class of interest is rare. Indeed, the majority of the tuples belong to class “2”, which, recall, is the negative class. Class “1”, which is the positive class, indicating those people ever told to have some form of arthritis, rheumatoid arthritis, gout, lupus, or fibromyalgia, is instead the minority class. Therefore, it is important to consider both how well the models classify positive tuples and how well they can recognize negative tuples. 
The performance measures I used to evaluate the model are taking into consideration the class imbalance problem. While accuracy may not be effective in this case, precision and recall are widely used measure when dealing with imbalanced data. Precision is a measure of exactness, saying what percentage of tuples labeled as positive are actually such. Recall, instead, is a measure of completeness: it gives the percentage of positive tuples that are labeled as such. Both precision and recall have perfect value when they are equal to 1. The closer their value to zero, the higher the number of misclassified tuples (false positive tuples for precision, false negative tuples for recall). 
Other appropriate measures when dealing with imbalanced data are the F-measure and the Matthew Correlation Coefficient (MCC) measure. The F-measure is the harmonic-mean of precision and recall, and therefore allows to use the two measures simultaneously for comparison. The MCC measure instead is probably the most reliable measure for binary class datasets because it counts for the quality of both the negative cases and the positive cases, independently of their ratios in the overall dataset.
In assessing my models, my evaluation criteria, therefore, dedicate particular attention to the MCC measure, but also rely on the F-measure. Additionally, I decided to first choose one best classifier model for each subset and I then make a comparison of the best 5 methods. I will finally compare the error rates of the best two models to choose my best model overall.

After having carefully reviewed all my models, here below you can find a table summarizing the weighted average of the performance measures of the best five models I chose.
Subset	Model	TP Rate	FP Rate	Precision	Recall	F-measure	MCC
1	SVM	0.7503	0.2397	0.7416	0.7503	0.7382	0.4110
2	SVM	0.7464	0.2338	0.7375	0.7464	0.7314	0.3980
3	NEURAL NETWORK	0.7390	0.2322	0.7295	0.7390	0.7207	0.3762
4	SVM	0.7513	0.2303	0.7431	0.7513	0.7373	0.4111
5	BOOTSTRAP FOREST	0.7419	0.2601	0.7324	0.7419	0.7317	0.3941

By comparing these results, I identified the two best models, which you can find marked in italics in the table. Since the performance measures are all very close to one another, I will use the error rates of the two models to make a comparison. In this case, I won’t need to perform hypothesis testing on the error rates, thanks to the nature of the classifier used (which both models share). For the first model, the error rate is 0.2497, while for the second model the error rate is 0.2487. Since the first model has a slightly higher error, I will choose the second as my best model.

Conclusions
In conclusion, the wrapper attribute selection method with a Support Vector Machine algorithm gave me the best performance. The model produced the best TP rate, the least FP rate, the best Precision the best Recall, the best MCC, and the second-best F-measure. 
Overall, I think the 5 most relevant attributes were age (x.age80), walking or climbing stairs difficulties (diffwalk), adults with good or better health (x.rfhlth), chronic obstructive pulmonary disease, emphysema or chronic bronchitis (chccopd1), and employment status (employ1). Indeed, these attributes were selected by either every or almost every attribute selection I used. Additionally, they were also among the first ranked in the methods using ranked search methods. 
From this project I learned that the data mining process can be tedious and present unexpected issues to deal with. Data formatting can influence a lot predictive analysis, so it is important to dedicate a good amount of both time and attention during the data preprocessing phase. Moreover, I learned the importance of choosing an appropriate attribute selection method. Inappropriate methods could significantly drop the performance evaluation measures of your models, make classifiers unable to predict classes for all tuples, as it happened to me with subset 2. Finally, data evaluation can seem a lot at the beginning, but finding a method to go over all the methods you created in an ordinate way can become an essential step to not lose track on anything. I think this project could really give me a good idea of how a data mining process as a whole can look like in real life situations. Academically speaking, it really helped me a lot in creating links among the course topics and modules. Therefore, I found this work not only a great opportunity to approach the working world, but also as a very insightful and enriching experience. 


Appendix
Attribute Selection Methods- Results
 
 

 
 
 

Classifier Models
Subset 1
NAIVE BAYES	Predicted	 
	1	2	Total
Actual	1	940	429	1369
	2	657	2031	2688
 	Total	1597	2460	4057

BOOSTSTRAP FOREST 	Predicted	 
	1	2	Total
Actual	1	713	656	1369
	2	387	2301	2688
 	Total	1100	2957	4057

SUPPORT VECTOR MACHINE	Predicted	 
	1	2	Total
Actual	1	670	699	1369
	2	314	2374	2688
 	Total	984	3073	4057

BOOSTED TREE	Predicted	 
	1	2	Total
Actual	1	643	726	1369
	2	319	2369	2688
 	Total	962	3095	4057

NEURAL NETWORK	Predicted	 
	1	2	Total
Actual	1	730	639	1369
	2	387	2301	2688
 	Total	1117	2940	4057

AVERAGE MEASURES	TP Rate	FP Rate	Precision	Recall	F-measure	MCC
NAIVE-BAYES	0.7323	0.3718	0.7456	0.7323	0.7367	0.4280
BOOTSTRAP FOREST	0.7429	0.2696	0.7343	0.7429	0.7350	0.4008
SVM	0.7503	0.2397	0.7416	0.7503	0.7382	0.4110
BOOSTED TREE	0.7424	0.2455	0.7327	0.7424	0.7290	0.3902
NEURAL NETWORK	0.7471	0.2675	0.7391	0.7471	0.7399	0.4121

Subset 2
NAIVE BAYES	Predicted	 
	1	2	Total
Actual	1	840	502	1342
	2	602	2086	2688
 	Total	1442	2588	4030

BOOSTSTRAP FOREST 	Predicted	 
	1	2	Total
Actual	1	555	814	1369
	2	418	2270	2688
 	Total	973	3084	4057

SUPPORT VECTOR MACHINE	Predicted	 
	1	2	Total
Actual	1	632	737	1369
	2	292	2396	2688
 	Total	924	3133	4057

BOOSTED TREE	Predicted	 
	1	2	Total
Actual	1	657	712	1369
	2	372	2316	2688
 	Total	1029	3028	4057

NEURAL NETWORK
(!)NOT PREDICTING EVERY TUPLE	Predicted	
	1	2	Total
Actual	1	627	625	1252
	2	326	2211	2537
 	Total	953	2836	3789

AVERAGE MEASURES	TP Rate	FP Rate	Precision	Recall	F-measure	MCC
NAIVE-BAYES	0.7261	0.3614	0.7316	0.7261	0.7284	0.3952
BOOTSTRAP FOREST	0.6963	0.3045	0.6802	0.6963	0.6811	0.2767
SVM	0.7464	0.2338	0.7375	0.7464	0.7314	0.3980
BOOSTED TREE	0.7328	0.2694	0.7222	0.7328	0.7218	0.3711

Subset 3
NAIVE BAYES	Predicted	 
	1	2	Total
Actual	1	865	504	1369
	2	654	2034	2688
 	Total	1519	2538	4057

BOOSTSTRAP FOREST 	Predicted	 
	1	2	Total
Actual	1	586	783	1369
	2	296	2391	2687
 	Total	882	3174	4056

SUPPORT VECTOR MACHINE	Predicted	 
	1	2	Total
Actual	1	562	807	1369
	2	273	2415	2688
 	Total	835	3222	4057

BOOSTED TREE	Predicted	 
	1	2	Total
Actual	1	571	798	1369
	2	293	2395	2688
 	Total	864	3193	4057

NEURAL NETWORK	Predicted	 
	1	2	Total
Actual	1	587	782	1369
	2	277	2411	2688
 	Total	864	3193	4057

AVERAGE MEASURES	TP Rate	FP Rate	Precision	Recall	F-measure	MCC
NAIVE-BAYES	0.7146	0.3798	0.7231	0.7146	0.7179	0.3796
BOOTSTRAP FOREST	0.7340	0.2416	0.7233	0.7340	0.7162	0.3644
SVM	0.7338	0.2334	0.7237	0.7338	0.7136	0.3613
BOOSTED TREE	0.7311	0.2420	0.7200	0.7311	0.7122	0.3558
NEURAL NETWORK	0.7390	0.2322	0.7295	0.7390	0.7207	0.3762

Subset 4
NAIVE BAYES	Predicted	 
	1	2	Total
Actual	1	880	489	1369
	2	546	2142	2688
 	Total	1426	2631	4057

BOOSTSTRAP FOREST 	Predicted	 
	1	2	Total
Actual	1	707	662	1369
	2	375	2313	2688
 	Total	1082	2975	4057

SUPPORT VECTOR MACHINE	Predicted	 
	1	2	Total
Actual	1	649	720	1369
	2	289	2399	2688
 	Total	938	3119	4057

BOOSTED TREE	Predicted	 
	1	2	Total
Actual	1	663	706	1369
	2	335	2353	2688
 	Total	998	3059	4057

NEURAL NETWORK	Predicted	 
	1	2	Total
Actual	1	770	599	1369
	2	447	2241	2688
 	Total	1217	2840	4057

AVERAGE MEASURES	TP Rate	FP Rate	Precision	Recall	F-measure	MCC
NAIVE-BAYES	0.7449	0.3256	0.7477	0.7449	0.7461	0.4354
BOOTSTRAP FOREST	0.7444	0.2646	0.7356	0.7444	0.7359	0.4030
SVM	0.7513	0.2303	0.7431	0.7513	0.7373	0.4111
BOOSTED TREE	0.7434	0.2508	0.7338	0.7434	0.7316	0.3949
NEURAL NETWORK	0.7422	0.2915	0.7363	0.7422	0.7381	0.4088

Subset 5
NAIVE BAYES	Predicted	 
	1	2	Total
Actual	1	775	594	1369
	2	500	2188	2688
 	Total	1275	2782	4057

BOOSTSTRAP FOREST 	Predicted	 
	1	2	Total
Actual	1	681	688	1369
	2	359	2329	2688
 	Total	1040	3017	4057

SUPPORT VECTOR MACHINE	Predicted	 
	1	2	Total
Actual	1	560	809	1369
	2	237	2451	2688
 	Total	797	3260	4057

BOOSTED TREE	Predicted	 
	1	2	Total
Actual	1	643	726	1369
	2	341	2347	2688
 	Total	984	3073	4057

NEURAL NETWORK	Predicted	 
	1	2	Total
Actual	1	597	772	1369
	2	299	2389	2688
 	Total	896	3161	4057

	TP Rate	FP Rate	Precision	Recall	F-measure	MCC
NAIVE-BAYES	0.7303	0.3166	0.7262	0.7303	0.7279	0.3871
BOOTSTRAP FOREST	0.7419	0.2601	0.7324	0.7419	0.7317	0.3941
SVM	0.7422	0.2163	0.7352	0.7422	0.7205	0.3819
BOOSTED TREE	0.7370	0.2562	0.7265	0.7370	0.7243	0.3782
NEURAL NETWORK	0.7360	0.2416	0.7256	0.7360	0.7191	0.3703

