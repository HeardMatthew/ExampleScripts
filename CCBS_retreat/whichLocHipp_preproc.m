% BV scripting in Matlab - preprocessing steps for IdenLoc
% 2014.01.07 - CNK Modified
% 2015.04.09 - AS modified

% As with the other scripts in this folder, my work was limited to changing paths and parameters. -MH

%%
clear all
%%
delete_intermediates = 1;

folder=['Folder for Matts Practice Analyses'];
study=['whichLocHipp'];
subject={'s01'};

%
num_funcruns={8}; %number of func runs by subject
firstfiles= { ... %run number for the functional data by subject
[7 8 9 10 12 13 14 15] }; %s01
% [11 12 13 14 16 17 19 21] }; %s02
% [8 9 10 11 12 13 14 15] }; % s03
% [8 9 10 11 13 14 15 16] }; % s04
% [9 10 11 12 14 15 16 17] }; % s05
% [8 9 10 11 13 14 15 16] }; % s06
% [9 10 11 12 13 14 15 16] }; % s07
% [8 9 10 11 13 14 15 16] }; % s08
% [11 12 13 14 15 17 18 19] }; % s09
% [9 10 11 12 14 15 16 17] }; % s10
% [9 10 11 12 13 14 15 16] }; % s11
% [9 10 11 12 13 14 16 17] }; % s12
% [9 10 18 12 13 14 15 16] }; % s13
% [9 10 11 12 13 15 16 17] }; % s14
% };

num_locruns={3};
locfiles={ ...
[17 18 10] }; %s01
% [22 23 24] }; %s02
% [16 17 18] }; % s03
% [17 18 19] }; % s04
% [19 20 21] }; % s05
% [18 19 20] }; % s07
% [18 19 20] }; % s08
% [20 21 22] }; % s09
% [19 20 21] }; % s10
% [17 18 19] }; % s11
% [18 19 20] }; % s12
% [17 19 20] }; % s13
% [18 19 20] }; % s14
% };

firstrun_name={1};  %1st run name, almost always 1 unless problem

%which files to run ( setting all equal to 1 here, i.e. running all)
% do_create={[ones(1,num_funcruns{1}) ones(1,num_locruns{1})]};
do_create={[zeros(1,num_funcruns{1}) zeros(1,num_locruns{1})]};
do_processing = {[ones(1,num_funcruns{1}) ones(1,num_locruns{1})]};
% do_processing{1}(1:8) = zeros(1,8); % Using this to not process the ones that are already done.

%%
numsubjs=size(subject,2);

%Motion Correction override - if you want to manually set the fmr to which
%you are motion correcting.
do_MC_override = 1;

