### Per species functions

# Function to create line figure of biomass trend per species

spp_trend_fig <- function(data,taxon_key){
  
  
  data %>% 
    group_by(taxon_key,year,variable,ssp,scen) %>% 
    summarise(
      total_value = sum(mean_value,na.rm = T),
      .groups = "drop"
    ) %>% 
    mutate(
      period = ifelse(year %in% seq(1995,2014,1),"history",year)
    ) %>% 
    filter(!is.na(period)) %>% 
    group_by(variable,scen,ssp,period) %>% 
    summarise(
      mean_variable = mean(total_value, na.rm = T),
      .groups = "drop"
    ) %>% 
    group_by(index,variable,scen,ssp,lat,lon) %>% 
    mutate(ratio = (lag(mean_variable)-mean_variable)/mean_variable) %>%
    # mutate(ratio = mean_variable/lag(mean_variable)) %>% 
    filter(!is.na(ratio)) %>% 
    ggplot() +
    geom_tile(
      # metR::geom_contour_fill(
      aes(
        x = lon,
        y = lat,
        # z = ratio,
        fill = ratio
      )#,
      # bins = 5
    ) +
    facet_grid(ssp+variable ~ scen) +
    scale_fill_gradient2() +
    MyFunctions::my_land_map() +
    geom_sf(data = ammb_sf, aes(), fill = "transparent") +
    coord_sf(
      xlim = c(-93,-83),
      ylim = c(0,10)
    )
  
  
  fig_name <- paste0(taxon)
  
  ggsave(filename = "../results/abd_catch_scen_lin.png", 
         plot = fig,
         width = 14,
         height = 10)
}

