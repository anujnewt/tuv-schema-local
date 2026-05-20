-- dmap_object_gen_tag : type : table name : cgm001
set search_path = fecxc,oracle,dmap_extension,public;
create table "cgm001"  (
cg15id numeric(38) not null,
cgm1id numeric(38) not null,
cgm1im char(4),
cgm1cd varchar(100),
cgm1ip numeric(38),
cgm1ni numeric(38) not null,
cgm1ic numeric(38),
ctades varchar(100),
ctaedi char(1),
ctafec varchar(8),
ctamov char(1),
ctaniv char(1),
ctasal char(1),
ctatip char(1),
ctausu varchar(10),
ctabal char(1) not null,
ctaref char(1),
ctaefe char(1),
ctadol char(1),
ctadef varchar(40),
ctaaux char(1),
cgm1au numeric(38) not null,
cgm1re varchar(255),
cgm1fi varchar(100),
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cgm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgm001 add primary key (cgm1id);
-- dmap_object_gen_tag : type : alter table name : cgm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgm001 alter column cg15id set not null;
-- dmap_object_gen_tag : type : alter table name : cgm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgm001 alter column cgm1id set not null;
-- dmap_object_gen_tag : type : alter table name : cgm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgm001 alter column cgm1ni set not null;
-- dmap_object_gen_tag : type : alter table name : cgm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgm001 alter column ctabal set not null;
-- dmap_object_gen_tag : type : alter table name : cgm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgm001 alter column cgm1au set not null;
