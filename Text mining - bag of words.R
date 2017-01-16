text <- "Text mining usually involves the process of structuring the input text. 
The overarching goal is, essentially, to turn text into data for analysis, 
via application of natural language processing (NLP) and analytical methods."

install.packages("qdap")
install.packages("tm")

library(qdap)
library(tm)

frequent_terms <- qdap::freq_terms(text,3)
plot(qdap::freq_terms(text,3))

# Import text data
tweets <- read.csv("coffee.csv", stringsAsFactors = FALSE)
# View the structure of tweets
str(tweets)
# Print out the number of rows in tweets
nrow(tweets)
# Isolate text from tweets: coffee_tweets
coffee_tweets <- tweets$text
# Load tm
library(tm)
# Make a Source object: coffee_source
coffee_source <- VectorSource(coffee_tweets)

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


# Create the object: text
text <- "<b>She</b> woke up at       6 A.M. It\'s so early!  
She was only 10% awake and began drinking coffee in front of her computer."
# All lowercase
tolower(text)
# Remove punctuation
removePunctuation(text)
# Remove numbers
removeNumbers(text)
# Remove whitespace
stripWhitespace(text)
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
# List standard English stop words
stopwords("en")
# Print text without standard stop words
removeWords(text, stopwords("en"))
# Add "coffee" and "bean" to the list: new_stops
new_stops <- c("coffee", "bean", stopwords("en"))
# Remove stop words from text
removeWords(text, new_stops)

# Create complicate
complicate <- c("complicated", "complication", "complicatedly")
# Perform word stemming: stem_doc
stem_doc <- stemDocument(complicate)
# Create the completion dictionary: comp_dict
comp_dict <- "complicate"
# Perform stem completion: complete_text 
complete_text <- stemCompletion(stem_doc, comp_dict)
# Print complete_text
complete_text


text_data <- "In a complicated haste, 
Tom rushed to fix a new complication, too complicatedly."
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



#Term documnet matrix or document term matrix
# Create the dtm from the corpus: coffee_dtm
coffee_dtm <- DocumentTermMatrix(clean_corp)
# Print out coffee_dtm data
coffee_dtm
# Convert coffee_dtm to a matrix: coffee_m
coffee_m <- as.matrix(coffee_dtm)
# Print the dimensions of coffee_m
dim(coffee_m)
# Review a portion of the matrix
coffee_m[148:150, 2587:2590]

# Create a TDM from clean_corp: coffee_tdm
coffee_tdm <- TermDocumentMatrix(clean_corp)
# Print coffee_tdm data
coffee_tdm
# Convert coffee_tdm to a matrix: coffee_m
coffee_m <- as.matrix(coffee_tdm)
# Print the dimensions of the matrix
dim(coffee_m)
# Review a portion of the matrix
coffee_m[2587:2590, 148:150]


## Make visuals

# Create a matrix: coffee_m
coffee_m <- as.matrix(coffee_tdm)
# Calculate the rowSums: term_frequency
term_frequency <- rowSums(coffee_m)
# Sort term_frequency in descending order
term_frequency <- sort(term_frequency, decreasing = TRUE)
# View the top 10 most common words
term_frequency[1:10]
# Plot a barchart of the 10 most common words
barplot(term_frequency[1:10], col = "tan", las = 2)


# Create frequency
frequency <- freq_terms(tweets$text, top = 10, at.least = 3, 
                        stopwords = "Top200Words")
# Make a frequency barchart
plot(frequency)
# Create frequency2
frequency2 <- freq_terms(tweets$text, top = 10, at.least = 3, 
                         stopwords = tm::stopwords("english"))
# Make a frequency2 barchart
plot(frequency2)


##Wordcloud

## term_frequency is loaded into your workspace

# Load wordcloud package
library(wordcloud)
# Print the first 10 entries in term_frequency
term_frequency[1:10]
# Create word_freqs
word_freqs <- data.frame(term = names(term_frequency), 
                         num = term_frequency)
