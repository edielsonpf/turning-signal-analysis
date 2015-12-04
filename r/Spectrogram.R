library (phonTools)
#data (sound)                 ## use the example 'sound' object provided
sound = loadsound('C:/Users/Edielson/Documents/Researches/turning-signal-analysis/data/selected/vc_200_f_010_ap_010-1.wav')
#par (mfrow = c(3,1), mar = c(4,4,1,1))
spectrogram (sound,maxfreq = 22050)
axis(1,cex=10)
axis(2,cex=10)
title(xlab= "Time (ms)", cex=15)
title(ylab= "Frequency (Hz)", cex=15)

sound = loadsound('C:/Users/Edielson/Documents/Researches/turning-signal-analysis/data/selected/vc_240_f_010_ap_010-1.wav')
spectrogram (sound,maxfreq = 22050)

sound = loadsound('C:/Users/Edielson/Documents/Researches/turning-signal-analysis/data/selected/vc_186_f_015_ap_015-1.wav')
spectrogram (sound,maxfreq = 22050)

sound = loadsound('C:/Users/Edielson/Documents/Researches/turning-signal-analysis/data/selected/vc_220_f_023_ap_015-1.wav')
spectrogram (sound,maxfreq = 22050)
#spectrogram (sound, fs = 44100, windowlength = 20, timestep = 10, padding = 10, preemphasisf = 50, maxfreq = 22050, colors = TRUE, dynamicrange = 50, nlevels = dynamicrange, maintitle = "", show = TRUE, window = 'hamming', windowparameter = 3, quality = FALSE)



#spectrogram (sound, color = 'alternate')
#spectrogram (sound, color = FALSE)


## Not run: 
#data(tico) 
#data(pellucens) 
# simple plots 
spectro(sound,f=44100) 
#spectro(tico,f=22050,osc=TRUE) 
#spectro(tico,f=22050,scale=FALSE) 
#spectro(tico,f=22050,osc=TRUE,scale=FALSE) 
