# The churn dataset contains data on a variety of telecom customers and 
# the modeling challenge is to predict which customers will cancel their service (or churn).

# Create custom indices: myFolds
myFolds <- createFolds(churn_y, k = 5)

# Create reusable trainControl object: myControl
myControl <- trainControl(
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE,
  savePredictions = TRUE,
  index = myFolds
)

# Fit the baseline model
# Fit glmnet model: model_glmnet
model_glmnet <- train(
  x = churn_x, y = churn_y,
  metric = "ROC",
  method = "glmnet",
  trControl = myControl
)

# Random forest with custom trainControl, Use of 'ranger' package
# Fit random forest: model_rf
model_rf <- train(
  x = churn_x, y = churn_y,
  metric = "ROC",
  method = "ranger",
  trControl = myControl
)

# Create a resamples object, comparing multiple models
# Create model_list
model_list <- list(item1 = model_glmnet, item2 = model_rf)

# Pass model_list to resamples(): resamples
resamples <- resamples(model_list)

# Summarize the results
summary(resamples)

# Create a box-and-whisker plot
# box-and-whisker plot, allows you to compare the distribution of predictive accuracy (in this case AUC) for the two models.
# note : model with the higher median AUC, as well as a smaller range between min and max AUC.

# Create bwplot
bwplot(resamples, metric = "ROC")

# Create a scatterplot
# note :  particularly useful for identifying if one model is consistently better than the other across all folds,
# or if there are situations when the inferior model produces better predictions on a particular subset of the data.

# Create xyplot
xyplot(resamples, metric ="ROC")

# note : 'caretEnsemble' provides the caretList() function for creating multiple caret models at once on the same dataset.
# Create ensemble model: stack
stack <- caretStack(model_list, method = "glm")

# Look at summary
summary(stack)