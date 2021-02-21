function plot_result()
    load('result.mat', 'Energy','ApEn', 'SamEn' ,'Std');
    T = array2table(Energy,'VariableNames',{'Accuracy','Sensitivity','Specificity'}...
        ,'RowNames',{'SVM','KNN','LDR'});
    % Get the table in string form.
    TString = evalc('disp(T)');
    % Use TeX Markup for bold formatting and underscores.
    TString = strrep(TString,'<strong>','\bf');
    TString = strrep(TString,'</strong>','\rm');
    TString = strrep(TString,'_','\_');
    % Get a fixed-width font.
    FixedWidth = get(0,'FixedWidthFontName');
    % Output the table using the annotation command.
    annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
        'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);
end