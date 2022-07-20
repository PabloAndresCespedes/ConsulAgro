create or replace package PERI247 is

  -- Author  : PROGRAMACION9
  -- Created : 01/07/2020 16:03:01
  -- Purpose :
  PROCEDURE PP_VALIDAR_PERIODO(I_EMPRESA IN NUMBER, I_PDOC_FEC IN DATE);
  FUNCTION FP_CLAVE_DOC(I_EMPRESA IN NUMBER) RETURN NUMBER;
  PROCEDURE PP_VALIDAR_PERIODO_FIN(I_EMPRESA IN NUMBER, I_PDOC_FEC IN DATE);

  PROCEDURE PP_MOSTRAR_PERIODO(I_EMPRESA      IN NUMBER,
                               I_COD_PERIODO  IN NUMBER,
                               I_PERI_FEC_INI OUT DATE,
                               I_PERI_FEC_FIN OUT DATE);

  PROCEDURE PL_VALIDAR_OPCTA(V_CTA       IN NUMBER,
                             V_EMPR      IN NUMBER,
                             V_LOGIN     IN VARCHAR2,
                             V_CTA_DESC  IN VARCHAR2,
                             V_OPERACION IN VARCHAR2,
                             V_PROGRAMA  IN VARCHAR2);
  PROCEDURE PP_VERIF_MOSTRAR_CTA_BANC(I_BCO_DESC    OUT VARCHAR2,
                                      I_CTA_DESC    OUT VARCHAR2,
                                      I_S_MON       OUT NUMBER,
                                      I_EMPRESA     IN NUMBER,
                                      I_DOC_CTA_BCO IN NUMBER,
                                      I_PROG        IN VARCHAR2);
  PROCEDURE PP_TRAER_MONEDA(S_MON_DESC  OUT VARCHAR2,
                            S_MON       IN NUMBER,
                            I_EMPRESA   IN NUMBER,
                            S_TASA_OFIC OUT NUMBER,
                            I_PDOC_FEC  IN DATE);

  PROCEDURE PP_BUSCAR_CONCEPTO(I_PCON_DESC            OUT VARCHAR2,
                               S_PDDET_CLAVE_CONCEPTO IN NUMBER,
                               I_EMPRESA              IN NUMBER);
  PROCEDURE PP_MOSTRAR_TECNICO(I_EMPL_NOMBRE OUT VARCHAR2,
                               I_TEC_LEGAJO  IN NUMBER,
                               I_EMPRESA     IN NUMBER);

  PROCEDURE PP_CARGAR_NRO_DOC(I_NRO_DOC OUT NUMBER, I_EMPRESA IN NUMBER);

  PROCEDURE PP_CARGAR_DETALLE(PERI_FEC_FIN           IN DATE,
                              S_PDDET_CLAVE_CONCEPTO IN NUMBER,
                              TEC_LEGAJO             IN NUMBER,
                              S_MON                  IN NUMBER,
                              I_EMPRESA              IN NUMBER,
                              RADIO_GROUP            IN VARCHAR2,
                              I_SUCURSAL             IN NUMBER,
                              I_PROG                 IN VARCHAR2 DEFAULT 'PERI247');

  PROCEDURE PP_CARGAR_DOCUMENTO_FIN(PROVEEDOR      IN NUMBER,
                                    CLAVE_CUOTA    IN NUMBER,
                                    VENCIMIENTO    IN DATE,
                                    IMPORTE        IN NUMBER,
                                    OBSERVACION    IN VARCHAR2,
                                    V_CLAVE        OUT NUMBER,
                                    I_EMPRESA      IN NUMBER,
                                    I_TASA_OFIC    IN NUMBER,
                                    I_DOC_CTA_BCO  IN NUMBER,
                                    I_PDOC_NRO_DOC IN NUMBER,
                                    I_MON_LOC      IN NUMBER,
                                    I_PDOC_FEC     IN DATE,
                                    I_DOC_OBS      IN VARCHAR2);

  PROCEDURE PP_INS_PER_DOC(IPDOC_CLAVE     IN NUMBER,
                           IPDOC_QUINCENA  IN NUMBER,
                           IPDOC_EMPLEADO  IN NUMBER,
                           IPDOC_FEC       IN DATE,
                           IPDOC_NRO_DOC   IN NUMBER,
                           IPDOC_FEC_GRAB  IN DATE,
                           IPDOC_LOGIN     IN VARCHAR2,
                           IPDOC_FORM      IN VARCHAR2,
                           IPDOC_PERIODO   IN NUMBER,
                           IPDOC_CLAVE_FIN IN NUMBER,
                           IPDOC_NRO_ITEM  IN NUMBER,
                           IPDOC_CONCEPTO  IN NUMBER,
                           IPDOC_IMPORTE   IN NUMBER,
                           I_MON           IN NUMBER,
                           I_EMPRESA       IN NUMBER,
                           I_TASA_OFIC     IN NUMBER);

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_PDOC_FEC     IN DATE,
                                   I_PDOC_NRO_DOC IN NUMBER,
                                   I_EMPRESA      IN NUMBER,
                                   I_PERIODO      IN NUMBER,
                                   I_MON_LOC      IN NUMBER,
                                   I_TASA_OFIC    IN NUMBER,
                                   I_DOC_CTA_BCO  IN NUMBER,
                                   I_MON          IN NUMBER,
                                   I_COD_SUCURSAL IN NUMBER,
                                   I_DOC_OBS      IN VARCHAR2);

  PROCEDURE PP_LLAMAR_REPORTE(I_CLAVE        IN NUMBER,
                              I_EMPRESA      IN NUMBER,
                              I_COD_SUCURSAL IN NUMBER,
                              V_PRI_CLAVE    IN NUMBER);

  PROCEDURE pp_borrar_Det(i_seq IN NUMBER);

