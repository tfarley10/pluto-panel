from bs4 import BeautifulSoup
import os
import re
import pandas as pd


def remove_multiple_space(string:str):
    
    return re.sub('\n+', '\n', string)


def pad_list(lst:[], size:int):
    new_lst = lst + [''] * (size - len(lst))
    return new_lst


def parse_attribute(att:str):
    att2 = att.strip()
    sp_2 = 'Attribute Definition:|Attribute Definition Source:|Attribute Domain Values:'
    att3 = re.split(sp_2, att2)
    att4 = [a.strip() for a in att3]
    att5 = pad_list(att4, 4)
    return att5


def meta_list(html_string):
    attribute_spl = "Attribute:\nAttribute Label:"
    atts = re.split(attribute_spl, html_string)
    result = [parse_attribute(a) for a in atts]
    return result[1:]


def html_to_df(year:int):
    if year == 2002:
        file_name = '2002.htm'
    else:
        file_name = '2003.html'
        
    m_path = os.path.join(os.getcwd(), 'parse_metadata/data/pdf')
    samp = os.path.join(m_path, file_name)
    
    with open(samp, 'rb') as fp:
        soup = BeautifulSoup(fp,  "html")
    
    txt = soup.get_text('\n')
    t2 = remove_multiple_space(txt)
    l = meta_list(t2)
    
    cols = ['field_name', 'definition', 'source', 'domain_definitions']
    df = pd.DataFrame(l, columns = cols)
    df['year'] = year
    return df


def main():
    out_path = os.path.join(os.getcwd(), 'parse_metadata/data/html_metadata.csv')
    if os.path.isfile(out_path):
        print("file exists")
    else:

        years = [2002, 2003]
        df_list = [html_to_df(y) for y in years]
        d = pd.concat(df_list)
        print(d)
        d.to_csv(out_path, index=False)


if __name__ == "__main__":
    main()







