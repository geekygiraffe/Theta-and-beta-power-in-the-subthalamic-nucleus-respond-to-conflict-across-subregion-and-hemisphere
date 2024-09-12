function [ampFlt,ampLenFlt] = fx_AmpFiltLenFilt(filtsig)
% figure; hold on
% subplot(2,1,1)
%  plot(filtsig{1, 1}','DisplayName','filtsig{1, 1}')

% thresholds trials 5SD
% mnsig = mean(filtsig{1,1},2,'omitnan');
% sdsig = std(mnsig);
% minsig = min(min(filtsig{1,1}));
% maxsig = max(max(filtsig{1,1}));
% sd5 = (mean(mnsig)+sdsig*5);
% sd3 = (mean(mnsig)+sdsig*3);
% sd8 = (mean(mnsig)+sdsig*8);
% sd36 = (mean(mnsig)+sdsig*36);

st = 0;


% for i = 1:size(filtsig{1,1},1)
% 
%     if mnsig(i,1)<= (mean(mnsig)+sdsig*5)%500 
%         st = st+1;
%         sigTrl{1,1}(st,:) = filtsig{1,1}(i,:);
%     end  %fi
% end % i

sigTrl = filtsig{1,1};

%Amplitude Threshold +/- 4 SD
ampMN = (mean(sigTrl,2,'omitnan'));
ampSD = std(ampMN,'omitnan');
ampRM = zeros(size(sigTrl,1),1);
st = 0;

for A = 1:size(sigTrl,1)
    % keep if amp less than mean(+4 SD) || greater thean mean(-4SD)
    if ampMN(A,1) <= (mean(ampMN)+ampSD*4) || ampMN(A,1) >= (mean(ampMN)-ampSD*4) % keep
        ampRM(A,1) = 0;
        st = st+1;
        sigTrlAmp(st,:) = sigTrl(A,:); 
    elseif ampMN(A,1) >= (mean(ampMN)+ampSD*4) || ampMN(A,1)<= (mean(ampMN)-ampSD*4) %remove
        % remove if amp greater than mean(+4 SD) || less thean mean(-4SD)
        ampRM(A,1) = 1;
    else
        disp('mean amp conditional fail')
        disp(num2str(A))
        pause
    end % fi filter
end % A

% remove amplitude outliers
ridx = [];
ridx = find(ampRM);
if ~isempty(ridx)
    clear rmx
    rmx =sort(ridx,'descend');
    for  r = 1:size(rmx,1)
        %if rmx(r) <= size(rt,1)
        sigFltAmp(rmx(r)) = [];
        %else
        %end
    end
else
    sigFltAmp = sigTrlAmp;
end

% thresholds length (RT) trials 4SD
for i = 1:size(sigFltAmp,1)
    x = sigFltAmp(i,:);
    siglen(i,:) = length(x(~isnan(x)));
end

lenMN = mean(siglen,2,'omitnan');
lenSD = std(siglen,'omitnan');
lenRM = zeros(size(sigFltAmp,1),1);
st = 0;
for L = 1:size(sigFltAmp,1)
    % keep if len less than mean(+4 SD) || greater thean mean(-4SD)
    if lenMN(L,1) <= (mean(lenMN)+lenSD*4) || lenMN(L,1) >= (mean(lenMN)-lenSD*4) % keep
        lenRM(L,1) = 0;
        st = st+1;
        sigTrlLen(st,:) = sigFltAmp(L,:); 
    elseif lenMN(L,1) >= (mean(lenMN)+lenSD*4) || lenMN(L,1)<= (mean(lenMN)-lenSD*4) %remove
        % remove if len greater than mean(+4 SD) || less thean mean(-4SD)
        lenRM(L,1) = 1;
    else
        disp('mean len conditional fail')
        disp(num2str(L))
        pause
    end % fi filter
end % L

% remove length outliers
ridx = [];
ridx = find(lenRM);
if ~isempty(ridx)
    clear rmx
    rmx =sort(ridx,'descend');
    for  r = 1:size(rmx,1)
        %if rmx(r) <= size(rt,1)
        sigFltLen(rmx(r)) = [];
        %else
        %end
    end
else
    sigFltLen = sigTrlLen;
end                           
    
% convert back to cell
ampFlt = {sigFltAmp};
ampLenFlt = {sigFltLen};