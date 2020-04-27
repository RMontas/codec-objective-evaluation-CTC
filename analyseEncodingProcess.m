function [POC, QP, BITS, ET, REF_PICS, REF_PICS_LAYER, RAPenalty] = analyseEncodingProcess(encoder_output, max_ref_pics, SCL_FLAG, num_MIs)

%% SCALABILITY
num_Layers = 6;
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
%     layerMask =  [ 6 6 4 6 3 6 4 6 3 6 4 6 6 ;
%                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
%                    4 6 2 6 4 6 2 6 4 6 2 6 4 ;
%                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
%                    3 6 4 6 3 6 4 6 3 6 4 6 3 ;
%                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
%                    4 6 2 6 4 6 1 6 4 6 2 6 4 ;
%                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
%                    3 6 4 6 3 6 4 6 3 6 4 6 3 ;
%                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
%                    4 6 2 6 4 6 2 6 4 6 2 6 4 ;
%                    6 5 6 5 6 5 6 5 6 5 6 5 6 ;
%                    6 6 4 6 3 6 4 6 3 6 4 6 6 ];
else %% NON SCL
    maskMax = floor(num_MIs / 2);
    layerMaskQ2 =  [ 2 2 2 2 2 2 2 2 2;
                    2 2 2 2 2 2 2 2 2;
                    2 2 2 2 2 2 2 2 2;
                    2 2 2 2 2 2 2 2 2;
                    2 2 2 2 2 2 2 2 2;
                    2 2 2 2 2 2 2 2 2;
                    2 2 2 2 2 2 2 2 2;
                    2 2 2 2 2 2 2 2 2;
                    2 2 2 2 2 2 2 2 1];
                layerMask = layerMaskQ2;
        layerMask(9:17,1:9) = flip(layerMaskQ2);
        layerMask(1:9,9:17) = flip(layerMaskQ2,2);
        layerMask(9:17,9:17) = flip(flip(layerMaskQ2,2));
        layerMask = layerMask(9-maskMax:9+maskMax, 9-maskMax:9+maskMax);
end
%%

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

if contains(encoder_output,"SET2") == 0

fid = fopen(encoder_output);
[outEncoderTxt] = textscan(fid, '%s');
fclose(fid);
numEntries = size(outEncoderTxt{1});
POC = zeros(num_MIs, num_MIs); POC(:,:)=-1;
QP = zeros(num_MIs, num_MIs); QP(:,:)=-1;
BITS = zeros(num_MIs, num_MIs); BITS(:,:)=-1;
ET = zeros(num_MIs, num_MIs); ET(:,:)=-1;
REF_PICS0 = zeros(max_ref_pics/2, num_MIs, num_MIs); REF_PICS0(:,:,:)=-1;
REF_PICS0_LAYER = zeros(max_ref_pics/2, num_MIs, num_MIs); REF_PICS0_LAYER(:,:,:)=-1;
SAIUsage = zeros(num_MIs, num_MIs); SAIUsage(:,:)=-1;
%L1
REF_PICS1 = zeros(max_ref_pics/2, num_MIs, num_MIs); REF_PICS1(:,:,:)=-1;
REF_PICS1_LAYER = zeros(max_ref_pics/2, num_MIs, num_MIs); REF_PICS1_LAYER(:,:,:)=-1;

