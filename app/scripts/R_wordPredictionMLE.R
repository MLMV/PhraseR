# ================================== HEADER ====================================

# Project: Coursera Data Science Capstone
# Task: Swiftkey Text Prediction
# Date: May 2017
# Creator: MLMV

# ================================== CODE ======================================

# Functions ---------------------------------------------------------------

# data frames just for me to see the returns of each function
matchB = data.frame()
matchC = data.frame()
matchD = data.frame()
matchE = data.frame()
matchF = data.frame()

# Predict from bGrams
wordPred2 <- function(phrase) {
      last1words <- word(phrase,-1)
      lookup <- paste0("^", last1words, " ")
      matches <- bGrams$vocab[which(grepl(lookup, bGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1)
            matches$lastw <- word(matches$terms,-1)
            matches$prob <- matches$terms_counts/sum(matches$terms_counts)
            matches$n = 2
            matchC <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","prob")]
      }
}

# Predict from cGrams
wordPred3 <- function(phrase) {
      last2words <- word(phrase,-2,-1)
      lookup <- paste0("^", last2words, " ")
      matches <- cGrams$vocab[which(grepl(lookup, cGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1,2)
            matches$lastw <- word(matches$terms,-1)
            matches$prob <- matches$terms_counts/sum(matches$terms_counts)
            matches$n = 3
            matchC <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","prob")]
      }
}

# Predict from dGrams
wordPred4 <- function(phrase) {
      last3words <- word(phrase,-3,-1)
      lookup <- paste0("^", last3words, " ")
      matches <- dGrams$vocab[which(grepl(lookup, dGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1,3)
            matches$lastw <- word(matches$terms,-1)
            matches$prob <- matches$terms_counts/sum(matches$terms_counts)
            matches$n = 4
            matchD <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","prob")]
      }
}

# Predict from eGrams
wordPred5 <- function(phrase) {
      last4words <- word(phrase,-4,-1)
      lookup <- paste0("^", last4words, " ")
      matches <- eGrams$vocab[which(grepl(lookup, eGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1,4)
            matches$lastw <- word(matches$terms,-1)
            matches$prob <- matches$terms_counts/sum(matches$terms_counts)
            matches$n = 5
            matchD <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","prob")]
      }
}

# Predict from fGrams
wordPred6 <- function(phrase) {
      last5words <- word(phrase,-5,-1)
      lookup <- paste0("^", last5words, " ")
      matches <- fGrams$vocab[which(grepl(lookup, fGrams$vocab$terms)), ]
      if (nrow(matches) > 0) {
            matches$firstws <- word(matches$terms,1,5)
            matches$lastw <- word(matches$terms,-1)
            matches$prob <- matches$terms_counts/sum(matches$terms_counts)
            matches$n = 6
            matchF <<- as.data.frame(matches) # just for me to see the returns
            matches[1:10,c("lastw","prob")]
      }
}

# Backoff function
backOff <- function(phrase) {
      t3 = Sys.time()
      matchB <<- NULL; matchC <<- NULL; matchD <<- NULL; matchE <<- NULL; matchF <<- NULL # just for me to clear previous returns
      unigrams = data.frame(lastw = (c("the", "and", "that", "for", "you", "with")), prob = c(0,0,0,0,0,0), stringsAsFactors = FALSE)
      predictions <- bind_rows(wordPred2(phrase), wordPred3(phrase), wordPred4(phrase), wordPred5(phrase), wordPred6(phrase), unigrams)
      predictions <- na.omit(predictions)
      predictions <- arrange(predictions, desc(prob))
      t4 = Sys.time()
      message(difftime(t4, t3, units = 'sec'))
      pTime <<- difftime(t4, t3, units = 'sec')
      unique(predictions$lastw)[1:6]
}

# Predictor wrapper
phraser <- function(phrase) {
      phrase <- gsub("[[:punct:]]", "", phrase)
      phrase <- gsub("[[:digit:]]", "", phrase)
      phrase <- tolower(phrase)
      phrase <- stripWhitespace(phrase)
      phrase <- trimws(phrase)
      print(phrase)
      if (phrase != "") {
            backOff(phrase)
      }
}
