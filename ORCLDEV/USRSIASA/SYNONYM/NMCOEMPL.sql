set client_encoding to 'UTF8';
 set search_path = usrsiasa;
create or replace view usrsiasa."nmcoempl" as select * from usrsiho."siasa_nmcoempl";
