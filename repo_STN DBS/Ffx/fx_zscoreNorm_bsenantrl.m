function [SIG] = fx_zscoreNorm_bsenantrl(SIG)

% [output]
% col 1 :: non-normalized signal
% col 2 :: zscore-normalized signal
% col 3 :: baseline-normalized signal
%% find index of nan markk pad (nan(10,1) that denotes switch between baseine and trial
var = {'ltd' 'rtd'};
cvar = {'congTrl' 'incgTrl'};
for s = 1:size(SIG,2)
    for v = 1:size(var,2)
        for c = 1:size(cvar,2) % NEED TO INSERT HEMISPHERE
            for b = 1:size(SIG(s).(var{v}).(cvar{c}),1)
                for h = 1:size(SIG(s).(var{v}).(cvar{c}),2)
                    for t = 1:size(SIG(s).(var{v}).(cvar{c}){b,h},1)
                       
                        fsig = SIG(s).(var{v}).(cvar{c}){b,h}{t,1};
                        [idx] = find(isnan(fsig));
                        %                     disp(s); disp(v); disp(c); disp(b); disp(t);
                        %                     s = 1; v = 2; c = 1; b = 2; t = 1;
                        if idx(1,1) > 300

                            trl = fsig(1,1:idx(1,1)-1);

                            if size(trl,2) >= 300
                                cut = trl(:,1:300);
                                alignT = flip(cut);
                                %datcat{i,2} = alignT;
                                plusbase = 0;
                            else
                                addpadd = 300- size(trl,2);
                                alignT = flip(trl);
                                plusbase = 1;
                                %will add extra baseline below
                            end % fi size trl

                            if size(idx,2) == 10
                                bse = fsig(1,idx(1,10)+1:end);
                                bse(isnan(bse)) = [];
                                if size(bse,2) > 402
                                    alignB = bse(1,1:end-101);
                                else
                                    bpad = abs(size(bse,2) - 300);
                                    alignB = bse(1,1:end-bpad);
                                    %datcat{i,1} = bse(end-480:end-101);%(102:end);
                                end
                            elseif size(idx,2) > 10
                                bse = fsig(1,idx(1,10)+1:idx(1,11)-1);
                                bse(isnan(bse)) = [];
                                alignB = bse;
                            end

                            %                                 if plusbase == 1 && size(bse,2) >= addpadd
                            %                                     padT = [alignT,bse(1,1:addpadd)];
                            %                                     datcat{i,2} = padT;
                            %                                 else
                            %                                     datacat{i,2} = alignT;
                            %                                 end % size base

                            %         clear t b addpadd patT plusbase% ~ ~ ~ ~ ~
                            SIG(s).(var{v}).rTrial{b,h}{t,1} = alignT;
                            SIG(s).(var{v}).bTrial{b,h}{t,1} = alignB;
                        end % fi
                    
                    end % t
                end % h
            end %'b'
        end %'c'
    end %'v'
end % s


%%
%% calculate mu & sigma per baseline trial 
% per cond & subject.hemi,blck,cond [cong|incg]


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% left base
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(SIG,2)
    for b = 1:size(SIG(s).ltd.bTrial,1)
        for h = 1:size(SIG(s).ltd.bTrial,2)
        %for c = 1:size(SIG(s).ltd.bTrial,2)
            if ~isempty(SIG(s).ltd.bTrial{b,h})
                
                for t = 1:size(SIG(s).ltd.bTrial{b,h},1)
                    SIG(s).ltd.MeanBase{b,h}{t,1} = nanmean(SIG(s).ltd.bTrial{b,h}{t,1});
                    SIG(s).ltd.StdBase{b,h}{t,1} = nanstd(SIG(s).ltd.bTrial{b,h}{t,1});
                end % t
                clear t
               
                SIG(s).ltd.mu{b,h} = nanmean(cell2mat(SIG(s).ltd.MeanBase{b, h}));
                SIG(s).ltd.sigma{b,h} = nanstd(cell2mat(SIG(s).ltd.MeanBase{b, h}));
                
            end %fi
        %end %c
        clear c
        end %h
        clear h
    end % b
    clear b
end % s% s
clear s
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % right base
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for s = 1:size(SIG,2)
        for b = 1:size(SIG(s).rtd.bTrial,1)
            for h = 1:size(SIG(s).rtd.bTrial,2)
                for c = 1:size(SIG(s).rtd.bTrial,2)
                    if ~isempty(SIG(s).rtd.bTrial{b,h})

                        for t = 1:size(SIG(s).rtd.bTrial{b,h},1)
                            SIG(s).rtd.MeanBase{b,h}{t,1} = nanmean(SIG(s).rtd.bTrial{b,h}{t,1});
                            SIG(s).rtd.StdBase{b,h}{t,1} = nanstd(SIG(s).rtd.bTrial{b,h}{t,1});
                        end % t
                        clear t

                        SIG(s).rtd.mu{b,h} = nanmean(cell2mat(SIG(s).rtd.MeanBase{b,h}));
                        SIG(s).rtd.sigma{b,h} = nanstd(cell2mat(SIG(s).rtd.MeanBase{b,h}));
                    end %fi
                end %c
                clear c
            end % h
            clear h
        end % b
        clear b
    end % % s
    clear s
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% full signal base
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(SIG,2)
    for b = 1:size(SIG(s).rspk.lfp,1)
        for h = 1:size(SIG(s).rspk.lfp,2)
            if ~isempty(SIG(s).rspk.lfp{b,h})
                SIG(s).rspk.mu{b,h}(:,1) = nanmean(SIG(s).rspk.lfp{b,h}(:,1));
                SIG(s).rspk.sigma{b,h}(:,1) = nanstd(SIG(s).rspk.lfp{b,h}(:,1));
            end % fi
        end % h
        clear h
    end % b
end % s
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%% baseline-normalized signal
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% left cong
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(SIG,2)
    for b = 1:size(SIG(s).ltd.rTrial,1)
        for h = 1:size(SIG(s).ltd.rTrial,2)
        %for c = 1%:size(MUA(s).ltd.congTrl,2)
            if ~isempty(SIG(s).ltd.rTrial{b,h})
                for t = 1:size(SIG(s).ltd.rTrial{b,h},1)
                    %!% can add in dimension for error and no response 
                    %trial col 1 == correct
                    for v = 1:size(SIG(s).ltd.rTrial{b,h}{t,1},2) % vector value
                        if ~isempty(SIG(s).ltd.bTrial{b,h})
                        mu = SIG(s).ltd.mu{b,h};
                        sigma = SIG(s).ltd.sigma{b,h};
                        point = SIG(s).ltd.rTrial{b,h}{t,1}(1,v);
                        SIG(s).ltd.zcong{b,h}{t,1}(1,v) = (point-mu)/sigma;
                        end % fi empty base
                    end % v
                    clear v
                end % t
                clear t
            end %fi
       % end % c
        clear c
        end %h
        clear h
    end % b
    clear b
end % s
clear s

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% left incg
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(SIG,2)
    for b = 1:size(SIG(s).ltd.rTrial,1)
        for h = 1:size(SIG(s).ltd.rTrial,2)
        %for c = 2%1:size(MUA(s).ltd.incgTrl,2)
            if ~isempty(SIG(s).ltd.rTrial{b,h})
                for t = 1:size(SIG(s).ltd.rTrial{b,h},1)
                    %!% can add in dimension for error and no response 
                     %trial col 4 == correct
                     r = 1;
                    for v = 1:size(SIG(s).ltd.rTrial{b,h}{t,r},2) % vector value
                        if ~isempty(SIG(s).ltd.bTrial)
                        mu = SIG(s).ltd.mu{b,h};
                        sigma = SIG(s).ltd.sigma{b,h};
                        point = SIG(s).ltd.rTrial{b,h}{t,r}(1,v);
                        SIG(s).ltd.zincg{b,h}{t,1}(1,v) = (point-mu)/sigma;
                        end % fi empty base
                    end % v
                    clear v
                end % t
                clear t
            end %fi
        %end % c
        clear c
        end % h
        clear h
    end % b
    clear b
end% s
clear s

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% right cong
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(SIG,2)

    for b = 1:size(SIG(s).rtd.rTrial,1)
        for h = 1:size(SIG(s).rtd.rTrial,2)
        %for c = 1%:size(MUA(s).rtd.rTrial,2)
            if ~isempty(SIG(s).rtd.rTrial{b,h})
                for t = 1:size(SIG(s).rtd.rTrial{b,h},1)
                    %!% can add in dimension for error and no response 
                     %trial col 1 == correct
                    for v = 1:size(SIG(s).rtd.rTrial{b,h}{t,1},2) % vector value
                        
                        mu = SIG(s).rtd.mu{b,h};
                        sigma = SIG(s).rtd.sigma{b,h};
                        point = SIG(s).rtd.rTrial{b,h}{t,1}(1,v);
                        SIG(s).rtd.zcong{b,h}{t,1}(1,v) = (point-mu)/sigma;
                        
                    end % v
                    clear v
                end % t
                clear t
            end %fi
        %end % c
        clear c
        end %h
        clear h
    end % b
    clear b
end % % s
clear s

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% right incg
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(SIG,2)
    for b = 1:size(SIG(s).rtd.rTrial,1)
        for h = 1:size(SIG(s).rtd.rTrial,2)
        %for c = 2%1:size(MUA(s).rtd.rTrial,2)
            if ~isempty(SIG(s).rtd.rTrial{b,h})
                for t = 1:size(SIG(s).rtd.rTrial{b,h},1)
                    %!% can add in dimension for error and no response 
                    r = 1;
                    for v = 1:size(SIG(s).rtd.rTrial{b,h}{t,r},2) % vector value
                        
                        mu = SIG(s).rtd.mu{b,h};
                        sigma = SIG(s).rtd.sigma{b,h};
                        point = SIG(s).rtd.rTrial{b,h}{t,r}(1,v);
                        SIG(s).rtd.zincg{b,h}{t,1}(1,v) = (point-mu)/sigma;
                        
                    end % v
                    clear v
                end % t
                clear t
            end %fi
        %end % c
        clear c
        end % h
        clear h
    end % b
    clear b
end % s
clear s

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% all
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(SIG,2)
    for b = 1:size(SIG(s).rspk.lfp,1)
        for h =  1:size(SIG(s).rspk.lfp,2)
        %for c = 1:size(SIG(s).rspk.lfp,2)
            if ~isempty(SIG(s).rspk.lfp{b,h})
               for v = 1:size(SIG(s).rspk.lfp{b,h},2) % vector value
                   %MUA(s).rspk.mua{b,c};
                   mu = SIG(s).rspk.mu{b,h};
                   sigma = SIG(s).rspk.sigma{b,h};
                   point = SIG(s).rspk.lfp{b,h}(1,v);
                   SIG(s).rspk.z{b,h}(1,v) = (point-mu)/sigma;

               end % v
               clear v
            end %fi
        %end % c
        clear c
        end %h
        clear h
    end % b
    clear b
end % subject

%%  normalize
%{
for s = 1:size(MUA,2)
    %LTD congruent - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for b = 1:size(MUA(s).ltd.congTrl,1)
        for c = 1:size(MUA(s).ltd.congTrl,2)
            if ~isempty(MUA(s).ltd.congTrl{b,c})
                for t = 1:size(MUA(s).ltd.congTrl{b,c},1)
                    
                    MUA(s).ltd.ncong{b,c}{t,2} = normalize(MUA(s).ltd.congTrl{b,c}{t,1});
                    
                end % t
                clear t
            end %fi
        end %c
        clear c
    end % b
    clear b
end % s
clear s

%LTD incongruent - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(MUA,2)
    for b = 1:size(MUA(s).ltd.incgTrl,1)
        for c = 1:size(MUA(s).ltd.incgTrl,2)
            if ~isempty(MUA(s).ltd.incgTrl{b,c})
                for t = 1:size(MUA(s).ltd.incgTrl{b,c},1)
                    r = 1;
                    MUA(s).ltd.nincg{b,c}{t,2} = normalize(MUA(s).ltd.incgTrl{b,c}{t,r});
                    
                end % t
                clear t
            end %fi
        end %c
        clear c
    end % b
    clear b
end% s
clear s

%LTD baseline - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(MUA,2)
    for b = 1:size(MUA(s).ltd.alignB,1)
        for c = 1:size(MUA(s).ltd.alignB,2)
            if ~isempty(MUA(s).ltd.alignB{b,c})
                for t = 1:size(MUA(s).ltd.alignB{b,c},1)
                    
                    MUA(s).ltd.nbase{b,c}{t,2} = normalize(MUA(s).ltd.alignB{b,c}{t,1});
                    
                end % t
                clear t
            end %fi
        end %c
        clear c
    end % b
    clear b
end% s
clear s
% right response
%RTD congruent - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(MUA,2)
    for b = 1:size(MUA(s).rtd.congTrl,1)
        for c = 1:size(MUA(s).rtd.congTrl,2)
            if ~isempty(MUA(s).rtd.congTrl{b,c})
                for t = 1:size(MUA(s).rtd.congTrl{b,c},1)
                    
                    MUA(s).rtd.ncong{b,c}{t,2} = normalize(MUA(s).rtd.congTrl{b,c}{t,1});
                    
                end % t
                clear t
            end %fi
        end %c
        clear c
    end % b
    clear b
end % s
clear s

%RTD incongruent - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(MUA,2)
    for b = 1:size(MUA(s).rtd.incgTrl,1)
        for c = 1:size(MUA(s).rtd.incgTrl,2)
            if ~isempty(MUA(s).rtd.incgTrl{b,c})
                for t = 1:size(MUA(s).rtd.incgTrl{b,c},1)
                    r = 1;
                    MUA(s).rtd.nincg{b,c}{t,2} = normalize(MUA(s).rtd.incgTrl{b,c}{t,r});
                    
                end % t
                clear t
            end %fi
        end %c
        clear c
    end % b
    clear b
end% s
clear s

%RTD baseline - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(MUA,2)
    for b = 1:size(MUA(s).rtd.alignB,1)
        for c = 1:size(MUA(s).rtd.alignB,2)
            if ~isempty(MUA(s).rtd.alignB{b,c})
                for t = 1:size(MUA(s).rtd.alignB{b,c},1)
                    
                    MUA(s).rtd.nbase{b,c}{t,2} = normalize(MUA(s).rtd.alignB{b,c}{t,1});
                    
                end % t
                clear t
            end %fi
        end %c
        clear c
    end % b
    clear b
end % s
clear s
% whole signal?  - - - - - - - - - - - - - - - - - - - - - - - - - - -
for s = 1:size(MUA,2)
    for b = 1:size(MUA(s).rspk.mua,1)
        for c = 1:size(MUA(s).rspk.mua,2)
            if ~isempty(MUA(s).rspk.mua{b,c})
                
                MUA(s).rspk.nmua{b,c}(2,:) = normalize(MUA(s).rspk.mua{b,c}(1,:));
                
            end %fi
        end %c
        clear c
    end % b
    clear b
end % s
clear s
%}
end