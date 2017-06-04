# ================================== HEADER ====================================

# Project: Coursera Data Science Capstone
# Task: Swiftkey Text Prediction
# Date: May 2017
# Creator: MLMV

# ================================== APP =======================================

# Define UI for application that draws a histogram

fluidPage(title = "PhraseR Text Prediction App",
          br(),
          sidebarLayout(
                sidebarPanel(
                      width = 4,
                      img(src = "wc.jpg"),
                      br(),
                      br(),
                      br(),
                      radioButtons(
                            "pMethod",
                            "Probability estimation:",
                            choiceNames = c(
                                  "Maximum likelyhood",
                                  "Good-Turing smoothing"
                            ),
                            choiceValues = c(1, 2),
                            selected = 1
                      ),
                      radioButtons(
                            "showTime",
                            "Prediction timer",
                            choices = c("On", "Off"),
                            selected = "On"
                      )
                ),
                mainPanel(
                      width = 5,
                      h2("PhraseR Text Prediction App"),
                      p(
                            "This app takes a large corpus of text documents to discover
                            structures in the data and how words are put together. It
                            performs cleaning and statistical analysis of the data, then
                            builds a predictive text model."
                      ),
                      p(
                            "Use the buttons on the left to select the type of model you want use,
                            then type your text in the box below and see what happens!"
                      ),
                      hr(),
                      textInput("phrase", "Type your sentence here"),
                      hr(),
                      textOutput("predictions"),
                      hr(),
                      textOutput("ptime"),
                      hr()
                      )
                ))