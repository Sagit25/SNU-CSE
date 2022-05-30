a = list(map(int, input().split()))
print("init : ", a)
n = int(input())
s = []

for i in range(n):
    s.append(list(input().split()))

for i in s:
    if i[0] == "add":
        for j in range(len(a)):
            a[j] += int(i[1])
    elif i[0] == "sub":
        for j in range(len(a)):
            a[j] -= int(i[1])
    elif i[0] == "mul":
        for j in range(len(a)):
            a[j] *= int(i[1])
    else:
        print((' ').join(i), ": Wrong argument!")
        break
    print((' ').join(i), ":", a)