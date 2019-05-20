import argparse
from parse import *
from pylab import *
from matplotlib.backends.backend_pdf import PdfPages

def get_seq_data(SEQ):

        if SEQ == "4DLF_13x13_PVS_I01_YUV444_10" :
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I01_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I02_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I02_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I03_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I03_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I04_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I04_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I05_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I05_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I06_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I06_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I07_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I07_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I08_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I08_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I09_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I09_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I10_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I10_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I11_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I11_YUV444_10", 0
        elif SEQ == "4DLF_13x13_PVS_I12_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_PVS_I12_YUV444_10", 0
            
        elif SEQ == "4DLF_13x13_SAI_I01_YUV444_10" :
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I01_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I02_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I02_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I03_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I03_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I04_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I04_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I05_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I05_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I06_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I06_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I07_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I07_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I08_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I08_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I09_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I09_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I10_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I10_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I11_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I11_YUV444_10", 0
        elif SEQ == "4DLF_13x13_SAI_I12_YUV444_10":
                return 625, 434, 13, 13, "4DLF_13x13_SAI_I12_YUV444_10", 0
            
        elif SEQ == "4DLF_13x13_PVS_I01_YUV420_10" :
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I01_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I02_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I02_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I03_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I03_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I04_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I04_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I05_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I05_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I06_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I06_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I07_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I07_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I08_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I08_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I09_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I09_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I10_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I10_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I11_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I11_YUV420_10", 0
        elif SEQ == "4DLF_13x13_PVS_I12_YUV420_10":
                return 626, 434, 13, 13, "4DLF_13x13_PVS_I12_YUV420_10", 0
            
        elif SEQ == "4DLF_13x13_I01_YUV420_8" :
                return 8126, 5642, 13, 13, "4DLF_13x13_I01_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I02_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I02_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I03_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I03_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I04_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I04_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I05_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I05_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I06_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I06_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I07_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I07_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I08_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I08_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I09_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I09_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I10_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I10_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I11_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I11_YUV420_8", 0
        elif SEQ == "4DLF_13x13_I12_YUV420_8":
                return 8126, 5642, 13, 13, "4DLF_13x13_I12_YUV420_8", 0
            
        elif SEQ == "4DLF_13x13_I01_YUV444_10" :
                return 8125, 5642, 13, 13, "4DLF_13x13_I01_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I02_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I02_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I03_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I03_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I04_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I04_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I05_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I05_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I06_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I06_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I07_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I07_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I08_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I08_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I09_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I09_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I10_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I10_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I11_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I11_YUV444_10", 0
        elif SEQ == "4DLF_13x13_I12_YUV444_10":
                return 8125, 5642, 13, 13, "4DLF_13x13_I12_YUV444_10", 0
        
parser = argparse.ArgumentParser(description="Script for RD Curves")
parser.add_argument("SEQ_MY", type=str)
parser.add_argument("main_dir_MY", type=str)
parser.add_argument("SEQ_REF", type=str)
parser.add_argument("main_dir_REF", type=str)
parser.add_argument("psnr_type", type=str)

args = parser.parse_args()

if args.psnr_type == "0": # GLOBAL PSNR
	pdfname = "res_rd_curves_" + args.SEQ_MY + "_" + args.main_dir_MY + "_vs_" + args.SEQ_REF + "_" + args.main_dir_REF + "/RD_Curves.pdf"
elif args.psnr_type == "1": # AVG PSNR Y (views)
	pdfname = "res_rd_curves_PSNR_Y_" + args.SEQ_MY + "_" + args.main_dir_MY + "_vs_" + args.SEQ_REF + "_" + args.main_dir_REF + "/RD_Curves.pdf"
elif args.psnr_type == "2": # AVG PSNR YUV (views)
        pdfname = "res_rd_curves_PSNR_YUV_" + args.SEQ_MY + "_" + args.main_dir_MY + "_vs_" + args.SEQ_REF + "_" + args.main_dir_REF + "/RD_Curves.pdf"

