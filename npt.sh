#!/bin/bash
#SBATCH -J npt
#SBATCH -p medium
#SBATCH -n 4
#SBATCH --cpus-per-task=4
#SBATCH -t 00:30:00

module load apps/gromacs/2020/cpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr
mpirun -n $SLURM_NTASKS gmx_mpi mdrun -deffnm npt

