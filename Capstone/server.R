
server <- function(input, output){
  
    output$plot_top <- renderPlotly({
        plot1<- ggplot(job_count2,aes(x=count_cat,y= reorder(Sector,count_cat), text = label)) +
            geom_col(aes(fill = count_cat)) +
            scale_fill_gradient(low = 'black', high = 'maroon') +
            labs(title="The Most Sector Needed Data Science", 
                 x="job count", 
                 y=NULL) +
            theme_grey() + 
            theme(legend.position = "none")
    
        ggplotly(plot1, tooltip = "text")
        })
  
    output$plot_salary <- renderPlotly({
    
        job_age <- job_clean %>%
            mutate(label = glue("Company Age: {company_age}
                           Average Salary: {avg_salary}"))
    
        plot2 <- job_age %>% ggplot() + 
            geom_point(aes(x = company_age, y = avg_salary, text = label, col=job_age$avg_salary)) +
            labs(x = "Company Age", y = "Average Salary",
                title = "Company Age vs Average Salary")
    
        ggplotly(plot2, tooltip = "text")
        })
    
    output$plot_country <- renderPlotly({
    
        job_10 <- job_clean %>% 
            filter(Industry == input$industry) %>% 
            group_by(Location) %>% 
            ungroup() %>% 
            arrange(desc(avg_salary))
    
        job_10_2 <- head(job_10, 10) %>% 
            mutate(label = glue("Industry: {Location}
                            Average Salary: {comma(avg_salary)}"))
    
        plot3 <- ggplot(job_10_2, aes(x = avg_salary, y = reorder(Location, avg_salary), text = label)) +
            geom_col(aes(fill = avg_salary)) +
            labs(title = "Avarege Salary of Every Country",
                 x = "Avarage Salary",
                 y = NULL) +
                 scale_fill_gradient(low = "orange", high= "maroon") +
                 theme_minimal() +
                 theme(legend.position = "none") 
        
        ggplotly(plot3, tooltip = "text")
        })
    
    output$plot_employee <- renderPlotly({
    
        job5 <- filter(.data = job_clean, Rating == "5")
        jobstyle <- job5 %>% 
              group_by(Location)
        
        theme_algo2 <- theme(
          panel.background = element_rect(fill = "White"),
          panel.grid.major = element_line(colour = "White"),
          panel.grid.minor = element_blank(),
          plot.title = element_text(family = "", 
                                    size = 20, 
                                    color = "Black"))
        
        plot4 <- jobstyle %>% 
          filter(Size %in% input$select_employee) %>% 
          ggplot(aes(fill = Location, reorder(factor(Size), Size, function(x) -length(x)),
                     text = glue(
                       "Location = {Location}"                         
                     ))) +
          geom_bar(position = "Stack") +
          labs(title = "Best Rating of Company Based on Total Employee and Location",
               x = "Employee", 
               y = "Total of Best Rating") +
          theme_algo2
        
        ggplotly(plot4, tooltip = "text")
        })
  
  
    output$database <- DT::renderDataTable(job_clean, options = list(scrollx = T)
                                     
                                     
                                     
                                     
  )
}