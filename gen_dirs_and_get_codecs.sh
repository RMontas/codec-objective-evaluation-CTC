#!/bin/bash

# Title: gen_dirs_and_get_codecs.sh

# Inputs: main_dir_name SEQ exe_dir

## Description: 
## generates directory structure and executables to run HEVC tests:
### main_dir:
#### SEQ:
##### QP0:
###### output_files
###### exe
##### QP1:
###### output_files
###### exe
##### QPx:
##### ...


declare -a epfl_4dlf_13x13_sai_yuv444_10=("4DLF_13x13_SAI_I01_YUV444_10" "4DLF_13x13_SAI_I02_YUV444_10" "4DLF_13x13_SAI_I03_YUV444_10" "4DLF_13x13_SAI_I04_YUV444_10" "4DLF_13x13_SAI_I05_YUV444_10" "4DLF_13x13_SAI_I06_YUV444_10" "4DLF_13x13_SAI_I07_YUV444_10" "4DLF_13x13_SAI_I08_YUV444_10" "4DLF_13x13_SAI_I09_YUV444_10" "4DLF_13x13_SAI_I10_YUV444_10" "4DLF_13x13_SAI_I11_YUV444_10" "4DLF_13x13_SAI_I12_YUV444_10")

declare -a fast=("PT150_FAST")
declare -a std=("LAURA" "SEAGULL" "PT0" "PT150" "DS" "DC")
declare -a std_rect=("LAURA_RECT" "SEAGULL_RECT" "PT0_RECT" "PT150_RECT" "DS_RECT" "DC_RECT")

declare -a epfl=("LL_I01" "LL_I02" "LL_I03" "LL_I04" "LL_I05" "LL_I06" "LL_I07" "LL_I08" "LL_I09" "LL_I10" "LL_I11" "LL_I12")
declare -a epfl_yuv444_10=("LL_I01_YUV444_10" "LL_I02_YUV444_10" "LL_I03_YUV444_10" "LL_I04_YUV444_10" "LL_I05_YUV444_10" "LL_I06_YUV444_10" "LL_I07_YUV444_10" "LL_I08_YUV444_10" "LL_I09_YUV444_10" "LL_I10_YUV444_10" "LL_I11_YUV444_10" "LL_I12_YUV444_10")

declare -a epfl_4dlf_yuv420_8=("4DLF_I01_YUV420_8" "4DLF_I02_YUV420_8" "4DLF_I03_YUV420_8" "4DLF_I04_YUV420_8" "4DLF_I05_YUV420_8" "4DLF_I06_YUV420_8" "4DLF_I07_YUV420_8" "4DLF_I08_YUV420_8" "4DLF_I09_YUV420_8" "4DLF_I10_YUV420_8" "4DLF_I11_YUV420_8" "4DLF_I12_YUV420_8")
declare -a epfl_4dlf_13x13_yuv420_8=("4DLF_13x13_I01_YUV420_8" "4DLF_13x13_I02_YUV420_8" "4DLF_13x13_I03_YUV420_8" "4DLF_13x13_I04_YUV420_8" "4DLF_13x13_I05_YUV420_8" "4DLF_13x13_I06_YUV420_8" "4DLF_13x13_I07_YUV420_8" "4DLF_13x13_I08_YUV420_8" "4DLF_13x13_I09_YUV420_8" "4DLF_13x13_I10_YUV420_8" "4DLF_13x13_I11_YUV420_8" "4DLF_13x13_I12_YUV420_8")
declare -a epfl_4dlf_13x13_yuv444_10=("4DLF_13x13_I01_YUV444_10" "4DLF_13x13_I02_YUV444_10" "4DLF_13x13_I03_YUV444_10" "4DLF_13x13_I04_YUV444_10" "4DLF_13x13_I05_YUV444_10" "4DLF_13x13_I06_YUV444_10" "4DLF_13x13_I07_YUV444_10" "4DLF_13x13_I08_YUV444_10" "4DLF_13x13_I09_YUV444_10" "4DLF_13x13_I10_YUV444_10" "4DLF_13x13_I11_YUV444_10" "4DLF_13x13_I12_YUV444_10")

