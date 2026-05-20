CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."ISDATE" 
   ( p_date_str in varchar2
     , p_date_fmt in varchar2 )
   return varchar2
is
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    return_value varchar2(5);
    l_date date;
begin
    begin
        l_date := to_date(p_date_str, p_date_fmt);
        return_value := 'TRUE';
    exception
        when others then
            return_value := 'FALSE';
    end;
    return return_value;
end isdate;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."ISDATE" 
   ( p_date_str in varchar2
     , p_date_fmt in varchar2 )
   return varchar2
is
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    return_value varchar2(5);
    l_date date;
begin
    begin
        l_date := to_date(p_date_str, p_date_fmt);
        return_value := 'TRUE';
    exception
        when others then
            return_value := 'FALSE';
    end;
    return return_value;
end isdate;
/
