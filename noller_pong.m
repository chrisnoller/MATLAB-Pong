function PongGame()
    % Create court figure, make title, set axis, draw middle dotted line and
    % top/bottom lines, turn axis off
    court = figure;
    set(court, 'Color', 'black', 'toolbar', 'none', 'menubar', 'none');
    title('ENGR 122 PONG', 'FontSize', 18, 'Color', 'w');
    axis([0 14 0 12]);
    line([7 7],[0 12],'LineStyle',':','LineWidth',1,'Color','yellow');
    line([0 14], [12 12], 'LineStyle', '-', 'LineWidth', 3, 'Color', 'yellow');
    line([0 14], [0 0], 'LineStyle', '-', 'LineWidth', 3, 'Color', 'yellow');
    axis off

    % Initialize inputs for left and right paddle
    left_input = 0;
    right_input = 0;

    % Initialize ball on court, randomize placement of y position of ball,
    % and initialize direction of ball
    hold on
    ball_x = 7;
    ball_y = randi([2 10]);
    ball_xdirection = 1;
    ball_ydirection = 1;
    ball = plot(ball_x, ball_y, 'w.', 'MarkerSize', 15);

    % Initialize paddles on court, set speed
    left_bottom = 5;
    left_height = 2;
    right_bottom = 5;
    right_height = 2;
    left_paddle = line([1 1], [left_bottom (left_bottom + left_height)], 'LineWidth', 5, 'Color', 'blue');
    right_paddle = line([13 13], [right_bottom (right_bottom + right_height)], 'LineWidth', 5, 'Color', 'red');

    % Initialize score on screen
    left_score = 0;
    right_score = 0;
    draw_left_score = text(2, 10, num2str(left_score), 'FontSize', 25, 'Color', 'yellow');
    draw_right_score = text(12, 10, num2str(right_score), 'FontSize', 25, 'Color', 'yellow');

    % While neither player has scored 10 points yet
    while (left_score < 3 || right_score < 3)
        % Use while loop for each "round", then reset after a player scores
        while 1
            % Update left and right paddle values
            left_bottom = updateLeft(left_input, left_bottom);
            right_bottom = updateRight(right_input, right_bottom);

            % Update ball x and y values
            ball_x = updateBallXPosition(ball_x, ball_xdirection);
            ball_y = updateBallYPosition(ball_y, ball_ydirection);

            % If the right paddle hits the ball, change the direction of the
            % ball, if not add 1 point to left paddle player and reset
            if (ball_x > 13)
                if (ball_y > right_bottom && ball_y < (right_bottom + right_height))
                    ball_xdirection = ball_xdirection * -1;
                else
                    left_score = left_score + 1
                    break;
                end
            end

            % If the left paddle hits the ball, change the direction of the
            % ball, if not add 1 point to right paddle player and reset
            if (ball_x < 1)
                if (ball_y > left_bottom && ball_y < (left_bottom + left_height))
                    ball_xdirection = ball_xdirection * -1;
                else
                    right_score = right_score + 1;
                    break;
                end
            end
            
            % If the ball hits the top or bottom of the court, change the
            % direction of the ball
            if (ball_y < 0.25)
                ball_ydirection = ball_ydirection * -1;
            end
            if (ball_y > 11.75)
                ball_ydirection = ball_ydirection * -1;
            end

            % Set Key listeners to figure
            set(court, 'KeyPressFcn', @keyDown, 'KeyReleaseFcn', @keyUp);

            % Update left and right paddle positions on figure
            set(left_paddle, 'YData', [left_bottom (left_bottom + left_height)]);
            set(right_paddle, 'YData', [right_bottom (right_bottom + right_height)]);
            set(ball, 'XData', [ball_x]);
            set(ball, 'YData', [ball_y]);

            % Allow drawings to render
            pause(0.01)
        end
        
        % Update scores, reset ball, allow for 3 second pause
        set(draw_left_score, 'String', num2str(left_score));
        set(draw_right_score, 'String', num2str(right_score));
        ball_x = 7;
        ball_y = randi([2 10]);
        pause(3)  
    end

    % Function listening for keys being pressed to control paddles
    function keyDown(source, event)
        if event.Key == 'q'
            left_input = 1;
        end
        if event.Key == 'a'
            left_input = -1;
        end
        if event.Key == 'o'
            right_input = 1;
        end
        if event.Key == 'l'
            right_input = -1;
        end
    end

    % Function listening for keys being released to let go of paddles
    function keyUp(source, event)
        if event.Key == 'q'
            left_input = 0;
        end
        if event.Key == 'a'
            left_input = 0;
        end
        if event.Key == 'o'
            right_input = 0;
        end
        if event.Key == 'l'
            right_input = 0;
        end   
    end

    % Function updating left paddle
    function left_bottom = updateLeft(left_input, left_bottom)
        if (left_input == 1) && ((left_bottom + left_height) < 12)
            left_bottom = left_bottom + .05;
        elseif (left_input == -1) && (left_bottom > 0)
            left_bottom = left_bottom - .05;
        end
    end

    % Function updating right paddle
    function right_bottom = updateRight(right_input, right_bottom)
        if (right_input == 1) && ((right_bottom + right_height) < 12)
            right_bottom = right_bottom + .05;
        elseif (right_input == -1) && (right_bottom > 0)
            right_bottom = right_bottom - .05;
        end
    end
    
    % Function updating x position of ball
    function ball_x = updateBallXPosition(ball_x, ball_xdirection)
        ball_x = ball_x + (0.030 * ball_xdirection);
    end
    
    % Function updating y position of ball
    function ball_y = updateBallYPosition(ball_y, ball_ydirection)
        ball_y = ball_y + (0.030 * ball_ydirection);
    end
end