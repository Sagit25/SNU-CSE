import pygame as pg
from math import *
import pygame.mixer

from color import *
from pause import *
from objects import *

class Game():
    def __init__(self, state, row, col, radius, width, blocknumber):
        pg.init()
        pg.display.set_caption("DCCP Project : Orbit or Beat")
        self.state = state
        self.row = row
        self.col = col
        self.radius = radius
        self.width = width
        self.display = pg.display.set_mode((self.row, self.col))
        self.display.fill(WHITE)
        pg.draw.circle(self.display, BLACK, (self.row//2, self.col//2), self.radius, self.width)
        self.clock = pg.time.Clock()
        self.game_over = False
        self.font = pygame.font.Font(None, 40)
        self.starttime = pygame.time.get_ticks()
        self.duringtime = 0
        self.savetime = 0
        self.maxscore = 0
        self.objects = []
        self.blocknumber = blocknumber
        self.count = 0
        self.rotate = 0
        
    def active_objects(self):
        for obj in self.objects:
            if obj.active:
                yield obj 
     
    def __handle__event(self, event): 
        for obj in self.active_objects():
            obj.handle_event(event)
                
    def __time__checker(self):
        self.duringtime = (pg.time.get_ticks()-self.starttime+self.savetime) / 1000
        timer = self.font.render("Time: " + str(int(self.duringtime+self.savetime)), True, BLACK)
        self.display.blit(timer, (20, 20))
        self.maxscore = max(int(self.duringtime+self.savetime), self.maxscore)
        score = self.font.render("Score: " + str(self.maxscore), True, BLACK)
        self.display.blit(score, (560, 20))    
    
    def __tick(self):
        for obj in self.objects:
            obj.tick()
            
    def __interact(self):
        for obj1 in self.active_objects():
            for obj2 in self.active_objects():
                if obj1 == obj2:
                    continue
                obj1.interact(obj2)
                obj2.interact(obj1)
            
    def __draw(self):
        self.display.fill(WHITE)
        pg.draw.circle(self.display, BLACK, (self.row//2, self.col//2), self.radius, self.width)
        self.__time__checker()
        for obj in self.objects:
            obj.draw()
        
    def play(self):
        self.objects = [Player(self, self.row/2, self.col/2-self.radius, self.width*2), Save(self), *[Block(self, i) for i in range(self.blocknumber)], Pause(self)]
        
        while not self.game_over:
            for event in pg.event.get():
                if event.type == pg.QUIT:
                    self.game_over = True
                    scorecord = self.font.render("Score: " + str(self.maxscore), True, GREEN)
                    self.display.blit(scorecord, (self.row/2-50, self.col/2))
                    pg.display.update()
                    time.sleep(5)
                    break
                self.__handle__event(event)
            self.__tick()
            self.__interact()
            self.__draw()
            self.clock.tick(10000) 
            pg.display.update()
        
if __name__ == "__main__":
    pygame.mixer.init()
    music = "EungEung.wav"
    sound = pygame.mixer.Sound(music)
    sound.play()
    Game(state = 1, row = 800, col = 800, radius = 300, width = 4, blocknumber = 20).play()