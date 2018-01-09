function segmented = segmentation(InputImage,xs,ys)

[rows, columns] = size(InputImage);
mask = poly2mask(xs, ys, rows, columns);
segmented = uint8(zeros(rows,columns));
for row = 1:rows
    for column = 1: columns
        if mask(row,column) == 0
            segmented(row,column) = (InputImage(row,column));
        end
    end
end

[bx,by]=getboxsnake;
mask1 = poly2mask(bx, by, rows, columns);
boxcut = uint8(zeros(rows,columns));
for row = 1:rows
    for column = 1: columns
        if mask1(row,column) == 1
            boxcut(row,column) = InputImage(row,column);
        end
    end
end
boxcut( ~any(boxcut,2), : ) = [];  %delete zero rows
boxcut( :, ~any(boxcut,1) ) = [];  %delete zero columns
[p,q]=size(boxcut);
i=1;j=1;
for row = 1:rows
    for column = 1: columns
        if mask(row,column) == 1
            segmented(row,column) = boxcut(i,j);
            j=j+1;
            if j>q && i==p
                i=1;j=1;
            end
            if j>q
                j=1;i=i+1;
            end
            
        end
    end
end


