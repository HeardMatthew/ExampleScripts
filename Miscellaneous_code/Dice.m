%% Dice.m
% Create a program that rolls and adds up any number of dice of any sides. 
clear all; clc; 

% Specify how many sides the dice have
n_dice = input('# Dice to roll = ');
sides_dice = input('  Sides per dice = ');
mods = input('  Modifier = ');

% Let's get rolling
total = 0;
for j = 1:n_dice
    roll = randi([1, sides_dice]); 
    total = total + roll; 
end
total = total + mods; 
display(['Your total is: ', num2str(total)])
