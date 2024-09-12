function [demean] = fx_Channel_demean(chanStat,dat)
%[chan,chanKeep,E,F,R,P] = fx_channelSelection(spk, idxTrial, aoTrl,subject)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% function take the average of all the channels out of the selected channel
% selected in previous fucntion
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
note = ' ';
svCh = []; svLh = []; svRh = [];
hem = size(chanStat{1,1},1);

% organize channels into hemispheres based on chan label (number)
cn = fieldnames(dat);
CN = cn.';

for q = 1:size(cn,1)
cno{q} = str2num(cn{q}(:,end-1:end));
end
[csort, I] = sort(cell2mat(cno),'ascend');
chanI = CN(I);
for j = 1:size(chanI,2)

    ch{1,j} = (chanI{1,j});
    
    chdat.(chanI{1,j}) = dat.(chanI{1,j});
end

fn = fieldnames(chdat);

for h = 1:hem
    chan = chanStat{1,1}{h,1};
    
% this loop is not perfect for staged bilaterals    
    for f = 1:size(fn,1)   
        if size((chdat.(fn{f})),2) < 2
            continue
        else
        %unilateral
        if hem <= 1 %(hem ==1)
            netCh(f,:) = (dat.(fn{f}));
%             netChAvg{1,h} = mean(netCh,'omitnan');
            uni = strcmp(fn{f},chan);
            if uni == 1
                svCh = dat.(fn{f});
            end % save chan
            
            %bilateral
        elseif hem >= 2%hem == 2
            
            if f < 4
                
                netLh(f,:) = (dat.(fn{f}));
%                 netLhAvg{1,h} = mean(netCh,'omitnan');
                
                 bil = strcmp(fn{f},chan);
                if bil==1
                    svLh = dat.(fn{f});
                end
                clear bil
                
            elseif f >= 4
                netRh(f-3,:) = (dat.(fn{f}));
%                 netRhAvg{1,h} = mean(netCh,'omitnan');
                
                 bil = strcmp(fn{f},chan);
                if bil==1
                    svRh = dat.(fn{f});
                end
                clear bil
                
            end % two hem
            
        end % fi hemi qualifier
        end % empty channal
    end %'f' fn RAW
    
end % 'h'

if ~isempty(svCh)
    netChAvg = mean(netCh,'omitnan');
    uniHem = double(svCh) - (netChAvg);
    demean.uni = uniHem;
end

if ~isempty(svLh)
    netLhAvg = mean(netLh,'omitnan');
    bilLHem = double(svLh) - (netLhAvg);
    demean.bilLH = bilLHem;
end

if ~isempty(svRh)
    netRhAvg = mean(netRh,'omitnan');
    bilRHem = double(svRh) - (netRhAvg);
    demean.bilRH = bilRHem;
end


end
