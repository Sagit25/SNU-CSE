n = int(input())
ment = 10000
mbir = 100000000
mans = ''
Ment = 0
Mbir = 0 
Mans = ''

for i in range(n):
    a = list(input().split())
    
    if ment > int(a[4]):
        ment = int(a[4])
        mbir = int(a[3])*10000+int(a[2])*100+int(a[1])
        mans = a[0]
    elif ment == int(a[4]) and mbir > int(a[3])*10000+int(a[2])*100+int(a[1]):
        mbir = int(a[3])*10000+int(a[2])*100+int(a[1])
        mans = a[0]

    if Ment < int(a[4]):
        Ment = int(a[4])
        Mbir = int(a[3])*10000+int(a[2])*100+int(a[1])
        Mans = a[0]
    elif Ment == int(a[4]) and Mbir < int(a[3])*10000+int(a[2])*100+int(a[1]):
        Mbir = int(a[3])*10000+int(a[2])*100+int(a[1])
        Mans = a[0]
        
print(mans)
print(Mans)