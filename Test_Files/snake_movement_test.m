function snake_movement_test()
    % Declare all variables as global to ensure they are shared between functions
    global snakeHead snakeDirection snakeBody snakeLength;
    
    % Initialize the initial state
    initializeGameState();
    
    % Simulate the snake's movement in the right direction
    simulateMove(); % First move to the right
    expectedHeadPosition = [6, 5]; % Expected position after one move to the right
    assert(isequal(snakeHead, expectedHeadPosition), 'Snake head should move to [6, 5].');

    expectedBodyPosition = [6, 5; 5, 5; 4, 5]; % Expected body positions after one move
    assert(isequal(snakeBody, expectedBodyPosition), 'Snake body should update correctly after one move.');
    
    % Simulate another move
    simulateMove(); % Second move to the right
    expectedHeadPosition = [7, 5]; % Expected position after the second move to the right
    assert(isequal(snakeHead, expectedHeadPosition), 'Snake head should move to [7, 5].');

    expectedBodyPosition = [7, 5; 6, 5; 5, 5]; % Expected body positions after the second move
    assert(isequal(snakeBody, expectedBodyPosition), 'Snake body should update correctly after the second move.');

    disp('snake movement test passed.');
end

function initializeGameState()
    % Initialize the global variables for the test
    global snakeHead snakeDirection snakeBody snakeLength;

    % Set initial game state where the snake is moving right
    snakeHead = [5, 5];  % Initial position of the snake's head
    snakeDirection = [1, 0]; % Moving right
    snakeBody = [5, 5; 4, 5; 3, 5];
    snakeLength = 3;
end

function simulateMove()
    % Declare the variables as global to maintain their state
    global snakeHead snakeBody snakeDirection snakeLength;

    % Simulate snake movement by updating the head and body positions
    snakeHead = snakeHead + snakeDirection;
    snakeBody = [snakeHead; snakeBody];
    
    % Keep the snake length consistent
    while length(snakeBody) > snakeLength
        snakeBody(end, :) = [];
    end
end
