
#!/bin/bash

# Title: gather_outputs_CTC.sh

# Inputs: REF main_dir 

## Description:
## gathers in two files all the bit and psnr values necessary to calculate BJM and generate RD curves


dir=$(pwd)
cd /home/rmonteiro/PhD/Sequences/JPEG_Pleno_HDCA

for qp in 12 17 22 27 32 37 42 47 52
do 
# PVSSPIRAL YUV44410
if [ $1 == "4DLF_PVS0_SET2_YUV444_10" ] ; then
        W=1920
        H=1080
        representation_type=3
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno_HDCA/FraunhoferIIS/Set2/PPM/"
        MIR=11
        if [ -d ${dir}/$2/$1/$qp ]; then
                BITS0=$(ls -l ${dir}/$2/4DLF_PVS0_SET2_YUV444_10/$qp/str.bin | awk '{sum+=$5} END {print sum*8}')
                BITS1=$(ls -l ${dir}/$2/4DLF_PVS1_SET2_YUV444_10/$qp/str.bin | awk '{sum+=$5} END {print sum*8}')
                BITS2=$(ls -l ${dir}/$2/4DLF_PVS2_SET2_YUV444_10/$qp/str.bin | awk '{sum+=$5} END {print sum*8}')
                BITS=$(echo $BITS0 $BITS1 $BITS2 | awk '{sum=$1+$2+$3} END {print sum/(1920*1080*11*33)}')
                echo $BITS >> ${dir}/$2/$1/${2}_bits.txt 
                echo $BITS
        fi
fi

if [ $1 == "4DLF_PVS_GREEK_YUV444_10" ] ; then
        W=512
        H=512
        representation_type=3
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno_HDCA/HCI/greek/PPM/"
        MIR=9
        if [ -d ${dir}/$2/$1/$qp ]; then
                BITS=$(ls -l ${dir}/$2/$1/$qp/str.bin | awk '{sum+=$5} END {print sum*8/21233664}') 
                echo $BITS >> ${dir}/$2/$1/${2}_bits.txt 
                echo $BITS
        fi
fi
if [ $1 == "4DLF_PVS_SIDEBOARD_YUV444_10" ] ; then
        W=512
        H=512
        representation_type=3
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno_HDCA/HCI/sideboard/PPM/"
        MIR=9
        if [ -d ${dir}/$2/$1/$qp ]; then
                BITS=$(ls -l ${dir}/$2/$1/$qp/str.bin | awk '{sum+=$5} END {print sum*8/21233664}') 
                echo $BITS >> ${dir}/$2/$1/${2}_bits.txt 
                echo $BITS
        fi
fi

if [ $1 == "4DLF_PVS_TAROT_YUV444_10" ] ; then
        W=1024
        H=1024
        representation_type=3
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno_HDCA/NewStanfordLF/tarot/PPM/"
        MIR=17
        if [ -d ${dir}/$2/$1/$qp ]; then
                BITS=$(ls -l ${dir}/$2/$1/$qp/str.bin | awk '{sum+=$5} END {print sum*8/(1024*1024*17*17)}') 
                echo $BITS >> ${dir}/$2/$1/${2}_bits.txt 
                echo $BITS
        fi
fi

# PVSSPIRAL YUV44410
if [ $1 == "4DLF_PVS0_SCL_SET2_YUV444_10" ] ; then
        W=1920
        H=1080
        representation_type=4
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno_HDCA/FraunhoferIIS/Set2/PPM/"
        MIR=11
        if [ -d ${dir}/$2/$1/$qp ]; then
                BITS0=$(ls -l ${dir}/$2/4DLF_PVS0_SCL_SET2_YUV444_10/$qp/str.bin | awk '{sum+=$5} END {print sum*8}')
                BITS1=$(ls -l ${dir}/$2/4DLF_PVS1_SCL_SET2_YUV444_10/$qp/str.bin | awk '{sum+=$5} END {print sum*8}')
                BITS2=$(ls -l ${dir}/$2/4DLF_PVS2_SCL_SET2_YUV444_10/$qp/str.bin | awk '{sum+=$5} END {print sum*8}')
                BITS=$(echo $BITS0 $BITS1 $BITS2 | awk '{sum=$1+$2+$3} END {print sum/(1920*1080*11*33)}')
                echo $BITS >> ${dir}/$2/$1/${2}_bits.txt 
                echo $BITS
        fi
fi

if [ $1 == "4DLF_PVS_SCL_GREEK_YUV444_10" ] ; then
        W=512
        H=512
        representation_type=4
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno_HDCA/HCI/greek/PPM/"
        MIR=9
        if [ -d ${dir}/$2/$1/$qp ]; then
                BITS=$(ls -l ${dir}/$2/$1/$qp/str.bin | awk '{sum+=$5} END {print sum*8/21233664}') 
                echo $BITS >> ${dir}/$2/$1/${2}_bits.txt 
                echo $BITS
        fi
fi
if [ $1 == "4DLF_PVS_SCL_SIDEBOARD_YUV444_10" ] ; then
        W=512
        H=512
        representation_type=4
        REF="/home/rmonteiro/PhD/Sequences/JPEG_Pleno_HDCA/HCI/sideboard/PPM/"
        MIR=9
        if [ -d ${dir}/$2/$1/$qp ]; then
                BITS=$(ls -l ${dir}/$2/$1/$qp/str.bin | awk '{sum+=$5} END {print sum*8/21233664}') 
                echo $BITS >> ${dir}/$2/$1/${2}_bits.txt 
                echo $BITS
        fi
fi


if [ $# == 3 ] ; then


if [ -d ${dir}/$2/$1/$qp ]; then
if [ $3 == 1 ] ; then
        echo "not implemented!!!"
	#echo "calcMetricsYUV4208('${REF}','${dir}/$2/$1/$qp/rec.yuv',${representation_type},$H,$W,${MIR},'${dir}/$2/$1/${2}_avg_psnr_views'); quit;"
        #/usr/local/MATLAB/R2017a/bin/matlab -nodesktop -nosplash -r "calcMetricsYUV4208('${REF}','${dir}/$2/$1/$qp/rec.yuv',${representation_type},$H,$W,${MIR},'${dir}/$2/$1/${2}'); quit;"
fi
if [ $3 == 2 ] ; then
	echo "calcMetricsYUV44410('${REF}','${dir}/$2/$1/$qp/rec.yuv',${representation_type},$H,$W,${MIR},'${dir}/$2/$1/${2}_avg_psnr_views'); quit;"
        /usr/local/MATLAB/R2017a/bin/matlab -nodesktop -nosplash -r "calcMetricsYUV44410('${REF}','${dir}/$2/$1/$qp/rec.yuv',${representation_type},$H,$W,${MIR},'${dir}/$2/$1/${2}'); quit;"
fi

fi
fi
done

