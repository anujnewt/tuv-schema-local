CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_DATOSGENERALES_AUT" 
(cliente in VARCHAR2,keyemp in varchar2, recurp in nmcoempl.emp_recurp%TYPE,
nombre in VARCHAR2, paterno in VARCHAR2, materno in VARCHAR2, domicilio in VARCHAR2, colonia in VARCHAR2,
ciudad in VARCHAR2, municipio in VARCHAR2, entidad in VARCHAR2, codigopostal in VARCHAR2, telefono in VARCHAR2,
clavebanco in VARCHAR2, cuentabanco in VARCHAR2, salariomensual in VARCHAR2, fechaingreso in DATE,
tipopago in VARCHAR2, metodopago in VARCHAR2, tipocontrato in VARCHAR2, proceso in VARCHAR2,
localidad in VARCHAR2, status in VARCHAR2, fecha in DATE)  IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   PRAGMA AUTONOMOUS_TRANSACTION;
   existe INTEGER;
BEGIN
    BEGIN
      SELECT COUNT(*) INTO existe
      FROM FoEmpleadosLABORA
      where "NumCliente" = cliente and "Clave" = recurp and "NumNomina" = keyemp;
    EXCEPTION
        WHEN OTHERS THEN
       insert into datosgenerales_errsaf values (keyemp, 'SELECT', SYSDATE,
       ' SELECT COUNT(*) FROM FoEmpleadosLABORA where "NumCliente" = ' || cliente || ' and "Clave" = ' || recurp || ' and "NumNomina" = ' || keyemp || ';  '
       );
       RETURN;
    END;
COMMIT;
  if existe > 0  then
    BEGIN
      update FoEmpleadosLABORA set
      "Nombre" = nombre, "ApPaterno" = paterno, "ApMaterno" = materno, "Domicilio" = domicilio, "Colonia" = colonia,
      "Ciudad" = ciudad, "MuniDele" = municipio, "IdEstado" = entidad, "CodPostal" = codigopostal, "Telefono" = telefono,
      "IdBanco" = clavebanco, "CLABE" = cuentabanco, "Salario" = salariomensual, "FechaIngreso" = fechaingreso, "IdTipoPago" = tipopago,
      "MetodoPago" = metodopago, "IdTipoContratacion" = tipocontrato, "IdEmpresa" = proceso, "IdUbicacion" = localidad, "IdEstatus" = status,
       "Exito" = 'N', "FechaSol" = fecha
      where "NumCliente" = cliente and "Clave" = recurp and "NumNomina" = keyemp;
    EXCEPTION
        WHEN OTHERS THEN
    NULL;
    END;
    COMMIT;
 Else
    BEGIN
      INSERT INTO FoEmpleadosLABORA VALUES
      (' ', cliente, recurp, keyemp, nombre, paterno, materno, domicilio, colonia,
      ciudad, municipio, entidad, codigopostal, telefono, clavebanco, cuentabanco, salariomensual, fechaingreso,
      tipopago, metodopago, tipocontrato, proceso, localidad, status, 'N', fecha, fecha);
    EXCEPTION
        WHEN OTHERS THEN
        NULL;
    END;
COMMIT;
end if;
END;
/
