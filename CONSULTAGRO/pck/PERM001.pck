create or replace package PERM001 is

  -- Author  : PROGRAMACION4
  -- Created : 28/12/2019 8:24:32
  -- Purpose : PAQUETE PARA MANTENIMIENTO

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  FUNCTION F_CALC_ANTIGUEDAD(P_FECHA_INGRESO DATE,
                             P_FECHA_SALIDA  DATE,
                             P_SITUACION     VARCHAR2) RETURN VARCHAR2;

  FUNCTION FP_OPER_HAB_PEST(I_EMPRESA  IN NUMBER,
                            I_USER     IN VARCHAR2,
                            I_PESTANHA IN VARCHAR2) RETURN NUMBER;

  PROCEDURE PP_GUARDAR_EMPLEADO(I_EMPL     IN PER_EMPLEADO%ROWTYPE,
                                I_OPER     IN VARCHAR2,
                                I_SUCURSAL IN NUMBER,
                                I_INDICE   IN VARCHAR2);

  PROCEDURE PP_TRAER_DATOS_POSTULANTE(V_EMPRESA       IN NUMBER,
                                      V_CLAVE_POST    IN NUMBER,
                                      V_NOMBRE_POST   OUT VARCHAR2,
                                      V_APELLIDO_POST OUT VARCHAR2,
                                      V_CEDULA_POST   OUT VARCHAR2,
                                      V_SEXO          OUT VARCHAR2,
                                      V_NACIO_POST    OUT NUMBER,
                                      V_EST_CIVIL     OUT VARCHAR2,
                                      V_OFICIO_POST   OUT NUMBER,
                                      V_DOMIC_POST    OUT VARCHAR2,
                                      V_CELULAR       OUT VARCHAR2,
                                      V_NIVEL_EDUC    OUT VARCHAR2,
                                      V_FEC_NAC       OUT DATE, ----DATOS POSUTLANTE
                                      V_TIPO_CONTRATO OUT VARCHAR2,
                                      V_AREA          OUT NUMBER,
                                      V_CARGO         OUT NUMBER,
                                      V_CONT_POR      OUT VARCHAR2,
                                      V_MARCACION     OUT VARCHAR2,
                                      V_MAR_SABADO    OUT VARCHAR2,
                                      V_MAR_ALMUERZO  OUT VARCHAR2,
                                      V_MAR_SISTEMA   OUT VARCHAR2,
                                      V_FORMA_PAGO    OUT NUMBER,
                                      V_SUCURSAL      OUT NUMBER);

  --==================================== ERDM ===============================================--
  PROCEDURE PP_INSERTAR_CLIENTE_PROVEEDOR(I_EMPL     IN PER_EMPLEADO%ROWTYPE,
                                          I_OPER     IN VARCHAR2,
                                          I_SUCURSAL IN NUMBER);

  --======================================= ==================================================--
  PROCEDURE PP_GENERAR_VCARD(I_EMPRESA IN NUMBER);
  
    PROCEDURE PP_EDITAR_CTA_BANCO (P_EMPRESA         IN NUMBER,
                                   P_SUCURSAL        IN NUMBER,
                                   P_DEPARTAMENTO    IN NUMBER);
  
    PROCEDURE PP_EDITAR_BCO (P_SEQ       IN NUMBER,
                             P_UBICACION IN NUMBER,
                             P_VALOR    IN NUMBER);
                             
                             
     PROCEDURE PP_EDITAR_REGISTRO;            
end PERM001;
/
CREATE OR REPLACE PACKAGE BODY PERM001 IS

  FUNCTION F_CALC_ANTIGUEDAD(P_FECHA_INGRESO DATE,
                             P_FECHA_SALIDA  DATE,
                             P_SITUACION     VARCHAR2) RETURN VARCHAR2 AS
    V_ANHOS   NUMBER := 0;
    V_MESES   NUMBER := 0;
    V_MSJ     VARCHAR2(100) := NULL;
    V_INGRESO DATE;
    V_SALIDA  DATE;
  BEGIN

    V_INGRESO := TO_DATE(P_FECHA_INGRESO, 'DD/MM/YYYY');
    V_SALIDA  := TO_DATE(P_FECHA_SALIDA, 'DD/MM/YYYY');

    IF P_SITUACION = 'A' THEN

      SELECT TRUNC((MONTHS_BETWEEN(TO_DATE(SYSDATE, 'dd/mm/yyyy'),
                                   TO_DATE(P_FECHA_INGRESO))) / 12)
        INTO V_ANHOS
        FROM DUAL;

      SELECT ROUND((((MONTHS_BETWEEN(TO_DATE(SYSDATE, 'dd/mm/yyyy'),
                                     TO_DATE(P_FECHA_INGRESO))) / 12) -
                   TRUNC((MONTHS_BETWEEN(TO_DATE(SYSDATE, 'dd/mm/yyyy'),
                                          TO_DATE(P_FECHA_INGRESO))) / 12)) * 12,
                   0)
        INTO V_MESES
        FROM DUAL;
      IF V_ANHOS > 0 THEN
        V_MSJ := V_ANHOS || ' a'||chr(241)||'os';
        IF V_ANHOS = 1 THEN
          V_MSJ := SUBSTR(V_MSJ, 1, LENGTH(V_MSJ) - 1);
        END IF;
      END IF;

      IF V_MESES > 0 THEN
        V_MSJ := V_MSJ || ' ' || V_MESES || ' meses';
        IF V_MESES = 1 THEN
          V_MSJ := SUBSTR(V_MSJ, 1, LENGTH(V_MSJ) - 2);
        END IF;
      END IF;

      RETURN V_MSJ;

    ELSE

      /* SELECT TRUNC((MONTHS_BETWEEN(TO_DATE(TO_DATE(P_FECHA_SALIDA), 'dd/mm/yyyy'),
                                 TO_DATE(P_FECHA_INGRESO))) / 12)
      INTO V_ANHOS
      FROM DUAL;*/

      SELECT TRUNC((MONTHS_BETWEEN(V_SALIDA, V_INGRESO)) / 12)
        INTO V_ANHOS
        FROM DUAL;

      /*  SELECT ROUND((((MONTHS_BETWEEN(TO_DATE(TO_DATE(P_FECHA_SALIDA), 'dd/mm/yyyy'),
                                   TO_DATE(P_FECHA_INGRESO))) / 12) -
                 TRUNC((MONTHS_BETWEEN(TO_DATE(P_FECHA_SALIDA,
                                                'dd/mm/yyyy'),
                                        TO_DATE(P_FECHA_INGRESO))) / 12)) * 12,
                 0)
      INTO V_MESES
      FROM DUAL;*/

      SELECT ROUND((((MONTHS_BETWEEN(V_SALIDA, V_INGRESO)) / 12) -
                   TRUNC((MONTHS_BETWEEN(V_SALIDA, V_INGRESO)) / 12)) * 12,
                   0)
        INTO V_MESES
        FROM DUAL;

      IF V_ANHOS > 0 THEN
        V_MSJ := V_ANHOS || ' a'||chr(241)||'os';
        IF V_ANHOS = 1 THEN
          V_MSJ := SUBSTR(V_MSJ, 1, LENGTH(V_MSJ) - 1);
        END IF;
      END IF;

      IF V_MESES > 0 THEN
        V_MSJ := V_MSJ || ' ' || V_MESES || ' meses';
        IF V_MESES = 1 THEN
          V_MSJ := SUBSTR(V_MSJ, 1, LENGTH(V_MSJ) - 2);
        END IF;
      END IF;

      RETURN V_MSJ;

    END IF;

  END F_CALC_ANTIGUEDAD;

  FUNCTION FP_OPER_HAB_PEST(I_EMPRESA  IN NUMBER,
                            I_USER     IN VARCHAR2,
                            I_PESTANHA IN VARCHAR2) RETURN NUMBER IS
    V_HAB NUMBER;
  BEGIN

  --  IF I_EMPRESA = 1 THEN
      SELECT 1
        INTO V_HAB
        FROM GEN_OPER_PEST_RRHH   T,
             GEN_PEST_RRHH        P,
             GEN_OPERADOR_EMPRESA OE,
             GEN_OPERADOR         O
       WHERE P.PESTRH_CODIGO = T.OPERRHH_PEST
         AND P.PESTRH_EMPR = T.OPERRHH_EMPR
         AND O.OPER_CODIGO = OE.OPEM_OPER
         AND OE.OPEM_EMPR = T.OPERRHH_EMPR
         AND T.OPERRHH_OPER = OE.OPEM_OPER
         AND T.OPERRHH_EMPR = I_EMPRESA
         AND UPPER(P.PESTRH_DESC) = UPPER(I_PESTANHA)
         AND O.OPER_LOGIN = I_USER;
   -- ELSE
    --  V_HAB := 1;
  --  END IF;

    RETURN V_HAB;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN

      V_HAB := 0;

      RETURN V_HAB;

  END;

  PROCEDURE PP_GUARDAR_EMPLEADO(I_EMPL     IN PER_EMPLEADO%ROWTYPE,
                                I_OPER     IN VARCHAR2,
                                I_SUCURSAL IN NUMBER,
                                I_INDICE   IN VARCHAR2) AS

    TOTAL_PORCENTAJE NUMBER;
    PERIODO_LINEA    NUMBER;
    V_CONTADOR       NUMBER;
    V_PROVEEDOR      NUMBER;
    V_CLIENTE        NUMBER;
    V_CLI_2          NUMBER;
    V_CONT_NOM_ID    NUMBER;

    V_FORMA_PAGO     NUMBER;
    V_TIPO_PAGO      NUMBER;
    v_COD_EXISTE     NUMBER;
  BEGIN

    IF I_EMPL.EMPL_EMPRESA = 2 AND I_INDICE = 'N' THEN
      V_PROVEEDOR := NULL;
      V_CLIENTE   := NULL;
      V_CLI_2     := NULL;
    ELSIF I_EMPL.EMPL_EMPRESA = 2 AND I_INDICE = 'S' AND I_OPER = 'INSERT' THEN

      BEGIN
        PERM001.PP_INSERTAR_CLIENTE_PROVEEDOR(I_EMPL     => I_EMPL,
                                              I_OPER     => I_OPER,
                                              I_SUCURSAL => I_SUCURSAL);

      END;

      V_PROVEEDOR := I_EMPL.EMPL_CODIGO_PROV;
      V_CLIENTE   := I_EMPL.EMPL_COD_CLIENTE;
      V_CLI_2     := I_EMPL.EMPL_CODIGO_CLI;

    ELSE
      V_PROVEEDOR := I_EMPL.EMPL_CODIGO_PROV;
      V_CLIENTE   := I_EMPL.EMPL_COD_CLIENTE;
      V_CLI_2     := I_EMPL.EMPL_CODIGO_CLI;
    END IF;

