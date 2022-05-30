a, b = map(str, input().split())
ans = 0
for i in range(0, min(len(a), len(b))):
    if '0' <= a[i] <= '9':
        if '0' <= b[i] <= '9' and b[i] < a[i]:
            ans = 2
            break
        elif '0' <= b[i] <= '9' and b[i] > a[i]:
            ans = 1
            break
        elif b[i] >= 'A':
            ans = 1
            break
    else:
        oa = ord(a[i]) 
        ob = ord(b[i])
        if '0' <= b[i] <= '9':
            ans = 2
            break
        if 'a' <= a[i]:
            oa -= 32
        if 'a' <= b[i]:
            ob -= 32
        if ob < oa:
            ans = 2
            break
        elif ob > oa:
            ans = 1
            break
if ans == 0:
    if len(b) < len(a):
        print("%s %s" %(b, a))
    else:
        print("%s %s" %(a, b))
elif ans == 1:
    print("%s %s" %(a, b))
else:
    print("%s %s" %(b, a))
