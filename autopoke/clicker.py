
#
# Constants
#

CLICKS_PER_SECOND = 50
HATCH_SECONDS = 25
HDR = False # Is the screen HDR?

HATCH = 'h'
CRAWL = 'c'
RUSH = '1'
SUPER = '2'
ULTRA = '3'
CLICK = 'x'
QUIT = 'q'

#
# Imports
#

import time
import threading
from heapq import *
from random import randrange, sample
from operator import sub
from pynput.mouse import Button, Controller, Listener as MouseListener
from pynput.keyboard import GlobalHotKeys, Listener as KbdListener, Key, KeyCode, Controller as Kbd

from pyautogui import screenshot

class Clicker(threading.Thread):
    def run(self):
        self.exit = False
        self.alt = False
        self.clicking = False
        self.hatching = False
        self.exploring = False
        self.rush = False
        self.rush_mode = ''

        self.mouse = Controller()
        self.kbd = Kbd()
        self.saved_pos = self.mouse.position
        self.kl = KbdListener(on_press=clicker.pressed, on_release=clicker.released)
        self.kl.start()
        self.ml = MouseListener(on_click=clicker.clicked)
        self.ml.start()
        last_hatch = time.time()
        while not self.exit:
            if self.clicking:
                self.mouse.position = self.saved_pos
                self.mouse.click(Button.left)
                time.sleep(1.0 / CLICKS_PER_SECOND)
            else:
                last_hatch = time.time()
                time.sleep(0.1)

            if self.hatching and self.clicking and time.time() - last_hatch > HATCH_SECONDS:
                last_hatch = time.time()
                self.kbd.press('h')
                self.kbd.release('h')
                time.sleep(1)
                for _ in range(3):
                    for n in range(45):
                        self.mouse.click(Button.left)
                        time.sleep(1.0 / CLICKS_PER_SECOND)
                        if not self.clicking:
                            break
                    time.sleep(0.5)
                    if not self.clicking:
                        break
                    self.kbd.press(Key.esc)
                    self.kbd.release(Key.esc)
        self.ml.stop()

    def pressed(self, key):
        try:
            if key == Key.alt_l:
                if self.clicking and not self.alt:
                    self.clicking = False
                    self.hatching = False
                    self.exploring = False
                    print('Stopped clicking!')
                else:
                    self.alt = True
            elif key.char == HATCH and self.clicking and not self.hatching:
                print('Hatching!')
                self.hatching = True
            elif key.char in (CRAWL, RUSH, SUPER, ULTRA) and self.clicking and not self.exploring:
                self.exploring = True
                self.rush = key.char != CRAWL
                self.rush_mode = key.char
                print(f'Start crawling! Mode is {self.rush_mode}')
            elif self.alt:
                if key.char == CLICK:
                    self.saved_pos = self.mouse.position
                    self.clicking = not self.clicking
                    print('Started clicking!' if self.clicking else 'Stopped clicking!')
                elif key.char == QUIT:
                    self.exit = True
                    return False
        except AttributeError:
            pass

    def released(self, key):
        if key == Key.alt_l:
            self.alt = False

    def clicked(self, x, y, button, down):
        if down:
            pass
        elif self.alt and button == Button.left and not self.clicking:
            self.saved_pos = self.mouse.position
            self.clicking = True
            print('Started clicking!')

BORDER = (0, 0, 0)
WHITE = (245, 245, 245)
DARK_WHITE = (122, 122, 122)
if HDR:
    GREEN = (46, 204, 113) # OK
    BLUE =  (52, 152, 219) # OK
    BLACK = (51, 51, 51) # OK
    DARK_RED = (115, 38, 30) # OK
    YELLOW = (241, 196, 15) # OK
    DARK_YELLOW = (120, 98, 7) # OK
    PURPLE = (155, 89, 182) # OK
    DARK_PURPLE = (77, 44, 91) # OK
    BROWN = (91, 90, 64) # OK
    DARK_BROWN = (45, 45, 32) # OK
else:
    GREEN = (127, 202, 116)
    BLUE =  (101, 153, 218)
    BLACK = (51, 51, 51)
    DARK_RED = (98, 39, 29)
    YELLOW = (227, 195, 33)
    DARK_YELLOW = (113, 97, 16)
    PURPLE = (139, 93, 181)
    DARK_PURPLE = (69, 46, 90)
    BROWN = (91, 90, 64) # FIXME
    DARK_BROWN = (45, 45, 32) # FIXME

