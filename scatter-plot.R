age_1=ChickWeight$Time[ChickWeight$Chick==1]
age_1
weight_1= ChickWeight$weight[ChickWeight$Chick==1]
weight_1
plot(age_1,weight_1, main="Scatter plot of weight vs age- 1st chick",
    xlab ="Age",
    ylab="Weight",
    col="red")