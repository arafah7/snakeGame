% so this is the main function on which the game will run

function snakeGame
    % so this is the game axis which will be equal
    axis equal;
    axis(0.5 + [0, 20, 0, 20]);
    %we have removed the x and y marks from the axis and made it into a box
    set(gca, 'xtick', [], 'ytick', []);
    box(gca, 'on');
    set(gcf, 'MenuBar', 'none');  
    set(gcf, 'Name', 'Snake Game Made By Arafah', 'NumberTitle', 'off');  

    % Now we will take user input for the name of the snake 

    gameTitle = inputdlg('Name your snake:', 'Game title', [1, 25]);
    title(gca, gameTitle{1});
    %Warning message box to warn the user not to select black and white 
    %As black and white is the colour of snake and the coin
    uiwait(msgbox('Please do not select black or white as the background color. Best of luck', 'Color Selection Warning', 'warn'));
    % The background color on which they want to play and their mode 
    bgColor = uisetcolor('Select the background color');
    set(gca, 'color', bgColor);
    %Asking about the mode they want to play in
    gameMode = questdlg('Choose game mode', 'Game Mode', 'With border', 'Without border', 'With border');
    % Asking user about the speed in which they want to play
    fps = str2double(inputdlg('Enter the snake speed from 1 to 10', 'Snake speed', [1, 50]));
    % if the speed is not a number or it is not between 1 and 10, we ask 
    % the user again for the speed
    while isnan(fps) || fps < 1 || fps > 10
        fps = str2double(inputdlg('Enter the snake speed from 1 to 10', 'Snake speed', [1, 50]));
    end

    % Fixing the mode according to the input of the user 
    if strcmp(gameMode, 'With border')
        borderMode = 'With';
    elseif strcmp(gameMode, 'Without border')
        borderMode = 'Without';
    end

    hold on;
   
    % Initializing the snake and coin vector 
 
    
    snakeHead = [10, 10];
     snakeDirection = [0, 1];
   
    % Fixing the initial position and length for the snake and coin
    snakeBody = [10, 10; 9, 10; 8, 10];
    snakeLength = 3;
    coin = [15, 10];

    % Plotting the snake and coin on the current axis 
    plotSnake = scatter(gca, snakeBody(:, 1), snakeBody(:, 2), 250, 'ks', 'filled');
    plotCoin = scatter(gca, coin(1), coin(2), 150, 'w', 'filled');

    % Initializing score and timer which we will display live in the window 
    score = 0;
    tic;
    timeText = uicontrol('Style', 'text', 'String', 'Time: 0', 'Position', [19, 40, 100, 20]);
    scoreText = uicontrol('Style', 'text', 'String', ['Score: ', num2str(score)], 'Position', [19, 60, 100, 20]);

   
    %Initializing the sound which will be played when 
    %Game gets over and  
    % Snake collides with coin
    [eatSound, eatFs] = audioread('eat_sound.mp3');  
    eatPlayer = audioplayer(eatSound, eatFs);

    [gameOverSound, gameOverFs] = audioread('game_over_sound.wav'); 
    gameOverPlayer = audioplayer(gameOverSound, gameOverFs);

    set(gcf, 'KeyPressFcn', @key);

    specialCoinTimer = [];
    specialCoinEaten = false;

    % Game loop timer
    game = timer('ExecutionMode', 'fixedRate', 'Period', max(1/fps, 0.001), 'TimerFcn', @play);
    start(game);

    % The main play function of the game 
    function play(~, ~)
        
        % Setting the movement of the snake 
        snakeHead = snakeHead + snakeDirection;
        snakeBody = [snakeHead; snakeBody];
        % Removing the last block of the snake as a head has been added
        while length(snakeBody) > snakeLength
            snakeBody(end, :) = [];
        end

        % Checking for collision with the snake head and its body
        if any(ismember(snakeBody(2:end, :), snakeHead, 'rows'))
            gameOver();
            return;
        end

        % Checking for collision with the coin of the snake 
        if isequal(snakeHead, coin)
            snakeLength = snakeLength + 1;
            sound(eatSound, eatFs); % Play the eat sound effect
            if specialCoinEaten
                score = score + 15;
                specialCoinEaten = false;
                removeSpecialCoin();
            else
                score = score + 1;
            end
            % Updating the score if the snake and coin clash
            set(scoreText, 'String', ['Score: ', num2str(score)]);
            %create special coins at intervals of 6 coins
            coin = randi(20, [1, 2]);
            if mod(score, 6) == 0 && ~specialCoinEaten
                createSpecialCoin();
            end
        end

        % Handle the  border modes
        if strcmp(borderMode, 'With')
            if any(snakeHead < 1) || any(snakeHead > 20)
                gameOver();
                return;
            end
            % pass through the boundary if mode is without
        elseif strcmp(borderMode, 'Without')
            if snakeHead(1) > 20, snakeHead(1) = 1; end
            if snakeHead(1) < 1, snakeHead(1) = 20; end
            if snakeHead(2) > 20, snakeHead(2) = 1; end
            if snakeHead(2) < 1, snakeHead(2) = 20; end
        end

        % Update the plot
        set(plotCoin, 'XData', coin(1), 'YData', coin(2));
        set(plotSnake, 'XData', snakeBody(:, 1), 'YData', snakeBody(:, 2));

        % Update the time
        elapsedTime = toc;
        set(timeText, 'String', ['Time: ', num2str(floor(elapsedTime))]);
    end

   


    % Function to create special coin
    function createSpecialCoin()
        specialCoinPosition = randi(20, [1, 2]);
        set(plotCoin, 'XData', specialCoinPosition(1), 'YData', specialCoinPosition(2), 'SizeData', 250, 'Marker', 'd', 'MarkerFaceColor', 'w');
        specialCoinEaten = true;

        specialCoinTimer = timer('StartDelay', 10, 'TimerFcn', @removeSpecialCoin);
        start(specialCoinTimer);
    end

    % Function to remove special coin
    function removeSpecialCoin(~, ~)
        %generate and plot a normal coin after special coin gets eaten
        specialCoinEaten = false;
        set(plotCoin, 'SizeData', 150, 'Marker', 'o', 'MarkerFaceColor', 'w');
        coin = randi(20, [1, 2]);
        set(plotCoin, 'XData', coin(1), 'YData', coin(2));
        if isvalid(specialCoinTimer), stop(specialCoinTimer); delete(specialCoinTimer); end
    end

    % Handle game over
    function gameOver()
        % Get the final score
        finalScore = score;
        % Stop the game timer
        stop(game)

        sound(gameOverSound, gameOverFs); % Play game over sound
        % Display a message dialog with the final score
        hMsgBox = msgbox(['Game over! You scored ', num2str(finalScore)], 'Game Over');

        % Waiting  for the user to press OK in the message box
        uiwait(hMsgBox);

        % Open a new figure window for the image
        figure('Name', 'Snake Game Facts', 'NumberTitle', 'off'); 
        imshow('10facts.png'); % Show the image file

        % Close the game window
        close(findobj('Type', 'figure', 'Name', 'Snake Game Made By Arafah')); 
    end

    % Key press function for controlling the movement of the snake 
    function key(~, event)
        switch event.Key
            case 'uparrow', newDirection = [0, 1];
            case 'downarrow', newDirection = [0, -1];
            case 'leftarrow', newDirection = [-1, 0];
            case 'rightarrow', newDirection = [1, 0];
            case 'space'
                if strcmp(get(game, 'Running'), 'on')
                    stop(game);
                    ButtonName = questdlg('Pause... Do you want to continue?', 'Pause', 'Continue', 'Close', 'Continue');
                    if strcmp(ButtonName, 'Restart')
                        clf;
                        snakeGame();
                    elseif strcmp(ButtonName, 'Close')
                        close;
                    else
                        start(game);
                    end
                end
                return;
            otherwise
                return;
        end

        % Update snake direction only if the new direction is not directly opposite
        if ~isequal(newDirection, -snakeDirection)
            snakeDirection = newDirection;
        end
    end
end
