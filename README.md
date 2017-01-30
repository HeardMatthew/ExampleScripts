# ExampleScripts
Here is a collection of scripts I have written during my undergraduate at The Ohio State University.

<h3> CCBS Fall Retreat Poster </h3>
I displayed my first poster at the annual CCBS Fall Retreat. In this repository I included a PDF copy of my poster and all the code I modified in order to create the results figures. The brain figures were created by hand using BrainVoyager. All graphs were created using an already existing Matlab file created by Daniel Berman, a doctoral student here in Dr. Julie Golomb's lab. My contribution to this code was adjusting file paths; originally the code pulled all the data off of a server we had set up at the lab. In order to run this already existing code on new data, I adjusted the locations of files called by the program. Included are:

   <h4>plot_xyz_small_MH.m : </h4>
   Running this file creates the same graphics included under Experiment 1 Results of my poster. 

   BMF_plotting_functions_MH_pathed_GitHub.m : Running this file creates the same graphs included under Experiment 2 Results of my poster. 

   withinSub_errorBars_pathed.m : This is a function called by the two plot codes. I changed a few paths within this file. 

   SEM_calc.m : This is a function called by the two plot codes. I made no changes to this file. 

Unfortunately, a substantial amount of code I used during this project has been lost--our lab has since changed computers used to analyze fMRI data. The Matlab code I used to automatically preprocess files in BrainVoyager did not survive the migration. My contribution to this code was similar to the above projects; I adjusted paths in an already existing pipeline. I made some changes in preprocessing options. I also recall spending a fair amount of time debugging some for loops that were not running correctly. 

Misc: I've included some simple codes I created from scratch when I first started learning Matlab in 2014 and Python in 2016. These include: 

   Dice.m : a script used to roll any (interger) number of dice with any (interger) number of sides. 

   QuadraticSolver.m : a script to solve a quadratic equation. 

   digit_sum.py : a script to define two functions: digit_sum(n) and digit_root(n). The former sums all numbers from 1 to n, while the other calculates the digital root of n. 

   fib.py : a script to generate a list of the Fibonnaci sequence from its first term to its nth term. 

   puzzle.py : a script I wrote inspired by the following riddle: http://mindyourdecisions.com/blog/2016/07/03/distance-between-two-random-points-in-a-square-sunday-puzzle/. The first function sim_squ_trials(n) calculates the average from n trials the distance between two random points within a square with side lengths 1. The second function sim_circumf_trials(n) calculates the average from n trials the distance between two random points along a unit circle. The third function sim_circ_trials(n) calculates the average from n trials the distance between two random points within a unit circle. 

In addition to the work here, I have completed tutorials on the following topics:
   
   MVPA analysis tutorial accompanying Sprague, T.C., Saproo, S. & Serences, J.T. (2015) Visual attention mitigates information loss in small- and large-scale neural codes. Trends in Cognitive Sciences. Tutorial found at http://serenceslab.ucsd.edu/reviews.html. I have included the code I created while going through this tutorial:
      
      Multivariate_tutorial.m
      
      Multivariate_tutorial_manyvariables.m
   
   Chapter 1 of Michael A. Nielsen's "Neural Networks and Deep Learning". 
   
   Visionlab Matlab Tutorial from Konkle Lab. This tutorial introduced me to some basics with PsychToolbox and advanced my understanding of Matlab commands. I cannot find a link to download this tutorial. 
   
   Codeacademy Python tutorial
