#import python libraries
import csv
import random
from faker import Faker

#Initialize
fake = Faker()

#input the number of rows that the csv file should have
num_rows = int(input("Enter the number of rows for the CSV file: "))

#input the name of the csv file (e.g. data.csv)
csv_file = input("Enter the name of the CSV file (e.g. data.csv): ")

#open the csv file
with open(csv_file, mode='w', newline='') as file:
    writer = csv.writer(file)

    #create the header
    header = ['FirstName',
              'LastName',
              'Gender',
              'DOB',
              'Email',
              'Address',
              'City',
              'State',
              'ZipCode',
              'Country',
              'LoyaltyProgramID']

    #write the header to the csv file
    writer.writerow(header)

#loop and generate multiple rowws
    for _ in range(num_rows):
        #generate a single row of data
        row = [
            fake.first_name(),
            fake.last_name(),
            random.choice(['M', 'F', 'Others', 'Not Specified']),
            fake.date_of_birth(),
            fake.email(),
            fake.address().replace(",", " ").replace('\n', ', '),  # Replace newlines in the address with a comma and space
            fake.city(),
            fake.state(),
            fake.zipcode(),
            fake.country(),
            random.randint(1,5) # Assuming there are 5 loyalty programs, you can adjust this range as needed
        ]
        #write the row to the csv file
        writer.writerow(row)


#print success message
print(f"CSV file '{csv_file}' with {num_rows} rows has been created successfully.")