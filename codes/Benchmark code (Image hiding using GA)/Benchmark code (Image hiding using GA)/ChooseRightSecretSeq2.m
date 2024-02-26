function reqBitSeq=ChooseRightSecretSeq(msg1,sbPole,sbDir)

[bitSeq,combBitSeq,reversBitSeq,reversCombBitSeq]=...
ConvertSecretImToBitSeq(msg1);
if sbPole==0 && sbDir==0
    reqBitSeq=bitSeq;
elseif sbPole==1 && sbDir==0
    reqBitSeq=combBitSeq;
elseif sbPole==0 && sbDir==1
    reqBitSeq=reversBitSeq;
elseif sbPole==1 && sbDir==1
    reqBitSeq=reversCombBitSeq;
end

end