#!/c/Python39/python.exe

import time
import threading
from random import randrange
from operator import sub
from pynput.mouse import Button, Controller
from pynput.keyboard import GlobalHotKeys, Listener, Key, KeyCode

from pyautogui import screenshot

CLICK = '<alt>+y'
QUIT = '<alt>+q'

state = lambda x: None
state.clicking = False
state.exit = False
state.last_move = time.time()

class Clicker(threading.Thread):
    def run(self):
        self.mouse = Controller()
        self.saved_pos = self.mouse.position
        while not state.exit:
            if state.clicking:
                self.mouse.position = self.saved_pos
                self.mouse.click(Button.left)
                time.sleep(0.001)
            else:
                time.sleep(0.1)

    def activate(self):
        self.saved_pos = self.mouse.position
        state.clicking = not state.clicking
        print('Started clicking!' if state.clicking else 'Stopped clicking.')

BLACK = (0, 0, 0)
GREEN = (46, 204, 113)

class Roamer(threading.Thread):
    def run(self):
        #print(pic)
        while not state.exit:
            self.pic = screenshot()
            l = self.find_hero()
            if not l:
                time.sleep(1)
                continue
            x0, y0, w, h = *l,
            print(x0, y0)
            time.sleep(1)

    def find_hero(self):
        for _ in range(10000):
            # Find a green pixel
            x, y = randrange(self.pic.width), randrange(self.pic.height)
            if self.pic.getpixel((x, y)) == GREEN:
                hero = self.find_box(x, y)
                if hero:
                    return hero

    def find_box(self, x, y):
        # Get pixel colour
        c = self.pic.getpixel((x, y))
        # Find a same-coloured rectangle around it
        while y > 0 and self.pic.getpixel((x, y - 1)) == c:
            y -= 1
        while x > 0 and self.pic.getpixel((x - 1, y)) == c:
            x -= 1
        x0, y0 = x, y
        while y < self.pic.height - 1 and self.pic.getpixel((x, y + 1)) == c:
            y += 1
        while x < self.pic.width - 1 and self.pic.getpixel((x + 1, y)) == c:
            x += 1
        w, h = x - x0 + 1, y - y0 + 1
        # Check that the borders are black
        if self.pic.getpixel((x0 - 1, y0 + h // 2)) != BLACK:
            return None
        if self.pic.getpixel((x0 + w, y0 + h // 2)) != BLACK:
            return None
        if self.pic.getpixel((x0 + w // 2, y0 - 1)) != BLACK:
            return None
        if self.pic.getpixel((x0 + w // 2, y0 + h)) != BLACK:
            return None
        # Check that the contents are same-coloured
        if self.pic.getpixel((x0 + w // 4, y0 + h // 2)) != c:
            return None
        if self.pic.getpixel((x0 + w // 4 * 3, y0 + h // 2)) != c:
            return None
        # Return the coordinates!
        return x0, y0, w, h


clicker = Clicker()
clicker.start()

roamer = Roamer()
roamer.start()

def on_quit():
    state.exit = True
    raise Listener.StopException

print('Autoclicker started')
print('-------------------')
print('Enable/disable clicks:', CLICK.replace('+', ' '))
print('Exit program:', QUIT.replace('+', ' '))
print('')

with GlobalHotKeys({ CLICK: clicker.activate, QUIT: on_quit }) as h:
    h.join()

