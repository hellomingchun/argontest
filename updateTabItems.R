library(shiny)
library(argonR)
library(argonDash)

source("tables/tables_tab.R")
shiny::shinyApp(
  ui = argonDashPage(
    title = "Playbook", 
    description = "my description", 
    author = "You",
    navbar = argonDashNavbar( title="Welcome",
      argonDropNav(
        argonDropNavItem(
          title="Overview",
          icon = argonIcon(name = "planet", color = "info")
        ),
      ),
      argonDropNav(
        argonDropNavItem(
          title="Policies & Procedures",
          icon = argonIcon(name = "collection", color = "info")
        ),
      ),
      argonDropNav(
        argonDropNavItem(
          title="Organization",
          icon = argonIcon(name = "circle-08", color = "info")
        ),
      ),
      argonDropNav(
        argonDropNavItem(
          title="Production",
          icon = argonIcon(name = "calendar-grid-58", color = "info")
        ),
      ),
      argonDropNav(
        argonDropNavItem(
          title="Projects",
          icon = argonIcon(name = "folder-17", color = "info")
        ),
      ),
    ), 
    sidebar = argonDashSidebar(
      id = "sidebar", 
      side = "left",
      size = "md", 
      skin = "light",
      background = "white",
      argonSidebarHeader(title = "Main Menu"),
      argonSidebarMenu(
        argonSidebarItem(
          tabName = "Americas",
          icon = argonIcon(name = "circle-08", color = "success"),
          "Americas"
        ),
        argonSidebarItem(
          tabName = "Tab2",
          icon = argonIcon(name = "atom", color = "success"),
          "Tab 2"
        )
      )
      
    ), 
    header = argonDashHeader(), 
    body = argonDashBody(
      argonTabItems(
        tables_tab
    ),
    footer = argonDashFooter(copyrights = "Yourself")
  )
),
uiOutput("table_UI")
)