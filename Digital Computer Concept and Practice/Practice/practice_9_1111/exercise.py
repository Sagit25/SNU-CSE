n = int(input())
a = input()
b = input()

x = y = 0
for i in range(n):
    if a[i] == b[i]:
        continue
    elif (a[i] == 'R' and b[i] == 'S') or (a[i] == 'S' and b[i] == 'P') or(a[i] == 'P' and b[i] == 'R'):
        x += 1
    else: 
        y += 1
        
if x == y:
    print('TIE')
elif x > y:
    print('A {0}'.format(x))
else:
    print('B {0}'.format(y))
    