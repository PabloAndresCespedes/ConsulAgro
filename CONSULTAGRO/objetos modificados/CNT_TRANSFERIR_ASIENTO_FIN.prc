CREATE OR REPLACE PROCEDURE CNT_TRANSFERIR_ASIENTO_FIN IS
  V_EXISTE                 NUMBER;
  V_MENSAJE                VARCHAR(32767);
  V_EMPR                   NUMBER;
  V_IND_HAB_MES_ACTUAL     VARCHAR2(2);
  V_PER_ACT_INI            DATE;
  V_PER_ACT_FIN            DATE;
  V_IND_CANALES_IPS        NUMBER := 0;
  V_IND_EMPLEADO_SIN_CANAL VARCHAR2(1) := 'N';

  CURSOR SUCURSALES IS
    SELECT SUC_CODIGO
      FROM GEN_SUCURSAL
     WHERE SUC_EMPR = 1
       AND SUC_CODIGO NOT IN (5);

  CURSOR CURSOR_IPS(I_FECHA IN DATE) IS
    SELECT SUC_DESC,
           DPTO_DESC,
           A.CANAL,
           CCO_USA_CANAL,
           A.EMPL_LEGAJO,
           A.EMPL_NOMBRE
      FROM PER_PERP013_V A
     WHERE A.MES = TO_CHAR(ADD_MONTHS(I_FECHA, 1), 'MM')
       AND A.ANHO = TO_CHAR(ADD_MONTHS(I_FECHA, 1), 'YYYY')
       AND A.PDOC_EMPR = 1
       AND CCO_USA_CANAL = 'S'
       AND CANAL = 'SIN CANAL'
     GROUP BY SUC_DESC,
              DPTO_DESC,
              A.CANAL,
              CCO_USA_CANAL,
              A.EMPL_LEGAJO,
              A.EMPL_NOMBRE
     ORDER BY 1, 2, 3;

