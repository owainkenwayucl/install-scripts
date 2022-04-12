#!/bin/bash -l

#$ -l h_rt=24:00:00

#$ -l mem=2G

##$ -wd /home/uccaoke/Scratch
#$ -cwd

#$ -pe mpi 80

#$ -l threads=1

#$ -P Unavailable
##$ -A Test_allocation

#$ -t 1-10000

#$ -N Trogdor
module load compilers/intel/2018/update3
module load mpi/intel/2018/update3/intel

INPUTDIR=$(pwd)
INPUTFILE=${INPUTFILE:-kathleen-singlenode.dat}

mkdir -p Trogdor-$[JOB_ID]-${SGE_TASK_ID}
cd Trogdor-$[JOB_ID]-${SGE_TASK_ID}

ln -s ${INPUTDIR}/${INPUTFILE} ./HPL.dat

export OMP_NUM_THREADS=2

while true; do
  gerun xhpl
done
