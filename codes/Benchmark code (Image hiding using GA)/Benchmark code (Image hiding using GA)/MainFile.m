clc
clear 
close all
tic
global imCover;
% User Message (Maximum allowed 60 char = 480  bit)
%message='Plain text sensitivity Test Method: The percentage of change in bits of cipher text obtained after e';    % The user message : length 296 bit 
%message='Hi Karaar';
%coverImageName='karaar.jpg';        % 512 * 512
for imNum=1:1
    imName = [num2str(imNum) '.jpeg'];
% hostImagePath = [cd '/../../../data/brain images/' imName '.mat'];
hostImagePath = [cd '/../../../data/Our Data/' imName];
%     message = 'Steganography is the practice of concealing a message within another message or a physical object. In computing/electronic contexts, a computer file, message, image, or video is concealed within another file, message, image, or video. The word steganography comes from Greek steganographia, which combines the words steganós (????????), meaning "covered or concealed", and -graphia (?????) meaning "writing".The first recorded use of the term was in 1499 by Johannes Trithemius in his Steganographia, a treatise on cryptography and steganography, disguised as a book on magic. Generally, the hidden messages appear to be (or to be part of) something else: images, articles, shopping lists, or some other cover text. For example, the hidden message may be in invisible ink between the visible lines of a private letter. Some implementations of steganography that lack a shared secret are forms of security';
%     message = 'Steganography is the practice of concealing a message within another message or a physical object. In computing/electronic contexts, a computer file, message, image, or video is concealed within another file, message, image, or video. The word steganography comes from Greek steganographia, which combines the words steganós (????????), meaning "covered or concealed", and -graphia (?????) meaning "writing".The first recorded use of the term was in 1499';
% message([4517 4635]) = [];
message = 'Steganography is the practice of concealing a message within another message or a physical object. In computing/electronic contexts, a computer file, message, image, or video is concealed within another file, message, image, or video. The word steganography comes from Greek steganographia, which combines the words steganós (????????), meaning "covered or concealed", and -graphia (?????) meaning "writing".The first recorded use of the term was in 1499 by Johannes Trithemius in his Steganographia, a treatise on cryptography and steganography, disguised as a book on magic. Generally, the hidden messages appear to be (or to be part of) something else: images, articles, shopping lists, or some other cover text. For example, the hidden message may be in invisible ink between the visible lines of a private letter. Some implementations of steganography that lack a shared secret are forms of security through obscurity, and key-dependent steganographic schemes adhere to Kerckhoffss principle.The advantage of steganography over cryptography alone is that the intended secret message does not attract attention to itself as an object of scrutiny. Plainly visible encrypted messages, no matter how unbreakable they are, arouse interest and may in themselves be incriminating in countries in which encryption';
% message = 'Steganography is the practice of concealing a message within another message or a physical object. In computing/electronic contexts, a computer file, message, image, or video is concealed within another file, message, image, or video. The word steganography comes from Greek steganographia, which combines the words steganós (????????), meaning "covered or concealed", and -graphia (?????) meaning "writing".The first recorded use of the term was in 1499 by Johannes Trithemius in his Steganographia, a treatise on cryptography and steganography, disguised as a book on magic. Generally, the hidden messages appear to be (or to be part of) something else: images, articles, shopping lists, or some other cover text. For example, the hidden message may be in invisible ink between the visible lines of a private letter. Some implementations of steganography that lack a shared secret are forms of security through obscurity, and key-dependent steganographic schemes adhere to Kerckhoffss principle.The advantage of steganography over cryptography alone is that the intended secret message does not attract attention to itself as an object of scrutiny. Plainly visible encrypted messages, no matter how unbreakable they are, arouse interest and may in themselves be incriminating in countries in which encryption is illegal.Whereas cryptography is the practice of protecting the contents of a message alone, steganography is concerned with concealing the fact that a secret message is being sent and its contents.Steganography includes the concealment of information within computer files. In digital steganography, electronic communications may include steganographic coding inside of a transport layer, such as a document file, image file, program, or protocol. Media files are ideal for steganographic transmission because of their large size. For example, a sender might start with an innocuous image file and adjust the color of every hundredth pixel to correspond to a letter in the alphabet. The change is so subtle that someone who is not specifically looking for it is unlikely to notice the change.The first recorded uses of steganography can be traced back to 440 BC in Greece, when Herodotus mentions two examples in his Histories.[4] Histiaeus sent a message to his vassal, Aristagoras, by shaving the head of his most trusted servant, "marking" the message onto his scalp, then sending him on his way once his hair had regrown, with the instruction, "When thou art come to Miletus, bid Aristagoras shave thy head, and look thereon." Additionally, Demaratus sent a warning about a forthcoming attack to Greece by writing it directly on the wooden backing of a wax tablet before applying its beeswax surface. Wax tablets were in common use then as reusable writing surfaces, sometimes used for shorthand.In his work Polygraphiae, Johannes Trithemius developed his so-called "Ave-Maria-Cipher" that can hide information in a Latin praise of God. "Auctor Sapientissimus Conseruans Angelica Deferat Nobis Charitas Potentissimi Creatoris" for example contains the concealed word VICIPEDIA.Discussions of steganography generally use terminology analogous to and consistent with conventional radio and communications technology. However, some terms appear specifically in software and are easily confused. These are the most relevant ones to digital steganographic systems: The payload is the data covertly communicated. The carrier is the signal, stream, or data file that hides the payload, which differs from the channel, which typically means the type of input, such as a JPEG image. The resulting signal, stream, or data file with the encoded payload is sometimes called the package, stego file, or covert message. The proportion of bytes, samples, or other signal elements modified to encode the payload is called the encoding density and is typically expressed as a number between 0 and 1.In a set of files, the files that are considered likely to contain a payload are suspects. A suspect identified through some type of statistical analysis can be referred to as a candidate.In computing, steganographically encoded package detection is called steganalysis. The simplest method to detect modified files, however, is to compare them to known originals. For example, to detect information being moved through the graphics on a website, an analyst can maintain known clean copies of the materials and then compare them against the current contents of the site. The differences, if the carrier is the same, comprise the payload. In general, using extremely high compression rates makes steganography difficult but not impossible. Compression errors provide a hiding place for data, but high compression reduces the amount of data available to hold the payload, raising the encoding density, which facilitates easier detection (in extreme cases, even by casual observation).There are a variety of basic tests that can be done to identify whether or not a secret message exists. This process is not concerned with the extraction of the message, which is a different process and a separate step. The most basic approaches of steganalysis are visual or aural attacks, structural attacks, and statistical attacks. These approaches attempt to detect the steganographic algorithms that were used.[49] These algorithms range from unsophisticated to very sophisticated, with early algorithms being much easier to detect due to statistical anomalies that were present. The size of the message that is being hidden is a factor in how difficult it is to detect. The overall size of the cover object also plays a factor as well. If the cover object is small and the message is large, this can distort the statistics and make it easier to detect. A larger cover object with a small message decreases the statistics and gives it a better chance of going unnoticed.';
% load(hostImagePath);

