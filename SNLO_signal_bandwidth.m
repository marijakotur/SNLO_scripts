% output the bandwidths

y=load('BEAM_3WP.DAT');
wl_axis=3*1e5./(y(:,1)+3*381.901);
sp_fwhm = fwhm(wl_axis,y(:,2));
[fit, func]=fitcurve_gaussian(wl_axis',y(:,2)'/max(y(:,2)),[1 260 2 0])
fitted = fit(1) * exp(-(wl_axis-fit(2)).^2/(2*fit(3)^2)) + fit(4);
sp_fwhm=abs(fit(3))*2.35482;
plot(wl_axis,y(:,2)/max(y(:,2)))
hold on
plot(wl_axis,fitted,'r--');
grid on

disp(sp_fwhm)
disp(['signal FWHM bandwith: ' num2str(sp_fwhm)])