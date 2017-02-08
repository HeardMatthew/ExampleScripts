
subjects={'s03', 's14', 's15', 's16', 's17', 's18', 's19', 's20', 's21', 's22'};
TR=2000;    % REMEMBER s03 and MT are special snowflakes (2000) otherwise (2500)

%Normal parameters
params.rcond = 0;       % What is this? -Matt
params.prtr  = TR;
params.nvol  = 206;

cd ./s03                % I've hard-coded selecting the directory because 
                        %   I don't know of a fancier way! -Matt
                        % Since I'm running one subject at a time, this
                        %   should be fine for now...

for s=1:1               % You can later change this for s=1:10 to run each subject
    
    cd prts
    
    for run=1:1    % Change this to 1:2 when you only run 2 instances of BMF_con
        
        prt=BVQXfile(['BMFcon' num2str(run) '.prt']);

        % convert to TR (this means from units of ms to units of TR). I've
        %   left this untouched -Matt
        for c=1:prt.NrOfConditions
        prt.Cond(c).OnOffsets=floor(prt.Cond(c).OnOffsets/TR+1);
        end
    prt.ResolutionOfTime='Volumes';
    prt.SaveAs(['BMFcon' num2str(run) '_TR.prt']); % Check name
        
    sdm=prt.CreateSDM(params);
    sdm.SaveAs(['s03_BMFcon' num2str(run) '_TR.sdm']); % Heads up, you have to do
                                                       % this manually :c
    
    end
    
    cd ..
    cd ..
end

cd ..
% Next step: is there a way to automate moving the sdms to their respective
% folders? -Matt