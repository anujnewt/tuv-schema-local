CREATE OR REPLACE EDITIONABLE PACKAGE "FECXC"."XXCHK_ACTUALIZA_ESTADOS_AUT" 
AS
  PROCEDURE XXCHK_ACT_ESTATUS_AUT;
END XXCHK_ACTUALIZA_ESTADOS_AUT;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "FECXC"."XXCHK_ACTUALIZA_ESTADOS_AUT" 
AS
  PROCEDURE XXCHK_ACT_ESTATUS_AUT
  IS
  V_E_CODIGO 					 XXCHK_CHEQUES_ALL.E_CODIGO%TYPE;
  V_REFERENCIA_CLIENTE			 XXCHK_CHEQUES_ALL.REFERENCIA_CLIENTE%TYPE;
  V_IMPORTE					 	 XXCHK_CHEQUES_ALL.IMPORTE%TYPE;
  V_MONEDA						 XXCHK_CHEQUES_ALL.MONEDA%TYPE;
  V_ID_ESTADO_CHEQUE			 XXCHK_CAPTURA_CHEQUES.ID_ESTADO_CHEQUE%TYPE;
  V_ID_TIPO_OPERACION_SET 		 XXCHK_CHEQUES_ALL.ID_TIPO_OPERACION_SET%TYPE;
  V_CUENTA_SBC_CAP_CHK			 INT;
  V_CUENTA_SBC_CHK_ALL			 INT;
  V_CUENTA_SBC					 INT;
  --------SELECCIONA TODOS LOS REGISTROS REPETIDOS EN XXCHK_CHEQUES_ALL, BASADOS EN CAPTURA CHEQUES PARA ACTUALIZAR LOS SBC
  CURSOR REG_REPETIDOS_SBC IS
  SELECT C.E_CODIGO, C.REFERENCIA_CLIENTE, C.IMPORTE, C.MONEDA
  FROM  XXCHK_CHEQUES_ALL A, (
									SELECT 	  E_CODIGO, REFERENCIA_CLIENTE, IMPORTE, MONEDA
                                    FROM   	  XXCHK_CHEQUES_ALL A, XXCHK_MAPEO_DE_ESTADOS C, XXCHK_CAT_EDOS D
                                    WHERE     PROCESADO IS NULL
                                    AND       C.ID_ESTADO_CHEQUE = D.ID_ESTADO_CHEQUE
                                    AND 	  A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
                                    AND    	  D.TIPO_OPERACION IN ('SBC')
                                    GROUP BY  E_CODIGO, REFERENCIA_CLIENTE, IMPORTE, MONEDA
								) B,
	     XXCHK_CAPTURA_CHEQUES C
  WHERE  A.E_CODIGO=B.E_CODIGO
  AND	 A.REFERENCIA_CLIENTE=B.REFERENCIA_CLIENTE
  AND    A.IMPORTE=B.IMPORTE
  AND	 A.MONEDA=B.MONEDA
  AND    A.E_CODIGO=C.E_CODIGO
  AND	 A.REFERENCIA_CLIENTE=C.REFERENCIA_CLIENTE
  AND    A.IMPORTE=C.IMPORTE
  AND	 A.MONEDA=C.MONEDA
  AND    A.PROCESADO IS NULL
  AND    C.PROCESADO IS NULL  				                        ---SOLO TOMA SI SON NUEVOS O SI YA SE REGISTRARON COMO 200 DE SBC
  AND 	 C.ID_ESTADO_CHEQUE IN ( SELECT DISTINCT ID_ESTADO_CHEQUE   ---SOLO SE PUEDEN CAMBIAR DE ESTADO LOS REG. EN DICHOS ESTADOS
  		 					     FROM XXCHK_CAT_CAMBIOS_ESTADO
								 WHERE ID_ESTADO_B IN (7))
  GROUP BY C.E_CODIGO, C.REFERENCIA_CLIENTE, C.IMPORTE, C.MONEDA;
  CURSOR ACT_REG_REPETIDOS IS
  SELECT DISTINCT C.E_CODIGO, C.REFERENCIA_CLIENTE, C.IMPORTE, C.MONEDA
  FROM 	 XXCHK_CHEQUES_ALL C
  WHERE  PROCESADO=100;
  -----SELECCIONA TODOS LOS REGISTROS REPETIDOS EN XXCHK_CHEQUES_ALL, BASADOS EN CAPTURA CHEQUES PARA ACTUALIZAR LOS EN FIRME Y RECHAZADOS
  CURSOR REG_FIRME IS
  SELECT C.E_CODIGO, C.REFERENCIA_CLIENTE, C.IMPORTE, C.MONEDA
  FROM  XXCHK_CHEQUES_ALL A, (
									SELECT E_CODIGO, REFERENCIA_CLIENTE, IMPORTE, MONEDA
                                    FROM   	  XXCHK_CHEQUES_ALL A, XXCHK_MAPEO_DE_ESTADOS C, XXCHK_CAT_EDOS D
                                    WHERE     PROCESADO IS NULL
                                    AND       C.ID_ESTADO_CHEQUE = D.ID_ESTADO_CHEQUE
                                    AND 	  A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
                                    AND    	  D.TIPO_OPERACION IN ('ENFIRME','RECHAZADO')
                                    GROUP BY  E_CODIGO, REFERENCIA_CLIENTE, IMPORTE, MONEDA
								) B,
	     XXCHK_CAPTURA_CHEQUES C
  WHERE  A.E_CODIGO=B.E_CODIGO
  AND	 A.REFERENCIA_CLIENTE=B.REFERENCIA_CLIENTE
  AND    A.IMPORTE=B.IMPORTE
  AND	 A.MONEDA=B.MONEDA
  AND    A.E_CODIGO=C.E_CODIGO
  AND	 A.REFERENCIA_CLIENTE=C.REFERENCIA_CLIENTE
  AND    A.IMPORTE=C.IMPORTE
  AND	 A.MONEDA=C.MONEDA
  AND    A.PROCESADO IS NULL
  AND    C.PROCESADO IS NULL
  AND 	 C.ID_ESTADO_CHEQUE IN ( SELECT DISTINCT ID_ESTADO_CHEQUE   ---SOLO SE PUEDEN CAMBIAR DE ESTADO LOS REG. EN DICHOS ESTADOS
  		 					     FROM XXCHK_CAT_CAMBIOS_ESTADO
								 WHERE ID_ESTADO_B IN (8,9))
  GROUP BY C.E_CODIGO, C.REFERENCIA_CLIENTE, C.IMPORTE, C.MONEDA;
  CURSOR REG_REPETIDOS_FIRME IS
  SELECT C.E_CODIGO, C.REFERENCIA_CLIENTE, C.IMPORTE, C.MONEDA
  FROM  XXCHK_CHEQUES_ALL A, (
									SELECT E_CODIGO, REFERENCIA_CLIENTE, IMPORTE, MONEDA
                                    FROM   	  XXCHK_CHEQUES_ALL A, XXCHK_MAPEO_DE_ESTADOS C, XXCHK_CAT_EDOS D
                                    WHERE     PROCESADO IS NULL
                                    AND       C.ID_ESTADO_CHEQUE = D.ID_ESTADO_CHEQUE
                                    AND 	  A.ID_TIPO_OPERACION_SET = C.ID_TIPO_OPERACION_SET
                                    AND    	  D.TIPO_OPERACION IN ('ENFIRME','RECHAZADO')
                                    GROUP BY  E_CODIGO, REFERENCIA_CLIENTE, IMPORTE, MONEDA
								) B,
	     XXCHK_CAPTURA_CHEQUES C
  WHERE  A.E_CODIGO=B.E_CODIGO
  AND	 A.REFERENCIA_CLIENTE=B.REFERENCIA_CLIENTE
  AND    A.IMPORTE=B.IMPORTE
  AND	 A.MONEDA=B.MONEDA
  AND    A.E_CODIGO=C.E_CODIGO
  AND	 A.REFERENCIA_CLIENTE=C.REFERENCIA_CLIENTE
  AND    A.IMPORTE=C.IMPORTE
  AND	 A.MONEDA=C.MONEDA
  AND    A.PROCESADO IS NULL
  AND    C.PROCESADO=200
  AND 	 C.ID_ESTADO_CHEQUE IN ( SELECT DISTINCT ID_ESTADO_CHEQUE   ---SOLO SE PUEDEN CAMBIAR DE ESTADO LOS REG. EN DICHOS ESTADOS
  		 					     FROM XXCHK_CAT_CAMBIOS_ESTADO
								 WHERE ID_ESTADO_B IN (8,9))
  GROUP BY C.E_CODIGO, C.REFERENCIA_CLIENTE, C.IMPORTE, C.MONEDA;
  CURSOR ACT_REG_FIRME IS
  SELECT DISTINCT C.E_CODIGO, C.REFERENCIA_CLIENTE, C.IMPORTE, C.MONEDA
  FROM 	 XXCHK_CHEQUES_ALL C
  WHERE  PROCESADO=100;
  -----------
  BEGIN
	---------------------------------------------PROCESO QUE LLEVARA A CABO LA ACTUALIZACION DE CHEQUES REPETIDOS-------------------
	----PROCESADO = 100 IDENTIFICA QUE ES UN REGISTRO REPETIDO Y QUE SE DEBE PROCESAR UNO POR UNO
	----PROCESADO = 200 IDENTIFICA QUE SE ACTUALIZO UN REGISTRO REPETIDO  A SBC
	-----ES NECESARIO REVISAR CUANTAS VECES TIENE QUE LLEVAR A CABO REGISTRO POR REGISTRO Y TIENE QUE SER EL MENOR REGISTRO DE AMBAS TABLAS
	SELECT MAX(COUNT(*))
	INTO   V_CUENTA_SBC_CAP_CHK
	FROM   XXCHK_CAPTURA_CHEQUES A, (
		   						 	 SELECT B.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA
									 FROM XXCHK_CHEQUES_ALL B
									 WHERE PROCESADO IS NULL
									 GROUP BY  B.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA
									 HAVING count(*) > 1) C
	WHERE  A.E_CODIGO=C.E_CODIGO
	AND	   A.REFERENCIA_CLIENTE=C.REFERENCIA_CLIENTE
	AND    A.IMPORTE=C.IMPORTE
	AND	   A.MONEDA=C.MONEDA
	AND    A.PROCESADO IS NULL
	GROUP BY  A.E_CODIGO, A.REFERENCIA_CLIENTE, A.IMPORTE, A.MONEDA;
	SELECT MAX(COUNT(*))
	INTO V_CUENTA_SBC_CHK_ALL
	FROM   XXCHK_CHEQUES_ALL A, (
	   						 	 SELECT B.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA, count(*)
								 FROM XXCHK_CAPTURA_CHEQUES  B
								 WHERE PROCESADO IS NULL
								 GROUP BY  B.E_CODIGO, B.REFERENCIA_CLIENTE, B.IMPORTE, B.MONEDA
								 HAVING count(*) > 1
								 ) C
	WHERE  A.E_CODIGO=C.E_CODIGO
	AND	   A.REFERENCIA_CLIENTE=C.REFERENCIA_CLIENTE
	AND    A.IMPORTE=C.IMPORTE
	AND	   A.MONEDA=C.MONEDA
	AND    A.PROCESADO IS NULL
	GROUP BY  A.E_CODIGO, A.REFERENCIA_CLIENTE, A.IMPORTE, A.MONEDA;
	IF V_CUENTA_SBC_CAP_CHK < V_CUENTA_SBC_CHK_ALL THEN
	    V_CUENTA_SBC:=V_CUENTA_SBC_CAP_CHK;
	ELSE
		V_CUENTA_SBC:=V_CUENTA_SBC_CHK_ALL;
	END IF;
	DBMS_OUTPUT.PUT_LINE ('V_CUENTA_SBC_CAP_CHK VALE LA 1RA VEZ: '||V_CUENTA_SBC_CAP_CHK); --ojo ooc
	DBMS_OUTPUT.PUT_LINE ('V_CUENTA_SBC_CHK_ALL VALE LA 1RA VEZ: '||V_CUENTA_SBC_CHK_ALL);  --ojo ooc
	WHILE (V_CUENTA_SBC <> 0)
	LOOP
			-----------------ACTUALIZA LOS REGISTROS UNICOS SELECCIONADOS PARA SER PROCESADOS----------------
			DBMS_OUTPUT.PUT_LINE ('en el loop de sbc: '||V_CUENTA_SBC); --OJO OOC
			OPEN REG_REPETIDOS_SBC;
		    LOOP
		    FETCH REG_REPETIDOS_SBC
		    INTO  V_E_CODIGO, V_REFERENCIA_CLIENTE, V_IMPORTE, V_MONEDA;
		    EXIT WHEN REG_REPETIDOS_SBC%NOTFOUND;
			    UPDATE XXCHK_CHEQUES_ALL A
			    SET 	 PROCESADO=100
			    WHERE    E_CODIGO=V_E_CODIGO
			    AND 	 REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
			    AND 	 IMPORTE=V_IMPORTE
			    AND 	 MONEDA=V_MONEDA
			    AND 	 ROWNUM<2
			    AND 	 PROCESADO IS NULL
				AND 	 ID_TIPO_OPERACION_SET IN (SELECT ID_TIPO_OPERACION_SET
						 					   	   FROM   XXCHK_MAPEO_DE_ESTADOS
												   WHERE  ID_ESTADO_CHEQUE=7);
				DBMS_OUTPUT.PUT_LINE ('PASO EL PRIMER UPDATE'); --OJO OOC
			    UPDATE XXCHK_CAPTURA_CHEQUES B
			    SET	   PROCESADO=100
			    WHERE  E_CODIGO=V_E_CODIGO
			    AND    REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
			    AND    IMPORTE=V_IMPORTE
			    AND    MONEDA=V_MONEDA
			    AND    ROWNUM<2
			    AND    PROCESADO IS NULL
				AND    B.ID_ESTADO_CHEQUE IN (SELECT DISTINCT ID_ESTADO_CHEQUE    ---SOLO SE PUEDEN CAMBIAR DE ESTADO LOS REG. EN DICHOS ESTADOS
			  		 					  	  FROM XXCHK_CAT_CAMBIOS_ESTADO
								 		  	  WHERE ID_ESTADO_B =7);  		      ----OJO AQUI ESTA EL ERROR;
				DBMS_OUTPUT.PUT_LINE ('PASO EL SEGUNDO UPDATE'); --OJO OOC
		    END LOOP;
			CLOSE REG_REPETIDOS_SBC;
		    --------------INSERTA LOS REGISTROS MODIFICADOS EN LA BITACORA------------------------------
			INSERT INTO XXCHK_CHEQ_ALL_HIST
			                  (
				                   E_CODIGO,
				                   NO_CHEQUE,
				                   ID_SEC_CHEQUE,
				                   MODIFIED_BY,
				                   TIPO_CHEQ,
				                   REFERENCIA_CLIENTE,
				                   ID_TIPO_OPERACION_SET,
								   PROCESADO,
		                           ID_ESTADO_CHEQUE
				              )
			SELECT   	DISTINCT x1.E_CODIGO, x1.NO_CHEQUE, x1.ID_SEC_CHEQUE, 'Automatico', 'Automatico',
						x1.REFERENCIA_CLIENTE, a.ID_TIPO_OPERACION_SET, NULL, d.ID_ESTADO_CHEQUE
			FROM 	    XXCHK_CHEQUES_ALL a,
				     	XXCHK_MAPEO_DE_ESTADOS c,
				     	XXCHK_CAT_EDOS d,
						XXCHK_CAPTURA_CHEQUES x1
			WHERE 		a.e_codigo = x1.e_codigo
			AND 		a.importe = x1.importe
			AND 		a.referencia_cliente = x1.referencia_cliente
			AND 		a.moneda = x1.moneda
			AND 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
			AND 		c.id_estado_cheque = d.id_estado_cheque
			AND 		d.tipo_operacion IN ('SBC')
			AND 		a.procesado=100
			AND 		x1.procesado=100;
			------------ACTUALIZA EL ESTADO DEL CHEQUE Y EL PROCESADO A 200 QUE ES EL FINAL PARA SBC Y NO SERA SELECCIONADO EN UN FUTURO
			UPDATE  XXCHK_CAPTURA_CHEQUES b
			SET  	b.ID_ESTADO_CHEQUE =    (   SELECT d.id_estado_cheque
								             FROM 	XXCHK_CHEQUES_ALL x1,
								                    XXCHK_MAPEO_DE_ESTADOS c,
								                   	XXCHK_CAT_EDOS d
								             WHERE EXISTS (
								                           SELECT   1
								                           FROM 	XXCHK_CHEQUES_ALL a,
								                                	XXCHK_MAPEO_DE_ESTADOS c,
								                                	XXCHK_CAT_EDOS d
								                           WHERE 	a.e_codigo = x1.e_codigo
								                           AND 		a.importe = x1.importe
								                           AND 		a.referencia_cliente = x1.referencia_cliente
								                           AND 		a.moneda = x1.moneda
								                           AND 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
								                           AND 		c.id_estado_cheque = d.id_estado_cheque
								                           AND 		d.tipo_operacion IN ('SBC')
								                           AND 		a.procesado=100
											 			   AND 		b.procesado=100
						 				 				  )
											 AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
											 AND c.id_estado_cheque = d.id_estado_cheque
											 AND d.tipo_operacion IN ('SBC')
											 AND x1.e_codigo = b.e_codigo
											 AND x1.importe = b.importe
											 AND x1.referencia_cliente = b.referencia_cliente
											 AND x1.moneda = b.moneda
											 AND x1.procesado = 100
											 AND b.procesado =  100
			  							),
			PROCESADO = 200
			WHERE EXISTS (
			         	  SELECT 1
			          	  FROM XXCHK_CHEQUES_ALL x1,
			              	   XXCHK_MAPEO_DE_ESTADOS c,
			              	   XXCHK_CAT_EDOS d
			          	  WHERE EXISTS (
					                   	 SELECT   1
					                     FROM 	  XXCHK_CHEQUES_ALL a,
					                          	  XXCHK_MAPEO_DE_ESTADOS c,
					                          	  XXCHK_CAT_EDOS d
					                     WHERE 	  a.e_codigo = x1.e_codigo
					                     AND 	  a.importe = x1.importe
					                     AND 	  a.referencia_cliente = x1.referencia_cliente
					                     AND 	  a.moneda = x1.moneda
					                     AND 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
					                     AND 	  c.id_estado_cheque = d.id_estado_cheque
					                     AND 	  d.tipo_operacion IN ('SBC')
					                     AND 	  a.procesado=100
										 AND 	  b.procesado=100
									   )
			AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
			AND c.id_estado_cheque = d.id_estado_cheque
			AND d.tipo_operacion IN ('SBC')
			AND x1.e_codigo = b.e_codigo
			AND x1.importe = b.importe
			AND x1.referencia_cliente = b.referencia_cliente
			AND x1.moneda = b.moneda
			AND x1.procesado=100
			AND b.procesado=100
			AND b.id_estado_cheque in  ( SELECT DISTINCT ID_ESTADO_CHEQUE   ---SOLO SE PUEDEN CAMBIAR DE ESTADO VALIDANDO LA REGLA DE CAMBIO DE ESTADOS
		  		 					     FROM XXCHK_CAT_CAMBIOS_ESTADO
										 WHERE ID_ESTADO_B IN (7)));
			------------- YA QUE SE ACTUALIZARON LOS ESTADOS CORRECTAMENTE SE PROCEDE A CAMBIAR EL ESTADO EN CHEQUES ALL PARA QUE NO SEAN TOMADOS EN CUENTA
			OPEN ACT_REG_REPETIDOS;
		    LOOP
		    FETCH ACT_REG_REPETIDOS
		    INTO  V_E_CODIGO, V_REFERENCIA_CLIENTE, V_IMPORTE, V_MONEDA;
		    EXIT WHEN ACT_REG_REPETIDOS%NOTFOUND;
			    UPDATE XXCHK_CHEQUES_ALL A
			    SET 	 PROCESADO=300
			    WHERE    E_CODIGO=V_E_CODIGO
			    AND 	 REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
			    AND 	 IMPORTE=V_IMPORTE
			    AND 	 MONEDA=V_MONEDA
				AND 	 PROCESADO=100
			    AND 	 ROWNUM<2;
		    END LOOP;
		    CLOSE ACT_REG_REPETIDOS;
			V_CUENTA_SBC:= V_CUENTA_SBC - 1;
	END LOOP;
