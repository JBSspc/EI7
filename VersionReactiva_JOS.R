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
