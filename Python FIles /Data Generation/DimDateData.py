#import pandas library
import pandas as pd

# start data and end date between which we need to generate the date data
start_date = '2016-01-01'
end_date = '2026-12-31'

#generate a series of dates between the start date and end date 
date_series = pd.date_range(start=start_date, end=end_date)
# print(date_series)

#convert these series of dates into a dataframe
date_dimension = pd.DataFrame(date_series, columns=['Date'])

#add new columns to our dataframe
date_dimension['DayofWeek'] = date_dimension['Date'].dt.dayofweek
date_dimension['Month'] = date_dimension['Date'].dt.month
date_dimension['Quarter'] = date_dimension['Date'].dt.quarter
date_dimension['Year'] = date_dimension['Date'].dt.year
date_dimension['IsWeekend'] = date_dimension['DayofWeek'].isin([5,6]) # Assuming 5 and 6 represent Saturday and Sunday respectively, you can adjust this if needed
date_dimension['DateID'] = date_dimension['Date'].dt.strftime('%Y%m%d').astype(int) # Create a DateID in the format YYYYMMDD

#reorder our dataframe so that the dateId column is the first column
cols = ['DateID'] + [col for col in date_dimension.columns if col != 'DateID']
date_dimension = date_dimension[cols]

#export the dataframe to a csv file ignoring the index
date_dimension.to_csv('../../Data/DimDateData.csv', index=False)