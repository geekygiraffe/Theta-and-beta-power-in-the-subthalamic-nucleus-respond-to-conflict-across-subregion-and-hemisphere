function [data] = fx_catcutBaselineTrial(data)
% function matches baseline data to trial data and stacks 'tip to tail
% data = ltd;
%[basleine, maker, trial]
% hemishere is double, have first the raw channels, then the demeaned
% channels per hem. so divide buy two to get true hem count. raw before
% demeand
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% insert a ten nan marker between baseline and trial
marker = nan(1,10);
c = 1; % channel

for s = 1:size(data,2) %subject
    if ~isempty(data(s).Bcong)
        for b = 1:size(data(s).Bcong,1) % block
            for h = 1:size(data(s).Bcong,2) % hemisphere
                if ~isempty(data(s).Bcong{b,h})
                    for t = 1:size(data(s).Bcong{b,h},1)
                        if ~isempty(data(s).Bcong{b,h}{t,1}) 
                        % disp(s); disp(b); disp(t);
                        Bt = double(cell2mat(data(s).Bcong{b,h}(t,1)));
                        Tt = double(data(s).cong{b,h}{t,1});
                        marker = nan(1,10);
                        data(s).congTrl{b,h}{t,:} = [Bt,marker,Tt];
                        data(s).congTrig{b,h}{t,:} = data(s).congMrk{b,h}{t,:} ;
                        clear Bt Tt
                        end % qualifying conditional (t)
                    end% trial
                    clear t
                end % qualifying conditional (b)
            end % hemisphere
        end %block
        clear b h
    end % qualifying conditional (s)
end %subject

for s = 1:size(data,2) %subject
    if ~isempty(data(s).Bincg)
        for b = 1:size(data(s).Bincg,1) % block
            for h = 1:size(data(s).Bincg,2) % hemisphere
                if ~isempty(data(s).Bincg{b,h})
                    for t = 1:size(data(s).Bincg{b,h},1)
                        %disp(s);disp(b);disp(h);disp(t);
                        if ~isempty(data(s).Bincg{b,h}{t,1})
                        Bt = double(cell2mat(data(s).Bincg{b,h}(t,1)));
                        Tt = double(data(s).incg{b,h}{t,1});%Tt%Tdata
                        data(s).incgTrl{b,h}{t,:} = [Bt,marker,Tt];
                         data(s).incgTrig{b,h}{t,:} = data(s).incgMrk{b,h}{t,:};
                        clear Bt Tt
                        end
                    end% trial
                    clear t
                end % qualifying conditional
            end % h
        end %block
        clear b h
    end % qualifying conditional (s)
end %subject

end