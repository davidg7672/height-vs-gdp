import pandas as pd
import io

data = """
State,Men's Height,Women's Height
Alabama,179+,163-164
Alaska,177-179,163-164
Arizona,177-179,163-164
Arkansas,177-179,163-164
California,177-,163-164
Colorado,177-,163-164
Connecticut,177-179,163-164
Delaware,177-179,163-164
Florida,177-179,163-164
Georgia,177-179,163-164
Hawaii,177-,163-164
Idaho,177-,163-164
Illinois,177-179,163-164
Indiana,177-179,163-164
Iowa,179+,164+
Kansas,179+,164+
Kentucky,179+,163-164
Louisiana,177-179,163-164
Maine,177-179,163-164
Maryland,177-179,163-164
Massachusetts,177-179,163-164
Michigan,177-179,163-164
Minnesota,177-179,164+
Mississippi,177-179,163-164
Missouri,177-179,163-164
Montana,179+,164+
Nebraska,179+,164+
Nevada,177-,163-164
New Hampshire,177-179,163-164
New Jersey,177-,163-
New Mexico,177-,163-
New York,177-,163-
North Carolina,177-179,163-164
North Dakota,179+,164+
Ohio,177-179,163-164
Oklahoma,177-179,163-164
Oregon,177-179,164+
Pennsylvania,177-179,163-164
Rhode Island,177-179,163-
South Carolina,177-179,163-164
South Dakota,179+,164+
Tennessee,177-179,163-164
Texas,179+,164+
Utah,179+,164+
Vermont,177-179,163-164
Virginia,177-179,163-164
Washington,177-179,163-164
West Virginia,179+,163-
Wisconsin,177-179,163-164
Wyoming,179+,164+
"""

df = pd.read_csv(io.StringIO(data))

def calculate_average_height(height_str):
    if '+' in height_str:
        height_str = height_str.replace('+', '')
        return float(height_str)
    elif '-' in height_str:
        parts = height_str.split('-')
        if len(parts) == 2:
            try:
                lower, upper = map(float, parts)
                return (lower + upper) / 2
            except ValueError:
                # Handle cases like "163-" or "177-" where there's only one number
                height_str = height_str.replace('-', '')
                return float(height_str)
        else:
            # Handle cases like "163-" where there's only one number
            height_str = height_str.replace('-', '')
            return float(height_str)
    else:
        return float(height_str)

df['Men\'s Height'] = df['Men\'s Height'].apply(calculate_average_height)
df['Women\'s Height'] = df['Women\'s Height'].apply(calculate_average_height)

print(df)

# To save to a CSV for use in R:
df.to_csv('processed_heights.csv', index=False)
