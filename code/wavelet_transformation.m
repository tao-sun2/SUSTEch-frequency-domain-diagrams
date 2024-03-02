clc;
clear;
data=textread('1000Hz.txt','%f');
n=2:2:size(data);
y=data(n)';
m=1:2:size(data);
t=data(m)';
[i,j]=size(m);[ii,jj]=size(m);
fs=j/t(1,jj);%采样频率 总点数//时间
Ts=1/fs;%
N=j;%序列数（总点数）
delta_f=1*fs/N;
figure(1);
subplot(3,1,1)
plot(t,y);
Y=fftshift(abs(fft(y)));
f=(-N/2:N/2-1)*delta_f;
subplot(3,1,2)
plot(f,Y);
wp=0.01/(fs/2); %滤掉该数据之前的噪音
ws=20/(fs/2); %该数据小于但接近需要频率
alpha_p=0.1; %接近需要频率的衰减强度
alpha_s=25;%噪音衰减强度
[N4,wn]=buttord(wp,ws,alpha_p,alpha_s);
[b,a]=butter(N4,wn,'high');
filter_bs_s = y;%滤波后原始数据
%filter_bs_s=filter_bs_s';
Y_bs_s = fftshift(abs(fft(filter_bs_s)))/N;
figure(2);
subplot(3,1,1);
plot(t,filter_bs_s);
grid on;
title('带阻滤波后时域图形');
subplot(3,1,2);
plot(f,Y_bs_s);
title('带阻滤波后频域幅度特性');


%%%%%%%%%%%   t(1,i)>x  x代表删掉xs以前的数据
for i=1:jj
if t(1,i)>0.05;
    p=i;
    break;
end
end
tt=zeros(1,jj-p+1);filter_bs_ss=zeros(1,jj-p+1);
for i=p:jj 
tt(1,i-p+1)=t(1,i);
end
for j=p:jj
    filter_bs_ss(1,j-p+1)=filter_bs_s(1,j);
end

figure(3)
subplot(2,2,1)
plot(t,filter_bs_s);
[sst,f]=wsst(filter_bs_s,jj/t(1,jj-p+1));
subplot(2,2,2)
pcolor(t,f,abs(sst));shading flat                                                                                                                                                                                                                                 
subplot(2,2,3)
plot(tt,filter_bs_ss);
[sst,f]=wsst(filter_bs_ss,jj/tt(1,jj-p+1));%提高分辨率（可以在wsst函数的79行中添加na=64-512，进一步调整分辨率）
subplot(2,2,4)
pcolor(tt,f,abs(sst));shading flat




%%%%%%%  tt为掐掉开头后的时间，ttt为tt归零后的时间
ttt=zeros(1,jj-p+1);
for i=1:jj-p+1
    ttt(1,i)=tt(1,i)-tt(1,1);
end
figure(4)
plot(ttt,filter_bs_ss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%作图 figure5
figure(5)
pcolor(ttt,f,abs(sst));shading flat                                                                                                                                                                                                                                 ;
colorbar;

%%%%控制字号、字体、加粗
set(gca,'fontsize',14,'fontname','Times new roman','fontweight','bold');
set(gca,'YDir','normal')
xlabel('Time/s','Fontweight','bold');

%%%%%%  调整坐标轴范围及间隔
%axis([0 5 200]);%%%%%%  前两个数值代表x轴的范围；后两个数值代表y轴范围
%set(gca,'XTick',0:0.5:5);%%%%%%  t：x：y代表x轴从t到y中间以x为间隔画图，注意t与y与上一行的前两个数值相同
%set(gca,'YTick',0:20:200);%%%%%%  tt：xx：yy代表y轴从tt到yy中间以xx为间隔画图，注意tt与yy与上两行的后两个数值相同
ylabel('Frequency/Hz','fontweight','bold');
title('Wavelet transform','fontweight','bold');

jjj(1,:)=ttt(1,:);
jjj(2,:)=filter_bs_ss(1,:);
jjj=jjj';
xlswrite('1000Hz.xls',jjj,1);

%%%控制图形大小
width=180;%宽度，像素数
height=18;%高度
left=20;%距屏幕左下角水平距离
bottem=10;%距屏幕左下角垂直距离
set(gcf,'position',[left,bottem,width,height])




