%% SNLO plane wave SFG
% close all
clear all

% crystal_thickness = [75 100 150 200 275 350 500 1000];
% fname = 'PW_785_392_';
% crystal_thickness = [150 200 250 350 500];
% fname = 'PW_785_392_';
% crystal_thickness = [100 150  200 275 350 500 ];
% crystal_thickness = [50 100 150 200 250 300 500];
% fname = 'PW_10mm_8mm_';

% crystal_thickness = [50 60 80 90 100 120 140 160 180];
% fname = '7mm_7mm_';
crystal_thickness = [80 100 120];
fname = '7mm_6mm_';

cm = jet(length(crystal_thickness));

figure(1)
hold on

for ii=1:length(crystal_thickness)
    cd([fname num2str(crystal_thickness(ii)) 'um_1.9mJ_3.2mJ']);
    y=load('PWMIX_SP.DAT');
    plot(y(:,1)*1e15,y(:,4),'color',cm(ii,:))
    s(ii)=sum(y(:,4));
    str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
    cd ..
end
box on
xlabel('Time [fs]')
ylabel('Irradiance [W/m^2]')
legend(str)

figure(2)
hold on
plot(crystal_thickness,s,'-o')
xlabel('Crystal thickness [µm]')
ylabel('TH signal (summed)')

figure(3)
hold on

for ii=1:length(crystal_thickness)
%     cd([fname num2str(crystal_thickness(ii))]);
    cd([fname num2str(crystal_thickness(ii)) 'um_1.9mJ_3.2mJ']);

    y=load('PWMIXSPS.DAT');
    wl_axis=3*1e5./(y(:,1)+3*381.901);
    plot(wl_axis,y(:,4),'color',cm(ii,:))
    fit=fitcurve_gaussian(wl_axis',y(:,4)'/max(y(:,4)),[1 262 2 0])
    sp_fwhm(ii)=abs(fit(3))*2.35482;
    str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
    cd ..
end
box on
xlabel('Wavelength [nm]')
ylabel('Signal [norm]')
legend(str)

figure(4)
hold on
plot(crystal_thickness,sp_fwhm,'o-')
xlabel('Crystal thickness [µm]')
ylabel('SH spectrum FWHM [nm]')
