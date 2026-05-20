set client_encoding to 'UTF8';
 set search_path = xx_bloqueobajas;
create or replace view xx_bloqueobajas."motivosbaja" as select * from labprod."bloqueos_motivosbaja";