end PERI247;
/
CREATE OR REPLACE PACKAGE BODY PERI247 IS

  PROCEDURE PP_VALIDAR_PERIODO(I_EMPRESA IN NUMBER, I_PDOC_FEC IN DATE) IS

    V_FEC_INI DATE;
    V_FEC_FIN DATE;

    V_PERIODO NUMBER;

  BEGIN

    SELECT PERI_FEC_INI
      INTO V_FEC_INI
      FROM PER_CONFIGURACION, PER_PERIODO
     WHERE CONF_PERI_ACT = PERI_CODIGO
       AND CONF_EMPR = PERI_EMPR
       AND CONF_EMPR = I_EMPRESA;

    SELECT PERI_FEC_FIN
      INTO V_FEC_FIN
      FROM PER_CONFIGURACION, PER_PERIODO
     WHERE CONF_PERI_SGTE = PERI_CODIGO
       AND CONF_EMPR = PERI_EMPR
       AND CONF_EMPR = I_EMPRESA;

    IF I_PDOC_FEC < V_FEC_INI OR I_PDOC_FEC > V_FEC_FIN THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'La fecha de documento debe estar comprendida entre ' ||
                              TO_CHAR(V_FEC_INI, 'dd-mm-yyyy') || ' y ' ||
                              TO_CHAR(V_FEC_FIN, 'dd-mm-yyyy'));
    END IF;

    SELECT PERI_CODIGO
      INTO V_PERIODO
      FROM PER_PERIODO
     WHERE PERI_FEC_INI <= I_PDOC_FEC
       AND PERI_FEC_FIN >= I_PDOC_FEC
       AND PERI_EMPR = I_EMPRESA;

    -- W_PERIODO := V_PERIODO;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20003,
                              'No ha sido cargada la configuracion de Recursos Humanos!');
  END;

  PROCEDURE PP_VALIDAR_PERIODO_FIN(I_EMPRESA IN NUMBER, I_PDOC_FEC IN DATE) IS

    V_FEC_INI DATE;
    V_FEC_FIN DATE;

    V_PERIODO NUMBER;

  BEGIN

    SELECT PERI_FEC_INI
      INTO V_FEC_INI
      FROM FIN_CONFIGURACION, FIN_PERIODO
     WHERE CONF_PERIODO_ACT = PERI_CODIGO
       AND CONF_EMPR = PERI_EMPR
       AND CONF_EMPR = I_EMPRESA;

    SELECT PERI_FEC_FIN
      INTO V_FEC_FIN
      FROM FIN_CONFIGURACION, FIN_PERIODO
     WHERE CONF_PERIODO_SGTE = PERI_CODIGO
       AND CONF_EMPR = PERI_EMPR
       AND CONF_EMPR = I_EMPRESA;

    IF I_PDOC_FEC < V_FEC_INI OR I_PDOC_FEC > V_FEC_FIN THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'La fecha de documento debe estar comprendida entre ' ||
                              TO_CHAR(V_FEC_INI, 'dd-mm-yyyy') || ' y ' ||
                              TO_CHAR(V_FEC_FIN, 'dd-mm-yyyy') ||
                              ', si se esta relacionando con FINANZAS!');
    END IF;

    SELECT PERI_CODIGO
      INTO V_PERIODO
      FROM FIN_PERIODO
     WHERE PERI_FEC_INI <= I_PDOC_FEC
       AND PERI_FEC_FIN >= I_PDOC_FEC
       AND PERI_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'No ha sido cargada la configuracion de Finanzas!');
  END;

  PROCEDURE PP_MOSTRAR_PERIODO(I_EMPRESA      IN NUMBER,
                               I_COD_PERIODO  IN NUMBER,
                               I_PERI_FEC_INI OUT DATE,
                               I_PERI_FEC_FIN OUT DATE) IS
  BEGIN
    SELECT TO_CHAR(PERI_FEC_INI, 'DD-MM-YYYY'),
           TO_CHAR(PERI_FEC_FIN, 'DD-MM-YYYY')
      INTO I_PERI_FEC_INI, I_PERI_FEC_FIN
      FROM PER_PERIODO P
     WHERE PERI_CODIGO = I_COD_PERIODO
       AND PERI_EMPR = I_EMPRESA;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20003, 'Periodo inexistente!');
  END;

  PROCEDURE PP_VERIF_MOSTRAR_CTA_BANC(I_BCO_DESC    OUT VARCHAR2,
                                      I_CTA_DESC    OUT VARCHAR2,
                                      I_S_MON       OUT NUMBER,
                                      I_EMPRESA     IN NUMBER,
                                      I_DOC_CTA_BCO IN NUMBER,
                                      I_PROG        IN VARCHAR2) IS
    V_MON NUMBER;
  BEGIN
    SELECT CTA_MON, BCO_DESC, CTA_DESC, CTA_MON
      INTO V_MON, I_BCO_DESC, I_CTA_DESC, I_S_MON
      FROM FIN_CUENTA_BANCARIA, FIN_BANCO
     WHERE CTA_BCO = BCO_CODIGO(+)
       AND CTA_EMPR = BCO_EMPR(+)
       AND CTA_EMPR = I_EMPRESA
       AND CTA_CODIGO = I_DOC_CTA_BCO;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_BCO_DESC := NULL;
      I_CTA_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20004,
                              'Caja inexistente y/o no tiene permiso para consultar. Verifiquelo en el 2-1-80!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END;

  PROCEDURE PL_VALIDAR_OPCTA(V_CTA       IN NUMBER,
                             V_EMPR      IN NUMBER,
                             V_LOGIN     IN VARCHAR2,
                             V_CTA_DESC  IN VARCHAR2,
                             V_OPERACION IN VARCHAR2,
                             V_PROGRAMA  IN VARCHAR2) IS
    V_DEP  VARCHAR2(1);
    V_EXT  VARCHAR2(1);
    V_PROP VARCHAR2(1);
    V_FEC  DATE;

    V_SUCURSAL NUMBER;

  BEGIN
    --BUSCAR LA SUCURSAL
    BEGIN
      SELECT CONF_SUC
        INTO V_SUCURSAL
        FROM GEN_CONFIGURACION
       WHERE CONF_EMPR = V_EMPR;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    IF SUBSTR(V_PROGRAMA, 1, 3) = 'FIN' THEN

      IF V_SUCURSAL = 1 THEN
        --BUSCAR CUAL FUE LA MAX FECHA MENOR AL DIA DEL HOY
        BEGIN
          SELECT CTA_ULT_FEC_MOVCR
            INTO V_FEC
            FROM FIN_CUENTA_BANCARIA
           WHERE CTA_CODIGO = V_CTA
             AND CTA_EMPR = V_EMPR;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
        END;
      END IF;
    END IF;

    SELECT OP_CTA_PROPIETARIO, OP_CTA_IND_PERM_DEP, OP_CTA_IND_PERM_EXT
      INTO V_PROP, V_DEP, V_EXT
      FROM GEN_OPERADOR_EMPRESA,
           GEN_OPERADOR,
           FIN_OPER_CTA_BCO,
           FIN_CUENTA_BANCARIA
     WHERE OPER_CODIGO = OP_CTA_OPER
       AND OP_CTA_EMPR = CTA_EMPR
       AND OP_CTA_CTA_CODIGO = CTA_CODIGO
       AND OPER_LOGIN = V_LOGIN
       AND OP_CTA_EMPR = V_EMPR
       AND OP_CTA_CTA_CODIGO = V_CTA
       AND OPER_CODIGO = OPEM_OPER
       AND OPEM_EMPR = V_EMPR;

    IF V_OPERACION = 'D' AND ((V_EMPR <> 2 AND NVL(V_PROP, 'N') <> 'S') OR
       (V_EMPR = 2 AND NVL(V_DEP, 'N') <> 'S')) THEN
      RAISE_APPLICATION_ERROR(-20005,
                              'No tiene permiso para operar con la Cta. ' ||
                              V_CTA_DESC);
    ELSE
      IF V_OPERACION = 'C' AND V_EXT <> 'S' THEN
        RAISE_APPLICATION_ERROR(-20006,
                                'No tiene permiso para operar con la Cta. ' ||
                                V_CTA_DESC);
      END IF;
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20007,
                              'No puede realizar operaciones con la Cta. ' ||
                              V_CTA_DESC);
  END;

  PROCEDURE PP_TRAER_MONEDA(S_MON_DESC  OUT VARCHAR2,
                            S_MON       IN NUMBER,
                            I_EMPRESA   IN NUMBER,
                            S_TASA_OFIC OUT NUMBER,
                            I_PDOC_FEC  IN DATE) IS

  BEGIN

    SELECT MON_DESC
      INTO S_MON_DESC
      FROM GEN_MONEDA
     WHERE MON_CODIGO = S_MON
       AND MON_EMPR = I_EMPRESA;

    --S_TASA_OFIC := FIN_BUSCAR_COTIZACION_FEC(I_PDOC_FEC, S_MON, I_EMPRESA);
     S_TASA_OFIC := gen_cotizacion(I_EMPRESA,S_MON,I_PDOC_FEC,'V');

    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20008, 'Moneda inexistente!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20009, SQLERRM);
  END;

  PROCEDURE PP_BUSCAR_CONCEPTO(I_PCON_DESC            OUT VARCHAR2,
                               S_PDDET_CLAVE_CONCEPTO IN NUMBER,
                               I_EMPRESA              IN NUMBER) IS
  BEGIN
    SELECT B.PCON_DESC
      INTO I_PCON_DESC
      FROM PER_CONCEPTO B
     WHERE B.PCON_CLAVE = S_PDDET_CLAVE_CONCEPTO
       AND B.PCON_CANCELADO_POR_CONC IS NOT NULL
       AND B.PCON_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'El concepto no existe!');

  END;

  PROCEDURE PP_MOSTRAR_TECNICO(I_EMPL_NOMBRE OUT VARCHAR2,
                               I_TEC_LEGAJO  IN NUMBER,
                               I_EMPRESA     IN NUMBER) IS

  BEGIN

    SELECT EMPL_NOMBRE || ' ' || EMPL_APE
      INTO I_EMPL_NOMBRE
      FROM PER_EMPLEADO
     WHERE EMPL_LEGAJO = I_TEC_LEGAJO
       AND EMPL_EMPRESA = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20011, 'Empleado inexistente!.');
  END;

  PROCEDURE PP_CARGAR_NRO_DOC(I_NRO_DOC OUT NUMBER, I_EMPRESA IN NUMBER) IS

  BEGIN
    GEN_CODIGO_LIBRE(COLUMNA         => 'pdoc_nro_doc',
                     TABLA           => 'per_documento',
                     VALORDESDE      => 574,
                     CODIGO          => I_NRO_DOC,
                     COLUMNA_EMPRESA => 'pdoc_empr',
                     EMPRESA         => I_EMPRESA);
  END;

  PROCEDURE PP_CARGAR_DETALLE(PERI_FEC_FIN           IN DATE,
                              S_PDDET_CLAVE_CONCEPTO IN NUMBER,
                              TEC_LEGAJO             IN NUMBER,
                              S_MON                  IN NUMBER,
                              I_EMPRESA              IN NUMBER,
                              RADIO_GROUP            IN VARCHAR2,
                              I_SUCURSAL             IN NUMBER,
                              I_PROG                 IN VARCHAR2 DEFAULT 'PERI247') IS
    V_WHERE    VARCHAR2(1000);
    V_CONSULTA VARCHAR2(20000);
  BEGIN
    
 -- RAISE_APPLICATION_ERROR(-20001,S_PDDET_CLAVE_CONCEPTO);
    IF I_SUCURSAL IS NULL AND I_EMPRESA = 1 THEN
      RAISE_APPLICATION_ERROR(-20001, 'La sucursal no puede quedar vacia');
    END IF;
    
    
    IF I_EMPRESA = 2 THEN
      V_WHERE := V_WHERE ||' CUO_FEC_VTO <= ' || CHR(39) || PERI_FEC_FIN || CHR(39);

      IF S_PDDET_CLAVE_CONCEPTO IS NOT NULL THEN
        
     ---- RAISE_APPLICATION_ERROR(-20001,S_PDDET_CLAVE_CONCEPTO);
        V_WHERE := V_WHERE || ' AND PCON_CLAVE=' || S_PDDET_CLAVE_CONCEPTO;
      END IF;

      IF TEC_LEGAJO IS NOT NULL THEN
        V_WHERE := V_WHERE || ' AND EMPL_LEGAJO=' || TEC_LEGAJO;
      END IF;
      
     IF I_SUCURSAL is not NULL THEN
      V_WHERE :=  V_WHERE ||'AND EMPL_SUCURSAL=' || I_SUCURSAL;
    END IF; 
      
      
         IF v('P2582_EXCLUIR_DE') = 1 THEN
           V_WHERE := V_WHERE || ' AND EMPL_LEGAJO  NOT IN (select desv_legajo
                                                                from desv_empleados
                                                                WHERE  desv_empr = '||I_EMPRESA||'
                                                                AND desv_periodo = '||V('P2582_PERIODO')||')';
                                                                
         V_WHERE := V_WHERE || ' AND empl_forma_pago <>3';
          END IF;
      
