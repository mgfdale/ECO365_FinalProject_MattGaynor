library(shiny)
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)
library(shinythemes)
library(rlang)
library(DT)
library(plotly)
library(ggthemes)
library(ggrepel)
library(rsconnect)


smash_df<- read.csv("smash_df.csv")

smash_df <- select(smash_df, -1)

#Lets now select the most important data columns to present on the home screen
short_smash_df <- smash_df %>% select(c("Character","Air.speed","Walk.Speed","Run.Speed","Dash.Frames","Regular.Fall",
                     "Grab.Range","Air.Jump","Weight"))


heavy_hit <- smash_df %>% select(c("Character","Weight","Regular.Fall","Run.Speed","Dash.Frames","Air.Jump"))

#Lets arange by descending weight
heavy_hit <- heavy_hit %>% arrange(desc(Weight))

#creating a df for speed
fast_hit <- smash_df %>% select(c("Character","Walk.Speed","Run.Speed","Dash.Frames","Air.Jump", "Weight"))

#Lets arange by descending speed
fast_hit <- fast_hit %>% arrange(desc(Run.Speed))

#Creating a df for each data category

#air dataframe below
air_df <- smash_df %>% select(c("Character","air_speed_rank", "Air.speed","air_acceleration_rank","air_acceleration_base","air_acceleration_additional",
                                "air_acceleration_max","Air.Jump"))

#Lets arange by descending Air Speed
air_df <- air_df %>% arrange(desc(Air.speed))


#roll dataframe below
roll_df <- smash_df %>% select(c("Character","forward_roll_rank","forward_roll_start_up"
                                 ,"forward_roll_total","backward_roll_start_up","backward_roll_rank",
                                 "backward_roll_rank"))
#Arrange the df in a specific order
roll_df <- roll_df %>% arrange(forward_roll_rank)



#dash dataframe below
dash_df <- smash_df %>% select(c("Character", "Dash.Frames", "Initial.Dash", "Pivot.Dash.Frames",
                                 "Fast..Initial.Dash.","Slow..Full.Dash."))

#This puts the characters with the LEAST amount of dash frames first
dash_df <- dash_df %>% arrange(Dash.Frames)


#speed dataframe below
speed_df <- smash_df %>% select(c("Character", "Walk.Speed" ,"Run.Speed"))

#Arranged with the fastest character at the top
speed_df <- speed_df %>% arrange(desc(Run.Speed))


#fall dataframe below
fall_df <- smash_df %>% select(c("Character","Regular.Fall","Fast.Fall", "fall_speed_rank", "Gravity"))

#Arrange with the highest regular fall number first
fall_df <- fall_df %>% arrange(desc(Regular.Fall))


#hop dataframe below
hop_df <- smash_df %>% select(c("Character", "Short.Hop.x", "Full.Hop.x","Hard.Land","Gravity"))

#Arrange with the shortest/lowest hop number first on the chart
hop_df <- hop_df %>% arrange(Short.Hop.x)


#frame dataframe below
framedata_df <- smash_df %>% select(c("Character","Attack.Frames", "Grab.Range", 
                                      "Neutral.Getup","ledge_roll","ledge_jump"))

#Arrange the df in a specific order

framedata_df <- framedata_df %>% arrange(desc(Attack.Frames))


#dodge dataframe below
dodge_df <- smash_df %>% select(c("Character", "na_dodge_rank", "na_dodge_startup",
                                  "Intangible.Until","na_dodge_total"))
#Arrange the df in a specific order

dodge_df <- dodge_df %>% arrange(na_dodge_rank)





#Webiste code below


