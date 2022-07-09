CREATE OR REPLACE PACKAGE FINC015 AS

  FUNCTION FP_BUSCAR_COTIZACION(P_FECHA   IN DATE,
                                P_MONEDA  IN INTEGER,
                                P_EMPRESA IN NUMBER) RETURN NUMBER;

  PROCEDURE PP_CARGA_CONSULTA_CUO(P_EMPRESA              IN NUMBER,
                                  P_MON                  IN NUMBER,
                                  P_PROV                 IN NUMBER,
                                  P_FEC_VTO              IN date,
                                  P_OPCI_SALDO           IN VARCHAR2,
                                  P_ORDEN                IN VARCHAR2,
                                  P_IMP_TOTAL_CUOTA      OUT VARCHAR2,
                                  P_IMP_TOTAL_PAGO       OUT VARCHAR2,
                                  P_IMP_TOTAL_SALDO_PROV OUT VARCHAR2,
                                  P_SESSION_ID           IN NUMBER,
                                  P_LOGIN                IN VARCHAR2,
                                  in_desde               in date := null
                                  );

  FUNCTION FP_IDENTIFICAR_PRIMER_PAGO(P_CLAVE_PAGO IN NUMBER,
                                      P_CLAVE_DOC  IN NUMBER,
                                      P_EMPRESA    IN NUMBER,
                                      p_FEC_VTO    IN DATE,
                                      P_FEC_PAGO   IN DATE) RETURN VARCHAR2;

  PROCEDURE PP_LLAMAR_REPORT(P_EMPRESA           IN NUMBER,
                             P_MON               IN NUMBER,
                             P_PROV              IN NUMBER,
                             P_FEC_VTO           IN DATE,
                             P_OPCI_SALDO        IN VARCHAR2,
                             P_OBS               IN VARCHAR2,
                             P_ORDEN             IN VARCHAR2,
                             P_SUCURSAL          IN NUMBER,
                             P_DESC_SUCURSAL     IN VARCHAR2,
                             P_PROV_RAZON_SOCIAL IN VARCHAR2,
                             P_DESC_MONEDA       IN VARCHAR2,
                             P_TELEFONO          IN VARCHAR2,
                             P_CONTACTO          IN VARCHAR2,
                             P_SALDO             IN VARCHAR2,
                             P_USUARIO           IN VARCHAR2,
                             P_SESSION           IN NUMBER,
                             P_NOMBRE_REP        OUT VARCHAR2,
                             P_PARAMETROS        OUT VARCHAR2);
  PROCEDURE PP_LLAMAR_excel(P_EMPRESA           IN NUMBER,
                            P_MON               IN NUMBER,
                            P_PROV              IN NUMBER,
                            P_FEC_VTO           IN DATE,
                            P_OPCI_SALDO        IN VARCHAR2,
                            P_ORDEN             IN VARCHAR2,
                            P_SUCURSAL          IN NUMBER,
                            P_DESC_SUCURSAL     IN VARCHAR2,
                            P_PROV_RAZON_SOCIAL IN VARCHAR2,
                            P_DESC_MONEDA       IN VARCHAR2,
                            P_TELEFONO          IN VARCHAR2,
                            P_CONTACTO          IN VARCHAR2,
                            P_SALDO             IN VARCHAR2,
                            P_USUARIO           IN VARCHAR2,
                            P_SESSION           IN NUMBER,
                            P_NOMBRE_REP        OUT VARCHAR2,
                            P_PARAMETROS        OUT VARCHAR2);
