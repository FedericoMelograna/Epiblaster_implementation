#!/bin/bash

cd $1

ls > ../Gametes_list.txt
awk '{print $0,NR}' ../Gametes_list.txt > ../Full_Gametes_list.txt
cp ../Full_Gametes_list.txt .
