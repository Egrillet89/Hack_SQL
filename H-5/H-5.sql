create table discounts (
  id_discount serial primary key,
  status varchar (10) not null,
  percentage integer not null
);

create table offers (
  id_offer serial primary key,
  status varchar (20) not null
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
  price integer not null,
  price_with_tax integer not null,
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
  foreign key (id_customer) references customers  (id_customer)
);