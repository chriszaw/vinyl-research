clear all; close all;
Tbl = readtable( '/Users/cz/Code/vinyl-research/matlab_code/A0000B0000/A0000B0000.csv');


% plot_scatter2(Tbl, 'quiet', 'a', 'PressingNumber', 'RMS_L', 'RMS_R', 'Pressing Number vs Unweighted RMS side a')
% plot_scatter2(Tbl, 'quiet', 'a', 'PressingNumber', 'A_L', 'A_R', 'Pressing Number vs A weighted RMS side a')
% plot_scatter2(Tbl, 'quiet', 'a', 'PressingNumber', 'CCIR_L', 'CCIR_R', 'Pressing Number vs CCIR weighted RMS side a')

% plot_scatter2(Tbl, 'quiet', 'b', 'PressingNumber', 'RMS_L', 'RMS_R', 'Pressing Number vs Unweighted RMS side b')
% plot_scatter2(Tbl, 'quiet', 'b', 'PressingNumber', 'A_L', 'A_R', 'Pressing Number vs A weighted RMS side b')
% plot_scatter2(Tbl, 'quiet', 'b', 'PressingNumber', 'CCIR_L', 'CCIR_R', 'Pressing Number vs CCIR weighted RMS side b')

% figure(4)
% plot_scatter2special(Tbl, 'quiet', 'a', 'PressingNumber', 'clicks_L', 'clicks_R', 'Pressing Number vs Clicks side a')
% figure(5)
% plot_scatter2(Tbl, 'quiet', 'b', 'PressingNumber', 'clicks_L', 'clicks_R', 'Pressing Number vs Clicks side b')

figure(10)
plot_histogram(10, Tbl, 'quiet', 'a', 'A_L', 'clicks histogram left channel', 'clicks', [-58 -52])




function plot_barchart2(plotnum, Tbl, trackname, side, x1, x2,titlestring, varname)
    cols = Tbl.Properties.VariableNames;
    pressruns = unique(Tbl.pressing);

    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx1 = find(ismember(cols, x1));
    colx2 = find(ismember(cols, x2));
    % X = table2array(Tbl(:,colx));

    X1 = [];
    X2 = [];
    for i = 1:length(pressruns)
        tbl = Tbl(strcmp(Tbl.pressing,pressruns{i}),:);
        x1 = mean(table2array(tbl(:,colx1)));
        x2 = mean(table2array(tbl(:,colx2)));
        X1 = [X1, x1];
        X2 = [X2, x2];
    end


    figure(plotnum); grid on; hold on;
    H = bar([X1, X2], 'LineWidth', 2);

    hold on;
    % H = bar(X1, 'LineWidth', 2)
    H(1).FaceColor = [0.6 0.6 0.6];
    H(2).FaceColor = [.9 .9 .9];
    set(gca,'xticklabel',pressruns)
    ax=gca;
    ax.FontSize=8;
    ax.XTick = (1:length(pressruns))   %THIS WAY, YOU SET HOW MANY XTICKS YOU WANT FOR YOUR XTICKLABELS
    xtickangle(45)
    ylabel(varname)
    title('RMS noise in quiet track')
    saveas(figure(plotnum),'RMSquiet.png')
end




function plot_barchart(plotnum, Tbl, trackname, side, x, titlestring, varname)
    cols = Tbl.Properties.VariableNames;
    pressruns = unique(Tbl.pressing);

    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx = find(ismember(cols, x));
    % X = table2array(Tbl(:,colx));

    X = [];
    for i = 1:length(pressruns)
        tbl = Tbl(strcmp(Tbl.pressing,pressruns{i}),:);
        x = mean(table2array(tbl(:,colx)));
        X = [X, x];
    end


    figure(plotnum); grid on; hold on;
    H = bar(X, 'LineWidth', 2)
    H(1).FaceColor = [0.6 0.6 0.6];
    % H(2).FaceColor = [.9 .9 .9];
    set(gca,'xticklabel',pressruns)
    ax=gca;
    ax.FontSize=8;
    ax.XTick = (1:length(pressruns))   %THIS WAY, YOU SET HOW MANY XTICKS YOU WANT FOR YOUR XTICKLABELS
    xtickangle(45)
    ylabel(varname)
    title('RMS noise in quiet track')
    saveas(figure(plotnum),'RMSquiet.png')
end

function plot_histogram(plotnum, Tbl, trackname, side, x, titlestring, varname, binlims)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx = find(ismember(cols, x));
    X = table2array(Tbl(:,colx));

    figure(plotnum); grid on; hold on;
    histogram(X,50,'BinLimits',binlims)

    ylabel('number of records')
    varname
    xlabel(varname)
    title(titlestring)
    plotname = strcat('plots/', titlestring,'.png');
    saveas(figure(plotnum), plotname)
end


function plot_scatter(Tbl, trackname, side, x, y,titlestring)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx = find(ismember(cols, x));
    coly = find(ismember(cols, y));
    X = table2array(Tbl(:,colx));
    Y = table2array(Tbl(:,coly));

    % figure(plotnum);  
    fig = figure('Visible', 'off');
    scatter(X,Y,'ko');
    grid on; 
    title(titlestring);
    plotname = strcat('plots/', titlestring,'.png');
    saveas(fig, plotname);

end

function plot_scatter2(Tbl, trackname, side, x, y1, y2, titlestring)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx = find(ismember(cols, x));
    coly1 = find(ismember(cols, y1));
    coly2 = find(ismember(cols, y2));
    X = table2array(Tbl(:,colx));
    Y1 = table2array(Tbl(:,coly1));
    Y2 = table2array(Tbl(:,coly2));

    % figure(plotnum);  
    fig = figure('Visible', 'off');
    scatter(X,Y1,'ko');
    grid on; hold on;
    scatter(X,Y2,'kx');
    legend({'left channel', 'right channel'});
    title(titlestring);
    plotname = strcat('plots/', titlestring,'.png');
    saveas(fig, plotname);

end

function plot_scatter2special(Tbl, trackname, side, x, y1, y2, titlestring)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx = find(ismember(cols, x));
    coly1 = find(ismember(cols, y1));
    coly2 = find(ismember(cols, y2));
    X = table2array(Tbl(:,colx));
    Y1 = table2array(Tbl(:,coly1));
    Y2 = table2array(Tbl(:,coly2));
    
    % figure(plotnum);  
    fig = figure('Visible', 'off');
    scatter(X,Y1,'ko');
    grid on; hold on;
    scatter(X,Y2,'kx');
    ylim([0,10])
    legend({'left channel', 'right channel'});
    title(titlestring);
    plotname = strcat('plots/', titlestring,'.png');
    saveas(fig, plotname);

end
