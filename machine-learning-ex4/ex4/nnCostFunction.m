function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));



a{1} = X'; size(a{1}); a{1} = [ones(1, m); a{1}]; size(a{1});% add a row of 1s to a1
X = ([ones(m, 1) X]); % add a column of 1s to X
z{2} = Theta1 * X'; size(z{2});
a{2} = sigmoid(z{2}); a{2} = [ones(1, m); a{2}]; size(a{2});% add a row of 1s to a2 
z{3} =  Theta2 * a{2}; size(z{3});
a{3} = sigmoid(z{3}); size (a{3});

h = (a{3})'; size(h);

% let's create a y that is 5000x10
fat_y = zeros(m, num_labels);
for i = 1:m
  fat_y(i, y(i)) = 1;
end

% compute cost and gradient
J = 0;
for i = 1:m
  for k = 1: num_labels
    yik = fat_y(i, k); 
    hik = h(i, k);
    J = J -1/m*(yik*log(hik)+(1-yik)*log(1-hik)); 
  end
end
unbiasedTheta1 = Theta1; unbiasedTheta1(:, 1) = zeros(size(unbiasedTheta1, 1), 1);
unbiasedTheta2 = Theta2; unbiasedTheta2(:, 1) = zeros(size(unbiasedTheta2, 1), 1);
J = J + lambda/(2*m)*(sum(sum(unbiasedTheta1.^2)) + sum(sum(unbiasedTheta2.^2)));


for t = 1: m  
  a1 = a{1}(:, t); 
  z2 = z{2}(:, t); % select column t
  a2 = a{2}(:, t);
  z3 = z{3}(:, t);
  a3 = a{3}(:, t);
  
  del3 = a3 - fat_y(t, :)';
  del2 = Theta2'*del3; del2 = del2(2: end); del2 = del2.*sigmoidGradient(z2); % step 3

  
  Theta2_grad = Theta2_grad + del3*a2'; 
  Theta1_grad = Theta1_grad + del2*a1'; 
end

Theta1_grad = Theta1_grad/m + (lambda/m)*unbiasedTheta1;
Theta2_grad = Theta2_grad/m + (lambda/m)*unbiasedTheta2;

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