# Create a wordcloud for the values in word_freqs
wordcloud(word_freqs$term, word_freqs$num, 
          max.words = 100, colors = "red")

# Add new stop words to clean_corpus()
clean_corpus <- function(corpus){
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removeWords, 
                   c(stopwords("en"), "amp", "chardonnay", "wine", "glass"))
  return(corpus)
}
# Create clean_chardonnay
clean_chardonnay <- clean_corpus(chardonnay_corp)
# Create chardonnay_tdm
chardonnay_tdm <- TermDocumentMatrix(clean_chardonnay)
# Create chardonnay_m
chardonnay_m <- as.matrix(chardonnay_tdm)
# Create chardonnay_words
chardonnay_words <- rowSums(chardonnay_m)
# Sort the chardonnay_words in descending order
chardonnay_words <- sort(chardonnay_words, decreasing = TRUE)
# Print the 6 most frequent chardonnay terms
head(chardonnay_words)
# Create the data frame chardonnay_freqs
chardonnay_freqs <- data.frame(term = names(chardonnay_words), 
                               num = chardonnay_words)
# Create a wordcloud for the values in word_freqs
wordcloud(chardonnay_freqs$term, chardonnay_freqs$num, 
          max.words = 50, colors = "red")
# Print the list of colors
colors()
# Print the wordcloud with the specified colors
wordcloud(chardonnay_freqs$term, chardonnay_freqs$num, max.words = 100, 
          colors = c("grey80", "darkgoldenrod1", "tomato"))
# List the available colors
display.brewer.all()
# Create purple_orange
purple_orange <- brewer.pal(10, "PuOr")
# Drop 2 faintest colors
purple_orange <- purple_orange[-(1:2)]
# Create a wordcloud with purple_orange palette
wordcloud(chardonnay_freqs$term, chardonnay_freqs$num, 
          max.words = 100, colors = purple_orange)


# Create all_coffee
all_coffee <- paste(coffee_tweets$text, collapse = " ")
# Create all_chardonnay
all_chardonnay <- paste(chardonnay_tweets$text, collapse = " ")
# Create all_tweets
all_tweets <- c(all_coffee, all_chardonnay)
# Convert to a vector source
all_tweets <- VectorSource(all_tweets)
# Create all_corpus
all_corpus <- VCorpus(all_tweets)

# Create all_coffee
all_coffee <- paste(coffee_tweets$text, collapse = " ")

##Common words
# Create all_chardonnay
all_chardonnay <- paste(chardonnay_tweets$text, collapse = " ")
# Create all_tweets
all_tweets <- c(all_coffee, all_chardonnay)
# Convert to a vector source
all_tweets <- VectorSource(all_tweets)
# Create all_corpus
all_corpus <- VCorpus(all_tweets)
# Clean the corpus
all_clean <- clean_corpus(all_corpus)
# Create all_tdm
all_tdm <- TermDocumentMatrix(all_clean)
# Create all_m
all_m <- as.matrix(all_tdm)
# Print a commonality cloud
commonality.cloud(all_m, colors = "steelblue1", max.words = 100)


##words not in common. 
# Clean the corpus
all_clean <- clean_corpus(all_corpus)
# Create all_tdm
all_tdm <- TermDocumentMatrix(all_clean)
# Give the columns distinct names
colnames(all_tdm) <- c("coffee", "chardonnay")
# Create all_m
all_m <- as.matrix(all_tdm)
# Create comparison cloud
comparison.cloud(all_m, colors = c("orange", "blue"), max.words = 50)


# Create common_words
common_words <- subset(all_tdm_m, all_tdm_m[, 1] > 0 & all_tdm_m[, 2] > 0)
# Create difference
difference <- abs(common_words[, 1] - common_words[, 2])
# Combine common_words and difference
common_words <- cbind(common_words, difference)
# Order the data frame from most differences to least
common_words <- common_words[order(common_words[, 3], decreasing = TRUE), ]
# Create top25_df
top25_df <- data.frame(x = common_words[1:25, 1], 
                       y = common_words[1:25, 2], 
                       labels = rownames(common_words[1:25, ]))
