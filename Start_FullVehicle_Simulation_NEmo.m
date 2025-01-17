% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
% Created on: 30.04.2019, Version: Matlab2018b
% ------------------------------------------------------------------------
% Description:  Runs a Simulink Longitudinal Simulation Model using either a
%               standard driving cycle (Part 1) or the measured driving cycles
%               of an experiment
% ------------------------------------------------------------------------
% open('Longitudinaldynamicmodel_SmartFortwo');                                      %Open Longitudinal dynamic model NEmo
% Longitudinaldynamicmodel_SmartFortwo_Parameterfile;                                %Load Parameters of NEmo in Model
% simn = sim('Longitudinaldynamicmodel_SmartFortwo','StopTime','1220');                %Simulate Model
% Simulink.sdi.view;                                                          %Show results in Simulink Data Inspector

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alternatively the simulation can be executed with the input of
% experimental data. To run the driving cycles of the measured experiments,   
% uncoment this part of the script.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
close all;
clc;

addpath(genpath('Experiment_Data'));
addpath(genpath('Laengsdynamikmodell'));
addpath(genpath('LIB'));

ModelName = 'Laengsdynamikmodell/Longitudinaldynamicmodel_SmartFortwo'; % Define the name of the Model to be simulated
ExpN = 14;                                                              % Number of total Experiment
load('Experiment_Data/SmartFortwo_Experiments');                        % load saved experiments
open(ModelName)                                                         % open model
Longitudinaldynamicmodel_SmartFortwo_Parameterfile;                     % load corresponing parameterfile of model

% Choose Driving Cycle
obj = 'Longitudinaldynamicmodel_SmartFortwo/Driving Cycle/Longitudinal Driving Cycles';
set_param(obj, 'dcname','Custom_Driving_Cycle');
% Number of Cycles
set_param(obj, 'dccircuits','1');
% Speed Vector [Nx2]
set_param(obj, 'dc_speed','cycle');
% Gear Vector [Nx2]
set_param(obj, 'dc_gear','[]');


for Expn = 1:ExpN
    % Run experiment with measured driving cycle
    [simulation(Expn), cycle] = SimSmartFortwoExperiment(ModelName, experiment, Expn); 
end

% get path of this script
[folder, ~, ~] = fileparts(mfilename('fullpath'));
% Save in the folder of this script
save([folder, '\SmartFortwo_Simulations'], 'simulation');
