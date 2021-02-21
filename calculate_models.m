function [SVM, KNN, LDR] = calculate_models(X,Y)
    M = 0.2;
    % SVM
    disp("Create SVM modle");
    cp = classperf(Y);
    for i=1:10
        [train,test] = crossvalind('HoldOut',Y,0.2);
        mdl = fitcsvm(X(train,:),Y(train));
        predictions = predict(mdl,X(test,:));
        classperf(cp,predictions,test);
    end
    accuracy = 1-cp.ErrorRate;
    disp ("Accuracy: " + accuracy + " Sensitivity:" + cp.Sensitivity + " Specificity: " + cp.Specificity);
    SVM = [accuracy,cp.Sensitivity,cp.Specificity];
    
    % KNN
    disp("Create KNN modle");
    cp = classperf(Y);
    for i=1:10
        [train,test] = crossvalind('HoldOut',Y,M);
        mdl = fitcknn(X(train,:),Y(train),'NumNeighbors',3);
        predictions = predict(mdl,X(test,:));
        classperf(cp,predictions,test); 
    end
    accuracy = 1-cp.ErrorRate;
    disp ("Accuracy: " + accuracy + " Sensitivity:" + cp.Sensitivity + " Specificity: " + cp.Specificity);
    KNN = [accuracy,cp.Sensitivity,cp.Specificity];
    
    % LDR
    disp("Create LDR modle");
    cp = classperf(Y);
    for i=1:10
        [train,test] = crossvalind('HoldOut',Y,M);
        mdl = fitcdiscr(X(train,:),Y(train),'DiscrimType','pseudolinear');
        predictions = predict(mdl,X(test,:));
        classperf(cp,predictions,test);
    end
    accuracy = 1-cp.ErrorRate;
    disp ("Accuracy: " + accuracy + " Sensitivity:" + cp.Sensitivity + " Specificity: " + cp.Specificity);
    LDR = [accuracy,cp.Sensitivity,cp.Specificity];
end