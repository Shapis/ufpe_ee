from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score
import numpy as np
from sklearn.metrics import confusion_matrix


def evaluate_models(data):
    # Assuming the last column is the target variable
    X = data.iloc[:, :-1]
    y = data.iloc[:, -1]

    # Split the data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Initialize the Gaussian Naive Bayes classifier
    gnb = GaussianNB()

    # Fit the model to the training data
    gnb.fit(X_train, y_train)

    # Predict the labels for the test set
    y_pred = gnb.predict(X_test)

    # Calculate the accuracy of the model
    accuracy = accuracy_score(y_test, y_pred)

    # Add a column of ones to the feature matrix for the intercept term
    X_train_b = np.c_[np.ones((X_train.shape[0], 1)), X_train]
    X_test_b = np.c_[np.ones((X_test.shape[0], 1)), X_test]

    # Compute the pseudo-inverse of the training feature matrix
    X_pseudo_inverse = np.linalg.pinv(X_train_b)

    # Compute the weights using the pseudo-inverse
    weights = X_pseudo_inverse.dot(y_train)

    # Predict the labels for the test set
    y_pred_ls = X_test_b.dot(weights)

    # Calculate the mean squared error of the model
    mse = np.mean((y_pred_ls - y_test) ** 2)
    print(f"Mean Squared Error: {mse:.2f}")

    # Calculate the confusion matrix for the Gaussian Naive Bayes model
    conf_matrix_gnb = confusion_matrix(y_test, y_pred)
    print("Confusion Matrix for Gaussian Naive Bayes:")
    print(conf_matrix_gnb)

    # Calculate the confusion matrix for the Least Squares model
    y_pred_ls_class = np.round(y_pred_ls).astype(int)
    conf_matrix_ls = confusion_matrix(y_test, y_pred_ls_class)
    print("Confusion Matrix for Least Squares:")
    print(conf_matrix_ls)

    # Calculate the average MSE and standard deviation for both models
    mse_gnb = np.mean((y_pred - y_test) ** 2)
    mse_ls = np.mean((y_pred_ls - y_test) ** 2)

    std_gnb = np.std((y_pred - y_test) ** 2)
    std_ls = np.std((y_pred_ls - y_test) ** 2)

    print(
        f"Gaussian Naive Bayes - Mean Squared Error: {mse_gnb:.2f}, Standard Deviation: {std_gnb:.2f}"
    )
    print(
        f"Least Squares - Mean Squared Error: {mse_ls:.2f}, Standard Deviation: {std_ls:.2f}"
    )
