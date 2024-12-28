import pandas as pd
import naive_bayes_classifier as nbc
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score
import numpy as np
from sklearn.metrics import confusion_matrix


# Replace 'your_file.csv' with the path to your CSV file
file_path = "dataset_ml20241212.csv"

# Read the CSV file
data = pd.read_csv(file_path)

# Display the first few rows of the dataframe
# print(data.head())

# Call the function with the data
# ! Criado para ter um padrao de comparacao.
# em.evaluate_models(data)

# Example usage:

# Assuming the last column is the target variable
x = data.iloc[:, :-1].values
y = data.iloc[:, -1].values

# Split the data into training and testing sets
x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.2, random_state=42
)

classificador_bayes = nbc.NaiveBayesClassifier()
classificador_bayes.fit(x_train, y_train)
y_prediction = classificador_bayes.predict(x_test)

# Calculate the accuracy of the model
accuracy = accuracy_score(y_test, y_prediction)
print(f"Accuracy: {accuracy:.2f}")

# Calculate the mean squared error (MSE)
mse = np.mean((y_test - y_prediction) ** 2)
print(f"Mean Squared Error: {mse:.2f}")

# Calculate the standard deviation of the prediction errors
std_dev = np.std(y_test - y_prediction)
print(f"Standard Deviation: {std_dev:.2f}")

# Calculate the confusion matrix
conf_matrix = confusion_matrix(y_test, y_prediction)
print("Confusion Matrix:")
print(conf_matrix)
