from sklearn.feature_selection import RFE
from sklearn.linear_model import LogisticRegression

import statsmodels.api as sm

import pandas as pd

RANDOM_SEED = 42
FEATURE_IMPORTANCE_CUTOFF = 0.00099
P_VALUES_STD_CUTOFF = 0.05


def convert_columns_into_categorical(dataset):
    categorical_feature_mask = dataset.dtypes == object
    categorical_cols = dataset.columns[categorical_feature_mask].tolist()
    if categorical_cols:
        dataset[categorical_cols] = dataset[categorical_cols].astype('category')
        for each_col in dataset[categorical_cols]:
            dataset[each_col] = dataset[each_col].cat.codes
    return dataset


def get_feature_importance_with_regression_method(X_train, y_train):
    X_train = convert_columns_into_categorical(X_train)

    logreg = LogisticRegression(random_state=RANDOM_SEED)
    rfe = RFE(logreg, 20)
    rfe = rfe.fit(X_train, y_train)

    return X_train.columns[rfe.support_]


def get_feature_importance_with_logit_method(X_train, y_train, show_summary_only=False, p_values_cutoff=P_VALUES_STD_CUTOFF):
    X_train = convert_columns_into_categorical(X_train)

    logit_model = sm.Logit(y_train, X_train, random_state=RANDOM_SEED)
    try:
        training_results = logit_model.fit()
        summary = training_results.summary2()
        if show_summary_only:
            return summary

        p_values_col_name = 'P>|z|'
        p_values_column = summary.tables[1][p_values_col_name]
        p_values_greater_than_cutoff = p_values_column >= p_values_cutoff

        pd.options.display.float_format = '{:.15f}'.format

        return p_values_column[p_values_greater_than_cutoff].sort_values(ascending=False)
    except Exception as ex:
        print("Couldn't completely run the process, due to an error:", ex)


def get_feature_importance_after_training(X_train, model):
    try:
        feature_importance = pd.Series(index=X_train.columns, data=np.abs(model.coef_))

        n_selected_features = (feature_importance > FEATURE_IMPORTANCE_CUTOFF).sum()
        reduction_in_features = (1 - n_selected_features / len(feature_importance)) * 100
        print('{0:d} features, reduction of {1:2.2f}% (feature importance cutoff score: {2:0.5f} and higher)'.format(
            n_selected_features, reduction_in_features, FEATURE_IMPORTANCE_CUTOFF)
        )
        print("~~~ Printing all features in the order of importance:")
        print(feature_importance.sort_values(ascending=False))
    except:
        print("~~~ This kind of model does not support coefficients which is used to generate feature importance")
