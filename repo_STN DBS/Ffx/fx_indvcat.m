function [STN] = fx_indvcat(stn,STN,cond)
% (stn,RT_,STN,RT,cond)
 toa = []; % combined
 soh = []; % ipsilateral
 cah = []; % contra lateral
 lhem = []; % left hemisphere
 rhem = []; % right hemisphere
 hem = []; % hemisphere conditions
 base = []; %baseline conditions
%  rtAll = [];
%  rtIpsi = [];
%  rtContra = [];
%  rtHem = [];

 for j = 1:size(stn,1) % row == block
          for k = 1:size(stn,2) % col == hemisphere
%      for k = 1:size(stn,2) % col == hemisphere
         if ~isempty(stn{j,k})
             toa = stn{j,k};
             hem = stn{j,k};

%              if j<2(RT_{j,k})
%              rtAll = RT_{j,k};
%              rtHem = RT_{j,k};
%              else
%                  rtAll = 0;
%                  rtHem =0;
%              end
             %for c = 1:size(toa,2)

             if strcmpi(cond, 'dCong') == 1 %isfield(STN,'dCong')
                 STN.dCong = [STN.dCong;toa];
%                  RT.dCong = [RT.dCong;rtAll];
                 %dCong{:,c} = [toa{:,c}];
             elseif strcmpi(cond, 'dIncg') == 1 %isfield(STN,'dIncg')
                 STN.dIncg = [STN.dIncg;toa];
%                  RT.dIncg = [RT.dIncg;rtAll];
                 %dIncg{:,c} = [toa{:,c}];
             elseif strcmpi(cond, 'vCong') == 1 %iisfield(STN,'vCong')
                 STN.vCong = [STN.vCong;toa];
%                  RT.vCong = [RT.vCong;rtAll];
                 %vCong{:,c} = [toa{:,c}];
             elseif strcmpi(cond, 'vIncg') == 1 %isfield(STN,'vIncg')
                 STN.vIncg = [STN.vIncg;toa];
%                  RT.vIncg = [RT.vIncg;rtAll];
                 %vIncg{:,c} = [toa{:,c}];

             elseif strcmpi(cond, 'LHdcong') == 1
                 STN.dCong = [STN.dCong;toa];
             elseif strcmpi(cond, 'RHdcong') == 1
                 STN.dCong = [STN.dCong;toa];
             elseif strcmpi(cond, 'LHdincg') == 1
                 STN.dIncg = [STN.dIncg;toa];
             elseif strcmpi(cond, 'RHdincg') == 1
                 STN.dIncg = [STN.dIncg;toa];
             elseif strcmpi(cond, 'LHvcong') == 1
                 STN.vCong = [STN.vCong;toa];
             elseif strcmpi(cond, 'RHvcong') == 1
                 STN.vCong = [STN.vCong;toa];
             elseif strcmpi(cond, 'LHvincg') == 1
                 STN.vIncg = [STN.vIncg;toa];
             elseif strcmpi(cond, 'RHvincg') == 1
                 STN.vIncg = [STN.vIncg;toa];
                 
             elseif strcmpi(cond, 'LrLdcong') == 1
                 STN.LrLdcong = [STN.LrLdcong;hem];
%                  RT.LrLdcong = [RT.LrLdcong;rtHem];
             elseif strcmpi(cond, 'RrRdcong') == 1
                 STN.RrRdcong = [STN.RrRdcong;hem];
%                  RT.RrRdcong = [RT.RrRdcong;rtHem];
             elseif strcmpi(cond, 'LrLdincg') == 1
                 STN.LrLdincg = [STN.LrLdincg;hem];
%                  RT.LrLdincg = [RT.LrLdincg;rtHem];
             elseif strcmpi(cond, 'RrRdincg') == 1
                 STN.RrRdincg = [STN.RrRdincg;hem];
%                  RT.RrRdincg = [RT.RrRdincg;rtHem];
             elseif strcmpi(cond, 'LrLvcong') == 1
                 STN.LrLvcong = [STN.LrLvcong;hem];
%                  RT.LrLvcong = [RT.LrLvcong;rtHem];
             elseif strcmpi(cond, 'RrRvcong') == 1
                 STN.RrRvcong = [STN.RrRvcong;hem];
