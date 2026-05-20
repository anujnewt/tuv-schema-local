-- dmap_object_gen_tag : type : index name : eul4_ped_exp_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_ped_exp_i on eul4_exp_deps (ped_exp_id);
