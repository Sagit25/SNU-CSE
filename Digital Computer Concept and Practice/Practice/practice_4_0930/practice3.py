a, b = map(int, input().split())
c, d = map(int, input().split())
if a == c:
    if b == d:
        print('Equivalent')
    else:
        print('None')
else:
    ans1 = (d-b)/(a-c)
    ans2 = (a*d-b*c)/(a-c)
    if ans1 - int(ans1) >= 0.5:
        print(int(ans1)+1, end = ",")
    else: 
        print(int(ans1), end = ",")
    if ans2 - int(ans2) >= 0.5:
        print(int(ans2)+1)
    else: 
        print(int(ans2))