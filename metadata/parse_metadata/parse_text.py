
import re
import os
import pandas as pd
from typing import Hashable
from calendar import month_name




def file_to_str(year:int):
    path = os.path.join(os.getcwd(), F'data/text_files/{year}_metadata.txt')
    try:

        with open(path) as p:

            contents = p.read()
        return contents
    except:
        print(f"{path} DNE")


# ## Clean up initial text file

# In[3]:


def clean_regex(pluto_text:str):
    single = '\n[\s\S]\n'
    page_num = '\n\d+\n'
    comb = single + '|' + page_num

    try:
        return re.sub(comb, '\n', pluto_text)
    except:
        print("exc")



# In[4]:


def mk_pluto_headers():
    pluto_dd = "PLUTO.? DATA DICTIONARY"

    header_list = []
    for m in list(month_name[1:]):
        header_list.append(pluto_dd + "\s*"+ m + " 200\d")
        header_list.append( m + " 200\d" + "\s*" + pluto_dd)

    return '|'.join(header_list)


# In[5]:


HEADS = mk_pluto_headers()


# In[6]:


def metadata_list(pluto_string:str):
        matches = re.split('Field Name:\s?', pluto_string)
        l = []
        for match in matches:
            if '. . .' not in match and '...' not in match:
                field = re.split('Format:\s?|Data Source:\s?|Description:\s?', match)
                for i in range(0, len(field)):
                    field[i] = re.sub('\s$', '', field[i])
                    field[i] = re.sub('[\s\n]{2,}', ' ', field[i])
                    field[i] = re.sub('\n', '', field[i])

                l.append(field)
        return l


# In[7]:


def text_to_df(yr):
    pluto_text = file_to_str(yr)
    txt = clean_regex(pluto_text)
    txt = re.sub(HEADS, '\n', txt)
    spl_text = metadata_list(txt)
    col_names = ['field_name', 'format', 'source', 'description']
    try:
        df = pd.DataFrame(spl_text, columns=col_names)
        df['year'] = yr
        return df
    except:
        print(f"there was an issue with {yr}")



# In[8]:


# text_to_df(2004)
l = []

for i in range(2004, 2021):
    if i != 2008:
        l.append(text_to_df(i))


# In[9]:


pd.concat(l)


# In[ ]:


def normalize(col_name: Hashable) -> str:
    fixes = [(r"[ /:,?()\.-]", "_"), (r"['’]", "")]
    """Perform normalization of column name."""
    result = str(col_name)
    for search, replace in fixes:
        result = re.sub(search, replace, result)
    return result


# In[ ]:


def clean_df(df):


    split_field = d.field_name.str.split('\s\(', expand = True)

    d['friendly_name'] = split_field.iloc[:,0]
    d['field_name'] = split_field.iloc[:,1]                      .str.replace(')', '', regex = False)

    d['field_name'] = df['field_name'].str.lower()
    d['field_name'] = d['field_name'].apply(normalize)
    return d
