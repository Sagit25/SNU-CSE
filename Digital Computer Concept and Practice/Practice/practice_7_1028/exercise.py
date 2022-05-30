pres = input()
s = list(''.join(pres.split()))
flag = 0

for i in range(int(len(s)/2)):
    if ord(s[i]) == ord(s[len(s)-1-i]) or ord(s[i]) == ord(s[len(s)-1-i])+32 or ord(s[i])+32 == ord(s[len(s)-1-i]):
        continue
    else:
        flag = 1
        break

if flag == 1:
    print(False)
else:
    print(True)