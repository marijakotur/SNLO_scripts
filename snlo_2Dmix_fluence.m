close all
clear all

% %2D fluence
% data=load('FLUENCE3.DAT');
%
% x=data(1:32,1);
% y=data((0:31)*32+1,2);x
% blue = reshape(data(:,5),32,[])
% red1 = reshape(data(:,3),32,[])
%
% surf(x,y,red1)
% axis tight

%  3D intensity
%  SIG_INT3.DAT (red1), ID_INT3.DAT (red2), PMP_INT3.DAT (blue),

d=load('BEAM_3TP.DAT');
time = d(:,1);

data1=load('SIG_INT3.DAT ');
data2=load('PMP_INT3.DAT ');
% #x_points*#y_points x #time_points+2
% data1(:,1) is the x axis repeated
% data1(:,2) is the y axis with each point repeated #x_point times
x=data1(1:32,1);
y=data1((0:31)*32+1,2);
C = strsplit(pwd,'\');

%plot the spatial outline through the middle of the spatial distribution for different delays
for i = 1:length(time)
    time_slice = reshape(data1(:,i+2),32,[]);
    outline_thru_max = time_slice(16,:);
    red1(i,:) = outline_thru_max;
    
    time_slice2 = reshape(data2(:,i+2),32,[]);
    outline_thru_max2 = time_slice2(16,:);
    blue(i,:) = outline_thru_max2;
    %     sumred1 = sum(sum(data1(:,3:end))); %[]
end

figure('Renderer', 'painters', 'Position', [100 100 1200 550])

subplot(1,2,1)
h = surf(x*1e3-round(mean(x*1e3)),time*1e15,red1)
set(gca,'fontsize',12);
% set(h,'Linewidth',0.5)
xlabel('Space [mm]')
ylabel('Time [fs]')
zlabel('Irradiance')
axis tight
title(C{end},'Interpreter','None')
view(115,30)

subplot(1,2,2)
surf(x*1e3-round(mean(x*1e3)),time*1e15,blue)
set(gca,'fontsize',12);
xlabel('Space [mm]')
ylabel('Time [fs]')
zlabel('Irradiance')
axis tight
title(C{end},'Interpreter','None')
view(115,30)

% dAdt = max(diff(time))*max(diff(x))*max(diff(y)); %[s*m^2]
% sumred1*dAdt*1e3
% surf(x,y,red1)
% axis tight

% figure
% hold on
% cm=jet(size(red1,1));
% for i =1:size(red1,1)
%     %     subplot(4,8,i)
%     %     waterfall(x,y,red1(:,i));
%     plot(x,red1(:,i),'color',cm(i,:));
% end
% 
