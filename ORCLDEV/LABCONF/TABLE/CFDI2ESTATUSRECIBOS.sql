-- dmap_object_gen_tag : type : table name : cfdi2estatusrecibos
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2estatusrecibos"  (
idcomprobanteemp numeric(10) not null,
est_feclec timestamp,
est_status numeric(5),
est_error varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2estatusrecibos
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2estatusrecibos add constraint pk_cfdi2estatusrecibos primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdi2estatusrecibos
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2estatusrecibos alter column idcomprobanteemp set not null;
