function [pheromone, concentration] = PheromonesUpdate(pheromone, concentration, decay)
	%{

	functionality:
		reduce all concentrations by decay, and only keep the pheromones with
		positive concentration.

	outputs:
		pheromone: list of all modified pheromones
		concentration: list of all new pheromone concentrations

	inputs:
		pheromone: list of all pheromones
		concentration: list of all pheromone concentrations
		decay: the concentration decay value

	%}
	%{
		Data structure of the inputs: 
			1. Raw index: each pheromone
			2. Pheromone: [x_pos, y_pos] 
			3. Concentration: [value, indicator{blue, red}] 
			4. decay: [red decay, blue decay] 
	%}

	% check whether input is valid
	[numPheromone, col] = size(pheromone); % get the dimension of the data
	if numPheromone == 0 
		return; % return if there are no pheromone
	end
	% decay the pheromones
	for conInd = 1:numPheromone
		concentration(conInd) = concentration(conInd) - decay; 
	end	
	% remove the zero concentration (cut down space complexity) 
	[rows, cols] = size(pheromone); 
	if rows ~= 0
		curInd = 1; % initialize the index
		% use space to cut down time complexity
		temptCon = concentration; 
		temptPh = pheromone; 
		concentration = []; 
		pheromone = []; 
		for i = 1:rows
			if temptCon(i) >= decay
				pheromone(curInd,:) = temptPh(i,:); 
				concentration(curInd) = temptCon(i); 
				curInd = curInd + 1; 
			end
		end
	end
	% for safety
	return; 
end