/*
IF I_EMPL.EMPL_TIPO_CONT = 'T' AND I_EMPL.EMPL_TERMINO_CONT is null THEN
RAISE_APPLICATION_ERROR (-20001, 'Falta cargar la fecha de termino de contrato');
END IF;*/


if I_EMPL.EMPL_MON_PAGO  is null then
  RAISE_APPLICATION_ERROR(-20010,'Falta Cargar la moneda de pago');

end if;
    -- RAISE_APPLICATION_ERROR(-20010,I_OPER||' OPERADOR = '||I_EMPL.EMPL_EMPRESA);
    IF I_OPER = 'INSERT' THEN
      ---================================================== ERDM ==========================================================---
 
      ---===================================================== =============================================================--
      SELECT COUNT (*)
        INTO V_COD_EXISTE
      FROM PER_EMPLEADO A 
      WHERE A.EMPL_DOC_IDENT = I_EMPL.EMPL_DOC_IDENT
        AND EMPL_EMPRESA = I_EMPL.EMPL_EMPRESA;
      
      IF V_COD_EXISTE > 0 THEN 
        RAISE_APPLICATION_ERROR(-20010,'Ya existe una ficha con ese nro de Cedula');
      
      END IF;
      
      BEGIN
        INSERT INTO PER_EMPLEADO
        (EMPL_LEGAJO,
         EMPL_NOMBRE,
         EMPL_DIR,
         EMPL_LOCALIDAD,
         EMPL_TEL,
         EMPL_EST_CIVIL,
         EMPL_SEXO,
         EMPL_GRUP_SANG,
         EMPL_FEC_NAC,
         EMPL_NACIONALIDAD,
         EMPL_DOC_IDENT,
         EMPL_PROF,
         EMPL_INSTRUCCION,
         EMPL_OBSERVA,
         EMPL_APE,
         EMPL_RUC,
         EMPL_FEC_INGRESO,
         EMPL_CATEG,
         EMPL_FORMA_PAGO,
         EMPL_GRUPO_PAGO,
         EMPL_CARGO,
         EMPL_EMPRESA,
         EMPL_SUCURSAL,
         EMPL_DEPARTAMENTO,
         EMPL_SITUACION_IPS,
         EMPL_PAGA_IPS,
         EMPL_NRO_SEG_SOCIAL,
         EMPL_SALARIO_BASE,
         EMPL_SALARIO_IPS,
         EMPL_SAL_BASI_REAL,
         EMPL_PLUS_OBJETIVO,
         EMPL_PLUS_FIJO,
         EMPL_IND_ANTICIPOS,
         EMPL_PRECIO_HNORMAL,
         EMPL_PRECIO_HEXTRA,
         EMPL_PRECIO_HNOCTURNA,
         EMPL_PRECIO_HDOMINGO,
         EMPL_SITUACION_ESCOLAR,
         EMPL_OBJ_HMES,
         EMPL_FEC_SALIDA,
         EMPL_MOTIVO_SALIDA,
         EMPL_HORA_ENTRADA,
         EMPL_HORA_SALIDA,
         EMPL_HORA_SAB_ENTRADA,
         EMPL_HORA_SAB_SALIDA,
         EMPL_HORA_DOM_ENTRADA,
         EMPL_HORA_DOM_SALIDA,
         EMPL_TURNO,
         EMPL_FEC_EMIS_CERT,
         EMPL_CODIGO_ACCESO,
         EMPL_CALC_HR_EXT,
         EMPL_TIEMPO_ALM,
         EMPL_DESC_TIEMP_ALM,
         EMPL_TIPO_SALARIO,
         EMPL_IMP_HORA_N_D,
         EMPL_IMP_HORA_N_N,
         EMPL_IMP_HORA_E_D,
         EMPL_IMP_HORA_E_N,
         EMPL_IMP_HORA_DF_D,
         EMPL_IMP_HORA_DF_N,
         EMPL_CODIGO_PROV,
         EMPL_IMP_HORA_E_M,
         EMPL_BCO_PAGO,
         EMPL_NRO_CTA,
         EMPL_MON_PAGO,
         EMPL_IMG_LR,
         EMPL_COD_OPERADOR,
         EMPL_PAGA_IRP,
         EMPL_PORC_IRP,
         EMPL_EMAIL_O365,
         EMPL_NRO_CORP,
         EMPL_NRO_CASILLERO,
         EMPL_VTO_PERIODO_PRUEBA,
         EMPL_TIPO_SEGURO,
         EMPL_ENTIDAD_SEGURO,
         EMPL_INICIO_SEGURO,
         EMPL_VENC_SEGURO,
         EMPL_COSTO_SEGURO,
         EMPL_NRO_CASILLERO_ALFA,
         EMPL_DOC_AREA_EEB,
         EMPL_DOC_AREA_EM,
         EMPL_DOC_AREA_ADM,
         EMPL_DOC_AREA_UNI,
         EMPL_DOC_AREA_EI,
         EMPL_DOC_AREA_MIES,
         EMPL_PH_ADM,
         EMPL_PH_MIES,
         EMPL_PH_EI,
         EMPL_PH_EEB,
         EMPL_PH_EM,
         EMPL_PH_OF,
         EMPL_DOC_AREA_OF,
         EMPL_DEPARTAMENTO_SEC,
         EMPL_DEPARTAMENTO_TERC,
         EMPL_COD_RELOJ,
         EMPL_COD_CLIENTE,
         EMPL_CONTRATADO_POR,
         EMPL_MARC_COMIS_SIST,
         EMPL_TIPO_COMIS,
         EMPL_AREA_ORGANI,
         EMPL_MOT_DESV,
         EMPL_FAC_DESV,
         EMPL_TIPO_DESV,
         EMPL_MAR_INDUCC,
         EMPL_TIPO_CONT,
         EMPL_NOMBRE_AD,
         EMPL_NRO_MTESS,
         EMPL_CONS_MARC,
         EMPL_MARC_ENTRADA,
         EMPL_MARC_SALIDA,
         EMPL_EVAL_DES_MARC,
         EMPL_IND_HORA_EXTRA,
         EMPL_GRUP_COMIS,
         EMPL_COB_EFECTIVO,
         EMPL_CODIGO_CHOFER,
         EMPL_CODIGO_CLI,
         EMPL_IND_IMP_CONTRATO,
         EMPL_LOGIN,
         EMPL_ZAFRA,
         EMPL_IMP_PLUS_SALARIAL,
         EMPL_CONS_MARC_TAB,
         EMPL_COD_POSTULANTE,
         EMPL_TIPO_TRABAJADOR,
         EMPL_MARC_SIST,
         EMPL_MARC_SABADO,
         EMPL_MARC_ALMUERZO,
         EMPL_V_CONTACTO,
         EMPL_V_NRO_CEL,
         EMPL_LIMITE_CRED,
         EMPL_CHEK_LIM_CD,
         EMPL_PORCENTAJE,
         EMPL_IND_COM_TRANS,
         EMPL_IND_VIATICO,
         EMPL_MONTO_VIATICO,
         EMPL_TERMINO_CONT)
      VALUES
        (I_EMPL.EMPL_LEGAJO,
         I_EMPL.EMPL_NOMBRE,
         I_EMPL.EMPL_DIR,
         I_EMPL.EMPL_LOCALIDAD,
         I_EMPL.EMPL_TEL,
         I_EMPL.EMPL_EST_CIVIL,
         I_EMPL.EMPL_SEXO,
         I_EMPL.EMPL_GRUP_SANG,
         I_EMPL.EMPL_FEC_NAC,
         I_EMPL.EMPL_NACIONALIDAD,
         I_EMPL.EMPL_DOC_IDENT,
         I_EMPL.EMPL_PROF,
         I_EMPL.EMPL_INSTRUCCION,
         I_EMPL.EMPL_OBSERVA,
         I_EMPL.EMPL_APE,
         I_EMPL.EMPL_RUC,
         I_EMPL.EMPL_FEC_INGRESO,
         I_EMPL.EMPL_CATEG,
         I_EMPL.EMPL_FORMA_PAGO,
         I_EMPL.EMPL_GRUPO_PAGO,
         I_EMPL.EMPL_CARGO,
         I_EMPL.EMPL_EMPRESA,
         I_EMPL.EMPL_SUCURSAL,
         I_EMPL.EMPL_DEPARTAMENTO,
         I_EMPL.EMPL_SITUACION_IPS,
         I_EMPL.EMPL_PAGA_IPS,
         I_EMPL.EMPL_NRO_SEG_SOCIAL,
         I_EMPL.EMPL_SALARIO_BASE,
         I_EMPL.EMPL_SALARIO_IPS,
         I_EMPL.EMPL_SAL_BASI_REAL,
         I_EMPL.EMPL_PLUS_OBJETIVO,
         I_EMPL.EMPL_PLUS_FIJO,
         I_EMPL.EMPL_IND_ANTICIPOS,
         I_EMPL.EMPL_PRECIO_HNORMAL,
         I_EMPL.EMPL_PRECIO_HEXTRA,
         I_EMPL.EMPL_PRECIO_HNOCTURNA,
         I_EMPL.EMPL_PRECIO_HDOMINGO,
         I_EMPL.EMPL_SITUACION_ESCOLAR,
         I_EMPL.EMPL_OBJ_HMES,
         I_EMPL.EMPL_FEC_SALIDA,
         I_EMPL.EMPL_MOTIVO_SALIDA,
         I_EMPL.EMPL_HORA_ENTRADA,
         I_EMPL.EMPL_HORA_SALIDA,
         I_EMPL.EMPL_HORA_SAB_ENTRADA,
         I_EMPL.EMPL_HORA_SAB_SALIDA,
         I_EMPL.EMPL_HORA_DOM_ENTRADA,
         I_EMPL.EMPL_HORA_DOM_SALIDA,
         I_EMPL.EMPL_TURNO,
         I_EMPL.EMPL_FEC_EMIS_CERT,
         I_EMPL.EMPL_CODIGO_ACCESO,
         I_EMPL.EMPL_CALC_HR_EXT,
         I_EMPL.EMPL_TIEMPO_ALM,
         I_EMPL.EMPL_DESC_TIEMP_ALM,
         I_EMPL.EMPL_TIPO_SALARIO,
         I_EMPL.EMPL_IMP_HORA_N_D,
         I_EMPL.EMPL_IMP_HORA_N_N,
         I_EMPL.EMPL_IMP_HORA_E_D,
         I_EMPL.EMPL_IMP_HORA_E_N,
         I_EMPL.EMPL_IMP_HORA_DF_D,
         I_EMPL.EMPL_IMP_HORA_DF_N,
         V_PROVEEDOR, --I_EMPL.EMPL_CODIGO_PROV,
         I_EMPL.EMPL_IMP_HORA_E_M,
         I_EMPL.EMPL_BCO_PAGO,
         I_EMPL.EMPL_NRO_CTA,
         I_EMPL.EMPL_MON_PAGO,
         I_EMPL.EMPL_IMG_LR,
         I_EMPL.EMPL_COD_OPERADOR,
         I_EMPL.EMPL_PAGA_IRP,
         I_EMPL.EMPL_PORC_IRP,
         I_EMPL.EMPL_EMAIL_O365,
         I_EMPL.EMPL_NRO_CORP,
         I_EMPL.EMPL_NRO_CASILLERO,
         I_EMPL.EMPL_VTO_PERIODO_PRUEBA,
         I_EMPL.EMPL_TIPO_SEGURO,
         I_EMPL.EMPL_ENTIDAD_SEGURO,
         I_EMPL.EMPL_INICIO_SEGURO,
         I_EMPL.EMPL_VENC_SEGURO,
         I_EMPL.EMPL_COSTO_SEGURO,
         I_EMPL.EMPL_NRO_CASILLERO_ALFA,
         I_EMPL.EMPL_DOC_AREA_EEB,
         I_EMPL.EMPL_DOC_AREA_EM,
         I_EMPL.EMPL_DOC_AREA_ADM,
         I_EMPL.EMPL_DOC_AREA_UNI,
         I_EMPL.EMPL_DOC_AREA_EI,
         I_EMPL.EMPL_DOC_AREA_MIES,
         I_EMPL.EMPL_PH_ADM,
         I_EMPL.EMPL_PH_MIES,
         I_EMPL.EMPL_PH_EI,
         I_EMPL.EMPL_PH_EEB,
         I_EMPL.EMPL_PH_EM,
         I_EMPL.EMPL_PH_OF,
         I_EMPL.EMPL_DOC_AREA_OF,
         I_EMPL.EMPL_DEPARTAMENTO_SEC,
         I_EMPL.EMPL_DEPARTAMENTO_TERC,
         I_EMPL.EMPL_COD_RELOJ,
         V_CLIENTE, --I_EMPL.EMPL_COD_CLIENTE,
         I_EMPL.EMPL_CONTRATADO_POR,
         I_EMPL.EMPL_MARC_COMIS_SIST,
         I_EMPL.EMPL_TIPO_COMIS,
         I_EMPL.EMPL_AREA_ORGANI,
         I_EMPL.EMPL_MOT_DESV,
         I_EMPL.EMPL_FAC_DESV,
         I_EMPL.EMPL_TIPO_DESV,
         I_EMPL.EMPL_MAR_INDUCC,
         I_EMPL.EMPL_TIPO_CONT,
         I_EMPL.EMPL_NOMBRE_AD,
         I_EMPL.EMPL_NRO_MTESS,
         I_EMPL.EMPL_CONS_MARC,
         I_EMPL.EMPL_MARC_ENTRADA,
         I_EMPL.EMPL_MARC_SALIDA,
         I_EMPL.EMPL_EVAL_DES_MARC,
         I_EMPL.EMPL_IND_HORA_EXTRA,
         I_EMPL.EMPL_GRUP_COMIS,
         I_EMPL.EMPL_COB_EFECTIVO,
         I_EMPL.EMPL_CODIGO_CHOFER,
         V_CLI_2, --I_EMPL.EMPL_CODIGO_CLI,
         I_EMPL.EMPL_IND_IMP_CONTRATO,
         I_EMPL.EMPL_LOGIN,
         I_EMPL.EMPL_ZAFRA,
         I_EMPL.EMPL_IMP_PLUS_SALARIAL,
         I_EMPL.EMPL_CONS_MARC_TAB,
         I_EMPL.EMPL_COD_POSTULANTE,
         I_EMPL.EMPL_TIPO_TRABAJADOR,
         I_EMPL.EMPL_MARC_SIST,
         I_EMPL.EMPL_MARC_SABADO,
         I_EMPL.EMPL_MARC_ALMUERZO,
         I_EMPL.EMPL_V_CONTACTO,
         I_EMPL.EMPL_V_NRO_CEL,
         I_EMPL.EMPL_LIMITE_CRED,
         I_EMPL.EMPL_CHEK_LIM_CD,
         I_EMPL.EMPL_PORCENTAJE,
         I_EMPL.EMPL_IND_COM_TRANS,
         I_EMPL.EMPL_IND_VIATICO,
         I_EMPL.EMPL_MONTO_VIATICO,
         I_EMPL.EMPL_TERMINO_CONT);
         END;
  
         ----------------------------PERDIDO DE ANDREA --- PARA QUE CREE DIRECTO EL CODIGO RELOJ
        IF   I_EMPL.EMPL_DOC_IDENT  IS NOT NULL AND  I_EMPL.EMPL_EMPRESA = 1 THEN
                 insert into per_codigos_reloj
                   (codr_legajo, codr_cod_reloj, codr_empr)
                 values
                   (I_EMPL.EMPL_LEGAJO, I_EMPL.EMPL_LEGAJO, I_EMPL.EMPL_EMPRESA);

        END IF;
    ELSIF I_OPER = 'UPDATE' THEN
      IF I_EMPL.EMPL_SITUACION = 'A' THEN


        UPDATE PER_EMPLEADO
           SET EMPL_NOMBRE             = TO_CHAR(I_EMPL.EMPL_NOMBRE),
               EMPL_DIR                = I_EMPL.EMPL_DIR,
               EMPL_LOCALIDAD          = I_EMPL.EMPL_LOCALIDAD,
               EMPL_TEL                = I_EMPL.EMPL_TEL,
               EMPL_EST_CIVIL          = I_EMPL.EMPL_EST_CIVIL,
               EMPL_SEXO               = I_EMPL.EMPL_SEXO,
               EMPL_GRUP_SANG          = I_EMPL.EMPL_GRUP_SANG,
               EMPL_FEC_NAC            = I_EMPL.EMPL_FEC_NAC,
               EMPL_NACIONALIDAD       = I_EMPL.EMPL_NACIONALIDAD,
               EMPL_DOC_IDENT          = I_EMPL.EMPL_DOC_IDENT,
               EMPL_PROF               = I_EMPL.EMPL_PROF,
               EMPL_INSTRUCCION        = I_EMPL.EMPL_INSTRUCCION,
               EMPL_OBSERVA            = I_EMPL.EMPL_OBSERVA,
               EMPL_APE                = I_EMPL.EMPL_APE,
               EMPL_RUC                = I_EMPL.EMPL_RUC,
               EMPL_FEC_INGRESO        = I_EMPL.EMPL_FEC_INGRESO,
               EMPL_CATEG              = I_EMPL.EMPL_CATEG,
               EMPL_FORMA_PAGO         = I_EMPL.EMPL_FORMA_PAGO,
               EMPL_GRUPO_PAGO         = I_EMPL.EMPL_GRUPO_PAGO,
               EMPL_CARGO              = I_EMPL.EMPL_CARGO,
               EMPL_SUCURSAL           = I_EMPL.EMPL_SUCURSAL,
               EMPL_DEPARTAMENTO       = I_EMPL.EMPL_DEPARTAMENTO,
               EMPL_SITUACION_IPS      = I_EMPL.EMPL_SITUACION_IPS,
               EMPL_PAGA_IPS           = I_EMPL.EMPL_PAGA_IPS,
               EMPL_NRO_SEG_SOCIAL     = I_EMPL.EMPL_NRO_SEG_SOCIAL,
               EMPL_SALARIO_BASE       = I_EMPL.EMPL_SALARIO_BASE,
               EMPL_SALARIO_IPS        = I_EMPL.EMPL_SALARIO_IPS,
               EMPL_SAL_BASI_REAL      = I_EMPL.EMPL_SAL_BASI_REAL,
               EMPL_PLUS_OBJETIVO      = I_EMPL.EMPL_PLUS_OBJETIVO,
               EMPL_PLUS_FIJO          = I_EMPL.EMPL_PLUS_FIJO,
               EMPL_IND_ANTICIPOS      = I_EMPL.EMPL_IND_ANTICIPOS,
               EMPL_PRECIO_HNORMAL     = I_EMPL.EMPL_PRECIO_HNORMAL,
               EMPL_PRECIO_HEXTRA      = I_EMPL.EMPL_PRECIO_HEXTRA,
               EMPL_PRECIO_HNOCTURNA   = I_EMPL.EMPL_PRECIO_HNOCTURNA,
               EMPL_PRECIO_HDOMINGO    = I_EMPL.EMPL_PRECIO_HDOMINGO,
               EMPL_SITUACION_ESCOLAR  = I_EMPL.EMPL_SITUACION_ESCOLAR,
               EMPL_OBJ_HMES           = I_EMPL.EMPL_OBJ_HMES,
               EMPL_FEC_SALIDA         = I_EMPL.EMPL_FEC_SALIDA,
               EMPL_MOTIVO_SALIDA      = I_EMPL.EMPL_MOTIVO_SALIDA,
               EMPL_HORA_ENTRADA       = I_EMPL.EMPL_HORA_ENTRADA,
               EMPL_HORA_SALIDA        = I_EMPL.EMPL_HORA_SALIDA,
               EMPL_HORA_SAB_ENTRADA   = I_EMPL.EMPL_HORA_SAB_ENTRADA,
               EMPL_HORA_SAB_SALIDA    = I_EMPL.EMPL_HORA_SAB_SALIDA,
               EMPL_HORA_DOM_ENTRADA   = I_EMPL.EMPL_HORA_DOM_ENTRADA,
               EMPL_HORA_DOM_SALIDA    = I_EMPL.EMPL_HORA_DOM_SALIDA,
               EMPL_TURNO              = I_EMPL.EMPL_TURNO,
               EMPL_FEC_EMIS_CERT      = I_EMPL.EMPL_FEC_EMIS_CERT,
               EMPL_CODIGO_ACCESO      = I_EMPL.EMPL_CODIGO_ACCESO,
               EMPL_CALC_HR_EXT        = I_EMPL.EMPL_CALC_HR_EXT,
               EMPL_TIEMPO_ALM         = I_EMPL.EMPL_TIEMPO_ALM,
               EMPL_DESC_TIEMP_ALM     = I_EMPL.EMPL_DESC_TIEMP_ALM,
               EMPL_TIPO_SALARIO       = I_EMPL.EMPL_TIPO_SALARIO,
               EMPL_IMP_HORA_N_D       = I_EMPL.EMPL_IMP_HORA_N_D,
               EMPL_IMP_HORA_N_N       = I_EMPL.EMPL_IMP_HORA_N_N,
               EMPL_IMP_HORA_E_D       = I_EMPL.EMPL_IMP_HORA_E_D,
               EMPL_IMP_HORA_E_N       = I_EMPL.EMPL_IMP_HORA_E_N,
               EMPL_IMP_HORA_DF_D      = I_EMPL.EMPL_IMP_HORA_DF_D,
               EMPL_IMP_HORA_DF_N      = I_EMPL.EMPL_IMP_HORA_DF_N,
               EMPL_CODIGO_PROV        = I_EMPL.EMPL_CODIGO_PROV,
               EMPL_IMP_HORA_E_M       = I_EMPL.EMPL_IMP_HORA_E_M,
               EMPL_BCO_PAGO           = I_EMPL.EMPL_BCO_PAGO,
               EMPL_NRO_CTA            = I_EMPL.EMPL_NRO_CTA,
               EMPL_MON_PAGO           = I_EMPL.EMPL_MON_PAGO,
               EMPL_COD_OPERADOR       = I_EMPL.EMPL_COD_OPERADOR,
               EMPL_PAGA_IRP           = I_EMPL.EMPL_PAGA_IRP,
               EMPL_PORC_IRP           = I_EMPL.EMPL_PORC_IRP,
               EMPL_EMAIL_O365         = I_EMPL.EMPL_EMAIL_O365,
               EMPL_NRO_CORP           = I_EMPL.EMPL_NRO_CORP,
               EMPL_NRO_CASILLERO      = I_EMPL.EMPL_NRO_CASILLERO,
               EMPL_VTO_PERIODO_PRUEBA = I_EMPL.EMPL_VTO_PERIODO_PRUEBA,
               EMPL_TIPO_SEGURO        = I_EMPL.EMPL_TIPO_SEGURO,
               EMPL_ENTIDAD_SEGURO     = I_EMPL.EMPL_ENTIDAD_SEGURO,
               EMPL_INICIO_SEGURO      = I_EMPL.EMPL_INICIO_SEGURO,
               EMPL_VENC_SEGURO        = I_EMPL.EMPL_VENC_SEGURO,
               EMPL_COSTO_SEGURO       = I_EMPL.EMPL_COSTO_SEGURO,
               EMPL_NRO_CASILLERO_ALFA = I_EMPL.EMPL_NRO_CASILLERO_ALFA,
               EMPL_DOC_AREA_EEB       = I_EMPL.EMPL_DOC_AREA_EEB,
               EMPL_DOC_AREA_EM        = I_EMPL.EMPL_DOC_AREA_EM,
               EMPL_DOC_AREA_ADM       = I_EMPL.EMPL_DOC_AREA_ADM,
               EMPL_DOC_AREA_UNI       = I_EMPL.EMPL_DOC_AREA_UNI,
               EMPL_DOC_AREA_EI        = I_EMPL.EMPL_DOC_AREA_EI,
               EMPL_DOC_AREA_MIES      = I_EMPL.EMPL_DOC_AREA_MIES,
               EMPL_PH_ADM             = I_EMPL.EMPL_PH_ADM,
               EMPL_PH_MIES            = I_EMPL.EMPL_PH_MIES,
               EMPL_PH_EI              = I_EMPL.EMPL_PH_EI,
               EMPL_PH_EEB             = I_EMPL.EMPL_PH_EEB,
               EMPL_PH_EM              = I_EMPL.EMPL_PH_EM,
               EMPL_PH_OF              = I_EMPL.EMPL_PH_OF,
               EMPL_DOC_AREA_OF        = I_EMPL.EMPL_DOC_AREA_OF,
               EMPL_DEPARTAMENTO_SEC   = I_EMPL.EMPL_DEPARTAMENTO_SEC,
               EMPL_DEPARTAMENTO_TERC  = I_EMPL.EMPL_DEPARTAMENTO_TERC,
               EMPL_COD_RELOJ          = I_EMPL.EMPL_COD_RELOJ,
               EMPL_COD_CLIENTE        = I_EMPL.EMPL_COD_CLIENTE,
               EMPL_CONTRATADO_POR     = I_EMPL.EMPL_CONTRATADO_POR,
               EMPL_MARC_COMIS_SIST    = I_EMPL.EMPL_MARC_COMIS_SIST,
               EMPL_TIPO_COMIS         = I_EMPL.EMPL_TIPO_COMIS,
               EMPL_AREA_ORGANI        = I_EMPL.EMPL_AREA_ORGANI,
               EMPL_MOT_DESV           = I_EMPL.EMPL_MOT_DESV,
               EMPL_FAC_DESV           = I_EMPL.EMPL_FAC_DESV,
               EMPL_TIPO_DESV          = I_EMPL.EMPL_TIPO_DESV,
               EMPL_MAR_INDUCC         = I_EMPL.EMPL_MAR_INDUCC,
               EMPL_TIPO_CONT          = I_EMPL.EMPL_TIPO_CONT,
               EMPL_NOMBRE_AD          = I_EMPL.EMPL_NOMBRE_AD,
               EMPL_NRO_MTESS          = I_EMPL.EMPL_NRO_MTESS,
               EMPL_CONS_MARC          = I_EMPL.EMPL_CONS_MARC,
               EMPL_MARC_ENTRADA       = I_EMPL.EMPL_MARC_ENTRADA,
               EMPL_MARC_SALIDA        = I_EMPL.EMPL_MARC_SALIDA,
               EMPL_EVAL_DES_MARC      = I_EMPL.EMPL_EVAL_DES_MARC,
               EMPL_IND_HORA_EXTRA     = I_EMPL.EMPL_IND_HORA_EXTRA,
               EMPL_GRUP_COMIS         = I_EMPL.EMPL_GRUP_COMIS,
               EMPL_COB_EFECTIVO       = I_EMPL.EMPL_COB_EFECTIVO,
               EMPL_CODIGO_CHOFER      = I_EMPL.EMPL_CODIGO_CHOFER,
               EMPL_CODIGO_CLI         = I_EMPL.EMPL_CODIGO_CLI,
               EMPL_IND_IMP_CONTRATO   = I_EMPL.EMPL_IND_IMP_CONTRATO,
               EMPL_LOGIN              = I_EMPL.EMPL_LOGIN,
               EMPL_ZAFRA              = I_EMPL.EMPL_ZAFRA,
               EMPL_IMP_PLUS_SALARIAL  = I_EMPL.EMPL_IMP_PLUS_SALARIAL,
               EMPL_CONS_MARC_TAB      = I_EMPL.EMPL_CONS_MARC_TAB,
               EMPL_COD_POSTULANTE     = I_EMPL.EMPL_COD_POSTULANTE,

               EMPL_TIPO_TRABAJADOR = I_EMPL.EMPL_TIPO_TRABAJADOR,
               EMPL_MARC_SIST       = I_EMPL.EMPL_MARC_SIST,
               EMPL_MARC_SABADO     = I_EMPL.EMPL_MARC_SABADO,
               EMPL_MARC_ALMUERZO   = I_EMPL.EMPL_MARC_ALMUERZO,
               EMPL_V_CONTACTO      = I_EMPL.EMPL_V_CONTACTO,
               EMPL_V_NRO_CEL       = I_EMPL.EMPL_V_NRO_CEL,
               EMPL_LIMITE_CRED     = I_EMPL.EMPL_LIMITE_CRED,
               EMPL_CHEK_LIM_CD     = I_EMPL.EMPL_CHEK_LIM_CD,
               EMPL_PORCENTAJE      = I_EMPL.EMPL_PORCENTAJE,
               EMPL_IND_COM_TRANS   = I_EMPL.EMPL_IND_COM_TRANS,
               EMPL_IND_VIATICO     = I_EMPL.EMPL_IND_VIATICO,
               EMPL_MONTO_VIATICO   = I_EMPL.EMPL_MONTO_VIATICO,
               EMPL_TERMINO_CONT    = I_EMPL.EMPL_TERMINO_CONT

         WHERE EMPL_LEGAJO = I_EMPL.EMPL_LEGAJO
           AND EMPL_EMPRESA = I_EMPL.EMPL_EMPRESA;



      ELSIF I_EMPL.EMPL_SITUACION <> 'A' AND I_EMPL.EMPL_EMPRESA = 1 THEN
        --  RAISE_APPLICATION_ERROR(-20001, I_EMPL.EMPL_SITUACION);
        SELECT COUNT(EMPL_NOMBRE_AD)
          INTO V_CONT_NOM_ID
          FROM PER_EMPLEADO
         WHERE EMPL_EMPRESA = I_EMPL.EMPL_EMPRESA
           AND EMPL_LEGAJO = I_EMPL.EMPL_LEGAJO;
         
        IF V_CONT_NOM_ID = 0 THEN
          RAISE_APPLICATION_ERROR(-20001,
                                  'No se puede modificar datos de la ficha mientras este inactiva');
        ELSIF V_CONT_NOM_ID > 0 AND I_EMPL.EMPL_NOMBRE_AD IS NOT NULL THEN
          RAISE_APPLICATION_ERROR(-20001,
                                  'No se puede modificar datos de la ficha mientras este inactiva');
        ELSE
          UPDATE PER_EMPLEADO
             SET EMPL_NOMBRE_AD = NULL
           WHERE EMPL_EMPRESA = I_EMPL.EMPL_EMPRESA
             AND EMPL_LEGAJO = I_EMPL.EMPL_LEGAJO;
        END IF;
        
      ELSE
        --- RAISE_APPLICATION_ERROR(-20001, I_EMPL.EMPL_SITUACION);
        RAISE_APPLICATION_ERROR(-20001,
                                'No se puede modificar datos de la ficha mientras este inactiva');
      END IF;

      --------------------------- *** SI ES TRANSAGRO Y CAMBIA DE SUCURSAL O DEPARTAMENTO
      -------------------------------DEBE CAMBIAR TAMBIEN ESOS DATOS EN LA LINEA DE NEGOCIO
      ------LV
   IF I_EMPL.EMPL_EMPRESA = 2 THEN
        BEGIN
          BEGIN
            SELECT NVL(SUM(C007), 0) PORCENTAJE, TO_NUMBER(C006) PERIODO
              INTO TOTAL_PORCENTAJE, PERIODO_LINEA
              FROM APEX_COLLECTIONS
             WHERE COLLECTION_NAME = 'LINEA_NEGOCIO'
               AND C007 IS NOT NULL
             GROUP BY C006;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              TOTAL_PORCENTAJE := 0;
          END;
          IF TOTAL_PORCENTAJE <> 100 THEN
            RAISE_APPLICATION_ERROR(-20001,
                                    'La sumatoria del porcentaje de la linea de negocio debe ser igual a 100');
          ELSIF TOTAL_PORCENTAJE = 100 THEN

            DELETE PER_EMPL_LINEA_PERI
             WHERE EMCP_PERIODO = PERIODO_LINEA
               AND EMCP_LEGAJO = I_EMPL.EMPL_LEGAJO
               AND EMCP_EMPR = I_EMPL.EMPL_EMPRESA;

            INSERT INTO PER_EMPL_LINEA_PERI
              (EMCP_PERIODO,
               EMCP_LEGAJO,
               EMCP_EMPR,
               EMCP_SUC,
               EMCP_DPTO,
               EMCP_LINEA,
               EMCP_PORC)
              SELECT TO_NUMBER(C006) PERIODO,
                     I_EMPL.EMPL_LEGAJO LEGAJO,
                     I_EMPL.EMPL_EMPRESA,
                     I_EMPL.EMPL_SUCURSAL SUCURSAL,
                     I_EMPL.EMPL_DEPARTAMENTO DEPARTAMENTO,
                     TO_NUMBER(C003) LIN_CODIGO,
                     TO_NUMBER(C007) PORCENTAJE
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'LINEA_NEGOCIO'
                 AND C007 IS NOT NULL;

            ---------------------SIEMPRE SE ESTARIA ACTUALIZANDO
            --ESTA TABLA CON EL ULTIMO PERIODO EN EL QUE EL EMPLEADO
            --SI SE LE INACTIVA GUARDARA EL ULTIMO PERIODO

            DELETE PER_EMPL_LINEA_PERI_ACT
             WHERE EMCP_LEGAJO = I_EMPL.EMPL_LEGAJO
               AND EMCP_EMPR = I_EMPL.EMPL_EMPRESA;

            INSERT INTO PER_EMPL_LINEA_PERI_ACT
              (EMCP_PERIODO,
               EMCP_LEGAJO,
               EMCP_EMPR,
               EMCP_SUC,
               EMCP_DPTO,
               EMCP_LINEA,
               EMCP_PORC)
              SELECT TO_NUMBER(C006) PERIODO,
                     I_EMPL.EMPL_LEGAJO LEGAJO,
                     I_EMPL.EMPL_EMPRESA,
                     I_EMPL.EMPL_SUCURSAL SUCURSAL,
                     I_EMPL.EMPL_DEPARTAMENTO DEPARTAMENTO,
                     TO_NUMBER(C003) LIN_CODIGO,
                     TO_NUMBER(C007) PORCENTAJE
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'LINEA_NEGOCIO'
                 AND C007 IS NOT NULL;

          END IF;
        END;

      END IF;
      ----------------------------
      --   RAISE_APPLICATION_ERROR(-20010,I_EMPL.EMPL_LEGAJO||' - '||I_EMPL.EMPL_EMPRESA||' - '||I_EMPL.EMPL_LOGIN);
    ELSIF I_OPER = 'DELETE' THEN
      --=====================================ERDM=================================================
      IF I_EMPL.EMPL_EMPRESA = 2 THEN

        SELECT COUNT(DOC_CLAVE)
          INTO V_CONTADOR
          FROM FIN_DOCUMENTO F
         WHERE F.DOC_EMPR = I_EMPL.EMPL_EMPRESA
           AND NVL(F.DOC_PROV, F.DOC_CLI) = I_EMPL.EMPL_CODIGO_PROV;

        IF V_CONTADOR > 0 THEN
          --  APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Existen documentos relacionados con el empleado no lo puede borrar' || '.',
          --                P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);

          RAISE_APPLICATION_ERROR(-20020,
                                  'Existen documentos relacionados con el empleado no lo puede borrar. ');
        ELSE

          DELETE FIN_CLI_EMPRESA
           WHERE CLEM_EMPR = I_EMPL.EMPL_EMPRESA
             AND CLEM_CLI = I_EMPL.EMPL_CODIGO_PROV
             AND CLEM_MON = 1;

          ---
          DELETE FIN_PROV_EMPRESA
           WHERE PREM_EMPR = I_EMPL.EMPL_EMPRESA
             AND PREM_PROV = I_EMPL.EMPL_CODIGO_PROV
             AND PREM_MON = 1;
          ---
          DELETE FIN_PERSONA
           WHERE PNA_CODIGO = I_EMPL.EMPL_CODIGO_PROV
             AND PNA_EMPR = I_EMPL.EMPL_EMPRESA;
          ---
          DELETE FIN_PROVEEDOR
           WHERE PROV_CODIGO = I_EMPL.EMPL_CODIGO_PROV
             AND PROV_EMPR = I_EMPL.EMPL_EMPRESA;
          ---
          DELETE PER_EMPL_SOL_CAMBIO_ESTADO
           WHERE EMPSOL_EMPR = I_EMPL.EMPL_EMPRESA
             AND EMPSOL_EMPL_LEG = I_EMPL.EMPL_LEGAJO;
          ---
          DELETE PER_EMPLEADO
           WHERE EMPL_LEGAJO = I_EMPL.EMPL_LEGAJO
             AND EMPL_EMPRESA = I_EMPL.EMPL_EMPRESA;

          ---
          DELETE FIN_CLIENTE
           WHERE CLI_CODIGO = I_EMPL.EMPL_CODIGO_PROV
             AND CLI_EMPR = I_EMPL.EMPL_EMPRESA;

        END IF;
        --=================================================================================================
      ELSE
