#/bin/bash

echo "# Temp(K) density_box1(kg/cm3) std density_box2(kg/cm3) std" >avg_density.dat
for idir in `ls -d ../../T_*_K*`; do

    # Files
    echo ${idir}
    f1=`ls ${idir}/*box1*prp`
    f2=`ls ${idir}/*box2*prp`
    temp=`basename ${idir} |awk -F "_"  '{print $2} '`

    # Average 50% of the file. Box 1
    total=$(grep -v '^#' ${f1} | wc -l)
    half=$((total / 2))
    tail -n $half <(grep -v '^#' ${f1}) >half1.dat
    avg1=`awk '{sum+=$2} END {print sum/NR}' half1.dat`
    std1=`awk '{sum+=$2; sumsq+=$2*$2} END {mean=sum/NR; print sqrt(sumsq/NR-mean^2)}' half1.dat`

    # Average 50% of the file. Box 2
    total=$(grep -v '^#' ${f2} | wc -l)
    half=$((total / 2))
    tail -n $half <(grep -v '^#' ${f2}) >half2.dat
    avg2=`awk '{sum+=$2} END {print sum/NR}' half2.dat`
    std2=`awk '{sum+=$2; sumsq+=$2*$2} END {mean=sum/NR; print sqrt(sumsq/NR-mean^2)}' half2.dat`

    # Write files
    echo "$temp $avg1 $std1 $avg2 $std2" >>avg_density.dat
    echo "$temp $avg1 $std1 $avg2 $std2"

    rm half1.dat half2.dat

done
