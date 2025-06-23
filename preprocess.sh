#!/bin/bash
#SBATCH -J preprocess
#SBATCH -p medium
#SBATCH -n 1
#SBATCH --cpus-per-task=4
#SBATCH -t 00:30:00
#SBATCH -o pre.out
#SBATCH -e pre.err

module load apps/gromacs/2020/cpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Run pdb2gmx with force field and water model choice
gmx_mpi pdb2gmx -f 1aki.pdb -o processed.gro -water tip3p <<EOF
15
EOF

# Create box
gmx_mpi editconf -f processed.gro -o newbox.gro -c -d 1.0 -bt cubic

# Solvate system
gmx_mpi solvate -cp newbox.gro -cs spc216.gro -o solvated.gro -p topol.top

