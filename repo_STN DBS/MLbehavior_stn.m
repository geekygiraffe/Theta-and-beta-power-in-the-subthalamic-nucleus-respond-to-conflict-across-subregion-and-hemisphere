%% section 0 dictionary
%STN population info
%{
%01 blk[1] [D] hemL
%02 blk[1 2] [D V] hemL
%03 blk[1 2] [D] hemL
%04 blk[1 2] [D V] hemR
%05 = []
%06 blk[1] [D] hemR
%07_a blk[1 3] [D V] hemL
%07_b blk[2] [V] hemR
%08 blk[1 2] [D V] hemB
%09 blk[1 2] [V V] hemB
%10_a blk[1 2] [D V] hemL
%10_b blk[1] [D] hemR
%11 blk[2 3] [D V] hemB
%13 blk [1 2] [D V] hemB
%14 blk [1 2] [D V] hemPsuedo - no ventral right hem block 2 
%16 blk [1 2] [D V] hemB
%17 blk [1 2] [D V] hemB
%18a blk [1 2] [D V] hemL
%18b blk [1 2] [D V] hemR
%}
cd 'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Github\jmNRG\behavioral'
addpath('./functions')
dirPref = 'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Data\DBS';
% dependencies
addpath(genpath('C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Github\SimonTask\Codes'));
addpath(genpath('C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Github\hcn_toolbox\monkeylogic_basic'));
%behavior output
output = 'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Data\DBS\spike_processingSimon\STNoutput\behavior\finalOutput';
%% section 1 organizing data 
% final subject output:  % 02 07 08 09 10b 11 13 14 16 18
subject = [...
%     "100001";...
    "100002";...
%    "100003";...
%     "100006";...
    "100007_a";...
    "100007_b";...
    "100008";...
    "100009";...
%     "100010_a";...
    "100010_b";...
    "100011";...
    "100013";...
    "100014";...
    "100016";...
%     "100017";...
    "100018_a";...
    "100018_b"];
block = [... 
%     1,nan;... % stn01
    1,2;...     % stn02
%    1,2;...    % stn03
%     1,2;...     % stn06
    1,3;...     % stn07a
    2,nan;...   % stn07b
    1,2;...     % stn08
    nan,2;...     % stn09
%     1,2;...     % stn10a
    1,nan;...   % stn10b
    2,3;...     % stn11 
    1,2;...     % stn13
    1,2;...     % stn14
    1,2;...     % stn16
%     1,2;...     % stn17
    1,2;...     % stn18a
    1,2];       % stn18b
hemisphere = [...
%     "left",nan;...    % stn01
    "left",nan;...      % stn02
%    "left",nan;...     % stn03
%     "right",nan;...     % stn06
    "left",nan;....     % stn07a
    "right",nan;....    % stn07b
    "left","right";...  % stn08
    "left","right";...  % stn09
%     "left",nan;...      % stn10a
    "right",nan;...     % stn10b
    "left","right";...  % stn11
    "left","right";...  % stn13
    "left","right";...  % stn14
    "left","right";...  % stn16
%     "left","right";...  % stn17
    "left",nan;...      % stn18a
    "right",nan];       % stn18b
subregion = [...
%     "dorsal",nan;...      % stn01
    "dorsal","ventral";...  % stn02
%    "dorsal","dorsal";...  % stn03
%     "dorsal","ventral";...  % stn06
    "dorsal","ventral";...  % stn07a
    "ventral",nan;...       % stn07b
    "dorsal","ventral";...  % stn08
    nan,"ventral";... % stn09
%     "dorsal","ventral";...  % stn10a
    "ventral",nan;...        % stn10b
    "dorsal","ventral";...  % stn11
    "dorsal","ventral";...  % stn13
    "dorsal","ventral";...  % stn14
    "dorsal","ventral";...  % stn16
%     "dorsal","ventral";...  % stn17
    "dorsal","ventral";...  % stn18a
    "dorsal","ventral"]; % stn18b
%target = ['stn';'stn';'stn';'stn';'stn';'stn';'stn';'stn';'stn';'stn';'stn';'stn']; % repmat("stn",[size(subject,1),1]);
%ver = [13;12;12;12;13;12;13;13;13;13;13;13];% repmat
ver = [...
    %10     % stn01
    13;...  % stn02
    %11;... % stn03
    %12;... % stn06
    12;...  % stn07a
    12;...  % stn07b
    13;...  % stn08
    12;...  % stn09
    %13;... % stn10a
    13;...  % stn10b
    12;...  % stn11
    13;...  % stn13
    13;...  % stn14
    13;...  % stn16
    %13;...  % stn17
    13;...  % stn18a
    13]; % stn18b
