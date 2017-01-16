german_credit <-read.csv("C:/Users/manch/Desktop/german_credit.csv")
library(gmodels)
CrossTable(german_credit$Creditability)
CrossTable(german_credit$Creditability, german_credit$Account.Balance,digits = 1,prop.r=F, prop.t=F, prop.chisq=F, chisq=T)
CrossTable(german_credit$Creditability, german_credit$Payment.Status.of.Previous.Credit,digits = 1,prop.r=F, prop.t=F, prop.chisq=F, chisq=T)
CrossTable(german_credit$Creditability, german_credit$Length.of.current.employment,digits = 1,prop.r=F, prop.t=F, prop.chisq=F, chisq=T)

str(credit)

names(german_credit) <- gsub(".", "_", names(german_credit), fixed = TRUE)

german_credit$Creditability <- as.factor(german_credit$Creditability)
german_credit$Account_Balance <- as.factor(german_credit$Account_Balance)
german_credit$Payment_Status_of_Previous_Credit <- as.factor(german_credit$Payment_Status_of_Previous_Credit)
german_credit$Purpose <- as.factor(german_credit$Purpose)
german_credit$Value_Savings_Stocks <- as.factor(german_credit$Value_Savings_Stocks)
german_credit$Length_of_current_employment<- as.factor(german_credit$Length_of_current_employment)
german_credit$Instalment_percent<- as.factor(german_credit$Instalment_percent)
german_credit$Sex___Marital_Status<- as.factor(german_credit$Sex___Marital_Status)
german_credit$Guarantors<- as.factor(german_credit$Guarantors)
german_credit$Duration_in_Current_address<- as.factor(german_credit$Duration_in_Current_address)
german_credit$Most_valuable_available_asset<- as.factor(german_credit$Most_valuable_available_asset)
german_credit$Concurrent_Credits<- as.factor(german_credit$Concurrent_Credits)
german_credit$Type_of_apartment<- as.factor(german_credit$Type_of_apartment)
german_credit$No_of_Credits_at_this_Bank<- as.factor(german_credit$No_of_Credits_at_this_Bank)
german_credit$Occupation<- as.factor(german_credit$Occupation)
german_credit$No_of_dependents<- as.factor(german_credit$No_of_dependents)
german_credit$Telephone<- as.factor(german_credit$Telephone)
german_credit$Foreign_Worker<- as.factor(german_credit$Foreign_Worker)

library(ggplot2)
par(mfrow=c(1,1))
hist_1 <- hist(german_credit$Credit_Amount, breaks = 50)
hist_1 <- hist(german_credit$Age__years_)
hist_1 <- hist(german_credit$Duration_of_Credit__month_)

ggplot(german_credit, aes(x=german_credit$Creditability,y=german_credit$Credit_Amount )) + geom_boxplot()
ggplot(german_credit, aes(x=german_credit$Creditability,y=german_credit$Age__years_ )) + geom_boxplot()
ggplot(german_credit, aes(x=german_credit$Creditability,y=german_credit$Duration_of_Credit__month_ )) + geom_boxplot()

index_highage <- which(german_credit$Age__years_ > 70)
german_credit <- german_credit[-index_highage, ]

summary(german_credit)

table(german_credit$Purpose)

##### In case missing data is there..
## Look at summary of loan_data
#summary(loan_data$int_rate)
# Get indices of missing interest rates: na_index
#na_index <- which(is.na(loan_data$int_rate))
# Remove observations with missing interest rates: loan_data_delrow_na
#loan_data_delrow_na <- loan_data[-na_index, ]
# Make copy of loan_data
#loan_data_delcol_na <- loan_data
# Delete interest rate column from loan_data_delcol_na
# Compute the median of int_rate
#median_ir <- median(loan_data$int_rate, na.rm = TRUE)
# Make copy of loan_data
#loan_data_replace <- loan_data
# Replace missing interest rates with median
#loan_data_replace$int_rate[na_index] <- median_ir
# Check if the NAs are gone
#summary(loan_data_replace$int_rate)
#loan_data_delcol_na$int_rate <- NULL
# Make the necessary replacements in the coarse classification example below 
loan_data$ir_cat <- rep(NA, length(loan_data$int_rate))
loan_data$ir_cat[which(loan_data$int_rate <= 8)] <- "0-8"
loan_data$ir_cat[which(loan_data$int_rate > 8 & loan_data$int_rate <= 11)] <- "8-11"
loan_data$ir_cat[which(loan_data$int_rate > 11 & loan_data$int_rate <= 13.5)] <- "11-13.5"
loan_data$ir_cat[which(loan_data$int_rate > 13.5)] <- "13.5+"
loan_data$ir_cat[which(is.na(loan_data$int_rate))] <- "Missing"
loan_data$ir_cat <- as.factor(loan_data$ir_cat)
# Look at your new variable using plot()
plot(loan_data$ir_cat)


