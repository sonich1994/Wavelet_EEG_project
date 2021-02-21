% parse_summary function
% input: folder path and name of folder in dataset folder (like 'chb01')
% output: struct of all seizures time per folder

function [seizures] = parse_summary(file_name)
    % summary_file = dir(folder_path + '\*summary.txt');
    file = fileread(file_name);
    file_split = strsplit(file, newline);
    match = contains(file_split, 'chb');
    start_seizures = [];
    end_seizures = [];
    seiz_idx = 0;
    num_of_seiz_files = 1;
    for num = 1:length(match)
        if match(num)
            amount = split(file_split(num+1),': ');
            amount = str2double(cell2mat(amount(2)));
            if amount == 0
                continue
            end
            file_name = split(file_split(num),': ');
            file_name = regexprep(cell2mat(file_name(2)),'[\n\r]+','');
            amount_idx = amount;
            while (amount_idx)
                start_time = split(file_split(num+2+seiz_idx),':');
                start_time = split(start_time(2));
                start_time = str2double(cell2mat(start_time(2)));
                start_seizures = [start_seizures start_time];

                end_time = split(file_split(num+3+seiz_idx),':');
                end_time = split(end_time(2));
                end_time = str2double(cell2mat(end_time(2)));
                end_seizures = [end_seizures end_time];
                seiz_idx = seiz_idx + 2;
                amount_idx = amount_idx - 1;
            end
            seizures(num_of_seiz_files).filename = file_name;
            seizures(num_of_seiz_files).start_seizures = start_seizures;
            seizures(num_of_seiz_files).end_seizures = end_seizures;
            seizures(num_of_seiz_files).amount = amount;
            num_of_seiz_files = num_of_seiz_files + 1;
            seiz_idx = 0;
            start_seizures = [];
            end_seizures = [];
        end
    end
end
