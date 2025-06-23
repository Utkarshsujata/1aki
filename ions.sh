#!/bin/bash
#SBATCH -J ions
#SBATCH -p medium
#SBATCH -n 1
#SBATCH --cpus-per-task=4
#SBATCH -t 00:20:00
#SBATCH -o ions.out
#SBATCH -e ions.err

module load apps/gromacs/2020/cpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Step 1: Generate binary input file
gmx_mpi grompp -f ions.mdp -c newbox.gro -p topol.top -o ions.tpr -maxwarn 1

# Step 2: Add ions (choose SOL group, usually group 13)
echo "13" | gmx_mpi genion -s ions.tpr -o solv_ions.gro -p topol.top -pname NA -nname CL -neutral

