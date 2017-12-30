# Hierarchical clustering with results
# Create hierarchical clustering model: hclust.out
hclust.out <- hclust(d = dist(x))

# Inspect the result
summary(hclust.out)

# cutree() is the R function that cuts a hierarchical model. 
# The h and k arguments to cutree() allow you to cut the tree based on a certain height h or a certain number of clusters k.
