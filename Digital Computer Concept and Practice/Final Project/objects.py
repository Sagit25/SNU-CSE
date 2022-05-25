import pygame as pg
from math import *
import random

from color import *
from pause import *

class Player():
    def __init__(self, game, x, y, radius):
        self.game = game
        self.x = x
        self.y = y
        self.radius = radius
        self.active = True
        pg.draw.circle(self.game.display, RED, (self.x, self.y), self.radius, self.radius*3)
        self.w = 1        
        self.angle = 0
        self.rate = 0
               
    def handle_event(self, event):
        if event.type == pg.KEYDOWN:
            if event.key == pg.K_SPACE:
                if self.game.state == 0:
                    self.game.state = 1
                elif self.game.state == 1:
                    self.game.state = 0
            if event.key == pg.K_UP:
                self.w *= 1.25
            if event.key == pg.K_DOWN:
                self.w *= 0.8
                    
    def tick(self):
        self.angle = self.w*self.game.duringtime-self.rate*2*pi
        if self.angle >= 2*pi:
            self.rate += 1
            self.w *= 1.05
            self.game.count += self.game.blocknumber
        if self.game.state == 1:
            self.x = self.game.row/2+sin(self.angle)*(self.game.radius+self.radius)
            self.y = self.game.col/2-cos(self.angle)*(self.game.radius+self.radius)
        elif self.game.state == 0:
            self.x = self.game.row/2+sin(self.angle)*(self.game.radius-self.game.width-self.radius)
            self.y = self.game.col/2-cos(self.angle)*(self.game.radius-self.game.width-self.radius)
    
    def draw(self):    
        pg.draw.circle(self.game.display, RED, (self.x, self.y), self.radius, self.radius)
        
    def interact(self, other):
        if isinstance(other, Save):
            if other.active == True and self.game.row/2-5 <= self.x <= self.game.row/2+5 and self.game.col/2 >= self.y >= 0:
                self.game.savetime = self.game.duringtime
                self.game.starttime = pg.time.get_ticks()
                other.active = False
        if isinstance(other, Block):
            self.xl = self.x+sin(self.w*self.game.duringtime)*self.radius
            self.xr = self.x-sin(self.w*self.game.duringtime)*self.radius
            self.yl = self.y+cos(self.w*self.game.duringtime)*self.radius
            self.yr = self.y-cos(self.w*self.game.duringtime)*self.radius
            if (self.xl >= other.x >= self.xr or self.xr >= other.x >= self.xl) and (self.yl >= other.y >= self.yr or self.yr >= other.y >= self.yl):
                self.game.starttime = pg.time.get_ticks()
                self.game.duringtime = self.game.savetime

class Block():
    def __init__(self, game, number):
        self.game = game
        self.number = number
        self.angle = random.uniform(pi*2*(2*self.number+3)/(2*self.game.blocknumber+1), pi*2*(2*self.number+2)/(2*self.game.blocknumber+2))
        self.state = random.randint(0, 1)
        if self.state == 1:
            self.x = self.game.row/2+sin(self.angle)*(self.game.radius+self.game.width)
            self.y = self.game.col/2-cos(self.angle)*(self.game.radius+self.game.width)
        elif self.state == 0:
            self.x = self.game.row/2+sin(self.angle)*(self.game.radius-self.game.width*2)
            self.y = self.game.col/2-cos(self.angle)*(self.game.radius-self.game.width*2)                    
        self.active = True
        pg.draw.circle(self.game.display, BLUE, (self.x, self.y), self.game.width*2, self.game.width*2)
        
    def handle_event(self, event):
        pass

    def tick(self):
        if self.game.count > self.game.rotate:
            self.game.rotate += 1
            self.angle = random.uniform(pi*2*(2*self.number+2)/(2*self.game.blocknumber+1), pi*2*(2*self.number+2)/(2*self.game.blocknumber+2))
            self.state = random.randint(0, 1)
            if self.state == 1:
                self.x = self.game.row/2+sin(self.angle)*(self.game.radius+self.game.width)
                self.y = self.game.col/2-cos(self.angle)*(self.game.radius+self.game.width)
            elif self.state == 0:
                self.x = self.game.row/2+sin(self.angle)*(self.game.radius-self.game.width*2)
                self.y = self.game.col/2-cos(self.angle)*(self.game.radius-self.game.width*2)

    def draw(self):
        pg.draw.circle(self.game.display, BLUE, (self.x, self.y), self.game.width*2, self.game.width*2)
    
    def interact(self, other):
        pass
    
class Save():
    def __init__(self, game):
        self.game = game
        self.active = False
        self.x = self.game.row/2
        self.y = self.game.col/2-self.game.radius-self.game.width
        self.state = 0

    def handle_event(self, event):
        pass
    
    def tick(self):
        for i in range(1, 20):
            if self.game.duringtime >= (15*i) and self.state < i:
                self.active = True
                self.state += 1
    
    def draw(self):
        if self.active == True:    
            pg.draw.circle(self.game.display, PURPLE, (self.x, self.y), 20, 2) 
    
    def interact(self, other):
        pass