BEGIN

  SELECT C.CONF_PER_ACT_INI,
         C.CONF_PER_ACT_FIN,
         NVL(CONF_IND_HAB_MES_ACT, 'N')

    INTO V_PER_ACT_INI, V_PER_ACT_FIN, V_IND_HAB_MES_ACTUAL
    FROM FIN_CONFIGURACION C
   WHERE C.CONF_EMPR = 1;

  -- V_IND_HAB_MES_ACTUAL:='S';

  --VERIFICAR SI EXISTE REGISTRO EN LA TABLA DE EMPLEADO CANAL SI NO EXISTE COPIAR DEL PERIODO ANTERIOR
  -------====================================================================================================
  BEGIN
    FOR R IN SUCURSALES LOOP
      SELECT COUNT(NVL(P.EMCP_LEGAJO, 0))
        INTO V_EXISTE
        FROM PER_EMPL_CANAL_PERI P
       WHERE P.EMCP_EMPR = 1
         AND P.EMCP_SUC = R.SUC_CODIGO
         AND P.EMCP_PERIODO IN
             (SELECT P.PERI_CODIGO
                FROM PER_PERIODO P
               WHERE P.EMCP_EMPR = 1
                 AND CASE
                       WHEN V_IND_HAB_MES_ACTUAL = 'S' THEN
                        V_PER_ACT_FIN
                       WHEN V_IND_HAB_MES_ACTUAL = 'N' AND
                            TO_DATE(SYSDATE, 'DD/MM/YYYY') <= V_PER_ACT_FIN + 5 THEN
                        V_PER_ACT_FIN
                       ELSE
                        LAST_DAY(ADD_MONTHS(V_PER_ACT_FIN, 1))
                     END BETWEEN P.PERI_FEC_INI AND P.PERI_FEC_FIN);
      IF V_EXISTE = 0 THEN
        V_IND_EMPLEADO_SIN_CANAL := 'S';
        INSERT INTO PER_EMPL_CANAL_PERI
          (SELECT EMCP_PERIODO + 1,
                  EMCP_LEGAJO,
                  EMCP_EMPR,
                  EMCP_SUC,
                  EMCP_DPTO,
                  EMCP_CANAL,
                  EMCP_PORC,
                  EMCP_CANAL_BETA
             FROM PER_EMPL_CANAL_PERI P
            WHERE P.EMCP_EMPR = 1
              AND P.EMCP_SUC = R.SUC_CODIGO
              AND P.EMCP_PERIODO IN
                  (SELECT P.PERI_CODIGO - 1
                     FROM PER_PERIODO P
                    WHERE PERI_EMPR = 1
                      AND DECODE(V_IND_HAB_MES_ACTUAL,
                                 'S',
                                 V_PER_ACT_FIN,
                                 LAST_DAY(ADD_MONTHS(V_PER_ACT_FIN, 1))) BETWEEN
                          P.PERI_FEC_INI AND P.PERI_FEC_FIN));

      END IF;
    END LOOP;
    -----SI INSERTA UN REGISTRO ESPECIFICANDO LA COPIA DE LOS DATOS
    IF V_IND_EMPLEADO_SIN_CANAL = 'S' THEN
      INSERT INTO CNT_ASIENTO_LOG
      VALUES
        (SEQ_CNT_CLAVE_LOG.NEXTVAL,
         'SE COPIARION CORRECTAMENTE LOS DATOS DE EMPLEADO CANAL PERIODO ',
         SYSDATE,
         1);

      COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      -----SI INSERTA UN REGISTRO ESPECIFICANDO EL ERROR
      INSERT INTO CNT_ASIENTO_LOG
      VALUES
        (SEQ_CNT_CLAVE_LOG.NEXTVAL,
         'ERROR AL HACER COPIA DE DATOS EN  PER_EMPL_CANAL_PERI',
         SYSDATE,
         1);
      COMMIT;
      -------
  END;
  -----===================================================================================================

  --VALIDAR CANALES IPS SI EL CENTRO DE COSTO REQUIERE CANAL
  FOR R IN CURSOR_IPS(V_PER_ACT_INI) LOOP
    V_IND_CANALES_IPS := V_IND_CANALES_IPS + 1;
    --IF R.CAN_CODIGO IS NULL AND R.CCO_USA_CANAL = 'S' THEN
    V_MENSAJE := V_MENSAJE || ' Dpto:' || R.SUC_DESC || '-Suc:' ||
                 R.DPTO_DESC || '-Cod:' || R.EMPL_LEGAJO || '-Nombre:' ||
                 R.EMPL_NOMBRE || CHR(13);
    --END IF;
  END LOOP;

  IF V_MENSAJE IS NOT NULL THEN
    --SE RECORTA EL MENSAJE SI SUPERA LOS 350 CARACTERES
    IF LENGTH(V_MENSAJE) > 350 THEN
      V_MENSAJE := SUBSTR(V_MENSAJE, 0, 350);
    END IF;
    -----SI INSERTA UN REGISTRO ESPECIFICANDO EL ERROR
    INSERT INTO CNT_ASIENTO_LOG
    VALUES
      (SEQ_CNT_CLAVE_LOG.NEXTVAL,
       'FALTA ASIGNAR CANAL A EMPLEADOS ' || CHR(13) || V_MENSAJE,
       SYSDATE,
       1);
    COMMIT;
    ---====================================================
  END IF;
  -----------------------------------------------------------------------------------------------------------
  PP_VALIDAR_ASIENTOS(V_IND_HAB_MES_ACTUAL, V_PER_ACT_INI, 1); --REVISA SI HAY CAMBIOS EN LOS DOCUMENTOS YA TRANSFERIDOS SI HAY CAMBIOS SE BORRAN LOS ASIENTOS Y SE GENERAN DE NUEVO
  PP_GENERAR_ASI_PRCLI(V_IND_HAB_MES_ACTUAL, 1); --ASIENTO DE PROVEEDOR_CLIENTE
  PP_GENERAR_ASI_INT_PMO(V_IND_HAB_MES_ACTUAL, 1); --ASIENTO DE PRESTAMO
  PP_GENERAR_ASI_DEV_IVA(V_IND_HAB_MES_ACTUAL, 1); --ASIENTO DE DEVOLUCION DE IVA
  PP_GENERAR_ASI_COMBUSTIBLE(V_IND_HAB_MES_ACTUAL, 1); --ASIENTO DE COMBUSTIBLE

  ---------=================SI ESTA INABILITADO PASAR AL SIGUIENTE MES
  IF V_IND_HAB_MES_ACTUAL = 'N' AND
     TO_DATE(SYSDATE, 'DD/MM/YYYY') <= V_PER_ACT_FIN + 5 THEN
    V_PER_ACT_FIN := LAST_DAY(ADD_MONTHS(V_PER_ACT_FIN, 1));
  END IF;
  --------=================

  PP_GENERAR_ASI_BCO(V_IND_HAB_MES_ACTUAL, 1);
  PP_GENERAR_ASI_PREST(V_IND_HAB_MES_ACTUAL, 1);
  PP_INSERTAR_ASIENTOI(V_IND_HAB_MES_ACTUAL, 1);
  PP_GENERAR_ASI_AGUINALDO(V_IND_HAB_MES_ACTUAL, 1);
  PP_GENERAR_ASI_COSTO_EXPORT(V_IND_HAB_MES_ACTUAL, 1);
  PP_ACTUALIZAR_CNT_ASIENTO_IP(V_IND_HAB_MES_ACTUAL, 1);
  --###########################################################################
  --------PROCESO DE REENUMERACION DE ASIENTOS
  /*
  DECLARE
    V_NRO          NUMBER;
    V_IND_REENUMER NUMBER := 0;
    CURSOR C IS
      SELECT ASI_CLAVE, ASI_NRO
        FROM CNT_ASIENTO A
       WHERE A.ASI_EMPR = P_EMPRESA
         AND TO_CHAR(A.ASI_FEC, 'MM/YYYY') =
             TO_CHAR(V_PER_ACT_FIN, 'MM/YYYY')
       ORDER BY ASI_NRO ASC;
  BEGIN
    FOR R IN C LOOP
      IF V_NRO IS NULL THEN
        V_NRO := R.ASI_NRO;
      ELSE
        V_NRO := V_NRO + 1;
      END IF;
      IF V_NRO != R.ASI_NRO THEN
        V_IND_REENUMER := V_IND_REENUMER + 1;
        --DBMS_OUTPUT.PUT_LINE(V_NRO || '-' || R.ASI_NRO);
        UPDATE CNT_ASIENTO
           SET ASI_NRO = V_NRO
         WHERE ASI_CLAVE = R.ASI_CLAVE
           AND ASI_EMPR = P_EMPRESA;
      END IF;

    END LOOP;
    IF V_IND_REENUMER > 0 THEN
      INSERT INTO CNT_ASIENTO_LOG
      VALUES
        (SEQ_CNT_CLAVE_LOG.NEXTVAL,
         'Se ha corrido un proceso de reenumeracion Asientos sastifactoriamente!',
         SYSDATE,
         P_EMPRESA);
    END IF;
  END;*/
  --###########################################################################

  V_EMPR := 1;
  COMMIT;

  ---------------------------------------------------ENVIAR MAIL
  DECLARE
    DESTINATARIO    VARCHAR2(600);
    COPIA           VARCHAR2(600);
    OCULTA          VARCHAR2(200);
    V_MENSAJE       VARCHAR2(32767);
    V_CONT          NUMBER := 0;
    V_ERRORSQL      VARCHAR2(45);
    V_TOTAL_CREDITO NUMBER;
    V_TOTAL_DEBITO  NUMBER;
    CURSOR ASI_LOG IS
      SELECT A.CAL_CLAVE, A.CAL_DESC, A.CAL_FECHA
        FROM CNT_ASIENTO_LOG A
       WHERE A.CAL_EMPR = 1
         AND TO_CHAR(A.CAL_FECHA, 'dd/mm/yyyy') =
             TO_CHAR(SYSDATE, 'dd/mm/yyyy')
       ORDER BY 1 ASC;
  BEGIN
    SELECT T.CO_PARA, T.CO_CC, T.CO_CCO
      INTO DESTINATARIO, COPIA, OCULTA
      FROM GEN_CORREOS T
     WHERE T.CO_ACCION = 'Trasferir_Finanzas';
    ----PARA ENVIAR LOS TOTALES DE CREDITO Y DEBITO EN DEL MES
    SELECT SUM(DECODE(B.ASID_IND_DB_CR, 'C', B.ASID_IMPORTE, 0)) TOTAL_CREDITO,
           SUM(DECODE(B.ASID_IND_DB_CR, 'D', B.ASID_IMPORTE, 0)) TOTAL_DEBITO
      INTO V_TOTAL_CREDITO, V_TOTAL_DEBITO
      FROM CNT_ASIENTO A, CNT_ASIENTO_DET B, CNT_CUENTA C
     WHERE A.ASI_CLAVE = B.ASID_CLAVE_ASI
       AND A.ASI_EMPR = B.ASID_EMPR
       AND B.ASID_CLAVE_CTACO = C.CTAC_CLAVE
       AND B.ASID_EMPR = C.CTAC_EMPR
       AND A.ASI_EMPR = 1
       AND TO_CHAR(ASI_FEC, 'mm-yyyy') =
           (SELECT DECODE(CONF_IND_HAB_MES_ACT,
                          'N',
                          TO_CHAR(ADD_MONTHS(C.CONF_PER_ACT_INI, 1),
                                  'mm-yyyy'),
                          TO_CHAR(C.CONF_PER_ACT_INI, 'mm-yyyy'))
              FROM FIN_CONFIGURACION C
             WHERE CONF_EMPR = 1);
    -------------------------------------------------------------------------
    FOR R IN ASI_LOG LOOP
      V_CONT    := V_CONT + 1;
      V_MENSAJE := V_MENSAJE || V_CONT || '-' || R.CAL_DESC || CHR(13);
    END LOOP;
    V_MENSAJE := V_MENSAJE || '===============TOTALES====================' ||
                 CHR(13);
    V_MENSAJE := V_MENSAJE || 'TOTAL CREDITO: ' || V_TOTAL_CREDITO ||
                 CHR(13);
    V_MENSAJE := V_MENSAJE || 'TOTAL DEBITO:  ' || V_TOTAL_DEBITO ||
                 CHR(13);
    --DBMS_OUTPUT.PUT_LINE(V_MENSAJE);
    /*   UTL_MAIL.SEND@TAGRO(SENDER     => 'programacion1@transagro.com.py',
                          RECIPIENTS => 'programacion2@hilagro.com.py',
                          CC         => 'contabilidad@hilagro.com.py;contabilidad2@hilagro.com.py',
                          SUBJECT    => 'Notificaciones y Errores de Transferencia de Asientos',
                          MESSAGE    => V_MENSAJE);
    */
  IF DESTINATARIO IS NOT NULL THEN
    UTL_MAIL.SEND(sender     => 'noreply',
                      recipients => DESTINATARIO,
                      cc         => COPIA,
                      bcc        => OCULTA,
                      subject    => 'Notificaciones y Errores de Transferencia de Asientos',
                      message    => V_MENSAJE,
                      mime_type  => 'text/plain');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_ERRORSQL := SQLERRM;
      RAISE_APPLICATION_ERROR(-20000, V_ERRORSQL);
      NULL;
  END;
  COMMIT;
  ----------------------------------------------------------
END;
/
