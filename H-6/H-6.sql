create table discounts (
  id_discount serial primary key,
  status Boolean default false,
  percentage integer not null
);

create table offers (
  id_offer serial primary key,
  status varchar (10) not null
);

create table taxes (
  id_tax serial primary key,
  percentage integer not null
);

create table country (
  id_country serial primary key,
  name varchar (30) not null
);

create table roles (
  id_role serial primary key,
  name varchar (20) not null
);

create table payments (
  id_payments serial primary key,
  payment_type varchar (20) not null
);

create table invoice_status (
  id_invoice_status serial primary key,
  status varchar (20) not null
);

create table customers (
  id_customer serial primary key,
  email varchar (100) not null,
  id_country integer not null,
  id_role integer not null,
  name varchar (100) not null,
  age integer,
  password varchar (20) not null,
  address varchar (200),
  foreign key (id_country) references country (id_country),
  foreign key (id_role) references roles (id_role)
);

create table products (
  id_product serial primary key,
  id_discount integer not null,
  id_offer integer not null,
  id_tax integer not null,
  name varchar (50) not null,
  details varchar (200) not null,
  minimum_stock integer not null,
  max_stock integer not null,
  current_stock integer not null,
  price decimal (10,2) not null,
  price_with_tax decimal (10,2) not null,
  foreign key (id_discount) references discounts (id_discount),
  foreign key (id_offer) references offers (id_offer),
  foreign key (id_tax) references taxes (id_tax)
);

create table invoices (
  id_invoice serial primary key,
  id_customer integer not null,
  id_payments integer not null,
  id_invoice_status integer not null,
  payment_date date not null,
  total_to_pay decimal (10,2) not null,
  foreign key (id_customer) references customers (id_customer),
  foreign key (id_payments) references payments (id_payments),
  foreign key (id_invoice_status) references invoice_status (id_invoice_status)
);

create table orders (
  id_order serial primary key,
  id_invoice integer not null,
  id_product integer not null,
  detail varchar (100),
  amount integer not null,
  price decimal (10,2) not null,
  foreign key (id_invoice) references invoices (id_invoice),
  foreign key (id_product) references products (id_product)
);

create table product_customers (
  id_product integer not null,
  id_customer integer not null,
  foreign key (id_product) references products (id_product),
  foreign key (id_customer) references customers  (id_customer),
  PRIMARY KEY (id_customer, id_product)
);



insert into discounts (percentage)
  values (10),
         (20),
         (30);

insert into roles (name)
  values ('Tier 0'),
         ('Tier 1'),
         ('Tier 2'),
         ('Banned');
         
insert into taxes (percentage)
  values (12),
         (14),
         (16);
         
insert into payments (payment_type)
  values ('Cash'),
         ('Credit Card'),
         ('Transfer');
         
insert into country (name)
  values ('Venezuela'),
         ('Spain'),
         ('USA');
         
insert into invoice_status (status)
  values ('Active'),
         ('Inactive'),
         ('On Hold');
         
insert into customers (email, name, age, password,address,id_role,id_country)
  Values ('foo@foo.com', 'foo', 24,'pass1234','caracas',1,1),
         ('bar@bar.com', 'bar', 35, 'Clave333', 'madrid',2,2),
         ('via@via.com' , 'via',40 ,'vi123456', 'guanare', 1,1),
         ('zap@zap.com', 'zap', 44, '123ppp','miami',3,3);


insert into offers (status)
  Values ('verano'),
         ('invierno'),
         ('primavera'),
         ('otoño');

insert into products (name, details, minimum_stock,max_stock, current_stock, price , price_with_tax,id_discount, id_offer, id_tax)
  Values ('Luz Led','60.000Lm de potencia', 1, 100, 35, 135.40,157.06, 1, 1,3),
         ('luz led', '50.000Lm de potencia', 1,100,60,110.3,125.74,2,2,2),
         ('Luz Led', '30.000Lm de potencia', 1,100,14,95,106.4,3,4,1);

insert into invoices(id_customer, id_payments, id_invoice_status,payment_date,total_to_pay)
  values (1,1,1,'02-15-2024',157.06),
         (2,2,2,'02-01-2024',251.48),
         (3,3,3,'01-25-2024',425.6);
         
insert into orders (id_invoice, id_product, detail, amount,price)
  values (1,1,'60.000Lm de potencia',1,157.06),
         (2,2,'50.000Lm de potencia', 2,125.74),
         (3,3,'30.000Lm de potencia',4,106.4);
         

delete from customers where id_customer = (select max(id_customer) from customers); 

update customers SET name = 'bot' where id_customer = 2;

update taxes set percentage = 18;

update products set price = 150, price_with_tax = 177 
  where id_product IN (SELECT id_product FROM products);


select u.email, u.name as fullname, u.age as age, u.password, u.address, c.name as country, r.name as roles
  from customers u
  inner join country c on u.id_country = c.id_country
  inner join roles r on u.id_role = r.id_role;


select p.name, p.details,p.minimum_stock,p.max_stock,p.current_stock,p.price,p.price_with_tax, d.percentage as discounts,t.percentage as taxes,o.status as offers
  from products p
  inner join discounts d on p.id_discount = d.id_discount
  inner join taxes t on p.id_tax = t.id_tax
  inner join offers o on p.id_offer = o.id_offer;

select i.id_invoice,c.name as customers,p.payment_type as payments, s.status as invoice_status, i.payment_date,i.total_to_pay
  from invoices i
  inner join customers c on i.id_customer = c.id_customer
  inner join payments p on i.id_payments = p.id_payments
  inner join invoice_status s on i.id_invoice_status = s.id_invoice_status;

select i.id_invoice as invoices, p.name as products, o.detail, o.amount, o.price
  from orders o
  inner join invoices i on o.id_invoice = i.id_invoice
  inner join products p on o.id_product = p.id_product;
  




