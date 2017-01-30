function [newBackBweight_SubVal, newFrontBweight_SubVal, newMidBweight_Subval] =  withinSub_errorBars_pathed(exp_vers,roiIdx)


if strcmp(exp_vers,'xyz_small')
    load('C:\Users\Matthew\Desktop\Research\Golomb\Poster\frontVSback_16subs_fwhm4_Allruns_5_1_500.mat')
    %     roi_list = {'lhPPA','lhRSC','lhOPA','lhLOC','lhMT','lhFFA','lhEBA'}; % only use left hemisphere data
    
    back_Bweight_means = nanmean(subBackBweight(roiIdx,:),2);
    front_Bweight_means = nanmean(subFrontBweight(roiIdx,:),2);
    frontback_Bweight_means = horzcat(front_Bweight_means,back_Bweight_means);
    
    %%%% within subject calcs %%%%
    
    withinSub_BFmean = mean(vertcat(subBackBweight(roiIdx,:),subFrontBweight(roiIdx,:))); % this is what you subtract from original values (the 'subject average' of back and front condition)    
    grandAvg = nanmean(withinSub_BFmean); % grand average of all values from: back and front conditions --- in a single ROI (roiIdx) --- for all subjects
    
    %%%% -------------------- %%%%
    
    for sub = 1:size(subBackBweight,2)
        %%%%%% withinSubVal = old value – subject average + grand average  %%%%%%        
        newBackBweight_SubVal(roiIdx,sub) = subBackBweight(roiIdx,sub) - withinSub_BFmean(sub)  + grandAvg;
        newFrontBweight_SubVal(roiIdx,sub) = subFrontBweight(roiIdx,sub) - withinSub_BFmean(sub)  + grandAvg;
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% BMF Version %%%%%%
elseif strcmp(exp_vers,'BMF')
    load('C:\Users\Matthew\Desktop\Research\Golomb\Poster\BMFcon_10subs_fwhm4_both_Allruns_7_6_1421.mat')

    back_Bweight_means = nanmean(subBackBweight(roiIdx,:),2);
    front_Bweight_means = nanmean(subFrontBweight(roiIdx,:),2);
    mid_Bweight_means = nanmean(subMidBweight(roiIdx,:),2);
    frontbackmiddle_Bweight_means = horzcat(front_Bweight_means,mid_Bweight_means,back_Bweight_means);
    
    %%%% within subject calcs %%%%
    
    withinSub_BMFmean = mean(vertcat(subBackBweight(roiIdx,:),subFrontBweight(roiIdx,:),subMidBweight(roiIdx,:))); % this is what you subtract from original values (the 'subject average' of back and front condition)    
    grandAvg = nanmean(withinSub_BMFmean); % grand average of all values from: back and front conditions --- in a single ROI (roiIdx) --- for all subjects
    
    %%%% -------------------- %%%%
    
    for sub = 1:size(subBackBweight,2)
        %%%%%% withinSubVal = old value – subject average + grand average  %%%%%%        
        newBackBweight_SubVal(roiIdx,sub) = subBackBweight(roiIdx,sub) - withinSub_BMFmean(sub)  + grandAvg;
        newFrontBweight_SubVal(roiIdx,sub) = subFrontBweight(roiIdx,sub) - withinSub_BMFmean(sub)  + grandAvg;
        newMidBweight_Subval(roiIdx,sub) = subMidBweight(roiIdx,sub) - withinSub_BMFmean(sub)  + grandAvg;
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
        error('which experiment?')
end




%% move to main code
%     %%% error bar stuff
%     errBars = 'withinSub'; % which type of error bar to plot
%     if strcmp(errBars,'withinSub')    %%%%%%%%%%%%% fill this in %%%%%%%%%%%%%%%%
%             semB_WS = SEM_calc(newBackBweight_SubVal');
%             semF_WS = SEM_calc(newFrontBweight_SubVal');
%             %     for roiIdx = 1:length(roi_list)
% %             for roiIdx = 1        
%                 plot([1,1] + 1,[back_Bweight_means-semB_WS(1) back_Bweight_means + semB_WS(1)],'-','Color','black');
%                 plot([1,1],[front_Bweight_means-semF_WS(1) front_Bweight_means + semF_WS(1)],'-','Color','black');
% %             end
%     end
% elseif strcmp(exp_vers,'BMF')
%     %%% fill this in    
% end
%     



% plot([roiIdx,roiIdx] + 1,[back_Bweight_means-semB_WS(roiIdx) back_Bweight_means(roiIdx)+semB_WS(roiIdx)],'-','Color','black');
%                 plot([roiIdx,roiIdx],[front_Bweight_means(roiIdx)-semF_WS(roiIdx) front_Bweight_means(roiIdx)+semF_WS(roiIdx)],'-','Color','black');














%%  old stuff
%     
%     
% elseif strcmp(errBars,'sem')
%     semB = SEM_calc(subBackBweight');
%     semF = SEM_calc(subFrontBweight');    
%     for roiIdx = 1:length(roi_list)
%         plot([roiIdx,roiIdx] + 1,[back_Bweight_means(roiIdx)-semB(roiIdx) back_Bweight_means(roiIdx)+semB(roiIdx)],'-','Color','black');
%         plot([roiIdx,roiIdx],[front_Bweight_means(roiIdx)-semF(roiIdx) front_Bweight_means(roiIdx)+semF(roiIdx)],'-','Color','black');
%         
%     end
% end
% 
% 
% %     bar([frontback_Bweight_means],'grouped')
% 
% 
% % frontbackmiddle_Bweight_means
%     bar([frontback_Bweight_means],'grouped','BarWidth',.7)
% %     bar([frontback_Bweight_means frontbackmiddle_Bweight_means(roiIdx,:)],'grouped','BarWidth',.7)
% 
%     hold on
%     
%     tName = sprintf('Group Avg. %s',roi_list{roiIdx});
% %     title(tName,'FontSize',24)
%     set(gcf,'Color','white');
%     ylim([-.08 .58])
% %     ylabel('Percent Signal Change','FontSize',24)
% end
% set(gcf,'Position',[0 5.0 200.0*2 250.0*2])    %'WindowStyle','normal')
% 
% 
% %%% error bar stuff
% errBars = 'withinSub'; % which type of error bar to plot
% if strcmp(errBars,'withinSub')
%     %%%%%%%%%%%%% fill this in %%%%%%%%%%%%%%%%
% elseif strcmp(errBars,'sem')
%     semB = SEM_calc(subBackBweight');
%     semF = SEM_calc(subFrontBweight');    
%     for roiIdx = 1:length(roi_list)
%         plot([roiIdx,roiIdx] + 1,[back_Bweight_means(roiIdx)-semB(roiIdx) back_Bweight_means(roiIdx)+semB(roiIdx)],'-','Color','black');
%         plot([roiIdx,roiIdx],[front_Bweight_means(roiIdx)-semF(roiIdx) front_Bweight_means(roiIdx)+semF(roiIdx)],'-','Color','black');
%         
%     end
% end
% 
% 
% %     grandAvg = mean((testWithinSub(1,:) + testWithinSub(2,:) ) / 2); %%% sanity check / longer way of getting grand average
