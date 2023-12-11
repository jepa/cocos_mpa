#!/bin/bash                                                                     
#SBATCH --job-name=ADRDisp                                                      
#SBATCH --account=rrg-wailung                                                   
#SBATCH -N 1    #Nodes                                                          
#SBATCH -N 1    #CPU count                                                      
#SBATCH --mem-per-cpu=700M                                                      
#SBATCH -t 00-15:00:00                                                          
#SBATCH --mail-user=j.palacios@oceans.ubc.ca                                    
#SBATCH --mail-type=ALL                                                         
#SBATCH --array=1-1                                                             
#SBATCH --output=Array-%A-%a.out                                                
#SBATCH --error=Array-%A-%a.err                                                 

cd $SLURM_SUBMIT_DIR
echo "Current working directory is `pwd`"
echo "Starting run at:$(date)"
echo “Starting task: $SLURM_ARRAY_TASK_ID”
sleep ${SLURM_ARRAY_TASK_ID}5s

export OMP_NUM_THREADS=1
/home/jepa/projects/rrg-wailung/jepa/Fortran/DBEM/DBEM_v2
echo "Program $SLURM_JOB_NAME finished with exit code $? at: $(date)"