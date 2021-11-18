library(shiny)
rm(list=ls())
data = data.frame(read.csv("/Users/lawrenceliu/Downloads/members.csv"))
data <- data[ -c(12:21) ]
data$Club.1.Abbreviation <- NULL
data$Birthdate.verified <- NULL
data$Section<- NULL
data$Club.2.Name<- NULL
data <- data[ -c(3:5, 10, 16:22,24:37)]
data$Expiration- NULL

names(data)[names(data) == "Referee.Highest.USA.Rating.Earned"] <- "Referee Rating"
# names(data)[names(data) == "Club.1.Name"] <- "Club Name"
names(data)[names(data) == "First.Name"] <- "First Name"
names(data)[names(data) == "Last.Name"] <- "Last Name"

data.2 = data[grep('C', data$Foil), ]

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Fencing Tracker"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("div",
                       "Division:",
                       c("All",
                         unique(as.character(data$Division))))
    ),
    column(4,
           selectInput("club",
                       "Club Name:",
                       c("All",
                         unique(as.character(data$Club.1.Name))))
    ),
    
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
  # 
  # # Sidebar layout with input and output definitions ----
  # sidebarLayout(
  #   
  #   # Sidebar panel for inputs ----
  #   sidebarPanel(
  #     
  #     # Input: Slider for the number of bins ----
  #     
  #   ),
  #   
  #   # Main panel for displaying outputs
  #   mainPanel(
  #     
  #     # Output: Histogram
  #     plotOutput(outputId = "distPlot")
  #     
  #   )
  # )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$table <- DT::renderDataTable(DT::datatable({
    data <- data
    if (input$div != "All") {
      data <- data[data$Division == input$div,]
    }
    if (input$club != "All") {
      data <- data[data$Club.1.Name == input$club,]
    }
    data
  }))
  
}
  



shinyApp(ui = ui, server = server)