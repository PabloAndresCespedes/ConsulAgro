CREATE OR REPLACE PACKAGE GENERAL IS

  FUNCTION FP_CONV_NRO_TXT(V_NUMERO IN NUMBER,
                           V_MONEDA IN NUMBER DEFAULT NULL) RETURN VARCHAR2;

  FUNCTION FP_PERIODO_ACTUAL(P_EMPRESA IN NUMBER) RETURN NUMBER;

  PROCEDURE PP_CONV_NRO_AGREGAR_TXT(V_TEXTO_OLD IN OUT VARCHAR2,
                                    V_TEXTO_NEW IN VARCHAR2);

  PROCEDURE PP_CONV_NRO_CENTENAS(V_TEXTO IN OUT VARCHAR2, V_NRO IN NUMBER);

  PROCEDURE PP_CONV_NRO_DECIMAS(V_TEXTO IN OUT VARCHAR2, V_NRO IN NUMBER);

  PROCEDURE PP_CONV_NRO_TRES_DIG(V_TEXTO  IN OUT VARCHAR2,
                                 V_NUMERO IN VARCHAR2,
                                 V_PARAM  IN VARCHAR2);

  PROCEDURE PP_CONV_NRO_UNIT(V_TEXTO IN OUT VARCHAR2, V_NRO IN NUMBER);

  FUNCTION VALIDAR_PERMISOS(P_EMPRESA NUMBER,
                            P_SISTEMA NUMBER,
                            P_PAGINA  NUMBER,
                            P_USUARIO VARCHAR2) RETURN BOOLEAN;

  PROCEDURE PP_CREAR_USUARIO(P_USUARIO           IN VARCHAR2,
                             P_CONTRASENA        IN VARCHAR2,
                             P_OPER_CODIGO       IN NUMBER,
                             P_OPER_NOMBRE       IN VARCHAR2,
                             P_OPER_DESC_ABREV   IN VARCHAR2,
                             P_OPER_EMPR         IN NUMBER,
                             P_OPER_SUC          IN NUMBER,
                             P_OPER_DEP          IN NUMBER,
                             P_OPER_IND_ADMIN    IN VARCHAR2,
                             P_OPER_MAX_SESSIONS IN NUMBER,
                             P_EMPRESAS_AUT      IN VARCHAR2,
                             P_OPER_DPTO         IN NUMBER,
                             P_OPER_SEC          IN NUMBER);

  PROCEDURE PP_ASOCIAR_PROGRAMAS(P_ROL           IN NUMBER,
                                 P_PROGRAMA      IN VARCHAR2,
                                 P_TIPO_PROGRAMA IN NUMBER,
                                 P_SISTEMA       IN NUMBER,
                                 P_EMPR          IN NUMBER);

  PROCEDURE PP_ASIGNAR_ROL_OPER(P_ROL      IN VARCHAR2,
                                P_OPERADOR IN NUMBER,
                                P_EMPRESA  IN NUMBER);

  PROCEDURE PP_ASIGNAR_SUC_OPER(P_SUC      IN VARCHAR2,
                                P_OPERADOR IN NUMBER,
                                P_EMPRESA  IN NUMBER);

  PROCEDURE PP_ASIGNAR_CAR_SUC(P_SUC     IN NUMBER,
                               P_CARG    IN VARCHAR2,
                               P_DPTO    IN NUMBER,
                               P_EMPRESA IN NUMBER);

  PROCEDURE PP_ASIGNAR_SUC_ROL(P_SUC     IN VARCHAR2,
                               P_ROL     IN NUMBER,
                               P_EMPRESA IN NUMBER);

  PROCEDURE PP_ASIGNAR_SUC_DOC(P_SUC     IN VARCHAR2,
                               P_OPER    IN NUMBER,
                               P_EMPRESA IN NUMBER,
                               P_EMP     IN NUMBER);
  ----------------------------------------------------------------
  PROCEDURE PP_ASIGNAR_PESTANHA_OPER(P_PEST    IN VARCHAR2,
                                     P_OPER    IN NUMBER,
                                     P_EMPRESA IN NUMBER);
  -----------------------------------------------------------------
  PROCEDURE PP_ASIGNAR_SIST_ROL(P_SIS     IN VARCHAR2,
                                P_ROL     IN NUMBER,
                                P_EMPRESA IN NUMBER);

  PROCEDURE PP_ASIGNAR_EMPR_OPER(P_EMPR IN VARCHAR2, P_OPERADOR IN NUMBER);

  PROCEDURE PP_ASIGNAR_LIPRE_OPER(P_LPRE     IN VARCHAR2,
                                  P_OPERADOR IN NUMBER,
                                  P_EMPRESA  IN NUMBER);

  PROCEDURE PP_ASIGNAR_OPER_AUX_CAJA(P_CTA_BCO  IN VARCHAR2,
                                     P_OPERADOR IN NUMBER,
                                     P_EMPRESA  IN NUMBER);

  PROCEDURE PP_ASIGNAR_CONCEPTO_OPER(P_OPERADOR IN NUMBER,
                                     P_EMPRESA  IN NUMBER);

  PROCEDURE PP_ASIGNAR_CNT_CUENTA_OPER(P_OPERADOR IN NUMBER,
                                       P_CUENTA   IN NUMBER,
                                       P_EMPRESA  IN NUMBER);

  PROCEDURE PP_ASIGNAR_TMOV_OPER(P_OPERADOR IN NUMBER,
                                 P_EMPRESA  IN NUMBER,
                                 P_OPER_DE  IN NUMBER DEFAULT NULL);

  PROCEDURE PP_ASIGNAR_CCOSTO_OPER(P_OPERADOR IN NUMBER,
                                   P_EMPRESA  IN NUMBER);

  PROCEDURE PP_ASIGNAR_LIN_NEG_OPER(P_OPERADOR IN NUMBER,
                                    P_EMPRESA  IN NUMBER);

  PROCEDURE PL_GEN_AUD_INSERT(CLAVE        IN NUMBER,
                              EMPRESA      IN NUMBER,
                              SUCURSAL     IN NUMBER,
                              SISTEMA      IN NUMBER,
                              PROGRAMA     IN NUMBER,
                              OPERACION    IN VARCHAR2,
                              LOGIN        IN VARCHAR2,
                              HORA_INICIO  IN DATE,
                              TIPO_SISTEMA IN VARCHAR2 DEFAULT NULL);

  PROCEDURE PL_GEN_AUD_UPDATE(AUD_CLAVE IN NUMBER, HORA_FIN IN DATE);

 /* PROCEDURE PL_VALIDAR_HAB_MES_STK(P_FECHA   IN DATE,
                                   P_EMPRESA IN NUMBER,
                                   P_USUARIO IN VARCHAR2);*/
                                   
  PROCEDURE PL_VALIDAR_HAB_MES_FIN(FECHA   IN DATE,
                                   EMPRESA IN NUMBER,
                                   USUARIO IN VARCHAR2);

  PROCEDURE PL_EXHIBIR_ERROR_PLSQL;

  FUNCTION FL_MON_US(V_EMPRESA IN NUMBER) RETURN NUMBER;

  FUNCTION FL_MON_DEC_IMP(MONEDA IN NUMBER, EMPRESA IN NUMBER) RETURN NUMBER;

  FUNCTION FL_TIPO_MOV(TMOVDESC VARCHAR2, EMPRESA NUMBER) RETURN NUMBER;

  PROCEDURE PP_GET_FEC_SISTEMA(I_EMPRESA          IN NUMBER,
                               O_FEC_INIC_SISTEMA OUT DATE,
                               O_FEC_FIN_SISTEMA  OUT DATE);
  PROCEDURE PP_GET_FEC_SIST_FIN(I_EMPRESA          IN NUMBER,
                                O_FEC_INIC_SISTEMA OUT DATE,
                                O_FEC_FIN_SISTEMA  OUT DATE);

  PROCEDURE PP_ASIG_DIAS_ATRASO_ROL(P_EMPRESA IN NUMBER); --Gen Rol, habilitar al usuario para aplicar dias de atraso

  PROCEDURE PL_GRABAR_ULT_NRO(I_NRO_DOC   IN NUMBER,
                              I_TIPO_MOV  IN NUMBER,
                              I_IMPRESORA IN NUMBER,
                              I_EMPRESA   IN NUMBER);

  PROCEDURE PP_AUT_ESP_DEPOSITO(P_EMPRESA            IN NUMBER,
                                P_OPER_LOGIN         IN VARCHAR2,
                                P_SUCURSAL           IN NUMBER,
                                P_DEPOSITO           IN NUMBER,
                                P_OPERACION          IN VARCHAR2,
                                P_CLAVE_AUTORIZACION OUT NUMBER);

  FUNCTION CNT_CTA_PADRE_NRO_DESC(P_CUENTA IN NUMBER, P_EMPRESA IN NUMBER)
    RETURN VARCHAR2;
    
  PROCEDURE PL_VALIDAR_HAB_MES_STK(FECHA   IN DATE,
                                   EMPRESA IN NUMBER,
                                   USUARIO IN VARCHAR2);
                                   
  PROCEDURE PP_AUDITAR_VER_STK(P_EMPRESA IN NUMBER, P_PERIODO IN NUMBER);

  FUNCTION FP_SITUACION_CHEQUE(P_EMPRESA          IN NUMBER,
                               P_CLAVE_CHEQUE     IN NUMBER,
                               P_FECHA_HASTA      IN DATE,
                               P_SITUACION_ACTUAL IN VARCHAR2
                               
                               ) RETURN VARCHAR2;
  FUNCTION FL_AUTO_FECHA(I_FECHA IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION FP_RETORNA_ULT_DIA_HABIL(I_FECHA IN DATE, I_EMPRESA IN NUMBER)
    RETURN DATE;

  FUNCTION FP_RETORNA_CANT_DIA_HABIL(I_FECHA_INI IN DATE,
                                     I_FECHA_FIN IN DATE,
                                     I_EMPRESA   IN NUMBER) RETURN NUMBER;

  FUNCTION FP_REGEXP_SUBSTR(I_TEXT    IN VARCHAR2,
                            I_EXP     IN VARCHAR2,
                            I_POS_INI IN NUMBER,
                            I_POS_FIN IN NUMBER) RETURN VARCHAR2;

  FUNCTION FP_PASS_VENCIDO RETURN BOOLEAN;
  FUNCTION FP_CONV_NRO_TXT_TRA(V_NUMERO IN NUMBER,
                               V_MONEDA IN NUMBER DEFAULT NULL)
    RETURN VARCHAR2;

  FUNCTION FP_VAL_CAJA_ARQUEO(I_EMPRESA IN NUMBER) RETURN BOOLEAN;
  PROCEDURE PP_ACT_IP_GEN_IMPRESORA(I_IP       VARCHAR2,
                                    I_EMPR     IN NUMBER,
                                    I_TERMINAL IN VARCHAR2);

  /*
    Author  : @PabloACespedes \(^-^)/
    Created : 15/07/2022 10:59:05
    retorna si es un usuario de una empresa externa
    para poder operar de igual modo
  */
  
  -- @param in_user: si es nulo busca el de sesion de APEX que invoca la funcion
  -- booleano
  function is_external_operator(
    in_user varchar2 := null
  )return boolean;
  
  -- 15/07/2022 13:07:09 @PabloACespedes \(^-^)/
  -- obtine el identificador del operador externo
  -- @param in_user: si es nulo busca el de sesion de APEX que invoca la funcion
  function get_external_operator_id(
    in_user varchar2 := null
  )return number;
  
  /*
    Obtiene el cargo del operador, segun la empresa:
    @param in_empresa: obligatorio
    @param in_operator: si es nulo busca el de sesion de APEX que invoca la funcion
  */
  function get_position_operator(
    in_empresa  number,
    in_operator number := null
  )return number;
  
  -- 25/07/2022 13:39:29 @PabloACespedes \(^-^)/
  -- Obtiene el logo de la empresa
  function get_logo_empresa(
    in_empresa number
  ) return gen_empresa.empr_logo%type;
  
END GENERAL;
/
CREATE OR REPLACE PACKAGE BODY GENERAL IS

  PROCEDURE PP_AUT_ESP_DEPOSITO(P_EMPRESA            IN NUMBER,
                                P_OPER_LOGIN         IN VARCHAR2,
                                P_SUCURSAL           IN NUMBER,
                                P_DEPOSITO           IN NUMBER,
                                P_OPERACION          IN VARCHAR2,
                                P_CLAVE_AUTORIZACION OUT NUMBER) IS
  
  BEGIN
    BEGIN
      SELECT MIN(STOPES_CLAVE)
        INTO P_CLAVE_AUTORIZACION
        FROM (SELECT STOPES_CLAVE,
                     NVL(E.STOPES_CANT, 0) CANTIDAD,
                     NVL(CANTIDAD, 0) CANT_UTILIZADA
              
                FROM STK_OPER_DEP_ESP E,
                     GEN_OPERADOR O,
                     (SELECT DOCU_CLAVE_STOPES,
                             DOCU_EMPR,
                             COUNT(DOCU_CLAVE) CANTIDAD
                        FROM STK_DOCUMENTO B
                       GROUP BY DOCU_CLAVE_STOPES, DOCU_EMPR)
               WHERE E.STOPES_OPERADOR = OPER_CODIGO
                 AND OPER_LOGIN = P_OPER_LOGIN
                 AND E.STOPES_EMPR = P_EMPRESA
                 AND E.STOPES_SUC = P_SUCURSAL
                 AND E.STOPES_CODIGO = P_DEPOSITO
                 AND STOPES_CLAVE = DOCU_CLAVE_STOPES(+)
                 AND STOPES_EMPR = DOCU_EMPR(+)
                 AND DECODE(P_OPERACION, 'DEP', STOPES_DEP, STOPES_EXT) = 'S'
                 AND TO_DATE(SYSDATE, 'DD/MM/YYYY') BETWEEN
                     TO_DATE(E.STOPES_FECHA_DESDE, 'DD/MM/YYYY') AND
                     TO_DATE(E.STOPES_FECHA_HASTA, 'DD/MM/YYYY'))
       WHERE NVL(CANTIDAD, 0) > NVL(CANT_UTILIZADA, 0);
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        P_CLAVE_AUTORIZACION := NULL;
      when others then
        raise_application_error(-20001,
                                'Error en PP_AUT_ESP_DEPOSITO ' || SQLCODE ||
                                ' -ERROR- ' || SQLERRM);
    END;
  
  END;

  FUNCTION FP_CONV_NRO_TXT(V_NUMERO IN NUMBER,
                           V_MONEDA IN NUMBER DEFAULT NULL) RETURN VARCHAR2 IS
    V_TEXTO VARCHAR2(1000) := NULL;
    V_MILM  NUMBER;
    V_MILL  NUMBER;
    V_MILE  NUMBER;
    V_CENT  NUMBER;
  
    V_NUM_ENT_TXT VARCHAR2(13);
    V_NUM_DEC_TXT VARCHAR2(20);
    V_NUM_DEC     NUMBER;
  BEGIN
  
    IF V_NUMERO = 0 THEN
      RETURN 'CERO';
    END IF;
  
    /*    IF V_NUMERO > 999999999 THEN
        RETURN 'NUMERO ES MUY GRANDE';
    END IF;*/
  
    IF V_NUMERO > 999999999999 THEN
      RETURN 'NUMERO ES MUY GRANDE';
    END IF;
  
    -- ANTES V_NUM_ENT_TXT := LPAD(TO_CHAR(TRUNC(V_NUMERO)),10,'0');
    V_NUM_ENT_TXT := LPAD(TO_CHAR(TRUNC(V_NUMERO)), 13, '0');
  
    /* HALLAR LA PARTE MILMILLON?SIMA DE V_NUM_ENT_TXT */
    V_MILM := TO_NUMBER(SUBSTR(V_NUM_ENT_TXT, 2, 3));
    IF V_MILM > 0 THEN
      GENERAL.PP_CONV_NRO_TRES_DIG(V_TEXTO,
                                   LPAD(TO_CHAR(V_MILM), 3, '0'),
                                   ' MIL');
    END IF;
  
    /* HALLAR LA PARTE MILLON?SIMA DE V_NUM_ENT_TXT */
    V_MILL := TO_NUMBER(SUBSTR(V_NUM_ENT_TXT, 5, 3));
    IF V_MILL > 0 THEN
      GENERAL.PP_CONV_NRO_TRES_DIG(V_TEXTO,
                                   LPAD(TO_CHAR(V_MILL), 3, '0'),
                                   ' MILLON');
      IF V_MILL > 1 OR V_MILM > 0 THEN
        V_TEXTO := V_TEXTO || 'ES';
      END IF;
    END IF;
  
    /* HALLAR LA PARTE MIL?SIMA DE V_NUM_ENT_TXT */
    V_MILE := TO_NUMBER(SUBSTR(V_NUM_ENT_TXT, 8, 3));
    IF V_MILE > 0 THEN
      GENERAL.PP_CONV_NRO_TRES_DIG(V_TEXTO,
                                   LPAD(TO_CHAR(V_MILE), 3, '0'),
                                   ' MIL');
    END IF;
  
    /* HALLAR LA PARTE CENT?SIMA DE V_NUM_ENT_TXT */
    V_CENT := TO_NUMBER(SUBSTR(V_NUM_ENT_TXT, 11, 3));
    IF V_CENT > 0 THEN
      GENERAL.PP_CONV_NRO_TRES_DIG(V_TEXTO,
                                   LPAD(TO_CHAR(V_CENT), 3, '0'),
                                   NULL);
      IF UPPER(SUBSTR(V_TEXTO, NVL(LENGTH(V_TEXTO), 0) - 1, 2)) = 'UN' THEN
        V_TEXTO := V_TEXTO || 'O';
      END IF;
    END IF;
  
    /* HALLAR LA PARTE DE LOS DECIMALES */
    V_NUM_DEC := V_NUMERO - TRUNC(V_NUMERO);
    IF V_MONEDA = 1 THEN
      --V_TEXTO := V_TEXTO;
      RETURN V_TEXTO; -- SI LA MONEDA ES IGUAL A 1 ENTONCES NO MOSTRAS DECIMALES POR DEFAULT SI SE DEJA VACIO SE MUESTRAS LOS DECIMALES
    ELSE
      IF V_NUM_DEC = 0 AND V_MONEDA = 2 THEN
        RETURN V_TEXTO || ' CON 00/100';
      ELSE
        IF V_MONEDA = 2 THEN
          V_TEXTO := V_TEXTO || ' CON ';
        END IF;
      END IF;
      V_NUM_DEC_TXT := TO_CHAR(V_NUM_DEC);
      IF V_MONEDA = 2 THEN
        IF NVL(LENGTH(V_NUM_DEC_TXT), 0) = 2 THEN
          V_TEXTO := V_TEXTO || RPAD(SUBSTR(V_NUM_DEC_TXT, 2, 1), 2, 0) ||
                     '/100';
        ELSIF NVL(LENGTH(V_NUM_DEC_TXT), 0) = 3 THEN
          V_TEXTO := V_TEXTO || RPAD(SUBSTR(V_NUM_DEC_TXT, 2, 2), 2, 0) ||
                     '/100';
        ELSIF NVL(LENGTH(V_NUM_DEC_TXT), 0) = 4 THEN
          V_TEXTO := V_TEXTO || SUBSTR(V_NUM_DEC_TXT, 2, 3) || '/1000';
        ELSE
          V_TEXTO := V_TEXTO || SUBSTR(V_NUM_DEC_TXT, 2, 4) || '/10000';
        END IF;
      END IF;
    END IF;
  
    RETURN V_TEXTO;
  
  END;

  PROCEDURE PP_CONV_NRO_AGREGAR_TXT(V_TEXTO_OLD IN OUT VARCHAR2,
                                    V_TEXTO_NEW IN VARCHAR2) IS
  BEGIN
    IF V_TEXTO_OLD IS NULL THEN
      V_TEXTO_OLD := V_TEXTO_NEW;
    ELSE
      V_TEXTO_OLD := V_TEXTO_OLD || ' ' || V_TEXTO_NEW;
    END IF;
  END;

  PROCEDURE PP_CONV_NRO_CENTENAS(V_TEXTO IN OUT VARCHAR2, V_NRO IN NUMBER) IS
  BEGIN
    IF V_NRO = 1 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'CIEN');
    ELSIF V_NRO = 2 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DOSCIENTOS');
    ELSIF V_NRO = 3 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'TRESCIENTOS');
    ELSIF V_NRO = 4 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'CUATROCIENTOS');
    ELSIF V_NRO = 5 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'QUINIENTOS');
    ELSIF V_NRO = 6 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'SEISCIENTOS');
    ELSIF V_NRO = 7 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'SETECIENTOS');
    ELSIF V_NRO = 8 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'OCHOCIENTOS');
    ELSIF V_NRO = 9 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'NOVECIENTOS');
    END IF;
  END;

  PROCEDURE PP_CONV_NRO_DECIMAS(V_TEXTO IN OUT VARCHAR2, V_NRO IN NUMBER) IS
  BEGIN
    IF V_NRO = 1 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DIEZ');
    ELSIF V_NRO = 2 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTE');
    ELSIF V_NRO = 3 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'TREINTA');
    ELSIF V_NRO = 4 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'CUARENTA');
    ELSIF V_NRO = 5 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'CINCUENTA');
    ELSIF V_NRO = 6 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'SESENTA');
    ELSIF V_NRO = 7 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'SETENTA');
    ELSIF V_NRO = 8 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'OCHENTA');
    ELSIF V_NRO = 9 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'NOVENTA');
    END IF;
  END;

  PROCEDURE PP_CONV_NRO_TRES_DIG(V_TEXTO  IN OUT VARCHAR2,
                                 V_NUMERO IN VARCHAR2,
                                 V_PARAM  IN VARCHAR2) IS
  
    V_CENT NUMBER;
    V_DECI NUMBER;
    V_UNIT NUMBER;
  
  BEGIN
    V_CENT := TO_NUMBER(SUBSTR(V_NUMERO, 1, 1)); --V_CENT = DIGITO CENTECIMAL
    IF NVL(V_CENT, 0) > 0 THEN
      GENERAL.PP_CONV_NRO_CENTENAS(V_TEXTO, V_CENT);
    END IF;
    IF V_CENT = 1 AND TO_NUMBER(V_NUMERO) > 100 THEN
      V_TEXTO := V_TEXTO || 'TO';
    END IF;
    V_UNIT := 0;
    V_DECI := TO_NUMBER(SUBSTR(V_NUMERO, 2, 1)); --V_DECI = DIGITO DECIMAL
    IF V_DECI = 1 OR V_DECI = 2 THEN
      GENERAL.PP_CONV_NRO_UNIT(V_TEXTO, TO_NUMBER(SUBSTR(V_NUMERO, 2, 2)));
    ELSE
      IF V_DECI > 0 THEN
        GENERAL.PP_CONV_NRO_DECIMAS(V_TEXTO, V_DECI);
      END IF;
      V_UNIT := TO_NUMBER(SUBSTR(V_NUMERO, 3, 1));
      IF V_UNIT > 0 THEN
        IF V_DECI > 2 THEN
          V_TEXTO := V_TEXTO || ' Y';
        END IF;
        GENERAL.PP_CONV_NRO_UNIT(V_TEXTO, V_UNIT);
      END IF;
    END IF;
    IF V_PARAM IS NOT NULL THEN
      V_TEXTO := V_TEXTO || V_PARAM;
    END IF;
  
  END;

  PROCEDURE PP_CONV_NRO_UNIT(V_TEXTO IN OUT VARCHAR2, V_NRO IN NUMBER) IS
  BEGIN
    IF V_NRO = 1 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'UN');
    ELSIF V_NRO = 2 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DOS');
    ELSIF V_NRO = 3 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'TRES');
    ELSIF V_NRO = 4 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'CUATRO');
    ELSIF V_NRO = 5 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'CINCO');
    ELSIF V_NRO = 6 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'SEIS');
    ELSIF V_NRO = 7 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'SIETE');
    ELSIF V_NRO = 8 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'OCHO');
    ELSIF V_NRO = 9 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'NUEVE');
    ELSIF V_NRO = 10 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DIEZ');
    ELSIF V_NRO = 11 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'ONCE');
    ELSIF V_NRO = 12 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DOCE');
    ELSIF V_NRO = 13 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'TRECE');
    ELSIF V_NRO = 14 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'CATORCE');
    ELSIF V_NRO = 15 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'QUINCE');
    ELSIF V_NRO = 16 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DIECISEIS');
    ELSIF V_NRO = 17 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DIECISIETE');
    ELSIF V_NRO = 18 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DIECIOCHO');
    ELSIF V_NRO = 19 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'DIECINUEVE');
    ELSIF V_NRO = 20 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTE');
    ELSIF V_NRO = 21 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTIUN');
    ELSIF V_NRO = 22 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTIDOS');
    ELSIF V_NRO = 23 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTITRES');
    ELSIF V_NRO = 24 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTICUATRO');
    ELSIF V_NRO = 25 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTICINCO');
    ELSIF V_NRO = 26 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTISEIS');
    ELSIF V_NRO = 27 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTISIETE');
    ELSIF V_NRO = 28 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTIOCHO');
    ELSIF V_NRO = 29 THEN
      GENERAL.PP_CONV_NRO_AGREGAR_TXT(V_TEXTO, 'VEINTINUEVE');
    END IF;
  END;

  FUNCTION VALIDAR_PERMISOS(P_EMPRESA NUMBER,
                            P_SISTEMA NUMBER,
                            P_PAGINA  NUMBER,
                            P_USUARIO VARCHAR2) RETURN BOOLEAN IS
    VAR_REGISTROS NUMBER := 0;
  BEGIN
    SELECT COUNT(1)
      INTO VAR_REGISTROS
      FROM GEN_PROGRAMA
     WHERE PROG_SISTEMA = (SELECT SIST_CODIGO
                             FROM GEN_SISTEMA
                            WHERE SIST_APP_ID = P_SISTEMA)
       AND PROG_APP = P_PAGINA
       AND PROG_CLAVE IN
           (SELECT ROPR_PROGRAMA
              FROM GEN_ROL_PROGRAMA
             WHERE ROPR_EMPR = P_EMPRESA
               AND ROPR_ROL IN
                   (SELECT OPRO_ROL
                      FROM GEN_OPERADOR_ROL
                     WHERE OPRO_EMPR = P_EMPRESA
                       AND OPRO_OPERADOR =
                           (SELECT OPER_CODIGO
                              FROM GEN_OPERADOR
                             WHERE RTRIM(UPPER(OPER_LOGIN)) =
                                   RTRIM(UPPER(P_USUARIO)))));
  
    IF VAR_REGISTROS = 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
  END VALIDAR_PERMISOS;

  PROCEDURE PP_CREAR_USUARIO(P_USUARIO           IN VARCHAR2,
                             P_CONTRASENA        IN VARCHAR2,
                             P_OPER_CODIGO       IN NUMBER,
                             P_OPER_NOMBRE       IN VARCHAR2,
                             P_OPER_DESC_ABREV   IN VARCHAR2,
                             P_OPER_EMPR         IN NUMBER,
                             P_OPER_SUC          IN NUMBER,
                             P_OPER_DEP          IN NUMBER,
                             P_OPER_IND_ADMIN    IN VARCHAR2,
                             P_OPER_MAX_SESSIONS IN NUMBER,
                             P_EMPRESAS_AUT      IN VARCHAR2,
                             P_OPER_DPTO         IN NUMBER,
                             P_OPER_SEC          IN NUMBER) IS
  
    V_SCRIPT VARCHAR2(2000);
    CURSOR C_EMPRESAS_AUT IS
      SELECT REGEXP_SUBSTR(P_EMPRESAS_AUT, '[^:]+', 1, LEVEL) EMPRESA
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_EMPRESAS_AUT, '[^:]+', 1, LEVEL) IS NOT NULL;
  
  BEGIN
    --CREAR USUARIO EN LA BASE DE DATOS
    V_SCRIPT := 'CREATE USER ' || P_USUARIO || ' IDENTIFIED BY ' ||
                P_CONTRASENA || ' DEFAULT TABLESPACE DATOS ' ||
                'TEMPORARY TABLESPACE TEMP ' || 'PROFILE DEFAULT';
    EXECUTE IMMEDIATE V_SCRIPT;
    V_SCRIPT := 'GRANT OPERADOR, OPERADOR2 TO ' || P_USUARIO;
    EXECUTE IMMEDIATE V_SCRIPT;
    V_SCRIPT := 'ALTER USER ' || P_USUARIO || ' DEFAULT ROLE OPERADOR2';
    EXECUTE IMMEDIATE V_SCRIPT;
    -- V_SCRIPT := 'GRANT SELECT ANY TABLE TO ' || P_USUARIO;--- 26/07/2021  MNUNEZ
    --- EXECUTE IMMEDIATE V_SCRIPT;
    V_SCRIPT := 'GRANT CREATE SESSION TO ' || P_USUARIO;
    EXECUTE IMMEDIATE V_SCRIPT;
  
    -- CREAR REGISTRO EN EL SISTEMA
    INSERT INTO GEN_OPERADOR
      (OPER_CODIGO,
       OPER_NOMBRE,
       OPER_LOGIN,
       OPER_DESC_ABREV,
       OPER_MAX_SESSIONS) --,OPER_DPTO)--,OPER_SEC)OPER_IND_ADMIN, OPER_DEP,, OPER_EMPR
    VALUES
      (P_OPER_CODIGO,
       P_OPER_NOMBRE,
       P_USUARIO,
       P_OPER_DESC_ABREV,
       P_OPER_MAX_SESSIONS); --,);--,);,,,, P_OPER_EMPR
  
    --ASOCIAR LAS EMPRESAS AUTORIZADAS AL USUARIO
    FOR REG IN C_EMPRESAS_AUT LOOP
      INSERT INTO GEN_OPERADOR_EMPRESA
        (OPEM_OPER,
         OPEM_EMPR,
         OPEM_SUC,
         OPEM_DEP,
         OPEM_DPTO,
         OPEM_SEC,
         OPEM_IND_ADMIN,
         opem_ind_articulo_costo)
      VALUES
        (P_OPER_CODIGO,
         REG.EMPRESA,
         P_OPER_SUC,
         P_OPER_DEP,
         P_OPER_DPTO,
         P_OPER_SEC,
         P_OPER_IND_ADMIN,
         'N'); --Por defecto es N. Pedido del se?or Ugo. 05/05/2021
    END LOOP;
  
  END PP_CREAR_USUARIO;

  PROCEDURE PP_ASOCIAR_PROGRAMAS(P_ROL           IN NUMBER,
                                 P_PROGRAMA      IN VARCHAR2,
                                 P_TIPO_PROGRAMA IN NUMBER,
                                 P_SISTEMA       IN NUMBER,
                                 P_EMPR          IN NUMBER) IS
    CURSOR C_PROGRAMAS_AUT IS
      SELECT REGEXP_SUBSTR(P_PROGRAMA, '[^:]+', 1, LEVEL) PROGRAMA
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_PROGRAMA, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
  
    DELETE GEN_ROL_PROGRAMA
     WHERE ROPR_PROGRAMA IN
           (SELECT PROG_CLAVE
              FROM GEN_PROGRAMA
             WHERE PROG_SISTEMA = P_SISTEMA
               AND PROG_TIPO_PROGRAMA = P_TIPO_PROGRAMA)
       AND ROPR_EMPR = P_EMPR
       AND ROPR_ROL = P_ROL;
  
    IF NVL(P_PROGRAMA, 'N') != 'N' THEN
      FOR REG IN C_PROGRAMAS_AUT LOOP
        INSERT INTO GEN_ROL_PROGRAMA
          (ROPR_ROL, ROPR_PROGRAMA, ROPR_EMPR)
        VALUES
          (P_ROL, REG.PROGRAMA, P_EMPR);
      END LOOP;
    END IF;
  END;
  ------------------------------------------
  PROCEDURE PP_ASIGNAR_ROL_OPER(P_ROL      IN VARCHAR2,
                                P_OPERADOR IN NUMBER,
                                P_EMPRESA  IN NUMBER) IS
    CURSOR C_ROLES IS
      SELECT REGEXP_SUBSTR(P_ROL, '[^:]+', 1, LEVEL) ROL
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_ROL, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
  
    DELETE GEN_OPERADOR_ROL
     WHERE OPRO_OPERADOR = P_OPERADOR
       AND OPRO_EMPR = P_EMPRESA;
  
    FOR V IN C_ROLES LOOP
      IF V.ROL IS NOT NULL THEN
        BEGIN
          INSERT INTO GEN_OPERADOR_ROL
            (OPRO_OPERADOR, OPRO_ROL, OPRO_EMPR)
          VALUES
            (P_OPERADOR, V.ROL, P_EMPRESA);
        EXCEPTION
          WHEN OTHERS THEN
            --RAISE_APPLICATION_ERROR(-20343, SQLERRM);
            RAISE_APPLICATION_ERROR(-20343,
                                    P_OPERADOR || P_EMPRESA || P_EMPRESA);
        END;
      
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      --RAISE_APPLICATION_ERROR(-20343, SQLERRM);
      RAISE_APPLICATION_ERROR(-20343, P_OPERADOR || P_EMPRESA || P_EMPRESA);
  END PP_ASIGNAR_ROL_OPER;
  ---------------------
  PROCEDURE PP_ASIGNAR_SUC_OPER(P_SUC      IN VARCHAR2,
                                P_OPERADOR IN NUMBER,
                                P_EMPRESA  IN NUMBER) IS
    CURSOR C_SUC IS
      SELECT REGEXP_SUBSTR(P_SUC, '[^:]+', 1, LEVEL) SUC
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_SUC, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
  
    DELETE GEN_OPERADOR_SUCURSAL
     WHERE OPSU_OPERADOR = P_OPERADOR
       AND OPSU_EMPR = P_EMPRESA;
  
    FOR V IN C_SUC LOOP
      IF V.SUC IS NOT NULL THEN
        INSERT INTO GEN_OPERADOR_SUCURSAL
          (OPSU_OPERADOR, OPSU_SUC, OPSU_EMPR)
        VALUES
          (P_OPERADOR, V.SUC, P_EMPRESA);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_SUC_OPER;

  PROCEDURE PP_ASIGNAR_CAR_SUC(P_SUC     IN NUMBER,
                               P_CARG    IN VARCHAR2,
                               P_DPTO    IN NUMBER,
                               P_EMPRESA IN NUMBER) IS
    CURSOR C_SUC IS
      SELECT REGEXP_SUBSTR(P_CARG, '[^:]+', 1, LEVEL) CARG
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_CARG, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
  
    DELETE PER_CARGO_SUC P
     WHERE P.PER_CAR_EMPR = P_EMPRESA
       AND P.PER_CAR_SUC = P_SUC
       AND P.PER_CAR_DPTO = P_DPTO;
  
    FOR V IN C_SUC LOOP
      IF V.CARG IS NOT NULL THEN
        NULL;
        BEGIN
        
          INSERT INTO PER_CARGO_SUC P
            (PER_CAR_EMPR, PER_CAR_CARG, PER_CAR_SUC, PER_CAR_DPTO)
          VALUES
            (P_EMPRESA, V.CARG, P_SUC, P_DPTO);
        EXCEPTION
          WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20343,
                                    P_EMPRESA || '-' || V.CARG || '-' ||
                                    P_SUC || '-' || P_DPTO);
        END;
      END IF;
    END LOOP;
  
    NULL;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_CAR_SUC;
  -------------------------------------------------
  PROCEDURE PP_ASIGNAR_SUC_ROL(P_SUC     IN VARCHAR2,
                               P_ROL     IN NUMBER,
                               P_EMPRESA IN NUMBER) IS
    CURSOR C_SUC IS
      SELECT REGEXP_SUBSTR(P_SUC, '[^:]+', 1, LEVEL) SUC
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_SUC, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
  
    DELETE GEN_ROL_SUCURSAL
     WHERE ROSU_ROL = P_ROL
       AND ROSU_EMPR = P_EMPRESA;
  
    FOR V IN C_SUC LOOP
      IF V.SUC IS NOT NULL THEN
        INSERT INTO GEN_ROL_SUCURSAL
          (ROSU_EMPR, ROSU_SUC, ROSU_ROL)
        VALUES
          (P_EMPRESA, V.SUC, P_ROL);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_SUC_ROL;
  --------------------------------------
  PROCEDURE PP_ASIGNAR_SUC_DOC(P_SUC     IN VARCHAR2,
                               P_OPER    IN NUMBER,
                               P_EMPRESA IN NUMBER,
                               P_EMP     IN NUMBER) IS
    CURSOR C_SUC IS
      SELECT REGEXP_SUBSTR(P_SUC, '[^:]+', 1, LEVEL) SUC
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_SUC, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
    --RAISE_APPLICATION_ERROR(-20343, P_SUC );
    DELETE GEN_SUPERVISOR_DOC_SUC
     WHERE SUPDOC_OPERADOR = P_OPER
       AND SUPDOC_EMPR = P_EMPRESA;
  
    FOR V IN C_SUC LOOP
      IF V.SUC IS NOT NULL THEN
        INSERT INTO GEN_SUPERVISOR_DOC_SUC
          (SUPDOC_OPERADOR, SUPDOC_SUC, SUPDOC_EMP, SUPDOC_EMPR)
        VALUES
          (P_OPER, V.SUC, P_EMP, P_EMPRESA);
        NULL;
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_SUC_DOC;
  --------------------------------------
  PROCEDURE PP_ASIGNAR_PESTANHA_OPER(P_PEST    IN VARCHAR2,
                                     P_OPER    IN NUMBER,
                                     P_EMPRESA IN NUMBER) IS
    CURSOR C_SUC IS
      SELECT REGEXP_SUBSTR(P_PEST, '[^:]+', 1, LEVEL) SUC
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_PEST, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
    --RAISE_APPLICATION_ERROR(-20343, P_SUC );
    DELETE GEN_OPER_PEST_RRHH
     WHERE OPERRHH_OPER = P_OPER
       AND OPERRHH_EMPR = P_EMPRESA;
  
    FOR V IN C_SUC LOOP
      IF V.SUC IS NOT NULL THEN
      
        INSERT INTO GEN_OPER_PEST_RRHH
          (OPERRHH_OPER, OPERRHH_PEST, OPERRHH_EMPR)
        VALUES
          (P_OPER, V.SUC, P_EMPRESA);
        NULL;
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_PESTANHA_OPER;
  --------------------------------------
  PROCEDURE PP_ASIGNAR_SIST_ROL(P_SIS     IN VARCHAR2,
                                P_ROL     IN NUMBER,
                                P_EMPRESA IN NUMBER) IS
    CURSOR C_SIS IS
      SELECT REGEXP_SUBSTR(P_SIS, '[^:]+', 1, LEVEL) SIS
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_SIS, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
  
    DELETE GEN_ROL_SISTEMA
     WHERE ROSI_ROL = P_ROL
       AND ROSI_EMPR = P_EMPRESA;
  
    FOR V IN C_SIS LOOP
      IF V.SIS IS NOT NULL THEN
        INSERT INTO GEN_ROL_SISTEMA
          (ROSI_ROL, ROSI_SISTEMA, ROSI_EMPR)
        VALUES
          (P_ROL, V.SIS, P_EMPRESA);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_SIST_ROL;

  PROCEDURE PP_ASIGNAR_EMPR_OPER(P_EMPR IN VARCHAR2,
                                 P_OPERADOR IN NUMBER) IS
    CURSOR C_EMPR IS
      SELECT REGEXP_SUBSTR(P_EMPR, '[^:]+', 1, LEVEL) EMPR
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_EMPR, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
    --raise_application_error(-20001,P_EMPR);
    ---DELETE GEN_OPERADOR_EMPRESA WHERE OPEM_OPER = P_OPERADOR;
  
  DELETE GEN_OPERADOR_EMPRESA
   WHERE OPEM_OPER = P_OPERADOR;
  
    FOR V IN C_EMPR LOOP
      IF V.EMPR IS NOT NULL THEN

        BEGIN
          INSERT INTO GEN_OPERADOR_EMPRESA
            (OPEM_OPER, OPEM_EMPR)
          VALUES
            (P_OPERADOR, V.EMPR);
        EXCEPTION
          WHEN DUP_VAL_ON_INDEX THEN
            NULL;
        END;
      
      END IF;
    
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_EMPR_OPER;

  PROCEDURE PP_ASIGNAR_LIPRE_OPER(P_LPRE     IN VARCHAR2,
                                  P_OPERADOR IN NUMBER,
                                  P_EMPRESA  IN NUMBER) IS
    CURSOR C_LPRE IS
      SELECT REGEXP_SUBSTR(P_LPRE, '[^:]+', 1, LEVEL) LPRE
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_LPRE, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
  
    DELETE GEN_OPERADOR_LISTA_PR
     WHERE OPLPR_OPERADOR = P_OPERADOR
       AND OPLPR_EMPRE = P_EMPRESA;
  
    FOR V IN C_LPRE LOOP
      IF V.LPRE IS NOT NULL THEN
        INSERT INTO GEN_OPERADOR_LISTA_PR
          (OPLPR_OPERADOR, OPLPR_LISTA_PR, OPLPR_EMPRE)
        VALUES
          (P_OPERADOR, V.LPRE, P_EMPRESA);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_LIPRE_OPER;

  PROCEDURE PP_ASIGNAR_OPER_AUX_CAJA(P_CTA_BCO  IN VARCHAR2,
                                     P_OPERADOR IN NUMBER,
                                     P_EMPRESA  IN NUMBER) IS
    CURSOR C_CTA_BCO IS
      SELECT REGEXP_SUBSTR(P_CTA_BCO, '[^:]+', 1, LEVEL) CTA_BCO
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(P_CTA_BCO, '[^:]+', 1, LEVEL) IS NOT NULL;
  BEGIN
  
    DELETE GEN_OPERAUX_CTABCO
     WHERE OPCTABCO_OPERADOR = P_OPERADOR
       AND OPCTABCO_EMPR = P_EMPRESA;
  
    FOR V IN C_CTA_BCO LOOP
      IF V.CTA_BCO IS NOT NULL THEN
        INSERT INTO GEN_OPERAUX_CTABCO
          (OPCTABCO_OPERADOR, OPCTABCO_CTA, OPCTABCO_EMPR)
        VALUES
          (P_OPERADOR, V.CTA_BCO, P_EMPRESA);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END PP_ASIGNAR_OPER_AUX_CAJA;

  PROCEDURE PP_ASIGNAR_CONCEPTO_OPER(P_OPERADOR IN NUMBER,
                                     P_EMPRESA  IN NUMBER) IS
  
  BEGIN
  
    FOR I IN 1 .. APEX_APPLICATION.G_F02.COUNT LOOP
      DELETE GEN_OPER_CONCEPTO O
       WHERE OPCO_OPERADOR = P_OPERADOR
         AND O.OPCO_CONCEPTO = TO_NUMBER(APEX_APPLICATION.G_F02(I))
         AND OPCO_EMPR = P_EMPRESA;
    END LOOP;
  
    FOR I IN 1 .. APEX_APPLICATION.G_F01.COUNT LOOP
      INSERT INTO GEN_OPER_CONCEPTO
        (OPCO_OPERADOR, OPCO_CONCEPTO, OPCO_EMPR)
      VALUES
        (P_OPERADOR, TO_NUMBER(APEX_APPLICATION.G_F01(I)), P_EMPRESA);
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END;

  PROCEDURE PP_ASIGNAR_TMOV_OPER(P_OPERADOR IN NUMBER,
                                 P_EMPRESA  IN NUMBER,
                                 P_OPER_DE  IN NUMBER DEFAULT NULL) IS
  
    V_COUNT NUMBER;
  
    FUNCTION BUSCAR_TMOV_OPER(P_EMPRESA  NUMBER,
                              P_OPERADOR NUMBER,
                              TMOV       NUMBER) RETURN NUMBER IS
    
      V_RETURN NUMBER;
    BEGIN
      SELECT COUNT(1)
        INTO V_RETURN
        FROM GEN_OPER_TMOV T
       WHERE T.OPMO_OPERADOR = P_OPERADOR
         AND T.OPMO_TMOV = TMOV
         AND T.OPMO_EMPR = P_EMPRESA;
      RETURN V_RETURN;
    END;
  BEGIN
  
    DELETE FROM GEN_OPER_TMOV
     WHERE OPMO_OPERADOR = P_OPERADOR
       AND OPMO_EMPR = P_EMPRESA;
  
    ----*********    1 *- ,CONSULTAR,
    FOR I IN 1 .. APEX_APPLICATION.G_F01.COUNT LOOP
      IF BUSCAR_TMOV_OPER(P_EMPRESA, P_OPERADOR, APEX_APPLICATION.G_F01(I)) > 0 THEN
        UPDATE GEN_OPER_TMOV
           SET OPMO_CONSULTAR = 'S'
         WHERE OPMO_TMOV = APEX_APPLICATION.G_F01(I)
           AND OPMO_OPERADOR = P_OPERADOR
           AND OPMO_EMPR = P_EMPRESA;
      ELSE
        INSERT INTO GEN_OPER_TMOV
          (OPMO_OPERADOR,
           OPMO_TMOV,
           OPMO_CONSULTAR,
           OPMO_INSERTAR,
           OPMO_ELIMINAR,
           OPMO_MODIFICAR,
           OPMO_EMPR)
        VALUES
          (P_OPERADOR,
           TO_NUMBER(APEX_APPLICATION.G_F01(I)),
           'S',
           'N',
           'N',
           'N',
           P_EMPRESA);
      END IF;
    END LOOP;
  
    ----*********    2 *- ,INSERTAR,
  
    FOR I IN 1 .. APEX_APPLICATION.G_F02.COUNT LOOP
      IF BUSCAR_TMOV_OPER(P_EMPRESA, P_OPERADOR, APEX_APPLICATION.G_F02(I)) > 0 THEN
      
        UPDATE GEN_OPER_TMOV
           SET OPMO_INSERTAR = 'S'
         WHERE OPMO_TMOV = APEX_APPLICATION.G_F02(I)
           AND OPMO_OPERADOR = P_OPERADOR
           AND OPMO_EMPR = P_EMPRESA;
      ELSE
        INSERT INTO GEN_OPER_TMOV
          (OPMO_OPERADOR,
           OPMO_TMOV,
           OPMO_CONSULTAR,
           OPMO_INSERTAR,
           OPMO_ELIMINAR,
           OPMO_MODIFICAR,
           OPMO_EMPR)
        VALUES
          (P_OPERADOR,
           TO_NUMBER(APEX_APPLICATION.G_F02(I)),
           'N',
           'S',
           'N',
           'N',
           P_EMPRESA);
      END IF;
    END LOOP;
  
    ----*********    3 *- ,ELIMINAR,
  
    FOR I IN 1 .. APEX_APPLICATION.G_F03.COUNT LOOP
      IF BUSCAR_TMOV_OPER(P_EMPRESA, P_OPERADOR, APEX_APPLICATION.G_F03(I)) > 0 THEN
        UPDATE GEN_OPER_TMOV
           SET OPMO_ELIMINAR = 'S'
         WHERE OPMO_TMOV = APEX_APPLICATION.G_F03(I)
           AND OPMO_OPERADOR = P_OPERADOR
           AND OPMO_EMPR = P_EMPRESA;
      ELSE
        INSERT INTO GEN_OPER_TMOV
          (OPMO_OPERADOR,
           OPMO_TMOV,
           OPMO_CONSULTAR,
           OPMO_INSERTAR,
           OPMO_ELIMINAR,
           OPMO_MODIFICAR,
           OPMO_EMPR)
        VALUES
          (P_OPERADOR,
           TO_NUMBER(APEX_APPLICATION.G_F03(I)),
           'N',
           'N',
           'S',
           'N',
           P_EMPRESA);
      END IF;
    END LOOP;
  
    ----*********    4 *- ,MODIFICAR
  
    FOR I IN 1 .. APEX_APPLICATION.G_F04.COUNT LOOP
      IF BUSCAR_TMOV_OPER(P_EMPRESA, P_OPERADOR, APEX_APPLICATION.G_F04(I)) > 0 THEN
        UPDATE GEN_OPER_TMOV
           SET OPMO_MODIFICAR = 'S'
         WHERE OPMO_TMOV = APEX_APPLICATION.G_F04(I)
           AND OPMO_OPERADOR = P_OPERADOR
           AND OPMO_EMPR = P_EMPRESA;
      
      ELSE
        INSERT INTO GEN_OPER_TMOV
          (OPMO_OPERADOR,
           OPMO_TMOV,
           OPMO_CONSULTAR,
           OPMO_INSERTAR,
           OPMO_ELIMINAR,
           OPMO_MODIFICAR,
           OPMO_EMPR)
        VALUES
          (P_OPERADOR,
           TO_NUMBER(APEX_APPLICATION.G_F04(I)),
           'N',
           'N',
           'N',
           'S',
           P_EMPRESA);
      END IF;
    END LOOP;
  
    FOR I IN 1 .. APEX_APPLICATION.G_F05.COUNT LOOP
      IF BUSCAR_TMOV_OPER(P_EMPRESA, P_OPERADOR, APEX_APPLICATION.G_F05(I)) > 0 THEN
        DELETE FROM GEN_OPER_TMOV
         WHERE OPMO_OPERADOR = P_OPERADOR
           AND OPMO_EMPR = P_EMPRESA
           AND OPMO_TMOV = APEX_APPLICATION.G_F05(I);
      
        INSERT INTO GEN_OPER_TMOV
          (OPMO_OPERADOR,
           OPMO_TMOV,
           OPMO_CONSULTAR,
           OPMO_INSERTAR,
           OPMO_ELIMINAR,
           OPMO_MODIFICAR,
           OPMO_EMPR)
          SELECT P_OPERADOR,
                 T.OPMO_TMOV,
                 T.OPMO_CONSULTAR,
                 T.OPMO_INSERTAR,
                 T.OPMO_ELIMINAR,
                 T.OPMO_MODIFICAR,
                 T.OPMO_EMPR
            FROM GEN_OPER_TMOV T
           WHERE OPMO_OPERADOR = P_OPER_DE
             AND OPMO_EMPR = P_EMPRESA
             AND OPMO_TMOV = APEX_APPLICATION.G_F05(I);
      
      ELSE
        INSERT INTO GEN_OPER_TMOV
          (OPMO_OPERADOR,
           OPMO_TMOV,
           OPMO_CONSULTAR,
           OPMO_INSERTAR,
           OPMO_ELIMINAR,
           OPMO_MODIFICAR,
           OPMO_EMPR)
          SELECT P_OPERADOR,
                 T.OPMO_TMOV,
                 T.OPMO_CONSULTAR,
                 T.OPMO_INSERTAR,
                 T.OPMO_ELIMINAR,
                 T.OPMO_MODIFICAR,
                 T.OPMO_EMPR
            FROM GEN_OPER_TMOV T
           WHERE OPMO_OPERADOR = P_OPER_DE
             AND OPMO_EMPR = P_EMPRESA
             AND OPMO_TMOV = APEX_APPLICATION.G_F05(I);
      
      END IF;
    END LOOP;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
  END;

  PROCEDURE PP_ASIGNAR_CCOSTO_OPER(P_OPERADOR IN NUMBER,
                                   P_EMPRESA  IN NUMBER) IS
  
  BEGIN
  
    DELETE GEN_OPERADOR_CCOSTO
     WHERE OPCCO_OPERADOR = P_OPERADOR
       AND OPCCO_EMPR = P_EMPRESA;
  
    DELETE GEN_OPERADOR_DEP_COMPRAS
     WHERE OPER_DEP_COM_OPER = P_OPERADOR
       AND OPER_DEP_COM_EMPR = P_EMPRESA;
  
    FOR I IN 1 .. APEX_APPLICATION.G_F01.COUNT LOOP
      INSERT INTO GEN_OPERADOR_CCOSTO
        (OPCCO_OPERADOR, OPCCO_CCOSTO, OPCCO_EMPR)
      VALUES
        (P_OPERADOR, TO_NUMBER(APEX_APPLICATION.G_F01(I)), P_EMPRESA);
    END LOOP;
  
    FOR I IN 1 .. APEX_APPLICATION.G_F02.COUNT LOOP
    
      INSERT INTO GEN_OPERADOR_DEP_COMPRAS
        (OPER_DEP_COM_OPER,
         OPER_DEP_COM_EMPR,
         OPER_DEP_COM_SUC,
         OPER_DEP_COM_DEP)
        SELECT P_OPERADOR, D.DEP_EMPR, D.DEP_SUC, D.DEP_CODIGO
          FROM STK_DEPOSITO D
         WHERE D.DEP_EMPR = P_EMPRESA
           AND (D.DEP_SUC || ',' || D.DEP_CODIGO) =
               (APEX_APPLICATION.G_F02(I));
    
    END LOOP;
  
  END;

  PROCEDURE PP_ASIGNAR_CNT_CUENTA_OPER(P_OPERADOR IN NUMBER,
                                       P_CUENTA   IN NUMBER,
                                       P_EMPRESA  IN NUMBER) AS
  
  BEGIN
  
    DELETE GEN_OPERADOR_CNT_CUENTA
     WHERE OPCNT_OPERADOR = P_OPERADOR
       AND OPCNT_CCOSTO = P_CUENTA
       AND OPCNT_EMPR = P_EMPRESA;
  
    FOR I IN 1 .. APEX_APPLICATION.G_F01.COUNT LOOP
    
      INSERT INTO GEN_OPERADOR_CNT_CUENTA
        (OPCNT_OPERADOR, OPCNT_CCOSTO, OPCNT_CUENTA, OPCNT_EMPR)
      VALUES
        (P_OPERADOR,
         P_CUENTA,
         TO_NUMBER(APEX_APPLICATION.G_F01(I)),
         P_EMPRESA);
    
    END LOOP;
  
  END;

  PROCEDURE PP_ASIGNAR_LIN_NEG_OPER(P_OPERADOR IN NUMBER,
                                    P_EMPRESA  IN NUMBER) AS
  BEGIN
  
    DELETE GEN_OPERADOR_LINEA_NEG
     WHERE OPLN_OPERADOR = P_OPERADOR
       AND OPLN_EMPR = P_EMPRESA;
  
    FOR I IN 1 .. APEX_APPLICATION.G_F01.COUNT LOOP
    
      INSERT INTO GEN_OPERADOR_LINEA_NEG
        (OPLN_OPERADOR, OPLN_LIN_NEG, OPLN_EMPR)
      VALUES
        (P_OPERADOR, TO_NUMBER(APEX_APPLICATION.G_F01(I)), P_EMPRESA);
    
    END LOOP;
  
  END;
  PROCEDURE PL_GEN_AUD_INSERT(CLAVE        IN NUMBER,
                              EMPRESA      IN NUMBER,
                              SUCURSAL     IN NUMBER,
                              SISTEMA      IN NUMBER,
                              PROGRAMA     IN NUMBER,
                              OPERACION    IN VARCHAR2,
                              LOGIN        IN VARCHAR2,
                              HORA_INICIO  IN DATE,
                              TIPO_SISTEMA IN VARCHAR2 DEFAULT NULL) IS
  BEGIN
    INSERT INTO GEN_AUDITORIA
      (GAUD_CLAVE,
       GAUD_EMPR,
       GAUD_SUC,
       GAUD_SISTEMA,
       GAUD_PROGRAMA,
       GAUD_OPERACION,
       GAUD_LOGIN,
       GAUD_HORA_INICIO,
       GAUD_TIPO_SISTEMA)
    VALUES
      (CLAVE,
       EMPRESA,
       SUCURSAL,
       SISTEMA,
       PROGRAMA,
       OPERACION,
       LOGIN,
       HORA_INICIO,
       TIPO_SISTEMA);
  
  END PL_GEN_AUD_INSERT;

  PROCEDURE PL_GEN_AUD_UPDATE(AUD_CLAVE IN NUMBER, HORA_FIN IN DATE) IS
  BEGIN
    UPDATE GEN_AUDITORIA
       SET GAUD_HORA_FIN = HORA_FIN
     WHERE GAUD_CLAVE = AUD_CLAVE;
  END PL_GEN_AUD_UPDATE;
  
