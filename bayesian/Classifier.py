# Aaron Griffin
# Machine learning on iris data set with scikit-learning

from sklearn import datasets
from sklearn import svm
from sklearn import cross_validation

iris = datasets.load_iris()
# Splits up the data set training data and testing data
x_train, x_test, y_train, y_test = cross_validation.train_test_split(
    iris.data, iris.target, test_size=0.4, random_state=0)

# Trains data based on the training data partitioned previously
clf = svm.SVC(kernel='linear', C=1).fit(x_train, y_train)
score = clf.score(x_test, y_test)

# Computes accuracy of model after training based on cross-validation
cross_scores = cross_validation.cross_val_score(clf, iris.data, iris.target, cv=5)
print('Cross-Validation Test Accuracy: %0.2f (+/- %0.2f)' % (cross_scores.mean(), cross_scores.std() * 2,))
print('Model trained!')

# Prompts for user input for prediction data
answer = raw_input('Enter parameters for prediction? (y/n) ')
while answer == 'y':
    slength = raw_input('Enter a Sepal Length: ')
    swidth = raw_input('Enter a Sepal Width: ')
    plength = raw_input('Enter a Petal Length: ')
    pwidth = raw_input('Enter a Petal Width: ')
    data = [slength, swidth, plength, pwidth]
    prediction = clf.predict(data)
    # Produces best guess of a species for given parameters
    print('Likely a ' + iris.target_names[prediction].tostring() + '.')
    answer = raw_input('Enter more paramters? (y/n)')
