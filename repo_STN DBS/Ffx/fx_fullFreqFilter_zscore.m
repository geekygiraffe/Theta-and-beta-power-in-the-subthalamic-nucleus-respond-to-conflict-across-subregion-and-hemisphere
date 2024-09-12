function [sbJ] = fx_fullFreqFilter_zscore(sbJ)

% input = 'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Data\DBS\spike_processingSimon\STNoutput\PPd\LFP\sorted\hem\conditions\fFreq'
%load(fullfile(input,'J.mat'));
% output = 'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Data\DBS\spike_processingSimon\STNoutput\PPd\LFP\sorted\hem\conditions\fFreq\znorm';
%switches
dosave = 0;
comboPsudoweighted = 0;
comboPsuedo = 0;
comboPsuedozPow =1;
%% average the psuedo hemisphere subjects
% ventral 7a & b
% dorsal & ventral 18a & b
if comboPsuedo ==1
    allJ = sbJ;
    tmpJ = sbJ;
    % tmpJ = J;
    fn = fieldnames(tmpJ);
    m = 0;
    for j = 1:9
        for c = 1:6
            if j ==9
                %STN 18a * 18b = 87+86 = 173
                cn = fieldnames((tmpJ(1).(fn{c})));
                for f = 7:size(cn)
                    J10(8).(fn{c}).subject ='STN18';
                    J10(8).(fn{c}).(cn{f}) =  [mean(tmpJ(8).(fn{c}).(cn{f})); mean(tmpJ(9).(fn{c}).(cn{f}))];
                end % f
            else
                J10(j).(fn{c}) = tmpJ(j).(fn{c});
            end % fi
        end % c
    end % j
    clear j
    for c = 7:size(fn,1) %conditions
        cn = fieldnames((tmpJ(1).(fn{c})));
        for f = 7:size(cn)% within condition variables
            % STN 02
            J10(1).(fn{c}).subject = tmpJ(1).(fn{c}).subject;
            J10(1).(fn{c}).(cn{f}) = tmpJ(1).(fn{c}).(cn{f});
            % STN 07a + 7b = 15+41 = 56
            J10(2).(fn{c}).subject ='STN07';
            J10(2).(fn{c}).(cn{f}) =  [mean(tmpJ(2).(fn{c}).(cn{f})); mean(tmpJ(3).(fn{c}).(cn{f}))];
            %STN 08
            J10(3).(fn{c}).subject = tmpJ(4).(fn{c}).subject;
            J10(3).(fn{c}).(cn{f}) = tmpJ(4).(fn{c}).(cn{f});
            %STN09
            J10(4).(fn{c}).subject = tmpJ(5).(fn{c}).subject;
            J10(4).(fn{c}).(cn{f}) = tmpJ(5).(fn{c}).(cn{f});
            %STN10b
            J10(5).(fn{c}).subject = tmpJ(6).(fn{c}).subject;
            J10(5).(fn{c}).(cn{f}) = tmpJ(6).(fn{c}).(cn{f});
            %STN11
            J10(6).(fn{c}).subject = tmpJ(7).(fn{c}).subject;
            J10(6).(fn{c}).(cn{f}) = tmpJ(7).(fn{c}).(cn{f});
            %STN13
            J10(7).(fn{c}).subject = tmpJ(8).(fn{c}).subject;
            J10(7).(fn{c}).(cn{f}) = tmpJ(8).(fn{c}).(cn{f});
            %STN14
            J10(8).(fn{c}).subject = tmpJ(9).(fn{c}).subject;
            J10(8).(fn{c}).(cn{f}) = tmpJ(9).(fn{c}).(cn{f});
            %STN16
            J10(9).(fn{c}).subject = tmpJ(10).(fn{c}).subject;
            J10(9).(fn{c}).(cn{f}) = tmpJ(10).(fn{c}).(cn{f});
            %STN17
            %         J10(10).(fn{c}).subject = tmpJ(11).(fn{c}).subject;
            %         J10(10).(fn{c}).(cn{f}) = tmpJ(11).(fn{c}).(cn{f});
            %STN 18a + 18b = 93+88 = 181
            J10(10).(fn{c}).subject ='STN18';
            J10(10).(fn{c}).(cn{f}) =  [mean(tmpJ(11).(fn{c}).(cn{f})); mean(tmpJ(12).(fn{c}).(cn{f}))];
        end % f
    end % c
    clear sbJ
    sbJ = J10;
