% % x-correlation from SNLO
% close all
clear all

% %0.5 mm crystal @ 57.1 deg, type II
% % 785nm, 2E-9J, 20fs, 0.1mm beam diameter
% % 261.7nm, energy in J, 1ps (0.5 fwhm in SNLO!), 1mm beam diameter, -6THz/ps

% 500 micron crystal
delay = {[200 400 600 750],[0 100 200 300 400 500 600 750 1000],[200 400 600],[200 300 400 600]};
energy = [50 100 200 500];
crystal_thickness = 500;

% % % 250 micron crystal
% delay = {[0 100 150 200 300 400 600],[100 200 300 400],[100 200 400]};
% energy = [100 200 500];
% crystal_thickness = 250;
% 
% % % 150 micron crystal
% delay = {[0 60 100 200 300 400]};
% energy = [100];
% crystal_thickness = 150;

figure(1)
hold on
figure(2)
hold on
cm = jet(length(energy))
for ii=1:length(energy)
    for jj=1:length(delay{ii})
        %     subplot(1,length(delay),jj)
        
        cd(['PW_785_392_type2_' num2str(crystal_thickness) 'mm_' num2str(delay{ii}(jj)) 'fs_' num2str(energy(ii)) 'mJ']);
%                 ['PW_785_392_type2_' num2str(crystal_thickness) 'mm_' num2str(delay{ii}(jj)) 'fs_' num2str(energy(ii)) 'mJ']
        
        figure(1)
        y=load('PWMIX_SP.DAT');
        plot(y(:,1)*1e15,y(:,3),'color',cm(ii,:))
        m{ii}(jj)=max(y(:,3));
        s{ii}(jj)=sum(y(:,3));
%                 str{ii,jj} = [num2str(energy(ii)) ' mJ' num2str(delay(jj)) ' fs'];
              
        if delay{ii}(jj) == 200
            lstr{ii} = [num2str(energy(ii)) ' µJ'];
            figure(2)
            z=load('PWMIXSPS.DAT');
            wl_axis=3*1e5./(z(:,1)+2*381.901);
            plot(wl_axis,z(:,3))
        end
            
        cd ..
    end
end

figure(1)
box on
xlabel('Time [fs]')
ylabel('Power [MW]')
% legend(str)

figure(2)
box on
xlabel('Time [fs]')
ylabel('Power [MW]')
legend(lstr)

figure
hold on
for jj=1:length(delay)
    
%     subplot(1,2,1)
    plot(delay{jj},s{jj}/max(s{jj}),'-o')
    xlabel('Delay [fs]')
    ylabel('Total 2nd harmonic signal [norm.]')
    lstr{jj} = [num2str(energy(jj)) ' µJ'];
    
%     subplot(1,2,2)
%     hold on
%     plot(delay{jj},s{jj},'-o')
%     xlabel('Delay [fs]')
%     ylabel('sum')
    
end
box on
legend(lstr)

%show spectra
