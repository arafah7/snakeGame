%This is the game background  on which the game will be played 
    %This should produce a nice background with a box 
    % Coordinates will go on from 0 - 20 in x and y axis 
    % The x and y coordinates will not be shown 
    axis equal;
    axis(0.5 + [0, 20, 0, 20]);
    set(gca, 'xtick', [], 'ytick', []);
    box(gca, 'on');

      %creates a simple user interface (UI) 
    % for customizing the title and background color 
    % it produces a input dialogue called game title and
    %asks to name the snake 
    %the input is then set as the title in current axis 
    %similarly it opens another color selecting dialogue box 
    %and asks user to select and then sets the selected color 
    %as the background of the current axis 
    gameTitle = inputdlg('Name your snake:', 'Game title', [1, 50]);
    title(gca, gameTitle{1});
    bgColor = uisetcolor('Select background color');
    set(gca, 'color', bgColor);

       % this opens a question dialogue and asks user to select the mode 
    % the two options are  with border and without border
    gameMode = questdlg('Choose game mode', 'Game Mode', 'With border', 'Without border','With border');
    %Asking user about the speed in which they want to play
    %Storing the numeric input  in fps which we will use to fix the game
    %speed
    fps = str2double(inputdlg('Enter the snake speed from 1 to 10', 'Snake speed', [1, 50]));
    %if the input for speed  is not a number or it is not between 1 and 10 ,we ask 
    %the user again for the speed
    while isnan(fps) || fps < 1 || fps > 10
        fps = str2double(inputdlg('Enter the snake speed from 1 to 10', 'Snake speed', [1, 50]));
    end
    % Fixing the mode according to the input of the user 
    if strcmp(gameMode, 'With border')
        borderMode = 'With';
    elseif strcmp(gameMode, 'Without border')
        borderMode = 'Without';
    end