

ui <- dashboardPage(
  dashboardHeader(title = "Data Science Job Analytics"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Overview", tabName = "overview", icon = icon("industry")),
      menuItem(text = "Employee", tabName = "employee", icon = icon("user")),
      menuItem(text = "Data Source", tabName = "data", icon = icon("database"))
    )
  ),
  dashboardBody(
    tabItems( #untuk mengakses menu per identitas yang dipanggil
      tabItem(tabName = "overview"
              , #akses identitas 
              fluidRow(
                valueBox(width = 6,
                         value = nrow(job_clean),
                         subtitle = "Total Data Science Job",
                         icon = icon("briefcase")),
                valueBox(width = 6,
                         value = n_distinct(job_clean$Location),
                         subtitle = "Total Location",
                         icon = icon("globe"))
                ),
              
              fluidRow(
                box(title = "Top Sector on Data Science Job",
                    width = 12, 
                    plotlyOutput(outputId = "plot_top")),
                 box(title = "Correlation Between Company Age and Average Salary",
                     width = 12,
                     plotlyOutput(outputId = "plot_salary"))
              )), 
     
      tabItem(tabName = "employee"
              ,
              fluidRow(
                box(width = 12, 
                    selectInput(inputId = "industry",
                                label= "Choose Your Sector:", 
                                choices= unique(job_clean$Industry),
                                selected = "Consulting")),
                box(width = 12, 
                    plotlyOutput(outputId = "plot_country"))
              ),
              
              fluidRow(
                box(width = 12, 
                    checkboxGroupInput(inputId = "select_employee",
                                      label = "Select Total Employee",
                                      choices = unique(job5$Size),
                                      inline = T,
                                      selected = c("1 to 50", "51 to 200", "Unknown")),
                    box(width = 12, 
                        plotlyOutput(outputId = "plot_employee"))
                )
                )), 
    
      tabItem(tabName = "data"
              , 
              fluidRow(
                box(width = 12,
                    title = "Data Science Job",
                    DT::dataTableOutput(outputId = "database"))
                      )
              )
    )
  )
)


  
    

  

