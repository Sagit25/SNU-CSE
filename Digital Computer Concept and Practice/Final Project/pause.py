import pygame as pg
from math import *
import time

class Pause():
    def __init__(self, game):
        self.game = game
        self.active = True
        self.timesave = 0
        
    def tick(self):
        pass
    
    def draw(self):
        pass
        
    def handle_event(self, event):
        if event.type == pg.KEYDOWN:
            if event.key == pg.K_p:
                t = self.game.duringtime
                for i in range(200):
                    time.sleep(0.1)
                    self.game.starttime = pg.time.get_ticks()
                    self.game.duringtime = 0
                self.game.starttime = pg.time.get_ticks()-t*1000
                self.game.duringtime = (t*1000+self.game.savetime) / 1000
                
    def interact(self, other):
        pass     