END;
/
CREATE OR REPLACE PACKAGE BODY FINC015 AS

  FUNCTION FP_BUSCAR_COTIZACION(P_FECHA   IN DATE,
                                P_MONEDA  IN INTEGER,
                                P_EMPRESA IN NUMBER) RETURN NUMBER IS
    TASA NUMBER;
  BEGIN
    SELECT COT_TASA
      INTO TASA
      FROM STK_COTIZACION
     WHERE COT_FEC = P_FECHA
       AND COT_MON = P_MONEDA
       AND COT_EMPR = P_EMPRESA;
  
    RETURN TASA;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --PL_EXHIBIR_ERROR('Cotizacion inexistente para la fecha:'
      --       ||TO_CHAR(FECHA,'DD-MM-YYYY')
      --       ||', Moneda:'||TO_CHAR(MONEDA)||'!');
      RETURN 0;
    
  END FP_BUSCAR_COTIZACION;

  FUNCTION FP_IDENTIFICAR_PRIMER_PAGO(P_CLAVE_PAGO IN NUMBER,
                                      P_CLAVE_DOC  IN NUMBER,
                                      P_EMPRESA    IN NUMBER,
                                      P_FEC_VTO    IN DATE,
                                      P_FEC_PAGO   IN DATE) RETURN VARCHAR2 IS
    V_CLAVE_PAGO          NUMBER;
    V_IND_SALDO           VARCHAR2(1);
    V_PAG_FEC_PRIMER_PAGO DATE;
  BEGIN
    SELECT MIN(PAG_CLAVE_PAGO)
      INTO V_CLAVE_PAGO
      FROM FIN_PAGO
     WHERE PAG_EMPR = P_EMPRESA
       AND PAG_CLAVE_DOC = P_CLAVE_DOC
       AND PAG_FEC_VTO = P_FEC_VTO;
  
    SELECT MIN(B.PAG_FEC_PAGO)
      INTO V_PAG_FEC_PRIMER_PAGO
      FROM FIN_PAGO B, FIN_CUOTA C
     WHERE B.PAG_CLAVE_DOC = P_CLAVE_DOC
       AND PAG_EMPR = P_EMPRESA
       AND C.CUO_FEC_VTO = P_FEC_VTO
       AND B.PAG_FEC_VTO = C.CUO_FEC_VTO
       AND B.PAG_CLAVE_DOC = C.CUO_CLAVE_DOC
       AND B.PAG_EMPR = C.CUO_EMPR;
  
    IF P_CLAVE_PAGO = V_CLAVE_PAGO AND P_FEC_PAGO = V_PAG_FEC_PRIMER_PAGO THEN
      V_IND_SALDO := 'S';
    ELSE
      V_IND_SALDO := 'N';
    END IF;
  
    RETURN V_IND_SALDO;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_IND_SALDO := 'S';
    
  END FP_IDENTIFICAR_PRIMER_PAGO;

  PROCEDURE PP_CARGA_CONSULTA_CUO(P_EMPRESA              IN NUMBER,
                                  P_MON                  IN NUMBER,
                                  P_PROV                 IN NUMBER,
                                  P_FEC_VTO              IN DATE,
                                  P_OPCI_SALDO           IN VARCHAR2,
                                  P_ORDEN                IN VARCHAR2,
                                  P_IMP_TOTAL_CUOTA      OUT VARCHAR2,
                                  P_IMP_TOTAL_PAGO       OUT VARCHAR2,
                                  P_IMP_TOTAL_SALDO_PROV OUT VARCHAR2,
                                  P_SESSION_ID           IN NUMBER,
                                  P_LOGIN                IN VARCHAR2,
                                  in_desde               in date := null
                                  ) IS
  
    TYPE CURTYP IS REF CURSOR;
    C_FINC015           CURTYP;
    V_CONSULTA          VARCHAR2(25000);
    P_CONF_ADELANTO_PRO NUMBER;
  
    TYPE CUR_TYPE IS RECORD(
      DOC_NRO_DOC       NUMBER(13),
      DOC_CLAVE         NUMBER(14),
      DOC_CLAVE_FIN_TA  NUMBER(14),
      TOT_COMPROB       NUMBER,
      CUO_IMP_MON       NUMBER(20, 4),
      DOC_FEC_DOC       DATE,
      CUO_FEC_VTO       DATE,
      PAG_FEC_PAGO      DATE,
      A                 number,
      B                 number,
      PAG_IMP_MON       NUMBER(20, 4),
      CUO_SALDO_MON     NUMBER(20, 4),
      TMOV_IND_DBCR_CTA VARCHAR2(1),
      TMOV_ABREV        VARCHAR2(5),
      NRO_PAG           varchar2(20),
      DOC_OBS           VARCHAR2(100));
  
    C CUR_TYPE;
  
    V_CLAVE NUMBER := 0;
    V_VTO   DATE := '01/01/1900';
  
  BEGIN
  
    CASE
      WHEN P_PROV IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'Ingrese el Proveedor!');
      WHEN P_MON IS NULL THEN
      
        RAISE_APPLICATION_ERROR(-20004, 'Ingrese la Moneda!');
      WHEN P_ORDEN IS NULL THEN
        RAISE_APPLICATION_ERROR(-20005, 'Elija un tipo de Orden!');
      ELSE
        NULL;
    END CASE;
  
    SELECT CONF_ADELANTO_PRO
      INTO P_CONF_ADELANTO_PRO
      FROM FIN_CONFIGURACION
     WHERE CONF_EMPR = P_EMPRESA;
  
    --   IF P_ORDEN = 'D' THEN
    V_CONSULTA := ' SELECT DO.DOC_NRO_DOC,
       DO.DOC_CLAVE,
       DO.DOC_CLAVE_FIN_TA,
       CASE
         WHEN TMOV_IND_DBCR_CTA = ''D'' THEN
          (DO.DOC_NETO_EXEN_MON + DO.DOC_NETO_GRAV_MON + DO.DOC_IVA_MON)
         ELSE
          (DO.DOC_NETO_EXEN_MON + DO.DOC_NETO_GRAV_MON + DO.DOC_IVA_MON) * (-1)
       END TOT_COMPROB,
       CASE
         WHEN TMOV_IND_DBCR_CTA = ''D'' THEN
          CUO_IMP_MON
         ELSE
          CUO_IMP_MON * (-1)
       END,
       DO.DOC_FEC_DOC,
       CUO_FEC_VTO,
       PAG_FEC_PAGO,
       NULL,
       NULL,
       CASE
         WHEN TMOV_IND_DBCR_CTA = ''D'' THEN
          PAG_IMP_MON * (-1)
         ELSE
          PAG_IMP_MON
       END,
       CASE
         WHEN TMOV_IND_DBCR_CTA = ''D'' THEN
           CUO_SALDO_MON
         ELSE
           CUO_SALDO_MON * (-1)
       END,
       TMOV_IND_DBCR_CTA,
       TMOV_ABREV,
       DP.DOC_NRO_DOC NRO_PAG,
       SUBSTR(
                      nvl(
                         do.doc_obs, (SELECT WM_CONCAT(DISTINCT T.DCON_OBS) 
                                      FROM FIN_DOC_CONCEPTO T
                                     WHERE T.DCON_CLAVE_DOC = DO.DOC_CLAVE
                                       AND T.DCON_EMPR = DO.DOC_EMPR)
                          )
              ,1,100) doc_obs
     FROM GEN_TIPO_MOV,
       FIN_DOCUMENTO DO,
       FIN_DOCUMENTO DP,
       
       FIN_UNION_CUOTA,
       FIN_UNION_PAGO
       
 WHERE TMOV_EMPR = ' || P_EMPRESA || '
   AND TMOV_EMPR = DO.DOC_EMPR
   and ( '''||in_desde||''' is null or DO.DOC_FEC_DOC >= to_date('''||in_desde||''', ''dd/mm/yyyy'') )
   AND (DO.DOC_EMPR = CUO_EMPR)
   AND DP.DOC_EMPR(+) = PAG_EMPR
   AND TMOV_CODIGO = DO.DOC_TIPO_MOV
   AND (CUO_FEC_VTO = PAG_FEC_VTO(+) AND CUO_CLAVE_DOC = PAG_CLAVE_DOC(+) AND CUO_EMPR = PAG_EMPR (+))
   AND (DO.DOC_CLAVE = CUO_CLAVE_DOC)
   AND DP.DOC_CLAVE(+) = PAG_CLAVE_PAGO 
   and do.doc_clave != 129379300101
    AND DO.DOC_PROV = ' || P_PROV || '
   AND DO.DOC_MON = ' || P_MON || '
   AND (TMOV_IND_AFECTA_SALDO = ''P'' -- C=CLIENTE, P=PROVEEDOR, N=NO
       OR DO.DOC_TIPO_MOV IN (' || P_CONF_ADELANTO_PRO ||
                  ', 81))
   AND (CUO_FEC_VTO <= ''' || P_FEC_VTO || ''' OR ''' ||
                  P_FEC_VTO || ''' IS NULL)
                    
   AND ((CUO_SALDO_MON  <> 0 AND ''' || P_OPCI_SALDO ||
                  ''' = ''N'') OR
       ''' || P_OPCI_SALDO || ''' = ''S'')
 ORDER BY DO.DOC_FEC_DOC,
          DO.DOC_CLAVE,
          TMOV_ABREV,
          DO.DOC_NRO_DOC,
          DO.DOC_FEC_DOC,
          CUO_FEC_VTO,
          PAG_FEC_PAGO';
  
 delete from x where otro='prueba';
 
     INSERT INTO X (CAMPO1, otro) VALUES (V_CONSULTA, 'prueba');
    COMMIT;
  
    DELETE FIN_FINC015_TEMP_2
     WHERE SESSION_ID = P_SESSION_ID
       AND USUARIO = P_LOGIN;
    COMMIT;
  
    OPEN C_FINC015 FOR V_CONSULTA;
  
    LOOP
      FETCH C_FINC015
        INTO C;
    
      EXIT WHEN C_FINC015%NOTFOUND;
    
      IF V_CLAVE <> C.DOC_CLAVE THEN
        V_CLAVE := C.DOC_CLAVE;
        V_VTO   := C.CUO_FEC_VTO;
        INSERT INTO FIN_FINC015_TEMP_2
          (DOC_NRO_DOC,
           DOC_CLAVE,
           DOC_CLAVE_FIN_TA,
           TOT_COMPROB,
           CUO_IMP_MON,
           DOC_FEC_DOC,
           CUO_FEC_VTO,
           PAG_FEC_PAGO,
           PAG_IMP_MON,
           CUO_SALDO_MON,
           TMOV_IND_DBCR_CTA,
           TMOV_ABREV,
           NRO_PAG,
           DOC_OBS,
           SESSION_ID,
           EMPR,
           USUARIO)
        VALUES
          (C.DOC_NRO_DOC,
           C.DOC_CLAVE,
           C.DOC_CLAVE_FIN_TA,
           C.TOT_COMPROB,
           C.CUO_IMP_MON,
           C.DOC_FEC_DOC,
           C.CUO_FEC_VTO,
           C.PAG_FEC_PAGO,
           C.PAG_IMP_MON,
           C.CUO_SALDO_MON,
           C.TMOV_IND_DBCR_CTA,
           C.TMOV_ABREV,
           C.NRO_PAG,
           C.DOC_OBS,
           P_SESSION_ID,
           P_EMPRESA,
           P_LOGIN);
      ELSE
        IF V_VTO <> C.CUO_FEC_VTO THEN
          V_VTO := C.CUO_FEC_VTO;
          INSERT INTO FIN_FINC015_TEMP_2
            (DOC_NRO_DOC,
             DOC_CLAVE,
             DOC_CLAVE_FIN_TA,
             TOT_COMPROB,
             CUO_IMP_MON,
             DOC_FEC_DOC,
             CUO_FEC_VTO,
             PAG_FEC_PAGO,
             PAG_IMP_MON,
             CUO_SALDO_MON,
             TMOV_IND_DBCR_CTA,
             TMOV_ABREV,
             NRO_PAG,
             DOC_OBS,
             SESSION_ID,
             EMPR,
             USUARIO)
          VALUES
            (NULL,
             NULL,
             NULL,
             NULL,
             C.CUO_IMP_MON,
             NULL,
             C.CUO_FEC_VTO,
             C.PAG_FEC_PAGO,
             C.PAG_IMP_MON,
             C.CUO_SALDO_MON,
             NULL,
             NULL,
             C.NRO_PAG,
             NULL,
             P_SESSION_ID,
             P_EMPRESA,
             P_LOGIN);
        ELSE
          INSERT INTO FIN_FINC015_TEMP_2
            (DOC_NRO_DOC,
             DOC_CLAVE,
             DOC_CLAVE_FIN_TA,
             TOT_COMPROB,
             CUO_IMP_MON,
             DOC_FEC_DOC,
             CUO_FEC_VTO,
             PAG_FEC_PAGO,
             PAG_IMP_MON,
             CUO_SALDO_MON,
             TMOV_IND_DBCR_CTA,
             TMOV_ABREV,
             NRO_PAG,
             DOC_OBS,
             SESSION_ID,
             EMPR,
             USUARIO)
          VALUES
            (NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             C.PAG_FEC_PAGO,
             C.PAG_IMP_MON,
             NULL,
             NULL,
             NULL,
             C.NRO_PAG,
             NULL,
             P_SESSION_ID,
             P_EMPRESA,
             P_LOGIN);
        END IF;
      END IF;
    END LOOP;
  
    COMMIT;
  
    --EL SALDO ACTUAL DEL PROVEEDOR
    BEGIN
    
      SELECT REPLACE(TO_CHAR((PREM_SALDO_ACT_MON - SUM(DOC_SALDO_MON)),
                             '999G999G999G999G999D00'),
                     ' ',
                     NULL)
        INTO P_IMP_TOTAL_SALDO_PROV
        FROM FIN_DOCUMENTO D, FIN_PROV_EMPRESA P
       WHERE DOC_EMPR = P_EMPRESA
         AND DOC_PROV = P_PROV
         AND DOC_MON = P_MON
         AND DOC_PROV = P.PREM_PROV
         AND DOC_EMPR = P.PREM_EMPR
         AND PREM_MON = DOC_MON
         and doc_clave != 129379300101
         AND DOC_TIPO_MOV = P_CONF_ADELANTO_PRO
       GROUP BY PREM_SALDO_ACT_MON;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        P_IMP_TOTAL_SALDO_PROV := 0;
    END;
  
    BEGIN
    
      SELECT REPLACE(TO_CHAR(SUM(CUO_IMP_MON), '999G999G999G999G999D00'),
                     ' ',
                     NULL),
             REPLACE(TO_CHAR(SUM(PAG_IMP_MON), '999G999G999G999G999D00'),
                     ' ',
                     NULL)
        INTO P_IMP_TOTAL_CUOTA, P_IMP_TOTAL_PAGO
        FROM (SELECT CASE
                       WHEN TMOV_IND_DBCR_CTA = 'D' THEN
                        (DO.DOC_NETO_EXEN_MON + DO.DOC_NETO_GRAV_MON +
                        DO.DOC_IVA_MON)
                       ELSE
                        (DO.DOC_NETO_EXEN_MON + DO.DOC_NETO_GRAV_MON +
                        DO.DOC_IVA_MON) * (-1)
                     END TOT_COMPROB,
                     CASE
                       WHEN TMOV_IND_DBCR_CTA = 'D' THEN
                        CASE
                          WHEN PAG_CLAVE_PAGO IS NOT NULL THEN
                           CASE
                             WHEN FINC015.FP_IDENTIFICAR_PRIMER_PAGO(PAG_CLAVE_PAGO,
                                                                     PAG_CLAVE_DOC,
                                                                     DO.DOC_EMPR,
                                                                     CUO_FEC_VTO,
                                                                     PAG_FEC_PAGO) = 'S' THEN
                              CUO_IMP_MON
                             ELSE
                              0
                           END
                          ELSE
                           CUO_IMP_MON
                        END
                     
                       ELSE
                        CUO_IMP_MON * (-1)
                     END CUO_IMP_MON,
                     
                     CASE
                       WHEN TMOV_IND_DBCR_CTA = 'D' THEN
                        PAG_IMP_MON * (-1)
                       ELSE
                        PAG_IMP_MON
                     END PAG_IMP_MON,
                     CASE
                       WHEN TMOV_IND_DBCR_CTA = 'D' THEN
                        CUO_SALDO_MON
                       ELSE
                        CUO_SALDO_MON * (-1)
                     END CUO_SALDO_MON
                FROM GEN_TIPO_MOV,
                     FIN_DOCUMENTO DO,
                     FIN_DOCUMENTO DP,
                     FIN_CUOTA,
                     FIN_PAGO
               WHERE TMOV_EMPR = P_EMPRESA
                 AND TMOV_EMPR = DO.DOC_EMPR
                 AND (DO.DOC_EMPR = CUO_EMPR)
                 AND DP.DOC_EMPR(+) = PAG_EMPR
                 AND TMOV_CODIGO = DO.DOC_TIPO_MOV
                 AND (CUO_FEC_VTO = PAG_FEC_VTO(+) AND
                     CUO_CLAVE_DOC = PAG_CLAVE_DOC(+) AND
                     CUO_EMPR = PAG_EMPR(+))
                 AND (DO.DOC_CLAVE = CUO_CLAVE_DOC)
                 AND DP.DOC_CLAVE(+) = PAG_CLAVE_PAGO
                 and do.doc_clave != 129379300101 --Esta factura ya se habia pago por una transferencia bancaria, por eso no debe aparecer en el extracto. 10/01/2020
                 AND DO.DOC_PROV = P_PROV
                 AND DO.DOC_MON = P_MON
                 AND (TMOV_IND_AFECTA_SALDO = 'P' -- C=CLIENTE, P=PROVEEDOR, N=NO
                     OR DO.DOC_TIPO_MOV IN (P_CONF_ADELANTO_PRO, 81))
                 AND (CUO_FEC_VTO <= P_FEC_VTO OR P_FEC_VTO IS NULL)
                    
                 AND ((DO.DOC_SALDO_MON <> 0 AND P_OPCI_SALDO = 'N') OR
                     P_OPCI_SALDO = 'S'));
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      
        P_IMP_TOTAL_CUOTA := 0;
        P_IMP_TOTAL_PAGO  := 0;
    END;
  
  END PP_CARGA_CONSULTA_CUO;

  PROCEDURE PP_LLAMAR_REPORT(P_EMPRESA           IN NUMBER,
                             P_MON               IN NUMBER,
                             P_PROV              IN NUMBER,
                             P_FEC_VTO           IN DATE,
                             P_OPCI_SALDO        IN VARCHAR2,
                             P_OBS               IN VARCHAR2,
                             P_ORDEN             IN VARCHAR2,
                             P_SUCURSAL          IN NUMBER,
                             P_DESC_SUCURSAL     IN VARCHAR2,
                             P_PROV_RAZON_SOCIAL IN VARCHAR2,
                             P_DESC_MONEDA       IN VARCHAR2,
                             P_TELEFONO          IN VARCHAR2,
                             P_CONTACTO          IN VARCHAR2,
                             P_SALDO             IN VARCHAR2,
                             P_USUARIO           IN VARCHAR2,
                             P_SESSION           IN NUMBER,
                             P_NOMBRE_REP        OUT VARCHAR2,
                             P_PARAMETROS        OUT VARCHAR2) IS
  
    V_PARAMETROS        VARCHAR2(4000);
    P_CONF_ADELANTO_PRO NUMBER;
    V_EMPR_DESC         VARCHAR2(250);
    V_SUC_DESC          VARCHAR2(250);
    v_where             varchar2(1000);
    P_ORDEN_CONSULTA    varchar2(500);
  BEGIN
  
    SELECT A.EMPR_RAZON_SOCIAL, B.SUC_DESC
      INTO V_EMPR_DESC, V_SUC_DESC
      FROM GEN_EMPRESA A, GEN_SUCURSAL B
     WHERE A.EMPR_CODIGO = B.SUC_EMPR
       AND A.EMPR_CODIGO = P_EMPRESA
       AND B.SUC_CODIGO = P_SUCURSAL;
  
    CASE
      WHEN P_PROV IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'Ingrese el Proveedor!');
      WHEN P_MON IS NULL THEN
      
        RAISE_APPLICATION_ERROR(-20004, 'Ingrese la Moneda!');
      WHEN P_ORDEN IS NULL THEN
        RAISE_APPLICATION_ERROR(-20005, 'Elija un tipo de Orden!');
      ELSE
        NULL;
    END CASE;
  
    IF P_OPCI_SALDO = 'N' THEN
      V_PARAMETROS := V_PARAMETROS || '&p_ind_saldo=' || (P_OPCI_SALDO);
    
      --V_WHERE := V_WHERE || ' AND A.DOC_SALDO_MON <> 0';
    
    END IF;
  
    IF P_ORDEN = 'D' THEN
      P_ORDEN_CONSULTA := ' TMOV_ABREV ,A.DOC_NRO_DOC ,A.DOC_FEC_DOC,CUO_FEC_VTO,PAG_FEC_PAGO';
    ELSE
      P_ORDEN_CONSULTA := ' CUO_FEC_VTO,TMOV_ABREV,A.DOC_NRO_DOC,A.DOC_FEC_DOC,PAG_FEC_PAGO';
    END IF;
  
    SELECT CONF_ADELANTO_PRO
      INTO P_CONF_ADELANTO_PRO
      FROM FIN_CONFIGURACION
     WHERE CONF_EMPR = P_EMPRESA;
--  RAISE_APPLICATION_ERROR(-20001,P_OBS);
    -- concatenar los parametros para llamar el reporte en jasper 
    V_PARAMETROS := 'P_FORMATO=' || url_encode('pdf');
    V_PARAMETROS := V_PARAMETROS || '&P_EMPRESA=' || (P_EMPRESA);
    V_PARAMETROS := V_PARAMETROS || '&P_DESC_EMPRESA=' ||
                    url_encode(V_EMPR_DESC);
    V_PARAMETROS := V_PARAMETROS || '&P_PROV=' || url_encode(P_PROV);
    V_PARAMETROS := V_PARAMETROS || '&P_MON=' || url_encode(P_MON);
    V_PARAMETROS := V_PARAMETROS || '&P_CONF_ADELANTO_PRO=' ||
                    url_encode(P_CONF_ADELANTO_PRO);
    V_PARAMETROS := V_PARAMETROS || '&P_DESC_SUCURSAL=' ||
                    url_encode(V_SUC_DESC);
    V_PARAMETROS := V_PARAMETROS || '&P_PROGRAMA=' || url_encode('FINC015');
    V_PARAMETROS := V_PARAMETROS || '&P_DESC_PROGRAMA=' ||
                    url_encode('EXTRACTO DE CUENTA DE PROVEEDORES');
    V_PARAMETROS := V_PARAMETROS || '&P_PROV_RAZON_SOCIAL=' ||
                    url_encode(P_PROV_RAZON_SOCIAL);
    V_PARAMETROS := V_PARAMETROS || '&P_COD_MONEDA=' || url_encode(P_MON);
    V_PARAMETROS := V_PARAMETROS || '&P_DESC_MONEDA=' ||
                    url_encode(P_DESC_MONEDA);
    V_PARAMETROS := V_PARAMETROS || '&P_IND_SALDO_CERO=' ||
                    url_encode(P_OPCI_SALDO);
    V_PARAMETROS := V_PARAMETROS || '&P_IND_OBS=' ||
                    url_encode(P_OBS);                    
                    
    V_PARAMETROS := V_PARAMETROS || '&P_ORDEN=' || url_encode(P_ORDEN);
    V_PARAMETROS := V_PARAMETROS || '&P_ORDEN_CONSULTA=' ||
                    url_encode(P_ORDEN_CONSULTA);
    V_PARAMETROS := V_PARAMETROS || '&P_TELEFONO=' ||
                    url_encode(P_TELEFONO);
    V_PARAMETROS := V_PARAMETROS || '&P_CONTACTO=' ||
                    url_encode(P_CONTACTO);
    V_PARAMETROS := V_PARAMETROS || '&P_SALDO=' || url_encode(P_SALDO);
    V_PARAMETROS := V_PARAMETROS || '&P_FEC_VENCIMIENTO=' ||
                    url_encode(TO_DATE(P_FEC_VTO, 'DD/MM/YYYY'));
    V_PARAMETROS := V_PARAMETROS || '&P_LOGIN=' || url_encode(P_USUARIO);
    V_PARAMETROS := V_PARAMETROS || '&P_WHERE=' || url_encode(V_WHERE);
    V_PARAMETROS := V_PARAMETROS || '&P_SESSION=' || url_encode(P_SESSION);
  
    P_PARAMETROS := V_PARAMETROS;
    P_NOMBRE_REP := 'FINC015';
    /* SE CARGARAN LAS VARIABLES EN ESTA TABLA AUXILIAR PARA QUE LA PAGINA DE REPORTES PUEDA SER DINAMICA
    Y ASI SE PUEDA REUTILIZAR
     */
  
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = P_USUARIO;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE)
    VALUES
      (P_PARAMETROS, P_USUARIO, 'finc005');
    COMMIT;
  
  END PP_LLAMAR_REPORT;

  PROCEDURE PP_LLAMAR_excel(P_EMPRESA           IN NUMBER,
                            P_MON               IN NUMBER,
                            P_PROV              IN NUMBER,
                            P_FEC_VTO           IN DATE,
                            P_OPCI_SALDO        IN VARCHAR2,
                            P_ORDEN             IN VARCHAR2,
                            P_SUCURSAL          IN NUMBER,
                            P_DESC_SUCURSAL     IN VARCHAR2,
                            P_PROV_RAZON_SOCIAL IN VARCHAR2,
                            P_DESC_MONEDA       IN VARCHAR2,
                            P_TELEFONO          IN VARCHAR2,
                            P_CONTACTO          IN VARCHAR2,
                            P_SALDO             IN VARCHAR2,
                            P_USUARIO           IN VARCHAR2,
                            P_SESSION           IN NUMBER,
                            P_NOMBRE_REP        OUT VARCHAR2,
                            P_PARAMETROS        OUT VARCHAR2) IS
  
    V_PARAMETROS        VARCHAR2(4000);
    P_CONF_ADELANTO_PRO NUMBER;
    V_EMPR_DESC         VARCHAR2(250);
    V_SUC_DESC          VARCHAR2(250);
    v_where             varchar2(1000);
    P_ORDEN_CONSULTA    varchar2(500);
  BEGIN
  
    SELECT A.EMPR_RAZON_SOCIAL, B.SUC_DESC
      INTO V_EMPR_DESC, V_SUC_DESC
      FROM GEN_EMPRESA A, GEN_SUCURSAL B
     WHERE A.EMPR_CODIGO = B.SUC_EMPR
       AND A.EMPR_CODIGO = P_EMPRESA
       AND B.SUC_CODIGO = P_SUCURSAL;
  
    CASE
      WHEN P_PROV IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'Ingrese el Proveedor!');
      WHEN P_MON IS NULL THEN
      
        RAISE_APPLICATION_ERROR(-20004, 'Ingrese la Moneda!');
      WHEN P_ORDEN IS NULL THEN
        RAISE_APPLICATION_ERROR(-20005, 'Elija un tipo de Orden!');
      ELSE
        NULL;
    END CASE;
  
    IF P_OPCI_SALDO = 'N' THEN
      V_PARAMETROS := V_PARAMETROS || '&p_ind_saldo=' || (P_OPCI_SALDO);
    
      --V_WHERE := V_WHERE || ' AND A.DOC_SALDO_MON <> 0';
    
    END IF;
  
    IF P_ORDEN = 'D' THEN
      P_ORDEN_CONSULTA := ' TMOV_ABREV ,A.DOC_NRO_DOC ,A.DOC_FEC_DOC,CUO_FEC_VTO,PAG_FEC_PAGO';
    ELSE
      P_ORDEN_CONSULTA := ' CUO_FEC_VTO,TMOV_ABREV,A.DOC_NRO_DOC,A.DOC_FEC_DOC,PAG_FEC_PAGO';
    END IF;
  
    SELECT CONF_ADELANTO_PRO
      INTO P_CONF_ADELANTO_PRO
      FROM FIN_CONFIGURACION
     WHERE CONF_EMPR = P_EMPRESA;
  
    -- concatenar los parametros para llamar el reporte en jasper 
    V_PARAMETROS := 'P_FORMATO=' || url_encode('xls');
    V_PARAMETROS := V_PARAMETROS || '&P_EMPRESA=' || (P_EMPRESA);
    V_PARAMETROS := V_PARAMETROS || '&P_DESC_EMPRESA=' ||
                    url_encode(V_EMPR_DESC);
    V_PARAMETROS := V_PARAMETROS || '&P_PROV=' || url_encode(P_PROV);
    V_PARAMETROS := V_PARAMETROS || '&P_MON=' || url_encode(P_MON);
    V_PARAMETROS := V_PARAMETROS || '&P_CONF_ADELANTO_PRO=' ||
                    url_encode(P_CONF_ADELANTO_PRO);
    V_PARAMETROS := V_PARAMETROS || '&P_DESC_SUCURSAL=' ||
                    url_encode(V_SUC_DESC);
    V_PARAMETROS := V_PARAMETROS || '&P_PROGRAMA=' || url_encode('FINC015');
    V_PARAMETROS := V_PARAMETROS || '&P_DESC_PROGRAMA=' ||
                    url_encode('EXTRACTO DE CUENTA DE PROVEEDORES');
    V_PARAMETROS := V_PARAMETROS || '&P_PROV_RAZON_SOCIAL=' ||
                    url_encode(P_PROV_RAZON_SOCIAL);
    V_PARAMETROS := V_PARAMETROS || '&P_COD_MONEDA=' || url_encode(P_MON);
    V_PARAMETROS := V_PARAMETROS || '&P_DESC_MONEDA=' ||
                    url_encode(P_DESC_MONEDA);
    V_PARAMETROS := V_PARAMETROS || '&P_IND_SALDO_CERO=' ||
                    url_encode(P_OPCI_SALDO);
    V_PARAMETROS := V_PARAMETROS || '&P_ORDEN=' || url_encode(P_ORDEN);
    V_PARAMETROS := V_PARAMETROS || '&P_ORDEN_CONSULTA=' ||
                    url_encode(P_ORDEN_CONSULTA);
    V_PARAMETROS := V_PARAMETROS || '&P_TELEFONO=' ||
                    url_encode(P_TELEFONO);
    V_PARAMETROS := V_PARAMETROS || '&P_CONTACTO=' ||
                    url_encode(P_CONTACTO);
    V_PARAMETROS := V_PARAMETROS || '&P_SALDO=' || url_encode(P_SALDO);
    V_PARAMETROS := V_PARAMETROS || '&P_FEC_VENCIMIENTO=' ||
                    url_encode(TO_DATE(P_FEC_VTO, 'DD/MM/YYYY'));
    V_PARAMETROS := V_PARAMETROS || '&P_LOGIN=' || url_encode(P_USUARIO);
    V_PARAMETROS := V_PARAMETROS || '&P_WHERE=' || url_encode(V_WHERE);
    V_PARAMETROS := V_PARAMETROS || '&P_SESSION=' || url_encode(P_SESSION);
  
    P_PARAMETROS := V_PARAMETROS;
    P_NOMBRE_REP := 'FINC015';
    /* SE CARGARAN LAS VARIABLES EN ESTA TABLA AUXILIAR PARA QUE LA PAGINA DE REPORTES PUEDA SER DINAMICA
    Y ASI SE PUEDA REUTILIZAR
     */
  
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = P_USUARIO;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (P_PARAMETROS, P_USUARIO, 'finc005', 'xls');
    COMMIT;
  
  END PP_LLAMAR_excel;

END;
/
