overview_tab <- argonTabItem(
  tabName = "tab1",
  uiOutput("overview_UI")
)

production_tab <- argonTabItem(
  tabName = "tab2",
  uiOutput("production_UI")
)

test_tab <- argonTabItem(
  tabName = "test_tab",
  uiOutput("test_UI")
)