function out = wordProc(sent, dict)

    badWords = {{'bitch' 'bastard' 'cunt' 'fuck' 'fucking' 'fucked' 'whore' 'penis' 'asshole' 'faggot'}};
    if contains(getWords(sent), badWords)
        out = false;
        return;
    end
    bool = logical(zeros(1, numel(dict)));
    for i = 1:numel(dict)
        bool(i) = contains(getWords(sent), dict{i});
    end
    out = find(bool);
end

function out = getWords(sent)

    mask = (sent >= '0' & sent <= '9') | (sent >= 'A' & sent <= 'z') | sent == ' ';
    sent = lower(strtrim(sent(mask)));
    
    
    [word, rest] = strtok(sent, ' ');
    out = {};
    
    while ~isempty(word)
        if ~any(strcmpi({'the', 'a', 'an'}, word))
            out = [out word];
        end
        
        [word, rest] = strtok(rest, ' ');
    end
    
end
function out = contains(words, cArr)

    % in this function, a nested cell array is fed in, with keywords of the
    % command
    
    out = true;
    
    for i = 1:numel(cArr)
        tempOut = false;
        for j = 1:numel(cArr{i})
            tempOut = tempOut | any(strcmpi(words(:), cArr{i}{j}));
        end
        
        out = out & tempOut;
        
    end
        

end