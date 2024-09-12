function [data] = fx_conitionAssignment_demeanCH(data,rspk,onset,offset)
% function cuts demeans signal from onset to offset values defined from
% behavioral data. 
% response type [col 1 correct CONG     || col 4 correct INCG]
%               [col 2 error CONG       || col 5 error INCG]    
%               [col 3 no response CONG || col 6 no response INCG]
% r1 = correct cong
% r2 = error cong
% r3 = no response cong
% r4 = correct incg
% r5 = error incg
% r6 = no response incg
% onset / offset to cut trials
for s = 1:size(data,2)%subject loop
    for b = 1:size(data(s).AO,1) % block
        
        
        if ~isempty(rspk(s).dsig{b,1})%~isempty(rspk(s).raw{b,1})
            
            cn = fieldnames(rspk(s).dsig{b,1});
            % fn = fieldnames(rspk(s).chan{b,1});
        else, continue, end
        
        for k = 1:length(cn)
            r1 = 0; r2 = 0; r3 = 0; r4 = 0; r5 = 0; r6 = 0;
            % response type [col 1 correct cong; col 4 correct incg]
            for r = 1:size(data(s).AO{b,1},2) 
                disp(r)
                for t = 1:size(data(s).AO{b,1}(:,r),1) % trial
                    %s=5; b=1; k=3; r=1; t=185;
                    %disp(s);disp(b);disp(k);disp(r);disp(t)
                    if  r == 1 && ~isempty(data(s).AO{b,1}{t,r})
                        r1 = r1+1; % true trial count per cond
                        ni = find(data(s).AO{b,1}{t,r}(1,:) == onset );    %data(s).AO{b,1}{t,r}(2,1);
                        nf = find(data(s).AO{b,1}{t,r}(1,:) == offset );   %data(s).AO{b,1}{t,r}(2,end);
                        if (data(s).AO{b,1}{t,r}(2,nf)) > length(rspk(s).demeanSig{b,1}.(cn{k}))
                            data(s).cong{b,k}{r1,1} = [];
                            %data(s).rtcong{b,k}{r1,1} = [];
                        else
                            data(s).cong{b,k}{r1,1} = rspk(s).demeanSig{b,1}.(cn{k})...
                                (data(s).AO{b,1}{t,r}(2,ni):data(s).AO{b,1}{t,r}(2,nf));
                            data(s).congMrk{b,k}{r1,1} =  (data(s).AO{b,1}{t,r});

                        end
                        clear ni nf
                    
                    elseif r == 2 && ~isempty(data(s).AO{b,1}{t,r})
                        r2 = r2+1; % true trial count per cond
                        ni = find(data(s).AO{b,1}{t,r}(1,:) == onset );
                        nf = find(data(s).AO{b,1}{t,r}(1,:) == offset );
                        if (data(s).AO{b,1}{t,r}(2,nf)) > length(rspk(s).demeanSig{b,1}.(cn{k}))
                            data(s).cong{b,k}{r2,2} = [];
                            data(s).errorCs{b,k}{r2,2} = 1;
                            %data(s).rtcong{b,k}{r2,2} = [];
                        else
                            data(s).cong{b,k}{r2,2} = rspk(s).demeanSig{b,1}.(cn{k})...
                                (data(s).AO{b,1}{t,r}(2,ni):data(s).AO{b,1}{t,r}(2,nf));
                            data(s).congMrk{b,k}{r2,2} = (data(s).AO{b,1}{t,r});
                            data(s).errorCs{b,k}{r2,2} = 0;
                        end
                        clear ni nf
                  
                    elseif r == 3 && ~isempty(data(s).AO{b,1}{t,r})
                        r3 = r3+1; % true trial count per cond
                        ni = find(data(s).AO{b,1}{t,r}(1,:) == onset );
                        nf = find(data(s).AO{b,1}{t,r}(1,:) == offset );
                        if (data(s).AO{b,1}{t,r}(2,nf)) > length(rspk(s).demeanSig{b,1}.(cn{k}))
                            data(s).cong{b,k}{r3,3} = [];
                            %data(s).rtcong{b,k}{r3,3} = [];
                        else
                            data(s).cong{b,k}{r3,3} =  rspk(s).demeanSig{b,1}.(cn{k})...
                                (data(s).AO{b,1}{t,r}(2,ni):data(s).AO{b,1}{t,r}(2,nf));
                            data(s).congMrk{b,k}{r3,3} =  (data(s).AO{b,1}{t,r});
                        end
                        clear ni nf
                 
                    elseif r == 4 && ~isempty(data(s).AO{b,1}{t,r})
                        r4 = r4 + 1; % true trial count per cond
                        ni = find(data(s).AO{b,1}{t,r}(1,:) == onset );
                        nf = find(data(s).AO{b,1}{t,r}(1,:) == offset );
                        if (data(s).AO{b,1}{t,r}(2,nf)) > length(rspk(s).demeanSig{b,1}.(cn{k}))
                            data(s).incg{b,k}{r4,1} = [];
                            %data(s).Irtincg{b,k}{r4,1} = [];
                        else
                            data(s).incg{b,k}{r4,1} =  rspk(s).demeanSig{b,1}.(cn{k})...
                                (data(s).AO{b,1}{t,r}(2,ni):data(s).AO{b,1}{t,r}(2,nf));
                             data(s).incgMrk{b,k}{r4,1} = (data(s).AO{b,1}{t,r});
                        end
                        clear ni nf
                  
                    elseif r == 5 & ~isempty(data(s).AO{b,1}{t,r})
                        r5 = r5+1; % true trial count per cond
                        ni = find(data(s).AO{b,1}{t,r}(1,:) == onset );
                        nf = find(data(s).AO{b,1}{t,r}(1,:) == offset );
                        if (data(s).AO{b,1}{t,r}(2,nf)) > length(rspk(s).demeanSig{b,1}.(cn{k}))
                            data(s).incg{b,k}{r5,2} = [];
                            data(s).errorNC{b,k}{r5,2} = 1;
                            %data(s).rtincg{b,k}{r5,2} = [];
                        else
                            data(s).incg{b,k}{r5,2} = rspk(s).demeanSig{b,1}.(cn{k})...
                                (data(s).AO{b,1}{t,r}(2,ni):data(s).AO{b,1}{t,r}(2,nf));
                            data(s).incgMrk{b,k}{r5,2} =  (data(s).AO{b,1}{t,r});
                            data(s).errorNC{b,k}{r5,2} = 0;
                        end
                        clear ni nf
                  
                    elseif r == 6 & ~isempty(data(s).AO{b,1}{t,r})
                        r6 = r6+1; % true trial count per cond
                        ni = find(data(s).AO{b,1}{t,r}(1,:) == onset );
                        nf = find(data(s).AO{b,1}{t,r}(1,:) == offset );
                        if (data(s).AO{b,1}{t,r}(2,nf)) > length(rspk(s).demeanSig{b,1}.(cn{k}))
                            data(s).incg{b,k}{r6,3} = [];
                            %data(s).rtincg{b,k}{r6,3} = [];
                        else
                            data(s).incg{b,k}{r6,3} = rspk(s).demeanSig{b,1}.(cn{k})...
                                (data(s).AO{b,1}{t,r}(2,ni):data(s).AO{b,1}{t,r}(2,nf));
                             data(s).incgMrk{b,k}{r6,3} =  (data(s).AO{b,1}{t,r});
                        end
                        clear ni nf
                    end %fi response
                    
                end % channel 't'
            end % trial 'r'
        end % response type 'k'
    end % block 'b'
end %subject loop


end