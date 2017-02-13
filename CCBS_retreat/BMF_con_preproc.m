% BV scripting in Matlab - preprocessing steps for IdenLoc
% 2014.01.07 - CNK Modified
% 2015.04.09 - AS modified
% 2016.07.10 - MH modified
% 2016.08.10 - MH modified

%%
clear all
%%
delete_intermediates = 1;

folder=['BMF_con'];
study=['BMF_con'];      % Now your pathing is pretty bad. Watch out if 
                        % recycling this for another study
subject={'s20'};    % change this by hand!

num_funcruns={ ...
%     2 % s03, CHECK TR since the number of volumes is different
%     2 % s14
%     2 % s15
%     2 % s16
%     2 % s17
%     3 % s18
%     3 % s19
    3 % s20
%     3 % s21
%     3 % s22
%     3 % s18_2,
    };

firstfiles= { ...
%     [16 17]   % s03
%     [11 12]   % s14
%     [11 12]   % s15
%     [11 12]   % s16
%     [12 13]   % s17
%     [7 8 14]  % s18
%     [8 9 15]  % s19
    [8 9 16]  % s20
%     [7 8 14]  % s21
%     [8 9 15]  % s22
%     [7 8 14]  % s18_2
    };

num_locruns={ ...
%     []  % s03
%     []  % s14
%     []  % s15
%     []  % s16
%     []  % s17
%     []  % s18
%     []  % s19
    3 % s20
%     []  % s21
%     []  % s22
%     []  % s18_2 
    };

locfiles={ ...
%     [] % s03
%     [] % s14
%     [] % s15
%     [] % s16
%     [] % s17
%     [] % s18
%     [] % s19
    [11 12 14] % s20
%     [] % s21
%     [] % s22
%     [] % s18_2
    };

firstrun_name={1};  %1st run name, almost always 1 unless problem

%which files to run ( setting all equal to 1 here, i.e. running all)
do_create={[ones(1,num_funcruns{1}) ones(1,num_locruns{1})]};
% do_create={[zeros(1,num_funcruns{1}) zeros(1,num_locruns{1})]};
do_processing = {[ones(1,num_funcruns{1}) ones(1,num_locruns{1})]};
% do_processing{1}(1:8) = zeros(1,8); % Using this to not process the ones that are already done.

%%
numsubjs=size(subject,2);

%Motion Correction override - if you want to manually set the fmr to which
%you are motion correcting.
do_MC_override = 1;

%FIX ME
for s=1:numsubjs
    if do_MC_override
        MCTargetFile = ['C:\Users\kupitz.1\Desktop\Folder for Matts Practice Analyses\' folder filesep subject{s} '\BMFcon1\' subject{s} '_BMFcon1.fmr'];
    end
    
    subject_path{s}=['C:\Users\kupitz.1\Desktop\Folder for Matts Practice Analyses\' folder filesep subject{s} '\'];
    
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
        nrSlices=41; %41 with 2.5s TR, 33 with 2.0s TR
        byteswap=false;
        bytesperpixel=2; %For functional data, the number of bytes is usually 2 (short integer, 16 bits)
        nrVolsInImg=1; %should be 1
        
        %Scanner parameters. OSU 3T machine (32-channel) is:
        %74x74 for 2s TR? This was not the case for s03
        %100x100 for 2.5s TR
        sizeX=100;
        sizeY=100;
        mosaicSizeX=ceil(sqrt(nrSlices))*sizeX; %6*64=384
        mosaicSizeY=ceil(sqrt(nrSlices))*sizeY;
        
        if r<=num_funcruns{s}
            nrOfVols=170;   % Number of volumes for a funcrun. 170 for 2.5s TR, 206 for 2.0s TR. 
            skipVols=0;
            targetfolder{r}=[subject_path{s} 'BMFcon' num2str(firstrun_name{s}+r-1) '\'];
            prtName=['BMFcon' num2str(firstrun_name{s}+r-1) '_TR.prt']; %has to be in target folder
            do_prt_link = 1;
            % stcprefix=[subject{s} '_funcRun' num2str(firstrun_name{s}+r-1) '_script']; % for testing.
            stcprefix=[subject{s} '_BMFcon' num2str(firstrun_name{s}+r-1)]; % not for testing
        elseif r<=num_funcruns{s}+num_locruns{s} %localizer (funcLoc) params. 
            nrOfVols=110;
            skipVols=0;
            targetfolder{r}=[subject_path{s} 'funcLocFOBSS' num2str(r-num_funcruns{s}) '\'];
            prtName=['funcLocFOBSS' num2str(r-num_funcruns{s}) '_TR.prt']; %has to be in target folder %STILL MOVING OVER MANUALLY -CK
            do_prt_link = 1;
            % stcprefix=[subject{s} '_funcLoc' num2str(r-num_funcruns{s}) '_script']; % for testing.
            stcprefix=[subject{s} '_funcLocFOBSS' num2str(r-num_funcruns{s})]; % not for testing.
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
    
    % temporal filtering. I'm not quite sure how to handle this. 
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
                fmrName=[targetfolder{r} subject{s} '_BMFcon' num2str(firstrun_name{s}+r-1) '.fmr']; % not for testing
            elseif r<=num_funcruns{s}+num_locruns{s} % Still untouched. 
                % fmrName=[targetfolder{r} subject{s} '_funcLoc' num2str(r-num_funcruns{s}) '_script' '.fmr']; % for testing
                fmrName=[targetfolder{r} subject{s} '_funcLocFOBSS' num2str(r-num_funcruns{s}) '.fmr']; % not for testing
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
                % do spatial smoothing. 
                fmr = bvqx.OpenDocument([fmrName]);
                success = fmr.SpatialGaussianSmoothing(smoothingSz, smoothingUnits);
                if ~success
                    any_process_error = 1;
                    disp(['ERROR IN SPATIAL SMOOTHING FOR SUBJECT ' subject{s} ' AND RUN ' num2str(r) '!!!']);
                    return;
                end
                fmrName = fmr.FileNameOfPreprocessdFMR;
                fmr.Close;
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
