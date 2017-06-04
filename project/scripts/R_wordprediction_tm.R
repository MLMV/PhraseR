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

setwd("~/Analytics/Study/Johns Hopkins Data Science 2015-2016/X - Data Science Capstone Project/Assignments")

# list for environment variables
env = list()
env$dirFiles <- getwd()
env$dirData <- paste(env$dirFiles,"/data", sep = "")
fileInfo <- read.table(file = "fileInfo.csv", sep = ",")


# Get data ----------------------------------------------------------------

swift <- VCorpus(DirSource(env$dirData, mode = "text", encoding = "UTF-8"),
                 readerControl = list(
                       reader = readPlain,
                       language = "english",
                       load = TRUE
                 ))

# Give descriptions that help me to remember which one's which :-)
swift[[1]]$meta$description <- "Blogs"
swift[[2]]$meta$description <- "News"
swift[[3]]$meta$description <- "Twitter"

# Take random samples
set.seed(1800)
swift[[1]]$content <- sample(swift[[1]]$content, fileInfo[1,3]*0.02)
swift[[2]]$content <- sample(swift[[2]]$content, fileInfo[2,3]*0.02)
swift[[3]]$content <- sample(swift[[3]]$content, fileInfo[3,3]*0.02)

# swiftBup <- swift # backup
# swift <- swiftBup # restore


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


# Term Document Matrices --------------------------------------------------

# # Unigrams
# tdm = list()
# tdm$tdm <- TermDocumentMatrix(swift)
# tdm$tdm <- removeSparseTerms(tdm$tdm, 0.25)
# # Find most frequent terms
# tdm$mostFreqAll <- findMostFreqTerms(tdm$tdm, 5000)
# tdm$tblMostFreqAll <- as.data.frame(tdm$mostFreqAll)
# tdm$tblMostFreqAll$Term <- rownames(tdm$tblMostFreqAll)
# tdm$tblMostFreqAll$totalOccur <- rowSums(tdm$tblMostFreqAll[,1:3])
# tdm$tblMostFreqAll <- tdm$tblMostFreqAll[4:5]
# tdm$tblMostFreqAll[2]

# Bigrams
tdm2 = list()
# set tokenizer options
tdm2$tknz <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
tdm2$tdm <- TermDocumentMatrix(swift, control = list(tokenize = tdm2$tknz))
#tdm2$tdm <- removeSparseTerms(tdm2$tdm, 0.05)
# Find most frequent terms
tdm2$mostFreqAll <- findMostFreqTerms(tdm2$tdm, 10000)
tdm2$tblMostFreqAll <- as.data.frame(tdm2$mostFreqAll)
tdm2$tblMostFreqAll$Term <- rownames(tdm2$tblMostFreqAll)
tdm2$tblMostFreqAll$totalOccur <- rowSums(tdm2$tblMostFreqAll[,1:3])
tdm2$tblMostFreqAll <- tdm2$tblMostFreqAll[4:5]
tdm2$tblMostFreqAll[2]

# Trigrams
tdm3 = list()
# set tokenizer options
tdm3$tknz <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
tdm3$tdm <- TermDocumentMatrix(swift, control = list(tokenize = tdm3$tknz))
#tdm3$tdm <- removeSparseTerms(tdm3$tdm, 0.05)
# Find most frequent terms
tdm3$mostFreqAll <- findMostFreqTerms(tdm3$tdm, 10000)
tdm3$tblMostFreqAll <- as.data.frame(tdm3$mostFreqAll)
tdm3$tblMostFreqAll$Term <- rownames(tdm3$tblMostFreqAll)
tdm3$tblMostFreqAll$totalOccur <- rowSums(tdm3$tblMostFreqAll[,1:3])
tdm3$tblMostFreqAll <- tdm3$tblMostFreqAll[4:5]
tdm3$tblMostFreqAll[2]

# Quadgrams
tdm4 = list()
# set tokenizer options
tdm4$tknz <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
tdm4$tdm <- TermDocumentMatrix(swift, control = list(tokenize = tdm4$tknz))
# tdm4$tdm <- removeSparseTerms(tdm4$tdm, 0.01)
# Find most frequent terms
tdm4$mostFreqAll <- findMostFreqTerms(tdm4$tdm, 10000)
tdm4$tblMostFreqAll <- as.data.frame(tdm4$mostFreqAll)
tdm4$tblMostFreqAll$Term <- rownames(tdm4$tblMostFreqAll)
tdm4$tblMostFreqAll$totalOccur <- rowSums(tdm4$tblMostFreqAll[,1:3])
tdm4$tblMostFreqAll <- tdm4$tblMostFreqAll[4:5]
tdm4$tblMostFreqAll[2]

# Pentagrams
tdm5 = list()
# set tokenizer options
tdm5$tknz <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))
tdm5$tdm <- TermDocumentMatrix(swift, control = list(tokenize = tdm5$tknz))
#tdm5$tdm <- removeSparseTerms(tdm5$tdm, 0.01)
# Find most frequent terms
tdm5$mostFreqAll <- findMostFreqTerms(tdm5$tdm, 10000)
tdm5$tblMostFreqAll <- as.data.frame(tdm5$mostFreqAll)
tdm5$tblMostFreqAll$Term <- rownames(tdm5$tblMostFreqAll)
tdm5$tblMostFreqAll$totalOccur <- rowSums(tdm5$tblMostFreqAll[,1:3])
tdm5$tblMostFreqAll <- tdm5$tblMostFreqAll[4:5]
tdm5$tblMostFreqAll[2]

