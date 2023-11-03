# Cargamos los paquetes ------------------------------
library(shiny)
library(ggplot2)
library(dplyr)

# Cargamos los datos ---------------------------------
load("db_lupus_cv.RData")

# Definir la UI --------------------------------------
ui <- fluidPage(
  titlePanel("Calidad de vida de un paciente con Lupus"),
  
  sidebarLayout(
    # Entradas
    sidebarPanel(
      selectInput(
        inputId = "variable", # Pregunta de calidad de vida
        label = "Aspecto relacionado con la calidad de vida: ",
        choices = colnames(rdata[,43:68])
      ),
    ),
    # Salidas
    mainPanel(
    plotOutput(outputId = "scatterplot")
    )
  )
)

# Definir el servidor ------------------------------
server <-function(input, output, session){
  output$scatterplot <- renderPlot({
    ggplot(data=, aes_string(x=input$x, y = input$y))+
      geom_point()
  })
}

# Crear un objeto de Shiny app --------------------
shinyApp(ui=ui, server = server)
