import os, fnmatch, sys

enc = sys.argv[1] == 'encode'

# the first table forces the first code digit to be > 0
TABLES = ["NaN", "WAREHOUSE", "DISTRICT", "CUSTOMER", "HISTORY", "NEW_ORDER", "ORDERS", "ORDER_LINE", "ITEM", "STOCK"]
QUALIFIERS = 'abcdefghijklmnopqrstuvwxyz'

#def encode(item):
#  els = item.split(':')
#  code = str(TABLES.index(els[1])) + els[2].zfill(5) + els[3]  
#  if(len(els) == 5):
#    code = code + str(QUALIFIERS.index(els[4])).zfill(2)
#  return code

codes = {}
count = 0

def encode(item):
  global count
  item = item[item.index(':') + 1:]
  if item not in codes:
    codes[item] = count
    codes[count] = item
    count = count + 1
  return str(codes[item])

def decode(item):
  return codes[int(item)]

# locate most recent file
flist = fnmatch.filter(os.listdir('.'), 'get-ops-*.txt')
flist.sort()
fname = flist[-1]


f = open(fname, "r")
for line in f:
  if line.startswith("###"):
    if enc: print '-2'
  else:
    code = encode(line.strip()) 
    if enc: print code + ' -1',
if enc: print '-2'

if not enc:
  f = open("result", "r")
  for line in f:
    items = line.split(' -1 ')[:-1]
    if len(items) == 1:
      continue

    items = map(decode, items)
    print ' '.join(items)

