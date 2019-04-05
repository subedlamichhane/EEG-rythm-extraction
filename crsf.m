function [z1ac z2ac]=crsf(eegdata)
%%% common refrene spacial filter implementation and DC removal

N=1200;
load ('test.mat');
eegdata=(test.data);
%number of channels
K=32;
fs=200;
R1=eegdata([1:16],:);%first class
R2=eegdata([17:32],:);%second class
r1=(R1*R1')/trace(R1*R1');
r2=(R2*R2')/trace(R2*R2');
n=length(r1);
r1=mean(r1,8);
r2=mean(r2,8);
r=r1+r2;
[U,Lambda] = eig(r);%%eigen vector generation
[Lambda,ind] = sort(diag(Lambda),'descend');
U=U(:,ind);
P=sqrt(inv(diag(Lambda)))*U';%%penalty calculation
S{1}=P*r1*P';
S{2}=P*r2*P';
[B,G] = eig(S{1},S{2}); 
[G,ind] = sort(diag(G)); 
B = B(:,ind);
W=(B'*P);%%common spatial filter cofficients
for i=1:length(ind), W(i,:)=W(i,:)./norm(W(i,:)); end

%C3=test.data(15,:);
z1=W*eegdata([1:16],:);
z2=W*eegdata([17:32],:);
%std(eegdata(15,:));variance of original data
%std(z(15,:));variance of filtered data
figure(4);
subplot(2,1,1);
plot(z1(15,:));
title('C3 data after filtered with common spatial filter');


%%%%%%DC removal %%%%%%%%%
for i=1:16
    for j=1:1200
        z1ac(i,:)=detrend(z1(i,:));
        j=j+1;
    end
end 
for i=1:16
    for j=1:1200
        z2ac(i,:)=detrend(z2(i,:));
        j=j+1;
    end
end 
subplot(2,1,2)
plot(z1ac(15,:));
title('C3 data after application of common spatial filter and DC removal')
end




