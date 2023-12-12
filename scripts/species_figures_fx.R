### Per species functions

# Function to create line figure of biomass trend per species

spp_trend_scen_fig <- function(data,taxon,data_path){
  
  # Global variables
  taxon_name <- spp_list %>% filter(taxon_key %in% taxon) %>% pull(common_name)
  
  # Verbantim
  print(paste("Creating plot for",taxon_name,"(",taxon,")"))
  
  # Analysis
  fig <- data %>%
    filter(taxon_key %in% taxon) %>%
    group_by(taxon_key,year,variable,ssp,scen) %>% 
    summarise(
      total_value = sum(mean_value,na.rm = T),
      .groups = "drop"
    ) %>% 
    mutate(
      period = ifelse(year %in% seq(1995,2014,1),"history",year)
    ) %>% 
    filter(period %in% c("history",seq(2015,2100,1))) %>% 
    group_by(variable,scen,ssp,period) %>% 
    summarise(
      mean_variable = mean(total_value, na.rm = T),
      .groups = "drop"
    ) %>% 
    group_by(variable,scen,ssp) %>% 
    mutate(
      relative_mean = (mean_variable - mean_variable[period == "history"])/abs(mean_variable[period == "history"])*100,
      running_mean = zoo::rollapply(relative_mean, width = 10, FUN = mean, align = "right", fill = NA),
      year = ifelse(period == "history",2014,period) %>% as.numeric(.),
      facet = ifelse(variable == "Abd","Abundance","Maximum Catch Potential"),
      SSP = ifelse(ssp == 26,"126","585"),
      Scenario = scen
    ) %>% 
      # View()
    ggplot() +
    geom_line(
      aes(
        x = year,
        y = running_mean,
        color = Scenario,
        linetype = SSP
      ),
      alpha = 0.5
    ) +
    geom_hline(yintercept = 0, linetype = "dashed", color = "grey") +
    labs(x = "Year",
         y = "Relative Change (%)") +
    facet_grid(~ facet) +
    ggtheme_p(
      leg_pos = "right"
    ) +
    scale_x_continuous(limits = c(2020,2100)) +
      scale_color_manual(values = scenario_pallet)
  
  fig_name <- paste0(data_path,"results/figures/scenario_trend/",taxon_name %>% str_replace(" ", "_"),"_scen_trend.png")
  
  ggsave(filename = fig_name, 
         plot = fig,
         width = 10,
         height = 5)
}


# Function to create line figure of biomass trend per species

spp_trend_status_fig <- function(data,taxon,data_path){
  
  # Global variables
  taxon_name <- spp_list %>% filter(taxon_key %in% taxon) %>% pull(common_name)
  
  # Verbantim
  print(paste("Creating plot for",taxon_name,"(",taxon,")"))
  
  # Analysis
  fig <-
    data %>%
    filter(taxon_key %in% taxon) %>%
    group_by(taxon_key,year,variable,ssp,scen,status) %>% 
    summarise(
      total_value = sum(mean_value,na.rm = T),
      .groups = "drop"
    ) %>% 
    mutate(
      period = ifelse(year %in% seq(1995,2014,1),"history",year)
    ) %>% 
    filter(period %in% c("history",seq(2015,2100,1))) %>% 
    group_by(variable,scen,status,ssp,period) %>% 
    summarise(
      mean_variable = mean(total_value, na.rm = T),
      .groups = "drop"
    ) %>% 
    group_by(variable,scen,status,ssp) %>% 
    mutate(
      relative_mean = (mean_variable - mean_variable[period == "history"])/abs(mean_variable[period == "history"])*100,
      running_mean = zoo::rollapply(relative_mean, width = 10, FUN = mean, align = "right", fill = NA),
      year = ifelse(period == "history",2014,period) %>% as.numeric(.),
      facet = ifelse(variable == "Abd","Abundance","Maximum Catch Potential"),
      SSP = ifelse(ssp == 26,"126","585"),
      Scenario = scen,
      Status = status
    ) %>% 
  ggplot() +
    geom_line(
      aes(
        x = year,
        y = running_mean,
        color = Status,
        linetype = SSP
      ),
      alpha = 0.5
    ) +
    geom_hline(yintercept = 0, linetype = "dashed", color = "grey") +
    labs(x = "Year",
         y = "Relative Change (%)") +
    facet_grid(Scenario ~ facet) +
    ggtheme_p(
      leg_pos = "right"
    ) +
    scale_x_continuous(limits = c(2020,2100)) +
      scale_color_manual(values = status_pallet)
  
  fig_name <- paste0(data_path,"results/figures/status_trend/",taxon_name %>% str_replace(" ", "_"),"_status_trend.png")
  
  ggsave(filename = fig_name, 
         plot = fig,
         width = 10,
         height = 7)
}





# Themes

ggtheme_p <- function(ax_tx_s = 12,
                      axx_tx_ang = 0,
                      axy_tx_ang = 0,
                      ax_tl_s = 14, 
                      leg_pos = "top", 
                      leg_aline = 0.5, 
                      leg_tl_s = 14,
                      leg_tx_s = 12,
                      hjust = 0, 
                      facet_tx_s = 12) {
  theme(
    panel.background = element_blank(),
    strip.background = element_blank(),
    panel.border   = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    axis.line = element_line(color = "black"),
    axis.ticks = element_blank(),
    axis.text.x = element_text(size = ax_tx_s,
                               angle = axx_tx_ang,
                               hjust = hjust,
                               face = "plain",
                               color = "black"),
    axis.text.y = element_text(size = ax_tx_s,
                               color = "black"),
    axis.title = element_text(size = ax_tl_s),
    # For legend
    legend.key = element_rect(colour = NA, fill = NA),
    legend.position = leg_pos,
    legend.title.align = leg_aline,
    legend.title = element_text(size = leg_tl_s),
    legend.text = element_text(size = leg_tx_s),
    # For `facet_wrap`
    strip.text = element_text(size = facet_tx_s, colour = "black")
  )
}


