#!/bin/bash
#SBATCH -J nvt
#SBATCH -p medium
#SBATCH -n 4
#SBATCH --cpus-per-task=4
#SBATCH -t 00:30:00

module load apps/gromacs/2020/cpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
mpirun -n $SLURM_NTASKS gmx_mpi mdrun -deffnm nvt

