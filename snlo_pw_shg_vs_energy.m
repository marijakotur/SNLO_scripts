% close all
clear all


% l = [0.1:0.1:0.5 0.75:0.25:1.5];
crystal_thickness =180;
power = [1 2 2.5 3 3.3 3.6 6 10 ];
% power = [2 2.5 3 4 6];

power = [    1.5000    2.0000    2.5000    3.0000    3.5000
             5.8000    4.8000    3.8000    2.8000    1.8000];

% power = [    1.5000    2.0000    2.5000    3.0000    3.5000
%              5.5000    4.5000    3.5000    2.5000    1.5000  ];


figure(1)
hold on
cm = jet(length(crystal_thickness));
xlabel('Time [fs]')
ylabel('Irradiance MW/cm^2')

figure(2)
xlabel('Wavelength [nm]')
ylabel('Signal [arb.]')
hold on

%compare irradiances from different data sets
for i=1:length(power)
    %     subplot(3,3,i)
    hold on
    %     power_str = ['_2.5mJ_' num2str(power(i)) 'mJ'];
    power_str = ['_' num2str(power(1,i)) 'mJ_' num2str(power(2,i)) 'mJ'];
    %     power_str = ['_' num2str(power(i)) 'mJ_3.3mJ'];
    cd(['10mm_8mm_' num2str(crystal_thickness) 'um' power_str])
    %     y = load(['PWMIX_SP_' num2str(l(i)*100,'%03.0f') '.DAT']);
    y = load(['PWMIX_SP.DAT']);
    z = load('PWMIXSPS.DAT');
    
    figure(1)
    plot(y(:,1)*1e15,y(:,3),'linestyle','--');
    plot(y(:,1)*1e15,y(:,4));
    axis tight
    %     s(i)=sum(y(:,4));
    s(i)=sum(y(:,4))*max(diff(y(:,1)));
    %     max(diff(y(:,1)))
    figure(2)
    %     plot(z(:,1)*1e15,z(:,3),'linestyle','--');
    wl_axis=3*1e5./(z(:,1)+3*381.901);
    plot(wl_axis,z(:,4));
    title(['SFG bandwidth vs crystal_thickness'])
    fit=fitcurve_gaussian(wl_axis',z(:,4)'/max(z(:,4)),[1 262 0.8 0]);
    sp_fwhm(i)=abs(fit(3))*2.35482;
    %     str{i} = [num2str(crystal_thickness(i)) ' µm'];
    
    axis([255, 268, -inf, inf]);
    
    cd ..
end
% legend(str)

figure(3)
subplot(1,2,1)
hold on
box on
plot(power(2,:),sp_fwhm,'-o')
xlabel('SH energy [mJ]')
ylabel('TH bandwidth')


% figure(4)
subplot(1,2,2)
hold on
box on
plot(power(2,:),s,'-o')
xlabel('SH energy [mJ]')
ylabel('TH signal (summed)')


%within a data set

%PWMIX_SP columns
%1: time axis
%2: red1 irradiance
%3: red2 irradiance
%4: blue irradiance
%5: red1 phase
%6: red2 phase
%7: blue phase

% s=load('PWMIXSPS_050.DAT');
