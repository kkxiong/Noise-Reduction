function noise_reduction()

debug = true;
noiseLevel = 0.5;
algorithm = 1;

[speech, fss] = audioread('voice.wav');
[noise, fsn] = audioread('noise.wav');

samplingFreq = fss;
if (samplingFreq ~= 48000) 
    disp('sample freq not supprted');
    return;
end

monoSpeech = speech(:,1);
monoNoise = noise(:,1);
noisySpeech = monoSpeech + noiseLevel * monoNoise;

audiowrite('speech_noisy.wav', noisySpeech, fss);
if (algorithm == 1)
    [speech_nr1, speech_nr2] = WienerNoiseReduction(noisySpeech, samplingFreq);
    audiowrite('speech_nr11.wav', speech_nr1, fss);
    audiowrite('speech_nr12.wav', speech_nr2, fss);
elseif (algorithm == 2)
    speech_nr = SSBoll79(noisySpeech, samplingFreq, 4);
    audiowrite('speech_nr2.wav', speech_nr, fss);
elseif (algorithm == 3)
    speech_nr = SSMultibandKamath02(noisySpeech, samplingFreq, 4);
    audiowrite('speech_nr3.wav', speech_nr, fss);
end


