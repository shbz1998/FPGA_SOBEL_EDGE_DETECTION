function [x_out, y_out, data_out] = ...
            sobel_edge_detection(x_in, y_in, data_in1)
        
%declaring LINE BUFFERS


persistent lineBuffer1 lineBuffer2  k

WIDTH =512; %image size
HEIGHT = 512;

CMAX = 2000;

Kx = [ 1  0 -1; 
       2  0 -2; 
       1  0 -1];
Ky = [ 1  2  1; 
       0  0  0; 
      -1 -2 -1];

if isempty(k)
    k = zeros(3);
end

%% LINE BUFFER LOGIC

%initiliazing line buffers to ZERO

if isempty(lineBuffer1)
    lineBuffer1 = zeros(1,WIDTH);
    lineBuffer2 = zeros(1,WIDTH);
end

%pixel values
xTemp = x_in-1;
yTemp = y_in-1;

if xTemp < 0
    xOutTemp = CMAX;
else
    xOutTemp = xTemp;
end
if yTemp < 0
    yOutTemp = CMAX;
else
    yOutTemp = yTemp;
end

%line buffer data valid: HIGH OR LOW
if x_in >= 0 && x_in < WIDTH
    dataValid = 1;
else
    dataValid = 0;
end

if dataValid == 1
    lbIndex = x_in+1; %increment line buffer index
else
    lbIndex = 1;
end

l1 = lineBuffer1(lbIndex);
l2 = lineBuffer2(lbIndex);



%write value in the line buffer
if dataValid == 1
    lb1WriteValue = l2; 
    lb2WriteValue = data_in1;
    w1 = [l1 l2 data_in1]';
    
    
else
    lb1WriteValue = l1;
    lb2WriteValue = l2;

   w1 = zeros(3,1); %3 rows, 1 column
end



lineBuffer1(lbIndex) = lb1WriteValue;
lineBuffer2(lbIndex) = lb2WriteValue;

k = [k(:,2:3) w1]; 

if yOutTemp == 0
    k(1,:) = k(2,:);

elseif yOutTemp == HEIGHT-1
    k(3,:) = k(2,:);

end
if xOutTemp == 0
    k(:,1) = k(:,2);

elseif xOutTemp == WIDTH-1
    k(:,3) = k(:,2);

end  


%% CONVOLUTION

Gx1 = 0;
Gy1 = 0;


for i=1:3
    for j=1:3
        Gx1 = Gx1 + k(i,j)*Kx(i,j);
        Gy1 = Gy1 + k(i,j)*Ky(i,j);
    end
end


G = abs(Gx1) + abs(Gy1);

Gd = floor(G/4);
Gdm = min(Gd,255);

x_out = xOutTemp;
y_out = yOutTemp;
if yOutTemp < HEIGHT && xOutTemp < WIDTH
    data_out = Gdm;
   
else
    data_out = 0;
end






