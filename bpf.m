

function [b]= bpf()

%- Passband: 8 Hz to 30 Hz;
%- Transition bands: 1 Hz each;
%- Passband ripple: 0.01;
%- Stopband attenuation: -41 dB.
load('test.mat')
rp=-20*log10(1-0.01);
rs=48;
rplin=0.01;
rslin=10^(-2.05);
fs=200;
%fnorm=freq/fs;
%f2=[7 8 30 31];
%a2=[0 1 1 0];
[n,fo,mo,w] = firpmord( [ 7 8 30 31], [ 0 1 0 ], [rslin  rplin  rslin], fs );
b=firpm(n,fo,mo,w);
%n
figure(1)
freqz(b,1,256,fs);
%fvtool(b,1);


c3=test.data(15,:);
figure(2)
plot(c3);
title('original eeg signal of C3 Channel');


y=filter(b,1,c3);
figure(3);
plot(y)
title('filtered eeg signal using designed bpf filter');
end
