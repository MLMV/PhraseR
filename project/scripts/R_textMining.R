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

# Get data ----------------------------------------------------------------

# Get file info
fileInfo <- read.table(file = "../files/fileInfo.csv", sep = ",")

swift <- VCorpus(DirSource("../data", mode = "text", encoding = "UTF-8"),
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
swift[[1]]$content <- sample(swift[[1]]$content, fileInfo[1,3]*0.1)
swift[[2]]$content <- sample(swift[[2]]$content, fileInfo[2,3]*0.1)
swift[[3]]$content <- sample(swift[[3]]$content, fileInfo[3,3]*0.1)

