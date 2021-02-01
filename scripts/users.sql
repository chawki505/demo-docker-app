-- create table
drop table if exists users;
create table users (
  name varchar(40) not null,
  fan_type INT DEFAULT 1,
  id int4 not null
);

-- insert table
insert into users (name, fan_type, id)
  select  ('user' || (t.id::text)) as nick,
          (random() * 1)::integer,
          (random() * 100000)::integer
  from (select * from generate_series(1, 100000) as id) as t;
