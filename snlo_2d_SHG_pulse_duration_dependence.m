% snlo bandwidth dependence for SHG

close all
clear all

pulse_duration = [35,40, 45];
spot_size = 10;

power_str = '_4.4mJ';

crystal_thickness = {[100 150 200 250 300 350],[100 150 200 225 250 300 350],[100 150  200 250 300 350]};


folders = {'C:\SNLO\2D-mix-SP-785-785_35fs','C:\SNLO\2d-mix-SP-785-785_40fs','C:\SNLO\2D-mix-SP-785-785_45fs'};

figure(1)
hold on

figure(2)
hold on

for jj=1:length(folders)
    clear peak_power;
    clear energy;
    clear sp_fwhm;
    cm = jet(length(crystal_thickness{jj}));
    cd(folders{jj});
    for ii=1:length(crystal_thickness{jj})
        cd([num2str(spot_size) 'mm_' num2str(crystal_thickness{jj}(ii)) 'um' power_str]);
        y=load('BEAM_3TP.DAT');
        t=load('BEAM_3TI.DAT'); %leftover fundamental
        figure(1)
        subplot(length(folders),1,jj)
        hold on
        plot((y(:,1)-y(1,1))*1e15,y(:,2),'color',cm(ii,:))
        peak_power(ii) = max(y(:,2));
        peak_power_fund(ii) = max(t(:,2));
        energy(ii) = sum(y(:,2))*max(diff(t(:,2)))*1e-9;
        %         str{ii} = [num2str(crystal_thickness(ii)) ' µm'];
        axis([0 250 -inf inf])
        
        %spectrum
        sp=load('BEAM_3WP.DAT');
        wl_axis=3*1e5./(sp(:,1)+2*381.901);
        plot(wl_axis,sp(:,2)/max(sp(:,2)),'color',cm(ii,:))
        fit=fitcurve_gaussian(wl_axis',sp(:,2)'/max(sp(:,2)),[1 390 1.5 0]);
        sp_fwhm(ii)=abs(fit(3))*2.35482;
        
        cd ..
    end
    
    figure(3)
    hold on
    plot(crystal_thickness{jj},sp_fwhm,'-o')
    
    figure(2)
    plot(crystal_thickness{jj},energy,'linestyle','-','marker','o')
    str2{jj} = folders{jj}(end-3:end);
end
legend(str2,'location','best')

box on
xlabel('Time [fs]')
ylabel('Power [MW]')
% legend(str)