end % combo psuedo
%% weighted average the psuedo hemisphere subjects
% ventral 7a & b % dorsal & ventral 18a & b
if comboPsudoweighted ==1
    allJ = sbJ;
    tmpJ = sbJ;
    fn = fieldnames(tmpJ);
    m = 0;
    for j = 1:9
        for c = 1:6
            if j ==9
                %STN 18a * 18b = 87+86 = 173
                cn = fieldnames((tmpJ(1).(fn{c})));
                for f = 7:size(cn)
                    J10(8).(fn{c}).subject ='STN18';
                    J10(8).(fn{c}).(cn{f}) =  [tmpJ(8).(fn{c}).(cn{f}); tmpJ(9).(fn{c}).(cn{f})];
                end % f
            else
                J10(j).(fn{c}) = tmpJ(j).(fn{c});
            end % fi
        end % c
    end % j
    clear j
    for c = 7:size(fn,1) %conditions
        cn = fieldnames((tmpJ(1).(fn{c})));
        for f = 7:size(cn)% within condition variables
            % STN 02
            J10(1).(fn{c}).subject = tmpJ(1).(fn{c}).subject;
            J10(1).(fn{c}).(cn{f}) = tmpJ(1).(fn{c}).(cn{f});
            % STN 07a + 7b = 15+41 = 56
            J10(2).(fn{c}).subject ='STN07';
            J10(2).(fn{c}).(cn{f}) =  [tmpJ(2).(fn{c}).(cn{f}); tmpJ(3).(fn{c}).(cn{f})];
            %STN 08
            J10(3).(fn{c}).subject = tmpJ(4).(fn{c}).subject;
            J10(3).(fn{c}).(cn{f}) = tmpJ(4).(fn{c}).(cn{f});
            %STN09
            J10(4).(fn{c}).subject = tmpJ(5).(fn{c}).subject;
            J10(4).(fn{c}).(cn{f}) = tmpJ(5).(fn{c}).(cn{f});
            %STN10b
            J10(5).(fn{c}).subject = tmpJ(6).(fn{c}).subject;
            J10(5).(fn{c}).(cn{f}) = tmpJ(6).(fn{c}).(cn{f});
            %STN11
            J10(6).(fn{c}).subject = tmpJ(7).(fn{c}).subject;
            J10(6).(fn{c}).(cn{f}) = tmpJ(7).(fn{c}).(cn{f});
            %STN13
            J10(7).(fn{c}).subject = tmpJ(8).(fn{c}).subject;
            J10(7).(fn{c}).(cn{f}) = tmpJ(8).(fn{c}).(cn{f});
            %STN14
            J10(8).(fn{c}).subject = tmpJ(9).(fn{c}).subject;
            J10(8).(fn{c}).(cn{f}) = tmpJ(9).(fn{c}).(cn{f});
            %STN16
            J10(9).(fn{c}).subject = tmpJ(10).(fn{c}).subject;
            J10(9).(fn{c}).(cn{f}) = tmpJ(10).(fn{c}).(cn{f});
            %STN17
            %         J10(10).(fn{c}).subject = tmpJ(11).(fn{c}).subject;
            %         J10(10).(fn{c}).(cn{f}) = tmpJ(11).(fn{c}).(cn{f});
            %STN 18a + 18b = 93+88 = 181
            J10(10).(fn{c}).subject ='STN18';
            J10(10).(fn{c}).(cn{f}) =  [tmpJ(11).(fn{c}).(cn{f}); tmpJ(12).(fn{c}).(cn{f})];
        end % f
    end % c
    clear sbJ
    sbJ = J10;