fn = 0;
for l = 1:num_Layers
    for j = 0:(num_MIs * num_MIs)-1
        [ypos, xpos] = find(cc_spiral == j);
        if layerMask(ypos,xpos) == l
            s = 1;
            while s < numEntries(1) && SAIUsage(ypos,xpos)==-1
                if strcmp(outEncoderTxt{1}(s),'POC') && str2double(outEncoderTxt{1}(s+1))==fn
                    POC(ypos,xpos) = str2double(outEncoderTxt{1}(s+1));
                    QP(ypos,xpos) = str2double(outEncoderTxt{1}(s+9));
                    BITS(ypos,xpos) = str2double(outEncoderTxt{1}(s+11));
                    ET(ypos,xpos) = str2double(outEncoderTxt{1}(s+23));
                    for refPicNum = 1:max_ref_pics/2 % L0
                        if strcmp(outEncoderTxt{1}(s+26+(refPicNum-1)),']') == 0 
                            REF_PICS0(refPicNum,ypos,xpos)=str2double(outEncoderTxt{1}(s+26+(refPicNum-1)));
                            [yposREF, xposREF] = find(cc_spiral_scl == REF_PICS0(refPicNum,ypos,xpos));
                            REF_PICS0_LAYER(refPicNum,ypos,xpos)=layerMask(yposREF, xposREF);
                        else 
                            break;
                        end
                    end
                    while strcmp(outEncoderTxt{1}(s),'[L1') == 0
                        s = s + 1;
                    end
                    for refPicNum = 1:max_ref_pics/2 % L1
                        if strcmp(outEncoderTxt{1}(s+(refPicNum)),']') == 0 
                            REF_PICS1(refPicNum,ypos,xpos)=str2double(outEncoderTxt{1}(s+(refPicNum)));
                            [yposREF, xposREF] = find(cc_spiral_scl == REF_PICS1(refPicNum,ypos,xpos));
                            REF_PICS1_LAYER(refPicNum,ypos,xpos)=layerMask(yposREF, xposREF);
                        else 
                            break;
                        end
                    end
                    SAIUsage(ypos,xpos)=1;
                    fn = fn + 1;
                end
                s = s + 1;
            end
        end
    end
end

clear outEncoderTxt;

% create single REF_PICS buffer with all references regardless of the list (L0 L1)
% repeated image refs will be ignored when calculating RAP
REF_PICS = zeros(max_ref_pics, num_MIs, num_MIs); REF_PICS(:,:,:)=-1;
REF_PICS_LAYER = zeros(max_ref_pics, num_MIs, num_MIs); REF_PICS_LAYER(:,:,:)=-1;
for fn=0:(num_MIs * num_MIs)-1
    [ypos, xpos] = find(cc_spiral_scl == fn);
    for refpic = 1:max_ref_pics/2 % L0
        REF_PICS(refpic,ypos,xpos) = REF_PICS0(refpic,ypos,xpos);
        REF_PICS_LAYER(refpic,ypos,xpos) = REF_PICS0_LAYER(refpic,ypos,xpos);
    end
    for refpic = 1:max_ref_pics/2 % L1
        REF_PICS(refpic+max_ref_pics/2,ypos,xpos) = REF_PICS1(refpic,ypos,xpos);
        REF_PICS_LAYER(refpic+max_ref_pics/2,ypos,xpos) = REF_PICS1_LAYER(refpic,ypos,xpos);
    end
end

REFUsage = zeros(num_MIs, num_MIs); REFUsage(:,:)=-1;
RAPenalty = zeros(num_MIs, num_MIs);
totalBits = sum(BITS(:));
for fn=0:(num_MIs * num_MIs)-1
    REFUsage(:,:)=-1;
    [ypos, xpos] = find(cc_spiral_scl == fn);
    accumBits = BITS(ypos, xpos);
    [accumBits, REFUsage] = accumBitsRefPics(accumBits, REF_PICS, BITS, REFUsage, ypos, xpos, cc_spiral_scl, max_ref_pics);
    %for refPicNum = 1:max_ref_pics
    %    if REF_PICS(refPicNum,ypos,xpos) > -1 % not intra
    %        [yposREF, xposREF] = find(cc_spiral_scl == REF_PICS(refPicNum,ypos,xpos));
    %        if REFUsage() == -1 % if not already used
    %            accumBits = accumBits + BITS(yposREF, xposREF);
    %        end
    %    end
    %end
    RAPenalty(ypos, xpos) = accumBits/totalBits;
end

