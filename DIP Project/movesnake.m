function [xs,ys]=movesnake(image, xs, ys, alpha, beta, gamma, kappa, wLine, wEdge, wTerm, iterations)
% image: This is the image data
% xs, ys: The initial snake coordinates
% alpha: Controls tension
% beta: Controls rigidity
% gamma: Step size
% kappa: Controls enegry term
% wl, we, wt: Weights for line, edge and terminal enegy components
% iterations: No. of iteration for which snake is to be moved

% Calculating size of image
[row,col] = size(image);

%Computing Eimage

Eline = image; %Eline is image intensity itself

[gradientX,gradientY] = gradient(image);
Eedge = -1 * sqrt ((gradientX .* gradientX + gradientY .* gradientY)); %Eedge is measured by gradient in the image

%masks for taking various derivatives
m1 = [-1 1];
m2 = [-1;1];
m3 = [1 -2 1];
m4 = [1;-2;1];
m5 = [1 -1;-1 1];

Cx = conv2(image,m1,'same');
Cy = conv2(image,m2,'same');
Cxx = conv2(image,m3,'same');
Cyy = conv2(image,m4,'same');
Cxy = conv2(image,m5,'same');

for i = 1:row
    for j= 1:col
        % Eterm:
        Eterm(i,j) = (Cyy(i,j)*Cx(i,j)*Cx(i,j) -2 *Cxy(i,j)*Cx(i,j)*Cy(i,j) +...
                      Cxx(i,j)*Cy(i,j)*Cy(i,j))/((1+Cx(i,j)*Cx(i,j) + Cy(i,j)*Cy(i,j))^1.5);
    end
end

%Eimage = wLine*Eline + wEdge*Eedge - wTerm*Eterm
Eimage = (wLine*Eline + wEdge*Eedge - wTerm*Eterm); 

[fx, fy] = gradient(Eimage); %computing the gradient

%initializing the snake
xs=xs';
ys=ys';
m = size(xs,1);
    
%populating the penta diagonal matrix
A = zeros(m,m);
b = [(2*alpha + 6 *beta) -(alpha + 4*beta) beta];
brow = zeros(1,m);
brow(1,1:3) = brow(1,1:3) + b;
brow(1,m-1:m) = brow(1,m-1:m) + [beta -(alpha + 4*beta)]; % populating a template row
for i=1:m
    A(i,:) = brow;
    brow = circshift(brow',1)'; % Template row being rotated to egenrate different rows in pentadiagonal matrix
end

[L,U] = lu(A + gamma .* eye(m,m));
Ainv = inv(U) * inv(L); % Computing Ainv using LU factorization
 
%moving the snake in each iteration
for i=1:iterations
    
    ssx = gamma*xs - kappa*interp2(fx,xs,ys);
    ssy = gamma*ys - kappa*interp2(fy,xs,ys);
    
    %calculating the new position of snake
    xs = Ainv * ssx;
    ys = Ainv * ssy;
    
    
    %Displaying the snake in its new position
    imshow(image,[]); 
    hold on;
    
    plot([xs; xs(1)], [ys; ys(1)], 'r-');
    hold off;
    pause(0.001)    
end


