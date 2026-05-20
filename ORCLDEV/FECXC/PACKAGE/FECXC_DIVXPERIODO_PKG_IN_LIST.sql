create or replace  function  fecxc.fecxc_divxperiodo_pkg_in_list (p_in_list varchar) returns setof t_in_list_tab as $body$
declare
-- pgv moved types start
--dmap moved type current package fecxc_divxperiodo_pkg;
-- type t_in_list_tab is table of varchar(4000);
-- pgv moved types end
l_text  varchar(32767) := p_in_list || ',';
l_idx   numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
loop
l_idx := position(',' in l_text);
exit when coalesce(l_idx, 0) = 0;
return next trim(both oracle.substr(l_text, 1, l_idx - 1));
l_text := oracle.substr(l_text, l_idx + 1);
end loop;
return;end;
$body$
language plpgsql
stable;
