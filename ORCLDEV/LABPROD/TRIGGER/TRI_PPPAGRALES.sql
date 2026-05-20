CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRI_PPPAGRALES" 
before insert on LABPROD.pppagrales
for each row
begin
select sec_pppagrales.nextval into :new.gra_keysec from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRI_PPPAGRALES" ENABLE;
