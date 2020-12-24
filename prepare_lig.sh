#! /bin/bash

#this script use the prepare_ligand4.py script to prepare the ligands.

liganddir='ligands'
script=$PWD'/prepare_ligand4.py'
pythonsh='/home/hyh/MGLTools-1.5.6/mgltools_x86_64Linux2_1.5.6/bin/pythonsh'
process_num=8



for ligand in ${liganddir}/*
do
    ext=${ligand##*.}
    echo -e ${pythonsh}" "${script}"\n-l "${ligand}" -o "${liganddir}"/"`basename ${ligand} ${ext}`"pdbqt"
done | xargs -n 2 -d'\n' -P ${process_num} bash -c '$0 $1'

mkdir ${liganddir}"/pdbqt"

for processed_ligand in ${liganddir}/*.pdbqt
do
    echo -e ${processed_ligand}"\n"${liganddir}"/pdbqt"
done | xargs -n 2 -d'\n' -P ${process_num} bash -c 'mv $0 $1'



#the output ligand files will be written to ${liganddir}/pdbqt