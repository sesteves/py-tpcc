import os, fnmatch

TABLES = ["NaN", "WAREHOUSE", "DISTRICT", "CUSTOMER", "HISTORY", "NEW_ORDER", "ORDERS", "ORDER_LINE", "ITEM", "STOCK"]
QUALIFIERS = 'abcdefghijklmnopqrstuvwxyz'

def decode(item):
  assert len(item) == 9 or len(item) == 7

  text = TABLES[int(item[0])] + ':' + str(int(item[1:6])) + ':' + item[6]
  if(len(item) == 9):
    text = text + ':' + QUALIFIERS[int(item[7:])]
  return text

f = open("result", "r")
for line in f:
  items = line.split(' -1 ')[:-1]
  if len(items) == 1:
    continue

  items = map(decode, items)
  print ' '.join(items)
