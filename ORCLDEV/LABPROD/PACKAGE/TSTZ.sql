-- dmap_object_gen_tag : type : domain name : utils_tstz
set search_path = labprod,oracle,dmap_extension,public;
create domain utils_tstz as timestamp(6) with time zone;