Task = ["simonTask";"simonTask";"simonTask";"simonTask";"simonTask";"simonTask";"simonTask";"simonTask";"simonTask";"simonTask";"simonTask";"simonTask"];
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
stn.id = subject;
stn.blk = block;
stn.hem = hemisphere;
stn.subregion = subregion;
stn.ver = ver;
stn.task = Task;
% parameters
neuralFlag = 1;
removeOutlierSubjs = 0;
removeOutlierTrials = 0;
% mapping for figures to plot
subj = stn.id;
doplot = 0;
dosave = 0;
% preallocate output - - - - - - - - - - - - - - - - - - - - - - - - - - -
summ = struct('subjects',{},'outlierPercentages',{},'overallSimonEffect',{},...
    'overallAccuracy',{},'overallCAF',{},'overallConflictControl',{},'onebackError_RT',{},...
    'onebackCAF',{},'onebackConflictControl',{},'leftSimonEffect',{},'leftAccuracy',{},...
    'leftCAF',{},'leftConflictControl',{},'rightSimonEffect',{},'rightAccuracy',{},...
    'rightCAF',{},'rightConflictControl',{},'twobackError_RT',{});

catData = struct;
dorsalBhv = summ;
ventralBhv = summ;

if neuralFlag
    behaveFileDir = 'Neural';
else
    behaveFileDir = 'Behavioral';
end

if ~exist('removeOutlierSubjs','var') | isempty(removeOutlierSubjs)
    removeOutlierSubjs = true;
end
if ~exist('removeOutlierTrials','var') | isempty(removeOutlierTrials)
    removeOutlierTrials = true;
end

% set parameters  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% called withing varCalc function
parameters.bins = 4;
parameters.oneBack_bins = 3;
parameters.LvR_bins = 3;
% defaultFigsToPlot = 0:17;
 parameters.scatter_lev = 0.05;
parameters.perf_thresh= 0.85;
parameters.rtThresh = 3; % in SDs above mean log(RT)

% define early press as per version .mat read in subject array - - - - - -
% earlyPresses based on simon task version behavioral codes
% ver 7 % earlyPresses = [11:17, 19 21:24]; %in mat file
% % STN version = 10 11 12 13
% % GPI version =
% % VIM version =

for j = 1:size(subj,1)
    if strcmp(stn.ver(j,1),'v7') == 1
        earlyPresses = [11:17, 19 21:24]; % ver 7
    elseif strcmp(stn.ver(j,1),'v8') == 1
        earlyPresses = [11:17, 19 21:24]; % ver 8
    elseif strcmp(stn.ver(j,1),'v9') == 1
        earlyPresses = [11:17, 19 21:24]; % ver 9
    elseif strcmp(stn.ver(j,1),'v10') == 1
        earlyPresses = [11:17, 19 21:24]; % ver 10
    elseif strcmp(stn.ver(j,1),'v11') == 1
        earlyPresses = [16 17 5];   % ver 11
    elseif strcmp(stn.ver(j,1),'v12' ) == 1
        earlyPresses = [16 17 5 3]; % ver 12
    elseif strcmp(stn.ver(j,1),'v13' ) == 1
        earlyPresses = [16 17 5 3]; % ver 13
    end
end

% removes trials with early presses
fun1 = @(x) (~ismember(x.BehavioralCodes.CodeNumbers,earlyPresses));

% all correct/incorrect responses (no, no-response trials)
fun2a = @(x) (x.TrialError==0 | x.TrialError==0.2 | ...
    x.TrialError==6 | x.TrialError==6.2);
fun2b = @(x) (x.TrialError==0 | x.TrialError==0.2);

% preallocate
catData = cell(size(subj,1),1);
trials_by_subj = zeros(size(subj,1));

%% subject loop for some initail sorting of data - - - - - - - - - - - - -
% bhvData data sorted into blocks
% cat data all data combined across blocks in subjects
% dorData dorsal blocks only
% venData ventral blocks only
for s = 1:size(subj,1)
    cur_subj = stn.id{s};

    behaveFoldStruct = dir(fullfile(dirPref,cur_subj,'Experiments','SimonTask',behaveFileDir));
    behaveFolds = behaveFoldStruct([behaveFoldStruct.isdir]);
    n = 0; % true block counter
    for b = 1:length(behaveFolds)
        %behaveFolds(b).name
        if contains(behaveFolds(b).name, '!Block#');n = n+1;continue; end
        if contains(behaveFolds(b).name, '.');n = n+1;continue; end
        if contains(behaveFolds(b).name, '..');n = n+1;continue; end
        if contains(behaveFolds(b).name, '_');n = n+1;continue; end
        if contains(behaveFolds(b).name, 'and');n = n+1;continue; end
        if contains(behaveFolds(b).name, 'zzz_');n = n+1;continue; end
