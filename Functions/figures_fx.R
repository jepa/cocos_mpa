### Per species functions
# This script has the functions used to prepare the data and plot the different
# figures per species presented in the report as supplemental material. The 
# figures (and functions) included are:

# spp_trend_scen_fig, creates line figure of biomass trend per species and sceario

# spp_trend_status_fig, creates line figure of biomass trend per species and grid status

# spp_map_scen_delta, creates map of biomass change per species and scenario

# ggtheme_p, standarized theme for plots

# ggtheme_pm, standarized theme for maps 

# Function to create line figure of biomass trend per species and scenario

trend_scen_fig <- function(data,taxon = NA,data_path){
  
  if(!is.na(taxon)) {
    # Global variables
    taxon_name <- spp_list %>% filter(taxon_key %in% taxon) %>% pull(common_name)
    # Figure name
    fig_name <- paste0(data_path,"results/figures/scenario_trend/",taxon_name %>% str_replace(" ", "_"),"_scen_trend.png")
    # Verbantim
    print(paste("Creating plot for",taxon_name,"(",taxon,")"))
    
    partial_df <- data %>%
      filter(taxon_key %in% taxon)
    
  }else{
    
    # Verbantim
    print("Creating plot for all taxa aggregated (scen_trend.png)")
    
    # figure name
    fig_name <- paste0("results/figures/scen_trend.png")
    
    partial_df <- data
  }

  # Analysis
  
  fig <- partial_df %>% 
    group_by(year,variable,ssp,scen) %>% 
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
  
# Save figure
  ggsave(filename = here(fig_name), 
         plot = fig,
         width = 10,
         height = 5)
}


# Function to create line figure of biomass trend per species

trend_status_fig <- function(data,taxon = NA,data_path){
  
  if(!is.na(taxon)) {
    # Global variables
    taxon_name <- spp_list %>% filter(taxon_key %in% taxon) %>% pull(common_name)
    # Figure name
    fig_name <- paste0(data_path,"results/figures/status_trend/",taxon_name %>% str_replace(" ", "_"),"_status_trend.png")
    # Verbantim
    print(paste("Creating plot for",taxon_name,"(",taxon,")"))
    
    partial_df <- data %>%
      filter(taxon_key %in% taxon)
    
  }else{
    
    # Verbantim
    print("Creating plot for all taxa aggregated")
    
    # figure name
    fig_name <- here(paste0("results/figures/status_trend.png"))
    
    partial_df <- data
  }
  
  # Analysis
  fig <- partial_df %>%
    group_by(year,variable,ssp,scen,status) %>% 
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
  
  
  ggsave(filename = fig_name, 
         plot = fig,
         width = 10,
         height = 7)
}


# Function to create box plot of biomass change per species and scenario

map_scen_delta <- function(data, taxon = NA, data_path){
  
  if(!is.na(taxon)) {
    # Global variables
    taxon_name <- spp_list %>% filter(taxon_key %in% taxon) %>% pull(common_name)
    # Figure name
    fig_name <- paste0(data_path,"results/figures/scenario_delta_map/",taxon_name %>% str_replace(" ", "_"),"_scen_delta.png")
    # Verbantim
    print(paste("Creating delta map for",taxon_name,"(",taxon,")"))
    
    partial_df <- data %>%
      filter(taxon_key %in% taxon)
    
  }else{
    
    # Verbantim
    print("Creating plot for all taxa aggregated (scenario_delta_map.png)")
    
    # figure name
    fig_name <- here(paste0("results/figures/scenario_delta_map.png"))
    
    partial_df <- data
  }
  
  
  # Analysis
  fig <-
    partial_df %>%
    group_by(year,variable,ssp,scen,index,lat,lon) %>% 
    summarise(
      total_value = sum(mean_value,na.rm = T),
      .groups = "drop"
    ) %>% 
    mutate(
      period = ifelse(year %in% seq(1995,2014,1),"history",
                      ifelse(year %in% seq(2030,2049,1),"mid",NA))
    ) %>% 
    filter(!is.na(period)) %>% 
    group_by(variable,scen,ssp,period,index,lat,lon) %>% 
    summarise(
      mean_variable = mean(total_value, na.rm = T),
      .groups = "drop"
    ) %>% 
    group_by(variable,scen,ssp,index,Latitude = lat,Longitude = lon) %>% 
      spread(period,mean_variable) %>% 
    mutate(
      history = replace_na(history,0),
      mid = replace_na(mid,0),
      relative_mean = ifelse(history == 0 & mid > 0,100,
                             ifelse(mid == 0 & history > 0,-100,
                                    ((mid-history)/history)*100)
                             ),  
      variable = ifelse(variable == "Abd","Abundance","Maximum Catch Potential"),
      SSP = ifelse(ssp == 26,"126","585"),
      Scenario = scen,
      relative_mean = ifelse(relative_mean > 100, 100,
                             ifelse(relative_mean < -100, -100,
                                    relative_mean)
                             )
    ) %>% 
    # filter(period == "mid") %>% 
    ggplot() +
    geom_tile(
      aes(
        x = Longitude,
        y = Latitude,
        fill = relative_mean
      )
    ) +
    facet_grid(scen ~ SSP + variable) +
    # scale_fill_gradient2("Relative Change (%)") +
      scale_fill_gradient2(low = "red", mid = "yellow", high = "blue", midpoint = 0) +
    MyFunctions::my_land_map() +
    geom_sf(data = ammb_sf, aes(), fill = "transparent", color = "black", size = 3) +
    coord_sf(
      xlim = c(-93,-83),
      ylim = c(0,10)
    ) +
    ggtheme_m() 
  
  ggsave(filename = fig_name, 
         plot = fig,
         width = 12,
         height = 12)
}