end %comboPsudoweighted
%% individuals
%test if trial is significant different then trial, if yes then zscore
fn = fieldnames(sbJ);
for c = 1:size(fn,1) % field condition loop %1:3:size for only collapsed
    for S = 1:size(sbJ,2) % subject loop
        
        
        %     % set significant trial counter
        t = 0;
        bsePow = [];
        trlPow = [];
        sigRM = [];
        
        if ~isempty(sbJ(S).(fn{c})) && fn{c} ~= "subject"
            
            vn = fieldnames(sbJ(S).(fn{c}));
            
            %             if isstruct(sbJ(S).(fn{c}).RT)
            %                 rt = sbJ(S).(fn{c}).RT;
            %             elseif iscell((sbJ(S).(fn{c}).RT))
            %                 rt = sbJ(S).(fn{c}).RT;
            %             end % struct/cell conditional
            
            for k = 1:size(vn,1) % variable loop
                %baseline conditions
                if contains((vn{k}),'_pow_bse')
                    if contains((vn{k}),'tfU_pow_bse')
                        Ubse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfA_pow_bse')
                        Abse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfbB_pow_bse')
                        bBbse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfBB_pow_bse')
                        BBbse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfB_pow_bse')
                        Bbse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfG_pow_bse')
                        Gbse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfF_pow_bse')
                        Fbse = (sbJ(S).(fn{c}).(vn{k}));
                    end % power band conditional
                    
                    %trial conditions
                elseif contains((vn{k}),'_pow_trl')
                    if contains((vn{k}),'tfU_pow_trl')
                        Utrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfA_pow_trl')
                        Atrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfbB_pow_trl')
                        bBtrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfBB_pow_trl')
                        BBtrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfB_pow_trl')
                        Btrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfG_pow_trl')
                        Gtrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfF_pow_trl')
                        Ftrl = (sbJ(S).(fn{c}).(vn{k}));
                    end % power band conditional
                end% fi '_pow_bse' | fi '_pow_trl'
            end %'k'
            
            %call freq bands
            bcond = {'Ubse', 'Abse', 'bBbse', 'BBbse', 'Bbse', 'Fbse'};%, 'Gbse'};%, 'Fbse'};
            tcond = {'Utrl', 'Atrl', 'bBtrl', 'BBtrl', 'Btrl', 'Ftrl'};%, 'Gtrl'};%,'Ftrl'};
            
            for j = 1:size(tcond,2)
                t = 0;
                sigRM = [];
                bsePow = [];
                trlPow = [];
                
                bseFull = (Fbse);
                trlFull = (Ftrl);
                bsecond = eval(bcond{j});
                trlcond = eval(tcond{j});
                %%
                %                 bsePow = [bsePow;bsecond];
                %                 trlPow = [trlPow;trlcond];
                for m = 1:size(trlcond,1)%(bsecond,1)%(bsePow,1) % trials
                    % define testing variables & trial iteration
                    x = bseFull(m,:);%bsecond(m,:);%bsePow(m,:);
                    y = trlcond(m,:);%trlcond(m,:);%trlPow(m,:);
                    %disp(m);disp(c); disp(k); disp(j); disp(i); disp(s)
                    
                    [h,p] = ttest(x,y);
                    
                    if  p <=0.05
                        %     sigtrialcounter
                        t = t+1;
                        muBase(t,:) = mean(bsecond(m,:),'omitnan');%bsecond
                        sigmaBase(t,:) = std(bsecond(m,:),'omitnan');%bsecond
                        
                        muBaseFull(t,:) = mean(bseFull(m,:),'omitnan');%bsecond
                        sigmaBaseFull(t,:) = std(bseFull(m,:),'omitnan');%bsecond
                        
                        mu_trl(t,:) = mean(trlcond(m,:),'omitnan');%trlcond
                        sigma_trl(t,:) = std(trlcond(m,:),'omitnan');%trlcond
                        
                        % relative baseline power (power within specific
                        % band / total band)
                        relativeBsePow(t,:) = bsecond(m,:)./bseFull(m,:);
                        
                        % z score to baseline
                        %https://bookdown.org/anta8363/fluoR_bookdown/stand.html
                        for r = 1:size(trlcond,2)%trlcond,2)%trlPow
                            z_tfpow(t,r) = (trlcond(t,r) - muBase(t,1)) / sigmaBase(t,1);%trlcond
                            %sigTrl(t,:) = trlcond(m,:);
                            %normalize freq baseline to full baseline
                            z_bnpow(t,r) = (bsecond(t,r) - muBaseFull(t,1)) / sigmaBaseFull(t,1);
                        end %'r'
                        
                        % log transform to baseline and convert to db
                        %Decibels are dimensionless numbers used to represent
                        %the ratio of two quantities of power: db = 10 log P1/P0 .
                        %This is a base 10 logarithm.
                        %For the common unit of "dbm" the reference power P0 is defined as 1 milliwatt : dbm = 10 log P1/1mw.
                        log_tfpow(t,:) = 10*log10(trlcond(t,:)./bsecond(t,:));
                        
                        % db normalize baseline to full baseline
                        log_bnpow(t,:) = 10*log10(bsecond(t,:)./bseFull(t,:));
                        
                        %relative log transform for beta peaks
                        trlLogpower(t,:) = (trlcond(t,:)./trlFull(t,:));
                        bseLogpower(t,:) = (bsecond(t,:)./bseFull(t,:));
                    else
                        sigRM(m,1) = 1;
                    end % fi statistical conditional: p <=0.05
                end %'m'
                %%
                %% column [U A bb BB B G F]
                %disp(S); disp(c);disp(j); % 5 1 1
                if ~isempty(sigRM)
                    rmTrlno = find(sigRM == 1);
                    sbJ(S).(fn{c}).sigRM{:,j} = find(sigRM == 1);
                    sbJ(S).(fn{c}).trlRM{:,j} = size(rmTrlno,1);
                else
                    
                    sbJ(S).(fn{c}).sigRM{:,j} = nan;
                    sbJ(S).(fn{c}).trlRM{:,j} = nan;
                end
                
                sbJ(S).(fn{c}).z_tfPow{:,j} = z_tfpow;
                sbJ(S).(fn{c}).tfDB{:,j} = log_tfpow;
                sbJ(S).(fn{c}).z_bnpow{:,j} = z_bnpow;
                sbJ(S).(fn{c}).log_bnpow{:,j} = log_bnpow;
                sbJ(S).(fn{c}).BsePowrelative{:,j} = relativeBsePow;
                
                sbJ(S).(fn{c}).trlLogpower{:,j} = trlLogpower;
                sbJ(S).(fn{c}).bseLogpower{:,j} = bseLogpower;
                %strcat('sig',(tcond{j}))
                %sbJ(S).(fn{c}).z_tfPow{:,j} = sigTrl;
                %                 sbJ(S).(fn{c}).z_tfPowFlt{:,j} = zsigTrl;
                %                 sbJ(S).(fn{c}).log_tfDbFlt{:,j} = logsigTrl;
                
                z_tfavg{:,j} = mean(z_tfpow);
                db_tfavg{:,j} = mean(log_tfpow);
                z_tfbavg{:,j} = mean(z_bnpow);
                db_tfbavg{:,j} = mean(log_bnpow);
                rPow_bseavg{:,j} = mean(relativeBsePow);
                %sem
                %stderr{:,j} = std(z_tfpow) / sqrt(length(z_tfpow));%std(z_tfpow) / sqrt(length(z_tfpow));
                %std(zsigTrl) / sqrt(length(zsigTrl));
                
                clear tnull
            end % 'j'
            
            sbJ(S).(fn{c}).zPowmean = z_tfavg;
            sbJ(S).(fn{c}).dbPowmean = db_tfavg;
            sbJ(S).(fn{c}).zBPowmean = z_tfbavg;
            sbJ(S).(fn{c}).dbBPowmean = db_tfbavg;
            sbJ(S).(fn{c}).relBPowmean = rPow_bseavg;
            
            clear stderr bsePow trlPow
            clear zsigTrl z_tfavg z_tfpow ZampRM Zmnsig
            clear logsigTrl log_tfavg log_tfpow LampRM Lmnsig
            
            %sigRM
        end % fi empty conditional
    end % S' subject
