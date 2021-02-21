
function [T_Energy,T_ApEn, T_SamEn ,T_Std] = generate_dataset(content,ch_index,window_size)
	count = content.samples * content.ch_num;
    len = floor(count/window_size);
    T_Energy = array2table(ones(len,8)*2,'VariableNames',{'Seizure'... 
            'Energy 1' 'Energy 2' 'Energy 3' ...
            'Energy 4' 'Energy 5' 'Energy 6' 'Energy 7'});
    T_ApEn = array2table(ones(len,8)*2,'VariableNames',{'Seizure'... 
            'ApEn 1' 'ApEn 2' 'ApEn 3' 'ApEn 4' ...
            'ApEn 5' 'ApEn 6' 'ApEn 7'});
    T_SamEn = array2table(ones(len,8)*2,'VariableNames',{'Seizure'... 
            'SamEn 1' 'SamEn 2' 'SamEn 3' 'SamEn 4' ...
            'SamEn 5' 'SamEn 6' 'SamEn 7'});
    T_Std = array2table(ones(len,8)*2,'VariableNames',{'Seizure'... 
            'Std 1' 'Std 2' 'Std 3' 'Std 4' ...
            'Std 5' 'Std 6' 'Std 7'});
    srate = content.srate;
	Signal = content.signals(ch_index,:);
	Seizure_Signal = [];
	for t = content.seizures.amount:-1:1 % extract seizure signal
        start_seizure = content.seizures.start_seizures(t)* srate;
        end_seizure = content.seizures.end_seizures(t)* srate;
        Seizure_Signal = [Seizure_Signal Signal(start_seizure:end_seizure)];
        Signal(start_seizure:end_seizure) = [];
    end            
    for p = 1 : floor(length(Signal)/window_size) % analyze signal 
        index = p;
        Start = 1 + (p-1)*window_size;
        End = p*window_size;
        signal = Signal(Start : End);
        T_Energy.Seizure(index) = false;
        T_ApEn.Seizure(index) = false;
        T_SamEn.Seizure(index) = false;
        T_Std.Seizure(index) = false;
        [c,l] = wavedec(signal,7,'db4');
        d = detcoef(c,l,[1 2 3 4 5 6 7]);
        for t = 1:length(d)
            T_Energy.(sprintf("Energy %d",t))(index) = sum((d{t}).^2);
            T_ApEn.(sprintf("ApEn %d",t))(index) = ApEn(2,0.8,d{t},1);
            T_SamEn.(sprintf("SamEn %d",t))(index) = SamEn(d{t},2,0.8,'euclidean');
            T_Std.(sprintf("Std %d",t))(index) = std(d{t});
        end
    end

    for i = 1 : floor(length(Seizure_Signal)/window_size)
        index = i + p;
        Start = 1 + (i-1)*window_size;
        End = i*window_size;
        signal = Seizure_Signal(Start : End);
        
        T_Energy.Seizure(index) = true;
        T_ApEn.Seizure(index) = true;
        T_SamEn.Seizure(index) = true;
        T_Std.Seizure(index) = true;
        
        [c,l] = wavedec(signal,7,'db4');
        d = detcoef(c,l,[1 2 3 4 5 6 7]);
        for t = 1:length(d)
            T_Energy.(sprintf("Energy %d",t))(index) = sum((d{t}).^2);
            T_ApEn.(sprintf("ApEn %d",t))(index) = ApEn(2,0.8,d{t},1);
            T_SamEn.(sprintf("SamEn %d",t))(index) = SamEn(d{t},2,0.8,'euclidean');
            T_Std.(sprintf("Std %d",t))(index) = std(d{t});
        end
    end
    if any(T_Energy.Seizure == 2)
        T_Energy(T_Energy.Seizure == 2,:) = [];
    end
    if any(T_ApEn.Seizure == 2)
        T_ApEn(T_ApEn.Seizure == 2,:) = [];
    end
    if any(T_SamEn.Seizure == 2)
        T_SamEn(T_SamEn.Seizure == 2,:) = [];
    end
    if any(T_Std.Seizure == 2)
        T_Std(T_Std.Seizure == 2,:) = [];
    end    
end 
