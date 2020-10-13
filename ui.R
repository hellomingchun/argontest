library(shiny)
library(argonR)
library(argonDash)

source("tables/tables_tab.R")
source("header.R")

  shinyUI = argonDashPage(
    title = "Playbook", 
    description = "my description", 
    author = "You",
    navbar = argonNavbar(id = "main-navbar",
                         argonNavMenu(side="right",
                           argonDropdown(
                             name = "tab1",
                             size = "lg",
                             argonDropdownItem(
                               description = "BlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBla",
                               src = "test.html",
                               icon = argonIcon(name = "spaceship", color = "primary")
                             ))),
                         argonNavMenu(
                           argonDropdown(
                             name = "tab2",
                             size = "lg",
                             argonDropdownItem(
                               description = "BlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBla",
                               src = "test.html",
                               icon = argonIcon(name = "spaceship", color = "primary")
                             ))),
                         argonNavMenu(
                           argonDropdown(
                             name = "tab3",
                             size = "lg",
                             argonDropdownItem(
                               description = "BlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBla",
                               src = "test.html",
                               icon = argonIcon(name = "spaceship", color = "primary")
                             ))),
                         argonNavMenu(
                           argonDropdown(
                             name = "tab4",
                             size = "lg",
                             argonDropdownItem(
                               description = "BlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBla",
                               src = "test.html",
                               icon = argonIcon(name = "spaceship", color = "primary")
                             ))),
                         argonNavMenu(
                           argonDropdown(
                             name = "tab5",
                             size = "lg",
                             argonDropdownItem(
                               description = "BlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBla",
                               src = "test.html",
                               icon = argonIcon(name = "spaceship", color = "primary")
                             )))),

    sidebar = argonDashSidebar(
      id = "sidebar", 
      side = "left",
      size = "md", 
      skin = "light",
      background = "white",
      argonSidebarHeader(title = "Main Menu"),
      argonSidebarMenu(
        argonSidebarItem(
          tabName = "tab1",
          icon = argonIcon(name = "circle-08", color = "success"),
          "Tab1"
        ),
        argonSidebarItem(
          tabName = "tab2",
          icon = argonIcon(name = "atom", color = "success"),
          "Tab2"
        ),
        argonSidebarItem(
          tabName = "test_tab",
          icon = argonIcon(name = "atom", color = "success"),
          "Test"
        )
      )
    ),
    header = argonDashHeader(argonHeader), 
    body = argonDashBody(
        argonTabItems(
          overview_tab,
          production_tab,
          test_tab
      )
    ),
    tags$p <- "test"
)