#front end code below (UI)
ui <- fluidPage(theme = shinytheme("cosmo"),
                navbarPage(
                  "Super Smash Brothers Ultimate Data",
                  
                  #first Tab code is below
                  tabPanel("Core Statistics", "A general overview of key statistics shown throughout each tab:",
                   imageOutput("banner"),
                   dataTableOutput("dynamic"),
                   plotOutput("faceting"),
                   tableOutput("data"),
                   plotOutput("plot", brush = "plot_brush")
                  ), #Second tab code is below
                  tabPanel("Heavy Hitters","The Characters shown below are best to choose if you’re 
                           a more conservative player that likes to deal massive hits to others.
                           Those that deal greater damage tend to be slower and weigh more. The heaviest character within the game is Bowser:", #MORE DESCRIPTIONS LIKE THIS
                           dataTableOutput("heavy"),
                           imageOutput("bowser"),
                           tableOutput("data2"),
                           plotOutput("plot2", brush = "plot_brush"),
                  ), #third tab code is below
                  tabPanel("Speedy Characters","The Characters shown below are best to choose if 
                  you’re a more aggressive player that likes to deal less damage at a faster pace.
                           Those that are faster deal less damage and tend to weigh less than others. The fastest character within the game is Sonic:", 
                           dataTableOutput("fast"),
                           imageOutput("sonic"),
                           tableOutput("data3"),
                           plotOutput("plot3", brush = "plot_brush")
                  ), #Air Tab code is below
                  tabPanel("Air Statistics","The Characters shown below are best to choose if 
                  you’re a player that likes to deal damage in the air.
                           Those that are the most mobile while moving in the air tend to weigh less than others. 
                           The character that holds the highest air speed within the game is Yoshi:",
                           dataTableOutput("air_table"),
                           imageOutput("yoshi"),
                           tableOutput("data_air"),  
                           plotOutput("plot_air", brush = "plot_brush")
                  ), #Roll Tab code is below
                  tabPanel("Roll Statistics","The Characters shown below are best to choose if 
                  you’re a player that relies heavily on rolling to dodge attacks.
                           Those that roll in the least amount of frames tend to be faster than others. 
                           The character that holds the highest roll rank within the game is Bayonetta:",
                           dataTableOutput("roll_table"),
                           imageOutput("bayo"),
                           plotOutput("plot_roll_forward"),
                           plotOutput("plot_roll_backward"),
                           tableOutput("data_roll"),  
                           plotOutput("plot_roll", brush = "plot_brush")
                  ), #Dash Tab code is below
                  tabPanel("Dash Statistics","Similar to Speed; The Characters shown below are best to choose if your playstyle is
                           between being aggressive but also conservative. The less dash frames a character holds, the faster their movement is.
                           The character that holds the least amount of dash frames is Sheik:",
                           dataTableOutput("dash_table"),
                           imageOutput("sheik"),
                           tableOutput("data_dash"),  
                           plotOutput("plot_dash", brush = "plot_brush")
                  
                  ), #Speed Tab code is below
                  tabPanel("Speed Statistics","The Characters shown below are best to choose if 
                  you’re a more aggressive player that likes to deal less damage but at a faster pace.
                           Those that are faster deal less damage and tend to weigh less than others. The fastest character within the game is Sonic:",
                           dataTableOutput("speed_table"),
                           imageOutput("Sonic"),
                           tableOutput("data_speed"),  
                           plotOutput("plot_speed", brush = "plot_brush")
                  ), #Fall Tab code is below
                  tabPanel("Fall Statistics","The Characters shown below are best to choose if 
                  you’re a player that prefers to stay on stage during the fight. The characters shown below 
                           fall at a greater speed than others while in the air - it is recommended that you do not choose these 
                           characters if you enjoy dealing damage while in the air or potentially while not over the stage.
                           The character with the highest fall speed and highest gravity value (making said character drop down at a higher speed)
                           is Fox:",
                           dataTableOutput("fall_table"),
                           imageOutput("fox"),
                           tableOutput("data_fall"),  
                           plotOutput("plot_fall", brush = "plot_brush")
                  ), #Hop tab code is below
                  tabPanel("Hop Statistics","Similar to Fall: The Characters shown below are best to choose if 
                  you’re a player that prefers to stay on stage during the fight. The characters shown below 
                           hop at a greater speed than others, while in the air - a faster hop leads to faster ariel attacks.
                           The character with the lowest hop frame (thus making the hop faster in real-time)
                           is Fox:",
                           dataTableOutput("hop_table"),
                           imageOutput("Fox"),
                           plotOutput("plot_shorthop"),
                           plotOutput("plot_fullhop"),
                           tableOutput("data_hop"),  
                           plotOutput("plot_hop", brush = "plot_brush")
                  ), #Frame tab code is below
                  tabPanel("Frame Statistics","These statistics show all of the Frame stats for each Character,
                           arranged with the fastest attack frame appearing at the top of the list (the lower the attack frame,
                           the faster that attack is). The character with the fastest attack frame is Squirtle:",
                           dataTableOutput("frame_table"),
                           imageOutput("squirtle"),
                           plotOutput("plot_frame"),
                           plotOutput("plot_frame2")
                  ),  #Dodge tab code is below
                  tabPanel("Dodge Statistics","Similar to Frame; The Characters shown below are best to choose if 
                  you’re a player that relies heavily on dodging during each fight.  
                           The characters shown below are arranged with the fastest Dodge frame (enabling them to dodge at a faster rate than others) appearing at the top of the list.
                           The character with the fastest/lowest dodge frame is Bayonetta:",
                           dataTableOutput("dodge_table"),
                           imageOutput("Bayo"),
                           plotOutput("plot_dodge"),
                           plotOutput("plot_dodge2"),
                           tableOutput("data_dodge"),  
                           plotOutput("plot_dodge3", brush = "plot_brush")
                  ),
                  #URL Tab code is below
                  tabPanel("View Source",
                    uiOutput("dev"),
                    imageOutput("smashball")
                    ),
        )
)




