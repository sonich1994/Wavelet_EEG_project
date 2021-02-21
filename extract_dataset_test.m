function [result,len] = extract_dataset_test(EEG,channels,window_size)
    disp("Feature extraction for test:")
    len = floor(EEG(1).content.samples/window_size);
    folder_name = "myDatasets";
	for k = 1:length(channels)
        Energy = [];
        ApEn = [];
        SamEn = [];
        Std = [];
        ch_name = channels(k);
        for i=1:length(EEG)
            ch_index = contains(EEG(i).content.ch,ch_name);
            file = split(EEG(i).file_name,'.');
            mat_file_name = sprintf("%s/%s_%s_%d.mat",folder_name,string(file(1)),ch_name,window_size);
            if exist(mat_file_name,'file') == 2
                fprintf("Load from %s\n",mat_file_name)
                load(mat_file_name,'T_Energy','T_ApEn', 'T_SamEn' ,'T_Std')
            else
                fprintf("Generate dataset from %s channel %s\n",EEG(i).file_name,ch_name)
                [T_Energy,T_ApEn, T_SamEn ,T_Std] = generate_dataset(EEG(i).content,ch_index,window_size);
                save(mat_file_name, 'T_Energy','T_ApEn', 'T_SamEn' ,'T_Std')
            end
            Energy = [Energy; T_Energy];
            ApEn = [ApEn; T_ApEn];
            SamEn = [SamEn; T_SamEn];
            Std = [Std; T_Std];
        end
        result(k).ch_name = ch_name;
        result(k).Energy = Energy;
        result(k).ApEn = ApEn;
        result(k).SamEn = SamEn;
        result(k).Std = Std;
     end
end