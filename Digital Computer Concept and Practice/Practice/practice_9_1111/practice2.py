class Team:
    def __init__(self, name, string, num, sco):
        self.name = name
        self.string = string
        self.num = num
        self.sco = sco    

n = int(input())
t = []
for i in range(n):
    a, b = input().split()
    t.append(Team(a, b, len(b), 0))

for i in range(n):
    for j in range(i):
        x = y = 0
        while x < t[i].num and y < t[j].num:
            a = t[i].string[x]
            b = t[j].string[y] 
            if a == b:
                x += 1
                y += 1
            elif (a == 'R' and b == 'S') or (a == 'S' and b == 'P') or(a == 'P' and b == 'R'):
                y += 1
            else: 
                x += 1
                
        if x >= t[i].num and y >= t[j].num:
            t[i].sco += max(0, t[j].num-t[i].num)
            t[j].sco += max(0, t[i].num-t[j].num)
        elif x >= t[i].num:
            t[j].sco += t[i].num + y
        elif y >= t[j].num:
            t[i].sco += t[j].num + x

for i in range(n):
    for j in range(i+1, n):
        if t[i].sco < t[j].sco:
            t[i], t[j] = t[j], t[i]
        elif t[i].sco == t[j].sco and t[i].name > t[j].name:
            t[i], t[j] = t[j], t[i]

for i in range(n):
    print("{0}:{1}".format(t[i].name, t[i].sco))
        
                