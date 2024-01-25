-- Step 1
/*SELECT * FROM stream LIMIT 20;
SELECT * FROM chat LIMIT 20;*/

/*
stream table is:
time
device_id
login
channel
country
player
game
stream_format
subscriber	

chat table is:
time
device_id
login
channel
country
player
game
*/

-- Step 2
--SELECT DISTINCT game FROM stream;
/*
League of Legends
DayZ
Dota 2
Heroes of the Storm
Counter-Strike: Global Offensive
Hearthstone: Heroes of Warcraft
The Binding of Isaac: Rebirth
Agar.io
Gaming Talk Shows
Rocket League
World of Tanks
ARK: Survival Evolved
SpeedRunners
Breaking Point
Duck Game
Devil May Cry 4: Special Edition
Block N Load
Fallout 3
Batman: Arkham Knight*/

-- Step 3
--SELECT DISTINCT channel FROM stream;
/*
frank
george
estelle
morty
kramer
jerry
helen
newman
elaine
susan
*/

-- Step 4
/*SELECT game,
  COUNT(*)
FROM stream
GROUP BY game
ORDER BY COUNT(*) DESC;*/

/*
game	COUNT(*)
League of Legends	1070
Dota 2	472
Counter-Strike: Global Offensive	302
DayZ	239
Heroes of the Storm	210
The Binding of Isaac: Rebirth	171
Gaming Talk Shows	170
Hearthstone: Heroes of Warcraft	90
World of Tanks	86
Agar.io	71
Rocket League	49
SpeedRunners	20
ARK: Survival Evolved	19
15
Duck Game	5
Fallout 3	3
Batman: Arkham Knight	3
Breaking Point	2
Block N Load	2
Devil May Cry 4: Special Edition	1
*/

-- Step 5
/*SELECT country, COUNT(*)
FROM stream
WHERE game = 'League of Legends'
GROUP BY country
ORDER BY COUNT(*) DESC;*/

/*
country	COUNT(*)
US	447
DE	66
CA	64
49
GB	45
TR	28
BR	25
DK	20
PL	19
NL	17
BE	17
SE	16
RO	16
MX	16
PT	15
.. ..
CL	1
BB	1
AL	1
*/

-- Step 6
/*SELECT player, COUNT(*)
FROM stream
GROUP by player
ORDER BY COUNT(*) DESC;*/
/*
player	COUNT(*)
site	1365
iphone_t	622
android	547
ipad_t	290
embed	125
xbox_one	22
home	16
amazon	6
frontpage	4
xbox360	1
roku	1
chromecast	1
*/

-- Step 7
/*SELECT game,
  CASE
    WHEN game = 'League of Legends' THEN 'MOBA'
    WHEN game = 'Dota 2' THEN 'MOBA'
    WHEN game = 'Heroes of the Storm' THEN 'MOBA'
    WHEN game = 'Counter-Strike: Global Offensive' THEN 'FPS'
    WHEN game = 'DayZ' THEN 'Survival'
    WHEN game = 'ARK: Survival Evolved' THEN 'Survival'
    ELSE 'Other'
  END as genre,
  COUNT(*) as 'count'
FROM stream
GROUP BY game
ORDER BY count DESC;*/

-- Step 8
/*SELECT time
FROM stream
LIMIT 10;*/
/* time format is YYY-MM-DD HH:MM:SS */

-- Step 9
/*SELECT time,
   strftime('%S', time) as seconds
FROM stream
GROUP BY 1
LIMIT 20;*/
/* the function strips out the seconds portion of the returned datetime */


-- Step 10
/*SELECT strftime('%H', time) as hours,
   COUNT(*) as 'hoursCount'
FROM stream
WHERE country = 'AU'
GROUP BY hours;*/

-- Step 11
SELECT * --s.device_id, 
  --time
FROM stream
JOIN chat 
  ON stream.device_id - chat.device_id
LIMIT 20;