for s=1:numsubjs
    if do_MC_override
        MCTargetFile = ['C:\Users\kupitz.1\Desktop\' folder filesep subject{s} '_whichLocHipp1\funcRun1\' subject{s} '_funcRun1.fmr'];
    end
    
    subject_path{s}=['C:\Users\kupitz.1\Desktop\' folder '\' subject{s} '_whichLocHipp1\'];
    
    bvqx = actxserver('BrainVoyagerQX.BrainVoyagerQXScriptAccess.1'); %open BV
    
    %bvqx.RenameDicomFilesInDirectory([subject_path{s} 'DICOMS\']); %rename DICOM file
    
    % Instead of setting prefix here, just figure it out from the renamed
    % directory (thanks Tim)
    tmp = dir([subject_path{s} 'DICOMS\']);
    dicomPrefix = strtok(tmp(3).name,'-');
    
    for r=1:num_funcruns{s}+num_locruns{s}
        %bvqx = actxserver('BrainVoyagerQX.BrainVoyagerQXInterface'); %open BV
        
        %BV naming convention allows up to 1000 functional runs; we deal
        %with that here
        if r<=num_funcruns{s}
            if firstfiles{s}(r)<10
                firstfilenum=['-000' num2str(firstfiles{s}(r))];
            elseif firstfiles{s}(r)<100
                firstfilenum=['-00' num2str(firstfiles{s}(r))];
            end
        elseif r<=num_funcruns{s}+num_locruns{s}
            if locfiles{s}<10
                firstfilenum=['-000' num2str(locfiles{s}(r-num_funcruns{s}))];
            elseif locfiles{s}<100
                firstfilenum=['-00' num2str(locfiles{s}(r-num_funcruns{s}))];
            end
        end
        
        
        % fmr variables (make sure correct for experiment)
        fileType='DICOM';
        firstFile=[subject_path{s} 'DICOMS\' dicomPrefix firstfilenum '-0001-00001.dcm'];
        createAMR=true;
        nrSlices=41; %2.5s TR
        byteswap=false;
        bytesperpixel=2; %For functional data, the number of bytes is usually 2 (short integer, 16 bits)
        nrVolsInImg=1; %should be 1
        
        %Scanner parameters. OSU 3T machine (32-channel) is:
        %74x74 for 2s TR
        %100x100 for 2.5s TR
        sizeX=100;
        sizeY=100;
        mosaicSizeX=ceil(sqrt(nrSlices))*sizeX; %6*64=384
        mosaicSizeY=ceil(sqrt(nrSlices))*sizeY;
        
        if r<=num_funcruns{s}
            nrOfVols=133;
            skipVols=0;
            targetfolder{r}=[subject_path{s} 'funcRun' num2str(firstrun_name{s}+r-1) '\'];
            prtName=[study '_main_' subject{s}(2:end) '_' num2str(firstrun_name{s}+r-1) 'TR.prt']; %has to be in target folder
            do_prt_link = 1;
            % stcprefix=[subject{s} '_funcRun' num2str(firstrun_name{s}+r-1) '_script']; % for testing.
            stcprefix=[subject{s} '_funcRun' num2str(firstrun_name{s}+r-1)]; % not for testing
        elseif r<=num_funcruns{s}+num_locruns{s} %localizer (funcLoc) params
            nrOfVols=91;
            skipVols=0;
            targetfolder{r}=[subject_path{s} 'funcLoc' num2str(r-num_funcruns{s}) '\'];
            prtName=['whichLocHipp_loc_' subject{s}(2:end) '_' num2str(r-num_funcruns{s}) 'ms.prt']; %has to be in target folder %STILL MOVING OVER MANUALLY -CK
            do_prt_link = 1;
            % stcprefix=[subject{s} '_funcLoc' num2str(r-num_funcruns{s}) '_script']; % for testing.
            stcprefix=[subject{s} '_funcLoc' num2str(r-num_funcruns{s})]; % not for testing.
        end
        
        if do_create{s}(r)
            % create fmr
            fmr = bvqx.CreateProjectMosaicFMR(fileType, firstFile, nrOfVols,...
                skipVols, createAMR, nrSlices,...
                stcprefix, byteswap, mosaicSizeX, mosaicSizeY, bytesperpixel,...
                targetfolder{r}, nrVolsInImg, sizeX, sizeY);
            
            % prt must be in target folder so copy here before linking;
            % this SHOULD be taken care of in 'data_prep' file
            
            % link prt
            if do_prt_link
                fmr.LinkStimulationProtocol(prtName);
            end
            %fmr.LinkStimulationProtocol([subject_path{s} 'prts\' prtName]);
            
            % save fmr
            fmr.SaveAs([stcprefix '.fmr']);
            fmr.Close;
            
             fprintf(['Created fmr ' stcprefix '\n']);
        end
        
    end %r
    
    %% Preprocessing Steps
    
    % define preprocessing parameters
    
    % slice time correction
    sliceOrder = 1; % ascending interleaved 1 %check this
    interpolationTC = 1; % 1=cubic spline
    
    % motion correction -- no parameters
    targetvolnumMC = 1;
    interpolationMC = 2; % 1=trilinear/trilinear 2=trilinear/sync
    dataSetMC = 0;
    numIterMC = 100;
    movieMC = 0; % save movie? not available yet?
    logMC = 1;
    
    % temporal filtering
    filterVal = 1/128; % 128-s cutoff
    filterUnits = 'Hz';
    
    % spatial smoothing
    smoothingSz = 4;
    smoothingUnits = 'mm';
    
    for r=1:num_funcruns{s}+num_locruns{s}
        if do_processing{s}(r)
            
            any_process_error = 0;
            
            if r<=num_funcruns{s}
                % fmrName=[targetfolder{r} subject{s} '_funcRun' num2str(firstrun_name{s}+r-1) '_script' '.fmr']; % for testing
                fmrName=[targetfolder{r} subject{s} '_funcRun' num2str(firstrun_name{s}+r-1) '.fmr']; % not for testing
            elseif r<=num_funcruns{s}+num_locruns{s}
                % fmrName=[targetfolder{r} subject{s} '_funcLoc' num2str(r-num_funcruns{s}) '_script' '.fmr']; % for testing
                fmrName=[targetfolder{r} subject{s} '_funcLoc' num2str(r-num_funcruns{s}) '.fmr']; % not for testing
            end
            
            % open the file
            fmr = bvqx.OpenDocument([fmrName]);
            
            % slice time correction
            success = fmr.CorrectSliceTiming(sliceOrder, interpolationTC);
            if ~success
                any_process_error = 1;
                disp(['ERROR IN SLICE TIMING CORRECTION FOR SUBJECT ' subject{s} ' AND RUN ' num2str(r) '!!!']);
                return;
            end
            fmrName = fmr.FileNameOfPreprocessdFMR;
            fmr.Close;
            
            % motion correction
            fmr = bvqx.OpenDocument([fmrName]);
            if r == 1 && ~do_MC_override
                success = fmr.CorrectMotionEx(targetvolnumMC,interpolationMC,dataSetMC,numIterMC,movieMC,logMC);
                if ~success
                    any_process_error = 1;
                    disp(['ERROR IN MOTION CORRECTION FOR SUBJECT ' subject{s} ' AND RUN ' num2str(r) '!!!']);
                    return;
                end
            else
                success = fmr.CorrectMotionTargetVolumeInOtherRunEx(MCTargetFile,targetvolnumMC,interpolationMC,dataSetMC,numIterMC,movieMC,logMC);
                if ~success
                    any_process_error = 1;
                    disp(['ERROR IN MOTION CORRECTION FOR SUBJECT ' subject{s} ' AND RUN ' num2str(r) '!!!']);
                    return;
                end
            end
            fmrName = fmr.FileNameOfPreprocessdFMR;
            fmr.Close;
            
            % spatial smoothing (assuming we're doing MVPA for main expt and
            % univariate analyses on localizers.)
            if r<=num_funcruns{s} % if it's a main task run
                % don't do spatial smoothing. 
            elseif r<=num_funcruns{s}+num_locruns{s} % if it's a localizer run
                fmr = bvqx.OpenDocument([fmrName]);
                success = fmr.SpatialGaussianSmoothing(smoothingSz, smoothingUnits);
                if ~success
                    any_process_error = 1;
                    disp(['ERROR IN SPATIAL SMOOTHING FOR SUBJECT ' subject{s} ' AND RUN ' num2str(r) '!!!']);
                    return;
                end
                fmrName = fmr.FileNameOfPreprocessdFMR;
                fmr.Close;
            end
            
            % temporal filtering
            fmr = bvqx.OpenDocument([fmrName]);
            success = fmr.TemporalHighPassFilter(filterVal, filterUnits);
            if ~success
                any_process_error = 1;
                disp(['ERROR IN TEMPORAL FILTERING FOR SUBJECT ' subject{s} ' AND RUN ' num2str(r) '!!!']);
                return;
            end
            fmrName = fmr.FileNameOfPreprocessdFMR;
            fmr.Close;
            
            % save the first run's file name for motion correction of later runs
            if r == 1 && ~do_MC_override
                MCTargetFile = [fmrName];
            end
            
            if ~any_process_error && delete_intermediates
                
                if r<=num_funcruns{s}
                    suffixName = ['_funcRun' num2str(firstrun_name{s}+r-1)];
                elseif r<=num_funcruns{s}+num_locruns{s}
                    suffixName=['_funcLoc' num2str(r-num_funcruns{s})];
                end
            end
            
            fprintf(['Preprocessed fmr ' fmrName '\n']);
        end %do_processing
    end %end run loop
    
end % s
