get_scores <- function(item, n){
  as.numeric(
    paste0("c(",
           paste0("input$", item, n, collapse = ", "),
           ")")
  )
}


#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  box::use(g = googlesheets4, magrittr)
  googlesheets4::gs4_auth(
    cache = ".secrets",
    email = "2869830202@qq.com"
  )
  
  Data <- googlesheets4::gs4_get("1FveHRUUPTN2yuMh4CTkXxrxlzhXgOKXpbQ6eyCUnv9E")
  
  #Data <- "1FveHRUUPTN2yuMh4CTkXxrxlzhXgOKXpbQ6eyCUnv9E"
  # Your application server logic 
  callModule(mod_Home_server, "Home_ui_1")
  callModule(mod_Exercises_server, "Exercises_ui_1")
  callModule(mod_MuscleGroup_server, "MuscleGroup_ui_1")
  
  Score <- reactive({as.numeric(
    (as.numeric(input$Score1) + as.numeric(input$Score2) + as.numeric(input$Score3) + as.numeric(input$Score4) + as.numeric(input$Score5) + as.numeric(input$Score6) +
       as.numeric(input$Score7) + as.numeric(input$Score8) + as.numeric(input$Score9) + as.numeric(input$Score10) + as.numeric(input$Score11) +
       as.numeric(input$Score12) + as.numeric(input$Score13) + as.numeric(input$Score14) + as.numeric(input$Score15) + as.numeric(input$Score16))/16
  )})
  output$Curve <- renderPlot({
    Score() * 2
  })
  output$Output <- renderText({ 
    paste("hi there", Score())})
  
  ################# Setup Data download    ##########################
  
  ### Make a Results vector comprising the participant data which we can then add to our Google data
  # Results <- reactive(c(
  #   input$Score1, input$Score2, input$Score3, input$Score4, input$Score5, input$Score6, input$Score7, input$Score8, input$Score9, input$Score10, input$Score11, input$Score12, input$Score13, input$Score14, input$Score15, input$Score16,
  #   Score(),
  #   input$Gender, input$Age, input$Ethnicity, input$Country, input$eco_Liberal, input$Soc_Liberal, input$Religiousness, input$Agree, input$Real,
  #   Sys.time()
  # ))
  # 
  Results <- reactive({
    x = matrix(c(
    "hi", input$Score1, input$Score2, input$Score3, input$Score4, input$Score5,
    input$Score6, input$Score7, input$Score8, input$Score9, input$Score10, input$Score11, input$Score12,
    input$Score13, input$Score14, input$Score15, input$Score16, input$Score, input$Gender, input$Age, input$Ethnicity,
    input$Country, input$eco_Liberal, input$Soc_Liberal, input$Religiousness, input$Agree, input$Real
  ), ncol = 27)
    colnames(x) = c("Time", "Score1", "Score2", "Score3", "Score4", "Score5", "Score6", 
                    "Score7", "Score8", "Score9", "Score10", "Score11", "Score12", 
                    "Score13", "Score14", "Score15", "Score16", "Score", "Gender", 
                    "Age", "Ethnicity", "Country", "eco_Liberal", "Soc_Liberal", 
                    "Religiousness", "Agree", "Accuracy")
    as.data.frame(x)
  })
  
  ### Reactive function to send data to Google. This will add the new row at the bottom of the dataset in Google Sheets
  observeEvent(input$n, {                                                                 #  Observe event action from Actionbutton
    Data  <- g$sheet_append(Data, sheet = "Data", Results())                                                                       ## Occasionally there are some issues if there is not at least 1-2 rows of data in the file. Best to make suedo data 
                                                 #  When actionbutton is pressed this will add their data to the good .doc                    
  }
  )
  
  # ### Full download
  # Filename <- paste0("Website Data", Sys.Date(), ".xlsx")         # Label the filename, with date
  # 
  # observeEvent(input$Fulldownload, {    ## Creates the download of Data into the GS file
  #   g$gs_title("Data") %>% 
  #     g$gs_download(to = Filename)    }
  # )
  # g$
}


# box::use(g = googlesheets4)



# Data <- googlesheets4::gs4_create("Data")
# googlesheets4::sheet_rename(Data, sheet = "Sheet1", new_name = "Data")
# 
# Setupvalues <- rbind(c("Time", "Score1", "Score2", "Score3", "Score4", "Score5", "Score6", "Score7", "Score8", "Score9", "Score10", "Score11", "Score12", "Score13", "Score14", "Score15", "Score16",
#                        "Score",
#                        "Gender", "Age", "Ethnicity", "Country", "eco_Liberal",  "Soc_Liberal", "Religiousness", "Agree", "Accuracy"),
#                      c(seq(1, 27))
# )
# cols = Setupvalues[1,]
# dput(cols)
# Data <- Data %>%
#   googlesheets4::write_sheet(data = as.list(1:27) |>
#                                setNames(
#                                  Setupvalues[1,]) |>
#                                as.data.frame()
#                              , sheet = "Data")


# 
# length(
#   c("Time", "Score1", "Score2", "Score3", "Score4", "Score5", "Score6", 
#     "Score7", "Score8", "Score9", "Score10", "Score11", "Score12", 
#     "Score13", "Score14", "Score15", "Score16", "Score", "Gender", 
#     "Age", "Ethnicity", "Country", "eco_Liberal", "Soc_Liberal", 
#     "Religiousness", "Agree", "Accuracy")
# )

# library(googlesheets4)
