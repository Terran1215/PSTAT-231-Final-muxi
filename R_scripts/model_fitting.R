#set seed
set.seed(1215)
#split data using Stratified sampling
milk_split=initial_split(milk, prop = 0.7, strata = Grade)
milk_train=training(milk_split)
milk_test=testing(milk_split)
# check the number of samples in two groups
dim(milk_train)
dim(milk_test)
milk_folds=vfold_cv(data = milk_train, v = 10, strata = Grade)
# create the recipe
milk_recipe=recipe(Grade ~ ., data = milk_train) %>% 
  # dummy all nominal predictors.
  step_dummy(all_nominal_predictors()) %>%
  # nomalize all predictors
  step_normalize(all_predictors()) 
# set the model
elastic_net_spec=multinom_reg(penalty = tune(), 
                                 mixture = tune()) %>% 
  set_mode("classification") %>% 
  set_engine("glmnet")
# set the workflow
en_workflow=workflow() %>% 
  add_recipe(milk_recipe) %>% 
  add_model(elastic_net_spec)
# set the model
rf_spec=rand_forest(mtry = tune(),min_n=tune()) %>%
  set_engine("ranger", importance = "impurity") %>%
  set_mode("classification")

# set the workflow
rf_wf=workflow() %>%
  add_model(rf_spec) %>%
  add_recipe(milk_recipe)
# set the model
boost_spec=boost_tree(trees = 5000, tree_depth = tune()) %>%
  set_engine("xgboost") %>%
  set_mode("classification")
# set the workflow
boost_wf=workflow() %>%
  add_model(boost_spec) %>%
  add_recipe(milk_recipe)
# set the model
svm_spec=svm_rbf() %>%
  set_mode("classification") %>%
  set_engine("kernlab")
# set the workflow
svm_wf=workflow() %>%
  add_model(svm_spec %>% set_args(cost = tune())) %>%
  add_recipe(milk_recipe)
# set the model
knn_spec=nearest_neighbor(neighbors = tune()) %>%
  set_mode("classification") %>%
  set_engine("kknn")
# set the workflow
knn_wf=workflow() %>%
  add_model(knn_spec) %>%
  add_recipe(milk_recipe)
