#!/bin/bash

#read -p "System name (wt_disp): " NAME

NAME=$1 #"cort_wt"
dtval=1

if [ $# -ne 1 ]; then
        echo "Only one argument is needed, run $0 system_name"
        exit 1
fi

#for i in {1..3}
for i in {2..3}
do

        echo 22 22 | gmx trjconv -s md1us1.tpr -f ./md1us${i}.xtc -center -pbc nojump -dt ${dtval} -o md1us${i}_nojump_dt${dtval}.xtc -n for_thermostat.ndx >&/dev/null
        echo 22 22 | gmx trjconv -s md1us1.tpr -f md1us${i}_nojump_dt${dtval}.xtc -fit rot+trans -o md1us${i}_${NAME}_fit_dt${dtval}.xtc -n for_thermostat.ndx >&/dev/null

        rm md1us${i}_nojump_dt${dtval}.xtc

        #grep 'ATOM' md1us${i}_${NAME}_fit_dt${dtval}.pdb | cut -c 30-56 > md1us${i}_${NAME}_fit_dt${dtval}.txt

        #rm md1us${i}_${NAME}_fit_dt${dtval}.pdb

done


#cat md1us1_${NAME}_fit_dt${dtval}.txt md1us2_${NAME}_fit_dt${dtval}.txt md1us3_${NAME}_fit_dt${dtval}.txt > md1us_all_${NAME}_fit_dt${dtval}.txt

#mkdir ca_txt_${NAME}

#mv md*txt ca_txt_${NAME}

