%% Check pathing
cc;

load('frontVSback_16subs_fwhm4_Allruns_5_1_500.mat')

roi_list = {'lhPPA','lhRSC','lhOPA','lhLOC','lhMT','lhFFA','lhEBA'}; % only use left hemisphere data
% for roiIdx = 7
for roiIdx = 1:length(roi_list)
    back_Bweight_means = nanmean(subBackBweight(roiIdx,:),2);
    front_Bweight_means = nanmean(subFrontBweight(roiIdx,:),2);
    frontback_Bweight_means = horzcat(front_Bweight_means,back_Bweight_means);
    figure(roiIdx)
    bar1 = bar([frontback_Bweight_means],'grouped','BarWidth',.6,'FaceColor','none');
    hold on    

    ylim([-.2 1])  %%% now scaled at .2 to 1 
    
%   you may have to play around with these settings to make good looking figures with the new scale

%   set(gcf,'Position',[0 2.0 200.0*3 250.0*2])    
    set(gcf,'Position',[0 2.0 200.0*2 250.0*2])

    %%%% call error bar function %%%%
    
    errBars = 'WS'; % WS is within subject error bars
    exp_vers = 'xyz_small';
    if strcmp(errBars,'WS')
        [newBackBweight_SubVal, newFrontBweight_SubVal] = withinSub_errorBars_pathed(exp_vers,roiIdx);
        errBars = 'withinSub'; % which type of error bar to plot
        if strcmp(errBars,'withinSub')
            semB_WS = SEM_calc(newBackBweight_SubVal');
            semF_WS = SEM_calc(newFrontBweight_SubVal');
            plot([1,1] + 1,[back_Bweight_means-semB_WS(roiIdx) back_Bweight_means + semB_WS(roiIdx)],'-','Color','black');
            plot([1,1],[front_Bweight_means-semF_WS(roiIdx) front_Bweight_means + semF_WS(roiIdx)],'-','Color','black');
        end
    else
        semB = SEM_calc(subBackBweight');
        semF = SEM_calc(subFrontBweight');
        % SEM

        plot([1,1] + 1,[back_Bweight_means - semB(roiIdx) back_Bweight_means + semB(roiIdx)],'-','Color','black');
        plot([1,1],[front_Bweight_means - semF(roiIdx) front_Bweight_means + semF(roiIdx)],'-','Color','black');
    end
    
    %%% edit for easy use in illustrator
    set(gca,'xtick',[]) 
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gcf,'Color','white')
    set(gca,'Visible','off')
    
%     baseline1 = get(bar1,'BaseLine');
%     set(baseline1,'LineStyle','none');
%     savename = sprintf('xyz_small_%s',roi_list{roiIdx});
%     saveas(gcf,savename,'epsc')
end
