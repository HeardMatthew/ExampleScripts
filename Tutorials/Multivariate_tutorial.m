%% Multivariate_tutorial.m
close all; clear all; clc;

% Generating a sample of data
nObs = 200;
nObsCond = nObs/2;
nv = 2;         
ampA = [1,2]; Sigma = [2 1.5; 1.5 2];  
rA = mvnrnd(ampA, Sigma, nObsCond);
ampB = [2 1]; Sigma = [2 1.5; 1.5 2];  
rB = mvnrnd(ampB, Sigma, nObsCond);

%NUMBER OF VARIABLES (aka # voxels) being examined across
%response amplitudes to each condition by voxel
%length = number of brain states

% % Another method to create data
% n = 0.7;        %magnitude of IID (independent identically distributed) noise
% rA = repmat(ampA, nObsCond, 1)  + (n*randn(nObsCond, nv));
% rB = repmat(ampB, nObsCond, 1) + (n*randn(nObsCond, nv));

% Plotting the data (each voxel on seperate graph)
figure(3), clf, hold on
plot(rA(:,1), 1:nObsCond, 'ro', 'MarkerSize', 10)
plot(rB(:,1), 1:nObsCond, 'bv', 'MarkerSize', 10)
set(gca, 'FontSize', 20)
set(gca, 'XLim', [min([rA(:,1);rB(:,1)]), max([rA(:,1);rB(:,1)])])
xlabel('Response amplitude')
set(gca, 'YTick', [])
legend({'Cond A', 'Cond B'})

figure(4), clf, hold on
plot(rA(:,2), 1:nObsCond, 'ro', 'MarkerSize', 10)
plot(rB(:,2), 1:nObsCond, 'bv', 'MarkerSize', 10)
set(gca, 'FontSize', 20)
set(gca, 'XLim', [min([rA(:,2);rB(:,2)]), max([rA(:,2);rB(:,2)])])
xlabel('Response amplitude')
set(gca, 'YTick', [])
legend({'Cond A', 'Cond B'})

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

% Plot the data using multivariate data
figure(2), clf, hold on
plot(rA(:,1), rA(:,2), 'ro', 'MarkerSize', 10)
plot(rB(:,1), rB(:,2), 'bv', 'MarkerSize', 10)
set(gca, 'FontSize', 20)     
minData = min([rA(:);rB(:)]);
maxData = max([rA(:);rB(:)]);
set(gca, 'XLim', [minData, maxData])
set(gca, 'YLim', [minData, maxData])
xlabel('Response of variable 1')
ylabel('Response of variable 2')
legend({'Cond A', 'Cond B'})
upperLineX = max([rA(:,1);rB(:,1)]);
upperLineY = max([rA(:,2);rB(:,2)]);
lowerLineX = min([rA(:,1);rB(:,1)]);
lowerLineY = min([rA(:,2);rB(:,2)]);
plot([lowerLineX, upperLineX], [lowerLineY, upperLineY], 'k', 'LineWidth', 2)

% Hold out some data
holdOut = nObsCond;         
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
