a, b, n = map(int, input().split())
res = []
ans = 0

for i in range(a, b+1):
    cnt = 0
    for j in range(1, i+1): 
        if i % j == 0: 
            cnt += 1
    if n == cnt:
        ans += 1
        res.append(i)

if ans == 0:
    print("no value between {0} and {1} with a divisor number of {2}.".format(a, b, n))
else:
    for i in res:
        print(i)
