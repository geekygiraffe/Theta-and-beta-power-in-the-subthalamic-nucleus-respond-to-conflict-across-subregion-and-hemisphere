function [AObsl,bslTime] = fx_bslAligned(raw, idxTrial, aoBsl)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% function takes the ao data and assines to conditions based on ao values.
% aligned to trial onset indicated in idxTrial
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% define trial types from AO data && grab normilized times && frame numbers
%trial number, can use to index into sig index ( index an index?)
% % ltd [1 cong] [3 cong no resp] [4 incg] [6 incg no resp]
% % rtd [2 cong] [3 cong no resp] [5 incg] [6 incg no resp]
% [1 cong][2 cong error][2 cong norsp][4 incg][5 error][6 incg no resp]

%
% Start_Trial 1;
% Fix_On 2;
% Fix_Off 3;
% Cue_On 4;
% Cue_Off 5;
% Left_Button_On 6;
% Right_Button_On 7;
% Instructions 8;
% % ML trial start        = 9;

% Cong_Left_Left          = 10;
% Cong_Left_Right         = 11;
% Cong_Left_NoResp        = 12;
% Cong_Right_Left         = 13;
% Cong_Right_Right        = 14;
% Cong_Right_NoResp       = 15;

% Abort_Early_Left       = 16;
% Abort_Early_Right      = 17;
 
% % ML trial end          = 18;

% Incg_Left_Left        = 19;
% Incg_Left_Right       = 20;
% Incg_Left_NoResp      = 21;
% Incg_Right_Left       = 22;
% Incg_Right_Right      = 23;
% Incg_Right_NoResp     = 24;

% End_Trial               = 25;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% trial by trial baseline definition - frame and time in matrix
% normalize the frames to get a normalized time 
% perform on windowed baseline (aoBsl{i,4}) whole window is in aoBsl{i,1}
%                 bslFrame = []; bslTime = []; % ~ ~ ~ ~ ~ ~ ~
%                 for i = 2:length(aoBsl)
%                     tmpfrm = aoBsl{i,4}(2,:);
%                     bslFrame = [bslFrame; tmpfrm];
%                     tmptme = aoBsl{i,4}(4,:);
%                     bslTime = [bslTime; tmptme];
%                 end % i
%                 
%                 for g = 1:size(bslTime,1)
%                     for h = 1:size(bslTime,2)
%                 
%                         tare = bslTime(1,1);
%                         
%                         normbTime(g,h) = bslTime(g,h) - tare;
%                         
%                     end % h
%                 end % g
%                 
                
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

fn = fieldnames(raw); %raw spk data from ao
fs = 44000;
%column four is the cut baseline data to match a window size [-500:-100]
%set above in script
%column 1 is the full baseline signal
% cut first trial 
idt = idxTrial(2:end,:);%cut first trial
for i = 1:size(idt,1) 
    
        AObsl{i,1} = aoBsl{i,1};
        AObsl{i,1}(2,:) = aoBsl{i,1}(2,:);% raw time
        AObsl{i,1}(3,:) = aoBsl{i,1}(3,:); % norm time
        AObsl{i,1}(4,:) = aoBsl{i,1}(4,:); % true time
        
        % reset time
        ttd = aoBsl{i,1}(5,:) - aoBsl{i,1}(5,1);
        if isnan(ttd(end)) == 1
            AObsl{i,1}(6,:)  = aoBsl{i,1}(5,1:end-1) - aoBsl{i,4}(5,1);
        else
            AObsl{i,1}(6,:)  = aoBsl{i,1}(5,:) - aoBsl{i,1}(5,1);
        end
        clear ttd Inan I x
         AObsl{i,1}(7,1) = i;%trial number
   
         

        I = sum(~isnan(aoBsl{i,1}(2,:)));
        AObsl{i,1}(7,2) = aoBsl{i,1}(2,I) -aoBsl{i,1}(2,1); % frame difference
        x = AObsl{i,1}(7,2);
        bslTime{i,1}(1,:) = [0:1/fs:x/fs]; % normalized time
end
%--------------------------------------------------------------------------
