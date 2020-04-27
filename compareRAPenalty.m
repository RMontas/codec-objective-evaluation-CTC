% HEVC_PVS

% HEVC_OPT --/
% HEVC_OPT_SCL --/
% HEVC_OPT_SCL_ALLLAYERS_RA2 --/
% HEVC_OPT_SCL_ALLLAYERS_RA4 --/
% HEVC_OPT_SCL_ALLLAYERS_RA5 --/
% HEVC_OPT_SCL_ALLLAYERS_RA9 --/
% HEVC_OPT_SCL_4LAYERS_RA1 --/
% HEVC_OPT_SCL_4LAYERS_RA2 --/
% HEVC_OPT_SCL_4LAYERS_RA4 --/
% HEVC_OPT_SCL_4LAYERS_RA9 --/
% HEVC_OPT_SCL_2LAYERS_RA1 --/
% HEVC_OPT_SCL_2LAYERS_RA2 --/
% HEVC_OPT_SCL_2LAYERS_RA4 --/
% HEVC_OPT_SCL_2LAYERS_RA9 --/

% HEVC_OPT_SCL_3LAYERS_RA1 --/
% HEVC_OPT_SCL_3LAYERS_RA2 --/
% HEVC_OPT_SCL_3LAYERS_RA4 --/
% HEVC_OPT_SCL_3LAYERS_RA5 --/
% HEVC_OPT_SCL_3LAYERS_RA9 --/

clear all
clc

max_ref_pics = 4; 
% add both lists 
%(HEVC-PVS-RA with 2 per list -> 4)
%(HEVC-PVS with 4 equal per list -> 8)
num_MIs = 13;
num_Imgs = 12;
num_QPs = 3;
ET = zeros(num_Imgs, num_QPs, num_MIs, num_MIs);
DT = zeros(num_Imgs, num_QPs, num_MIs, num_MIs);
BITS = zeros(num_Imgs, num_QPs, num_MIs, num_MIs);
REF_PICS = zeros(num_Imgs, num_QPs, max_ref_pics, num_MIs, num_MIs); 
REF_PICS_LAYER = zeros(num_Imgs, num_QPs, max_ref_pics, num_MIs, num_MIs); 
RAPenalty = zeros(num_Imgs, num_QPs, num_MIs, num_MIs);

SCL_FLAG = 0;

for img = 1:num_Imgs
    qpidx=1;
    for qp = 17:5:27
        encoder_output = strcat("HEVC_PVS_RA_IP8/4DLF_13x13_PVS_I",sprintf("%02d",img),"_YUV444_10/",num2str(qp),"/out_4DLF_13x13_PVS_I",sprintf("%02d",img),"_YUV444_10_",num2str(qp),".txt")
        %decoder_output = strcat("HEVC_OPT_SCL/4DLF_13x13_PVS_SCL_I",sprintf("%02d",img),"_YUV444_10/",num2str(qp),"/out_DEC_4DLF_13x13_PVS_SCL_I",sprintf("%02d",img),"_YUV444_10_",num2str(qp),".txt")
        [POC, QP, BITS(img,qpidx,:,:), ET(img,qpidx,:,:), REF_PICS(img,qpidx,:,:,:), REF_PICS_LAYER(img,qpidx,:,:,:), RAPenalty(img,qpidx,:,:)] = analyseEncodingProcess(encoder_output, max_ref_pics, SCL_FLAG, num_MIs);
        if qp == 27
        %[DT(img,qpidx,:,:)] = analyseDecodingProcess(decoder_output, max_ref_pics, SCL_FLAG);
        end
        qpidx=qpidx+1;
    end
end

% fixate QP / average I & View
qpidx=1;
for qp = 17:5:27
    aux = squeeze(RAPenalty(:,qpidx,:,:));
    avgFixQP(qpidx) = mean(aux(:));
    stdFixQP(qpidx) = std(aux(:));
    maxFixQP(qpidx) = max(aux(:));
    minFixQP(qpidx) = min(aux(:));
    qpidx=qpidx+1;
    clear aux
end
% figure, plot(avgFixQP), hold on,
% plot(stdFixQP)
% plot(maxFixQP)
% plot(minFixQP)
% xlabel('QP') 
% ylabel('Random Access Penalty') 
% legend({'Avg','Std','Max','Min'},'Location','northwest')
% fixate I / average QP & View
for img = 1:num_Imgs
    aux = squeeze(RAPenalty(img,:,:,:));
    avgFixImg(img) = mean(aux(:));
    stdFixImg(img) = std(aux(:));
    maxFixImg(img) = max(aux(:));
    minFixImg(img) = min(aux(:));
    clear aux
end
% figure, plot(avgFixImg), hold on,
% plot(stdFixImg)
% plot(maxFixImg)
% plot(minFixImg)
% xlabel('Image') 
% ylabel('Random Access Penalty') 
% legend({'Avg','Std','Max','Min'},'Location','northwest')

% QP 27
avgFixQP(3)
stdFixQP(3)
maxFixQP(3)
minFixQP(3)
% QP 22
% avgFixQP(2)
% stdFixQP(2)
% maxFixQP(2)
% minFixQP(2)
% QP 37
% avgFixQP(5)
% stdFixQP(5)
% maxFixQP(5)
% minFixQP(5)

%% STATS FOR BITS/ET/DT PER SCALABILITY LAYER 
num_Layers = 6;
totalBitsPerLayer = zeros(num_Imgs, num_Layers);
totalEncTimePerLayer = zeros(num_Imgs, num_Layers);
totalDecTimePerLayer = zeros(num_Imgs, num_Layers);

if SCL_FLAG == 1 %% SCL
    layerMask =  [  6 6 4 6 3 6 4 6 3 6 4 6 6 ;
                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
                    4 6 2 6 4 6 2 6 4 6 2 6 4 ;
                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
                    3 6 4 6 3 6 4 6 3 6 4 6 3 ;
                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
                    4 6 2 6 4 6 1 6 4 6 2 6 4 ;
                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
                    3 6 4 6 3 6 4 6 3 6 4 6 3 ;
                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
                    4 6 2 6 4 6 2 6 4 6 2 6 4 ;
                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
                    6 6 4 6 3 6 4 6 3 6 4 6 6 ];
    cc_spiral = spiral(num_MIs);
    cc_spiral(:,:) = cc_spiral(:,:) -1;
    cc_spiral_scl = zeros(num_MIs, num_MIs);
    fn = 0;
    for l = 1:num_Layers
        for j = 0:(num_MIs * num_MIs)-1
            [ypos, xpos] = find(cc_spiral == j);
            if layerMask(ypos,xpos) == l
                cc_spiral_scl(ypos,xpos) = fn;
                fn = fn + 1;
            end
        end
    end
    for j = 0:(num_MIs * num_MIs)-1
        for img = 1:num_Imgs
            [ypos, xpos] = find(cc_spiral_scl == j);
            totalBitsPerLayer(img, layerMask(ypos,xpos)) = totalBitsPerLayer(img, layerMask(ypos,xpos)) + BITS(img,3,ypos,xpos); % QP 27 (3)
            totalEncTimePerLayer(img, layerMask(ypos,xpos)) = totalEncTimePerLayer(img, layerMask(ypos,xpos)) + ET(img,3,ypos,xpos); % QP 27 (3)
            totalDecTimePerLayer(img, layerMask(ypos,xpos)) = totalDecTimePerLayer(img, layerMask(ypos,xpos)) + DT(img,3,ypos,xpos); % QP 27 (3)
        end
    end
end