end % c

%             dosave=0;
%             if dosave ==1
%                 disp(output) %'C:\Users\j0mcdo06\Box\Dept-Neurosurgery_NRGlab\Data\DBS\spike_processingSimon\STNoutput\lfp\freq'
%                 save(fullfile(output, 'sbJ.mat'), 'sbJ', '-v7.3');
%             end
%% average the psuedo hemisphere subjects
% ventral 7a & b
% dorsal & ventral 18a & b
if comboPsuedozPow ==1
    netJ = sbJ;
    tmpJ = sbJ;
    fn = fieldnames(tmpJ);
    m = 0;
    for j = 1:9
        for c = 1:6
            if j ==9
                %STN 18a * 18b = 87+86 = 173
                cn = fieldnames((tmpJ(1).(fn{c})));
                for f = 7:size(cn)
                    J10(8).(fn{c}).subject ='STN18';
                    J10(8).(fn{c}).(cn{f})=  [{tmpJ(8).(fn{c}).(cn{f})}; {tmpJ(9).(fn{c}).(cn{f})}];
                    if f >= 21
                        for r = 1:6 % across bands
                            J10(8).(fn{c}).(cn{f}){1,r} =  [mean(tmpJ(8).(fn{c}).(cn{f}){1,r}); mean(tmpJ(9).(fn{c}).(cn{f}){1,r})];
                        end %'r'
                    end % fi f
                end % f
            else
                J10(j).(fn{c}) = tmpJ(j).(fn{c});
            end % fi
        end % c
    end % j
    clear j
    
    for c = 7:size(fn,1) %conditions
        cn = fieldnames((tmpJ(1).(fn{c})));
        for f = 7:size(cn)% within condition variables
            % STN 02
            J10(1).(fn{c}).subject = tmpJ(1).(fn{c}).subject;
            J10(1).(fn{c}).(cn{f}) = tmpJ(1).(fn{c}).(cn{f});
            % STN 07a + 7b = 15+41 = 56
            J10(2).(fn{c}).subject ='STN07';
            J10(2).(fn{c}).(cn{f})=  [{tmpJ(2).(fn{c}).(cn{f})}; {tmpJ(3).(fn{c}).(cn{f})}];
            if f >= 21
                for r = 1:6 % across bands
                    J10(2).(fn{c}).(cn{f}){1,r} =  [mean(tmpJ(2).(fn{c}).(cn{f}){1,r}); mean(tmpJ(3).(fn{c}).(cn{f}){1,r})];
                end
            end % fi f
            %STN 08
            J10(3).(fn{c}).subject = tmpJ(4).(fn{c}).subject;
            J10(3).(fn{c}).(cn{f}) = tmpJ(4).(fn{c}).(cn{f});
            %STN09
            J10(4).(fn{c}).subject = tmpJ(5).(fn{c}).subject;
            J10(4).(fn{c}).(cn{f}) = tmpJ(5).(fn{c}).(cn{f});
            %STN10b
            J10(5).(fn{c}).subject = tmpJ(6).(fn{c}).subject;
            J10(5).(fn{c}).(cn{f}) = tmpJ(6).(fn{c}).(cn{f});
            %STN11
            J10(6).(fn{c}).subject = tmpJ(7).(fn{c}).subject;
            J10(6).(fn{c}).(cn{f}) = tmpJ(7).(fn{c}).(cn{f});
            %STN13
            J10(7).(fn{c}).subject = tmpJ(8).(fn{c}).subject;
            J10(7).(fn{c}).(cn{f}) = tmpJ(8).(fn{c}).(cn{f});
            %STN14
            J10(8).(fn{c}).subject = tmpJ(9).(fn{c}).subject;
            J10(8).(fn{c}).(cn{f}) = tmpJ(9).(fn{c}).(cn{f});
            %STN16
            J10(9).(fn{c}).subject = tmpJ(10).(fn{c}).subject;
            J10(9).(fn{c}).(cn{f}) = tmpJ(10).(fn{c}).(cn{f});
            %STN17
            %         J10(10).(fn{c}).subject = tmpJ(11).(fn{c}).subject;
            %         J10(10).(fn{c}).(cn{f}) = tmpJ(11).(fn{c}).(cn{f});
            %STN 18a + 18b = 93+88 = 181
            J10(10).(fn{c}).subject ='STN18';
            J10(10).(fn{c}).(cn{f}) =  [{tmpJ(11).(fn{c}).(cn{f})}; {tmpJ(12).(fn{c}).(cn{f})}];
            if f >= 21
                for r = 1:3 % across bands
                    J10(10).(fn{c}).(cn{f}){1,r} =  [mean(tmpJ(11).(fn{c}).(cn{f}){1,r}); mean(tmpJ(12).(fn{c}).(cn{f}){1,r})];
                end
            end % fi f
        end % f
    end % c
