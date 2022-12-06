function [angle] = ComputeNewAngle(x, y, ant_angle, pheromones, concentration, r_smell, sigma_1, sigma_2)
%{

functionality:
    - if there are no pheromones in the map, the angle only changes in a 
    random way controlled by the normal distribution specified in the 
    project description. Then, terminate the function.
    - compute the pheromones positions relative to x,y, and also their
    distance.
    - compute the pheromones angles relative to the x axis in range 0, 2pi.
    - filter out the unavailable pheromones.
    - if there are no available pheromones in the map, the angle only 
    changes in a random way controlled by the normal distribution specified
    in the project description. Then, terminate the function.
    - compute the mean of value of all the pheromones positions weighted by
    their concentration.
    - compute the new angle.

outputs:
    angle: the new angle of the ant

inputs:
    x: the x of ant
    y: the y of ant
    ant_angle: the current angle of ant
    pheromones: list of all pheromones
    concentration: list of all pheromone concentrations
    r_smell: the distance in which ant can smell pheromones
    sigma_1: the angle randomness sigma, if ant finds pheromones
    sigma_2: the angle randomness sigma, if ant does not find pheromones
%}

% Loop through all the pheromones
	%	1. Check the distance is <= radius
	% 2. Check the relative angle is between [-90, 90]
	% 3. Update the Maximum, and it's index 
	%====================Initialize Parameters==================
	angle = ant_angle; 
	[rows, cols] = size(pheromones); 
	dist = 0; relativeAngle = 0; 
	phIns = []; 
	%===================Find The Point to Turn to==================
	for phInd = 1:rows
		% get current pheromone x,y position
		phX = pheromones(phInd,1); 
		phY = pheromones(phInd,2); 
		% calculate the angle between ant and the pheromone
		relativeAngle = atan2(phY-y, phX-x); 
		% check whether the angle is insize the smell area
		if relativeAngle < -pi/2 || relativeAngle > pi/2
			continue; % can't smell this -> find the next one
		end
		% check the distance is inside the area
		dist = ((phX-x)*(phX-x) + (phY-y)*(phY-y))^0.5; 
		% the (dist < 0.05) is prevent ant from smelling itself
		if dist > r_smell  % is further than a ant can smell
			continue; 
		end
		%****************Pass the smell criteria******************
		% store the inside pheromoen (weight x,y position with concentration) 
		phIns(end+1) = phInd; 
	end
	%==============Start update the ant's angle==============
	if length(phIns) ~= 0 % if there are pheromone in the smell area
		targetX = 0; targetY = 0; 
		sumCon = 0; 
		for i = 1:length(phIns)
			ind = phIns(i); 
			con = concentration(ind); 
			sumCon = sumCon + con; 
			targetX = targetX + pheromones(ind,1)*con; 
			targetY = targetY + pheromones(ind,2)*con; 
		end
		% sum of concentration
		targetX = targetX / sumCon; 
		targetY = targetY / sumCon; 
		newAngle = atan2(targetY-y, targetX-x); 
		angle = ant_angle + newAngle + normrnd(0,sigma_1);
	else % if there is not pheromone in the smell area
		angle = ant_angle + normrnd(0,sigma_2); 
	end
	% keep the angle under 360 degree
	angle = rem(angle, 2*pi); 
end
