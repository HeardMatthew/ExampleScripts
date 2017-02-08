% Hey, this might actually do ALL the preprocessing in one fell swoop. 
% Check how files save. This is where I expect to have issues. 
subjects={'s14', 's15', 's16', 's17', 's18', 's19', 's20'};
BMF_runs = {2, 2, 2, 2, 3, 3, 3};
% Input all the subjects which you want to analyze in this structure
TR=2500; % TR for the scan. 

%Normal parameters
params.rcond = 0;       % What is this? -Matt
params.prtr  = TR;
params.nvol  = 170;

for s=1:numel(subjects)
    cd(sprintf('./%s', subjects{s}))
    cd prts
    
    for run=1:BMF_runs{s}    % Change this to 1:2 when you only run 2 instances of BMF_con
        
        prt=BVQXfile(['BMFcon' num2str(run) '.prt']);

        % convert to TR (this means from units of ms to units of TR). I've
        %   left this untouched -Matt
        for c=1:prt.NrOfConditions
        prt.Cond(c).OnOffsets=floor(prt.Cond(c).OnOffsets/TR+1);
        end
    prt.ResolutionOfTime='Volumes';
    prt.SaveAs(['BMFcon' num2str(run) '_TR.prt']);
    sdm=prt.CreateSDM(params);
    sdm.SaveAs(['s20_BMFcon' num2str(run) '_TR.sdm']); % Heads up, you have to do
                                                       % this manually :c
    
    end
    
    cd ..
    cd ..
end

cd ..
% Next step: is there a way to automate moving the sdms to their respective
% folders? -Matt


for s=14:20
    cd(sprintf('./s%d', s))
end