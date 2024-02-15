create table countries (
  id_country serial primary key,
  name varchar (50) not null
);

create table users (
  id serial primary key,
  id_country integer not null,
  email varchar (100) not null,
  name varchar (90) not null,
  foreign key (id_country) references countries (id_country)
);