function out = GetSignalBin(X, window, WindowShift)

dim = size(X);
if window > dim(1);
    error('The length of X should be longer than window');
end

out_length = fix((dim(1)-window)/WindowShift+1);
out=zeros(out_length, dim(2));

 for i= 1:out_length;
     index = (i-1)*WindowShift+1;
     temp = X(index:(index+window-1),:);
     out(i,:) = FR(temp);
     %Returns the ratio of the lowest frequency in a bin to the highest frequency in the bin
 end