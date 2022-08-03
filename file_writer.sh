#!/bin/bash


for folder in GAMETES_001/*
do
for  subfold in $folder/* do
mv $subfold/GLM_second_step_NOT_Corrected.txt $folder/"${subfold##*/}".txt
rm *
done;
done; 
