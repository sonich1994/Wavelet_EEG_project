clc;
close all;
clear all;

%% select parameters
dataset_path = "dataset";
patients = ["chb01","chb03","chb05","chb08","chb19","chb20"];
%channels = ["FP2-F8","F7-T7","FP1-F7","F8-T8"];
channels = ["FP1-F7","F7-T7","T7-P7",...
           "P7-O1","FP1-F3","F3-C3",...
           "C3-P3","P3-O1","FP2-F4",...
           "F4-C4","C4-P4","P4-O2",...
           "FP2-F8","F8-T8","T8-P8",...
           "P8-O2","FZ-CZ","CZ-PZ",...
           "T7-FT9","FT9-FT10","FT10-T8"];
window_size = 4096; % 16 sec per ephoce

%% Build algorithm for each patient 
num_of_patients = length(patients);
Energy = zeros(3,3);
ApEn = zeros(3,3);
SamEn = zeros(3,3);
Std = zeros(3,3);
for i = 1 : num_of_patients
    disp("Start analyze patient: " + patients(i))
    % Load files
    EEG = load_files(channels,patients(i), dataset_path);
    % Generate datasets
    dataset = extract_dataset(EEG ,channels,window_size);
    % Analyze Dataset
    [Energy_result, ApEn_result, SamEn_result, Std_result] = analyze_dataset(dataset);
    Energy = Energy + Energy_result./num_of_patients;
    ApEn = ApEn + ApEn_result./num_of_patients;
    SamEn = SamEn + SamEn_result./num_of_patients;
    Std = Std + Std_result./num_of_patients;
end
save('result.mat', 'Energy','ApEn', 'SamEn' ,'Std')
