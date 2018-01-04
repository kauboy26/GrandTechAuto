function out = nodeLoader(path)

    % this function isn't really essential to the game. it just helps me by
    % making data entry related to the nodes easy.
    % 
    % the 'path' specifies the name of the text file, which is in the following
    % format:
    % 
    % Name
    % Node ID (a number)
    % Description
    % Item list (separated by commas)
    % connections to other nodes (in NESWUD format), a list of IDs

    fh = fopen(path, 'r');

    
    line = '';
    % count = 1;
    while ~isequal(line, '#')
        line = fgetl(fh);
        n = str2num(line);
        out(n).des = sprintf(fgetl(fh));
        
        % to extract the key words
        ca = {}; 
        line = fgetl(fh);
        count = 1;
        while ~isequal(line, '~')
            [t1, t2] = strtok(line, '|');
            if ~isempty(t2)
                [word, rest] = strtok(t1, ' ');
                w1 = {};
                while ~isempty(word)
                    w1{1, end + 1} = word;
                    [word, rest] = strtok(rest, ' ');
                end
                
                w2 = {};
                [word, rest] = strtok(t2(2:end), ' ');
                while ~isempty(word)
                    w2{1, end + 1} = word;
                    [word, rest] = strtok(rest, ' ');
                end
                
                ca{1, count} = {w1 w2};
                count = count + 1;
                
            else
                [word, rest] = strtok(t1, ' ');
                w1 = {};
                while ~isempty(word)
                    w1{1, end + 1} = word;
                    [word, rest] = strtok(rest, ' ');
                end
                ca{1, count} = {w1};
                count = count + 1;
            end
            line = fgetl(fh);
        end
        out(n).words = ca;
        line = fgetl(fh);
        out(n).cons = str2num(line);
        line = fgetl(fh);
    end
    
    fclose(fh);
    
end
