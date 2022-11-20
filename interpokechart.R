#install.packages(c("shiny", "shinythemes"))
library(shiny)
library(shinythemes)
Pokemon <- read.csv("C:/Users/terra/projects/ColumbiaUniversity/CourseLessonPlans/WebApps/pokemon.csv")


ui<- fluidPage(
  theme=shinytheme("cerulean"),
  navbarPage("My Pokemon Charts",
            tabPanel("Pokemon Stats",
                     sidebarPanel(
                       tags$h3("Pokemon Type:"),
                       selectInput("type", label = "Choose a Pokemon type",
                                   choices = rownames(table(Pokemon$Type.1)),
                                   selected = "Fire")
                     ),
                     mainPanel(
                       h1("HP Chart"),
                       plotOutput(outputId="allPokemon")
                     )),
            tabPanel("Water Type Pokemon",
                     
                     sidebarPanel(
                       tags$h3("Input:"),
                       textInput("txt1", "Pokemon Name","")
                     ),
                     mainPanel(
                       h1("HP Chart"),
                       plotOutput(outputId="waterPokemon")
                     ))
            )
)

server<-function(input,output){
  
  Pokemon %>% filter(Pokemon$Type.1=="Water")->water_pokemon
  
  output$allPokemon <- renderPlot({
    Pokemon %>% filter(Pokemon$Type.1==input$type)->pokemon_by_type
    ggplot(data=pokemon_by_type, aes(x=HP, y=Speed))+geom_point(color="red")
  })
  
  output$waterPokemon <- renderPlot({
    ggplot(data=water_pokemon, aes(x=HP, y=Speed))+geom_point(color="blue")
  })
  
}

shinyApp(ui=ui,server=server)