%         if cur_subj == "100009" && contains(behaveFolds(b).name, 'Block1'); n = n+1; continue; end % only 10 trials no cong
%         if cur_subj == "100009" && contains(behaveFolds(b).name, 'Block3'); n = n+1; continue; end % right hem only, striatum recording, neurphys not processed
        %true block count
        B = b-n;
        behaveFile = dir([fullfile(behaveFolds(b).folder,behaveFolds(b).name) '\*.bhv2']);
        bcount(s,B) = B;
        
        % seperate blocks
%         behaveBlk(s,B).dir =  dir([fullfile(behaveFolds(b).folder,behaveFolds(b).name) '\*.bhv2']);
%         bata = mlread(fullfile(behaveFile(end).folder,behaveFile(end).name));
%         idx = isnan([bata.ReactionTime]);
%         bata(idx) = [];
%         trials_by_block_subj(s,b) = trials_by_subj(s,b) + length(bata);
%         behaveBlk(s,B).data = bata;
%         noBlk = B;
        
        bhvData{s,B} = mlread(fullfile(behaveFile(end).folder,behaveFile(end).name));
        idx = isnan([bhvData{s,B} .ReactionTime]);
        bhvData{s,B}(idx) = [];
        trials_by_subj(s) = trials_by_subj(s,B) + length(bhvData{s,B});
        %if length(behaveFile)>1
        %error('Too many behavioral files in block folder.'); end
        %disp(b); disp(s); % manual debug to grab the last .behv if more than one
        
        %forcing to grab last .bhv file in block folder, assuming
        % correct file
        Data = mlread(fullfile(behaveFile(end).folder,behaveFile(end).name));
        idx = isnan([Data.ReactionTime]);
        Data(idx) = [];
        %trials_by_subj(s) = trials_by_subj(s) + length(Data);
%         
%         if b==1
%             catData{s} = data;
%             blkData{s} = bata;
%         else
%             %multiple blocks of data catenated along length of behvaData,
%             %can look in first column for trial number
            catData{s} = [catData{s} Data];
            %blkData{s,B} = [bata];%[catData{s} bata];
            %behaveData{s,b} = [behaveData{s} blkData];
            
%         end % fi
        %sort into dorsal and ventral blocks of data
        %(subject) x block by subregion = dorsal or ventral block
        sxb = stn.blk(s,:);
        clear target % ~ ~ ~ ~ ~ ~ ~
        if ~isempty(sxb(1,B))
            target = stn.subregion(s,B);
            if strcmpi(target,'dorsal') ==1 %&& num2str(stn.blk(1,r)) == bnum(s,r)
                dData{s,B} = Data;
                vData{s,B} = NaN;%[];
            elseif strcmpi(target,'ventral') ==1 %&& num2str(stn.blk(1,r)) == bnum(s,r)
                vData{s,B} = Data;
                dData{s,B} = NaN;%[];
            end % fi target
        end % fi empty
        
        % check for outliers
        removeSubjs = false(size(subj{s}));
        if removeOutlierSubjs
            dat = bhvData{s,B};
            dat = dat(arrayfun(fun1,dat));
            good_resp_data = dat(arrayfun(fun2a,dat));
            perf = sum(arrayfun(fun2b,good_resp_data))/trials_by_block_subj(s);
            if perf < perf_thresh
                removeSubjs(s) = true;
            end
            bhvData{s,B} = good_resp_data;
            trials_by_subj(s) = length(good_resp_data);
        end % outlier
        %behaveData(removeSubjs) = [];
        if any(removeSubjs)
            subjs_rem = subj(removeSubjs);
            fprintf(['Removed %d subjects due to behavioral performance below threhsold %.2f. Subjects removed are: \n'],length(subjs_rem),perf_thresh);
            fprintf('%s\n',subjs_rem{:});
        end %rmv sbj
        
        % # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
        subj(removeSubjs) = [];
        summ(s).stnsubj = subj;
        
        % input flag outlier percentage subjects - - - - - - - - - - - - - - - - -
        outlierPercentageBySubj = zeros(size(subj{s}));
        if removeOutlierTrials
            dat = behaveData{s};
            numTrials = length(dat.ReactionTime);
            rt = log10([dat.ReactionTime]);
            mn_rt = mean(rt);
            sd_rt = std(rt);
            z_rt = (rt - mn_rt)/sd_rt;
            not_outlier_rt = z_rt<=rt_thresh;
            dat = dat(not_outlier_rt);
            behaveData{s.B} = dat;
            outlierPercentageBySubj(s,B) = sum(~not_outlier_rt)/numTrials;
        end % fi
        
        % # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
        summ(s).outlierPercentages = outlierPercentageBySubj;
    end %'b'