%surf(RAPenalty)
%a=sprintf("Avg: %f\nStd: %f\nMax: %f\nMin: %f\n",mean(RAPenalty(:)),std(RAPenalty(:)),max(RAPenalty(:)),min(RAPenalty(:)));
%disp(a)
else    
    POC = zeros(num_MIs, num_MIs*3); POC(:,:)=-1;
    QP = zeros(num_MIs, num_MIs*3); QP(:,:)=-1;
    BITS = zeros(num_MIs, num_MIs*3); BITS(:,:)=-1;
    ET = zeros(num_MIs, num_MIs*3); ET(:,:)=-1;
    REF_PICS0 = zeros(max_ref_pics, num_MIs, num_MIs*3); REF_PICS0(:,:,:)=-1;
    REF_PICS0_LAYER = zeros(max_ref_pics, num_MIs, num_MIs*3); REF_PICS0_LAYER(:,:,:)=-1;
    REF_PICS1 = zeros(max_ref_pics, num_MIs, num_MIs*3); REF_PICS1(:,:,:)=-1;
    REF_PICS1_LAYER = zeros(max_ref_pics, num_MIs, num_MIs*3); REF_PICS1_LAYER(:,:,:)=-1;
    SAIUsage = zeros(num_MIs, num_MIs*3); SAIUsage(:,:)=-1;
    
    for fileN = 1:3
        encoder_output_char = char(encoder_output);
        encoder_output_char_PVS_positions = strfind(encoder_output_char,"PVS");
        encoder_output_char = strcat(encoder_output_char(1:encoder_output_char_PVS_positions(1)-1),"PVS",num2str(fileN-1), ...
            encoder_output_char(encoder_output_char_PVS_positions(1)+4:encoder_output_char_PVS_positions(2)-1),"PVS",num2str(fileN-1), ...
            encoder_output_char(encoder_output_char_PVS_positions(2)+4:end));
        %%%%%%%%%%%%%%% COMMENT NEXT LINE WHEN NOT USING HEVC_PVS... //  % bug: folder name has "PVS" it doesnt work
         if fileN == 1
             encoder_output_char = "HEVC_PVS_RA_IP16/4DLF_PVS0_SET2_YUV444_10/27/out_4DLF_PVS0_SET2_YUV444_10_27.txt";
         end
         if fileN == 2
             encoder_output_char = "HEVC_PVS_RA_IP16/4DLF_PVS1_SET2_YUV444_10/27/out_4DLF_PVS1_SET2_YUV444_10_27.txt";
         end
         if fileN == 3
             encoder_output_char = "HEVC_PVS_RA_IP16/4DLF_PVS2_SET2_YUV444_10/27/out_4DLF_PVS2_SET2_YUV444_10_27.txt";
         end
        %%%%%%%%%%%%%%%
        fid = fopen(encoder_output_char);
        [outEncoderTxt] = textscan(fid, '%s');
        fclose(fid);
        numEntries = size(outEncoderTxt{1});
        
        fn = 0;
        for l = 1:num_Layers
            for j = 0:(num_MIs * num_MIs)-1
                [ypos, xpos] = find(cc_spiral == j);
                if layerMask(ypos,xpos) == l
                    s = 1;
                    while s < numEntries(1) && SAIUsage(ypos,xpos+num_MIs*(fileN-1))==-1
                        if strcmp(outEncoderTxt{1}(s),'POC') && str2double(outEncoderTxt{1}(s+1))==fn
                            POC(ypos,xpos+num_MIs*(fileN-1)) = str2double(outEncoderTxt{1}(s+1));
                            QP(ypos,xpos+num_MIs*(fileN-1)) = str2double(outEncoderTxt{1}(s+9));
                            BITS(ypos,xpos+num_MIs*(fileN-1)) = str2double(outEncoderTxt{1}(s+11));
                            ET(ypos,xpos+num_MIs*(fileN-1)) = str2double(outEncoderTxt{1}(s+23));
                            for refPicNum = 1:max_ref_pics % L0
                                if strcmp(outEncoderTxt{1}(s+26+(refPicNum-1)),']') == 0
                                    REF_PICS0(refPicNum,ypos,xpos+num_MIs*(fileN-1))=str2double(outEncoderTxt{1}(s+26+(refPicNum-1)));
                                    [yposREF, xposREF] = find(cc_spiral_scl == REF_PICS0(refPicNum,ypos,xpos+num_MIs*(fileN-1)));
                                    REF_PICS0_LAYER(refPicNum,ypos,xpos+num_MIs*(fileN-1))=layerMask(yposREF, xposREF);
                                else
                                    break;
                                end
                            end
                            while strcmp(outEncoderTxt{1}(s),'[L1') == 0
                                s = s + 1;
                            end
                            for refPicNum = 1:max_ref_pics % L1
                                if strcmp(outEncoderTxt{1}(s+(refPicNum)),']') == 0
                                    REF_PICS1(refPicNum,ypos,xpos+num_MIs*(fileN-1))=str2double(outEncoderTxt{1}(s+(refPicNum)));
                                    [yposREF, xposREF] = find(cc_spiral_scl == REF_PICS1(refPicNum,ypos,xpos+num_MIs*(fileN-1)));
                                    REF_PICS1_LAYER(refPicNum,ypos,xpos+num_MIs*(fileN-1))=layerMask(yposREF, xposREF);
                                else
                                    break;
                                end
                            end
                            SAIUsage(ypos,xpos+num_MIs*(fileN-1))=1;
                            fn = fn + 1;
                        end
                        s = s + 1;
                    end
                end
            end
        end
    end
    clear outEncoderTxt;
    
    % create single REF_PICS buffer with all references regardless of the list (L0 L1)
    % repeated image refs will be ignored when calculating RAP
    REF_PICS = zeros(max_ref_pics, num_MIs, num_MIs*3); REF_PICS(:,:,:)=-1;
    REF_PICS_LAYER = zeros(max_ref_pics/2, num_MIs, num_MIs*3); REF_PICS_LAYER(:,:,:)=-1;
    for fileN = 1:3
        for fn=0:(num_MIs * num_MIs)-1
            [ypos, xpos] = find(cc_spiral_scl == fn);
            for refpic = 1:max_ref_pics/2 % L0
                REF_PICS(refpic,ypos,xpos+num_MIs*(fileN-1)) = REF_PICS0(refpic,ypos,xpos+num_MIs*(fileN-1));
                REF_PICS_LAYER(refpic,ypos,xpos+num_MIs*(fileN-1)) = REF_PICS0_LAYER(refpic,ypos,xpos+num_MIs*(fileN-1));
            end
            for refpic = 1:max_ref_pics/2 % L1
                REF_PICS(refpic+max_ref_pics/2,ypos,xpos+num_MIs*(fileN-1)) = REF_PICS1(refpic,ypos,xpos+num_MIs*(fileN-1));
                REF_PICS_LAYER(refpic+max_ref_pics/2,ypos,xpos+num_MIs*(fileN-1)) = REF_PICS1_LAYER(refpic,ypos,xpos+num_MIs*(fileN-1));
            end
        end
    end
    
    REFUsage = zeros(num_MIs, num_MIs); REFUsage(:,:)=-1;
    RAPenalty = zeros(num_MIs, num_MIs*3);
    totalBits = sum(BITS(:));
    for fileN = 1:3
        REFUsage(:,:)=-1;
        for fn=0:(num_MIs * num_MIs)-1
            REFUsage(:,:)=-1;
            [ypos, xpos] = find(cc_spiral_scl == fn);
            accumBits = BITS(ypos, xpos+num_MIs*(fileN-1));
            [accumBits, REFUsage] = accumBitsRefPics(accumBits, REF_PICS(:,:,1+num_MIs*(fileN-1):num_MIs*(fileN)), BITS(:,1+num_MIs*(fileN-1):num_MIs*(fileN)), REFUsage, ypos, xpos, cc_spiral_scl, max_ref_pics);
            %for refPicNum = 1:max_ref_pics
            %    if REF_PICS(refPicNum,ypos,xpos) > -1 % not intra
            %        [yposREF, xposREF] = find(cc_spiral_scl == REF_PICS(refPicNum,ypos,xpos));
            %        if REFUsage() == -1 % if not already used
            %            accumBits = accumBits + BITS(yposREF, xposREF);
            %        end
            %    end
            %end
            RAPenalty(ypos, xpos+num_MIs*(fileN-1)) = accumBits/totalBits;
            RAPenalty(ypos, xpos+num_MIs*(fileN-1)) 
        end
    end
    
    %surf(RAPenalty)
    %a=sprintf("Avg: %f\nStd: %f\nMax: %f\nMin: %f\n",mean(RAPenalty(:)),std(RAPenalty(:)),max(RAPenalty(:)),min(RAPenalty(:)));
    %disp(a)

    
end

end

function [accumBits, REFUsage] = accumBitsRefPics(accumBits, REF_PICS, BITS, REFUsage, ypos, xpos, cc_spiral_scl, max_ref_pics)

for refPicNum = 1:max_ref_pics
    if REF_PICS(refPicNum,ypos,xpos) > -1 % not intra
        [yposREF, xposREF] = find(cc_spiral_scl == REF_PICS(refPicNum,ypos,xpos));
        if REFUsage(yposREF, xposREF) == -1 % if not already used
            REFUsage(yposREF, xposREF) = 0;
            accumBits = accumBits + BITS(yposREF, xposREF);
            [accumBits, REFUsage] = accumBitsRefPics(accumBits, REF_PICS, BITS, REFUsage, yposREF, xposREF, cc_spiral_scl, max_ref_pics);
        end
    end
end
end

