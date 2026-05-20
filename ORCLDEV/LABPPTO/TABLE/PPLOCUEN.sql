-- dmap_object_gen_tag : type : table name : pplocuen
set search_path = labppto,oracle,dmap_extension,public;
create table "pplocuen"  (
cue_keycue numeric(38) not null,
cue_keytpo numeric(38) not null,
cue_keydes char(35) not null,
cue_tipcue numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplocuen
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocuen alter column cue_keycue set not null;
-- dmap_object_gen_tag : type : alter table name : pplocuen
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocuen alter column cue_keytpo set not null;
-- dmap_object_gen_tag : type : alter table name : pplocuen
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocuen alter column cue_keydes set not null;
-- dmap_object_gen_tag : type : alter table name : pplocuen
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocuen alter column cue_tipcue set not null;
