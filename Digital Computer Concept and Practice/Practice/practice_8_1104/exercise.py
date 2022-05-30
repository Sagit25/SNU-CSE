s = input()
a = [-1] * 26

for i in range(len(s)):
    if ord(s[i]) < ord('A') or ord(s[i]) > ord('z') or ord('Z') < ord(s[i]) < ord('a'):
        continue
    if ord(s[i]) >= ord('a') and a[ord(s[i])-ord('a')] == -1:
        a[ord(s[i])-ord('a')] = i
    elif ord(s[i]) < ord('a') and a[ord(s[i])-ord('A')] == -1:
        a[ord(s[i])-ord('A')] = i

for i in range(26):
    print(a[i], end=" ") 