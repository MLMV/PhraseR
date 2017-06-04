# ================================== HEADER ====================================

# Project: Coursera Data Science Capstone
# Task: Swiftkey Text Prediction
# Date: May 2017
# Creator: MLMV

# ================================== CODE ======================================

# Prep workspace
# !! NOTE: set working directory to where this file is
tmr = list()


# Get file info
source("R_fileInfo.R")
tmr$t1 = Sys.time(); tmr$fileInfo = difftime(tmr$t1, tmr$t0, units = 'min')

      
# Get data
source("R_textMining.R")
tmr$t2 = Sys.time(); tmr$fileRead = difftime(tmr$t2, tmr$t1, units = 'min')
      
      
# Clean data
source("R_textClean.R")
tmr$t3 = Sys.time(); tmr$fileClean = difftime(tmr$t3, tmr$t2, units = 'min')
      
      
# nGram vocabularies using text2vec
source("R_tokenizer.R")
tmr$t4 = Sys.time(); tmr$tokenize = difftime(tmr$t4, tmr$t3, units = 'min')


# Good-Turing Smoothing
source("R_goodTuring.R")
tmr$t5 = Sys.time(); tmr$smoothing = difftime(tmr$t5, tmr$t4, units = 'min')

      
# Word prediction MLE
source("R_wordPredictionMLE.R")
tmr$t6 = Sys.time(); tmr$loadMLE = difftime(tmr$t6, tmr$t5, units = 'min')

      
# Word prediction GT
source("R_wordPredictionGT.R")
tmr$t7 = Sys.time(); tmr$loadGT = difftime(tmr$t7, tmr$t6, units = 'min')
tmr$totalTime = difftime(tmr$t7, tmr$t1, units = 'min')


# Open scripts for testing and timers
file.edit('R_tester.R')
file.edit('R_timers.R')

