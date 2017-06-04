# ================================== HEADER ====================================

# Project: Coursera Data Science Capstone
# Task: Swiftkey Text Prediction
# Date: May 2017
# Creator: MLMV

# ================================== CODE ======================================

# Functions ---------------------------------------------------------------

# data frames just for me to see the returns of each function
matchBGT = data.frame()
matchCGT = data.frame()
matchDGT = data.frame()
matchEGT = data.frame()
matchFGT = data.frame()

# Predict from bGrams
wordPred2GT <- function(phrase) {
      last1words <- word(phrase,-1)
      lookup <- paste0("^", last1words, " ")
      matches <- bGrams$vocab[which(grepl(lookup, bGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1)
            matches$lastw <- word(matches$terms,-1)
            matches$r <- matches$terms_counts
            matches <- join(matches, bSmooth, by = "r")
            matches$ngram = 2
            matches <- arrange(matches, desc(p))
            matchBGT <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","p","ngram")]
      }
}

# Predict from cGrams
wordPred3GT <- function(phrase) {
      last2words <- word(phrase,-2,-1)
      lookup <- paste0("^", last2words, " ")
      matches <- cGrams$vocab[which(grepl(lookup, cGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1,2)
            matches$lastw <- word(matches$terms,-1)
            matches$r <- matches$terms_counts
            matches <- join(matches, cSmooth, by = "r")
            matches$ngram = 3
            matches <- arrange(matches, desc(p))
            matchCGT <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","p","ngram")]
      }
}

# Predict from dGrams
wordPred4GT <- function(phrase) {
      last3words <- word(phrase,-3,-1)
      lookup <- paste0("^", last3words, " ")
      matches <- dGrams$vocab[which(grepl(lookup, dGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1,3)
            matches$lastw <- word(matches$terms,-1)
            matches$r <- matches$terms_counts
            matches <- join(matches, dSmooth, by = "r")
            matches$ngram = 4
            matches <- arrange(matches, desc(p))
            matchDGT <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","p","ngram")]
      }
}

# Predict from eGrams
wordPred5GT <- function(phrase) {
      last4words <- word(phrase,-4,-1)
      lookup <- paste0("^", last4words, " ")
      matches <- eGrams$vocab[which(grepl(lookup, eGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1,4)
            matches$lastw <- word(matches$terms,-1)
            matches$r <- matches$terms_counts
            matches <- join(matches, eSmooth, by = "r")
            matches$ngram = 5
            matches <- arrange(matches, desc(p))
            matchDGT <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","p","ngram")]
      }
}

# Predict from fGrams
wordPred6GT <- function(phrase) {
      last5words <- word(phrase,-5,-1)
      lookup <- paste0("^", last5words, " ")
      matches <- fGrams$vocab[which(grepl(lookup, fGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1,5)
            matches$lastw <- word(matches$terms,-1)
            matches$r <- matches$terms_counts
            matches <- join(matches, fSmooth, by = "r")
            matches$ngram = 6
            matches <- arrange(matches, desc(p))
            matchFGT <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","p","ngram")]
      }
}

# Backoff function
backOffGT <- function(phrase) {
      t3 = Sys.time()
      matchBGT <<- NULL; matchCGT <<- NULL; matchDGT <<- NULL; matchEGT <<- NULL; matchFGT <<- NULL # just for me to clear previous returns
      unigrams = data.frame(lastw = (c("the", "and", "that", "for", "you", "with")), p = 0, ngram = 1, stringsAsFactors = FALSE)
      predictions <- bind_rows(wordPred2GT(phrase), wordPred3GT(phrase), wordPred4GT(phrase), wordPred5GT(phrase), wordPred6GT(phrase), unigrams)
      predictions <- na.omit(predictions)
      predictions <- arrange(predictions, desc(ngram), desc(p))
      t4 = Sys.time()
      message(difftime(t4, t3, units = 'sec'))
      pTimeGT <<- difftime(t4, t3, units = 'sec')
      unique(predictions$lastw)[1:6]
}

# Predictor wrapper
phraserGT <- function(phrase) {
      phrase <- gsub("[[:punct:]]", "", phrase)
      phrase <- gsub("[[:digit:]]", "", phrase)
      phrase <- tolower(phrase)
      phrase <- stripWhitespace(phrase)
      phrase <- trimws(phrase)
      print(phrase)
      if (phrase != "") {
            backOffGT(phrase)
      }
}

