# Personalized functions needed for the data analysis


load_pkg <- function(pkg_list){
  new.pkg <- pkg_list[!(pkg_list %in% installed.packages()[, 
                                                           "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE, repos = "http://cran.us.r-project.org")
  sapply(pkg_list, require, character.only = TRUE)
}