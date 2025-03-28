import pandas as pd
import os

def combine_csv_to_excel(folder_path, output_excel_file):
    """Combines all CSV files in a folder into a single Excel file."""

    all_data = pd.DataFrame()  # Initialize an empty DataFrame
    for filename in os.listdir(folder_path):
        if filename.endswith(".csv"):
            filepath = os.path.join(folder_path, filename)
            try:
                df = pd.read_csv(filepath)
                all_data = pd.concat([all_data, df], ignore_index=True)
            except pd.errors.EmptyDataError:
                print(f"Warning: {filename} is empty and was skipped.")

    all_data.to_excel(output_excel_file, index=False)
    print(f"Combined data saved to {output_excel_file}")

# Example usage:
folder_path = "/Users/davidsosa/Code/school/regression-analysis/projects/final-project/data/HeightVsIncome/StateByStateFred"  # Replace with the actual folder path
output_excel_file = "combined_data.xlsx"
combine_csv_to_excel(folder_path, output_excel_file)