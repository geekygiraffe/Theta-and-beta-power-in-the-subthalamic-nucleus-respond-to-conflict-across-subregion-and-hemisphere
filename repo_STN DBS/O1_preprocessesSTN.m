%[ Preporcessing routine for raw stn data                                ]%
% first run: C:\Users\HCN_user1\Box\Dept-Neurosurgery_NRGlab\Github\hcn_toolbox\basic

% script stores all subjects trials (rspk) as well as condition based assignments
% (ltd|rtd) 1 channel per hemisphere is selected in channel selection
% run spikeprocessing next:
% dependent fucntions:
%    fx_channelSelectionPP;fx_trlAligned;fx_bslAligned;fx_baselineAssignment;fx_rmvEmptyStruct

%citations:
%Zavala, Zaghloul (2018). Brain
%Cognitive control involves theta power within trials and
%beta power across trials in the prefrontal-subthalamic network.

%Stark, Abeles (2007). The Journal of Neuroscience
%Predicting Movement from Multiunit Activity
tic
% @JMcD 
% NOTES :: @!- @!- @!- @!- @!- @!- @!- @!- @!- @!- @!- @!- @!- @!- @!- @!- 

%[------------------------------------------------------------------------]%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cd % code directory
% addpath './Ffx';% function directry'./fx';

% root 
% dir = 
% dFld = 
% out = 

% output = fullfile(root,dir,out,'xxx');

% if ~exist(output, 'dir')
%     mkdir(output)
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
dpath = ls(fullfile(root,dir, dFld));
m = 0; % subject reset counter to offset blanks
% subject loop % s % s % s % s % s % s % s % s % s % s % s % s % s % s % s
for s = 1:size(dpath,1) % outer subject loop
    clear idxTrial idxMLi idxMLf
    
    
    if contains(dpath(s,:), '!XXYYYY ');     m = m+1; continue; end
    if contains(dpath(s,:), '.');            m = m+1; continue; end
    if contains(dpath(s,:), '..');           m = m+1; continue; end
    if contains(dpath(s,:), 'zzz_');         m = m+1; continue; end
       
    % find blank spaced and reset subject name
    for x = 1:size(dpath(s,:),2)
        if dpath(s,x) == ' '
            y(x) = x; end
    end % x
    
    % 'format' subject name string - - - - - - - - - - - - - - - - - -
    z = find(y); % first zero index of subject str array
    subject = (dpath(s,1:z(1,1)-1))
    t = s - m; % true subject counter
    x = []; y = []; z = []; % ~ ~ ~ ~ ~ ~ ~ ~
    
    path = fullfile(root, dir,dFld, subject); blkfld = ls(path);
    % insert counter to reset block number
    n = 0; r = [];% ~ ~ ~ ~ ~ ~ ~
    
    % prblem subjects 
    %if strcmp(subject,'100003') == 1; continue; end
    if strcmp(subject,'100004') == 1; continue; end 
    if strcmp(subject,'100005') == 1; continue; end 
    if strcmp(subject,'100006') == 1; continue; end 
    
    % block loop % b % b % b % b % b % b % b % b % b % b % b % b % b % b % 
    for b = 1:size(blkfld,1) % outer block loop
        if contains(blkfld(b,:), '!Block#');n = n+1; continue; end
        if contains(blkfld(b,:), '.');      n = n+1; continue; end
        if contains(blkfld(b,:), '..');     n = n+1; continue; end
        if contains(blkfld(b,:), '_');      n = n+1; continue; end
        if contains(blkfld(b,:), 'and');    n = n+1; continue; end
        if contains(blkfld(b,:), 'zzz_');   n = n+1; continue; end
        
        % short channels
         if strcmp(subject,'100009') == 1 && b == 3 continue; end 
         %100011; striatum block
        if strcmp(subject,'100011') == 1 && b == 3 continue; end 
        % striatum block&& b == 3
        if strcmp(subject,'100007_b') == 1 && b == 3 continue; end 
        % subject 100003 needed to have blocks 1 and 2 merged, generated a
        % psuedo block 3 folder for the single block of merged data. 
%          if strcmp(subject,'100003') == 1 && b == 3;  n = n+1; continue; end         
%          if strcmp(subject,'100003') == 1 && b == 4;  n = n+1; continue; end 
        % stim blocks
%         if strcmp(subject,'100006') == 1 && b == 4 continue; end %
        
