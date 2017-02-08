clear all;


%% Study info
TR = 2000; % Originally 2.5
disdaqs = 0; %time at beginning
numVols = 198; % 166 if TR = 2.5
eventLength = 9000; %10000; %in ms
params.rcond = 0;
params.prtr = TR;
params.nvol = numVols;
params2=params; %2nd set of params for fir model
params2.ndcreg = 8;
params2.type = 'fir';
numCond=2;
condName={'moving','stationary'};
condColor=[255 0 0; 0 255 0];

%%

% 1=subjNumber 5=initTrial (sec) 6=cond
%%

subj='20';
%init='j0';
study='MTlocalizer';

% cd ..
cd(['s' subj]);

%load behav file
cd('prts')
fname=['dat_raw.o' subj '.MT_localizer_TR2000.xls'];
fid=fopen(fname);
cd ..

data=textscan(fid,'%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n');

%startrun=min(data{2});
%endrun=max(data{2});
%trials=80;
data{5}=round(data{5}*10)/10;

for r=1:1
     condOnsets = {[],[]};
% 
%     for trial=1:trials
%         ind=(r-1)*trials+trial;
%      
%         tempCond =  data{6}(ind);
%         tempOnset = data{5}(ind);
%         condOnsets{tempCond} = [condOnsets{tempCond} tempOnset];
%     end
%     run=data{2}(ind);
    
    for cond=1:numCond
        condOnsets{cond}=data{5}(find(data{6}==cond))';
    end
    
    % convert to ms and add offsets
    for cc=1:numCond
        %condOnsets{cc} = [(condOnsets{cc}'-disdaqs)*1000 (condOnsets{cc}'-disdaqs)*1000+eventLength];
        condOnsets{cc} = [round((condOnsets{cc}'-disdaqs)*1000/TR)+1 round((condOnsets{cc}'-disdaqs)*1000/TR+eventLength/TR)];
    end
    
    % create PRT object
    prt = BVQXfile('new:prt');
    for cc=1:numCond
        prt.AddCond(condName{cc},condOnsets{cc},condColor(cc,:));
    end
    prt.ResolutionOfTime='Volumes';
    prt.Experiment=study;
    
    % create RTC object
    sdm = prt.CreateSDM(params);
    
    cd('prts')
    sdm.SaveAs(['s20_' study '_TR.sdm']);
    prt.SaveAs([study '_TR.prt']);
    %make FIR rtc also
    sdm = prt.CreateSDM(params2);
    sdm.SaveAs(['s20_' study '_TR_FIR.sdm']);
    cd ..
    
    BVQXfile(0,'clearallobjects');
end

cd ..
% cd ..