%                  RT.RrRvcong = [RT.RrRvcong;rtHem];
             elseif strcmpi(cond, 'LrLvincg') == 1
                 STN.LrLvincg = [STN.LrLvincg;hem];
%                  RT.LrLvincg = [RT.LrLvincg;rtHem];
             elseif strcmpi(cond, 'RrRvincg') == 1
                 STN.RrRvincg = [STN.RrRvincg;hem];
%                  RT.RrRvincg = [RT.RrRvincg;rtHem];
             elseif strcmpi(cond, 'RrLdcong') == 1
                 STN.RrLdcong = [STN.RrLdcong;hem];
%                  RT.RrLdcong = [RT.RrLdcong;rtHem];
             elseif strcmpi(cond, 'LrRdcong') == 1
                 STN.LrRdcong = [STN.LrRdcong;hem];
%                  RT.LrRdcong = [RT.LrRdcong;rtHem];
             elseif strcmpi(cond, 'RrLdincg') == 1
                 STN.RrLdincg = [STN.RrLdincg;hem];
%                  RT.RrLdincg = [RT.RrLdincg;rtHem];
             elseif strcmpi(cond, 'LrRdincg') == 1
                 STN.LrRdincg = [STN.LrRdincg;hem];
%                  RT.LrRdincg = [RT.LrRdincg;rtHem];
             elseif strcmpi(cond, 'RrLvcong') == 1
                 STN.RrLvcong = [STN.RrLvcong;hem];
%                  RT.RrLvcong = [RT.RrLvcong;rtHem];
             elseif strcmpi(cond, 'LrRvcong') == 1
                 STN.LrRvcong = [STN.LrRvcong;hem];
%                  RT.LrRvcong = [RT.LrRvcong;rtHem];
             elseif strcmpi(cond, 'RrLvincg') == 1
                 STN.RrLvincg = [STN.RrLvincg;hem];
%                  RT.RrLvincg = [RT.RrLvincg;rtHem];
             elseif strcmpi(cond, 'LrRvincg') == 1
                 STN.LrRvincg = [STN.LrRvincg;hem];
%                  RT.LrRvincg = [RT.LrRvincg;rtHem];
             elseif strcmpi(cond, 'base')
                 STN.BDcong = [STN.BDcong;base];
%                  RT.BDcong = [RT.BDcong;rtBase];
             end % combined conditions

             if ~contains(cond,'H') % test conditon :: response laterality or Left/Right Hemisphere
                 if j==1 && ~isempty(stn{j,k})
                     soh = stn{1,k};
                     if strcmpi(cond,'dCong') == 1%isfield(STN,'ipDcong')
                         STN.ipDcong = [STN.ipDcong;soh];
                     elseif strcmpi(cond, 'dIncg') == 1 %isfield(STN,'ipDincg')
                         STN.ipDincg = [STN.ipDincg;soh];
                     elseif strcmpi(cond, 'vCong') == 1 %isfield(STN,'ipVcong')
                         STN.ipVcong = [STN.ipVcong;soh];
                     elseif strcmpi(cond, 'vIncg') == 1 %isfield(STN,'ipVincg')
                         STN.ipVincg = [STN.ipVincg;soh];

                     end % cond string
                 end % ipsilateral j ==1

                 if j==2 &&~isempty(stn{2,k})
                     cah = stn{2,k};%{stn02{2,:}};
                     if strcmpi(cond, 'dCong') == 1 %isfield(STN,'ctDcong')
                         STN.ctDcong = [STN.ctDcong;cah];
                     elseif strcmpi(cond, 'dIncg') == 1 %isfield(STN,'ipDincg')
                         STN.ctDincg = [STN.ctDincg;cah];
                     elseif strcmpi(cond, 'vCong') == 1 %isfield(STN,'ipVcong')
                         STN.ctVcong = [STN.ctVcong;cah];
                     elseif strcmpi(cond, 'vIncg') == 1 %isfield(STN,'ipVincg')
                         STN.ctVincg = [STN.ctVincg;cah];

                     end % cond string
                 end % contralateral j ==2
                 %end % c
             elseif contains(cond,'H')
                 if k==1 && ~isempty(stn{j,k})
                     lhem = stn{j,1};
                     if strcmpi(cond,'LHdcong') == 1
                         STN.LHdcong = [STN.LHdcong;lhem];
                     elseif strcmpi(cond, 'LHdincg') == 1
                         STN.LHdincg = [STN.LHdincg;lhem];
                     elseif strcmpi(cond, 'LHvcong') == 1
                         STN.LHvcong = [STN.LHvcong;lhem];
                     elseif strcmpi(cond, 'LHvincg') == 1
                         STN.LHvincg = [STN.LHvincg;lhem];
                     end % fi cond string
                 end % left hemi k ==1

                 if k ==2 && ~isempty(stn{j,k})
                     rhem = stn{j,2};
                     if strcmpi(cond,'RHdcong') == 1
                         STN.RHdcong = [STN.RHdcong;rhem];
                     elseif strcmpi(cond, 'RHdincg') == 1
                         STN.RHdincg = [STN.RHdincg;rhem];
                     elseif strcmpi(cond, 'RHvcong') == 1
                         STN.RHvcong = [STN.RHvcong;rhem];
                     elseif strcmpi(cond, 'RHvincg') == 1
                         STN.RHvincg = [STN.RHvincg;rhem];
                     end % fi cond string
                 end % right hemi k ==2
             end % close test condition
         end %  fi empty
     end % k hemi
     end % j ( switched inner/ outer loop for hemisphere division) (j (row) become iner loop)

