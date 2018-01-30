from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup

links=[]
my_url = 'https://dublin.craigslist.org/search/hhh'
uClient = uReq(my_url)
page_html = uClient.read()
uClient.close()

page_soup = soup(page_html, 'html.parser')

containers = page_soup.findAll('a',{'class':'result-title hdrlnk'})

for container in containers: 
    links.append(container['href'])
    
filename = 'CraigsList_hhh.csv'
f = open(filename, 'w')
f.write('Name, Address, Housing, Price, Description\n')

for link in links:
    my_url = link
    uClient = uReq(my_url)
    page_html = uClient.read()
    page_soup = soup(page_html, 'html.parser')
    
    perma_soup = page_soup
    name = page_soup.find('span',{'id':'titletextonly'})
    name=name.text

    page_soup = perma_soup
    addr = page_soup.find('span',{'class':'postingtitletext'})
    addr = str(addr.small)
    addr = addr[9:-9]
    
    page_soup = perma_soup
    housing = page_soup.find('span',{'class':'housing'})
    if housing == None:
        housing = 'NA'
    else:
        housing = housing.text
    
    page_soup = perma_soup
    price = page_soup.find('span',{'class':'price'})
    if price == None:
        price = 'NA'
    else:
        price = price.text
    
    page_soup = perma_soup
    desc = page_soup.find('section',{'id':'postingbody'})
    desc = desc.text[30:]
    desc = desc.split()
    desc = ' '.join(desc)
    
    try:
        f.write(name.replace(',','|') +','+ addr.replace(',','|') + ','+ housing.replace(',','|') + ',' + price.replace(',','|') + ',' + desc.replace(',','|') + '\n')
    except UnicodeEncodeError:
        pass
f.close()