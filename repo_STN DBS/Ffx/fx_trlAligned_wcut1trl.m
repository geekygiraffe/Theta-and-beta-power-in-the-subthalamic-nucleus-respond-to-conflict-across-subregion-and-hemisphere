function [ltdAO, ltdTime, rtdAO, rtdTime] = fx_trlAligned_wcut1trl(raw, idxTrial, aoTrl)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% function takes the ao data and assines to conditions based on ao values.
% aligned to trial onset indicated in idxTrial
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% define trial types from AO data && grab normilized times && frame numbers
%trial number, can use to index into sig index ( index an index?)
% % ltd [1 cong] [3 cong no resp] [4 incg] [6 incg no resp]
% % rtd [2 cong] [3 cong no resp] [5 incg] [6 incg no resp]
% [1 cong][2 cong error][2 cong norsp][4 incg][5 error][6 incg no resp]

% Start_Trial 1;
% Fix_On 2;
% Fix_Off 3;
% Cue_On 4;
% Cue_Off 5;
% Left_Button_On 6;
% Right_Button_On 7;
% Instructions 8;
% % ML trial start        = 9;

% :: cond type_ expected _ recieved ::
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
fn = fieldnames(raw); %raw spk data from ao
fs = 44000;
for i = 1:size(aoTrl,1)  % first trial already removed
 
%% cue for left button press - - - - - - - - - - - - - - - - - - - - - - - -
 % Cong_Left_Left          = 10; correct congruent
    if ismember(6,aoTrl{i,1}(1,:)) == 1 && ismember(10,aoTrl{i,1}(1,:)) == 1
        ltdAO{i,1} = aoTrl{i,1};
        ltdAO{i,1}(2,:) = aoTrl{i,1}(2,:);% raw time
        ltdAO{i,1}(3,:) = aoTrl{i,1}(3,:); % norm time
        ltdAO{i,1}(4,:) = aoTrl{i,1}(4,:); % true time
        ltdAO{i,1}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
        clear ttd Inan I x
        ltdAO{i,1}(6,1) = i;%trial number
        Inan = ~isnan(aoTrl{i,1}(2,:));
        I = sum(Inan);
        ltdAO{i,1}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = ltdAO{i,1}(6,2);
        ltdTime{i,1}(1,:) = [0:1/fs:x/fs]; % normalized time
%x Cong_Left_Right         = 11; error congruent
%> Cong_Right_Left         = 13;
    elseif ismember(6,aoTrl{i,1}(1,:)) == 1 && ismember(13,aoTrl{i,1}(1,:)) == 1
        ltdAO{i,2} = aoTrl{i,1};
        ltdAO{i,2}(2,:) = aoTrl{i,1}(2,:);% raw time
        ltdAO{i,2}(3,:) = aoTrl{i,1}(3,:); % norm time
        ltdAO{i,2}(4,:) = aoTrl{i,1}(4,:); % true time
        ltdAO{i,2}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
        clear ttd Inan I x
        ltdAO{i,2}(6,1) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        ltdAO{i,2}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = ltdAO{i,2}(6,2);
        ltdTime{i,2}(1,:) = [0:1/fs:x/fs]; % normalized time
% Incong_Left_Left        = 19;  correct incongruent
    elseif ismember(6,aoTrl{i,1}(1,:)) == 1 && ismember(19,aoTrl{i,1}(1,:)) == 1
        ltdAO{i,4} = aoTrl{i,1};
        ltdAO{i,4}(2,:) = aoTrl{i,1}(2,:);% raw time
        ltdAO{i,4}(3,:) = aoTrl{i,1}(3,:); % norm time
        ltdAO{i,4}(4,:) = aoTrl{i,1}(4,:); % true time
        ltdAO{i,4}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
        clear ttd Inan I x
        ltdAO{i,4}(6,1) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        ltdAO{i,4}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = ltdAO{i,4}(6,2);
        ltdTime{i,4}(1,:) = [0:1/fs:x/fs]; % normalized time
% Incong_Left_Right       = 20;  error inconguent
% > incg_Right_Left       = 22;
    elseif ismember(6,aoTrl{i,1}(1,:)) == 1 && ismember(22,aoTrl{i,1}(1,:)) == 1 
        ltdAO{i,5} = aoTrl{i,1};
        ltdAO{i,5}(2,:) = aoTrl{i,1}(2,:);% raw time
        ltdAO{i,5}(3,:) = aoTrl{i,1}(3,:); % norm time
        ltdAO{i,5}(4,:) = aoTrl{i,1}(4,:); % true time
        ltdAO{i,5}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
        clear ttd Inan I x
        ltdAO{i,5}(6,1) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        ltdAO{i,5}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = ltdAO{i,5}(6,2);
        ltdTime{i,5}(1,:) = [0:1/fs:x/fs]; % normalized time
    end % left