declare -a epfl_4dlf_pvs_yuv420_8=("4DLF_PVS_I01_YUV420_8" "4DLF_PVS_I02_YUV420_8" "4DLF_PVS_I03_YUV420_8" "4DLF_PVS_I04_YUV420_8" "4DLF_PVS_I05_YUV420_8" "4DLF_PVS_I06_YUV420_8" "4DLF_PVS_I07_YUV420_8" "4DLF_PVS_I08_YUV420_8" "4DLF_PVS_I09_YUV420_8" "4DLF_PVS_I10_YUV420_8" "4DLF_PVS_I11_YUV420_8" "4DLF_PVS_I12_YUV420_8")
declare -a epfl_4dlf_13x13_pvs_yuv420_8=("4DLF_13x13_PVS_I01_YUV420_8" "4DLF_13x13_PVS_I02_YUV420_8" "4DLF_13x13_PVS_I03_YUV420_8" "4DLF_13x13_PVS_I04_YUV420_8" "4DLF_13x13_PVS_I05_YUV420_8" "4DLF_13x13_PVS_I06_YUV420_8" "4DLF_13x13_PVS_I07_YUV420_8" "4DLF_13x13_PVS_I08_YUV420_8" "4DLF_13x13_PVS_I09_YUV420_8" "4DLF_13x13_PVS_I10_YUV420_8" "4DLF_13x13_PVS_I11_YUV420_8" "4DLF_13x13_PVS_I12_YUV420_8")
declare -a epfl_4dlf_13x13_pvs_yuv444_10=("4DLF_13x13_PVS_I01_YUV444_10" "4DLF_13x13_PVS_I02_YUV444_10" "4DLF_13x13_PVS_I03_YUV444_10" "4DLF_13x13_PVS_I04_YUV444_10" "4DLF_13x13_PVS_I05_YUV444_10" "4DLF_13x13_PVS_I06_YUV444_10" "4DLF_13x13_PVS_I07_YUV444_10" "4DLF_13x13_PVS_I08_YUV444_10" "4DLF_13x13_PVS_I09_YUV444_10" "4DLF_13x13_PVS_I10_YUV444_10" "4DLF_13x13_PVS_I11_YUV444_10" "4DLF_13x13_PVS_I12_YUV444_10")

declare -a epfl_4dlf_13x13_pvs_scl_yuv444_10=("4DLF_13x13_PVS_SCL_I01_YUV444_10" "4DLF_13x13_PVS_SCL_I02_YUV444_10" "4DLF_13x13_PVS_SCL_I03_YUV444_10" "4DLF_13x13_PVS_SCL_I04_YUV444_10" "4DLF_13x13_PVS_SCL_I05_YUV444_10" "4DLF_13x13_PVS_SCL_I06_YUV444_10" "4DLF_13x13_PVS_SCL_I07_YUV444_10" "4DLF_13x13_PVS_SCL_I08_YUV444_10" "4DLF_13x13_PVS_SCL_I09_YUV444_10" "4DLF_13x13_PVS_SCL_I10_YUV444_10" "4DLF_13x13_PVS_SCL_I11_YUV444_10" "4DLF_13x13_PVS_SCL_I12_YUV444_10")
declare -a epfl_4dlf_13x13_pvs_scl_yuv420_8=("4DLF_13x13_PVS_SCL_I01_YUV420_8" "4DLF_13x13_PVS_SCL_I02_YUV420_8" "4DLF_13x13_PVS_SCL_I03_YUV420_8" "4DLF_13x13_PVS_SCL_I04_YUV420_8" "4DLF_13x13_PVS_SCL_I05_YUV420_8" "4DLF_13x13_PVS_SCL_I06_YUV420_8" "4DLF_13x13_PVS_SCL_I07_YUV420_8" "4DLF_13x13_PVS_SCL_I08_YUV420_8" "4DLF_13x13_PVS_SCL_I09_YUV420_8" "4DLF_13x13_PVS_SCL_I10_YUV420_8" "4DLF_13x13_PVS_SCL_I11_YUV420_8" "4DLF_13x13_PVS_SCL_I12_YUV420_8")