--V_WHERE := V_WHERE || ' AND PCON_CLAVE=' || S_PDDET_CLAVE_CONCEPTO;
 --V_WHERE := ' CUO_FEC_VTO <= ' || CHR(39) || PERI_FEC_FIN || CHR(39);
      --FILTRO DE PRESTADORES DE SERVICIOS
      V_WHERE := V_WHERE || ' AND FORMA_PAGO <>3 ';
      V_WHERE := V_WHERE || ' AND SITUACION =''A'' ';
      V_WHERE := V_WHERE || ' AND NVL(EMPL_MON_PAGO,1)=' || S_MON;

      V_CONSULTA := 'SELECT  EMPL_LEGAJO,
                        EMPL_NOMBRE,
                        EMPL_CODIGO_PROV,
                        DPTO_DESC, PCON_CLAVE,
                        PCON_DESC,
                        FIN_OBS,
                        CUO_CLAVE_DOC,
                        CUO_FEC_VTO,
                        CUO_IMP_MON,
                        CUO_SALDO_MON,
                        PCON_CANCELADO_POR_CONC,
                        EMPL_SUCURSAL,
                        EMPL_MON_PAGO,
                        SITUACION,
                        FORMA_PAGO
                        FROM PER_PERI047_V_TAGRO
                        WHERE' || V_WHERE;
   --RAISE_APPLICATION_ERROR(-20001, V_WHERE);                    
                        
                        

    ELSIF I_EMPRESA = 1 THEN


      IF I_PROG = 'PERC002' THEN---LV 06/06/2021

        V_WHERE := ' EMPL_SUCURSAL=' || I_SUCURSAL;
      ELSE
      V_WHERE := ' CUO_FEC_VTO <= ' || CHR(39) || PERI_FEC_FIN || CHR(39) ||' AND EMPL_SUCURSAL=' || I_SUCURSAL;
      END IF;
      IF S_PDDET_CLAVE_CONCEPTO IS NOT NULL THEN
        V_WHERE := V_WHERE || ' AND PCON_CLAVE=' || S_PDDET_CLAVE_CONCEPTO;
      END IF;

      IF TEC_LEGAJO IS NOT NULL THEN
        V_WHERE := V_WHERE || ' AND EMPL_LEGAJO=' || TEC_LEGAJO;
      END IF;

      V_WHERE := V_WHERE || ' AND EMPL_EMPRESA=' || I_EMPRESA;
      V_WHERE := V_WHERE || ' AND nvl(EMPL_mon_pago,1)=' || S_MON;
      V_WHERE := V_WHERE || ' AND nvl(EMPL_mon_pago,1)=' || S_MON;

      --V_WHERE := V_WHERE ||' AND nvl(empr,1)='||I_EMPRESA;
      IF RADIO_GROUP IS NOT NULL AND RADIO_GROUP != 3 THEN
        V_WHERE := V_WHERE || ' AND dpto_grupo_pago = ' || RADIO_GROUP;
      END IF;
