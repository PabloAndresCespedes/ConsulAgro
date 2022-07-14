CREATE OR REPLACE PACKAGE PERP007 IS

  -- AUTHOR  : PROGRAMACION13
  -- CREATED : 04/06/2020 9:01:58
  -- PURPOSE :

  PROCEDURE PP_MOSTRAR_PERIODO(P_EMPRESA      IN NUMBER,
                               P_PERIODO      IN NUMBER,
                               P_PERI_FEC_INI OUT DATE,
                               P_PERI_FEC_FIN OUT DATE);

  PROCEDURE PP_ACTUALIZAR_REGISTRO(P_EMPRESA      IN NUMBER,
                                   P_SUCURSAL     IN NUMBER,
                                   P_RUTA_ARCHIVO IN VARCHAR2,
                                   P_APP_SESSION  IN NUMBER,
                                   P_USUARIO      IN VARCHAR2,
                                   P_MENSAJE      OUT VARCHAR2);

  FUNCTION PP_VALIDAR_MARCACIONES(P_EMPRESA      IN NUMBER,
                                   P_SUCURSAL     IN NUMBER,
                                   P_RUTA_ARCHIVO IN BLOB,
                                   P_APP_SESSION  IN NUMBER,
                                   P_USUARIO      IN VARCHAR2)RETURN VARCHAR2;

  PROCEDURE PP_IMPORTAR_MARCACIONES(P_EMPRESA  IN NUMBER);

  PROCEDURE PP_IMPORT_TXT(P_EMPRESA   IN NUMBER,
                          P_BLOB_DATA IN BLOB,
                          P_APP_USER  IN VARCHAR2,
                          P_FORMATO   OUT VARCHAR2);
  FUNCTION PP_VALIDAR_MARCACIONES_CEDEC(P_EMPRESA     IN NUMBER,
                                         P_ARCHIVO     IN VARCHAR2,
                                         P_APP_SESSION IN NUMBER)RETURN VARCHAR2;
  PROCEDURE PP_IMPORTAR_MARCACIONES_CEDEC(P_EMPRESA IN NUMBER);
  PROCEDURE PP_IMPORT_ARCHIVO(P_EMPRESA IN NUMBER, P_ARCHIVO IN VARCHAR2); --PRUEBAAA
 PROCEDURE PP_PROCESAR_CAST (P_EMPRESA IN NUMBER,
                             P_FEC_INI IN DATE,
                             P_FEC_HAST IN DATE );

  /*
    Author  : @PabloACespedes \(^-^)/
    Created : 14/07/2022 14:17:11
    Nuevo proceso para exportar horas registradas por el reloj
    Reglas: 
     - Tener el nro de legajo del empleado
     - Fecha Hora de la marcacion
     - Tipo de Marcacion segun reglas del reloj: 
       * 0 entrada 
       * 1 salida
  */
  procedure import_hours(
    in_empresa  number,
    in_user     varchar2, --> Usuario APEX
    in_filename varchar2
  );
  
