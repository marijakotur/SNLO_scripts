% 2d 785nm + 392.5nm 
% col1: delay in fs
% col2: output pulse energy in mJ
% col3: output peak irradiance in 1e10W/sq cm

data = [8, 0.827, 2.75;
    0, 1.13, 3.5;
    -8, 1.45, 4.15;
    -15, 1.67, 4.46;
    -18, 1.74, 4.48; 
    -19, 1.76, 4.49; 
    -20, 1.77, 4.48; 
    -22, 1.79, 4.44; 
    -24, 1.81, 4.39;
    -26, 1.81, 4.32;
    -29, 1.80,4.17;
    -34, 1.73,3.89;
    -39, 1.62,3.63;
    -49, 1.28, 3.22;
    -59, 0.908, 2.64];

% plotyy(data(:,1),data(:,2),data(:,1),data(:,3))

bw_data = [-59, 1.9416;
    -49, 1.8842;
    -39, 1.8549;
-34, 1.8501;
    -26,  1.8548;
    -24, 1.8525;
    -20, 1.8671;
    -15, 1.8829;
    -8, 1.9138;
0, 1.9639
8, 2.0273];

% hold on
% plot(bw_data(:,1),bw_data(:,2))
[ax, ay1, ay2] = plotyy(data(:,1),data(:,2),bw_data(:,1),bw_data(:,2));
xlabel(ax(1),'Delay [fs]')
ylabel(ax(1),'Pulse energy [mJ]')
ylabel(ax(2),'Bandwidth [nm]')



