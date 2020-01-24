function out = GetRMS(X, window, WindowShift)

dim = size(X);
if window > dim(1);
    error('The length of X should be longer than window');
end

X=X.^2;

out_length = fix((dim(1)-window)/WindowShift+1);
out=zeros(out_length, dim(2));

 for i= 1:out_length;
     index = (i-1)*WindowShift+1;
     temp = X(index:(index+window-1),:);
     out(i,:) = sqrt(mean(temp));
 end