box_delta_status <- function(data,taxon = NA,data_path){
  
  if(!is.na(taxon)) {
    # Global variables
    taxon_name <- spp_list %>% filter(taxon_key %in% taxon) %>% pull(common_name)
    # Figure names
    fig_name_a <- paste0(data_path,"results/figures/scenario_status_delta_box/",taxon_name %>% str_replace(" ", "_"),"_status_scen_delta_box.png")
    fig_name_b <- paste0(data_path,"results/figures/scenario_delta_box/",taxon_name %>% str_replace(" ", "_"),"_scen_delta_box.png")
    # Verbantim
    print(paste("Creating plot for",taxon_name,"(",taxon,")"))
    
    partial_df <- data %>%
      filter(taxon_key %in% taxon)
    
  }else{
    
    # Verbantim
    print("Creating plot for all taxa aggregated")
    
    # figure name
    fig_name_a <- paste0("results/figures/status_scen_delta_box.png")
    fig_name_b <- paste0("results/figures/scenario_delta_box.png")
    
    partial_df <- data
  }
  
  
  # Analysis
  df <- partial_df %>% 
    group_by(year,variable,ssp,scen,status,index) %>% 
    summarise(
      total_value = sum(mean_value,na.rm = T),
      .groups = "drop"
    ) %>% 
    mutate(
      period = ifelse(year %in% seq(1995,2014,1),"history",
                      ifelse(year %in% seq(2030,2049,1),"mid",NA))
    ) %>% 
    filter(!is.na(period)) %>% 
    group_by(variable,scen,ssp,period,status,index) %>% 
    summarise(
      mean_variable = mean(total_value, na.rm = T),
      .groups = "drop"
    ) %>% 
    group_by(variable,scen,ssp,status,index) %>% 
    mutate(
      relative_mean = (mean_variable - mean_variable[period == "history"])/abs(mean_variable[period == "history"])*100,
      variable = ifelse(variable == "Abd","Abundance","Maximum Catch Potential"),
      SSP = ifelse(ssp == 26,"126","585"),
      Scenario = scen
    ) %>% 
    filter(period == "mid")
  
  
  # Snceario + status
  fig_a <-
    df %>% 
    ggplot() +
    geom_boxplot(
      aes(
        x = SSP,
        y = relative_mean,
        fill = Scenario
      )
    ) +
    labs(y = "Relative change (%)") +
    facet_grid(status~variable, scales = "free") +
    scale_fill_manual(values = scenario_pallet) +
    ggtheme_p(
      leg_pos = "right"
    ) 
  
  
  
  ggsave(filename = fig_name_a, 
         plot = fig_a,
         width = 8,
         height = 8)
  
  # Just scenario
  fig_b <-
    df %>% 
    ggplot() +
    geom_boxplot(
      aes(
        x = SSP,
        y = relative_mean,
        fill = Scenario
      )
    ) +
    labs(y = "Relative change (%)") +
    facet_grid(~variable) +
    scale_fill_manual(values = scenario_pallet) +
    ggtheme_p(
      leg_pos = "right"
    ) 
  
  ggsave(filename = fig_name_b, 
         plot = fig_b,
         width = 8,
         height = 8)
  
}


## Weighted box plot

