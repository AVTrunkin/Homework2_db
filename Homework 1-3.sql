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
	name VARCHAR(200) NOT NULL,
	years INTEGER NOT NULL 
);


CREATE TABLE Music_track(
	id SERIAL PRIMARY key,
	name VARCHAR(200) NOT NULL,
	length INTEGER NOT NULL,
	record_id INTEGER not null,
	foreign key (record_id) references Records(id)
);


CREATE TABLE Collection(
	id SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	years INTEGER NOT NULL
);

CREATE TABLE C_Mt(
	collection_id INTEGER REFERENCES Collection(id),
	music_track_id INTEGER REFERENCES Music_track(id),
	CONSTRAINT pk PRIMARY KEY (collection_id, music_track_id)
);

CREATE TABLE M_Mg(
	musician_id INTEGER REFERENCES Musician(id),
	musical_genres_id INTEGER REFERENCES Musical_genres(id),
	CONSTRAINT vk PRIMARY KEY (musician_id, musical_genres_id)
);

CREATE TABLE M_R(
	musician_id INTEGER REFERENCES Musician(id),
	records_id INTEGER REFERENCES Records(id),
	CONSTRAINT sk PRIMARY KEY (musician_id, records_id)
);


-- Задание 1 заполнение таблиц

insert into Musician (name_alias) values
	('Михаил Круг'), ('Олег Газманов'), ('Денис Майданов'), ('Лучиано Паваротти'), ('Луи Армстронг'), ('Михаил_Круг'), ('Круг');

insert into Musical_genres (name) values 
	('POP'), ('CLASSIC'), ('JAZ');

insert into Records (name, years) values 
	('Кольщик', 2009), ('Исповедь', 2003), ('Мышка',2000),  -- Круг
	('Солдаты России', 2023), ('Отбой',2019), ('Сделан в СССР', 2005), -- Газманов
	('ВДВ', 2017), ('Флаг моего государства',2015), ('Русский мир', 2023), -- Майданов
	('O Sole Mio', 2007), ('Luciano Pavarotti', 2012), ('Mamma', 2007), -- Лучиано
	('All Time Greatest Hits', 2018), ('The Very Best Of Louis Armstrong', 1998), ('Cest si bon',1991); -- Луи

insert into Music_track (name, length, record_id) values 
	('Кольщик', 289,1), ('Кресты', 310,2), ('Мышка', 207, 3), 
	('Солдаты России', 263, 4), ('Отбой', 180, 5), ('Сделан в СССР', 246, 6), 
	('ВДВ', 221, 7), ('Флаг моего государства', 274, 8), ('Русский мир', 207, 9),
	('O Sole Mio', 169, 10), ('Luciano Pavarotti', 280, 11), ('Mamma', 184, 12),
	('Hello, Dolly!', 148, 13), ('What A Wonderful World', 139, 14), ('Summertime', 297, 15);

insert into Collection (name, years) values 
	('Шансон лучшее 50', 2024), ('Classic 10', 2016), ('JAZ 15',2019), ('Родина', 2024), ('Лучшее', 2025);

insert into C_Mt (collection_id, music_track_id) values
	(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9),
	(2, 10), (2, 11), (2, 12), 
	(3, 13), (3, 14), (3, 15), 
	(4, 4), (4, 6), (4, 7), (4, 8), (4, 9),
	(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10), (5, 11), (5, 12), (5, 13), (5, 14), (5, 15);

insert into M_Mg (musician_id, musical_genres_id) values
	(1, 1), (2, 1), (3, 1), (6, 1), (7, 1), (4, 2), (5, 3);

insert into M_R (musician_id, records_id) values
	(1, 1), (1, 2), (1, 3), 
	(6, 1), (6, 2), (6, 3), 
	(7, 1), (7, 2), (7, 3), 
	(2, 4), (2, 5), (2, 6), 
	(3, 7), (3, 8), (3, 9), 
	(4, 10), (4, 11), (4, 12), 
	(5, 13), (5, 14), (5, 15);


-- Задание 2 SELECT-запросы

select name,  length from music_track
order by length desc
limit 1;

select name, length from music_track
where length >=3.5*60;

select name, years from Collection
where years between '2018' and '2020';

select name_alias from musician
where name_alias not like '% %';

select name from music_track
where name like '%мое%' or name like '%ma%';


-- /Задание №3 SELECT-запросы/
-- /Количество исполнителей в каждом жанре./
select COUNT(distinct musician_id) musician_id, musical_genres_id from m_mg
group by musical_genres_id;

-- /Количество треков, вошедших в альбомы 2019–2020 годов/

select COUNT(record_id) FROM records r LEFT JOIN music_track mt ON r.id = mt.id
where years between '2018' and '2020';

-- /Средняя продолжительность треков по каждому альбому/
select r.name, avg(length) FROM records r LEFT JOIN music_track mt ON r.id = mt.id
group by r.name;

-- /Все исполнители, которые не выпустили альбомы в 2020 году/

select mt.name FROM records r LEFT JOIN music_track mt ON r.id = mt.id
where years not between '2020' and '2020';

-- /Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)/

select m2.name_alias na, c.name col_n  FROM musician m right JOIN m_r mr  ON m.id = mr.records_id
left join musician m2 on mr.musician_id = m2.id
left join music_track mt on mr.records_id = mt.id
left join c_mt cm on mt.id = cm.music_track_id
left join collection c on cm.collection_id = c.id 
group by na, col_n
having m2.name_alias like 'Луи Армстронг' ;
