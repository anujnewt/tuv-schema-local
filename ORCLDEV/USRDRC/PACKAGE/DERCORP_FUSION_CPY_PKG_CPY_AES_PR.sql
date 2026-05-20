create or replace procedure usrdrc.dercorp_fusion_cpy_pkg_cpy_aes_pr (meta_key numeric, id_empresa numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_seq numeric;
var_seq_doc numeric;
cur_cpy_metatbl_row cursor for
select *
from dercorp_metatbl_tab
where id_meta_row = meta_key;
row_cpy record;
--cursor para obtener los documentos jams
cur_doc_ejer_row cursor for
select
*
from
pendium_ejercicio_social_tab
where
id_meta_row=meta_key;
row_cpy_doc record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('dercorp_metatbl_seq') into strict var_seq
;
select
nextval('pendium_ejercicio_soc_seq') into strict var_seq_doc
;
open cur_cpy_metatbl_row;
fetch cur_cpy_metatbl_row into row_cpy;
close cur_cpy_metatbl_row;
row_cpy.id_meta_row := var_seq;
row_cpy.id_empresa  := id_empresa;/* dmap converted statement start */
row_cpy.val_c149    :=  concat(row_cpy.val_c149, '*') ;/* dmap converted statement end */
insert into dercorp_metatbl_tab
values (row_cpy.*);
--insertamos documentos
--   open cur_doc_ejer_row;
--      fetch cur_doc_ejer_row into row_cpy_doc;
---     close cur_doc_ejer_row;
for row_cpy_doc in cur_doc_ejer_row
loop
row_cpy_doc.id_ejercicio_row  :=var_seq_doc;
row_cpy_doc.id_meta_row := var_seq;
insert into pendium_ejercicio_social_tab
values (row_cpy_doc.*);
end loop;
--  row_cpy_doc.id_ejercicio_row  :=var_seq_doc;
-- row_cpy_doc.id_meta_row := var_seq;
--insert into pendium_ejercicio_social_tab
--values row_cpy_doc;
--update dercorp_metatbl_tab set val_c149 =
--where id_meta_row = var_seq;
end;
$body$
language plpgsql
;