TILE_PLAYER = 0
TILE_EMPTY =  1
TILE_SAFE =   2
TILE_FIGHT =  TILE_SAFE # or 3
TILE_CHEST =  4
TILE_HIDDEN = 5
TILE_STAIRS = 6
TILE_BOSS =   7
TILE_AVOID =  8 # Used to avoid fights
TILE_START =  9

COLORMAP = (
    (TILE_PLAYER, GREEN),
    (TILE_EMPTY,  WHITE, DARK_WHITE),
    (TILE_FIGHT,  DARK_RED),
    (TILE_CHEST,  YELLOW, DARK_YELLOW),
    (TILE_HIDDEN, BLACK),
    (TILE_BOSS,   PURPLE, DARK_PURPLE),
    (TILE_STAIRS, BROWN, DARK_BROWN),
    (TILE_START,  BLUE),
)

class Explorer(threading.Thread):
    def run(self):
        self.kbd = Kbd()
        self.reset_history()
        self.last_move = (0, 0)
        while not clicker.exit:
            l = None
            try:
                if clicker.exploring:
                    self.pic = screenshot()
                    l = self.find_hero()
            except:
                raise
                pass
            if l:
                self.roam(*l)
            else:
                # Hero not found, maybe not in a dungeon… wait for a second
                time.sleep(1)

    def roam(self, x0, y0, w, h):
        left, right, top, bottom = x0, x0, y0, y0
        while l := self.find_box(left - 4, y0 + 2): 
            if left == l[0]:
                break
            left = l[0]
        while l := self.find_box(right + w + 2, y0 + 2):
            if right == l[0]:
                break
            right = l[0]
        while l := self.find_box(x0 + 2, top - 4):
            if top == l[1]:
                break
            top = l[1]
        while l := self.find_box(x0 + 2, bottom + h + 2):
            if bottom == l[1]:
                break
            bottom = l[1]
        # Compute dungeon size
        mx = round((right - left) / w + 1)
        my = round((bottom - top) / h + 1)
        # Readjust cell width/height values
        w = (right - left) / (mx - 1) if mx > 1 else w
        h = (bottom - top) / (my - 1) if my > 1 else h
        # Place player
        sx = round((x0 - left) / w)
        sy = round((y0 - top) / h)
        if self.history[-1] != (sx, sy):
            self.history = [*self.history[1:], (sx, sy)]
        # Compute map
        data = [[-1] * mx for _ in range(my)]
        found_tiles = set()
        for y in range(my):
            for x in range(mx):
                c = self.pic.getpixel((left + 2 + x * w, top + 2 + y * h))
                for m in COLORMAP:
                    for c0 in m[1:]:
                        if self.match_color(c, c0):
                            data[y][x] = m[0]
                            found_tiles.add(m[0])
                if data[y][x] == -1:
                    print('Error: unknown color at', x, y, ':', c)
        # Tweak the map
        # If the boss was found, mark all unknown tiles as safe for visiting
        # If rushing but not super rushing, try to avoid fights
        # If rushing and no more chests or hidden tiles, rush to the boss
        chests_cleaned = TILE_HIDDEN not in found_tiles and TILE_CHEST not in found_tiles
        has_end = TILE_BOSS in found_tiles or TILE_STAIRS in found_tiles
        for y in range(my):
            for x in range(mx):
                if has_end and data[y][x] == TILE_HIDDEN:
                    if clicker.rush and clicker.rush_mode in (SUPER, ULTRA):
                        data[y][x] = TILE_EMPTY # Fights are small fry
                    else:
                        data[y][x] = TILE_SAFE
                if clicker.rush and data[y][x] == TILE_FIGHT:
                    if clicker.rush_mode in (SUPER, ULTRA):
                        data[y][x] = TILE_EMPTY # Fights are small fry
                    elif not chests_cleaned:
                        data[y][x] = TILE_HIDDEN # Priorise chests over fights
                    else:
                        data[y][x] = TILE_AVOID # Priorise boss over fights
                #if clicker.rush and chests_cleaned and data[y][x] == TILE_BOSS:
                #    data[y][x] = TILE_SAFE
        # Find the best target and the direction to reach it
        best_move, best_next_move, best_cost = (0, 0), (0, 0), 1e32
        #print('')
        for y in range(my):
            for x in range(mx):
                if clicker.rush:
                    # If the exit is found in ultra rush mode, ignore other targets
                    # If there are chests in rush mode, ignore other targets
                    if has_end and clicker.rush_mode == ULTRA:
                        if data[y][x] not in (TILE_BOSS, TILE_STAIRS):
                            continue
                    else:
                        if data[y][x] != TILE_CHEST and TILE_CHEST in found_tiles:
                            continue
                        if chests_cleaned and has_end and data[y][x] not in (TILE_BOSS, TILE_STAIRS):
                            continue
                else:
                    # If there are fights in crawl mode, ignore other targets
                    if data[y][x] != TILE_FIGHT and TILE_FIGHT in found_tiles:
                        continue
                if data[y][x] >= TILE_SAFE:
                    move, next_move, cost = self.compute_cost(data, sx, sy, x, y)
                    #print('target:', x, y, 'cost:', cost, 'move:', move)
                    if cost < best_cost:
                        best_move, best_next_move, best_cost = move, next_move, cost
        #lut = '@.:Xo?B-S'
        #for l in data:
        #    print('|' + ' '.join(lut[c] for c in l) + '|')
        key = ['a', 'w', None, 's', 'd'][2 * best_move[0] + best_move[1] + 2]
        if key and not clicker.exit:
            self.kbd.press(key)
            self.kbd.release(key)
            delay = 0.01
            # Safeguard if lagging: if we appear to be stuck, wait a bit longer
            if len(set(self.history)) <= len(self.history) / 2:
                delay = randrange(2, 5) / 10
                self.reset_history()
            # If the next move lands us in danger zone, wait longer, too
            x2, y2 = sx + 2 * best_move[0], sy + 2 * best_move[1]
            if x2 >= 0 and y2 >= 0 and x2 < mx and y2 < my and data[y2][x2] in (TILE_START, TILE_BOSS, TILE_STAIRS):
                delay = 0.2
            if best_next_move:
                x2, y2 = x2 + best_next_move[0], y2 + best_next_move[1]
                if x2 >= 0 and y2 >= 0 and x2 < mx and y2 < my and data[y2][x2] in (TILE_START, TILE_BOSS, TILE_STAIRS):
                    delay = 0.2
            time.sleep(delay)

    def reset_history(self):
        self.history = list(range(12)) # Meaningless but unique values

    @staticmethod
    def compute_cost(data, sx, sy, tx, ty):
        mx, my = len(data[0]), len(data)
        def weight(x, y):
            return pow(8, 2 + data[y][x])
        visited = set()
        todo = []
        heappush(todo, (0, (sx, sy), ()))
        while todo:
            cost, cell, path = heappop(todo)
            if cell in visited:
                continue
            visited.add(cell)
            choices = [(0,1), (-1,0), (0,-1), (1,0)]
            for d in sample(choices, len(choices)):
                x1, y1 = cell[0] + d[0], cell[1] + d[1]
                if x1 < 0 or y1 < 0 or x1 >= mx or y1 >= my or (x1, y1) in visited:
                    continue
                new_cost = cost + weight(x1, y1)
                new_path = path + (d,)
                if (x1, y1) == (tx, ty):
                    return new_path[0], new_path[1] if len(new_path) >= 2 else None, new_cost
                heappush(todo, (new_cost, (x1, y1), new_path))

    def find_hero(self):
        for _ in range(10000):
            # Find a green pixel
            x, y = randrange(self.pic.width), randrange(self.pic.height)
            if self.match_color(self.pic.getpixel((x, y)), GREEN):
                hero = self.find_box(x, y)
                if hero:
                    return hero

    @staticmethod
    def match_color(c1, c2):
        return sum(map(abs, map(sub, c1, c2))) < 1.0

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
        if self.pic.getpixel((x0 - 1, y0 + h // 2)) != BORDER:
            return None
        if self.pic.getpixel((x0 + w, y0 + h // 2)) != BORDER:
            return None
        if self.pic.getpixel((x0 + w // 2, y0 - 1)) != BORDER:
            return None
        if self.pic.getpixel((x0 + w // 2, y0 + h)) != BORDER:
            return None
        # Check that the contents are same-coloured
        if self.pic.getpixel((x0 + w // 16, y0 + h // 4)) != c:
            return None
        if self.pic.getpixel((x0 + w * 15 // 16, y0 + h * 3 // 4)) != c:
            return None
        # Return the coordinates!
        return x0, y0, w, h


clicker = Clicker()
clicker.start()

explorer = Explorer()
explorer.start()

print('Autoclicker started')
print('-------------------')
print('Start clicking (mouse): <alt> + <click>')
print('Start clicking (kbd): <alt> + ', CLICK)
print('Stop clicking: <alt>')
print('Hatch mode:', HATCH)
print('Dungeon crawl mode:', CRAWL)
print('Dungeon rush mode:', RUSH)
print('Dungeon super rush mode:', SUPER)
print('Dungeon ultra rush mode:', ULTRA)
print('Exit program: <alt> +', QUIT)
print('')

clicker.join()
