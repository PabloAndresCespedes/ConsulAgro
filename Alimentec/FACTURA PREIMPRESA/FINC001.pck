CREATE OR REPLACE PACKAGE FINC001 AS

  PROCEDURE PP_BUSCAR_FACTURA(P_EMPRESA     IN NUMBER,
                              P_TIPO_MOV    IN NUMBER,
                              P_DOC_NRO_DOC IN NUMBER,
                              P_DOC_CLAVE   OUT VARCHAR2,
                              P_NRO_DOC_AUX OUT NUMBER,
                              P_AUX         OUT NUMBER);

  PROCEDURE PP_CARGAR_DETALLE(P_EMPRESA            IN NUMBER,
                              P_TIPO_MOV           IN NUMBER,
                              P_DOC_CLAVE          IN VARCHAR2,
                              P_SUC_DESC           OUT VARCHAR2,
                              P_MON_DESC           OUT VARCHAR2,
                              P_DOC_LOGIN          OUT VARCHAR2,
                              P_S_TASA_OFIC        OUT NUMBER,
                              P_DOC_FEC_OPER       OUT DATE,
                              P_DOC_FEC_DOC        OUT DATE,
                              P_DOC_SIST           OUT VARCHAR2,
                              P_DOC_FEC_GRAB       OUT DATE,
                              P_DOC_OBS            OUT VARCHAR2,
                              P_DOC_LEGAJO         OUT NUMBER,
                              P_PLAF_DESC          OUT VARCHAR2,
                              P_CAN_DESC           OUT VARCHAR2,
                              P_W_TOT_DOC          OUT NUMBER,
                              P_DOC_SALDO_LOC      OUT NUMBER,
                              P_DOC_SALDO_MON      OUT NUMBER,
                              P_DOC_NRO_CHEQUE     OUT NUMBER,
                              P_DOC_TIMBRADO       OUT VARCHAR2,
                              P_IDENTIFICAR_CLI    OUT VARCHAR2,
                              P_S_DOC_CLI_NOM      OUT VARCHAR2,
                              P_RUC1               OUT VARCHAR2,
                              P_S_DOC_CLI_DIR      OUT VARCHAR2,
                              P_S_DOC_CLI_TEL      OUT VARCHAR2,
                              P_RUC2               OUT VARCHAR2,
                              P_S_DOC_CLI_NOM2     OUT VARCHAR2,
                              P_DOC_COBRADOR       OUT NUMBER,
                              P_DOC_BASE_IMPON_MON OUT NUMBER,
                              P_DOC_FEC_CHEQUE     OUT DATE,
                              P_BCO_DESC_2         OUT VARCHAR2,
                              P_CTA_DESC           OUT VARCHAR2,
                              P_BCO_DESC           OUT VARCHAR2,
                              P_DOC_CTA_BCO        OUT VARCHAR2,
                              P_RET_ESTADO         OUT VARCHAR2,
                              P_SC_NRO             OUT VARCHAR2,
                              P_SC_FECHA           OUT DATE,
                              P_OC_NRO             OUT VARCHAR2,
                              P_OC_FECHA           OUT DATE,
                              P_DOC_NETO_EXEN_LOC  OUT NUMBER,
                              P_DOC_NETO_EXEN_MON  OUT NUMBER,
                              
                              P_DOC_NETO_GRAV_MON OUT NUMBER,
                              P_DOC_NETO_GRAV_LOC OUT NUMBER,
                              P_DOC_IVA_MON       OUT NUMBER,
                              P_DOC_IVA_LOC       OUT NUMBER,
                              P_CLAVE_STK         OUT NUMBER,
                              P_TIPO_FACTURA       OUT VARCHAR2);

  PROCEDURE LLAMAR_REPORTE(P_EMPRESA         NUMBER,
                           P_DOC_CLAVE       NUMBER,
                           P_USUARIO         VARCHAR2,
                           P_TIPO_MOVIMIENTO NUMBER DEFAULT NULL);

  PROCEDURE PP_IMPRIMIR_REPORTE_TRANS(P_EMPRESA            IN NUMBER,
                                      P_TIPO_DE_MOVIMIENTO IN NUMBER,
                                      P_CLAVE              IN NUMBER,
                                      P_CLAVE_STK          IN NUMBER,
                                      P_SUCURSAL           IN NUMBER,
                                      P_DOC_NRO_DOC        IN NUMBER);

  PROCEDURE PP_IMPRIMIR_REPORTE_STK_DOC(P_EMPRESA            IN NUMBER,
                                        P_TIPO_DE_MOVIMIENTO IN NUMBER,
                                        P_CLAVE_STK          IN NUMBER);

  PROCEDURE PP_IMPRIMIR_REPORTE_DOC(P_EMPRESA            IN NUMBER,
                                    P_TIPO_DE_MOVIMIENTO IN NUMBER,
                                    P_CLAVE              IN NUMBER,
                                    P_ALERTA             OUT VARCHAR2);

  FUNCTION CF_VENCIMIENTOFORMULA(I_DOC_CLAVE IN NUMBER,
                                 I_EMPRESA   IN NUMBER) RETURN CHAR;

  FUNCTION CCO_CCO_HILAGRO_CFFORMULA(I_CCO_HILAGRO_DESC IN VARCHAR2)
    RETURN CHAR;

