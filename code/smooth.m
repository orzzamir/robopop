function y = smooth(x, w)
    l = length(x);
    y=zeros(l,1);
    
    for i=1:w
        y(i)=x(i);
    end
    
    for i=(l-w+1):l
        y(i)=x(i);
    end
    
    for i=(w+1):(l-w)
       y(i) = sum(x(i-w:i+w))/(2*w+1); 
    end
end