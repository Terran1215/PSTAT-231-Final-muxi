roc_auc=c(en_roc_auc$.estimate, rf_roc_auc$.estimate, boost_roc_auc$.estimate, svm_roc_auc$.estimate,knn_roc_auc$.estimate)
models=c("Elastic net", "Random Forest", "Boosted Trees", "Support vector machine","K-nearest neighbors")
# create a tibble
results=tibble(roc_auc = roc_auc, models = models)
results %>% 
  arrange(-roc_auc)
# fit the best Random Forests model
predicted_data=augment(rf_final_fit, new_data = milk_test) %>% 
  select(Grade, starts_with(".pred"))
predicted_data %>% roc_auc(Grade, .pred_high:.pred_low)
# show the autoplot
predicted_data %>% roc_curve(Grade, .pred_high:.pred_low) %>% 
  autoplot()
# show the heat map of the confusion matrix
predicted_data %>% 
  conf_mat(truth = Grade, estimate = .pred_class) %>%
  autoplot(type = "heatmap")