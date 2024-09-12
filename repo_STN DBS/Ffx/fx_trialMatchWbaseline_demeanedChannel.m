function [ldata,rdata,rspk] = fx_trialMatchWbaseline_demeanedChannel(rspk,ldata,rdata)
% function matches baseline data to trial
% selecting only demeaned channels, others exist here. probalmatic upstream
%ldata = ltd;
%rdata = rtd;

for s = 1:size(rspk,2) %subject
    for b = 1:size(rspk(s).aoBsl,1) % block
        for t = 2:size(rspk(s).aoBsl{b,1},1)
            tno(1,1) = NaN;
            % disp(s);disp(b);disp(t);
            % s=5;b=2;t=2;
            %tno = rspk(s).aoBsl{b,1}{t,1}(7,1);
            tno(t,1) = rspk(s).aoBsl{b,1}{t,1}(7,1);
            
            cn = fieldnames(rspk(s).bsig{b,1});
            dn = fieldnames(rspk(s).dsig{b,1});
            % demean
            % left - correct congruent - - - - - - - - - - - - - - - - -
            %for L = 1:size(ldata(s).time{b,1},1)
            %disp(s);disp(b);disp(t);
            if size(ldata(s).AO{b,1},1) >= tno(t,1) && ~isempty(ldata(s).AO{b,1}{t,1}) ...
                    && tno(t,1) == ldata(s).AO{b,1}{t,1}(6,1)
                
                %loop selected channels               
                for k = 1:size(dn,1)
                    fcn = char(dn(k));
                     if strcmp(fcn, 'uni') ==1 || contains(fcn, 'H') ==1
                        ldata(s).bcong{b,1}.(fcn){t,1} = rspk(s).dsig{b,1}.(fcn){t,1};
                        ldata(s).bline{b,1}.(fcn){t,1} = rspk(s).dsig{b,1}.(fcn){t,1};
                        ldata(s).baod{b,1}{t,1} = rspk(s).aoBsl{b,1}{t,1};
                        %rspk(s).blineD{b,k}{t,1} = rspk(s).bsig{b,1}.(fcn){t,1};% bline
                     else
                     end
                end %k
                clear cn dn fcn
                %left - correct incongruent  - -- - - - - - - - - - - -
            elseif size(ldata(s).AO{b,1},1) >= tno(t,1) && ~isempty(ldata(s).AO{b,1}{t,4})...
                    && tno(t,1) == ldata(s).AO{b,1}{t,4}(6,1)
                %loop selected channels
                %cn = fieldnames(rspk(s).raw{b,1});
                %cn = fieldnames(rspk(s).bsig{b,1});
                %cn = find(contains(fieldnames(rspk(s).dsig{b,1}),'_dmean'));
                
                for k = 1:size(dn,1)
                    fcn = char(dn(k));
                    if strcmp(fcn, 'uni') == 1 || contains(fcn, 'H') ==1
                        ldata(s).bincg{b,1}.(fcn){t,1} = rspk(s).dsig{b,1}.(fcn){t,1};
                        ldata(s).bline{b,1}.(fcn){t,1} = rspk(s).dsig{b,1}.(fcn){t,1};
                        ldata(s).baod{b,1}{t,1} = rspk(s).aoBsl{b,1}{t,1};
                        
                        %rspk(s).blineD{b,k}{t,2} = rspk(s).bsig{b,1}.(fcn){t,1};% bline
                     else
                     end
                end % k
                clear cn dn fcn
                % right - correct congruent - - - - - - - - - - - - - - - - -
            elseif size(rdata(s).AO{b,1},1) >= tno(t,1) && ~isempty(rdata(s).AO{b,1}{t,1})...
                    && tno(t) == rdata(s).AO{b,1}{t,1}(6,1)
                
                %loop selected channels               
                for k = 1:size(dn,1)
                    fcn = char(dn(k));
                    if strcmp(fcn, 'uni') == 1 || contains(fcn, 'H') ==1
                        rdata(s).bcong{b,1}.(fcn){t,1} = rspk(s).dsig{b,1}.(fcn){t,1};
                        rdata(s).bline{b,1}.(fcn){t,1} = rspk(s).dsig{b,1}.(fcn){t,1};
                        rdata(s).baod{b,1}{t,1} = rspk(s).aoBsl{b,1}{t,1};                        
                        %rspk(s).blineD{b,k}{t,3} = rspk(s).dsig{b,1}.(fcn){t,1};% bline
                     else
                     end
                end %k
                clear cn dn fcn
                % right - correct incongruent - - - - - - - - - - - -
            elseif size(rdata(s).AO{b,1},1) >= tno(t,1) && ~isempty(rdata(s).AO{b,1}{t,4})...
                    && rdata(s).AO{b,1}{t,4}(6,1) == tno(t,1)
                
                %loop selected channels
                for k = 1:size(dn,1)
                    fcn = char(dn(k));
                     if strcmp(fcn, 'uni') == 1 || contains(fcn, 'H') ==1
                        rdata(s).bincg{b,1}.(fcn){t,1} = rspk(s).dsig{b,1}.(fcn){t,1};
                        rdata(s).bline{b,1}.(fcn){t,1} = rspk(s).dsig{b,1}.(fcn){t,1};
                        rdata(s).baod{b,1}{t,1} = rspk(s).aoBsl{b,1}{t,1};                        
                        %rspk(s).blineD{b,k}{t,4} = rspk(s).dsig{b,1}.(fcn){t,1};% bline
                    else
                     end
                end %k
                clear cn dn fcn
            end %fi          
        end% trial
        clear t
    end %block
    clear b
end %subject

end
