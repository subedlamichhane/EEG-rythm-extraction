clc
clear all
load('test.mat')
fs=200;%sampling frequency 200 HZ
dat=test.data;%data initializtion
%%step 2 : common spatial filterring and DC removal
[z1,z2]=crsf(dat)%step 2 o/p in z
ch15=dat(15,:);
psch15=z1(15,:);%load ch5 with processed chanel C3 data
%%figure;
%%freqz(ch15,1,1024,fs);%unprocessed channel C3 frequency plot
%%figure;
%%freqz(ch15,1,1024,fs);
%%filter application
b=bpf();
fildat=filter(b,1,z1);%filteration of processed data
fltch15=fildat(15,:);
figure;
%freqz(fltch15,1,1024,fs);%%Filtered channel C3 frequency plot
plot(fltch15);
title('preprocessed C3 data after filtered by bpf')

%%%fragment extraction
tt=12000/200;%total time of a channel in sec
n=randi(tt-5);%random time selection
t1=n/tt;
t2=t1+0.5;
n1=fix(t1*12000);
n2=fix(t2*12000);
nfframe=dat(15,[n1:n2])
frame=fildat(15,[n1:n2]);
figure;
%pxx=pburg(frame,10,[],200)
pburg(nfframe,10,[],200);%%Auto regressive power spectrum Analysis of chanel C3
title('C3 spectrum for random 0.5 sec fragment for unfiltered data')

figure;
%pxx=pburg(frame,10,[],200)
pburg(frame,10,[],200);%%Auto regressive power spectrum Analysis of chanel C3
title('C3 spectrum for random 0.5 sec fragment')




