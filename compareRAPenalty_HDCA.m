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
encoderName = "HEVC_PVS_RA_IP8";

max_ref_pics = 4; 
% add both lists 
%(HEVC-PVS-RA with 2 per list -> 4)
%(HEVC-PVS with 4 equal per list -> 8)
num_MIs = 9;
num_Imgs = 2; % 2 9x9 Images
ET = zeros(num_Imgs, num_MIs, num_MIs);
DT = zeros(num_Imgs, num_MIs, num_MIs);
BITS = zeros(num_Imgs, num_MIs, num_MIs);
REF_PICS = zeros(num_Imgs, max_ref_pics, num_MIs, num_MIs); 
REF_PICS_LAYER = zeros(num_Imgs, max_ref_pics, num_MIs, num_MIs); 
RAPenalty = zeros(num_Imgs, num_MIs, num_MIs);

SCL_FLAG = 0;
qp = 27;
img = 1;
encoder_output = strcat(encoderName,"/4DLF_PVS_GREEK_YUV444_10/",num2str(qp),"/out_4DLF_PVS_GREEK_YUV444_10_",num2str(qp),".txt")
%decoder_output = strcat(encoderName,"/4DLF_PVS_SCL_GREEK_YUV444_10/",num2str(qp),"/out_DEC_4DLF_PVS_SCL_GREEK_YUV444_10_",num2str(qp),".txt")
[POC, QP, BITS(img,:,:), ET(img,:,:), REF_PICS(img,:,:,:), REF_PICS_LAYER(img,:,:,:), RAPenalty(img,:,:)] = analyseEncodingProcess(encoder_output, max_ref_pics, SCL_FLAG, num_MIs);
%[DT(img,:,:)] = analyseDecodingProcess(decoder_output, max_ref_pics, SCL_FLAG, num_MIs);
img = 2;
encoder_output = strcat(encoderName,"/4DLF_PVS_SIDEBOARD_YUV444_10/",num2str(qp),"/out_4DLF_PVS_SIDEBOARD_YUV444_10_",num2str(qp),".txt")
%decoder_output = strcat(encoderName,"/4DLF_PVS_SCL_SIDEBOARD_YUV444_10/",num2str(qp),"/out_DEC_4DLF_PVS_SCL_SIDEBOARD_YUV444_10_",num2str(qp),".txt")
[POC, QP, BITS(img,:,:), ET(img,:,:), REF_PICS(img,:,:,:), REF_PICS_LAYER(img,:,:,:), RAPenalty(img,:,:)] = analyseEncodingProcess(encoder_output, max_ref_pics, SCL_FLAG, num_MIs);
%[DT(img,:,:)] = analyseDecodingProcess(decoder_output, max_ref_pics, SCL_FLAG, num_MIs);

num_Imgs = 1; % 1 11x33 images
num_MIs = 11;
ET_SET2 = zeros(num_Imgs, num_MIs, num_MIs*3);
DT_SET2 = zeros(num_Imgs, num_MIs, num_MIs*3);
BITS_SET2 = zeros(num_Imgs, num_MIs, num_MIs*3);
REF_PICS_SET2 = zeros(num_Imgs, max_ref_pics, num_MIs, num_MIs*3); 
REF_PICS_LAYER_SET2 = zeros(num_Imgs, max_ref_pics, num_MIs, num_MIs*3); 
RAPenalty_SET2 = zeros(num_Imgs, num_MIs, num_MIs*3);
img = 1;
encoder_output = strcat(encoderName,"/4DLF_PVS0_SET2_YUV444_10/",num2str(qp),"/out_4DLF_PVS0_SET2_YUV444_10_",num2str(qp),".txt")
%decoder_output = strcat(encoderName,"/4DLF_PVS0_SCL_SET2_YUV444_10/",num2str(qp),"/out_DEC_4DLF_PVS0_SCL_SET2_YUV444_10_",num2str(qp),".txt")
[POC_SET2, QP_SET2, BITS_SET2(img,:,:), ET_SET2(img,:,:), REF_PICS_SET2(img,:,:,:), REF_PICS_LAYER_SET2(img,:,:,:), RAPenalty_SET2(img,:,:)] = analyseEncodingProcess(encoder_output, max_ref_pics, SCL_FLAG, num_MIs);
%[DT_SET2(img,:,:)] = analyseDecodingProcess(decoder_output, max_ref_pics, SCL_FLAG, num_MIs);

% fixate QP / average I & View
%aux = squeeze(RAPenalty(:,qpidx,:,:));
rasterizedRAPenaltyArrays = zeros(1,2*9*9 + 3*11*11);
rasterizedRAPenaltyArrays(1:2*9*9) = reshape(RAPenalty,[1 2*9*9]);
rasterizedRAPenaltyArrays(2*9*9+1:end) = reshape(RAPenalty_SET2,[1 11*33]);
avgFixQP = mean(rasterizedRAPenaltyArrays(:));
stdFixQP = std(rasterizedRAPenaltyArrays(:));
maxFixQP = max(rasterizedRAPenaltyArrays(:));
minFixQP = min(rasterizedRAPenaltyArrays(:));

