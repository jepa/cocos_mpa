  # Settings file for converting DBEM
  # .txt files to .Rdata files
  # Juliano Palacios

library(parallel)
  
  scenarios <- c("C6MPIS26MIS3") 
  category <- c("Abd","Catch")
  
  spplist <- read.table("~/projects/rrg-wailung/jepa/cocos_mpa/data/RunSppListCoco1.txt") %>% 
    filter(V1 %in% c("600006"))

  stryr <- 1951
  endyr <- 2100
  
  out_path <- "/home/jepa/scratch/Results/R/"
  
# Call function
source("/home/jepa/projects/rrg-wailung/jepa/R/Scripts/dbem_txt_to_rdata.R")
  
  print(scenarios)
  

# CAll function for scenaios in Settings file
# for(scen in 1: length(scenarios)){
#   lapply(spplist, dbem_txt_to_rdata, scenario = scenarios[scen], output_path = out_path)
# }

  # McLapply version
  
  ncores = Sys.getenv("SLURM_CPUS_PER_TASK")
  
  for(scen in 1: length(scenarios)){
    mclapply(spplist$V1, dbem_txt_to_rdata, scenario = scenarios[scen], output_path = out_path, mc.cores = ncores)
  }
  

