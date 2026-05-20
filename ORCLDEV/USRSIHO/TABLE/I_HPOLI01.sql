-- dmap_object_gen_tag : type : index name : i_hpoli01
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hpoli01 on holopoli (pol_keypro, pol_keyapr, pol_keynom, pol_numemi);
