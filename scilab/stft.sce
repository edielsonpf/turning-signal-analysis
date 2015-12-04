clf();
N=1024;
[x,Fs,bits]=wavread('C:\Users\Edielson\Documents\Researches\turning-signal-analysis\data\selected\vc_200_f_010_ap_010-1.wav');
t=0:1/Fs:(length(x)-1)/Fs;
subplot(211);
plot(t(1:N),x(1:N));
subplot(212); 
[tfr,t,f]=tfrstft(x(1:N)');
t=t./Fs;

grayplot(t,f,abs(tfr)');
//[sp,T,F] = Ctfrsp(x,1:1024,1024);
//grayplot(T,F,sp');
