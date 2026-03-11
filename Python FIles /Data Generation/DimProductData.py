#import python libraries
import pandas as pd
import csv
import random

#input the number of rows that the csv file should have
num_rows = int(input("Enter the number of rows for the CSV file: "))

#input the name of the csv file (e.g. data.csv)
csv_file = input("Enter the name of the CSV file (e.g. data.csv): ")

# details of the excel file that has the lookup data, File Path and Name, Sheet Name, Column Names for the lookup data
lookup_file_path = '/Users/sj/Desktop/OfflineRetailProject/LookupFile.xlsx'

lookup_sheet_name_product = "Raw Product Names" # Assuming the sheet name is "Raw Product Names", you can change this if needed
product_column_name = 'Product Name' # Assuming the column name for product names is "Product Name", you can change this if needed
lookup_sheet_name_category = "Product Categories" # Assuming the sheet name is "Product Categories", you can change this if needed
category_column_name = 'Category Name' # Assuming the column name for categories is "Category Name", you can change this if needed

# fetch the sheet data in a dataframe
lookup_df_product = pd.read_excel(lookup_file_path, sheet_name=lookup_sheet_name_product)
lookup_df_category = pd.read_excel(lookup_file_path, sheet_name=lookup_sheet_name_category)

#open the csv file
with open(csv_file, mode='w', newline='',) as file:
    writer = csv.writer(file)

    #create the header
    header = [
              'ProductName',
              'Category',
              'Brand',
              'UnitPrice'
            ]

    #write the header to the csv file
    writer.writerow(header)

#loop and generate multiple rowws
    for _ in range(num_rows):
    
        #generate a single row of data  
        row = [
            lookup_df_product[product_column_name].sample(n=1).values[0], # Randomly select a product name from the lookup data
            lookup_df_category[category_column_name].sample(n=1).values[0], # Randomly select a category from the lookup data
            random.choice(['FakeLuxeAura', 'FakeUrbanGlow', 'FakeEtherealEdge', 'FakeVelvelVista', 'FakeZenithStyle']), # Randomly select a brand name, you can adjust the options as needed
            random.randint(100, 1000) # Generate a random unit price between 100 and 1000, you can adjust the range as needed
        ]
        #write the row to the csv file
        writer.writerow(row)

#print success message
print(f"CSV file '{csv_file}' with {num_rows} rows has been created successfully.")