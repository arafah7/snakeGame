function self_collision_test()
    % Declare all variables as global to ensure they are shared between functions
    global snakeHead snakeDirection snakeBody snakeLength isGameOver;

    % Initialize the game state
    initializeGameState();

    % Simulate snake moving to cause self-collision
    % Move left into its own body
    for i = 1:3 % Move left enough times to collide with itself
        play();
    end

    % Test to check if the game is over after self-collision
    assert(isGameOver, 'The game should end when the snake collides with itself.');
    disp('Self-collision test passed.');
end

function initializeGameState()
    % Initialize the global variables for the test
    global snakeHead snakeDirection snakeBody snakeLength isGameOver;

    % Set initial game state where the snake is about to collide with itself
    snakeHead = [5, 5];  % Initial position of the snake's head
    snakeDirection = [0, -1]; % Moving left towards its own body
    snakeBody = [5, 5; 5, 4; 5, 3; 4, 3; 4, 4; 4, 5]; % Snake body arranged in a square
    snakeLength = 6;
    isGameOver = false; % Initial game state is not over
end

function play()
    % Declare the variables as global to maintain their state
    global snakeHead snakeBody snakeDirection snakeLength isGameOver;

    % Simulate snake movement by updating the head and body positions
    snakeHead = snakeHead + snakeDirection;
    snakeBody = [snakeHead; snakeBody];
    
    % Keep the snake length consistent
    while length(snakeBody) > snakeLength
        snakeBody(end, :) = [];
    end

    % Check for self-collision
    if any(ismember(snakeBody(2:end, :), snakeHead, 'rows'))
        isGameOver = true; % Mark game as over
        return; % Stop further processing
    end
end