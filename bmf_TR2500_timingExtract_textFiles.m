function bmf_TR2500_timingExtract_textFiles

% Once again, my work with this script was mostly limited to changing file paths and running the function with different parameters. -MH

sub = {'4166JG'};
numSubs = length(sub);
cd('C:\Users\kupitz.1\Desktop\Folder for Matts Practice Analyses\BMF_con\1d files')
path = 'C:\Users\kupitz.1\Dropbox\Shared Lab Folder\FMRI_Experiments\xyz_fMRI_small\bmf_and_supp\';

for s = 1:numSubs
    if strcmp(sub(s),'4081JG')
        bmf_timing = importdata([path 'EM_time_BMF.txt']);
    elseif strcmp(sub(s),'4088JG')
        bmf_timing = importdata([path 'DB_time_BMF.txt']);
    elseif strcmp(sub(s),'4093JG')
        bmf_timing = importdata([path 'AE_time_BMF.txt']);
    elseif strcmp(sub(s),'4116JG')
        bmf_timing = importdata([path 'JK_time_BMF.txt']);
    elseif strcmp(sub(s),'4166JG')
        bmf_timing = importdata([path 'MB_time_BMF.txt']);
    elseif strcmp(sub(s),'4193JG')
        bmf_timing = importdata([path 'AL_time_BMF.txt']);
    elseif strcmp(sub(s),'4225JG')
        bmf_timing = importdata([path 'XZ_time_BMF.txt']);
    elseif strcmp(sub(s),'4240JG')
        bmf_timing = importdata([path 'AK_time_BMF.txt']);
    elseif strcmp(sub(s),'4345JG')
        bmf_timing = importdata([path 'BA_time_BMF.txt']);
    else
        error('Specify subject!!!!')
    end
    
    timeCourse = round(bmf_timing.data(:,5) * 10) / 10; %round to tenth of a second
    timeCourse = timeCourse * 1000;
    depths = bmf_timing.data(:,7);
    

    idxTimeMid = zeros(length(timeCourse),1);
    idxTimeFront = zeros(length(timeCourse),1);
    idxTimeBack = zeros(length(timeCourse),1);
    idxTimeFix = zeros(length(timeCourse),1);
    
    for t = 1:length(depths)
        tmpDepth = depths(t);
        if tmpDepth == 0
            idxTimeMid(t) = true;
        elseif tmpDepth == 12 % -12 is front for BMF (except subject 4166JG / s18)
            idxTimeFront(t) = true;
        elseif tmpDepth == -12  % 12 is back for BMF (except subject 4166JG / s18)
            idxTimeBack(t) = true;
        elseif isnan(tmpDepth)
            idxTimeFix(t) = true;
        else
            error('Indexing went wrong somewhere')
        end
    end
    
    
    % filter time courses of each depth (and fixation)
        
    numRuns = 3;    % change this variable to indicate how many runs of BMF were done on a subject to subject basis
    if numRuns == 2
        fixationTimes = timeCourse .* idxTimeFix;
        fixationTimes = nonzeros(fixationTimes)';
        fixationTimes = vertcat(fixationTimes([1:8]),fixationTimes([9:16]));
        midTimes = timeCourse .* idxTimeMid;
        midTimes = nonzeros(midTimes)';
        midTimes = vertcat(midTimes([1:8]),midTimes([9:16]));
        frontTimes = timeCourse .* idxTimeFront;
        frontTimes = nonzeros(frontTimes)';
        frontTimes = vertcat(frontTimes([1:8]),frontTimes([9:16]));
        backTimes = timeCourse .* idxTimeBack;
        backTimes = nonzeros(backTimes)';
        backTimes = vertcat(backTimes([1:8]),backTimes([9:16]));
        fixFileName = 'fixationBMF.1D';
    elseif numRuns == 3
        fixationTimes = timeCourse .* idxTimeFix; 
        fixationTimes = nonzeros(fixationTimes)';
        fixationTimes = vertcat(fixationTimes([1:8]),fixationTimes([9:16]),fixationTimes([17:24]));
        midTimes = timeCourse .* idxTimeMid;
        midTimes = nonzeros(midTimes)';
        midTimes = vertcat(midTimes([1:8]),midTimes([9:16]),midTimes([17:24]));    
        frontTimes = timeCourse .* idxTimeFront;
        frontTimes = nonzeros(frontTimes)';
        frontTimes = vertcat(frontTimes([1:8]),frontTimes([9:16]),frontTimes([17:24]));
        backTimes = timeCourse .* idxTimeBack;
        backTimes = nonzeros(backTimes)';
        backTimes = vertcat(backTimes([1:8]),backTimes([9:16]),backTimes([17:24]));
        fixFileName = 'fixationBMF_3runs.1D';
    end
   
end
    
    fixFileName = 'fixationBMF.1D';
    
    
for f = 1:numRuns
    fidFix = fopen(fixFileName,'a');
    fprintf(fidFix,'%g\t',fixationTimes(f,:));
    fprintf(fidFix,'\n');
    fclose(fidFix);
end

midFileName = sprintf('%s_midBMF.1D',sub{s});

for m = 1:numRuns
    fidmid = fopen(midFileName,'a');
    fprintf(fidmid,'%g\t',midTimes(m,:));
    fprintf(fidmid,'\n');
    fclose(fidmid);
end

frontFileName = sprintf('%s_frontBMF.1D',sub{s});

for fr = 1:numRuns
        fidfront = fopen(frontFileName,'a');
        fprintf(fidfront,'%g\t',frontTimes(fr,:));
        fprintf(fidfront,'\n');
        fclose(fidfront);
end

backFileName = sprintf('%s_backBMF.1D',sub{s});

for b = 1:numRuns
    fidBack = fopen(backFileName,'a');
    fprintf(fidBack,'%g\t',backTimes(b,:));
    fprintf(fidBack,'\n');
    fclose(fidBack);
end
%     
%     copyfile(backFileName,sprintf('/artichoke_home/fMRI/xyz_small/%s/reg_data/',sub{s}))
%     copyfile(frontFileName,sprintf('/artichoke_home/fMRI/xyz_small/%s/reg_data/',sub{s}))
%     copyfile(midFileName,sprintf('/artichoke_home/fMRI/xyz_small/%s/reg_data/',sub{s}))
%     copyfile(fixFileName,sprintf('/artichoke_home/fMRI/xyz_small/%s/reg_data/',sub{s}))

end

% make two rows     
    
    % STRICTLY FOR SUBJECTS '4081JG','4088JG','4093JG'
    %     fixationTimes = timeCourse .* idxTimeFix; fixationTimes = unique(nonzeros(fixationTimes))';  fixationTimes = vertcat(fixationTimes,fixationTimes);
    %     midTimes = timeCourse .* idxTimeMid; midTimes = unique(nonzeros(midTimes))'; midTimes = vertcat(midTimes,midTimes);
    %     frontTimes = timeCourse .* idxTimeFront; frontTimes = unique(nonzeros(frontTimes))'; frontTimes = vertcat(frontTimes,frontTimes);
    %     backTimes = timeCourse .* idxTimeBack; backTimes = unique(nonzeros(backTimes))'; backTimes = vertcat(backTimes,backTimes);