%  % store # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
%  if strcmpi(cond, 'dCong') == 1 
%      STN.dCong = [STN.dCong;dCong];
%      STN.ipDcong = [STN.ipDcong;ipDcong];
%      STN.ctDcong = [STN.ctDcong;ctDcong];
%  elseif strcmpi(cond, 'dIncg') == 1 
%      STN.dIncg = [STN.dIncg;dIncg];
%      STN.ipDincg = [STN.ipDincg;ipDincg];
%      STN.ctDincg = [STN.ctDincg;ctDincg];
%  elseif strcmpi(cond, 'vCong') == 1 
%      STN.vCong = [STN.vCong;vCong];
%      STN.ipVcong = [STN.ipVcong;ipVcong];
%      STN.ctVcong = [STN.ctVcong;ctVcong];
%  elseif strcmpi(cond, 'vIncg') == 1 
%      STN.vIncg = [STN.vIncg;vIncg];
%      STN.ipVincg = [STN.ipVincg;ipVincg];
%      STN.ctVincg = [STN.ctVincg;ctVincg];
%  end % # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 
fn = fieldnames(STN);
[fnx] =  find(contains(fn, cond,'IgnoreCase',true));
% for x = 1:size(fnx,1)
%     if contains((fn{fnx(x,1)}),'RT') == 1
%         (fnx(x,1)) == nan;
%     end
% end

for i = 1:size(fnx,1)
   %for f = 1:size(fn(fnx(i,1)),1)
%    if ~isempty(STN.(fn{fnx(i,1)}))
        for t = 1:size(STN.(fn{fnx(i,1)}),1)
            for c = 1:size(STN.(fn{fnx(i,1)}),2)
            vect(t,i) = size(STN.(fn{fnx(i,1)}){t,1},2);
            %vect(t,i) = size(STN.(fn{i}){t,1},2);
            end % clear c
        end;clear t % ~ ~ ~ ~ ~ ~ t
 
        mVect{:,i} = max(vect(:,i));
%    else isempty(STN.(fn{fnx(i,1)}))
%        msg = strcat((fn{fnx(i,1)}), '...', 'empty block');
%        disp(msg)
%    end % fi empty block
end % i 
% grab all time max dims
m2Mat = max(cell2mat(mVect));

for f = 1:size(fnx,1)
    for t = 1:size(STN.(fn{fnx(f,1)}),1)
        for c = 1:size(STN.(fn{fnx(f,1)}),2)
            if ~isempty(STN.(fn{fnx(f,1)}){t,c})
                vect(t,2) = mVect{1,f}-size(STN.(fn{fnx(f,1)}){t,c},2);
                nanpad = NaN(1,abs(vect(t,2)));
                %sigCue(t,:,c) = [STN.(fn{fnx(f,1)}){t,c},nanpad];
                sigCue{c}(t,:) = [STN.(fn{fnx(f,1)}){t,c},nanpad];
                rsp = flip(STN.(fn{fnx(f,1)}){t,c});
                
                
                %sigRsp(t,:,c)= [rsp,nanpad];
                sigRsp{c}(t,:)= [rsp,nanpad];
                