------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------PARA LOS REGISTROS RECHAZADOS Y LIBERADOS----------------------------------------------------------
	---------------------------------------------PROCESO QUE LLEVARA A CABO LA ACTUALIZACION DE CHEQUES REPETIDOS-------------------
	----PROCESADO = 100 IDENTIFICA QUE ES UN REGISTRO REPETIDO Y QUE SE DEBE PROCESAR UNO POR UNO
	----PROCESADO = 200 IDENTIFICA QUE SE ACTUALIZO UN REGISTRO REPETIDO  A SBC
	-----------------ACTUALIZA LOS REGISTROS UNICOS SELECCIONADOS PARA SER PROCESADOS----------------
	DBMS_OUTPUT.PUT_LINE ('V_CUENTA_SBC_CAP_CHK VALE LA 2da VEZ: '||V_CUENTA_SBC_CAP_CHK);  ---ojo ooc
	DBMS_OUTPUT.PUT_LINE ('V_CUENTA_SBC_CHK_ALL VALE LA 2da VEZ: '||V_CUENTA_SBC_CHK_ALL);	---ojo ooc
	IF V_CUENTA_SBC_CAP_CHK < V_CUENTA_SBC_CHK_ALL THEN
	    V_CUENTA_SBC:=V_CUENTA_SBC_CAP_CHK;
	ELSE
		V_CUENTA_SBC:=V_CUENTA_SBC_CHK_ALL;
	END IF;
	WHILE (V_CUENTA_SBC <> 0)
	LOOP
		DBMS_OUTPUT.PUT_LINE ('en el loop DE FIRME valgo: '||V_CUENTA_SBC); --OJO OOC
		OPEN REG_FIRME;
		   LOOP
		   FETCH REG_FIRME
		   INTO  V_E_CODIGO, V_REFERENCIA_CLIENTE, V_IMPORTE, V_MONEDA;
		   EXIT WHEN REG_FIRME%NOTFOUND;
		    UPDATE   XXCHK_CHEQUES_ALL A
		    SET 	 PROCESADO=100
		    WHERE    E_CODIGO=V_E_CODIGO
		    AND 	 REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
		    AND 	 IMPORTE=V_IMPORTE
		    AND 	 MONEDA=V_MONEDA
		    AND 	 ROWNUM<2
		    AND 	 PROCESADO IS NULL
			AND 	 ID_TIPO_OPERACION_SET IN (
					 					   	    SELECT ID_TIPO_OPERACION_SET
											    FROM XXCHK_MAPEO_DE_ESTADOS
											    WHERE ID_ESTADO_CHEQUE IN (8,9)); ---SOLO PARA LOS REGISTROS EN NUILL
		    UPDATE XXCHK_CAPTURA_CHEQUES B
		    SET	   PROCESADO=100
		    WHERE  E_CODIGO=V_E_CODIGO
		    AND    REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
		    AND    IMPORTE=V_IMPORTE
		    AND    MONEDA=V_MONEDA
		    AND    ROWNUM<2
		    AND    PROCESADO IS NULL
			AND    B.ID_ESTADO_CHEQUE IN (SELECT DISTINCT ID_ESTADO_CHEQUE   ---SOLO SE PUEDEN CAMBIAR DE ESTADO LOS REG. EN DICHOS ESTADOS
			  		 					  FROM XXCHK_CAT_CAMBIOS_ESTADO
								 		  WHERE ID_ESTADO_B IN (8,9));  		 		 ----OJO AQUI ESTA EL ERROR
		   END LOOP;
		CLOSE REG_FIRME;
		   --------------INSERTA LOS REGISTROS MODIFICADOS EN LA BITACORA------------------------------
		INSERT INTO XXCHK_CHEQ_ALL_HIST
		                  (
			                   E_CODIGO,
			                   NO_CHEQUE,
			                   ID_SEC_CHEQUE,
			                   MODIFIED_BY,
			                   TIPO_CHEQ,
			                   REFERENCIA_CLIENTE,
			                   ID_TIPO_OPERACION_SET,
							   PROCESADO,
		                       ID_ESTADO_CHEQUE
			              )
		SELECT   	DISTINCT x1.E_CODIGO, x1.NO_CHEQUE, x1.ID_SEC_CHEQUE, 'Automatico', 'Automatico',
					x1.REFERENCIA_CLIENTE, a.ID_TIPO_OPERACION_SET, NULL, d.ID_ESTADO_CHEQUE
		FROM 	    XXCHK_CHEQUES_ALL a,
			     	XXCHK_MAPEO_DE_ESTADOS c,
			     	XXCHK_CAT_EDOS d,
					XXCHK_CAPTURA_CHEQUES x1
		WHERE 		a.e_codigo = x1.e_codigo
		AND 		a.importe = x1.importe
		AND 		a.referencia_cliente = x1.referencia_cliente
		AND 		a.moneda = x1.moneda
		AND 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
		AND 		c.id_estado_cheque = d.id_estado_cheque
		AND 		d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
		AND 		a.procesado=100
		AND 		x1.procesado=100;
		------------ACTUALIZA EL ESTADO DEL CHEQUE Y EL PROCESADO A 200 QUE ES EL FINAL PARA SBC Y NO SERA SELECCIONADO EN UN FUTURO
		UPDATE  XXCHK_CAPTURA_CHEQUES b
		SET  b.ID_ESTADO_CHEQUE =    (   SELECT d.id_estado_cheque
							             FROM 	XXCHK_CHEQUES_ALL x1,
							                    XXCHK_MAPEO_DE_ESTADOS c,
							                   	XXCHK_CAT_EDOS d
							             WHERE EXISTS (
							                           SELECT   1
							                           FROM 	XXCHK_CHEQUES_ALL a,
							                                	XXCHK_MAPEO_DE_ESTADOS c,
							                                	XXCHK_CAT_EDOS d
							                           WHERE 	a.e_codigo = x1.e_codigo
							                           AND 		a.importe = x1.importe
							                           AND 		a.referencia_cliente = x1.referencia_cliente
							                           AND 		a.moneda = x1.moneda
							                           AND 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
							                           AND 		c.id_estado_cheque = d.id_estado_cheque
							                           AND 		d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
							                           AND 		a.procesado=100
										 			   AND 		b.procesado=100
					 				 				  )
										 AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
										 AND c.id_estado_cheque = d.id_estado_cheque
										 AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
										 AND x1.e_codigo = b.e_codigo
										 AND x1.importe = b.importe
										 AND x1.referencia_cliente = b.referencia_cliente
										 AND x1.moneda = b.moneda
										 AND x1.procesado = 100
										 AND b.procesado =  100
		  							),
		PROCESADO = 300
		WHERE EXISTS (
		         	  SELECT 1
		          	  FROM XXCHK_CHEQUES_ALL x1,
		              	   XXCHK_MAPEO_DE_ESTADOS c,
		              	   XXCHK_CAT_EDOS d
		          	  WHERE EXISTS (
				                   	 SELECT   1
				                     FROM 	  XXCHK_CHEQUES_ALL a,
				                          	  XXCHK_MAPEO_DE_ESTADOS c,
				                          	  XXCHK_CAT_EDOS d
				                     WHERE 	  a.e_codigo = x1.e_codigo
				                     AND 	  a.importe = x1.importe
				                     AND 	  a.referencia_cliente = x1.referencia_cliente
				                     AND 	  a.moneda = x1.moneda
				                     AND 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
				                     AND 	  c.id_estado_cheque = d.id_estado_cheque
				                     AND 	  d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
				                     AND 	  a.procesado=100
									 AND 	  b.procesado=100
								   )
		AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
		AND c.id_estado_cheque = d.id_estado_cheque
		AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
		AND x1.e_codigo = b.e_codigo
		AND x1.importe = b.importe
		AND x1.referencia_cliente = b.referencia_cliente
		AND x1.moneda = b.moneda
		AND x1.procesado=100
		AND b.procesado=100
		AND b.id_estado_cheque in  ( SELECT DISTINCT ID_ESTADO_CHEQUE   ---SOLO SE PUEDEN CAMBIAR DE ESTADO VALIDANDO LA REGLA DE CAMBIO DE ESTADOS
		 		 					     FROM XXCHK_CAT_CAMBIOS_ESTADO
									 WHERE ID_ESTADO_B IN (8,9)));
		------------- YA QUE SE ACTUALIZARON LOS ESTADOS CORRECTAMENTE SE PROCEDE A CAMBIAR EL ESTADO EN CHEQUES ALL PARA QUE NO SEAN TOMADOS EN CUENTA
		OPEN ACT_REG_REPETIDOS;
		   LOOP
		   FETCH ACT_REG_REPETIDOS
		   INTO  V_E_CODIGO, V_REFERENCIA_CLIENTE, V_IMPORTE, V_MONEDA;
		   EXIT WHEN ACT_REG_REPETIDOS%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE ('si entro al cursor');
		    UPDATE XXCHK_CHEQUES_ALL A
		    SET 	 PROCESADO=300
		    WHERE    E_CODIGO=V_E_CODIGO
		    AND 	 REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
		    AND 	 IMPORTE=V_IMPORTE
		    AND 	 MONEDA=V_MONEDA
			AND 	 PROCESADO=100
		    AND 	 ROWNUM<2;
		   END LOOP;
		   CLOSE ACT_REG_REPETIDOS;
		   V_CUENTA_SBC:= V_CUENTA_SBC - 1;
	END LOOP;
