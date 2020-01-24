function [det,entr] = GetRPcoes(x, window, WindowShift)

dim = size(x);
if window > dim(1);
    error('The length of X should be longer than window');
end

out_length = fix((dim(1)-window)/WindowShift+1);
det=zeros(out_length, dim(2));
entr=zeros(out_length, dim(2));
x= x';

for i= 1:out_length;
     if( rem(i, floor(out_length/10)) ==1)
         i
        toc
        tic
     end
     index = (i-1)*WindowShift+1;
     for j=1:16
         rp = RPplot_FAN(x(j,index:(index+window-1)),9,4,50,0);
        [~,DET,ENTR,~] = Recu_RQA(rp,1,2);
        det(i,j) = DET;
        entr(i,j) = ENTR;
     end
 end





                 