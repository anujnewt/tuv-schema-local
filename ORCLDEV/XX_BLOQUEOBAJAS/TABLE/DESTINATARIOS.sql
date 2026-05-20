-- dmap_object_gen_tag : type : table name : destinatarios
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
create table "destinatarios"  (
iddestinatario numeric(38) not null,
tiponotificacion numeric(38) not null,
destinatario varchar(50) not null,
tipodestinatario numeric(38) not null,
fechacreacion timestamp(0) not null,
usuario varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : destinatarios
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table destinatarios add constraint destinatarios_pk primary key (iddestinatario);
-- dmap_object_gen_tag : type : alter table name : destinatarios
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table destinatarios alter column iddestinatario set not null;
-- dmap_object_gen_tag : type : alter table name : destinatarios
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table destinatarios alter column tiponotificacion set not null;
-- dmap_object_gen_tag : type : alter table name : destinatarios
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table destinatarios alter column destinatario set not null;
-- dmap_object_gen_tag : type : alter table name : destinatarios
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table destinatarios alter column tipodestinatario set not null;
-- dmap_object_gen_tag : type : alter table name : destinatarios
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table destinatarios alter column fechacreacion set not null;
-- dmap_object_gen_tag : type : alter table name : destinatarios
set search_path = xx_bloqueobajas,oracle,dmap_extension,public;
alter table destinatarios alter column usuario set not null;
