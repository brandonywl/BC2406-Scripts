# R in RMSE allows for congruency in units <- mainly for the ability to do comps. Extent of error
tp <- 10
tn <- 20
fp <- 17
fn <- 3

fraud <- tn + fp
not_fraud <- tp + fn

cases <- fraud + not_fraud

prediction_acc <- (tp + tn) / cases
random_acc <- fraud / cases
err <- (fp + fn) / cases

# Q2.6 Not a good result as random acc > predict_acc -> Random guesses better than the model

# Q2.7 Overall Error Rate is not a good determinant  as it may be due to the distribution of the data

# Given that random_acc is 0.74, random_err is 0.26 < err

# Instead, it is better to show sensitivity error such as tpr, tfr.

tpr <- tp / (tp + fn)
tnr <- tn / (tn + fp)

# Or Correlation Coefficient Scores

# Q2.8 It depends on whether the model can perform as well on an independent and identically distributed dataset (Test set)

# Q2.9 We should try to do Train-Test splits when we have a sufficiently large dataset to do so.
# However, given a small dataset, we can attempt other methods such as shuffling