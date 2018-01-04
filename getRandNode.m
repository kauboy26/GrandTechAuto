function out = getRandNode(ind)

    opts = {3 [6 5]; 69 [39 40]};
    keys = [opts{:, 1}];
    num = opts{find(keys == ind), 2};
    
    if rand() > 0.4
        out = num(1);
    else
        out = num(2);
    end
end

