# Personalized functions needed for the data analysis

# Load and install packages
load_pkg <- function(pkg_list){
  new.pkg <- pkg_list[!(pkg_list %in% installed.packages()[, 
                                                           "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE, repos = "http://cran.us.r-project.org")
  sapply(pkg_list, require, character.only = TRUE)
}


# Read data and group them

# scenario = "C6GFDL26F1MPAS2"

load_dbem <- function(scenario, cat = "Catch"){
  
  print(scenario)
  
  if(Sys.info()[8] == "jepa88"){
    # List of modeled species
    files_to_read <- list.files(MyFunctions::my_path("D","dbem/",scenario),pattern = cat)
  }else{
    files_to_read <- list.files("SARAH PASTE YOUR ROOT PATH HERE",scenario,pattern = cat)
  }
  
  
  for(s in 1:length(files_to_read)){
  
    # for(s in 1:5){
    
    if(Sys.info()[8] == "jepa88"){
      
      path_to_read <- paste0("/Users/jepa88/Library/CloudStorage/OneDrive-UBC/Data/cocos_mpa/data/dbem/",scenario,"/",files_to_read[s])      
      
      if(files_to_read[s] != "600107Abd.RData"){
        
        load(path_to_read)
        
      }else{
        
        next()
      }
    }else{
      
      load(paste0('SARAH PASTE YOUR ROOT PATH HERE',scenario,"/",files_to_read[s]))
      
    }
    
    
    mpa_df <- as.data.frame(data)
    
    if(ncol(mpa_df) == 250){
      colnames(mpa_df) <- seq(1851,2100,1)
    }else{
      colnames(mpa_df) <- seq(1951,2100,1)
    }
    rm(data)
    
    dbem_df <- mpa_df %>% 
      rowid_to_column("index") %>% 
      filter(index %in% scen_grid$index) %>% 
      gather("year","value",`1951`:`2100`) %>% 
      mutate(taxon_key = str_sub(files_to_read[s],1,6)) %>% 
      select(index,taxon_key,year,value)
    
    
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


# Function to compare files in two folders

compare_folders <- function(folder1, folder2) {
  files1 <- list.files(folder1)
  files2 <- list.files(folder2)
  
  different_files <- setdiff(files1, files2)
  
  return(different_files)
}


## Aggregate runs

agg_dbem_runs <- function(model_list, cat = "Catch",grid = scen_grid, path = "~/Library/CloudStorage/OneDrive-UBC/Data/dbem/results/"){

df <- bind_rows(
  lapply(model_list,
         load_dbem, cat = cat)
) %>% 
  group_by(index,year,taxon_key,scen,ssp) %>% 
  summarise(
    sd_value = sd(value, na.rm = T),
    mean_value = mean(value, na.rm = T),
    n_species = length(unique(taxon_key))
  ) %>% 
  mutate(variable = "Catch") %>%
  left_join(scen_grid,
            by = c("index","scen")
  ) %>% 
  filter(!is.na(mean_value))

file_name <- paste0(path,"dbem_agg_runs_",cat,".csv")

write_csv(df,"dbem_runs_catch.csv")

}

# Check original distributions

distribution_check <- function(spp, spp_data){
  
  # Get global variables
  spp <- spp_data %>% 
    filter(taxon_key %in% spp) %>% 
    pull(taxon_key)
  
  taxa <- spp_data %>% 
    filter(taxon_key %in% spp) %>% 
    pull(common_name)
  
  
  def_map <- readr:: read_csv(paste0("~/Library/CloudStorage/OneDrive-UBC/Data/dbem/def_distributions/S",spp,".csv"), 
                              col_names = FALSE) %>% 
    bind_cols(MyFunctions::my_data("dbem_coords")) %>% 
    filter(X1 > 0) %>% 
    ggplot() +
    geom_sf(data = rnaturalearth::ne_countries(scale = "small", returnclass = c("sf")), aes()) +
    geom_tile(
      aes(
        x = lon,
        y = lat,
        fill = X1
      )
    ) +
    scale_fill_viridis_b() +
    ggtitle(paste("Def. distribution for",spp,taxa))
  
  rrg_map <- readr:: read_csv(paste0("~/Library/CloudStorage/OneDrive-UBC/Data/dbem/rrg_distributions/S",spp,".csv"), 
                              col_names = FALSE) %>% 
    bind_cols(MyFunctions::my_data("dbem_coords")) %>% 
    filter(X1 > 0) %>% 
    ggplot() +
    geom_sf(data = rnaturalearth::ne_countries(scale = "small", returnclass = c("sf")), aes()) +
    geom_tile(
      aes(
        x = lon,
        y = lat,
        fill = X1
      )
    ) +
    scale_fill_viridis_b() +
    ggtitle(paste("Rrg. distribution for",spp,taxa))
  
  
  maps <- gridExtra::grid.arrange(def_map,rrg_map)
  
  ggsave(filename = paste0("../data/distributions/",spp,".png"),
         plot = maps,
         height = 7,
         width = 7
  )
}