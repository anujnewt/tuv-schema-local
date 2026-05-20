-- dmap_object_gen_tag : type : index name : nmestr01
set search_path = labconf,oracle,dmap_extension,public;
create index nmestr01 on nmcoestr (est_nomvar, est_nivjer);
