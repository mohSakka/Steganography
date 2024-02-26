function reqBitSeq=ChooseRightSecretSeq(sbPole,sbDir)

global bitSeq combBitSeq reversBitSeq reversCombBitSeq
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