%snlo 2d mixing
%SHG 785+392=262

close all
clear all

%%%%% temporal structure
% crystal_thickness = [13 12 11.5 11 10.5 10 9.5 9 8.5 8 7.5 7 6.5 ];
crystal_thickness = [0.13 0.15 0.18 0.2 0.22 0.25 ];
% spot_size = [10 12];


cm = jet(length(crystal_thickness));
% runs = [14 2 9 8 10 3 5 4 6 7 11 12 13];
runs = [15 3 19 16 17 18 ];


figure
hold on

for ii=1:length(runs)
    cd(['run' num2str(ii)]);
    y=load('BEAM_3TP.DAT');
    plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
%     y=load('BEAM_3TS.DAT');
%     plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
    str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
    s(ii)=sum(y(:,2)*max(diff(y(:,1))));
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

for ii=1:length(runs)
    cd(['run' num2str(ii)]);
    y=load('BEAM_3WP.DAT');
    wl_axis=3*1e5./(y(:,1)+3*381.901);
    plot(wl_axis,y(:,2)/max(y(:,2)),'color',cm(ii,:))
    fit=fitcurve_gaussian(wl_axis',y(:,2)'/max(y(:,2)),[1 262 1.5 0]);
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
