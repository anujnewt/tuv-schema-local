create or replace procedure usrdrc.dercorp_apoderados_pkg_copy_estructura_pr (pstescriturafrom varchar, pstescriturato varchar, pinidempresahasta numeric, pinidempresadesde numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--delete from dercorp_apoderados_tab
delete from dercorp_apoderados_wk_tab
where  id_empresa     = pinidempresahasta
and    des_escritura  = pstescriturato
;
for i in (select * from dercorp_apoderados_tab apo
where 1=1
and   des_escritura = pstescriturafrom
and   id_empresa    = pinidempresadesde
)
loop
--ecm 06 mayo 2016 captura - consulta - cambiar tabla final por tabla de trabajo
--insert into dercorp_apoderados_tab apo ( id_empresa, insert into dercorp_apoderados_wk_tab (  id_empresa,
id_catalogo,
id_catalogo_valor,
des_tipo_elemento,
num_tipo_poder,
des_grupo,
des_escritura,
fec_fecha_baja,
des_tipo_baja,
des_documento,
atributo1,
atributo2,
atributo3,
atributo15,
fec_creation_date
)
values (pinidempresahasta,
i.id_catalogo,
i.id_catalogo_valor,
i.des_tipo_elemento,
i.num_tipo_poder,
i.des_grupo,
pstescriturato,
--i.des_escritura,
i.fec_fecha_baja,
i.des_tipo_baja,
i.des_documento,
i.atributo1,
i.atributo2,
i.atributo3,
i.atributo15,
i.fec_creation_date
);
end loop;
/* commit; */
end;
$body$
language plpgsql
;
