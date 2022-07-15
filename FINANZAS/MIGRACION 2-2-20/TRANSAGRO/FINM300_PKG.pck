CREATE OR REPLACE PACKAGE FINM300_PKG IS

  -- AUTHOR  : PROGRAMACION9
  -- CREATED : 26/01/2021 15:22:55
  -- PURPOSE :

  -- PUBLIC TYPE DECLARATIONS

  PROCEDURE PP_CARGAR_DATOS              (I_EMPRESA                  IN NUMBER,
                                          BLOQ                       OUT NUMBER);
  FUNCTION FIN_PERSONA_RESTRINGIDA       (IN_PERSONA                 IN NUMBER,
                                          I_EMPRESA                  IN NUMBER) RETURN VARCHAR;
  PROCEDURE PP_TRAER_DESC_BANC           (I_CTA_BCO                  IN NUMBER,
                                          I_EMPRESA                  IN NUMBER,
                                          I_BCO_DESC                 OUT VARCHAR2);
  PROCEDURE PP_TRAER_DESC_MON_CTABANCARIA(I_EMPRESA                  IN NUMBER,
                                          I_MON_SIMBOLO              OUT VARCHAR2,
                                          I_CTA_MON                  IN NUMBER);
  PROCEDURE PP_MOSTRAR_TIPO_PERSONA      (I_TIPP_DESC                OUT VARCHAR2,
                                          I_PNA_TIPO                 IN NUMBER,
                                          I_EMPRESA                  IN NUMBER);
  PROCEDURE PP_TRAER_DESC_PAIS           (I_PNA_PAIS                 IN NUMBER,
                                          I_PAIS_DESC                OUT VARCHAR2,
                                          I_EMPRESA                  IN NUMBER);
  PROCEDURE PP_TRAER_DESC_SEGMENTO       (I_SEG_DESC                 OUT VARCHAR2,
                                          I_PNA_SEGMENTO             IN NUMBER,
                                          I_EMPRESA                  IN NUMBER);
  PROCEDURE PP_TRAER_DESC_SUCURSAL       (I_SUC_DESC                 OUT VARCHAR2,
                                          I_EMPRESA                  IN NUMBER,
                                          I_PNA_SUC                  IN NUMBER);
  PROCEDURE PP_MOSTRAR_VENDEDOR          (I_VEND_NOMBRE              OUT VARCHAR2,
                                          I_PNA_VENDEDOR             IN NUMBER,
                                          I_EMPRESA                  IN NUMBER);
  PROCEDURE PP_TRAER_TIPO_PROVEEDOR      (I_PROV_TIPO                IN NUMBER,
                                          I_EMPRESA                  IN NUMBER,
                                          I_TIPR_DESC                OUT VARCHAR2);
  PROCEDURE PP_TRAER_DESC_ZONA           (I_ZONA_DESC                OUT VARCHAR2,
                                          I_CLI_ZONA                 IN NUMBER,
                                          I_EMPRESA                  IN NUMBER);
  PROCEDURE PP_TRAER_DESC_CATE           (I_FCAT_DESC                OUT VARCHAR2,
                                          I_CLI_CATEG                IN NUMBER,
                                          I_EMPRESA                  IN NUMBER);
  PROCEDURE PP_TRAER_DESC_RAMO           (I_CLI_RAMO                 IN NUMBER,
                                          I_EMPRESA                  IN NUMBER,
                                          I_RAMO_DESC                OUT VARCHAR2);
  FUNCTION PA_CALCULAR_DV_11_A           (P_NUMERO                   IN VARCHAR2,
                                          P_BASEMAX                   IN NUMBER DEFAULT 11) RETURN NUMBER;
  PROCEDURE PP_TRAER_EMPLEADO            (I_CLI_CATEG                 IN NUMBER,
                                          I_CLI_COD_EMPL_EMPR_ORIG    IN NUMBER,
                                          I_S_CLI_COD_EMPL_EMPR_ORIG  OUT VARCHAR2);
  PROCEDURE PP_TRAER_DESC_MON            (I_EMPRESA                   IN NUMBER,
                                          I_CLI_MON                   IN NUMBER,
                                          I_MON_SIMBOLO               OUT VARCHAR2);
  PROCEDURE PP_CARGRA_FIN_CLI_CTA_BCO    (I_EMPRESA                   IN NUMBER,
                                          I_PNA_CODIGO                IN NUMBER);
  FUNCTION FP_REND_PROD                  (IN_PRODUCTO                 IN NUMBER,
                                          IN_CALIDAD                  IN NUMBER,
                                          IN_CANT_HA                  IN NUMBER) RETURN NUMBER;
  PROCEDURE PP_CARGAR_LOTES              (I_EMPRESA                   IN NUMBER,
                                          I_PNA_CODIGO                IN NUMBER);

  --=====LOTES
  PROCEDURE PP_MOSTRAR_CALIDAD_SUELO     (LOTE_CALIDAD_SUELO          IN NUMBER,
                                          I_EMPRESA                   IN NUMBER,
                                          CAL_DESC                    OUT VARCHAR2);
  PROCEDURE PP_MOSTRAR_LOCALIDAD         (LOC_DESC                    OUT VARCHAR2,
                                          DIST_DESC                   OUT VARCHAR2,
                                          LOTE_LOCALIDAD              IN NUMBER,
                                          I_EMPRESA                   IN NUMBER);
  PROCEDURE PP_MOSTRAR_STATUS            (LOTE_STATUS                 IN VARCHAR2,
                                          LOTE_STATUS_DESC            OUT VARCHAR2);
  PROCEDURE PP_MOSTRAR_TIPO_ALQUILER     (TIPO_DESC                   OUT VARCHAR2,
                                          I_EMPRESA                   IN NUMBER,
                                          LOTE_TIPO_ALQUILER          IN NUMBER);
  PROCEDURE PP_VALIDAR_NRO_DOC_CONYUGE   (I_PNA_CODIGO                IN NUMBER,
                                          I_PNA_DOC_IDENT_CONYUGE     IN VARCHAR2,
                                          I_EMPRESA                   IN NUMBER,
                                          I_PNA_NOMBRE                IN VARCHAR2);
  PROCEDURE PP_VALIDAR_DATOS;
  PROCEDURE PP_ACTUALIZAR_REGISTRO       (I_EMPRESA                   IN NUMBER,
                                          I_PNA_CODIGO                IN NUMBER,
                                          I_CLI_FEC_INGRESO           IN OUT DATE,
                                          I_PNA_LUGAR_ORIGEN_REPLICA  OUT VARCHAR2,
                                          I_PROV_LUGAR_ORIGEN_REPLICA OUT VARCHAR2,
                                          I_CLI_LUGAR_ORIGEN_REPLICA  OUT VARCHAR2,
                                          I_CLI_FEC_ACTUALIZACION     OUT DATE,
                                          I_CLI_MON                   IN OUT NUMBER,
                                          I_MON_LOC                   IN NUMBER);
  PROCEDURE PP_VAL_DAT_CTA_BCO           (I_EMPRESA                   IN NUMBER);
  PROCEDURE PP_BORRAR_FIN_CLI_CTA_BCO    (SEQ_ID_BCO                  IN NUMBER);
  PROCEDURE PP_BORRAR_LOTE               (SEQ_AREA                    IN NUMBER);
  PROCEDURE PP_BORRAR_REGISTRO ;

END FINM300_PKG;
/
CREATE OR REPLACE PACKAGE BODY FINM300_PKG IS
  PROCEDURE PP_CARGAR_DATOS(I_EMPRESA IN NUMBER, BLOQ OUT NUMBER) IS
    V_VER_CATEG          VARCHAR(1);
    V_MON_LOC            NUMBER;
    V_CANT_DECIMALES_LOC NUMBER;
    V_SIMBOLO_MON_LOC    VARCHAR2(10);
    V_HAB_FACT_COMB_GS   VARCHAR2(10);
    V_OPER_RET           VARCHAR2(10);
    V_OPEM_MOD_ESTADO_CLI VARCHAR2(10);
  BEGIN

    SELECT CONF_MON_LOC
      INTO V_MON_LOC
      FROM GEN_CONFIGURACION
     WHERE CONF_EMPR = I_EMPRESA;

    APEX_UTIL.SET_SESSION_STATE('P6507_MON_LOC', V_MON_LOC);

    SELECT MON_DEC_IMP, MON_SIMBOLO
      INTO V_CANT_DECIMALES_LOC, V_SIMBOLO_MON_LOC
      FROM GEN_MONEDA
     WHERE MON_CODIGO = V_MON_LOC
       AND MON_EMPR = I_EMPRESA;

    APEX_UTIL.SET_SESSION_STATE('P6507_CANT_DECIMALES_LOC',
                                V_CANT_DECIMALES_LOC);
    APEX_UTIL.SET_SESSION_STATE('P6507_SIMBOLO_MON_LOC', V_SIMBOLO_MON_LOC);

    G.CARGAR_RENDIMIENTOS;

    --CONTROL PARA VER SI EL USUARIO PUEDE HABILITAR AL CLIENTE PARA EMITIR FACTURA EN GS.
    SELECT OPEM_IND_FACT_COMB_GS,
           OPEM_IND_MOD_RET_PER,
           NVL(OPEM_ACC_CATEGORIA_CLIENTE, 'N')
      INTO V_HAB_FACT_COMB_GS, V_OPER_RET, V_VER_CATEG

      FROM GEN_OPERADOR, GEN_OPERADOR_EMPRESA
     WHERE OPEM_OPER = OPER_CODIGO
       AND OPEM_EMPR = I_EMPRESA
       AND OPER_LOGIN = GEN_DEVUELVE_USER;

    APEX_UTIL.SET_SESSION_STATE('P6507_HAB_FACT_COMB_GS',
                                V_HAB_FACT_COMB_GS);
    APEX_UTIL.SET_SESSION_STATE('P6507_OPER_RET', V_OPER_RET);
    --
    IF V_VER_CATEG = 'S' THEN
      /*SET_ITEM_PROPERTY('FIN_PERSONA.PNA_SEGMENTO'    , VISIBLE, PROPERTY_TRUE);
      SET_ITEM_PROPERTY('FIN_PERSONA.PNA_SEGMENTO'    , ENABLED, PROPERTY_TRUE);
      SET_ITEM_PROPERTY('FIN_PERSONA.SEG_DESC'    , VISIBLE, PROPERTY_TRUE);*/
      BLOQ := 1;
    END IF;
    --
    IF NVL(V_HAB_FACT_COMB_GS, 'N') = 'S' OR
       GEN_DEVUELVE_USER IN ('RONNY', 'ADCS') THEN
      /* SET_ITEM_PROPERTY('CLI_FACT_COMB_GS',ENABLED,PROPERTY_TRUE);
      SET_ITEM_PROPERTY('CLI_FACT_COMB_GS',NAVIGABLE,PROPERTY_TRUE);
      SET_ITEM_PROPERTY('CLI_FACT_COMB_GS',UPDATEABLE,PROPERTY_TRUE);

      SET_ITEM_PROPERTY('CLI_PORC_FLETE',ENABLED,PROPERTY_TRUE);
      SET_ITEM_PROPERTY('CLI_PORC_FLETE',NAVIGABLE,PROPERTY_TRUE);
      SET_ITEM_PROPERTY('CLI_PORC_FLETE',UPDATEABLE,PROPERTY_TRUE);*/
      BLOQ := 2;
    ELSE
      BLOQ := 3;
      /*SET_ITEM_PROPERTY('CLI_FACT_COMB_GS',ENABLED,PROPERTY_FALSE);
      SET_ITEM_PROPERTY('CLI_PORC_FLETE',ENABLED,PROPERTY_FALSE);*/
    END IF;

    IF NVL(V_OPER_RET, 'N') = 'S' OR GEN_DEVUELVE_USER IN ('RONNY') THEN
      BLOQ := 4;
      /* SET_ITEM_PROPERTY('bprov.prov_ind_retencion',ENABLED,PROPERTY_TRUE);
      SET_ITEM_PROPERTY('bprov.prov_ind_retencion',NAVIGABLE,PROPERTY_TRUE);
      SET_ITEM_PROPERTY('bprov.prov_ind_retencion',UPDATEABLE,PROPERTY_TRUE);*/
    ELSE
      BLOQ := 5;
      /* SET_ITEM_PROPERTY('bprov.prov_ind_retencion',ENABLED,PROPERTY_FALSE);
      SET_ITEM_PROPERTY('bprov.prov_ind_retencion',ENABLED,PROPERTY_FALSE);*/
    END IF;

  END;
  FUNCTION FIN_PERSONA_RESTRINGIDA(IN_PERSONA IN NUMBER,
                                   I_EMPRESA  IN NUMBER) RETURN VARCHAR IS
    V_CODIGO NUMBER := 0;

  BEGIN

    IF IN_PERSONA IS NOT NULL THEN
      SELECT NVL(MAX(FPC.FPC_PNA), 0)
        INTO V_CODIGO
        FROM FIN_PNA_CTA FPC
       WHERE FPC.FPC_PNA = IN_PERSONA
         AND FPC.FPC_EMPR = I_EMPRESA
         AND FPC.FPC_OPERADOR IN
             (SELECT OPER_CODIGO
                FROM GEN_OPERADOR O
               WHERE OPER_LOGIN = GEN_DEVUELVE_USER);
    END IF;
    IF V_CODIGO > 0 THEN
      RETURN('S');
    ELSE
      RETURN('N');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN('N');
  END FIN_PERSONA_RESTRINGIDA;

  PROCEDURE PP_TRAER_DESC_BANC(I_CTA_BCO  IN NUMBER,
                               I_EMPRESA  IN NUMBER,
                               I_BCO_DESC OUT VARCHAR2) IS
  BEGIN
    IF I_CTA_BCO IS NOT NULL THEN
      SELECT BCO_DESC
        INTO I_BCO_DESC
        FROM FIN_BANCO
       WHERE BCO_CODIGO = I_CTA_BCO
         AND BCO_EMPR = I_EMPRESA;
    ELSE
      I_BCO_DESC := NULL;
    END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_BCO_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'Banco inexistente!');
  END;

  PROCEDURE PP_TRAER_DESC_MON_CTABANCARIA(I_EMPRESA     IN NUMBER,
                                          I_MON_SIMBOLO OUT VARCHAR2,
                                          I_CTA_MON     IN NUMBER) IS
  BEGIN
    IF I_CTA_MON IS NOT NULL THEN
      SELECT MON_SIMBOLO
        INTO I_MON_SIMBOLO
        FROM GEN_MONEDA
       WHERE MON_CODIGO = I_CTA_MON
         AND MON_EMPR = I_EMPRESA;
    ELSE
      I_MON_SIMBOLO := NULL;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_MON_SIMBOLO := NULL;
  END;
  PROCEDURE PP_MOSTRAR_TIPO_PERSONA(I_TIPP_DESC OUT VARCHAR2,
                                    I_PNA_TIPO  IN NUMBER,
                                    I_EMPRESA   IN NUMBER) IS
  BEGIN

    SELECT TIPP_DESC
      INTO I_TIPP_DESC
      FROM FIN_TIPO_PERSONA
     WHERE TIPP_CODIGO = I_PNA_TIPO
       AND TIPP_EMPR = I_EMPRESA;
