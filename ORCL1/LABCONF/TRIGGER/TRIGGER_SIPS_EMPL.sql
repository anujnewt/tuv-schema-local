CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABCONF"."TRIGGER_SIPS_EMPL" 
before insert on LABCONF.com_orac_sips_empl
for each row
begin
select sips_empl.nextval into :new.ora_noctvo from dual;
end;



/
ALTER TRIGGER "LABCONF"."TRIGGER_SIPS_EMPL" ENABLE;