set.seed(453)
index_train <- sample(1:nrow(german_credit), 2 / 3 * nrow(german_credit))
training_set <- german_credit[index_train, ]
test_set <- german_credit[-index_train, ]
LogModel <- glm(Creditability ~ ., family=binomial, data = training_set)
LogModel
LogModel_pred <- predict(LogModel, test_set)
range(LogModel_pred)
pred_class <- ifelse(LogModel_pred>=0.7, 1,0)
table(pred_class,test_set$Creditability)
print(paste("Accuracy usind validation method is: ", 1-sum(pred_class!=test_set$Creditability)/nrow(test_set)))
library(pROC)
plot(ROC_logit)
auc(ROC_logit)



library("randomForest")


#RandomForest - Tuning the parameters using Cross-validation technique

ntree = c(600,700,800,900,1000)
mtry = c(11,12,13)
nodesize = c(4,5,6)
k=10
n=floor(nrow(german_credit)/k)
rf_accuracy_poss=c()
rf_accuracy_all=data.frame("No_of_Trees" = integer(0),"No_of_features"=integer(0),
                           "Nodesize" = integer(0), "Accuracy"= numeric(0))
#using 10-fold cross validation
for (t in ntree){
  for (m in mtry){
    for (n in nodesize){
      for (i in 1:k){
        s1 = ((i-1)*n+1)
        s2 = (i*n)
        subset = s1:s2
        rf_train<- german_credit[-subset,]
        rf_test<- german_credit[subset,]
        rf_fit<-randomForest(x=rf_train[,-c(1)], y = rf_train[,c(1)], 
                             ntree = t, mtry = m, nodesize = n)
        rf_pred <- predict(rf_fit, rf_test, type = "prob")[,2]
        rf_pred_class <- ifelse(rf_pred>0.5, 1, 0)
        rf_accuracy_poss[i]<- 1 - sum(rf_test$Creditability!=rf_pred_class)/nrow(rf_test)
      } 
      print(paste("number of trees: ",t,"number of features: ", m, "nodesize :", n,
                  "Cross-Validation mean Accuracy",mean(rf_accuracy_poss)))
      rf_accuracy_all<- rbind(rf_accuracy_all, data.frame(t,m,n,mean(rf_accuracy_poss)))
    }
  }
}

print("The best parameters and the accuracies are :")
rf_accuracy_all[rf_accuracy_all$mean.rf_accuracy_poss. == max(rf_accuracy_all$mean.rf_accuracy_poss.),]


#Building the model using the best parameters
k=10
n=floor(nrow(german_credit)/k)
rf_accuracy<-c()
for (i in 1:k){
  s1 = ((i-1)*n+1)
  s2 = (i*n)
  subset = s1:s2
  rf_train<- german_credit[-subset,]
  rf_test<- german_credit[subset,]
  rf_fit<-randomForest(x=rf_train[,-c(1)], y = rf_train[,c(1)],
                       ntree = 800,mtry = 12,nodesize = 12)
  rf_pred <- predict(rf_fit, rf_test, type = "prob")[,2]
  rf_pred_class <- ifelse(rf_pred>0.5, 1, 0)
  print(paste("RF Accuracy: ",1 - sum(rf_test$Creditability!=rf_pred_class)/nrow(rf_test)))
  rf_accuracy[i]<- 1- (sum(rf_test$Creditability!=rf_pred_class)/nrow(rf_test))
}

print(paste("The accuracy of the Random Forest is: ", mean(rf_accuracy)))

randomForest()
