clear 
close all
clc

n = 7;
symbol_num = 5;

numbers = 0:n*symbol_num-1;
interleave = reshape(numbers,n,symbol_num);
% for interleaver, the i-th entry of the output sequence is 
% the map(i)-th entry of the input
map = reshape(interleave',1,n*symbol_num); 

% 0001010
% 0011111
% 0000111
% 1011011
% 1100101
test = [0 0 0 1 0 1 0 0 0 1 1 1 1 1 0 0 0 0 1 1 1 1 0 1 1 0 1 1 1 1 0 0 1 0 1];
output_interleaver = test(map+1);

deinterleave = reshape(numbers,symbol_num,n);
% for deinterleaver, the i-th entry of the output sequence is 
% the inversemap(i)-th entry of the input
inversemap = reshape(deinterleave',1,n*symbol_num); 
output_deinterleaver = output_interleaver(inversemap+1);

fileID = fopen('interleave.txt', 'w');
for i = 1:n*symbol_num
    fprintf(fileID, 'data_o[%d] <= data_i[%d];\n', i-1, map(i));
end
fprintf(fileID, 'eno <= 1;\n');
fclose(fileID);

fileID = fopen('deinterleave.txt', 'w');
for i = 1:n*symbol_num
    fprintf(fileID, 'r_data_o[%d] <= r_data_i[%d];\n', i-1, inversemap(i));
end
fprintf(fileID, 'r_eno <= 1;\n');
fclose(fileID);