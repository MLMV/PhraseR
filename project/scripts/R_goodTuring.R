# ================================== HEADER ====================================

# Project: Coursera Data Science Capstone
# Task: Swiftkey Text Prediction
# Date: May 2017
# Creator: MLMV

# ================================== CODE ======================================

# Good Turing smoothed probabilities for observed n-gram frequencies.
# Takes as input a dataframe with 3 variables for each n-gram:
# (char) first n-1 words 
# (char) last 1 word 
# (int) frequency 
# Then uses a linear regression model to find probabilities for ranked n-grams.


# Smooth function ---------------------------------------------------------

goodTuring <- function(table) {
      
      n_grams <- data.frame(X = table(table$freq))
      names(n_grams) <- c("r", "n")
      n_grams$r <- as.numeric(as.character(n_grams$r))
      n_gramTtl <- nrow(n_grams)
      N <- sum(n_grams$r * n_grams$n)
      P_0 <- n_grams$r[1] / N
      n_grams$Z <- 0
      for (c in 1:n_gramTtl) {
            if (c == 1) {
                  i <- 0
                  } else {
                        i <- i <- n_grams$r[c - 1]
                        }
            if (c == n_gramTtl) {
                  k <- n_grams$r[c]
                  } else {
                        k <- n_grams$r[c + 1]
                        }
            n_grams$Z[c] <- 2 * n_grams$n[c] / (k - i)
            }
      n_grams$logr <- log(n_grams$r)
      n_grams$logZ <- log(n_grams$Z)
      n_grams$rstar <- 0

      # Linear regression model
      model1 <- glm(logZ ~ logr, data = n_grams)
      c0 <- model1$coefficients[1]
      c1 <- model1$coefficients[2]
      
      ycheck = FALSE
      
      for (c in 1:(n_gramTtl - 1)) {
            rplus1 <- n_grams$r[c] + 1
            s_rplus1 <- exp(c0 + (c1 * n_grams$logr[c + 1]))
            s_r <- exp(c0 + (c1 * n_grams$logr[c]))
            y <- rplus1 * s_rplus1 / s_r
            if (ycheck) {
                  n_grams$rstar[c] <- y
                  } else {
                        n_rplus1 <- n_grams$n[n_grams$r == rplus1]
                        n_r <- n_grams$n[c]
                        x <- (rplus1) * n_rplus1 / n_r
                        if (abs(x - y) > 1.96 * sqrt(((rplus1) ^ 2) *
                                                     (n_rplus1 / ((n_r) ^ 2)) *
                                                     (1 + (n_rplus1 / n_r)))) {
                              n_grams$rstar[c] <- x
                              } else {
                                    n_grams$rstar[c] <- y
                                    ycheck = TRUE
                              }
                        }
            if (c == (n_gramTtl - 1)) {
                  n_grams$rstar[c + 1] <- y
            }
            }
      
      N_1 <- sum(n_grams$n * n_grams$rstar)
      n_grams$p <- (1 - P_0) * n_grams$rstar / N_1
      
      return(n_grams)
}


# Run smoothing on ngrams -------------------------------------------------

bSmooth = data.frame(firstgram = word(bGrams$vocab$terms, 1),
                     lastgram = word(bGrams$vocab$terms, -1),
                     freq = bGrams$vocab$terms_counts, 
                     stringsAsFactors = F)
bSmooth <- goodTuring(bSmooth)

cSmooth = data.frame(firstgram = word(cGrams$vocab$terms, 1,2),
                     lastgram = word(cGrams$vocab$terms, -1),
                     freq = cGrams$vocab$terms_counts, 
                     stringsAsFactors = F)
cSmooth <- goodTuring(cSmooth)

dSmooth = data.frame(firstgram = word(dGrams$vocab$terms, 1,3),
                     lastgram = word(dGrams$vocab$terms, -1),
                     freq = dGrams$vocab$terms_counts, 
                     stringsAsFactors = F)
dSmooth <- goodTuring(dSmooth)

eSmooth = data.frame(firstgram = word(eGrams$vocab$terms, 1,4),
                     lastgram = word(eGrams$vocab$terms, -1),
                     freq = eGrams$vocab$terms_counts, 
                     stringsAsFactors = F)
eSmooth <- goodTuring(eSmooth)

fSmooth = data.frame(firstgram = word(fGrams$vocab$terms, 1,5),
                     lastgram = word(fGrams$vocab$terms, -1),
                     freq = fGrams$vocab$terms_counts, 
                     stringsAsFactors = F)
fSmooth <- goodTuring(fSmooth)

saveRDS(bSmooth, "../files/bSmooth.rds")
saveRDS(cSmooth, "../files/cSmooth.rds")
saveRDS(dSmooth, "../files/dSmooth.rds")
saveRDS(eSmooth, "../files/eSmooth.rds")
saveRDS(fSmooth, "../files/fSmooth.rds")
