import pygame as pg
from pygame.constants import QUIT
from time import sleep

from color import *
from object import *

# Strip Constant
lside = rside = 5
uside = dside = 10

class Game():
    block_size = 10 # Size Constant
    
    # Constructer
    def __init__(self, n_rows, n_cols):
        pg.init()
        pg.display.set_caption("DCCP Assn4 Snake Game 2021-15738 Yang SukHun")
        self.display = pg.display.set_mode(((n_cols+lside+rside)*self.block_size, (n_rows+uside+dside)*self.block_size))
        self.n_rows = n_rows
        self.n_cols = n_cols
        self.clock = pg.time.Clock()
        self.game_over = False
        self.objects = []
    
    # Find Which Object is Active    
    def active_objects(self):
        for obj in self.objects:
            if obj.active:
                yield obj
    
    # Handle Event Function         
    def __handle__event(self, event):
        for obj in self.active_objects():
            obj.handle_event(event)
    
    # Tick Function        
    def __tick(self):
        for obj in self.active_objects():
            obj.tick()
    
    # All of Draw Function
    def __draw(self):
        # Background Draw
        self.display.fill(BLACK)
        pg.draw.rect(self.display, WHITE, [lside*self.block_size, uside*self.block_size, self.n_cols*self.block_size, self.n_rows*self.block_size], 1)
        
        # Food Status Draw
        pgfont = pg.font.Font(None, self.block_size*3)
        for i in range(3):
            pg.draw.rect(self.display, FOOD_COLOR[i][0], [(lside+(self.n_cols*(i+1))//4)*self.block_size, (uside+self.n_rows+dside//2-1)*self.block_size, self.block_size, self.block_size])
            foodscore = pgfont.render(str(FOOD_COLOR[i][1]), True, WHITE)
            self.display.blit(foodscore, ((lside+(self.n_cols*(i+1))//4+self.block_size//2)*self.block_size, (uside+self.n_rows+dside//2-1)*self.block_size))
            
        # Score Draw
        score1 = 'BLUE(P1,WASD) : ' + str(self.objects[0].size)
        score2 = 'RED(P2,Arrow) : ' + str(self.objects[1].size)
        player1score = pgfont.render(score1, True, WHITE)
        player2score = pgfont.render(score2, True, WHITE)
        versus = pgfont.render('vs', True, WHITE)
        score = pgfont.render('Score', True, WHITE)
        self.display.blit(score, ((lside)*self.block_size, (uside//2)*self.block_size))
        self.display.blit(player1score, ((lside+(self.n_cols)//4-3)*self.block_size, (uside//2)*self.block_size))
        self.display.blit(player2score, ((lside+(self.n_cols*2)//4+6)*self.block_size, (uside//2)*self.block_size))
        self.display.blit(versus, ((lside+self.n_cols//2)*self.block_size, (uside//2)*self.block_size))
        
        # Object Draw
        for obj in self.active_objects():
            obj.draw()
        pg.display.update()

    # Interact Function
    def __interact(self):
        for obj1 in self.objects:
            for obj2 in self.objects:
                if obj1.active and obj2.active:
                    obj1.interact(obj2)
                    obj2.interact(obj1)                            

    # Game Over Condition (about Food Remain)
    def __game__over(self):
        food_remains = False
        for obj in self.active_objects():
            if isinstance(obj, Food):
                food_remains = True  
        if not food_remains:
            self.game_over = True
    
    # Player Win Condition (No Interact with Other Snake)    
    def __player__win(self):
        flag1 = flag2 = 0   # flag1 = 1 : Player1 Win, flag2 = 1 : Player2 Win
        pgfont = pg.font.Font(None, self.block_size*5)
        p1win = pgfont.render('P1 win', True, WHITE)
        p2win = pgfont.render('P2 win', True, WHITE)
        tie = pgfont.render('Tie', True, WHITE)
            
        # Out of Boundary
        for obj in self.objects:
            if obj.x < lside+1 or obj.x > self.n_cols-2+lside or obj.y < 1+uside or obj.y > self.n_rows-2+uside:
                self.game_over = True
                if isinstance(obj, Player1):
                    flag2 = 1
                if isinstance(obj, Player2):
                    flag1 = 1
            
        # Length >= 24
        snake1 = self.objects[0]
        snake2 = self.objects[1]
        if snake1.size >= 24:
            flag1 = 1
        if snake2.size >= 24:
            flag2 = 1
            
        # Crash with another Snake (Head to Head)
        pos1 = (snake1.x+snake1.dx == snake2.x and snake1.y+snake1.dy == snake2.y)
        pos2 = (snake2.x+snake2.dx == snake1.x and snake2.y+snake2.dy == snake1.y)
        pos3 = (snake2.x == snake1.x and snake2.y == snake1.y)
        flagh = 0   # If two crash head to head, than no crash head to body
        if (pos1 and pos2) or pos3:
            if snake1.size > snake2.size:
                flag2 = 1
            elif snake1.size < snake2.size:
                flag1 = 1
            elif snake1.size == snake2.size:
                flag1 = flag2 = 1
            flagh = 1
                
        if flagh == 0:
            # P1 Head to P2 Body
            for snk2 in snake2.snake[1:]:
                pos = (snk2[0] == snake1.x and snk2[1] == snake1.y)
                if pos:
                    flag2 = 1
                    
            # P2 Head to P1 Body
            for snk1 in snake1.snake[1:]:
                pos = (snk1[0] == snake2.x and snk1[1] == snake2.y)
                if pos:
                    flag1 = 1
            
        # Print String
        if flag1 == 1 and flag2 == 1:
            self.display.blit(tie, ((lside+self.n_cols//2-3)*self.block_size, (uside+self.n_rows//2-3)*self.block_size))
            pg.display.update()
            sleep(10)
            self.game_over = True
        elif flag1 == 1:
            self.display.blit(p1win, ((lside+self.n_cols//2-5)*self.block_size, (uside+self.n_rows//2-3)*self.block_size))
            pg.display.update()
            sleep(10)
            self.game_over = True
        elif flag2 == 1:
            self.display.blit(p2win, ((lside+self.n_cols//2-5)*self.block_size, (uside+self.n_rows//2-3)*self.block_size))
            pg.display.update()
            sleep(10)
            self.game_over = True
        
    # Game Fuction    
    def play(self, n_foods):
        startc1 = lside + (self.n_cols*3)//4
        startc2 = lside + self.n_cols//4
        startr = uside + self.n_rows//2
        self.objects = [
            Player1(startc2, startr, self, [[startc2, startr]], 1),
            Player2(startc1, startr, self, [[startc1, startr]], 1),
            *[Food(self) for i in range(n_foods)]
        ]
        
        while not self.game_over:
            for event in pg.event.get():
                if event.type == QUIT:
                    self.game_over = True
                    break
                    
                self.__handle__event(event)
    
            self.__tick()                
            self.__interact()
            self.__draw()   
            self.__game__over()
            self.__player__win()
        
            self.clock.tick(10)

if __name__ == "__main__":
    Game(n_rows=60, n_cols = 80).play(n_foods = 20)