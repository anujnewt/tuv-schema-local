-- dmap_object_gen_tag : type : index name : nmempl_kaz03
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmempl_kaz03 on nmcoempl (emp_keypro, emp_status);
