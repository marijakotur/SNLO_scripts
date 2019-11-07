close all
clear all

beam_diameter = [10 9 7 6 5];
cm = jet(length(beam_diameter));

figure
hold on

for ii=1:length(beam_diameter)
    cd([num2str(beam_diameter(ii)) 'mm_200mm']);
    y=load('BEAM_3TP.DAT');
    plot(y(:,1)*1e15,y(:,2),'color',cm(ii,:)) 
    y=load('BEAM_3TS.DAT');
%     plot(y(:,1)*1e15,y(:,2),'--','color',cm(ii,:))
    str{ii} = [num2str(beam_diameter(ii)) ' mm'];
    cd ..
end
legend(str,'location','best')
box on
xlabel('Time [fs]')
ylabel('Power [mW]')