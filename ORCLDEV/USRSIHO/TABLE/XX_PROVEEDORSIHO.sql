-- dmap_object_gen_tag : type : table name : xx_proveedorsiho
set search_path = usrsiho,oracle,dmap_extension,public;
create table "xx_proveedorsiho"  (
noemple numeric(10),
tipoproveedor numeric(10),
cvempresa numeric(10),
nombre varchar(40),
paterno varchar(40),
materno varchar(40),
rfc varchar(13),
curp varchar(18),
perjuridica numeric(10),
tipomov varchar(5),
status varchar(3),
fecha timestamp(0),
hora varchar(10),
rfcanterior varchar(13),
telefono varchar(10),
ciudad varchar(40),
estado varchar(40),
delegacion varchar(40),
calle varchar(60),
nointerior varchar(40),
noexterior varchar(40),
colonia varchar(40),
codigopostal varchar(6)
) ;
