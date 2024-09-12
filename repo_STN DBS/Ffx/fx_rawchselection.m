function [sigraw,allch,allsz] = fx_rawchselection(intVar,T)
% bug check function to compare channel data
            count = 0;
            r = 0;
            n = 0;
            
            for i = 1:size(intVar,2)
                if contains(intVar(1,i), 'CRAW') == 1
                    count = count+1;
                    craw{count,:} = intVar(1,i);
                end
            end
       %match var sizes
       r = 0;
       for k = 1:size(T,1)
           for j = 1:size(craw,1)
               if strcmpi(T(k).name,craw{j,1}) ==1
                   r = r+1;
                   signm{r,:} = T(k).name;
                   sigsz(r,:) = T(k).size;
               end % fi var match
           end % 'j'
       end %'k'

       allch = signm;
       allsz = sigsz;
       sigmode = mode(sigsz);
      
       for m = 1:size(signm)
           sig{m,1} = signm{m,1};
           sig{m,2} = sigsz(m,2);
           if sig{m,2} == sigmode(1,2)
               n = n+1;
               sigraw{n,:} = sig{m,1};
           end % fi size qualifier
       end %'m'                
       
end % fx

%% visualize 
%{
%block 1
%15802501/fs =  359.1477
figure; hold on; 
subplot(2,1,1); plot(raw.cnt02);
title('cnt02 1742507')
subplot(2,1,2); plot(raw.cnt07)
title('cnt07 17545008')
suptitle('selected chan |15802501|')
hold off

figure; hold on; 
subplot(3,2,1); plot(RAW.ant01)
subplot(3,2,3); plot(RAW.cnt02);title('cnt02')
subplot(3,2,5); plot(RAW.pst03)
subplot(3,2,2); plot(RAW.ant06)
subplot(3,2,4); plot(RAW.cnt07);title('cnt07')
subplot(3,2,6); plot(RAW.pst08)
suptitle('all chan')
hold off

%block 2
% 1091774/fs =   24.8130
figure; hold on; 
subplot(2,1,1); plot(raw.cnt02);
title('cnt02 17425057')
subplot(2,1,2); plot(raw.cnt07)
title('cnt07 16333283')
suptitle('blk 2 selected chan |1091774|')
hold off

figure; hold on; 
subplot(3,2,1); plot(RAW.ant01)
subplot(3,2,3); plot(RAW.cnt02);title('cnt02')
subplot(3,2,5); plot(RAW.pst03)
subplot(3,2,2); plot(RAW.ant06)
subplot(3,2,4); plot(RAW.cnt07);title('cnt07')
subplot(3,2,6); plot(RAW.pst08)
suptitle('all chan')
hold off


figure;hold on
plot(1,3.231925863636364e+03,'o')
plot(1,3.627949863636364e+03,'o')
h1d = (3.231925863636364e+03-3.627949863636364e+03)
plot(2,8.213306181818181e+03,'o')
plot(2,8.584517136363636e+03,'o')
h2d = (8.213306181818181e+03-8.584517136363636e+03)
xlim([0 3])
h1d - h2d

%}
