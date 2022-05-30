b = str(input())
a = []

for i in b:
    a.append(i)

def rps(a, b):
    if (a == 'R' and b == 'S') or (a == 'S' and b == 'P') or (a == 'P' and b == 'R'):
        return 1
    else:
        return 0

i = 1
while i != len(a):
    for j in range(0, len(a), 2*i):
        x = y = 0
        for k in range(i):
            x += rps(a[j+k], a[j+k+i])
            y += rps(a[j+k+i], a[j+k])
        if y > x:
            for k in range(i):
                a[j+k], a[j+i+k] = a[j+i+k], a[j+k]   
    i *= 2
    
for i in a:
    print(i, end="")