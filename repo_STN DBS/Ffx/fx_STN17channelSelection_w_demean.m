function [chanStat,dat,cq] = fx_STN17channelSelection_w_demean(dat,trlFrame,stype)
%[chan,chanKeep,E,F,R,P] = fx_channelSelection(spk, idxTrial, aoTrl,subject)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% function takes the ao data, cuts it to the trial period and selects which
% channel will be propagated along the processing pipeline
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
note = ' ';
%for s = 1:size(rspk,2)
%    for b = 1:size(rspk(s).raw,1)
% define data
% spk   :: sligtly filtered (from ao) spike data
% raw   :: raw micro data from AO
% aoTrl :: trigger marks from ao data
% lfp   :: lfp data
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%        if ~isempty(rspk(s).raw{b,1})
% data parameters `````````````````````````````````````````````````````````
cn = fieldnames(dat); %raw  data from ao
CN = cn.';

% use first column of trlFrame end to mark begining of trials on cut signal
for q = 1:size(cn,1)
    % sort fieldnames by channel info
    cno{q} = str2num(cn{q}(:,end-1:end));
    
    for p = 1:size(trlFrame,1)
        T = trlFrame(p,1);
        F = trlFrame(p,end);
        
        if isnan(F)
            F = trlFrame(p,end-1);
            if isnan(F)
                F = trlFrame(p,end-2);
                if isnan(F)
                    F = trlFrame(p,end-3);
                    if isnan(F)
                        F = trlFrame(p,end-4);
                    end % 4 nan pad
                end % 3 nan pad
            end % 2 nan pad
        end % 1 nan pad
        
        % store first and last TrlFrame to cut signal
        if p == 1
            Ti = T;
        end
        Tf = F;
    end %'p'
    %Ti = T; % temp assign to see if cutting improves... JLb
    
    % here, Tf should never be greater then the size of the signal...
    if Tf > size(dat.(cn{q}),2)
        %fyi = nan;
        note = [note,'marked end of trial is greater than size of trial']
        cq.(cn{q}) = dat.(cn{q})(Ti:end);
    elseif Tf < size(dat.(cn{q}),2)
        cq.(cn{q}) = dat.(cn{q})(Ti:Tf);
    end
    if Ti > size(dat.(cn{q}),2)
        %         disp('uncut channel filtering, trl time is all wrong')
        note = [note,'marked beginning of trial is greater than size of trial'];
        disp(note)
        cq.(cn{q}) = dat.(cn{q})(1:end);
    end
end % q
% put channels in order
[csort, I] = sort(cell2mat(cno),'ascend');
chanI = CN(I);

% calculate variability across channels
for j = 1:size(chanI,2)
    
    %disp(s);disp(b);disp(j);
    %s=1;b=2;j=1;
    ch{1,j} = (chanI{1,j});
    
    chdat = cq.(chanI{1,j});
    if isempty(chdat)
        continue %ie straitum channel stn09
    end % fi empty channel data
    %chdat = dat.(chanI{1,j});
    
 % filter - - - - - - - - - - - - - - - - - - -
    if strcmp(stype, 'MU')
        fsig = fx_muaFilter(chdat);
    elseif strcmp(stype, 'LFP')
        fsig = fx_lfpFilter(chdat);
        %notchFilter = 60Hz;
    elseif strcmp(stype, 'SU')
        fsig = fx_suaFilter(chdat);
    end % fi filter type
    
    
    % variability - - - - - - - - - - - - - - - - - - -
    v(1,j) = var(double(fsig));
    %     k(1,j)=kurtosis(double(chdat));
    %     m(1,j)=mean(double(chdat));
    %     d(1,j)=median(double(chdat));
    %     s(1,j)=std(double(chdat));
    
    varQ(:,j)  = {v(1,j);(chanI{1,j})};
end %j

% how many channels
chanQ = size(cn,1);
ch = varQ(2,:);
% unilateral - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% has been recommended to just remove 04 05 09 10 || calculated lowest two variance per hem
% top two highest variance stays. the known noise channels
% should atomatically have lower variance ie infomation theory
if chanQ <= 4 % check number of hemispheres, if only 1 can sort as is
    vs = sort(v,'descend');
    hv = vs(1,1);
    
    h1 = find(hv(1,1) == v);
    %h2 = find(hv(1,2) == v);
    %Vn = mat2cell(v,1,j);
    %cel = {ch ; v};
    % get mean
    
    % define channels to keep
    keepChan = {ch(h1);};%ch(h2)};
    
    % remove channels with low variablity
    rmchn = []; ch = 0;
    for k = 1:size(cn,1)
        if strcmp((chanI{1,k}), keepChan{1,1}) %| strcmp((cn{k}), keepChan{2,1})
            kn = (chanI{1,k});
        else rm = (chanI{1,k});
            ch = ch+1;
            rmchn{ch,1} =  rm;
        end
    end
    datFull = dat; % save full data field uncut for full channel demaning below
    if ~isempty(rmchn)
        dat = rmfield(dat,rmchn);
    else
        %raw(s).chan{b,1} = rspk(s).raw{b,1};
        %chanStat{s,2} = rmchn;
    end % fi empty remove channel
    
    % 1 :: channels to keep
    % 2 :: channels to remove
    % 3 :: variance per channel
    chanStat{1,1} = keepChan;
    chanStat{1,2} = rmchn;
    chanStat{1,3} = varQ;
    chanStat{1,4} = note;
    
    clear keepChan kn
    % bilateral - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
elseif chanQ >= 4 % if number of hemispheres is 2 will need to select 2 chan per hem
    qhem = ceil(chanQ/2); % split the channels into hemispheres
    hemn = 3; % if first hem is ant cnt pst 1:3
    % 1 hemisphere
    vs1 = sort(v(1,1:hemn),'descend');
    hv1 = vs1(1,1:2); % take top two sorted variability
    h1a = find(hv1(1,1) == v);
    %h1b = find(hv1(1,2) == v);
    %Vn = mat2cell(v,1,j);
    %cel = {cn ; v};
    h1cn = {ch(1:hemn) ; v(1:hemn)};
    % 2 hemisphere
    vs2 = sort(v(1,hemn+1:end),'descend');
    hv2 = vs2(1,1); % take top two sorted variability
    h2a = find(hv2(1,1) == v);
    %h2b = find(hv2(1,2) == v);
    
    %Vn = mat2cell(v,1,j);
    %cel = {cn ; v};
    h2cn = {ch(hemn+1:end) ; v(hemn+1:end)};
    
    % define channels to keep
    %keepChan = {ch(h1a);ch(h1b);ch(h2a);ch(h2b)};
    keepChan = {ch(h1a);ch(h2a)};
    
    
    % remove channels with low variablity
    rmchn = []; ch = 0; Lh = []; Rh = [];
    for k = 1:size(cn,1)
        if strcmp((chanI{1,k}), keepChan{1,1}) | strcmp((chanI{1,k}), keepChan{2,1})
            %| strcmp((cn{k}), keepChan{3,1})
            %| strcmp((cn{k}), keepChan{4,1})
            if isempty(Lh)
                Lh = 1;
                knL = (chanI{1,k});
            elseif isempty(Rh)
                Rh = 1;
                knR = (chanI{1,k});
            end % fi hem keep chan
        else rm = (chanI{1,k});
            ch = ch+1;
            rmchn{ch,1} =  rm;
        end % fi
    end %'k'
    
    datFull = dat; % save full data field uncut for full channel demaning below
    % 1 :: channels to keep
    % 2 :: channels to remove
    % 3 :: variance per channel
    chanStat{1,1} = keepChan;
    chanStat{1,2} = rmchn;
    chanStat{1,3} = {h1cn;h2cn};
    chanStat{1,4} = note;
    dat = rmfield(dat,rmchn);
    

    
    clear keepChan knL knR
    clear keepChan knL knR
    
end % fi chanQ, hem check


end

