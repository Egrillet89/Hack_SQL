create table countries (
  id_country serial primary key,
  name varchar (50) not null
);

create table priorities (
  id_priority serial primary key,
  name varchar (10) not null
);

create table contact_request (
  id serial primary key,
  id_priority integer not null,
  id_country integer not null,
  name varchar (50) not null,
  email varchar (100) not null,
  address varchar (300) not null,
  foreign key (id_country) references countries (id_country),
  foreign key (id_priority) references priorities (id_priority)
);

insert into countries (name) 
  values ('USA'),('Portugal'),('France'),('Spain'),('Poland');

select * from countries;

insert into priorities (name)
  values ('High'),('Medium'),('Low');
  
select * from priorities;

insert into contact_request (name, email, address,id_country,id_priority)
  values ('Adrian','Adrian@gmail.com','Lisboa', 2, 2),
         ('Eleazar','Eleazar@gmail.com','Paris', 3, 1),
         ('Jesus','Jesus@gmail.com','Varsovia', 5, 3);

select u.id as id, u.email, u.name as fullname, c.name as country, u.address as address, p.name as priority
  from contact_request u 
  inner join countries c on u.id_country = c.id_country
  inner join priorities p on u.id_priority = p.id_priority;
  
DELETE FROM contact_request
WHERE id = (SELECT MAX(id) FROM contact_request);

select u.id as id, u.email, u.name as fullname, c.name as country, u.address as address, p.name as priority
  from contact_request u 
  inner join countries c on u.id_country = c.id_country
  inner join priorities p on u.id_priority = p.id_priority;
  
DELETE FROM contact_request
WHERE id = (SELECT min(id) FROM contact_request);  

select u.id as id, u.email, u.name as fullname, c.name as country, u.address as address, p.name as priority
  from contact_request u 
  inner join countries c on u.id_country = c.id_country
  inner join priorities p on u.id_priority = p.id_priority;
