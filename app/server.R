# ================================== APP =======================================

server <- function(input, output) {
      
      output$predictions <- renderText({
            if (input$pMethod == 1) {
                  pred <- phraser(input$phrase)
            }
            else {
                  pred <- phraserGT(input$phrase)
            }
            pred
      })
      
      output$ptime <- renderText({
            if (input$showTime == "On") {
                  if (input$phrase != "") {
                        if (input$pMethod == 1) {
                              pred <- phraser(input$phrase)
                              predtime <- round(pTime, 4)
                        }
                        else {
                              pred <- phraserGT(input$phrase)
                              predtime <- round(pTime, 4)
                        }
                        paste0("Prediction time in seconds: ", predtime)      
                  } else {
                        paste0("Prediction time in seconds: ")
                  }      
            }
      
      })
      
      output$wcloud <- renderPlot({
            if (input$pMethod == 1) {
                  phraser(input$phrase)
            }
            else {
                  phraserGT(input$phrase)
            }
      })
      
}

