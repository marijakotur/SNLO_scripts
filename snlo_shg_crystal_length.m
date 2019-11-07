close all
clear all


% l = [0.1:0.1:0.5 0.75:0.25:1.5];
crystal_thickness = [100:20:220 250 300 400 500];
power_str = '_2.5mJ_3.3mJ';

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
for i=1:length(crystal_thickness)
%     subplot(3,3,i)
    hold on
    cd(['10mm_8mm_' num2str(crystal_thickness(i)) 'um' power_str])
%     y = load(['PWMIX_SP_' num2str(l(i)*100,'%03.0f') '.DAT']);
    y = load(['PWMIX_SP.DAT']);
    z = load('PWMIXSPS.DAT');

    figure(1)
    plot(y(:,1)*1e15,y(:,3),'linestyle','--');
    plot(y(:,1)*1e15,y(:,4));
    axis tight
%     s(i)=sum(y(:,4));
    s(i)=sum(y(:,4))*max(diff(y(:,1)));
    figure(2)
%     plot(z(:,1)*1e15,z(:,3),'linestyle','--');
    wl_axis=3*1e5./(z(:,1)+3*381.901);
    plot(wl_axis,z(:,4));
    title(['SFG bandwidth vs crystal_thickness'])
    fit=fitcurve_gaussian(wl_axis',z(:,4)'/max(z(:,4)),[1 262 0.8 0]);
    sp_fwhm(i)=abs(fit(3))*2.35482;
    str{i} = [num2str(crystal_thickness(i)) ' µm'];
    axis([255, 268, -inf, inf]);
    
    cd ..
end
legend(str)

figure(3)
subplot(1,2,1)
hold on
box on
grid on
plot(crystal_thickness,sp_fwhm,'-o')
xlabel('Crystal thickness [µm]')
ylabel('TH bandwidth')


subplot(1,2,2)
hold on
box on
grid on
plot(crystal_thickness,s/max(s),'-o')
xlabel('Crystal thickness [µm]')
ylabel('TH signal (summed)')


%within a data sets

%PWMIX_SP columns
%1: time axis
%2: red1 irradiance
%3: red2 irradiance
%4: blue irradiance
%5: red1 phase
%6: red2 phase
%7: blue phase

% s=load('PWMIXSPS_050.DAT');
