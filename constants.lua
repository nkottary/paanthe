-- window stuff goes here.
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

-- game specific stuff.
FRICTION = 0.999

-- player stuff goes here.
PLAYER_START_X = 400
PLAYER_START_Y = 300
PLAYER_WIDTH = 120
PLAYER_HEIGHT = 70
PLAYER_SPEED_LIMIT = 2000.0
PLAYER_ACCEL_X = 1000.0
PLAYER_ACCEL_Y = 1000.0

--player sprite stuff
PLAYER_SPRITE_WIDTH = 128
PLAYER_SPRITE_HEIGHT = 70
PLAYER_SPRITE_RATE = 0.1

--bullet stuff
BULLET_WIDTH = 5
BULLET_HEIGHT = 5
BULLET_SPEED = 500

--enemy stuff
ENEMY_WIDTH = 70
ENEMY_HEIGHT = 70
ENEMY_SPEED_LIMIT = 2000.0
ENEMY_ACCEL_X = 500.0
ENEMY_ACCEL_Y = 500.0
ENEMY_SPAWN_TIME = 3 	--spawn an enemy every 10 seconds.
MAX_NUMBER_OF_ENEMIES = 10 -- maximum number of enemies on the screen at any time.

--background image stuff
BACKGROUND_VEL_X = 500.0

--explosion stuff
EXPLOSION_SPRITE_RATE = 0.1
EXPLOSION_SPRITE_WIDTH = 96
EXPLOSION_SPRITE_HEIGHT = 96
EXPLOSION_TIME = 1

--BOUNCE OPTIONS : when player collides with enemy
BOUNCE_ATTENUATION = 3.0

--keys
K_UP = 'up'
K_DOWN = 'down'
K_RIGHT = 'right'
K_LEFT = 'left'
K_SHOOT = 'lctrl'