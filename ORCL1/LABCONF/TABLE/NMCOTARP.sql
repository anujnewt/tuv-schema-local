-- dmap_object_gen_tag : type : table name : nmcotarp
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcotarp"  (
arp_keyarp varchar(3),
arp_keyrep varchar(16),
arp_keytab varchar(8),
arp_keycam varchar(60),
arp_tabdep varchar(60),
arp_camdep varchar(60),
arp_tabapl varchar(1),
arp_tabpri varchar(2)
) ;
