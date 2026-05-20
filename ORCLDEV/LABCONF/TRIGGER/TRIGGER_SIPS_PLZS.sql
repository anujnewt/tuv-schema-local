CREATE OR REPLACE EDITIONABLE TRIGGER "LABCONF"."TRIGGER_SIPS_PLZS" 
before insert on LABCONF.com_orac_sips_plzs
for each row
begin
select sips_plzs.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABCONF"."TRIGGER_SIPS_PLZS" ENABLE;
