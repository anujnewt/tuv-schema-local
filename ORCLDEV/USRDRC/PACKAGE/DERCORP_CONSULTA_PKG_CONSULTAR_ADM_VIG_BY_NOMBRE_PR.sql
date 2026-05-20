create or replace procedure usrdrc.dercorp_consulta_pkg_consultar_adm_vig_by_nombre_pr (p_id_empresa integer ,p_id_flex_tab varchar ,p_nombre varchar) as $body$
declare
i record;
-- pgv moved types start
-- pgv moved types end
v_cadena_sql             varchar(5000);
rsresultado              refcursor;
rowmeta                  dercorp_metatbl_tab%rowtype;
/*
cursor con_adm_vig_cur(cp_id_empresa   in integer
,cp_id_flex_tab  in varchar2)
is
select   meta.*
from     dercorp_metatbl_tab meta
where    meta.id_empresa  =   cp_id_empresa
and      meta.id_flex_tbl =   cp_id_flex_tab
and      meta.val_c15 is not null --no de orden
--and      ( (meta.val_c4 is null ) or (meta.val_c7 is null ) ) --jjaq 09/01/2019 se comenta para el punto prioritario numero 16
and val_c1 in(15611,16787)
order by to_number(meta.val_c15), dercorp_catalogs_pkg_get_funcionarios_fn(meta.val_c1);
*/
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from dercorp_con_adm_vig_tmp
where 1=1
and id_empresa = p_id_empresa
and id_flex_tbl = p_id_flex_tab
;/* dmap converted statement start */
v_cadena_sql :=  concat('SELECT META.* FROM DERCORP_METATBL_TAB META WHERE META.ID_EMPRESA = ', p_id_empresa , ' AND META.ID_FLEX_TBL = ' , p_id_flex_tab , ' AND NULLIF(META.VAL_C15::text, '') IS NOT NULL AND VAL_C1 IN (' , p_nombre , ')  ORDER BY  (META.VAL_C15)::numeric, DERCORP_CATALOGS_PKG_GET_FUNCIONARIOS_FN(META.VAL_C1)') ; /* dmap converted statement end *//* dmap converted statement */
if  p_id_flex_tab = '8' or
--p_id_flex_tab = 16 or
p_id_flex_tab = '25' or
--p_id_flex_tab = 26 or
p_id_flex_tab = '39'
--p_id_flex_tab = 44 or
--p_id_flex_tab = 45 or
--p_id_flex_tab = 43
then
/*
open rsresultado for v_cadena_sql;
loop
fetch rsresultado into lincount;
exit when rsresultado%notfound;
end loop;*/
--for i in select * from con_adm_vig_cur(p_id_empresa,p_id_flex_tab)
open rsresultado for execute v_cadena_sql;
loop
fetch rsresultado into rowmeta;
exit when not found; /* apply on rsresultado */
--                if (i.val_c4 is not null)then  --jjaq 11/01/2019 se comenta para el punto prioritario numero 16
--                    null;
--                else
insert into dercorp_con_adm_vig_tmp(id_meta_row
,id_flex_tbl
,id_empresa
,val_c1
,val_c2
,val_c3
,val_c15
) values (
rowmeta.id_meta_row
,rowmeta.id_flex_tbl
,rowmeta.id_empresa
,rowmeta.val_c1
,rowmeta.val_c2
,rowmeta.val_c3
,rowmeta.val_c15
);
--                end if;
end loop;
end if;
if  p_id_flex_tab = '9' or
p_id_flex_tab = '11' or
p_id_flex_tab = '12' or
p_id_flex_tab = '13' or
p_id_flex_tab = '14' or
p_id_flex_tab = '15' or
p_id_flex_tab = '16' or
p_id_flex_tab = '26' or
p_id_flex_tab = '43' or
p_id_flex_tab = '44' or
p_id_flex_tab = '45' or
p_id_flex_tab = '46' or -- se agrega flex table jams 04/07/2017
p_id_flex_tab = '40' then
--for i in select * from con_adm_vig_cur(p_id_empresa,p_id_flex_tab)
open rsresultado for execute v_cadena_sql;
loop
fetch rsresultado into rowmeta;
exit when not found; /* apply on rsresultado */
--                if (i.val_c4 is not null) and
--                   (i.val_c7 is not null)then
--                    null;                             --jjaq 11/01/2019 se comenta para el punto prioritario numero 16
--                elsif(i.val_c4 is not null) and
--                     (i.val_c7 is null)then           --jjaq 11/01/2019 se comenta para el punto prioritario numero 16
/*
insert into dercorp_con_adm_vig_tmp(id_meta_row
,id_flex_tbl
,id_empresa
,val_c1
,val_c2
,val_c3
,val_c5
,val_c6
,val_c8
,val_c15
) values(
i.id_meta_row
,i.id_flex_tbl
,i.id_empresa
,null
,i.val_c2
,null
,i.val_c5
,i.val_c6
,i.val_c8
,i.val_c15
);
elsif(i.val_c4 is null) and
(i.val_c7 is not null)then
insert into dercorp_con_adm_vig_tmp( id_meta_row
,id_flex_tbl
,id_empresa
,val_c1
,val_c2
,val_c3
,val_c5
,val_c6
,val_c8
,val_c15
) values(
i.id_meta_row
,i.id_flex_tbl
,i.id_empresa
,i.val_c1
,i.val_c2
,i.val_c3
,null--i.val_c5       --jjaq 22-10-2018 no antes null, con null no muestra la suplencia en consulta
,null
,i.val_c8
,i.val_c15
);
*/
--                elsif(i.val_c4 is null) and
--                     (i.val_c7 is null)then
insert into dercorp_con_adm_vig_tmp( id_meta_row
,id_flex_tbl
,id_empresa
,val_c1
,val_c2
,val_c3
,val_c5
,val_c6
,val_c8
,val_c15
) values (
rowmeta.id_meta_row
,rowmeta.id_flex_tbl
,rowmeta.id_empresa
,rowmeta.val_c1
,rowmeta.val_c2
,rowmeta.val_c3
,rowmeta.val_c5
,rowmeta.val_c6
,rowmeta.val_c8
,rowmeta.val_c15
);
--                end if;
end loop;
end if;
/* commit; */
end;
$body$
language plpgsql
;
