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

# note : it's very important to use the argument stringsAsFactors = FALSE
# Import text data
tweets <- read.csv("coffee.csv", stringsAsFactors = FALSE)

# View the structure of tweets
str(tweets)

# Print out the number of rows in tweets
nrow(tweets)

# Isolate text from tweets: coffee_tweets
coffee_tweets <- tweets$text

# note : convert vector containing the text data to a corpus.
# corpus is a collection of documents, but it's also important to know that in the text mining domain, R recognizes it as a data type.
# There are two kinds of the corpus data type, the permanent corpus, PCorpus, and the volatile corpus, VCorpus.
# use VectorSource() because text data is contained in a vector. The output of this function is called a Source object.

# Load tm
library(tm)

# Make a vector source: coffee_source
coffee_source <- VectorSource(coffee_tweets)

# The VCorpus object is a nested list, or list of lists. At each index of the VCorpus object, there is a PlainTextDocument object, 
# which is essentially a list that contains the actual text data (content), as well as some corresponding metadata (meta). 
# It can help to visualize a VCorpus object to conceptualize the whole thing.

## coffee_source is already in your workspace

# Make a volatile corpus: coffee_corpus
coffee_corpus <- VCorpus(coffee_source)

# Print out coffee_corpus
coffee_corpus

# Print data on the 15th tweet in coffee_corpus
coffee_corpus[[15]]

# Print the content of the 15th tweet in coffee_corpus
coffee_corpus[[15]][1]

# Print example_text to the console
example_text

# For text data in DataFrames.
# Create a DataframeSource on columns 2 and 3: df_source
df_source <- DataframeSource(example_text[, 2:3])

# Convert df_source to a corpus: df_corpus
df_corpus <- VCorpus(df_source)

# Examine df_corpus
df_corpus

# Create a VectorSource on column 3: vec_source
vec_source <- VectorSource(example_text[, 3])

# Convert vec_source to a corpus: vec_corpus
vec_corpus <- VCorpus(vec_source)

# Examine vec_corpus
vec_corpus

# Common cleaning functions from tm

# Create the object: text
text <- "<b>She</b> woke up at       6 A.M. It\'s so early!  She was only 10% awake and began drinking coffee in front of her computer."

# All lowercase
tolower(text)

# Remove punctuation
removePunctuation(text)

# Remove numbers
removeNumbers(text)

# Remove whitespace
stripWhitespace(text)

# Cleaning with qdap
## text is still loaded in your workspace

# Remove text within brackets
bracketX(text)

# Replace numbers with words
replace_number(text)

# Replace abbreviations
replace_abbreviation(text)

# Replace contractions
replace_contraction(text)

# Replace symbols with words
replace_symbol(text)

## text is preloaded into your workspace

# List standard English stop words
stopwords("en")

# Print text without standard stop words
removeWords(text, stopwords("en"))

# Add "coffee" and "bean" to the list: new_stops
new_stops <- c("coffee", "bean", stopwords("en"))

# Remove stop words from text
removeWords(text, new_stops)

# another useful preprocessing step involves word stemming and stem completion.
# Create complicate
complicate <- c("complicated", "complication", "complicatedly")

# Perform word stemming: stem_doc
stem_doc <- stemDocument(complicate)

# Create the completion dictionary: comp_dict
comp_dict <- c("complicate")

# Perform stem completion: complete_text 
complete_text <- stemCompletion(stem_doc, comp_dict)

# Print complete_text
complete_text

# IMPORTANT for sentenses !
# Remove punctuation: rm_punc
rm_punc <- removePunctuation(text_data)

# Create character vector: n_char_vec
n_char_vec <- unlist(strsplit(rm_punc, split = ' '))

# Perform word stemming: stem_doc
stem_doc <- stemDocument(n_char_vec)

# Print stem_doc
stem_doc

# Re-complete stemmed document: complete_doc
complete_doc <- stemCompletion(stem_doc, comp_dict)

# Print complete_doc
complete_doc

# Apply preprocessing steps to a corpus
# Alter the function code to match the instructions
clean_corpus <- function(corpus){
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removeWords, c(stopwords("en"), "coffee", "mug"))
  return(corpus)
}

# Apply your customized function to the tweet_corp: clean_corp
clean_corp <- clean_corpus(tweet_corp)

# Print out a cleaned up tweet
clean_corp[[227]][1]

# Print out the same tweet in original form
tweets$text[227]