% 'format' block folder string - - - - - - - - - - - - - - - - - -
        for x = 1:size(blkfld(b,:),2)
            if blkfld(b,x) == ' '
                y(x) = x;
                z = find(y); % first zero index of subject str array
                block = (blkfld(b,1:z(1,1)-1));
            elseif ~contains(blkfld(b,:), ' ')
                block =blkfld(b,:);
            end % fi
        end % x
        
        % reset block count to account for nonblocks included in loop,
        % impletment below in stored output
        r = b - n;% true block counter
        x = []; y = []; z = []; % ~ ~ ~ ~ ~ ~ ~ ~
        
        ffile = ls([fullfile(path, block), '\*.mat']);
        
        % file loop % f % f % f % f % f % f % f % f % f % f % f % f % f % f
        for f = 1:size(ffile,1) % file loop
            file = ffile(f,:);
            
            % channel loop % c % c % c % c % c % c % c % c % c % c % c % c % c % c % c
            fload = (fullfile(root,dir,dFld,subject,block,file));
            load(fload);
            
             %% PARAMATERS ````````````````````````````````````````````````
             doplot = 0;
             dosave = 0;
             fs = 44000;
             % ````````````````````````````````````````````````````````````
            % define channel data - - - - - - - - - - - - - - - - - - - - -
            % raw signal - - - - - - - - - - - - - - - - - - - - - - - - - 
            % need to use raw signal due to internal filtering embedded in
            % spk signal... if script runs *too fast* or data is not
            % contained within the signal, or channels are missing, check
            % that the channel names are listed if not add as a new elseif
            % index (elseif exist('...' ) == 1; raw.ant01 = ...;)
            
            % SPK signal - - - - - - - - - - - - - - - - - - - - - - - - - 
            % do not use this for single or multi unit processing, contains
            % AO inline processing that obscures the data see: Quiroga 2009
            % the hardware filtering can result in a phase lag effect. 
            % Macro LFP signal - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            % is most likely not useful

            T = whos;
            % find the objects with the type 'ClassName' from the workspace:
            matches= strcmp({T.class}, 'int16');
            intVar = {T(matches).name};
            [sigraw,tmp,out] = fx_rawchselection(intVar,T);
        
            for c = 1:size(sigraw,1)
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'01')
                    raw.ant01 = eval(sigraw{c,1});end % 01_ant
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'02')
                    raw.cnt02 = eval(sigraw{c,1}); end % 02_cnt
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'03')
                    raw.pst03 = eval(sigraw{c,1}); end % 03_pst
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'04')
                    raw.med04 = eval(sigraw{c,1}); 
                end % 04_med
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'05')
                    raw.lat05 = eval(sigraw{c,1}); 
                end % 05_lat
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'06')
                    raw.ant06 = eval(sigraw{c,1});end % 06_ant
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'07')
                    raw.cnt07 = eval(sigraw{c,1}); end % 07_cnt
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'08')
                    raw.pst08 = eval(sigraw{c,1}); 
                end % 08_pst
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'09')
                    %raw.med09 = eval(sigraw{c,1}); 
                end % 09_med
                
                if exist(sigraw{c,1}) == 1 ...
                        && contains(sigraw{c,1},'10')
                    %raw.lat10 = eval(sigraw{c,1}); 
                end % 10_lat
            end % 'c'
            
%  specific channel handeling
             if strcmp(subject,'100009') == 1 && b==5; 
                 raw.ant01 = 0;%raw.pst03; % striatum channel
             end 
             if strcmp(subject,'100010_a') == 1 || strcmp(subject,'100010_b') == 1
                 raw = rmfield(raw,'ant06');
                 raw = rmfield(raw,'cnt07');
                 raw = rmfield(raw,'pst08');
             end
             
             if strcmp(subject,'100017') == 1  
                 % bilateral recording from unilateral cport set up
                 raw = rmfield(raw,'ant06');
                 raw = rmfield(raw,'cnt07');
                 raw = rmfield(raw,'pst08');
                 raw.ant06 = raw.med04; 
                 raw.pst08 = raw.lat05;
                 raw = rmfield(raw,'med04');
                 raw = rmfield(raw,'lat05');
              end % fi STN17
            
%% Time & trial alignment - - - - - - - - - - - - - - - - - - - - - - - - - 
% need to minues from frame number to normalize to time begin
    % index start and end of trial in cport to grab time point
    % this is currently hard coded, would be a good idea to label
    % the 'nine' which is now a 4 to TstartIndex and 'eighteen',
    % which is now 5 to TendIndex. denoting the period of data to
    % be grabbed as labeled by the ML indexes.
        % four = cue presentation
        % five = cue off ( response has been made)
        % @25 is end trial 18 is ML end |-->for an additial half second +
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    