#backend code
server <- function(input, output, session) {
  
  
  #First Tab Code Below
  output$dynamic <- renderDataTable(short_smash_df, options = list(pageLength = 5))
  
  output$faceting <- renderPlot({
    ggplot(short_smash_df, aes(x="Grab.Range",y="Dash.Frames",color=Character)) + geom_tile() + geom_point() +
      geom_jitter() + ggtitle("Dash Frames against Grab Range")
  })
  
  
  output$data <- renderTable({
    brushedPoints(short_smash_df, input$plot_brush)
  })
  
  output$plot <- renderPlot({
    ggplot(short_smash_df, aes(Walk.Speed,Dash.Frames)) + geom_point() + ggtitle("Dash Frames against Walk Speed") + theme_base()
  }, res = 96) 
  

  #Image backend code below - banner
  output$banner <- renderImage({
    filename <- normalizePath(file.path('./banner.jpeg',
                                        paste('image', '2', '.jpeg', sep='')))
    
    # Return a list containing the filename
    list(src = "./banner.jpeg", alt = "Alternate text", width=1390,height=370) #Use this to change image size
  })
  

  #Below here is for the heavy tab
  output$heavy <- renderDataTable(heavy_hit,options = list(pageLength = 5))
 
  output$data2 <- renderTable({
    brushedPoints(heavy_hit, input$plot_brush)
  })
  
   output$plot2 <- renderPlot({
    ggplot(heavy_hit, aes(Run.Speed, Weight)) + geom_point() + ggtitle("Weight Against Speed") + theme_gdocs()
  }, res = 96) 
  
  
  #Generate images for bowser; just do characters at the top of the table
   
   #Image backend code below for - bowser
   output$bowser <- renderImage({
     filename <- normalizePath(file.path('./bowser.jpeg',
                                         paste('image', '2', '.jpeg', sep='')))
     
     # Return a list containing the filename
     list(src = "./bowser.jpeg", alt = "Alternate text", width=700,height=400)
   })
   
  
  #Below here is for the fast tab
  output$fast <- renderDataTable(fast_hit,options = list(pageLength = 5))
  
  output$data3 <- renderTable({
    brushedPoints(heavy_hit, input$plot_brush)
  })
  
  output$plot3 <- renderPlot({
    ggplot(fast_hit, aes(Run.Speed, Dash.Frames)) + geom_point() + ggtitle("Dash Frames Against Run Speed") + theme_calc()
  }, res = 96) 
  
  
  #Image backend code below for - sonic
  output$sonic <- renderImage({
    filename <- normalizePath(file.path('./sonic.jpeg',
                                        paste('image', '2', '.jpeg', sep='')))
    
    # Return a list containing the filename
    list(src = "./sonic.jpeg", alt = "Alternate text", width=700,height=400)
  })

  
  #Below here is for the air tab
  output$air_table <- renderDataTable(air_df,options = list(pageLength = 5))
  
  output$data_air <- renderTable({
    brushedPoints(air_df, input$plot_brush)
  })
  
  output$plot_air <- renderPlot({
    ggplot(air_df, aes(Air.speed, Air.Jump)) + geom_point() + coord_flip() + ggtitle("Air Speed Against Air Jump")
  }, res = 96) 
  
  #Image backend code below for - yoshi
  output$yoshi <- renderImage({
    filename <- normalizePath(file.path('./yoshi.jpeg',
                                        paste('image', '2', '.jpeg', sep='')))
    
    # Return a list containing the filename
    list(src = "./yoshi.jpeg", alt = "Alternate text", width=700,height=400)
  })
  
  #Below here is for the roll tab
  output$roll_table <- renderDataTable(roll_df,options = list(pageLength = 5))
  
  #forward roll barchart
  output$plot_roll_forward <- renderPlot({
    ggplot(data=roll_df, aes(forward_roll_start_up)) + geom_bar() + ggtitle("Forward Roll Start Up Frame Count") + theme_light()
  }, res = 96) 
  
  #backward roll barchart
  output$plot_roll_backward <- renderPlot({
    ggplot(data=roll_df, aes(backward_roll_start_up)) + geom_bar() + ggtitle("Backward Roll Start Up Frame Count") + theme_light()
  }, res = 96) 
  
  #roll chart with brush point code below
  output$data_roll <- renderTable({
    brushedPoints(roll_df, input$plot_brush)
  })
  
  output$plot_roll <- renderPlot({
    ggplot(roll_df, aes(backward_roll_start_up,forward_roll_start_up)) + geom_point() + ggtitle("Forward Roll Start Against Backward Roll Start Up") + theme_clean()
  }, res = 96) 
  
  #Image backend code below for - bayo
  output$bayo <- renderImage({
    filename <- normalizePath(file.path('./bayo.jpeg',
                                        paste('image', '2', '.jpeg', sep='')))
    
    # Return a list containing the filename
    list(src = "./bayo.jpeg", alt = "Alternate text", width=700,height=400)
  })
  
  
  #Below here is the Dash Code USE THIS FORMAT FOR REFERENCE
  output$dash_table <- renderDataTable(dash_df,options = list(pageLength = 5))
  
  output$data_dash <- renderTable({
    brushedPoints(dash_df, input$plot_brush)
  })
  
  output$plot_dash <- renderPlot({
    ggplot(dash_df, aes(Initial.Dash,Dash.Frames)) + geom_point() + ggtitle("Dash Frames Against Initial Dash Frames") + theme_fivethirtyeight()
  }, res = 96) 
  
  #Image backend code below - sheik
  output$sheik <- renderImage({
    filename <- normalizePath(file.path('./sheik.jpeg',
                                        paste('image', '2', '.jpeg', sep='')))
    
    # Return a list containing the filename
    list(src = "./sheik.jpeg", alt = "Alternate text", width=700,height=400)
  })
  

  
  #Code for the speed tab
  output$speed_table <- renderDataTable(speed_df,options = list(pageLength = 5))
  
  output$data_speed <- renderTable({
    brushedPoints(speed_df, input$plot_brush)
  })
  
  output$plot_speed <- renderPlot({
    ggplot(speed_df, aes(Walk.Speed,Run.Speed)) + geom_point() + ggtitle("Run Speed Against Walk Speed") + theme_base()
  }, res = 96) 
  
  #Image backend code - sonic
  output$Sonic <- renderImage({
    filename <- normalizePath(file.path('./sonic.jpeg',
                                        paste('image', '2', '.jpeg', sep='')))
    
    # Return a list containing the filename
    list(src = "./sonic.jpeg", alt = "Alternate text", width=700,height=400)
  })
  
  
  #Code for the fall tab
  output$fall_table <- renderDataTable(fall_df,options = list(pageLength = 5))
  
  output$data_fall <- renderTable({
    brushedPoints(fall_df, input$plot_brush)
  })
  
  output$plot_fall <- renderPlot({
    ggplot(fall_df, aes(Gravity,Regular.Fall)) + geom_point() + ggtitle("Fall Speed Against Gravity") + theme_foundation()
  }, res = 96) 
  
  #Image backend code - fox
  output$fox <- renderImage({
    filename <- normalizePath(file.path('./fox.png',
                                        paste('image', '2', '.png', sep='')))
    
    # Return a list containing the filename
    list(src = "./fox.png", alt = "Alternate text", width=700,height=400)
  })
  

  #Below here is for the hop tab
  output$hop_table <- renderDataTable(hop_df,options = list(pageLength = 5))
  
  #short hop barchart
  output$plot_shorthop <- renderPlot({
    ggplot(data=hop_df, aes(Short.Hop.x)) + geom_bar() + ggtitle("Short Hop Frame Count") + theme_light()
  }, res = 96) 
  
  #full hop barchart
  output$plot_fullhop <- renderPlot({
    ggplot(data=hop_df, aes(Full.Hop.x)) + geom_bar() + ggtitle("Full Hop Frame Count") + theme_light()
  }, res = 96) 
  
  #hop chart with brush point code below
  output$data_hop <- renderTable({
    brushedPoints(hop_df, input$plot_brush)
  })
  
  output$plot_hop <- renderPlot({
    ggplot(hop_df, aes(Short.Hop.x,Full.Hop.x)) + geom_point() + ggtitle("Full Hop Against Short Hop") + theme_light()
  }, res = 96) 
  
  
  #Image backend code  - fox
  output$Fox <- renderImage({
    filename <- normalizePath(file.path('./fox.png',
                                        paste('image', '2', '.png', sep='')))
    
    # Return a list containing the filename
    list(src = "./fox.png", alt = "Alternate text", width=700,height=400)
  })

  #Below here is for the Frame tab
  output$frame_table <- renderDataTable(framedata_df,options = list(pageLength = 5))
  
  #short hop barchart
  output$plot_frame <- renderPlot({
    ggplot(data=framedata_df, aes(Attack.Frames)) + geom_bar(width = 0.7) + coord_flip() + theme_light()
  }, res = 96) #Use cord flip to change axi orientation for it to show the text  
  
  #full hop barchart
  output$plot_frame2 <- renderPlot({
    ggplot(data=framedata_df, aes(Neutral.Getup)) + geom_bar() + theme_light()
  }, res = 96) 
  
  #Image backend code below for squirtle
  output$squirtle <- renderImage({
    filename <- normalizePath(file.path('./squirtle.jpeg',
                                        paste('image', '2', '.jpeg', sep='')))
    
    # Return a list containing the filename
    list(src = "./squirtle.jpeg", alt = "Alternate text", width=700,height=400)
  })

  
  #Below here is for the Dodge tab
  output$dodge_table <- renderDataTable(dodge_df,options = list(pageLength = 5))
  
  #dodge startup frame barchart
  output$plot_dodge <- renderPlot({
    ggplot(data=dodge_df, aes(na_dodge_startup,na.rm=TRUE)) + geom_bar(width = 0.7,na.rm = TRUE) + coord_flip() + theme_light()
  }, res = 96) #Use cord flip to change axi orientation for it to show the text  
  
  #total dodge frame barchart
  output$plot_dodge2 <- renderPlot({
    ggplot(data=dodge_df, aes(na_dodge_total,na.rm=TRUE)) + geom_bar(na.rm = TRUE) + theme_light()
  }, res = 96) 
  
  #dodge chart with brush point code below
  output$data_dodge <- renderTable({
    brushedPoints(dodge_df, input$plot_brush)
  })
  
  #dodge chart point code below
  output$plot_dodge3 <- renderPlot({
    ggplot(dodge_df, aes(na_dodge_startup,na_dodge_total)) + geom_point() + theme_pander()
  }, res = 96) 
  
  #Image backend code below for - bayo
  output$Bayo <- renderImage({
    filename <- normalizePath(file.path('./bayo.jpeg',
                                        paste('image', '2', '.jpeg', sep='')))
    
    # Return a list containing the filename
    list(src = "./bayo.jpeg", alt = "Alternate text", width=700,height=400)
  })

  
  #URL Backend Code below
  url <- a("https://ultimateframedata.com/stats", href="https://ultimateframedata.com/stats")
  output$dev <- renderUI({
    tagList("Smash Statistics Webpage:", url)
  })
  
  
  #Image backend code below THIS WORKS
    output$smashball <- renderImage({
      filename <- normalizePath(file.path('./smashball.png',
                                          paste('image', '2', '.png', sep='')))
      
      # Return a list containing the filename
      list(src = "./smashball.png", alt = "Alternate text", width=1390,height=670)
    })

    


}

shinyApp(ui, server)







