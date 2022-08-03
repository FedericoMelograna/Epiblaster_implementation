#!/bin/bash


for folder in GAMETES_002_v2/*
do
for  subfold in $folder/* 
do
cp $subfold/GLM_second_step_NOT_Corrected.txt $folder/"${subfold##*/}".txt
#rm $subfold/*.txt
#rm $subfold
done;
done; 
