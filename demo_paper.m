
start_ind = [350, 400, 450, 500, 550];
r = cell(length(start_ind),1);
for i = 1:length(start_ind)
    r{i} = demo_caltran('gist', start_ind(i));
end

algs = fieldnames(r{1});
fprintf('\n\nFinal Summary results:\t Accuracy \t   AP\n');
for i = 1:length(algs)
    alg = algs{i};
    str = '%s:\t\t';
    if length(alg) < 7 % less than a tab
        str = [str, '\t'];
    end
    acc = zeros(numel(start_ind),1); ap = zeros(numel(start_ind),1);
    for j = 1:numel(start_ind)
        acc(j) = r{j}.(alg).acc;
        ap(j) = r{j}.(alg).ap*100;
    end
    str = [str, ' %6.2f+-%1.2f \t %6.2f+-%1.2f\n'];
    fprintf(str, alg, mean(acc), std(acc)/sqrt(numel(start_ind)), ...
        mean(ap), std(ap)/sqrt(numel(start_ind)));
end