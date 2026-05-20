create or replace  function  labprod.apilabora_security_get_hashapi (p_username varchar, p_password varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
l_salt varchar(30) := '1b&?E____%ntytA7iK';
begin 

/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
return crypt.hash(encode(upper(p_username::bytea, 'hex'):: concat(bytea, l_salt , upper(p_password))) ,crypt.hash_sh1);/* dmap converted statement end */end;
$body$
language plpgsql
stable;
