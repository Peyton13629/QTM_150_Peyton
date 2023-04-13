
library(shiny)
library(palmerpenguins)
dataset1 <- penguins %>% 
  filter(!species %in% c("Adelie", "Chinstrap"))
dataset2 <- penguins %>% 
  filter(!species %in% c("Adelie", "Gentoo"))
dataset3 <- penguins %>% 
  filter(!species %in% c("Chinstrap", "Gentoo"))

# Define UI ----
ui <- fluidPage(
  titlePanel("Penguin Dataset Exploration "),
  radioButtons(
    inputId = "my_radio",
    label = "Choose a species of penguin to summarise:",
    choices = c("Gentoo Penguin", "Chinstrap Penguin", "Adelie Penguin"),
    selected = "Gentoo Penguin"
  ),
  verbatimTextOutput("summary_output")
)

# Define server logic ----
server <- function(input, output) {
  # Render the summary output based on selected dataset
  output$summary_output <- renderPrint({
    # Choose dataset based on radio button value
    dataset <- switch(input$my_radio,
                      "Gentoo Penguin" = dataset1,
                      "Chinstrap Penguin" = dataset2,
                      "Adelie Penguin" = dataset3)
    
    # Apply summary function on selected dataset
    summary(dataset)
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
