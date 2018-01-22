import os, fnmatch, sys, time

# chunk size
n = int(sys.argv[1])
size = int(sys.argv[2])

# locate most recent file
flist = fnmatch.filter(os.listdir('.'), 'get-ops-*.txt')
flist.sort()
fname = flist[-1]

f_out_name = "sequences/gets/get-ops-%d.txt"
cur_time = lambda: int(round(time.time() * 1000))

count_chunks = 0
f_out = open(f_out_name % count_chunks, 'w')
count = 0
f = open(fname, "r")
for line in f:
  if line.startswith("###"):
    if count == size:
      f_out.close()
      count_chunks = count_chunks + 1
      if count_chunks == n:
        break
      f_out = open(f_out_name % count_chunks, 'w')
      count = 0
    count = count + 1
  f_out.write(line)
f.close()
