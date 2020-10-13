library(shiny)
library(rhandsontable)

shinyServer = function(input, output, session) {
  output$overview_UI <- renderUI({
    argonTable(
      cardWrap = T,
      headTitles = c(
        "PROJECT",
        "BUDGET",
        "STATUS",
        "USERS",
        "COMPLETION",
        ""
      ),
      argonTableItems(
        argonTableItem("Overview"),
        argonTableItem(dataCell = TRUE, "$2,500 USD"),
        argonTableItem(
          dataCell = TRUE, 
          argonBadge(
            text = "Pending",
            status = "danger"
          )
        ),
        argonTableItem(
          argonAvatar(
            size = "sm",
            src = "https://image.flaticon.com/icons/svg/219/219976.svg"
          )
        ),
        argonTableItem(
          dataCell = TRUE, 
          argonProgress(value = 60, status = "danger")
        ),
        argonTableItem(
          argonButton(
            name = "Click me!",
            status = "warning",
            icon = "atom",
            size = "sm"
          )
        )
      )
    )
  })
  
  output$production_UI <- renderUI({
    argonTable(
      cardWrap = T,
      headTitles = c(
        "PROJECT",
        "BUDGET",
        "STATUS",
        "USERS",
        "COMPLETION",
        ""
      ),
      argonTableItems(
        argonTableItem("Production"),
        argonTableItem(dataCell = TRUE, "$2,500 USD"),
        argonTableItem(
          dataCell = TRUE,
          argonBadge(
            text = "Pending",
            status = "danger"
          )
        ),
        argonTableItem(
          argonAvatar(
            size = "sm",
            src = "https://image.flaticon.com/icons/svg/219/219976.svg"
          )
        ),
        argonTableItem(
          dataCell = TRUE,
          argonProgress(value = 60, status = "danger")
        ),
        argonTableItem(
          argonButton(
            name = "Click me!",
            status = "warning",
            icon = "atom",
            size = "sm"
          )
        )
      )
    )
  })
  
  output$test_UI <- renderUI({
    fluidPage(
      titlePanel("Edit and save a table"),
      sidebarLayout(
        sidebarPanel(
          helpText("Shiny app based on an example given in the rhandsontable package.", 
                   "Right-click on the table to delete/insert rows.", 
                   "Double-click on a cell to edit"),
          
          wellPanel(
            h3("Table options"),
            radioButtons("useType", "Use Data Types", c("TRUE", "FALSE"))
          ),
          br(), 
          
          wellPanel(
            h3("Save table"), 
            div(class='row', 
                div(class="col-sm-6", 
                    actionButton("save", "Save")),
                div(class="col-sm-6",
                    radioButtons("fileType", "File type", c("ASCII", "RDS")))
            )
          )
          
        ),
        
        mainPanel(
          wellPanel(
            uiOutput("message", inline=TRUE)
          ),
          
          actionButton("cancel", "Cancel last action"),
          br(), br(), 
          
          rHandsontableOutput("hot"),
          br(),
        )
      )
    )
  })
  
  values <- reactiveValues()
  DF <- dget("/Users/macos/Desktop/ShinyPlaybook/argonDash/inst/examples/updateTabItems/data/test_data.txt")
  # DF <- cars
  outdir <- "/Users/macos/Desktop/ShinyPlaybook/argonDash/inst/examples/updateTabItems/data"
  outfilename <- "test_data"
  ## Handsontable
  observe({
    if (!is.null(input$hot)) {
      values[["previous"]] <- isolate(values[["DF"]])
      DF = hot_to_r(input$hot)
    } else {
      if (is.null(values[["DF"]]))
        DF <- DF
      else
        DF <- values[["DF"]]
    }
    values[["DF"]] <- DF
  })
  
  output$hot <- renderRHandsontable({
    DF <- values[["DF"]]
    if (!is.null(DF))
      rhandsontable(DF, useTypes = as.logical(input$useType), stretchH = "all")
  })
  
  ## Save 
  observeEvent(input$save, {
    fileType <- isolate(input$fileType)
    finalDF <- isolate(values[["DF"]])
    if(fileType == "ASCII"){
      dput(finalDF, file=file.path(outdir, sprintf("%s.txt", outfilename)))
    }
    else{
      saveRDS(finalDF, file=file.path(outdir, sprintf("%s.rds", outfilename)))
    }
  }
  )
  
  ## Cancel last action    
  observeEvent(input$cancel, {
    if(!is.null(isolate(values[["previous"]]))) values[["DF"]] <- isolate(values[["previous"]])
  })
  
  ## Add column
  output$ui_newcolname <- renderUI({
    textInput("newcolumnname", "Name", sprintf("newcol%s", 1+ncol(values[["DF"]])))
  })
  observeEvent(input$addcolumn, {
    DF <- isolate(values[["DF"]])
    values[["previous"]] <- DF
    newcolumn <- eval(parse(text=sprintf('%s(nrow(DF))', isolate(input$newcolumntype))))
    values[["DF"]] <- setNames(cbind(DF, newcolumn, stringsAsFactors=FALSE), c(names(DF), isolate(input$newcolumnname)))
  })
  
  ## Message
  output$message <- renderUI({
    if(input$save==0){
      helpText(sprintf("This table will be saved in folder \"%s\" once you press the Save button.", outdir))
    }else{
      outfile <- ifelse(isolate(input$fileType)=="ASCII", "table.txt", "table.rds")
      fun <- ifelse(isolate(input$fileType)=="ASCII", "dget", "readRDS")
      list(helpText(sprintf("File saved: \"%s\".", file.path(outdir, outfile))),
           helpText(sprintf("Type %s(\"%s\") to get it.", fun, outfile)))
    }
  })
}