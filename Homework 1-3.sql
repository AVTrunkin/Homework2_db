CREATE TABLE Musical_genres(
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
	);


CREATE TABLE Musician(
	id SERIAL PRIMARY KEY,
	name_alias VARCHAR(200) NOT NULL
	);


CREATE TABLE Records(
	id SERIAL PRIMARY KEY,
	name 	VARCHAR(200)	NOT NULL,
	years	INTEGER(3)	NOT NULL 
	);


CREATE TABLE Music_track(
	id SERIAL PRIMARY key,
	name 		VARCHAR(200) NOT NULL,
	length 		INTEGER(3)	 NOT NULL,
	record_id 	INTEGER		 NOT NULL,
	FOREIGN KEY (record_id) REFERENCES Records(id)
	);


CREATE TABLE Collection(
	id SERIAL PRIMARY KEY,
	name 	VARCHAR(200) NOT NULL,
	years 	INTEGER(4) 	 NOT NULL
	);

CREATE TABLE C_Mt(
	collection_id 	INTEGER REFERENCES Collection(id),
	music_track_id 	INTEGER REFERENCES Music_track(id),
	CONSTRAINT pk PRIMARY KEY (collection_id, music_track_id)
	);

CREATE TABLE M_Mg(
	musician_id 		INTEGER REFERENCES Musician(id),
	musical_genres_id 	INTEGER REFERENCES Musical_genres(id),
	CONSTRAINT vk PRIMARY KEY (musician_id, musical_genres_id)
	);

CREATE TABLE M_R(
	musician_id INTEGER REFERENCES Musician(id),
	records_id 	INTEGER REFERENCES Records(id),
	CONSTRAINT sk PRIMARY KEY (musician_id, records_id)
	);


-- Задание 1 заполнение таблиц
-- Заполняем таблицу с исполнителями (не менее 4 исполнителей)
INSERT INTO Musician (name_alias) 
VALUES ('Михаил Круг'), ('Олег Газманов'), ('Денис Майданов'), 
	   ('Лучиано Паваротти'), ('Луи Армстронг'), ('Михаил_Круг'), ('Круг');

-- Заполняем таблицу с жанрами (не менее 3 жанров)
INSERT INTO Musical_genres (name) 
VALUES ('POP'), ('CLASSIC'), ('JAZ');

-- Заполняем таблицу с альбомами (не менее 3 альбомов)
INSERT INTO Records (name, years) 
VALUES ('Кольщик', 2009), ('Исповедь', 2003), ('Мышка',2000),  -- Круг
	   ('Солдаты России', 2023), ('Отбой',2019), ('Сделан в СССР', 2005), -- Газманов
	   ('ВДВ', 2017), ('Флаг моего государства',2015), ('Русский мир', 2023), -- Майданов
	   ('O Sole Mio', 2007), ('Luciano Pavarotti', 2012), ('Mamma', 2007), -- Лучиано
	   ('All Time Greatest Hits', 2018), ('The Very Best Of Louis Armstrong', 1998), ('Cest si bon',1991); -- Луи

-- Заполняем таблицу с треками (не менее 6 треков)
INSERT INTO Music_track (name, length, record_id) 
VALUES ('Кольщик', 289,1), ('Кресты', 310,2), ('Мышка', 207, 3), 
	   ('Солдаты России', 263, 4), ('Отбой', 180, 5), ('Сделан в СССР', 246, 6), 
	   ('ВДВ', 221, 7), ('Флаг моего государства', 274, 8), ('Русский мир', 207, 9),
	   ('O Sole Mio', 169, 10), ('Luciano Pavarotti', 280, 11), ('Mamma', 184, 12),
	   ('Hello, Dolly!', 148, 13), ('What A Wonderful World', 139, 14), ('Summertime', 297, 15);

-- Заполняем таблицу сборников (не менее 4 сборников)
INSERT INTO Collection (name, years) 
VALUES ('Шансон лучшее 50', 2024), ('Classic 10', 2016), 
	   ('JAZ 15',2019), ('Родина', 2024), ('Лучшее', 2025);