--raise_application_error (-20001, v('P2582_EXCLUIR_DE'));
   IF v('P2582_EXCLUIR_DE') = 1 THEN
   V_WHERE := V_WHERE || ' AND EMPL_LEGAJO  NOT IN (select desv_legajo
                                                        from desv_empleados
                                                        WHERE  desv_empr = '||I_EMPRESA||'
                                                        AND desv_periodo = '||V('P2582_PERIODO')||')';
                                                        
 V_WHERE := V_WHERE || ' AND empl_forma_pago <>3';
  END IF;
      
      



      V_WHERE := V_WHERE || ' AND EMPL_EMPRESA = ' || I_EMPRESA;

      V_CONSULTA := ' SELECT EMPL_LEGAJO,
                             EMPL_NOMBRE,
                             EMPL_CODIGO_PROV,
                             DPTO_DESC,
                             PCON_CLAVE,
                             PCON_DESC,
                             FIN_OBS,
                             CUO_CLAVE_DOC,
                             CUO_FEC_VTO,
                             CUO_IMP_MON,
                             CUO_SALDO_MON,
                             PCON_CANCELADO_POR_CONC,
                             EMPL_SUCURSAL,
                             EMPL_EMPRESA,
                             EMPL_MON_PAGO,
                             DPTO_GRUPO_PAGO,
                             EMPL_DEPARTAMENTO
                        FROM PER_PERI047_V
                        WHERE' || V_WHERE;
if gen_devuelve_user = 'ADCS'THEN
 INSERT INTO X (CAMPO1, OTRO) VALUES (V_CONSULTA, 'PERI047_456');
