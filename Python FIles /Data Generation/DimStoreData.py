#import python libraries
import pandas as pd
import csv
import random
from faker import Faker

#Initialize
fake = Faker()

#input the number of rows that the csv file should have
num_rows = int(input("Enter the number of rows for the CSV file: "))

#input the name of the csv file (e.g. data.csv)
csv_file = input("Enter the name of the CSV file (e.g. data.csv): ")

# details of the excel file that has the lookup data, File Path and Name, Sheet Name, Column Names for the lookup data
lookup_file_path = '/Users/sj/Desktop/OfflineRetailProject/LookupFile.xlsx'
lookup_sheet_name = "Store Name Data" # Assuming the sheet name is "Store Name Data", you can change this if needed
adjective_column_name = 'Adjectives' # Assuming the column name for adjectives is "Adjectives", you can change this if needed
noun_column_name = 'Nouns' # Assuming the column name for nouns is "Nouns", you can change this if needed

# fetch the sheet data in a dataframe
lookup_df = pd.read_excel(lookup_file_path, sheet_name=lookup_sheet_name)

#open the csv file
with open(csv_file, mode='w', newline='',) as file:
    writer = csv.writer(file)

    #create the header
    header = [
              'StoreName',
              'StoreType',
              'StoreOpeningDate',
              'Address',
              'City',
              'State',
              'Country',
              'Region',
              'ManagerName'
            ]

    #write the header to the csv file
    writer.writerow(header)

#loop and generate multiple rowws
    for _ in range(num_rows):
        #select a random adjective and noun from the lookup data and concatenate it with "The" to create a store name, you can adjust the format as needed
        random_adjective = lookup_df[adjective_column_name].sample(n=1).values[0]
        random_noun = lookup_df[noun_column_name].sample(n=1).values[0]
        store_name = f"The {random_adjective} {random_noun}"
        #generate a single row of data  
        row = [
            store_name,
            random.choice(['Exclusive', 'MBO', 'SMB', 'Outlet Stores']), # Randomly select a store type, you can adjust the options as needed
            fake.date(), # Generate a random opening date 
            fake.address().replace(",", " ").replace('\n', ', '),  # Replace newlines in the address with a comma and space
            fake.city(),
            fake.state(),
            fake.country(),
            random.choice(['North', 'South', 'East', 'West']), # Randomly assign a region, you can adjust the options as needed
            fake.first_name() # Generate a random manager name
        ]
        #write the row to the csv file
        writer.writerow(row)

#print success message
print(f"CSV file '{csv_file}' with {num_rows} rows has been created successfully.")