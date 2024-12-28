import pandas as pd
import evaluate_models as em

# Replace 'your_file.csv' with the path to your CSV file
file_path = "dataset_ml20241212.csv"

# Read the CSV file
data = pd.read_csv(file_path)

# Display the first few rows of the dataframe
print(data.head())

# Call the function with the data
# ! Criado para ter um padrao de comparacao.
em.evaluate_models(data)
