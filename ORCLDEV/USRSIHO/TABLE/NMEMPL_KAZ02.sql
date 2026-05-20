-- dmap_object_gen_tag : type : index name : nmempl_kaz02
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmempl_kaz02 on nmcoempl (emp_keypro, emp_nomemp);
