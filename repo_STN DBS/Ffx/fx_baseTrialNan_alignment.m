function [data,datcat,bData,tData,fTrl,trlRM] = fx_baseTrialNan_alignment(sig)
% function [data, tcut, bcut] = fx_baseTrialNan_alignment(sig)
% organize, cut to 380, and realign data
trlRM = [];
% preallocate baseline_data matrix
% b_d = zeros(size(sig))
for i = size(sig,1):-1:1 % trials
    %disp(i)
    [idx] = find(isnan(sig(i,:)));
    if   idx(1,1) > 300 %~isempty(idx) &&
        full= sig(i,1:idx(1,1)-1);
        fTrl{i,:} = flip(full);
        trl = sig(i,1:idx(1,1)-1);
        
        if size(trl,2) >= 380
            cut = trl(:,1:380);
            alignT = flip(cut);
            datcat{i,2} = alignT;
            plusbase = 0;
        else
            addpadd = 380- size(trl,2);
            alignT = flip(trl);
            plusbase = 1;
            %will add extra baseline below
        end % fi size trl
        
        if size(idx,2) == 10
            bse = sig(i,idx(1,10)+1:end);
            bse(isnan(bse)) = [];
            datcat{i,1} = bse(end-480:end-101);
        elseif size(idx,2) > 10
            bse = sig(i,idx(1,10)+1:idx(1,11)-1);
            bse(isnan(bse)) = [];
            if size(bse,2) < 380
            bse = []; continue
            elseif size(bse,2) < 480
                minpad = size(bse,2) - 380;
            datcat{i,1} = bse(1:end-minpad);
            else
            datcat{i,1} = bse(end-480:end-101);
            end
        end % conditional for no nan pad at end (the max L trial)
        
        if plusbase == 1 && size(bse,2) >= addpadd
            padT = [alignT,bse(1,1:addpadd)];
            datcat{i,2} = padT;
        else
            datcat{i,2} = alignT;
        end % size base
        
        clear t b addpadd patT plusbase% ~ ~ ~ ~ ~
        
        datcat{i,3} = [datcat{i,1},datcat{i,2}];
        b_d(i,:) = datcat{i,3};
        bData(i,:) =  datcat{i,1};
        tData(i,:) =  datcat{i,2};
        %[bse(121:400),alignT];%(1:280)
        %             tcut(i,:) = alignT(1:368);
        %             bcut(i,:) = bse(end-468:end-102);
        
    else
        bse = [];
        trl = [];
        datcat{i,3} = [];
%         RM = i;
%         trlRM = [trlRM, RM];
%         clear RM;
        %if last trial,first iteration, is needed to be removed will be out
        %of range, first check existence.
        if exist('b_d','var');b_d(i,:) = [];end
        %b_d(i,:) = [];
        %             tcut(i,:) = [];
        %             bcut(i,:) = [];
    end % fi not enough trial data
    
end % i
 if exist('b_d','var')
data = b_d;

 else
    data = nan;
end
