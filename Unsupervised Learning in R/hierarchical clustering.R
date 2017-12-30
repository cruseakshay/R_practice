# Hierarchical clustering with results
# Create hierarchical clustering model: hclust.out
hclust.out <- hclust(d = dist(x))

# Inspect the result
summary(hclust.out)

# note : cutree() is the R function that cuts a hierarchical model. 
# The h and k arguments to cutree() allow you to cut the tree based on a certain height h or a certain number of clusters k.

# Cut by height
cutree(hclust.out, h = 7)

# Cut by number of clusters
cutree(hclust.out, k = 3)

# Linkage methods
# Cluster using complete linkage: hclust.complete
hclust.complete <- hclust(dist(x), method = "complete")

# Cluster using average linkage: hclust.average
hclust.average <- hclust(dist(x), method = "average")

# Cluster using single linkage: hclust.single
hclust.single <- hclust(dist(x), method = "single")

# Plot dendrogram of hclust.complete
plot(hclust.complete, main = "Complete")

# Plot dendrogram of hclust.average
plot(hclust.average, main = "Average")

# Plot dendrogram of hclust.single
plot(hclust.single, main = "Single")

# scaling
# note : clustering real data may require scaling the features if they have different distributions.
# View column means
colMeans(pokemon)

# View column standard deviations
apply(pokemon, 2, sd)

# Scale the data
pokemon.scaled <- scale(pokemon)

# Create hierarchical clustering model: hclust.pokemon
hclust.pokemon <- hclust(dist(pokemon.scaled), method = "complete")

# Comparing kmeans() and hclust()
# Apply cutree() to hclust.pokemon: cut.pokemon
cut.pokemon <- cutree(hclust.pokemon, k = 3)

# Compare methods
table(cut.pokemon, km.pokemon$cluster)