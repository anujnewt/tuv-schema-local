set client_encoding to 'UTF8';
 set search_path = usrsai;
create or replace view usrsai."detpcanr" as select * from usrsiho."detpcanr";
