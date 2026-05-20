create or replace procedure labppto."sp_carga_concepp"  (itpomov smallint, itpocue smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_keycon     smallint;
ws_keydes     varchar(35);
wn_keytpo     smallint;
wn_tipo       smallint;
wi_tipcue     smallint;
cursor1 cursor for
select distinct cue_keycue,cue_keydes
from    pplocuen;
begin
--wn_contreg := 0;
open cursor1;
loop
fetch cursor1 into
ws_keycon, ws_keydes;
exit when not found; /* apply on cursor1 */
/* the original statement block */
insert into pplocuen(cue_keycue, cue_keytpo, cue_keydes, cue_tipcue)
values (ws_keycon, itpomov, ws_keydes, itpocue);
--wn_contreg := wn_contreg + 1;
end loop;
close cursor1;
--total := wn_contreg;
--return wn_contreg;
end;
$body$
language plpgsql
;