END PERP007;
/
CREATE OR REPLACE PACKAGE BODY PERP007 IS

  PROCEDURE PP_MOSTRAR_PERIODO(P_EMPRESA      IN NUMBER,
                               P_PERIODO      IN NUMBER,
                               P_PERI_FEC_INI OUT DATE,
                               P_PERI_FEC_FIN OUT DATE) IS

    V_PERIODO_ACT  NUMBER;
    V_PERIODO_SGTE NUMBER;
  BEGIN
    SELECT CONF_PERI_ACT, CONF_PERI_SGTE
      INTO V_PERIODO_ACT, V_PERIODO_SGTE
      FROM PER_CONFIGURACION C
     WHERE CONF_EMPR = P_EMPRESA;
    IF P_PERIODO NOT IN (V_PERIODO_ACT, V_PERIODO_SGTE) THEN
      P_PERI_FEC_INI := NULL;
      P_PERI_FEC_FIN := NULL;

      RAISE_APPLICATION_ERROR(-20001,
                              'Solo puede escoger los periodos ' ||
                              V_PERIODO_ACT || ' y ' || V_PERIODO_SGTE ||
                              ', que son los periodos actual y siguiente del modulo de Recursos Humanos!');
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Verifique si la configuracion del modulo de Recursos Humanos ha sido cargada!');
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Demasiadas Filas en Per_Configuracion! - Avise al departamento de Informatica');

  END;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(P_EMPRESA      IN NUMBER,
                                   P_SUCURSAL     IN NUMBER,
                                   P_RUTA_ARCHIVO IN VARCHAR2,
                                   P_APP_SESSION  IN NUMBER,
                                   P_USUARIO      IN VARCHAR2,
                                   P_MENSAJE      OUT VARCHAR2) IS
    SALIR            EXCEPTION;
    NON_ORACLE_ERROR EXCEPTION;
    PRAGMA EXCEPTION_INIT(NON_ORACLE_ERROR, -100501);
    V_ARCHIVO_IMPORTAR BLOB; --ARCHIVO A IMPORTAR
    
  BEGIN
    ---
  P_MENSAJE:=NULL;
 ------ 
  
  
    BEGIN
      SELECT BLOB_CONTENT
        INTO V_ARCHIVO_IMPORTAR
        FROM APEX_APPLICATION_TEMP_FILES A
       WHERE A.NAME = P_RUTA_ARCHIVO
         AND ROWNUM = 1;
    EXCEPTION
      WHEN OTHERS THEN
        V_ARCHIVO_IMPORTAR := NULL;
    END;

    --IMPORTAR MARCACIONES
    IF P_EMPRESA = 3 THEN
      P_MENSAJE := PP_VALIDAR_MARCACIONES_CEDEC(P_EMPRESA,
                                                P_RUTA_ARCHIVO,
                                                P_APP_SESSION);
      PP_IMPORTAR_MARCACIONES_CEDEC(P_EMPRESA);
      P_MENSAJE := P_MENSAJE || '
       ' || '      Actualizacion Exitosamente!!!';
    ELSE

      P_MENSAJE := PP_VALIDAR_MARCACIONES(P_EMPRESA      => P_EMPRESA,
                                          P_SUCURSAL     => P_SUCURSAL,
                                          P_RUTA_ARCHIVO => V_ARCHIVO_IMPORTAR,
                                          P_APP_SESSION  => P_APP_SESSION,
                                          P_USUARIO      => P_USUARIO);
      IF P_MENSAJE IS NULL THEN
        PP_IMPORTAR_MARCACIONES(P_EMPRESA);
        P_MENSAJE := 'Datos Actualizados Exitosamente!!!';
      END IF;
    END IF;

  EXCEPTION
    WHEN SALIR THEN
      NULL;
    WHEN NON_ORACLE_ERROR THEN
      NULL;
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END PP_ACTUALIZAR_REGISTRO;

  FUNCTION PP_VALIDAR_MARCACIONES(P_EMPRESA      IN NUMBER,
                                  P_SUCURSAL     IN NUMBER,
                                  P_RUTA_ARCHIVO IN BLOB,
                                  P_APP_SESSION  IN NUMBER,
                                  P_USUARIO      IN VARCHAR2) RETURN VARCHAR2 IS
    VMARC VARCHAR2(32721);
    TABLALLAVEADA EXCEPTION;
    PRAGMA EXCEPTION_INIT(TABLALLAVEADA, -54);

    VMARCEMPL   VARCHAR2(100);
    VMARCNOM    VARCHAR2(300);
    VMARCFECHA  VARCHAR2(100);
    VMARCHORA   VARCHAR2(100);
    VMARCEVENTO VARCHAR2(1);
    V_RELOJ     VARCHAR2(100);

    V_BANDERA   NUMBER := 0;
    V_CANT      NUMBER := 0;
    V_EMPL_EMPR NUMBER := P_EMPRESA; --MIENTRAS SE MODIFICA LAS EMPRESAS
    V_FORMATO   VARCHAR2(2);

  BEGIN

    PP_IMPORT_TXT(P_EMPRESA, P_RUTA_ARCHIVO, GEN_DEVUELVE_USER, V_FORMATO);
    DELETE FROM PER_PERP007_TEMP;
    DELETE FROM PERP007_TEMP WHERE USUARIO = P_USUARIO;
    COMMIT;

    FOR I IN (SELECT IMPORT_TXT VMARC
                FROM PERP007_IMP_TXT
               WHERE USUARIO = P_USUARIO
                 AND EMPR = P_EMPRESA) LOOP

      IF V_FORMATO = 'A' THEN
        IF P_EMPRESA = 1 AND GEN_DEVUELVE_USER() IN ('MAREK') THEN
          --CUANDO SE HIZO LA IMPLEMENTACI?N EN CDA, ESTABA EN INGL?S EL MARCADOR DEL SEKUR Y PARA NO DESHACER TODO, SE HIZO UNA EXCEPCI?N.05/11/2020
          --  RAISE_APPLICATION_ERROR(-20001,'adsfasdf');

          VMARCEMPL  := SUBSTR(I.VMARC, 57, 6); --FORMATO HILAGRO
          VMARCNOM   := UPPER(SUBSTR(I.VMARC, 32, 25));
          VMARCFECHA := SUBSTR(I.VMARC, 78, 11);
          VMARCHORA  := SUBSTR(I.VMARC, 78, 18);

          IF SUBSTR(I.VMARC, 111, 1) LIKE '1' THEN
            VMARCEVENTO := SUBSTR(I.VMARC, 99, 1);
             IF VMARCEVENTO='/' THEN
                VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);
              END IF;
          ELSIF SUBSTR(I.VMARC, 111, 1) LIKE '3' THEN
            VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);
            IF (VMARCEVENTO = 'I' OR VMARCEVENTO = 'E') THEN
              --- OR  VMARCEVENTO = '/') THEN
              --INPUT (ENTRADA)
              VMARCEVENTO := 'E';
            ELSIF VMARCEVENTO = 'O' OR VMARCEVENTO = 'S' OR
                  VMARCEVENTO = 'l' THEN
              --OUTPUT (SALIDA)
              VMARCEVENTO := 'S';
            END IF;
          ELSE
            VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);
            IF VMARCEVENTO = 'I' OR VMARCEVENTO = 'E' THEN
              --- OR VMARCEVENTO = '/' THEN
              --INPUT (ENTRADA)
              VMARCEVENTO := 'E';
            ELSIF VMARCEVENTO = 'O' OR VMARCEVENTO = 'S' OR
                  VMARCEVENTO = 'l' THEN
              --OUTPUT (SALIDA)
              VMARCEVENTO := 'S';
            ELSE
              VMARCEVENTO := SUBSTR(I.VMARC, 84, 1);

            END IF;
          END IF;

          V_CANT := V_CANT + 1;
          
          
           ELSIF GEN_DEVUELVE_USER() IN ('LIZAG','ADCS') THEN
          --CUANDO SE HIZO LA IMPLEMENTACI?N EN CDA, ESTABA EN INGL?S EL MARCADOR DEL SEKUR Y PARA NO DESHACER TODO, SE HIZO UNA EXCEPCI?N.05/11/2020
          --  RAISE_APPLICATION_ERROR(-20001,'adsfasdf');

          VMARCEMPL  := SUBSTR(I.VMARC, 31, 7); --FORMATO HILAGRO
          VMARCNOM   := UPPER(SUBSTR(I.VMARC, 46, 20));
          VMARCFECHA := SUBSTR(I.VMARC, 67, 11);
          VMARCHORA  := SUBSTR(I.VMARC, 67, 18);

         /* IF SUBSTR(I.VMARC, 100, 1) LIKE '1' THEN
            VMARCEVENTO := SUBSTR(I.VMARC, 89, 1);
             IF VMARCEVENTO='/' THEN
                VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);
              END IF;
          ELSIF SUBSTR(I.VMARC, 89, 1) LIKE '3' THEN
            VMARCEVENTO := SUBSTR(I.VMARC, 89, 1);
            IF (VMARCEVENTO = 'I' OR VMARCEVENTO = 'E') THEN
              --- OR  VMARCEVENTO = '/') THEN
              --INPUT (ENTRADA)
              VMARCEVENTO := 'E';
            ELSIF VMARCEVENTO = 'O' OR VMARCEVENTO = 'S' OR
                  VMARCEVENTO = 'l' THEN
              --OUTPUT (SALIDA)
              VMARCEVENTO := 'S';
            END IF;
          ELSE*/
            VMARCEVENTO := SUBSTR(I.VMARC, 90, 1);
           -- RAISE_APPLICATION_ERROR(-20001,VMARCEVENTO);
            IF VMARCEVENTO = 'I' OR VMARCEVENTO = 'E' THEN
              --- OR VMARCEVENTO = '/' THEN
              --INPUT (ENTRADA)
              VMARCEVENTO := 'E';
            ELSIF VMARCEVENTO = 'O' OR VMARCEVENTO = 'S' OR
                  VMARCEVENTO = 'l' THEN
              --OUTPUT (SALIDA)
              VMARCEVENTO := 'S';
            ELSE
              VMARCEVENTO := SUBSTR(I.VMARC, 84, 1);

            END IF;
         -- END IF;

          V_CANT := V_CANT + 1;

        ELSIF P_EMPRESA <> 2 THEN

          IF P_EMPRESA = 3 THEN
            VMARCEMPL := SUBSTR(I.VMARC, 57, 7); --FORMATO CEDEC
          ELSE
            VMARCEMPL := SUBSTR(I.VMARC, 57, 6); --FORMATO HILAGRO
          END IF;

          VMARCNOM   := UPPER(SUBSTR(I.VMARC, 32, 25));
          VMARCFECHA := SUBSTR(I.VMARC, 78, 10);
          VMARCHORA  := SUBSTR(I.VMARC, 78, 16);

          IF SUBSTR(I.VMARC, 111, 1) LIKE '1' THEN
            VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);
          ELSIF SUBSTR(VMARC, 111, 1) LIKE '3' THEN
            VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);
          ELSE
            IF SUBSTR(VMARC, 111, 1) LIKE '2' THEN
              --SI ES MOLINO 2
              IF SUBSTR(VMARC, 98, 1) LIKE 'M' THEN
                VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);
              ELSE
                VMARCEVENTO := SUBSTR(I.VMARC, 99, 1);
              END IF;
            ELSE
              VMARCEVENTO := SUBSTR(I.VMARC, 84, 1);

            END IF;
          END IF;

          IF VMARCEVENTO = 'l' THEN
            VMARCEVENTO := 'S';
          END IF;

          V_CANT := V_CANT + 1;
        END IF;
      ELSIF V_FORMATO = 'B' THEN
        IF P_EMPRESA <> 2 THEN

          VMARCEMPL   := SUBSTR(I.VMARC, 1, 6);
          VMARCNOM    := UPPER(SUBSTR(I.VMARC, 1, 7));
          VMARCFECHA  := SUBSTR(I.VMARC, 30, 11);
          VMARCHORA   := SUBSTR(I.VMARC, 30, 20);
          VMARCEVENTO := SUBSTR(I.VMARC, 51, 1);
          V_RELOJ     := SUBSTR(I.VMARC, 58, 14);

          V_CANT := V_CANT + 1;

        END IF;
      END IF;

      IF P_EMPRESA = 2 THEN
        VMARCEMPL   := SUBSTR(I.VMARC, 57, 6);
        VMARCNOM    := UPPER(SUBSTR(I.VMARC, 32, 23));
        VMARCFECHA  := SUBSTR(I.VMARC, 78, 10);
        VMARCHORA   := SUBSTR(I.VMARC, 78, 20);
        VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);

        V_CANT := V_CANT + 1;

      END IF;

      INSERT INTO PER_PERP007_TEMP
        (CODIGO, NOMBRE, FECHA, HORA, EVENTO, MAR_RELOJ_ORIG, EMPR)
      VALUES
        (VMARCEMPL,
         VMARCNOM,
         TO_DATE(VMARCFECHA, 'dd/mm/yyyy'),
         TO_DATE(VMARCHORA, 'dd/mm/yyyy HH24:MI:SS'),
         VMARCEVENTO,
         V_RELOJ,
         V_EMPL_EMPR);
    END LOOP;

    COMMIT;

    FOR V IN (SELECT DISTINCT CODIGO, NOMBRE
                FROM PER_PERP007_TEMP
               WHERE CODIGO IN (SELECT DISTINCT CODIGO
                                  FROM PER_PERP007_TEMP
                                 WHERE EMPR = P_EMPRESA
                                MINUS
                                SELECT R.CODR_COD_RELOJ
                                  FROM PER_CODIGOS_RELOJ R, PER_EMPLEADO PE
                                 WHERE R.CODR_LEGAJO = PE.EMPL_LEGAJO
                                   AND R.CODR_EMPR = PE.EMPL_EMPRESA
                                   --AND PE.EMPL_SITUACION = 'A' --PARA QUE SOLO FILTRE LOS ACTIVOS. PEDIDO DE JULIO, 18/12/2019
                                   AND CODR_EMPR = P_EMPRESA)
               ORDER BY 1) LOOP
      V_BANDERA := 1;
      INSERT INTO PERP007_TEMP
        (CODIGO, NOMBRE, APP_SESSION, USUARIO)
      VALUES
        (V.CODIGO, V.NOMBRE, P_APP_SESSION, P_USUARIO);
    END LOOP;
    COMMIT;

    IF V_BANDERA = 1 THEN

        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Existen marcaciones que no tienen asignado empleado.Has click en refrescar ',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
       RETURN 1;
    ELSE
      RETURN NULL;

    END IF;

    IF V_CANT = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Archivo vacio');
    END IF;
  EXCEPTION
    WHEN TABLALLAVEADA THEN
      RAISE_APPLICATION_ERROR(-20001, 'Tabla bloqueada por otro usuario!');

  END PP_VALIDAR_MARCACIONES;

  PROCEDURE PP_IMPORTAR_MARCACIONES(P_EMPRESA IN NUMBER) IS

    TABLALLAVEADA EXCEPTION;
    PRAGMA EXCEPTION_INIT(TABLALLAVEADA, -54);

    VMARCEMPLAUX PER_EMPLEADO.EMPL_LEGAJO%TYPE;

  BEGIN
  --RAISE_APPLICATION_ERROR(-20001, 'Tabla bloqueada por otro usuario!');
    --VRESULTADO := 'ERROR'; --POR SI SALGA ABRUPTAMENTE

    FOR V IN (SELECT CODIGO         VMARCEMPL,
                     NOMBRE,
                     FECHA          VMARCFECHA,
                     HORA           VMARCHORA,
                     EVENTO         VMARCEVENTO,
                     MAR_RELOJ_ORIG V_RELOJ,
                     EMPR           EMPRESA
                FROM PER_PERP007_TEMP
               WHERE EMPR = P_EMPRESA
               ORDER BY ROWID) LOOP

      BEGIN
        SELECT CODR_LEGAJO
          INTO VMARCEMPLAUX
          FROM PER_CODIGOS_RELOJ
         WHERE CODR_COD_RELOJ = TO_NUMBER(V.VMARCEMPL)
           AND CODR_EMPR = P_EMPRESA;
 /*RAISE_APPLICATION_ERROR(-20001,
                                  'El codigo de reloj ' || V.NOMBRE ||
                                  ' - ' ||VMARCEMPLAUX||
                                  ' , no tiene codigo de empleado. Verifique en el Mantenimiento de Empleados.');
 */       INSERT INTO PER_MARCACION_DIARIA
          (MARC_FECHA,
           MARC_EMPLEADO,
           MARC_EVENTO,
           MARC_HORA,
           MARC_LOGIN,
           MARC_FECHA_GRAB,
           MARC_FORM,
           MARC_ORIGEN,
           MARC_ESTADO,
           MAR_RELOJ_ORIG,
           MARC_EMPR)
        VALUES
          (V.VMARCFECHA,
            VMARCEMPLAUX,
           V.VMARCEVENTO,
           V.VMARCHORA,
           GEN_DEVUELVE_USER,
           SYSDATE,
           'PERP007',
           'R',
           'N',
           V.V_RELOJ,
           V.EMPRESA);

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20001,
                                  'El codigo de reloj ' || V.NOMBRE ||
                                  ' - ' || TO_NUMBER(V.VMARCEMPL) ||
                                  ' , no tiene codigo de empleado. Verifique en el Mantenimiento de Empleados.');
        WHEN DUP_VAL_ON_INDEX THEN
          NULL;
      END;

    END LOOP;
    COMMIT;

  END PP_IMPORTAR_MARCACIONES;

  PROCEDURE PP_IMPORT_TXT(P_EMPRESA   IN NUMBER,
                          P_BLOB_DATA IN BLOB,
                          P_APP_USER  IN VARCHAR2,
                          P_FORMATO   OUT VARCHAR2) AS

    V_BLOB_LEN  NUMBER;
    V_POSISION  NUMBER;
    V_RAW_CHUNK RAW(10000);
    V_CHAR      CHAR(1);
    V_LINEA     VARCHAR2(32767);
    C_CHUNK_LEN NUMBER := 1;
    FV          WWV_FLOW_GLOBAL.VC_ARR2;
    V_SR_NO     NUMBER := 1;

  BEGIN

    DELETE FROM PERP007_IMP_TXT WHERE USUARIO = GEN_DEVUELVE_USER;
    COMMIT;
    V_BLOB_LEN := DBMS_LOB.GETLENGTH(P_BLOB_DATA);
    V_POSISION := 1;

    WHILE (V_POSISION <= V_BLOB_LEN) LOOP
      V_RAW_CHUNK := DBMS_LOB.SUBSTR(P_BLOB_DATA, C_CHUNK_LEN, V_POSISION);
      V_CHAR      := CHR(TO_NUMBER(RAWTOHEX(V_RAW_CHUNK), 'XXXXXX'));
      V_LINEA     := V_LINEA || V_CHAR;
      V_POSISION  := V_POSISION + C_CHUNK_LEN;

      IF V_CHAR = CHR(10) THEN

        V_LINEA := REPLACE(V_LINEA, ';', ':');
        FV      := WWV_FLOW_UTILITIES.STRING_TO_TABLE(V_LINEA);

        IF V_SR_NO = 1 AND FV(1) LIKE ('%Nombre%') THEN
          P_FORMATO := 'B';
        ELSIF V_SR_NO = 1 AND FV(1) NOT LIKE ('%Nombre%') THEN
          P_FORMATO := 'A';
        END IF;

        -- RAISE_APPLICATION_ERROR(-20001,P_FORMATO);

        IF P_FORMATO = 'B' THEN
          IF FV(1) NOT LIKE ('%Nombre%') THEN
            INSERT INTO PERP007_IMP_TXT
            VALUES
              (FV(1) || ':' || FV(2) || ':' || FV(3),
               P_APP_USER,
               P_EMPRESA);
          END IF;
        ELSIF P_FORMATO = 'A' THEN

          INSERT INTO PERP007_IMP_TXT
          VALUES
            (FV(1) || ':' || FV(2), P_APP_USER, P_EMPRESA);
        END IF;

        V_LINEA := NULL;
        V_SR_NO := V_SR_NO + 1;
      END IF;
    END LOOP;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      GENERAL.PL_EXHIBIR_ERROR_PLSQL;

  END PP_IMPORT_TXT;
  FUNCTION PP_VALIDAR_MARCACIONES_CEDEC(P_EMPRESA     IN NUMBER,
                                        P_ARCHIVO     IN VARCHAR2,
                                        P_APP_SESSION IN NUMBER)
    RETURN VARCHAR2 IS

    VMARC       VARCHAR2(500);
    VMARCEMPL   NUMBER;
    VMARCNOM    VARCHAR2(100);
    VMARCFECHA  VARCHAR2(50);
    VMARCHORA   VARCHAR2(50);
    VMARCEVENTO VARCHAR2(1);

    V_BANDERA NUMBER := 0;
    V_CANT    NUMBER := 0;

  BEGIN

    DELETE FROM PER_PERP007_TEMP;
    DELETE FROM PERP007_TEMP WHERE USUARIO = GEN_DEVUELVE_USER;
    COMMIT;
    PERP007.PP_IMPORT_ARCHIVO(P_EMPRESA, P_ARCHIVO);

    FOR I IN (SELECT IMPORT_TXT VMARC
                FROM PERP007_IMP_TXT
               WHERE USUARIO = GEN_DEVUELVE_USER
                 AND EMPR = P_EMPRESA) LOOP

    /*  VMARCEMPL := SUBSTR(I.VMARC, 57, 8); --CAMBIANDO LA EXTENSION PORQUE NO USA EL CODIGO DEL EMPLEADO, SINO EL CI
      --VMARCNOM     := UPPER(SUBSTR(VMARC,32,25)); LINEA ORIGINAL. FORMATO HILAGRO
      VMARCNOM    := UPPER(SUBSTR(I.VMARC, 32, 25)); --CAMBIANDO LA EXTENSION PORQUE NO USA EL CODIGO DEL EMPLEADO, SINO EL CI. FORMATO CEDEC
      VMARCFECHA  := SUBSTR(I.VMARC, 78, 10);
      VMARCHORA   := SUBSTR(I.VMARC, 78, 16);
      VMARCEVENTO := SUBSTR(I.VMARC, 100, 1);

      --MVERA... SE AGREGO ESTA CONDINCION POR QUE ALGUNOS VECES MARCAN MAL  LA OPCION DE ENTRADA Y SALIDA EN SEKUR...
      IF VMARCEVENTO NOT IN ('E', 'S') THEN
        VMARCEVENTO := SUBSTR(I.VMARC, 98, 1);
      END IF;
*/

    VMARCEMPL := SUBSTR(I.VMARC, 50, 8); --CAMBIANDO LA EXTENSION PORQUE NO USA EL CODIGO DEL EMPLEADO, SINO EL CI
      --VMARCNOM     := UPPER(SUBSTR(VMARC,32,25)); LINEA ORIGINAL. FORMATO HILAGRO
      VMARCNOM    := UPPER(SUBSTR(I.VMARC, 32, 8)); --CAMBIANDO LA EXTENSION PORQUE NO USA EL CODIGO DEL EMPLEADO, SINO EL CI. FORMATO CEDEC
      VMARCFECHA  := SUBSTR(I.VMARC, 71, 10);
      VMARCHORA   := SUBSTR(I.VMARC, 71, 16);
      VMARCEVENTO := SUBSTR(I.VMARC, 93, 1);

      --MVERA... SE AGREGO ESTA CONDINCION POR QUE ALGUNOS VECES MARCAN MAL  LA OPCION DE ENTRADA Y SALIDA EN SEKUR...
      IF VMARCEVENTO NOT IN ('E', 'S') THEN
        VMARCEVENTO := SUBSTR(I.VMARC, 91, 1);
      END IF;
      
      V_CANT := V_CANT + 1;

      BEGIN
        INSERT INTO PER_PERP007_TEMP
        VALUES
          (VMARCEMPL,
           VMARCNOM,
           TO_DATE(VMARCFECHA, 'dd/mm/yyyy'),
           TO_DATE(VMARCHORA, 'dd/mm/yyyy hh24:mi'),
           VMARCEVENTO,
           P_EMPRESA,
           NULL);

      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001, SQLERRM);
      END;

    END LOOP;

    FOR V IN (SELECT DISTINCT CODIGO, NOMBRE
                FROM PER_PERP007_TEMP
               WHERE CODIGO IN (SELECT DISTINCT CODIGO
                                  FROM PER_PERP007_TEMP
                                 WHERE EMPR = P_EMPRESA
                                MINUS
                                SELECT R.CODR_LEGAJO
                                  FROM PER_CODIGOS_RELOJ_CEDEC R
                                 WHERE CODR_EMPR = P_EMPRESA) --HACE EL SELECT, DE OTRA TABLA, DISTINTA A LA QUE TIENE LA ESTRUCTURA DE HILAGRO PORQUE REALIZARON EL REGISTRO DE LOS PERSONALES
              --EN EL RELOJ, CON EL NUMERO DE CI Y NO CON EL CODIGO DEL EMPLEADO Y PARA EVITAR CAMBIAR TODOS LOS REGISTROS DEL RELOJ, SE CREA UNA NUEVA ESTRUCTURA EN LA BD
               ORDER BY 1) LOOP
      V_BANDERA := 1;
      INSERT INTO PERP007_TEMP
        (CODIGO, NOMBRE, APP_SESSION, USUARIO)
      VALUES
        (V.CODIGO, V.NOMBRE, P_APP_SESSION, GEN_DEVUELVE_USER);

    END LOOP;
    COMMIT;

    IF V_BANDERA = 1 THEN
      RETURN('Existen marcaciones que no tienen asignado empleado.');
    ELSE
      RETURN NULL;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END;
  PROCEDURE PP_IMPORTAR_MARCACIONES_CEDEC(P_EMPRESA IN NUMBER) IS

    VMARCEMPL    NUMBER;
    VMARCEMPLAUX NUMBER;
  BEGIN

    FOR V IN (SELECT CODIGO VMARCEMPL,
                     NOMBRE,
                     FECHA  VMARCFECHA,
                     HORA   VMARCHORA,
                     EVENTO VMARCEVENTO
                FROM PER_PERP007_TEMP
               WHERE EMPR = P_EMPRESA
               ORDER BY ROWID) LOOP

      BEGIN
        BEGIN
          SELECT CODR_LEGAJO
            INTO VMARCEMPLAUX
            FROM PER_CODIGOS_RELOJ_CEDEC
           WHERE CODR_COD_RELOJ = V.VMARCEMPL
             AND CODR_EMPR = P_EMPRESA;

          INSERT INTO PER_MARCACION_DIARIA_CEDEC
            (MARC_FECHA,
             MARC_EMPLEADO,
             MARC_EVENTO,
             MARC_HORA,
             MARC_LOGIN,
             MARC_FECHA_GRAB,
             MARC_FORM,
             MARC_ORIGEN,
             MARC_ESTADO,
             MARC_EMPR)
          VALUES
            (V.VMARCFECHA,
             VMARCEMPLAUX,
             V.VMARCEVENTO,
             V.VMARCHORA,
             GEN_DEVUELVE_USER,
             SYSDATE,
             'PERP015',
             'R',
             'N',
             P_EMPRESA);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
        END;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20001,
                                  'El codigo de reloj ' ||
                                  TO_NUMBER(V.VMARCEMPL) ||
                                  ', no tiene codigo de empleado. Verifique en el Mantenimiento de Empleados.');
        WHEN DUP_VAL_ON_INDEX THEN
          NULL;
      END;

    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      GENERAL.PL_EXHIBIR_ERROR_PLSQL;
  END;

  PROCEDURE PP_IMPORT_ARCHIVO(P_EMPRESA IN NUMBER, P_ARCHIVO IN VARCHAR2) IS

    CURSOR C_FILE IS
      WITH FILES AS
       (SELECT D.BLOB_CONTENT, D.FILENAME
          FROM APEX_APPLICATION_TEMP_FILES D
         WHERE D.NAME = P_ARCHIVO
           AND ROWNUM = 1)
      SELECT LINE_NUMBER, COL001, ROW_INFO
        FROM FILES F
       CROSS JOIN TABLE (APEX_DATA_PARSER.PARSE(P_CONTENT   => F.BLOB_CONTENT,
                               P_FILE_NAME => F.FILENAME)) EXCEL;

  BEGIN
    IF P_ARCHIVO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Archivo destino no se ha especificado correctamente.');
    END IF;

    DELETE FROM PERP007_IMP_TXT
     WHERE USUARIO = GEN_DEVUELVE_USER
       AND EMPR = P_EMPRESA;
    COMMIT;
    FOR REC IN C_FILE LOOP

      INSERT INTO PERP007_IMP_TXT
      VALUES
        (REC.COL001, GEN_DEVUELVE_USER, P_EMPRESA);

    END LOOP;

    --SE ELIMINA PARA LIBERAR EL CURSOR, PARA QUE PUEDA IMPORTAR BIEN EN LA SIGTE VEZ
    DELETE FROM APEX_APPLICATION_TEMP_FILES M
     WHERE M.NAME = P_ARCHIVO
       AND ROWNUM = 1;
  END PP_IMPORT_ARCHIVO;
  
    
 PROCEDURE PP_PROCESAR_CAST (P_EMPRESA IN NUMBER,
                             P_FEC_INI IN DATE,
                             P_FEC_HAST IN DATE )IS
   
 BEGIN
 --  RAISE_APPLICATION_ERROR(-20001,P_FEC_INI||' - '||P_FEC_HAST);
 DELETE PRDL051_TEMP_TVC
 WHERE P_SESSION = V('APP_SESSION');
  FOR X IN ( SELECT MIN(M."visit_date") ENTRADA,
                    MAX(M."visit_date") SALIDA,
                    A.VEND_LEGAJO_EMPL  LEGAJO,
                    TRUNC(M."visit_date") FECHA,
                    VEND_LEGAJO           VENDEDOR,
                    M.EMPL_NOMBRE
               FROM CAST_VISIT M, FAC_VENDEDOR A

              WHERE M."salesman_code" = A.VEND_LEGAJO
                AND A.VEND_EMPR = P_EMPRESA
                AND TRUNC(M."visit_date") between P_FEC_INI and P_FEC_HAST
              GROUP BY A.VEND_LEGAJO_EMPL,
                       TRUNC(M."visit_date"),
                       VEND_LEGAJO,
                       M.EMPL_NOMBRE )LOOP
 IF x.LEGAJO IS NOT NULL THEN
   begin 
        INSERT INTO PER_MARCACION_DIARIA
              (MARC_FECHA,
               MARC_EMPLEADO,
               MARC_EVENTO,
               MARC_HORA,
               MARC_LOGIN,
               MARC_FECHA_GRAB,
               MARC_FORM,
               MARC_ORIGEN,
               MARC_ESTADO,
               MAR_RELOJ_ORIG,
               MARC_EMPR)
            VALUES
              (X.FECHA,
               X.LEGAJO,
               'E',
               x.ENTRADA,
               GEN_DEVUELVE_USER,
               SYSDATE,
               'PERP007',
               'C',
               'N',
               NULL,
               P_EMPRESA);
       exception when others then
         null;
       
       end;
       begin
     INSERT INTO PER_MARCACION_DIARIA
              (MARC_FECHA,
               MARC_EMPLEADO,
               MARC_EVENTO,
               MARC_HORA,
               MARC_LOGIN,
               MARC_FECHA_GRAB,
               MARC_FORM,
               MARC_ORIGEN,
               MARC_ESTADO,
               MAR_RELOJ_ORIG,
               MARC_EMPR)
            VALUES
              (X.FECHA,
               X.LEGAJO,
               'S',
               x.SALIDA,
               GEN_DEVUELVE_USER,
               SYSDATE,
               'PERP007',
               'C',
               'N',
               NULL,
               P_EMPRESA);
          exception when others then
         null;
       
       end;      
 ELSE
   INSERT INTO PRDL051_TEMP_TVC
                   (DETALLE,
                    MES1,
                    P_SESSION)
                   values
                   (x.VENDEDOR,
                   x.EMPL_NOMBRE,
                   V('APP_SESSION'));
 END IF;              
               
 END LOOP;
 
 
 END PP_PROCESAR_CAST;
   
