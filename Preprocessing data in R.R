# dataset : Wisconsin Breast Cancer dataset
# This dataset presents a classic binary classification problem: 
# 50% of the samples are benign, 50% are malignant, and the challenge is to identify which are which.

# Apply median imputation: model
model <- train(
  x = breast_cancer_x, y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = "medianImpute"
)

# Print model to console
model

# Apply KNN imputation: model2
model2 <- train(
  x = breast_cancer_x, y = breast_cancer_y,
  method = "glm",
  trControl = myControl,
  preProcess = "knnImpute"
)

# Print model to console
model2

# compare plot result for out of box samples
dotplot(resamples, metric = "ROC")