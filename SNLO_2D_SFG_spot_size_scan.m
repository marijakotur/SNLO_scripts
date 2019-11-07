%snlo 2d mixing
%SHG 785+392=262

close all
clear all

%%%%% temporal structure
spot_size = [4 5 5.5 6 7];
spot_size_str = [4 5 55 6 7];

% crystal_thickness = [200 300 500];
cm = jet(length(spot_size));

figure
hold on

for ii=1:length(spot_size)
    cd([ num2str(spot_size_str(ii)) 'mm_' num2str(spot_size_str(ii)) 'mm_200mm']);
    y=load('BEAM_3TP.DAT');
    plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
%     y=load('BEAM_3TS.DAT');
%     plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
    str{ii} = [num2str(spot_size(ii)) ' mm'];
    s(ii)=sum(y(:,2));
    cd ..
end
box on
xlabel('Time [fs]')
ylabel('Power [MW]')
legend(str)

figure
plot(spot_size,s,'-o')
xlabel('Spot size [mm]')
ylabel('TH signal (summed)')

% %% SH spectrum
% figure
% hold on
% 
% for ii=1:length(spot_size)
%     cd([ num2str(spot_size_str(ii)) 'mm_' num2str(spot_size_str(ii)) 'mm_200mm']);
%     y=load('BEAM_3WP.DAT');
%     wl_axis=3*1e5./(y(:,1)+3*381.901);
%     plot(wl_axis,y(:,2)/max(y(:,2)),'color',cm(ii,:))
%     fit=fitcurve_gaussian(wl_axis',y(:,2)'/max(y(:,2)),[1 262 1.5 0])
%     sp_fwhm(ii)=abs(fit(3))*2.35482;
%     str{ii} = [num2str(spot_size(ii)) ' mm'];
%     cd ..
% end
% box on
% xlabel('Wavelength [nm]')
% ylabel('Power [MW]')
% legend(str)
% 
% figure
% plot(spot_size,sp_fwhm,'-o')
% xlabel('spot size [mm]')
% ylabel('TH bandwidth')

%% second harmonic energy scan
sh_energy = [20 24 26 30 40 80];
cm = jet(length(sh_energy));
clear s
clear ii

figure
hold on

for ii=1:length(sh_energy)
    cd([ '6mm_6mm_200mm_IR33_SH' num2str(sh_energy(ii))]);
    y=load('BEAM_3TP.DAT');
    plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
%     y=load('BEAM_3TS.DAT');
%     plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
    str{ii} = [num2str(sh_energy(ii)) ' mm'];
    s(ii)=sum(y(:,2));
    cd ..
end
box on
xlabel('Time [fs]')
ylabel('Power [MW]')
legend(str)

figure
plot(sh_energy,s,'-o')
xlabel('Spot size [mm]')
ylabel('TH signal (summed)')

