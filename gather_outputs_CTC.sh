
#!/bin/bash

# Title: gather_outputs_CTC.sh

# Inputs: REF main_dir 

## Description:
## gathers in two files all the bit and psnr values necessary to calculate BJM and generate RD curves

# PVSSPIRAL YUV44410
W=625
H=434
MIR=13
representation_type=3
if [ $1 == "4DLF_13x13_PVS_I01_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I01/"
fi
if [ $1 == "4DLF_13x13_PVS_I02_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I02/"
fi
if [ $1 == "4DLF_13x13_PVS_I03_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I03/"
fi
if [ $1 == "4DLF_13x13_PVS_I04_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I04/"
fi
if [ $1 == "4DLF_13x13_PVS_I05_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I05/"
fi
if [ $1 == "4DLF_13x13_PVS_I06_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I06/"
fi
if [ $1 == "4DLF_13x13_PVS_I07_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I07/"
fi
if [ $1 == "4DLF_13x13_PVS_I08_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I08/"
fi
if [ $1 == "4DLF_13x13_PVS_I09_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I09/"
fi
if [ $1 == "4DLF_13x13_PVS_I10_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I10/"
fi
if [ $1 == "4DLF_13x13_PVS_I11_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I11/"
fi
if [ $1 == "4DLF_13x13_PVS_I12_YUV444_10" ] ; then
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno/SAI/RGB44410/I12/"
fi

dir=$(pwd)
cd /home/rmonteiro/PhD/Sequences/JPEG_Pleno
if [ $# == 3 ] ; then

for qp in 12 17 22 27 32 37 42
do
if [ -d ${dir}/$2/$1/$qp ]; then
if [ $3 == 1 ] ; then
	echo "calcMetricsYUV4208('${REF}','${dir}/$2/$1/$qp/rec.yuv',${representation_type},$H,$W,${MIR},'${dir}/$2/$1/${2}_avg_psnr_views.txt'); quit;"
        /usr/local/MATLAB/R2017a/bin/matlab -nodesktop -nosplash -r "calcMetricsYUV4208('${REF}','${dir}/$2/$1/$qp/rec.yuv',${representation_type},$H,$W,${MIR},'${dir}/$2/$1/${2}'); quit;"
fi
if [ $3 == 2 ] ; then
	echo "calcMetricsYUV44410('${REF}','${dir}/$2/$1/$qp/rec.yuv',${representation_type},$H,$W,${MIR},'${dir}/$2/$1/${2}_avg_psnr_views.txt'); quit;"
        /usr/local/MATLAB/R2017a/bin/matlab -nodesktop -nosplash -r "calcMetricsYUV44410('${REF}','${dir}/$2/$1/$qp/rec.yuv',${representation_type},$H,$W,${MIR},'${dir}/$2/$1/${2}'); quit;"
fi

BITS=$(ls -l ${dir}/$2/$1/$qp/str.bin | awk '{sum+=$5} END {print sum*8/45841250}') 
echo $BITS >> ${dir}/$2/$1/${2}_bits.txt 
echo $BITS

fi
done
fi
