clear all;close all;clc
set(0,'DefaultLineLineWidth',1.5);
set(0,'DefaultAxesFontSize',12);
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth',1.5)


addpath('/Users/cz/Code/vinyl-research/matlab_code/')

A0000B0000 = readtable('/Users/cz/Code/vinyl-research/A0000B0000manual.csv');
A0137B0137 = readtable('/Users/cz/Code/vinyl-research/A0137B0137manual.csv');
BOTH = readtable('/Users/cz/Code/vinyl-research/manualmatching.csv');
% cols = Tbl.Properties.VariableNames;

% A0000B0000 = BOTH(strcmp(BOTH.pressing,'A0000B0000'));

% A0137B0137 = BOTH(strcmp(BOTH.pressing,'')

% % 
% % A0000B0000 = removevars(A0000B0000,{'pressing_SettingsTable'});

% T.Properties.VariableNames{58} = 'pressing';

disp('transition')
firsttransA_La = get_stats(A0000B0000, 'transition', 'a', 'A_L')
firsttransA_Ra = get_stats(A0000B0000, 'transition', 'a', 'A_R')
firsttransA_Lb = get_stats(A0000B0000, 'transition', 'b', 'A_L')
firsttransA_Rb = get_stats(A0000B0000, 'transition', 'b', 'A_R')
secondtransA_La = get_stats(A0137B0137, 'transition', 'a', 'A_L')
secondtransA_R = get_stats(A0137B0137, 'transition', 'a', 'A_R')
secondtransA_Lb = get_stats(A0137B0137, 'transition', 'b', 'A_L')
secondtransA_R = get_stats(A0137B0137, 'transition', 'b', 'A_R')

disp('quiet')
firstquietA_La = get_stats(A0000B0000, 'quiet', 'a', 'A_L')
firstquietA_Rb = get_stats(A0000B0000, 'quiet', 'a', 'A_R')
firstquietA_Lb = get_stats(A0000B0000, 'quiet', 'b', 'A_L')
firstquietA_Rb = get_stats(A0000B0000, 'quiet', 'b', 'A_R')
secondquietA_La = get_stats(A0137B0137, 'quiet', 'a', 'A_L')
secondquietA_Ra = get_stats(A0137B0137, 'quiet', 'a', 'A_R')
secondquietA_Lb = get_stats(A0137B0137, 'quiet', 'b', 'A_L')
secondquietA_Rb = get_stats(A0137B0137, 'quiet', 'b', 'A_R')

disp('quiet2')
firstquiet2A_La = get_stats(A0000B0000, 'quiet2', 'a', 'A_L')
firstquiet2A_Ra = get_stats(A0000B0000, 'quiet2', 'a', 'A_R')
firstquiet2A_Lb = get_stats(A0000B0000, 'quiet2', 'b', 'A_L')
firstquiet2A_Rb = get_stats(A0000B0000, 'quiet2', 'b', 'A_R')
secondquiet2A_La = get_stats(A0137B0137, 'quiet2', 'a', 'A_L')
secondquiet2A_Ra = get_stats(A0137B0137, 'quiet2', 'a', 'A_R')
secondquiet2A_Lb = get_stats(A0137B0137, 'quiet2', 'b', 'A_L')
secondquiet2A_Rb = get_stats(A0137B0137, 'quiet2', 'b', 'A_R')

A_LstatsTable(1,:) = struct2table(firsttransA_La)
A_LstatsTable(2,:) = struct2table(firsttransA_Ra)
A_LstatsTable(3,:) = struct2table(firsttransA_Lb)
A_LstatsTable(4,:) = struct2table(firsttransA_Rb)
A_LstatsTable(5,:) = struct2table(firsttransA_La)
A_LstatsTable(6,:) = struct2table(firsttransA_Ra)
A_LstatsTable(7,:) = struct2table(firsttransA_La)
A_LstatsTable(8,:) = struct2table(firsttransA_La)
A_LstatsTable(9,:) = struct2table(firsttransA_La)
A_LstatsTable(10,:) = struct2table(firsttransA_La)
A_LstatsTable(11,:) = struct2table(firsttransA_La)
A_LstatsTable(12,:) = struct2table(firsttransA_La)
A_LstatsTable(13,:) = struct2table(firsttransA_La)
A_LstatsTable(14,:) = struct2table(firsttransA_La)
A_LstatsTable(15,:) = struct2table(firsttransA_La)
A_LstatsTable(16,:) = struct2table(firsttransA_La)
A_LstatsTable(17,:) = struct2table(firsttransA_La)

% plot_scatter2(BOTH, 'quiet', 'a', 'PressingNumber', 'A_L', 'A_R','A-weighted RMS vs. pressing number side a', 'BOTHPressingNumberARMSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'PressingNumber', 'A_L', 'A_R','A-weighted RMS  vs. pressing number side b', 'BOTHPressingNumberARMSb')
% plot_scatter2(BOTH, 'quiet', 'a', 'PressingNumber', 'RMS_L', 'RMS_R','RMS vs. pressing number side a', 'BOTHPressingNumberRMSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'PressingNumber', 'RMS_L', 'RMS_R','RMS  vs. pressing number side b', 'BOTHPressingNumberRMSb')
% plot_scatter2(BOTH, 'quiet', 'a', 'PressingNumber', 'THD_L', 'THD_R','Total harmonic distortion  vs. pressing number side a', 'BOTHPressingNumberTHDa')
% plot_scatter2(BOTH, 'quiet', 'b', 'PressingNumber', 'THD_L', 'THD_R','Total harmonic distortion vs. pressing number side b', 'BOTHPressingNumberTHDb')
% plot_scatter2(BOTH, 'quiet', 'a', 'PressingNumber', 'clicks_L', 'clicks_R','Number of clicks  vs. pressing number side a', 'BOTHPressingNumberCLICKSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'PressingNumber', 'clicks_L', 'clicks_R','Number of clicks vs. pressing number side b', 'BOTHPressingNumberCLICKSb')



% plot_scatter2(BOTH, '3150Hz', 'a', 'PressingNumber', 'wow_L', 'wow_R','Wow  vs. pressing number side a', 'BOTHPressingNumberWOWa')
% plot_scatter2(BOTH, '3150Hz', 'b', 'PressingNumber', 'wow_L', 'wow_R','Wow  vs. pressing number side b', 'BOTHPressingNumberWOWb')
% plot_scatter(BOTH, '3150Hz', 'a', 'PressingNumber', 'centreholeoffset','Centre hole offset vs. pressing number side a', 'BOTHPressingNumberCHOa')
% plot_scatter(BOTH, '3150Hz', 'b', 'PressingNumber', 'centreholeoffset','Centre hole offset vs. pressing number side b', 'BOTHPressingNumberCHOb')


% plot_scatter(BOTH, '1kHzL', 'a', 'PressingNumber', 'stereo_bleed','Stereo bleed vs pressing number side a', 'BOTHPressingNumberSBa')
% plot_scatter(BOTH, '1kHzL', 'b', 'PressingNumber', 'stereo_bleed','Stereo bleed vs pressing number side b', 'BOTHPressingNumberSBb')


% plot_scatter2(BOTH, 'quiet', 'a', 'maxMouldSteamIn_F', 'A_L', 'A_R','A-weighted RMS vs. maximum mould steam in temperature side a', 'BOTHmaxMouldSteamInARMSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'maxMouldSteamIn_F', 'A_L', 'A_R','A-weighted RMS vs. maximum mould steam in temperature side b', 'BOTHmaxMouldSteamINARMSb')
% plot_scatter2(BOTH, 'quiet', 'a', 'maxMouldSteamIn_F', 'RMS_L', 'RMS_R','RMS vs. maximum mould steam in temperature side a', 'BOTHmaxMouldSteamInRMSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'maxMouldSteamIn_F', 'RMS_L', 'RMS_R','RMS vs. maximum mould steam in temperature side b', 'BOTHmaxMouldSteamINRMSb')
% plot_scatter2(BOTH, 'quiet', 'a', 'maxMouldSteamIn_F', 'clicks_L', 'clicks_R','Number of clicks vs. maximum mould steam in temperature side a', 'BOTHmaxMouldSteamInCLICKSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'maxMouldSteamIn_F', 'clicks_L', 'clicks_R','Number of clicks vs. maximum mould steam in temperature side b', 'BOTHmaxMouldSteamInCLICKSb')


% plot_scatter2(BOTH, 'quiet', 'a', 'maxExtruderPremouldTemp_F', 'A_L', 'A_R','A-weighted RMS vs. maximum extruder premould temperature  side a', 'BOTHmaxExtruderPremouldTempARMSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'maxExtruderPremouldTemp_F', 'A_L', 'A_R','A-weighted RMS vs. maximum extruder premould temperature side b', 'BOTHmaxmaxExtruderPremouldTempARMSb')
% plot_scatter2(BOTH, 'quiet', 'a', 'maxExtruderPremouldTemp_F', 'RMS_L', 'RMS_R','RMS vs. maximum extruder premould temperature  side a', 'BOTHmaxExtruderPremouldTempRMSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'maxExtruderPremouldTemp_F', 'RMS_L', 'RMS_R','RMS vs. maximum extruder premould temperature  side b', 'BOTHmaxmaxExtruderPremouldTempRMSb')
% plot_scatter2(BOTH, 'quiet', 'a', 'maxExtruderPremouldTemp_F', 'clicks_L', 'clicks_R','Number of clicks vs. maximum extruder premould temperature side a', 'BOTHmaxExtruderPremouldTempCLICKSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'maxMouldSteamIn_F', 'clicks_L', 'clicks_R','Number of clicks vs. maximum extruder premould temperature side b', 'BOTHmaxmaxExtruderPremouldTempCLICKSb')

% plot_scatter2(BOTH, 'quiet', 'a', 'minMouldSteamOutBottom_F', 'A_L', 'A_R','Minimum steam out temperature of the bottom mould vs. A-weighted RMS side a', 'BOTHminMouldSteamOutBottomARMSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'minMouldSteamOutBottom_F', 'A_L', 'A_R','Minimum steam out temperature of the bottom mould vs. RMS side b', 'BOTHminMouldSteamOutBottomARMSb')
% plot_scatter2(BOTH, 'quiet', 'a', 'minMouldSteamOutTop_F', 'RMS_L', 'RMS_R','Minimum steam out temperature of the top mould vs. RMS side a', 'BOTHminMouldSteamOutTopRMSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'minMouldSteamOutBottom_F', 'RMS_L', 'RMS_R','Minimum steam out temperature of the top mould vs. number of clicks side b', 'BOTHminMouldSteamOutTopRMSb')
% plot_scatter2(BOTH, 'quiet', 'a', 'minMouldSteamOutTop_F', 'clicks_L', 'clicks_R','Minimum steam out temperature of the top mould vs. number of clicks side a', 'BOTHminMouldSteamOutToCLICKSa')
% plot_scatter2(BOTH, 'quiet', 'b', 'minMouldSteamOutBottom_F', 'clicks_L', 'clicks_R','Minimum steam out temperature of the top mould vs. number of clicks side b', 'BOTHminMouldSteamOutTopCLICKSb')



% plot_scatter2(BOTH, '1kHz', 'a', 'PressingNumber', 'RMS_L', 'RMS_R','Pressing number vs. A-weighted RMS', 'BOTH1kHzRMSa')
% plot_scatter2(BOTH, '1kHz', 'b', 'PressingNumber', 'RMS_L', 'RMS_R','RMS level of reference tone', 'BOTH1kHzRMSb')
% plot_scatter2(BOTH, '1kHz', 'a', 'PressingNumber', 'A_L', 'A_R','A-weighted RMS level of reference tone', 'BOTH1kHzARMSa')
% plot_scatter2(BOTH, '1kHz', 'b', 'PressingNumber', 'A_L', 'A_R','A weighted RMS level of reference tone', 'BOTH1kHzARMSb')

% plot_scatter2(BOTH, 'transition', 'a', 'PressingNumber', 'clicks_L', 'clicks_R','Number of clicks in the transition track', 'BOTHclickstransitiona')
% plot_scatter2(BOTH, 'transition', 'b', 'PressingNumber', 'clicks_L', 'clicks_R','Number of clicks in the transition track', 'BOTHclickstransitionb')

% plot_stereohistogramstats(A0000B0000, 'quiet', 'a', 'A_L', 'A_R', 'A-weighted noise in the quiet track of the first pressing side a', 'A0000B0000quietAhista')
% plot_stereohistogramstats(A0000B0000, 'quiet', 'b', 'A_L', 'A_R', 'A-weighted noise in the quiet track of the first pressing side b', 'A0000B0000quietAhistb')
% plot_stereohistogramstats(A0137B0137, 'quiet', 'a', 'A_L', 'A_R', 'A-weighted noise in the quiet track of the second pressing side a', 'A0137B0137quietAhista')
% plot_stereohistogramstats(A0137B0137, 'quiet', 'b', 'A_L', 'A_R', 'A-weighted noise in the quiet track of the second pressing side b', 'A0137B0137quietAhistb')

% plot_stereohistogramstats(BOTH, 'quiet', 'a', 'A_L', 'A_R', 'A-weighted noise in the quiet track side a', 'BOTHquietAhista')
% plot_stereohistogramstats(BOTH, 'quiet', 'b', 'A_L', 'A_R', 'A-weighted noise in the quiet track side b', 'BOTHquietAhistb')


% plot_stereohistogram(BOTH, 'transition', 'a', 'A_L', 'A_R', 'A-weighted noise in the transition track side a', 'transitionAhista')
% plot_stereohistogram(BOTH, 'transition', 'b', 'A_L', 'A_R', 'A-weighted noise in the transition track side b', 'transitionAhistb')
% plot_barchart2(BOTH, 'transition', 'a', 'A_L', 'A_R','A weighted noise in the transition track side a', '[dB]', 'transitionpressingAa')
% % plot_barchart2(BOTH, 'transition', 'b', 'A_L', 'A_R','A weighted noise in the transition track side b', '[dB]', 'transitionpressingAb')

% plot_scatter2(BOTH, '3150Hz', 'a', 'PressingNumber','wow_L', 'wow_R','Peak to peak wow per record', 'wowa3150')
% plot_scatter2(BOTH, '3150Hz', 'b', 'PressingNumber', 'wow_L', 'wow_R','Peak to peak wow per record', 'wowb3150')
% plot_scatter2(BOTH, '3150Hz', 'a', 'PressingNumber','wow_L', 'wow_R','Peak to peak wow per record', 'wowa3150')
% plot_scatter2(BOTH, '3150Hz', 'b', 'PressingNumber', 'wow_L', 'wow_R','Peak to peak wow per record', 'wowb3150')


% A_L = BOTH{:,'A_L'}./20;
% A_R = BOTH{:,'A_R'}./20;
% A_Labs = 10.^(A_L);
% A_Rabs = 10.^(A_R);

% BOTH(:,'A_Labs') = num2cell(A_Labs);
% BOTH(:,'A_Rabs') = num2cell(A_Rabs);


% % BOTH(:,'A_Labs') = 10.^((BOTH{:,'A_L'}./20));
% % BOTH(:,'A_Rabs') = 10.^((BOTH{:,'A_R'}./20));

% plot_scatter2(BOTH, 'quiet', 'a', 'PressingNumber', 'A_Labs', 'A_Rabs','A-weighted RMS levels per record', 'quietPressingNumberAabsa')
% plot_scatter2(BOTH, 'quiet', 'b', 'PressingNumber', 'A_Labs', 'A_Rabs','A-weighted RMS levels per record', 'quietPressingNumberAabsb')

% plot_scatter2(A0000B0000, 'quiet', 'a', 'PressingNumber', 'A_L', 'A_R','A-weighted RMS levels per record', 'A0000B0000quietPressingNumberARMSa')
% plot_scatter2(A0000B0000, 'quiet', 'b', 'PressingNumber', 'A_L', 'A_R','A-weighted RMS levels per record', 'A0000B0000quietPressingNumberARMSb')

plot_scatter6(A0000B0000, 'quiet', 'quiet2', 'a',  'PressingNumber', 'RMS_L', 'RMS_R', 'Unweighted RMS levels per record side a', 'A0000B0000quiettracksRMSa')
plot_scatter6(A0000B0000, 'quiet', 'quiet2', 'a',  'PressingNumber', 'A_L', 'A_R', 'A weighted RMS levels per record side a', 'A0000B000quiettracksAa')
plot_scatter6(A0000B0000, 'quiet', 'quiet2', 'a',  'PressingNumber', 'CCIR_L', 'CCIR_R', 'CCIR weighted RMS levels per record side a', 'A0000B000quiettracksCCIRa')

plot_scatter6(A0000B0000, 'quiet', 'quiet2', 'b',  'PressingNumber', 'RMS_L', 'RMS_R', 'Unweighted RMS levels per record side b', 'A0000B0000quiettracksRMSb')
plot_scatter6(A0000B0000, 'quiet', 'quiet2', 'b',  'PressingNumber', 'A_L', 'A_R', 'A weighted RMS levels per record side b', 'A0000B000quiettracksAb')
plot_scatter6(A0000B0000, 'quiet', 'quiet2', 'b',  'PressingNumber', 'CCIR_L', 'CCIR_R', 'CCIR weighted RMS levels per record side b', 'A0000B000quiettracksCCIRb')

%~~~~~~~~~~~~~ Plot 
function plot_scatter6(Tbl, trackname1, trackname2, side, x, y1, y2, titlestring, filename)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    Tbl1 = Tbl(strcmp(Tbl.track,trackname1),:);
    Tbl2 = Tbl(strcmp(Tbl.track,trackname2),:);
    % Tbl3 = Tbl(strcmp(Tbl.track,trackname3),:);
    colx = find(ismember(cols, x));
    coly1 = find(ismember(cols, y1));
    coly2 = find(ismember(cols, y2));
    X1 = table2array(Tbl1(:,colx));
    Y1L = table2array(Tbl1(:,coly1));
    Y1R = table2array(Tbl1(:,coly2));
    X2 = table2array(Tbl2(:,colx));
    Y2L = table2array(Tbl2(:,coly1));
    Y2R = table2array(Tbl2(:,coly2));
    % X3 = table2array(Tbl3(:,colx));
    % Y3L = table2array(Tbl3(:,coly1)); 
    % Y3R = table2array(Tbl3(:,coly2));

    % figure(plotnum);  
    fig = figure('Visible', 'off');
    scatter(X1,Y1L,'ko');
    grid on; hold on;
    scatter(X1,Y1R,'kx');
    scatter(X2,Y2L,'bo');
    grid on; hold on;
    scatter(X2,Y2R,'bx');
    % scatter(X3,Y3L,'go');
    % grid on; hold on;
    % scatter(X3,Y3R,'gx');
    legend({'quiet left', 'quiet right', 'quiet2 left', 'quiet2 right'});
    ylim([-58,-38])
    xlim([0,100])
    xlabel('record number')
    ylabel('Level [dB]')
    title(titlestring);
    plotname = strcat('plots/', filename,'.png');
    saveas(fig, plotname);
end




function stats = get_stats(Tbl, trackname, side, column)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx = find(ismember(cols, column));
    X = table2array(Tbl(:,colx));

    stats = datastats(X);

end

function plot_barchart2(Tbl, trackname, side, x1, x2,titlestring, varname, filename)
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


    % figure(plotnum); grid on; hold on;
    fig = figure('Visible', 'off'); grid on; hold on;

    H = bar([X1, X2], 'LineWidth', 2);

    hold on;
    % H = bar(X1, 'LineWidth', 2)
    H(1).FaceColor = [0.6 0.6 0.6];
    % H(2).FaceColor = [.9 .9 .9];
    set(gca,'xticklabel',pressruns)
    ax=gca;
    ax.FontSize=8;
    ax.XTick = (1:length(pressruns))   %THIS WAY, YOU SET HOW MANY XTICKS YOU WANT FOR YOUR XTICKLABELS
    xtickangle(45)
    ylabel(varname)
    title(titlestring)
    plotname = strcat('plots/', filename,'.png');
    saveas(fig, plotname);
end

function plot_barchart(Tbl, trackname, side, x, titlestring, varname, filename)
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


    % figure(plotnum); grid on; hold on;
    fig = figure('Visible', 'off'); grid on; hold on;

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

function plot_histogram(Tbl, trackname, side, x, titlestring, varname, binlims, filename)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx = find(ismember(cols, x));
    X = table2array(Tbl(:,colx));

    % figure(plotnum); grid on; hold on;
    fig = figure('Visible', 'off'); grid on; hold on;

    histogram(X,50,'BinLimits',binlims)

    ylabel('number of records')
    varname
    xlabel(varname)
    title(titlestring)
    plotname = strcat('plots/', filename,'.png');
    saveas(figure(plotnum), plotname)
end


function plot_scatter(Tbl, trackname, side, x, y,titlestring, filename)
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
    plotname = strcat('plots/', filename,'.png');
    saveas(fig, plotname);

end

function plot_scatter2(Tbl, trackname, side, x, y1, y2, titlestring, filename)
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
    plotname = strcat('plots/', filename,'.png');
    saveas(fig, plotname);

end

function plot_scatterraw(X, Y, titlestring, filename)
    fig = figure('Visible', 'off');
    scatter(X,Y,'ko');
    grid on; 
    title(titlestring);
    plotname = strcat('plots/', filename,'.png');
    saveas(fig, plotname);

end

function plot_scatterraw2(X, Y, titlestring, filename)
    fig = figure('Visible', 'off');
    scatter(X,Y,'ko');
    grid on; 
    title(titlestring);
    plotname = strcat('plots/', filename,'.png');
    saveas(fig, plotname);

end



function plot_stereohistogramstats(Tbl, trackname, side, x1, x2, titlestring, filename)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx1 = find(ismember(cols, x1));
    colx2 = find(ismember(cols, x2));
    data_L = table2array(Tbl(:,colx1));
    data_R = table2array(Tbl(:,colx2));


    statsL = datastats(data_L);
    statsR = datastats(data_R);    
    
    % lower_binL = statsL.mean - 10;
    % lower_binR = statsR.mean - 10;
    % upper_binL = statsL.mean + 10;
    % upper_binR = statsR.mean + 10;


    fig = figure('Visible', 'off');
    % histogram(data_L, 50,'BinLimits',[lower_binL,upper_binL], 'facecolor',[0.6 0.6 0.6])
    histogram(data_L, 50, 'facecolor',[0.6 0.6 0.6])
    hold on; grid on;
    histogram(data_R,50, 'facecolor',[0.3 0.3 0.3])
    % histogram(data_R,50,'BinLimits',[lower_binL,upper_binL], 'facecolor',[0.3 0.3 0.3])
    title(titlestring)
    legend('left channel', 'right channel')
    dim = [0.2 0.5 0.3 0.3];
    str = {strcat('left mean :',num2str(statsL.mean)),strcat('left std :',num2str(statsL.std)),strcat('right mean :',num2str(statsR.mean)),strcat('right std :',num2str(statsR.std))};
    annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor', 'white');
    plotname = strcat('plots/',filename,'.png');
    saveas(fig, plotname);
end


function plot_stereohistogram(Tbl, trackname, side, x1, x2, titlestring, filename)
    cols = Tbl.Properties.VariableNames;
    Tbl = Tbl(strcmp(Tbl.track,trackname),:);
    Tbl = Tbl(strcmp(Tbl.side,side),:);
    colx1 = find(ismember(cols, x1));
    colx2 = find(ismember(cols, x2));
    data_L = table2array(Tbl(:,colx1));
    data_R = table2array(Tbl(:,colx2));


    statsL = datastats(data_L);
    statsR = datastats(data_R);    
    
    % lower_binL = statsL.mean - 10;
    % lower_binR = statsR.mean - 10;
    % upper_binL = statsL.mean + 10;
    % upper_binR = statsR.mean + 10;


    fig = figure('Visible', 'off');
    % histogram(data_L, 50,'BinLimits',[lower_binL,upper_binL], 'facecolor',[0.6 0.6 0.6])
    histogram(data_L, 50, 'facecolor',[0.6 0.6 0.6])
    hold on; grid on;
    histogram(data_R,50, 'facecolor',[0.3 0.3 0.3])
    % histogram(data_R,50,'BinLimits',[lower_binL,upper_binL], 'facecolor',[0.3 0.3 0.3])
    title(titlestring)
    legend('left channel', 'right channel')
    % dim = [0.2 0.5 0.3 0.3];
    % str = {strcat('left mean :',num2str(statsL.mean)),strcat('left std :',num2str(statsL.std)),strcat('right mean :',num2str(statsR.mean)),strcat('right std :',num2str(statsR.std))};
    % annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor', 'white');
    plotname = strcat('plots/',filename,'.png');
    saveas(fig, plotname);
end