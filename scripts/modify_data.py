import pandas as pd

# Load the data
df = pd.read_excel('./combined_data.xlsx')

# Melt the data to long format
melted_df = pd.melt(
    df, 
    id_vars=['observation_date'], 
    var_name='State_Code', 
    value_name='Median_Income'
)

# Extract state abbreviations from the codes (assuming the format is consistent)
melted_df['State'] = melted_df['State_Code'].str.extract(r'MEHOINUS([A-Z]{2})A672N')

# Drop rows with missing income values
melted_df = melted_df.dropna(subset=['Median_Income'])

# Save the reorganized data
melted_df.to_excel('reorganized_data.xlsx', index=False)