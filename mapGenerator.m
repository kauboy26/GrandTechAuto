function  [imgOut, skel] = mapGenerator(path)

    skel = readMap(path);
    [rs, cs] = size(skel);
    
    imgOut = zeros(rs * 32, cs * 32, 3);
    
    % loading tiles
    tiles = imread('tiles.png');
    
    imgOut = sAndR(skel, imgOut, tiles, 'grass');
    imgOut = sAndR(skel, imgOut, tiles, 'sand');
    imgOut = sAndR(skel, imgOut, tiles, 'path');
    imgOut = sAndR(skel, imgOut, tiles, 'wat');
    imgOut = sAndR(skel, imgOut, tiles, 'for');
    
    imgOut = uint8(imgOut);
end

function out = sAndR(arr, img, tiles, t)

    out = img;
    [rs, ~, ~] = size(arr);
    ind = find(arr == ID(t))';
    tile = tiles(1:32, (ID(t) - 1) * 32 + 1: ID(t) * 32, :);

    for i = ind
        out((1 + mod(i - 1, rs) * 32):(mod(i - 1, rs) * 32 + 32), floor((i - 1) / rs) * 32 + 1: (floor((i - 1) / rs) + 1) * 32, :) = tile;    
    end
end

function out = readMap(path)

% green, black, yellow --> walkable (grass, path, sand)
% red, gray (200) --> house, cave entrances (enterable)
% red (128), gray (128) = house, cave (map to be generated)
% blue, green (128) --> water, forest
% blue (128) --> people

    img = imread(path);
    [rs, cs, ~] = size(img);
    
    out = zeros(rs, cs);
    rF = img(:, :, 1) == 255;
    gF = img(:, :, 2) == 255;
    bF = img(:, :, 3) == 255;
    rE = img(:, :, 1) == 0;
    gE = img(:, :, 2) == 0;
    bE = img(:, :, 3) == 0;
    rH = img(:, :, 1) == 128;
    gH = img(:, :, 2) == 128;
    bH = img(:, :, 3) == 128;
    
    
    out(rE & gF & bE) = ID('grass');
    out(rE & gE & bE) = ID('path');
    out(rF & gF & bE) = ID('sand');
    out(rE & gE & bF) = ID('wat');
    out(rH & gE & bE) = ID('hs');
    out(rE & gH & bE) = ID('for');
    out(rE & bE & bH) = ID('peep');


end

function out = ID(in)

    type = {'grass' 2
        'path' 5
        'sand' 3
        'hs' 10
        'cv' 6
        'hE' 8
        'cE' 7
        'wat' 4
        'for' 1
        'peep' 9
        };

    if isequal(class(in), 'double')
        ind = [type{:, 2}(1)] == in;
        out = type{ind, 1};
    elseif isequal(class(in), 'char')
        ind = strcmp(type(:, 1), in);
        out = type{ind, 2};
    else
        out = false;
    end

end

