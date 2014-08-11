function result = classify_data(expt, model, Xtr, Ytr, Xte, Yte)
% Usage: result = classify_data(expt, model, Xtr, Ytr, Xte, Yte)
% 
tic;
fprintf('[Classify Data] %s', expt.classifier);
switch expt.classifier
    case 'linearsvm'
        [pred,a,pr] = predict(Yte, sparse(Xte), model, '-q');
        prob = model.Label(1) * pr;
        accuracy = a(1);
    case 'knn'
        if isfield(model, 'L')
            L = model.L;
        else
            L = eye(size(Xtr, 2));
        end
        K0 = Xtr * L * Xte'; % linear kernel no adaptation
        nK0tr = diag(Xtr * L * Xtr'); % training kernel no adaptation
        nK0te = diag(Xte * L * Xte'); % test kernel no adaptation
        [pred,~,~,prob] = kernelKNN(Ytr, K0', nK0tr, nK0te);
        accuracy = 100 * sum(pred == Yte)/length(Yte);
    otherwise
        error( 'Classifier type %s is not supported.', expt.classifier );
end
fprintf('  (%2.2f s)\n', toc);
[recall, prec, info] = vl_pr(Yte, prob, 'Interpolate', expt.interp);
ap = info.ap;

result.pred   = pred;
result.prob   = prob;
result.acc    = accuracy;
result.recall = recall;
result.prec   = prec;
result.ap     = ap;
end