# [https://www.yahoo.com/somerandomstring, http://www.yahoo.com/some/random/string, http://www.google.com]
import re

def condense(arr):
    d = {}
    output = []
    domain = re.compile(r'www.\w*.\w*')
    cleanarr = domain.findall(''.join(arr))
    for i in cleanarr:
        if i in d:
            d[i] += 1
        else:
            d[i] = 1
    
    for k,v in d.items():
        output.append(k+' '+str(v))
    return output
print(condense(["https://www.yahoo.com/somerandomstring", "http://www.yahoo.com/some/random/string", "http://www.google.com"]))