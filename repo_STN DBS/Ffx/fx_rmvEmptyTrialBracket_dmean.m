function [data] = fx_rmvEmptyTrialBracket_dmean(data)
%
% function removes empty trial shells and renames variables

% ------------------------------------------------------------------------
%data = ltd;
% net baseline & ao data && full signal 'rspk'
for s = 1:size(data,2) %subject
    for b = 1:size(data(s).bline,1) % block
              
        if ~isempty(data(s).bline{b,1}) && isstruct(data(s).bline{b,1})
           
            
                cn = fieldnames(data(s).bline{b,1});
            %cn = fieldnames(data(s).baod{b,1});
            
            for k = 1:size(cn,1)  % channel
                count = 0; % ~ ~ ~ ~ ~ ~ ~
                for t = size(data(s).bline{b,1}.(cn{k}),1):-1:1 %trial
                    
                    %for i = size(data,2):-1:1
                    if ~isempty(data(s).bline{b,1}.(cn{k}){t,1})
                        count = count+1;
                        data(s).Base{b,k}{count,1} = data(s).bline{b,1}.(cn{k}){t,1};
                        data(s).btime{b,k}{count,1} = data(s).baod{b,1}{t,1};
                        %disp(s);disp(b);disp(k);disp(t);
%                        data(s).rtime{b,1}{count,:} = data(s).rTime{b,1}{t,:};
                    end %fi
                end % t
            end %k
%         % full signal
%         elseif ~isempty(data(s).bline{b,1}) && ~isstruct(data(s).bline{b,1})
%             for c = 1:size(data(s).bline,2) % channel
%                 for r = 1:size(data(s).bline{b,c},2) % cond
%                     count = 0; % ~ ~ ~ ~ ~ ~ ~
%                     for t = size(data(s).bline{b,c},1):-1:1 %trial
%                         if ~isempty(data(s).bline{b,c}{t,r})
%                             count = count+1;
%                             data(s).Base{b,c}{count,r} = data(s).bline{b,c}{t,r};
%                             %data(s).btime{b,c}{count,r} = data(s).baod{b,c}{t,r};
%                         end %fi
%                     end % t
%                 end %r
%             end % c
        end %fi
    end % b
end %s

% cong baseline
for s = 1:size(data,2) %subject
    if isfield(data(s),'bcong')
        for b = 1:size(data(s).bcong,1) % block
            if ~isempty(data(s).bcong{b,1})%if ~isempty(data(s).bline{b,1})
                cn = fieldnames(data(s).bcong{b,1});
                for k = 1:size(cn,1)  % channel
                    count = 0; % ~ ~ ~ ~ ~ ~ ~
                    for t = size(data(s).bcong{b,1}.(cn{k}),1):-1:1 %trial
                        
                        %for i = size(data,2):-1:1
                        if ~isempty(data(s).bcong{b,1}.(cn{k}){t,1})
                            count = count+1;
                            data(s).Bcong{b,k}{count,1} = data(s).bcong{b,1}.(cn{k}){t,1};
                            %data(s).rtcong{b,k}{count,:} = data(s).rTime{b,1}{t,:}; % ?
                        end %fi
                    end % t
                end %k
            end %fi
        end % b
    end % fi check for rspk input
end %s
%incg baseline
for s = 1:size(data,2) %subject
    if isfield(data(s),'bincg')
        for b = 1:size(data(s).bincg,1) % block
            if ~isempty(data(s).bincg{b,1})%if ~isempty(data(s).bline{b,1})
                cn = fieldnames(data(s).bincg{b,1});
                for k = 1:size(cn,1)  % channel
                    count = 0; % ~ ~ ~ ~ ~ ~ ~
                    for t = size(data(s).bincg{b,1}.(cn{k}),1):-1:1 %trial
                        
                        %for i = size(data,2):-1:1
                        if ~isempty(data(s).bincg{b,1}.(cn{k}){t,1})
                            count = count+1;
                            data(s).Bincg{b,k}{count,1} = data(s).bincg{b,1}.(cn{k}){t,1};
                             %data(s).rtincg{b,k}{count,:} = data(s).rTime{b,1}{t,:}; % ?
                        end %fi
                    end % t
                end %k
            end% fi
        end % b
    end % fi for bug check input rsppk
end %s

% test jlb
% % % for s = 1:size(data,2)
% % %     
% % %     data(s).base = data(s).Base;
% % %     data(s).bcong = data(s).Bcong;
% % %     data(s).bincg = data(s).Bincg;
% % %    
% % % end % s
% % % vars = {'Bcong','Bincg','Base'};
% % % data = rmfield(data, vars);


end % fx