-- Заполняем таблицу связей между сборниками и треками 
INSERT INTO C_Mt (collection_id, music_track_id) 
VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9),
	   (2, 10), (2, 11), (2, 12), 
	   (3, 13), (3, 14), (3, 15), 
	   (4, 4), (4, 6), (4, 7), (4, 8), (4, 9),
	   (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), 
       (5, 6), (5, 7), (5, 8), (5, 9), (5, 10), 
       (5, 11), (5, 12), (5, 13), (5, 14), (5, 15);

-- Заполняем таблицу связей между исполнителями и жанрами
INSERT INTO M_Mg (musician_id, musical_genres_id) 
VALUES (1, 1), (2, 1), (3, 1), (6, 1), (7, 1), (4, 2), (5, 3);

-- Заполняем таблицу связей между исполнителями и альбомами
INSERT INTO M_R (musician_id, records_id) 
VALUES (1, 1), (1, 2), (1, 3), 
	   (6, 1), (6, 2), (6, 3), 
	   (7, 1), (7, 2), (7, 3), 
	   (2, 4), (2, 5), (2, 6), 
	   (3, 7), (3, 8), (3, 9), 
	   (4, 10), (4, 11), (4, 12), 
	   (5, 13), (5, 14), (5, 15);


-- Задание 2 SELECT-запросы
-- Название и продолжительность самого длительного трека
SELECT name,  length 
  FROM music_track
ORDER BY length DESC
LIMIT 1;

-- Название треков, продолжительность которых не менее 3,5 минут
SELECT name, length 
  FROM music_track
 WHERE length >=3.5*60;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name, years 
  FROM Collection
 WHERE years BETWEEN '2018' AND '2020';

-- Исполнители, чьё имя состоит из одного слова
SELECT name_alias 
  FROM musician
 WHERE name_alias NOT LIKE '% %';

-- Название треков, которые содержат слово «мой» или «my»
SELECT name 
  FROM music_track
 WHERE name LIKE '%мое%' OR name LIKE '%ma%';


-- Задание №3 SELECT-запросы
-- Количество исполнителей в каждом жанре
SELECT COUNT(DISTINCT musician_id) musician_id, musical_genres_id 
  FROM m_mg
 GROUP BY musical_genres_id;

-- Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(record_id) 
  FROM records AS r 
       LEFT JOIN music_track AS mt 
       ON r.id = mt.id
 WHERE years BETWEEN '2018' AND '2020';

-- Средняя продолжительность треков по каждому альбому
SELECT r.name, avg(length) 
  FROM records AS r 
       LEFT JOIN music_track AS mt 
       ON r.id = mt.id
 GROUP BY r.name;

-- Все исполнители, которые не выпустили альбомы в 2020 году
SELECT name_alias, years
  FROM records AS r 
  	   LEFT JOIN music_track AS mt 
  	   ON r.id = mt.id
  	   
  	   LEFT JOIN m_r AS mr 
  	   ON r.id = mr.records_id
  	   
  	   LEFT JOIN musician AS m
  	   ON mr.musician_id = m.id
 GROUP BY name_alias, years 
HAVING years NOT BETWEEN '2020' AND '2020';

-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT m2.name_alias AS na, c.name AS col_n  
  FROM musician AS m 
       RIGHT JOIN m_r AS mr  
       ON m.id = mr.records_id
       
       LEFT JOIN musician AS m2 
       ON mr.musician_id = m2.id
       
       LEFT JOIN music_track AS mt 
       ON mr.records_id = mt.id
       
       LEFT JOIN c_mt AS cm 
       ON mt.id = cm.music_track_id
       
       LEFT JOIN collection AS c 
       ON cm.collection_id = c.id 
 GROUP BY na, col_n
HAVING m2.name_alias LIKE 'Луи Армстронг';
