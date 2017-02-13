% As mentioned in make_SDMs_BMF_con, I wanted to rewrite the script to preprocess each subject at once. Towards the end of the project, 
% I felt confident enough in my coding skill to start overhauling the code. After this little project, I planned to work a similar
% rewrite into BMF_con_preproc. However, I did not finish this project. I will indicate the areas which I did not finish. -MH

% I am unsure if I correctly coded saving files into the proper directory. -MH
subjects={'s14', 's15', 's16', 's17', 's18', 's19', 's20'};
BMF_runs = {2, 2, 2, 2, 3, 3, 3};
% Input all the subjects which you want to analyze in this structure
TR=2500; % TR for the scan. Make sure it isn't 2000. 

%Normal parameters
params.rcond = 0;
params.prtr  = TR;
params.nvol  = 170;

for s=1:numel(subjects)
    cd(sprintf('./%s', subjects{s}))
    cd prts
    
    for run=1:BMF_runs{s}
        
        prt=BVQXfile(['BMFcon' num2str(run) '.prt']);

        % convert to TR (this means from units of ms to units of TR). I
        % left this untouched from the original code. -MH
        for c=1:prt.NrOfConditions
        prt.Cond(c).OnOffsets=floor(prt.Cond(c).OnOffsets/TR+1);
        end
    prt.ResolutionOfTime='Volumes';
    prt.SaveAs(['BMFcon' num2str(run) '_TR.prt']);
    sdm=prt.CreateSDM(params);
    sdm.SaveAs(['s20_BMFcon' num2str(run) '_TR.sdm']); % This line needs to be rewritten such that each .sdm saves with the proper 
                                                       % subject name. -MH
    
    end
    
    cd ..
    cd ..
end

cd ..

% I did not write a code to ensure the files saved into the proper directory. -MH
for s=14:20
    cd(sprintf('./s%d', s))
end
