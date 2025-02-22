% for calculagraph
num_runs = 10;
% calculagraph
calculagraph = zeros(1, num_runs);

for times = 1:num_runs
    start_time = tic;
    %competitve graph
    datasetname = 'ice cream';
    
    sim = importdata('D:\Code of RA\Preflib\results\ice-cream\ice-cream.mat');
    rankernum = size(sim,1);
    querynum = size(sim,2);
    item_num = size(sim,3);
    [~,rank] = sort(-sim,3);
    [~,rank] = sort(rank,3);
    
    indegree = zeros(querynum,item_num);
    outdegree = zeros(querynum,item_num);
    for i=1:rankernum
        indegree = indegree + reshape(rank(i,:,:),querynum,item_num) - 1;
    end
    outdegree = item_num * rankernum - indegree;
    indegree = indegree + 1;
    outdegree = outdegree + 1;
    score = outdegree ./ indegree;
    [~,res] = sort(-score,2);
    [~,res] = sort(res,2);
    
    % save the .mat file which consist of the rank result
    save('D:\Code of RA\Preflib\results\ice-cream\rank-based\rank-result-ice-cream-CG.mat', 'res');

    end_time = toc(start_time);
    calculagraph(times) = end_time;
end

% print each run time
for times = 1:num_runs
    fprintf('run %d time：%.8f seconds\n', times, calculagraph(times));
end

% average_time
average_time = mean(calculagraph);
fprintf('average run time：%.8f seconds\n', average_time);   

    
    
    
    