function food_collision_test()
    % Declare all variables as global to ensure they are shared between functions
    global snakeHead snakeDirection snakeBody snakeLength food score specialFoodEaten;

    % Initialize the game state
    initializeGameState();

    % Simulate snake moving towards the food
    for i = 1:2 % Two steps are enough to reach the food
        play();
    end

    % Test to check if the snake length increased after eating food
    assert(snakeLength == 4, 'The snake length should increase by 1 after eating food.');
    disp('Food collision test passed.');
end

function initializeGameState()
    % Initialize the global variables for the test
    global snakeHead snakeDirection snakeBody snakeLength food specialFoodEaten score;

    % Set initial game state where the snake is close to the food
    snakeHead = [5, 5];  % Initial position of the snake's head
    snakeDirection = [1, 0]; % Moving right towards the food
    snakeBody = [5, 5; 4, 5; 3, 5];
    snakeLength = 3;
    food = [6, 5]; % Place food in the snake's path
    specialFoodEaten = false;
    score = 0; % Initial score
end

function play()
    % Declare the variables as global to maintain their state
    global snakeHead snakeBody snakeDirection snakeLength food specialFoodEaten score;

    % Simulate snake movement by updating the head and body positions
    snakeHead = snakeHead + snakeDirection;
    snakeBody = [snakeHead; snakeBody];
    
    % Keep the snake length consistent
    while length(snakeBody) > snakeLength
        snakeBody(end, :) = [];
    end

    % Check for collision with food
    if isequal(snakeHead, food)
        snakeLength = snakeLength + 1; % Increase snake length after eating food
        score = score + 1; % Increase score
        food = randi(20, [1, 2]); % Generate new food position
    end
end