/*
  PROCEDURE PL_VALIDAR_HAB_MES_STK(P_FECHA   IN DATE,
                                   P_EMPRESA IN NUMBER,
                                   P_USUARIO IN VARCHAR2) IS
    V_VARIABLE             VARCHAR2(1);
    V_OPER_IND_HAB_MES_ACT VARCHAR2(1);
  
  BEGIN
    --VALIDAR SI ESTA DESHABILITADO EL PERIODO ACTUAL DE STOCK
    BEGIN
      SELECT 'X'
        INTO V_VARIABLE
        FROM STK_CONFIGURACION, STK_PERIODO
       WHERE CONF_PERIODO_ACT = PERI_CODIGO
         AND CONF_EMPR = PERI_EMPR
         AND P_FECHA BETWEEN PERI_FEC_INI AND PERI_FEC_FIN
            --AND CONF_IND_HAB_MES_ACT = 'N'
         AND CONF_IND_HAB_MES_ACT IN ('N', 'S')
         AND CONF_EMPR = P_EMPRESA;
      -----------------------------------------------------------------------------------------------------------
      IF V_VARIABLE = 'X' THEN
        BEGIN
          SELECT NVL(OPEM_IND_HAB_MES_STK, 'N')
            INTO V_OPER_IND_HAB_MES_ACT
            FROM GEN_OPERADOR, GEN_OPERADOR_EMPRESA
           WHERE OPER_CODIGO = OPEM_OPER
             AND OPER_LOGIN = P_USUARIO
             AND OPEM_EMPR = P_EMPRESA;
        
          IF V_OPER_IND_HAB_MES_ACT = 'N' THEN
            APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'EL PERIODO ACTUAL DE STOCK ESTA DESHABILITADO PARA ESTE USUARIO, AVISE AL DPTO. DE INFORMATICA!',
                                 P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
            RAISE_APPLICATION_ERROR(-20002,
                                    'EL PERIODO ACTUAL DE STOCK ESTA DESHABILITADO PARA ESTE USUARIO, AVISE AL DPTO. DE INFORMATICA!.');
          END IF;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
        END;
      END IF;
      -----------------------------------------------------------------------------------------------------------------
      --PL_EXHIBIR_ERROR('EL PERIODO ACTUAL ESTA DESHABILITADO PARA EL SISTEMA DE STOCK, AVISE AL DPTO. DE INFORMATICA!.');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  
    --SI YA SE HIZO EL PRE-CIERRE DEL SISTEMA STK ENTONCES
    --NO SE DEBE PERMITIR INGRESAR MOVIMIENTOS
    DECLARE
      V_COCI_IND_PRE_CERRADO VARCHAR2(1);
      V_CONF_EMPR            NUMBER;
      V_CONF_SUC             NUMBER;
    BEGIN
      SELECT CONF_EMPR, CONF_SUC
        INTO V_CONF_EMPR, V_CONF_SUC
        FROM GEN_CONFIGURACION
       WHERE CONF_EMPR = P_EMPRESA;
      SELECT COCI_IND_PRE_CERRADO
        INTO V_COCI_IND_PRE_CERRADO
        FROM GEN_CONTROL_CIERRE
       WHERE COCI_EMPR = V_CONF_EMPR
         AND COCI_SUC = V_CONF_SUC
         AND COCI_SISTEMA = (SELECT SIST_CODIGO
                               FROM GEN_SISTEMA
                              WHERE SIST_DESC_ABREV = 'STK')
         AND COCI_PERIODO = (SELECT CONF_PERIODO_ACT
                               FROM STK_CONFIGURACION
                              WHERE CONF_EMPR = P_EMPRESA)
         AND P_FECHA = (SELECT P_FECHA
                          FROM STK_CONFIGURACION, STK_PERIODO
                         WHERE CONF_PERIODO_ACT = PERI_CODIGO
                           AND CONF_EMPR = PERI_EMPR
                           AND P_FECHA BETWEEN PERI_FEC_INI AND PERI_FEC_FIN
                           AND CONF_EMPR = V_CONF_EMPR);
      IF V_COCI_IND_PRE_CERRADO = 'S' THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'EL PERIODO ACTUAL YA FUE PRE-CERRADO PARA EL SISTEMA DE STOCK!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'EL PERIODO ACTUAL YA FUE PRE-CERRADO PARA EL SISTEMA DE STOCK!');
      END IF;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  
  END PL_VALIDAR_HAB_MES_STK;
*/
  PROCEDURE PL_VALIDAR_HAB_MES_FIN(FECHA   IN DATE,
                                   EMPRESA IN NUMBER,
                                   USUARIO IN VARCHAR2) IS
    V_VARIABLE             VARCHAR2(1);
    V_OPER_IND_HAB_MES_ACT VARCHAR2(1);
    V_CONF_FEC_LIM_MOD     DATE;
    V_CONF_PER_ACT_INI     DATE;
    V_CONF_PER_ACT_FIN     DATE;
    V_CONF_PER_SGT_FIN     DATE;
    VALOR                  VARCHAR2(1);
  
  BEGIN
    --VALIDAR SI EL PERIODO ACTUAL ESTA HABILITADO
    BEGIN
      --=====TRAEMOS LA CONFIGURACION DEL PERIODO Y COMPARAMOS===========================
      SELECT CONF_FEC_LIM_MOD,
             CONF_PER_ACT_INI,
             CONF_PER_ACT_FIN,
             CONF_PER_SGTE_FIN
        INTO V_CONF_FEC_LIM_MOD,
             V_CONF_PER_ACT_INI,
             V_CONF_PER_ACT_FIN,
             V_CONF_PER_SGT_FIN
        FROM FIN_CONFIGURACION
       WHERE CONF_IND_HAB_MES_ACT IN ('N', 'S')
         AND CONF_EMPR = EMPRESA;
    
      --------------------------------------------------------------------------------------------------------------------
    
      -- VALIDAMOS PARA QUE SOLO USUARIOS 'PRIVILEGIADOS' PUEDAN MODIFICAR DATOS DE PERIODOS CERRADOS 24/11/2021 JB
    
      BEGIN
      
        SELECT NVL(GOE.OPEM_IND_HAB_ESP_FIN, 'N')
          INTO VALOR
          FROM GEN_OPERADOR_EMPRESA GOE
         WHERE GOE.OPEM_OPER =
               (SELECT N.OPER_CODIGO
                  FROM GEN_OPERADOR N
                 WHERE N.OPER_LOGIN = USUARIO)
           AND GOE.OPEM_EMPR = EMPRESA;
      
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          VALOR := 'N';
        WHEN TOO_MANY_ROWS THEN
          VALOR := 'N';
        WHEN OTHERS THEN
          VALOR := 'N';
        
      END;
   
      IF FECHA < V_CONF_FEC_LIM_MOD THEN
        IF VALOR = 'N' THEN
          RAISE_APPLICATION_ERROR(-20001,
                                  'No se puede hacer modificaciones anteriores a la fecha: ' ||
                                  V_CONF_FEC_LIM_MOD || ' !.(BD)' || FECHA);
        END IF;
      END IF;

      IF FECHA BETWEEN V_CONF_PER_ACT_INI AND V_CONF_PER_ACT_FIN THEN
        BEGIN
          SELECT NVL(OPEM_IND_HAB_MES_ACT, 'N')
            INTO V_OPER_IND_HAB_MES_ACT
            FROM GEN_OPERADOR, GEN_OPERADOR_EMPRESA
           WHERE OPER_CODIGO = OPEM_OPER
             AND OPER_LOGIN = USUARIO
             AND OPEM_EMPR = EMPRESA;
        
          IF V_OPER_IND_HAB_MES_ACT = 'N' THEN
            RAISE_APPLICATION_ERROR(-20001,
                                    'El periodo actual de FINANZAS esta deshabilitado para este usuario, avise al dpto. de informatica!.(BD)');
          END IF;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
        END;
        /*      ELSE
        IF FECHA NOT BETWEEN V_CONF_PER_ACT_INI AND V_CONF_PER_SGT_FIN THEN
          RAISE_APPLICATION_ERROR(-20001,
                                  'La fecha debe estar comprendida entre: ' ||
                                  V_CONF_PER_ACT_INI || ' y ' ||
                                  V_CONF_PER_SGT_FIN);
        END IF;*/
      
      END IF;
    
      ------------------------------------------------------------------------------------------------------------------------
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  
    --SI YA SE HIZO EL PRE-CIERRE DEL SISTEMA FIN ENTONCES
    --NO SE DEBE PERMITIR INGRESAR MOVIMIENTOS
    DECLARE
      V_COCI_IND_PRE_CERRADO VARCHAR2(1);
      V_CONF_SUC             NUMBER;
    BEGIN
      SELECT CONF_SUC
        INTO V_CONF_SUC
        FROM GEN_CONFIGURACION
       WHERE CONF_EMPR = EMPRESA;
      SELECT COCI_IND_PRE_CERRADO
        INTO V_COCI_IND_PRE_CERRADO
        FROM GEN_CONTROL_CIERRE
       WHERE COCI_EMPR = EMPRESA
         AND COCI_SUC = V_CONF_SUC
         AND COCI_SISTEMA = (SELECT SIST_CODIGO
                               FROM GEN_SISTEMA
                              WHERE SIST_DESC_ABREV = 'FIN')
         AND COCI_PERIODO = (SELECT CONF_PERIODO_ACT
                               FROM FIN_CONFIGURACION
                              WHERE CONF_EMPR = EMPRESA)
         AND FECHA =
             (SELECT FECHA
                FROM FIN_CONFIGURACION
               WHERE FECHA BETWEEN CONF_FEC_LIM_MOD AND CONF_PER_ACT_FIN
                 AND CONF_EMPR = EMPRESA);
    
      IF V_COCI_IND_PRE_CERRADO = 'S' THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'El periodo actual ya fue pre-cerrado para el sistema de finanzas!(BD)');
      END IF;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  END;

  PROCEDURE PL_EXHIBIR_ERROR_PLSQL IS
  
    V_MESSAGE VARCHAR2(200);
  
  BEGIN
    V_MESSAGE := 'ERROR ORA: ' || SQLCODE || ' - ' || SQLERRM;
    RAISE_APPLICATION_ERROR(-20001, V_MESSAGE);
  END;

  FUNCTION FP_PERIODO_ACTUAL(P_EMPRESA IN NUMBER) RETURN NUMBER IS
    PERIODO NUMBER;
  BEGIN
  
    SELECT CONF_PERIODO_ACT
      INTO PERIODO
      FROM STK_CONFIGURACION
     WHERE CONF_EMPR = P_EMPRESA;
  
    RETURN PERIODO;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      ---PL_EXHIBIR_ERROR('No puede ser nulo!');
      RAISE_APPLICATION_ERROR(-20001,
                              'No se encuentra periodo para la empresa' ||
                              P_EMPRESA);
  END;

  FUNCTION FL_MON_US(V_EMPRESA IN NUMBER) RETURN NUMBER IS
    V_MON_US GEN_CONFIGURACION.CONF_MON_US%TYPE;
  
  BEGIN
    SELECT CONF_MON_US
      INTO V_MON_US
      FROM GEN_CONFIGURACION
     WHERE CONF_EMPR = V_EMPRESA;
  
    RETURN V_MON_US;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Moneda U$ inexistente en GEN_CONFIGURACION!');
    WHEN OTHERS THEN
      PL_EXHIBIR_ERROR_PLSQL;
  END FL_MON_US;

  FUNCTION FL_MON_DEC_IMP(MONEDA IN NUMBER, EMPRESA IN NUMBER) RETURN NUMBER IS
    RMON GEN_MONEDA.MON_DEC_IMP%TYPE;
  
  BEGIN
    SELECT MON_DEC_IMP
      INTO RMON
      FROM GEN_MONEDA
     WHERE MON_CODIGO = MONEDA
       AND MON_EMPR = EMPRESA;
  
    RETURN RMON;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Codigo de moneda ' || TO_CHAR(MONEDA) ||
                              'inexistente en GEN_MONEDA!');
    
  END FL_MON_DEC_IMP;

  FUNCTION FL_TIPO_MOV(TMOVDESC VARCHAR2, EMPRESA NUMBER) RETURN NUMBER IS
    V_CODIGO NUMBER;
  BEGIN
    /*
    CREADO POR TERESITA MARTINEZ
    AGREGADO A LA LIB.PLL POR EP - 10-04-2002
    ESTA FUNCION RECIBE LA DESCRIPCION DEL TIPO DE MOVIMIENTO Y
    RETORNO EL CODIGO DE LA MISMA.
    */
    SELECT TMOV_CODIGO
      INTO V_CODIGO
      FROM GEN_TIPO_MOV
     WHERE TMOV_DESC = TMOVDESC
       AND TMOV_EMPR = EMPRESA;
    RETURN(V_CODIGO);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Primero debe crear un tipo de movimientos,con la descripcion: "' ||
                              TMOVDESC || '"');
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'No puede existir mas de un tipo de mov. con la descrpcion: "' ||
                              TMOVDESC || '"');
  END FL_TIPO_MOV;

  PROCEDURE PP_GET_FEC_SIST_FIN(I_EMPRESA          IN NUMBER,
                                O_FEC_INIC_SISTEMA OUT DATE,
                                O_FEC_FIN_SISTEMA  OUT DATE) IS
  BEGIN
    BEGIN
    
      SELECT PERI_FEC_INI
        INTO O_FEC_INIC_SISTEMA
        FROM FIN_PERIODO A, FIN_CONFIGURACION B
       WHERE PERI_FEC_INI BETWEEN B.CONF_PER_ACT_INI AND B.CONF_PER_ACT_FIN
         AND CONF_EMPR = PERI_EMPR
         AND CONF_EMPR = I_EMPRESA;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        O_FEC_INIC_SISTEMA := SYSDATE;
        RAISE_APPLICATION_ERROR(-20001,
                                'No existe periodo actual o registro de configuracion en sistema');
    END;
  
    --*
    BEGIN
    
      SELECT max(PERI_FEC_FIN)
        INTO O_FEC_FIN_SISTEMA
        FROM FIN_PERIODO A, FIN_CONFIGURACION B
       WHERE PERI_FEC_INI BETWEEN B.CONF_PER_SGTE_INI AND
             B.CONF_PER_SGTE_FIN
         AND CONF_EMPR = PERI_EMPR
         AND CONF_EMPR = I_EMPRESA;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        O_FEC_FIN_SISTEMA := SYSDATE;
        RAISE_APPLICATION_ERROR(-20001,
                                'No existe periodo actual o registro de configuracion en sistema');
    END;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Problema PP_GET_FEC_SIST_FIN' || SQLCODE || '-' ||
                              SQLERRM);
    
  END PP_GET_FEC_SIST_FIN;

  PROCEDURE PP_GET_FEC_SISTEMA(I_EMPRESA          IN NUMBER,
                               O_FEC_INIC_SISTEMA OUT DATE,
                               O_FEC_FIN_SISTEMA  OUT DATE) IS
  BEGIN
    BEGIN
    
      SELECT PERI_FEC_INI
        INTO O_FEC_INIC_SISTEMA
        FROM PRD_PERIODO, PRD_CONFIGURACION
       WHERE PERI_CODIGO = CONF_PERI_ACT
         AND CONF_EMPR = PERI_EMPR
         AND CONF_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        O_FEC_INIC_SISTEMA := SYSDATE;
        RAISE_APPLICATION_ERROR(-20001,
                                'No existe periodo actual o registro de configuracion en sistema');
    END;
  
    --*
  
    BEGIN
      SELECT PERI_FEC_FIN
        INTO O_FEC_FIN_SISTEMA
        FROM PRD_PERIODO, PRD_CONFIGURACION
       WHERE PERI_CODIGO = CONF_PERI_SGTE
         AND CONF_EMPR = PERI_EMPR
         AND CONF_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        O_FEC_FIN_SISTEMA := SYSDATE;
        RAISE_APPLICATION_ERROR(-20001,
                                'No existe periodo actual o registro de configuracion en sistema');
    END;
  
  END PP_GET_FEC_SISTEMA;

  PROCEDURE PP_ASIG_DIAS_ATRASO_ROL(P_EMPRESA IN NUMBER) IS
    --GEN ROL, HABILITAR AL USUARIO PARA APLICAR DIAS DE ATRASO
    V_IND_DETALLE VARCHAR2(2) := 'N';
    VROW          BINARY_INTEGER;
  BEGIN
  
    FOR I IN 1 .. APEX_APPLICATION.G_F02.COUNT LOOP
      FOR II IN 1 .. APEX_APPLICATION.G_F01.COUNT LOOP
      
        UPDATE GEN_ROL
           SET ROL_ASIG_CLI_MAX_ATRASO = TO_CHAR(APEX_APPLICATION.G_F02(I))
        -- WHERE ROL_CODIGO = TO_NUMBER(APEX_APPLICATION.G_F01(II));
         WHERE ROL_CODIGO = 1;
      
      /*
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        INSERT INTO GEN_ROL
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          (ROL_CODIGO, ROL_NOMBRE, ROL_ASIG_CLI_MAX_ATRASO, ROL_EMPR)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        VALUES
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          (300, 'Hola', APEX_APPLICATION.G_F02(I), 1);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          */
      END LOOP;
    END LOOP;
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END;

  PROCEDURE PL_GRABAR_ULT_NRO(I_NRO_DOC   IN NUMBER,
                              I_TIPO_MOV  IN NUMBER,
                              I_IMPRESORA IN NUMBER,
                              I_EMPRESA   IN NUMBER) IS
  BEGIN
  
    IF I_TIPO_MOV IN (9, 10) THEN
      --FACTURAS
      GEN_EXEC('UPDATE GEN_IMPRESORA SET IMP_ULT_FACT = ' || I_NRO_DOC ||
               ' WHERE IMP_EMPR = ' || I_EMPRESA || ' AND IMP_CODIGO=' ||
               I_IMPRESORA);
    END IF;
  
    IF I_TIPO_MOV IN (16) THEN
      --NOTAS DE CREDITO.
      GEN_EXEC('UPDATE GEN_IMPRESORA SET IMP_ULT_NOTA_CREDITO = ' ||
               I_NRO_DOC || ' WHERE IMP_EMPR = ' || I_EMPRESA ||
               ' AND IMP_CODIGO=' || I_IMPRESORA);
    END IF;
  
    IF I_TIPO_MOV IN (23) THEN
      --RETENCIONES.
      GEN_EXEC('UPDATE GEN_IMPRESORA SET IMP_ULT_RETENCION = ' ||
               I_NRO_DOC || ' WHERE IMP_EMPR = ' || I_EMPRESA ||
               ' AND IMP_CODIGO=' || I_IMPRESORA);
    END IF;
  
    IF I_TIPO_MOV = 7 THEN
      --AUTOFACTURA
      GEN_EXEC('UPDATE GEN_IMPRESORA SET IMP_ULT_FACT_COMPRA = ' ||
               I_NRO_DOC || ' WHERE IMP_EMPR = ' || I_EMPRESA ||
               ' AND IMP_CODIGO=' || I_IMPRESORA);
    END IF;
  
  END;

  FUNCTION CNT_CTA_PADRE_NRO_DESC(P_CUENTA IN NUMBER, P_EMPRESA IN NUMBER)
    RETURN VARCHAR2 IS
    V_LARGO_MASCARA    NUMBER;
    V_MASCARA          VARCHAR2(50);
    V_CUENTA_PADRE     VARCHAR2(50);
    V_C                NUMBER := 0;
    B                  NUMBER;
    X                  NUMBER;
    V_CTA_PADRE_NOMBRE VARCHAR2(1000);
  
  BEGIN
  
    SELECT CONF.CONF_MASCARA_DE_CUENTA
      INTO V_MASCARA
      FROM CNT_CONFIGURACION CONF
     WHERE CONF.CONF_EMPR = P_EMPRESA;
  
    V_LARGO_MASCARA := LENGTH(V_MASCARA);
    FOR I IN 1 .. V_LARGO_MASCARA LOOP
      V_C := V_C + 1;
      IF SUBSTR(V_MASCARA, I, 1) <> '-' THEN
        V_CUENTA_PADRE := V_CUENTA_PADRE || SUBSTR(P_CUENTA, V_C, 1);
      ELSE
        V_CUENTA_PADRE := V_CUENTA_PADRE || '-';
        V_C            := V_C - 1;
      END IF;
    END LOOP;
  
    B := 0;
    FOR I IN REVERSE 1 .. V_LARGO_MASCARA LOOP
      IF SUBSTR(V_MASCARA, I, 1) = '-' AND B = 1 THEN
        V_CUENTA_PADRE := V_CUENTA_PADRE;
        EXIT;
      ELSE
        IF REPLACE(SUBSTR(V_CUENTA_PADRE, I, 1), '-', 0) > 0 THEN
          V_CUENTA_PADRE := SUBSTR(V_CUENTA_PADRE, 1, I - 1);
          V_CUENTA_PADRE := RPAD(V_CUENTA_PADRE,
                                 LENGTH(REPLACE(V_MASCARA, '-', '')),
                                 0);
          B              := 1;
        END IF;
      END IF;
    END LOOP;
  
    V_CUENTA_PADRE := REPLACE(V_CUENTA_PADRE, '-', '');
    V_CUENTA_PADRE := RPAD(V_CUENTA_PADRE,
                           LENGTH(REPLACE(V_MASCARA, '-', '')),
                           0);
  
    SELECT NVL(MAX(CTAC_NRO), 0)
      INTO X
      FROM CNT_CUENTA
     WHERE CTAC_NRO = V_CUENTA_PADRE
       AND CTAC_EMPR = P_EMPRESA;
  
    IF X = 0 THEN
      V_CTA_PADRE_NOMBRE := V_CUENTA_PADRE || ' ' ||
                            'mal ubicada en el plan de Cta.';
    ELSE
      IF V_CUENTA_PADRE NOT LIKE '000000000' THEN
        SELECT CTAC_NRO || ' ' || CTAC_DESC
          INTO V_CTA_PADRE_NOMBRE
          FROM CNT_CUENTA
         WHERE CTAC_NRO = V_CUENTA_PADRE
           AND CTAC_EMPR = P_EMPRESA;
      ELSE
        V_CTA_PADRE_NOMBRE := 'SIN CUENTA PADRE';
      END IF;
    END IF;
  
    RETURN V_CTA_PADRE_NOMBRE;
  
  END;

  PROCEDURE PL_VALIDAR_HAB_MES_STK(FECHA   IN DATE,
                                   EMPRESA IN NUMBER,
                                   USUARIO IN VARCHAR2) IS
    V_VARIABLE             VARCHAR2(1);
    V_OPER_IND_HAB_MES_ACT VARCHAR2(1);
    V_CONF_FEC_LIM_MOD     DATE;
    V_CONF_PER_ACT_INI     DATE;
    V_CONF_PER_ACT_FIN     DATE;
  
  BEGIN
    --VALIDAR SI EL PERIODO ACTUAL ESTA HABILITADO
    BEGIN
      --=====TRAEMOS LA CONFIGURACION DEL PERIODO Y COMPARAMOS===========================
      SELECT B.PERI_FEC_INI, B.PERI_FEC_INI, B.PERI_FEC_FIN
        INTO V_CONF_FEC_LIM_MOD, V_CONF_PER_ACT_INI, V_CONF_PER_ACT_FIN
        FROM STK_CONFIGURACION A, STK_PERIODO B
       WHERE PERI_CODIGO = A.CONF_PERIODO_ACT
         AND CONF_EMPR = PERI_EMPR
         AND CONF_EMPR = EMPRESA;
    
      --------------------------------------------------------------------------------------------------------------------
      IF FECHA < V_CONF_FEC_LIM_MOD THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'No se puede hacer modificaciones anteriores a la fecha: ' ||
                                V_CONF_FEC_LIM_MOD || ' !.(BD)');
      END IF;
    
      IF FECHA BETWEEN V_CONF_PER_ACT_INI AND V_CONF_PER_ACT_FIN  AND gen_devuelve_user <> 'ADCS' THEN
        BEGIN
          SELECT NVL(OPEM_IND_HAB_MES_STK, 'N')
            INTO V_OPER_IND_HAB_MES_ACT
            FROM GEN_OPERADOR, GEN_OPERADOR_EMPRESA
           WHERE OPER_CODIGO = OPEM_OPER
             AND OPER_LOGIN = USUARIO
             AND OPEM_EMPR = EMPRESA;
        
          IF V_OPER_IND_HAB_MES_ACT = 'N' THEN
            
           
            RAISE_APPLICATION_ERROR(-20001,
                                    'El periodo actual de STOCK esta deshabilitado para este usuario, avise al dpto. de informatica!.(BD)');
          END IF;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
        END;
      END IF;
    
      ------------------------------------------------------------------------------------------------------------------------
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  
    --SI YA SE HIZO EL PRE-CIERRE DEL SISTEMA FIN ENTONCES
    --NO SE DEBE PERMITIR INGRESAR MOVIMIENTOS
    DECLARE
      V_COCI_IND_PRE_CERRADO VARCHAR2(1);
      V_CONF_SUC             NUMBER;
    BEGIN
      SELECT CONF_SUC
        INTO V_CONF_SUC
        FROM GEN_CONFIGURACION
       WHERE CONF_EMPR = EMPRESA;
      SELECT COCI_IND_PRE_CERRADO
        INTO V_COCI_IND_PRE_CERRADO
        FROM GEN_CONTROL_CIERRE
       WHERE COCI_EMPR = EMPRESA
         AND COCI_SUC = V_CONF_SUC
         AND COCI_SISTEMA = (SELECT SIST_CODIGO
                               FROM GEN_SISTEMA
                              WHERE SIST_DESC_ABREV = 'STK')
         AND COCI_PERIODO = (SELECT CONF_PERIODO_ACT
                               FROM STK_CONFIGURACION
                              WHERE CONF_EMPR = EMPRESA)
         AND FECHA = (SELECT FECHA
                        FROM STK_CONFIGURACION A, STK_PERIODO B
                       WHERE PERI_CODIGO = A.CONF_PERIODO_ACT
                         AND CONF_EMPR = PERI_EMPR
                         AND FECHA BETWEEN B.PERI_FEC_INI AND B.PERI_FEC_FIN
                         AND CONF_EMPR = EMPRESA);
    
      IF V_COCI_IND_PRE_CERRADO = 'S' THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'El periodo actual ya fue pre-cerrado para el sistema de finanzas!');
      END IF;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  END;

  PROCEDURE PP_AUDITAR_VER_STK(P_EMPRESA IN NUMBER, P_PERIODO IN NUMBER) IS
    --GEN ROL, AUDITORIA DE VERIFICACION DE SISTEMA
  
  BEGIN
  
    INSERT INTO STK_AUD_VERIF_SIST
      (AVS_EMPR, AVS_USUARIO, AVS_FECHA, AVS_PERIODO)
    VALUES
      (P_EMPRESA, GEN_DEVUELVE_USER, SYSDATE, P_PERIODO);
  
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END;

  FUNCTION FP_SITUACION_CHEQUE(P_EMPRESA          IN NUMBER,
                               P_CLAVE_CHEQUE     IN NUMBER,
                               P_FECHA_HASTA      IN DATE,
                               P_SITUACION_ACTUAL IN VARCHAR2)
    RETURN VARCHAR2 IS
    V_SITUACION_ACT VARCHAR2(45);
  BEGIN
  
    BEGIN
    
      /*ESTO ES PARA DETERMINAR EL PRIMER ESTADO ANTERIOR QUE TUVO
      DESPUES DE ESTA FECHA,EL SERIA EL ESTADO ACTUAL EN ESA FECHA SI NO HAY UN REGISTRO POSTERIOR
      SIGNIFICA QUE EL ESTADO ACTUAL DEL CHEQUE ES EL ESTADO ACTUAL A ESA FECHA*/
    
      SELECT CHDO_EST_ANT_CHEQ
        INTO V_SITUACION_ACT
        FROM (SELECT DOC_FEC_DOC,
                     DOC_FEC_GRAB,
                     B.CHDO_EST_ANT_CHEQ,
                     CHEQ_SITUACION
                FROM FIN_CHEQUE A, FIN_CHEQUE_DOCUMENTO B, FIN_DOCUMENTO D
               WHERE CHDO_CLAVE_DOC = D.DOC_CLAVE
                 AND CHDO_EMPR = DOC_EMPR
                 AND CHEQ_CLAVE = B.CHDO_CLAVE_CHEQ
                 AND CHEQ_EMPR = B.CHDO_EMPR
                 AND CHEQ_CLAVE = P_CLAVE_CHEQUE
               ORDER BY DOC_FEC_GRAB ASC)
       WHERE DOC_FEC_DOC > P_FECHA_HASTA
         AND ROWNUM = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_SITUACION_ACT := P_SITUACION_ACTUAL;
    END;
  
    RETURN V_SITUACION_ACT;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20343, SQLERRM);
  END;

  FUNCTION FL_AUTO_FECHA(I_FECHA IN VARCHAR2) RETURN VARCHAR2 IS
  
    V_FECHA        VARCHAR2(10);
    V_FECHA_AUX    VARCHAR2(100);
    V_FECHA_ACTUAL VARCHAR2(10) := TO_CHAR(SYSDATE, 'DDMMYYYY');
  BEGIN
 
    IF REGEXP_REPLACE(I_FECHA, '[^0-9]') IS NULL THEN
      V_FECHA := TO_CHAR(SYSDATE, 'DD/MM/YYYY');
      RETURN V_FECHA;
    END IF;
  
    V_FECHA_AUX := REGEXP_REPLACE(I_FECHA, '[^0-9]');
  
    IF LENGTH(V_FECHA_AUX) = 1 THEN
      V_FECHA_AUX := '0' || V_FECHA_AUX;
    END IF;
  
    V_FECHA := V_FECHA_AUX ||
               SUBSTR(V_FECHA_ACTUAL, LENGTH(V_FECHA_AUX) + 1, 10);
  
    IF TO_NUMBER(SUBSTR(V_FECHA, 0, 2)) >
      
       TO_NUMBER(SUBSTR(TO_CHAR(LAST_DAY(SYSDATE), 'DDMMYYYY'), 0, 2)) THEN
    
      --   RAISE_APPLICATION_ERROR(-20001,
      --                         'EL mes '||TO_CHAR(LAST_DAY(SYSDATE),
      --                                                   'MONTH') ||' solo tiene ' ||
      --                         TO_NUMBER(SUBSTR(TO_CHAR(LAST_DAY(SYSDATE),
      --                                                  'DDMMYYYY'),
      --                                          0,
      --                                       2))  ||' dias!');
      NULL;
    ELSIF TO_NUMBER(SUBSTR(V_FECHA, 3, 2)) > 12 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'El mes se ingresa desde el 1 hasta el 12!');
    END IF;
 -- RAISE_APPLICATION_ERROR(-20001, 'pasa?');
    BEGIN
      V_FECHA := TO_DATE(V_FECHA, 'DD/MM/YYYY');
    EXCEPTION
      when too_many_rows then
        RAISE_APPLICATION_ERROR(-20001, 'Fecha Incorrecta Verifique_2!');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Fecha Incorrecta Verifique!');
      
    END;
  
    RETURN V_FECHA;
   
  END;

  FUNCTION FP_RETORNA_ULT_DIA_HABIL(I_FECHA IN DATE, I_EMPRESA IN NUMBER)
    RETURN DATE IS
  
    V_FECHA_OUT DATE;
  
  BEGIN
  
    SELECT MAX(FECHA)
      INTO V_FECHA_OUT
      FROM (SELECT TO_DATE(LEVEL || '/' || TO_CHAR(I_FECHA, 'mm/yyyy'),
                           'dd/mm/yyyy') FECHA
              FROM DUAL
            CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(I_FECHA), 'DD'))) DIAS,
           GEN_FERIADO B
     WHERE DIAS.FECHA = B.FER_FEC(+)
       AND I_EMPRESA = B.FER_EMPR(+)
       AND CASE
             WHEN FER_FEC IS NOT NULL OR
                  REPLACE(TO_CHAR(FECHA, 'DAY', 'NLS_DATE_LANGUAGE=SPANISH'),
                          ' ',
                          NULL) = 'DOMINGO' THEN
              'FERIADO'
             ELSE
              'HABIL'
           END = 'HABIL';
  
    RETURN V_FECHA_OUT;
  END;

  FUNCTION FP_RETORNA_CANT_DIA_HABIL(I_FECHA_INI IN DATE,
                                     I_FECHA_FIN IN DATE,
                                     I_EMPRESA   IN NUMBER)
  
   RETURN NUMBER IS
  
    V_CANT_DIAS           NUMBER;
    V_CANT_MESES          NUMBER;
    V_CANT_DIAS_ACUMULADO NUMBER;
    V_FEC_INI_AUX         DATE;
    V_FEC_FIN_AUX         DATE;
    V_FEC_MES_AUX         DATE; --PARA CONTAR LA DIFERENCIA ENTRE MESES
  
  BEGIN
  
    IF I_FECHA_FIN IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'Ingrese la fecha hasta!');
    ELSIF I_FECHA_INI IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'Ingrese la fecha desde!');
    END IF;
  
    IF I_FECHA_FIN < I_FECHA_INI THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'La fecha hasta no puede ser menor a la fecha desde!');
    END IF;
  
    IF I_FECHA_FIN - I_FECHA_INI > 365 THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'El rango de fechas es muy elevado, revisa las fechas!');
    END IF;
  
    V_FEC_MES_AUX := I_FECHA_INI; --ACUMULADOR DE FECHAS PARA SABER CUANTOS MESES SON
  
    LOOP
    
      V_CANT_MESES := NVL(V_CANT_MESES, 0) + 1;
    
      EXIT WHEN TO_CHAR(V_FEC_MES_AUX, 'MM/YYY') = TO_CHAR(I_FECHA_FIN,
                                                           'MM/YYY');
    
      V_FEC_MES_AUX := ADD_MONTHS(V_FEC_MES_AUX, 1);
    
    END LOOP;
  
    FOR I IN 1 .. V_CANT_MESES LOOP
    
      IF V_CANT_MESES = 1 THEN
      
        V_FEC_INI_AUX := I_FECHA_INI;
        V_FEC_FIN_AUX := I_FECHA_FIN;
      ELSE
      
        IF I = 1 THEN
          V_FEC_INI_AUX := I_FECHA_INI;
          V_FEC_FIN_AUX := LAST_DAY(I_FECHA_INI);
        
        ELSIF I = V_CANT_MESES THEN
          V_FEC_INI_AUX := TO_DATE('01' || TO_CHAR(I_FECHA_FIN, 'MM/YYYY'));
          V_FEC_FIN_AUX := I_FECHA_FIN;
        
        ELSE
          V_FEC_INI_AUX := TO_DATE('01' ||
                                   TO_CHAR(ADD_MONTHS(V_FEC_INI_AUX, 1),
                                           'MM/YYYY'));
          V_FEC_FIN_AUX := TO_DATE(LAST_DAY(ADD_MONTHS(V_FEC_INI_AUX, 1)),
                                   'DD/MM/YYYY');
        
        END IF;
      END IF;
    
      SELECT COUNT(FECHA)
        INTO V_CANT_DIAS
        FROM (SELECT TO_DATE(LEVEL || '/' ||
                             TO_CHAR(V_FEC_INI_AUX, 'mm/yyyy'),
                             'dd/mm/yyyy') FECHA
                FROM DUAL
              CONNECT BY LEVEL <=
                         TO_NUMBER(TO_CHAR(LAST_DAY(V_FEC_INI_AUX), 'DD'))) DIAS,
             GEN_FERIADO B
       WHERE DIAS.FECHA = B.FER_FEC(+)
         AND I_EMPRESA = B.FER_EMPR(+)
         AND CASE
               WHEN FER_FEC IS NOT NULL OR
                    REPLACE(TO_CHAR(FECHA,
                                    'DAY',
                                    'NLS_DATE_LANGUAGE=SPANISH'),
                            ' ',
                            NULL) = 'DOMINGO' THEN
                'FERIADO'
               ELSE
                'HABIL'
             END = 'HABIL'
         AND FECHA BETWEEN V_FEC_INI_AUX AND V_FEC_FIN_AUX;
    
      V_CANT_DIAS_ACUMULADO := NVL(V_CANT_DIAS_ACUMULADO, 0) + V_CANT_DIAS;
    
    END LOOP;
  
    RETURN V_CANT_DIAS_ACUMULADO;
  END;

  FUNCTION FP_REGEXP_SUBSTR(I_TEXT    IN VARCHAR2,
                            I_EXP     IN VARCHAR2,
                            I_POS_INI IN NUMBER,
                            I_POS_FIN IN NUMBER) RETURN VARCHAR2 AS
    V_RETURN VARCHAR2(5000);
  BEGIN
    V_RETURN := REGEXP_SUBSTR(I_TEXT, I_EXP, I_POS_INI, I_POS_FIN);
    RETURN V_RETURN;
  END FP_REGEXP_SUBSTR;

  FUNCTION FP_PASS_VENCIDO RETURN BOOLEAN IS
    V_FECHA  DATE;
    V_RESULT NUMBER;
  BEGIN
    SELECT OPER_CADUCA
      INTO V_FECHA
      FROM GEN_OPERADOR
     WHERE OPER_LOGIN = GEN_DEVUELVE_USER
       AND OPER_LOGIN <> 'ADCS';
  
    IF TRUNC(SYSDATE) >= TRUNC(V_FECHA) THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END FP_PASS_VENCIDO;
  FUNCTION FP_CONV_NRO_TXT_TRA(V_NUMERO IN NUMBER,
                               V_MONEDA IN NUMBER DEFAULT NULL)
    RETURN VARCHAR2 IS
    V_TEXTO VARCHAR2(1000) := NULL;
    V_MILM  NUMBER;
    V_MILL  NUMBER;
    V_MILE  NUMBER;
    V_CENT  NUMBER;
  
    V_NUM_ENT_TXT VARCHAR2(13);
    V_NUM_DEC_TXT VARCHAR2(20);
    V_NUM_DEC     NUMBER;
  BEGIN
  
    IF V_NUMERO = 0 THEN
      RETURN 'CERO';
    END IF;
  
    /*    IF V_NUMERO > 999999999 THEN
        RETURN 'NUMERO ES MUY GRANDE';
    END IF;*/
  
    IF V_NUMERO > 999999999999 THEN
      RETURN 'NUMERO ES MUY GRANDE';
    END IF;
  
    -- ANTES V_NUM_ENT_TXT := LPAD(TO_CHAR(TRUNC(V_NUMERO)),10,'0');
    V_NUM_ENT_TXT := LPAD(TO_CHAR(TRUNC(V_NUMERO)), 13, '0');
  
    /* HALLAR LA PARTE MILMILLON?SIMA DE V_NUM_ENT_TXT */
    V_MILM := TO_NUMBER(SUBSTR(V_NUM_ENT_TXT, 2, 3));
    IF V_MILM > 0 THEN
      GENERAL.PP_CONV_NRO_TRES_DIG(V_TEXTO,
                                   LPAD(TO_CHAR(V_MILM), 3, '0'),
                                   ' MIL');
    END IF;
  
    /* HALLAR LA PARTE MILLON?SIMA DE V_NUM_ENT_TXT */
    V_MILL := TO_NUMBER(SUBSTR(V_NUM_ENT_TXT, 5, 3));
    IF V_MILL > 0 THEN
      GENERAL.PP_CONV_NRO_TRES_DIG(V_TEXTO,
                                   LPAD(TO_CHAR(V_MILL), 3, '0'),
                                   ' MILLON');
      IF V_MILL > 1 OR V_MILM > 0 THEN
        V_TEXTO := V_TEXTO || 'ES';
      END IF;
    END IF;
  
    /* HALLAR LA PARTE MIL?SIMA DE V_NUM_ENT_TXT */
    V_MILE := TO_NUMBER(SUBSTR(V_NUM_ENT_TXT, 8, 3));
    IF V_MILE > 0 THEN
      GENERAL.PP_CONV_NRO_TRES_DIG(V_TEXTO,
                                   LPAD(TO_CHAR(V_MILE), 3, '0'),
                                   ' MIL');
    END IF;
  
    /* HALLAR LA PARTE CENT?SIMA DE V_NUM_ENT_TXT */
    V_CENT := TO_NUMBER(SUBSTR(V_NUM_ENT_TXT, 11, 3));
    IF V_CENT > 0 THEN
      GENERAL.PP_CONV_NRO_TRES_DIG(V_TEXTO,
                                   LPAD(TO_CHAR(V_CENT), 3, '0'),
                                   NULL);
      IF UPPER(SUBSTR(V_TEXTO, NVL(LENGTH(V_TEXTO), 0) - 1, 2)) = 'UN' THEN
        V_TEXTO := V_TEXTO || '';
      END IF;
    END IF;
  
    /* HALLAR LA PARTE DE LOS DECIMALES */
    V_NUM_DEC := V_NUMERO - TRUNC(V_NUMERO);
    IF V_MONEDA = 1 THEN
      --V_TEXTO := V_TEXTO;
      RETURN V_TEXTO; -- SI LA MONEDA ES IGUAL A 1 ENTONCES NO MOSTRAS DECIMALES POR DEFAULT SI SE DEJA VACIO SE MUESTRAS LOS DECIMALES
    ELSE
      IF V_NUM_DEC = 0 AND V_MONEDA = 2 THEN
        RETURN V_TEXTO || ' CON 00/100';
      ELSE
        IF V_MONEDA = 2 THEN
          V_TEXTO := V_TEXTO || ' CON ';
        END IF;
      END IF;
      V_NUM_DEC_TXT := TO_CHAR(V_NUM_DEC);
      IF V_MONEDA = 2 THEN
        IF NVL(LENGTH(V_NUM_DEC_TXT), 0) = 2 THEN
          V_TEXTO := V_TEXTO || RPAD(SUBSTR(V_NUM_DEC_TXT, 2, 1), 2, 0) ||
                     '/100';
        ELSIF NVL(LENGTH(V_NUM_DEC_TXT), 0) = 3 THEN
          V_TEXTO := V_TEXTO || RPAD(SUBSTR(V_NUM_DEC_TXT, 2, 2), 2, 0) ||
                     '/100';
        ELSIF NVL(LENGTH(V_NUM_DEC_TXT), 0) = 4 THEN
          V_TEXTO := V_TEXTO || SUBSTR(V_NUM_DEC_TXT, 2, 3) || '/1000';
        ELSE
          V_TEXTO := V_TEXTO || SUBSTR(V_NUM_DEC_TXT, 2, 4) || '/10000';
        END IF;
      END IF;
    END IF;
  
    RETURN V_TEXTO;
  
  END;

  FUNCTION FP_VAL_CAJA_ARQUEO(I_EMPRESA IN NUMBER) RETURN BOOLEAN IS
    V_COUNT  NUMBER;
    V_RETURN BOOLEAN;
  
  BEGIN
    IF I_EMPRESA = 2 THEN
      V_RETURN := FALSE;
    ELSE
      SELECT COUNT(*)
        INTO V_COUNT
        FROM FIN_OPER_CTA_BCO B, GEN_OPERADOR C
       WHERE B.OP_CTA_OPER = C.OPER_CODIGO
         AND C.OPER_LOGIN = GEN_DEVUELVE_USER
         AND B.OP_CTA_ARQUEO = 'S'
         AND B.OP_CTA_EMPR = I_EMPRESA;
      IF V_COUNT > 0 THEN
        V_RETURN := TRUE;
      ELSE
        V_RETURN := FALSE;
      END IF;
    END IF;
    RETURN V_RETURN;
  END FP_VAL_CAJA_ARQUEO;

  PROCEDURE PP_ACT_IP_GEN_IMPRESORA(I_IP       VARCHAR2,
                                    I_EMPR     IN NUMBER,
                                    I_TERMINAL IN VARCHAR2) IS
  BEGIN
  
    UPDATE GEN_IMPRESORA S
       SET S.IMPR_IP = I_IP
     WHERE S.IMP_TERMINAL = UPPER(I_TERMINAL)
       AND S.IMP_EMPR = I_EMPR;
  
  END;

    
  function is_external_operator(
    in_user varchar2 := null
  )return boolean is
  l_c number;
  begin
    select distinct 1 into l_c
    from gen_operador_externo e
    where e.the_user = nvl(in_user, sys_context('APEX$SESSION','APP_USER'));
    
    return true;
  exception
    when others then
      return false;
  end is_external_operator; 
  
  function get_external_operator_id(
    in_user varchar2 := null
  )return number
  is 
  l_r number;
  begin
    select e.id
    into l_r
    from gen_operador_externo e
    where e.the_user = coalesce(in_user, sys_context('APEX$SESSION','APP_USER'));
    
    return l_r;
  exception
    when no_data_found then
      return -999;
  end get_external_operator_id;
  
  -- obtiene los cargos del operador, segun la empresa
  function get_position_operator(
    in_empresa  number,
    in_operator number
  )return number is
  l_cargo number;
  begin
    -- solo puede haber un cargo por empresa y operador, es igual que el de la ficha
    -- viene de PER_CARGO
    select c.cargo_id
    into l_cargo
    from gen_operador_ext_cargos c
    where c.oper_ext_id = coalesce(in_operator, get_external_operator_id)
    and   c.empr_id     = in_empresa;
 
    return l_cargo;
  exception
    when no_Data_found then
      return null;
  end get_position_operator;

  function get_logo_empresa(
    in_empresa number
  ) return gen_empresa.empr_logo%type is
  l_r gen_empresa.empr_logo%type;
  begin
    select e.empr_logo
    into l_r
    from gen_empresa e
    where e.empr_codigo=in_empresa;
    
    return l_r;
  exception
    when no_data_found then
      return null;  
  end get_logo_empresa;
  
BEGIN
  -- INITIALIZATION
  NULL;
END GENERAL;
/
