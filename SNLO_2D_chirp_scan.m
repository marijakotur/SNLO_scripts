%snlo 2d mixing
%SHG 785+785=392

% close all
clear all

cd('C:\SNLO\2D-mix-SP_785+785\10mm_correct_walkoff')

%%%%% temporal structure
crystal_thickness = [200];
chirp_str = {'','_-1THz','_-0.5THz'};
chirp = [0 -0.5 -1];


spot_size = 10;

cm = jet(length(crystal_thickness));

figure(1)
hold on

power_str = '_4.4mJ';

for ii=1:length(chirp_str)
    cd([num2str(spot_size) 'mm_' num2str(crystal_thickness(ii)) 'mm' power_str]);
    y=load('BEAM_3TP.DAT');
    plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:))
    peak_power(ii) = max(y(:,2))
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
plot(crystal_thickness,peak_power,'r-o')

%%%SH spectrum
figure(3)
hold on

for ii=1:length(crystal_thickness)
    cd([num2str(spot_size) 'mm_' num2str(crystal_thickness(ii)) 'mm' power_str]);
    y=load('BEAM_3WP.DAT');
    plot(3*1e5./(y(:,1)+381.9*2),y(:,2)/max(y(:,2)),'color',cm(ii,:))
    wl_axis=3*1e5./(y(:,1)+2*381.901);
    fit=fitcurve_gaussian(wl_axis',y(:,2)'/max(y(:,2)),[1 392 2 0])
    sp_fwhm(ii)=abs(fit(3))*2.35482;
    str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
    cd ..
end
box on
xlabel('Wavelength [nm]')
ylabel('Power [MW]')
legend(str)


figure(4)
hold on
plot(crystal_thickness,sp_fwhm,'-o')


