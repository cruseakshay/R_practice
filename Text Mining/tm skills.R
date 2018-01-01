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