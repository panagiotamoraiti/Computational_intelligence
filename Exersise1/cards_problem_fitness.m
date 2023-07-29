function scores = cards_problem_fitness(x)
    target = [49, 33, 12600];
    pop_size = size(x,1);
    scores = zeros(size(x,1),1);
    
    for i = 1:pop_size
        perm = x{i};
        stack1 = perm(1:5);
        stack2 = perm(6:10);
        stack3 = perm(11:15);
        
        sum1 = sum(stack1);
        sum2 = sum(stack2);
        prod3 = prod(stack3);
        
        total_sum = abs([sum1, sum2, prod3] - target);
        scores(i) = sum(total_sum);
    end
end