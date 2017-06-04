# ================================== HEADER ====================================

# Project: Coursera Capstone Project
# Task: Natural Language Processing
# Date: March 18, 2017
# Creator: Michel Voogd


# ================================== CODE ======================================

# Prep workspace ----------------------------------------------------------

# File info ---------------------------------------------------------------

# Timestamp 0
timers$t0 = Sys.time()

      # store filenames in a list
      
      setwd("../data")
      fileList <- list.files(recursive = T, pattern = "*.txt")
      
      l <- lapply(paste(fileList, sep = "/"), function(f) {
            fileSize <- file.info(f)[1] / 1024 / 1024
            con <- file(f, open = "r")
            lines <- readLines(con)
            nchars <- lapply(lines, nchar)
            maxchars <- which.max(nchars)
            maxlength <- nchar(lines[maxchars])
            nwords <- sum(sapply(strsplit(lines, "\\s+"), length))
            close(con)
            return(c(
                  f,
                  format(round(fileSize, 2), nsmall = 2),
                  length(lines),
                  maxchars,
                  maxlength,
                  nwords
            ))
      })
      
      fileInfo <- data.frame(matrix(unlist(l), nrow = length(l), byrow = T))
      colnames(fileInfo) <-
            c("file",
              "size(MB)",
              "num.of.lines",
              "longest.line",
              "max.length",
              "num.of.words")
      
      write.table(fileInfo, file = "../files/fileInfo.csv", sep = ",")
      
      remove(l)
      remove(fileList)
      remove(fileInfo)
                        
      setwd("../scripts")
      