--RAISE_APPLICATION_ERROR(-20005, 'Tipo inexistente!');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_TIPP_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20005, 'Tipo inexistente!');

  END;

  PROCEDURE PP_TRAER_DESC_PAIS(I_PNA_PAIS  IN NUMBER,
                               I_PAIS_DESC OUT VARCHAR2,
                               I_EMPRESA   IN NUMBER) IS
  BEGIN
    IF I_PNA_PAIS IS NOT NULL THEN
      SELECT PAIS_DESC
        INTO I_PAIS_DESC
        FROM GEN_PAIS
       WHERE PAIS_CODIGO = I_PNA_PAIS
         AND PAIS_EMPR = I_EMPRESA;
    ELSE
      I_PAIS_DESC := NULL;
    END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_PAIS_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20006, 'Pa??s inexistente!');
  END;

  PROCEDURE PP_TRAER_DESC_SEGMENTO(I_SEG_DESC     OUT VARCHAR2,
                                   I_PNA_SEGMENTO IN NUMBER,
                                   I_EMPRESA      IN NUMBER) IS
  BEGIN

    SELECT SEG_DESC
      INTO I_SEG_DESC
      FROM FIN_SEGMENTO
     WHERE SEG_CODIGO = I_PNA_SEGMENTO
       AND SEG_EMPR = I_EMPRESA;

  EXCEPTION

    WHEN NO_DATA_FOUND THEN
      I_SEG_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20007, 'Segmento inexistente!');

  END;
  PROCEDURE PP_TRAER_DESC_SUCURSAL(I_SUC_DESC OUT VARCHAR2,
                                   I_EMPRESA  IN NUMBER,
                                   I_PNA_SUC  IN NUMBER) IS
  BEGIN

    SELECT SUC_DESC
      INTO I_SUC_DESC
      FROM GEN_SUCURSAL
     WHERE SUC_EMPR = I_EMPRESA
       AND SUC_CODIGO = I_PNA_SUC;

  EXCEPTION

    WHEN NO_DATA_FOUND THEN
      I_SUC_DESC := NULL;
      RAISE_APPLICATION_ERROR(20008, 'Sucursal inexistente!');
  END;
  PROCEDURE PP_MOSTRAR_VENDEDOR(I_VEND_NOMBRE  OUT VARCHAR2,
                                I_PNA_VENDEDOR IN NUMBER,
                                I_EMPRESA      IN NUMBER) IS
  BEGIN

    SELECT EMPL_NOMBRE || NVL(EMPL_APE, '')
      INTO I_VEND_NOMBRE

      FROM PER_EMPLEADO, FAC_VENDEDOR

     WHERE EMPL_LEGAJO = VEND_LEGAJO
       AND VEND_LEGAJO = I_PNA_VENDEDOR
       AND VEND_EMPR = EMPL_EMPRESA
       AND VEND_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_VEND_NOMBRE := NULL;
      RAISE_APPLICATION_ERROR(-20009, 'Vendedor inexistente!');
  END;

  PROCEDURE PP_TRAER_TIPO_PROVEEDOR(I_PROV_TIPO IN NUMBER,
                                    I_EMPRESA   IN NUMBER,
                                    I_TIPR_DESC OUT VARCHAR2) IS
  BEGIN
    IF I_PROV_TIPO IS NOT NULL THEN
      SELECT TIPR_DESC
        INTO I_TIPR_DESC
        FROM FIN_TIPO_PROVEEDOR
       WHERE TIPR_CODIGO = I_PROV_TIPO
         AND TIPR_EMPR = I_EMPRESA;
    ELSE
      I_TIPR_DESC := NULL;
    END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_TIPR_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20011, 'Tipo inexistente!');
  END;

  PROCEDURE PP_TRAER_DESC_ZONA(I_ZONA_DESC OUT VARCHAR2,
                               I_CLI_ZONA  IN NUMBER,
                               I_EMPRESA   IN NUMBER) IS
  BEGIN
    IF I_CLI_ZONA IS NOT NULL THEN
      SELECT ZONA_DESC
        INTO I_ZONA_DESC
        FROM FAC_ZONA
       WHERE ZONA_CODIGO = I_CLI_ZONA
         AND ZONA_EMPR = I_EMPRESA;
    END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_ZONA_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20012, 'Zona inexistente!');
  END;

  PROCEDURE PP_TRAER_DESC_CATE(I_FCAT_DESC OUT VARCHAR2,
                               I_CLI_CATEG IN NUMBER,
                               I_EMPRESA   IN NUMBER) IS
  BEGIN
    SELECT FCAT_DESC
      INTO I_FCAT_DESC
      FROM FAC_CATEGORIA
     WHERE FCAT_CODIGO = I_CLI_CATEG
       AND FCAT_EMPR = I_EMPRESA;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_FCAT_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20014, 'Categor??a inexistente!');
  END;

  PROCEDURE PP_TRAER_DESC_RAMO(I_CLI_RAMO  IN NUMBER,
                               I_EMPRESA   IN NUMBER,
                               I_RAMO_DESC OUT VARCHAR2) IS
  BEGIN
    IF I_CLI_RAMO IS NOT NULL THEN
      SELECT RAMO_DESC
        INTO I_RAMO_DESC
        FROM FIN_RAMO
       WHERE RAMO_CODIGO = I_CLI_RAMO
         AND RAMO_EMPR = I_EMPRESA;
    END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_RAMO_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20016, 'Ramo de actividad inexistente!');

  END;

  FUNCTION PA_CALCULAR_DV_11_A(P_NUMERO  IN VARCHAR2,
                               P_BASEMAX IN NUMBER DEFAULT 11) RETURN NUMBER IS
    /*
        CALCULA DIGITO VERIFICADOR NUMERICO CON ENTRADA ALFANUMERICA Y BASEMAX 11
    */
    V_TOTAL      NUMBER(6);
    V_RESTO      NUMBER(2);
    K            NUMBER(2);
    V_NUMERO_AUX NUMBER(1);
    V_NUMERO_AL  VARCHAR2(255);
    V_CARACTER   VARCHAR2(1);
    V_DIGIT      NUMBER;
  BEGIN
    -- CAMBIA LA ULTIMA LETRA POR ASCII EN CASO QUE LA CEDULA TERMINE EN LETRA
    IF P_NUMERO IS NOT NULL THEN
      FOR I IN 1 .. LENGTH(P_NUMERO) LOOP
        V_CARACTER := UPPER(SUBSTR(P_NUMERO, I, 1));
        IF ASCII(V_CARACTER) NOT BETWEEN 48 AND 57 THEN
          -- DE 0 A 9
          V_NUMERO_AL := V_NUMERO_AL || ASCII(V_CARACTER);
        ELSE
          V_NUMERO_AL := V_NUMERO_AL || V_CARACTER;
        END IF;

      END LOOP;
      -- CALCULA EL DV
      K       := 2;
      V_TOTAL := 0;

      FOR I IN REVERSE 1 .. LENGTH(V_NUMERO_AL) LOOP
        IF K > P_BASEMAX THEN
          K := 2;
        END IF;
        V_NUMERO_AUX := TO_NUMBER(SUBSTR(V_NUMERO_AL, I, 1));
        V_TOTAL      := V_TOTAL + (V_NUMERO_AUX * K);
        K            := K + 1;
      END LOOP;

      V_RESTO := MOD(V_TOTAL, 11);

      IF V_RESTO > 1 THEN
        V_DIGIT := 11 - V_RESTO;
      ELSE
        V_DIGIT := 0;
      END IF;
    END IF;
    RETURN V_DIGIT;

  END;
  PROCEDURE PP_TRAER_EMPLEADO(I_CLI_CATEG                IN NUMBER,
                              I_CLI_COD_EMPL_EMPR_ORIG   IN NUMBER,
                              I_S_CLI_COD_EMPL_EMPR_ORIG OUT VARCHAR2) IS

    SALIR EXCEPTION;
  BEGIN
    IF I_CLI_CATEG NOT IN (4, 5) THEN
      RAISE SALIR;
    ELSE
      IF I_CLI_COD_EMPL_EMPR_ORIG IS NULL THEN
        RAISE_APPLICATION_ERROR(-20005,
                                'Codigo de empleado no puede quedar en blanco');
      END IF;
    END IF;

    IF I_CLI_CATEG = 4 THEN

      SELECT T.NOMBRE
        INTO I_S_CLI_COD_EMPL_EMPR_ORIG
        FROM FIN_EMPLEADOS_HILAGRO T
       WHERE EMPL_LEGAJO = I_CLI_COD_EMPL_EMPR_ORIG
         AND EMPL_EMPRESA = 1;

    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_S_CLI_COD_EMPL_EMPR_ORIG := NULL;
      RAISE_APPLICATION_ERROR(-20006, 'Codigo de empleado inexistente');
    WHEN SALIR THEN
      I_S_CLI_COD_EMPL_EMPR_ORIG := NULL;

  END;

  PROCEDURE PP_TRAER_DESC_MON(I_EMPRESA     IN NUMBER,
                              I_CLI_MON     IN NUMBER,
                              I_MON_SIMBOLO OUT VARCHAR2) IS
  BEGIN
    SELECT MON_SIMBOLO
      INTO I_MON_SIMBOLO
      FROM GEN_MONEDA
     WHERE MON_CODIGO = I_CLI_MON
       AND MON_EMPR = I_EMPRESA;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_MON_SIMBOLO := NULL;
  END;

  PROCEDURE PP_CARGRA_FIN_CLI_CTA_BCO(I_EMPRESA    IN NUMBER,
                                      I_PNA_CODIGO IN NUMBER) IS

  BEGIN
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'FIN_CLI_CTA_BCO');
    FOR C IN (SELECT T.CTA_CLI,
                     T.CTA_BCO,
                     C.BCO_DESC,
                     T.CTA_NRO,
                     T.CTA_TITULAR,
                     T.CTA_TITULAR_CI,
                     T.CTA_EMPR,
                     T.CTA_MON,
                     G.MON_SIMBOLO,
                     T.CTA_PREDET
                FROM FIN_CLI_CTA_BANC T, FIN_BANCO C, GEN_MONEDA G
               WHERE T.CTA_EMPR = I_EMPRESA
                 AND T.CTA_BCO = C.BCO_CODIGO
                 AND T.CTA_EMPR = C.BCO_EMPR
                 AND T.CTA_MON = G.MON_CODIGO
                 AND T.CTA_EMPR = G.MON_EMPR
                 AND CTA_CLI = I_PNA_CODIGO) LOOP

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'FIN_CLI_CTA_BCO',
                                 P_N001            => C.CTA_CLI,
                                 P_N002            => C.CTA_BCO,
                                 P_C001            => C.BCO_DESC,
                                 P_C007            => C.CTA_NRO,
                                 P_C002            => C.CTA_TITULAR,
                                 P_C003            => C.CTA_TITULAR_CI,
                                 P_N004            => C.CTA_EMPR,
                                 P_C004            => C.CTA_MON,
                                 P_C005            => C.MON_SIMBOLO,
                                 P_C006            => C.CTA_PREDET);
    END LOOP;
  END;

  FUNCTION FP_REND_PROD(IN_PRODUCTO IN NUMBER,
                        IN_CALIDAD  IN NUMBER,
                        IN_CANT_HA  NUMBER) RETURN NUMBER IS

    V_RET NUMBER := 0;

  BEGIN
    BEGIN
      -- CALL THE PROCEDURE
      G.CARGAR_RENDIMIENTOS;
    END;

    IF IN_CALIDAD = 1 THEN
      V_RET := G.V_TAB_RENDIM_PROD(IN_PRODUCTO).REND_EXCELENTE_TON;
    ELSIF IN_CALIDAD = 2 THEN
      V_RET := G.V_TAB_RENDIM_PROD(IN_PRODUCTO).REND_BUENO_TON;
    ELSIF IN_CALIDAD = 3 THEN
      V_RET := G.V_TAB_RENDIM_PROD(IN_PRODUCTO).REND_MALO;
    ELSIF IN_CALIDAD = 4 THEN
      V_RET := G.V_TAB_RENDIM_PROD(IN_PRODUCTO).REND_NO_EVALUADO;
    END IF;

    RETURN ROUND(V_RET * IN_CANT_HA, 2);
    /*
    EXCEPTION
      WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20002,'Error en FP_REND_PROD!');
           RETURN V_RET;*/

  END;

  PROCEDURE PP_CARGAR_LOTES(I_EMPRESA IN NUMBER, I_PNA_CODIGO IN NUMBER) IS
  BEGIN
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'AREA');
    FOR V IN (SELECT LOTE_PERSONA,
                     LOTE_NUMERO,
                     TO_CHAR(LOTE_LOCALIDAD) LOTE_LOCALIDAD,
                     LOC_DESC,
                     LOTE_OBS_LOC,
                     LOTE_TAM_HAS,
                     LOTE_STATUS,
                     DECODE(LOTE_STATUS, 'P', 'PROPIO', 'A', 'ALQUILADO') LOTE_STATUS_DESC,
                     LOTE_IND_HIPOTECA,
                     LOTE_NOM_HIPOTECA,
                     LOTE_TIPO_ALQUILER,
                     LOTE_CALIDAD_SUELO,
                     CAL_DESC,
                     FINM300_PKG.FP_REND_PROD(1,
                                              LOTE_CALIDAD_SUELO,
                                              LOTE_TAM_HAS) LOTE_HAS_SOJA,
                     FINM300_PKG.FP_REND_PROD(2,
                                              LOTE_CALIDAD_SUELO,
                                              LOTE_TAM_HAS) LOTE_HAS_SOJA_Z,
                     FINM300_PKG.FP_REND_PROD(3,
                                              LOTE_CALIDAD_SUELO,
                                              LOTE_TAM_HAS) LOTE_HAS_MAIZ,
                     FINM300_PKG.FP_REND_PROD(4,
                                              LOTE_CALIDAD_SUELO,
                                              LOTE_TAM_HAS) LOTE_HAS_TRIGO,
                     LOTE_LUGAR_ORIGEN,
                     LOTE_EMPR,
                     J.TIPO_DESC,
                     DIST_DESC,
                     '<span class="fa fa-minus-square" aria-hidden="true"></span>' BORRAR
                FROM FIN_LOTE_PRODUCTOR T,
                     GEN_LOCALIDAD,
                     GEN_DISTRITO,
                     ACO_CALIDAD_SUELO,
                     FIN_TIPO_ALQ_PROD  J
               WHERE LOC_DISTRITO = DIST_CODIGO
                 AND LOC_EMPR = DIST_EMPR
                 AND LOTE_PERSONA = I_PNA_CODIGO
                 AND T.LOTE_EMPR = I_EMPRESA
                 AND T.LOTE_LOCALIDAD = LOC_CODIGO
                 AND LOC_EMPR = T.LOTE_EMPR
                 AND CAL_CODIGO = LOTE_CALIDAD_SUELO
                 AND CAL_EMPR = LOTE_EMPR
                 AND T.LOTE_TIPO_ALQUILER = J.TIPO_CODIGO(+)
                 AND T.LOTE_EMPR = J.TIPO_EMPR(+)
              /*UNION ALL
              SELECT NULL LOTE_PERSONA,
                     MAX(LOTE_NUMERO) MAX_LOTE_NUMERO,
                     'Distrito:' LOTE_LOCALIDAD,
                     H.DIST_DESC,
                     'Hectareas' LOTE_OBS_LOC,
                     SUM(LOTE_TAM_HAS) LOTE_TAM_HAS_SUM,
                     NULL LOTE_STATUS,
                     NULL LOTE_STATUS_DESC,
                     NULL LOTE_IND_HIPOTECA,
                     NULL LOTE_NOM_HIPOTECA,
                     NULL LOTE_TIPO_ALQUILER,
                     NULL LOTE_CALIDAD_SUELO,
                     'Totales' CAL_DESC,
                     SUM(FINM300_PKG.FP_REND_PROD(1,
                                                  LOTE_CALIDAD_SUELO,
                                                  LOTE_TAM_HAS)) LOTE_HAS_SOJA_SUM,
                     SUM(FINM300_PKG.FP_REND_PROD(2,
                                                  LOTE_CALIDAD_SUELO,
                                                  LOTE_TAM_HAS)) LOTE_HAS_SOJA_Z_SUM,
                     SUM(FINM300_PKG.FP_REND_PROD(3,
                                                  LOTE_CALIDAD_SUELO,
                                                  LOTE_TAM_HAS)) LOTE_HAS_MAIZ_SUM,
                     SUM(FINM300_PKG.FP_REND_PROD(4,
                                                  LOTE_CALIDAD_SUELO,
                                                  LOTE_TAM_HAS)) LOTE_HAS_TRIGO_SUM,
                     NULL LOTE_LUGAR_ORIGEN,
                     NULL LOTE_EMPR,
                     NULL,
                     NULL,
                     NULL
                FROM FIN_LOTE_PRODUCTOR T,
                     GEN_LOCALIDAD,
                     GEN_DISTRITO       H,
                     ACO_CALIDAD_SUELO
               WHERE LOC_DISTRITO = DIST_CODIGO
                 AND LOC_EMPR = DIST_EMPR
                 AND T.LOTE_PERSONA = I_PNA_CODIGO
                 AND T.LOTE_EMPR = I_EMPRESA
                 AND T.LOTE_LOCALIDAD = LOC_CODIGO
                 AND LOC_EMPR = LOTE_EMPR
                 AND CAL_CODIGO = LOTE_CALIDAD_SUELO
                 AND CAL_EMPR = LOTE_EMPR

               GROUP BY DIST_DESC*/
              ) LOOP

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'AREA',
                                 P_N001            => V.LOTE_PERSONA,
                                 P_N002            => V.LOTE_NUMERO,
                                 P_C001            => V.LOTE_LOCALIDAD,
                                 P_C002            => V.LOC_DESC,
                                 P_C003            => V.LOTE_OBS_LOC,
                                 P_N003            => V.LOTE_TAM_HAS,
                                 P_C004            => V.LOTE_STATUS,
                                 P_C005            => V.LOTE_STATUS_DESC,
                                 P_C006            => V.LOTE_IND_HIPOTECA,
                                 P_C007            => V.LOTE_NOM_HIPOTECA,
                                 P_C008            => V.LOTE_TIPO_ALQUILER,
                                 P_C009            => V.LOTE_CALIDAD_SUELO,
                                 P_C010            => V.CAL_DESC,
                                 P_C011            => V.LOTE_HAS_SOJA,
                                 P_C012            => V.LOTE_HAS_SOJA_Z,
                                 P_C013            => V.LOTE_HAS_MAIZ,
                                 P_C014            => V.LOTE_HAS_TRIGO,
                                 P_C015            => V.LOTE_LUGAR_ORIGEN,
                                 P_C016            => V.LOTE_EMPR,
                                 P_C017            => V.TIPO_DESC,
                                 P_C018            => V.DIST_DESC,
                                 P_C019            => V.BORRAR);

    END LOOP;

  END;

  --=========LOTES
  PROCEDURE PP_MOSTRAR_CALIDAD_SUELO(LOTE_CALIDAD_SUELO IN NUMBER,
                                     I_EMPRESA          IN NUMBER,
                                     CAL_DESC           OUT VARCHAR2) IS
  BEGIN
    IF LOTE_CALIDAD_SUELO IS NOT NULL THEN
      SELECT CAL_DESC
        INTO CAL_DESC
        FROM ACO_CALIDAD_SUELO
       WHERE CAL_CODIGO = LOTE_CALIDAD_SUELO
         AND CAL_EMPR = I_EMPRESA;
    ELSE
      CAL_DESC := NULL;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      CAL_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'Calidad inexistente!');
  END;

  PROCEDURE PP_MOSTRAR_LOCALIDAD(LOC_DESC       OUT VARCHAR2,
                                 DIST_DESC      OUT VARCHAR2,
                                 LOTE_LOCALIDAD IN NUMBER,
                                 I_EMPRESA      IN NUMBER) IS
  BEGIN
    SELECT LOC_DESC, DIST_DESC
      INTO LOC_DESC, DIST_DESC
      FROM GEN_LOCALIDAD, GEN_DISTRITO
     WHERE LOC_DISTRITO = DIST_CODIGO
       AND LOC_CODIGO = LOTE_LOCALIDAD
       AND LOC_EMPR = DIST_EMPR
       AND LOC_EMPR = I_EMPRESA;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002, 'Localidad inexistente!');
  END;

  PROCEDURE PP_MOSTRAR_STATUS(LOTE_STATUS      IN VARCHAR2,
                              LOTE_STATUS_DESC OUT VARCHAR2) IS
  BEGIN
    IF LOTE_STATUS = 'P' THEN
      LOTE_STATUS_DESC := 'PROPIO';
    ELSIF LOTE_STATUS = 'A' THEN
      LOTE_STATUS_DESC := 'ALQUILADO';
    ELSE
      RAISE_APPLICATION_ERROR(-20003,
                              'Status inexistente. Ingrese P=Propio ?? A=Alquilado!');
    END IF;
  END;

  PROCEDURE PP_MOSTRAR_TIPO_ALQUILER(TIPO_DESC          OUT VARCHAR2,
                                     I_EMPRESA          IN NUMBER,
                                     LOTE_TIPO_ALQUILER IN NUMBER) IS
  BEGIN

    SELECT TIPO_DESC
      INTO TIPO_DESC
      FROM FIN_TIPO_ALQ_PROD
     WHERE TIPO_CODIGO = LOTE_TIPO_ALQUILER
       AND TIPO_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      TIPO_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20004, 'Tipo de Alquiler inexistente!');
  END;

  PROCEDURE PP_VALIDAR_NRO_DOC_CONYUGE(I_PNA_CODIGO            IN NUMBER,
                                       I_PNA_DOC_IDENT_CONYUGE IN VARCHAR2,
                                       I_EMPRESA               IN NUMBER,
                                       I_PNA_NOMBRE            IN VARCHAR2) IS
  BEGIN
    FOR R IN (SELECT PNA_CODIGO, PNA_NOMBRE
                FROM FIN_PERSONA
               WHERE PNA_CODIGO <> I_PNA_CODIGO
                 AND PNA_DOC_IDENT_CONYUGE = I_PNA_DOC_IDENT_CONYUGE
                 AND PNA_EMPR = I_EMPRESA
                 AND PNA_DOC_IDENT_CONYUGE NOT IN ('99999901', 99999901) --RUC PARA PROVEEDORES DEL BRASIL, PEDIDO DE BUENA. 29/01/2020. NO DEBE BLOQUEAR.
              ) LOOP
      RAISE_APPLICATION_ERROR(-20010,
                              'No puede asignar ??ste numero de documento como conyuge de ' ||
                              I_PNA_NOMBRE ||
                              ' pues ya est?? asignado como conyuge de ' ||
                              R.PNA_NOMBRE || '[' || R.PNA_CODIGO || ']!');
    END LOOP;

  END;

  PROCEDURE PP_VALIDAR_DATOS IS
  BEGIN

    --CONTROL DE FECHA DE NACIMIENTO PARA PRODUCTORES.

    IF v('P6507_PNA_FEC_NAC') IS NULL AND v('P6507_CLI_CATEG') = 1 THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'La fecha de nacimiento para el productor es requerida!');
    END IF;

    /* IF v('P6507_PNA_DOM_LATITUD_GRA') IS NOT NULL OR
       v('P6507_PNA_DOM_LATITUD_MIN') IS NOT NULL OR
       v('P6507_PNA_DOM_LONGITUD_GRA') IS NOT NULL OR
       v('P6507_PNA_DOM_LONGITUD_MIN') IS NOT NULL THEN

      IF v('P6507_PNA_DOM_LATITUD_GRA') IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004,
                                'Debe ingresar en forma completa los datos de coordenada del domicilio!');
      END IF;

      IF v('P6507_PNA_DOM_LATITUD_MIN') IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004,
                                'Debe ingresar en forma completa los datos de coordenada del domicilio!');
      END IF;

      IF v('P6507_PNA_DOM_LONGITUD_GRA') IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004,
                                'Debe ingresar en forma completa los datos de coordenada del domicilio!');
      END IF;

      IF v('P6507_PNA_DOM_LONGITUD_MIN') IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004,
                                'Debe ingresar en forma completa los datos de coordenada del domicilio!');
      END IF;

    END IF;*/

    IF v('P6507_PNA_TIPO') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Ingrese el tipo de persona!');
    END IF;

    IF v('P6507_PNA_CODIGO') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'No puede ser nulo!');
    END IF;

    IF v('P6507_PNA_NOMBRE') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'El nombre de la persona no puede ser nula!');
    END IF;

    IF v('P6507_PNA_TIPO') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Ingrese el tipo de persona!');
    END IF;

    IF v('P6507_PNA_PAIS') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Pais no puede ser nulo!');
    END IF;

    IF NVL(v('P6507_PNA_RUC_DV'), v('P6507_PNA_RUC_DV_AUX')) IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Ruc no puede ser nulo!');
    END IF;

    IF v('P6507_PNA_DIRECCION') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Direccion no puede ser nula!');
    END IF;

    IF v('P6507_PNA_FEC_NAC') IS NULL AND v('P_SUCURSAL') <> 7 THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'Fecha Nacimiento no puede ser nula!');
    END IF;

    IF v('P6507_PNA_TELEFONO') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Telefono no puede ser nulo!');
    END IF;
    IF v('P6507_PNA_EMAIL_TESO') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'El email para el banco no puede ser nulo!');
    END IF;
    IF v('P6507_PNA_SUC') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Sucursal no puede ser nulo!');
    END IF;

    IF v('P6507_PNA_VENDEDOR') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Responsable no puede ser nulo!');
    END IF;

    /*IF v('P6507_PNA_DOC_IDENT_CONYUGE') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'El elemento no puede ser nulo!');
    END IF;*/
    /*IF v('P6507_PROV_TIMBRADO') IS NULL THEN
       RAISE_APPLICATION_ERROR(-20004, 'El timbrado no puede ser nulo!');
     END IF;
    IF v('P6507_PROV_CONTADOR_NOMB') IS NULL THEN
       RAISE_APPLICATION_ERROR(-20004,
                               'El nombre del contador no puede ser nulo!');
     END IF;*/
    IF v('P6507_PROV_EST_PROV') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'El estado del proveedor no puede ser nulo!');
    END IF;

    IF v('P6507_PROV_TIPO') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'El tipo de proveedor no puede ser nulo!');
    END IF;

    IF v('P6507_CLI_ZONA') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Zona no puede ser nulo!');
    END IF;

    IF v('P6507_CLI_CATEG') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Categoria no puede ser nulo!');
    END IF;

    IF v('P6507_CLI_RAMO') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'Actividad no puede ser nulo!');
    END IF;

    /*IF v('P6507_CLI_IMP_LIM_CR') IS NULL THEN
          RAISE_APPLICATION_ERROR(-20004,
                                  'Limite de credito no puede ser nulo!');
        END IF;
    */
    IF v('P6507_CLI_BLOQ_LIM_CR') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'Bloqueo de credito no puede ser nulo!');
    END IF;

    IF v('P6507_CLI_EST_CLI') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004,
                              'Estado de cliente no puede ser nulo!');
    END IF;

     IF v('P6507_PNA_DOC_TIPO')  IS  NULL THEN
        RAISE_APPLICATION_ERROR(-20004,
                              'El tipo de documento no puede ser nulo!');

     END IF;




    IF NVL(v('P6507_PNA_DV'), v('P6507_PNA_DV_AUX')) IS NULL  and v('P6507_PNA_DOC_TIPO')  = 2 THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Digito Verificador no puede ser nulo!');
    END IF;

    IF v('P6507_PNA_CODIGO') IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Ingrese el codigo de persona para guardar!');
    END IF;

    DECLARE
      V_CONTADOR NUMBER := 0;
    BEGIN
      SELECT COUNT(1)
        INTO V_CONTADOR
        FROM FIN_CLIENTE C, PER_EMPLEADO E
       WHERE C.CLI_RUC_DV(+) = TO_CHAR(E.EMPL_DOC_IDENT)
         AND E.EMPL_SITUACION = 'A'
         AND TO_CHAR(E.EMPL_DOC_IDENT) = V('P6507_PNA_RUC_DV');

      IF V_CONTADOR > 0 THEN
        IF V('P6507_CLI_CATEG') NOT IN (3, 4, 5, 10) THEN
          RAISE_APPLICATION_ERROR(-20013,
                                  'Este cliente no puede pertenecer a esta categoria');

        END IF;
      ELSIF V_CONTADOR < 1 THEN
        IF V('P6507_CLI_CATEG') NOT IN (1, 2, 6, 7, 8, 9) THEN
          RAISE_APPLICATION_ERROR(-20014,
                                  'Este cliente no puede pertenecer a esta categoria');
        END IF;
      END IF;

    END;

  END;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_EMPRESA                   IN NUMBER,
                                   I_PNA_CODIGO                IN NUMBER,
                                   I_CLI_FEC_INGRESO           IN OUT DATE,
                                   I_PNA_LUGAR_ORIGEN_REPLICA  OUT VARCHAR2,
                                   I_PROV_LUGAR_ORIGEN_REPLICA OUT VARCHAR2,
                                   I_CLI_LUGAR_ORIGEN_REPLICA  OUT VARCHAR2,
                                   I_CLI_FEC_ACTUALIZACION     OUT DATE,
                                   I_CLI_MON                   IN OUT NUMBER,
                                   I_MON_LOC                   IN NUMBER) IS
    SALIR EXCEPTION;
    V_BORRAR_BCO  VARCHAR2(1);
    V_BORRAR_AREA NUMBER := 0;
    V_NUMERO      NUMBER := 0;
    V_EXIST       NUMBER := 0;
    V_DV          NUMBER;
    V_RUC         VARCHAR2(60);
  BEGIN
    BEGIN
      SELECT 'S'
        INTO V_BORRAR_BCO
        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'BOR_CLI_CTA_BCO'
         AND N001 = I_PNA_CODIGO;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    BEGIN
      SELECT COUNT(N001)
        INTO V_BORRAR_AREA
        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'AREA'
         AND N001 = I_PNA_CODIGO;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
    --PERSONA
    --GO_BLOCK('FIN_PERSONA');
    IF I_PNA_CODIGO IS NULL THEN
      RAISE SALIR;
    END IF;

    --PROVEEDOR
    I_PNA_LUGAR_ORIGEN_REPLICA  := GEN_LUGAR_ORIGEN;
    I_PROV_LUGAR_ORIGEN_REPLICA := I_PNA_LUGAR_ORIGEN_REPLICA;
    --CLIENTE
    IF I_CLI_FEC_INGRESO IS NULL THEN
      I_CLI_FEC_INGRESO := SYSDATE;
    END IF;
    I_CLI_FEC_ACTUALIZACION := SYSDATE;
    IF I_CLI_MON IS NULL THEN
      I_CLI_MON := I_MON_LOC;
    END IF;

    I_CLI_LUGAR_ORIGEN_REPLICA := I_PNA_LUGAR_ORIGEN_REPLICA;
    PP_VAL_DAT_CTA_BCO(I_EMPRESA);
    -- --================INSERT
       PP_VALIDAR_DATOS;
     IF v('P6507_PNA_DOC_TIPO')= 2 THEN
       V_DV := NVL(v('P6507_PNA_DV'), v('P6507_PNA_DV_AUX'));
       V_RUC := NVL(v('P6507_PNA_RUC_DV'), v('P6507_PNA_RUC_DV_AUX')) || '-' ||
         NVL(v('P6507_PNA_DV'), v('P6507_PNA_DV_AUX'));
     else
        V_DV := NULL;
        V_RUC := NVL(v('P6507_PNA_RUC_DV'), v('P6507_PNA_RUC_DV_AUX'));
     end IF;



    IF v('P6507_IND_CREAR') = 'C' THEN
      --============INSERTAR EN FIN_PERSONA


      INSERT INTO FIN_PERSONA
        (PNA_CODIGO,
         PNA_NOMBRE,
         PNA_TIPO,
         PNA_PAIS,
         PNA_RUC_DV,
         PNA_DV,
         PNA_DIRECCION,
         PNA_DOM_LATITUD_GRA,
         PNA_DOM_LATITUD_MIN,
         PNA_DOM_LONGITUD_GRA,
         PNA_DOM_LONGITUD_MIN,
         PNA_TELEFONO,
         PNA_FAX,
         PNA_CELULAR,
         PNA_EMAIL,
         PNA_EMAIL_TESO,
         PNA_NOTA_LIQUIDACION,
         PNA_MULTINACIONAL,
         PNA_IND_CONTROL_LC,
         PNA_IND_LIBRE_FAC_GA_ADM,
         PNA_SEGMENTO,
         PNA_EMPR,
         PNA_SUC,
         PNA_VENDEDOR,
         PNA_NOM_CONYUGE,
         PNA_DOC_IDENT_CONYUGE,
         PNA_LUGAR_ORIGEN_REPLICA,
         PNA_FEC_NAC,
         PNA_NOM_CODEUDOR1,
         PNA_NRODOC_CODEUDOR1,
         PNA_NOM_CODEUDOR2,
         PNA_NRODOC_CODEUDOR2,
         PNA_NOM_CODEUDOR3,
         PNA_NRODOC_CODEUDOR3,
         PNA_CONTADOR_NOMB,
         PNA_CONTADOR_CEL,
         PNA_DOC_TIPO )
      VALUES
        (v('P6507_PNA_CODIGO'),
         v('P6507_PNA_NOMBRE'),
         v('P6507_PNA_TIPO'),
         v('P6507_PNA_PAIS'),
         NVL(v('P6507_PNA_RUC_DV'), v('P6507_PNA_RUC_DV_AUX')),
         V_DV,
         v('P6507_PNA_DIRECCION'),
         v('P6507_PNA_DOM_LATITUD_GRA'),
         v('P6507_PNA_DOM_LATITUD_MIN'),
         v('P6507_PNA_DOM_LONGITUD_GRA'),
         v('P6507_PNA_DOM_LONGITUD_MIN'),
         v('P6507_PNA_TELEFONO'),
         v('P6507_PNA_FAX'),
         v('P6507_PNA_CELULAR'),
         v('P6507_PNA_EMAIL'),
         v('P6507_PNA_EMAIL_TESO'),
         v('P6507_PNA_NOTA_LIQUIDACION'),
         v('P6507_PNA_MULTINACIONAL'),
         v('P6507_PNA_IND_CONTROL_LC'),
         v('P6507_PNA_IND_LIBRE_FAC_GA_ADM'),
         v('P6507_PNA_SEGMENTO'),
         I_EMPRESA,
         v('P6507_PNA_SUC'),
         v('P6507_PNA_VENDEDOR'),
         v('P6507_PNA_NOM_CONYUGE'),
         v('P6507_PNA_DOC_IDENT_CONYUGE'),
         I_PNA_LUGAR_ORIGEN_REPLICA,
         v('P6507_PNA_FEC_NAC'),
         v('P6507_PNA_NOM_CODEUDOR1'),
         v('P6507_PNA_NRODOC_CODEUDOR1'),
         v('P6507_PNA_NOM_CODEUDOR2'),
         v('P6507_PNA_NRODOC_CODEUDOR2'),
         v('P6507_PNA_NOM_CODEUDOR3'),
         v('P6507_PNA_NRODOC_CODEUDOR3'),
         v('P6507_PNA_CONTADOR_NOMB'),
         v('P6507_PNA_CONTADOR_CEL'),
         v('P6507_PNA_DOC_TIPO'));
      INSERT INTO FIN_PROVEEDOR
        (PROV_CODIGO,
         PROV_RUC_DV,
         PROV_DV,
         PROV_TIMBRADO,
         PROV_RAZON_SOCIAL,
         PROV_DIR,
         PROV_TEL,
         PROV_CELULAR,
         PROV_FAX,
         PROV_RUC,
         PROV_IND_RETENCION,
         PROV_PERS_CONTACTO,
         PROV_PERS_CONTACTO2,
         PROV_PROPIETARIO,
         PROV_EST_PROV,
         PROV_OBS,
         PROV_TIPO,
         PROV_LUGAR_ORIGEN_REPLICA,
         PROV_RETENCION,
         PROV_PAIS,
         PROV_EMAIL,
         PROV_CONTADOR_NOMB,
         PROV_CONTADOR_CEL,
         PROV_EMPR,
         PROV_DOC_TIPO,
         PROV_CIUDAD)
      VALUES
        (v('P6507_PNA_CODIGO'),
         NVL(v('P6507_PNA_RUC_DV'), v('P6507_PNA_RUC_DV_AUX')),
         V_DV,
         v('P6507_PROV_TIMBRADO'),
         v('P6507_PNA_NOMBRE'),
         v('P6507_PNA_DIRECCION'),
         v('P6507_PNA_TELEFONO'),
         v('P6507_PNA_CELULAR'),
         v('P6507_PNA_FAX'),
         V_RUC,
         v('P6507_PROV_IND_RETENCION'),
         v('P6507_PROV_PERS_CONTACTO'),
         v('P6507_PROV_PERS_CONTACTO2'),
         v('P6507_PROV_PROPIETARIO'),
         v('P6507_PROV_EST_PROV'),
         v('P6507_PROV_OBS'),
         v('P6507_PROV_TIPO'),
         I_PROV_LUGAR_ORIGEN_REPLICA,
         v('P6507_PROV_IND_RETENCION'),
         v('P6507_PNA_PAIS'),
         v('P6507_PNA_EMAIL'),
         v('P6507_PROV_CONTADOR_NOMB'),
         v('P6507_PROV_CONTADOR_CEL'),
         I_EMPRESA,
         v('P6507_PNA_DOC_TIPO'),
         v('P6507_COD_CIUDAD'));

      INSERT INTO FIN_CLIENTE
        (CLI_CODIGO,
         CLI_RUC_DV,
         CLI_DV,
         CLI_NOM,
         CLI_EMAIL,
         CLI_PROPIETARIO,
         CLI_DOC_IDENT_PROPIETARIO,
         CLI_PERS_CONTACTO,
         CLI_DOC_IDENT_CONTACTO,
         CLI_DIR,
         CLI_OBS,
         CLI_ZONA,
         CLI_CATEG,
         CLI_RAMO,
         CLI_DIR_PARTICULAR,
         CLI_IND_EXIGIR_RESP_FCRED,
         CLI_COD_EMPL_EMPR_ORIG,
         CLI_FACT_COMB_GS,
         CLI_PORC_FLETE,
         CLI_IMP_LIM_CR,
         CLI_RUC,
         CLI_MAX_DIAS_ATRASO,
         CLI_IND_POTENCIAL,
         CLI_EST_CLI,
         CLI_TEL,
         CLI_TEL_PARTICULAR,
         CLI_VALOR_AGREGADO,
         CLI_FEC_ACTUALIZACION,
         CLI_FEC_INGRESO,
         CLI_MON,
         CLI_FAX,
         CLI_BLOQ_LIM_CR,
         CLI_LUGAR_ORIGEN_REPLICA,
         CLI_PAIS,
         CLI_EMPR,
         CLI_DOC_TIPO)
      VALUES

        (v('P6507_PNA_CODIGO'),
         NVL(v('P6507_PNA_RUC_DV'), v('P6507_PNA_RUC_DV_AUX')),
         V_DV,
         v('P6507_PNA_NOMBRE'),
         v('P6507_PNA_EMAIL'),
         v('P6507_CLI_PROPIETARIO'),
         v('P6507_CLI_DOC_IDENT_PROPIETARI'),
         v('P6507_CLI_PERS_CONTACTO'),
         v('P6507_CLI_DOC_IDENT_CONTACTO'),
         v('P6507_PNA_DIRECCION'),
         v('P6507_CLI_OBS'),
         v('P6507_CLI_ZONA'),
         v('P6507_CLI_CATEG'),
         v('P6507_CLI_RAMO'),
         v('P6507_CLI_DIR_PARTICULAR'),
         v('P6507_CLI_IND_EXIGIR_RESP_FCRE'),
         v('P6507_CLI_COD_EMPL_EMPR_ORIG'),
         v('P6507_CLI_FACT_COMB_GS'),
         v('P6507_CLI_PORC_FLETE'),
         /*v('P6507_CLI_IMP_LIM_CR')*/
         0,
         V_RUC,
         v('P6507_CLI_MAX_DIAS_ATRASO'),
         v('P6507_CLI_IND_POTENCIAL'),
         v('P6507_CLI_EST_CLI'),
         v('P6507_PNA_TELEFONO'),
         v('P6507_CLI_TEL_PARTICULAR'),
         v('P6507_CLI_VALOR_AGREGADO'),
         v('P6507_CLI_FEC_ACTUALIZACION'),
         v('P6507_CLI_FEC_INGRESO'),
         I_CLI_MON,
         v('P6507_PNA_FAX'),
         v('P6507_CLI_BLOQ_LIM_CR'),
         I_CLI_LUGAR_ORIGEN_REPLICA,
         v('P6507_PNA_PAIS'),
         I_EMPRESA,
         v('P6507_PNA_DOC_TIPO'));

      --============INSERTAR EN FIN_CLI_CTA_BANC

      FOR V IN (SELECT N001   CTA_CLI,
                       N002   CTA_BCO,
                       C001   BCO_DESC,
                       C007   CTA_NRO,
                       C002   CTA_TITULAR,
                       C003   CTA_TITULAR_CI,
                       C004   CTA_MON,
                       C005   MON_SIMBOLO,
                       C006   CTA_PREDET,
                       SEQ_ID
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'FIN_CLI_CTA_BCO') LOOP
        INSERT INTO FIN_CLI_CTA_BANC
          (CTA_CLI,
           CTA_BCO,
           CTA_NRO,
           CTA_TITULAR,
           CTA_TITULAR_CI,
           CTA_EMPR,
           CTA_MON,
           CTA_PREDET)
        VALUES
          (getitem('P6507_PNA_CODIGO'),
           V.CTA_BCO,
           V.CTA_NRO,
           V.CTA_TITULAR,
           V.CTA_TITULAR_CI,
           I_EMPRESA,
           V.CTA_MON,
           V.CTA_PREDET);
      END LOOP;
      --============INSERTAR EN FIN_LOTE_PRODUCTOR
      BEGIN
        SELECT MAX(NVL(N002, 0))
          INTO V_NUMERO
          FROM APEX_COLLECTIONS
         WHERE COLLECTION_NAME = 'AREA';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;
      FOR B IN (SELECT N001 LOTE_PERSONA,
                       N002 LOTE_NUMERO,
                       C001 LOTE_LOCALIDAD,
                       C002 LOC_DESC,
                       C003 LOTE_OBS_LOC,
                       N003 LOTE_TAM_HAS,
                       C004 LOTE_STATUS,
                       C005 LOTE_STATUS_DESC,
                       C006 LOTE_IND_HIPOTECA,
                       C007 LOTE_NOM_HIPOTECA,
                       C008 LOTE_TIPO_ALQUILER,
                       C017 TIPO_DESC,
                       C009 LOTE_CALIDAD_SUELO,
                       C010 CAL_DESC,
                       TO_NUMBER(REPLACE(C011, '.')) LOTE_HAS_SOJA,
                       TO_NUMBER(REPLACE(C012, '.')) LOTE_HAS_SOJA_Z,
                       TO_NUMBER(REPLACE(C013, '.')) LOTE_HAS_MAIZ,
                       TO_NUMBER(REPLACE(C014, '.')) LOTE_HAS_TRIGO,
                       NVL(C015, GEN_LUGAR_ORIGEN) LOTE_LUGAR_ORIGEN,
                       I_EMPRESA LOTE_EMPR,
                       C018 DIST_DESC
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'AREA') LOOP
        INSERT INTO FIN_LOTE_PRODUCTOR
          (LOTE_PERSONA,
           LOTE_NUMERO,
           LOTE_LOCALIDAD,
           LOTE_OBS_LOC,
           LOTE_TAM_HAS,
           LOTE_STATUS,
           LOTE_TIPO_ALQUILER,
           LOTE_IND_HIPOTECA,
           LOTE_NOM_HIPOTECA,
           LOTE_CALIDAD_SUELO,
           LOTE_LUGAR_ORIGEN,
           LOTE_HAS_SOJA,
           LOTE_HAS_SOJA_Z,
           LOTE_HAS_MAIZ,
           LOTE_HAS_TRIGO,
           LOTE_EMPR)
        VALUES
          (B.LOTE_PERSONA,
           V_NUMERO,
           B.LOTE_LOCALIDAD,
           B.LOTE_OBS_LOC,
           B.LOTE_TAM_HAS,
           B.LOTE_STATUS,
           B.LOTE_TIPO_ALQUILER,
           B.LOTE_IND_HIPOTECA,
           B.LOTE_NOM_HIPOTECA,
           B.LOTE_CALIDAD_SUELO,
           B.LOTE_LUGAR_ORIGEN,
           TO_NUMBER(B.LOTE_HAS_SOJA),
           TO_NUMBER(B.LOTE_HAS_SOJA_Z),
           TO_NUMBER(B.LOTE_HAS_MAIZ),
           TO_NUMBER(B.LOTE_HAS_TRIGO),
           B.LOTE_EMPR);

      END LOOP;
    ELSE
      --================UPDATE
       -- RAISE_APPLICATION_ERROR(-20012,v('P6507_PNA_RUC_DV_AUX'));
      --================UPDATE FIN_PERSONA
      UPDATE FIN_PERSONA
         SET PNA_NOMBRE               = v('P6507_PNA_NOMBRE'),
             PNA_TIPO                 = v('P6507_PNA_TIPO'),
             PNA_PAIS                 = v('P6507_PNA_PAIS'),
             PNA_RUC_DV               = NVL(v('P6507_PNA_RUC_DV'),
                                            v('P6507_PNA_RUC_DV_AUX')),
             PNA_DV                   = V_DV,
             PNA_DIRECCION            = v('P6507_PNA_DIRECCION'),
             PNA_DOM_LATITUD_GRA      = v('P6507_PNA_DOM_LATITUD_GRA'),
             PNA_DOM_LATITUD_MIN      = v('P6507_PNA_DOM_LATITUD_MIN'),
             PNA_DOM_LONGITUD_GRA     = v('P6507_PNA_DOM_LONGITUD_GRA'),
             PNA_DOM_LONGITUD_MIN     = v('P6507_PNA_DOM_LONGITUD_MIN'),
             PNA_TELEFONO             = v('P6507_PNA_TELEFONO'),
             PNA_FAX                  = v('P6507_PNA_FAX'),
             PNA_CELULAR              = v('P6507_PNA_CELULAR'),
             PNA_EMAIL                = v('P6507_PNA_EMAIL'),
             PNA_EMAIL_TESO           = v('P6507_PNA_EMAIL_TESO'),
             PNA_NOTA_LIQUIDACION     = v('P6507_PNA_NOTA_LIQUIDACION'),
             PNA_MULTINACIONAL        = v('P6507_PNA_MULTINACIONAL'),
             PNA_IND_CONTROL_LC       = v('P6507_PNA_IND_CONTROL_LC'),
             PNA_IND_LIBRE_FAC_GA_ADM = v('P6507_PNA_IND_LIBRE_FAC_GA_ADM'),
             PNA_SEGMENTO             = v('P6507_PNA_SEGMENTO'),
             PNA_SUC                  = v('P6507_PNA_SUC'),
             PNA_VENDEDOR             = v('P6507_PNA_VENDEDOR'),
             PNA_NOM_CONYUGE          = v('P6507_PNA_NOM_CONYUGE'),
             PNA_DOC_IDENT_CONYUGE    = v('P6507_PNA_DOC_IDENT_CONYUGE'),
             PNA_LUGAR_ORIGEN_REPLICA = v('P6507_PNA_LUGAR_ORIGEN_REPLICA'),
             PNA_FEC_NAC              = v('P6507_PNA_FEC_NAC'),
             PNA_NOM_CODEUDOR1        = v('P6507_PNA_NOM_CODEUDOR1'),
             PNA_NRODOC_CODEUDOR1     = v('P6507_PNA_NRODOC_CODEUDOR1'),
             PNA_NOM_CODEUDOR2        = v('P6507_PNA_NOM_CODEUDOR2'),
             PNA_NRODOC_CODEUDOR2     = v('P6507_PNA_NRODOC_CODEUDOR1'),
             PNA_NOM_CODEUDOR3        = v('P6507_PNA_NOM_CODEUDOR3'),
             PNA_NRODOC_CODEUDOR3     = v('P6507_PNA_NRODOC_CODEUDOR3'),
             PNA_CONTADOR_NOMB        = v('P6507_PNA_CONTADOR_NOMB'),
             PNA_CONTADOR_CEL         = v('P6507_PNA_CONTADOR_CEL'),
             PNA_DOC_TIPO             = v('P6507_PNA_DOC_TIPO')
       WHERE PNA_CODIGO = v('P6507_PNA_CODIGO')
         AND PNA_EMPR = v('P_EMPRESA');

      --=========== UPDATE FIN_POVEEDOR

      UPDATE FIN_PROVEEDOR
         SET PROV_RUC_DV               = NVL(v('P6507_PNA_RUC_DV'),
                                             v('P6507_PNA_RUC_DV_AUX')),
             PROV_DV                   = V_DV,
             PROV_TIMBRADO             = v('P6507_PROV_TIMBRADO'),
             PROV_RAZON_SOCIAL         = v('P6507_PNA_NOMBRE'),
             PROV_DIR                  = v('P6507_PNA_DIRECCION'),
             PROV_TEL                  = v('P6507_PNA_TELEFONO'),
             PROV_CELULAR              = v('P6507_PNA_CELULAR'),
             PROV_FAX                  = v('P6507_PNA_FAX'),
             PROV_RUC                  = V_RUC,
             PROV_IND_RETENCION        = v('P6507_PROV_IND_RETENCION'),
             PROV_PERS_CONTACTO        = v('P6507_PROV_PERS_CONTACTO'),
             PROV_PERS_CONTACTO2       = v('P6507_PROV_PERS_CONTACTO2'),
             PROV_PROPIETARIO          = v('P6507_PROV_PROPIETARIO'),
             PROV_EST_PROV             = v('P6507_PROV_EST_PROV'),
             PROV_OBS                  = v('P6507_PROV_OBS'),
             PROV_TIPO                 = v('P6507_PROV_TIPO'),
             PROV_LUGAR_ORIGEN_REPLICA = v('P6507_PROV_LUGAR_ORIGEN_REPLIC'),
             PROV_RETENCION            = v('P6507_PROV_IND_RETENCION'),
             PROV_PAIS                 = v('P6507_PNA_PAIS'),
             PROV_EMAIL                = v('P6507_PNA_EMAIL'),
             PROV_CONTADOR_NOMB        = v('P6507_PROV_CONTADOR_NOMB'),
             PROV_CONTADOR_CEL         = v('P6507_PROV_CONTADOR_CEL'),
             PROV_DOC_TIPO             = v('P6507_PNA_DOC_TIPO'),
             PROV_CIUDAD               = v('P6507_COD_CIUDAD')
       WHERE PROV_CODIGO = v('P6507_PNA_CODIGO')
         AND PROV_EMPR = v('P_EMPRESA');

      --===========UPDATE FIN_CLIENTE

      UPDATE FIN_CLIENTE
         SET CLI_RUC_DV                = NVL(v('P6507_PNA_RUC_DV'),
                                             v('P6507_PNA_RUC_DV_AUX')),
             CLI_DV                    = V_DV,
             CLI_NOM                   = v('P6507_PNA_NOMBRE'),
             CLI_EMAIL                 = v('P6507_PNA_EMAIL'),
             CLI_PROPIETARIO           = v('P6507_CLI_PROPIETARIO'),
             CLI_DOC_IDENT_PROPIETARIO = v('P6507_CLI_DOC_IDENT_PROPIETARI'),
             CLI_PERS_CONTACTO         = v('P6507_CLI_PERS_CONTACTO'),
             CLI_DOC_IDENT_CONTACTO    = v('P6507_CLI_DOC_IDENT_CONTACTO'),
             CLI_DIR                   = v('P6507_PNA_DIRECCION'),
             CLI_OBS                   = v('P6507_CLI_OBS'),
             CLI_ZONA                  = v('P6507_CLI_ZONA'),
             CLI_CATEG                 = v('P6507_CLI_CATEG'),
             CLI_RAMO                  = v('P6507_CLI_RAMO'),
             CLI_DIR_PARTICULAR        = v('P6507_CLI_DIR_PARTICULAR'),
             CLI_IND_EXIGIR_RESP_FCRED = v('P6507_CLI_IND_EXIGIR_RESP_FCRE'),
             CLI_COD_EMPL_EMPR_ORIG    = v('P6507_CLI_COD_EMPL_EMPR_ORIG'),
             CLI_FACT_COMB_GS          = v('P6507_CLI_FACT_COMB_GS'),
             CLI_PORC_FLETE            = v('P6507_CLI_PORC_FLETE'),
             CLI_IMP_LIM_CR            = 0, --v('P6507_CLI_IMP_LIM_CR'),
             CLI_RUC                   = V_RUC,
             CLI_MAX_DIAS_ATRASO       = v('P6507_CLI_MAX_DIAS_ATRASO'),
             CLI_IND_POTENCIAL         = v('P6507_CLI_IND_POTENCIAL'),
             CLI_EST_CLI               = v('P6507_CLI_EST_CLI'),
             CLI_TEL                   = v('P6507_PNA_TELEFONO'),
             CLI_TEL_PARTICULAR        = v('P6507_CLI_TEL_PARTICULAR'),
             CLI_VALOR_AGREGADO        = v('P6507_CLI_VALOR_AGREGADO'),
             CLI_FEC_ACTUALIZACION     = v('P6507_CLI_FEC_ACTUALIZACION'),
             CLI_FEC_INGRESO           = v('P6507_CLI_FEC_INGRESO'),
             CLI_MON                   = I_CLI_MON,
             CLI_FAX                   = v('P6507_PNA_FAX'),
             CLI_BLOQ_LIM_CR           = v('P6507_CLI_BLOQ_LIM_CR'),
             CLI_LUGAR_ORIGEN_REPLICA  = v('P6507_CLI_LUGAR_ORIGEN_REPLICA'),
             CLI_PAIS                  = v('P6507_PNA_PAIS'),
             CLI_DOC_TIPO              = v('P6507_PNA_DOC_TIPO')
       WHERE CLI_CODIGO = v('P6507_PNA_CODIGO')
         AND CLI_EMPR = v('P_EMPRESA');

      --============UPDATE EN FIN_CLI_CTA_BANC

      DELETE FIN_CLI_CTA_BANC
       WHERE CTA_CLI = v('P6507_PNA_CODIGO')
         AND CTA_EMPR = v('P_EMPRESA');

      FOR V IN (SELECT N001   CTA_CLI,
                       N002   CTA_BCO,
                       C001   BCO_DESC,
                       C007   CTA_NRO,
                       C002   CTA_TITULAR,
                       C003   CTA_TITULAR_CI,
                       N004   CTA_EMPR,
                       C004   CTA_MON,
                       C005   MON_SIMBOLO,
                       C006   CTA_PREDET,
                       SEQ_ID
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'FIN_CLI_CTA_BCO') LOOP
        INSERT INTO FIN_CLI_CTA_BANC
          (CTA_CLI,
           CTA_BCO,
           CTA_NRO,
           CTA_TITULAR,
           CTA_TITULAR_CI,
           CTA_EMPR,
           CTA_MON,
           CTA_PREDET)
        VALUES
          (V.CTA_CLI,
           V.CTA_BCO,
           V.CTA_NRO,
           V.CTA_TITULAR,
           V.CTA_TITULAR_CI,
           V.CTA_EMPR,
           V.CTA_MON,
           V.CTA_PREDET);
      END LOOP;

      --============INSERTAR EN FIN_LOTE_PRODUCTOR

      BEGIN
        SELECT COUNT(LOTE_NUMERO)
          INTO V_EXIST
          FROM FIN_LOTE_PRODUCTOR
         WHERE LOTE_PERSONA = v('P6507_PNA_CODIGO')
           AND LOTE_EMPR = v('P_EMPRESA');
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      IF V_EXIST > 0 THEN
        DELETE FIN_LOTE_PRODUCTOR
         WHERE LOTE_PERSONA = v('P6507_PNA_CODIGO')
           AND LOTE_EMPR = v('P_EMPRESA');
      END IF;

      BEGIN
        SELECT MAX(NVL(N002, 1))
          INTO V_NUMERO
          FROM APEX_COLLECTIONS
         WHERE COLLECTION_NAME = 'AREA';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      FOR B IN (SELECT N001 LOTE_PERSONA,
                       N002 LOTE_NUMERO,
                       TO_NUMBER(C001) LOTE_LOCALIDAD,
                       C003 LOTE_OBS_LOC,
                       N003 LOTE_TAM_HAS,
                       C004 LOTE_STATUS,
                       C006 LOTE_IND_HIPOTECA,
                       C007 LOTE_NOM_HIPOTECA,
                       TO_NUMBER(C008) LOTE_TIPO_ALQUILER,
                       TO_NUMBER(C009) LOTE_CALIDAD_SUELO,
                       TO_NUMBER(REPLACE(C011, '.')) LOTE_HAS_SOJA,
                       TO_NUMBER(REPLACE(C012, '.')) LOTE_HAS_SOJA_Z,
                       TO_NUMBER(REPLACE(C013, '.')) LOTE_HAS_MAIZ,
                       TO_NUMBER(REPLACE(C014, '.')) LOTE_HAS_TRIGO,
                       TO_NUMBER(C015) LOTE_LUGAR_ORIGEN,
                       I_EMPRESA LOTE_EMPR
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'AREA') LOOP

        INSERT INTO FIN_LOTE_PRODUCTOR
          (LOTE_PERSONA,
           LOTE_NUMERO,
           LOTE_LOCALIDAD,
           LOTE_OBS_LOC,
           LOTE_TAM_HAS,
           LOTE_STATUS,
           LOTE_TIPO_ALQUILER,
           LOTE_IND_HIPOTECA,
           LOTE_NOM_HIPOTECA,
           LOTE_CALIDAD_SUELO,
           LOTE_LUGAR_ORIGEN,
           LOTE_HAS_SOJA,
           LOTE_HAS_SOJA_Z,
           LOTE_HAS_MAIZ,
           LOTE_HAS_TRIGO,
           LOTE_EMPR)
        VALUES
          (v('P6507_PNA_CODIGO'),
           V_NUMERO,
           B.LOTE_LOCALIDAD,
           B.LOTE_OBS_LOC,
           B.LOTE_TAM_HAS,
           B.LOTE_STATUS,
           B.LOTE_TIPO_ALQUILER,
           B.LOTE_IND_HIPOTECA,
           B.LOTE_NOM_HIPOTECA,
           B.LOTE_CALIDAD_SUELO,
           GEN_LUGAR_ORIGEN,
           B.LOTE_HAS_SOJA,
           B.LOTE_HAS_SOJA_Z,
           B.LOTE_HAS_MAIZ,
           B.LOTE_HAS_TRIGO,
           B.LOTE_EMPR);
        V_NUMERO := V_NUMERO + 1;
      END LOOP;

    END IF;
  EXCEPTION
    WHEN SALIR THEN
      NULL;
  END;

  PROCEDURE PP_VAL_DAT_CTA_BCO(I_EMPRESA IN NUMBER) IS
  BEGIN
    FOR C IN (SELECT COUNT(*) CANT, (C004) CTA_MON
                FROM APEX_COLLECTIONS T
               WHERE T.N004 = I_EMPRESA
                 AND T.N001 = v('P6507_PNA_CODIGO')
                 AND COLLECTION_NAME = 'FIN_CLI_CTA_BCO'
                 AND NVL(C006, 'N') = 'S'
               GROUP BY T.C004, T.N001) /*(SELECT COUNT(*) CANT, T.CTA_MON
                    FROM FIN_CLI_CTA_BANC T
                   WHERE T.CTA_EMPR = I_EMPRESA
                     AND T.CTA_PREDET = 'S'
                     AND T.CTA_CLI =
                         v('P6507_PNA_CODIGO')
                   GROUP BY T.CTA_MON, T.CTA_CLI)*/
     LOOP

      IF C.CANT > 1 THEN
        RAISE_APPLICATION_ERROR(-20006,
                                'Solo puede marcar un banco predet. por moneda');
      END IF;
    END LOOP;
    ---*** VALIDAR DATOS
    DECLARE
    BEGIN
      FOR C IN (SELECT C004 MON, SUM(DECODE(C006, 'S', 1, 0)) SI
                  FROM APEX_COLLECTIONS T
                 WHERE T.N004 = I_EMPRESA
                   AND T.N001 = v('P6507_PNA_CODIGO')
                   AND COLLECTION_NAME = 'FIN_CLI_CTA_BCO'
                 GROUP BY T.C004, T.N001) LOOP

        IF C.SI = 0 THEN
          RAISE_APPLICATION_ERROR(-20006,
                                  'Favor elegir un banco predeterminado para la moneda ' ||
                                  C.MON);
        END IF;
      END LOOP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        FOR C IN (SELECT COUNT(*) CANT, T.CTA_MON
                    FROM FIN_CLI_CTA_BANC T
                   WHERE T.CTA_EMPR = I_EMPRESA
                     AND T.CTA_PREDET = 'S'
                     AND T.CTA_CLI = v('P6507_PNA_CODIGO')
                   GROUP BY T.CTA_MON, T.CTA_CLI) LOOP

          IF C.CANT > 1 THEN
            RAISE_APPLICATION_ERROR(-20006,
                                    'Solo puede marcar un banco predet. por moneda');
          END IF;
        END LOOP;
    END;
  END;

  PROCEDURE PP_BORRAR_FIN_CLI_CTA_BCO(SEQ_ID_BCO IN NUMBER) IS

  BEGIN

    FOR C IN (SELECT N001   CTA_CLI,
                     N002   CTA_BCO,
                     C001   BCO_DESC,
                     C007   CTA_NRO,
                     C002   CTA_TITULAR,
                     C003   CTA_TITULAR_CI,
                     N004   CTA_EMPR,
                     C004   CTA_MON,
                     C005   MON_SIMBOLO,
                     C006   CTA_PREDET,
                     SEQ_ID
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'FIN_CLI_CTA_BCO'
                 AND SEQ_ID = SEQ_ID_BCO) LOOP

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'BOR_CLI_CTA_BCO',
                                 P_N001            => C.CTA_CLI,
                                 P_N002            => C.CTA_BCO,
                                 P_C001            => C.BCO_DESC,
                                 P_C007            => C.CTA_NRO,
                                 P_C002            => C.CTA_TITULAR,
                                 P_C003            => C.CTA_TITULAR_CI,
                                 P_N004            => C.CTA_EMPR,
                                 P_C004            => C.CTA_MON,
                                 P_C005            => C.MON_SIMBOLO,
                                 P_C006            => C.CTA_PREDET);
    END LOOP;

    APEX_COLLECTION.DELETE_MEMBER(P_COLLECTION_NAME => 'FIN_CLI_CTA_BCO',
                                  P_SEQ             => SEQ_ID_BCO);
  END;

  PROCEDURE PP_BORRAR_LOTE(SEQ_AREA IN NUMBER) IS

  BEGIN

    FOR V IN (SELECT N001   LOTE_PERSONA,
                     N002   LOTE_NUMERO,
                     C001   LOTE_LOCALIDAD,
                     C002   LOC_DESC,
                     C003   LOTE_OBS_LOC,
                     N003   LOTE_TAM_HAS,
                     C004   LOTE_STATUS,
                     C005   LOTE_STATUS_DESC,
                     C006   LOTE_IND_HIPOTECA,
                     C007   LOTE_NOM_HIPOTECA,
                     C008   LOTE_TIPO_ALQUILER,
                     C017   TIPO_DESC,
                     C009   LOTE_CALIDAD_SUELO,
                     C010   CAL_DESC,
                     C011   LOTE_HAS_SOJA,
                     C012   LOTE_HAS_SOJA_Z,
                     C013   LOTE_HAS_MAIZ,
                     C014   LOTE_HAS_TRIGO,
                     C015   LOTE_LUGAR_ORIGEN,
                     C016   LOTE_EMPR,
                     SEQ_ID,
                     C018   DIST_DESC
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'AREA'
                 AND SEQ_ID = SEQ_AREA) LOOP

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'AREA_BORRAR',
                                 P_N001            => V.LOTE_PERSONA,
                                 P_N002            => V.LOTE_NUMERO,
                                 P_C001            => V.LOTE_LOCALIDAD,
                                 P_C002            => V.LOC_DESC,
                                 P_C003            => V.LOTE_OBS_LOC,
                                 P_N003            => V.LOTE_TAM_HAS,
                                 P_C004            => V.LOTE_STATUS,
                                 P_C005            => V.LOTE_STATUS_DESC,
                                 P_C006            => V.LOTE_IND_HIPOTECA,
                                 P_C007            => V.LOTE_NOM_HIPOTECA,
                                 P_C008            => V.LOTE_TIPO_ALQUILER,
                                 P_C009            => V.LOTE_CALIDAD_SUELO,
                                 P_C010            => V.CAL_DESC,
                                 P_C011            => V.LOTE_HAS_SOJA,
                                 P_C012            => V.LOTE_HAS_SOJA_Z,
                                 P_C013            => V.LOTE_HAS_MAIZ,
                                 P_C014            => V.LOTE_HAS_TRIGO,
                                 P_C015            => V.LOTE_LUGAR_ORIGEN,
                                 P_C016            => V.LOTE_EMPR,
                                 P_C017            => V.TIPO_DESC,
                                 P_C018            => V.DIST_DESC);

    END LOOP;

    APEX_COLLECTION.DELETE_MEMBER(P_COLLECTION_NAME => 'AREA',
                                  P_SEQ             => SEQ_AREA);

  END;

  PROCEDURE PP_VALIDAR_INTEGRIDAD_PROV IS

  BEGIN
    DECLARE
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM IMP_FACTURA
         WHERE FAC_PROV = v('P6507_PROV_CODIGO')
           AND FAC_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_PROV_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No puede borrar registro - Proveedor tiene asignado pedido/s de importaci??n!');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    END;

    DECLARE
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM FIN_DOCUMENTO
         WHERE DOC_PROV = v('P6507_PROV_CODIGO')
           AND DOC_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_PROV_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No puede borrar registro - Proveedor tiene asignado documento/s!');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    END;

    DECLARE
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM STK_ARTICULO
         WHERE ART_PROV = v('P6507_PROV_CODIGO')
           AND ART_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_PROV_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No puede borrar registro - Proveedor tiene asignado art??culo/s!');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    END;

    DECLARE
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM FIN_PROV_EMPRESA
         WHERE PREM_PROV = v('P6507_PROV_CODIGO')
           AND PREM_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_PROV_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No puede borrar registro - Proveedor asignado a empresa/s!');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    END;
  END;

  PROCEDURE PP_VALIDAR_INTEGRIDAD_CLIENTE IS

  BEGIN

    DECLARE
      NO_EXISTE_TABLA EXCEPTION;
      PRAGMA EXCEPTION_INIT(NO_EXISTE_TABLA, -942);
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM FIN_DOCUMENTO
         WHERE DOC_CLI = v('P6507_CLI_CODIGO')
           AND DOC_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_CLI_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No se puede borrar el cliente porque tiene documentos en FINANZAS.');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    EXCEPTION
      WHEN NO_EXISTE_TABLA THEN
        NULL;
    END;

    DECLARE
      NO_EXISTE_TABLA EXCEPTION;
      PRAGMA EXCEPTION_INIT(NO_EXISTE_TABLA, -942);
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM STK_DOCUMENTO
         WHERE DOCU_CLI = v('P6507_CLI_CODIGO')
           AND DOCU_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_CLI_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No se puede borrar el cliente porque tiene documentos en STOCK.');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    EXCEPTION
      WHEN NO_EXISTE_TABLA THEN
        NULL;
    END;

    DECLARE
      NO_EXISTE_TABLA EXCEPTION;
      PRAGMA EXCEPTION_INIT(NO_EXISTE_TABLA, -942);
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM STK_REMISION
         WHERE REM_CLI = v('P6507_CLI_CODIGO')
           AND REM_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_CLI_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No se puede borrar el cliente porque tiene REMISIONES.');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    EXCEPTION
      WHEN NO_EXISTE_TABLA THEN
        NULL;
    END;

    DECLARE
      NO_EXISTE_TABLA EXCEPTION;
      PRAGMA EXCEPTION_INIT(NO_EXISTE_TABLA, -942);
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM FIN_CHEQUE
         WHERE CHEQ_CLI = v('P6507_CLI_CODIGO')
           AND CHEQ_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_CLI_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No se puede borrar el cliente porque tiene CHEQUES.');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    EXCEPTION
      WHEN NO_EXISTE_TABLA THEN
        NULL;
    END;

    DECLARE
      NO_EXISTE_TABLA EXCEPTION;
      PRAGMA EXCEPTION_INIT(NO_EXISTE_TABLA, -942);
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM FIN_DOCUMENTO
         WHERE DOC_CLI_CODEUDOR = v('P6507_CLI_CODIGO')
           AND DOC_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_CLI_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No se puede borrar el cliente porque figura como codeudor de otro cliente.');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    EXCEPTION
      WHEN NO_EXISTE_TABLA THEN
        NULL;
    END;

    DECLARE
      NO_EXISTE_TABLA EXCEPTION;
      PRAGMA EXCEPTION_INIT(NO_EXISTE_TABLA, -942);
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM PRD_ORDEN_TRABAJO
         WHERE OT_CLI = v('P6507_CLI_CODIGO')
           AND OT_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_CLI_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No se puede borrar el cliente porque tiene ORDENES DE TRABAJO (OT).');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    EXCEPTION
      WHEN NO_EXISTE_TABLA THEN
        NULL;
    END;

    DECLARE
      NO_EXISTE_TABLA EXCEPTION;
      PRAGMA EXCEPTION_INIT(NO_EXISTE_TABLA, -942);
      CURSOR PRIMARY_CUR IS
        SELECT 'x'
          FROM PRE_PRESUPUESTO
         WHERE PRES_CLI = v('P6507_CLI_CODIGO')
           AND PRES_EMPR = v('P_EMPRESA');
      PRIMARY_DUMMY VARCHAR2(1);
    BEGIN
      IF ((v('P6507_CLI_CODIGO') IS NOT NULL)) THEN
        OPEN PRIMARY_CUR;
        FETCH PRIMARY_CUR
          INTO PRIMARY_DUMMY;
        IF (PRIMARY_CUR%FOUND) THEN
          RAISE_APPLICATION_ERROR(-20015,
                                  'No se puede borrar el cliente porque tiene PRESUPUESTO.');
          CLOSE PRIMARY_CUR;
          RETURN;
        END IF;
        CLOSE PRIMARY_CUR;
      END IF;
    EXCEPTION
      WHEN NO_EXISTE_TABLA THEN
        NULL;
    END;

    /*  DECLARE
      NO_EXISTE_TABLA EXCEPTION;
      PRAGMA EXCEPTION_INIT(NO_EXISTE_TABLA, -942);
      CURSOR PRIMARY_CUR IS SELECT 'x'
          FROM TAR_TAREA
          WHERE TAR_CLI = v('P6507_CLI_CODIGO')
          AND TAR_EMPR = v('P_EMPRESA');
      --PRIMARY_DUMMY  VARCHAR2(1);
    BEGIN
      IF ( ( v('P6507_CLI_CODIGO') IS NOT NULL ) ) THEN
          OPEN PRIMARY_CUR;
          FETCH PRIMARY_CUR INTO PRIMARY_DUMMY;
          IF ( PRIMARY_CUR%FOUND ) THEN
             RAISE_APPLICATION_ERROR(-20015,'No se puede borrar el cliente porque hay TAREAS.');
             CLOSE PRIMARY_CUR;
             RETURN;
          END IF;
          CLOSE PRIMARY_CUR;
      END IF;
    EXCEPTION
      WHEN NO_EXISTE_TABLA THEN
        NULL;
    END;*/

  END;

  PROCEDURE PP_BORRAR_REGISTRO IS
  BEGIN


    IF V('APP_USER') != 'MARGDAQ' THEN
      RAISE_APPLICATION_ERROR(-20015,
                                  'Usted no tiene permiso para realizar la anulacion de la ficha, favor contactarse con el area de credito si desea borrar la ficha de clientes');
    END IF;

    PP_VALIDAR_INTEGRIDAD_PROV;
    --------------------------------------------------------------
    PP_VALIDAR_INTEGRIDAD_CLIENTE;
    ------------------------------------------------------------------
    DECLARE
      --V_MESSAGE VARCHAR2(70) := '??BORRAR LOS DATOS?';
      SALIR EXCEPTION;

    BEGIN

      --IF FP_CONFIRMAR_REG(V_MESSAGE) = 'CONFIRMAR' THEN

      --PARA QUE SE REPLIQUE EL DELETE SE DEBE CAMBIAR EL LUGAR DE
      --ORIGEN DE REPLICA, ES DECIR, TOMAR POSECI??N
      UPDATE FIN_PROVEEDOR
         SET PROV_LUGAR_ORIGEN_REPLICA = GEN_LUGAR_ORIGEN
       WHERE PROV_CODIGO = v('P6507_PNA_CODIGO')
         AND PROV_EMPR = v('P_EMPRESA');

      UPDATE FIN_CLIENTE
         SET CLI_LUGAR_ORIGEN_REPLICA = GEN_LUGAR_ORIGEN
       WHERE CLI_CODIGO = v('P6507_PNA_CODIGO')
         AND CLI_EMPR = v('P_EMPRESA');

      UPDATE FIN_LOTE_PRODUCTOR
         SET LOTE_LUGAR_ORIGEN = GEN_LUGAR_ORIGEN
       WHERE LOTE_PERSONA = v('P6507_PNA_CODIGO')
         AND LOTE_EMPR = v('P_EMPRESA');

      DELETE FIN_PERSONA
       WHERE PNA_CODIGO = v('P6507_PNA_CODIGO')
         AND PNA_EMPR = v('P_EMPRESA');

      --
      -- Begin default relation program section
      --
      BEGIN
        --
        -- Begin BAREA detail program section
        --

        DELETE FROM FIN_LOTE_PRODUCTOR F
         WHERE F.LOTE_PERSONA = v('P6507_PNA_CODIGO')
           AND F.LOTE_EMPR = v('P_EMPRESA');
        --
        -- End BAREA detail program section
        --
        --
        -- Begin BPROV detail program section
        --
        DELETE FROM FIN_PROVEEDOR F
         WHERE F.PROV_CODIGO = v('P6507_PNA_CODIGO')
           and F.PROV_EMPR = v('P_EMPRESA');
        --
        -- End BPROV detail program section
        --
        --
        -- Begin BCLIE detail program section
        --
        DELETE FROM FIN_CLIENTE F
         WHERE F.CLI_CODIGO = v('P6507_PNA_CODIGO')
           and F.CLI_EMPR = v('P_EMPRESA');
        --
        -- End BCLIE detail program section
        --
        --
        -- Begin BAREA detail program section
        --
        --
        -- End BAREA detail program section
        --
      END;
      --
      -- End default relation program section
      --

    EXCEPTION
      WHEN SALIR THEN
        NULL;
    END;
  END;

/*FUNCTION PP_FORMATEAR_RUC RETURN NUMBER IS
    V_CARACTER   VARCHAR2(50);
    V_CANT       NUMBER := 0;
    V_PNA_RUC_DV NUMBER;
    V_CAR        VARCHAR2(50);
  BEGIN

    FOR I IN (SELECT LEVEL NRO
                FROM DUAL
              CONNECT BY LEVEL <= LENGTH('3726373-0')) LOOP

      SELECT SUBSTR('3726373-0', I.NRO) INTO V_CARACTER FROM DUAL;
      IF V_CARACTER = '-' THEN

       V_CAR := V_CAR||V_CARACTER;

       ELSE

        V_CANT := V_CANT + 1;
        V_CAR := V_CAR||V_CARACTER;
      END IF;

    END LOOP;
    BEGIN
      SELECT TO_NUMBER(V_CAR) INTO V_PNA_RUC_DV FROM DUAL;
    EXCEPTION
      WHEN INVALID_NUMBER THEN
        SELECT TO_NUMBER(SUBSTR(V_CAR, 1, V_CANT))
          INTO V_PNA_RUC_DV
          FROM DUAL;

    END;

    RETURN(V_CANT);

  END;
*/

END FINM300_PKG;
/
