%% Initialization
tic;
clc;
clear;
close all;

%% Data Import
file_path = '../data/1000Hz.txt'; % Modify this to read other files
data=textread(file_path,'%f');

%% Data Preprocessing
n=2:2:size(data);
y=data(n)';
m=1:2:size(data);
t=data(m)';
[i,j]=size(m);
fs=j/t(1,j); % sampling rate
Ts=1/fs;
N=j; % total point
delta_f=1*fs/N;

%% Fourier Analysis
figure(1);
subplot(2,1,1)
plot(t,y);
title('time domain')
Y=fftshift(abs(fft(y)));
f=(-(N-1)/2:(N-1)/2)*delta_f;
subplot(2,1,2)
plot(f,Y);
title('frequency domain')

%% WSST Analysis
[sst,f]=wsst(y,fs);

%% Data Visualization
figure(2)
pcolor(t,f,abs(sst));shading flat;
colorbar;

% Control font size, font, bolding
set(gca,'fontsize',14,'fontname','Times new roman','fontweight','bold');
set(gca,'YDir','normal')
xlabel('Time/s','Fontweight','bold');
ylabel('Frequency/Hz','fontweight','bold');
title('Wavelet transform','fontweight','bold');

%% Run Time Calculation
elapsed_time = toc;
fprintf('Total elapsed time: %.2f seconds\n', elapsed_time);