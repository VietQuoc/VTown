import  urllib


def download_file(url, file_name):
        urllib.request.urlretrieve(url, file_name)

def get_number_company(text):
    a,b = text.split(":")
    c,d,e = b.strip().split(" ")
    return c

def convert_number_company_to_number_page(nc):
    a = int(nc) // 10;
    b = float(nc) // 10;
    if b > 0 :
        a = a + 1
    return a