# Epiblaster

## Packages 

The needed packages are:

```
library(episcan)
library(dplyr)
```

That can be easily installed from the CRAN. 
The implementation is based on a UNIX system, so it naturally adapts to the server, but need git bash or similar to run on a WINDOWS machine. It has been tested on both a windows machine with wsl.exe ( Ubuntu 20.04 LTS (GNU/Linux 4.4.0-19041-Microsoft x86_64)  )  and the server. 

## Data shape

The data should be in a “ “ space separed file in which the outcome is in a column named “Class” and each other column is a SNP with the column name the SNP name


## Epiblaster script implementation

```
cd $(downloaded_repo)    

./iterator_on_files.sh 
$data_folder
$result_folder
$code_folder
quantitative   # quantitative or case_control
```

For additional information about the methodology and the data format we refer to [Documentation and guidelines](Documentation_Episcan.docx)

<!-- cd /mnt/c/Users/fmelo/Desktop/Backup_Federico/Work/Epistasis/Episcan_epiblaster/Pipeline_iterative/Code_v2_enhanced       

./iterator_on_files.sh /mnt/c/Users/fmelo/Documents/GitHub/epistasis-simulation/Gametes/Data_li_1_EDM-2/ /mnt/c/Users/fmelo/Desktop/Backup_Federico/Work/Epistasis/Episcan_epiblaster/Pipeline_iterative/Gametes_results/ /mnt/c/Users/fmelo/Desktop/Backup_Federico/Work/Epistasis/Episcan_epiblaster/Pipeline_iterative/Code_v2_enhanced/ quantitative   

Or, in a more generalizable way 


cd  Documents/GitHub/epiblaster/
filepath=`pwd`
# mkdir -p Example_result # can also automatically create the repo!
Code/iterator_on_files.sh $filepath/Example_data/ $filepath/Example_result/ $filepath/Code case-control   
 -->


## Practical example
```
cd Epiblaster_implementation/

filepath=`pwd`
mkdir -p Example_result

Code/iterator_on_files.sh $filepath/Example_data/ $filepath/Example_result/ $filepath/Code case_control   
```

