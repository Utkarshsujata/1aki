#!/bin/bash
#SBATCH -J em
#SBATCH -p medium
#SBATCH -n 4
#SBATCH --cpus-per-task=4
#SBATCH -t 00:30:00

module load apps/gromacs/2020/cpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

gmx grompp -f em.mdp -c solv_ions.gro -p topol.top -o em.tpr
mpirun -n $SLURM_NTASKS gmx_mpi mdrun -deffnm em

