-- dmap_object_gen_tag : type : table name : cfdi2qr
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2qr"  (
idcomprobanteemp numeric(10) not null,
qrcode bytea
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2qr
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2qr add constraint pk_cfdi2qr primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdi2qr
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2qr alter column idcomprobanteemp set not null;
