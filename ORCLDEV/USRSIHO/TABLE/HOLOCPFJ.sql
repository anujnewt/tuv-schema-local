-- dmap_object_gen_tag : type : table name : holocpfj
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holocpfj"  (
cpf_repeti varchar(3) not null,
cpf_keycon varchar(3) not null,
cpf_keycof varchar(3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holocpfj
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocpfj add constraint pk_hocpf primary key (cpf_repeti,cpf_keycon,cpf_keycof);
-- dmap_object_gen_tag : type : alter table name : holocpfj
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocpfj alter column cpf_repeti set not null;
-- dmap_object_gen_tag : type : alter table name : holocpfj
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocpfj alter column cpf_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : holocpfj
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocpfj alter column cpf_keycof set not null;
