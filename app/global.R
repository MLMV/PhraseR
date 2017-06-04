# Prep workspace ----------------------------------------------------------

library(shiny)
library(tm)
library(RWeka)
library(stringr)
library(text2vec)
library(plyr)
library(dplyr)

# Source n-grams/MLE and GT probabilities -------------------------------------
bGrams <- readRDS("./files/bGrams.rds")
cGrams <- readRDS("./files/cGrams.rds")
dGrams <- readRDS("./files/dGrams.rds")
eGrams <- readRDS("./files/eGrams.rds")
fGrams <- readRDS("./files/fGrams.rds")
bSmooth <- readRDS("./files/bSmooth.rds")
cSmooth <- readRDS("./files/cSmooth.rds")
dSmooth <- readRDS("./files/dSmooth.rds")
eSmooth <- readRDS("./files/eSmooth.rds")
fSmooth <- readRDS("./files/fSmooth.rds")

# Source word prediction functions ----------------------------------------
source("./scripts/R_wordPredictionMLE.R")
source("./scripts/R_wordPredictionGT.R")