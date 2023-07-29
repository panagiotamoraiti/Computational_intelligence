clc;clear;

% input data 
data = dec2bin(0:63) - '0'; % all six digits combinations, matrix with 64 rows and 6 columns

% randomly select 50 rows for training
idx_train = randperm(size(data, 1), 50);
inputs_train = data(idx_train, :);
% use the remaining rows for testing
idx_test = setdiff(1:size(data, 1), idx_train);
inputs_test = data(idx_test, :);

% labels
outputs_train = ~mod(sum(inputs_train, 2), 2); % 1x50 vector, 0 even or 1 odd
outputs_test = ~mod(sum(inputs_test, 2), 2); % 1x14 vector, 0 even or 1 odd

% neural network
%net = newff([zeros(6, 1) ones(6, 1)], [3 3 3 3 3 3 1], {'tansig', 'tansig', 'tansig', 'tansig', 'tansig', 'tansig', 'logsig'}, 'trainlm');
net = newff(minmax(data'), [3 3 3 3 3 3 1], {'tansig', 'tansig', 'tansig', 'tansig', 'tansig', 'tansig', 'logsig'}, 'trainlm');

% train the network
net.trainParam.show = 50; % The result is shown at every 50th iteration (epoch) 
net.trainParam.lr = 0.01; % Learning rate used in some gradient schemes 
net.trainParam.epochs = 1000; % Max number of iterations 
net.trainParam.goal = 1e-5; % Error tolerance; stopping criterion
net1 = train(net, inputs_train', outputs_train');

% predictions
predictions = sim(net1, inputs_test'); % predictions
binary_predictions = predictions >= 0.5;

% mean square error
N = size(outputs_test, 1);
mse = sum((outputs_test'-binary_predictions).^2)/N;
fprintf('Mean square Error = %.4f\n', mse)

% accuracy
accuracy = sum(binary_predictions == outputs_test')/N;
fprintf('Accuracy = %.2f%% \n', accuracy*100);