/*
        DELETE PER_EMPLEADO
         WHERE EMPL_LEGAJO = I_EMPL.EMPL_LEGAJO
           AND EMPL_EMPRESA = I_EMPL.EMPL_EMPRESA;*/
           
    -- raise_application_error (-20001, I_EMPL.EMPL_COD_RELOJ);              
       DELETE FROM PER_CODIGOS_RELOJ A
         WHERE A.CODR_LEGAJO = I_EMPL.EMPL_LEGAJO
           AND A.CODR_EMPR = I_EMPL.EMPL_EMPRESA;

        DELETE FROM PER_EMPLEADO_DEPTO A
         WHERE A.PEREMPDEP_EMPL = I_EMPL.EMPL_LEGAJO
           AND A.PEREMPDEP_EMPR = I_EMPL.EMPL_EMPRESA;

         DELETE FROM PER_EMPL_PAGO_HIS X
         WHERE X.EMPL_LEGAJO = I_EMPL.EMPL_LEGAJO
           AND X.EMPL_EMPR = I_EMPL.EMPL_EMPRESA;
           
          DELETE FROM PER_EMPLEADO
         WHERE EMPL_EMPRESA = I_EMPL.EMPL_EMPRESA
           AND EMPL_LEGAJO = I_EMPL.EMPL_LEGAJO;

        DELETE FROM FIN_PROV_EMPRESA S
         WHERE S.PREM_EMPR = I_EMPL.EMPL_EMPRESA
           AND S.PREM_PROV = I_EMPL.EMPL_CODIGO_PROV;

        DELETE FROM FIN_PROVEEDOR A
         WHERE A.PROV_CODIGO = I_EMPL.EMPL_CODIGO_PROV
           AND A.PROV_EMPR = I_EMPL.EMPL_EMPRESA;

        DELETE FROM FIN_CLIENTE
         WHERE CLI_EMPR =I_EMPL.EMPL_EMPRESA
           AND CLI_CODIGO =I_EMPL.EMPL_COD_CLIENTE;

      END IF;

    ELSE
      RAISE_APPLICATION_ERROR(-20010,
                              'Error pack perm001 operacion enviada al procedimiento es incorrecto');
    END IF;

    IF NOT (I_OPER = 'DELETE') AND
       DBMS_LOB.GETLENGTH(I_EMPL.EMPL_IMG_BLOB) IS NOT NULL THEN
      UPDATE PER_EMPLEADO
         SET EMPL_IMG_BLOB = I_EMPL.EMPL_IMG_BLOB
       WHERE EMPL_LEGAJO = I_EMPL.EMPL_LEGAJO
         AND EMPL_EMPRESA = I_EMPL.EMPL_EMPRESA;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLERRM);
  END PP_GUARDAR_EMPLEADO;

  PROCEDURE PP_TRAER_DATOS_POSTULANTE(V_EMPRESA       IN NUMBER,
                                      V_CLAVE_POST    IN NUMBER,
                                      V_NOMBRE_POST   OUT VARCHAR2,
                                      V_APELLIDO_POST OUT VARCHAR2,
                                      V_CEDULA_POST   OUT VARCHAR2,
                                      V_SEXO          OUT VARCHAR2,
                                      V_NACIO_POST    OUT NUMBER,
                                      V_EST_CIVIL     OUT VARCHAR2,
                                      V_OFICIO_POST   OUT NUMBER,
                                      V_DOMIC_POST    OUT VARCHAR2,
                                      V_CELULAR       OUT VARCHAR2,
                                      V_NIVEL_EDUC    OUT VARCHAR2,
                                      V_FEC_NAC       OUT DATE, ----DATOS POSUTLANTE
                                      V_TIPO_CONTRATO OUT VARCHAR2,
                                      V_AREA          OUT NUMBER,
                                      V_CARGO         OUT NUMBER,
                                      V_CONT_POR      OUT VARCHAR2,
                                      V_MARCACION     OUT VARCHAR2,
                                      V_MAR_SABADO    OUT VARCHAR2,
                                      V_MAR_ALMUERZO  OUT VARCHAR2,
                                      V_MAR_SISTEMA   OUT VARCHAR2,
                                      V_FORMA_PAGO    OUT NUMBER,
                                      V_SUCURSAL      OUT NUMBER) IS

    X_SOL_CLAVE  NUMBER;
    X_NIVEL_EDUC NUMBER;

  BEGIN

    SELECT MAX(P.SELPER_SOLICI)
      INTO X_SOL_CLAVE
      FROM PER_SELECCION_PERSONAL P
     WHERE P.SELEPER_ESTADO_GRAL = 'C'
       AND P.SELEPER_EMPR = V_EMPRESA
       AND P.SELPER_POSTUL = V_CLAVE_POST;

    SELECT PO.DOCPOS_NOMBRE,
           PO.DOCPOS_APELLIDO,
           PO.DOCPOS_CEDULA_IDEN,
           PO.DOCPOS_SEXO,
           PO.DOCPOS_NACI,
           PO.DOCPOS_ESTADO_CIV,
           PO.DOCPOS_PROF,
           PO.DOCPOS_DOMICILIO,
           PO.DOCPOS_TEL_CELULAR,
           PO.DOCPOS_NIVEL_EDUC,
           PO.DOCPOS_FECHA_NAC
      INTO V_NOMBRE_POST,
           V_APELLIDO_POST,
           V_CEDULA_POST,
           V_SEXO,
           V_NACIO_POST,
           V_EST_CIVIL,
           V_OFICIO_POST,
           V_DOMIC_POST,
           V_CELULAR,
           X_NIVEL_EDUC,
           V_FEC_NAC
      FROM PER_POSTULANTE_CARGO PO
     WHERE PO.DOCPOS_CLAVE = V_CLAVE_POST
       AND PO.DOCPOS_EMPR = V_EMPRESA;

    SELECT DECODE(S.SOLPER_TIPO_CONT, 'IN', 'I', 'T'),
           S.SOLPER_AREA,
           S.SOLPER_CARGO,
           CASE
             WHEN SOLPER_TIPO_SELEC = 'PR' AND
                  SOLPER_TIPO_CONTRATACION = 'PR' THEN
              'RRHH'
             ELSE
              'Otros'
           END CONTRATADO_POR,
           S.SOLPER_CONS_MARC,
           S.SOLPER_CONS_MSABADO,
           S.SOLPER_CONS_MALMUEZO,
           S.SOLPER_CONS_MSISTEMA,
           S.SOLPER_FORMA_PAGO,
           S.SOLPER_SUCURSAL
      INTO V_TIPO_CONTRATO,
           V_AREA,
           V_CARGO,
           V_CONT_POR,
           V_MARCACION,
           V_MAR_SABADO,
           V_MAR_ALMUERZO,
           V_MAR_SISTEMA,
           V_FORMA_PAGO,
           V_SUCURSAL
      FROM PER_SOLICITUD_PERSONAL S
     WHERE S.SOLPER_EMPR = V_EMPRESA
       AND S.SOLPER_CLAVE = X_SOL_CLAVE
       AND S.SOLPER_ESTADO_APROB = 'C';

    IF X_NIVEL_EDUC IS NOT NULL THEN
      SELECT D.NIVEDUC_DESC
        INTO V_NIVEL_EDUC
        FROM PER_NIVEL_EDUCATIVO D
       WHERE D.NIVEDUC_EMPR = V_EMPRESA
         AND D.NIVEDUC_CLAVE = X_NIVEL_EDUC;
    END IF;
  END PP_TRAER_DATOS_POSTULANTE;

  --==================================== ERDM ===============================================--
  PROCEDURE PP_INSERTAR_CLIENTE_PROVEEDOR(I_EMPL     IN PER_EMPLEADO%ROWTYPE,
                                          I_OPER     IN VARCHAR2,
                                          I_SUCURSAL IN NUMBER) IS

    /* V_EMPL := I_EMPL.EMPL_LEGAJO|| ' NOMBRE =' ||
         I_EMPL.EMPL_NOMBRE|| ' PROVEEDOR =' ||
         I_EMPL.EMPL_CODIGO_PROV|| ' OPERADOR =' ||
         I_EMPL.EMPL_CODIGO_CLI|| ' -/- ' ;
    INSERT INTO X(CAMPO1,OTRO) VALUES ( V_EMPL, 'PROBLANDO JEJEJE' );
    COMMIT;*/

    V_DESDE   NUMBER := 1;
    V_RUC     VARCHAR2(20);
    V_RUC_DV  VARCHAR2(20);
    V_DV      VARCHAR2(2);
    V_COD     NUMBER := 0;
    V_DESDE_1 NUMBER := 0;
    V_TIPO_DOC   NUMBER;
  BEGIN
    --===========================
    IF I_SUCURSAL <> 1 THEN
      V_DESDE := I_SUCURSAL * 10000;
    END IF;

    V_COD := I_EMPL.EMPL_CODIGO_PROV;

    V_RUC := GEN_EXTRAE_SOLO_NROS(I_EMPL.EMPL_DOC_IDENT);

    IF I_EMPL.EMPL_DOC_IDENT = V_RUC THEN
      V_RUC_DV := I_EMPL.EMPL_DOC_IDENT;
      V_DV     := NULL;-- 0;
    ELSE
      V_RUC_DV := SUBSTR(V_RUC, 1, LENGTH(V_RUC) - 1);
      V_DV     :=  NULL;---SUBSTR(V_RUC, LENGTH(V_RUC));
    END IF;



    IF  I_EMPL.EMPL_NACIONALIDAD = 1 THEN
       V_TIPO_DOC := 1; 
    ELSE
       V_TIPO_DOC := 4;
    
    END IF;
    --=============INSERTANDO

    INSERT INTO FIN_PERSONA
      (PNA_CODIGO,
       PNA_NOMBRE,
       PNA_DIRECCION,
       PNA_TELEFONO,
       PNA_FAX,
       PNA_RUC_DV,
       PNA_DV,
       PNA_PAIS,
       PNA_FEC_NAC,
       PNA_VENDEDOR,
       PNA_SEGMENTO,
       PNA_SUC,
       PNA_LUGAR_ORIGEN_REPLICA,
       PNA_TIPO,
       PNA_EMPR,
       PNA_DOC_TIPO)
    VALUES
      (V_COD,
       NVL(I_EMPL.EMPL_NOMBRE || ' ' || I_EMPL.EMPL_APE, '.'),
       NVL(I_EMPL.EMPL_DIR, '.'),
       NVL(I_EMPL.EMPL_TEL, '.'),
       NULL,
       V_RUC_DV,
       null,
       1,
       I_EMPL.EMPL_FEC_NAC,
       46,
       1,
       I_EMPL.EMPL_SUCURSAL,
       GEN_LUGAR_ORIGEN,
       1,
       I_EMPL.EMPL_EMPRESA,
       V_TIPO_DOC);

    --===========================

    INSERT INTO FIN_CLIENTE
      (CLI_CODIGO,
       CLI_NOM,
       CLI_DIR,
       CLI_TEL,
       CLI_RUC,
       CLI_CATEG,
       CLI_EST_CLI,
       CLI_MON,
       CLI_IMP_LIM_CR,
       CLI_BLOQ_LIM_CR,
       CLI_MAX_DIAS_ATRASO,
       CLI_LUGAR_ORIGEN_REPLICA,
       CLI_RUC_DV,
       cli_dv,
       CLI_PAIS,
       CLI_ZONA,
       CLI_COD_EMPL_EMPR_ORIG,
       CLI_EMPR,
       CLI_DOC_TIPO )
    VALUES
      (V_COD,
       NVL(I_EMPL.EMPL_NOMBRE || ' ' || I_EMPL.EMPL_APE, '.'),
       NVL(I_EMPL.EMPL_DIR, '.'),
       NVL(I_EMPL.EMPL_TEL, '.'),
       NVL(V_RUC, '.'),
       3,
       'A',
       1,
       0,
       'N',
       0,
       GEN_LUGAR_ORIGEN,
       V_RUC_DV,
       null,
       1,
       20,
       I_EMPL.EMPL_LEGAJO,
       I_EMPL.EMPL_EMPRESA,
       V_TIPO_DOC );

    INSERT INTO FIN_CLI_EMPRESA
      (CLEM_EMPR,
       CLEM_CLI,
       CLEM_MON,
       CLEM_IMP_LIM_CR,
       CLEM_BLOQ_LIM_CR,
       CLEM_LUGAR_ORIGEN_REPLICA)
    VALUES
      (I_EMPL.EMPL_EMPRESA, V_COD, 1, 0, 'N', GEN_LUGAR_ORIGEN);

    --===========================
    INSERT INTO FIN_PROVEEDOR
      (PROV_CODIGO,
       PROV_PAIS,
       PROV_RAZON_SOCIAL,
       PROV_DIR,
       PROV_TEL,
       PROV_FAX,
       PROV_RUC,
       PROV_EST_PROV,
       PROV_TIPO,
       PROV_EMAIL,
       PROV_LUGAR_ORIGEN_REPLICA,
       PROV_DV,
       PROV_RUC_DV,
       PROV_IND_RETENCION,
       PROV_RETENCION,
       PROV_EMPR,
       PROV_DOC_TIPO )
    VALUES
      (V_COD,
       1,
       NVL(I_EMPL.EMPL_NOMBRE || ' ' || I_EMPL.EMPL_APE, '.'),
       NVL(I_EMPL.EMPL_DIR, '.'),
       NVL(I_EMPL.EMPL_TEL, '.'),
       NULL,
       NVL(V_RUC, '.'),
       'A',
       10,
       NULL,
       GEN_LUGAR_ORIGEN,
       null,
       V_RUC_DV,
       'S',
       'S',
       I_EMPL.EMPL_EMPRESA,
       V_TIPO_DOC);

    INSERT INTO FIN_PROV_EMPRESA
      (PREM_EMPR, PREM_PROV, PREM_MON, PREM_LUGAR_ORIGEN_REPLICA)
    VALUES
      (I_EMPL.EMPL_EMPRESA, V_COD, 1, GEN_LUGAR_ORIGEN);

  END PP_INSERTAR_CLIENTE_PROVEEDOR;
  --======================================= ==================================================--
  PROCEDURE PP_GENERAR_VCARD(I_EMPRESA IN NUMBER) IS

    V_EMPRESA VARCHAR2(50);

    ---*** CONFIGURACIONES PARA MANIPULACION DE BLOB;
    L_BLOB        BLOB;
    L_TEXT        CLOB;
    L_DEST_OFFSET PLS_INTEGER := 1;
    L_SRC_OFFSET  PLS_INTEGER := 1;
    L_LANG_CTX    PLS_INTEGER := DBMS_LOB.DEFAULT_LANG_CTX;
    L_BLOB_WARN   PLS_INTEGER := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;

  BEGIN
    SELECT INITCAP(P.EMPR_RAZON_SOCIAL)
      INTO V_EMPRESA
      FROM GEN_EMPRESA P
     WHERE P.EMPR_CODIGO = I_EMPRESA;

    FOR I IN (SELECT P.EMPL_LEGAJO,
                     INITCAP(P.EMPL_NOMBRE) NOMBRE,
                     INITCAP(P.EMPL_V_CONTACTO) EMPL_V_CONTACTO,
                     P.EMPL_V_NRO_CEL,
                     INITCAP(C.CAR_DESC) CAR_DESC
                FROM PER_EMPLEADO P, PER_CARGO C
               WHERE P.EMPL_EMPRESA = I_EMPRESA
                 AND P.EMPL_CARGO = C.CAR_CODIGO
                 AND P.EMPL_EMPRESA = C.CAR_EMPR
                 AND P.EMPL_V_NRO_CEL IS NOT NULL
                 AND P.EMPL_V_CONTACTO IS NOT NULL) LOOP

      L_TEXT := L_TEXT || 'BEGIN:VCARD
