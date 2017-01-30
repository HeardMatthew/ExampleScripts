function BMF_plotting_functions_MH_pathed_GitHub
%% plot individual ROIs group average BMF
%%%%%%%%%%%%%%%%%%%%%%%%
% this will likely be the most useful of these plotting functions 
%%%%%%%%%%%%%%%%%%%%%%%%
cc;
cd('C:\Users\Matthew\Desktop\Research\Golomb\Poster')
% load('/artichoke_home/fMRI/xyz_small/matlab_main/results/BMFcon_5subs_fwhm4_both_Allruns_5_1_447.mat')
load('C:\Users\Matthew\Desktop\Research\Golomb\Poster\BMFcon_10subs_fwhm4_both_Allruns_7_6_1421.mat')

depths = {'Front', 'Middle', 'Back'}; 
roi_list = {'PPA','RSC','OPA','LOC','MT','FFA','EBA'}; % both hemispheres
for roiIdx = 1:length(roi_list)
    front_Bweight_means = nanmean(subFrontBweight(roiIdx,:),2);
    mid_Bweight_means = nanmean(subMidBweight(roiIdx,:),2);
    back_Bweight_means = nanmean(subBackBweight(roiIdx,:),2);
    
    frontbackmiddle_Bweight_means = horzcat(front_Bweight_means,mid_Bweight_means,back_Bweight_means);
      % This naming convention is a little frustrating. The variable
      % is [front, mid, back] but it is named front back middle. Why?
    % main plot
    figure(roiIdx)
    bar([frontbackmiddle_Bweight_means],'grouped','FaceColor','none');

    hold on
    tName = sprintf('Group Avg. %s',roi_list{roiIdx});
    title(tName,'FontSize',24) % This line creates the title.
    set(gcf,'Color','white');
    
%     ylim([-.2 .8]) %%% %%% make sure to pay attention to the scale  ORIGINAL IS [-.2 .8]
     ylim([-.2 1]) %%% %%% make sure to pay attention to the scale. Must be this... 

    ylabel('Percent Signal Change','FontSize',24)
    
    set(gca,'XTick',[1:size(depths,2)],'XTickLabel',depths,'FontSize',24) % Sets x labels. 
        
    %%% add legend in illustrator
%     legend('Front','Middle','Back','Location','BestOutside'); %     legend('boxoff')

    set(gcf,'Position',[0 5.0 200.0*2 250.0*2])
    
    
    %%%% call error bar function %%%%
  
    errBars = 'WS'; % WS is within subject error bars
    exp_vers = 'BMF';
    
    if strcmp(errBars,'WS')
        [newBackBweight_SubVal, newFrontBweight_SubVal, newMidBweight_SubVal] = withinSub_errorBars_pathed(exp_vers,roiIdx);
        errBars = 'withinSub'; % which type of error bar to plot
        if strcmp(errBars,'withinSub')
            semB_WS = SEM_calc(newBackBweight_SubVal');
            semF_WS = SEM_calc(newFrontBweight_SubVal');
            semM_WS = SEM_calc(newMidBweight_SubVal');
            plot([1,1] + 2,[back_Bweight_means-semB_WS(roiIdx) back_Bweight_means + semB_WS(roiIdx)],'-','Color','black');
            plot([1,1] ,[front_Bweight_means-semF_WS(roiIdx) front_Bweight_means + semF_WS(roiIdx)],'-','Color','black');
            plot([1,1] + 1,[mid_Bweight_means-semM_WS(roiIdx) mid_Bweight_means + semM_WS(roiIdx)],'-','Color','black');

        end
    else
        semB = SEM_calc(subBackBweight');
        semF = SEM_calc(subFrontBweight');
        semM = SEM_calc(subMidBweight');
        plot([1,1] + 2,[back_Bweight_means - semB(roiIdx) back_Bweight_means + semB(roiIdx)],'-','Color','black');
        plot([1,1],[front_Bweight_means - semF(roiIdx) front_Bweight_means + semF(roiIdx)],'-','Color','black');
        plot([1,1] + 1,[mid_Bweight_means - semM(roiIdx) mid_Bweight_means + semM(roiIdx)],'-','Color','black');
    end
    
    % Blanches the figure
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gcf,'Color','white')
    set(gca,'Visible','off')
    hold off
%     savename = sprintf('BMF_%s',roi_list{roiIdx});
%     saveas(gcf,savename,'epsc')
end
