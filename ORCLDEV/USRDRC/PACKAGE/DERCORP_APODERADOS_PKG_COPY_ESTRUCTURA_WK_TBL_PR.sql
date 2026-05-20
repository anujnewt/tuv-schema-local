create or replace procedure usrdrc.dercorp_apoderados_pkg_copy_estructura_wk_tbl_pr (pinidempresa numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from dercorp_apoderados_wk_tab
where  id_empresa     = pinidempresa;
for i in (select * from dercorp_apoderados_tab apo
where id_empresa = pinidempresa)
loop insert into dercorp_apoderados_wk_tab ( id_empresa,
id_catalogo,
id_catalogo_valor,
des_tipo_elemento,
num_tipo_poder,
des_grupo,
des_escritura,
fec_fecha_baja,
des_tipo_baja,
des_documento,
cod_revocado,
des_proto_med_esc,
fec_proto_med_esc,
des_revocado_mediante,
fec_revocado_mediante,
id_revocacion,
atributo1,
atributo2,
atributo3,
atributo15,
fec_creation_date
)
values (pinidempresa,
i.id_catalogo,
i.id_catalogo_valor,
i.des_tipo_elemento,
i.num_tipo_poder,
i.des_grupo,
i.des_escritura,
i.fec_fecha_baja,
i.des_tipo_baja,
i.des_documento,
i.cod_revocado,
i.des_proto_med_esc,
i.fec_proto_med_esc,
i.des_revocado_mediante,
i.fec_revocado_mediante,
i.id_revocacion,
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
