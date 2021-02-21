function [EEG_train,EEG_test] = split_EEG(EEG)
    count = ceil(length(EEG) * 0.2);
    indexes = [0,0];
    while (diff(indexes) == 0)
        indexes = randi(length(EEG) ,[1 count]);
    end
    EEG_train = EEG;
    EEG_train(indexes) = []; 
    EEG_test = EEG(indexes);
end