TBegin = strcat(sigraw{1,1},'_TimeBegin');
TimeBegin = eval(TBegin) * 44000;
nfactor = TimeBegin; % normilization to reset time begin to time 0
% ~ ~ ~ ~ ~ ~ ~
clear instruction firstTrl Cport
            % instruction slide handleing
            if ismember(8,CPORT__1)
                instruction = find(CPORT__1(2,:) == 8);
                if size(instruction,2) > 1
                    %remove inital block that needed to be restarted
                    Cport = CPORT__1; clear CPORT__1
                    CPORT__1 = Cport(:,instruction(1,2):end);
                 
                elseif size(instruction,2) == 1
                      
                end
                % finds first indicator of ML start (9)
            else ~ismember(8,CPORT__1); % no instruction slide... 
%               
            end % fi instuction slide skipping
            
cport = CPORT__1;
%                 %  skip first trial here by grabbing the second 18,
%                 % baseline should then line up correctly...due to no baseline
%                 % for first trial.

            % minus time begin frame from all frame identifyers
            normTimeFrame = ones(length(cport),1).* nfactor;
            resetFrame = cport(1,:)';
            cport(3,:) = [resetFrame - normTimeFrame]';
            
            % divide frame value by fs to convert to time
            cport(5,:) = cport(1,:)./44000;
            
            % row1: frame value, row2: ML code, row3: time row
            % 4:normallized time
            cport(4,:) = cport(3,:)./44000;
            
            % generate a time vector with an absolute zero time
            tzero = cport(4,1);
            tones = ones(length(cport),1).* tzero;
            resetTime = cport(4,:)';
            tvect = [resetTime - tones]';
            cport(6,:) = tvect;
     
TstartIndex = find(cport(2,:) == 9);
TendIndex = find(cport(2,:) == 18);
numTrl = size(TstartIndex,2);

% bug test to eliminate trials that dont contain trial info
% (subject STN09 B3)
Q = 0;clear q marq
for q = 2:length(TstartIndex)
     if q > length(TstartIndex) && Q >= 1
         continue % due to deletion, size changes mid loop
     end
    % temp trial array
    trltrg = cport(2,TstartIndex(1,q-1):TstartIndex(1,q));
% logical check, true if does contain a '18' or trial end
    trueTrial = ~ismember(trltrg,18);
% qualifier if no '18' within trial markers mark as empty
    if all(trueTrial)
        Q = Q+1;
        marq(Q,1) = q;
        TstartIndex(:,q) = [];
    end
    clear trltrg truetrial
end
clear q 

            % build in qualifier if first 18 cue happens before a trial
            % start... (recording error) - this might indicate files need
            % to be merged in 'shell_run_basic.m'
            if TstartIndex(1,1) < TendIndex(1,1) && size(TstartIndex,2) == size(TendIndex,2) 
             
            elseif  TstartIndex(1,1) > TendIndex(1,1)
                TendIndex(:,1) = [];
            end
            if size(TstartIndex,2) ~= size(TendIndex,2)
                
                disp('trial mismatch')

            end % ensure that first inidcator is a trial start
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% trial and baseline organization -
    % intertrial interval from end trial to begin trial for baseline period
    % so grab from (row, colTwo : (row+1,colOne)
    %CPORT
    %  col 1 :: ao data
    %  col 2 :: index of start (end of previous trial)
    %  col 3 :: index of finish (begining of trial)
    %  col 4 :: AO data with normalized frames and times
    %  col 5 :: indices
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -            
            idxTrial(:,1) = TstartIndex;
            idxTrial(:,2) = TendIndex;
% trials, skip first
            % row1: ML cues row2: normalized frame numbers row3: normalized time
            for a = 2:size(idxTrial,1)
                
                % use trial index start to finish to grab cport cue codes and frame number
                if ~isnan(idxTrial(a,1)) && ~isnan(idxTrial(a,2))
                    %
                    aoTrl{a,1} = [cport(2,idxTrial(a,1):idxTrial(a,2));cport(3,idxTrial(a,1):idxTrial(a,2))];
                    
                    % convert the cport frame number
                    aoTrl{a,2} = cport(3,idxTrial(a,1))/44000; % start
                    aoTrl{a,3} = cport(3,idxTrial(a,2))/44000; % finish
                    
                    % convert frame number to time
                    aoTrl{a,1}(3,:) = (aoTrl{a,1}(2,:)/44000);
                    aoTrl{a,1}(4,:) = [cport(6,idxTrial(a,1):idxTrial(a,2))];%;cport(6,idxTrial(a,1):idxTrial(a,2))];
                    
                    % nan pad trials without equal cue indicators
                    % @edit for vector size 10 (31 cue was added) B
                    % cut again to eliminate some response time adding a nanpad
                    % added again when increasing time
                    % var :: if error check here for bug % ! % ! % ! % ! % ! %!
                    padNum = 12; %5
                    nt = 0;
                    if size(aoTrl{a,1},2) == padNum
                        
                    elseif size(aoTrl{a,1},2) < padNum
                        A = size(aoTrl{a,1},2);
                        A2 = size(aoTrl{a,1},1);
                        B = padNum - A; d = nan(A2,B);
                        aoTrl{a,1} = [aoTrl{a,1},d];
                    elseif size(aoTrl{a,1},2) > padNum
                        %nt = nt +1;
                        bugx(a,1) = a;
                        
                    end % fi pad
                end % fi qualifier, nan index (should be last)
            end % 'a' - - - - - - - -  - - - - - - - - - - - - - - - - -
            clear a
            