end  %close initial subj loop
%%
% special handeling and removal of outliers
% combine stn03 half blocks - removed subj stn03
% combo = [dData{3,1},dData{3,2}];
% dData{3,1} = [];dData{3,2} = [];
% bhvData{3,1} = [];bhvData{3,2} = [];
% dData{3,1} = combo;bhvData{3,1} = combo;

dorData = dData;
venData = vData;
netData = bhvData;
% final formating and write out
% [dorData] = fx_rmv(dData);
% [venData] = fx_rmv(vData);
% [netData] = fx_rmv(bhvData);
%% section 2 calculations of variables
% RT, 
%set individiuals do [save, plot]
do = 0;
dosave = 1;
    [dorsal,dor] = fx_varCalc(stn,dorData,parameters,'dorData',do);
    [ventral,ven] = fx_varCalc(stn,venData,parameters,'venData',do);
    [allSTN,net] = fx_varCalc(stn,catData,parameters,'catData',do);
    [bhvxBlk] = fx_varCalc(stn,bhvData,parameters,'blkData',do);
%save net
    if dosave ==1
        %output = 'C:\Users\HCN_user1\Box\Dept-Neurosurgery_NRGlab\Data\DBS\spike_processingSimon\STNoutput\behavior'
        save(fullfile(output,'stnid.mat'),'stn');
        save(fullfile(output,'dorsal.mat'),'dorsal');
        save(fullfile(output,'ventral.mat'),'ventral');
        save(fullfile(output,'allSTN.mat'),'allSTN');
        save(fullfile(output,'bhvxBlk.mat'),'bhvxBlk');
    end   
% variables will be output in table format for neurphys comparisons [dorsal, ventral, allData] 
% navigate to table output folder:
% 'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Github\jmNRG\behavioral\tblOutput'
[dorTbl] = fx_behaviorTable(stn,dorsal,'dorsal');
[venTbl] = fx_behaviorTable(stn,ventral,'ventral');
[netTbl] = fx_behaviorTable(stn,allSTN,'all');
%% section 3 statistics and vizulaization -------------------------------------------
% set statistics definitions
pstr = {'*','**','***'};
pthresh = [0.05, 0.01, 0.001];
numSubjs = size(subject,1);
 % navigate to figure output path
cd 'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Github\jmNRG\behavioral\final'
% Figure 1 $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ 
% Plot _ all subjects binned reaction times - - - - - - - - - - - - - - - -
% RT distribution by subject
%individual subjects binned reation times (equally spaced bins) should
figure
nrows = ceil(numSubjs/4);
for s = 1:numSubjs
    data = catData{s};
    rt = [data.ReactionTime];
    
    subplot(nrows,4,s)
    histogram(rt)
 
    title(['Subject ', subject{s}])
    if rem(s,4)==1
        ylabel('Count')
    end
    if rem(s,4)==2 & (floor(s/4)==nrows | nrows==1)
        xlabel('Binned reaction time (ms)')
    end
end % $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $  $ $ $ $ $ $ $
[dor] = fx_PLToverallReactionTime(dor,'doral-',parameters,1,1);
[ven] = fx_PLToverallReactionTime(ven,'ventral-',parameters,1,1);
[net] = fx_PLToverallReactionTime(net,' ',parameters,1,1);

%plot axis are not consistent across conditions
[dor] = fx_PLTsimoneffect(dor,'dorsal-',parameters,1,1);
[ven] = fx_PLTsimoneffect(ven,'ventral-',parameters,1,1);
[net] = fx_PLTsimoneffect(net,' ',parameters,1);

[dor] = fx_PLTaccuracies(dor,'dorsal-',parameters,1);
[ven] = fx_PLTaccuracies(ven,'ventral-',parameters,1);
[net] = fx_PLTaccuracies(net,' ',parameters,1);
%! getting an additional slope value...
[dor] = fx_PLTdelta(dor,'dorsal-',parameters,1);
[ven] = fx_PLTdelta(ven,'ventral-',parameters,1);
[net] = fx_PLTdelta(net,' ',parameters,1);
%!@ meanRT_LR [cong|incg] had double pop - LR thoughout had too much data
%in rows
[dor] = fx_PLTleftright(dor,'dorsal-',parameters,doplot)
[ven] = fx_PLTleftright(ven,'ventral-',parameters,doplot)
[net] = fx_PLTleftright(net,' ',parameters,doplot)
%!@ too few trials. also a few bugs 
% [dor] = fx_PLToneback(dor,'dorsal-',parameters,doplot)
% [ven] = fx_PLToneback(ven,'ventral-',parameters,doplot)
% [net] = fx_PLToneback(net,' ',parameters,doplot)