box_delta_status <- function(data,taxon = NA,data_path){
  
  if(!is.na(taxon)) {
    # Global variables
    taxon_name <- spp_list %>% filter(taxon_key %in% taxon) %>% pull(common_name)
    # Figure names
    fig_name_a <- paste0(data_path,"results/figures/scenario_status_delta_box/",taxon_name %>% str_replace(" ", "_"),"_status_scen_delta_box.png")
    fig_name_b <- paste0(data_path,"results/figures/scenario_delta_box/",taxon_name %>% str_replace(" ", "_"),"_scen_delta_box.png")
    # Verbantim
    print(paste("Creating plot for",taxon_name,"(",taxon,")"))
    
    partial_df <- data %>%
      filter(taxon_key %in% taxon)
    
  }else{
    
    # Verbantim
    print("Creating plot for all taxa aggregated")
    
    # figure name
    fig_name_a <- paste0("results/figures/status_scen_delta_box.png")
    fig_name_b <- paste0("results/figures/scenario_delta_box.png")
    
    partial_df <- data
  }
  
  # Estimate ammount of grids
  n_status <- scen_grid %>% 
    group_by(status,scen) %>% 
    tally()
  
  
  partial_df %>% 
    group_by(index,year,ssp,scen,status,variable) %>% 
    summarise(
      total_value = sum(mean_value,na.rm = T),
      .groups = "drop"
    ) %>% 
    mutate(
      period = ifelse(year %in% seq(1995,2014,1),"history",
                      ifelse(year %in% seq(2030,2049,1),"mid",NA))
    ) %>% 
    filter(!is.na(period)) %>% 
    # group_by(variable,scen,ssp,period,status,index) %>% 
    # summarise(
      # mean_variable = mean(total_value, na.rm = T),
      # .groups = "drop"
    # ) %>% 
    left_join(n_status,
              by = c("status","scen")
    ) %>% 
    mutate(value_wgt = total_value/n,
      relative_mean = (value_wgt - value_wgt[period == "history"])/abs(value_wgt[period == "history"])*100,
      variable = ifelse(variable == "Abd","Abundance","Maximum Catch Potential"),
      SSP = ifelse(ssp == 26,"126","585"),
      Scenario = scen,
      relative_mean = ifelse(relative_mean > 100, 100,relative_mean)
    ) %>% 
    ggplot() +
    geom_boxplot(
      aes(
        x = SSP,
        y = relative_mean,
        fill = Scenario
      )
    ) +
    labs(y = "Relative change (%)") +
    facet_grid(status~variable, scales = "free") +
    scale_fill_manual(values = scenario_pallet) +
    ggtheme_p(
      leg_pos = "right"
    ) 
  
  
  # Analysis
  df <- partial_df %>% 
    group_by(year,variable,ssp,scen,status,index) %>% 
    summarise(
      total_value = sum(mean_value,na.rm = T),
      .groups = "drop"
    ) %>% 
    mutate(
      period = ifelse(year %in% seq(1995,2014,1),"history",
                      ifelse(year %in% seq(2030,2049,1),"mid",NA))
    ) %>% 
    filter(!is.na(period)) %>% 
    group_by(variable,scen,ssp,period,status,index) %>% 
    summarise(
      mean_variable = mean(total_value, na.rm = T),
      .groups = "drop"
    ) %>% 
    group_by(variable,scen,ssp,status,index) %>% 
    mutate(
      relative_mean = (mean_variable - mean_variable[period == "history"])/abs(mean_variable[period == "history"])*100,
      variable = ifelse(variable == "Abd","Abundance","Maximum Catch Potential"),
      SSP = ifelse(ssp == 26,"126","585"),
      Scenario = scen
    ) %>% 
    filter(period == "mid")
  
  
  # Snceario + status
  fig <-
    df %>% 
    ggplot() +
    geom_boxplot(
      aes(
        x = SSP,
        y = relative_mean,
        fill = Scenario
      )
    ) +
    labs(y = "Relative change (%)") +
    facet_grid(status~variable, scales = "free") +
    scale_fill_manual(values = scenario_pallet) +
    ggtheme_p(
      leg_pos = "right"
    ) 
  
  
  
  ggsave(filename = fig_name, 
         plot = fig,
         width = 8,
         height = 8)
  
}

# ------------------------------------------------------ #
# Themes
# ------------------------------------------------------ #

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


ggtheme_m <- function(ax_tx_s = 14,
                      axx_tx_ang = 0,
                      axy_tx_ang = 0,
                      ax_tl_s = 15,
                      leg_pos = "bottom",
                      leg_aline = 0,
                      leg_tl_s = 16,
                      leg_tx_s = 14,
                      leg_width = 1,
                      hjust = 0, 
                      facet_tl_s = 14){
  
  
  theme(
    # Background
    panel.background = element_blank(),
    strip.background = element_blank(),
    panel.border   = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = "white"),
    # Axis
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
    # Legend 
    legend.key = element_rect(colour = NA, fill = NA),
    legend.position = leg_pos,
    legend.title.align = leg_aline,
    legend.title = element_text(size = leg_tl_s),
    legend.text = element_text(size = leg_tx_s),
    legend.key.width = unit(2,"line"),
    # For facets
    strip.text = element_text(size = facet_tl_s, colour = "black"),
    # strip.text.x = element_text(size = 11)
  )
  
}


ggtheme_m_sarah <- function(ax_tx_s = 14,
                      axx_tx_ang = 0,
                      axy_tx_ang = 0,
                      ax_tl_s = 15,
                      leg_pos = "right",
                      leg_aline = 0,
                      leg_tl_s = 16,
                      leg_tx_s = 14,
                      leg_width = 1,
                      hjust = 0, 
                      facet_tl_s = 14){
  
  
  theme(
    # Background
    panel.background = element_blank(),
    strip.background = element_blank(),
    panel.border   = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = "white"),
    # Axis
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
    # Legend 
    # For facets
    strip.text = element_text(size = facet_tl_s, colour = "black"),
    # strip.text.x = element_text(size = 11)
  )
  
}

