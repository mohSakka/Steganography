function trueMessage=ConvertToTrueMessage(orgMessage,sbPole,sbDir)


if sbPole==0 && sbDir==0
    trueMessage=orgMessage;
elseif sbPole==0 && sbDir==1
    trueMessage=wrev(orgMessage);
elseif sbPole==1 && sbDir==0
    trueMessage=orgMessage;
    for i=1:length(orgMessage)
        if orgMessage(i)=='0'
            trueMessage(i)='1';
        else
            trueMessage(i)='0';
        end
    end
elseif sbPole==1 && sbDir==1
    trueMessage=orgMessage;
    for i=1:length(orgMessage)
        if orgMessage(i)=='0'
            trueMessage(i)='1';
        else
            trueMessage(i)='0';
        end
    end
    trueMessage=wrev(trueMessage);
    
end

end