% imCover =  cjdata.image;
imCover = imread(hostImagePath);
imCover = preprocess(imCover);
imSec=double(message); 
%ReadImages;
for seed = 1:1
global bitSeq combBitSeq reversBitSeq reversCombBitSeq 
[bitSeq,combBitSeq,reversBitSeq,reversCombBitSeq]=ConvertSecretImToBitSeq(imSec);

% Call genetic to determine the best way of embedding
GApart;

% Extract the original Message
[orgMessage]=ExtractOriginalMessage(stego,chromPixelSeq,nvar,messageLength,chrom);
sbPole=chrom(5);
sbDir=chrom(6);
trueMessage=ConvertToTrueMessage(orgMessage,sbPole,sbDir);

imSecEx=reshape(trueMessage,length(imSec),8);
imSecEx=bin2dec(imSecEx);
imSecEx=reshape(imSecEx,1,length(imSec));

% Results;
elapsedTime=toc;
clc
str=['The elapsed time is : ' num2str(elapsedTime) ' sec'];
disp(str);
% savingDir = [cd '/../../../results_Chest/BenchMark/long message ' imName];
% if ~exist(savingDir,'dir');
%     mkdir(savingDir);
% end
% save([savingDir '/seed ' num2str(seed)],'chrom','bestVal','imSecEx','trueMessage','stego');
end
end