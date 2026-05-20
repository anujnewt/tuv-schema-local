-- dmap_object_gen_tag : type : table name : ecpersonapuesto
set search_path = pppt,oracle,dmap_extension,public;
create table "ecpersonapuesto"  (
identrevista numeric(38) not null default 0,
idpersonal numeric(38) not null,
idpuesto numeric(38) not null,
fecha timestamp(0) not null,
resultado numeric not null default 0,
compatibilidad numeric not null default 0,
entrevistador varchar(100),
comentarios varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : ecpersonapuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapuesto alter column identrevista set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonapuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapuesto alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonapuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapuesto alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonapuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapuesto alter column fecha set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonapuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapuesto alter column resultado set not null;
-- dmap_object_gen_tag : type : alter table name : ecpersonapuesto
set search_path = pppt,oracle,dmap_extension,public;
alter table ecpersonapuesto alter column compatibilidad set not null;