END FINC001;
/
CREATE OR REPLACE PACKAGE BODY FINC001 AS

  PROCEDURE PP_BUSCAR_FACTURA(P_EMPRESA     IN NUMBER,
                              P_TIPO_MOV    IN NUMBER,
                              P_DOC_NRO_DOC IN NUMBER,
                              P_DOC_CLAVE   OUT VARCHAR2,
                              P_NRO_DOC_AUX OUT NUMBER,
                              P_AUX         OUT NUMBER) AS
    V_CLAVE   VARCHAR2(20);
    V_PERSONA NUMBER;
  
  BEGIN
  
    SELECT DOC_CLAVE, NVL(DOC_CLI, DOC_PROV)
      INTO V_CLAVE, V_PERSONA
      FROM FIN_DOCUMENTO
     WHERE DOC_NRO_DOC = P_DOC_NRO_DOC
       AND DOC_TIPO_MOV = P_TIPO_MOV
       AND DOC_EMPR = P_EMPRESA;
  
    --==========AGREGADO POR LR EL 03/09/2021 SOLICITUD DEL SE?OR FRANZ FRIESEN
    --Validar visualizaci?n del cliente/proveedor.
    IF V_PERSONA IS NOT NULL THEN
      IF FIN_PERSONA_RESTRINGIDA(V_PERSONA, P_EMPRESA) = 'S' THEN
        -- P_DOC_CLAVE := NULL;
        RAISE_APPLICATION_ERROR(-20010,
                                'La persona del documento se encuentra Restringida!');
      
      END IF;
    END IF;
    --===============================================================================
  
    P_DOC_CLAVE   := V_CLAVE;
    P_NRO_DOC_AUX := NULL;
    P_AUX         := NULL;
    --setitem('P131_CLAVE',V_CLAVE);
    --*
  
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
    
      P_NRO_DOC_AUX := P_DOC_NRO_DOC;
      P_DOC_CLAVE   := NULL;
      P_AUX         := NULL;
    WHEN NO_DATA_FOUND THEN
      P_AUX := 61502;
  END PP_BUSCAR_FACTURA;

  PROCEDURE PP_CARGAR_DETALLE(P_EMPRESA            IN NUMBER,
                              P_TIPO_MOV           IN NUMBER,
                              P_DOC_CLAVE          IN VARCHAR2,
                              P_SUC_DESC           OUT VARCHAR2,
                              P_MON_DESC           OUT VARCHAR2,
                              P_DOC_LOGIN          OUT VARCHAR2,
                              P_S_TASA_OFIC        OUT NUMBER,
                              P_DOC_FEC_OPER       OUT DATE,
                              P_DOC_FEC_DOC        OUT DATE,
                              P_DOC_SIST           OUT VARCHAR2,
                              P_DOC_FEC_GRAB       OUT DATE,
                              P_DOC_OBS            OUT VARCHAR2,
                              P_DOC_LEGAJO         OUT NUMBER,
                              P_PLAF_DESC          OUT VARCHAR2,
                              P_CAN_DESC           OUT VARCHAR2,
                              P_W_TOT_DOC          OUT NUMBER,
                              P_DOC_SALDO_LOC      OUT NUMBER,
                              P_DOC_SALDO_MON      OUT NUMBER,
                              P_DOC_NRO_CHEQUE     OUT NUMBER,
                              P_DOC_TIMBRADO       OUT VARCHAR2,
                              P_IDENTIFICAR_CLI    OUT VARCHAR2,
                              P_S_DOC_CLI_NOM      OUT VARCHAR2,
                              P_RUC1               OUT VARCHAR2,
                              P_S_DOC_CLI_DIR      OUT VARCHAR2,
                              P_S_DOC_CLI_TEL      OUT VARCHAR2,
                              P_RUC2               OUT VARCHAR2,
                              P_S_DOC_CLI_NOM2     OUT VARCHAR2,
                              P_DOC_COBRADOR       OUT NUMBER,
                              P_DOC_BASE_IMPON_MON OUT NUMBER,
                              P_DOC_FEC_CHEQUE     OUT DATE,
                              P_BCO_DESC_2         OUT VARCHAR2,
                              P_CTA_DESC           OUT VARCHAR2,
                              P_BCO_DESC           OUT VARCHAR2,
                              P_DOC_CTA_BCO        OUT VARCHAR2,
                              P_RET_ESTADO         OUT VARCHAR2,
                              P_SC_NRO             OUT VARCHAR2,
                              P_SC_FECHA           OUT DATE,
                              P_OC_NRO             OUT VARCHAR2,
                              P_OC_FECHA           OUT DATE,
                              P_DOC_NETO_EXEN_LOC  OUT NUMBER,
                              P_DOC_NETO_EXEN_MON  OUT NUMBER,
                              P_DOC_NETO_GRAV_MON  OUT NUMBER,
                              P_DOC_NETO_GRAV_LOC  OUT NUMBER,
                              P_DOC_IVA_MON        OUT NUMBER,
                              P_DOC_IVA_LOC        OUT NUMBER,
                              P_CLAVE_STK          OUT NUMBER,
                              P_TIPO_FACTURA       OUT VARCHAR2) AS
  
    V_PROV_ACO              NUMBER;
    V_PROVEEDOR             NUMBER;
    V_CLIENTE               NUMBER;
    V_CTA                   NUMBER;
    TOT_MON                 NUMBER;
    TOT_LOC                 NUMBER;
    V_DOC_MON               NUMBER;
    V_CHEQUE_BCO            NUMBER;
    V_TMOV_IND_AFECTA_SALDO VARCHAR2(5);
    V_W_IND_ER              VARCHAR2(5);
    V_CLAVE                 NUMBER;
  
  BEGIN
    V_CLAVE := REPLACE(P_DOC_CLAVE, ':');
  
    SELECT DOC_PROV,
           (SELECT S.SUC_CODIGO || ' - ' || S.SUC_DESC
              FROM GEN_SUCURSAL S
             WHERE S.SUC_EMPR = DOC_EMPR
               AND S.SUC_CODIGO = DOC_SUC) DOC_SUC,
           (SELECT M.MON_CODIGO || ' - ' || M.MON_DESC
              FROM GEN_MONEDA M
             WHERE M.MON_CODIGO = DOC_MON
               AND M.MON_EMPR = DOC_EMPR) MONEDA,
           DOC_MON,
           DOC_LOGIN,
           DOC_TASA,
           DOC_FEC_OPER,
           DOC_FEC_DOC,
           DOC_SIST,
           DOC_FEC_GRAB,
           DOC_CLI,
           DOC_CTA_BCO,
           DOC_OBS,
           DOC_LEGAJO,
           (SELECT P.PLAF_CODIGO || ' - ' || P.PLAF_DESC
              FROM FAC_PLAN_FINAN P
             WHERE P.PLAF_EMPR = DOC_EMPR
               AND P.PLAF_CODIGO = DOC_PLAN_FINAN) PLAN,
           (SELECT CV.CAN_CODIGO || ' - ' || CV.CAN_DESC
              FROM FAC_CANAL_VENTA CV
             WHERE CV.CAN_EMPR = DOC_EMPR
               AND CV.CAN_CODIGO = DOC_CANAL) CANAL,
           NVL(DOC_NETO_EXEN_MON, 0) + NVL(DOC_NETO_GRAV_MON, 0) +
           NVL(DOC_IVA_MON, 0),
           DOC_SALDO_LOC,
           DOC_SALDO_MON,
           DOC_PROV_ACOPIO,
           DOC_NRO_CHEQUE,
           ': ' || DOC_TIMBRADO,
           NVL(DOC_NETO_EXEN_LOC, 0) + NVL(DOC_NETO_GRAV_LOC, 0) +
           NVL(DOC_IVA_LOC, 0),
           NVL(DOC_NETO_EXEN_MON, 0) + NVL(DOC_NETO_GRAV_MON, 0) +
           NVL(DOC_IVA_MON, 0),
           DOC_COBRADOR,
           DOC_BASE_IMPON_MON,
           DOC_FEC_CHEQUE,
           DOC_BCO_CHEQUE,
           DOC_CLI_NOM,
           DOC_CLI_DIR,
           DOC_CLI_TEL,
           DOC_CLI_RUC,
           DOC_NETO_EXEN_MON,
           DOC_NETO_EXEN_LOC,
           DOC_NETO_GRAV_MON,
           DOC_NETO_GRAV_LOC,
           DOC_IVA_MON,
           DOC_IVA_LOC,
           DOC_CLAVE_STK,
           DOC_TIPO_FACTURA
    
      INTO V_PROVEEDOR,
           P_SUC_DESC,
           P_MON_DESC,
           V_DOC_MON,
           P_DOC_LOGIN,
           P_S_TASA_OFIC,
           P_DOC_FEC_OPER,
           P_DOC_FEC_DOC,
           P_DOC_SIST,
           P_DOC_FEC_GRAB,
           V_CLIENTE,
           V_CTA,
           P_DOC_OBS,
           P_DOC_LEGAJO,
           P_PLAF_DESC,
           P_CAN_DESC,
           P_W_TOT_DOC,
           P_DOC_SALDO_LOC,
           P_DOC_SALDO_MON,
           V_PROV_ACO,
           P_DOC_NRO_CHEQUE,
           P_DOC_TIMBRADO,
           TOT_LOC,
           TOT_MON,
           P_DOC_COBRADOR,
           P_DOC_BASE_IMPON_MON,
           P_DOC_FEC_CHEQUE,
           V_CHEQUE_BCO,
           P_S_DOC_CLI_NOM,
           P_S_DOC_CLI_DIR,
           P_S_DOC_CLI_TEL,
           P_RUC1,
           P_DOC_NETO_EXEN_MON,
           P_DOC_NETO_EXEN_LOC,
           P_DOC_NETO_GRAV_MON,
           P_DOC_NETO_GRAV_LOC,
           P_DOC_IVA_MON,
           P_DOC_IVA_LOC,
           P_CLAVE_STK,
           P_TIPO_FACTURA
    
      FROM FIN_DOCUMENTO
     WHERE DOC_CLAVE = V_CLAVE
       AND DOC_EMPR = P_EMPRESA
       AND DOC_TIPO_MOV = P_TIPO_MOV;
  
    --==========AGREGADO POR LR EL 03/09/2021 SOLICITUD DEL SE?OR FRANZ FRIESEN
    --Validar visualizaci?n del cliente/proveedor.
    IF FIN_PERSONA_RESTRINGIDA(NVL(V_CLIENTE, V_PROVEEDOR), P_EMPRESA) = 'S' THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'La persona del documento se encuentra Restringida!');
    END IF;
    --===============================================================================
  
    --*
    SELECT TMOV_IND_ER, TMOV_IND_AFECTA_SALDO
      INTO V_W_IND_ER, V_TMOV_IND_AFECTA_SALDO
      FROM GEN_TIPO_MOV
     WHERE TMOV_CODIGO = P_TIPO_MOV
       AND TMOV_EMPR = P_EMPRESA;
  
    IF V_TMOV_IND_AFECTA_SALDO = 'P' THEN
      P_IDENTIFICAR_CLI := 'Proveedor ';
    ELSIF V_TMOV_IND_AFECTA_SALDO = 'C' THEN
      P_IDENTIFICAR_CLI := 'Cliente ';
    ELSE
      IF V_W_IND_ER = 'R' THEN
        P_IDENTIFICAR_CLI := 'Proveedor ';
      ELSE
        P_IDENTIFICAR_CLI := 'Cliente ';
      END IF;
    END IF;
    --*
    IF V_CLIENTE IS NOT NULL THEN
    
      SELECT CLI_CODIGO || ' - ' || CLI_NOM,
             CLI_RUC CLIENTE,
             ': ' || CLI_DIR,
             SUBSTR(CLI_TEL, 1, 15) TELEFONO
        INTO P_S_DOC_CLI_NOM, P_RUC1, P_S_DOC_CLI_DIR, P_S_DOC_CLI_TEL
        FROM FIN_CLIENTE
       WHERE CLI_CODIGO = V_CLIENTE
         AND CLI_EMPR = P_EMPRESA;
      P_RUC2           := P_RUC1;
      P_S_DOC_CLI_NOM2 := P_S_DOC_CLI_NOM;
      --*
    ELSIF V_PROV_ACO IS NOT NULL OR V_PROVEEDOR IS NOT NULL THEN
    
      IF V_PROV_ACO IS NOT NULL THEN
        BEGIN
          SELECT PROV_CODIGO || ' - ' || PROV_RAZON_SOCIAL,
                 ': ' || PROV_RUC
            INTO P_S_DOC_CLI_NOM, P_RUC1
            FROM FIN_PROVEEDOR
           WHERE PROV_CODIGO = V_PROV_ACO
             AND PROV_EMPR = P_EMPRESA;
        
          SELECT PROV_CODIGO || ' - ' || PROV_RAZON_SOCIAL,
                 ': ' || PROV_RUC
            INTO P_S_DOC_CLI_NOM2, P_RUC2
            FROM FIN_PROVEEDOR
           WHERE PROV_CODIGO = V_PROVEEDOR
             AND PROV_EMPR = P_EMPRESA;
        EXCEPTION
          WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20343, 'proveedor aco.');
          WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20343, 'proveedor aco.');
        END;
      
      ELSE
        BEGIN
          SELECT PROV_CODIGO || ' - ' || PROV_RAZON_SOCIAL,
                 ': ' || PROV_RUC,
                 PROV_DIR,
                 PROV_TEL
            INTO P_S_DOC_CLI_NOM, P_RUC1, P_S_DOC_CLI_DIR, P_S_DOC_CLI_TEL
            FROM FIN_PROVEEDOR
           WHERE PROV_CODIGO = V_PROVEEDOR
             AND PROV_EMPR = P_EMPRESA;
          P_RUC2           := P_RUC1;
          P_S_DOC_CLI_NOM2 := P_S_DOC_CLI_NOM;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20343, 'proveedor .');
        END;
      END IF;
    END IF;
    --*
  
    IF V_DOC_MON IS NOT NULL AND P_S_TASA_OFIC IS NULL THEN
      P_S_TASA_OFIC := TOT_LOC / TOT_MON;
    END IF;
    --*
    IF V_CHEQUE_BCO IS NOT NULL THEN
      SELECT BCO_DESC
        INTO P_BCO_DESC_2
        FROM FIN_BANCO
       WHERE BCO_CODIGO = V_CHEQUE_BCO
         AND BCO_EMPR = P_EMPRESA;
    END IF;
    --*
    IF V_CTA IS NOT NULL THEN
      SELECT ': ' || CTA_CODIGO, BCO_DESC, CTA_DESC
        INTO P_DOC_CTA_BCO, P_BCO_DESC, P_CTA_DESC
        FROM FIN_CUENTA_BANCARIA, FIN_BANCO
       WHERE CTA_EMPR = P_EMPRESA
         AND CTA_EMPR = BCO_EMPR(+)
         AND CTA_BCO = BCO_CODIGO(+)
         AND CTA_CODIGO = V_CTA;
    END IF;
    --*
    IF P_TIPO_MOV = 61 AND V_CLAVE IS NOT NULL THEN
      BEGIN
        SELECT DECODE(RET_ESTADO,
                      'P',
                      'PENDIENTE',
                      'G',
                      'GENERADO',
                      'C',
                      'CONFIRMADO',
                      NULL) ESTADO
          INTO P_RET_ESTADO
          FROM FIN_RETENCION
         WHERE RET_RET_CLAVE = V_CLAVE
           AND RET_EMPR = P_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          P_RET_ESTADO := NULL;
      END;
    
    END IF;
    --*
    BEGIN
      SELECT TRUNC(OCOM_NRO), OCOM_FEC
        INTO P_OC_NRO, P_OC_FECHA
        FROM (SELECT DISTINCT OC.OCOM_NRO, OC.OCOM_FEC
              --    INTO P_SC_NRO, P_SC_FECHA, P_OC_NRO, P_OC_FECHA
                FROM FIN_DOC_CONCEPTO     FC,
                     STK_ORDEN_COMPRA     OC,
                     STK_ORDEN_COMPRA_DET OCD
               WHERE FC.DCON_CLAVE_DOC = V_CLAVE
                 AND FC.DCON_EMPR = P_EMPRESA
                 AND OC.OCOM_CLAVE = OCD.OCOMD_CLAVE_OCOM
                 AND OC.OCOM_EMPR = OCD.OCOMD_EMPR
                 AND OCD.OCOMD_CLAVE_OCOM = FC.DCON_OCOMD_CLAVE
                 AND OCD.OCOMD_EMPR = FC.DCON_EMPR
                    
                 AND OCD.OCOMD_EMPR = FC.DCON_EMPR
              
              UNION ALL
              SELECT DISTINCT OC.OCOM_NRO, OC.OCOM_FEC
              -- INTO P_SC_NRO, P_SC_FECHA, P_OC_NRO, P_OC_FECHA
                FROM FIN_DOCUMENTO        FD,
                     STK_DOCUMENTO_DET    SD,
                     STK_ORDEN_COMPRA     OC,
                     STK_ORDEN_COMPRA_DET OCD
               WHERE DOC_CLAVE = V_CLAVE
                 AND DOC_EMPR = P_EMPRESA
                 AND DOC_CLAVE_STK = DETA_CLAVE_DOC
                 AND DOC_EMPR = DETA_EMPR
                    
                 AND OC.OCOM_CLAVE = OCD.OCOMD_CLAVE_OCOM
                 AND OC.OCOM_EMPR = OCD.OCOMD_EMPR
                    
                 AND OCD.OCOMD_CLAVE_OCOM = SD.DETA_OCOMD_CLAVE
                 AND OCD.OCOMD_EMPR = SD.DETA_EMPR
                    
                 AND OCD.OCOMD_EMPR = SD.DETA_EMPR);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
      WHEN OTHERS THEN
        NULL;
    END;
  
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20343, 'CLAVE.');
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20343, 'Documento no encontrado');
  END PP_CARGAR_DETALLE;

  PROCEDURE LLAMAR_REPORTE(P_EMPRESA         NUMBER,
                           P_DOC_CLAVE       NUMBER,
                           P_USUARIO         VARCHAR2,
                           P_TIPO_MOVIMIENTO NUMBER DEFAULT NULL) AS
    V_PARAMETROS    VARCHAR2(600);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    V_REPORT        VARCHAR2(50);
    V_AFECTA_STOCK  VARCHAR2(2);
    V_TIPO_MOV      NUMBER;
    V_CLAVE_AUT     NUMBER; --VARIABLE AUXILIAR
  BEGIN
    BEGIN
      SELECT DISTINCT DOC_TIPO_MOV, AFECTA_STOCK
        INTO V_TIPO_MOV, V_AFECTA_STOCK
        FROM (SELECT DOC_TIPO_MOV,
                     DECODE(DOC_CLAVE_STK, NULL, 'NO', 'SI') AFECTA_STOCK
                FROM FIN_DOCUMENTO D
               WHERE D.DOC_CLAVE = P_DOC_CLAVE
                 AND DOC_EMPR = P_EMPRESA
              UNION ALL
              SELECT DOC_TIPO_MOV,
                     DECODE(DOC_CLAVE_STK, NULL, 'NO', 'SI') AFECTA_STOCK
                FROM FIN_DOCUMENTO_COMI015_TEMP D
               WHERE D.DOC_CLAVE = P_DOC_CLAVE
                 AND DOC_EMPR = P_EMPRESA
              UNION ALL
              SELECT DOC_TIPO_MOV,
                     DECODE(DOC_CLAVE_STK, NULL, 'NO', 'SI') AFECTA_STOCK
                FROM FIN_DOCUMENTO_TMP D
               WHERE D.DOC_CLAVE = P_DOC_CLAVE
                 AND DOC_EMPR = P_EMPRESA);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
      
    END;
  
    -- RAISE_APPLICATION_ERROR(-20343, 'CLAVE.');
    -- CONCATENAR LOS PARAMETROS PARA LLAMAR EL REPORTE EN JASPER
    V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    (P_EMPRESA);
    IF V_AFECTA_STOCK = 'NO' AND V_TIPO_MOV IN (7, 9, 10, 16, 18, 31) THEN
    
      IF V_TIPO_MOV = 7 THEN
        --EN ESTE PUNTO, DEBE PREGUNTAR, SI SE ESTA QUERIENDO IMPRIMIR DESDE EL 8-2-5, QUE TIRA EN LA TEMPORAL O DESDE EL 2-3-5 O CUALQUIER PROGRAMA DE REIMPRESION
        --PORQUE CON EL UNION QUE SE LE AGREGO AL REPORTE PARA QUE TOME DE LA TEMPORAL O DEL REAL, PARA QUE PUEDA IMPRIMIR DESDE EL 8-2-5, ANULA LOS DETALLES REPETIDOS
        --13/08/2019
        SELECT COUNT(*)
          INTO V_CLAVE_AUT
          FROM FIN_DOCUMENTO D
         WHERE D.DOC_CLAVE = P_DOC_CLAVE
           AND D.DOC_EMPR = P_EMPRESA; --BUSCA LA CLAVE EN FIN_DOCUMENTO
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                        P_DOC_CLAVE;
        IF NVL(V_CLAVE_AUT, 0) = 0 THEN
          --ESTA IMPRIMIENDO DESDE EL 8-2-5
          V_REPORT := 'COMI001G_TEMP';
        ELSE
          V_REPORT := 'COMI001G';
        END IF;
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                        P_DOC_CLAVE;
        V_REPORT     := 'COMI001G';
      ELSIF V_TIPO_MOV IN (9, 10) then
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                        P_DOC_CLAVE;
        V_REPORT     := 'FACP008_G';
        -- V_REPORT     := 'FACP008_TMP';
      ELSIF V_TIPO_MOV IN (16) THEN
        -----PRIMERO PASO POR APROBACION AIS QUEGUARDA EN LA TEMPORAL LV'31/10/2019'
      
        SELECT COUNT(*)
          INTO V_CLAVE_AUT
          FROM FIN_DOCUMENTO D
         WHERE D.DOC_CLAVE = P_DOC_CLAVE
           AND D.DOC_EMPR = P_EMPRESA; --BUSCA LA CLAVE EN FIN_DOCUMENTO
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                        P_DOC_CLAVE;
        IF NVL(V_CLAVE_AUT, 0) = 0 THEN
          --ESTA IMPRIMIENDO DESDE EL 8-2-5
          V_REPORT := 'FACI036_G_TEMP';
        ELSE
          V_REPORT := 'FACI036_G';
        END IF;
      
      ELSIF V_TIPO_MOV IN (18) THEN
      
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DOC_CLAVE=' ||
                        P_DOC_CLAVE;
        V_REPORT     := 'FINI003B_REC_AI';
      ELSIF V_TIPO_MOV IN (31) AND P_EMPRESA NOT BETWEEN 5 AND 17 THEN
      
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DOC_CLAVE=' ||
                        P_DOC_CLAVE;
        V_REPORT     := 'FINI003C_REC_AI';
      
        ---/***************************ERDM***************************/
      ELSIF V_TIPO_MOV IN (31) AND P_EMPRESA BETWEEN 5 AND 17 THEN
        DECLARE
          V_CONTADOR       NUMBER;
          V_DOC_MON        NUMBER;
          V_DOC_CLI_NOM    VARCHAR(800);
          V_DCON_EXEN_MON  NUMBER;
          V_DCON_OBS       VARCHAR(500);
          V_DOC_NRO_DOC    NUMBER;
          V_DOC_FEC_OPER   DATE;
          V_IMPORTE_LETRAS VARCHAR2(800);
          V_TEXTO          VARCHAR2(800);
          V_MON_DESC       VARCHAR2(800);
          V_MON_SIMBOLO    VARCHAR2(800);
          V_EMPR_DESC      VARCHAR2(800);
        BEGIN
          SELECT COUNT(1)
            INTO V_CONTADOR
            FROM GEN_EMPRESA A
           WHERE A.EMPR_LOGO IS NOT NULL
             AND A.EMPR_CODIGO = P_EMPRESA;
        
          IF V_CONTADOR > 0 THEN
            V_REPORT := 'FINI003GR';
          ELSE
            V_REPORT := 'FINI003GR_SI';
          END IF;
        
          SELECT A.DOC_MON,
                 A.DOC_NRO_DOC,
                 A.DOC_CLI_NOM,
                 B.DCON_EXEN_MON,
                 B.DCON_OBS,
                 A.DOC_FEC_OPER
            INTO V_DOC_MON,
                 V_DOC_NRO_DOC,
                 V_DOC_CLI_NOM,
                 V_DCON_EXEN_MON,
                 V_DCON_OBS,
                 V_DOC_FEC_OPER
            FROM FIN_DOCUMENTO A, FIN_DOC_CONCEPTO B
           WHERE A.DOC_CLAVE = B.DCON_CLAVE_DOC
             AND A.DOC_EMPR = B.DCON_EMPR
             AND B.DCON_CLAVE_DOC = P_DOC_CLAVE
             AND A.DOC_EMPR = P_EMPRESA;
        
          V_IMPORTE_LETRAS := GENERAL.FP_CONV_NRO_TXT(V_DCON_EXEN_MON,
                                                      V_DOC_MON);
        
          IF V_DOC_MON = 1 THEN
            V_TEXTO := 'La suma de guaranies:';
          ELSE
            V_TEXTO := 'La suma de dolares:';
          END IF;
        
          BEGIN
            SELECT A.EMPR_RAZON_SOCIAL
              INTO V_EMPR_DESC
              FROM GEN_EMPRESA A
             WHERE A.EMPR_CODIGO = P_EMPRESA;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20001, 'Empresa no valida!');
          END;
        
          BEGIN
            SELECT A.MON_DESC, A.MON_SIMBOLO
              INTO V_MON_DESC, V_MON_SIMBOLO
              FROM GEN_MONEDA A
             WHERE A.MON_EMPR = P_EMPRESA
               AND A.MON_CODIGO = V_DOC_MON;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20001, 'Empresa no valida!');
          END;
        
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                          URL_ENCODE(P_EMPRESA);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                          'P_IMPORTE_LETRAS=' ||
                          URL_ENCODE(V_IMPORTE_LETRAS);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_IMPORTE=' ||
                          URL_ENCODE(V_DCON_EXEN_MON);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_MONEDA=' ||
                          URL_ENCODE(V_MON_SIMBOLO);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                          'P_NRO_DOCUMENTO=' || URL_ENCODE(V_DOC_NRO_DOC);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_FECHA=' ||
                          URL_ENCODE(V_DOC_FEC_OPER);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                          'P_RAZON_SOCIAL=' || URL_ENCODE(V_DOC_CLI_NOM);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                          'P_MONEDA_COD=' || URL_ENCODE(V_DOC_MON);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_TEXTO=' ||
                          URL_ENCODE(V_TEXTO);
          V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                          'P_OBSERVACION=' || URL_ENCODE(V_DCON_OBS);
          /* V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
          'P_EMPRESA_DESC=' || URL_ENCODE(V_EMPR_DESC);*/
        
        END;
      
        ---/***************************FIN***************************/
      END IF;
    
    ELSE
      IF V_TIPO_MOV = 7 THEN
        --EN ESTE PUNTO, DEBE PREGUNTAR, SI SE ESTA QUERIENDO IMPRIMIR DESDE EL 8-2-5, QUE TIRA EN LA TEMPORAL O DESDE EL 2-3-5 O CUALQUIER PROGRAMA DE REIMPRESION
        --PORQUE CON EL UNION QUE SE LE AGREGO AL REPORTE PARA QUE TOME DE LA TEMPORAL O DEL REAL, PARA QUE PUEDA IMPRIMIR DESDE EL 8-2-5, ANULA LOS DETALLES REPETIDOS
        --13/08/2019
        SELECT COUNT(*)
          INTO V_CLAVE_AUT
          FROM FIN_DOCUMENTO D
         WHERE D.DOC_CLAVE = P_DOC_CLAVE
           AND D.DOC_EMPR = P_EMPRESA; --BUSCA LA CLAVE EN FIN_DOCUMENTO
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                        P_DOC_CLAVE;
        IF NVL(V_CLAVE_AUT, 0) = 0 THEN
          --ESTA IMPRIMIENDO DESDE EL 8-2-5
          V_REPORT := 'COMI001G_TEMP';
        ELSE
          V_REPORT := 'COMI001G';
        END IF;
      
      ELSIF V_TIPO_MOV IN (9, 10) then
        
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                        P_DOC_CLAVE;
        if p_empresa in (1,2) then  --> Hilagro Transagro              
          V_REPORT     := 'FACP008';
        else
          V_REPORT     := 'FACP008_PREIMPRESO';
        end if;
      ELSIF V_TIPO_MOV IN (16) THEN
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                        P_DOC_CLAVE;
        V_REPORT     := 'FACI036';
      ELSE
      
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DOC_CLAVE=' ||
                        P_DOC_CLAVE;
        V_REPORT     := 'FINI003_REC_AI';
      END IF;
    
    END IF;
    
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER();
    COMMIT;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, P_USUARIO, V_REPORT, 'pdf');
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;

  PROCEDURE PP_IMPRIMIR_REPORTE_TRANS(P_EMPRESA            IN NUMBER,
                                      P_TIPO_DE_MOVIMIENTO IN NUMBER,
                                      P_CLAVE              IN NUMBER,
                                      P_CLAVE_STK          IN NUMBER,
                                      P_SUCURSAL           IN NUMBER,
                                      P_DOC_NRO_DOC        IN NUMBER) IS
  
    V_PARAMETROS    VARCHAR2(600);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    I_REPORT        VARCHAR2(15);
    V_EMPR_DESC     VARCHAR2(30);
    V_DESC_SUCURSAL VARCHAR2(50);
    V_CLAVE         VARCHAR2(100);
    V_USER          VARCHAR2(8);
  BEGIN
    V_USER := GEN_DEVUELVE_USER;
    BEGIN
    
      SELECT DOC_CLAVE
        INTO V_CLAVE
        FROM FIN_DOCUMENTO
       WHERE DOC_NRO_DOC = P_DOC_NRO_DOC
         AND DOC_CLAVE = P_CLAVE
         AND DOC_TIPO_MOV = P_TIPO_DE_MOVIMIENTO
         AND DOC_EMPR = P_EMPRESA;
    END;
  
    BEGIN
      SELECT SUC_DESC
        INTO V_DESC_SUCURSAL
        FROM GEN_SUCURSAL
       WHERE SUC_CODIGO = P_SUCURSAL
         AND SUC_EMPR = P_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
    BEGIN
      SELECT A.EMPR_RAZON_SOCIAL
        INTO V_EMPR_DESC
        FROM GEN_EMPRESA A
       WHERE A.EMPR_CODIGO = P_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20016, 'Empresa no valida!');
    END;
  
    --SELECT TO_NUMBER( P_CLAVE,'9999999999999999D9999','NLS_NUMERIC_CHARACTERS='',.''') INTO V_CLAVE FROM DUAL;
  
    V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    APEX_UTIL.URL_ENCODE(P_EMPRESA);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESC_EMPR=' ||
                    APEX_UTIL.URL_ENCODE(V_EMPR_DESC);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESC_SUC=' ||
                    APEX_UTIL.URL_ENCODE(V_DESC_SUCURSAL);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESC_PROGRAMA=' ||
                    APEX_UTIL.URL_ENCODE(V_EMPR_DESC || ' - ' ||
                                         'COMPROBANTE');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_PROGRAMA=' ||
                    APEX_UTIL.URL_ENCODE('FINC201');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                    APEX_UTIL.URL_ENCODE(V_CLAVE);
  
    I_REPORT := 'finc201GR';
  
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
    COMMIT;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, 'finc201GR', 'pdf');
    COMMIT;
    /*EXCEPTION
    WHEN OTHERS THEN
      NULL;*/
  
  END PP_IMPRIMIR_REPORTE_TRANS;

  PROCEDURE PP_IMPRIMIR_REPORTE_STK_DOC(P_EMPRESA            IN NUMBER,
                                        P_TIPO_DE_MOVIMIENTO IN NUMBER,
                                        P_CLAVE_STK          IN NUMBER) IS
  
    V_PARAMETROS    VARCHAR2(600);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    I_REPORT        VARCHAR2(30);
  
  BEGIN
  
    IF P_TIPO_DE_MOVIMIENTO = 16 AND P_EMPRESA = 2 THEN
    
      V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                      URL_ENCODE(P_CLAVE_STK);
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                      URL_ENCODE(P_EMPRESA);
      I_REPORT     := 'faci208_autoimpresor_A';
    END IF;
  
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
    COMMIT;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, I_REPORT, 'pdf');
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END PP_IMPRIMIR_REPORTE_STK_DOC;

  FUNCTION CF_VENCIMIENTOFORMULA(I_DOC_CLAVE IN NUMBER,
                                 I_EMPRESA   IN NUMBER) RETURN CHAR IS
    V_CADENA VARCHAR2(200);
    CURSOR C IS
      SELECT TO_CHAR(CUO_FEC_VTO, 'DD') || '-' ||
             RTRIM(TO_CHAR(CUO_FEC_VTO,
                           'MONTH',
                           'nls_date_language=spanish')) || '-' ||
             TO_CHAR(CUO_FEC_VTO, 'YYYY') VTO
        FROM FIN_CUOTA
       WHERE CUO_CLAVE_DOC = I_DOC_CLAVE
         AND CUO_EMPR = I_EMPRESA
       ORDER BY CUO_FEC_VTO;
    ---------
    CURSOR T IS
      SELECT SUBSTR(TO_CHAR(CUO_FEC_VTO, 'DD') || '-' ||
                    RTRIM(TO_CHAR(CUO_FEC_VTO,
                                  'MONTH',
                                  'nls_date_language=spanish')) || '-' ||
                    TO_CHAR(CUO_FEC_VTO, 'YYYY'),
                    1,
                    30) VTO
        FROM FIN_CUOTA
       WHERE CUO_CLAVE_DOC = I_DOC_CLAVE
         AND CUO_EMPR = I_EMPRESA
         AND ROWNUM <= 2
       ORDER BY CUO_FEC_VTO;
  
    CURSOR R IS
      SELECT SUBSTR(TO_CHAR(CUO_FEC_VTO, 'DD') || '-' ||
                    RTRIM(TO_CHAR(CUO_FEC_VTO, 'MM')) || '-' ||
                    TO_CHAR(CUO_FEC_VTO, 'YYYY'),
                    1,
                    30) VTO
        FROM FIN_CUOTA
       WHERE CUO_CLAVE_DOC = I_DOC_CLAVE
         AND CUO_EMPR = I_EMPRESA
         AND ROWNUM <= 2
       ORDER BY CUO_FEC_VTO;
    V_CONTA NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO V_CONTA
      FROM FAC_DOCUMENTO_DET A
     WHERE A.DET_EMPR = I_EMPRESA
       AND A.DET_CLAVE_PED IS NOT NULL
       AND A.DET_CLAVE_DOC = I_DOC_CLAVE;
    IF V_CONTA > 0 THEN
      FOR V IN R LOOP
        V_CADENA := ';' || V_CADENA || V.VTO;
      END LOOP;
    ELSE
      IF I_EMPRESA <> 2 THEN
        FOR V IN C LOOP
          V_CADENA := ';' || V_CADENA || V.VTO;
        END LOOP;
      ELSE
        FOR V IN T LOOP
          V_CADENA := ';' || V_CADENA || V.VTO;
        END LOOP;
      END IF;
    END IF;
    RETURN SUBSTR(V_CADENA, 2);
  END;

  FUNCTION CCO_CCO_HILAGRO_CFFORMULA(I_CCO_HILAGRO_DESC IN VARCHAR2)
    RETURN CHAR IS
    V_RET VARCHAR2(100);
  BEGIN
  
    IF I_CCO_HILAGRO_DESC IS NOT NULL THEN
      V_RET := 'Suc. Hilagro: ' || I_CCO_HILAGRO_DESC;
    END IF;
  
    RETURN V_RET;
  
  END;

  PROCEDURE PP_IMPRIMIR_REPORTE_DOC(P_EMPRESA            IN NUMBER,
                                    P_TIPO_DE_MOVIMIENTO IN NUMBER,
                                    P_CLAVE              IN NUMBER,
                                    P_ALERTA             OUT VARCHAR2) IS
  
    V_PARAMETROS       VARCHAR2(600);
    V_IDENTIFICADOR    VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    I_REPORT           VARCHAR2(40);
    V_ES_TRANSPORTE    VARCHAR2(1);
    V_USER             VARCHAR2(8);
    V_TIPO_MOV         NUMBER;
    V_AFECTA_STOCK     VARCHAR2(8);
    P_DOC_CLAVE_LIQUID NUMBER; --Clave de la liquidacion.
  BEGIN
  
    BEGIN
      SELECT DISTINCT DOC_TIPO_MOV, AFECTA_STOCK
        INTO V_TIPO_MOV, V_AFECTA_STOCK
        FROM (SELECT DOC_TIPO_MOV,
                     DECODE(DOC_CLAVE_STK, NULL, 'NO', 'SI') AFECTA_STOCK
                FROM FIN_DOCUMENTO D
               WHERE D.DOC_CLAVE = P_CLAVE
                 AND DOC_EMPR = P_EMPRESA
              UNION ALL
              SELECT DOC_TIPO_MOV,
                     DECODE(DOC_CLAVE_STK, NULL, 'NO', 'SI') AFECTA_STOCK
                FROM FIN_DOCUMENTO_COMI015_TEMP D
               WHERE D.DOC_CLAVE = P_CLAVE
                 AND DOC_EMPR = P_EMPRESA
              UNION ALL
              SELECT DOC_TIPO_MOV,
                     DECODE(DOC_CLAVE_STK, NULL, 'NO', 'SI') AFECTA_STOCK
                FROM FIN_DOCUMENTO_TMP D
               WHERE D.DOC_CLAVE = P_CLAVE
                 AND DOC_EMPR = P_EMPRESA);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
      
    END;
  
    V_USER   := GEN_DEVUELVE_USER;
    P_ALERTA := 'N';
  
    --Recupera los datos de la liqui en el caso que lo tenga. 26/05/2021
    SELECT F.DOC_CLAVE_LIQUID
      INTO P_DOC_CLAVE_LIQUID
      FROM FIN_DOCUMENTO F
     WHERE F.DOC_EMPR = P_EMPRESA
       AND F.DOC_CLAVE = P_CLAVE
       AND ROWNUM = 1;
  
    --  raise_application_error(-20001, P_DOC_CLAVE_LIQUID);
  
    --99  RAISE_APPLICATION_ERROR(-20001,P_CLAVE);
    --IF P_CLAVE IS NOT NULL THEN
    IF P_TIPO_DE_MOVIMIENTO = 16 AND P_EMPRESA = 2 AND
       V_AFECTA_STOCK = 'NO' THEN
      P_ALERTA := 'S';
      I_REPORT := 'faci208_autoimpresorB_SS';
    ELSIF P_TIPO_DE_MOVIMIENTO = 16 AND P_EMPRESA = 2 AND
          V_AFECTA_STOCK = 'SI' THEN
      P_ALERTA := 'S';
      I_REPORT := 'faci208_autoimpresorB';
    ELSIF P_TIPO_DE_MOVIMIENTO IN (9, 10) AND P_EMPRESA = 2 THEN
      P_ALERTA := 'S';
      BEGIN
        SELECT DISTINCT 'S'
          INTO V_ES_TRANSPORTE
          FROM TRA_OCARGA_PROD A
         WHERE A.OCP_CLAVE_COBRO = P_CLAVE
           AND A.OCP_EMPR = P_EMPRESA;
      
        IF P_EMPRESA = 2 THEN
          P_ALERTA := 'S';
          I_REPORT := 'trai206_autoimpresor';
        
        END IF;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          P_ALERTA := 'S';
          /*if v_user in ('ARIELB','ADCS') then
          I_REPORT := 'faci235_autoimpresor_b';
          else*/
          I_REPORT := 'faci235_autoimpresor';
          -- end if;
      END;
    
    ELSIF P_TIPO_DE_MOVIMIENTO IN (6) AND P_EMPRESA = 2 THEN
      P_ALERTA := 'S';
      I_REPORT := 'FINI237_AUTOIMPRESOR';
    ELSIF P_TIPO_DE_MOVIMIENTO IN (7) AND P_EMPRESA = 2 THEN
      P_ALERTA := 'S';
      I_REPORT := 'AUTOFACTURA_AUTOIMPRESOR';
    ELSIF P_TIPO_DE_MOVIMIENTO IN (15) AND P_EMPRESA = 2 THEN
      P_ALERTA := 'S';
      I_REPORT := 'NotaDB_autoimpresor';
    ELSIF P_TIPO_DE_MOVIMIENTO IN (33) AND P_EMPRESA = 2 THEN
      P_ALERTA := 'S';
      I_REPORT := 'FINI234_RE_CAAN';
    ELSIF P_TIPO_DE_MOVIMIENTO IN (26, 31) THEN
      I_REPORT := 'FINI201_REC';
    END IF;
  
    DECLARE
      V_CONTA NUMBER;
    BEGIN
      SELECT COUNT(1)
        INTO V_CONTA
        FROM FAC_DOCUMENTO_DET A
       WHERE A.DET_EMPR = P_EMPRESA
         AND A.DET_CLAVE_PED IS NOT NULL
         AND A.DET_CLAVE_DOC = P_CLAVE;
    
      IF V_CONTA > 0 THEN
        I_REPORT := 'faci235_autoimpresor_insum';
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    --  END IF;
  
    V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                    APEX_UTIL.URL_ENCODE(P_CLAVE);
    IF P_TIPO_DE_MOVIMIENTO IN (26, 31) THEN
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                      'P_EMPR_RAZON_SOCIAL=' ||
                      APEX_UTIL.URL_ENCODE(V('P194_DOCU_PROV_NOM'));
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_scta_nombre=' ||
                      APEX_UTIL.URL_ENCODE(V('P194_DOCU_PROV_NOM'));
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_MONTO=' ||
                      APEX_UTIL.URL_ENCODE(V('P194_S_TOT_MON'));
    
      V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'p_localidad=' ||
                      APEX_UTIL.URL_ENCODE(V('P194_LOCALIDAD'));
    END IF;
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                    'P_DOC_CLAVE_LIQUID=' ||
                    APEX_UTIL.URL_ENCODE(P_DOC_CLAVE_LIQUID);
  
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    APEX_UTIL.URL_ENCODE(P_EMPRESA);
    --raise_application_error(-20001,I_REPORT);
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
    COMMIT;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, I_REPORT, 'pdf');
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END PP_IMPRIMIR_REPORTE_DOC;

END FINC001;
/
