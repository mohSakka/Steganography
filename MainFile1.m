clc
clear
close all
tic
global imCover;
for imNum=[1:2]
    imName = [num2str(imNum)] ;
    %hostImagePath = ['../data/Our Data/' imName '.jpeg'];
    hostImagePath = ['../data/brain images/' imName '.mat'];
%hostImagePath = [cd '/../../../data/brain images/' imName '.mat'];
    message = 'Steganography is the practice of concealing a message within another message or a physical object. In computing/electronic contexts, a computer file, message, image, or video is concealed within another file, message, image, or video. The word steganography comes from Greek steganographia, which combines the words steganos , meaning "covered or concealed, and -graphia  meaning "writing.The first recorded use of the term was in 1499 by Johannes Trithemius in his Steganographia, a treatise on cryptography and steganography, disguised as a book on magic. Generally, the hidden messages appear to be (or to be part of) something else: images, articles, shopping lists, or some other cover text. For example, the hidden message may be in invisible ink between the visible lines of a private letter. Some implementations of steganography that lack a shared secret are forms of security through obscurity, and key-dependent steganographic schemes adhere to Kerckhoffss principle.The advantage of steganography over cryptography alone is that the intended secret message does not attract attention to itself as an object of scrutiny. Plainly visible encrypted messages, no matter how unbreakable they are, arouse interest and may in themselves be incriminating in countries in which encryptionis illegal.Whereas cryptography is the practice of protecting the contents of a message alone, steganography is concerned with concealing the fact that a secret message is being sent and its contents. Steganography includes the concealment of information within computer files. In digital steganography, electronic communications may include steganographic coding inside of a transport layer such as a document file image file program or protocol. Media files are ideal for steganographic transmission because of their large size. For example a sender might start with an innocuous image file and adjust the color of every hundredth pixel to correspond to a letter in the alphabet. The change is so subtle that someone who is not specifically looking for it is unlikely to notice the change.The first recorded uses of steganography can be traced back to 440 BC in Greece, when Herodotus mentions two examples in his Histories. Histiaeus sent a message to his vassal, Aristagoras, by shaving the head of his most trusted servant, "marking" the message onto his scalp, then sending him on his way once his hair had regrown, with the instruction, "When thou art come to Miletus, bid Aristagoras shave thy head, and look thereon." Additionally, Demaratus sent a warning about a forthcoming attack to Greece by writing it directly on the wooden backing of a wax tablet before applying its beeswax surface. Wax tablets were in common use then as reusable writing surfaces, sometimes used for shorthand.In his work Polygraphiae, Johannes Trithemius developed his so-called "Ave-Maria-Cipher" that can hide information in a Latin praise of God. "Auctor Sapientissimus Conseruans Angelica Deferat Nobis Charitas Potentissimi Creatoris for example contains the concealed word VICIPEDIA.Modern steganography entered the world in 1985 with the advent of personal computers being applied to classical steganography problems.[7] Development following that was very slow, but has since taken off, going by a large number of steganography software availableAn image or a text can be converted into a soundfile, which is then analysed with a spectrogram to reveal the image. Various artists have used this method to conceal hidden pictures in their songs, such as Aphex Twin in "Windowlicker" or Nine Inch Nails in their album Year ZeroIn communities with social or government taboos or censorship, people use cultural steganographyhiding messages in idiom, pop culture references, and other messages they share publicly and assume are monitored. This relies on social context to make the underlying messages visible only to certain readers.';
 %message = 'Steganography';
   load(hostImagePath);
   imCover =  cjdata.image;
   % imCover = imread(hostImagePath);
    imCover = preprocess(imCover);
    stego = imCover;
    imSec = double(message);
    numberOfSubMsgs = 9;
    prevInd = 1;
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
    for seed = 1:5
         %imCover = imread(hostImagePath);
         load(hostImagePath);
   imCover =  cjdata.image;
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
            
        end
        extractedMessage = cell2mat(imSecEx);
        % Results;
        elapsedTime=toc;
        clc
        str=['The elapsed time is : ' num2str(elapsedTime) ' sec'];
        disp(str);
         savingDir = ['../results/brain_9/'];
%         if ~exist(savingDir,'dir');
%             mkdir(savingDir);
%         end
        save([savingDir '/' num2str(imNum) '_seed ' num2str(seed)],'finalChrom','imSecEx','trueMessage','stego');
    end
    end
