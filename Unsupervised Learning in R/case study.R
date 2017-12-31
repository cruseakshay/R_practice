# first step is to download and prepare the data.
# dataset : Wisconsin breast cancer data
url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1903/datasets/WisconsinCancer.csv"

# Download the data: wisc.df
wisc.df <- read.csv(url)

# Convert the features of the data: wisc.data
wisc.data <- as.matrix(wisc.df[, 3:32])

# Set the row names of wisc.data
row.names(wisc.data) <- wisc.df$id

# Create diagnosis vector
diagnosis <- as.numeric(wisc.df$diagnosis == "M")

#Explore the data to answer the following questions:

# How many observations are in this dataset?
# How many variables/features in the data are suffixed with _mean?
# How many of the observations have a malignant diagnosis?
# ans : 569, 10, 212

# note : two common reasons for scaling data:

# 1. The input variables use different units of measurement.
# 2. The input variables have significantly different variances.

# Check column means and standard deviations
colMeans(wisc.data)
apply(wisc.data , 2, sd)

# Execute PCA, scaling if appropriate: wisc.pr
wisc.pr <- prcomp(wisc.data, scale = TRUE)

# Look at summary of results
summary(wisc.pr)

# Interpreting PCA results
# What stands out to you about this plot? Is it easy or difficult to understand? Why?
# Create a biplot of wisc.pr
biplot(wisc.pr)

# Scatter plot observations by components 1 and 2
plot(wisc.pr$x[, c(1, 2)], col = (diagnosis + 1), 
     xlab = "PC1", ylab = "PC2")

# Repeat for components 1 and 3
plot(wisc.pr$x[, c(1, 3)], col = (diagnosis + 1), 
     xlab = "PC1", ylab = "PC3")

# Do additional data exploration of your choosing below (optional)
plot(wisc.pr$x[, c(1, 4)], col = (diagnosis + 1), 
     xlab = "PC1", ylab = "PC4")
# ans : Because principal component 2 explains more variance in the original data than principal component 3,
# first plot has a cleaner cut separating the two subgroups.

# scree plots showing the proportion of variance explained as the number of principal components increases.
# note : ask if there's an elbow in the amount of variance explained that might lead to pick a natural number of principal components.
# Set up 1 x 2 plotting grid
par(mfrow = c(1, 2))

# Calculate variability of each component
pr.var <- wisc.pr$sdev^2

# Variance explained by each principal component: pve
pve <- pr.var/sum(pr.var)

# Plot variance explained for each principal component
plot(pve, xlab = "Principal Component", 
     ylab = "Proportion of Variance Explained", 
     ylim = c(0, 1), type = "b")

# Plot cumulative proportion of variance explained
# note : cumsum() to create,  plot of cumulative proportion of variance explained.
plot(cumsum(pve), xlab = "Principal Component", 
     ylab = "Cumulative Proportion of Variance Explained", 
     ylim = c(0, 1), type = "b")

# For the first principal component, what is the component of the loading vector for the feature concave.points_mean? 
# ans : -0.26085376

# Hierarchical clustering of case data
# Scale the wisc.data data: data.scaled
data.scaled <- scale(wisc.data)

# Calculate the (Euclidean) distances: data.dist
data.dist <- dist(data.scaled)

# Create a hierarchical clustering model: wisc.hclust
wisc.hclust <- hclust(data.dist, method = "complete")

# what is the height at which the clustering model has 4 clusters?
# ans : 20 (using plot function on model)

# Cut tree so that it has 4 clusters: wisc.hclust.clusters
wisc.hclust.clusters <- cutree(wisc.hclust, k = 4)

# Compare cluster membership to actual diagnoses
table(wisc.hclust.clusters, diagnosis)

# k-means clustering and comparing results
# Create a k-means model on wisc.data: wisc.km
wisc.km <- kmeans(scale(wisc.data), centers = 2, nstart = 20)

# Compare k-means to actual diagnoses
# How well does k-means separate the two diagnoses?
table(wisc.km$cluster, diagnosis)

# Compare k-means to hierarchical clustering
table(wisc.km$cluster, wisc.hclust.clusters)

# ans : Looking at the second table generated, 
# it looks like clusters 1, 2, and 4 from the hierarchical clustering model can be interpreted as the cluster 1 equivalent from the k-means algorithm,
# and cluster 3 can be interpreted as the cluster 2 equivalent.

# Clustering on PCA results
# how using PCA affects the model? 
# Create a hierarchical clustering model: wisc.pr.hclust
wisc.pr.hclust <- hclust(dist(wisc.pr$x[, 1:7]), method = "complete")

# Cut model into 4 clusters: wisc.pr.hclust.clusters
wisc.pr.hclust.clusters <- cutree(wisc.pr.hclust, k = 4)

# Compare to actual diagnoses
table(wisc.pr.hclust.clusters, diagnosis)
table(wisc.hclust.clusters, diagnosis)
# Compare to k-means and hierarchical
table(wisc.km$cluster, diagnosis)