end %comboPsuedozPow
%%
clear sbJ
sbJ = J10;
%%
end % individual function


%{
function [sbJ] = fx_indv_lfppowerTTEstzscore(sbJ)
%% individuals
%test if trial is significant different then trial, if yes then zscore

fn = fieldnames(sbJ);
for c = 1:size(fn,1)
    %     % set significant trial counter
    %     t = 0;
    %     bsePow = [];
    %     trlPow = [];

    for S = 1:size(sbJ,2)
        if ~isempty(sbJ(S).(fn{c})) && fn{c} ~= "subject"

            vn = fieldnames(sbJ(S).(fn{c}));

            for k = 1:size(vn,1)

                %baseline
                if contains((vn{k}),'_pow_bse')
                    if contains((vn{k}),'tfU')
                        Ubse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfA')
                        Abse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfBb')
                        Bbbse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfBB')
                        BBbse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfB')
                        Bbse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfG')
                        Gbse = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfF')
                        Fbse = (sbJ(S).(fn{c}).(vn{k}));
                    end % power band conditional

                    %trial
                elseif contains((vn{k}),'_pow_trl')
                    if contains((vn{k}),'tfU')
                        Utrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfA')
                        Atrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfBb')
                        Bbtrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfBB')
                        BBtrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfB')
                        Btrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfG')
                        Gtrl = (sbJ(S).(fn{c}).(vn{k}));
                    elseif contains((vn{k}),'tfF')
                        Ftrl = (sbJ(S).(fn{c}).(vn{k}));
                    end % power band conditional
                end% fi '_pow_bse' | fi '_pow_trl'
            end %'k'

            %call freq bands
            bcond = {'Ubse', 'Abse', 'Bbbse', 'BBbse', 'Bbse', 'Gbse', 'Fbse'};
            tcond = {'Utrl', 'Atrl', 'Bbtrl', 'BBtrl', 'Btrl', 'Gtrl','Ftrl'};

            for j = 1:size(bcond,2)
                t = 0;
                bsePow = [];
                trlPow = [];

                if j == 7 % full freq range analysis - - - - - - - - - - -
                    %for s = 1:size(eval(bcond{j}),1)
                    bsecond = eval(bcond{j});
                    trlcond = eval(tcond{j});
                    bsePow = cat(3,bsePow,bsecond);%{s,:}
                    trlPow = cat(3,trlPow,trlcond);%{s,:}
                    %end % s

                    % average across subject dimension
                    bPow = mean(bsePow,3);
                    tPow = mean(trlPow,3);
                   
                    for i = 1:size(bPow,1) % freq bands
                        rm = [];
                        % define testing variables & trial iteration
                        x = bPow(i,:);
                        y = tPow(i,:);
                        
                        %disp(c); disp(k); disp(j); disp(i); disp(s)
                        %             c = 1
                        %             k = 15
                        %             j = 5
                        %             s = 1
                        %             i = 1
                        [h,p] = ttest(x,y);

                        if  p >0.05
                            nonsigBand(i,1) = i;
                            rm = find(nonsigBand);
                        elseif p <=0.05
                            %     sigtrialcounter
                            muBase(i,:) = mean(bPow(i,:),'omitnan');
                            sigmaBase(i,:) = std(bPow(i,:),'omitnan');

                            mu_trl(i,:) = mean(tPow(i,:),'omitnan');
                            sigma_trl(i,:) = std(tPow(i,:),'omitnan');

                            % z score to baseline
                            %https://bookdown.org/anta8363/fluoR_bookdown/stand.html
                            for r = 1:size(tPow,2)
                                z_tfFpow(i,r) = (tPow(i,r) - muBase(i,1)) / sigmaBase(i,1);
                            end %'r'
                        end % fi statistical conditional
                    end % 'i'

                    if ~isempty(rm) == 1
                        for n = 1:size(rm)
                            z_tfFpow(rm(n),:) = zeros(1,379);
                        end % n
                    end
                    % freq band groupings
                    clear s i bPow tPow

                else % individual freq bands - - - - - - - - - - - - - - -

               
                    bsecond = eval(bcond{j});
                    trlcond = eval(tcond{j});
                    bsePow = [bsePow;bsecond];
                    trlPow = [trlPow;trlcond];
             

                end % freq band / full conditional
t = 0;
                for m = 1:size(bsePow,1)

                    % define testing variables & trial iteration
                    x = bsePow(m,:);
                    y = trlPow(m,:);
                    %disp(c); disp(k); disp(j); disp(i); disp(s)
                    %             c = 1
                    %             k = 15
                    %             j = 5
                    %             s = 1
                    %             i = 1
                    [h,p] = ttest(x,y);

                    if  p <=0.05
                        %     sigtrialcounter
                        t = t+1;
                        muBase(t,:) = mean(bsePow(m,:),'omitnan');
                        sigmaBase(t,:) = std(bsePow(m,:),'omitnan');

                        mu_trl(t,:) = mean(trlPow(m,:),'omitnan');
                        sigma_trl(t,:) = std(trlPow(m,:),'omitnan');

                        % z score to baseline
                        %https://bookdown.org/anta8363/fluoR_bookdown/stand.html
                        %for q = size(trlPow,1)
                            for r = 1:size(trlPow,2)
                                z_tfpow(t,r) = (trlPow(t,r) - muBase(t,1)) / sigmaBase(t,1);
                            end %'r'
                        %end %'q'
                    end % fi statistical conditional
                    
                end % 'm'
clear muBase sigmaBase mu_trl sigma_trl t
                %% insert power filter for amplitude outliers
                mnsig = mean(z_tfpow,2,'omitnan');
                sdsig = std(mnsig);
                st = 0;
                for ii = 1:size(z_tfpow,1)

                    if mnsig(ii,1)<= (mean(mnsig)+sdsig*3)
                        st = st+1;
                        zsigTrl(st,:) = z_tfpow(ii,:);
                    end  %fi
                end % ii

                %% column [U A b B G F]
                sbJ(S).(fn{c}).z_tfPow{:,j} = zsigTrl;%z_tfpow;
                z_tfavg{:,j} = mean(zsigTrl);%(z_tfpow);
                %sem
                stderr{:,j} = std(zsigTrl) / sqrt(length(zsigTrl));%std(z_tfpow) / sqrt(length(z_tfpow));

                if j ==7 % store full band metrics
                    sbJ(S).(fn{c}).z_tfPow{:,7} = zsigTrl;
                    z_tfavg{:,7} =  mean(zsigTrl,2,'omitnan');
                    stderr{:,7} = std(zsigTrl,0,1,'omitnan') / sqrt(length(zsigTrl));
                    %sbJ(S).(fn{c}).z_tfPow{:,7} = z_tfFpow;
                    %z_tfavg{:,7} =  mean(z_tfFpow,2,'omitnan');
                    %stderr{:,7} = std(z_tfFpow,0,1,'omitnan') / sqrt(length(z_tfFpow));
                end % full band metrics conditional
            end % 'j'

            sbJ(S).(fn{c}).zPowmean = z_tfavg;
            sbJ(S).(fn{c}).stderror = stderr;
clear zsigTrl z_tfavg stderr bsePow trlPow z_tfpow
        end % fi empty subject conditional
    end % S' subject
end % c
end % individual function

%}