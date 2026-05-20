-- dmap_object_gen_tag : type : table name : emfechfac
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emfechfac"  (
fec_fecha timestamp(0) not null,
fec_factor numeric(10) not null,
fec_descri varchar(200)
) ;
-- dmap_object_gen_tag : type : alter table name : emfechfac
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfechfac alter column fec_fecha set not null;
-- dmap_object_gen_tag : type : alter table name : emfechfac
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emfechfac alter column fec_factor set not null;
