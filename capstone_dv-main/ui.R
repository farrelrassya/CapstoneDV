library(shiny)
library(shinydashboard)

    header <- dashboardHeader(
      title = "AIR POLUTTION JKT MEI 2021"
    )
    
    sidebar <- dashboardSidebar(
      sidebarMenu(
        menuItem(
          text = "Introduction",
          tabName = "intro",
          icon = icon("info")
        ),
        menuItem(
          text = "Air Pollutant Standard Index",
          tabName = "ispu",
          icon = icon("radiation-alt")
        ),
        menuItem(
          text = "Data",
          tabName = "data",
          icon = icon("book")
        )
      )
    )
    
    body <- dashboardBody(
      tabItems(
        
        # TAB 1
        tabItem(
          tabName = "intro",
          fluidPage(
            h2(tags$b("Air Pollutant Standard Index")),
            br(),
            div(style = "text-align:justify",
                p("Air Pollution Standard Index (ISPU) according to the Ministry of Environment and Forestry
                  The Republic of Indonesia is a number that does not have a unit that describes the quality condition
                  ambient air at a specific location and time based on the impact on health
                  humans, aesthetic values ​​and other living things.",
                  "Air Pollutant Standard Index data obtained from the operation of the Monitoring Station
                  Automatic Ambient Air Quality. While the Air Pollutant Standard Index Parameters
                  include: Matter Particles (PM10 and PM 2.5), Carbon dioxide (CO), Sulfur dioxide (SO2), Nitrogen dioxide (NO2)."),
                br()
                )
            )
            ), 
        #TAB 2
        tabItem(
          tabName = "ispu",
          fluidRow(
            valueBox(value = ispu$stasiun %>% 
                       unique() %>% 
                       length(),
                     subtitle = "Number of Stations per Region",
                     width = 4,
                     color = "orange",
                     icon = icon("map-marker-alt")),
            valueBox(value = ispu_case1$Parameter_Polutan %>% 
                       unique() %>% 
                       length(),
                     width = 4,
                     subtitle = "Number of Pollutant Parameters",
                     color = "lime",
                     icon = icon("atom")),
            valueBox(value = ispu$categori %>% 
                       unique() %>% 
                       length(),
                     width = 4,
                     subtitle = "Total Air Pollutant Standard Index Category",
                     color = "yellow",
                     icon = icon("seedling"))),
          fluidPage(  #PLOT 1
            box(
              width = 7,
              plotlyOutput("plot1"),
              title = "Average Pollutant Parameters per DKI Jakarta Station",
              solidHeader = T),
            box(
              width = 5,
              height = 460,
              background = "lime",
              selectInput(inputId = "stasiun_id",
                          label = "Station Area",
                          choices = unique(ispu$stasiun))
        )
      ),
      fluidPage(  #PLOT 2
        box(
          width = 8,
          plotlyOutput("plot2"),
          title = "Total Air Pollutant Standard Index Category",
          solidHeader = T),
        box(
          width = 4,
          height = 460,
          background = "lime",
          dateRangeInput(
            inputId = "tanggal",
            label = "Range Date",
            start = "2021-05-01",
            end = "2021-05-31",
            min = "2021-05-01",
            max = "2021-05-31",
            format = "yyyy-mm-dd",
            startview = "month",
            weekstart = 0,
            language = "en",
            separator = " to ",
            width = NULL,
            autoclose = TRUE
          )
  )
      )
    ),
  tabItem(
    tabName = "data",
    fluidRow(
      box(width = 12,
          DT::dataTableOutput("data_ispu"))
    )
  )
  )
)
    
dashboardPage(
  header = header,
  body = body,
  sidebar = sidebar,
  skin = "green"
)