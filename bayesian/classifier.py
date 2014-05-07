#!/usr/bin/python2
# Docstring
"""Machine learning on iris data set with scikit-learning"""
__author__ = "Aaron Griffin"

from sklearn import datasets, svm, cross_validation
import numpy as np

# Checks to see if there is at least 1 standard deviation between the predicted value and the rest
def check_difference(prob, prediction):
    standard_deviation = np.std(prob, axis=0)
    cluster = []
    for i in range(len(prob) - 1):
        if abs(prob[i] - prob[i+1]) < standard_deviation and (i == prediction or i+1 == prediction):
            cluster.append((i, i+1))
        elif abs(prob[i] - prob[i-1]) < standard_deviation and (i == prediction or i-1 == prediction):
            cluster.append((i, i-1))
    return cluster

# Prints the names and probabilities of clustered probabilities
def print_cluster(data, cluster, prob):
    print("Inconclusive Results! There is less than a standard deviation between: ")
    for i in cluster:
        print('{0}: {1:.2f}%, {2}: {3:.2f}%'.format(data.target_names[i[0]].tostring(), prob[i[0]]*100,
                                                  data.target_names[i[1]].tostring(), prob[i[1]]*100))

# Loads the iris dataset from the scikit learn module
iris = datasets.load_iris()

# Splits up the data set training data and testing data
# THis is a random split
x_train, x_test, y_train, y_test = cross_validation.train_test_split(
    iris.data, iris.target, test_size=0.4, random_state=0)

# Trains data based on the training data partitioned previously
clf = svm.SVC(kernel='linear', C=1, probability=True).fit(x_train, y_train)

SCORE = clf.score(x_test, y_test)

# Computes accuracy of model after training based on cross-validation
CROSS_SCORES = cross_validation.cross_val_score(clf, iris.data, iris.target, cv=5)
print('Cross-Validation Test Accuracy: %0.2f (+/- %0.2f)' % (CROSS_SCORES.mean() * 100, CROSS_SCORES.std() * 2,))
print('Model trained!')

# Prompts for user input for prediction data
answer = raw_input('Enter parameters for prediction? (y/n) ')
while answer == 'y':
    SLENGTH = raw_input('Enter a Sepal Length: ')
    SWIDTH = raw_input('Enter a Sepal Width: ')
    PLENGTH = raw_input('Enter a Petal Length: ')
    PWIDTH = raw_input('Enter a Petal Width: ')
    data = [SLENGTH, SWIDTH, PLENGTH, PWIDTH]
    prediction = clf.predict(data)
    probabilities = clf.predict_proba(data)[0]
    # Check to see if the prediction is a good one
    cluster_list = check_difference(probabilities, prediction)
    if cluster_list:
        # If probabilities are close print out what it's close to
        print_cluster(iris, cluster_list, probabilities)
    print('{0:.2f}% chance it is a {1}.'.format(float(probabilities[prediction]) * 100, iris.target_names[prediction].tostring()))
    answer = raw_input('Enter more parameters? (y/n) ')
