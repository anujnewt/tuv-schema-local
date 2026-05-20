-- dmap_object_gen_tag : type : table name : grupo360
set search_path = pppt,oracle,dmap_extension,public;
create table "grupo360"  (
idgrupo numeric(38) not null default 0,
tipo numeric(38),
tipoevaluacion numeric(38),
perfil numeric(38),
pesojefe numeric(38),
pesopares numeric(38),
pesosubordinados numeric(38),
pesoclientes numeric(38),
status numeric(38),
fecha timestamp(0),
nombre varchar(50),
nivel numeric(38),
pesoclientesexternos numeric(38),
pesoautoevaluacion numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : grupo360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupo360 alter column idgrupo set not null;