declare -a hdca_4dlf_pvs_yuv444_10=("4DLF_PVS0_SET2_YUV444_10" "4DLF_PVS1_SET2_YUV444_10" "4DLF_PVS2_SET2_YUV444_10" "4DLF_PVS_GREEK_YUV444_10" "4DLF_PVS_SIDEBOARD_YUV444_10" "4DLF_PVS_TAROT_YUV444_10")
declare -a hdca_4dlf_pvs_scl_yuv444_10=("4DLF_PVS0_SCL_SET2_YUV444_10" "4DLF_PVS1_SCL_SET2_YUV444_10" "4DLF_PVS2_SCL_SET2_YUV444_10" "4DLF_PVS_SCL_GREEK_YUV444_10" "4DLF_PVS_SCL_SIDEBOARD_YUV444_10" "4DLF_PVS_SCL_TAROT_YUV444_10")

mkdir $1 

if [ $2 == "HDCA" ]
then

for i in "${hdca_4dlf_pvs_yuv444_10[@]}"
do
mkdir $1/$i
for qp in 17 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
	cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "HDCA_SCL" ]
then

for i in "${hdca_4dlf_pvs_scl_yuv444_10[@]}"
do
mkdir $1/$i
for qp in 17 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
	cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "STD" ] 
then

for i in "${std[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
	mkdir $1/$i/$qp
	cp $3/TAppEncoderStatic $1/$i/$qp
	cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi
 
if [ $2 == "STD_RECT" ]
then

for i in "${std_rect[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
	cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL" ]
then

for i in "${epfl[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
	cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_YUV444_10" ]
then

for i in "${epfl_yuv444_10[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_YUV420_8" ]
then    

for i in "${epfl_4dlf_yuv420_8[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_YUV444_10" ]
then

for i in "${epfl_4dlf_yuv444_10[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_PVS_YUV420_8" ]
then

for i in "${epfl_4dlf_pvs_yuv420_8[@]}"
do
mkdir $1/$i
for qp in 17 22 27 32 37 42
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_13x13_YUV420_8" ]
then

for i in "${epfl_4dlf_13x13_yuv420_8[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_13x13_YUV444_10" ]
then

for i in "${epfl_4dlf_13x13_yuv444_10[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_13x13_PVS_YUV420_8" ]
then

for i in "${epfl_4dlf_13x13_pvs_yuv420_8[@]}"
do
mkdir $1/$i
for qp in 17 22 27 32 37 42
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_13x13_PVS_YUV444_10" ]
then

for i in "${epfl_4dlf_13x13_pvs_yuv444_10[@]}"
do
mkdir $1/$i
for qp in 17 22 27 32 37 42
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_13x13_PVS_SCL_YUV444_10" ]
then

for i in "${epfl_4dlf_13x13_pvs_scl_yuv444_10[@]}"
do
mkdir $1/$i
for qp in 17 22 27 32 37 42
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi

if [ $2 == "EPFL_4DLF_13x13_PVS_SCL_YUV420_8" ]
then

for i in "${epfl_4dlf_13x13_pvs_scl_yuv420_8[@]}"
do
mkdir $1/$i
for qp in 17 22 27 32 37 42
do
        mkdir $1/$i/$qp
        cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi


if [ $2 == "FAST" ]
then

for i in "${fast[@]}"
do
mkdir $1/$i
for qp in 22 27 32 37 42 47
do
        mkdir $1/$i/$qp
	cp $3/TAppEncoderStatic $1/$i/$qp
        cp $3/TAppDecoderStatic $1/$i/$qp
done
done
fi
