%% BV scripting in Matlab - make VTCs for idenLocfMRI1
% ck 2013.07.19

% As with many of the other scripts in this folder, my work with this script was limited to adjusting parameters and folder paths. -MH

%%
clear all
%%
folder='BMF_con';
study='BMFcon';
subject={'s20'}; %list subject numbers to be analysed right now (can separate all these with commas)
num_funcruns={0}; %number of runs (not loc) for each subj in list -- usually 2 or 3
num_locruns={3}; % number of localizers to make vtc's for; put how many you *collected*, even if using .vois from previous session.
firstrun_name={1};  %1st run name, almost always 1 unless problem; must include one for each subject.

%{
subject={'s02','s03','s04'}; %list subject numbers to be analysed right now
num_funcruns={8,8,8}; %number of runs (not loc) for each subj in list -- usually 8
num_locruns={3,0,3}; % number of localizers to make vtc's for; put how many you *collected*, even if using .vois from previous session.
firstrun_name={1,1,1};  %1st run name, almost always 1 unless problem; must include one for each subject.
%}
%%

resolution=2; %2x2x2 resolution of functional data.
interpolation=1; %linear
bbithresh=100;
datatype=2; %float

numsubjs=size(subject,2);

align_run = 1; % run that you're aligning the others to

for s=1:numsubjs
    %for subjects with hippocampus localized from previous session, we'll
    %align the .vtc to the ACPC vmr for that session.
    % use_prevSess_vmr = strcmp(subject{s},'s01') | strcmp(subject{s},'s02') | strcmp(subject{s},'s03');  
    use_prevSess_vmr = 0;
    transform_tal_space = 1;
    
    subject_path{s}=['C:\Users\kupitz.1\Desktop\Folder for Matts Practice Analyses\' folder '\' subject{s} '\'];
    if use_prevSess_vmr
        vmrfilename{s}=[subject_path{s} 'highres\' subject{s} '_highres_old_ACPC.vmr'];
    else
        vmrfilename{s}=[subject_path{s} 'highres\' subject{s} '_highres.vmr'];
    end
    bvqx = actxserver('BrainVoyagerQX.BrainVoyagerQXScriptAccess.1'); %open BV
    
    for r=1:num_funcruns{s}+num_locruns{s}
        if r<=num_funcruns{s}
            targetfolder{r}=[subject_path{s} 'BMFcon' num2str(firstrun_name{s}+r-1) '\'];
            name=[subject{s} '_BMFcon' num2str(firstrun_name{s}+r-1)];
            % For main runs, grabbing .fmr with smoothing. Should I avoid
            %   spatially smoothed runs??
            % suffix= '_script_SCCAI_3DMCTS_LTR_THP0.01Hz'; % for testing
            suffix= '_SCCAI_3DMCTS_SD3DSS4.00mm_LTR_THP0.01Hz'; % These are hard-coded rather than taken from the pre-processed files!!!!!
            % suffix='_SCCAI2_3DMCT_LTR_THP0.01Hz';
        elseif r<=num_funcruns{s}+num_locruns{s}
            targetfolder{r}=[subject_path{s} 'funcLocFOBSS' num2str(firstrun_name{s}+r-1-num_funcruns{s}) '\'];
            name=[subject{s} '_funcLocFOBSS' num2str(firstrun_name{s}+r-1-num_funcruns{s})];
            % For localizers, grabbing .fmr with smoothing.
            suffix='_SCCAI_3DMCTS_SD3DSS4.00mm_LTR_THP0.01Hz'; % These are hard-coded rather than taken from the pre-processed files!!!!!
        end
        
        %targetfolder{r}=[subject_path{s} name '/'];
        
        if r == align_run %this info is same for all runs and just needs to be set from run1
%             iaFile=dir([targetfolder{r} '*_IA.trf']);
%             faFile=dir([targetfolder{r} '*_FA.trf']);
            %ia_names{s}=[targetfolder{r} iaFile.name];
            %fa_names{s}=[targetfolder{r} faFile.name];
            %             ia_names{s}=[targetfolder{r} subject{s} '_funcRun' num2str(firstrun_name{s}+r-1) '_SCCAI2_3DMCT_SD3DSS4.00mm_LTR_THP0.01Hz-TO-' subject{s} '_inplane_ISO_SAG_CLEAN_IA.trf'];
            %             fa_names{s}=[targetfolder{r} subject{s} '_funcRun' num2str(firstrun_name{s}+r-1) '_SCCAI2_3DMCT_SD3DSS4.00mm_LTR_THP0.01Hz-TO-' subject{s} '_inplane_ISO_SAG_CLEAN_FA.trf'];]
            ia_names{s}=[targetfolder{r} subject{s} '_BMFcon' num2str(firstrun_name{s}+r-1) '-TO-' subject{s} '_highres_IA.trf'];
            fa_names{s}=[targetfolder{r} subject{s} '_BMFcon' num2str(firstrun_name{s}+r-1) '-TO-' subject{s} '_highres_FA.trf'];
%             ia_names{s}=['C:\Users\kupitz.1\Desktop\Folder for Matts Practice Analyses\BMF_con\s20\BMFcon1\s20_BMFcon1-TO-s20_highres_IA.trf'];
%             fa_names{s}=['C:\Users\kupitz.1\Desktop\Folder for Matts Practice Analyses\BMF_con\s20\BMFcon1\s20_BMFcon1-TO-s20_highres_FA.trf'];
            %acpc_names{s}=[subject_path{s} 'highres/' subject{s} '_highres_HOM_ACPC.trf'];
            %tal_names{s}=[subject_path{s} 'highres/' subject{s} '_highres_HOM_ACPC.tal'];
        end
        
        fmr_names{s}{r}=[targetfolder{r} name suffix '.fmr'];
        if use_prevSess_vmr
            vtc_names{s}{r}=[targetfolder{r} name suffix '_old_ACPC.vtc'];
        elseif transform_tal_space
            vtc_names{s}{r}=[targetfolder{r} name suffix '_TAL.vtc'];
        else
            vtc_names{s}{r}=[targetfolder{r} name suffix '_NATIVE.vtc'];
        end
        
        pause(3);  % for some reason, error if the next command is immediately issued
        vmrproject=bvqx.OpenDocument(vmrfilename{s});
        
        fprintf(['Creating VTC ' name '\n']);
        if use_prevSess_vmr
            acpc_names{s}=[subject_path{s} 'highres/' subject{s} '_highres-TO-' subject{s} '_highres_old_ACPC' '.trf']; % isn't actually ACPC; actually session to session
            vmrproject.CreateVTCInACPCSpace(fmr_names{s}{r},ia_names{s},fa_names{s},acpc_names{s},vtc_names{s}{r},datatype,resolution,interpolation,bbithresh);
        elseif transform_tal_space
            acpc_names{s}=[subject_path{s} 'highres/' subject{s} '_highres_IIHC_ACPC.trf']; % Manually check for this name. It might change for some subjects            tal_names{s}= (.TAL)
            tal_names{s}=[subject_path{s} 'highres/' subject{s} '_highres_IIHC_ACPC.tal']; % And here!
            vmrproject.CreateVTCInTALSpace(fmr_names{s}{r},ia_names{s},fa_names{s},acpc_names{s},tal_names{s},vtc_names{s}{r},datatype,resolution,interpolation,bbithresh);
        else
            vmrproject.CreateVTCInVMRSpace(fmr_names{s}{r},ia_names{s},fa_names{s},vtc_names{s}{r},datatype,resolution,interpolation,bbithresh);
        end 
        

        
        %BVQXfile(0,'clearallobjects');
    end
end

