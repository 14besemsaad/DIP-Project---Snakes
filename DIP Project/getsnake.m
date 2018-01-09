
function [xs, ys] = getsnake

hold on;    
button = 1;
hold on
xy = [];
n = 0;

disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')

% Loop, picking up the points.
while button == 1
    [xi,yi,button] = ginput(1); 
    plot(xi,yi,'ro')
    n = n+1;
    xy(:,n) = [xi;yi];
end

n = n+1;
xy(:,n) = [xy(1,1);xy(2,1)];

% Interpolate with a spline curve and finer spacing.
t = 1:n;
interval = 1: 0.1: n;
xy = spline(t,xy,interval);

xs = xy(1,:);
ys = xy(2,:);
