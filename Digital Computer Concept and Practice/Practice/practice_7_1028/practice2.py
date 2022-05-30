a = list(input().split())
b = list(input().split())

newa = [i for i in a]
for i in b:
    newa.remove(i)

if len(newa) == 0:
    print("Complete!")
else:
    print((' '.join(sorted(newa))))
