### Per species functions

# Function to create line figure of biomass trend per species

spp_trend_fig <- function(data,taxon){
  
  fig <- data %>% 
    filter(takon_key %in% taxon) %>% 
    group_by(takon_key,year,scen,status,ssp,variable) %>% 
    summarise(
      total_value = sum(mean_value,na.rm = T)
    ) %>% 
    # filter(scen == "S1") %>% 
    ggplot() +
    geom_line(
      aes(
        x = as.numeric(year),
        y = total_value,
        color = scen
      )
    ) +
    facet_wrap(ssp+variable~status,
               scales = "free")
  
  
  fig_name <- paste0(taxon)
  
  ggsave(filename = "../results/abd_catch_scen_lin.png", 
         plot = fig,
         width = 14,
         height = 10)
}

