# Distance matrix and dendrogram
# Create dist_rain
dist_rain <- dist(rain$rainfall)

# View the distance matrix
dist_rain

# Create hc
hc <- hclust(dist_rain)

# Plot hc
plot(hc, labels = rain$city)

# Make a distance matrix and dendrogram from a TDM
# Why adjust the sparsity of the TDM/DTM? --> TDMs and DTMs are sparse, meaning they contain mostly zeros,
# and also easy interpretion of dendrogram

# Print the dimensions of tweets_tdm
dim(tweets_tdm)

# Create tdm1
tdm1 <- removeSparseTerms(tweets_tdm, sparse = 0.95)

# Create tdm2
tdm2 <- removeSparseTerms(tweets_tdm, sparse = 0.975)

# Print tdm1
tdm1

# Print tdm2
tdm2

# a text based dendrogram
# note : A peculiarity of TDM and DTM objects is that you have to convert them first to matrices (with as.matrix()),
# then to data frames (with as.data.frame()), before using them with the dist() function.

# Create tweets_tdm2
tweets_tdm2 <- removeSparseTerms(tweets_tdm, sparse = 0.975)

# Create tdm_m
tdm_m <- as.matrix(tweets_tdm2)

# Create tdm_df
tdm_df <- as.data.frame(tdm_m)

# Create tweets_dist
tweets_dist <- dist(tdm_df)

# Create hc
hc <- hclust(tweets_dist)

# Plot the dendrogram
plot(hc)

# Dendrogram aesthetics
# Load dendextend
library(dendextend)

# Create hc
hc <- hclust(tweets_dist)

# Create hcd
hcd <- as.dendrogram(hc)

# Print the labels in hcd
labels(hcd)

# Change the branch color to red for "marvin" and "gaye"
branches_attr_by_labels(hcd, c("marvin", "gaye"), color = "red")

# Plot hcd
plot(hcd, main = "Better Dendrogram")

# Add cluster rectangles 
rect.dendrogram(hcd,k = 2, border = "grey50")