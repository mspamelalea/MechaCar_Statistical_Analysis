plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot(fill = 'orange',color ='blue',outlier.color = 'red') + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot and rotate x-axis labels 45 degrees
mpg_summary <- mpg %>% group_by(class, year) %>% summarize(Mean_Hwy=mean(hwy))
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year),fill=Mean_Hwy))
plt + geom_tile() + labs(x="Vehicle Class",y="Vehicle 
Year",fill="Mean Highway (MPG)")

mpg_summary <- mpg %>% group_by(model, year) %>% summarize(Mean_Hwy=mean(hwy))
plt <- ggplot(mpg_summary, aes(x=model,y=year,fill=Mean_Hwy))
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + 
  theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5)) 

plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + #add boxplot
theme(axis.text.x=element_text(angle=45,hjust=1)) + #rotate x-axis labels 45 degrees
 geom_point() #overlay scatter plot on top

mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ)) #create summary table
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") #add scatter plot

mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ))
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + #add scatter plot with labels
 geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) #overlay with error bars

mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy)) #convert to long format
head(mpg_long)

plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot with labels rotated 45 degrees

plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + #create multiple boxplots, one for each MPG type
 theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels

plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=drv)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(drv)) + #create multiple boxplots, one for each MPG type
  theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels

#Qualitative Test for Normality
ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot

#Quantitative Test for Normality - Shapiro-Wilk test
shapiro.test(mtcars$wt)

library("ggplot2")
library("tidyverse")
#Sample the dataset
population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot
sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#One Sample T-test on Mileage
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) #compare sample versus population means

#Two Sample T-test
#Make to sample tables from population:
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points
#Samples should not be statistically different
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples

#Paired two-sided T-test
#generate samples:
mpg_data <- read.csv('mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008
#paired t-test
t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples

#ANOVA
#Clean the data
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
summary(aov(hp ~ cyl,data=mtcars_filt))

#Correlation
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot
#Quantify strength of the correlation
cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient

#used car example
used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F) #read in dataset
head(used_cars)
#test whether or not vehicle miles driven and selling price are correlated
plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import dataset into ggplot2
plt + geom_point() #create a scatter plot
#Can't really tell if they are correlated
#use the pearson correlation coefficient function
cor(used_cars$Miles_Driven,used_cars$Selling_Price) 

#Correlatin Matrix
#convert data frame into numeric matrix
used_matrix <- as.matrix(used_cars[,c("Selling_Price", "Present_Price", "Miles_Driven")])
cor(used_matrix)

#linear regression model
lm(qsec ~ hp,mtcars) 
#determine our p-value and our r-squared value for a simple linear regression model
summary(lm(qsec~hp,mtcars))
#visualize the fitted line against our dataset using ggplot2
model <- lm(qsec ~ hp,mtcars) 
yvals <- model$coefficients['hp']*mtcars$hp +
  model$coefficients['(Intercept)'] 
#plot the linear model over our scatter plot:
plt <- ggplot(mtcars,aes(x=hp,y=qsec))  #import dataset
plt + geom_point() + geom_line(aes(y=yvals), color = "red") 

#Multiple Linear Regression
lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model
summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars)) #generate summary statistics

#Chi-squared Test
tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distributions

