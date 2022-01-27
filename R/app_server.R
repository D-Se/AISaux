#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  callModule(mod_Home_server, "Home_ui_1")
  callModule(mod_Exercises_server, "Exercises_ui_1")
  callModule(mod_MuscleGroup_server, "MuscleGroup_ui_1")
}
