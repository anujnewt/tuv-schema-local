CREATE OR REPLACE EDITIONABLE TRIGGER "LABCONF"."TRIGGER_SIPS_PUES" 
before insert on LABCONF.com_orac_sips_pues
for each row
begin
select sips_pues.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABCONF"."TRIGGER_SIPS_PUES" ENABLE;
