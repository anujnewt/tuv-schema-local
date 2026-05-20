set client_encoding to 'UTF8';
 set search_path = usrsai;
create or replace view usrsai."detsolact" as select * from usrsiho."detsolact";
