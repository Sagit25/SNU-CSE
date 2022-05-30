# number 1

'''
new_data = gm_data.sort_values(["gdp"], ascending=True)
m = M = 0
for i in new_data[:10].gdp:
    print(i)
    m += i
m /= 10
for i in new_data[-10:].gdp:
    print(i)
    M += i
M /= 10
print(M-m)

Answer : 38547
'''

# number 2

'''
gm_data.sort_values(["employment"], ascending=True)

Answer : Burundi
'''

# number 3
'''
gm_data.sort_values(["life_exp"], ascending=True)

Answer : Iceland
'''