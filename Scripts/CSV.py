import csv

def create_and_write_file_txt(filename, *line):
    ''' Create new csv file with first data in A1 cell!
        Input path of filename. ex test_data/compliance/exp_filter_v2/filename.csv
    '''
        
    with open(filename, "a", newline='', encoding='utf-8') as file:
        for i in line:
            file.write(i+"\n")
    file.close()
    
def read_data_file(name, index=0):
    f = open(name, mode='r', encoding="utf8")
    f1 = f.readlines()
    your_list = []
    for i in f1:
        i = i[:-int(index)]
        your_list.append(i)
    f.close()
    return your_list

def work_csv_file(filename,mot,hai,ba,bon,nam,sau,bay,tam,chin,muoi,mmot,mhai,mba):
    ''' Create new csv file with first data in A1 cell!
        Input path of filename. ex test_data/compliance/exp_filter_v2/filename.csv
    '''
    
    csvfile = open(filename, "a", newline='', encoding='utf-8')
    writer = csv.writer(csvfile)
    writer.writerow([mot,hai,ba,bon,nam,sau,bay,tam,chin,muoi,mmot,mhai,mba])
    csvfile.close()
    
