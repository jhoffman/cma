function model = train_model(expt, Xs, Ys)

switch expt.classifier
    case 'linearsvm'
        model = train(Ys, sparse(Xs), sprintf('-c %d -q', expt.C));
    case 'knn'
        model = [];
    otherwise
        error( 'Classifier type %s is not supported.', expt.classifier );
end

end