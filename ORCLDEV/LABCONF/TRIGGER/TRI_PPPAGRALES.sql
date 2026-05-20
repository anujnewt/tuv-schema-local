CREATE OR REPLACE EDITIONABLE TRIGGER "LABCONF"."TRI_PPPAGRALES" 
before insert on LABCONF.pppagrales
for each row
begin
select sec_pppagrales.nextval into :new.gra_keysec from dual;
end;




/
ALTER TRIGGER "LABCONF"."TRI_PPPAGRALES" ENABLE;
