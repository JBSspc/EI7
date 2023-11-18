# Cargamos los paquetes ------------------------------
library(shiny)
library(ggplot2)
library(dplyr)

# Cargamos los datos ---------------------------------
load("db_lupus2.RData")
load("descripcionGraf.RData")

# Definir la UI --------------------------------------
ui <- fluidPage(
  titlePanel("Calidad de vida de un paciente con Lupus"),
  textOutput("Introtitle"),
  textOutput("Introtext"),
  
  
  sidebarLayout(
    # Entradas
    sidebarPanel(
      selectInput(
        inputId = "variable", # Pregunta de calidad de vida
        label = "Aspecto relacionado con la calidad de vida: ",
        choices = colnames(db_lupus2[,2:27])
      ),
      selectInput(
        inputId = "variableGraf", # Pregunta de calidad de vida
        label = "Descripción del gráfico ",
        choices = colnames(df)
      ),
    
    ),
    # Salidas
    mainPanel(
    plotOutput(outputId = "plot"),
    verbatimTextOutput(outputId = "descripcion")
    )
  )
)

# Definir el servidor -----------------------------------
server <- function(input, output) {
  reactive_data <- reactive({
    db_lupus2 %>%
      count(dx_time, .data[[input$variable]], wt = NULL)
  })
  
  output$Introtitle <-renderText({"Introducción"})
  output$Introtext<- renderText({"El presente proyecto se enfoca en el diseño e implementación de una aplicación que permite visualizar las variables de tiempo de diagnóstico y calidad de vida para los sujetos con diagnóstico de lupus. 
En esta entrega, se incluyen gráficos estáticos que se  intregarán en un ambiente reactivo, con el fin de que el usuario pueda escoger una variable relacionada con la calidad de vida y pueda visualizar cómo ha sido la calidad de vida de los pacientes con lupus, según el tiempo de diagnóstico que tienen (desde el dianóstico formal hasta el momento en que se registró en la base de datos). Lo anterior, puede ayudarles a conocer algunas características que podrían esperar de la enfermedad en los próximos años."})
  
  
  des <- reactive({
    data[, input$varaibleGraf, drop = FALSE]
  })
  
  output$plot <- renderPlot({
    data <- reactive_data()
    data$calidad_vida <- as.factor(data[[input$variable]])
    
    ggplot(data, aes(dx_time, n, colour = calidad_vida)) +
      geom_point(position = "jitter") +
      xlab("Tiempo de diagnóstico (años)") +
      ylab("Incidencia") +
      ggtitle(paste("Tiempo de diagnóstico y", input$variable)) +
      scale_colour_hue() +
      guides(colour = guide_legend(title = paste("¿Cómo puntuaría su", input$variable, "?"))) +
      theme(text = element_text(size = 15))
  })
  
  output$descripcion <- renderPrint({
    des()
  })


}

# Crear un objeto de Shiny app --------------------
shinyApp(ui=ui, server = server)
