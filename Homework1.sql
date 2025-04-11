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

insert into Musician (name_alias) values
	('Михаил Круг'), ('Олег Газманов'), ('Денис Майданов'), ('Лучиано Паваротти'), ('Луи Армстронг');

insert into Musical_genres (name) values 
	('POP'), ('CLASSIC'), ('JAZ');

insert into Records (name, years) values 
	('Кольщик', 2009), ('Исповедь', 2003), ('Мышка',2000),  -- Круг
	('Солдаты России', 2023), ('Отбой',2019), ('Сделан в СССР', 2005), -- Газманов
	('ВДВ', 2017), ('Флаг моего государства',2015), ('Русский мир', 2023), -- Майданов
	('O Sole Mio', 2007), ('Luciano Pavarotti', 2012), ('Mamma', 2007), -- Лучиано
	('All Time Greatest Hits', 2018), ('The Very Best Of Louis Armstrong', 1998), ('Cest si bon',1991); -- Луи

insert into Music_track (name, length, record_id) values 
	('Кольщик', 289,31), ('Кресты', 310,32), ('Мышка', 207, 33), 
	('Солдаты России', 263, 34), ('Отбой', 180, 35), ('Сделан в СССР', 246, 36), 
	('ВДВ', 221, 37), ('Флаг моего государства', 274, 38), ('Русский мир', 207, 39),
	('O Sole Mio', 169, 40), ('Luciano Pavarotti', 280, 41), ('Mamma', 184, 42),
	('Hello, Dolly!', 148, 43), ('What A Wonderful World', 139, 44), ('Summertime', 297, 45);

insert into Collection (name, years) values 
	('Шансон лучшее 50', 2024), ('Classic 10', 2016), ('JAZ 15',2019), ('Родина', 2024), ('Лучшее', 2025);


