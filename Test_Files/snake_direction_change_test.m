function snake_direction_change_test()
    % Declare all variables as global to ensure they are shared between functions
    global snakeDirection;
    
    % Initialize the initial direction
    snakeDirection = [1, 0]; % Initially moving right

    % Simulate key presses to change direction
    simulateKeyPress('downarrow'); % Should change to [0, -1] (down)
    assert(isequal(snakeDirection, [0, -1]), 'Snake direction should change to down.');

    simulateKeyPress('leftarrow'); % Should change to [-1, 0] (left)
    assert(isequal(snakeDirection, [-1, 0]), 'Snake direction should change to left.');

    simulateKeyPress('uparrow'); % Should change to [0, 1] (up)
    assert(isequal(snakeDirection, [0, 1]), 'Snake direction should change to up.');

    simulateKeyPress('rightarrow'); % Should change to [1, 0] (right)
    assert(isequal(snakeDirection, [1, 0]), 'Snake direction should change to right.');

    % Test for an invalid direction change: moving right and then attempting to move left
    simulateKeyPress('leftarrow'); % Invalid change, should remain [1, 0]
    assert(isequal(snakeDirection, [1, 0]), 'Snake direction should stay right when attempting to move left.');

    disp(' Snake Direction change test passed.');
end

function simulateKeyPress(key)
    % Declare snakeDirection as global to change it within this function
    global snakeDirection;
    
    % Define the new direction based on the key press
    switch key
        case 'uparrow'
            newDirection = [0, 1];
        case 'downarrow'
            newDirection = [0, -1];
        case 'leftarrow'
            newDirection = [-1, 0];
        case 'rightarrow'
            newDirection = [1, 0];
        otherwise
            return; % Do nothing if an unexpected key is passed
    end

    % Update snake direction only if the new direction is not directly opposite
    if ~isequal(newDirection, -snakeDirection)
        snakeDirection = newDirection;
    end
end