procedure import_hours(
    in_empresa  number,
    in_user     varchar2,
    in_filename varchar2
 )as
 
 type r_legajoHs is record(
   nro_linea number,
   legajo    number,
   fecha     date,
   tipo	     varchar2(1 char) --> 0=E o 1=S
 );
 
 type t_legajoHs is table of r_legajoHs index by pls_integer;
 
 l_hs_x_legajo t_legajoHs;
 
 co_current constant date := current_date;
 
 co_num_comodin  constant varchar2(3 char)  := '-99';
 co_date_comodin constant varchar2(16 char) := '01/01/1990 00:00';
 co_mask_date    constant varchar2(18 char) := 'dd/mm/yyyy hh24:mi';
 co_indefinido   constant varchar2(1 char)  := 'I';
begin
   if in_empresa is null then
     Raise_application_error(-20000, 'Empresa no encontrada');
   end if;
   
   -- para pruebas se_utiliza un espejo de tabla
   delete from per_marcacion_diaria_tmp;
   
   select line_number nro_linea,
          to_number(nvl(p.col001, co_num_comodin)) legajo, 
          to_date(nvl(p.col002, co_date_comodin), co_mask_date) fecha_hora,
          case to_number(nvl(p.col003, co_num_comodin)) 
            when 0 then 
              'E'
            when 1 then 
              'S' 
          else co_indefinido end tipo
   bulk collect into l_hs_x_legajo      
   from apex_application_temp_files f, 
       table( apex_data_parser.parse(
                p_content   => f.blob_content,
                p_file_name => f.filename,
                p_csv_col_delimiter => ','
              ) 
            ) p
   where f.name = in_filename;
 
 <<f_records>>
 for i in 1 .. l_hs_x_legajo.count loop
   if l_hs_x_legajo(i).legajo = to_number(co_num_comodin) then
     Raise_application_error(-20000, 'Linea Nro: '||l_hs_x_legajo(i).nro_linea||' del Archivo. Registro sin n'||chr(250)||'mero de legajo');
   end if;
   
   if l_hs_x_legajo(i).fecha = to_date(co_date_comodin, co_mask_date) then
     Raise_application_error(-20000, 'Linea Nro: '||l_hs_x_legajo(i).nro_linea||' del Archivo. Registro sin fecha y hora de marcaci'||chr(243)||'n');
   end if;
   
   if l_hs_x_legajo(i).tipo = co_indefinido then
     Raise_application_error(-20000, 'Linea Nro: '||l_hs_x_legajo(i).nro_linea||' del Archivo. Registro sin tipo de marcaci'||chr(243)||'n. Entrada / Salida (0 o 1)');
   end if;

   insert into per_marcacion_diaria_tmp
          (marc_fecha,
           marc_empleado,
           marc_evento,
           marc_hora,
           marc_login,
           marc_fecha_grab,
           marc_form,
           marc_origen,
           marc_estado,
           marc_empr
           )
        values
          (l_hs_x_legajo(i).fecha,
           l_hs_x_legajo(i).legajo,
           l_hs_x_legajo(i).tipo,
           l_hs_x_legajo(i).fecha,
           in_user,
           co_current,
           'PERP007',
           'R',
           'N',
           in_empresa
           );
   
 end loop f_records;
 
end import_hours;
                           
END PERP007;
/
