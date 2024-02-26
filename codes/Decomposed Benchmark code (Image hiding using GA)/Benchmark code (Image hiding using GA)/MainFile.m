clc
clear
close all
tic
global imCover;
for imNum=1:1
    imName = [num2str(imNum) ];
%   hostImagePath = [cd '/../../../data/brain images/' imName '.mat'];
    hostImagePath = [cd '/../../../data/Our Data/' imName '.jpeg'];
    %message = 'Steganography is the practice of concealing a message within another message or a physical object. In computing/electronic contexts, a computer file, message, image, or video is concealed within another file, message, image, or video. The word steganography comes from Greek steganographia, which combines the words steganós (????????), meaning "covered or concealed", and -graphia (?????) meaning "writing".The first recorded use of the term was in 1499 by Johannes Trithemius in his Steganographia, a treatise on cryptography and steganography, disguised as a book on magic. Generally, the hidden messages appear to be (or to be part of) something else: images, articles, shopping lists, or some other cover text. For example, the hidden message may be in invisible ink between the visible lines of a private letter. Some implementations of steganography that lack a shared secret are forms of security through obscurity, and key-dependent steganographic schemes adhere to Kerckhoffss principle.The advantage of steganography over cryptography alone is that the intended secret message does not attract attention to itself as an object of scrutiny. Plainly visible encrypted messages, no matter how unbreakable they are, arouse interest and may in themselves be incriminating in countries in which encryption';
    %message = 'During the first part of your life, you only become aware of happiness once you have lost it.'
    %message='Its more important than ever to make sure your mobile devices are secure and your personal information stays private.';
    message = 'Our goal is to increase awareness about cyber safety. Please review complete Terms during enrollment or setup.'
    %     message = 'Steganography';
