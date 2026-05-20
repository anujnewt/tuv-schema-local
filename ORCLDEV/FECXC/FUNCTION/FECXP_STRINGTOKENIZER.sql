CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."FECXP_STRINGTOKENIZER" 
(
   PC$Chaine IN VARCHAR2,         -- input string
   PN$Pos IN PLS_INTEGER,         -- token number
   PC$Sep IN VARCHAR2 DEFAULT ',' -- separator character
)
RETURN VARCHAR2
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  LC$Chaine VARCHAR2(32767) := PC$Sep || PC$Chaine ;
  LI$I      PLS_INTEGER ;
  LI$I2     PLS_INTEGER ;
BEGIN
  LI$I := INSTR( LC$Chaine, PC$Sep, 1, PN$Pos ) ;
  IF LI$I > 0 THEN
    LI$I2 := INSTR( LC$Chaine, PC$Sep, 1, PN$Pos + 1) ;
    IF LI$I2 = 0 THEN LI$I2 := LENGTH( LC$Chaine ) + 1 ; END IF ;
    RETURN( SUBSTR( LC$Chaine, LI$I+1, LI$I2 - LI$I-1 ) ) ;
  ELSE
    RETURN NULL ;
  END IF ;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."FECXP_STRINGTOKENIZER" 
(
   PC$Chaine IN VARCHAR2,         -- input string
   PN$Pos IN PLS_INTEGER,         -- token number
   PC$Sep IN VARCHAR2 DEFAULT ',' -- separator character
)
RETURN VARCHAR2
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  LC$Chaine VARCHAR2(32767) := PC$Sep || PC$Chaine ;
  LI$I      PLS_INTEGER ;
  LI$I2     PLS_INTEGER ;
BEGIN
  LI$I := INSTR( LC$Chaine, PC$Sep, 1, PN$Pos ) ;
  IF LI$I > 0 THEN
    LI$I2 := INSTR( LC$Chaine, PC$Sep, 1, PN$Pos + 1) ;
    IF LI$I2 = 0 THEN LI$I2 := LENGTH( LC$Chaine ) + 1 ; END IF ;
    RETURN( SUBSTR( LC$Chaine, LI$I+1, LI$I2 - LI$I-1 ) ) ;
  ELSE
    RETURN NULL ;
  END IF ;
END;
/
