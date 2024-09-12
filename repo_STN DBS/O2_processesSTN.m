%[ processing routine for preprocessed stn data                           ]%
% previously run preprocessSpike -- > 
% next: subjectStrut for all channels all time (for raul)
% manualBlockSorting for select channels and time cut 5:300 ms. 

% 0 >> shell_run_basic.m section 1:3 to convert AO data to matlab 
%0.5 >> data manually moved into C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Data\DBS\spike_processingSimon\STN
% 1 >> preprocessSpike.m to sort and organzize data

% dependent functions:
%fx_cueTime fx_baselineSpikeData fx_trialMatchWbaseline fx_rmvEmptyTrialBracket
%fx_rmvEmptyTrialBracketFullsig fx_conitionAssignment fx_fsignalfpeaks fx_zscoreNorm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cd 
% addpath './Ffx';
% root 
% dir
% dFld
% in 
% fullfile(root,dir,dFld,in)
% input = fullfile(root,dir,dFld,in);
% output = fullfile(input,'LFP');
% 
% if ~exist(output, 'dir')
%     mkdir(output)
% end
tic
% file I/O # - # - # - # - # - # - # - # - # - # - # - # - # - # - # - # -
 % stn  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
load(fullfile(input,'ltd.mat'));
load(fullfile(input,'rtd.mat'));
% baseline and raw data - - - - - - - - - - - - - - - - - - - - - - - - - -
load(fullfile(input,'rspk.mat'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% parameters ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` `
dosave = 1;
doplot = 0 ;
analyzeSingleUnit = 0;
% ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` `
% outer loop through hem & subjects ltd | rtd - - - - - - - - - - - - - - -
% {subject, block, file, trials} 
% [1 cong][2 cong error][2 cong norsp][4 incg][5 error][6 incg no resp]
% CONG - [1 cong] [2 cong error][3 cong noresp] 
% INCG - [1 incg] [2 incg error] [3 incg noresp]
% AOdata: 
%   row 1 markers in data corresponding to ML behavior
%   row 2 frame time
%   row 3 % normalized to fs
%   row 4 time relative to start
%   row 5 time relative to each trial
%   row 6 = trial number
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% match trial number with trial to sync up baseline data - - - - - - - - - -
[ltd,rtd,rspk] = fx_trialMatchWbaseline_demeanedChannel(rspk,ltd,rtd);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%  remove empty then calculate spike rate for baselineing- - - - - - - - - -
% rspk output:
    % column1: left cong    
    % column2: left incg    
    % column3: right cong    
    % column4: right incg    

[ltd] = fx_rmvEmptyTrialBracket_dmean(ltd);
[rtd] = fx_rmvEmptyTrialBracket_dmean(rtd);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%seperate conditions @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
    %[cong][1:3]{correct,error,no response}
    %[incg][4:6]{correct,error,no response}
    onset = 9;
    offset = 18;
[ltd] = fx_conitionAssignment_demeanCH(ltd,rspk,onset,offset);
[rtd] =fx_conitionAssignment_demeanCH(rtd,rspk,onset,offset);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
[ltd] =fx_catcutBaselineTrial(ltd);
[rtd] =fx_catcutBaselineTrial(rtd);
% temp save - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
LTD = ltd;
RTD = rtd;
RSPK = rspk;
% calculate RT from selected trials
[ltd] = fx_trialRTcalc(ltd);
[rtd] = fx_trialRTcalc(rtd);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%function takes preprocessed data organized by hemisphere [ltd|rtd], 
% blocks containtings channels with rows of trials and columns of response types
%[cong|incg|base] --> [ CONG|INCG :: correct error noresp]
% currently hard editted in to get only correct trials ('r')
% performs filtering and clipping of data
[ltd,rspk]= fx_fsignalfpeaks_chOpt(ltd,rspk); 
[rtd,rspk]  = fx_fsignalfpeaks_chOpt(rtd,rspk);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%%
% data reassign & clip to only correct
for s = 1:size(rspk,2)
    % local field potential filtering
    LFP(s).no = rspk(s).no;
    LFP(s).rspk.lfp = rspk(s).lfp;
    %left
    LFP(s).ltd.congRT = ltd(s).congRT;
    LFP(s).ltd.incgRT = ltd(s).incgRT;
    LFP(s).ltd.base = ltd(s).lfpBase;
    LFP(s).ltd.cong = ltd(s).lfpCong;
    LFP(s).ltd.incg = ltd(s).lfpIncg;
    % right
    LFP(s).rtd.congRT = rtd(s).congRT;
    LFP(s).rtd.incgRT = rtd(s).incgRT;
    LFP(s).rtd.base = rtd(s).lfpBase;
    LFP(s).rtd.cong = rtd(s).lfpCong;
    LFP(s).rtd.incg = rtd(s).lfpIncg;
    % baseline + trial
    LFP(s).ltd.congTrl = ltd(s).LFPcongTrl;
    LFP(s).ltd.incgTrl = ltd(s).LFPincgTrl;
    LFP(s).rtd.congTrl = rtd(s).LFPcongTrl;
    LFP(s).rtd.incgTrl = rtd(s).LFPincgTrl;
end % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%%
% baseline normalize muas' - - - - - - - - - - - - - - - - - - - - - - - - 
[zLFP] = fx_zscoreNorm_bsenantrl(LFP);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

disp(output)
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
if ~exist(output, 'dir')
    mkdir(output)
end
disp(output)
if dosave == 1
    save(fullfile(output, 'rspk.mat'), 'rspk', '-v7.3');
    save(fullfile(output, 'ltd.mat'), 'ltd', '-v7.3');
    save(fullfile(output, 'rtd.mat'), 'rtd', '-v7.3');
    save(fullfile(output, 'LFP.mat'), 'LFP', '-v7.3');
    save(fullfile(output, 'zLFP.mat'), 'zLFP', '-v7.3');
    save(fullfile(output, 'MUA.mat'), 'MUA', '-v7.3');
   
end % # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

%% run script, manual sort flip and cat
% % run subjectStruct. m --> struct for raul 
%     % cond.subject.channel z scored not zscored