% baseline            
            for a = 1:size(idxTrial,1)
                
                % use trial index start to finish to grab cport cue codes and frame number
                if ~isnan(idxTrial(a,1)) && ~isnan(idxTrial(a,2))
                    
                    if a == size(idxTrial,1)
                        continue % cant calculate beyond last index
                    else
                        % go 18:9 for baseline period (nine of next trial)
                        aoBsl{a,1} = [cport(2,idxTrial(a,2):idxTrial(a+1,1));
                            cport(3,idxTrial(a,2):idxTrial(a+1,1));...
                            cport(4,idxTrial(a,2):idxTrial(a+1,1));...
                            cport(5,idxTrial(a,2):idxTrial(a+1,1));...
                            cport(6,idxTrial(a,2):idxTrial(a+1,1))];
                        
                        % convert the cport frame number
                        aoBsl{a,2} = cport(3,idxTrial(a,2))/44000; % start baseline (marker 18)
                        aoBsl{a,3} = cport(3,idxTrial(a+1,1))/44000; % finish baseline (next 9 marker)
                    end
                end
            end % a - - - - - - - -  - - - - - - - - - - - - - - - - -
% remove first trial, bug check to make sure baseline and trial align
%figure;plot(cell2mat(aoTrl(:,2)));hold on;plot(cell2mat(aoBsl(:,3)))
aoTrl(1,:)=[];
if strcmp(subject,'100003') == 1 && r == 1
    aoBsl(96:97,:)=[];
end
if strcmp(subject,'100013') == 1 && b==3
    if size(aoBsl,1) > 192
        %aoBsl(192:196,:)=[];
        aoBsl(192:end,:)=[];
    end
    if size(aoTrl,1) > 191
        aoTrl(192:end,:)=[];
    end
end
bsl = cell2mat(aoBsl(1,3));
trl = cell2mat(aoTrl(1,2));
if bsl ~= trl
    disp('basline & trial time do not align')
    pause
end % time alignment qualifier bsl & trl
%% channel selection - - - - - - - - - - - - - - - - - - - - - - - - - - -
%  PP    
% selection should occur prior to pp to use surgical data notes ...
% to determine how many channels would be expected based on hemisphere, %
% should also have some sort of info contained in the signal

% it has been recommended to just remove chan no. 04 05 09 10 
% will instead calculated lowest two variance per hem
% top two highest variance stays
% chanStat c1==>keep chan c2==>remove chan
    % col 1: keep chan
    % col 2 : remove chan
    % col 3: chan variabilty with hemispheres 
        % stacked row 1 == hem 1 row 2 == hem 2 
%- - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - -        
            trlFrame = []; trlTime = []; % ~ ~ ~ ~ ~ ~ ~
            for i = 1:length(aoTrl) 
                if isempty(aoTrl{i,1})
                    % trial removed above due to cue code discrepency
                else
                    tmpfrm = aoTrl{i,1}(2,:);
                    trlFrame = [trlFrame; tmpfrm];
                    tmptme = aoTrl{i,1}(4,:);
                    trlTime = [trlTime; tmptme];
                end % i
            end % fi
            
            for g = 1:size(trlTime,1)
                for h = 1:size(trlTime,2)
                    tare = trlTime(1,1);
                    normTime(g,h) = trlTime(g,h) - tare;
                end % h
            end % g
            ntrltime{t,r,f,:,:} = normTime;
            
% temp store
RAW = raw;
   
