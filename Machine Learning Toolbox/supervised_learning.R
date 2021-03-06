# Take datasets from https://www.datacamp.com/courses/machine-learning-toolbox
#Try a 60/40 split
# Shuffle row indices: rows
rows <- sample(nrow(Sonar))

# Randomly order data: Sonar
Sonar <- Sonar[rows, ]

# Identify row to split on: split
split <- round(nrow(Sonar) * .60)

# Create train
train <- Sonar[1:split, ]

# Create test
test <- Sonar[(split+1):nrow(Sonar), ]

#Fit a logistic regression model
# Fit glm model: model
model <- glm(Class ~ . ,family="binomial", data=train)

# Predict on test: p
p <- predict(model, test, type = "response")

#Calculate a confusion matrix
# Calculate class probabilities: p_class
p_class <- ifelse(p > 0.50, "M", "R")

# Create confusion matrix
confusionMatrix(p_class, test[["Class"]])

#Try another threshold
# Apply threshold of 0.9: p_class is class probabilities
p_class <- ifelse(p > 0.90, "M", "R")

# Create confusion matrix
confusionMatrix(p_class, test[["Class"]])

#From probabilites to confusion matrix
# Apply threshold of 0.10: p_class
p_class <- ifelse(p > 0.10, "M", "R")

# Create confusion matrix
confusionMatrix(p_class, test[["Class"]])

# Predict on test: p
p <- predict(model, test, type = "response")

# Make ROC curve # Create trainControl object: myControl

myControl <- trainControl(
  method = "cv",
  number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)
#caTools package for colAUC()
colAUC(p, test[["Class"]], plotROC = TRUE)

#AUC - Area Under Curve:: single-number summary of a model's ability to discriminate the positive from the negative class.

# Create trainControl object: myControl
myControl <- trainControl(
  method = "cv",
  number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)

# Using custom trainControl
# Train glm with custom trainControl: model
model <- train(Class ~ ., method = "glm", Sonar, trControl=myControl)

# Print model to console
model

# Fit a random forest
# Fit random forest: model
model <- train(
  quality ~ .,
  tuneLength = 1,
  data = wine, method = "ranger",
  trControl = trainControl(method = "cv", number = 5, verboseIter = TRUE)
)

# Print model to console
model

# Hyper parameter tuning 
# Fit random forest: model
model <- train(
  quality ~ .,
  tuneLength = 3,
  data = wine, method = "ranger",
  trControl = trainControl(method = "cv", number = 5, verboseIter = TRUE)
)

# Print model to console
model

# Plot model
plot(model) 

#Fit a random forest with custom tuning
# Fit random forest: model
model <- train(
  quality ~ .,
  tuneGrid = data.frame(mtry = c(2,3,7)),
  data = wine, method = "ranger",
  trControl = trainControl(method = "cv", number = 5, verboseIter = TRUE)
)

# Print model to console
model

# Plot model
plot(model)

#using glmnet
# Create custom trainControl: myControl
myControl <- trainControl(
  method = "cv", number = 10,
  summaryFunction = twoClassSummary,
  classProbs = TRUE, # IMPORTANT!
  verboseIter = TRUE
)

#Fit glmnet with custom trainControl
# glmnet is an extention of the generalized linear regression model (or glm) that places constraints on the magnitude of the coefficients to prevent overfitting.
# Ridge regression (or alpha = 0)
# Lasso regression (or alpha = 1)

# Fit glmnet model: model
model <- train(
  y ~ . , overfit,
  method = "glmnet",
  trControl = myControl
)

# Print model to console
model

# Print maximum ROC statistic
max(model[["results"]])

# Tuning parameters in glmnet.
# Train glmnet with custom trainControl and tuning: model
model <- train(
  y ~ ., overfit,
  tuneGrid = expand.grid(alpha = 0:1, lambda = seq(0.0001, 1, length = 20)),
  method = "glmnet",
  trControl = myControl
)

# Print model to console
model

# Print maximum ROC statistic
max(model[["results"]][["ROC"]])
