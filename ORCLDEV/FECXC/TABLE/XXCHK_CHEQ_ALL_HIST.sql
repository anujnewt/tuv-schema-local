-- dmap_object_gen_tag : type : table name : xxchk_cheq_all_hist
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_cheq_all_hist"  (
id_estado_cheque numeric(38),
id_sec_cheque numeric(38),
e_codigo numeric(38),
no_folio_det numeric(38),
id_status_mov varchar(2),
date_created timestamp(0) not null default statement_timestamp(),
modified_by varchar(30) not null,
tipo_cheq varchar(15) not null,
referencia_cliente varchar(50) not null,
id_tipo_operacion_set numeric(38),
no_cheque numeric(38),
procesado numeric(38),
group_id numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheq_all_hist
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheq_all_hist alter column date_created set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheq_all_hist
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheq_all_hist alter column modified_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheq_all_hist
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheq_all_hist alter column tipo_cheq set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheq_all_hist
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheq_all_hist alter column referencia_cliente set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheq_all_hist
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheq_all_hist add constraint fk_xxchk_ch_fk_histch_xxchk_ch foreign key (e_codigo,no_folio_det,id_status_mov) references xxchk_cheques_all(e_codigo,no_folio_det,id_status_mov) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheq_all_hist
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheq_all_hist add constraint fk_xxchk_histchk_chk foreign key (id_sec_cheque) references xxchk_captura_cheques(id_sec_cheque) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheq_all_hist
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheq_all_hist add constraint fk_xxchk_histchk_estachk foreign key (id_estado_cheque) references xxchk_cat_edos(id_estado_cheque) on delete no action not deferrable initially immediate;
