function zcr = getZCR(data)
len=length(data);
zcr=0;
for i=1:len-1
    if data(i)*data(i+1)<=0
        zcr=zcr+1;
    end
end
end