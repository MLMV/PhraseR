# ================================== HEADER ====================================

# Project: Coursera Data Science Capstone
# Task: Swiftkey Text Prediction
# Date: May 2017
# Creator: MLMV

# ================================== CODE ======================================

# Prep workspace ----------------------------------------------------------

library(text2vec)
library(plyr)
library(dplyr)

# nGram vocabularies using text2vec ---------------------------------------

toknzr = itoken(c(swift[[1]]$content, swift[[2]]$content, swift[[3]]$content),
                tokenizer = word_tokenizer,
                progressbar = FALSE)

bGrams = create_vocabulary(toknzr, ngram = c(2L, 2L), sep_ngram = " ")
bGrams = bGrams %>% prune_vocabulary(term_count_min = 2)
bGrams$vocab <- arrange(bGrams$vocab, desc(terms_counts))

cGrams = create_vocabulary(toknzr, ngram = c(3L, 3L), sep_ngram = " ")
cGrams = cGrams %>% prune_vocabulary(term_count_min = 2)
cGrams$vocab <- arrange(cGrams$vocab, desc(terms_counts))

dGrams = create_vocabulary(toknzr, ngram = c(4L, 4L), sep_ngram = " ")
dGrams = dGrams %>% prune_vocabulary(term_count_min = 2)
dGrams$vocab <- arrange(dGrams$vocab, desc(terms_counts))

eGrams = create_vocabulary(toknzr, ngram = c(5L, 5L), sep_ngram = " ")
eGrams = eGrams %>% prune_vocabulary(term_count_min = 2)
eGrams$vocab <- arrange(eGrams$vocab, desc(terms_counts))

fGrams = create_vocabulary(toknzr, ngram = c(6L, 6L), sep_ngram = " ")
fGrams = fGrams %>% prune_vocabulary(term_count_min = 2)
fGrams$vocab <- arrange(fGrams$vocab, desc(terms_counts))

saveRDS(bGrams, "../files/bGrams.rds")
saveRDS(cGrams, "../files/cGrams.rds")
saveRDS(dGrams, "../files/dGrams.rds")
saveRDS(eGrams, "../files/eGrams.rds")
saveRDS(fGrams, "../files/fGrams.rds")