# Create the pyramid plot
pyramid.plot(top25_df$x, top25_df$y, labels = top25_df$labels, 
             gap = 8, top.labels = c("Chardonnay", "Words", "Coffee"), 
             main = "Words in Common", laxlab = NULL, 
             raxlab = NULL, unit = NULL)


# Word association
word_associate(coffee_tweets$text, match.string = c("barista"), 
               stopwords = c(Top200Words, "coffee", "amp"), 
               network.plot = TRUE, cloud.colors = c("gray85", "darkred"))
# Add title
title(main = "Barista Coffee Tweet Associations")



#_____________________________________________________________________---
# Create dist_rain
dist_rain <- dist(rain[, 2])
# View the distance matrix
dist_rain
# Create hc
hc <- hclust(dist_rain)
# Plot hc
plot(hc, labels = rain$city)


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

##better dendograms
# Load dendextend
library(dendextend)

# Create hc
hc <- hclust(tweets_dist)
# Create hcd
hcd <- as.dendrogram(hc)
# Print the labels in hcd
labels(hcd)
# Change the branch color to red for "marvin" and "gaye"
hcd <- branches_attr_by_labels(hcd, c("marvin", "gaye"), "red")
# Plot hcd
plot(hcd, main = "Better Dendrogram")
# Add cluster rectangles 
rect.dendrogram(hcd, k = 2, border = "grey50")



# Load dendextend
library(dendextend)
# Create hc
hc <- hclust(tweets_dist)
# Create hcd
hcd <- as.dendrogram(hc)
# Print the labels in hcd
labels(hcd)
# Change the branch color to red for "marvin" and "gaye"
hcd <- branches_attr_by_labels(hcd, c("marvin", "gaye"), "red")
# Plot hcd
plot(hcd, main = "Better Dendrogram")
# Add cluster rectangles 
rect.dendrogram(hcd, k = 2, border = "grey50")


#n gram token

# Make tokenizer function 
tokenizer <- function(x) 
  NGramTokenizer(x, Weka_control(min = 2, max = 2))
# Create unigram_dtm
unigram_dtm <- DocumentTermMatrix(text_corp)
# Create bigram_dtm
bigram_dtm <- DocumentTermMatrix(
  text_corp, 
  control = list(tokenize = tokenizer)
)
# Examine unigram_dtm
unigram_dtm
# Examine bigram_dtm
bigram_dtm


# Create bigram_dtm_m
bigram_dtm_m <- as.matrix(bigram_dtm)
# Create freq
freq <- colSums(bigram_dtm_m)
# Create bi_words
bi_words <- names(freq)
# Examine part of bi_words
bi_words[2577:2587]
# Plot a wordcloud
wordcloud(bi_words, freq, max.words = 15)


#TF IDF
# Create tf_tdm
tf_tdm <- TermDocumentMatrix(text_corp)

# Create tfidf_tdm
tfidf_tdm <- TermDocumentMatrix(
  text_corp, 
  control = list(weighting = weightTfIdf)
)

# Create tf_tdm_m
tf_tdm_m <- as.matrix(tf_tdm)

# Create tfidf_tdm_m 
tfidf_tdm_m <- as.matrix(tfidf_tdm)

# Examine part of tf_tdm_m
tf_tdm_m[508:509, 5:10]

# Examine part of tfidf_tdm_m
tfidf_tdm_m[508:509, 5:10]


##Capturing metadata in tm

# Add author to custom reading list
custom_reader <- readTabular(
  mapping = list(content = "text", 
                 id = "num", 
                 author = "screenName", 
                 date = "created")
)

# Make corpus with custom reading
text_corpus <- VCorpus(
  DataframeSource(tweets), 
  readerControl = list(reader = custom_reader)
)

# Clean corpus
text_corpus <- clean_corpus(text_corpus)

# Print data
text_corpus[[1]][1]

# Print metadata
text_corpus[[1]][2]



##____________________________________________________________________-


#Case study
