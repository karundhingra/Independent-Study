
hfr = dsp.AudioFileReader('Filename','adtBabble2.wav',...
     'OutputDataType','double');
 hfr.SamplesPerFrame = hfr.SampleRate*8;
 % set up array to read in ten segments of 4 seconds
       data = zeros(hfr.SamplesPerFrame,10); 
% now read the data using the step() method
 for n = 1:40
     % read one frame of audio ten seconds in length
     audioframe = step(hfr);
     % extract a single channel of the two channel .wav file
     audiosample = audioframe(:,1);
     % place the 10-second audio sample in the matrix 
     data(:,n) = audiosample;
 end
 
% choose the 5-th column as your audio sample
%creating audio signla mixed with noise on positive SNR
y1 = data(:,5); 
for i = 20:61
    for j = 1:9
        Inputfilename = sprintf('C:/Users/karun/Desktop/Signal Processing/IEEE_male/S_%d_0%d.wav', i,j);
        disp(Inputfilename);
        [ speech, fs] = audioread(Inputfilename);
        for k = 38:-4:2          
                       
            y1 = data(:,k);        
    
            %[ noise, fs] = audioread( 'ssn.wav' );
    
            snr = 5; 
    
    
            noisy = addnoise( speech, y1, snr );
        
            filename = sprintf('C:/Users/karun/Desktop/mixed_signal_possnr/noisy_%d_%d_%d_pos5.wav', i,j,k);
            audiowrite(filename, noisy, fs)
        end
    end
end
%creating audio signla mixed with noise on negative SNR
for i = 20:61
    for j = 1:9
        Inputfilename = sprintf('C:/Users/karun/Desktop/Signal Processing/IEEE_male/S_%d_0%d.wav', i,j);
        disp(Inputfilename);
        [ speech, fs] = audioread(Inputfilename);
        for k = 38:-4:2          
                       
            y1 = data(:,k);        
    
            %[ noise, fs] = audioread( 'ssn.wav' );
    
            snr = -5; 
    
    
            noisy = addnoise( speech, y1, snr );
        
            filename = sprintf('C:/Users/karun/Desktop/mixed_signal_negsnr/noisy_%d_%d_%d_neg5.wav', i,j,k);
            audiowrite(filename, noisy, fs)
        end
    end
end
   
%function for mixing signal and noise on the giving snr
  function [ noisy, noise ] = addnoise( signal, noise, snr )
    % inline function for SNR calculation
    SNR = @(signal,noisy)( 20*log10(norm(signal)/norm(signal-noisy)) );

    % needed for older realases of MATLAB
    randi = @(n)( round(1+(n-1)*rand) );

    % ensure masker is at least as long as the target
    S = length( signal );
    N = length( noise );
    if( S>N ), error( 'Error: length(signal)>length(noise)' ); end;

    % generate a random start location in the masker signal
    R = randi(1+N-S);

    % extract random section of the masker signal
    noise = noise(R:R+S-1);

    % scale the masker w.r.t. to target at a desired SNR level
    noise = noise / norm(noise) * norm(signal) / 10.0^(0.05*snr);

    % generate the mixture signal
    noisy = signal + noise;

    % sanity check
    %assert( abs(SNR(signal,noisy)-snr) < 1E10*eps(snr) ); 
    end
    

%%% EOF

    

    