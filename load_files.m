% load all files in dataset folder
% input none, the function know the path
% output EEG struct contian the data and headers of files

function [EEG] = load_files(channels,patient_name, main_path)
    files_idx = 1;
    path = main_path + '\' + patient_name; %main_files(j).name;
    files = dir2(path);
    seizures = parse_summary(path + '\' + patient_name + '-summary-new.txt');
    for i = 1:length(files)
        if contains(files(i).name,".seizures")
            file_name = erase(files(i).name,".seizures");
            [data,header] = ReadEDF(path + '\' + file_name);
            EEG(files_idx).file_name = file_name;
            EEG(files_idx).content = order_content(file_name,data,header,channels,seizures);
            files_idx = files_idx + 1;           
        end
    end
end