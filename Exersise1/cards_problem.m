n = 15;
pop_size = 60;

type cards_problem_create_permutations.m 
type cards_problem_crossover_permutation.m 
type cards_problem_mutate_permutation.m 
type cards_problem_fitness.m 

FitnessFcn = @(x) cards_problem_fitness(x);
        
options = gaoptimset('PopulationType', 'custom', 'PopInitRange', ... 
                     [1;n]); 
options = gaoptimset(options,'CreationFcn',@cards_problem_create_permutations, ... 
                             'CrossoverFcn',@cards_problem_crossover_permutation, ... 
                             'MutationFcn',@cards_problem_mutate_permutation, ...  
                             'Generations',1000,'PopulationSize',pop_size, ... 
                             'StallGenLimit',200,'Vectorized','on'); 
numberOfVariables = n; 
[x, fval, reason, output] = ga(FitnessFcn, numberOfVariables, options)

% Display results
stack1 = x{1}(1:5);
stack2 = x{1}(6:10);
stack3 = x{1}(11:15);

fprintf('Stack 1: %s\n', num2str(stack1));
fprintf('Sum of stack 1: %d\n', sum(stack1));
fprintf('Stack 2: %s\n', num2str(stack2));
fprintf('Sum of stack 2: %d\n', sum(stack2));
fprintf('Stack 3: %s\n', num2str(stack3));
fprintf('Product of stack 3: %d\n', prod(stack3));

fprintf('Fitness score: %.2f\n', fval); % We want to make this as smaller as possible
% fprintf('Check: %d\n', abs(49-sum(stack1))+abs(33-sum(stack2))+abs(12600-prod(stack3)));