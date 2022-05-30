s = str(input())
ans = str()
e = n = 0
for i in range(0, len(s)):
    if 'A' <= s[i] <= 'Z' or 'a' <= s[i] <= 'z':
        e += 1
    else:
        n += 1

if e == 0: 
    ans += 'E'
if len(s) < 8: 
    ans += 'L'
if n <= 2:
    ans += 'N'

if len(ans) == 0:
    print('*' * len(s))
else:
    for i in ans:
        if i != ans[len(ans)-1]: 
            print(i, end=",")
        else:
            print(i)