' ||'VERSION:3.0
' ||'N:;'||i.EMPL_V_CONTACTO||';;;
' || 'ORG:' || V_EMPRESA || '
' || 'TITLE:' || I.CAR_DESC || '
' || 'FN:' || I.EMPL_V_CONTACTO || '
' || 'TEL;WORK;VOICE:' || I.EMPL_V_NRO_CEL || '
END:VCARD
';

    /*L_TEXT := L_TEXT || I.EMPL_LEGAJO -- 18 NRO.IDENTIFICADOR(ENTRADA/SALIDA) PARA SEGUIMIENTO EMPRESA.
                    || ';' || I.EMPL_NOMBRE -- 14 SI SE PAGA MAS DE UNA FACTURA, SE INGRESA LA PRIMERA AQUI Y LAS DEMAS EN REF_FACTURAS
                    || ';' || I.EMPL_V_CONTACTO -- 7 'I' (INTERBANCARIA SIPAP)/ 'C' (PAGO BBVA)
                    || ';' || I.EMPL_V_NRO_CEL; -- 6 NRO.CTA.CREDITO(PAGO BBVA)/EN BLANCO(PAGO SIPAP)*/
    END LOOP;

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'PERM001_DESCARGAR_VCARD') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'PERM001_DESCARGAR_VCARD');
    END IF;
    APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'PERM001_DESCARGAR_VCARD');

    IF L_TEXT IS NOT NULL THEN

      DBMS_LOB.CREATETEMPORARY(L_BLOB, TRUE);

      DBMS_LOB.CONVERTTOBLOB(DEST_LOB     => L_BLOB,
                             SRC_CLOB     => L_TEXT,
                             AMOUNT       => DBMS_LOB.LOBMAXSIZE,
                             DEST_OFFSET  => L_DEST_OFFSET,
                             SRC_OFFSET   => L_SRC_OFFSET,
                             BLOB_CSID    => NLS_CHARSET_ID('UTF8'), --DBMS_LOB.DEFAULT_CSID,
                             LANG_CONTEXT => L_LANG_CTX,
                             WARNING      => L_BLOB_WARN);
      OWA_UTIL.MIME_HEADER('application/octet-stream', FALSE, 'UTF-8');

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'PERM001_DESCARGAR_VCARD',
                                 P_C001            => V_EMPRESA||'_'||
                                                      to_char(SYSDATE,'DDMMYYYY'),
                                 P_C002            => V('APP_USER'),
                                 P_C003            => '.VCF',
                                 P_C004            => NULL,
                                 P_BLOB001         => L_BLOB);
    ELSE
      RAISE_APPLICATION_ERROR(-20010,
                              'No se ha encontrado registros para exportar');
    END IF;
  END PP_GENERAR_VCARD;
  
  
  PROCEDURE PP_EDITAR_CTA_BANCO (P_EMPRESA         IN NUMBER,
                                 P_SUCURSAL        IN NUMBER,
                                 P_DEPARTAMENTO    IN NUMBER)IS
  V_QUERY VARCHAR2(20000);
  V_AND VARCHAR2(20000);
  
  
  BEGIN
    IF P_SUCURSAL IS NOT NULL THEN
      V_AND := V_AND|| ' AND EMPL_SUCURSAL ='||P_SUCURSAL;
      
    
    END IF;
    IF P_DEPARTAMENTO IS NOT NULL THEN
      V_AND := V_AND|| ' AND EMPL_DEPARTAMENTO ='||P_DEPARTAMENTO;
    
    END IF;    
    
    
  --V_AND 
      V_QUERY:= 'SELECT A.EMPL_LEGAJO, 
                       A.EMPL_NOMBRE, 
                       A.EMPL_APE, 
                       A.EMPL_SUCURSAL, 
                       A.EMPL_DEPARTAMENTO, 
                       A.EMPL_BCO_PAGO, 
                       A.EMPL_NRO_CTA
                FROM PER_EMPLEADO A
                WHERE EMPL_EMPRESA = '||P_EMPRESA||'
                 '||V_AND||'
                AND EMPL_SITUACION  = ''A''';
                
        
        
             

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'EMPL_CUENTA_BCO') THEN
        APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EMPL_CUENTA_BCO');
    END IF;
    APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'EMPL_CUENTA_BCO',
                                                   P_QUERY           => V_QUERY);

  
  END PP_EDITAR_CTA_BANCO;
  
  
  PROCEDURE PP_EDITAR_BCO (P_SEQ       IN NUMBER,
                           P_UBICACION IN NUMBER,
                           P_VALOR     IN NUMBER) IS
    
   BEGIN
     
 ---  raise_application_error (-20001,P_SEQ||'-'||P_UBICACION||'-'||P_VALOR);
     
   
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE (
                            P_COLLECTION_NAME => 'EMPL_CUENTA_BCO',
                            P_SEQ             => P_SEQ,
                            P_ATTR_NUMBER     => P_UBICACION,
                            P_ATTR_VALUE      => P_VALOR);  
                            
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE (
                            P_COLLECTION_NAME => 'EMPL_CUENTA_BCO',
                            P_SEQ             => P_SEQ,
                            P_ATTR_NUMBER     => 8,
                            P_ATTR_VALUE      => 'S');
                            
                            
                 
             
   END PP_EDITAR_BCO;
   
  PROCEDURE PP_EDITAR_REGISTRO IS
    
  BEGIN
    
   FOR X IN (SELECT C001 EMPL_LEGAJO, 
                    C002 EMPL_NOMBRE, 
                    C003 EMPL_APE, 
                    C004 EMPL_SUCURSAL, 
                    C005 EMPL_DEPARTAMENTO, 
                    C006 EMPL_BCO_PAGO, 
                    C007 EMPL_NRO_CTA
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'EMPL_CUENTA_BCO'
                 AND C008 = 'S') LOOP
                 
                 
      UPDATE PER_EMPLEADO
         SET EMPL_BCO_PAGO = X.EMPL_BCO_PAGO,
             EMPL_NRO_CTA  = X.EMPL_NRO_CTA
        WHERE EMPL_LEGAJO  = X.EMPL_LEGAJO
          AND EMPL_EMPRESA = V('P_EMPRESA');   
    
  END LOOP;
      
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EMPL_CUENTA_BCO');
  
  
  END PP_EDITAR_REGISTRO;
  
END PERM001;
/
