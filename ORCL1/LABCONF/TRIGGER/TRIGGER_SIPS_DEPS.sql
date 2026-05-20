CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABCONF"."TRIGGER_SIPS_DEPS" 
before insert on LABCONF.com_orac_sips_deps
for each row
begin
select sips_deps.nextval into :new.ora_noctvo from dual;
end;



/
ALTER TRIGGER "LABCONF"."TRIGGER_SIPS_DEPS" ENABLE;
