function out = imageBox()

    fig = figure('Name', 'RED DRAGON CASINO', 'NumberTitle', 'off');
      
    xs = [-0.75 0 0.75];
    
    tb  = uicontrol(fig, 'Style', 'text', 'String', 'After they STOP MOVING, choose any shell. If there''s a pea under it, you win!', 'Position', [5 330 600 40], 'HorizontalAlignment', 'left', 'FontSize', 12);
    
    for i = linspace(0, 2 * pi, 100)
        hold off;
        [x1 y1] = getCircle(xs(1), 0, 0.25);
        [x2 y2] = getCircle(xs(2), 0, 0.25);
        [x3 y3] = getCircle(xs(3), 0, 0.25);
        fill(x1 - cos(i) * 0.375 + 0.375, y1 + sin(i) * 0.25, 'r');
        axis off;
        axis([-1 1 -1 1]);
        axis square;
        hold on;
        fill(x2 + cos(i) * 0.375 - 0.375, y2 - sin(i) * 0.25, 'r');
        fill(x3 + cos(i) * 0.375 - 0.375, y3 - sin(i) * 0.25, 'r');
        pause(0.01)
    end
    
    [x y] = ginput(1);
    if sqrt((x + 0.75) ^ 2 + y ^ 2) < 0.25
        out = 28;
    else
        out = 29;
    end
    
    uiwait(msgbox('Your choice has been made. Close the casino window to continue.'));

end



function [xC, yC] = getCircle(x, y, rad)

    t = linspace(0, 2 * pi, 40);
    xC = x + rad * cos(t);
    yC = y + rad * sin(t);

end