% function testUI(source, event)
% 
%     T = 0.1:0.01:10;
%     a = source.Value;
%     y = exp(-a ./ T);
%     plot(T, y);
%     
%     
% 
% end

function out = testUI()
% 
%     % in this function, a nested cell array is fed in, with keywords of the
%     % command
%     
%     out = true;
%     
%     for i = 1:numel(cArr)
%         tempOut = false;
%         for j = 1:numel(cArr{i})
%             tempOut = tempOut | any(strcmpi(words(:), cArr{i}{j}));
%         end
%         
%         out = out & tempOut
%         
%     end
%         


fh = fopen('lol.txt', 'r');
out = fgetl(fh)
disp('done');
line = fgetl(fh)


end