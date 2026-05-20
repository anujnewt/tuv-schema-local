-- dmap_object_gen_tag : type : index name : eul4_gp_pri_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_gp_pri_i on eul4_access_privs (gp_app_id);
