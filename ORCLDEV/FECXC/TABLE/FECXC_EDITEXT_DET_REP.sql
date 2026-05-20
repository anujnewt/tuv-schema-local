-- dmap_object_gen_tag : type : table name : fecxc_editext_det_rep
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_editext_det_rep"  (
division numeric(38),
concepto numeric(38),
codmoneda varchar(3),
cobranza_dia decimal(20, 4) default 0,
cobranza_mes decimal(20, 4) default 0,
presup_mes decimal(20, 4) default 0,
varia_mes decimal(20, 4) default 0,
perc_mes decimal(20, 4) default 0,
cobranza_alafecha decimal(20, 4) default 0,
presup_alafecha decimal(20, 4) default 0,
varia_alafecha decimal(20, 4) default 0,
perc_alafecha decimal(20, 2) default 0,
cobranza_anterior decimal(20, 4) default 0,
varia_anterior decimal(20, 4) default 0,
perc_anterior decimal(20, 4) default 0,
division_desc varchar(100),
concepto_desc varchar(100) default null
) ;
