# ExampleScripts
Here is a collection of scripts I have written during my undergraduate at The Ohio State University.

CCBS Retreat: I displayed my first poster at the annual CCBS Fall Retreat. In this repository I included a PDF copy of my poster and all the code I modified in order to create the results figures. All graphs were created using an already existing Matlab file created by Daniel Berman, a doctoral student here in Dr. Julie Golomb's lab. My contribution to this code was adjusting file paths; originally the code pulled all the data off of a server we had set up at the lab. In order to run this already existing code on new data, I adjusted the locations of files called by the program. Included are: 

plot_xyz_small_MH.m : Running this file creates the same graphics included under Experiment 1 Results of my poster. 

BMF_plotting_functions_MH_pathed_GitHub.m : Running this file creates the same graphs included under Experiment 2 Results of my poster. 

withinSub_errorBars_pathed.m : This is a function called by the two plot codes. I changed a few paths within this file. 

SEM_calc.m : This is a function called by the two plot codes. I made no changes to this file. 

Unfortunately, a substantial amount of code I used during this project has been lost--our lab has since changed computers used to analyze fMRI data. The Matlab code I used to automatically preprocess DICOM files in BrainVoyager did not survive the migration. My contribution to this code was similar to the above projects; I adjusted paths in an already existing pipeline. I made some changes in preprocessing options. I also recall spending a fair amount of time debugging some for loops that were not running correctly. 


In addition to the work here, I have completed tutorials on the following topics:
   MVPA analysis tutorial accompanying Sprague, T.C., Saproo, S. & Serences, J.T. (2015) Visual attention mitigates information loss in small- and large-scale neural codes. Trends in Cognitive Sciences. Tutorial found at http://serenceslab.ucsd.edu/reviews.html. 
   Chapter 1 of Michael A. Nielsen's "Neural Networks and Deep Learning". 
   Visionlab Matlab Tutorial from Konkle Lab (cannot find online... add this in a repository?
   Codeacademy Python tutorial
   
   Consider sections: "Tutorials", "Modifications made to existing codes", and "Code from Scratch"
