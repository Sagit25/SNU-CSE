s = input()
k = []
flag = 0

for i in s:
    if i == '(' or i == '{' or i =='[':
        k.append(i)
    elif i == ')':
        if len(k) >= 1 and k[len(k)-1] == '(':
            k.pop()
        else:
            flag = 1
            break
    elif i == '}':
        if len(k) >= 1 and k[len(k)-1] == '{':
            k.pop()
        else:
            flag = 1
            break   
    elif i == ']':
        if len(k) >= 1 and k[len(k)-1] == '[':
            k.pop()
        else:
            flag = 1
            break 
    else:
        continue

if flag == 0 and len(k) == 0:
    print('True')
else:
    print('False')