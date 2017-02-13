# ExampleScripts
This repository contains a collection of scripts I wrote during my undergraduate at The Ohio State University.

<h2>CCBS Fall Retreat Poster </h2>
I displayed my first poster at the annual Center for Cognitive and Brain Sciences Fall Retreat in 2016. For this project, I helped collect and analyze data using Matlab and BrainVoyager and compared my results with those generated in AFNI by PhD student Dan Berman. In this repository I made a folder (/CCBS_retreat) including a PDF of my poster and all the code used to create the figures featured in the results. I created the inflated brain figures by hand using BrainVoyager and Adobe Illustrator. In addition, I modified an already existing Matlab code to generate the graphs. I contributed to this code mostly by adjusting file paths; originally the code loaded the data from a server set up in Dr. Julie Golomb's lab. Included in this repository are the following relevant scripts:

      plot_xyz_small_MH.m
   Running this file creates the same graphics included under Experiment 1 Results of my poster. The colors seen on the poster were added using Adobe Illustrator. 
      
      MF_plotting_functions_MH_pathed_GitHub.m
   Running this file creates the same graphics included under Experiment 2 Results of my poster. The colors seen on the poster were added using Adobe Illustrator. 

      withinSub_errorBars_pathed.m
   This is a function called by the two plot codes. I changed a few paths within this file. 

      SEM_calc.m
   This is a function called by the two plot codes. I made <em>no</em> changes to this file. 

<h2>fMRI data preprocessing:</h2>
In addition to creating figures and presenting a poster, as part of my summer experience with Golomb Lab I preprocessed fMRI data. As I learned coding and experiment skills, I edited an already existing preprocessing pipeline (used by Anna Shafer-Skelton, former Golomb Lab lab manager, for her project WhichLocHipp) to preprocess the data for Dan Berman's project (BMF). I added the following files to this directory that best represent my contributions to this project: 

      SDMs_BMF_orig.m
   This is the original file I used to create single design matrices (SDMs) while preprocessing fMRI data. I found it to be very time-consuming to change subject number and paths everytime I preprocessed a subject. 
      
      SMDs_BMF_wip.m
   I decided to start an overhaul of SDMs_BMF_orig.m so I could preprocess each subject at the same time. However, I did not complete this new script by the time my summer was over. As the code currently stands, I had not edited the code that saves the SDM with the proper name or in the proper location. 
      
      preproc_BMF.m
   This is the main script I used to preprocess data for Dan Berman's project. I changed parameters file names, and paths from the original, but the majority of the code is the same as the original WhichLocHipp.m version.
      
      preproc_WhichLocHipp.m
   I included the original preprocessing pipeline I used so that the changes I made are more evident. 
      
<h2>Miscellaneous Code</h2> 
I've included (in /Miscellaneous_code) some simple codes I created when I first started learning Matlab in 2014 and Python in 2016. These include: 

      Dice.m
   Here is a script used to roll any (interger) number of dice with any (interger) number of sides. 

      QuadraticSolver.m
   Here is a script to solve a quadratic equation. 

      digit_sum.py
   Here is a script to define two functions: digit_sum(n) and digit_root(n). The former sums all numbers from 1 to n, while the other calculates the digital root of a given interger n. 

      fib.py
   Here is a script to generate a list of the Fibonnaci sequence from its first term to its nth term. 

      puzzle.py
   Here is a script I wrote inspired by the following puzzle: http://mindyourdecisions.com/blog/2016/07/03/distance-between-two-random-points-in-a-square-sunday-puzzle/. The first function sim_squ_trials(n) uses n trials to calculate the average distance between two random points within a square with side lengths 1. The second function sim_circumf_trials(n) uses n trials to calculate the average distance between two random points along the circumference of a unit circle. The third function sim_circ_trials(n) uses n trials to calculate the average distance between two random points within a unit circle. 

<h2>Tutorials </h2>
In addition to the aforementioned work, I have completed tutorials on the following topics:
   
   <h4>MVPA tutorial: </h4>
   I completed the tutorial accompanying Sprague, T.C., Saproo, S. & Serences, J.T. (2015) Visual attention mitigates information loss in small- and large-scale neural codes. Trends in Cognitive Sciences. The tutorial can be found at http://serenceslab.ucsd.edu/reviews.html. I have included the code I created while learning about MVPA in /Tutorials:
      
      Multivariate_tutorial.m
      
      Multivariate_tutorial_manyvariables.m
   
   <h4>Neural Networks in Python: </h4>
   I read Chapter 1 of Michael A. Nielsen's "Neural Networks and Deep Learning". This textbook outlines the basics to creating an artificial neural network and includes a guided tutorial to creating a neural network capable of recognizing handwritten letters and numbers. 
   
   <h4>Matlab and PsychToolbox: </h4>
   I completed a Matlab tutorial from Konkle Lab. This tutorial introduced me to some basics with PsychToolbox and advanced my understanding of Matlab commands. Most undergraduates in Dr. Julie Golomb's lab learn how to code with Matlab using this tutorial. 
   
   <h4>Codeacademy Python tutorial: </h4>
   I completed the free Python tutorial from Codeacademy to develop my skills with Python.  
