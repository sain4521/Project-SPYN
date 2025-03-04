global key
InitKeyboard();
while 1
    pause(0.1);
    switch key
        case 'uparrow'
            disp('Up');
            brick.MoveMotor('A', 20);
            brick.MoveMotor('D', 18.5);
            
        case 'downarrow'
            disp('Down');
            brick.MoveMotor('A', -20);
            brick.MoveMotor('D', -19);
            
        case 'leftarrow'
            brick.MoveMotor('A', 10);
            brick.MoveMotor('D', -10);
            
        case 'rightarrow'
            brick.MoveMotor('A', -10);
            brick.MoveMotor('D', 10);
            
        case 0
            %disp('No Key Press');
            brick.StopMotor('ADB', 'Coast');
            
        case 'w'
            disp('Crane Up');
            brick.MoveMotor('B', -20);
            
        case 's'
            disp('Crane Down');
            brick.MoveMotor('B', 20);
            
        case 'q'
            break;
    end
end

CloseKeyboard();
