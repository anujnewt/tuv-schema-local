-- dmap_object_gen_tag : type : table name : tmp_cont_exclu
set search_path = usrsiho,oracle,dmap_extension,public;
create table "tmp_cont_exclu"  (
con_keyfol numeric(10),
con_keydep varchar(16),
con_keypue varchar(16),
con_keyemp numeric(10),
con_numcap numeric(5),
con_fecpag timestamp(0),
con_fecpro timestamp(0),
con_cosuni decimal(13, 2) not null,
con_numerr numeric(5),
con_stscon varchar(1),
con_tipfol varchar(1),
con_numlin numeric(10),
con_keynom numeric(5),
con_forpag numeric(10),
con_tipcam decimal(16, 6),
con_tiptra varchar(2),
con_keypro numeric(5),
con_arefis varchar(6),
con_descap varchar(200),
con_fpafin numeric(10),
con_tcafin decimal(16, 6),
con_keyrph numeric(10),
con_keyusu numeric(10),
con_fecmod timestamp(0),
con_odcori varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : tmp_cont_exclu
set search_path = usrsiho,oracle,dmap_extension,public;
alter table tmp_cont_exclu alter column con_cosuni set not null;