--COMMIT;
--****-------------------------------------------------------------------------------------------------------------------------------------
	IF V_CUENTA_SBC_CAP_CHK < V_CUENTA_SBC_CHK_ALL THEN
	    V_CUENTA_SBC:=V_CUENTA_SBC_CAP_CHK;
	ELSE
		V_CUENTA_SBC:=V_CUENTA_SBC_CHK_ALL;
	END IF;
	WHILE (V_CUENTA_SBC <> 0)
	LOOP
		DBMS_OUTPUT.PUT_LINE ('en el loop DE FIRME valgo: '||V_CUENTA_SBC); --OJO OOC
		OPEN REG_REPETIDOS_FIRME;
		   LOOP
		   FETCH REG_REPETIDOS_FIRME
		   INTO  V_E_CODIGO, V_REFERENCIA_CLIENTE, V_IMPORTE, V_MONEDA;
		   EXIT WHEN REG_REPETIDOS_FIRME%NOTFOUND;
		    UPDATE   XXCHK_CHEQUES_ALL A
		    SET 	 PROCESADO=100
		    WHERE    E_CODIGO=V_E_CODIGO
		    AND 	 REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
		    AND 	 IMPORTE=V_IMPORTE
		    AND 	 MONEDA=V_MONEDA
		    AND 	 ROWNUM<2
			AND 	 PROCESADO IS NULL
			AND 	 ID_TIPO_OPERACION_SET IN (
					 					   	    SELECT ID_TIPO_OPERACION_SET
											    FROM XXCHK_MAPEO_DE_ESTADOS
											    WHERE ID_ESTADO_CHEQUE IN (8,9)); ---SOLO PARA LOS REGISTROS EN NUILL
		    UPDATE XXCHK_CAPTURA_CHEQUES B
		    SET	   PROCESADO=100
		    WHERE  E_CODIGO=V_E_CODIGO
		    AND    REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
		    AND    IMPORTE=V_IMPORTE
		    AND    MONEDA=V_MONEDA
		    AND    ROWNUM<2
		    AND    PROCESADO=200;
		   END LOOP;
		CLOSE REG_REPETIDOS_FIRME;
		   --------------INSERTA LOS REGISTROS MODIFICADOS EN LA BITACORA------------------------------
		INSERT INTO XXCHK_CHEQ_ALL_HIST
		                  (
			                   E_CODIGO,
			                   NO_CHEQUE,
			                   ID_SEC_CHEQUE,
			                   MODIFIED_BY,
			                   TIPO_CHEQ,
			                   REFERENCIA_CLIENTE,
			                   ID_TIPO_OPERACION_SET,
							   PROCESADO,
		                       ID_ESTADO_CHEQUE
			              )
		SELECT   	DISTINCT x1.E_CODIGO, x1.NO_CHEQUE, x1.ID_SEC_CHEQUE, 'Automatico', 'Automatico',
					x1.REFERENCIA_CLIENTE, a.ID_TIPO_OPERACION_SET, NULL, d.ID_ESTADO_CHEQUE
		FROM 	    XXCHK_CHEQUES_ALL a,
			     	XXCHK_MAPEO_DE_ESTADOS c,
			     	XXCHK_CAT_EDOS d,
					XXCHK_CAPTURA_CHEQUES x1
		WHERE 		a.e_codigo = x1.e_codigo
		AND 		a.importe = x1.importe
		AND 		a.referencia_cliente = x1.referencia_cliente
		AND 		a.moneda = x1.moneda
		AND 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
		AND 		c.id_estado_cheque = d.id_estado_cheque
		AND 		d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
		AND 		a.procesado=100
		AND 		x1.procesado=100;
		------------ACTUALIZA EL ESTADO DEL CHEQUE Y EL PROCESADO A 200 QUE ES EL FINAL PARA SBC Y NO SERA SELECCIONADO EN UN FUTURO
		UPDATE  XXCHK_CAPTURA_CHEQUES b
		SET  b.ID_ESTADO_CHEQUE =    (   SELECT d.id_estado_cheque
							             FROM 	XXCHK_CHEQUES_ALL x1,
							                    XXCHK_MAPEO_DE_ESTADOS c,
							                   	XXCHK_CAT_EDOS d
							             WHERE EXISTS (
							                           SELECT   1
							                           FROM 	XXCHK_CHEQUES_ALL a,
							                                	XXCHK_MAPEO_DE_ESTADOS c,
							                                	XXCHK_CAT_EDOS d
							                           WHERE 	a.e_codigo = x1.e_codigo
							                           AND 		a.importe = x1.importe
							                           AND 		a.referencia_cliente = x1.referencia_cliente
							                           AND 		a.moneda = x1.moneda
							                           AND 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
							                           AND 		c.id_estado_cheque = d.id_estado_cheque
							                           AND 		d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
							                           AND 		a.procesado=100
										 			   AND 		b.procesado=100
					 				 				  )
										 AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
										 AND c.id_estado_cheque = d.id_estado_cheque
										 AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
										 AND x1.e_codigo = b.e_codigo
										 AND x1.importe = b.importe
										 AND x1.referencia_cliente = b.referencia_cliente
										 AND x1.moneda = b.moneda
										 AND x1.procesado = 100
										 AND b.procesado =  100
		  							),
		PROCESADO = 300
		WHERE EXISTS (
		         	  SELECT 1
		          	  FROM XXCHK_CHEQUES_ALL x1,
		              	   XXCHK_MAPEO_DE_ESTADOS c,
		              	   XXCHK_CAT_EDOS d
		          	  WHERE EXISTS (
				                   	 SELECT   1
				                     FROM 	  XXCHK_CHEQUES_ALL a,
				                          	  XXCHK_MAPEO_DE_ESTADOS c,
				                          	  XXCHK_CAT_EDOS d
				                     WHERE 	  a.e_codigo = x1.e_codigo
				                     AND 	  a.importe = x1.importe
				                     AND 	  a.referencia_cliente = x1.referencia_cliente
				                     AND 	  a.moneda = x1.moneda
				                     AND 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
				                     AND 	  c.id_estado_cheque = d.id_estado_cheque
				                     AND 	  d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
				                     AND 	  a.procesado=100
									 AND 	  b.procesado=100
								   )
		AND x1.id_tipo_operacion_set = c.id_tipo_operacion_set
		AND c.id_estado_cheque = d.id_estado_cheque
		AND d.tipo_operacion IN ('ENFIRME', 'RECHAZADO')
		AND x1.e_codigo = b.e_codigo
		AND x1.importe = b.importe
		AND x1.referencia_cliente = b.referencia_cliente
		AND x1.moneda = b.moneda
		AND x1.procesado=100
		AND b.procesado=100
		AND b.id_estado_cheque in  ( SELECT DISTINCT ID_ESTADO_CHEQUE   ---SOLO SE PUEDEN CAMBIAR DE ESTADO VALIDANDO LA REGLA DE CAMBIO DE ESTADOS
		 		 					     FROM XXCHK_CAT_CAMBIOS_ESTADO
									 WHERE ID_ESTADO_B IN (8,9)));
		------------- YA QUE SE ACTUALIZARON LOS ESTADOS CORRECTAMENTE SE PROCEDE A CAMBIAR EL ESTADO EN CHEQUES ALL PARA QUE NO SEAN TOMADOS EN CUENTA
		OPEN ACT_REG_REPETIDOS;
		   LOOP
		   FETCH ACT_REG_REPETIDOS
		   INTO  V_E_CODIGO, V_REFERENCIA_CLIENTE, V_IMPORTE, V_MONEDA;
		   EXIT WHEN ACT_REG_REPETIDOS%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE ('si entro al cursor final ooc');
		    UPDATE XXCHK_CHEQUES_ALL A
		    SET 	 PROCESADO=300
		    WHERE    E_CODIGO=V_E_CODIGO
		    AND 	 REFERENCIA_CLIENTE=V_REFERENCIA_CLIENTE
		    AND 	 IMPORTE=V_IMPORTE
		    AND 	 MONEDA=V_MONEDA
			AND 	 PROCESADO=100
		    AND 	 ROWNUM<2;
		   END LOOP;
		   CLOSE ACT_REG_REPETIDOS;
		   V_CUENTA_SBC:= V_CUENTA_SBC - 1;
	END LOOP;
--****-------------------------------------------------------------------------------------------------------------------------------------
END XXCHK_ACT_ESTATUS_AUT;
END XXCHK_ACTUALIZA_ESTADOS_AUT;
/;