% figure, plot(avgFixImg), hold on,
% plot(stdFixImg)
% plot(maxFixImg)
% plot(minFixImg)
% xlabel('Image') 
% ylabel('Random Access Penalty') 
% legend({'Avg','Std','Max','Min'},'Location','northwest')

% QP 27
fixQPResults = [avgFixQP stdFixQP maxFixQP minFixQP; 0 0 0 0]

%% STATS FOR BITS/ET/DT PER SCALABILITY LAYER 
num_Imgs = 2;
num_MIs = 9;
num_Layers = 6;
totalBitsPerLayer = zeros(num_Imgs, num_Layers);
totalEncTimePerLayer = zeros(num_Imgs, num_Layers);
totalDecTimePerLayer = zeros(num_Imgs, num_Layers);

if SCL_FLAG == 1 %% SCL
    maskMax = floor(num_MIs / 2);
    layerMaskQ2 =  [ 6 6 4 6 6 6 4 6 6 ;
        6 5 6 5 6 5 6 5 6 ;
        4 6 3 6 4 6 3 6 4 ;
        6 5 6 5 6 5 6 5 6 ;
        6 6 4 6 2 6 4 6 2 ;
        6 5 6 5 6 5 6 5 6 ;
        4 6 3 6 4 6 3 6 4 ;
        6 5 6 5 6 5 6 5 6 ;
        6 6 4 6 2 6 4 6 1 ];
    layerMask = layerMaskQ2;
    layerMask(9:17,1:9) = flip(layerMaskQ2);
    layerMask(1:9,9:17) = flip(layerMaskQ2,2);
    layerMask(9:17,9:17) = flip(flip(layerMaskQ2,2));
    layerMask = layerMask(9-maskMax:9+maskMax, 9-maskMax:9+maskMax);
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
            totalBitsPerLayer(img, layerMask(ypos,xpos)) = totalBitsPerLayer(img, layerMask(ypos,xpos)) + BITS(img,ypos,xpos); % QP 27 
            totalEncTimePerLayer(img, layerMask(ypos,xpos)) = totalEncTimePerLayer(img, layerMask(ypos,xpos)) + ET(img,ypos,xpos); % QP 27 
            totalDecTimePerLayer(img, layerMask(ypos,xpos)) = totalDecTimePerLayer(img, layerMask(ypos,xpos)) + DT(img,ypos,xpos); % QP 27 
        end
    end
end

num_Imgs = 1;
num_MIs = 11;
num_Layers = 6;
totalBitsPerLayerSET2 = zeros(num_Imgs, num_Layers);
totalEncTimePerLayerSET2 = zeros(num_Imgs, num_Layers);
totalDecTimePerLayerSET2 = zeros(num_Imgs, num_Layers);

if SCL_FLAG == 1 %% SCL
    maskMax = floor(num_MIs / 2);
    layerMaskQ2 =  [ 6 6 4 6 6 6 4 6 6 ;
        6 5 6 5 6 5 6 5 6 ;
        4 6 3 6 4 6 3 6 4 ;
        6 5 6 5 6 5 6 5 6 ;
        6 6 4 6 2 6 4 6 2 ;
        6 5 6 5 6 5 6 5 6 ;
        4 6 3 6 4 6 3 6 4 ;
        6 5 6 5 6 5 6 5 6 ;
        6 6 4 6 2 6 4 6 1 ];
    layerMask = layerMaskQ2;
    layerMask(9:17,1:9) = flip(layerMaskQ2);
    layerMask(1:9,9:17) = flip(layerMaskQ2,2);
    layerMask(9:17,9:17) = flip(flip(layerMaskQ2,2));
    layerMask = layerMask(9-maskMax:9+maskMax, 9-maskMax:9+maskMax);
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
    for fileN = 1:3
        for j = 0:(num_MIs * num_MIs)-1
            for img = 1:num_Imgs
                [ypos, xpos] = find(cc_spiral_scl == j);
                totalBitsPerLayerSET2(img, layerMask(ypos,xpos)) = totalBitsPerLayerSET2(img, layerMask(ypos,xpos)) + BITS_SET2(img,ypos,xpos+num_MIs*(fileN-1)); % QP 27
                totalEncTimePerLayerSET2(img, layerMask(ypos,xpos)) = totalEncTimePerLayerSET2(img, layerMask(ypos,xpos)) + ET_SET2(img,ypos,xpos+num_MIs*(fileN-1)); % QP 27
                totalDecTimePerLayerSET2(img, layerMask(ypos,xpos)) = totalDecTimePerLayerSET2(img, layerMask(ypos,xpos)) + DT_SET2(img,ypos,xpos+num_MIs*(fileN-1)); % QP 27
            end
        end
    end
end

