#' The application User-Interface
#' 
#' 
#' https://github.com/ConalMonaghan/Shiny-Survey-and-Feedback-Site/blob/master/UI
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  box::use(s = shinydashboard, sp = shinydashboardPlus) # package aliases
  tagList(
    golem_add_external_resources(),
    # start of UI
    sp$dashboardPage(
      header = sp$dashboardHeader(
        title = "Applied Information Science",
        titleWidth = 500
      ),
      sidebar = s$dashboardSidebar(
        s$sidebarMenu(
          # id gives tabName of the currently-selected tab
          id = "tabs",
          s$menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
          s$menuItem("Muscle Group View", icon = icon("th"), tabName = "mg"),
          s$menuItem("Exercise View", icon = icon("bar-chart-o"), tabName = "ev"
          ))
      ),
      # show UI elements on selection
      body = s$dashboardBody(
        s$tabItems(
          s$tabItem("dashboard", mod_Home_ui("Home_ui_1")),
          s$tabItem("mg", mod_MuscleGroup_ui("MuscleGroup_ui_1")),
          s$tabItem("ev", mod_Exercises_ui("Exercises_ui_1")
          )
        ) 
      ),
      title = "Applied Information Science"
    )
  )
}


#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'testapp'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}
