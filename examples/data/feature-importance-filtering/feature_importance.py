#!/bin/python

#
# Copyright 2020 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

from sklearn.feature_selection import RFE, VarianceThreshold
from sklearn.linear_model import LogisticRegression

import statsmodels.api as sm

import pandas as pd
import numpy as np

RANDOM_SEED = 42
FEATURE_IMPORTANCE_CUTOFF = 0.00099
P_VALUES_STD_CUTOFF = 0.05


def convert_columns_into_categorical(dataset):
    """
    Replace all the categorical columns in the dataset with type category,
    and their values with the category codes instead of just text or string numbers.

    :param dataset:
        raw dataset with one or more categories

    :return:
        dataset with catogries replaced
    """
    categorical_feature_mask = dataset.dtypes == object
    categorical_cols = dataset.columns[categorical_feature_mask].tolist()
    if categorical_cols:
        dataset[categorical_cols] = dataset[categorical_cols].astype('category')
        for each_col in dataset[categorical_cols]:
            dataset[each_col] = dataset[each_col].cat.codes
    return dataset


def get_feature_importance_with_regression_method(X_train, y_train, features_to_select: int = 20):
    """
    Return a list of features by importance based on the training dataset set passed in.
    A quick Logistic regression is performed on the dataset (hence the split parameters).
    Further feature ranking with Recursive Feature Elimination (RFE) is applied
    (see https://scikit-learn.org/stable/modules/generated/sklearn.feature_selection.RFE.html).

    :param X_train:
        The features part of the dataset (hence X_train).

    :param y_train:
        The target or label part of the dataset (hence y_train).

    :return:
        A list of features by importance are returned after applying above methods.

    Credits:
        Inspired by blog post https://towardsdatascience.com/building-a-logistic-regression-in-python-step-by-step-becd4d56c9c8
        Credits to Susan Li (https://medium.com/@actsusanli)

    """
    X_train = convert_columns_into_categorical(X_train)

    logreg = LogisticRegression(random_state=RANDOM_SEED)
    rfe = RFE(logreg, features_to_select)
    rfe = rfe.fit(X_train, y_train)

    return X_train.columns[rfe.support_]


# https://www.wallstreetmojo.com/normalization-formula/
def normalize(values: np.ndarray) -> np.ndarray:
    return (values - values.min()) / (values.max() - values.min()) 


# Issue: Singularity Matrix error by Logit() method
# https://stackoverflow.com/questions/20703733/logit-regression-and-singular-matrix-error-in-python
def variance_threshold_selector(data: pd.DataFrame, threshold: float = 0.5) -> pd.DataFrame:
    selector = VarianceThreshold(threshold)
    selector.fit(data)
    return data[data.columns[selector.get_support(indices=True)]]


def get_feature_importance_with_logit_method(X_train, y_train, 
                                             method: str = None,
                                             show_summary_only: bool = False, 
                                             remove_low_variance_cols = False, variance_threshold: float = 0.05,
                                             p_values_cutoff: float = P_VALUES_STD_CUTOFF):
    """
    Return a list of features by importance based on the training dataset set passed in.
    A quick Logit fitting is performed on the dataset (hence the split parameters).
    Then based on the p-values of each of the columns

    :param X_train:
        The features part of the dataset (hence X_train).

    :param y_train:
        The target or label part of the dataset (hence y_train).

    :param method
        The method to use as optimiser.
        Defaults to None, other option is 'bfgs' which is known to work in many cases

    :param remove_low_variance_cols:
        Drops those columns/features that have a low variance before passing them to the Logit function.
        If remove_low_variance_cols = False, then the variance_threshold value won't be used.
        Defaults to False.

    :param variance_threshold:
        The minimum tolerance value beyond which such columns can be considered to be dropped.
        This parameter will be ignore if remove_low_variance_cols=False
        Defaults to 0.05.

    :param show_summary_only:
        Does not return filtered features but the whole summary table returned by the Logit function.
        If show_summary_only = True, then the p_values_cutoff value won't be used.
        Defaults to False.

    :param p_values_cutoff:
        The cut-off value to use when filtering feature importance.
        All feature with p-value less than this value will be eliminated from the return list.
        This parameter will be ignore if show_summary_only=True
        Defaults to 0.05.

    :return:
        A table of features by importance are returned after applying above methods.
        Table two fields, feature name and it's p-value. (if show_summary_only=False).
        Or
        The original summary table returned by Logit (if show_summary_only=True).

    Credits:
        Inspired by blog post https://towardsdatascience.com/building-a-logistic-regression-in-python-step-by-step-becd4d56c9c8
        Credits to Susan Li (https://medium.com/@actsusanli)
    """
    X_train = convert_columns_into_categorical(X_train)
    if remove_low_variance_cols: 
        X_train = variance_threshold_selector(X_train, variance_threshold)
    y_train = normalize(y_train)

    logit_model = sm.Logit(y_train, X_train, random_state=RANDOM_SEED)
    try:
        if method: 
            training_results = logit_model.fit(method=method)
        else:
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
    """
    Return a list of features by importance based on the training dataset and model passed in.
    Many models return feature importance in the form of coefficents per feature or list of important features.
    Based on ElasticNet the below implementation looks for coefficents returned.

    :param X_train:
        The features part of the dataset (hence X_train).

    :param model:
        The model created after training has been performed using the dataset.

    :return:
        A table of features by importance are returned after applying above methods.
        Table two fields, feature name and it's coefficient value derived during training.

    Credits:
        Inspired by ElasticNet, thanks Carlo (@CarloLepelaars) for recommending
        it to me during our bitgrit SB FX competition
    """
    try:
        feature_importance = pd.Series(index=X_train.columns, data=np.abs(model.coef_))

        n_selected_features = (feature_importance > FEATURE_IMPORTANCE_CUTOFF).sum()
        reduction_in_features = (1 - n_selected_features / len(feature_importance)) * 100
        print('{0:d} features, reduction of {1:2.2f}% (feature importance cutoff score: {2:0.5f} and higher)'.format(
            n_selected_features, reduction_in_features, FEATURE_IMPORTANCE_CUTOFF)
        )

        return feature_importance.sort_values(ascending=False)
    except:
        print("~~~ This kind of model does not support coefficients which is used to generate feature importance")
