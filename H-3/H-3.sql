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

