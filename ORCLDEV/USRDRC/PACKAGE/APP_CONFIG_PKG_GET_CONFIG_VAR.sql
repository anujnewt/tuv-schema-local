create or replace procedure usrdrc.app_config_pkg_get_config_var (configcode varchar, configvalue inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
gstencryptedpassword  varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if configcode = 'PWD_DOC'
then
select
ss_crypto_pkg.decrypt_fn(val_config) into strict configvalue
from
app_config_tab
where
cod_config = configcode;
else
select
val_config into strict configvalue
from
app_config_tab
where
cod_config = configcode;
end if;end;
$body$
language plpgsql
;
