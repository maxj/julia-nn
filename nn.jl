function sigmoid(x, deriv)
	 if (deriv == true)
	    return x.*(1-x)
	 end
	 return 1./(1+exp(-x))
end


function train_nn(weights, intermediateLayers, intDimension, truth, numberOfIterations)


    layers = Dict()
    deltas = Dict()
    for iter in 0:numberOfIterations

        layers[0] = X
        
        for ilayer in 1:intermediateLayers+2
            layers[ilayer] = sigmoid(layers[ilayer-1] * weights[ilayer-1], false)
        end

        # Calculate Errors                                                                                                                    
        previousError = y - layers[intermediateLayers+2]
        deltas[intermediateLayers+2] = previousError .* sigmoid(layers[intermediateLayers+2], true)
        for ilayer in intermediateLayers+1:-1:0
            previousError = deltas[ilayer+1] * weights[ilayer]'
            deltas[ilayer] = previousError .* sigmoid(layers[ilayer], true)
        end
        
        # Update weights from errors                                                                                                          
        for ilayer in intermediateLayers+1:-1:0
        weights[ilayer] += layers[ilayer]' * deltas[ilayer+1]
        end
    end  
    return layers
end

X = [0 0 1; 0 1 1; 1 0 1; 1 1 1] 
y = [0;1;1;0]

# zero mean synapse weights

intermediateLayers = 2
numberOfIterations = 60000
weights = Dict()
intDimension = 10

# Initialize weights
weights[0] = 2*randn(3,intDimension)-1
for ilayer in 1:intermediateLayers
    weights[ilayer] = 2*rand(intDimension,intDimension)-1
end
weights[intermediateLayers+1] = 2*rand(intDimension,1)-1

layers = train_nn(weights, intermediateLayers, intDimension, y, numberOfIterations)

print("Final output:\n")
print(layers[intermediateLayers+2])
print("\n")

