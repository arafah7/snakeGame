function wall_Collision_test()
    % Declare all variables as global to ensure they are shared between functions
    global snakeHead snakeDirection snakeBody snakeLength food plotSnake plotFood scoreText timeText specialFoodEaten borderMode gameOverFlag;
    
    % Initialize the game state
    initializeGameState();

    % Simulate the game step to make the snake collide with the wall
    play();

    % Check if the game ends after collision with the wall
    assert(gameOverFlag, 'The game should end when the snake collides with the wall.');

    disp('Wall collision test passed.');
end

function initializeGameState()
    % Initialize the global variables for the test
    global snakeHead snakeDirection snakeBody snakeLength food plotSnake plotFood scoreText timeText specialFoodEaten borderMode gameOverFlag;
    
    % Set initial game state where the snake will collide with the wall
    snakeHead = [1, 1];  % Snake's head is at the edge of the grid
    snakeDirection = [-1, 0]; % Moving left towards the wall
    snakeBody = [1, 1; 2, 1; 3, 1];
    snakeLength = 3;
    food = [15, 10];
    
    % Initialize variables that might be used in play()
    plotSnake = []; % Dummy value; replace with actual plot if needed
    plotFood = [];
    scoreText = [];
    timeText = [];
    specialFoodEaten = false;
    borderMode = 'With'; % Game should end when the snake hits the border
    gameOverFlag = false; % Initialize the game-over flag as false
    
    % You can also initialize plot-related variables if necessary
end

function play(~, ~)
    % Declare the variables as global to maintain their state
    global snakeHead snakeBody snakeDirection snakeLength food plotSnake plotFood scoreText timeText specialFoodEaten borderMode gameOverFlag;

    % Simulate snake movement by updating the head and body positions
    snakeHead = snakeHead + snakeDirection;
    snakeBody = [snakeHead; snakeBody];
    
    % Keep the snake length consistent
    while length(snakeBody) > snakeLength
        snakeBody(end, :) = [];
    end

    % Handle border collision check
    if strcmp(borderMode, 'With')
        if any(snakeHead < 1) || any(snakeHead > 20)
            gameOver();
            return;
        end
    end

    % Additional logic from your original play function...
end

function gameOver()
    % Declare the game-over flag as global
    global gameOverFlag;
    
    % Set the flag to true to indicate game over
    gameOverFlag = true;
end
