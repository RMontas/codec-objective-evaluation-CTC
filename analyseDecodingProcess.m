function [DT] = analyseDecodingProcess(encoder_output, max_ref_pics, SCL_FLAG, num_MIs)

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
    layerMask =  [  2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 1 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ;
                    2 2 2 2 2 2 2 2 2 2 2 2 2 ];
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

DT = zeros(num_MIs, num_MIs); DT(:,:)=-1;
SAIUsage = zeros(num_MIs, num_MIs); SAIUsage(:,:)=-1;

fn = 0;
for l = 1:num_Layers
    for j = 0:(num_MIs * num_MIs)-1
        [ypos, xpos] = find(cc_spiral == j);
        if layerMask(ypos,xpos) == l
            s = 1;
            while s < numEntries(1) && SAIUsage(ypos,xpos)==-1
                if strcmp(outEncoderTxt{1}(s),'POC') && str2double(outEncoderTxt{1}(s+1))==fn
                    outDec = strsplit(string(outEncoderTxt{1}(s+10)),']');
                    DT(ypos,xpos) = str2double(outDec(1));
                    SAIUsage(ypos,xpos)=1;
                    fn = fn + 1;
                end
                s = s + 1;
            end
        end
    end
end

clear outEncoderTxt;

else
     DT = zeros(num_MIs, num_MIs*3); DT(:,:)=-1;
     SAIUsage = zeros(num_MIs, num_MIs*3); SAIUsage(:,:)=-1;
     for fileN = 1:3
         encoder_output_char = char(encoder_output);
         encoder_output_char_PVS_positions = strfind(encoder_output_char,"PVS");
         encoder_output_char = strcat(encoder_output_char(1:encoder_output_char_PVS_positions(1)-1),"PVS",num2str(fileN-1), ...
             encoder_output_char(encoder_output_char_PVS_positions(1)+4:encoder_output_char_PVS_positions(2)-1),"PVS",num2str(fileN-1), ...
             encoder_output_char(encoder_output_char_PVS_positions(2)+4:end));
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
                             outDec = strsplit(string(outEncoderTxt{1}(s+10)),']');
                             DT(ypos,xpos+num_MIs*(fileN-1)) = str2double(outDec(1));
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
    
end
