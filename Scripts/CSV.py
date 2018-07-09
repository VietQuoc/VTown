import csv

def create_and_write_file(filename, *line):
    ''' Create new csv file with first data in A1 cell!
        Input path of filename. ex test_data/compliance/exp_filter_v2/filename.csv
    '''
        
    with open(filename, "a", newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        for i in line:
            writer.writerow([i])

def read_data_file(name):
    with open(name, 'r') as f:
        reader = csv.reader(f)
        your_list = list(reader)
    return your_list