%      load(hostImagePath);
%      imCover =  cjdata.image;
   imCover = imread(hostImagePath);
    imCover = preprocess(imCover);
    stego = imCover;
    imSec = double(message);
    numberOfSubMsgs = 5;
    prevInd = 1;
       figure(2);
            imshow(imCover);
            hold on
    for sbmsg=1:numberOfSubMsgs
        try
        subMsgs{sbmsg} = imSec(prevInd:prevInd + floor(length(imSec)/numberOfSubMsgs));
        catch
            subMsgs{sbmsg} = imSec(prevInd:end);
        end
        prevInd = prevInd+floor(length(imSec)/numberOfSubMsgs) + 1;
    end
    
    %imSec12 = {imSec1,imSec2};
    %ReadImages;
    for seed =2:2
         %imCover = imread(hostImagePath);
         %load(hostImagePath);
     %imCover =  cjdata.image;
     imCover =  imread(hostImagePath);
    imCover = preprocess(imCover);
        global bitSeq combBitSeq reversBitSeq reversCombBitSeq
        finalChrom=[];
        forbiddenAreas = [];
        oldChromPixels = [];
        for deco =1:numberOfSubMsgs
            
        [bitSeq,combBitSeq,reversBitSeq,reversCombBitSeq]=...
            ConvertSecretImToBitSeq(subMsgs{deco});
      
        % Call genetic to determine the best way of embedding
        GApart;
        finalChrom = [finalChrom chrom];
        forbiddenAreas = [forbiddenAreas forbiddenArea];
        
        % Extract the original Message
        [orgMessage{deco}]=ExtractOriginalMessage...
            (oldChromPixels,stego,chromPixelSeq,nvar,...
            messageLength,chrom);
        oldChromPixels = [oldChromPixels oldPixelsSequence];
        sbPole=chrom(5);
        sbDir=chrom(6);
        trueMessage{deco}=ConvertToTrueMessage(orgMessage{deco},sbPole,sbDir);
        
        imSecEx{deco}=reshape(trueMessage{deco},length(subMsgs{deco}),8);
        imSecEx{deco}=bin2dec(imSecEx{deco});
        imSecEx{deco}=reshape(imSecEx{deco},1,length(subMsgs{deco}));
       
        if deco<numberOfSubMsgs
            imCover = stego;
        end
             offset = 10;
            [messRows,messCols] = ind2sub([512,512],messPixelSeq);
            figure(2);
            %plot(messCols,messRows,'.','color',rand(1,3))
            plot_dir (messCols',messRows')
            text(messCols(1),messRows(1),char(imSecEx{deco}),'color','w')
            if ismember(direction,[0,2])
                p1 = [messCols(1),messRows(offset)-offset];
                p2 = [messCols(offset),messRows(1)-offset];
                p3 = [p1(1),p1(2)+offset];
                p4 = [p2(1),p2(2)+offset];
                dp = p2-p1; 
                dp2 = p4-p3;
            elseif ismember(direction,[1,3])
                p1 = [messCols(offset),messRows(offset)];
                p2 = [messCols(1),messRows(offset)];
                p3 = [p1(1),p1(2)+offset];
                p4 = [p2(1),p2(2)+offset];
                dp = p2-p1; 
                dp2 = p4-p3;
            elseif ismember(direction,[4,7])
                p1 = [messCols(offset)-offset,messRows(offset)];
                p2 = [messCols(1),messRows(1)-offset];
                p3 = [p1(1)-offset,p1(2)];
                p4 = [p2(1),p2(2)-offset];
                dp = p2-p1; 
                dp2 = p4-p3;
            elseif ismember(direction,[5,6])
                p1 = [messCols(offset),messRows(offset)-offset];
                p2 = [messCols(1)-offset,messRows(1)];
                p3 = [p1(1),p1(2)-offset];
                p4 = [p2(1)-offset,p2(2)];
                dp = p2-p1; 
                dp2 = p4-p3; 
            elseif ismember(direction,[8,9])
                p1 = [messCols(offset),messRows(offset)-offset];
                p2 = [messCols(1)+offset,messRows(1)-offset];
                p3 = [p1(1),p1(2)-offset];
                p4 = [p2(1)+offset,p2(2)-offset];
                dp = p2-p1; 
                dp2 = p4-p3; 
            elseif ismember(direction,[10,11])
                p1 = [messCols(offset),messRows(offset)-offset];
                p2 = [messCols(1)+offset,messRows(1)+offset];
                p3 = [p1(1),p1(2)-offset];
                p4 = [p2(1)+offset,p2(2)+offset];
                dp = p2-p1; 
                dp2 = p4-p3; 
            elseif ismember(direction,[12,15])
                p1 = [messCols(offset),messRows(offset)-offset];
                p2 = [messCols(1)+offset,messRows(1)+offset];
                p3 = [p1(1),p1(2)+offset];
                p4 = [p2(1)+offset,p2(2)-offset];
                dp = p2-p1; 
                dp2 = p4-p3;
            else
                p1 = [messCols(offset),messRows(offset)+offset];
                p2 = [messCols(1)+offset,messRows(1)-offset];
                p3 = [p1(1),p1(2)-offset];
                p4 = [p2(1)+offset,p2(2)+offset];
                dp = p2-p1; 
                dp2 = p4-p3;
            end
         
                
        end
%          legend(char(imSecEx{1}),char(imSecEx{2}),char(imSecEx{3}),...
%              char(imSecEx{4}),char(imSecEx{5}))
        extractedMessage = cell2mat(imSecEx);
        % Results;
        elapsedTime=toc;
        clc
        str=['The elapsed time is : ' num2str(elapsedTime) ' sec'];
        disp(str);
        savingDir = [cd '/../../../results-codeOcean-Chest/BenchMark_Decomposed3' ];
%         if ~exist(savingDir,'dir');
%             mkdir(savingDir);
%         end
       % save([savingDir '/' imName '_seed ' num2str(seed)],'finalChrom','imSecEx','trueMessage','stego');
    end
    end
