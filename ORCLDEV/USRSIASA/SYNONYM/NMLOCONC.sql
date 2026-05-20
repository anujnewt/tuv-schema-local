set client_encoding to 'UTF8';
 set search_path = usrsiasa;
create or replace view usrsiasa."nmloconc" as select * from usrsiho."siasa_nmloconc";
