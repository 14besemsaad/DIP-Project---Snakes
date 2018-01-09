function [xs,ys] = getboxsnake
rect=getrect();
width=rect(3);height=rect(4);
x1=rect(1);x2=x1+width-1;x3=x2;x4=x1;
y1=rect(2);y2=y1;y3=y1+height-1;y4=y3;
ys=[];
%%%%%%%% xs1
xs=x1:x2;    
for i=1:height-1
    xs=[xs x2];
end
for i=x3-1:-1:x1
    xs=[xs i];
end
for i=1:height-2
    xs=[xs x4];
end
%%%%%%%%%%%

%%%%%%%%% ys1
for i=1:width
    ys=[ys rect(2)];
end
for i=y2+1:1:y3
    ys=[ys i];
end
for i=1:width-1
    ys=[ys y3];
end
for i=y4-1:-1:y1+1
    ys=[ys i];
end
%%%%%%%%%%%%% 
end