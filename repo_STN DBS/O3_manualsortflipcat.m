%[processing routine for stn data                                       ]%
% manual entry for blocks of data - - - - - - - - - - - - - - - - - - - - -
%STN02 left unilateral  :: 1blk dorsal 2blk ventral - 
%STN03 right unilateral :: combo dorsal blocks - removed
%STN04 no data
%STN07 staged    :: _a left /_b right staged(unilateral) _a 1block 1 dorsal _b striatum _a/_b block 2 ventral
%STN08 bilateral :: 1blk dorsal 2blk ventral
%STN09 bilateral :: blk1 no congruent trls & 3 (do not include) 1blk ventral
%STN10 psuedo staged unilateral :: _a Left Hem block1-dorsal block2-ventral
%                                  _b Right Hem block1-ventral
%STN11 bilateral :: block 1 dorsal block 2 ventral
%STN13 bilateral :: block 1 dorsal block 2 ventral
%STN14 bilateral ::  block 1 dorsal block 2 ventral
%STN16 bilateral :: block 1 dorsal block 2 ventral
%STN17 bilateral :: block 1 dorsal block 2 ventral
%STN18_a staged  :: left 1 blk dorsal (+1 stim) 1 blk ventral (+1stim)
%STN18_b staged  :: right 1 block dorsal (+1 blk stim) 1 blk ventral 
% final data output
%'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Data\DBS\spike_processingSimon\STNoutput\mua\condmat\STNgroup'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cd 
% addpath './Ffx';
% root 
% dir 
% dFld 
% in 
% fullfile(root,dir,dFld,in)
% input 
% output

