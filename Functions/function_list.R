# Personalized functions needed for the data analysis

# Load and install packages
load_pkg <- function(pkg_list){
  new.pkg <- pkg_list[!(pkg_list %in% installed.packages()[, 
                                                           "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE, repos = "http://cran.us.r-project.org")
  sapply(pkg_list, require, character.only = TRUE)
}


# Read data and gorup them

load_dbem <- function(scenario, cat = "Catch"){
  
  
  if(Sys.info()[8] == "jepa88"){
  # List of modeled species
  files_to_read <- list.files(MyFunctions::my_path("D","dbem/",scenario),pattern = cat)[25]
  }else{
  files_to_read <- list.files("SARAH PASTE YOUR ROOT PATH HERE",scenario,pattern = cat)
  }
  
  for(s in 1:length(files_to_read)){
  # for(s in 1:5){

    if(Sys.info()[8] == "jepa88"){
            load(paste0("/Users/jepa88/Library/CloudStorage/OneDrive-UBC/Data/cocos_mpa/data/dbem/",scenario,"/",files_to_read[s]))
    }else{

      load(paste0('SARAH PASTE YOUR ROOT PATH HERE',scenario,"/",files_to_read[s]))
      
      }
  
  
  mpa_df <- as.data.frame(data)
  colnames(mpa_df) <- seq(1951,2100,1)
  rm(data)
  
  dbem_df <- mpa_df %>% 
    rowid_to_column("index") %>% 
    filter(index %in% scen_grid$index) %>% 
    gather("year","value",`1951`:`2100`) %>% 
    mutate(taxon_key = str_sub(files_to_read[s],1,6))
  
  
  if(s == 1){
    final_df <- dbem_df
  }else{
    final_df <- bind_rows(final_df,dbem_df)
  }
  
  }
  
  final_df <- final_df %>% 
    mutate(scen = str_sub(scenario,14,15),
           esm = str_sub(scenario,3,6),
           ssp = str_sub(scenario,7,8)
           )
  
  return(final_df)
  
}
