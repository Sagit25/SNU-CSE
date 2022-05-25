import chart as c
import league as l

import sys

command = sys.argv[1]


#### DO NOT MODIFY THIS CODE ####

if command == "bar":
    BAR_DATA = []
    c.axis()
    with open ("./bar_data.txt", "r") as f:
        BAR_DATA = [line.rstrip() for line in f]
    c.bar_chart(BAR_DATA)    

elif command == "scatter":
    SCATTER_DATA = []
    c.axis()
    with open ("./scatter_data.txt", "r") as f :
        SCATTER_DATA = [line.rstrip() for line in f]
    c.scatterplot(SCATTER_DATA)

elif command == "league":
    l.league()

else:
    print("Wrong argument!!")

c.free_turtle()