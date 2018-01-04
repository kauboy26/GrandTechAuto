function out = sliderBox()

    fig = figure('Name', 'RED DRAGON CASINO', 'NumberTitle', 'off');
    global in;
    in = 0;
    
    sl = uicontrol(fig, 'Style', 'slider', 'Min', 0, 'Max', 1000, 'Value', 0, 'Callback', @replot, 'Position', [120 400 300 20], 'BackgroundColor', 'yellow');
    x = linspace(-1000, 1000, 100);
    y = x .^ 3 / 100000;
    plot(x, y, 'b');
    
    uiwait(fig);
    
    msgbox(sprintf('You have put in %0.2f. You may win up to %0.2f.', in, in ^ 3 / 100000));
    out = 14;
    
    
end

function replot(source, event)

    global in;

    
    
    x = linspace(-1000, 1000, 100);
    y = x .^ 3 / 100000;
    plot(x, y, 'b');
    hold on;
    in = source.Value;
    pot = in ^ 3 / 100000;
    plot([-in in], [-pot pot], 'r');
    hold off;
    
    xlabel('Amount you put in');
    ylabel('Amount you may win OR lose');


end