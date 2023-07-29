clc; clear;
fis = readfis('Emergency_Braking.fis');
%showrule(fis)

% Speed, distance
inputs = [3 6 14 25 30; 10 4 6 10 2];
output = evalfis(fis, inputs);
disp("Braking:");

for i = 1:length(output)
   disp(['The velocity of the car is ', num2str(inputs(1,i)), ' and the distance of the obstacle is ', num2str(inputs(2,i)), ' -> Braking is ', num2str(output(i))]);
end