%                 cut = rsp(1:300);
%                 rspf{c}(t,:) = flip(cut);
                
                %         cuedata{t,c} = STN.(fn{fnx(f,1)}){t,c};
                %         rspdata{t,:,c} = rsp;
                
                clear nanpad
            end
        end % c
    end % t
    clear t % ~ ~ ~ ~ ~ ~ t
 %%   Cut the cue | rsp aligned signal to 250 frames from trial 2 on.
% dim 1 trials - first trial removed upstream processing
% dim 2 time(ms) - 1:250
% dim 3 channels
for b = 1:size(sigCue,1)
    for c = 1:size(sigCue,2)
        cueAll{b,c} = (sigCue{b,c}(1:end,1:300));
        %avgCueMua = nanmean(cueAll,1);
        rspAll{b,c} = (sigRsp{b,c}(1:end,1:300));
        %avgRspMua = nanmean(rspAll,1);
    end
end
    %% store # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
% %     if f == 1  
        trial = (strcat(fn{fnx(f,1)},'_trl'));
        average = (strcat(fn{fnx(f,1)},'_avg'));
        STN.cue.(trial) = cueAll;
%         STN.cue.(average) = avgCueMua;
        STN.rsp.(trial) = rspAll;
%         STN.rsp.(average) = avgRspMua;
        % STN.vCong_trl = muaAll;
        % STN.vCong_avg = avgMua;
        STN.sigcue.(trial) = sigCue;
        STN.sigrsp.(trial) = sigRsp;
        % cut and realigned with time vector 
%         STN.rspf.(trial) = rspf;
        % response time
%         STN.RT = RT;
    
% %     end
% %     if f == 2
% %         trial = (strcat(fn{fnx(f,1)},'_trl'));
% %         average = (strcat(fn{fnx(f,1)},'_avg'));
% %         STN.cue.(trial) = cueAll;
% % %         STN.cue.(average) = avgCueMua;
% %         STN.rsp.(trial) = rspAll;
% % %         STN.rsp.(average) = avgRspMua;
% %         % STN.ipVcong_trl = muaAll;
% %         % STN.ipVcong_avg = avgMua;
% %         STN.sigcue.(trial) = sigCue;
% %         STN.sigrsp.(trial) = sigRsp;
% %         % cut and realigned with time vector 
% % %         STN.rspf.(trial) = rspf;
% %         STN.RT = RT;
% %     end
% %     if f ==3
% %         trial = (strcat(fn{fnx(f,1)},'_trl'));
% %         average = (strcat(fn{fnx(f,1)},'_avg'));
% %         STN.cue.(trial) = cueAll;
% % %         STN.cue.(average) = avgCueMua;
% %         STN.rsp.(trial) = rspAll;
% % %         STN.rsp.(average) = avgRspMua;
% %         % STN.ctVcong_trl = muaAll;
% %         % STN.ctVcong_avg = avgMua;
% %         STN.sigcue.(trial) = sigCue;
% %         STN.sigrsp.(trial) = sigRsp;
% %         % cut and realigned with time vector 
% % %         STN.rspf.(trial) = rspf;
% %         STN.RT = RT;
% %     end % cond f
    clear vect cueAll rspAll avgCueMua avgRspMua sigCue sigRsp
end % 'f'
clear sigCue sigRsp mVect

% remove fields
if strcmpi(cond, 'dCong') == 1 %isfield(STN,'ctDcong')
    STN = rmfield(STN,'dCong');
    STN = rmfield(STN,'ipDcong');
    STN = rmfield(STN,'ctDcong');
elseif strcmpi(cond, 'dIncg') == 1 %isfield(STN,'ipDincg')
    STN = rmfield(STN,'dIncg');
    STN = rmfield(STN,'ipDincg');
    STN = rmfield(STN,'ctDincg');
elseif strcmpi(cond, 'vCong') == 1 %isfield(STN,'ipVcong')
    STN = rmfield(STN,'vCong');
    STN = rmfield(STN,'ipVcong');
    STN = rmfield(STN,'ctVcong');
elseif strcmpi(cond, 'vIncg') == 1 %isfield(STN,'ipVincg')
    STN = rmfield(STN,'vIncg');
    STN = rmfield(STN,'ipVincg');
    STN = rmfield(STN,'ctVincg');
end


end
