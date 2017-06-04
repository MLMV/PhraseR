# ================================== HEADER ====================================

# Project: Coursera Data Science Capstone
# Task: Swiftkey Text Prediction
# Date: May 2017
# Creator: MLMV

# ================================== CODE ======================================

# Prep workspace ----------------------------------------------------------

library(tm)
library(RWeka)
library(stringr)

# Clean data --------------------------------------------------------------

# Convert from UTF-8to ASCII
swift[[1]]$content <- iconv(swift[[1]]$content, "UTF-8", "ASCII", sub = "byte")
swift[[2]]$content <- iconv(swift[[2]]$content, "UTF-8", "ASCII", sub = "byte")
swift[[3]]$content <- iconv(swift[[3]]$content, "UTF-8", "ASCII", sub = "byte")

# Remove punctuation and numbers
swift <- tm_map(swift, content_transformer(removePunctuation))
swift <- tm_map(swift, content_transformer(removeNumbers))

# Convert to lower caps (only works after ASCII conversion)
swift <- tm_map(swift, content_transformer(tolower))

# Remove stopwords - chose to skip
# swift <- tm_map(swift, removeWords, stopwords("english"))

# Remove profanities
# Load profane words list
refData = list()
con = url("https://www.cs.cmu.edu/~biglou/resources/bad-words.txt")
refData$badWords = readLines(con)
close(con); rm(con)
# Remove them
swift <- tm_map(swift, removeWords, refData$badWords)

# Stemming - chose to skip
# swift <- tm_map(swift, stemDocument)

# Strip excess white spaces
swift <- tm_map(swift, stripWhitespace)