%% cue for right button press - - - - - - - - - - - - -
% Cong_Right_Left         = 13; error congruent
% >  Cong_Left_Right         = 11;
    if ismember(7,aoTrl{i,1}(1,:)) == 1 && ismember(11,aoTrl{i,1}(1,:)) == 1
        rtdAO{i,2}= aoTrl{i,1};
        rtdAO{i,2}(2,:) = aoTrl{i,1}(2,:);% raw time
        rtdAO{i,2}(3,:) = aoTrl{i,1}(3,:); % norm time
        rtdAO{i,2}(4,:) = aoTrl{i,1}(4,:); % true time
        rtdAO{i,2}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);% reset time
        clear ttd Inan I x
        rtdAO{i,2}(6,1) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        rtdAO{i,2}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = rtdAO{i,2}(6,2);
        rtdTime{i,2}(1,:) = [0:1/fs:x/fs]; % normalized time
 % Cong_Right_Right        = 14;  correct congruent
    elseif ismember(7,aoTrl{i,1}(1,:)) == 1 && ismember(14,aoTrl{i,1}(1,:)) == 1
        rtdAO{i,1} = aoTrl{i,1};
        rtdAO{i,1}(2,:) = aoTrl{i,1}(2,:);% raw time
        rtdAO{i,1}(3,:) = aoTrl{i,1}(3,:); % norm time
        rtdAO{i,1}(4,:) = aoTrl{i,1}(4,:); % true time
        rtdAO{i,1}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
        clear ttd Inan I x
        rtdAO{i,1}(6,1) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        rtdAO{i,1}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = rtdAO{i,1}(6,2);
        rtdTime{i,1}(1,:) = [0:1/fs:x/fs]; % normalized time
% Incg_Right_Left         = 22;        error incongruent
% >  Incg_Left_Right       = 20;
    elseif ismember(7,aoTrl{i,1}(1,:)) == 1 && ismember(20,aoTrl{i,1}(1,:)) == 1
        rtdAO{i,5} = aoTrl{i,1};
        rtdAO{i,5}(2,:) = aoTrl{i,1}(2,:);% raw time
        rtdAO{i,5}(3,:) = aoTrl{i,1}(3,:); % norm time
        rtdAO{i,5}(4,:) = aoTrl{i,1}(4,:); % true time
        rtdAO{i,5}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);% reset time
        clear ttd Inan I x
        rtdAO{i,5}(6,1) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        rtdAO{i,5}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1) % frame difference
        x = rtdAO{i,5}(6,2);
        rtdTime{i,5}(1,:) = [0:1/fs:x/fs]; % normalized time
% Incong_Right_Right      = 23;        correct incongruent
    elseif ismember(7,aoTrl{i,1}(1,:)) == 1 && ismember(23,aoTrl{i,1}(1,:)) == 1
        rtdAO{i,4} = aoTrl{i,1};
        rtdAO{i,4}(2,:) = aoTrl{i,1}(2,:);% raw time
        rtdAO{i,4}(3,:) = aoTrl{i,1}(3,:); % norm time
        rtdAO{i,4}(4,:) = aoTrl{i,1}(4,:); % true time
        rtdAO{i,4}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);% reset time

        clear ttd Inan I x
        rtdAO{i,4}(6,1) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        rtdAO{i,4}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = rtdAO{i,4}(6,2);
        rtdTime{i,4}(1,:) = [0:1/fs:x/fs]; % normalized time
    end % right
%% no button press 
% Cong_Left_NoResp        = 12; no response congruent
    if ~ismember(6,aoTrl{i,1}(1,:)) == 1 && ~ismember(7,aoTrl{i,1}(1,:)) == 1 && ismember(12,aoTrl{i,1}) == 1 
        ltdAO{i,3} = aoTrl{i,1}(:,1:end);% @end-1
        ltdAO{i,3}(2,:) = aoTrl{i,1}(2,1:end);% raw time @end-1
        ltdAO{i,3}(3,:) = aoTrl{i,1}(3,1:end); % norm time @end-1
        ltdAO{i,3}(4,:) = aoTrl{i,1}(4,1:end); % true time  @end-1
        %ltdAO{i,3}(5,:)  = aoTrial{i,1}(4,:) - aoTrial{i,1}(4,1);% reset time
        % reset time
%        ttd = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
%         if isnan(ttd(end)) == 1
%             ltdAO{i,3}(5,:)  = aoTrl{i,1}(4,1:end-1) - aoTrl{i,1}(4,1);
%         elseif isnan(ttd(end-1)) == 1
%             ltdAO{i,1}(5,:)  = aoTrl{i,1}(4,1:end-2) - aoTrl{i,1}(4,1);
%         else
            ltdAO{i,3}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);% reset time
        %end
        clear ttd Inan I x
        ltdAO{i,3}(6,1) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        ltdAO{i,3}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1) ;% frame difference
        x = ltdAO{i,3}(6,2);
        ltdTime{i,3}(1,:) = [0:1/fs:x/fs]; % normalized time
