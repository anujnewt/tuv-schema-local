set client_encoding to 'UTF8';
 set search_path = usrsai;
create or replace view usrsai."detpetco" as select * from usrsiho."detpetco";
