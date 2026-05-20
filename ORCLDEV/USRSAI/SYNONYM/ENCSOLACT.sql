set client_encoding to 'UTF8';
 set search_path = usrsai;
create or replace view usrsai."encsolact" as select * from usrsiho."encsolact";
