# Cargamos los paquetes ------------------------------
library(shiny)
library(ggplot2)

# Cargamos los datos ---------------------------------
load("db_lupus_cv.RData")

# Definir la UI --------------------------------------
ui <- fluidPage(
  titlePanel("Calidad de vida de un paciente con Lupus"),
  
  sidebarLayout(
    # Entradas
    sidebarPanel(
      selectInput(
        inputId = "pregunta_calidad_vida", # Pregunta de calidad de vida
        label = "Aspecto relacionado con la calidad de vida: ",
        choices = c("Calidad de vida", "Salud", "Impedimento por dolor",
                    "Cantidad de medicamento", "Disfrutar la vida",
                    "Sentido de la vida", "Concentración", "Seguridad",
                    "Ambiente físico saludable", "Capacidad para desplazarse",
                    "Suficiente energía", "Aceptación de la apariencia",
                    "Suficiente dinero", "Información disponible",
                    "Oportunidad de ocio", "Sueño", "Actividades diarias",
                    "Capacidad de trabajo", "Satisfacción de uno mismo",
                    "Relaciones personales", "Vida sexual", " Apoyo de los amigos",
                    "Condiciones de vivienda", "Acceso a servicios sanitarios",
                    "Transporte", "Frecuencia de sentimientos negativos"),
        selected = "Calidad de vida"
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