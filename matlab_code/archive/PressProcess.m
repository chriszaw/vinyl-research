
addpath('E:\audio_files\A0000B0000\')
folder = ('D:\OneDrive - University of Waterloo\Vinyl_Project\data\121918_A0000B0000\');

% addpath('/Users/cz/OneDrive - University of Waterloo/Vinyl_Project/audio_bin/') 
% folder = ('/Users/cz/OneDrive - University of Waterloo/Vinyl_Project/data/121918_A0000B0000/')

clc

date_tags = {'121918', '122018'};

AggTable = [];
recordTable = [];
for i=(1:length(date_tags))
    %#####_SensorValues
    % tracks the data from the sensors in the press via timestamps
    selectedColumns ={'id',
    'RecordTimeStamp',
    'PressPosition_Inches',
    'PressForce_Ton',
    'MouldSteamIn_PSI',
    'MouldSteamIn_F',
    'MouldSteamOutTop_F',
    'MouldSteamOutBottom_F',
    'ExtruderFeedthroatTemp_F',
    'ExtruderBarrelZone1Temp_F',
    'ExtruderBarrelZone2Temp_F',
    'ExtruderBarrelZone3Temp_F',
    'ExtruderDieZoneTemp_F',
    'ExtruderPremouldTemp_F',
    'ExtruderMeltTemp_F'};

    opts = detectImportOptions(strcat(folder,date_tags{i},'_SensorValues.csv'));
    getvaropts(opts,selectedColumns);
    opts = setvartype(opts,selectedColumns,'string');
    opts.SelectedVariableNames = selectedColumns;
    
    if i == 1
        SensorValues = readtable(strcat(folder,date_tags{i},'_SensorValues.csv'),opts);
    else
        SensorValues = [SensorValues; readtable(strcat(folder,date_tags{i},'_SensorValues.csv'),opts)];
    end
    % disp(strcat('SensorValues',num2str(height(SensorValues))))

    %#####_JobDetailsCurrent
    % tracks cycle times

    if i == 1
        JobDetails = readtable(strcat(folder,date_tags{i},'_JobDetailsCurrent.csv'));
    else
        JobDetails = [JobDetails; readtable(strcat(folder, date_tags{i},'_JobDetailsCurrent.csv'))];
    end
    % disp(strcat('JobDetails',num2str(height(JobDetails))))

    %#####_ADAPT_DATA
    % tracks the press options changes via timestamps
    if i == 1
        ADAPT = readtable(strcat(folder, date_tags{i}, '_CZA0000B0000_ADAPT_DATA.xlsx'));
    else
        ADAPT = [ADAPT; readtable(strcat(folder,date_tags{i},'_CZA0000B0000_ADAPT_DATA.xlsx'))];
    end
    % disp(strcat('ADAPT',num2str(height(ADAPT))))


end

SensorValues.PressPosition_Inches = str2double(SensorValues.PressPosition_Inches);
SensorValues.PressForce_Ton = str2double(SensorValues.PressForce_Ton);
SensorValues.MouldSteamIn_F = str2double(SensorValues.MouldSteamIn_F);
SensorValues.MouldSteamOutTop_F = str2double(SensorValues.MouldSteamOutTop_F);
SensorValues.MouldSteamOutBottom_F = str2double(SensorValues.MouldSteamOutBottom_F);
SensorValues.ExtruderFeedthroatTemp_F = str2double(SensorValues.ExtruderFeedthroatTemp_F);
SensorValues.ExtruderBarrelZone1Temp_F = str2double(SensorValues.ExtruderBarrelZone1Temp_F);
SensorValues.ExtruderBarrelZone2Temp_F = str2double(SensorValues.ExtruderBarrelZone2Temp_F);
SensorValues.ExtruderBarrelZone3Temp_F = str2double(SensorValues.ExtruderBarrelZone3Temp_F);
SensorValues.ExtruderDieZoneTemp_F = str2double(SensorValues.ExtruderDieZoneTemp_F);
% SensorValues.ExtruderFeedthroatTemp_F = str2double(SensorValues.ExtruderFeedthroatTemp_F);
SensorValues.ExtruderPremouldTemp_F = str2double(SensorValues.ExtruderPremouldTemp_F);
SensorValues.ExtruderMeltTemp_F = str2double(SensorValues.ExtruderMeltTemp_F);


%#####_TimeStamps
% Recorded by hand timestamps

TimeStamps = readtable(strcat(folder,'121918_TimeStamps.xlsx'));
SensorValues.RecordTimeStamp = datetime(SensorValues.RecordTimeStamp, 'InputFormat', 'yyyy-MM-dd HH:mm');
TimeStamps.TimeStamp = datetime(TimeStamps.TimeStamp, 'InputFormat', 'MMMM d, yyyy hh:mm:ss');

for i = (1:length(TimeStamps.TimeStamp))
    %% convert all the necessary columns to numbers
    [closestTimeStamp,closestIndex] = min(abs(SensorValues.RecordTimeStamp(i:length(SensorValues.RecordTimeStamp))-TimeStamps.TimeStamp(i)));
    if isnan(closestTimeStamp)
        continue
    end
    disp(strcat('****',string(SensorValues.RecordTimeStamp(closestIndex)),'.....',string(TimeStamps.TimeStamp(i)),'****'))

        % find the max or min PressForce in a nearby area, 
    %write needed values to table  
    preclosestIndex = closestIndex;
    disp(strcat('pre closestIndex:    ', num2str(closestIndex)))
    disp(strcat('pre position:  ', num2str(SensorValues.PressPosition_Inches(closestIndex))))

    if SensorValues.PressPosition_Inches(closestIndex) < 1
        % disp('Press open') 
        % if press is open then find the first value where the press is closed
        for k = (1:10)
            pl = SensorValues.PressPosition_Inches(closestIndex - k);
            pr = SensorValues.PressPosition_Inches(closestIndex + k);
            
            if pl > 1
                closestIndex = closestIndex - k;
                % disp('index fixed') 
                % closestIndex
                % SensorValues.PressPosition_Inches(closestIndex)
                % disp(strcat('post closestIndex:    ', num2str(closestIndex)))
                % disp(strcat('post position:  ', num2str(SensorValues.PressPosition_Inches(closestIndex))))
            
                break
            end
            if pr > 1
                closestIndex = closestIndex + k;
                % disp('index fixed') 
                % closestIndex
                % SensorValues.PressPosition_Inches(closestIndex)
                % disp(strcat('post closestIndex:    ', num2str(closestIndex)))
                % disp(strcat('post position:  ', num2str(SensorValues.PressPosition_Inches(closestIndex))))
            
                break
            end
        end
    end 
    %~~closestIndex points to a position where the press was closed~~%
    disp(strcat('post closestIndex:    ', num2str(closestIndex)))
    disp(strcat('post position:  ', num2str(SensorValues.PressPosition_Inches(closestIndex))))

    open = false;
    close = false;
    lower = false;
    upper = false;

    % for k = (1:30)
    %     if abs(SensorValues.PressPosition_Inches(closestIndex + k + 1) - SensorValues.PressPosition_Inches(closestIndex - k)) > 1
    %         if open == false 
    %             disp('press open set')
    %             press_open = closestIndex + k;
    %             open = true;
    %         elseif lower == false;
    %             disp('lower bound set')
    %             lower_bound = press_open + k;
    %             lower = true;
    %         end
    %     end
    % end
    % for k = (1:30)
    %     if abs(SensorValues.PressPosition_Inches(closestIndex - k - 1) - SensorValues.PressPosition_Inches(closestIndex - k)) > 1
    %         if close == false 
    %             disp('press close set')
    %             press_close = closestIndex + k;
    %             close = true;
    %         elseif upper == false;
    %             disp('upper bound set')
    %             upper_bound = press_open + k;
    %             upper = true;
    %             break
    %         end
    %     end
    % end

        % pl = SensorValues.PressPosition_Inches(closestIndex - k);
        % pu = SensorValues.PressPosition_Inches(closestIndex + k);
        
        % if pl > 1 && lower == true 
        %     lower_bound = closestIndex + k;
        %     % disp(strcat('lower bound:    ', num2str(lower_bound)))
        %     % disp(strcat('lower position:  ', num2str(SensorValues.PressPosition_Inches(lower_bound))))
        % elseif pl < 1 && lower == false 
        %     lower = true;
        %     press_open = closestIndex + k;
        %     % disp(strcat('press open:    ', num2str(closestIndex)))
        %     % disp(strcat('open position:  ', num2str(SensorValues.PressPosition_Inches(closestIndex))))
        % elseif pu > 1 && upper == true
        %     upper_bound = closestIndex - k;
        %     % disp(strcat('upper bound:    ', num2str(closestIndex)))
        %     % disp(strcat('upper position:  ', num2str(SensorValues.PressPosition_Inches(closestIndex))))
        % elseif pu < 1 && upper == false;
        %     press_open = closestIndex - k;
        %     % disp(strcat('press close:    ', num2str(closestIndex)))
        %     % disp(strcat('close position:  ', num2str(SensorValues.PressPosition_Inches(closestIndex))))
        % end
    % end
    % lower = false;
    % upper = false;

   % look backwards in time to find when the press was last open
    
%%~~~~ BROKEN INDIVIDUAL FOR LOOPS~~~~~~~~% 
    % j = closestIndex;
    % SensorValues.PressPosition_Inches(j);

    %~~~~ PRESS CLOSE ~~~~%
    for j = (closestIndex:-1:closestIndex - 10)
        % SensorValues.PressPosition_Inches(j)
        if SensorValues.PressPosition_Inches(j) < 1
            % disp('found press close')
            press_close = j + 1;
            % disp(strcat('index:    ', num2str(press_close),'   position:  ', num2str(SensorValues.PressPosition_Inches(press_close))))
            % disp(strcat('j:  ', press_close))
            break 
            if j == closestIndex - 9
                % disp('concat press close')
                press_close = j + 1;
            end    
        end
    end
    % disp(strcat('press_close:  ', num2str(press_close)))


    %~~~~ LOWER BOUND ~~~~%
    lower_bound = 0;
    for j = (press_close-1:-1:press_close - 11)
        % j
        if SensorValues.PressPosition_Inches(j) > 1
            % disp('found lower bound')
            % disp(strcat('lower bound:  ', num2str(lower_bound)))
            lower_bound = j + 1;
            disp(strcat('index:    ', num2str(lower_bound),'   position:  ', num2str(SensorValues.PressPosition_Inches(lower_bound))))
            break 
        end
        if j == press_close - 11
            % disp('concat lower bound')
            lower_bound = j + 1;
            break
        end
    end


    % disp('finished lower bound loop')

    %~~~~ PRESS OPEN ~~~~%
    for j = (closestIndex:closestIndex + 10)
        % closestIndex - j
        % SensorValues.PressPosition_Inches(closestIndex - j)
        if SensorValues.PressPosition_Inches(j) < 1
            % disp('found press open')
            press_open = j;
            % disp(strcat('index:    ', num2str(press_open),'   position:  ', num2str(SensorValues.PressPosition_Inches(press_open))))
            break 
        if j == closestIndex + 9
            % disp('concat press_open')
            press_open = j;
        end
    
        end
    end

    %~~~~ UPPER BOUND ~~~~%
    for j = (press_open + 1:press_open + 10)
        if SensorValues.PressPosition_Inches(j) > 1
            % disp('found = upper bound')
            upper_bound = j;
            % disp(strcat('index:    ', num2str(upper_bound),'   position:  ', num2str(SensorValues.PressPosition_Inches(upper_bound))))
            break 
            if j == press_open + 9
                % disp('concat upper bound')
                upper_bound = j
            end    
        end
    end


    length(recordTable)
    if length(recordTable) > 1 && press_close == recordTable( length(recordTable)-1 , 2 ); 
        disp('DUPLICATE FOUND')
        continue
        % [closestTimeStamp,closestIndex] = min(abs(SensorValues.RecordTimeStamp-TimeStamps.TimeStamp(i)));
    end


    % disp(strcat('lower bound:    ', num2str(lower_bound)))
    % disp(strcat('press close:    ', num2str(press_close)))
    % disp(strcat('press open:    ', num2str(press_open)))
    % disp(strcat('upper bound:    ', num2str(upper_bound)))



    % while str2double(SensorValues.PressPosition_Inches(j)) > 1 && j > (closestIndex + 10) 
        % disp('while loop 1')
        % j = j - 1;
    % end
    % press_close = j + 1; %this represents the table index when the press was closed

    %look backwards to find when the press 
    % while str2double(SensorValues.PressPosition_Inches(j)) < 1 && j > closestIndex + 10
    %     disp('while loop 2')
    %     j = j - 1;
    % end
    % lower_bound = j + 1; %

    % % look forwards in time to find the next time the press closes
    % j = closestIndex;
    
    % while str2double(SensorValues.PressPosition_Inches(j)) > 1 && j < closestIndex + 10
    %     disp('while loop 3')
    %     j = j + 1;
    % end
    
    % press_open = j - 1; 

    % try  
    %     while str2double(SensorValues.PressPosition_Inches(j)) < 1 && j < closestIndex + 10
    %         disp('while loop 4')           
    %         j = j + 1;
    %     end
    % catch 
    %     disp('END OF FILE')
    % end
    
    % upper_bound = j - 1;

    % pull the necessary adapt settings

    % perform all the needed measurements 
    % SensorValues(lower_bound:upper_bound)

    %% record number and record ID will be different because of Junk records 
    % determine from the time stamps when the nearest record 
    % lower_bound
    % upper_bound
    % upper_bound - lower_bound

    % for k = (lower_bound:upper_bound)
    %     if k == lower_bound
    %         disp('lower_bound')
    %     end
    %     if k == press_close
    %         disp('press_close')
    %     end
    %     if k == press_open
    %         disp('press_open')
    %     end
    %     if k == upper_bound
    %         disp('upper_bound')
    %     end
    %     if k == closestIndex
    %         disp('closestIndex')
    %     end
    %     disp(num2str(SensorValues.PressPosition_Inches(k)))
    %     end

    % SensorValues.PressPosition_Inches(press_close:press_open)
    recordTable = [recordTable; lower_bound, press_close, press_open, upper_bound];
end
recordTable
length(recordTable)
% ADAPT
% JobDetails
% TimeStamps
% SensorValues
% get the hand recorded timestamp
% identify a pressing cycle by press position (one open and close)
% -> need to keep in mind times when parameter's changed 

% RECORDID is added by this code 
