function [errors]=compute_errors(theta,X,Y)

errors = nan(1,numel(theta));
for i = 1:numel(theta)
    errors(i) = sum((eval_poly(X,theta{i})-Y).^2);
end
