#MechaCarChallenge
#install packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("magrittr")
library("tidyverse")
library("dplyr")


#MPG Regression
#read csv file
mecha_mpg <- read.csv('mechaCar_mpg.csv') #import dataset
#The multiple linear regression statement:
lm(mpg ~ vehicle.length + vehicle.weight + spoiler.angle + ground.clearance + AWD,data=mecha_mpg) #generate multiple linear regression model
#Obtain Satistical Metrics
summary(lm(mpg ~ vehicle.length + vehicle.weight + spoiler.angle + ground.clearance + AWD,data=mecha_mpg) #generate multiple linear regression model
)


#Suspension Coil Summary
susp_coil <- read.csv('Suspension_Coil.csv') #import dataset

#Summarize grouped by Lot
summarize_coil_by_lot <-susp_coil  %>% group_by(Manufacturing_Lot) %>%summarize(Mean_Coil=mean(PSI),Median_Coil=median(PSI),StdDev=sd(PSI),Variance=var(PSI))
#Summarize entire population
summarize_coil <-susp_coil  %>% summarize(Mean_Coil=mean(PSI),Median_Coil=median(PSI),StdDev=sd(PSI),Variance=var(PSI))


#Plot population
plt <- ggplot(susp_coil,aes(x=log10(PSI))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#One-sample Student's T-test
sample_table <- susp_coil %>% sample_n(50) #randomly sample 50 data points
t.test(log10(sample_table$PSI),mu=mean(log10(susp_coil$PSI))) #compare sample vs population means




