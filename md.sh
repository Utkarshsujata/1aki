#!/bin/bash
#SBATCH -J md
#SBATCH -p medium
#SBATCH -n 4
#SBATCH --cpus-per-task=4
#SBATCH -t 01:00:00

module load apps/gromacs/2020/cpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

gmx grompp -f md.mdp -c npt.gro -p topol.top -o md.tpr
mpirun -n $SLURM_NTASKS gmx_mpi mdrun -deffnm md

