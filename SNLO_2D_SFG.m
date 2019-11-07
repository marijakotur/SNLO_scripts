%snlo 2d mixing
%SHG 785+392=262

% close all
clear all

%%%%% temporal structure
% crystal_thickness = [80 100 150 175 200];
% crystal_thickness = [200 300 500];
crystal_thickness = [50 100 150 200 250 300 500];
cm = jet(length(crystal_thickness));

figure
hold on

for ii=1:length(crystal_thickness)
    cd(['6mm_8mm_' num2str(crystal_thickness(ii)) 'mm']);
    y=load('BEAM_3TP.DAT');
    plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
%     y=load('BEAM_3TS.DAT');
%     plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
    str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
    s(ii)=sum(y(:,2));
    cd ..
end
box on
xlabel('Time [fs]')
ylabel('Power [MW]')
legend(str)

figure
plot(crystal_thickness,s,'-o')
xlabel('Crystal thickness [µm]')
ylabel('TH signal (summed)')

%%%SH spectrum


figure
hold on

for ii=1:length(crystal_thickness)
    cd(['6mm_8mm_' num2str(crystal_thickness(ii)) 'mm']);
    y=load('BEAM_3WP.DAT');
    wl_axis=3*1e5./(y(:,1)+3*381.901);
    plot(wl_axis,y(:,2)/max(y(:,2)),'color',cm(ii,:))
    fit=fitcurve_gaussian(wl_axis',y(:,2)'/max(y(:,2)),[1 262 1.5 0])
    sp_fwhm(ii)=abs(fit(3))*2.35482;
    str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
    cd ..
end
box on
xlabel('Wavelength [nm]')
ylabel('Power [MW]')
legend(str)

figure
plot(crystal_thickness,sp_fwhm,'-o')
xlabel('Crystal thickness [µm]')
ylabel('TH bandwidth')
