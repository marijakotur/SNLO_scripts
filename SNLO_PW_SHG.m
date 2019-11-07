%% SNLO plane wave SFG
close all
clear all

chirp = [-200 -100 -60:20:40];

cm = jet(length(chirp));

figure
hold on

for ii=1:length(chirp)
    cd(['785_785_' num2str(chirp(ii))]);
    y=load('PWMIX_SP.DAT');
    plot(y(:,1)*1e15,y(:,4),'color',cm(ii,:))
    s(ii)=sum(y(:,4));
    str{ii} = [num2str(chirp(ii)) ' µm'];
    cd ..
end
box on
xlabel('Time [fs]')
ylabel('Irradiance [W/m^2]')
legend(str)

figure
plot(chirp,s,'-o')
xlabel('Chirp [THz/ps]')
ylabel('TH signal (summed)')

figure
hold on

for ii=1:length(chirp)
    cd(['785_785_' num2str(chirp(ii))]);
    y=load('PWMIXSPS.DAT');
    wl_axis=3*1e5./(y(:,1)+2*381.901);
    plot(wl_axis,y(:,4),'color',cm(ii,:))
    fit=fitcurve_gaussian(wl_axis',y(:,4)'/max(y(:,4)),[1 262 2 0])
    sp_fwhm(ii)=abs(fit(3))*2.35482;
    str{ii} = [num2str(chirp(ii)) ' µm'];
    cd ..
end
box on
xlabel('Wavelength [nm]')
ylabel('Signal [norm]')
legend(str)

figure
plot(chirp,sp_fwhm,'o-')
xlabel('Chirp [THz/ps]')
ylabel('SH spectrum FWHM [nm]')