END IF;
    END IF;





    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'PERI247') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'PERI247');
    END IF;
    APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'PERI247',
                                                   P_QUERY           => V_CONSULTA);

  END;

  FUNCTION FP_CLAVE_DOC(I_EMPRESA IN NUMBER) RETURN NUMBER IS
    V_CLAVE NUMBER;
  BEGIN
    SELECT NVL(MAX(PDOC_CLAVE), 0)
      INTO V_CLAVE
      FROM PER_DOCUMENTO
     WHERE PDOC_EMPR = I_EMPRESA;

    RETURN V_CLAVE;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_PDOC_FEC     IN DATE,
                                   I_PDOC_NRO_DOC IN NUMBER,
                                   I_EMPRESA      IN NUMBER,
                                   I_PERIODO      IN NUMBER,
                                   I_MON_LOC      IN NUMBER,
                                   I_TASA_OFIC    IN NUMBER,
                                   I_DOC_CTA_BCO  IN NUMBER,
                                   I_MON          IN NUMBER,
                                   I_COD_SUCURSAL IN NUMBER,
                                   I_DOC_OBS      IN VARCHAR2) IS

    V_CLAVE_FIN NUMBER;
    V_CLAVE     NUMBER;
    V_PRI_CLAVE NUMBER;
    V_CLAVE_HIL NUMBER;
    V_PCON_IND_EFECTIVO VARCHAR2(1);
  BEGIN

    V_CLAVE := FP_CLAVE_DOC(I_EMPRESA);
    -- IF I_EMPRESA = 2 THEN
    FOR V IN (SELECT C001 EMPL_LEGAJO,
                     C002 EMPL_NOMBRE,
                     C003 EMPL_CODIGO_PROV,
                     C004 DPTO_DESC,
                     C005 PCON_CLAVE,
                     C006 PCON_DESC,
                     C007 FIN_OBS,
                     C008 CUO_CLAVE_DOC,
                     C009 CUO_FEC_VTO,
                     C010 CUO_IMP_MON,
                     C011 CUO_SALDO_MON,
                     C012 PCON_CANCELADO_POR_CONC,
                     C013 EMPL_SUCURSAL,
                     C014 EMPL_EMPRESA,
                     C015 EMPL_MON_PAGO,
                     C016 DPTO_GRUPO_PAGO,
                     C017 EMPL_DEPARTAMENTO
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'PERI247') LOOP
               
               
    SELECT NVL(A.PCON_IND_EFECTIVO,'N')
    INTO V_PCON_IND_EFECTIVO
    FROM PER_CONCEPTO A 
    WHERE A.PCON_CLAVE = V.PCON_CLAVE 
    AND A.PCON_EMPR = I_EMPRESA;  
   
    IF V_PCON_IND_EFECTIVO = 'S' THEN
         PP_CARGAR_DOCUMENTO_FIN(V.EMPL_CODIGO_PROV,
                              V.CUO_CLAVE_DOC,
                              V.CUO_FEC_VTO,
                              V.CUO_SALDO_MON,
                              'DEV.AD.' || SUBSTR(V.EMPL_NOMBRE, 1, 10),
                              V_CLAVE_FIN,
                              I_EMPRESA,
                              I_TASA_OFIC,
                              NULL,
                              I_PDOC_NRO_DOC,
                              I_MON_LOC,
                              I_PDOC_FEC,
                              I_DOC_OBS);
                              
    
    ELSE
      
        PP_CARGAR_DOCUMENTO_FIN(V.EMPL_CODIGO_PROV,
                              V.CUO_CLAVE_DOC,
                              V.CUO_FEC_VTO,
                              V.CUO_SALDO_MON,
                              'DEV.AD.' || SUBSTR(V.EMPL_NOMBRE, 1, 10),
                              V_CLAVE_FIN,
                              I_EMPRESA,
                              I_TASA_OFIC,
                              I_DOC_CTA_BCO,
                              I_PDOC_NRO_DOC,
                              I_MON_LOC,
                              I_PDOC_FEC,
                              I_DOC_OBS);
    
    END IF;                          
      

    IF V_PCON_IND_EFECTIVO = 'S' THEN
        
     
     DECLARE
     
     V_IPS       NUMBER:= 0;
     V_IMP_IPS   NUMBER := 0;
     V_CLAVE_IPS NUMBER ; 
     
      BEGIN
        
      V_IPS := ROUND(V.CUO_SALDO_MON *0.09);
      V_IMP_IPS := V.CUO_SALDO_MON - V_IPS;  
      
     V_CLAVE := V_CLAVE + 1;
       PERI247.PP_INS_PER_DOC(IPDOC_CLAVE     => V_CLAVE,
                               IPDOC_QUINCENA  => 2,
                               IPDOC_EMPLEADO  => V.EMPL_LEGAJO,
                               IPDOC_FEC       => I_PDOC_FEC,
                               IPDOC_NRO_DOC   => I_PDOC_NRO_DOC,
                               IPDOC_FEC_GRAB  => SYSDATE,
                               IPDOC_LOGIN     => GEN_DEVUELVE_USER,
                               IPDOC_FORM      => 'PERI005',
                               IPDOC_PERIODO   => I_PERIODO,
                               IPDOC_CLAVE_FIN => V_CLAVE_FIN,
                               IPDOC_NRO_ITEM  => 1,
                               IPDOC_CONCEPTO  => V.PCON_CANCELADO_POR_CONC,
                               IPDOC_IMPORTE   => V_IMP_IPS,
                               I_MON           => I_MON,
                               I_EMPRESA       => I_EMPRESA,
                               I_TASA_OFIC     => I_TASA_OFIC);
                               
   
    V_CLAVE_IPS:= FP_CLAVE_DOC(I_EMPRESA);
     V_CLAVE_IPS := V_CLAVE_IPS + 1;
        PERI247.PP_INS_PER_DOC(IPDOC_CLAVE     => V_CLAVE_IPS,
                               IPDOC_QUINCENA  => 2,
                               IPDOC_EMPLEADO  => V.EMPL_LEGAJO,
                               IPDOC_FEC       => I_PDOC_FEC,
                               IPDOC_NRO_DOC   => I_PDOC_NRO_DOC,
                               IPDOC_FEC_GRAB  => SYSDATE,
                               IPDOC_LOGIN     => GEN_DEVUELVE_USER,
                               IPDOC_FORM      => 'PERI005',
                               IPDOC_PERIODO   => I_PERIODO,
                               IPDOC_CLAVE_FIN => V_CLAVE_FIN,
                               IPDOC_NRO_ITEM  => 1,
                               IPDOC_CONCEPTO  => 4,
                               IPDOC_IMPORTE   => V_IPS,
                               I_MON           => I_MON,
                               I_EMPRESA       => I_EMPRESA,
                               I_TASA_OFIC     => I_TASA_OFIC);
                               
     --
     V_CLAVE_HIL := FP_CLAVE_DOC(I_EMPRESA);
     V_CLAVE_HIL := V_CLAVE_HIL + 1;   
     
     --               
        PERI247.PP_INS_PER_DOC(IPDOC_CLAVE     => V_CLAVE_HIL,
                               IPDOC_QUINCENA  => 2,
                               IPDOC_EMPLEADO  => V.EMPL_LEGAJO,
                               IPDOC_FEC       => I_PDOC_FEC,
                               IPDOC_NRO_DOC   => I_PDOC_NRO_DOC,
                               IPDOC_FEC_GRAB  => SYSDATE,
                               IPDOC_LOGIN     => GEN_DEVUELVE_USER,
                               IPDOC_FORM      => 'PERI005',
                               IPDOC_PERIODO   => I_PERIODO,
                               IPDOC_CLAVE_FIN => V_CLAVE_FIN,
                               IPDOC_NRO_ITEM  => 1,
                               IPDOC_CONCEPTO  => V.PCON_CLAVE,
                               IPDOC_IMPORTE   => V.CUO_SALDO_MON,
                               I_MON           => I_MON,
                               I_EMPRESA       => I_EMPRESA,
                               I_TASA_OFIC     => I_TASA_OFIC); 
                               
                               
                               
      
      END;
      
      ELSE
      
      BEGIN
      V_CLAVE := V_CLAVE + 1;
        -- CALL THE PROCEDURE
        PERI247.PP_INS_PER_DOC(IPDOC_CLAVE     => V_CLAVE,
                               IPDOC_QUINCENA  => 2,
                               IPDOC_EMPLEADO  => V.EMPL_LEGAJO,
                               IPDOC_FEC       => I_PDOC_FEC,
                               IPDOC_NRO_DOC   => I_PDOC_NRO_DOC,
                               IPDOC_FEC_GRAB  => SYSDATE,
                               IPDOC_LOGIN     => GEN_DEVUELVE_USER,
                               IPDOC_FORM      => 'PERI005',
                               IPDOC_PERIODO   => I_PERIODO,
                               IPDOC_CLAVE_FIN => V_CLAVE_FIN,
                               IPDOC_NRO_ITEM  => 1,
                               IPDOC_CONCEPTO  => V.PCON_CANCELADO_POR_CONC,
                               IPDOC_IMPORTE   => V.CUO_SALDO_MON,
                               I_MON           => I_MON,
                               I_EMPRESA       => I_EMPRESA,
                               I_TASA_OFIC     => I_TASA_OFIC);
      END;
      
   
    END IF;

    END LOOP;

    COMMIT;

    BEGIN
      -- CALL THE PROCEDURE
      PERI247.PP_LLAMAR_REPORTE(I_CLAVE        => V_CLAVE,
                                I_EMPRESA      => I_EMPRESA,
                                I_COD_SUCURSAL => I_COD_SUCURSAL,
                                V_PRI_CLAVE    => V_PRI_CLAVE);
    END;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
      --DISPLAY_ERROR;
  END;

  PROCEDURE PP_CARGAR_DOCUMENTO_FIN(PROVEEDOR      IN NUMBER,
                                    CLAVE_CUOTA    IN NUMBER,
                                    VENCIMIENTO    IN DATE,
                                    IMPORTE        IN NUMBER,
                                    OBSERVACION    IN VARCHAR2,
                                    V_CLAVE        OUT NUMBER,
                                    I_EMPRESA      IN NUMBER,
                                    I_TASA_OFIC    IN NUMBER,
                                    I_DOC_CTA_BCO  IN NUMBER,
                                    I_PDOC_NRO_DOC IN NUMBER,
                                    I_MON_LOC      IN NUMBER,
                                    I_PDOC_FEC     IN DATE,
                                    I_DOC_OBS      IN VARCHAR2) IS

    V_DOC_TIPO_SALDO  VARCHAR2(1);
    V_FCON_TIPO_SALDO VARCHAR2(1);
  BEGIN

    V_CLAVE := FIN_SEQ_DOC_NEXTVAL;
    IF I_EMPRESA = 2 THEN
      SELECT TMOV_TIPO
        INTO V_DOC_TIPO_SALDO
        FROM GEN_TIPO_MOV
       WHERE TMOV_CODIGO = 33
         AND TMOV_EMPR = I_EMPRESA;

      SELECT FCON_TIPO_SALDO
        INTO V_FCON_TIPO_SALDO
        FROM FIN_CONCEPTO
       WHERE FCON_CLAVE = 895
         AND FCON_EMPR = I_EMPRESA;

      INSERT INTO FIN_DOCUMENTO
        (DOC_CLAVE,
         DOC_EMPR,
         DOC_CTA_BCO,
         DOC_SUC,
         DOC_TIPO_MOV,
         DOC_NRO_DOC,
         DOC_TIPO_SALDO,
         DOC_MON,
         DOC_PROV,
         DOC_CLI_NOM,
         DOC_FEC_OPER,
         DOC_FEC_DOC,
         DOC_BRUTO_EXEN_LOC,
         DOC_BRUTO_EXEN_MON,
         DOC_BRUTO_GRAV_LOC,
         DOC_BRUTO_GRAV_MON,
         DOC_NETO_EXEN_LOC,
         DOC_NETO_EXEN_MON,
         DOC_NETO_GRAV_LOC,
         DOC_NETO_GRAV_MON,
         DOC_IVA_LOC,
         DOC_IVA_MON,
         DOC_SALDO_INI_MON,
         DOC_SALDO_LOC,
         DOC_SALDO_MON,
         DOC_SALDO_PER_ACT_LOC,
         DOC_SALDO_PER_ACT_MON,
         DOC_OBS,
         DOC_BASE_IMPON_LOC,
         DOC_BASE_IMPON_MON,
         DOC_LOGIN,
         DOC_FEC_GRAB,
         DOC_SIST,
         DOC_OPERADOR,
         DOC_TASA)
      VALUES
        (V_CLAVE,
         I_EMPRESA,
         I_DOC_CTA_BCO,
         1,
         33,
         I_PDOC_NRO_DOC,
         V_DOC_TIPO_SALDO,
         I_MON_LOC,
         PROVEEDOR,
         NULL,
         I_PDOC_FEC,
         I_PDOC_FEC,
         IMPORTE * NVL(I_TASA_OFIC, 1),
         IMPORTE,
         0,
         0,
         IMPORTE * NVL(I_TASA_OFIC, 1),
         IMPORTE,
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         DECODE(I_EMPRESA, 2, NULL, I_DOC_OBS), --'ANTIC. Personal-Modulo RRHH',
         0,
         0,
         GEN_DEVUELVE_USER,
         SYSDATE,
         'PER',
         2,
         DECODE(I_EMPRESA, 1, I_TASA_OFIC, NULL));

      INSERT INTO FIN_DOC_CONCEPTO
        (DCON_ITEM,
         DCON_CLAVE_DOC,
         DCON_CLAVE_CONCEPTO,
         DCON_CLAVE_CTACO,
         DCON_TIPO_SALDO,
         DCON_EXEN_LOC,
         DCON_EXEN_MON,
         DCON_GRAV_LOC,
         DCON_GRAV_MON,
         DCON_IVA_LOC,
         DCON_IVA_MON,
         DCON_IND_TIPO_IVA_COMPRA,
         DCON_OBS,
         DCON_EMPR)

      VALUES
        (1,
         V_CLAVE,
         895,
         2520,
         V_FCON_TIPO_SALDO,
         IMPORTE * NVL(I_TASA_OFIC, 1),
         IMPORTE,
         0,
         0,
         0,
         0,
         1,
         OBSERVACION,
         I_EMPRESA);

      INSERT INTO FIN_PAGO
        (PAG_CLAVE_DOC,
         PAG_FEC_VTO,
         PAG_CLAVE_PAGO,
         PAG_FEC_PAGO,
         PAG_IMP_LOC,
         PAG_IMP_MON,
         PAG_LOGIN,
         PAG_FEC_GRAB,
         PAG_SIST,
         PAG_EMPR)
      VALUES
        (CLAVE_CUOTA,
         VENCIMIENTO,
         V_CLAVE,
         I_PDOC_FEC,
         IMPORTE * NVL(I_TASA_OFIC, 1),
         IMPORTE,
         GEN_DEVUELVE_USER,
         SYSDATE,
         'PER',
         I_EMPRESA);

    ELSE

      V_CLAVE := FIN_SEQ_DOC_NEXTVAL;

      SELECT TMOV_TIPO
        INTO V_DOC_TIPO_SALDO
        FROM GEN_TIPO_MOV
       WHERE TMOV_CODIGO = 33
         AND TMOV_EMPR = I_EMPRESA;

      SELECT FCON_TIPO_SALDO
        INTO V_FCON_TIPO_SALDO
        FROM FIN_CONCEPTO
       WHERE FCON_CLAVE = 495
         AND FCON_EMPR = I_EMPRESA;

      INSERT INTO FIN_DOCUMENTO
        (DOC_CLAVE,
         DOC_EMPR,
         DOC_CTA_BCO,
         DOC_SUC,
         DOC_TIPO_MOV,
         DOC_NRO_DOC,
         DOC_TIPO_SALDO,
         DOC_MON,
         DOC_PROV,
         DOC_CLI_NOM,
         DOC_FEC_OPER,
         DOC_FEC_DOC,
         DOC_BRUTO_EXEN_LOC,
         DOC_BRUTO_EXEN_MON,
         DOC_BRUTO_GRAV_LOC,
         DOC_BRUTO_GRAV_MON,
         DOC_NETO_EXEN_LOC,
         DOC_NETO_EXEN_MON,
         DOC_NETO_GRAV_LOC,
         DOC_NETO_GRAV_MON,
         DOC_IVA_LOC,
         DOC_IVA_MON,
         DOC_SALDO_INI_MON,
         DOC_SALDO_LOC,
         DOC_SALDO_MON,
         DOC_SALDO_PER_ACT_LOC,
         DOC_SALDO_PER_ACT_MON,
         DOC_OBS,
         DOC_BASE_IMPON_LOC,
         DOC_BASE_IMPON_MON,
         DOC_LOGIN,
         DOC_FEC_GRAB,
         DOC_SIST,
         DOC_OPERADOR)
      VALUES
        (V_CLAVE,
         I_EMPRESA,
         I_DOC_CTA_BCO,
         1,
         33,
         I_PDOC_NRO_DOC,
         V_DOC_TIPO_SALDO,
         I_MON_LOC,
         PROVEEDOR,
         NULL,
         I_PDOC_FEC,
         I_PDOC_FEC,
         IMPORTE * NVL(I_TASA_OFIC, 1),
         IMPORTE,
         0,
         0,
         IMPORTE * NVL(I_TASA_OFIC, 1),
         IMPORTE,
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         NULL, --'ANTIC. Personal-Modulo RRHH',
         0,
         0,
         GEN_DEVUELVE_USER,
         SYSDATE,
         'PER',
         2);

      INSERT INTO FIN_DOC_CONCEPTO
        (DCON_ITEM,
         DCON_CLAVE_DOC,
         DCON_CLAVE_CONCEPTO,
         DCON_CLAVE_CTACO,
         DCON_TIPO_SALDO,
         DCON_EXEN_LOC,
         DCON_EXEN_MON,
         DCON_GRAV_LOC,
         DCON_GRAV_MON,
         DCON_IVA_LOC,
         DCON_IVA_MON,
         DCON_IND_TIPO_IVA_COMPRA,
         DCON_OBS,
         DCON_EMPR)

      VALUES
        (1,
         V_CLAVE,
         495,
         18,
         V_FCON_TIPO_SALDO,
         IMPORTE * NVL(I_TASA_OFIC, 1),
         IMPORTE,
         0,
         0,
         0,
         0,
         1,
         OBSERVACION,
         I_EMPRESA);

      INSERT INTO FIN_PAGO
        (PAG_CLAVE_DOC,
         PAG_FEC_VTO,
         PAG_CLAVE_PAGO,
         PAG_FEC_PAGO,
         PAG_IMP_LOC,
         PAG_IMP_MON,
         PAG_LOGIN,
         PAG_FEC_GRAB,
         PAG_SIST,
         PAG_EMPR)
      VALUES
        (CLAVE_CUOTA,
         VENCIMIENTO,
         V_CLAVE,
         I_PDOC_FEC,
         IMPORTE * NVL(I_TASA_OFIC, 1),
         IMPORTE,
         GEN_DEVUELVE_USER,
         SYSDATE,
         'PER',
         I_EMPRESA);
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);

  END;

  PROCEDURE PP_INS_PER_DOC(IPDOC_CLAVE     IN NUMBER,
                           IPDOC_QUINCENA  IN NUMBER,
                           IPDOC_EMPLEADO  IN NUMBER,
                           IPDOC_FEC       IN DATE,
                           IPDOC_NRO_DOC   IN NUMBER,
                           IPDOC_FEC_GRAB  IN DATE,
                           IPDOC_LOGIN     IN VARCHAR2,
                           IPDOC_FORM      IN VARCHAR2,
                           IPDOC_PERIODO   IN NUMBER,
                           IPDOC_CLAVE_FIN IN NUMBER,
                           IPDOC_NRO_ITEM  IN NUMBER,
                           IPDOC_CONCEPTO  IN NUMBER,
                           IPDOC_IMPORTE   IN NUMBER,
                           I_MON           IN NUMBER,
                           I_EMPRESA       IN NUMBER,
                           I_TASA_OFIC     IN NUMBER) IS
  V_CONTADOR NUMBER :=0;
  V_CLAVE    NUMBER :=0;
  BEGIN
    
   SELECT COUNT(1)
    INTO V_CONTADOR
    FROM PER_DOCUMENTO
  WHERE PDOC_CLAVE = IPDOC_CLAVE
    AND PDOC_EMPR = I_EMPRESA;
    
    IF V_CONTADOR > 0 THEN
      V_CLAVE := FP_CLAVE_DOC(I_EMPRESA);
    ELSE
      V_CLAVE := IPDOC_CLAVE;
    END IF;
    
    INSERT INTO PER_DOCUMENTO
      (PDOC_CLAVE,
       PDOC_QUINCENA,
       PDOC_EMPLEADO,
       PDOC_FEC,
       PDOC_NRO_DOC,
       PDOC_FEC_GRAB,
       PDOC_LOGIN,
       PDOC_FORM,
       PDOC_PERIODO,
       PDOC_CLAVE_FIN,
       PDOC_MON,
       PDOC_EMPR)
    VALUES
      (IPDOC_CLAVE,
       IPDOC_QUINCENA,
       IPDOC_EMPLEADO,
       IPDOC_FEC,
       IPDOC_NRO_DOC,
       IPDOC_FEC_GRAB,
       IPDOC_LOGIN,
       IPDOC_FORM,
       IPDOC_PERIODO,
       IPDOC_CLAVE_FIN,
       I_MON,
       I_EMPRESA);

    INSERT INTO PER_DOCUMENTO_DET
      (PDDET_CLAVE_DOC,
       PDDET_ITEM,
       PDDET_CLAVE_CONCEPTO,
       PDDET_IMP,
       PDDET_IMP_LOC,
       PDDET_EMPR)
    VALUES
      (IPDOC_CLAVE,
       IPDOC_NRO_ITEM,
       IPDOC_CONCEPTO,
       IPDOC_IMPORTE,
       IPDOC_IMPORTE * NVL(I_TASA_OFIC, 1),
       I_EMPRESA);

  END;

  PROCEDURE PP_LLAMAR_REPORTE(I_CLAVE        IN NUMBER,
                              I_EMPRESA      IN NUMBER,
                              I_COD_SUCURSAL IN NUMBER,
                              V_PRI_CLAVE    IN NUMBER) IS

    V_PARAMETROS    VARCHAR2(32767);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    V_EMPR_DESC     VARCHAR2(50);
    V_DESC_SUCURSAL VARCHAR2(100);
    V_WHERE         VARCHAR2(32767);

  BEGIN
    BEGIN
      SELECT A.EMPR_RAZON_SOCIAL
        INTO V_EMPR_DESC
        FROM GEN_EMPRESA A
       WHERE A.EMPR_CODIGO = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN

        RAISE_APPLICATION_ERROR(-20016, 'Empresa no valida!');
    END;

    BEGIN
      SELECT SUC_DESC
        INTO V_DESC_SUCURSAL
        FROM GEN_SUCURSAL
       WHERE SUC_CODIGO = I_COD_SUCURSAL
         AND SUC_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    --  RAISE_APPLICATION_ERROR(-20001,'PRIMER: '||V_PRI_CLAVE||' SEGUNDO'||I_CLAVE);

    V_WHERE := V_WHERE || '  AND PDOC_CLAVE BETWEEN  ' || V_PRI_CLAVE ||
               ' AND ' || I_CLAVE;

    V_PARAMETROS := 'P_FORMATO=' || URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    URL_ENCODE(I_EMPRESA);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESCRIP_EMPR=' ||
                    URL_ENCODE(V_EMPR_DESC);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_PROGRAMA=' ||
                    URL_ENCODE('PERI034');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_SUCURSAL=' ||
                    URL_ENCODE(V_DESC_SUCURSAL);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESC_PROGRAMA=' ||
                    URL_ENCODE('GENERAR SALARIO JORNAL');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_WHERE=' ||
                    URL_ENCODE(V_WHERE);

    INSERT INTO X (CAMPO1, OTRO) VALUES (V_PARAMETROS, 'PERI034');
    COMMIT;

    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, 'PERI034', 'pdf');
    COMMIT;
    /*  EXCEPTION
       WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20001, SQLERRM);

    */
  END;

  PROCEDURE PP_BORRAR_DET(I_SEQ IN NUMBER) AS
  BEGIN

    APEX_COLLECTION.DELETE_MEMBER(P_COLLECTION_NAME => 'PERI247',
                                  P_SEQ             => I_SEQ);
    APEX_COLLECTION.RESEQUENCE_COLLECTION(P_COLLECTION_NAME => 'PERI247');

  END PP_BORRAR_DET;

END PERI247;
/
