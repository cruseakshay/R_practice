# What is text mining?
# ans : Text mining is the process of distilling actionable insights from text.

# Load qdap
library(qdap)

# Print new_text to the console
new_text

# Find the 10 most frequent terms: term_count
term_count <- freq_terms(new_text, 4)

# Plot term_count
plot(term_count)