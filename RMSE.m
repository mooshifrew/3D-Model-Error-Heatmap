function rmse = RMSE(residuals)
rmse = sqrt(mean(residuals.^2));
end 