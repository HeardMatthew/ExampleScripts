% As with other scripts in this folder, most of my work was limited to changing parameters and folder names. -MH
subjects={'s03', 's14', 's15', 's16', 's17', 's18', 's19', 's20', 's21', 's22'};
TR=2000;    % REMEMBER s03 and MT are special snowflakes (2000) otherwise (2500)

%Normal parameters
params.rcond = 0;
params.prtr  = TR;
params.nvol  = 206;

cd ./s03    % In hindsight, I could have rewritten this directory change and next for loop to run this script for each subject at once. -MH
for s=1:1 
    
    cd prts
    
    for run=1:1    % Change this to 1:2 when you only run 2 instances of BMF_con
        
        prt=BVQXfile(['BMFcon' num2str(run) '.prt']);

        % convert to TR (this means from units of ms to units of TR).
        for c=1:prt.NrOfConditions
        prt.Cond(c).OnOffsets=floor(prt.Cond(c).OnOffsets/TR+1);
        end
    prt.ResolutionOfTime='Volumes';
    prt.SaveAs(['BMFcon' num2str(run) '_TR.prt']); % Check name
        
    sdm=prt.CreateSDM(params);
    sdm.SaveAs(['s03_BMFcon' num2str(run) '_TR.sdm']); % I had to adjust this manually, but I could have rewritten this as above. -MH
    
    end
    
    cd ..
    cd ..
end

cd ..
