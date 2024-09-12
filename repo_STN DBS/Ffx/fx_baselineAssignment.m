function [base dbase] = fx_baselineAssignment (AOdata,raw,chanSat,demean)    
%[dmean_baseline,baseDM]
%     AOdata = AObsl;
%     spk = spk;
%     subject = t;
%     block = r;
%     file = f;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% function reads in spide data and AO trials info, cuts data into
%trial types [cong|incg]
% ltd [1 cong] [2 cong error][3 cong no resp] [4 incg] [5 incg error] [6 incg no resp]
% rtd [1 cong] [2 cong error][3 cong no resp] [4 incg] [5 incg error] [6 incg no resp]
%t = subject
%r = block
%f = file
%spk = unfiltered spike data
% AOdata = 
%   row 1 markers in data corresponding to ML behavior
%   row 2 frame time
%   row 3 % normalized to fs
%   row 4 time relative to start
%   row 5 time relative to each trial
%   row 6 = trial number

% CONG [1 cong] [2 cong error][3 cong noresp] 
% INCG [1 incg] [2 incg error] [3 incg noresp]
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
D = size(AOdata,2); % trials

                fn = []; k = []; % ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
                fn = fieldnames(raw);
                %fnn = fieldnames(netChan);
                %sn = find(contains(fnn,'_dmean'));
                dn = fieldnames(demean);
                for k = 1:size(fn,1)
                    
                    if(isnumeric(raw.(fn{k})))
                        % eliminate files with less data
                        
                        % on select channels
                        tsk = raw.(fn{k}); % raw
                        
                        if D >=1
                            counter = 0; i = [];% ~ ~ ~ ~ ~ ~ ~
                            for i = 1:size(AOdata,1)
                                if ~isempty(AOdata{i,1}) == 1
                                    counter = counter + 1;
                                     if size(tsk,2) < AOdata{i,1}(2,1) || size(tsk,2) < AOdata{i,1}(2,2)
%                                         %
                                         baseline{counter,1} = NaN;
                                    else
                                    baseline{counter,1} = tsk(1,AOdata{i,1}(2,1):AOdata{i,1}(2,end));
%                                    t_ltd.cong{counter,2} = tsk(1,ltdAO{i,1}(4,1):ltdAO{i,1}(4,end));
                                     end % fi size tsk
                                end % size ao data exists
                            end % 'i'
                        end % D

                        base.(fn{k}) = baseline;
                        
                    end % fi
                end % k

%{                
%                 %% demean channels
%                 for m = 1:size(sn,1)
%                     
%                     snf = (char(fnn(sn(m))));
%                     
%                     if isnumeric(netChan.(snf))
%                         % eliminate files with less data
%                         
%                         % on select channels
%                         msk = netChan.(snf); % demean channel 
%                         
%                         if D >=1
%                             counter = 0; i = [];% ~ ~ ~ ~ ~ ~ ~
%                             for i = 1:size(AOdata,1)
%                                 if ~isempty(AOdata{i,1}) == 1
%                                     counter = counter + 1;
%                                     if size(msk,2) < AOdata{i,1}(2,1) || size(msk,2) < AOdata{i,1}(2,2)
%                                         %
%                                         dmean_baseline{counter,1} = [];
%                                     else
%                                     dmean_baseline{counter,1} = msk(1,AOdata{i,1}(2,1):AOdata{i,1}(2,end));
% %                                    t_ltd.cong{counter,2} = tsk(1,ltdAO{i,1}(4,1):ltdAO{i,1}(4,end));
%                                     end
%                                 end
%                             end
%                         end
% 
%                         
%                         baseDM.(snf) = dmean_baseline;
%                         
%                     end % fi
%                 end % m
%}
%% demean channels

for k = 1:size(dn,1)
    
    if(isnumeric(demean.(dn{k})))
        % eliminate files with less data
        
        % on select channels
        tsk = demean.(dn{k}); % raw
        
        if D >=1
            counter = 0; i = [];% ~ ~ ~ ~ ~ ~ ~
            for i = 1:size(AOdata,1)
                if ~isempty(AOdata{i,1}) == 1
                    counter = counter + 1;
                    if size(tsk,2) < AOdata{i,1}(2,1) || size(tsk,2) < AOdata{i,1}(2,2)
                        %
                        dbaseline{counter,1} = NaN;
                    else
                        dbaseline{counter,1} = tsk(1,AOdata{i,1}(2,1):AOdata{i,1}(2,end));
                        %                                    t_ltd.cong{counter,2} = tsk(1,ltdAO{i,1}(4,1):ltdAO{i,1}(4,end));
                    end % sz tsk
                end % aodata exists
            end % 'i'
        end % 'D'
        
        dbase.(dn{k}) = dbaseline;
        
    end % fi
end % k

                    %snf = (char(fnn(dn(m))));
                    if size(dn,1) <2 && contains(dn,'uni')%size(dn,1) ==1 &&
                        % on demeaned channels unilateral
                        msk(1,:) = demean.uni; % demean channel 
                    else
                        % on demeaned channels bilateral
                        if contains(dn(1,1),'bilLH')
                            msk(1,:) = demean.bilLH;
                        end
                        
                        if size(dn,1) >1 && contains(dn(2,1),'bilRH')
                            if size(demean.bilRH,2) ~= size(msk,2)
                                tmsk = msk; 
                                clear msk
                                if size(demean.bilRH,2) > size(tmsk,2)
                                    zpad = zeros(1,size(demean.bilRH,2) - size(tmsk,2));
                                    msk(1,:)= [tmsk,zpad];
                                elseif size(demean.bilRH,2) < size(tmsk,2) %msk
                                    zpad = zeros(1,size(size(tmsk,2)-demean.bilRH,2));
                                    msk(2,:) = [demean.bilRH,zpad];
                                end
                                clear zpad tmsk
                            else % fi sz ~=
                                msk(2,:) = demean.bilRH;
                            end % 
                        end % sz dn
                    end
                    for m = 1:size(msk,1)
                        if D >=1
                            counter = 0; i = [];% ~ ~ ~ ~ ~ ~ ~
                            for i = 1:size(AOdata,1)
                                if ~isempty(AOdata{i,1}) == 1
                                    counter = counter + 1;
                                    if size(msk(m,:),2) < AOdata{i,1}(2,1) || size(msk(m,:),2) < AOdata{i,1}(2,2)
                                        dmean_baseline{counter,m} = [];
                                    else
                                        dmean_baseline{counter,m} = msk(m,AOdata{i,1}(2,1):AOdata{i,1}(2,end));
                                        % t_ltd.cong{counter,2} = tsk(1,ltdAO{i,1}(4,1):ltdAO{i,1}(4,end));
                                    end % fi conditional size of signal and trial marker
                                end % fi qualifier AO not empty
                            end % 'i' trial
                        end % fi qualifier trials ao
                    end % 'm'
                    
                    if size(dn,1) <2 && strcmpi(dn(1,1),'uni')
                        %if strcmpi(dn(1,1),'uni')%size(dn,1) ==1
                        dbase.uni = dmean_baseline;
                    elseif size(dn,1) >1
                        if strcmpi(dn(1,1),'bilLH') %&& %size(dn,1) ==2 && m ==1
                            dbase.bilLH = dmean_baseline(:,1);end
                        if strcmpi(dn(2,1),'bilRH')%size(dn,1) ==2 && m ==2
                            dbase.bilRH = dmean_baseline(:,2);end
                    end

                            %baseDM.(snf) = dmean_baseline;
                    
end