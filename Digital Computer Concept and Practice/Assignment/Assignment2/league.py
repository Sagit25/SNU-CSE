import turtle as t

from league_data import TEAM_INFO, GAME_INFO
 
t.setworldcoordinates(0,0,800,800)

def league():
    r = 30
    dist = 90
    height = 40
    t.speed(0)
    
    ####### Enter Your Code ########

    t.speed(20)
    new_dist = dist
    round = 0
    x = dist
    for i in GAME_INFO:
        round += 1
        t.penup()
        t.left(90)
        t.fd(height+r*round*2)
        t.right(90)
        t.pendown()
        for j in i:
            t.penup()
            t.fd(new_dist)
            t.pendown()
            t.color(TEAM_INFO[j[0]])
            t.begin_fill()
            t.circle(-r)
            t.end_fill()
            t.color('black')
            t.circle(-r)
            t.penup()
            t.right(90)
            t.fd(r)
            t.write(j[0], align = "center")
            t.bk(r)
            t.left(90)
            t.pendown()
            t.left(90)
            t.fd(height)
            t.right(90)
            t.fd(new_dist/2)
            t.color(TEAM_INFO[j[2]])
            t.begin_fill()
            t.circle(r)
            t.end_fill()
            t.color('black')
            t.circle(r)
            t.penup()
            t.left(90)
            t.fd(r)
            t.write(j[2], align = "center")
            t.bk(r)
            t.right(90)
            t.pendown()
            t.fd(new_dist/2)
            t.right(90)
            t.fd(height)
            t.left(90)
            t.color(TEAM_INFO[j[1]])
            t.begin_fill()
            t.circle(-r)
            t.end_fill()
            t.color('black')
            t.circle(-r)
            t.penup()
            t.right(90)
            t.fd(r)
            t.write(j[1], align = "center")
            t.bk(r)
            t.left(90)
            t.pendown()
        t.penup()
        t.goto(-dist*(2**(round-1))+dist/2, height*round)
        t.pendown()
        new_dist *= 2


    ####### End of the Code ########
