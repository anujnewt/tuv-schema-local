-- dmap_object_gen_tag : type : table name : pcdetalleanda
set search_path = usrsiho,oracle,dmap_extension,public;
create table "pcdetalleanda"  (
deaidnumdet numeric(10) not null,
deaidnumenc numeric(10) not null,
deahorapeticion varchar(5),
deacodigoempleado numeric(10) not null,
deapersonaje varchar(40),
deafechagrabacion timestamp(0),
deanumeroprogramas varchar(20),
deatabulador numeric(5),
deapagdiftab numeric(5),
deaclapueact varchar(16) not null,
deatipocontrato numeric(10) not null,
deatipocontratacio varchar(1) not null,
deafoliocontrato numeric(10),
deafechaactualiza timestamp(0),
deafechacapturacon timestamp(0),
deaidproduccion numeric(10),
deaauxiliarnum1 numeric(10),
deaauxiliarnum2 numeric(10),
deaauxiliarchar1 varchar(20),
deaauxiliarchar2 varchar(20),
deaparteconjunto varchar(100),
deaestatus numeric(10),
deakeytab numeric(10),
deafecinicont timestamp(0),
deafecfincont timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : pcdetalleanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcdetalleanda add constraint ct_pcdetalleand2 primary key (deaidnumdet);
-- dmap_object_gen_tag : type : alter table name : pcdetalleanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcdetalleanda alter column deaidnumdet set not null;
-- dmap_object_gen_tag : type : alter table name : pcdetalleanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcdetalleanda alter column deaidnumenc set not null;
-- dmap_object_gen_tag : type : alter table name : pcdetalleanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcdetalleanda alter column deacodigoempleado set not null;
-- dmap_object_gen_tag : type : alter table name : pcdetalleanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcdetalleanda alter column deaclapueact set not null;
-- dmap_object_gen_tag : type : alter table name : pcdetalleanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcdetalleanda alter column deatipocontrato set not null;
-- dmap_object_gen_tag : type : alter table name : pcdetalleanda
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcdetalleanda alter column deatipocontratacio set not null;