output_pdf = PdfPages(pdfname)

# find input video
h_MY, w_MY, mw_MY, mh_MY, sequence_name_MY, fo_MY = get_seq_data(args.SEQ_MY)
total_pixels_MY = h_MY * w_MY
h_REF, w_REF, mw_REF, mh_REF, sequence_name_REF, fo_REF = get_seq_data(args.SEQ_REF)
total_pixels_REF = h_REF * w_REF
num_QP=9

psnr_my=[0 for i in range(num_QP)]
bit_my=[0 for i in range(num_QP)]
psnr_ref0=[0 for i in range(num_QP)]
bit_ref0=[0 for i in range(num_QP)]

fREF0_bits = open(args.main_dir_REF + "/" + args.SEQ_REF + "/" + args.main_dir_REF + "_bits.txt", "r")
fMY_bits = open(args.main_dir_MY + "/" + args.SEQ_MY + "/" + args.main_dir_MY + "_bits.txt", "r")
if args.psnr_type == "0": # GLOBAL PSNR
	fREF0_psnr = open(args.main_dir_REF + "/" + args.SEQ_REF + "/" + args.main_dir_REF + "_psnr.txt", "r")
	fMY_psnr = open(args.main_dir_MY + "/" + args.SEQ_MY + "/" + args.main_dir_MY + "_psnr.txt", "r")
elif args.psnr_type == "1": # AVG PSNR Y (views)
	fREF0_psnr = open(args.main_dir_REF + "/" + args.SEQ_REF + "/" + args.main_dir_REF + "_avg_psnr_y.txt", "r")
        fMY_psnr = open(args.main_dir_MY + "/" + args.SEQ_MY + "/" + args.main_dir_MY + "_avg_psnr_y.txt", "r")
elif args.psnr_type == "2": # AVG PSNR YUV (views)
	fREF0_psnr = open(args.main_dir_REF + "/" + args.SEQ_REF + "/" + args.main_dir_REF + "_avg_psnr_yuv.txt", "r")
        fMY_psnr = open(args.main_dir_MY + "/" + args.SEQ_MY + "/" + args.main_dir_MY + "_avg_psnr_yuv.txt", "r")

l=0
for line in fREF0_bits:
	#bit_ref0[l] = double(line)/total_pixels_REF
	bit_ref0[l] = double(line)
	l = l + 1
num_QP_REF0 = 0
for line in fREF0_psnr:
        psnr_ref0[num_QP_REF0] = double(line)
        num_QP_REF0 = num_QP_REF0 + 1
l=0
for line in fMY_bits:
        #bit_my[l] = double(line)/total_pixels_MY
	bit_my[l] = double(line)
        l = l + 1
num_QP_MY = 0
for line in fMY_psnr:
        psnr_my[num_QP_MY] = double(line)
        num_QP_MY = num_QP_MY + 1

bit_ref0.sort(reverse=True)
bit_my.sort(reverse=True)
psnr_ref0.sort(reverse=True)
psnr_my.sort(reverse=True)


fREF0_bits.close()
fREF0_psnr.close()
fMY_bits.close()
fMY_psnr.close()

print bit_ref0
print bit_my
print psnr_ref0
print psnr_my

print num_QP_REF0
print num_QP_MY
plot(bit_ref0[0:num_QP_REF0],psnr_ref0[0:num_QP_REF0], "r",marker="o", label=args.main_dir_REF)
plot(bit_my[0:num_QP_MY],psnr_my[0:num_QP_MY], "b",marker="o", label=args.main_dir_MY)
#xscale('log')
grid(True)
legend(loc = 4,prop={'size':6})
xlabel("Rate (bits)")
ylabel("PSNR (dB)")
title_name = sequence_name_REF + " " + str(w_REF) + "x" + str(h_REF) + ", MI:" + str(mw_REF)
title(title_name)
output_pdf.savefig()
clf()

output_pdf.close()


