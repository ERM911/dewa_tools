function C = get_confusion_matrix(y_test,y_predict)

[C,order] = confusionmat(y_test,y_predict);

C