# Sextagrams
tdm6 = list()
# set tokenizer options
tdm6$tknz <- function(x) NGramTokenizer(x, Weka_control(min = 6, max = 6))
tdm6$tdm <- TermDocumentMatrix(swift, control = list(tokenize = tdm6$tknz))
#tdm6$tdm <- removeSparseTerms(tdm6$tdm, 0.01)
# Find most frequent terms
tdm6$mostFreqAll <- findMostFreqTerms(tdm6$tdm, 10000)
tdm6$tblMostFreqAll <- as.data.frame(tdm6$mostFreqAll)
tdm6$tblMostFreqAll$Term <- rownames(tdm6$tblMostFreqAll)
tdm6$tblMostFreqAll$totalOccur <- rowSums(tdm6$tblMostFreqAll[,1:3])
tdm6$tblMostFreqAll <- tdm6$tblMostFreqAll[4:5]
tdm6$tblMostFreqAll[2]

# Functions ---------------------------------------------------------------

# Predict from bigrams
wordPred2 <- function(phrase) {
      last1words <- word(phrase,-1)
      lookup <- paste0("^", last1words, " ")
      matches <-
            tdm2$tblMostFreqAll[which(grepl(lookup, tdm2$tblMostFreqAll$Term)), ]$Term
      prediction <- word(matches,-1)
      prediction[1:50]
}

# Predict from trigrams
wordPred3 <- function(phrase) {
      last2words <- word(phrase,-2,-1)
      lookup <- paste0("^", last2words, " ")
      matches <-
            tdm3$tblMostFreqAll[which(grepl(lookup, tdm3$tblMostFreqAll$Term)), ]$Term
      prediction <- word(matches,-1)
      prediction[1:50]
}

# Predict from quadgrams
wordPred4 <- function(phrase) {
      last3words <- word(phrase,-3,-1)
      lookup <- paste0("^", last3words, " ")
      matches <-
            tdm4$tblMostFreqAll[which(grepl(lookup, tdm4$tblMostFreqAll$Term)), ]$Term
      prediction <- word(matches,-1)
      prediction[1:50]
}

# Predict from pentagrams
wordPred5 <- function(phrase) {
      last4words <- word(phrase,-4,-1)
      lookup <- paste0("^", last4words, " ")
      matches <-
            tdm5$tblMostFreqAll[which(grepl(lookup, tdm5$tblMostFreqAll$Term)), ]$Term
      prediction <- word(matches,-1)
      prediction[1:50]
}

# Predict from sextagrams
wordPred6 <- function(phrase) {
      last5words <- word(phrase,-5,-1)
      lookup <- paste0("^", last5words, " ")
      matches <-
            tdm6$tblMostFreqAll[which(grepl(lookup, tdm6$tblMostFreqAll$Term)), ]$Term
      prediction <- word(matches,-1)
      prediction[1:50]
}


# Backoff function
backOff <- function(phrase) {
      predictions <- NULL
      predictions <- append(predictions, wordPred6(phrase))
      predictions <- append(predictions, wordPred5(phrase))
      predictions <- append(predictions, wordPred4(phrase))
      predictions <- append(predictions, wordPred3(phrase))
      predictions <- append(predictions, wordPred2(phrase))
      predictions <- append(predictions, c("the", "and", "that", "for", "you"))
      predictions <- unique(na.omit(predictions))
      head(predictions, 6)
}
      

# Test functions
# phrase <- "Go on a romantic date at the"
# phrase <- gsub("[[:punct:]]", "", phrase)
# phrase <- gsub("[[:digit:]]", "", phrase)
# phrase <- tolower(phrase)
# phrase <- stripWhitespace(phrase)
# phrase
# wordPred6(phrase)
# wordPred5(phrase)
# wordPred4(phrase)
# wordPred3(phrase)
# wordPred2(phrase)
# backOff(phrase)

# lastwords <- word(phrase,-2,-1)
# lookup <- paste0("^", lastwords, " ")
# tdm3$tblMostFreqAll[which(grepl(lookup, tdm3$tblMostFreqAll$Term)), ]$Term[1:5]

# Predictor wrapper
phraser <- function(phrase) {
      phrase <- gsub("[[:punct:]]", "", phrase)
      phrase <- gsub("[[:digit:]]", "", phrase)
      phrase <- tolower(phrase)
      phrase <- stripWhitespace(phrase)
      print(phrase)
      backOff(phrase)
}

phraser("The guy in front of me just bought a pound of bacon, a bouquet, and a case of")
phraser("You're the reason why I smile everyday. Can you follow me please? It would mean the")
phraser("Hey sunshine, can you follow me and make me the")
phraser("Very early observations on the Bills game: Offense still struggling but the")
phraser("Go on a romantic date at the")
phraser("Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my")
phraser("Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some")
phraser("After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little")
phraser("Be grateful for the good times and keep the faith during the")
phraser("If this isn't the cutest thing you've ever seen, then you must be")












                  















