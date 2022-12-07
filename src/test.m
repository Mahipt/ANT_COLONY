close all; 
clear; 
clc; 




% test code for ComputeNewAngle


pheromones = [
	1 0; 
	0 1; 
	-1 0; 
	0 -1; 
]; 
concentrations = [1 0.8 0.7 0.6]; 
r_smell = 10;
sigma_1 = 0.01; 
sigma_2 = 0.8; 

maxAngle = -Inf; 
minAngle = Inf; 
angle = zeros(100, 1); 
curInd = 1; 
for i = 1:100
	x = 0; 
	y = 0; 
	curAngle = 0; 
	rv = ComputeNewAngle(x,y,curAngle,pheromones, concentrations,...
			r_smell, sigma_1, sigma_2); 
	if maxAngle <= (rv * 180 / pi) 
		maxAngle = rv * 180 / pi; 
	end 
	if minAngle >= (rv * 180 / pi) 
		minAngle = rv * 180 / pi; 
	end 
	angle(curInd) = rv * 180 / pi; 
	curInd = curInd + 1; 
end

fprintf("Max Angle: %f\n",maxAngle); 
fprintf("Min Angle: %f\n",minAngle); 
fprintf("Range: %f\n", maxAngle - minAngle); 
