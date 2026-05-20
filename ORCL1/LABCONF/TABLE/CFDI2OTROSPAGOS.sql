-- dmap_object_gen_tag : type : table name : cfdi2otrospagos
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2otrospagos"  (
idnomina numeric(10) not null,
tipootropago varchar(3) not null,
clave varchar(15) not null,
concepto varchar(100) not null,
importe decimal(18, 2) not null,
subsidiocausado decimal(18, 2),
saldoafavor decimal(18, 2),
anio numeric(10),
remanentesalfav decimal(18, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2otrospagos
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2otrospagos alter column idnomina set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2otrospagos
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2otrospagos alter column tipootropago set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2otrospagos
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2otrospagos alter column clave set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2otrospagos
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2otrospagos alter column concepto set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2otrospagos
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2otrospagos alter column importe set not null;
