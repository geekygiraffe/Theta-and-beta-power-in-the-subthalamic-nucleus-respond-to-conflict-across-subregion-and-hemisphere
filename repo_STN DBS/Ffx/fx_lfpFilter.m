function [lfp]= fx_lfpFilter(sig)
 %extracted local field potential (LFP) activity from each macroelectrode 
 % bandpass filtered both signals between 1 and 500 Hz, 
 % notch filtering at 60 Hz, and downsampled the data to 1 kHz.
 
 %magnitude and instantaneous phase information in the frequency domain
 %convolved the LFP signals captured from the STN from each trial 
 %with complex valued Morlet wavelets (wave number 6).
 % 47 logarithmically spaced (8 scales/octave) wavelets between 2 and 107 Hz 
 %and convolved each wavelet with 3000 ms of LFP data from each trial. 
 
 %For cue-locked analyses, 
 % analyzed LFP signals from 1000 ms before to 2000 ms following arrow presentation. 
 %For response-locked analyses, 
 % analyzed LFP signals from 1500 ms before to 1500 ms after the response. 
 % used a 1000 ms buffer on both sides of the clipped data to eliminate edge effects.
 % squared the magnitude of the continuous-time wavelet transform 
    %to generate a continuous measure of instantaneous power for each frequency. 
 
 % determined the z-scored power from each channel and frequency using the mean and standard deviation of the power recorded from that channel during a baseline period. We defined the baseline period as the 500 ms preceding the presentation of the fixation cue in each trial, and used the mean power during this baseline period to normalize all cue and response locked analyses. During this time, the participants were staring at a blank screen between two adjacent trials.
 %
fs = 44000;
[B,A] = butter(3,[1 500]/(fs/2));
notchFilt = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
               'DesignMethod','butter','SampleRate',fs);
%                         define signal - - - - - - - - - - - - - - - -
%   data = rspk(s);
%                         sig = detrend(double((data.raw{b,1}.(fn{k}))));
%                         raw.signal{b,1}.(fn{k}) = sig;
%                         filter
%                         [data]= fx_muaFilter(data)

                        % filter - - - - - - - - - - - - - - - - - - -
                        fsig = filter(B,A,sig);
                        ffsig = filtfilt(notchFilt,fsig);
                        
                        % downsample to fs 1000 (1000 samples per second)
                         ds = 1000;
                         x = fs/ds;
                         if ~isempty(ffsig)
                           lfp = downsample(ffsig,x);  
                             
                         else
                             disp('empty sig')
                             lfp = [1 1 1];
                         end
                         
 % downsample to fs 1000 (1000 samples per second)
%                         dsmua = downsample(ffsig,44);
%                         sqmua = sqrt(dsmua);
                        %gaussian filter
%                         sig = real(sqmua);
%                         sigma = 50;
%                         lfp = imgaussfilt(sig,sigma);
% # # # # # # # # # # # # # # # # # # 
%                         data.muaSignal{b,1}.(fn{k}) = sqrsig;
%                         data.rms = rsig;
                        
end
                        
%%
%{
                       %define signal - - - - - - - - - - - - - -
                                sig = (data(s).incg{b,c}{t,r});
                                incg.sig{b,c}{t,r} = sig;
                                [mua]= fx_muaFilter(sig)
%                                 % filter - - - - - - - - - - - - - - - - -
%                                 fsig = filter(B,A,sig);
%                                 incg.fsignal{b,c}{t,r} = fsig;
%                                 % downsample - - - - - - - - - - - - - - -
%                                 dsig = downsample(fsig,88);
%                                 incg.dsignal{b,c}{t,r} = dsig;
%                                 % clip +/- 2 std - - - - - - - - - - - - -
%                                 S = 2.*(std(dsig));
%                                 clear i % ~ ~ ~ ~ ~ ~ ~
%                                 for i = 1:size(dsig,2)
%                                     if dsig(1,i) < -S
%                                         dsig(1,i) = 0;
%                                     elseif dsig(1,i) > S
%                                         dsig(1,i) = 0;
%                                     end % fi | elseif
%                                 end % i
%                                 % impose a threshold  - - - - - - - - - - - - -
%                                 signal = abs(dsig);
%                                 mn = mean(signal);
%                                 mx = max(signal);
%                                 thr = mx-mn;
%                                 clear j % ~ ~ ~ ~ ~ ~ ~
%                                 for j = 1:size(sig,2)
%                                     if sig(j) < thr
%                                         sig(j) = 0;
%                                     end
%                                 end % j
                                %find peaks & location of filtered, downsampled, clipped signal
                                %[sppk ,ploc] = findpeaks(dsig);
%%
%}