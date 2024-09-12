function [data] = fx_trialRTcalc(data)
% fucntion calculates RT per trial between behavioral markers 4 & 5

% cong
for s = 1:size(data,2)%subject loop
    for b = 1:size(data(s).congTrig,1) % block
        if ~isempty(data(s).congTrig{b,1})
            for t = 1:size(data(s).congTrig{b,1}(:,1),1) % trial

                if ~isempty(data(s).congTrig{b,1}{t,1}) %&& size(data(s).AO{b,1}{t,r},2) > 6
                    %disp(s);disp(b);disp(r);disp(t);
                    % s=1;b=2;r=1;t=1;
                    cueONidx = find(data(s).congTrig{b,1}{t,1}(1,:) == 4);
                    cueOFFidx = find(data(s).congTrig{b,1}{t,1}(1,:) == 5);

                    cue = data(s).congTrig{b,1}{t,1}(3,cueONidx); % cue onset '4'
                    rTime = data(s).congTrig{b,1}{t,1}(3,cueOFFidx); % trial onset '9'

                    I =  rTime - cue; %find diff
                    %                     cuesig{b,t}(:,r) = I;
                    %data(s).rTime{b,t}(:,1) = I;
                    data(s).congRT{b,1}{t,1} = I;
                    % ~ ~ ~ ~ ~ ~ ~
                    clear cue tstart I cuesig cueONidx cueOFFidx
                end % fi empty trial qualifier
            end % trial 't'
            %clear t
        %clear r
    end % fi empty block qualifier
end % block 'b'
%clear b
end %subject loop

% incg
for s = 1:size(data,2)%subject loop
    for b = 1:size(data(s).incgTrig,1) % block
        if ~isempty(data(s).incgTrig{b,1})
            for t = 1:size(data(s).incgTrig{b,1}(:,1),1) % trial

                if ~isempty(data(s).incgTrig{b,1}{t,1}) %&& size(data(s).AO{b,1}{t,r},2) > 6
                    %disp(s);disp(b);disp(r);disp(t);
                    % s=1;b=2;r=1;t=1;
                    cueONidx = find(data(s).incgTrig{b,1}{t,1}(1,:) == 4);
                    cueOFFidx = find(data(s).incgTrig{b,1}{t,1}(1,:) == 5);

                    cue = data(s).incgTrig{b,1}{t,1}(3,cueONidx); % cue onset '4'
                    rTime = data(s).incgTrig{b,1}{t,1}(3,cueOFFidx); % trial onset '9'

                    I =  rTime - cue; %find diff
                    %                     cuesig{b,t}(:,r) = I;
                    %data(s).rTime{b,t}(:,1) = I;
                    data(s).incgRT{b,1}{t,1} = I;
                    % ~ ~ ~ ~ ~ ~ ~
                    clear cue tstart I cuesig cueONidx cueOFFidx
                end % fi empty trial qualifier
            end % trial 't'
            %clear t
    end % fi empty block qualifier
end % block 'b'
%clear b
end %subject loop

end















































%{

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% function takes the subject data, reads the AO fieldname and finds the
% difference between the trial start and cue onset. Also removes all empty
% rows in AO data to have compressed trials (rows) conditions(columns)
% ltd - [1 cong correct] [2 cong error][3 cong no resp] [4 incg correct] [5 incg error] [6 incg no resp]
% rtd - [1 cong] [2 cong error][3 cong no resp] [4 incg] [5 incg error] [6 incg no resp]

% CONG - [1 cong] [2 cong error][3 cong noresp]
% INCG - [1 incg] [2 incg error] [3 incg noresp]
% output # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
% returns a time vector for trial aligned data with empty trials removed [data.time]
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

for s = 1:size(data,2)%subject loop
    for b = 1:size(data(s).AO,1) % block
        if ~isempty(data(s).AO{b,1})
        r1 = 0; r2 = 0; r3 = 0; r4 = 0; r5 = 0; r6 = 0;
        for r = 1:size(data(s).AO{b,1},2) % response type
            for t = 1:size(data(s).AO{b,1}(:,r),1) % trial
                
                
                if ~isempty(data(s).AO{b,1}{t,r}) %&& size(data(s).AO{b,1}{t,r},2) > 6 
                    %disp(s);disp(b);disp(r);disp(t); 
                    % s=1;b=2;r=1;t=1;
     cueONidx = find(data(s).AO{b,1}{t,r}(1,:) == 4);
     cueOFFidx = find(data(s).AO{b,1}{t,r}(1,:) == 5);
                    
                    cue = data(s).AO{b,1}{t,r}(3,cueONidx); % cue onset '4'
                    rTime = data(s).AO{b,1}{t,r}(3,cueOFFidx); % trial onset '9'
                    
                    I =  rTime - cue; %find diff
%                     cuesig{b,t}(:,r) = I;
                    %data(s).rTime{b,t}(:,1) = I;
                    data(s).rTime{b,1}{t,r} = I;
                    % ~ ~ ~ ~ ~ ~ ~
                    clear cue tstart I cuesig cueONidx cueOFFidx 
                end % fi empty trial qualifier

                
            end % trial 't'
            %clear t
        end % response type 'r'
        %clear r
        end % fi empty block qualifier
    end % block 'b'
    %clear b
end %subject loop

% reverse and remove empty
%%
for s = 1:size(data,2)
    for b = 1:size(data(s).rTime,1)
        if ~isempty(data(s).rTime{b,1})
            for r = 1:size(data(s).rTime{b,1},2)
                trm2 = 0; trm1 = 0;
                for t = 1:size(data(s).rTime{b,1},1)
                    % cong
                    if r == 1 && ~isempty(data(s).rTime{b,1}{t,1})
                        data(s).RTcong{b,1}{t-trm1,1} = data(s).rTime{b,1}{t,1};
                    elseif r == 1 && isempty(data(s).rTime{b,1}{t,1})
                        trm1 = trm1+1;
                    end
                    % incg
                    if r == 4 && ~isempty(data(s).rTime{b,1}{t,4})
                        data(s).RTincg{b,1}{t-trm2,1} = data(s).rTime{b,1}{t,4};
                    elseif r == 4 && isempty(data(s).rTime{b,1}{t,4})
                        trm2 = trm2+1;
                    end
                end % 't'
                clear t
            end % 'r'
        end % fi
    end %'b'
end %'s'
%%
%}