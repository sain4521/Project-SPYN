%{
Port  1 - touch sensor
Port 2 - color sensor
Port 3 - gyro sensor
Port 4 - sonic sensor
 
Port A -  wheel  motor 
Port B - arm motor 
Port D - wheel motor
%}


brick.SetColorMode(2, 2);

finishPickup = 0;



% this while loop is for auto-drive
while 1

    % Move Forward
    brick.MoveMotor('A', 55);
    brick.MoveMotor('D', 55);


    % get color sensor reading
    touch = brick.TouchPressed(1);
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(4);

    % color react
    if color == 2 || color == 3
        finishPickup = 1;
        disp('value finishPickup change to 1');
        disp('Read blue/green, running keyboard control');
        brick.StopMotor('AD', 'Brake');
        run('kbrdcontrol_1');
        brick.StopMotor('AD', 'Brake');
        pause(1);
        brick.MoveMotor('AD', 70);
        pause(1);
    end

    % the car won't stop if it haven't went to blue or green area
    if color == 4 && finishPickup == 0
        disp('read yellow, finishPickup dont satisfy');
    end


    % yellow, distination
    if color == 4 && finishPickup == 1
        disp('Read yellow, stop all actions');
        brick.MoveMotor('AD', 0);
        break;
    end


    % red, stop for 1 second
    if color == 5
        disp('Read red, pause for 1 second');
        brick.MoveMotor('AD', 0);
        pause(1);
        brick.MoveMotor('A', 70);
        brick.MoveMotor('D', 70);
        pause(0.5);
    end

    % Wall distance
    if distance > 60% && distance < 301 
        pause(0.6);
        brick.StopMotor('AD', 'Brake');
        brick.MoveMotor('A', -27);
        brick.MoveMotor('D', 27);
        pause(0.89);
        brick.StopMotor('A', 'Brake');
        brick.MoveMotor('AD', 70);
        pause(1.7);
    end
    if distance < 6
         disp('close');
        pause(0.6);
        brick.MoveMotor('A', -2);
        brick.MoveMotor('D', 2);
        pause(0.9);
        brick.StopMotor('AD', 'Brake');
    end

    
    % if hit the wall
    if touch 
        % keep going 1 sec to make sure really touched the wall
        pause(0.2);

        disp('touched');
        brick.StopMotor('AD');
        distance = brick.UltrasonicDist(4);

        % move back
        brick.MoveMotor('AD', -40);
        pause(0.65);

        % turn right
        brick.MoveMotor('A', 27);
        brick.MoveMotor('D', -27);
        pause(0.9);
        brick.StopMotor('AD', 'Brake');
    end
    



end