% Incong_Left_NoResp      = 21;  no response incongruent
    elseif ~ismember(6,aoTrl{i,1}(1,:)) == 1 && ~ismember(7,aoTrl{i,1}(1,:)) == 1 && ismember(21,aoTrl{i,1}(1,:)) == 1
        ltdAO{i,6} = aoTrl{i,1}(:,1:end); % @end-1
        ltdAO{i,6}(2,:) = aoTrl{i,1}(2,1:end); % raw time @end-1
        ltdAO{i,6}(3,:) = aoTrl{i,1}(3,1:end); % norm time @end-1
        ltdAO{i,6}(4,:) = aoTrl{i,1}(4,1:end); % true time @end-1
        % reset time
%        ttd = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
%         if isnan(ttd(end)) == 1
%             ltdAO{i,6}(5,:)  = aoTrl{i,1}(4,1:end-1) - aoTrl{i,1}(4,1);% reset time
%         elseif isnan(ttd(end-1)) == 1
%             ltdAO{i,1}(5,:)  = aoTrl{i,1}(4,1:end-2) - aoTrl{i,1}(4,1);    
%         else
            ltdAO{i,6}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);% reset time
        %end
        clear ttd Inan I x
        ltdAO{i,6}(6,1) = i; %trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        ltdAO{i,6}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = ltdAO{i,6}(6,2);
        ltdTime{i,6}(1,:) = [0:1/fs:x/fs]; % normalized time
% Cong_Right_NoResp       = 15;  no response congruent
    elseif ~ismember(6,aoTrl{i,1}(1,:)) == 1 && ~ismember(7,aoTrl{i,1}(1,:)) == 1 && ismember(15,aoTrl{i,1}(1,:)) == 1 
        rtdAO{i,3} = aoTrl{i,1}(:,1:end); % @end-1
        rtdAO{i,3}(2,:) = aoTrl{i,1}(2,1:end);% raw time @end-1
        rtdAO{i,3}(3,:) = aoTrl{i,1}(3,1:end); % norm time @end-1
        rtdAO{i,3}(4,:) = aoTrl{i,1}(4,1:end); % true time @end-1
        % reset time
%        ttd = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
%         if isnan(ttd(end)) == 1
%             rtdAO{i,3}(5,:)  = aoTrl{i,1}(4,1:end-1) - aoTrl{i,1}(4,1);% reset time
%         elseif isnan(ttd(end-1)) == 1
%             rtdAO{i,1}(5,:)  = aoTrl{i,1}(4,1:end-2) - aoTrl{i,1}(4,1);    
%         else
            rtdAO{i,3}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);% reset time
        %end
        clear ttd Inan I x
        rtdAO{i,3}(6,:) = i;%trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        rtdAO{i,3}(6,2) = aoTrl{i,1}(2,I) -aoTrl{i,1}(2,1); % frame difference
        x = rtdAO{i,3}(6,2);
        rtdTime{i,3}(1,:) = [0:1/fs:x/fs]; % normalized time
% Incong_Left_NoResp      = 24;      no response incongruent  
    elseif ~ismember(6,aoTrl{i,1}(1,:)) == 1 && ~ismember(7,aoTrl{i,1}(1,:)) == 1 && ismember(24,aoTrl{i,1}(1,:)) == 1
        rtdAO{i,6} = aoTrl{i,1}(:,1:end); % @end-1
        rtdAO{i,6}(2,:) = aoTrl{i,1}(2,1:end);% raw time @end-1
        rtdAO{i,6}(3,:) = aoTrl{i,1}(3,1:end); % norm time @end-1
        rtdAO{i,6}(4,:) = aoTrl{i,1}(4,1:end); % true time @end-1
        
%        ttd = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);
%         if isnan(ttd(end)) == 1
%             rtdAO{i,6}(5,:)  = aoTrl{i,1}(4,1:end-1) - aoTrl{i,1}(4,1);% reset time
%         elseif isnan(ttd(end-1)) == 1
%             rtdAO{i,1}(5,:)  = aoTrl{i,1}(4,1:end-2) - aoTrl{i,1}(4,1);    
%         else
            rtdAO{i,6}(5,:)  = aoTrl{i,1}(4,:) - aoTrl{i,1}(4,1);% reset time
        %end
        %rtdAO{i,6}(5,:)  = aoTrial{i,1}(4,:) - aoTrial{i,1}(4,1);% reset time
        clear ttd Inan I x
        rtdAO{i,6}(6,:) = i; % define trial number
        I = sum(~isnan(aoTrl{i,1}(2,:)));
        rtdAO{i,1}(6,2) = aoTrl{i,1}(2,I) - aoTrl{i,1}(2,1); % frame difference
        x = rtdAO{i,6}(6,2);
        rtdTime{i,6}(1,:) = [0:1/fs:x/fs]; % normalized time
    end % no resp _________________________________________________________
end % trials ______________________________________________________________

end
%--------------------------------------------------------------------------
