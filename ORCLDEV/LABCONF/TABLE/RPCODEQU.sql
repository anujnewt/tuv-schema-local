-- dmap_object_gen_tag : type : table name : rpcodequ
set search_path = labconf,oracle,dmap_extension,public;
create table "rpcodequ"  (
deq_keyrep varchar(16),
deq_defvar varchar(16),
deq_numsec numeric(38),
deq_detqry varchar(200)
) ;