% if ~exist(output, 'dir')
%     mkdir(output)
% end
tic
% file I/O # - # - # - # - # - # - # - # - # - # - # - # - # - # - # - # -
load(fullfile(input,'LFP.mat'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parameters ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` `
dosave = 1;
sid = {'stn02';'stn03';'stn07_a';'stn07_b';'stn08';'stn09';'stn10_a';'stn10_b';'stn11';'stn13'; 'stn14';'stn16'; 'stn17';'stn18_a';'stn18_b'};
snow = {'100002';'100003';'100007_a';'100007_b';'100008';'100009';'100010_a';'100010_b';'100011';'100013';'100014';'100016';'100017';'100018_a';'100018_b'};
%[incg | cong \ dorsal | ventral] {ipsi|cntr, left response|right response}
%         [1|2 \ 1|2]                {1|2,                1|2}
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% note:
%if toggling between zscored and not be sure to adjust on line 773 for
%correct output folder
%% sort into subregion & conditions
% ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` ` `
% dorsal congruent | incongruent
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% STN02 :: left unilateral 1blk_dorsal
if strcmp(LFP(1).no, '100002')==1 %&&  ~isempty(LFP(1).ltd.congTrl)
    stn02{1,1} = [LFP(1).ltd.congTrl{1,1}]; % blk1 (chn1) Lhem- left rsp = ipsi
    stn02{2,2} = [LFP(1).rtd.congTrl{1,1}]; % blk1 (chn1) Lhem- right rsp = contral
    RT_stn02{1,1} = [LFP(1).ltd.congRT{1,1}];
    RT_stn02{2,2} = [LFP(1).rtd.congRT{1,1}];
else (disp('subjet mismatch')); end
% STN03 :: right unilateral 2blks_dorsal
if strcmp(LFP(2).no, '100003')==1 %&&  ~isempty(LFP(2).ltd.congTrl)
  stn03{2,1} = [LFP(2).ltd.congTrl{1,1};LFP(2).ltd.congTrl{2,1}]; % 2blk (chn2) Rhem- left r = contral
  stn03{1,2} = [LFP(2).rtd.congTrl{1,1};LFP(2).rtd.congTrl{2,1}]; % blk1 (chn2) Rhem- right r = ipsi
   RT_stn03{2,1} = [LFP(2).ltd.congRT{1,1};LFP(2).ltd.congRT{2,1}];    
   RT_stn03{1,2} = [LFP(2).rtd.congRT{1,1};LFP(2).rtd.congRT{2,1}];
else (disp('subjet mismatch'));stn03=[]; end
% STN07_a :: left staged unilateral | blk1_dorsal blk2_ventral chan 3 pst
% - bad channel resolution
if strcmp(LFP(3).no, '100007_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn07_a{1,1} = [LFP(3).ltd.congTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn07_a{2,2} = [LFP(3).rtd.congTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
     RT_stn07_a{1,1} = [LFP(3).ltd.congRT{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
     RT_stn07_a{2,2} = [LFP(3).rtd.congRT{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
%STN07_b :: right staged unilateral blk 1 striatum blk2 - ventral
stn07_b = [];
% STN08 :: bilateral 2 dorsal blks left hem chan 1 right hem chan 5
if strcmp(LFP(5).no, '100008')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn08{1,1} = [LFP(5).ltd.congTrl{1,1}]; % blk1 - Lhem - left r = ipsi
    stn08{2,1} = [LFP(5).ltd.congTrl{1,2}]; % blk1 - Rhem  - left r = contra
    stn08{2,2} = [LFP(5).rtd.congTrl{1,1}]; % blk1 - Lhem - right r = contra
    stn08{1,2} = [LFP(5).rtd.congTrl{1,2}]; % blk1 - Rhem - right r = ipsi
    RT_stn08{1,1} = [LFP(5).ltd.congRT{1,1}];
%     RT_stn08{2,1} = [LFP(5).ltd.congRT{2,1}];
    RT_stn08{2,2} = [LFP(5).rtd.congRT{1,1}];
%     RT_stn08{1,2} = [LFP(5).rtd.congRT{2,1}];
else (disp('subjet mismatch')); end
% STN09 :: bilateral 1 dorsal blk left hem chan 1 rigth hem chan 4
if strcmp(LFP(6).no, '100009')==1 %&&  ~isempty(LFP(6).ltd.congTrl)
    stn09 = [];
else (disp('subjet mismatch')); end
%STN10_a :: Psuedo bilateral (staged) - left hem . blk1_dorsal blk2_ventral
if strcmp(LFP(7).no, '100010_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn10_a{1,1} = [LFP(7).ltd.congTrl{1,1}]; % blk1-Lhem - left r = ipsi
    stn10_a{2,2} = [LFP(7).rtd.congTrl{1,1}]; % blk1 ch -Lhem - right r = contra
    RT_stn10_a{1,1} = [LFP(7).ltd.congRT{1,1}]; 
    RT_stn10_a{2,2} = [LFP(7).rtd.congRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN10_b :: Psuedo bilateral - right hem . blk1_dorsal
% if strcmp(LFP(8).no, '100010_b')==1 %&&  ~isempty(LFP(8).ltd.congTrl)
%     stn10_b{2,1} = [LFP(8).ltd.congTrl{1,1}]; % blk1 -Rhem - left r = contra
%     stn10_b{1,2} = [LFP(8).rtd.congTrl{1,1}]; % blk1 -Rhem - right r = ipsi
%     RT_stn10_b{1,1} = [LFP(8).ltd.congRT{1,1}]; 
%     RT_stn10_b{2,2} = [LFP(8).rtd.congRT{1,1}]; 
% else (disp('subjet mismatch')); end
%STN11 :: bilateral 3 blks. blk2_dorsal left hem chan 1 right hem chan 4
if strcmp(LFP(9).no, '100011')==1 %&&  ~isempty(LFP(9).ltd.congTrl)
    stn11{1,1} = [LFP(9).ltd.congTrl{2,1}]; % blk2 chn1 - left hem - left r = ipsi
    stn11{2,1} = [LFP(9).ltd.congTrl{2,2}]; % blk2 chn4 - right hem - left r = contra
    stn11{2,2} = [LFP(9).rtd.congTrl{2,1}]; % blk2 chn1 - left hem - right r = contra
    stn11{1,2} = [LFP(9).rtd.congTrl{2,2}]; % blk2 chn4 - right hem - right r = ipsi
    RT_stn11{1,1} = [LFP(9).ltd.congRT{2,1}]; 
%     RT_stn11{2,1} = [LFP(9).ltd.congRT{2,1}]; 
    RT_stn11{2,2} = [LFP(9).rtd.congRT{2,1}]; 
%     RT_stn11{1,2} = [LFP(9).rtd.congRT{2,1}];
else (disp('subjet mismatch')); end
%STN13 :: bilateral
if strcmp(LFP(10).no, '100013') ==1 %&&  ~isempty(LFP(10).ltd.congTrl)
    stn13{1,1} = [LFP(10).ltd.congTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn13{2,1} = [LFP(10).ltd.congTrl{1,2}]; % blk1 - right hem - left r = contra
    stn13{2,2} = [LFP(10).rtd.congTrl{1,1}]; % blk1 - left hem - right r = contra
    stn13{1,2} = [LFP(10).rtd.congTrl{1,2}]; % blk1 - right hem - right r = ipsi
    RT_stn13{1,1} = [LFP(10).ltd.congRT{1,1}]; 
    RT_stn13{2,2} = [LFP(10).rtd.congRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN14 :: bilateral
if strcmp(LFP(11).no, '100014') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn14{1,1} = [LFP(11).ltd.congTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn14{2,1} = [LFP(11).ltd.congTrl{1,2}]; % blk1 - right hem - left r = contra
    stn14{2,2} = [LFP(11).rtd.congTrl{1,1}]; % blk1 - left hem - right r = contra
    stn14{1,2} = [LFP(11).rtd.congTrl{1,2}]; % blk1 - right hem - right r = ipsi
    RT_stn14{1,1} = [LFP(11).ltd.congRT{1,1}]; 
    RT_stn14{2,2} = [LFP(11).rtd.congRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN16 :: bilateral
if strcmp(LFP(12).no, '100016') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn16{1,1} = [LFP(12).ltd.congTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn16{2,1} = [LFP(12).ltd.congTrl{1,2}]; % blk1 - right hem - left r = contra
    stn16{2,2} = [LFP(12).rtd.congTrl{1,1}]; % blk1 - left hem - right r = contra
    stn16{1,2} = [LFP(12).rtd.congTrl{1,2}]; % blk1 - right hem - right r = ipsi
    RT_stn16{1,1} = [LFP(12).ltd.congRT{1,1}]; 
    RT_stn16{2,2} = [LFP(12).rtd.congRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN17 :: bilateral
if strcmp(LFP(13).no, '100017') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn17{1,1} = [LFP(13).ltd.congTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn17{2,1} = [LFP(13).ltd.congTrl{1,2}]; % blk1 - right hem - left r = contra
    stn17{2,2} = [LFP(13).rtd.congTrl{1,1}]; % blk1 - left hem - right r = contra
    stn17{1,2} = [LFP(13).rtd.congTrl{1,2}]; % blk1 - right hem - right r = ipsi
    RT_stn17{1,1} = [LFP(13).ltd.congRT{1,1}]; 
    RT_stn17{2,2} = [LFP(13).rtd.congRT{1,1}]; 
else (disp('subjet mismatch')); end
% STN18_a :: left staged unilateral | blk1_dorsal blk2_ventral chan 3 pst
if strcmp(LFP(14).no, '100018_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn18_a{1,1} = [LFP(14).ltd.congTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn18_a{2,2} = [LFP(14).rtd.congTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
     RT_stn18_a{1,1} = [LFP(14).ltd.congRT{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
     RT_stn18_a{2,2} = [LFP(14).rtd.congRT{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
if strcmp(LFP(15).no, '100018_b')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn18_b{1,1} = [LFP(15).ltd.congTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn18_b{2,2} = [LFP(15).rtd.congTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
     RT_stn18_b{1,1} = [LFP(15).ltd.congRT{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
     RT_stn18_b{2,2} = [LFP(15).rtd.congRT{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
STN.dCong = [];STN.ipDcong = [];STN.ctDcong = []; RT.dCong = []; RT.ipDcong = []; RT.ctDcong = [];
dCong = [stn02; stn03; stn07_a; stn07_b; stn08; stn09; stn10_a;  stn11; stn13; stn14; stn16; stn17; stn18_a; stn18_b;];%stn10_b;
ipDcong = {stn02{1,:}; stn03{1,:}; stn07_a{1,:}; stn08{1,:}; stn10_a{1,:}; stn11{1,:}; stn13{1,:}; stn14{1,:}; stn16{1,:}; stn17{1,:};stn18_a{1,:};stn18_b{1,:}};% stn10_b{1,:};
ctDcong = {stn02{2,:}; stn03{2,:}; stn07_a{2,:}; stn08{2,:}; stn10_a{2,:}; stn11{2,:};stn13{2,:}; stn14{2,:}; stn16{2,:}; stn17{2,:};stn18_a{2,:};stn18_b{2,:}};%stn10_b{2,:};
% RTdCong = [RT_stn02; RT_stn03; RT_stn07_a; RT_stn08; RT_stn10_a; RT_stn10_b; RT_stn11];
% RTipDcong = {RT_stn02{1,:}; RT_stn03{1,:}; RT_stn07_a{1,:}; RT_stn08{1,:}; RT_stn10_a{1,:}; RT_stn10_b{1,:}; RT_stn11{1,:}};
% RTctDcong = {RT_stn02{2,:}; RT_stn03{2,:}; RT_stn07_a{2,:}; RT_stn08{2,:}; RT_stn10_a{2,:}; RT_stn10_b{2,:}; RT_stn11{2,:}};

[dcong.STN02] = fx_indvcat(stn02,STN,'dCong');%RT_stn02 RT
dcong.STN02.RT = RT_stn02; 
dcong.STN02.ipRT = RT_stn02{1,1};
dcong.STN02.ctRT = RT_stn02{2,2}; 

[dcong.STN03] = fx_indvcat(stn03,STN,'dCong');%,RT_stn03,RT
dcong.STN03.RT = RT_stn03; 
dcong.STN03.ipRT = RT_stn03{1,1}; 
dcong.STN03.ctRT = RT_stn03{2,2}; 

[dcong.STN07a] = fx_indvcat(stn07_a,STN,'dCong');%,RT_stn07_a,RT
dcong.STN07a.RT = RT_stn07_a; 
dcong.STN07a.ipRT = RT_stn07_a{1,1}; 
dcong.STN07a.ctRT = RT_stn07_a{2,2}; 

%[STN07b] = fx_indvcat(stn07_b,STN);
[dcong.STN08] = fx_indvcat(stn08,STN,'dCong');%,RT_stn08,RT
dcong.STN08.RT = RT_stn08; 
dcong.STN08.ipRT = RT_stn08{1,1}; 
dcong.STN08.ctRT = RT_stn08{2,2}; 

%[dcong.STN09] = fx_indvcat(stn09,STN,'dCong');
[dcong.STN10a] = fx_indvcat(stn10_a,STN,'dCong');%,RT_stn10_a,RT
dcong.STN10a.RT = RT_stn10_a; 
dcong.STN10a.ipRT = RT_stn10_a{1,1}; 
dcong.STN10a.ctRT = RT_stn10_a{2,2}; 

% [dcong.STN10b] = fx_indvcat(stn10_b,STN,'dCong');%,RT_stn10_b,RT
% dcong.STN10b.RT = RT_stn10_b; 
% dcong.STN10b.ipRT = RT_stn10_b{1,1}; 
% dcong.STN10b.ctRT = RT_stn10_b{2,2}; 

[dcong.STN11] = fx_indvcat(stn11,STN,'dCong');%,RT_stn11,RT
dcong.STN11.RT = RT_stn11; 
dcong.STN11.ipRT = RT_stn11{1,1}; 
dcong.STN11.ctRT = RT_stn11{2,1}; 

[dcong.STN13] = fx_indvcat(stn13,STN,'dCong');%,RT_stn13,RT
dcong.STN13.RT = RT_stn13; 
dcong.STN13.ipRT = RT_stn13{1,1}; 
dcong.STN13.ctRT = RT_stn13{2,2}; 

[dcong.STN14] = fx_indvcat(stn14,STN,'dCong');%,RT_stn14,RT
dcong.STN14.RT = RT_stn14; 
dcong.STN14.ipRT = RT_stn14{1,1}; 
dcong.STN14.ctRT = RT_stn14{2,2}; 

[dcong.STN16] = fx_indvcat(stn16,STN,'dCong');
dcong.STN16.RT = RT_stn16; 
dcong.STN16.ipRT = RT_stn16{1,1}; 
dcong.STN16.ctRT = RT_stn16{2,2}; 

[dcong.STN17] = fx_indvcat(stn17,STN,'dCong');
dcong.STN17.RT = RT_stn17; 
dcong.STN17.ipRT = RT_stn17{1,1}; 
dcong.STN17.ctRT = RT_stn17{2,2}; 

[dcong.STN18a] = fx_indvcat(stn18_a,STN,'dCong');
dcong.STN18a.RT = RT_stn18_a; 
dcong.STN18a.ipRT = RT_stn18_a{1,1}; 
dcong.STN18a.ctRT = RT_stn18_a{2,2}; 

[dcong.STN18b] = fx_indvcat(stn18_b,STN,'dCong');
dcong.STN18b.RT = RT_stn18_b; 
dcong.STN18b.ipRT = RT_stn18_b{1,1}; 
dcong.STN18b.ctRT = RT_stn18_b{2,2}; 
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
clear STN stn02 stn03 stn07_a stn07_b stn08 stn09 stn10_a stn10_b stn11 stn13 stn14 stn16 stn17 stn18_a stn18_b
clear RT RT_stn02 RT_stn03 RT_stn07_a RT_stn07_b RT_stn08 RT_stn09 RT_stn10_a RT_stn10_b RT_stn11 RT_stn13 RT_stn14 RT_stn16 RT_stn17 RT_stn18_a RT_stn18_b
% -------------------------------------------------------------------------
% dorsal incg 
% -------------------------------------------------------------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% STN02 :: left unilateral-->2 blocks. blk1_dorsal
if strcmp(LFP(1).no, '100002')==1 %&&  ~isempty(LFP(2).ltd.congTrl)
    stn02{1,1} = [LFP(1).ltd.incgTrl{1,1}]; % blk1 chn1 Lhem- left rsp = ipsi
    stn02{2,2} = [LFP(1).rtd.incgTrl{1,1}]; % blk1 chn1 Lhem- right rsp = contral
    RT_stn02{1,1} = [LFP(1).ltd.incgRT{1,1}];
    RT_stn02{2,2} = [LFP(1).rtd.incgRT{1,1}];
else (disp('subjet mismatch')); end
% STN03 :: right unilateral--> 2 blocks not combined.  2blks_dorsal
if strcmp(LFP(2).no, '100003')==1 %&&  ~isempty(LFP(2).ltd.congTrl)
    stn03{2,1} = [LFP(2).ltd.incgTrl{1,1};LFP(2).ltd.incgTrl{2,1}]; % 2blk chn2 Rhem- left r = contral
    stn03{1,2} = [LFP(2).rtd.incgTrl{1,1};LFP(2).rtd.incgTrl{2,1}]; % blk1 chn2 Rhem- right r = ipsi
     RT_stn03{2,1} = [LFP(2).ltd.incgRT{1,1};LFP(2).ltd.incgRT{2,1}]; 
     RT_stn03{1,2} = [LFP(2).rtd.incgRT{1,1};LFP(2).rtd.incgRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN07_a :: left staged unilateral--> 2 blocks. blk1_dorsal chan 3 pst
% - bad channel resolution
if strcmp(LFP(3).no, '100007_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn07_a{1,1} = [LFP(3).ltd.incgTrl{1,1}]; % blk1 chn3 Lhem- left r = ipsi
    stn07_a{2,2} = [LFP(3).rtd.incgTrl{1,1}]; % blk1 chn3 Lhem- right r = contra
     RT_stn07_a{1,1} = [LFP(3).ltd.incgRT{1,1}]; 
     RT_stn07_a{2,2} = [LFP(3).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN07_b :: right staged unilateral blk1_striatum blk2_ventral
stn07_b = [];
%STN08 :: bilateral--> 2 blocks. blk1_dorsal Lhem chan 1, Rhem chan 5
if strcmp(LFP(5).no, '100008')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn08{1,1} = [LFP(5).ltd.incgTrl{1,1}]; % blk1 chn1 -Lhem - left r = ipsi
    stn08{2,1} = [LFP(5).ltd.incgTrl{1,2}]; % blk1 chn5 - Rhem  - left r = contra
    stn08{2,2} = [LFP(5).rtd.incgTrl{1,1}]; % blk1 chn1 - Lhem - right r = contra
    stn08{1,2} = [LFP(5).rtd.incgTrl{1,2}]; % blk1 chn5 - Rhem - right r = ipsi
    RT_stn08{1,1} = [LFP(5).ltd.incgRT{1,1}]; 
    RT_stn08{2,2} = [LFP(5).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN09 :: bilateral--> 1 block. blk1_dorsal left hem chan 1 rigth hem chan 4
if strcmp(LFP(6).no, '100009')==1 %&&  ~isempty(LFP(6).ltd.congTrl)
stn09 = [];
else (disp('subjet mismatch')); end
%STN10 :: Psuedo bilateral 3 blks. blk1_dorsal blk2_ventral left Hem blk_3
%dorsal right him
if strcmp(LFP(7).no, '100010_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn10_a{1,1} = [LFP(7).ltd.incgTrl{1,1}]; % blk1 ch -Lhem - left r = ipsi
    stn10_a{2,2} = [LFP(7).rtd.incgTrl{1,1}]; % blk1 ch -Lhem - right r = contra
    RT_stn10_a{1,1} = [LFP(7).ltd.incgRT{1,1}]; 
    RT_stn10_a{2,2} = [LFP(7).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN10_b :: Psuedo bilateral - right hem . blk1_ventral
% if strcmp(LFP(8).no, '100010_b')==1 %&&  ~isempty(LFP(8).ltd.congTrl)
%     stn10_b{2,1} = [LFP(8).ltd.incgTrl{1,1}]; % blk1 ch -Rhem - left r = contra
%     stn10_b{1,2} = [LFP(8).rtd.incgTrl{1,1}]; % blk1 ch -Rhem - right r = ipsi
%     RT_stn10_b{2,2} = [LFP(8).ltd.incgRT{1,1}];
%     RT_stn10_b{1,1} = [LFP(8).rtd.incgRT{1,1}]; 
% else (disp('subjet mismatch')); end
%STN11 :: bilateral-->3blocks. blk2_dorsal left hem chan 1 right hem chan 4
if strcmp(LFP(9).no, '100011')==1 %&&  ~isempty(LFP(9).ltd.congTrl)
    stn11{1,1} = [LFP(9).ltd.incgTrl{2,1}]; % blk2 - left hem - left r = ipsi
    stn11{2,1} = [LFP(9).ltd.incgTrl{2,2}]; % blk2 - right hem - left r = contra
    stn11{2,2} = [LFP(9).rtd.incgTrl{2,1}]; % blk2- left hem - right r = contra
    stn11{1,2} = [LFP(9).rtd.incgTrl{2,2}]; % blk2- right hem - right r = ipsi
    RT_stn11{1,1} = [LFP(9).ltd.incgRT{1,1}];
%     RT_stn11{2,1} = [LFP(9).ltd.incgRT{2,1}]; 
%     RT_stn11{2,2} = [LFP(9).rtd.incgRT{2,1}]; 
    RT_stn11{2,2} = [LFP(9).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN13 :: 
if strcmp(LFP(10).no, '100013')==1 %&&  ~isempty(LFP(10).ltd.congTrl)
    stn13{1,1} = [LFP(10).ltd.incgTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn13{2,1} = [LFP(10).ltd.incgTrl{1,2}]; % blk1 - right hem - left r = contra
    stn13{2,2} = [LFP(10).rtd.incgTrl{1,1}]; % blk1 - left hem - right r = contra
    stn13{1,2} = [LFP(10).rtd.incgTrl{1,2}]; % blk1 - right hem - right r = ipsi
    RT_stn13{1,1} = [LFP(10).ltd.incgRT{1,1}];
    RT_stn13{2,2} = [LFP(10).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN14 :: 
if strcmp(LFP(11).no, '100014')==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn14{1,1} = [LFP(11).ltd.incgTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn14{2,1} = [LFP(11).ltd.incgTrl{1,2}]; % blk1 - right hem - left r = contra
    stn14{2,2} = [LFP(11).rtd.incgTrl{1,1}]; % blk1 - left hem - right r = contra
    stn14{1,2} = [LFP(11).rtd.incgTrl{1,2}]; % blk1 - right hem - right r = ipsi
    RT_stn14{1,1} = [LFP(11).ltd.incgRT{1,1}];
    RT_stn14{2,2} = [LFP(11).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN16 :: bilateral--> 2 blocks. blk1_dorsal 
if strcmp(LFP(12).no, '100016')==1 
    stn16{1,1} = [LFP(12).ltd.incgTrl{1,1}]; % blk1 
    stn16{2,1} = [LFP(12).ltd.incgTrl{1,2}]; % blk1 
    stn16{2,2} = [LFP(12).rtd.incgTrl{1,1}]; % blk1 
    stn16{1,2} = [LFP(12).rtd.incgTrl{1,2}]; % blk1 c
    RT_stn16{1,1} = [LFP(12).ltd.incgRT{1,1}]; 
    RT_stn16{2,2} = [LFP(12).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN17 :: bilateral--> 2 blocks. blk1_dorsal 
if strcmp(LFP(13).no, '100017')==1 
    stn17{1,1} = [LFP(13).ltd.incgTrl{1,1}];  
    stn17{2,1} = [LFP(13).ltd.incgTrl{1,2}]; 
    stn17{2,2} = [LFP(13).rtd.incgTrl{1,1}]; 
    stn17{1,2} = [LFP(13).rtd.incgTrl{1,2}]; 
    RT_stn17{1,1} = [LFP(13).ltd.incgRT{1,1}]; 
    RT_stn17{2,2} = [LFP(13).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN18_a :: 
if strcmp(LFP(14).no, '100018_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn18_a{1,1} = [LFP(14).ltd.incgTrl{1,1}]; % blk1 ch -Lhem - left r = ipsi
    stn18_a{2,2} = [LFP(14).rtd.incgTrl{1,1}]; % blk1 ch -Lhem - right r = contra
    RT_stn18_a{1,1} = [LFP(14).ltd.incgRT{1,1}]; 
    RT_stn18_a{2,2} = [LFP(14).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
if strcmp(LFP(15).no, '100018_b')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn18_b{1,1} = [LFP(15).ltd.incgTrl{1,1}]; % blk1 ch -Lhem - left r = ipsi
    stn18_b{2,2} = [LFP(15).rtd.incgTrl{1,1}]; % blk1 ch -Lhem - right r = contra
    RT_stn18_b{1,1} = [LFP(15).ltd.incgRT{1,1}]; 
    RT_stn18_b{2,2} = [LFP(15).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
STN.dIncg = [];STN.ipDincg = [];STN.ctDincg = []; RT.dIncg = []; RT.ipDincg = []; RT.ctDincg = [];
dIncg = [stn02; stn03; stn07_a; stn07_b; stn08; stn10_a; stn11; stn13; stn14; stn16; stn17; stn18_a; stn18_b; ];%stn10_b; 
ipDincg = {stn02{1,:}; stn03{1,:}; stn07_a{1,:}; stn08{1,:}; stn10_a{1,:}; stn11{1,:}; stn13{1,:}; stn14{1,:}; stn16{1,:}; stn17{1,:}; stn18_a{1,:}; stn18_a{1,:}};%stn10_b{1,:}; 
ctDincg = {stn02{2,:}; stn03{2,:}; stn07_a{2,:}; stn08{2,:}; stn10_a{2,:};  stn11{2,:}; stn13{2,:}; stn14{2,:}; stn16{2,:}; stn17{2,:}; stn18_a{2,:}; stn18_a{2,:}};%stn10_b{2,:};

[dincg.STN02] = fx_indvcat(stn02,STN,'dIncg');%,RT_stn02,,RT
dincg.STN02.RT = RT_stn02; 
dincg.STN02.ipRT = RT_stn02{1,1}; 
dincg.STN02.ctRT = RT_stn02{2,2}; 

%[dincg.STN03] = fx_indvcat(stn03,RT_stn03,STN,RT,'dIncg');

[dincg.STN07a] = fx_indvcat(stn07_a,STN,'dIncg');%,RT_stn07_a,RT
dincg.STN07a.RT = RT_stn07_a; 
dincg.STN07a.ipRT = RT_stn07_a{1,1}; 
dincg.STN07a.ctRT = RT_stn07_a{2,2}; 

[dincg.STN08] = fx_indvcat(stn08,STN,'dIncg');%,RT_stn08,RT
dincg.STN08.RT = RT_stn08; 
dincg.STN08.ipRT = RT_stn08{1,1}; 
dincg.STN08.ctRT = RT_stn08{2,2}; 

[dincg.STN10a] = fx_indvcat(stn10_a,STN,'dIncg');%,RT_stn10_a,RT
dincg.STN10a.RT = RT_stn10_a; 
dincg.STN10a.ipRT = RT_stn10_a{1,1}; 
dincg.STN10a.ctRT = RT_stn10_a{2,2}; 

% [dincg.STN10b] = fx_indvcat(stn10_b,STN,'dIncg');%,RT_stn10_b,RT
% dincg.STN10b.RT = RT_stn10_b; 
% dincg.STN10b.ipRT = RT_stn10_b{1,1}; 
% dincg.STN10b.ctRT = RT_stn10_b{2,2}; 

[dincg.STN11] = fx_indvcat(stn11,STN,'dIncg');%,RT_stn11,RT
dincg.STN11.RT = RT_stn11; 
dincg.STN11.ipRT = RT_stn11{1,1}; 
dincg.STN11.ctRT = RT_stn11{2,2}; 

[dincg.STN13] = fx_indvcat(stn13,STN,'dIncg');%,RT_stn13,RT
dincg.STN13.RT = RT_stn13; 
dincg.STN13.ipRT = RT_stn13{1,1}; 
dincg.STN13.ctRT = RT_stn13{2,2}; 

[dincg.STN14] = fx_indvcat(stn14,STN,'dIncg');%,RT_stn14,RT
dincg.STN14.RT = RT_stn14; 
dincg.STN14.ipRT = RT_stn14{1,1}; 
dincg.STN14.ctRT = RT_stn14{2,2}; 

[dincg.STN16] = fx_indvcat(stn16,STN,'dIncg');%,RT_stn08,RT
dincg.STN16.RT = RT_stn16; 
dincg.STN16.ipRT = RT_stn16{1,1}; 
dincg.STN16.ctRT = RT_stn16{2,2}; 

[dincg.STN17] = fx_indvcat(stn17,STN,'dIncg');%,RT_stn08,RT
dincg.STN17.RT = RT_stn17; 
dincg.STN17.ipRT = RT_stn17{1,1}; 
dincg.STN17.ctRT = RT_stn17{2,2}; 

[dincg.STN18a] = fx_indvcat(stn18_a,STN,'dIncg');%,RT_stn10_a,RT
dincg.STN18a.RT = RT_stn18_a; 
dincg.STN18a.ipRT = RT_stn18_a{1,1}; 
dincg.STN18a.ctRT = RT_stn18_a{2,2}; 

[dincg.STN18b] = fx_indvcat(stn18_b,STN,'dIncg');%,RT_stn10_a,RT
dincg.STN18b.RT = RT_stn18_b; 
dincg.STN18b.ipRT = RT_stn18_b{1,1}; 
dincg.STN18b.ctRT = RT_stn18_b{2,2}; 
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
clear STN stn02 stn03 stn07_a stn07_b stn08 stn09 stn10_a stn10_b stn11 stn13 stn14 stn16 stn17 stn18_a stn18_b
clear RT RT_stn02 RT_stn03 RT_stn07_a RT_stn07_b RT_stn08 RT_stn09 RT_stn10_a RT_stn10_b RT_stn11 RT_stn13 RT_stn14 RT_stn16 RT_stn17 RT_stn18_a RT_stn18_b
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% ventral congruent | incongruent
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% STN02 :: left unilateral-->2 blocks. blk2_ventral
if strcmp(LFP(1).no, '100002')==1 %&&  ~isempty(LFP(1).ltd.congTrl)
    stn02{1,1} = [LFP(1).ltd.congTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn02{2,2} = [LFP(1).rtd.congTrl{2,1}]; % blk2 Lhem- right r = contra
    RT_stn02{1,1} = [LFP(1).ltd.congRT{2,1}]; 
    RT_stn02{2,2} = [LFP(1).rtd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
% STN03 :: right unilateral--> 2 blocks not combined. no ventral block
stn03 = [];
% STN07_a :: left staged unilateral--> 2 blocks. blk2_ventral chan 3 pst
% - bad channel resolution
if strcmp(LFP(3).no, '100007_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn07_a{1,1} = [LFP(3).ltd.congTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn07_a{2,2} = [LFP(3).rtd.congTrl{2,1}]; % blk2 Lhem- right r = contra
    RT_stn07_a{1,1} = [LFP(3).ltd.congRT{2,1}];
    RT_stn07_a{2,2} = [LFP(3).rtd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
% STN07_b :: right staged unilateral--> 2 blocks. blk1_striatum blk2_ventral
if strcmp(LFP(4).no, '100007_b')==1 %&&  ~isempty(LFP(4).ltd.congTrl)
    stn07_b{2,1} = [LFP(4).ltd.congTrl{2,1}]; % blk2 chn3 Rhem- left r = contra
    stn07_b{1,2} = [LFP(4).rtd.congTrl{2,1}]; % blk2 chn3 Rhem- right r = ipsi
    RT_stn07_b{2,2} = [LFP(4).ltd.congRT{2,1}]; 
    RT_stn07_b{1,1} = [LFP(4).rtd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN08 :: bilateral--> 2 blocks. blk2_ventral Lhem chan 2, Rhem chan 4
if strcmp(LFP(5).no, '100008')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn08{1,1} = [LFP(5).ltd.congTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn08{2,1} = [LFP(5).ltd.congTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn08{2,2} = [LFP(5).rtd.congTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn08{1,2} = [LFP(5).rtd.congTrl{2,2}]; % blk2 - Rhem - right r = ipsi
    RT_stn08{1,1} = [LFP(5).ltd.congRT{2,1}];
    RT_stn08{2,2} = [LFP(5).rtd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN09 :: bilateral--> 2 block. no dorsal block
if strcmp(LFP(6).no, '100009')==1 %&&  ~isempty(LFP(6).ltd.congTrl)
    stn09{1,1} = [LFP(6).ltd.congTrl{2,1}];%LFP(6).ltd.congTrl{3,1}]; % blk2 Lhem - left r = ipsi
    stn09{2,1} = [LFP(6).ltd.congTrl{2,2}];%LFP(6).ltd.congTrl{3,2}]; % blk2 Rhem  - left r = contra
    stn09{2,2} = [LFP(6).rtd.congTrl{2,1}];%LFP(6).rtd.congTrl{3,1}]; % blk2 Lhem - right r = contra
    stn09{1,2} = [LFP(6).rtd.congTrl{2,2}];%LFP(6).rtd.congTrl{3,2}]; % blk2 Rhem - right r = ipsi
    RT_stn09{1,1} = [LFP(6).ltd.congRT{2,1}];
    %RT_stn09{2,1} = [LFP(6).ltd.congRT{2,2};LFP(6).ltd.congRT{3,2}]; 
    RT_stn09{2,2} = [LFP(6).rtd.congRT{2,1}];
    %RT_stn09{1,2} = [LFP(6).rtd.congRT{2,2};LFP(6).rtd.congRT{3,2}];    
end
%STN10 :: Psuedo bilateral 3 blks. blk1_dorsal blk2_ventral left Hem blk_3
%dorsal right him
if strcmp(LFP(7).no, '100010_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn10_a{1,1} = [LFP(7).ltd.congTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn10_a{2,2} = [LFP(7).rtd.congTrl{2,1}]; % blk2 - Lhem - right r = contra
    RT_stn10_a{1,1} = [LFP(7).ltd.congRT{2,1}];
    RT_stn10_a{2,2} = [LFP(7).rtd.congRT{2,1}];
else (disp('subjet mismatch')); end
%STN10_b :: Psuedo bilateral - right hem . blk1_dorsal
if strcmp(LFP(8).no, '100010_b')==1 %&&  ~isempty(LFP(8).ltd.congTrl)
    stn10_b{2,1} = [LFP(8).ltd.congTrl{1,1}]; % blk1 -Rhem - left r = contra
    stn10_b{1,2} = [LFP(8).rtd.congTrl{1,1}]; % blk1 -Rhem - right r = ipsi
    RT_stn10_b{1,1} = [LFP(8).ltd.congRT{1,1}]; 
    RT_stn10_b{2,2} = [LFP(8).rtd.congRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN11 :: bilateral-->3blocks. blk3_ventral left hem chan 1 right hem chan
%7 (tmp09) may be artificial
if strcmp(LFP(9).no, '100011')==1 %&&  ~isempty(LFP(9).ltd.congTrl)
    stn11{1,1} = [LFP(9).ltd.congTrl{3,1}]; % blk3 - left hem - left r = ipsi
    stn11{2,1} = [LFP(9).ltd.congTrl{3,2}]; % blk3 - right hem - left r = contra
    stn11{2,2} = [LFP(9).rtd.congTrl{3,1}]; % blk3 - left hem - right r = contra
    stn11{1,2} = [LFP(9).rtd.congTrl{3,2}]; % blk3 - right hem - right r = ipsi
    RT_stn11{1,1} = [LFP(9).ltd.congRT{3,1}]; 
    %RT_stn11{2,1} = [LFP(9).ltd.congRT{3,2}]; 
    RT_stn11{2,2} = [LFP(9).rtd.congRT{3,1}]; 
   % RT_stn11{1,2} = [LFP(9).rtd.congRT{3,2}];     
else (disp('subjet mismatch')); end
%STN13 :: bilateral-->
if strcmp(LFP(10).no, '100013')==1 %&&  ~isempty(LFP(10).ltd.congTrl)
    stn13{1,1} = [LFP(10).ltd.congTrl{2,1}]; % blk2 - left hem - left r = ipsi
    stn13{2,1} = [LFP(10).ltd.congTrl{2,2}]; % blk2 - right hem - left r = contra
    stn13{2,2} = [LFP(10).rtd.congTrl{2,1}]; % blk2 - left hem - right r = contra
    stn13{1,2} = [LFP(10).rtd.congTrl{2,2}]; % blk2- right hem - right r = ipsi
    RT_stn13{1,1} = [LFP(10).ltd.congRT{2,1}]; 
    RT_stn13{2,2} = [LFP(10).rtd.congRT{2,1}];     
else (disp('subjet mismatch')); end
%STN14 :: bilateral-->
if strcmp(LFP(11).no, '100014')==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn14{1,1} = [LFP(11).ltd.congTrl{2,1}]; % blk2 - left hem - left r = ipsi
   % stn14{2,1} = [LFP(11).ltd.congTrl{2,2}]; % blk2 - right hem - left r = contra
    stn14{2,2} = [LFP(11).rtd.congTrl{2,1}]; % blk2 - left hem - right r = contra
    %stn14{1,2} = [LFP(11).rtd.congTrl{2,2}]; % blk2- right hem - right r = ipsi
    RT_stn14{1,1} = [LFP(11).ltd.congRT{2,1}]; 
    RT_stn14{2,2} = [LFP(11).rtd.congRT{2,1}];     
else (disp('subjet mismatch')); end
%STN16 :: bilateral-->
if strcmp(LFP(12).no, '100016')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn16{1,1} = [LFP(12).ltd.congTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn16{2,1} = [LFP(12).ltd.congTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn16{2,2} = [LFP(12).rtd.congTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn16{1,2} = [LFP(12).rtd.congTrl{2,2}]; % blk2 - Rhem - right r = ipsi
    RT_stn16{1,1} = [LFP(12).ltd.congRT{2,1}];
    RT_stn16{2,2} = [LFP(12).rtd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN17 :: bilateral-->
if strcmp(LFP(13).no, '100017')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn17{1,1} = [LFP(13).ltd.congTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn17{2,1} = [LFP(13).ltd.congTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn17{2,2} = [LFP(13).rtd.congTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn17{1,2} = [LFP(13).rtd.congTrl{2,2}]; % blk2 - Rhem - right r = ipsi
    RT_stn17{1,1} = [LFP(13).ltd.congRT{2,1}];
    RT_stn17{2,2} = [LFP(13).rtd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
% STN18_a ::
if strcmp(LFP(14).no, '100018_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn18_a{1,1} = [LFP(14).ltd.congTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn18_a{2,2} = [LFP(14).rtd.congTrl{2,1}]; % blk2 Lhem- right r = contra
    RT_stn18_a{1,1} = [LFP(14).ltd.congRT{2,1}];
    RT_stn18_a{2,2} = [LFP(14).rtd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
% STN07_b :: right staged unilateral--> 2 blocks. blk1_striatum blk2_ventral
if strcmp(LFP(15).no, '100018_b')==1 %&&  ~isempty(LFP(4).ltd.congTrl)
    stn18_b{2,1} = [LFP(15).ltd.congTrl{2,1}]; % blk2 chn3 Rhem- left r = contra
    stn18_b{1,2} = [LFP(15).rtd.congTrl{2,1}]; % blk2 chn3 Rhem- right r = ipsi
    RT_stn18_b{2,2} = [LFP(15).ltd.congRT{2,1}]; 
    RT_stn18_b{1,1} = [LFP(15).rtd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
STN.vCong = [];STN.ipVcong = [];STN.ctVcong = [];RT.vCong = [];RT.ipVcong = [];RT.ctVcong = [];
vCong = [stn02;stn03;stn07_a;stn07_b;stn08;stn09;stn10_a;stn10_b;stn11;stn13;stn14;stn16;stn17;stn18_a;stn18_b];
ipVcong = {stn02{1,:}; stn07_a{1,:}; stn07_b{1,:}; stn08{1,:}; stn09{1,:}; stn10_a{1,:}; stn11{1,:}; stn13{1,:}; stn14{1,:}; stn16{1,:}; stn17{1,:}; stn18_a{1,:}; stn18_b{1,:};};
ctVcong = {stn02{2,:}; stn07_a{2,:}; stn07_b{2,:}; stn08{2,:}; stn09{2,:}; stn10_a{2,:}; stn11{2,:}; stn13{2,:}; stn14{2,:}; stn16{2,:}; stn17{2,:}; stn18_a{2,:}; stn18_b{2,:}};

[vcong.STN02] = fx_indvcat(stn02,STN,'vCong');%,RT_stn02,RT
vcong.STN02.RT = RT_stn02; 
vcong.STN02.ipRT = RT_stn02{1,1}; 
vcong.STN02.ctRT = RT_stn02{2,2}; 
[vcong.STN07a] = fx_indvcat(stn07_a,STN,'vCong');%,RT_stn07_a,RT
vcong.STN07a.RT = RT_stn07_a; 
vcong.STN07a.ipRT = RT_stn07_a{1,1}; 
vcong.STN07a.ctRT = RT_stn07_a{2,2};
[vcong.STN07b] = fx_indvcat(stn07_b,STN,'vCong');%,RT_stn07_b,RT
vcong.STN07b.RT = RT_stn07_b; 
vcong.STN07b.ipRT = RT_stn07_b{1,1}; 
vcong.STN07b.ctRT = RT_stn07_b{2,2}; 
[vcong.STN08] = fx_indvcat(stn08,STN,'vCong');%,RT_stn08,RT
vcong.STN08.RT = RT_stn08; 
vcong.STN08.ipRT = RT_stn08{1,1}; 
vcong.STN08.ctRT = RT_stn08{2,2}; 
[vcong.STN09] = fx_indvcat(stn09,STN,'vCong');%,RT_stn09,RT
vcong.STN09.RT = RT_stn09; 
vcong.STN09.ipRT = RT_stn09{1,1}; 
vcong.STN09.ctRT = RT_stn09{2,2}; 
[vcong.STN10a] = fx_indvcat(stn10_a,STN,'vCong');%,RT_stn10_a,RT
vcong.STN10a.RT = RT_stn10_a; 
vcong.STN10a.ipRT = RT_stn10_a{1,1}; 
vcong.STN10a.ctRT = RT_stn10_a{2,2}; 
[vcong.STN10b] = fx_indvcat(stn10_b,STN,'vCong');
vcong.STN10b.RT = RT_stn10_b; 
vcong.STN10b.ipRT = RT_stn10_b{1,1}; 
vcong.STN10b.ctRT = RT_stn10_b{2,2}; 
[vcong.STN11] = fx_indvcat(stn11,STN,'vCong');%,RT_stn11,RT
vcong.STN11.RT = RT_stn11; 
vcong.STN11.ipRT = RT_stn11{1,1}; 
vcong.STN11.ctRT = RT_stn11{2,2}; 
[vcong.STN13] = fx_indvcat(stn13,STN,'vCong');%,RT_stn13,RT
vcong.STN13.RT = RT_stn13; 
vcong.STN13.ipRT = RT_stn13{1,1}; 
vcong.STN13.ctRT = RT_stn13{2,2}; 
[vcong.STN14] = fx_indvcat(stn14,STN,'vCong');%,RT_stn14,RT
vcong.STN14.RT = RT_stn14; 
vcong.STN14.ipRT = RT_stn14{1,1}; 
vcong.STN14.ctRT = RT_stn14{2,2}; 
[vcong.STN16] = fx_indvcat(stn16,STN,'vCong');%,RT_stn08,RT
vcong.STN16.RT = RT_stn16; 
vcong.STN16.ipRT = RT_stn16{1,1}; 
vcong.STN16.ctRT = RT_stn16{2,2}; 
[vcong.STN17] = fx_indvcat(stn17,STN,'vCong');
vcong.STN17.RT = RT_stn17; 
vcong.STN17.ipRT = RT_stn17{1,1}; 
vcong.STN17.ctRT = RT_stn17{2,2}; 
[vcong.STN18a] = fx_indvcat(stn18_a,STN,'vCong');%,RT_stn07_a,RT
vcong.STN18a.RT = RT_stn18_a; 
vcong.STN18a.ipRT = RT_stn18_a{1,1}; 
vcong.STN18a.ctRT = RT_stn18_a{2,2};
[vcong.STN18b] = fx_indvcat(stn18_b,STN,'vCong');%,RT_stn07_b,RT
vcong.STN18b.RT = RT_stn18_b; 
vcong.STN18b.ipRT = RT_stn18_b{1,1}; 
vcong.STN18b.ctRT = RT_stn18_b{2,2}; 
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
clear STN stn02 stn03 stn07_a stn07_b stn08 stn09 stn10_a stn10_b stn11 stn13 stn14 stn16 stn17 stn18_a stn18_b
clear RT RT_stn02 RT_stn03 RT_stn07_a RT_stn07_b RT_stn08 RT_stn09 RT_stn10_a RT_stn10_b RT_stn11 RT_stn13 RT_stn14 RT_stn16 RT_stn17 RT_stn18_a RT_stn18_b
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%--------------------------------------------------------------------------
% ventral incongruent
%--------------------------------------------------------------------------
% STN02 :: left unilateral-->2 blocks. blk2_ventral
if strcmp(LFP(1).no, '100002')==1 %&&  ~isempty(LFP(1).ltd.congTrl)
    stn02{1,1} = [LFP(1).ltd.incgTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn02{2,2} = [LFP(1).rtd.incgTrl{2,1}]; % blk2 Lhem- right r = contra
    RT_stn02{1,1} = [LFP(1).ltd.incgRT{2,1}]; 
    RT_stn02{2,2} = [LFP(1).rtd.incgRT{2,1}];     
else (disp('subjet mismatch')); end
% STN03 :: right unilateral--> 2 blocks not combined. no ventral block
stn03 = [];
% STN07_a :: left staged unilateral--> 2 blocks. blk2_ventral chan 3 pst
% - bad channel resolution
if strcmp(LFP(3).no, '100007_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn07_a{1,1} = [LFP(3).ltd.incgTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn07_a{2,2} = [LFP(3).rtd.incgTrl{2,1}]; % blk2 Lhem- right r = contra
    RT_stn07_a{1,1} = [LFP(3).ltd.incgRT{2,1}]; 
    RT_stn07_a{2,2} = [LFP(3).rtd.incgRT{2,1}];     
else (disp('subjet mismatch')); end
% STN07_b :: right staged unilateral--> 2 blocks. blk1_striatum blk2_ventral
if strcmp(LFP(4).no, '100007_b')==1 %&&  ~isempty(LFP(4).ltd.congTrl)
    stn07_b{2,1} = [LFP(4).ltd.incgTrl{2,1}]; % blk2 Rhem- left r = contra
    stn07_b{1,2} = [LFP(4).rtd.incgTrl{2,1}]; % blk2 Rhem- right r = ipsi
    RT_stn07_b{2,2} = [LFP(4).ltd.incgRT{2,1}];
    RT_stn07_b{1,1} = [LFP(4).rtd.incgRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN08 :: bilateral--> 2 blocks. blk2_ventral Lhem chan 2, Rhem chan 4
if strcmp(LFP(5).no, '100008')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn08{1,1} = [LFP(5).ltd.incgTrl{2,1}]; % blk2 -Lhem - left r = ipsi
    stn08{2,1} = [LFP(5).ltd.incgTrl{2,2}]; % blk2 - Rhem  - left r = contra
    stn08{2,2} = [LFP(5).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn08{1,2} = [LFP(5).rtd.incgTrl{2,2}]; % blk2 - Rhem - right r = ipsi
    RT_stn08{1,1} = [LFP(5).ltd.incgRT{2,1}];
    RT_stn08{2,2} = [LFP(5).rtd.incgRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN09 :: bilateral--> 1 block. no ventral block
if strcmp(LFP(6).no, '100009')==1 %&&  ~isempty(LFP(6).ltd.congTrl)
    stn09{1,1} = [LFP(6).ltd.incgTrl{2,1}];%LFP(6).ltd.incgTrl{3,1}]; % blk2 &3 Lhem - left r = ipsi
    stn09{2,1} = [LFP(6).ltd.incgTrl{2,2}];%LFP(6).ltd.incgTrl{3,2}]; % blk2 &3 Rhem  - left r = contra
    stn09{2,2} = [LFP(6).rtd.incgTrl{2,1}];%LFP(6).rtd.incgTrl{3,1}]; % blk2 &3 Lhem - right r = contra
    stn09{1,2} = [LFP(6).rtd.incgTrl{2,2}];%LFP(6).rtd.incgTrl{3,2}]; % blk2 &3 Rhem - right r = ipsi
    RT_stn09{1,1} = [LFP(6).ltd.incgRT{2,1}];
    RT_stn09{2,2} = [LFP(6).rtd.incgRT{2,1}];
else (disp('subjet mismatch')); end
%STN10 :: Psuedo bilateral 3 blks. blk1_dorsal blk2_ventral left Hem blk_3
%dorsal right him
if strcmp(LFP(7).no, '100010_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn10_a{1,1} = [LFP(7).ltd.incgTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn10_a{2,2} = [LFP(7).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    RT_stn10_a{1,1} = [LFP(7).ltd.incgRT{2,1}]; 
    RT_stn10_a{2,2} = [LFP(7).rtd.incgRT{2,1}];    
else (disp('subjet mismatch')); end
%STN10_b :: Psuedo bilateral - right hem . blk1_ventral
if strcmp(LFP(8).no, '100010_b')==1 %&&  ~isempty(LFP(8).ltd.congTrl)
    stn10_b{2,1} = [LFP(8).ltd.incgTrl{1,1}]; % blk1 -Rhem - left r = contra
    stn10_b{1,2} = [LFP(8).rtd.incgTrl{1,1}]; % blk1 -Rhem - right r = ipsi
    RT_stn10_b{1,1} = [LFP(8).ltd.incgRT{1,1}]; 
    RT_stn10_b{2,2} = [LFP(8).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
%STN11 :: bilateral-->3blocks. blk3_ventral left hem chan 1 right hem chan
%7 (tmp09) may be artificial
if strcmp(LFP(9).no, '100011')==1 %&&  ~isempty(LFP(9).ltd.congTrl)
    stn11{1,1} = [LFP(9).ltd.incgTrl{3,1}]; % blk3 chn1 - left hem - left r = ipsi
    stn11{2,1} = [LFP(9).ltd.incgTrl{3,2}]; % blk3 chn4 - right hem - left r = contra
    stn11{2,2} = [LFP(9).rtd.incgTrl{3,1}]; % blk3 chn1 - left hem - right r = contra
    stn11{1,2} = [LFP(9).rtd.incgTrl{3,2}]; % blk3 chn4 - right hem - right r = ipsi
    RT_stn11{1,1} = [LFP(9).ltd.incgRT{3,1}];
    RT_stn11{2,2} = [LFP(9).rtd.incgRT{3,1}]; 
else (disp('subjet mismatch')); end
%STN13 :: bilateral--> 2 blocks. blk2_ventral Lhem, Rhem 
if strcmp(LFP(10).no, '100013')==1 %&& ~isempty(LFP(10).ltd.congTrl)
    stn13{1,1} = [LFP(10).ltd.incgTrl{2,1}]; % blk2 -Lhem - left r = ipsi
    stn13{2,1} = [LFP(10).ltd.incgTrl{2,2}]; % blk2 - Rhem  - left r = contra
    stn13{2,2} = [LFP(10).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn13{1,2} = [LFP(10).rtd.incgTrl{2,2}]; % blk2 - Rhem - right r = ipsi
    RT_stn13{1,1} = [LFP(10).ltd.incgRT{2,1}];
    RT_stn13{2,2} = [LFP(10).rtd.incgRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN13 :: bilateral--> 2 blocks. blk2_ventral Lhem, Rhem 
if strcmp(LFP(11).no, '100014')==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn14{1,1} = [LFP(11).ltd.incgTrl{2,1}]; % blk2 -Lhem - left r = ipsi
    stn14{2,1} = [LFP(11).ltd.incgTrl{2,2}]; % blk2 - Rhem  - left r = contra
    stn14{2,2} = [LFP(11).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn14{1,2} = [LFP(11).rtd.incgTrl{2,2}]; % blk2 - Rhem - right r = ipsi
    RT_stn14{1,1} = [LFP(11).ltd.incgRT{2,1}];
    RT_stn14{2,2} = [LFP(11).rtd.incgRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN16 :: bilateral--> 2 blocks. blk2_ventral
if strcmp(LFP(12).no, '100016')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn16{1,1} = [LFP(12).ltd.incgTrl{2,1}]; % blk2 -Lhem - left r = ipsi
    stn16{2,1} = [LFP(12).ltd.incgTrl{2,2}]; % blk2 - Rhem  - left r = contra
    stn16{2,2} = [LFP(12).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn16{1,2} = [LFP(12).rtd.incgTrl{2,2}]; % blk2 - Rhem - right r = ipsi
    RT_stn16{1,1} = [LFP(12).ltd.incgRT{2,1}];
    RT_stn16{2,2} = [LFP(12).rtd.incgRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN17 :: bilateral--> 2 blocks. blk2_ventral
if strcmp(LFP(13).no, '100017')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn17{1,1} = [LFP(13).ltd.incgTrl{2,1}]; % blk2 -Lhem - left r = ipsi
    stn17{2,1} = [LFP(13).ltd.incgTrl{2,2}]; % blk2 - Rhem  - left r = contra
    stn17{2,2} = [LFP(13).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn17{1,2} = [LFP(13).rtd.incgTrl{2,2}]; % blk2 - Rhem - right r = ipsi
    RT_stn17{1,1} = [LFP(13).ltd.incgRT{2,1}];
    RT_stn17{2,2} = [LFP(13).rtd.incgRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN18_a :: 
if strcmp(LFP(14).no, '100018_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn18_a{1,1} = [LFP(14).ltd.incgTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn18_a{2,2} = [LFP(14).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    RT_stn18_a{1,1} = [LFP(14).ltd.incgRT{2,1}]; 
    RT_stn18_a{2,2} = [LFP(14).rtd.incgRT{2,1}];    
else (disp('subjet mismatch')); end
%STN18_b :: Psuedo bilateral - right hem . blk1_ventral
if strcmp(LFP(15).no, '100018_b')==1 %&&  ~isempty(LFP(8).ltd.congTrl)
    stn18_b{2,1} = [LFP(15).ltd.incgTrl{1,1}]; % blk1 -Rhem - left r = contra
    stn18_b{1,2} = [LFP(15).rtd.incgTrl{1,1}]; % blk1 -Rhem - right r = ipsi
    RT_stn18_b{1,1} = [LFP(15).ltd.incgRT{1,1}]; 
    RT_stn18_b{2,2} = [LFP(15).rtd.incgRT{1,1}]; 
else (disp('subjet mismatch')); end
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
STN.vIncg = [];STN.ipVincg = [];STN.ctVincg = [];RT.vIncg = [];RT.ipVincg = [];RT.ctVincg = [];
vIncg = [stn02;stn03;stn07_a;stn07_b;stn08;stn09;stn10_a; stn10_b;stn11;stn13;stn14;stn16;stn17;stn18_a; stn18_b];
ipVincg = {stn02{1,:}; stn07_a{1,:};stn07_b{1,:}; stn08{1,:}; stn09{1,:}; stn10_a{1,:};stn10_b{1,:};stn11{1,:};stn13{1,:};stn14{1,:};stn16{1,:};stn17{1,:};stn18_a{1,:};stn18_b{1,:}};
ctVincg = {stn02{2,:}; stn07_a{2,:}; stn07_b{2,:}; stn08{2,:}; stn09{2,:}; stn10_a{2,:};stn10_b{2,:};stn11{2,:};stn13{2,:};stn14{2,:};stn16{2,:};stn17{2,:};stn18_a{2,:};stn18_b{2,:}};

[vincg.STN02] = fx_indvcat(stn02,STN,'vIncg');%,RT_stn02,RT
vincg.STN02.RT = RT_stn02; 
vincg.STN02.ipRT = RT_stn02{1,1}; 
vincg.STN02.ctRT = RT_stn02{2,2}; 
[vincg.STN07a] = fx_indvcat(stn07_a,STN,'vIncg');%,RT_stn07_a,RT
vincg.STN07a.RT = RT_stn07_a; 
vincg.STN07a.ipRT = RT_stn07_a{1,1}; 
vincg.STN07a.ctRT = RT_stn07_a{2,2}; 
[vincg.STN07b] = fx_indvcat(stn07_b,STN,'vIncg');%,RT_stn07_b,RT
vincg.STN07b.RT = RT_stn07_b; 
vincg.STN07b.ipRT = RT_stn07_b{1,1}; 
vincg.STN07b.ctRT = RT_stn07_b{2,2}; 
[vincg.STN08] = fx_indvcat(stn08,STN,'vIncg');%,RT_stn08,RT
vincg.STN08.RT = RT_stn08; 
vincg.STN08.ipRT = RT_stn08{1,1}; 
vincg.STN08.ctRT = RT_stn08{2,2}; 
[vincg.STN09] = fx_indvcat(stn09,STN,'vIncg');%,RT_stn09,RT
vincg.STN09.RT = RT_stn09; 
vincg.STN09.ipRT = RT_stn09{1,1}; 
vincg.STN09.ctRT = RT_stn09{2,2}; 
[vincg.STN10a] = fx_indvcat(stn10_a,STN,'vIncg');%,RT_stn10_a,RT
vincg.STN10a.RT = RT_stn10_a; 
vincg.STN10a.ipRT = RT_stn10_a{1,1}; 
vincg.STN10a.ctRT = RT_stn10_a{2,2}; 
[vincg.STN10b] = fx_indvcat(stn10_b,STN,'vIncg');%,RT_stn10_a,RT
vincg.STN10b.RT = RT_stn10_b; 
vincg.STN10b.ipRT = RT_stn10_b{1,1}; 
vincg.STN10b.ctRT = RT_stn10_b{2,2}; 
[vincg.STN11] = fx_indvcat(stn11,STN,'vIncg');%,RT_stn11,RT
vincg.STN11.RT = RT_stn11; 
vincg.STN11.ipRT = RT_stn11{1,1}; 
vincg.STN11.ctRT = RT_stn11{2,2}; 
[vincg.STN13] = fx_indvcat(stn13,STN,'vIncg');%,RT_stn13,RT
vincg.STN13.RT = RT_stn13; 
vincg.STN13.ipRT = RT_stn13{1,1}; 
vincg.STN13.ctRT = RT_stn13{2,2}; 
[vincg.STN14] = fx_indvcat(stn14,STN,'vIncg');%,RT_stn14,RT
vincg.STN14.RT = RT_stn14; 
vincg.STN14.ipRT = RT_stn14{1,1}; 
vincg.STN14.ctRT = RT_stn14{2,2}; 
[vincg.STN16] = fx_indvcat(stn16,STN,'vIncg');%,RT_stn08,RT
vincg.STN16.RT = RT_stn16; 
vincg.STN16.ipRT = RT_stn16{1,1}; 
vincg.STN16.ctRT = RT_stn16{2,2}; 
[vincg.STN17] = fx_indvcat(stn17,STN,'vIncg');%,RT_stn08,RT
vincg.STN17.RT = RT_stn17; 
vincg.STN17.ipRT = RT_stn17{1,1}; 
vincg.STN17.ctRT = RT_stn17{2,2}; 
[vincg.STN18a] = fx_indvcat(stn18_a,STN,'vIncg');
vincg.STN18a.RT = RT_stn18_a; 
vincg.STN18a.ipRT = RT_stn18_a{1,1}; 
vincg.STN18a.ctRT = RT_stn18_a{2,2}; 
[vincg.STN18b] = fx_indvcat(stn18_b,STN,'vIncg');
vincg.STN18b.RT = RT_stn18_b; 
vincg.STN18b.ipRT = RT_stn18_b{1,1}; 
vincg.STN18b.ctRT = RT_stn18_b{2,2}; 
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
clear stn02 stn03 stn07_a stn07_b stn08 stn09 stn10_a stn10_b stn11 stn13 stn14 stn16 stn17 stn18_a stn18_b
clear RT RT_stn02 RT_stn03 RT_stn07_a RT_stn07_b RT_stn08 RT_stn09 RT_stn10_a RT_stn10_b RT_stn11 RT_stn13 RT_stn14 RT_stn16 RT_stn17  RT_stn18_a RT_stn18_b 
% % % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% sort into hemispheres
% dorsal 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% cong 
% Left- | Right- HEMISPHERE
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% STN02 :: left unilateral 1blk_dorsal
if strcmp(LFP(1).no, '100002')==1 %&&  ~isempty(LFP(1).ltd.congTrl)
    stn02{1,1} = [LFP(1).ltd.congTrl{1,1}]; % blk1 (chn1) Lhem- left rsp = ipsi
    stn02{2,1} = [LFP(1).rtd.congTrl{1,1}]; % blk1 (chn1) Lhem- right rsp = contral
else (disp('subjet mismatch')); end
% STN07_a :: left staged unilateral | blk1_dorsal blk2_ventral chan 3 pst
% - bad channel resolution
if strcmp(LFP(3).no, '100007_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn07_a{1,1} = [LFP(3).ltd.congTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn07_a{2,1} = [LFP(3).rtd.congTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
%STN07_b :: right staged unilateral blk 1 striatum blk2 - ventral
stn07_b = [];
% STN08 :: bilateral 2 dorsal blks left hem chan 1 right hem chan 5
if strcmp(LFP(5).no, '100008')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn08{1,1} = [LFP(5).ltd.congTrl{1,1}]; % blk1 - Lhem - left r = ipsi
    stn08{1,2} = [LFP(5).ltd.congTrl{1,2}]; % blk1 - Rhem  - left r = contra
    stn08{2,1} = [LFP(5).rtd.congTrl{1,1}]; % blk1 - Lhem - right r = contra
    stn08{2,2} = [LFP(5).rtd.congTrl{1,2}]; % blk1 - Rhem - right r = ipsi
else (disp('subjet mismatch')); end
% STN09 :: bilateral 1 dorsal blk left hem chan 1 rigth hem chan 4
if strcmp(LFP(6).no, '100009')==1 %&&  ~isempty(LFP(6).ltd.congTrl)
    stn09 = [];
else (disp('subjet mismatch')); end
%STN10_a :: Psuedo bilateral (staged) - left hem . blk1_dorsal blk2_ventral
if strcmp(LFP(7).no, '100010_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn10_a{1,1} = [LFP(7).ltd.congTrl{1,1}]; % blk1-Lhem - left r = ipsi
    stn10_a{2,1} = [LFP(7).rtd.congTrl{1,1}]; % blk1 ch -Lhem - right r = contra
else (disp('subjet mismatch')); end
%STN10_b :: Psuedo bilateral - right hem . blk1_ventral
stn10_b = [];
%STN11 :: bilateral 3 blks. blk2_dorsal left hem chan 1 right hem chan 4
if strcmp(LFP(9).no, '100011')==1 %&&  ~isempty(LFP(9).ltd.congTrl)
    stn11{1,1} = [LFP(9).ltd.congTrl{2,1}]; % blk2 chn1 - left hem - left r = ipsi
    stn11{1,2} = [LFP(9).ltd.congTrl{2,2}]; % blk2 chn4 - right hem - left r = contra
    stn11{2,1} = [LFP(9).rtd.congTrl{2,1}]; % blk2 chn1 - left hem - right r = contra
    stn11{2,2} = [LFP(9).rtd.congTrl{2,2}]; % blk2 chn4 - right hem - right r = ipsi
    RT_stn11{1,1} = [LFP(9).ltd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN13 :: bilateral
if strcmp(LFP(10).no, '100013') ==1 %&&  ~isempty(LFP(10).ltd.congTrl)
    stn13{1,1} = [LFP(10).ltd.congTrl{1,1}]; % blk1 - left hem - left r = ipsi
    %stn13{1,2} = [LFP(10).ltd.congTrl{1,2}]; % blk1 - right hem - left r = contra
    stn13{2,1} = [LFP(10).rtd.congTrl{1,1}]; % blk1 - left hem - right r = contra
    %stn13{2,2} = [LFP(10).rtd.congTrl{1,2}]; % blk1 - right hem - right r = ipsi
else (disp('subjet mismatch')); end
%STN14 :: bilateral
if strcmp(LFP(11).no, '100014') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn14{1,1} = [LFP(11).ltd.congTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn14{1,2} = [LFP(11).ltd.congTrl{1,2}]; % blk1 - right hem - left r = contra
    stn14{2,1} = [LFP(11).rtd.congTrl{1,1}]; % blk1 - left hem - right r = contra
    stn14{2,2} = [LFP(11).rtd.congTrl{1,2}]; % blk1 - right hem - right r = ipsi
else (disp('subjet mismatch')); end
%STN16 :: bilateral
if strcmp(LFP(12).no, '100016') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn16{1,1} = [LFP(12).ltd.congTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn16{1,2} = [LFP(12).ltd.congTrl{1,2}]; % blk1 - right hem - left r = contra
    stn16{2,1} = [LFP(12).rtd.congTrl{1,1}]; % blk1 - left hem - right r = contra
    stn16{2,2} = [LFP(12).rtd.congTrl{1,2}]; % blk1 - right hem - right r = ipsi
else (disp('subjet mismatch')); end
%STN17 :: bilateral
if strcmp(LFP(13).no, '100017') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn17{1,1} = [LFP(13).ltd.congTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn17{1,2} = [LFP(13).ltd.congTrl{1,2}]; % blk1 - right hem - left r = contra
    stn17{2,1} = [LFP(13).rtd.congTrl{1,1}]; % blk1 - left hem - right r = contra
    stn17{2,2} = [LFP(13).rtd.congTrl{1,2}]; % blk1 - right hem - right r = ipsi
else (disp('subjet mismatch')); end
% STN18_a :: left staged unilateral | blk1_dorsal blk2_ventral chan 3 pst
if strcmp(LFP(14).no, '100018_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn18_a{1,1} = [LFP(14).ltd.congTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn18_a{2,1} = [LFP(14).rtd.congTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
if strcmp(LFP(15).no, '100018_b')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn18_b{1,2} = [LFP(15).ltd.congTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn18_b{2,2} = [LFP(15).rtd.congTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

STN.dCong = [];STN.LHdcong = [];STN.RHdcong = [];
% dCong = [stn02; stn07_a; stn07_b; stn08; stn09; stn10_a;  stn11; stn13; stn14; stn16; stn17; stn18_a; stn18_b;];
% LHDcong = {stn02{:,1};stn07_a{:,1}; stn08{:,1}; stn10_a{:,1}; stn11{:,1}; stn13{:,1}; stn14{:,1}; stn16{:,1}; stn17{:,1};stn18_a{:,1};};
% RHDcong = {stn08{:,2}; stn11{:,2};stn13{:,2}; stn14{:,2}; stn16{:,2}; stn17{:,2};stn18_b{:,2}};

[LHdcong.STN02] = fx_indvcat(stn02,STN,'LHdcong');
dcongLH.STN02 = stn02{:,1};

[LHdcong.STN07a] = fx_indvcat(stn07_a,STN,'LHdcong');
dcongLH.STN07a = stn07_a{:,1}; 

[LHdcong.STN08] = fx_indvcat(stn08,STN,'LHdcong');
[RHdcong.STN08] = fx_indvcat(stn08,STN,'RHdcong');
dcongLH.STN08 = stn08{:,1}; 
dcongRH.STN08 = stn08{:,2}; 

[LHdcong.STN10a] = fx_indvcat(stn10_a,STN,'LHdcong');
dcongLH.STN10a = stn10_a{:,1}; 

[LHdcong.STN11] = fx_indvcat(stn11,STN,'LHdcong');
[RHdcong.STN11] = fx_indvcat(stn11,STN,'RHdcong');
dcongLH.STN11 = stn11{:,1}; 
dcongRH.STN11 =stn11{:,2}; 

[LHdcong.STN13] = fx_indvcat(stn13,STN,'LHdcong');
%[RHdcong.STN13] = fx_indvcat(stn13,STN,'RHdcong');
dcongLH.STN13= stn13{:,1}; 
%dcongRH.STN13 = stn13{:,2}; 

[LHdcong.STN14] = fx_indvcat(stn14,STN,'LHdcong');
[RHdcong.STN14] = fx_indvcat(stn14,STN,'RHdcong');
dcongLH.STN14= stn14{:,1}; 
dcongRH.STN14 = stn14{:,2}; 

[LHdcong.STN16] = fx_indvcat(stn16,STN,'LHdcong');
[RHdcong.STN16] = fx_indvcat(stn16,STN,'RHdcong');
dcongLH.STN16 = stn16{:,1}; 
dcongRH.STN16 = stn16{:,2};

[LHdcong.STN17] = fx_indvcat(stn17,STN,'LHdcong');
[RHdcong.STN17] = fx_indvcat(stn17,STN,'RHdcong');
dcongLH.STN17 = stn17{:,1}; 
dcongRH.STN17 = stn17{:,2}; 

[LHdcong.STN18a] = fx_indvcat(stn18_a,STN,'LHdcong');
[RHdcong.STN18b] = fx_indvcat(stn18_b,STN,'RHdcong');
dcongLH.STN18a = stn18_a{:,1}; 
dcongRH.STN18b = stn18_b{:,2}; 
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
clear STN stn02 stn03 stn07_a stn07_b stn08 stn09 stn10_a stn10_b stn11 stn13 stn14 stn16 stn17 stn18_a stn18_b
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% incg 
% Left- | Right- HEMISPHERE
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% STN02 :: left unilateral 1blk_dorsal
if strcmp(LFP(1).no, '100002')==1 %&&  ~isempty(LFP(1).ltd.congTrl)
    stn02{1,1} = [LFP(1).ltd.incgTrl{1,1}]; % blk1 (chn1) Lhem- left rsp = ipsi
    stn02{2,1} = [LFP(1).rtd.incgTrl{1,1}]; % blk1 (chn1) Lhem- right rsp = contral
else (disp('subjet mismatch')); end
% STN07_a :: left staged unilateral | blk1_dorsal blk2_ventral chan 3 pst
% - bad channel resolution
if strcmp(LFP(3).no, '100007_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn07_a{1,1} = [LFP(3).ltd.incgTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn07_a{2,1} = [LFP(3).rtd.incgTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
%STN07_b :: right staged unilateral blk 1 striatum blk2 - ventral
stn07_b = [];
% STN08 :: bilateral 2 dorsal blks left hem chan 1 right hem chan 5
if strcmp(LFP(5).no, '100008')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn08{1,1} = [LFP(5).ltd.incgTrl{1,1}]; % blk1 - Lhem - left r = ipsi
    stn08{1,2} = [LFP(5).ltd.incgTrl{1,2}]; % blk1 - Rhem  - left r = contra
    stn08{2,1} = [LFP(5).rtd.incgTrl{1,1}]; % blk1 - Lhem - right r = contra
    stn08{2,2} = [LFP(5).rtd.incgTrl{1,2}]; % blk1 - Rhem - right r = ipsi
else (disp('subjet mismatch')); end
% STN09 :: bilateral 1 dorsal blk left hem chan 1 rigth hem chan 4
if strcmp(LFP(6).no, '100009')==1 %&&  ~isempty(LFP(6).ltd.congTrl)
    stn09 = [];
else (disp('subjet mismatch')); end
%STN10_a :: Psuedo bilateral (staged) - left hem . blk1_dorsal blk2_ventral
if strcmp(LFP(7).no, '100010_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn10_a{1,1} = [LFP(7).ltd.incgTrl{1,1}]; % blk1-Lhem - left r = ipsi
    stn10_a{2,1} = [LFP(7).rtd.incgTrl{1,1}]; % blk1 ch -Lhem - right r = contra
else (disp('subjet mismatch')); end
%STN10_b :: Psuedo bilateral - right hem . blk1_ventral
stn10_b = [];
%STN11 :: bilateral 3 blks. blk2_dorsal left hem chan 1 right hem chan 4
if strcmp(LFP(9).no, '100011')==1 %&&  ~isempty(LFP(9).ltd.congTrl)
    stn11{1,1} = [LFP(9).ltd.incgTrl{2,1}]; % blk2 chn1 - left hem - left r = ipsi
    stn11{1,2} = [LFP(9).ltd.incgTrl{2,2}]; % blk2 chn4 - right hem - left r = contra
    stn11{2,1} = [LFP(9).rtd.incgTrl{2,1}]; % blk2 chn1 - left hem - right r = contra
    stn11{2,2} = [LFP(9).rtd.incgTrl{2,2}]; % blk2 chn4 - right hem - right r = ipsi
    RT_stn11{1,1} = [LFP(9).ltd.congRT{2,1}]; 
else (disp('subjet mismatch')); end
%STN13 :: bilateral
if strcmp(LFP(10).no, '100013') ==1 %&&  ~isempty(LFP(10).ltd.congTrl)
    stn13{1,1} = [LFP(10).ltd.incgTrl{1,1}]; % blk1 - left hem - left r = ipsi
    %stn13{1,2} = [LFP(10).ltd.incgTrl{1,2}]; % blk1 - right hem - left r = contra
    stn13{2,1} = [LFP(10).rtd.incgTrl{1,1}]; % blk1 - left hem - right r = contra
    %stn13{2,2} = [LFP(10).rtd.incgTrl{1,2}]; % blk1 - right hem - right r = ipsi
else (disp('subjet mismatch')); end
%STN14 :: bilateral
if strcmp(LFP(11).no, '100014') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn14{1,1} = [LFP(11).ltd.incgTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn14{1,2} = [LFP(11).ltd.incgTrl{1,2}]; % blk1 - right hem - left r = contra
    stn14{2,1} = [LFP(11).rtd.incgTrl{1,1}]; % blk1 - left hem - right r = contra
    stn14{2,2} = [LFP(11).rtd.incgTrl{1,2}]; % blk1 - right hem - right r = ipsi
else (disp('subjet mismatch')); end
%STN16 :: bilateral
if strcmp(LFP(12).no, '100016') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn16{1,1} = [LFP(12).ltd.incgTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn16{1,2} = [LFP(12).ltd.incgTrl{1,2}]; % blk1 - right hem - left r = contra
    stn16{2,1} = [LFP(12).rtd.incgTrl{1,1}]; % blk1 - left hem - right r = contra
    stn16{2,2} = [LFP(12).rtd.incgTrl{1,2}]; % blk1 - right hem - right r = ipsi
else (disp('subjet mismatch')); end
%STN17 :: bilateral
if strcmp(LFP(13).no, '100017') ==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn17{1,1} = [LFP(13).ltd.incgTrl{1,1}]; % blk1 - left hem - left r = ipsi
    stn17{1,2} = [LFP(13).ltd.incgTrl{1,2}]; % blk1 - right hem - left r = contra
    stn17{2,1} = [LFP(13).rtd.incgTrl{1,1}]; % blk1 - left hem - right r = contra
    stn17{2,2} = [LFP(13).rtd.incgTrl{1,2}]; % blk1 - right hem - right r = ipsi
else (disp('subjet mismatch')); end
% STN18_a :: left staged unilateral | blk1_dorsal blk2_ventral chan 3 pst
if strcmp(LFP(14).no, '100018_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn18_a{1,1} = [LFP(14).ltd.incgTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn18_a{2,1} = [LFP(14).rtd.incgTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
if strcmp(LFP(15).no, '100018_b')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn18_b{1,2} = [LFP(15).ltd.incgTrl{1,1}]; % blk 1 chn3 Lhem- left r = ipsi
    stn18_b{2,2} = [LFP(15).rtd.incgTrl{1,1}]; % blk 1 chn3 Lhem- right r = contra
else (disp('subjet mismatch')); end
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

STN.dIncg = [];STN.LHdincg = [];STN.RHdincg= [];
% dIncg = [stn02; stn03; stn07_a; stn07_b; stn08; stn09; stn10_a;  stn11; stn13; stn14; stn16; stn17; stn18_a; stn18_b;];%stn10_b;
% LHDincg = {stn02{:,1};stn07_a{:,1}; stn08{:,1}; stn10_a{:,1}; stn11{:,1}; stn13{:,1}; stn14{:,1}; stn16{:,1}; stn17{:,1};stn18_a{:,1};};
% RHDincg = {stn08{:,2}; stn11{:,2};stn13{:,2}; stn14{:,2}; stn16{:,2}; stn17{:,2};stn18_b{:,2}};

[LHdincg.STN02] = fx_indvcat(stn02,STN,'LHdincg');
dincgLH.STN02 = stn02{:,1};

[LHdincg.STN07a] = fx_indvcat(stn07_a,STN,'LHdincg');
dincgLH.STN07a = stn07_a{:,1}; 

[LHdincg.STN08] = fx_indvcat(stn08,STN,'LHdincg');
[RHdincg.STN08] = fx_indvcat(stn08,STN,'RHdincg');
dincgLH.STN08 = stn08{:,1}; 
dincgRH.STN08 = stn08{:,2};

[LHdincg.STN10a] = fx_indvcat(stn10_a,STN,'LHdincg');
dincgLH.STN10a = stn10_a{:,1}; 

[LHdincg.STN11] = fx_indvcat(stn11,STN,'LHdincg');
[RHdincg.STN11] = fx_indvcat(stn11,STN,'RHdincg');
dincgLH.STN11 = stn11{:,1}; 
dincgRH.STN11 =stn11{:,2}; 

[LHdincg.STN13] = fx_indvcat(stn13,STN,'LHdincg');
%[RHdincg.STN13] = fx_indvcat(stn13,STN,'RHdincg');
dincgLH.STN13= stn13{:,1}; 
%dincgRH.STN13 = stn13{:,2}; 

[LHdincg.STN14] = fx_indvcat(stn14,STN,'LHdincg');
[RHdincg.STN14] = fx_indvcat(stn14,STN,'RHdincg');
dincgLH.STN14= stn14{:,1}; 
dincgRH.STN14 = stn14{:,2}; 

[LHdincg.STN16] = fx_indvcat(stn16,STN,'LHdincg');
[RHdincg.STN16] = fx_indvcat(stn16,STN,'RHdincg');
dincgLH.STN16 = stn16{:,1}; 
dincgRH.STN16 = stn16{:,2}; 

[LHdincg.STN17] = fx_indvcat(stn17,STN,'LHdincg');
[RHdincg.STN17] = fx_indvcat(stn17,STN,'RHdincg');
dincgLH.STN17 = stn17{:,1}; 
dincgRH.STN17 = stn17{:,2}; 

[LHdincg.STN18a] = fx_indvcat(stn18_a,STN,'LHdincg');
[RHdincg.STN18b] = fx_indvcat(stn18_b,STN,'RHdincg');
dincgLH.STN18a = stn18_a{:,1}; 
dincgRH.STN18b = stn18_b{:,2}; 
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
clear STN stn02 stn03 stn07_a stn07_b stn08 stn09 stn10_a stn10_b stn11 stn13 stn14 stn16 stn17 stn18_a stn18_b

%% ventral 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% cong 
% Left- | Right- HEMISPHERE
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% STN02 :: left unilateral-->2 blocks. blk2_ventral
if strcmp(LFP(1).no, '100002')==1 %&&  ~isempty(LFP(1).ltd.congTrl)
    stn02{1,1} = [LFP(1).ltd.congTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn02{2,1} = [LFP(1).rtd.congTrl{2,1}]; % blk2 Lhem- right r = contra
else (disp('subjet mismatch')); end
% STN07_a :: left staged unilateral--> 2 blocks. blk2_ventral chan 3 pst
% - bad channel resolution
if strcmp(LFP(3).no, '100007_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn07_a{1,1} = [LFP(3).ltd.congTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn07_a{2,1} = [LFP(3).rtd.congTrl{2,1}]; % blk2 Lhem- right r = contra
else (disp('subjet mismatch')); end
% STN07_b :: right staged unilateral--> 2 blocks. blk1_striatum blk2_ventral
if strcmp(LFP(4).no, '100007_b')==1 %&&  ~isempty(LFP(4).ltd.congTrl)
    stn07_b{2,2} = [LFP(4).ltd.congTrl{2,1}]; % blk2 chn3 Rhem- left r = contra
    stn07_b{1,2} = [LFP(4).rtd.congTrl{2,1}]; % blk2 chn3 Rhem- right r = ipsi
else (disp('subjet mismatch')); end
%STN08 :: bilateral--> 2 blocks. blk2_ventral Lhem chan 2, Rhem chan 4
if strcmp(LFP(5).no, '100008')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn08{1,1} = [LFP(5).ltd.congTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn08{1,2} = [LFP(5).ltd.congTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn08{2,1} = [LFP(5).rtd.congTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn08{2,2} = [LFP(5).rtd.congTrl{2,2}]; % blk2 - Rhem - right r = ipsi
else (disp('subjet mismatch')); end
%STN09 :: bilateral--> 2 block. no dorsal block
if strcmp(LFP(6).no, '100009')==1 %&&  ~isempty(LFP(6).ltd.congTrl)
    stn09{1,1} = [LFP(6).ltd.congTrl{2,1}];%LFP(6).ltd.congTrl{3,1}]; % blk2 Lhem - left r = ipsi
    stn09{1,2} = [LFP(6).ltd.congTrl{3,2}];%LFP(6).ltd.congTrl{3,2}]; % blk2 Rhem  - left r = contra
    stn09{2,1} = [LFP(6).rtd.congTrl{2,1}];%LFP(6).rtd.congTrl{3,1}]; % blk2 Lhem - right r = contra
    stn09{2,2} = [LFP(6).rtd.congTrl{3,2}];%LFP(6).rtd.congTrl{3,2}]; % blk2 Rhem - right r = ipsi    
end
%STN10 :: Psuedo bilateral 3 blks. blk1_dorsal blk2_ventral left Hem blk_3
%dorsal right hem
if strcmp(LFP(7).no, '100010_a')==1 %&&  ~isempty(LFP(7).ltd.congTrl)
    stn10_a{1,1} = [LFP(7).ltd.congTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn10_a{2,1} = [LFP(7).rtd.congTrl{2,1}]; % blk2 - Lhem - right r = contra
else (disp('subjet mismatch')); end
%STN10_b :: Psuedo bilateral - right hem . blk1_dorsal
if strcmp(LFP(8).no, '100010_b')==1 %&&  ~isempty(LFP(8).ltd.congTrl)
    stn10_b{1,2} = [LFP(8).ltd.congTrl{1,1}]; % blk1 -Rhem - left r = contra
    stn10_b{2,2} = [LFP(8).rtd.congTrl{1,1}]; % blk1 -Rhem - right r = ipsi
else (disp('subjet mismatch')); end
%STN11 :: bilateral-->3blocks. blk3_ventral left hem chan 1 right hem chan
%7 (tmp09) may be artificial
if strcmp(LFP(9).no, '100011')==1 %&&  ~isempty(LFP(9).ltd.congTrl)
    stn11{1,1} = [LFP(9).ltd.congTrl{3,1}]; % blk3 - left hem - left r = ipsi
%     stn11{1,2} = [LFP(9).ltd.congTrl{3,2}]; % blk3 - right hem - left r = contra
    stn11{2,1} = [LFP(9).rtd.congTrl{3,1}]; % blk3 - left hem - right r = contra
%     stn11{2,2} = [LFP(9).rtd.congTrl{3,2}]; % blk3 - right hem - right r = ipsi     
else (disp('subjet mismatch')); end
%STN13 :: bilateral-->
if strcmp(LFP(10).no, '100013')==1 %&&  ~isempty(LFP(10).ltd.congTrl)
    stn13{1,1} = [LFP(10).ltd.congTrl{2,1}]; % blk2 - left hem - left r = ipsi
    stn13{1,2} = [LFP(10).ltd.congTrl{2,2}]; % blk2 - right hem - left r = contra
    stn13{2,1} = [LFP(10).rtd.congTrl{2,1}]; % blk2 - left hem - right r = contra
    stn13{2,2} = [LFP(10).rtd.congTrl{2,2}]; % blk2- right hem - right r = ipsi  
else (disp('subjet mismatch')); end
%STN14 :: bilateral-->
if strcmp(LFP(11).no, '100014')==1 %&&  ~isempty(LFP(11).ltd.congTrl)
    stn14{1,1} = [LFP(11).ltd.congTrl{2,1}]; % blk2 - left hem - left r = ipsi
    stn14{2,1} = [LFP(11).rtd.congTrl{2,1}]; % blk2 - left hem - right r = contra 
else (disp('subjet mismatch')); end
%STN16 :: bilateral-->
if strcmp(LFP(12).no, '100016')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn16{1,1} = [LFP(12).ltd.congTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn16{1,2} = [LFP(12).ltd.congTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn16{2,1} = [LFP(12).rtd.congTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn16{2,2} = [LFP(12).rtd.congTrl{2,2}]; % blk2 - Rhem - right r = ipsi
else (disp('subjet mismatch')); end
%STN17 :: bilateral-->
if strcmp(LFP(13).no, '100017')==1 %&&  ~isempty(LFP(5).ltd.congTrl)
    stn17{1,1} = [LFP(13).ltd.congTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn17{1,2} = [LFP(13).ltd.congTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn17{2,1} = [LFP(13).rtd.congTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn17{2,2} = [LFP(13).rtd.congTrl{2,2}]; % blk2 - Rhem - right r = ipsi
else (disp('subjet mismatch')); end
% STN18_a ::
if strcmp(LFP(14).no, '100018_a')==1 %&&  ~isempty(LFP(3).ltd.congTrl)
    stn18_a{1,1} = [LFP(14).ltd.congTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn18_a{2,1} = [LFP(14).rtd.congTrl{2,1}]; % blk2 Lhem- right r = contra
else (disp('subjet mismatch')); end
% STN18_b :: right staged unilateral--> 2 blocks. blk1_striatum blk2_ventral
if strcmp(LFP(15).no, '100018_b')==1 %&&  ~isempty(LFP(4).ltd.congTrl)
    stn18_b{1,2} = [LFP(15).ltd.congTrl{2,1}]; % blk2 chn3 Rhem- left r = contra
    stn18_b{2,2} = [LFP(15).rtd.congTrl{2,1}]; % blk2 chn3 Rhem- right r = ipsi
else (disp('subjet mismatch')); end
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
STN.vCong = [];STN.LHvcong = [];STN.RHvcong = [];
% vCong = [stn02;stn03;stn07_a;stn07_b;stn08;stn09;stn10_a;stn10_b;stn11;stn13;stn14;stn16;stn17;stn18_a;stn18_b];
% LHVcong = {stn02{:,1}; stn07_a{:,1}; stn08{:,1}; stn09{:,1}; stn10_a{:,1}; stn11{:,1}; stn13{:,1}; stn14{:,1}; stn16{:,1}; stn17{:,1}; stn18_a{:,1}};
% RHVcong = {stn07_b{:,2}; stn08{:,2}; stn09{:,2}; stn10_a{:,2}; stn11{:,2}; stn13{:,2}; stn14{:,2}; stn16{:,2}; stn17{:,2}; stn18_b{:,2}};

[LHvcong.STN02] = fx_indvcat(stn02,STN,'LHvcong');
vcongLH.STN02 = stn02{:,1}; 

[LHvcong.STN07a] = fx_indvcat(stn07_a,STN,'LHvcong');
[RHvcong.STN07b] = fx_indvcat(stn07_b,STN,'RHvcong');
vcongLH.STN07a = stn07_a{1,1}; 
vcongRH.STN07b= stn07_b{:,2}; 

[LHvcong.STN08] = fx_indvcat(stn08,STN,'LHvcong');
[RHvcong.STN08] = fx_indvcat(stn08,STN,'RHvcong');
vcongLH.STN08= stn08{:,1}; 
vcongRH.STN08= stn08{:,2}; 

[LHvcong.STN09] = fx_indvcat(stn09,STN,'LHvcong');
[RHvcong.STN09] = fx_indvcat(stn09,STN,'RHvcong');
LHVcong.STN09 = stn09{:,1}; 
RHVcong.STN09 = stn09{:,2};

[LHvcong.STN10a] = fx_indvcat(stn10_a,STN,'LHvcong');
[RHvcong.STN10b] = fx_indvcat(stn10_b,STN,'RHvcong');
vcongLH.STN10a = stn10_a{:,1}; 
vcongRH.STN10b = stn10_b{:,2}; 

[LHvcong.STN11] = fx_indvcat(stn11,STN,'LHvcong');
vcongLH.STN11 = stn11{:,1}; 

[LHvcong.STN13] = fx_indvcat(stn13,STN,'LHvcong');
[RHvcong.STN13] = fx_indvcat(stn13,STN,'RHvcong');
vcongLH.STN13= stn13{:,1}; 
vcongRH.STN13 = stn13{:,2}; 

[LHvcong.STN14] = fx_indvcat(stn14,STN,'LHvcong');
vcongLH.STN14 = stn14{:,1}; 

[LHvcong.STN16] = fx_indvcat(stn16,STN,'LHvcong');
[RHvcong.STN16] = fx_indvcat(stn16,STN,'RHvcong');
vcongLH.STN16 = stn16{:,1}; 
vcongRH.STN16 = stn16{:,2}; 

[LHvcong.STN17] = fx_indvcat(stn17,STN,'LHvcong');
[RHvcong.STN17] = fx_indvcat(stn17,STN,'RHvcong');
vcongLH.STN17 = stn17{:,1}; 
vcongRH.STN17 = stn17{:,2}; 

[LHvcong.STN18a] = fx_indvcat(stn18_a,STN,'LHvcong');
[RHvcong.STN18b] = fx_indvcat(stn18_b,STN,'RHvcong');
vcongLH.STN18a = stn18_a{:,1}; 
vcongRH.STN18b = stn18_b{:,2}; 
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
clear STN stn02 stn03 stn07_a stn07_b stn08 stn09 stn10_a stn10_b stn11 stn13 stn14 stn16 stn17 stn18_a stn18_b
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% incg 
% Left- | Right- HEMISPHERE
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% STN02 :: left unilateral-->2 blocks. blk2_ventral
if strcmp(LFP(1).no, '100002')==1 %&&  ~isempty(LFP(1).ltd.incgTrl)
    stn02{1,1} = [LFP(1).ltd.incgTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn02{2,1} = [LFP(1).rtd.incgTrl{2,1}]; % blk2 Lhem- right r = contra
else (disp('subjet mismatch')); end
% STN07_a :: left staged unilateral--> 2 blocks. blk2_ventral chan 3 pst
% - bad channel resolution
if strcmp(LFP(3).no, '100007_a')==1 %&&  ~isempty(LFP(3).ltd.incgTrl)
    stn07_a{1,1} = [LFP(3).ltd.incgTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn07_a{2,1} = [LFP(3).rtd.incgTrl{2,1}]; % blk2 Lhem- right r = contra
else (disp('subjet mismatch')); end
% STN07_b :: right staged unilateral--> 2 blocks. blk1_striatum blk2_ventral
if strcmp(LFP(4).no, '100007_b')==1 %&&  ~isempty(LFP(4).ltd.incgTrl)
    stn07_b{2,2} = [LFP(4).ltd.incgTrl{2,1}]; % blk2 chn3 Rhem- left r = contra
    stn07_b{1,2} = [LFP(4).rtd.incgTrl{2,1}]; % blk2 chn3 Rhem- right r = ipsi
else (disp('subjet mismatch')); end
%STN08 :: bilateral--> 2 blocks. blk2_ventral Lhem chan 2, Rhem chan 4
if strcmp(LFP(5).no, '100008')==1 %&&  ~isempty(LFP(5).ltd.incgTrl)
    stn08{1,1} = [LFP(5).ltd.incgTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn08{1,2} = [LFP(5).ltd.incgTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn08{2,1} = [LFP(5).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn08{2,2} = [LFP(5).rtd.incgTrl{2,2}]; % blk2 - Rhem - right r = ipsi
else (disp('subjet mismatch')); end
%STN09 :: bilateral--> 2 block. no dorsal block
if strcmp(LFP(6).no, '100009')==1 %&&  ~isempty(LFP(6).ltd.incgTrl)
    stn09{1,1} = [LFP(6).ltd.incgTrl{2,1}];%LFP(6).ltd.incgTrl{3,1}]; % blk2 Lhem - left r = ipsi
    stn09{1,2} = [LFP(6).ltd.incgTrl{3,2}];%LFP(6).ltd.incgTrl{3,2}]; % blk2 Rhem  - left r = contra
    stn09{2,1} = [LFP(6).rtd.incgTrl{2,1}];%LFP(6).rtd.incgTrl{3,1}]; % blk2 Lhem - right r = contra
    stn09{2,2} = [LFP(6).rtd.incgTrl{3,2}];%LFP(6).rtd.incgTrl{3,2}]; % blk2 Rhem - right r = ipsi    
end
%STN10 :: Psuedo bilateral 3 blks. blk1_dorsal blk2_ventral left Hem blk_3
%dorsal right hem
if strcmp(LFP(7).no, '100010_a')==1 %&&  ~isempty(LFP(7).ltd.incgTrl)
    stn10_a{1,1} = [LFP(7).ltd.incgTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn10_a{2,1} = [LFP(7).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
else (disp('subjet mismatch')); end
%STN10_b :: Psuedo bilateral - right hem . blk1_dorsal
if strcmp(LFP(8).no, '100010_b')==1 %&&  ~isempty(LFP(8).ltd.incgTrl)
    stn10_b{1,2} = [LFP(8).ltd.incgTrl{1,1}]; % blk1 -Rhem - left r = contra
    stn10_b{2,2} = [LFP(8).rtd.incgTrl{1,1}]; % blk1 -Rhem - right r = ipsi
else (disp('subjet mismatch')); end
%STN11 :: bilateral-->3blocks. blk3_ventral left hem chan 1 right hem chan
%7 (tmp09) may be artificial
if strcmp(LFP(9).no, '100011')==1 %&&  ~isempty(LFP(9).ltd.incgTrl)
    stn11{1,1} = [LFP(9).ltd.incgTrl{3,1}]; % blk3 - left hem - left r = ipsi
%     stn11{1,2} = [LFP(9).ltd.incgTrl{3,2}]; % blk3 - right hem - left r = contra
    stn11{2,1} = [LFP(9).rtd.incgTrl{3,1}]; % blk3 - left hem - right r = contra
%     stn11{2,2} = [LFP(9).rtd.incgTrl{3,2}]; % blk3 - right hem - right r = ipsi     
else (disp('subjet mismatch')); end
%STN13 :: bilateral-->
if strcmp(LFP(10).no, '100013')==1 %&&  ~isempty(LFP(10).ltd.incgTrl)
    stn13{1,1} = [LFP(10).ltd.incgTrl{2,1}]; % blk2 - left hem - left r = ipsi
    stn13{1,2} = [LFP(10).ltd.incgTrl{2,2}]; % blk2 - right hem - left r = contra
    stn13{2,1} = [LFP(10).rtd.incgTrl{2,1}]; % blk2 - left hem - right r = contra
    stn13{2,2} = [LFP(10).rtd.incgTrl{2,2}]; % blk2- right hem - right r = ipsi  
else (disp('subjet mismatch')); end
%STN14 :: bilateral-->
if strcmp(LFP(11).no, '100014')==1 %&&  ~isempty(LFP(11).ltd.incgTrl)
    stn14{1,1} = [LFP(11).ltd.incgTrl{2,1}]; % blk2 - left hem - left r = ipsi
    stn14{2,1} = [LFP(11).rtd.incgTrl{2,1}]; % blk2 - left hem - right r = contra 
else (disp('subjet mismatch')); end
%STN16 :: bilateral-->
if strcmp(LFP(12).no, '100016')==1 %&&  ~isempty(LFP(5).ltd.incgTrl)
    stn16{1,1} = [LFP(12).ltd.incgTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn16{1,2} = [LFP(12).ltd.incgTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn16{2,1} = [LFP(12).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn16{2,2} = [LFP(12).rtd.incgTrl{2,2}]; % blk2 - Rhem - right r = ipsi
else (disp('subjet mismatch')); end
%STN17 :: bilateral-->
if strcmp(LFP(13).no, '100017')==1 %&&  ~isempty(LFP(5).ltd.incgTrl)
    stn17{1,1} = [LFP(13).ltd.incgTrl{2,1}]; % blk2 - Lhem - left r = ipsi
    stn17{1,2} = [LFP(13).ltd.incgTrl{2,2}]; % blk2 - Rhem - left r = contra
    stn17{2,1} = [LFP(13).rtd.incgTrl{2,1}]; % blk2 - Lhem - right r = contra
    stn17{2,2} = [LFP(13).rtd.incgTrl{2,2}]; % blk2 - Rhem - right r = ipsi
else (disp('subjet mismatch')); end
% STN18_a ::
if strcmp(LFP(14).no, '100018_a')==1 %&&  ~isempty(LFP(3).ltd.incgTrl)
    stn18_a{1,1} = [LFP(14).ltd.incgTrl{2,1}]; % blk2 Lhem- left r = ipsi
    stn18_a{2,1} = [LFP(14).rtd.incgTrl{2,1}]; % blk2 Lhem- right r = contra
else (disp('subjet mismatch')); end
% STN07_b :: right staged unilateral--> 2 blocks. blk1_striatum blk2_ventral
if strcmp(LFP(15).no, '100018_b')==1 %&&  ~isempty(LFP(4).ltd.incgTrl)
    stn18_b{1,2} = [LFP(15).ltd.incgTrl{2,1}]; % blk2 chn3 Rhem- left r = contra
    stn18_b{2,2} = [LFP(15).rtd.incgTrl{2,1}]; % blk2 chn3 Rhem- right r = ipsi
else (disp('subjet mismatch')); end
% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 STN.vIncg = [];STN.LHvincg = [];STN.RHvincg = [];
% vIncg = [stn02;stn03;stn07_a;stn07_b;stn08;stn09;stn10_a;stn10_b;stn11;stn13;stn14;stn16;stn17;stn18_a;stn18_b];
% LHVincg = {stn02{:,1}; stn07_a{:,1}; stn08{:,1}; stn09{:,1}; stn10_a{:,1}; stn11{:,1}; stn13{:,1}; stn14{:,1}; stn16{:,1}; stn17{:,1}; stn18_a{:,1}};
% RHVincg = {stn07_b{:,2}; stn08{:,2}; stn09{:,2}; stn10_a{:,2}; stn11{:,2}; stn13{:,2}; stn14{:,2}; stn16{:,2}; stn17{:,2}; stn18_b{:,2}};

[LHvincg.STN02] = fx_indvcat(stn02,STN,'LHvincg');
vincgLH.STN02 = stn02{:,1}; 

[LHvincg.STN07a] = fx_indvcat(stn07_a,STN,'LHvincg');
[RHvincg.STN07b] = fx_indvcat(stn07_b,STN,'RHvincg');
vincgLH.STN07a = stn07_a{1,1}; 
vincgRH.STN07b= stn07_b{:,2}; 

[LHvincg.STN08] = fx_indvcat(stn08,STN,'LHvincg');
[RHvincg.STN08] = fx_indvcat(stn08,STN,'RHvincg');
vincgLH.STN08= stn08{:,1}; 
vincgRH.STN08= stn08{:,2}; 

[LHvincg.STN09] = fx_indvcat(stn09,STN,'LHvincg');
[RHvincg.STN09] = fx_indvcat(stn09,STN,'RHvincg');
LHVincg.STN09 = stn09{:,1}; 
RHVcong.STN09 = stn09{:,2};

[LHvincg.STN10a] = fx_indvcat(stn10_a,STN,'LHvincg');
[RHvincg.STN10b] = fx_indvcat(stn10_b,STN,'RHvincg');
vcincgLH.STN10a = stn10_a{:,1}; 
vincgRH.STN10b = stn10_b{:,2}; 

[LHvincg.STN11] = fx_indvcat(stn11,STN,'LHvincg');
vincgLH.STN11 = stn11{:,1}; 

[LHvincg.STN13] = fx_indvcat(stn13,STN,'LHvincg');
[RHvincg.STN13] = fx_indvcat(stn13,STN,'RHvincg');
vincgLH.STN13= stn13{:,1}; 
vincgRH.STN13 = stn13{:,2}; 

[LHvincg.STN14] = fx_indvcat(stn14,STN,'LHvincg');
vincgLH.STN14 = stn14{:,1}; 

[LHvincg.STN16] = fx_indvcat(stn16,STN,'LHvincg');
[RHvincg.STN16] = fx_indvcat(stn16,STN,'RHvincg');
vincgLH.STN16 = stn16{:,1}; 
vincgRH.STN16 = stn16{:,2}; 

[LHvincg.STN17] = fx_indvcat(stn17,STN,'LHvincg');
[RHvincg.STN17] = fx_indvcat(stn17,STN,'RHvincg');
vincgLH.STN17 = stn17{:,1}; 
vincgRH.STN17 = stn17{:,2}; 

[LHvincg.STN18a] = fx_indvcat(stn18_a,STN,'LHvincg');
[RHvincg.STN18b] = fx_indvcat(stn18_b,STN,'RHvincg');
vincgLH.STN18a = stn18_a{:,1}; 
vincgRH.STN18b = stn18_b{:,2}; 
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
clear STN stn02 stn03 stn07_a stn07_b stn08 stn09 stn10_a stn10_b stn11 stn13 stn14 stn16 stn17 stn18_a stn18_b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cat subjects into struct - - - - - - - - - - - - - - - - - - - - - - - - -
condition = {'dcong'; 'dincg'; 'vcong'; 'vincg';...
    'LHdcong';'RHdcong';'LHdincg';'RHdincg';...
    'LHvcong';'RHvcong';'LHvincg';'RHvincg'};

condFld = fullfile(output,'conditions')
if ~exist(condFld, 'dir')
    mkdir(condFld)
end
k=1;
for d = 1:size(condition,1)
    fn = fieldnames(eval(condition{d}));
    [fnz] =  find(contains(fn,'STN','IgnoreCase',true));% subjects
    save(fullfile(output,'conditions', condition{d}), (condition{d}), '-v7.3');
    
    for z = 1:size(fnz,1) % subjects

        if d == 1 %&& contains(fn{fnz(z)},'STN')% dorsal congruent trials          
            dcong.Rsp{z,k} = [dcong.(fn{fnz(z)}).rsp.dCong_trl{1,k}];
            dcong.ipRsp{z,k} = [dcong.(fn{fnz(z)}).rsp.ipDcong_trl{1,k}];
            dcong.ctRsp{z,k} = [dcong.(fn{fnz(z)}).rsp.ctDcong_trl{1,k}];
            dcong.Rsp_m{z,k} = [dcong.(fn{fnz(z)}).sigrsp.dCong_trl{1,k}];
            dcong.ipRsp_m{z,k} = [dcong.(fn{fnz(z)}).sigrsp.ipDcong_trl{1,k}];
            dcong.ctRsp_m{z,k} = [dcong.(fn{fnz(z)}).sigrsp.ctDcong_trl{1,k}];
            
        elseif d == 2 %&& contains(fn{fnz(z)},'STN')% dorsal incongruent            
            dincg.Rsp{z,k}= [dincg.(fn{fnz(z)}).rsp.dIncg_trl{1,k}];
            dincg.ipRsp{z,k} = [dincg.(fn{fnz(z)}).rsp.ipDincg_trl{1,k}];
            dincg.ctRsp{z,k} = [dincg.(fn{fnz(z)}).rsp.ctDincg_trl{1,k}];
            dincg.Rsp_m{z,k}= [dincg.(fn{fnz(z)}).sigrsp.dIncg_trl{1,k}];
            dincg.ipRsp_m{z,k} = [dincg.(fn{fnz(z)}).sigrsp.ipDincg_trl{1,k}];
            dincg.ctRsp_m{z,k} = [dincg.(fn{fnz(z)}).sigrsp.ctDincg_trl{1,k}];
           
        elseif d == 3 %&& contains(fn{fnz(z)},'STN')% ventral congruent           
            vcong.Rsp{z,k}= [vcong.(fn{fnz(z)}).rsp.vCong_trl{1,k}];
            vcong.ipRsp{z,k} = [vcong.(fn{fnz(z)}).rsp.ipVcong_trl{1,k}];
            vcong.ctRsp{z,k} = [vcong.(fn{fnz(z)}).rsp.ctVcong_trl{1,k}];
            vcong.Rsp_m{z,k}= [vcong.(fn{fnz(z)}).sigrsp.vCong_trl{1,k}];
            vcong.ipRsp_m{z,k} = [vcong.(fn{fnz(z)}).sigrsp.ipVcong_trl{1,k}];
            vcong.ctRsp_m{z,k} = [vcong.(fn{fnz(z)}).sigrsp.ctVcong_trl{1,k}];           
        elseif d == 4 %&& contains(fn{fnz(z)},'STN')% ventral incongruent            
            vincg.Rsp{z,k} = [vincg.(fn{fnz(z)}).rsp.vIncg_trl{1,k}];
            vincg.ipRsp{z,k} = [vincg.(fn{fnz(z)}).rsp.ipVincg_trl{1,k}];
            vincg.ctRsp{z,k}= [vincg.(fn{fnz(z)}).rsp.ctVincg_trl{1,k}];
            vincg.Rsp_m{z,k} = [vincg.(fn{fnz(z)}).sigrsp.vIncg_trl{1,k}];
            vincg.ipRsp_m{z,k} = [vincg.(fn{fnz(z)}).sigrsp.ipVincg_trl{1,k}];
            vincg.ctRsp_m{z,k}= [vincg.(fn{fnz(z)}).sigrsp.ctVincg_trl{1,k}];            
            % hemisphere sectioneD
        elseif d == 5 %'LHdcong'
            LHdcong.Rsp{z,k} = [LHdcong.(fn{fnz(z)}).rsp.LHdcong_trl{1,k}];
            LHdcong.Rsp_m{z,k} = [LHdcong.(fn{fnz(z)}).sigrsp.LHdcong_trl{1,k}];
        elseif d == 6 %'RHdcong'
            RHdcong.Rsp{z,k} = [RHdcong.(fn{fnz(z)}).rsp.RHdcong_trl{1,k}];
            RHdcong.Rsp_m{z,k} = [RHdcong.(fn{fnz(z)}).sigrsp.RHdcong_trl{1,k}];
        elseif d == 7 %'LHdincg'
            LHdincg.Rsp{z,k} = [LHdincg.(fn{fnz(z)}).rsp.LHdincg_trl{1,k}];
            LHdincg.Rsp_m{z,k} = [LHdincg.(fn{fnz(z)}).sigrsp.LHdincg_trl{1,k}];
        elseif d == 8 %'RHdincg'
            RHdincg.Rsp{z,k} = [RHdincg.(fn{fnz(z)}).rsp.RHdincg_trl{1,k}];
            RHdincg.Rsp_m{z,k} = [RHdincg.(fn{fnz(z)}).sigrsp.RHdincg_trl{1,k}];
        elseif d == 9%'LHvcong'
            LHvcong.Rsp{z,k} = [LHvcong.(fn{fnz(z)}).rsp.LHvcong_trl{1,k}];
            LHvcong.Rsp_m{z,k} = [LHvcong.(fn{fnz(z)}).sigrsp.LHvcong_trl{1,k}];
        elseif d == 10%'RHvcong
            RHvcong.Rsp{z,k} = [RHvcong.(fn{fnz(z)}).rsp.RHvcong_trl{1,k}];
            RHvcong.Rsp_m{z,k} = [RHvcong.(fn{fnz(z)}).sigrsp.RHvcong_trl{1,k}];
        elseif d == 11'%'LHvincg'
            LHvincg.Rsp{z,k} = [LHvincg.(fn{fnz(z)}).rsp.LHvincg_trl{1,k}];
            LHvincg.Rsp_m{z,k} = [LHvincg.(fn{fnz(z)}).sigrsp.LHvincg_trl{1,k}];
        elseif d == 12%'RHvincg'
            RHvincg.Rsp{z,k} = [RHvincg.(fn{fnz(z)}).rsp.RHvincg_trl{1,k}];
            RHvincg.Rsp_m{z,k} = [RHvincg.(fn{fnz(z)}).sigrsp.RHvincg_trl{1,k}];
        end % fi
    end % 'z'
end % 'd' condition loop

%% average conditions in G groups [cue|rsp]
% padd with nans to max dim
for d = 1:size(condition,1)
    cond = eval(condition{d});
    fc = fieldnames(eval(condition{d}));
    [fnc] =  find(~contains(fc,'STN','IgnoreCase',true));
    
    for c = 1:size(fnc,1) % conditions
        
        for b = 1:size(cond.(fc{fnc(c)}),1) % blocks of trials
            vect(b,1) = size(cond.(fc{fnc(c)}){b,1},2);
        end;clear b % ~ ~ ~ ~ ~ ~ b
        
        %get max for all blocks per cond
        mVect = max(vect);
        % grab all max dims across conds...

        matcat = [];
        for b = 1:size(cond.(fc{fnc(c)}),1) % blocks of trials
            for t = 1:size(cond.(fc{fnc(c)}){b,1},1)
                tvect(t,b) = mVect-size(cond.(fc{fnc(c)}){b,1},2);
                nanpad = NaN(1,tvect(t,b));
                muaMat(t,:) = [cond.(fc{fnc(c)}){b,1}(t,:),nanpad];
            end % t
            matcat = [matcat;muaMat];
            clear nanpad
           
        end; clear b% ~ ~ ~ ~ ~ ~ b
        
        varstrg = (strcat(condition{d},'Trls_',fc(fnc(c))));
        
        G.(varstrg{1,1}) = matcat;
        clear vect mVect muaMat muaAll aveMua flipMat flipMua muaRsp avgrsp matcat
    end % 'c'
end % d condition loop
%% average conditions
fn = fieldnames(G);

for i = 1:size(fn,1)
    
    cond = fn{i};
    Gavg.(cond) = nanmean(G.(cond),1);
end
%% nanpad all - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
g = G;
gn = fieldnames(G);
for i = 1:size(gn,1)
    
    mSize(i,:) = size(G.(gn{i}),2);
    
end
mdim = max(mSize);
gvar = [];

for i = 1:size(gn,1)
    vect = mdim - size(G.(gn{i}),2);
    for t = 1:size(G.(gn{i}),1)
        
        nanpad = NaN(1,vect);
        var = G.(gn{i})(t,:);
        
        nanpad = NaN(1,vect);
        gvar(t,:) = [var, nanpad];
        %gvar = [gvar,gvar];
        % G.(gn{i})(t,1)= [G.(gn{i})(t,1),nanpad];
        clear nanpad
    end;clear t % ~ ~ ~ ~ ~ ~ t
    G.(gn{i}) = gvar;
    gvar = []; % ~ ~ ~ ~ ~ ~ ~
end


%% # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if dosave ==1
    disp(output)
    save(fullfile(output, 'G.mat'), 'G', '-v7.3');
    save(fullfile(output, 'dcong.mat'), 'dcong', '-v7.3');
    save(fullfile(output, 'dincg.mat'), 'dincg', '-v7.3');
    save(fullfile(output, 'vcong.mat'), 'vcong', '-v7.3');
    save(fullfile(output, 'vincg.mat'), 'vincg', '-v7.3');

    save(fullfile(output, 'LHdcong.mat'), 'dcong', '-v7.3');
    save(fullfile(output, 'LHdincg.mat'), 'dincg', '-v7.3');
    save(fullfile(output, 'LHvcong.mat'), 'vcong', '-v7.3');
    save(fullfile(output, 'LHvincg.mat'), 'vincg', '-v7.3');

    save(fullfile(output, 'RHdcong.mat'), 'dcong', '-v7.3');
    save(fullfile(output, 'RHdincg.mat'), 'dincg', '-v7.3');
    save(fullfile(output, 'RHvcong.mat'), 'vcong', '-v7.3');
    save(fullfile(output, 'RHvincg.mat'), 'vincg', '-v7.3');

    save(fullfile(output, 'Gavg.mat'), 'Gavg', '-v7.3');
    
end % # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #