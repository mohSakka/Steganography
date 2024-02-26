function [messReq,chromReq,status]=DetermineRequiredNumberOfPixels(messageLength,chromLength,...
    numOfUsedBits,coverLength)

% messReq : number of required pixels to embed the message
% chromReq : number of required pixels to embed the chromosome

if numOfUsedBits==0
    status=false;
    messReq=inf;
    chromReq=inf;
    return;
end

% Determine the required number of pixels to embed the message
while mod(messageLength,numOfUsedBits)~=0
    messageLength=messageLength+1;
end
messReq=messageLength/numOfUsedBits;    % Required number of pixels to embed the message

% Determine the required number of pixels to embed the chromosome bits
chromReq=chromLength;

if (messReq+chromReq)<=coverLength
    status=true;
else
    status=false;
end

end