if s==4 && r ==3
   % row 1:47 are negative...
    tFrame = trlFrame(47:end);
    clear trlFrame
    trlFrame = tFrame;
end

if s == 17
    [chanStat,raw] = fx_STN17channelSelection_w_demean(raw,trlFrame,'LFP');
    [demean] = fx_Channel_demean(chanStat,RAW);
    % change hemisphere qulaifier to 4 line 111
else
[chanStat,raw] = fx_channelSelection_w_demean(raw,trlFrame,'LFP');
[demean] = fx_Channel_demean(chanStat,RAW);
end

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%% align data 
            % --------------------------------------------------------------------------
            % aligned to trial onset & cue
            % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            % define trial types from AO data && grab normilized times && frame numbers
            %trial number, can use to index into sig index ( index an index?)
            % ltd [1 cong] [3 cong no resp] [4 incg] [6 incg no resp]
            % rtd [2 cong] [3 cong no resp] [5 incg] [6 incg no resp]
            %[ltdAO, ltdTime, rtdAO, rtdTime] = fx_trlAligned(raw, idxTrial, aoTrl);
            [ltdAO, ltdTime, rtdAO, rtdTime] = fx_trlAligned_wcut1trl(raw, idxTrial, aoTrl);
            [AObsl, bslTime] = fx_bslAligned(raw, idxTrial, aoBsl);            
            
            [baseline dmbaseline] = fx_baselineAssignment (AObsl,raw,chanStat,demean);
            %--------------------------------------------------------------------------          
            %% store the signal for group output- - - - - - - - - - - - - - - - - - - - - - - - - - - -
            %(t)-subj (r)-block (f)-file
            ltd(t).no = subject;
            rtd(t).no = subject;
           
            ltd(t).AO{r,f} = ltdAO;
            rtd(t).AO{r,f} = rtdAO;

            ltd(t).nTime{r,f} = ltdTime;
            rtd(t).nTIme{r,f} = rtdTime;            
            
            rspk(t).no = subject;
            rspk(t).chanInfo{r,f} = chanStat;
            rspk(t).raw{r,f} = raw;
           % rspk(t).csig{r,f} = netChan;
            rspk(t).aoBsl{r,f} = AObsl;
            rspk(t).nTime{r,f} = bslTime;
            rspk(t).bsig{r,f} = baseline;
            rspk(t).dsig{r,f} = dmbaseline;
            rspk(t).demeanSig{r,f} = demean;
            
            % store the signal for individual output
            Sbj.file = (strcat("STN_",subject(end-3:end)));
            Sbj.no = subject;
            Sbj.ltdAO{r,f} = ltdAO;
            Sbj.rtdAO{r,f} = rtdAO;
            Sbj.bslAO{r,f} = AObsl;
            Sbj.rspk{r,f} = raw;
            Sbj.chanInfo{r,f} = chanStat;
            Sbj.rspk {r,f}= raw;
            Sbj.chsig {r,f}= demean;
        end % f file loop
        %~ ~ ~ ~ ~ ~ ~ ~ ~ ~ reset outside channel loop
        %clear ltdCong ltdIncg rtdCong ltdIncg
clear -regexp ^CRAW ^CLFP ^CMacro ^CSPK ^SF
clear int16        
clear raw RAW TimeBegin
        clear lcdCong lcdIncg rcdCong rcdIncg
        clear rtdAO ltdAO ltdAOtrl rtdAOtrl rtdAOcue ltdAOcue
        clear cport Cport CPORT__1 idxTrial idxCue idxBase bstart bend
    end % b block loop

% output individidual
idvFile = strcat(subject,'_PP.mat')
save(fullfile(output,idvFile), 'Sbj', '-v7.3');
clear Sbj idvFile
end % s subject loop

% remove empty subject fields
[ltd] = fx_rmvEmptyStruct(ltd);
[rtd] = fx_rmvEmptyStruct(rtd);
[rspk] = fx_rmvEmptyStruct(rspk);

dosave = 1;
% @ !!! @ @ !!! @ @ !!! @ @ !!! @ @ !!! @ @ !!! @ @ !!! @ @ !!! @ @ !!! @
% TO DO: append each subject rather then rerunning & overwriting 
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if ~exist(output, 'dir')
    mkdir(output)
end
disp(output)
if dosave == 1
    save(fullfile(output, 'rspk.mat'), 'rspk', '-v7.3');
    save(fullfile(output, 'ltd.mat'), 'ltd', '-v7.3');
    save(fullfile(output, 'rtd.mat'), 'rtd', '-v7.3');
end % # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

toc % 25 min
