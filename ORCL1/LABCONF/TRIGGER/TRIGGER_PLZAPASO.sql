CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABCONF"."TRIGGER_PLZAPASO" 
before insert on LABCONF.plzapaso
for each row
begin
select sequ_plzapaso.nextval into :new.ora_noctvo from dual;
end;



/
ALTER TRIGGER "LABCONF"."TRIGGER_PLZAPASO" ENABLE;
