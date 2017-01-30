%% Multivariate_tutorial.m
close all; clear all; clc;

% Generating a sample of data
nObs = 200;
nObsCond = nObs/2;
nv = 10;         
ampA = [2 1 2 2 1 1 2 1 1 1]; Sigma = [2 1.5; 1.5 2];  
% rA = mvnrnd(ampA, Sigma, nObsCond);
ampB = [1 2 1 1 2 2 1 2 2 2]; Sigma = [2 1.5; 1.5 2];  
% rB = mvnrnd(ampB, Sigma, nObsCond);

%NUMBER OF VARIABLES (aka # voxels) being examined across
%response amplitudes to each condition by voxel
%length = number of brain states

% Another method to create data
n = 0.7;        %magnitude of IID (independent identically distributed) noise
rA = repmat(ampA, nObsCond, 1)  + (n*randn(nObsCond, nv));
rB = repmat(ampB, nObsCond, 1) + (n*randn(nObsCond, nv));

% What happens if you use univariable method?
meanA = mean(rA,2);
meanB = mean(rB,2);
figure(1), clf, hold on
plot(meanA, 1:nObsCond, 'ro', 'MarkerSize', 10)
plot(meanB, 1:nObsCond, 'bv', 'MarkerSize', 10)
set(gca, 'FontSize', 20)
set(gca, 'XLim', [min([meanA;meanB]), max([meanA;meanB])])
xlabel('Response amplitude')
set(gca, 'YTick', [])
legend({'Cond A', 'Cond B'})
boundaryPoint = (mean(meanA)+mean(meanB))/2;
plot([boundaryPoint, boundaryPoint], get(gca, 'YLim'), 'k--', 'LineWidth', 2)
get(gca, 'YLim');

% Plot the data using multivariate data, not possible on one graph, too many variables
% Here's an attempt to plot across two different variables. 
% This section will plot variable 1 vs 2, 2 vs 3, etc. 

for i=2:11
    figure(i), clf, hold on
    if i~=11
        plot(rA(:,i-1), rA(:,i), 'ro', 'MarkerSize', 10)
        plot(rB(:,i-1), rB(:,i), 'bv', 'MarkerSize', 10)
        set(gca, 'FontSize', 20)     
        minData = min([rA(:);rB(:)]);
        maxData = max([rA(:);rB(:)]);
        set(gca, 'XLim', [minData, maxData])
        set(gca, 'YLim', [minData, maxData])
        xlabel(['Response of variable ', num2str(i-1)])
        ylabel(['Response of variable ', num2str(i)])
        legend({'Cond A', 'Cond B'})
        upperLineX = max([rA(:,i-1);rB(:,i-1)]);
        upperLineY = max([rA(:,i);rB(:,i)]);
        lowerLineX = min([rA(:,i-1);rB(:,i-1)]);
        lowerLineY = min([rA(:,i);rB(:,i)]);
        plot([lowerLineX, upperLineX], [lowerLineY, upperLineY], 'k', 'LineWidth', 2)
    elseif i==11
        plot(rA(:,i-1), rA(:,1), 'ro', 'MarkerSize', 10)
        plot(rB(:,i-1), rB(:,1), 'bv', 'MarkerSize', 10)
        set(gca, 'FontSize', 20)     
        minData = min([rA(:);rB(:)]);
        maxData = max([rA(:);rB(:)]);
        set(gca, 'XLim', [minData, maxData])
        set(gca, 'YLim', [minData, maxData])
        xlabel('Response of variable 1')
        ylabel('Response of variable 2')
        legend({'Cond A', 'Cond B'})
        upperLineX = max([rA(:,i-1);rB(:,i-1)]);
        upperLineY = max([rA(:,1);rB(:,1)]);
        lowerLineX = min([rA(:,i-1);rB(:,i-1)]);
        lowerLineY = min([rA(:,1);rB(:,1)]);
        plot([lowerLineX, upperLineX], [lowerLineY, upperLineY], 'k', 'LineWidth', 2)
    end
end

% Hold out some data
holdOut = nObsCond;         %again, some = half     
nPerms = 100;
labels = [ones(nObsCond,1); ones(nObsCond,1)+1];
data = [rA; rB];

% Try some univariate processing!
% Serence's function finds the mean across variables. What would happen if 
% you wanted to try to run each variable seperately?
classAccUni = uniClass(data, labels, holdOut, nPerms)

% And now, for something different
[classAccMultiCorr,confusionMatrix] = corrClass(data, labels, holdOut, nPerms)
HeatMap(confusionMatrix)
classAccMultiEuc = normEucClass(data, labels, holdOut, nPerms)
classAccMultiMaha2 = mahaClass2(data, labels, holdOut, nPerms)
