%snlo 2d mixing
%SHG 785+785=392

% close all
clear all

% cd('C:\SNLO\2D-mix-SP_785+785\10mm_correct_walkoff')
% cd('C:\SNLO\2D-mix-SP-785-785_40fs')
% cd('C:\SNLO\2D-mix-SP-785-785_45fs')
cd('C:\SNLO\2d-mix-SP-785-785_35fs');


%%%%% temporal structure
% crystal_thickness = [100 150 200 250 300 400 500 750 1000];
% crystal_thickness = [100 150 200 250 300 400];
% crystal_thickness = [250 500 750 1000 1500];
% crystal_thickness = [100 200 250 300 350 400 500];
% crystal_thickness = [100 150 200 250 300 350];
% crystal_thickness = [125 150 200 250 300 500];
% crystal_thickness = [100 150 175 200 250];
% crystal_thickness = [100 115 125 130 135 150];
% spot_size = 6.5;
crystal_thickness = [120 140 150];
spot_size = 7.5;
% crystal_thickness = [100 150 200 250 300 350];
% spot_size = 10;



cm = jet(length(crystal_thickness));

figure(1)
hold on

power_str = '_3.5mJ';

for ii=1:length(crystal_thickness)
    cd([num2str(spot_size) 'mm_' num2str(crystal_thickness(ii)) 'um' power_str]);
    y=load('BEAM_3TP.DAT');
    t=load('BEAM_3TI.DAT'); %leftover fundamental
    plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:));
    peak_power(ii) = max(y(:,2));
    peak_power_fund(ii) = max(t(:,2));
    str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
    cd ..
end
box on
xlabel('Time [fs]')
ylabel('Power [MW]')
legend(str)

%plot SH peak power vs crystal length
figure(2)
hold on
plot(crystal_thickness,peak_power,'b-o')
plot(crystal_thickness,peak_power_fund*2,'r-s')
xlabel('crystal thickness [µm]')
ylabel('Peak power [MW]')
legend('SH peak power','idler peak power x2')

%%%SH spectrum
for ii=1:length(crystal_thickness)
    cd([num2str(spot_size) 'mm_' num2str(crystal_thickness(ii)) 'um' power_str]);
    y=load('BEAM_3WP.DAT');
%     plot(3*1e5./(y(:,1)+381.9*2),y(:,2)/max(y(:,2)),'color',cm(ii,:))
    wl_axis=3*1e5./(y(:,1)+2*381.901);
    fit=fitcurve_gaussian(wl_axis',y(:,2)'/max(y(:,2)),[1 400 10 0])
    sp_fwhm(ii)=abs(fit(3))*2.35482;
    str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
    cd ..
end
% figure(3)
% hold on
% box on
% xlabel('Wavelength [nm]')
% ylabel('Power [MW]')
% legend(str)


figure(4)
hold on
plot(crystal_thickness,sp_fwhm,'-o')
xlabel('Wavelength [nm]')
ylabel('Spectrum FWHM [nm]')


% %% SH spectrum FWHM by hand
% figure
% plot([100 150 200 250 300 400 500],2*(392.773-[389.76 389.93 390.12 390.3 390.475 390.77 391.04]),'-o')
% xlabel('Crystal thickness [µm]')
% ylabel('SH spectrum FWHM [nm]')


% %%%fund spectrum

% figure
% hold on
% 
% for ii=1:length(crystal_thickness)
%     cd(['5mm_' num2str(crystal_thickness(ii)) 'mm']);
%     y=load('BEAM_3WS.DAT');
%     plot(3*1e5./(y(:,1)+381.9),y(:,2)/max(y(:,2)),'color',cm(ii,:))
%     str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
%     cd ..
% end
% box on
% xlabel('Wavelength [nm]')
% ylabel('Power [MW]')
% legend(str)

