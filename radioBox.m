function out = radioBox(ind)

    global optval;
    optval = 1;

    keys = [50 51];
    n = find(keys == ind);
    
    opts = {{'What is Professor Kantwon''s last name?' 'Rogers', 'Uchiha', 'Uzumaki', 'Hatake'}, {'We saw you jump the median buddy, and you don''t even look like you''re old enough. However, we can let you off if you choose to become a spy for us. What do you say?' 'Hell yeah, I''ll spy for you!' 'No way bub! Lemme go to jail.'}};
    
    cons = {{22 12 12 12} {9 10}};
    
    
    fig = figure('Name', 'Your options', 'NumberTitle', 'off', 'Position', [100 100 800 300]);   
    bg = uibuttongroup(fig, 'Title', 'Choose an option', 'SelectionChangedFcn', @doMe);
    tb  = uicontrol(fig, 'Style', 'text', 'String', opts{n}{1}, 'Position', [10 200 600 40], 'HorizontalAlignment', 'left');
    
    for i = 2:numel(opts{n})
        rb(i - 1) = uicontrol(bg, 'Style', 'radiobutton', 'Tag', num2str(i - 1), 'String', opts{n}{i}, 'Position', [100 200 - 40 * (i - 1) 600 40]);
    end
    
    uiwait(fig);
    out = cons{n}{optval};

end

function doMe(bg, event)

    global optval;
    optval = str2num(bg.SelectedObject.Tag);

end

