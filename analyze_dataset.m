function [Energy_result, ApEn_result, SamEn_result, Std_result] = analyze_dataset(dataset)    
    % Energy
    disp("Develop algorithm based Energy");
    X = [];
    Y = dataset(1).Energy.Seizure;
    for i = 1:length(dataset)
        T = removevars(dataset(i).Energy ,{'Seizure'});
        T.Properties.VariableNames = T.Properties.VariableNames + " " + dataset(i).ch_name;
        X = [X T];
    end
    
    [Energy_svm, Energy_knn, Energy_ldr] = calculate_models(X, Y);
    Energy_result = [Energy_svm; Energy_knn; Energy_ldr] ;
    
    % ApEn
    disp("Develop algorithm based ApEn");
    X = [];
    Y = dataset(1).ApEn.Seizure;
    for i = 1:length(dataset)
        T = removevars(dataset(i).ApEn ,{'Seizure'});
        T.Properties.VariableNames = T.Properties.VariableNames + " " + dataset(i).ch_name;
        X = [X T];
    end
    
    [ApEn_svm, ApEn_knn, ApEn_ldr] = calculate_models(X, Y);
    ApEn_result = [ApEn_svm; ApEn_knn; ApEn_ldr] ;
    
    % SamEn
    disp("Develop algorithm based SamEn");
    X = [];
    Y = dataset(1).SamEn.Seizure;
    for i = 1:length(dataset)
        T = removevars(dataset(i).SamEn ,{'Seizure'});
        T.Properties.VariableNames = T.Properties.VariableNames + " " + dataset(i).ch_name;
        X = [X T];
    end
    
    [SamEn_svm, SamEn_knn, SamEn_ldr] = calculate_models(X, Y);
    SamEn_result = [SamEn_svm; SamEn_knn; SamEn_ldr] ;
    
    % Std
    disp("Develop algorithm based Std");
    X = [];
    Y = dataset(1).Std.Seizure;
    for i = 1:length(dataset)
        T = removevars(dataset(i).Std ,{'Seizure'});
        T.Properties.VariableNames = T.Properties.VariableNames + " " + dataset(i).ch_name;
        X = [X T];
    end
    
    [Std_svm, Std_knn, Std_ldr] = calculate_models(X, Y);
    Std_result = [Std_svm; Std_knn; Std_ldr] ;
    
 end