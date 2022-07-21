CREATE OR REPLACE PACKAGE PERI088 AS

  PROCEDURE PP_TRAER_DATOS_CONTRATO(V_EMPRESA          IN NUMBER,
                                    V_NRO_SOL          IN NUMBER,
                                    V_CLAVE_POST       IN NUMBER,
                                    V_NOMBRE_POST      OUT VARCHAR2,
                                    V_CEDULA_POST      OUT NUMBER,
                                    V_EDAD_POST        OUT NUMBER,
                                    V_NACIO_POST       OUT VARCHAR2,
                                    V_OFICIO_POST      OUT VARCHAR2,
                                    V_DOMIC_POST       OUT VARCHAR2,
                                    V_AREA_SOL         OUT VARCHAR2,
                                    V_CARGO_SOL        OUT VARCHAR2,
                                    V_TIPO_CONT        OUT VARCHAR2,
                                    V_SALARIO_ACORD    OUT VARCHAR2,
                                    V_DES_DOTACION     OUT VARCHAR2,
                                    V_DES_SELECCION    OUT VARCHAR2,
                                    V_DES_CONTRATACION OUT VARCHAR2,
                                    V_DES_MARCACION    OUT VARCHAR2,
                                    V_DES_MAR_SABADO   OUT VARCHAR2,
                                    V_DES_ALMUERZO     OUT VARCHAR2,
                                    V_DES_MAR_SISTEMA  OUT VARCHAR2,
                                    V_TIPO_CONTRATO    OUT VARCHAR2,
                                    V_AREA             OUT NUMBER,
                                    V_CARGO            OUT NUMBER,
                                    V_CONT_POR         OUT VARCHAR2,
                                    V_MARCACION        OUT VARCHAR2,
                                    V_MAR_SABADO       OUT VARCHAR2,
                                    V_MAR_ALMUERZO     OUT VARCHAR2,
                                    V_MAR_SISTEMA      OUT VARCHAR2,
                                    V_FORMA_PAGO       OUT NUMBER,
                                    V_SUCURSAL         OUT NUMBER,
                                    v_valor            OUT NUMBER);

  PROCEDURE PP_LLAMAR_REPORT_CONTRATO(V_EMPRESA       IN NUMBER,
                                      V_CLAVE_SOL     IN NUMBER,
                                      V_CLAVE_POST    IN NUMBER,
                                      V_REMUN_CONV    IN VARCHAR2,
                                      V_FECHA_INGRESO IN DATE,
                                      V_CANT_DIAS     IN NUMBER,
                                      V_TIPO_PAGO     IN NUMBER,
                                      V_USER          IN VARCHAR2,
                                      V_TIPO_SALIDA   IN VARCHAR2,
                                      V_TIPO_DOC      IN VARCHAR2,
                                      V_CLA_CONT2     IN NUMBER,
                                      V_LEGAJO        IN NUMBER);

  PROCEDURE PP_CREAR_RECONTRATACION(P_EMPRESA      IN NUMBER,
                                    P_LEGAJO       IN NUMBER,
                                    P_NOMBRE       OUT VARCHAR2,
                                    P_EDAD         OUT NUMBER,
                                    P_NAC          OUT VARCHAR2,
                                    P_DIRECCION    OUT VARCHAR2,
                                    P_CI           OUT NUMBER,
                                    P_OFICIO       OUT VARCHAR2,
                                    p_OFI_COD      OUT NUMBER,
                                    P_EST_CIVIL    OUT VARCHAR2,
                                    P_ACT_CONTRATO IN VARCHAR2,
                                    P_AREA         OUT NUMBER,
                                    P_CARGO        OUT NUMBER,
                                    P_INICIO       OUT DATE);

  PROCEDURE PP_INSERTAR_RECONTRATACION(P_EMPRESA    IN NUMBER,
                                       P_LEGAJO     IN NUMBER,
                                       P_DIRECCION  IN VARCHAR2,
                                       P_CI         IN NUMBER,
                                       P_OFI_COD    IN NUMBER,
                                       P_AREA       IN NUMBER,
                                       P_CARGO      IN NUMBER,
                                       P_TIPO_CONT  IN VARCHAR2,
                                       P_FEC_INICIO IN DATE,
                                       P_REM_CONV   IN VARCHAR2,
                                       P_FEC_FIN    IN DATE,
                                       P_FORMA_PAGO IN NUMBER,
                                       P_CON_IPS    IN VARCHAR2,
                                       P_PCON_MTESS IN VARCHAR2,
                                       P_PCON_SUC   IN NUMBER,
                                       P_EST_CIVIL  IN VARCHAR2,
                                       P_CODIGO     IN NUMBER,
                                       P_SOL_NRO    IN NUMBER,
                                       P_HS_ENTRADA IN VARCHAR2,
                                       P_HS_SALIDA  IN VARCHAR2,
                                       P_HS_ENT_SAB IN VARCHAR2,
                                       P_HS_SAL_SAB IN VARCHAR2,
                                       P_ACT_CONT   IN VARCHAR2,
                                       P_KM_MANT    IN NUMBER,
                                       P_PLAZO      IN VARCHAR2,
                                       P_HORARIO    IN VARCHAR2,
                                       P_FECHA_DOC  IN DATE);

  PROCEDURE PP_ELIMINAR_REG_RECONTRATO(P_EMPRESA IN NUMBER,
                                       P_CODIGO  IN NUMBER);

  PROCEDURE PP_LLAMAR_CONTRATO_MJT(P_EMPRESA    IN NUMBER,
                                   P_CLAVE_CONT IN NUMBER);

  PROCEDURE PP_BUSCAR_DATOS_MTESS(P_EMPRESA        IN NUMBER,
                                  P_FICHA          IN VARCHAR2,
                                  P_EMPL_LEGAJO    IN NUMBER,
                                  P_POST_CODIGO    IN NUMBER,
                                  P_EMPL_NOMBRE    OUT VARCHAR2,
                                  P_EMPL_EDAD      OUT VARCHAR2,
                                  P_EMPL_SEXO      OUT VARCHAR2,
                                  P_EMPL_EST_CIVIL OUT VARCHAR2,
                                  P_EMPL_OFICIO    OUT VARCHAR2,
                                  P_EMPL_CARGO     OUT NUMBER,
                                  P_EMPL_AREA      OUT NUMBER,
                                  P_EMPL_NAC       OUT VARCHAR2,
                                  P_FEC_INGRESO    OUT DATE,
                                  P_EMPL_DOMICILIO OUT VARCHAR2,
                                  P_TIPO_REM       OUT VARCHAR2,
                                  P_REMUNERACION   OUT VARCHAR2);

  PROCEDURE PP_BUSCAR_PROFESION(P_EMPRESA   IN NUMBER,
                                P_PROF_COD  IN NUMBER,
                                P_PROF_DESC OUT VARCHAR2);

  PROCEDURE PP_BUSCAR_AREA(P_EMPRESA   IN NUMBER,
                           P_AREA_COD  IN NUMBER,
                           P_AREA_DESC OUT VARCHAR2);

  PROCEDURE PP_BUSCAR_CARGO(P_EMPRESA    IN NUMBER,
                            P_CARGO_COD  IN NUMBER,
                            P_CARGO_DESC OUT VARCHAR2,
                            P_AREA_DESC  IN VARCHAR2,
                            P_PRI_1      OUT VARCHAR2,
                            P_PRI_2      OUT VARCHAR2);

  PROCEDURE PP_BUSCAR_NACIONALIDAD(P_EMPRESA  IN NUMBER,
                                   P_NAC_COD  IN NUMBER,
                                   P_NAC_DESC OUT VARCHAR2);

  PROCEDURE PP_ACTUALIZAR_MTESS(P_EMPRESA   IN NUMBER,
                                P_OPERACION IN VARCHAR2,
                                P_CONT      IN PER_CONTRATO_MTESS%ROWTYPE);
END PERI088;
/
CREATE OR REPLACE PACKAGE BODY PERI088 as
  -- 21/07/2022 9:56:06 @PabloACespedes \(^-^)/
  -- constantes de las empresas
  co_hilagro   constant number := 1;
  co_transagro constant number := 2;
  
  PROCEDURE PP_TRAER_DATOS_CONTRATO(V_EMPRESA          IN NUMBER,
                                    V_NRO_SOL          IN NUMBER,
                                    V_CLAVE_POST       IN NUMBER,
                                    V_NOMBRE_POST      OUT VARCHAR2,
                                    V_CEDULA_POST      OUT NUMBER,
                                    V_EDAD_POST        OUT NUMBER,
                                    V_NACIO_POST       OUT VARCHAR2,
                                    V_OFICIO_POST      OUT VARCHAR2,
                                    V_DOMIC_POST       OUT VARCHAR2,
                                    V_AREA_SOL         OUT VARCHAR2,
                                    V_CARGO_SOL        OUT VARCHAR2,
                                    V_TIPO_CONT        OUT VARCHAR2,
                                    V_SALARIO_ACORD    OUT VARCHAR2,
                                    V_DES_DOTACION     OUT VARCHAR2,
                                    V_DES_SELECCION    OUT VARCHAR2,
                                    V_DES_CONTRATACION OUT VARCHAR2,
                                    V_DES_MARCACION    OUT VARCHAR2,
                                    V_DES_MAR_SABADO   OUT VARCHAR2,
                                    V_DES_ALMUERZO     OUT VARCHAR2,
                                    V_DES_MAR_SISTEMA  OUT VARCHAR2,
                                    V_TIPO_CONTRATO    OUT VARCHAR2,
                                    V_AREA             OUT NUMBER,
                                    V_CARGO            OUT NUMBER,
                                    V_CONT_POR         OUT VARCHAR2,
                                    V_MARCACION        OUT VARCHAR2,
                                    V_MAR_SABADO       OUT VARCHAR2,
                                    V_MAR_ALMUERZO     OUT VARCHAR2,
                                    V_MAR_SISTEMA      OUT VARCHAR2,
                                    V_FORMA_PAGO       OUT NUMBER,
                                    V_SUCURSAL         OUT NUMBER,
                                    v_valor            OUT NUMBER) AS
  BEGIN

    SELECT PO.DOCPOS_NOMBRE || ' ' || PO.DOCPOS_APELLIDO,
           PO.DOCPOS_CEDULA_IDEN,
           TRUNC(MONTHS_BETWEEN(TO_CHAR(SYSDATE, 'DD/MM/YYYY'),
                                TO_CHAR(PO.DOCPOS_FECHA_NAC, 'DD/MM/YYYY')) / 12),
           NAC.PAIS_NACIONALIDAD,
           PROF.PROF_DESC,
           INITCAP(PO.DOCPOS_DOMICILIO) DOCPOS_DOMICILIO
      INTO V_NOMBRE_POST,
           V_CEDULA_POST,
           V_EDAD_POST,
           V_NACIO_POST,
           V_OFICIO_POST,
           V_DOMIC_POST
      FROM PER_POSTULANTE_CARGO PO, GEN_PAIS NAC, GEN_PROFESION PROF
     WHERE PO.DOCPOS_CLAVE = V_CLAVE_POST
       AND PO.DOCPOS_EMPR = V_EMPRESA
       AND PO.DOCPOS_EMPR = NAC.PAIS_EMPR(+)
       AND PO.DOCPOS_NACI = NAC.PAIS_CODIGO(+)
       AND PO.DOCPOS_EMPR = PROF.PROF_EMPR(+)
       AND PO.DOCPOS_PROF = PROF.PROF_CODIGO(+);

    SELECT S.SOLPER_AREA || ' - ' || PA.AREDPP_DESC,
           S.SOLPER_CARGO || ' - ' || PC.CAR_DESC,
           DECODE(S.SOLPER_TIPO_CONT, 'TE', 'Temporal', 'IN', 'Indefinido'),
           (SELECT DECODE(T.SELEPER_EES_SALAR_ACORD,
                          NULL,
                          T.SELEPER_EAR_SALAR_PRO,
                          T.SELEPER_EES_SALAR_ACORD)
              FROM PER_SELECCION_PERSONAL T
             WHERE T.SELEPER_EMPR = V_EMPRESA
               AND T.SELPER_SOLICI = V_NRO_SOL
               AND T.SELPER_POSTUL = V_CLAVE_POST),
           DECODE(S.SOLPER_TIPO_DOTAC, 'IN', 'Incremento', 'Reposicion') Dotacion,
           DECODE(S.SOLPER_TIPO_SELEC, 'PR', 'Programada', 'Anticipada') Seleccion,
           DECODE(S.SOLPER_TIPO_CONTRATACION, 'PR', 'Programada', 'Directa') Contratacion,
           DECODE(S.SOLPER_CONS_MARC, 'S', 'Si', 'No') MARC,
           DECODE(S.SOLPER_CONS_MSABADO, 'S', 'Si', 'No'),
           DECODE(S.SOLPER_CONS_MALMUEZO, 'S', 'Si', 'No'),
           DECODE(S.SOLPER_CONS_MSISTEMA, 'R', 'Reloj', 'Sistema'),
           S.SOLPER_TIPO_CONT,
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
      INTO V_AREA_SOL,
           V_CARGO_SOL,
           V_TIPO_CONT,
           V_SALARIO_ACORD,
           V_DES_DOTACION,
           V_DES_SELECCION,
           V_DES_CONTRATACION,
           V_DES_MARCACION,
           V_DES_MAR_SABADO,
           V_DES_ALMUERZO,
           V_DES_MAR_SISTEMA,
           V_TIPO_CONTRATO,
           V_AREA,
           V_CARGO,
           V_CONT_POR,
           V_MARCACION,
           V_MAR_SABADO,
           V_MAR_ALMUERZO,
           V_MAR_SISTEMA,
           V_FORMA_PAGO,
           V_SUCURSAL
      FROM PER_SOLICITUD_PERSONAL  S,
           PER_AREA_DPP            PA,
           PER_CARGO               PC,
           PER_DESCRIP_PUESTO_PERF DP
     WHERE S.SOLPER_EMPR = V_EMPRESA
       AND S.SOLPER_CLAVE = V_NRO_SOL
       AND S.SOLPER_ESTADO_APROB = 'C'
       AND S.SOLPER_EMPR = PA.AREDPP_EMPR
       AND S.SOLPER_AREA = PA.AREDPP_CLAVE
       AND S.SOLPER_EMPR = PC.CAR_EMPR
       AND S.SOLPER_CARGO = PC.CAR_CODIGO
       AND S.SOLPER_EMPR = DP.DPP_EMPR
       AND S.SOLPER_AREA = DP.DPP_AREA
       AND S.SOLPER_CARGO = DP.DPP_CARGO_DPP;

    IF V_TIPO_CONT = 'Temporal' THEN
      v_valor := 1;
      --    RAISE_APPLICATION_ERROR(-20001, v_valor);
    ELSE
      v_valor := 2;
      --      RAISE_APPLICATION_ERROR(-20001, v_valor);
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_NOMBRE_POST := NULL;
      V_CEDULA_POST := NULL;
      V_EDAD_POST   := NULL;
      V_NACIO_POST  := NULL;
      V_OFICIO_POST := NULL;
      V_DOMIC_POST  := NULL;
      V_AREA_SOL    := NULL;
      V_CARGO_SOL   := NULL;
      V_TIPO_CONT   := NULL;

      RAISE_APPLICATION_ERROR(-20001, 'Problemas al Cargar los datos');

  END PP_TRAER_DATOS_CONTRATO;

  PROCEDURE PP_LLAMAR_REPORT_CONTRATO(V_EMPRESA       IN NUMBER,
                                      V_CLAVE_SOL     IN NUMBER,
                                      V_CLAVE_POST    IN NUMBER,
                                      V_REMUN_CONV    IN VARCHAR2,
                                      V_FECHA_INGRESO IN DATE,
                                      V_CANT_DIAS     IN NUMBER,
                                      V_TIPO_PAGO     IN NUMBER,
                                      V_USER          IN VARCHAR2,
                                      V_TIPO_SALIDA   IN VARCHAR2,
                                      V_TIPO_DOC      IN VARCHAR2,
                                      V_CLA_CONT2     IN NUMBER,
                                      V_LEGAJO        IN NUMBER) IS

    V_PARAMETROS          VARCHAR2(30000);
    V_NOMBRE_EMPRESA      VARCHAR2(1000);
    V_DEPART_EMPR         VARCHAR2(1000);
    V_REPUB_EMPR          VARCHAR2(1000);
    V_FECHA_CONT_LETRAS_1 VARCHAR2(1000);
    V_FECHA_CONT_LETRAS_2 VARCHAR2(1000);
    V_GEN_GEN_NOMBRE      VARCHAR2(1000);
    V_GEN_GEN_DOMIC       VARCHAR2(1000);
    V_NOMBRE_POSTUL       VARCHAR2(1000);
    V_SR_NOMBRE_POSTUL    VARCHAR2(1000);
    V_EDAD_POSTUL         NUMBER;
    V_GENERO_POSTUL       VARCHAR2(1000);
    V_ESTADO_CIVIL_POSTUL VARCHAR2(1000);
    V_PROFESION_POSTUL    VARCHAR2(1000);
    V_NACINALIDAD_POSTUL  VARCHAR2(1000);
    V_CIUDAD_POSTUL       VARCHAR2(1000);
    V_DIR_POSTUL          VARCHAR2(10000);
    V_CIUDAD_EMPR         VARCHAR2(1000);
    V_AREA_CARGO          VARCHAR2(1000);
    V_CARGO_DESC          VARCHAR2(1000);
    V_AMPER               VARCHAR2(2) := '&';
    V_FORMA_PAGO          VARCHAR2(1000);
    V_TIPO_CONT           VARCHAR2(5);
    V_COD_GARGO           NUMBER;
    V_COD_AREA            NUMBER;
    V_PLAZO_CONTRATO_1    VARCHAR2(1000);
    V_PLAZO_CONTRATO_2    VARCHAR2(1000);
    V_PLAZO_CONTRATO_3    VARCHAR2(1000);
    V_PLAZO_CONTRATO_4    VARCHAR2(1000);
    V_DURACION_DIVISION   VARCHAR2(1);
    V_REMUN_CONV_PAS      NCLOB;
    V_CLAUSULA_ESPECIAL   VARCHAR2(1);
    V_CI_POSTUL           VARCHAR2(100);
    V_GEN_GEN_CI          NUMBER;
    V_GEN_GEN_CI_CHAR     VARCHAR2(100);
    V_CI_POSTUL_CHAR      VARCHAR2(100);
    V_NOMBRE_REPORTE      VARCHAR2(200);
    V_CLAUSULA_ESP1       VARCHAR2(1000);
    V_CE_COD1             VARCHAR2(10);
    V_CE_COD2             VARCHAR2(10);
    V_CE_COD3             VARCHAR2(10);
    V_CE_COD4             VARCHAR2(10);
    V_CE_COD5             VARCHAR2(10);
    V_ZAFRA               NUMBER;
    V_FEC_ZAFRA           VARCHAR2(60);
    V_DES_ZAFRA           VARCHAR2(60);
    v_remu                varchar2(600);
    V_SUCURSAL            VARCHAR2(60);
    V_HORA_ENT            VARCHAR2(10);
    V_HORA_ENT_SAB        VARCHAR2(10);
    V_HORA_SAL            VARCHAR2(10);
    V_HORA_SAL_SAB        VARCHAR2(10);
    V_VTO_INDEFINIDO      DATE;
    V_TIPO_dESC           VARCHAR2(10);
    V_HORARIO             VARCHAR2(15000);
    V_KM_MANT             NUMBER;
    V_ACTUALIZACION       VARCHAR2(10);
    V_FECHA_CONTRATO1     DATE;
    v_dir1                varchar2(500);
    v_dir2                varchar2(500);
    -- V_FECHA               DATE;

    v_Fecha_Desv date;
  BEGIN

    SELECT PC.CONF_CONT_DIREC,
           PC.CONF_CONT_DEPART,
           PC.CONF_CONT_REPUB,
           PC.CONF_CONT_GEREN_GEN,
           PC.CONF_CONT_GEREN_DIR,
           PC.CONF_CONT_GEREN_CI
      INTO V_CIUDAD_EMPR,
           V_DEPART_EMPR,
           V_REPUB_EMPR,
           V_GEN_GEN_NOMBRE,
           V_GEN_GEN_DOMIC,
           V_GEN_GEN_CI
      FROM PER_CONFIGURACION PC
     WHERE PC.CONF_EMPR = V_EMPRESA;

    SELECT GE.EMPR_RAZON_SOCIAL
      INTO V_NOMBRE_EMPRESA
      FROM GEN_EMPRESA GE
     WHERE GE.EMPR_CODIGO = V_EMPRESA;

    --------------------------------------------------------------POR SELECCION

    IF V_CLAVE_SOL IS NOT NULL THEN

      BEGIN
        SELECT CASE
                 WHEN SUC_CODIGO = 1 THEN
                  'CENTRAL'
                 ELSE
                  SUC_DESC
               END SUCURSAL,
               NVL(TO_CHAR(S.CONSEL_HS_ENT, 'HH24:MI'), '07:00'),
               NVL(TO_CHAR(S.CONSEL_HS_SAL, 'HH24:MI'), '17:00'),
               NVL(TO_CHAR(S.CONSEL_HS_ENT_SAB, 'HH24:MI'), '07:00'),
               NVL(TO_CHAR(S.CONSEL_HS_SAL_SAB, 'HH24:MI'), '12:00'),
               CASE
                 WHEN NVL(TO_CHAR(S.CONSEL_HS_ENT, 'HH24:MI'), '07:00') >
                      '12:00' THEN
                  'descanso'
                 else
                  'almuerzo'
               end descanso,
               S.CONSEL_DIRECCION
          INTO V_SUCURSAL,
               V_HORA_ENT,
               V_HORA_SAL,
               V_HORA_ENT_SAB,
               V_HORA_SAL_SAB,
               V_TIPO_dESC,
               v_dir2
          FROM PER_CONTRATO_PROC_SEL S, GEN_SUCURSAL
         WHERE CONSEL_SUC = SUC_CODIGO(+)
           AND CONSEL_EMPR = SUC_EMPR(+)
           AND CONSEL_POSTUL = V_CLAVE_POST
           AND CONSEL_SOLI = V_CLAVE_SOL
           AND SUC_EMPR(+) = V_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          V_SUCURSAL := NULL;
      END;

      SELECT CASE
               WHEN PP.DOCPOS_EMPR = 1 THEN
                PP.DOCPOS_NOMBRE || ' ' || PP.DOCPOS_APELLIDO
               ELSE
                INITCAP(PP.DOCPOS_NOMBRE || ' ' || PP.DOCPOS_APELLIDO)
             END NOMBRE,
             DECODE(PP.DOCPOS_SEXO, 'M', 'Masculino', 'F', 'Femenino'),
             DECODE(PP.DOCPOS_ESTADO_CIV,
                    'C',
                    'Casad',
                    'S',
                    'Solter',
                    'Solter'),
             CASE
               WHEN PP.DOCPOS_EMPR = 1 THEN
                GP.PROF_DESC
               ELSE
                INITCAP(GP.PROF_DESC)
             END PROFESION,
             GPA.PAIS_NACIONALIDAD,
             CASE
               WHEN PP.DOCPOS_EMPR = 1 THEN
                PP.DOCPOS_DOMICILIO
               ELSE
                INITCAP(FZ.ZONA_DESC)
             END DOMICILIO,
             CASE
               WHEN PP.DOCPOS_EMPR = 1 THEN
                PP.DOCPOS_DOMICILIO
               ELSE
                INITCAP(FZ.ZONA_DESC)
             END ZONA_DESC,
             PP.DOCPOS_CEDULA_IDEN,
             TRUNC(MONTHS_BETWEEN(V_FECHA_INGRESO,
                                  TO_CHAR(PP.DOCPOS_FECHA_NAC, 'dd/mm/yyyy')) / 12)
        INTO V_NOMBRE_POSTUL,
             V_GENERO_POSTUL,
             V_ESTADO_CIVIL_POSTUL,
             V_PROFESION_POSTUL,
             V_NACINALIDAD_POSTUL,
             v_dir1, ---V_DIR_POSTUL,
             V_CIUDAD_POSTUL,
             V_CI_POSTUL,
             V_EDAD_POSTUL
        FROM PER_POSTULANTE_CARGO PP,
             GEN_PROFESION        GP,
             GEN_PAIS             GPA,
             FAC_ZONA             FZ
       WHERE PP.DOCPOS_EMPR = V_EMPRESA
         AND PP.DOCPOS_CLAVE = V_CLAVE_POST
         AND PP.DOCPOS_EMPR = GPA.PAIS_EMPR(+)
         AND PP.DOCPOS_NACI = GPA.PAIS_CODIGO(+)
         AND PP.DOCPOS_EMPR = GP.PROF_EMPR(+)
         AND PP.DOCPOS_PROF = GP.PROF_CODIGO(+)
         AND PP.DOCPOS_EMPR = FZ.ZONA_EMPR(+)
         AND PP.DOCPOS_ZONA = FZ.ZONA_CODIGO(+);

      IF v_dir2 IS NOT NULL THEN
        V_DIR_POSTUL := v_dir2;
      ELSE
        V_DIR_POSTUL := v_dir1;
      END IF;
      -- raise_application_error (-20001, V_DIR_POSTUL);

      IF V_GENERO_POSTUL = 'Masculino' THEN
        IF V_TIPO_DOC = 3 THEN
          V_SR_NOMBRE_POSTUL := 'El sr. ' || V_NOMBRE_POSTUL;
        ELSE
          V_SR_NOMBRE_POSTUL := 'el sr. ' || V_NOMBRE_POSTUL;
        END IF;
        V_ESTADO_CIVIL_POSTUL := V_ESTADO_CIVIL_POSTUL || 'o';
      ELSE
        V_SR_NOMBRE_POSTUL    := 'la sra. ' || V_NOMBRE_POSTUL;
        V_ESTADO_CIVIL_POSTUL := V_ESTADO_CIVIL_POSTUL || 'a';
      END IF;

      SELECT AR.AREDPP_DESC,
             PCA.CAR_DESC,
             SOL.SOLPER_TIPO_CONT,
             SOL.SOLPER_AREA,
             SOL.SOLPER_CARGO,
             SOL.SOLPER_ZAFRA
        INTO V_AREA_CARGO,
             V_CARGO_DESC,
             V_TIPO_CONT,
             V_COD_AREA,
             V_COD_GARGO,
             V_ZAFRA
        FROM PER_SOLICITUD_PERSONAL SOL,
             PER_AREA_DPP           AR,
             PER_CARGO_DPP          PCD,
             PER_CARGO              PCA
       WHERE SOL.SOLPER_EMPR = V_EMPRESA
         AND SOL.SOLPER_CLAVE = V_CLAVE_SOL
         AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR(+)
         AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE(+)
         AND SOL.SOLPER_EMPR = PCD.CARDPP_EMPR(+)
         AND SOL.SOLPER_CARGO = PCD.CARDPP_CLAVE(+)
         AND SOL.SOLPER_AREA = PCD.CARDPP_AREA(+)
         AND PCD.CARDPP_EMPR = PCA.CAR_EMPR(+)
         AND PCD.CARDPP_CLAVE = PCA.CAR_CODIGO(+);

    ELSE
      -------------------------------------------------------------SIN PROCESO DE SELECCION

      SELECT C.EMPL_NOMBRE || ' ' || C.EMPL_APE NOMBRE,
             decode(c.empl_sexo, 'M', 'Masculino', 'F', 'Femenino') sexo,
             DECODE(DECODE(A.PCON_EST_CIVIL,
                           NULL,
                           C.EMPL_EST_CIVIL,
                           PCON_EST_CIVIL),
                    'C',
                    'Casad',
                    'S',
                    'Solter',
                    'Solter') ESTADO_CIVIL,
             CASE
               WHEN a.pcon_empr = 1 THEN
                P.PROF_DESC
               ELSE
                INITCAP(P.PROF_DESC)
             END PROFESION,
             S.PAIS_NACIONALIDAD,

             CASE
               WHEN pcon_empr = 1 THEN
                A.PCON_DIRECCION
               ELSE
                INITCAP(A.PCON_DIRECCION)
             END DOMICILIO,

             CASE
               WHEN pcon_empr = 1 THEN
                A.PCON_DIRECCION
               ELSE
                INITCAP(A.PCON_DIRECCION)
             END ZONA_DESC,
             A.PCON_CI,
             TRUNC(MONTHS_BETWEEN(a.pcon_fec_contrato,
                                  TO_CHAR(C.EMPL_FEC_NAC, 'dd/mm/yyyy')) / 12) EDAD,
             PCON_KM_MANT,
             PCON_ACTUALIZACION,
             DECODE(A.PCON_FEC_CONTRATO,
                    NULL,
                    V_FECHA_INGRESO,
                    A.PCON_FEC_CONTRATO)
        INTO V_NOMBRE_POSTUL,
             V_GENERO_POSTUL,
             V_ESTADO_CIVIL_POSTUL,
             V_PROFESION_POSTUL,
             V_NACINALIDAD_POSTUL,
             V_DIR_POSTUL,
             V_CIUDAD_POSTUL,
             V_CI_POSTUL,
             V_EDAD_POSTUL,
             V_KM_MANT,
             V_ACTUALIZACION,
             V_FECHA_CONTRATO1
        FROM PER_CONT_SIN_PROSELC A,
             PER_EMPLEADO         C,
             GEN_PROFESION        P,
             GEN_PAIS             S
       WHERE A.PCON_LEGAJO = C.EMPL_LEGAJO
         AND A.PCON_EMPR = C.EMPL_EMPRESA
         AND C.EMPL_NACIONALIDAD = S.PAIS_CODIGO(+)
         AND C.EMPL_EMPRESA = S.PAIS_EMPR(+)
         AND C.EMPL_PROF = P.PROF_CODIGO(+)
         AND C.EMPL_EMPRESA = P.PROF_EMPR(+)
         AND A.PCON_EMPR = V_EMPRESA
         AND A.PCON_CODIGO = V_CLA_CONT2;

      IF V_GENERO_POSTUL = 'Masculino' THEN
        IF V_TIPO_DOC = 3 THEN
          V_SR_NOMBRE_POSTUL := 'El sr. ' || V_NOMBRE_POSTUL;
        ELSE
          V_SR_NOMBRE_POSTUL := 'el sr. ' || V_NOMBRE_POSTUL;
        END IF;
        V_ESTADO_CIVIL_POSTUL := V_ESTADO_CIVIL_POSTUL || 'o';
      ELSE
        V_SR_NOMBRE_POSTUL    := 'la sra. ' || V_NOMBRE_POSTUL;
        V_ESTADO_CIVIL_POSTUL := V_ESTADO_CIVIL_POSTUL || 'a';
      END IF;

      SELECT AR.AREDPP_DESC,
             PCA.CAR_DESC,
             CON.PCON_TIPO_CONT,
             CON.PCON_AREA,
             CON.PCON_CARGO,
             NULL,
             CASE
               WHEN SUC_CODIGO = 1 THEN
                'CENTRAL'
               ELSE
                SUC_DESC
             END SUCURSAL,
             NVL(TO_CHAR(PCON_HS_ENT, 'HH24:MI'), '07:00'),
             NVL(TO_CHAR(PCON_HS_SAL, 'HH24:MI'), '17:00'),
             NVL(TO_CHAR(PCON_HS_ENT_SAB, 'HH24:MI'), '07:00'),
             NVL(TO_CHAR(PCON_HS_SAL_SAB, 'HH24:MI'), '12:00'),
             CASE
               WHEN NVL(TO_CHAR(PCON_HS_ENT, 'HH24:MI'), '07:00') > '12:00' THEN
                'descanso'
               else
                'almuerzo'
             end descanso
        INTO V_AREA_CARGO,
             V_CARGO_DESC,
             V_TIPO_CONT,
             V_COD_AREA,
             V_COD_GARGO,
             V_ZAFRA,
             V_SUCURSAL,
             V_HORA_ENT,
             V_HORA_SAL,
             V_HORA_ENT_SAB,
             V_HORA_SAL_SAB,
             V_TIPO_dESC
        FROM PER_CONT_SIN_PROSELC CON,
             PER_AREA_DPP         AR,
             PER_CARGO_DPP        PCD,
             PER_CARGO            PCA,
             GEN_SUCURSAL         GS
       WHERE CON.PCON_EMPR = V_EMPRESA
         AND CON.PCON_CODIGO = V_CLA_CONT2
         AND CON.PCON_EMPR = AR.AREDPP_EMPR(+)
         AND CON.PCON_AREA = AR.AREDPP_CLAVE(+)
         AND CON.PCON_EMPR = PCD.CARDPP_EMPR(+)
         AND CON.PCON_CARGO = PCD.CARDPP_CLAVE(+)
         AND CON.PCON_AREA = PCD.CARDPP_AREA(+)
         AND CON.PCON_EMPR = PCA.CAR_EMPR(+)
         AND CON.PCON_CARGO = PCA.CAR_CODIGO(+)
         AND CON.PCON_SUC = GS.SUC_CODIGO(+)
         AND CON.PCON_EMPR = GS.SUC_EMPR(+);

    END IF;

    if V_TIPO_PAGO = 1 and V_EMPRESA = 2 then
      v_remu := 'jornal por hora de trabajo de acuerdo al minimo vigente';

    else
      v_remu := ' de ' || V_REMUN_CONV;
    end if;

    IF V_CARGO_DESC LIKE '%CHOFER%' AND V_EMPRESA = 1 THEN
      V_FORMA_PAGO := '2.1.- El presente Contrato Individual de Trabajo es por unidad de tiempo.';
    ELSE
      V_FORMA_PAGO := '2.1.- Por unidad de tiempo.';

    END IF;
    V_REMUN_CONV_PAS := '3.1.-' || V_REMUN_CONV;

    IF V_TIPO_CONT = 'IN' THEN

      V_PLAZO_CONTRATO_1 := '4.1.- Indefinido.    X ';
      V_PLAZO_CONTRATO_2 := '4.2.- Fecha de inicio del trabajo: ' ||
                            V_FECHA_INGRESO;
      -- V_PLAZO_CONTRATO_3 := '4.3.- Periodo de prueba: 60 dias, desde el '||V_FECHA_INGRESO||' hasta el '||ADD_MONTHS((TO_DATE(SYSDATE,'DD/MM/YYYY')),2); -- El periodo de prueba debe ser desde la fecha de ingreso mas dos meses.

      IF nvl(V_ACTUALIZACION, 'X') = 'X' THEN
        /*   V_PLAZO_CONTRATO_3 := '4.3.- Periodo de prueba: 60 dias, desde el ' ||
        V_FECHA_INGRESO || ' hasta el ' ||
        ADD_MONTHS((TO_DATE(V_FECHA_INGRESO,
                            'DD/MM/YYYY')),
                   2);*/

        V_PLAZO_CONTRATO_3 := 'Periodo de Prueba es de 60 dias desde la fecha de inicio de las Labores.';
      END IF;

    ELSIF V_TIPO_CONT = 'TE' THEN
      v_Fecha_Desv := TO_DATE(V_FECHA_INGRESO, 'DD/MM/YYYY') + 60;

      --Esto es algo temporal, falta modificar el contrato, para incluir esa parte.
      --  V_VTO_INDEFINIDO := ADD_MONTHS(TO_DATE(V_FECHA_INGRESO, 'DD/MM/YYYY'), +2);
      V_PLAZO_CONTRATO_1 := '4.1.- Plazo determinado';
      V_PLAZO_CONTRATO_2 := '4.2.- Fecha de ingreso del trabajador: ' ||
                            V_FECHA_INGRESO;
      if V_CLAVE_SOL not in (854, 842) then
        ----/*'||v_Fecha_Desv||'*/
        V_PLAZO_CONTRATO_3 := '4.3.- Fecha de terminacion del contrato: 03/12/2021. La terminacion del contrato es sin responsabilidad para las partes. ' ||
                              'El presente contrato se pacta por plazo determinado en razon de la necesidad de la ' ||
                              'empresa de contar con mas personal debido a la temporada de zafra.' || --- al aumento de ventas. '||--para proceder a control de peso, toma de muestra y molienda  ' ||
                             --'debido a la temporada de zafra que se inicia el 01 de octubre del cte. a?o con finalizacion de fecha 30 diciembre del cte. a?o. ' ||
                              'Y estimando las partes, de comun acuerdo que, al efecto, el plazo para el cumplimiento de dicho objetivo es el establecido en este contrato.' ||
                             --  'establecido en este contrato. ' ||
                              'Si la tarea que le es encomendada concluye antes del plazo previsto, el presente contrato concluira sin obligacion de preavisar ni indemnizar para ninguna de las partes.';
      ELSIF V_CLAVE_SOL in (854, 842) then
        V_PLAZO_CONTRATO_3 := '4.3.- Fecha de terminacion del contrato: 15/10/2021. La terminacion del contrato es sin responsabilidad para las partes. ' ||
                              'El presente contrato se pacta por plazo determinado en razon de la necesidad de la ' ||
                              'empresa de contar con mas personal para cubrir vacaciones. ' || --- licencia por marternidad. '||--para proceder a control de peso, toma de muestra y molienda  ' ||
                             --'debido a la temporada de zafra que se inicia el 01 de octubre del cte. a?o con finalizacion de fecha 30 diciembre del cte. a?o. ' ||
                              'Y estimando las partes, de comun acuerdo que, al efecto, el plazo para el cumplimiento de dicho objetivo es el establecido en este contrato.' ||
                             --  'establecido en este contrato. ' ||
                              'Si la tarea que le es encomendada concluye antes del plazo previsto, el presente contrato concluira sin obligacion de preavisar ni indemnizar para ninguna de las partes';
      END IF;

    END IF;

    IF V_TIPO_PAGO = 2 THEN
      V_DURACION_DIVISION := 'S';
    ELSE
      V_DURACION_DIVISION := 'N';
    END IF;

    IF V_COD_AREA = 5 THEN
      V_CLAUSULA_ESPECIAL := 'N'; --Cambio que solicito Andrea, porque el manual no se le entrega...
    ELSE
      V_CLAUSULA_ESPECIAL := 'N';
    END IF;

    IF V_CLAVE_SOL IS NULL THEN
      V_FECHA_CONTRATO1 := V_FECHA_CONTRATO1;
    ELSE
      V_FECHA_CONTRATO1 := V_FECHA_INGRESO;
    END IF;

    V_FECHA_CONT_LETRAS_1 := ' ' ||
                             LOWER(GENERAL.FP_CONV_NRO_TXT(TO_NUMBER(TO_CHAR(V_FECHA_CONTRATO1,
                                                                             'DD')))) ||
                             ' dias del mes de ' ||
                             REPLACE(LOWER(TO_CHAR(TO_DATE(V_FECHA_CONTRATO1),
                                                   'MONTH')),
                                     ' ',
                                     '');

    V_FECHA_CONT_LETRAS_2 := LOWER(GENERAL.FP_CONV_NRO_TXT(TO_NUMBER(TO_CHAR(V_FECHA_CONTRATO1,
                                                                             'YYYY'))));

    V_FECHA_CONT_LETRAS_1 := REPLACE(V_FECHA_CONT_LETRAS_1,
                                     ' con 0/100',
                                     '');

    V_FECHA_CONT_LETRAS_2 := REPLACE(V_FECHA_CONT_LETRAS_2,
                                     ' con 0/100',
                                     '');

    V_GEN_GEN_CI_CHAR := TO_CHAR(V_GEN_GEN_CI, '999G999G999G990');
    V_CI_POSTUL_CHAR  := TO_CHAR(V_CI_POSTUL, '999G999G999G990');

    IF V_EMPRESA = 2 THEN
      ---PARA EL CONTRATO DE TRANSAGRO
      IF V_AREA_CARGO = 'SILO' THEN
        V_CLAUSULA_ESP1 := '6.4.- EL TRABAJADOR se compromete a utilizar los equipos de seguridad provistos ' ||
                           'por la empresa durante el ejercicio de sus tareas, ' ||
                           'de conformidad a lo establecido en el Art. 277 del Codigo del Trabajo.-';
        V_CE_COD1       := '6.5.- ';
        V_CE_COD2       := '6.6.- ';
        V_CE_COD3       := '6.7.- ';
        V_CE_COD4       := '6.8.- ';
        V_CE_COD5       := '6.9.- ';

      ELSE
        V_CE_COD1 := '6.4.- ';
        V_CE_COD2 := '6.5.- ';
        V_CE_COD3 := '6.6.- ';
        V_CE_COD4 := '6.7.- ';
        V_CE_COD5 := '6.8.- ';
      END IF;
      IF V_COD_GARGO = 38 THEN
        IF V_ZAFRA = 1 THEN
          V_FEC_ZAFRA := TO_NUMBER(to_char(sysdate, 'YYYY'));
          V_DES_ZAFRA := 'SOJA';
        ELSIF V_ZAFRA = 2 THEN
          V_FEC_ZAFRA := 'setiembre de ' || to_char(sysdate, 'YYYY'); ---'agosto de ' || to_char(sysdate, 'YYYY'); ---'agosto de ' || to_char(sysdate, 'YYYY');
          V_DES_ZAFRA := 'MAIZ';
        ELSIF V_ZAFRA = 3 THEN
          V_FEC_ZAFRA := 'agosto de ' || to_char(sysdate, 'YYYY');
          V_DES_ZAFRA := 'TRIGO';
         ELSIF V_ZAFRA = 4 THEN
          V_FEC_ZAFRA := 'agosto de ' || to_char(sysdate, 'YYYY');
          V_DES_ZAFRA := 'SOJA ZAFRINHA';
        END IF;
      END IF;

    END IF;
    -- concatenar los parametros para llamar el reporte en jasper
    V_PARAMETROS := 'P_FORMATO=' || URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CIUDAD_EMPR=' ||
                    URL_ENCODE(V_CIUDAD_EMPR);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_DEPART_EMPR=' ||
                    URL_ENCODE(V_DEPART_EMPR);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_REPUB_EMPR=' ||
                    URL_ENCODE(V_REPUB_EMPR);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FECHA_CONT_LETRAS_1=' ||
                    URL_ENCODE(V_FECHA_CONT_LETRAS_1);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FECHA_CONT_LETRAS_2=' ||
                    URL_ENCODE(V_FECHA_CONT_LETRAS_2);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_GEN_GEN_NOMBRE=' ||
                    URL_ENCODE(V_GEN_GEN_NOMBRE);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_NOMBRE_EMPRESA=' ||
                    URL_ENCODE(V_NOMBRE_EMPRESA);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_GEN_GEN_DOMIC=' ||
                    URL_ENCODE(V_GEN_GEN_DOMIC);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_SR_NOMBRE_POSTUL=' ||
                    URL_ENCODE(V_SR_NOMBRE_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_EDAD_POSTUL=' ||
                    URL_ENCODE(V_EDAD_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_GENERO_POSTUL=' ||
                    URL_ENCODE(V_GENERO_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_ESTADO_CIVIL_POSTUL=' ||
                    URL_ENCODE(V_ESTADO_CIVIL_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_PROFESION_POSTUL=' ||
                    URL_ENCODE(V_PROFESION_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_NACINALIDAD_POSTUL=' ||
                    URL_ENCODE(V_NACINALIDAD_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_DIR_POSTUL=' ||
                    URL_ENCODE(REPLACE(REPLACE(REPLACE(V_DIR_POSTUL,
                                                       CHR(10),
                                                       ''),
                                               CHR(13),
                                               ''),
                                       '.',
                                       ' '));
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CIUDAD_EMPR=' ||
                    URL_ENCODE(V_CIUDAD_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_AREA_CARGO=' ||
                    URL_ENCODE(REPLACE(V_AREA_CARGO, '.', ''));
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CARGO_DESC=' ||
                    URL_ENCODE(V_CARGO_DESC);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FORMA_PAGO=' ||
                    URL_ENCODE(V_FORMA_PAGO);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_REMUN_CONVENIDA=' ||
                    URL_ENCODE(V_REMUN_CONV_PAS);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_PLAZO_CONTRATO_1=' ||
                    URL_ENCODE(V_PLAZO_CONTRATO_1);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_PLAZO_CONTRATO_2=' ||
                    URL_ENCODE(V_PLAZO_CONTRATO_2);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_PLAZO_CONTRATO_3=' ||
                    URL_ENCODE(V_PLAZO_CONTRATO_3);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_DURACION_DIVISION=' ||
                    URL_ENCODE(V_DURACION_DIVISION);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAUSULA_ESPECIAL=' ||
                    URL_ENCODE(V_CLAUSULA_ESPECIAL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_NOMBRE_EMPLEADO=' ||
                    URL_ENCODE(V_NOMBRE_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_NOMBRE_EMPLEADOR=' ||
                    URL_ENCODE(upper(V_GEN_GEN_NOMBRE));
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CI_EMPLEADO=' ||
                    URL_ENCODE(REPLACE(V_CI_POSTUL_CHAR, ' ', ''));
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CI_EMPLEADOR=' ||
                    URL_ENCODE(REPLACE(V_GEN_GEN_CI_CHAR, ' ', ''));
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CIUDAD_POST=' ||
                    URL_ENCODE(V_CIUDAD_POSTUL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FEC_INGRESO_POST=' ||
                    URL_ENCODE(V_FECHA_INGRESO);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAUSULA_ESPEC=' ||
                    URL_ENCODE(V_CLAUSULA_ESP1);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAUSULA_COD1=' ||
                    URL_ENCODE(V_CE_COD1);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAUSULA_COD2=' ||
                    URL_ENCODE(V_CE_COD2);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAUSULA_COD3=' ||
                    URL_ENCODE(V_CE_COD3);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAUSULA_COD4=' ||
                    URL_ENCODE(V_CE_COD4);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAUSULA_COD5=' ||
                    URL_ENCODE(V_CE_COD5);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FEC_ZAFRA=' ||
                    URL_ENCODE(V_FEC_ZAFRA);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_REMUNERACION_TRANS=' ||
                    URL_ENCODE(v_remu);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_ZAFRA_DES=' ||
                    URL_ENCODE(V_DES_ZAFRA);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_EMPRESA=' ||
                    URL_ENCODE(V_EMPRESA);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_SUCURSAL=' ||
                    URL_ENCODE(V_SUCURSAL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CONT_EMPL=' ||
                    URL_ENCODE(V_CLA_CONT2);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_HS_ENTRADA=' ||
                    URL_ENCODE(V_HORA_ENT);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_HS_SALIDA=' ||
                    URL_ENCODE(V_HORA_SAL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_HS_ENT_SAB=' ||
                    URL_ENCODE(V_HORA_ENT_SAB);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_HS_SAL_SAB=' ||
                    URL_ENCODE(V_HORA_SAL_SAB);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_TIPO_DESC=' ||
                    URL_ENCODE(V_TIPO_DESC);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_km_chofer=' ||
                    URL_ENCODE(V_KM_MANT);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FORMA_PAGO_COD=' ||
                    URL_ENCODE(V_TIPO_PAGO);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAVE_SOL=' ||
                    URL_ENCODE(V_CLAVE_SOL);
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_TIPO_CONTRATO=' ||
                    URL_ENCODE(CHR(39) || V_TIPO_CONT || CHR(39));

    /*IF V_CLAVE_POST IS NULL AND V_EMPRESA = 1 THEN
     V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAVE_POST=' ||
                     URL_ENCODE('''''');
    ELSIF V_CLAVE_POST IS NOT NULL THEN */
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAVE_POST=' ||
                    URL_ENCODE(V_CLAVE_POST);

    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FEC_INGRESO=' ||
                    URL_ENCODE(V_FECHA_INGRESO);

    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FECHA_CONT=' ||
                    URL_ENCODE(V_FECHA_CONTRATO1);

    /* END IF;*/

    ----raise_application_error (-20001,V_TIPO_DOC||'***'||V_EMPRESA);

    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = V_USER;

    IF V_TIPO_DOC = 1 AND V_EMPRESA = 1 AND V_CARGO_DESC LIKE '%CHOFER%' and
       nvl(V_ACTUALIZACION, 'N') <> 'A' THEN
      V_NOMBRE_REPORTE := 'PERI088_CHR';
    ELSIF V_TIPO_DOC = 1 AND V_EMPRESA = 1 AND V_CARGO_DESC LIKE '%CHOFER%' and
          nvl(V_ACTUALIZACION, 'N') = 'A' THEN
      V_NOMBRE_REPORTE := 'PERI088_CHR1';
    ELSIF V_TIPO_DOC = 1 AND V_EMPRESA = 1 and
          nvl(V_ACTUALIZACION, 'N') <> 'A' THEN
      V_NOMBRE_REPORTE := 'PERI088';
    ELSIF V_TIPO_DOC = 1 AND V_EMPRESA = 1 and
          nvl(V_ACTUALIZACION, 'N') = 'A' THEN
      V_NOMBRE_REPORTE := 'PERI088_1';
    ELSIF V_TIPO_DOC = 1 AND V_EMPRESA = 2 AND V_COD_GARGO = 1 THEN
      V_NOMBRE_REPORTE := 'PERI088_T1'; ---ES EL CONTRATO PARA LOS CHOFRES
    ELSIF V_TIPO_DOC = 1 AND V_EMPRESA = 2 AND V_COD_GARGO = 38 THEN
      V_NOMBRE_REPORTE := 'PERI088_T2'; ---ES EL CONTRATO PARA LOS ZAFREROS
    ELSIF V_TIPO_DOC = 1 AND V_EMPRESA = 2 AND V_COD_GARGO = 114 THEN
      V_NOMBRE_REPORTE := 'PERI088_T4'; ---ES EL CONTRATO PARA LOS ZAFREROS
    ELSIF V_TIPO_DOC = 1 AND V_EMPRESA = 2 AND
          V_COD_GARGO NOT IN (1, 38, 114) THEN
      V_NOMBRE_REPORTE := 'PERI088_T3';
    ELSIF V_TIPO_DOC = 2 THEN
      V_NOMBRE_REPORTE := 'PERI088_A'; ---DOCUMENTO DE ANEXO PARA CHOFERES
    ELSIF V_TIPO_DOC = 3 THEN
      V_NOMBRE_REPORTE := 'PERI088_C'; ---CONTRATO DE CONFIDENCIALIDAD PARA LOS TRABAJADORES DE TRANSAGRO
    ELSIF V_TIPO_DOC = 4 AND V_EMPRESA = 2 THEN
      V_NOMBRE_REPORTE := 'PERI088_AD'; ---CONTRATO DE CONFIDENCIALIDAD PARA LOS TRABAJADORES DE TRANSAGRO
    ELSIF V_TIPO_DOC = 4 AND V_EMPRESA = 1 THEN
      V_NOMBRE_REPORTE := 'PERI088_CH_AD';
    else
      -- 11/07/2022 13:52:01 @PabloACespedes \(^-^)/
      -- se_utiliza el de base para las otras empresas
      V_NOMBRE_REPORTE := 'PERI088_2';
    END IF;
    --if v_empresa = 20 then  RAISE_APPLICATION_ERROR (-20001,V_NOMBRE_REPORTE||'***'); end if;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, V_USER, V_NOMBRE_REPORTE, V_TIPO_SALIDA);
    COMMIT;

  END PP_LLAMAR_REPORT_CONTRATO;

  PROCEDURE PP_CREAR_RECONTRATACION(P_EMPRESA      IN NUMBER,
                                    P_LEGAJO       IN NUMBER,
                                    P_NOMBRE       OUT VARCHAR2,
                                    P_EDAD         OUT NUMBER,
                                    P_NAC          OUT VARCHAR2,
                                    P_DIRECCION    OUT VARCHAR2,
                                    P_CI           OUT NUMBER,
                                    P_OFICIO       OUT VARCHAR2,
                                    P_OFI_COD      OUT NUMBER,
                                    P_EST_CIVIL    OUT VARCHAR2,
                                    P_ACT_CONTRATO IN VARCHAR2,
                                    P_AREA         OUT NUMBER,
                                    P_CARGO        OUT NUMBER,
                                    P_INICIO       OUT DATE) IS

    V_LISTA_NEGRA NUMBER;

    v_AREA       NUMBER;
    v_CARGO      NUMBER;
    P_TIPO_CONT  VARCHAR2(60);
    P_FORMA_PAGO NUMBER;
    P_SUCURSAL   NUMBER;
  BEGIN
    BEGIN

      SELECT EMPL_NOMBRE || ' ' || EMPL_APE NOMBRE,
             TRUNC((SYSDATE - A.EMPL_FEC_NAC) / 365) EDAD,
             B.PAIS_NACIONALIDAD,
             INITCAP(P.PCON_DIRECCION) PCON_DIRECCION,
             A.EMPL_DOC_IDENT,
             C.PCAT_DESC,
             C.PCAT_CODIGO,
             P.PCON_EST_CIVIL,
             DECODE(P_ACT_CONTRATO, 'A', P.PCON_AREA, NULL),
             DECODE(P_ACT_CONTRATO, 'A', P.PCON_CARGO, NULL),
             DECODE(P_ACT_CONTRATO, 'A', P.PCON_TIPO_CONT, NULL),
             DECODE(P_ACT_CONTRATO, 'A', P.PCON_FORMA_PAGO, NULL),
             DECODE(P_ACT_CONTRATO, 'A', P.PCON_SUC, NULL),
             EMPL_FEC_INGRESO
        INTO P_NOMBRE,
             P_EDAD,
             P_NAC,
             P_DIRECCION,
             P_CI,
             P_OFICIO,
             P_OFI_COD,
             P_EST_CIVIL,
             P_AREA,
             P_CARGO,
             P_TIPO_CONT,
             P_FORMA_PAGO,
             P_SUCURSAL,
             P_INICIO
        FROM PER_CONT_SIN_PROSELC P,
             PER_EMPLEADO         A,
             GEN_PAIS             B,
             PER_CATEGORIA        C
       WHERE EMPL_NACIONALIDAD = B.PAIS_CODIGO(+)
         AND EMPL_EMPRESA = B.PAIS_EMPR(+)
         AND EMPL_CATEG = C.PCAT_CODIGO(+)
         AND EMPL_EMPRESA = C.PCAT_EMPR(+)
         AND P.PCON_LEGAJO = A.EMPL_LEGAJO
         AND P.PCON_EMPR = A.EMPL_EMPRESA
         AND EMPL_SITUACION in ('I', 'A')
         AND EMPL_EMPRESA = P_EMPRESA
         AND EMPL_LEGAJO = P_LEGAJO
       group by EMPL_NOMBRE || ' ' || EMPL_APE,
                TRUNC((SYSDATE - A.EMPL_FEC_NAC) / 365),
                B.PAIS_NACIONALIDAD,
                INITCAP(P.PCON_DIRECCION),
                A.EMPL_DOC_IDENT,
                C.PCAT_DESC,
                C.PCAT_CODIGO,
                P.PCON_EST_CIVIL,
                DECODE(P_ACT_CONTRATO, 'A', P.PCON_AREA, NULL),
                DECODE(P_ACT_CONTRATO, 'A', P.PCON_CARGO, NULL),
                DECODE(P_ACT_CONTRATO, 'A', P.PCON_TIPO_CONT, NULL),
                DECODE(P_ACT_CONTRATO, 'A', P.PCON_FORMA_PAGO, NULL),
                DECODE(P_ACT_CONTRATO, 'A', P.PCON_SUC, NULL),
                EMPL_FEC_INGRESO;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN

        BEGIN
          SELECT EMPL_NOMBRE || ' ' || EMPL_APE NOMBRE,
                 TRUNC((SYSDATE - A.EMPL_FEC_NAC) / 365) EDAD,
                 B.PAIS_NACIONALIDAD,
                 INITCAP(A.EMPL_DIR) EMPL_DIR,
                 A.EMPL_DOC_IDENT,
                 C.PCAT_DESC,
                 C.PCAT_CODIGO,
                 A.EMPL_EST_CIVIL,
                 DECODE(P_ACT_CONTRATO, 'A', A.EMPL_AREA_ORGANI, NULL),
                 DECODE(P_ACT_CONTRATO, 'A', A.EMPL_CARGO, NULL),
                 DECODE(P_ACT_CONTRATO, 'A', A.EMPL_TIPO_CONT, NULL),
                 DECODE(P_ACT_CONTRATO, 'A', A.EMPL_FORMA_PAGO, NULL),
                 DECODE(P_ACT_CONTRATO, 'A', A.EMPL_SUCURSAL, NULL),
                 EMPL_FEC_INGRESO
            INTO P_NOMBRE,
                 P_EDAD,
                 P_NAC,
                 P_DIRECCION,
                 P_CI,
                 P_OFICIO,
                 P_OFI_COD,
                 P_EST_CIVIL,
                 P_AREA,
                 P_CARGO,
                 P_TIPO_CONT,
                 P_FORMA_PAGO,
                 P_SUCURSAL,
                 P_INICIO
            FROM PER_EMPLEADO A, GEN_PAIS B, PER_CATEGORIA C
           WHERE EMPL_NACIONALIDAD = B.PAIS_CODIGO(+)
             AND EMPL_EMPRESA = B.PAIS_EMPR(+)
             AND EMPL_CATEG = C.PCAT_CODIGO(+)
             AND EMPL_EMPRESA = C.PCAT_EMPR(+)
                -- AND EMPL_SITUACION in('I','A')
             AND EMPL_EMPRESA = P_EMPRESA
             AND EMPL_LEGAJO = P_LEGAJO;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001,
                                    'El empleado no existe o esta activo');
          WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001,
                                    'Error, avise al administrador');
        END;
      WHEN TOO_MANY_ROWS THEN
        SELECT EMPL_NOMBRE || ' ' || EMPL_APE NOMBRE,
               TRUNC((SYSDATE - A.EMPL_FEC_NAC) / 365) EDAD,
               B.PAIS_NACIONALIDAD,
               INITCAP(A.EMPL_DIR) EMPL_DIR,
               A.EMPL_DOC_IDENT,
               C.PCAT_DESC,
               C.PCAT_CODIGO,
               A.EMPL_EST_CIVIL,
               DECODE(P_ACT_CONTRATO, 'A', A.EMPL_AREA_ORGANI, NULL),
               DECODE(P_ACT_CONTRATO, 'A', A.EMPL_CARGO, NULL),
               DECODE(P_ACT_CONTRATO, 'A', A.EMPL_TIPO_CONT, NULL),
               DECODE(P_ACT_CONTRATO, 'A', A.EMPL_FORMA_PAGO, NULL),
               DECODE(P_ACT_CONTRATO, 'A', A.EMPL_SUCURSAL, NULL),
               EMPL_FEC_INGRESO
          INTO P_NOMBRE,
               P_EDAD,
               P_NAC,
               P_DIRECCION,
               P_CI,
               P_OFICIO,
               P_OFI_COD,
               P_EST_CIVIL,
               P_AREA,
               P_CARGO,
               P_TIPO_CONT,
               P_FORMA_PAGO,
               P_SUCURSAL,
               P_INICIO
          FROM PER_EMPLEADO A, GEN_PAIS B, PER_CATEGORIA C
         WHERE EMPL_NACIONALIDAD = B.PAIS_CODIGO(+)
           AND EMPL_EMPRESA = B.PAIS_EMPR(+)
           AND EMPL_CATEG = C.PCAT_CODIGO(+)
           AND EMPL_EMPRESA = C.PCAT_EMPR(+)
           AND EMPL_SITUACION in ('I', 'A')
           AND EMPL_EMPRESA = P_EMPRESA
           AND EMPL_LEGAJO = P_LEGAJO;

        -----------------------------VERIFICAR LISTA NEGRA
        select count(*)
          into V_LISTA_NEGRA
          from FIN_CLI_LIST_NEGRA a
         where replace(a.clisne_ci, '.', null) = TO_CHAR(P_CI)
           AND a.clisne_EMPR = P_EMPRESA;

        IF V_LISTA_NEGRA > 0 THEN
          RAISE_APPLICATION_ERROR(-20001,
                                  'El empleado se encuentra en lista negra');
        END IF;

    END;

  END PP_CREAR_RECONTRATACION;

  PROCEDURE PP_INSERTAR_RECONTRATACION(P_EMPRESA    IN NUMBER,
                                       P_LEGAJO     IN NUMBER,
                                       P_DIRECCION  IN VARCHAR2,
                                       P_CI         IN NUMBER,
                                       P_OFI_COD    IN NUMBER,
                                       P_AREA       IN NUMBER,
                                       P_CARGO      IN NUMBER,
                                       P_TIPO_CONT  IN VARCHAR2,
                                       P_FEC_INICIO IN DATE,
                                       P_REM_CONV   IN VARCHAR2,
                                       P_FEC_FIN    IN DATE,
                                       P_FORMA_PAGO IN NUMBER,
                                       P_CON_IPS    IN VARCHAR2,
                                       P_PCON_MTESS IN VARCHAR2,
                                       P_PCON_SUC   IN NUMBER,
                                       P_EST_CIVIL  IN VARCHAR2,
                                       P_CODIGO     IN NUMBER,
                                       P_SOL_NRO    IN NUMBER,
                                       P_HS_ENTRADA IN VARCHAR2,
                                       P_HS_SALIDA  IN VARCHAR2,
                                       P_HS_ENT_SAB IN VARCHAR2,
                                       P_HS_SAL_SAB IN VARCHAR2,
                                       P_ACT_CONT   IN VARCHAR2,
                                       P_KM_MANT    IN NUMBER,
                                       P_PLAZO      IN VARCHAR2,
                                       P_HORARIO    IN VARCHAR2,
                                       P_FECHA_DOC  IN DATE) IS
    V_CON_CODIGO   NUMBER;
    P_ACCION       VARCHAR2(1);
    X_ENTRADA      DATE;
    X_SALIDA       DATE;
    X_ENT_SABADO   DATE;
    X_SAL_SABADO   DATE;
    x_fec_contrato date;
  BEGIN

    if P_FECHA_DOC is null then
      x_fec_contrato := P_FEC_INICIO;
    else
      x_fec_contrato := P_FECHA_DOC;
    end if;

    IF P_CODIGO IS NULL THEN
      P_ACCION := 'N';
    ELSE
      P_ACCION := 'E';
    END IF;

    IF P_LEGAJO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'Debe elegir un empleado');
    END IF;
    IF P_DIRECCION IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'La direccion no puede quedar vacia');
    END IF;
    IF P_AREA IS NULL AND P_EMPRESA = 1 THEN
      RAISE_APPLICATION_ERROR(-20001, 'El area no puede quedar vacia');
    END IF;
    IF P_CARGO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'El cargo no puede quedar vacio');
    END IF;
    IF P_FORMA_PAGO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'La forma de pago no puede ser nulo');
    END IF;
    IF P_PCON_SUC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'La sucursal no puede quedar vacio');
    END IF;
    --------VALIDACIONES
    IF P_EMPRESA = 2 THEN
      IF P_PCON_MTESS IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'El nro MTESS no puede quedar vacio');
      END IF;

      IF P_CON_IPS IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'El nro reg IPS no puede quedar vacio');
      END IF;
    END IF;

    SELECT TO_DATE(TRUNC(SYSDATE) || ' ' ||
                   TO_CHAR(TO_DATE(P_HS_ENTRADA, 'HH24:MI:SS'), 'HH24:MI'),
                   'dd/mm/yyyy HH24:MI'),
           TO_DATE(TRUNC(SYSDATE) || ' ' ||
                   TO_CHAR(TO_DATE(P_HS_SALIDA, 'HH24:MI:SS'), 'HH24:MI'),
                   'dd/mm/yyyy HH24:MI'),
           TO_DATE(TRUNC(SYSDATE) || ' ' ||
                   TO_CHAR(TO_DATE(P_HS_ENT_SAB, 'HH24:MI:SS'), 'HH24:MI'),
                   'dd/mm/yyyy HH24:MI'),
           TO_DATE(TRUNC(SYSDATE) || ' ' ||
                   TO_CHAR(TO_DATE(P_HS_SAL_SAB, 'HH24:MI:SS'), 'HH24:MI'),
                   'dd/mm/yyyy HH24:MI')
      INTO X_ENTRADA, X_SALIDA, X_ENT_SABADO, X_SAL_SABADO
      FROM DUAL;
    GEN_CODIGO_LIBRE('PCON_CODIGO',
                     'PER_CONT_SIN_PROSELC',
                     1,
                     V_CON_CODIGO,
                     'PCON_EMPR',
                     P_EMPRESA);

    IF P_ACCION = 'N' then
      ---NUEVO
      INSERT INTO PER_CONT_SIN_PROSELC
        (PCON_LEGAJO,
         PCON_CI,
         PCON_DIRECCION,
         PCON_OFICIO,
         PCON_AREA,
         PCON_CARGO,
         PCON_TIPO_CONT,
         PCON_FECHA_INICIO,
         PCON_REM_CONV,
         PCON_FECHA_FIN,
         PCON_FORMA_PAGO,
         PCON_IPS,
         PCON_MTESS,
         PCON_SUC,
         PCON_CODIGO,
         PCON_EMPR,
         PCON_EST_CIVIL,
         PCON_SOL_NRO,
         PCON_HS_ENT,
         PCON_HS_SAL,
         PCON_HS_ENT_SAB,
         PCON_HS_SAL_SAB,
         PCON_ACTUALIZACION,
         PCON_KM_MANT,
         PCON_PLAZO,
         PCON_HORARIO,
         pcon_fec_contrato)
      VALUES
        (P_LEGAJO,
         P_CI,
         P_DIRECCION,
         P_OFI_COD,
         P_AREA,
         P_CARGO,
         P_TIPO_CONT,
         P_FEC_INICIO,
         P_REM_CONV,
         P_FEC_FIN,
         P_FORMA_PAGO,
         P_CON_IPS,
         P_PCON_MTESS,
         P_PCON_SUC,
         V_CON_CODIGO,
         P_EMPRESA,
         P_EST_CIVIL,
         P_SOL_NRO,
         X_ENTRADA,
         X_SALIDA,
         X_ENT_SABADO,
         X_SAL_SABADO,
         P_ACT_CONT,
         P_KM_MANT,
         P_PLAZO,
         P_HORARIO,
         x_fec_contrato);
    END IF;

    IF P_ACCION = 'E' then
      ---EDITAR
      UPDATE PER_CONT_SIN_PROSELC
         SET PCON_LEGAJO       = P_LEGAJO,
             PCON_CI           = P_CI,
             PCON_DIRECCION    = P_DIRECCION,
             PCON_OFICIO       = P_OFI_COD,
             PCON_AREA         = P_AREA,
             PCON_CARGO        = P_CARGO,
             PCON_TIPO_CONT    = P_TIPO_CONT,
             PCON_FECHA_INICIO = P_FEC_INICIO,
             PCON_REM_CONV     = P_REM_CONV,
             PCON_FECHA_FIN    = P_FEC_FIN,
             PCON_FORMA_PAGO   = P_FORMA_PAGO,
             PCON_IPS          = P_CON_IPS,
             PCON_MTESS        = P_PCON_MTESS,
             PCON_SUC          = P_PCON_SUC,
             PCON_EST_CIVIL    = P_EST_CIVIL,
             PCON_SOL_NRO      = P_SOL_NRO,
             PCON_HS_ENT       = X_ENTRADA,
             PCON_HS_SAL       = X_SALIDA,
             PCON_HS_ENT_SAB   = X_ENT_SABADO,
             PCON_HS_SAL_SAB   = X_SAL_SABADO,
             PCON_KM_MANT      = P_KM_MANT,
             PCON_PLAZO        = P_PLAZO,
             PCON_HORARIO      = P_HORARIO,
             pcon_fec_contrato = x_fec_contrato
       WHERE PCON_CODIGO = P_CODIGO
         AND PCON_EMPR = P_EMPRESA;

    END IF;

  END PP_INSERTAR_RECONTRATACION;

  PROCEDURE PP_ELIMINAR_REG_RECONTRATO(P_EMPRESA IN NUMBER,
                                       P_CODIGO  IN NUMBER) IS
  BEGIN
    DELETE PER_CONT_SIN_PROSELC
     WHERE PCON_CODIGO = P_CODIGO
       AND PCON_EMPR = P_EMPRESA;

  END PP_ELIMINAR_REG_RECONTRATO;

  PROCEDURE PP_BUSCAR_DATOS_MTESS(P_EMPRESA        IN NUMBER,
                                  P_FICHA          IN VARCHAR2,
                                  P_EMPL_LEGAJO    IN NUMBER,
                                  P_POST_CODIGO    IN NUMBER,
                                  P_EMPL_NOMBRE    OUT VARCHAR2,
                                  P_EMPL_EDAD      OUT VARCHAR2,
                                  P_EMPL_SEXO      OUT VARCHAR2,
                                  P_EMPL_EST_CIVIL OUT VARCHAR2,
                                  P_EMPL_OFICIO    OUT VARCHAR2,
                                  P_EMPL_CARGO     OUT NUMBER,
                                  P_EMPL_AREA      OUT NUMBER,
                                  P_EMPL_NAC       OUT VARCHAR2,
                                  P_FEC_INGRESO    OUT DATE,
                                  P_EMPL_DOMICILIO OUT VARCHAR2,
                                  P_TIPO_REM       OUT VARCHAR2,
                                  P_REMUNERACION   OUT VARCHAR2) IS

  BEGIN

    -------------------------------si estira los datos de la ficha del postulante

    IF P_FICHA = 'P' THEN

      SELECT PO.DOCPOS_NOMBRE || ' ' || PO.DOCPOS_APELLIDO,
             TRUNC(MONTHS_BETWEEN(TO_CHAR(SYSDATE, 'DD/MM/YYYY'),
                                  TO_CHAR(PO.DOCPOS_FECHA_NAC, 'DD/MM/YYYY')) / 12) EDAD,
             PO.DOCPOS_SEXO,
             PO.DOCPOS_ESTADO_CIV,
             PO.DOCPOS_PROF,
             NULL,
             NULL,
             PO.DOCPOS_NACI,
             NULL,
             PO.DOCPOS_DOMICILIO
        INTO P_EMPL_NOMBRE,
             P_EMPL_EDAD,
             P_EMPL_SEXO,
             P_EMPL_EST_CIVIL,
             P_EMPL_OFICIO,
             P_EMPL_CARGO,
             P_EMPL_AREA,
             P_EMPL_NAC,
             P_FEC_INGRESO,
             P_EMPL_DOMICILIO
        FROM PER_POSTULANTE_CARGO PO
       WHERE PO.DOCPOS_CLAVE = P_POST_CODIGO
         AND PO.DOCPOS_EMPR = P_EMPRESA;
    ELSE
      SELECT EMPL_NOMBRE || ' ' || EMPL_APE NOMBRE,
             TRUNC((SYSDATE - A.EMPL_FEC_NAC) / 365) EDAD,
             EMPL_SEXO,
             EMPL_EST_CIVIL,
             A.EMPL_PROF,
             nvl(A.EMPL_AREA_ORGANI,3),
             nvl(A.EMPL_CARGO,1),
             A.EMPL_NACIONALIDAD,
             A.EMPL_FEC_INGRESO,
             A.EMPL_DIR,
             DECODE(A.EMPL_FORMA_PAGO, 2, 'A', 1, 'B', NULL) REMN,
             REPLACE(TO_CHAR(DECODE(A.EMPL_FORMA_PAGO,
                                    2,
                                    A.EMPL_SALARIO_BASE,
                                    1,
                                    A.EMPL_IMP_HORA_N_D * 8,
                                    NULL),
                             '999G999G999G999G999'),
                     ' ',
                     NULL) SALARIO
        INTO P_EMPL_NOMBRE,
             P_EMPL_EDAD,
             P_EMPL_SEXO,
             P_EMPL_EST_CIVIL,
             P_EMPL_OFICIO,
             P_EMPL_AREA,
             P_EMPL_CARGO,
             P_EMPL_NAC,
             P_FEC_INGRESO,
             P_EMPL_DOMICILIO,
             P_TIPO_REM,
             P_REMUNERACION
        FROM PER_EMPLEADO A
       WHERE EMPL_EMPRESA = P_EMPRESA
         AND EMPL_LEGAJO = P_EMPL_LEGAJO;

    END IF;

  END PP_BUSCAR_DATOS_MTESS;

  PROCEDURE PP_BUSCAR_PROFESION(P_EMPRESA   IN NUMBER,
                                P_PROF_COD  IN NUMBER,
                                P_PROF_DESC OUT VARCHAR2) IS

  BEGIN

    SELECT PROF_DESC
      INTO P_PROF_DESC
      FROM GEN_PROFESION
     WHERE PROF_EMPR = P_EMPRESA
       AND PROF_CODIGO = P_PROF_COD;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      P_PROF_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'La profesion no existe');

  END PP_BUSCAR_PROFESION;

  PROCEDURE PP_BUSCAR_AREA(P_EMPRESA   IN NUMBER,
                           P_AREA_COD  IN NUMBER,
                           P_AREA_DESC OUT VARCHAR2) IS

  BEGIN
    SELECT INITCAP(D.AREDPP_DESC)
      INTO P_AREA_DESC
      FROM PER_AREA_DPP D
     WHERE AREDPP_EMPR = P_EMPRESA
       AND AREDPP_CLAVE = P_AREA_COD;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      P_AREA_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'El area no existe');

  END PP_BUSCAR_AREA;

  PROCEDURE PP_BUSCAR_CARGO(P_EMPRESA    IN NUMBER,
                            P_CARGO_COD  IN NUMBER,
                            P_CARGO_DESC OUT VARCHAR2,
                            P_AREA_DESC  IN VARCHAR2,
                            P_PRI_1      OUT VARCHAR2,
                            P_PRI_2      OUT VARCHAR2) IS

  BEGIN
    SELECT INITCAP(CAR_DESC)
      INTO P_CARGO_DESC
      FROM PER_CARGO
     WHERE CAR_EMPR = P_EMPRESA
       AND CAR_CODIGO = P_CARGO_COD;

    P_PRI_1 := 'Contratado como empleado en el area ' || P_AREA_DESC ||
               ', en la funcion ' || P_CARGO_DESC;
    P_PRI_2 := 'En el domicilio legal de la Empresa';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      P_CARGO_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'El cargo no existe');

  END PP_BUSCAR_CARGO;

  PROCEDURE PP_BUSCAR_NACIONALIDAD(P_EMPRESA  IN NUMBER,
                                   P_NAC_COD  IN NUMBER,
                                   P_NAC_DESC OUT VARCHAR2) IS

  BEGIN

    SELECT INITCAP(A.PAIS_NACIONALIDAD)
      INTO P_NAC_DESC
      FROM GEN_PAIS A
     WHERE PAIS_EMPR = P_EMPRESA
       AND PAIS_CODIGO = P_NAC_COD;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      P_NAC_DESC := NULL;
      -- RAISE_APPLICATION_ERROR (-20001, 'La nacionalidad no existe');

  END PP_BUSCAR_NACIONALIDAD;

  PROCEDURE PP_ACTUALIZAR_MTESS(P_EMPRESA   IN NUMBER,
                                P_OPERACION IN VARCHAR2,
                                P_CONT      IN PER_CONTRATO_MTESS%ROWTYPE) IS

    V_SEQ_PER_CONTRATO   NUMBER;
    V_DIAS               VARCHAR2(100);
    V_MES                VARCHAR2(100);
    V_ANHO               VARCHAR2(100);
    V_EMPL_DIS           VARCHAR2(100);
    V_EST_CIVIL          VARCHAR2(200);
    V_CONT_CIUDAD        VARCHAR2(100);
    V_CONT_REP_DIST      VARCHAR2(100);
    V_CONT_REP_NOMBRE    VARCHAR2(100);
    V_CONT_REP_DOMICILIO VARCHAR2(100);
    V_CONT_REP_EDAD      VARCHAR2(100);
    V_CONT_REP_SEXO      VARCHAR2(100);
    V_CONT_REP_EST_CIVIL VARCHAR2(100);
    V_CONT_REP_OFICIO    VARCHAR2(100);
    V_CONT_REP_NAC       VARCHAR2(100);
    V_CONT_EMPR_DESC     VARCHAR2(100);
    V_DESC_EMPRESA       VARCHAR2(100);
  BEGIN
    ---- raise_application_error(-20001,'lkajsdflkjasdflkjasdk?fljlksdfj');

    V_DIAS := ' ' ||
              LOWER(GENERAL.FP_CONV_NRO_TXT(TO_NUMBER(TO_CHAR(TO_DATE(P_CONT.CONT_EMPL_INGRESO),
                                                              'DD'))));
    V_MES  := TO_CHAR(TO_DATE(P_CONT.CONT_EMPL_INGRESO), 'month');
    V_ANHO := LOWER(GENERAL.FP_CONV_NRO_TXT(TO_NUMBER(TO_CHAR(TO_DATE(P_CONT.CONT_EMPL_INGRESO),
                                                              'YY'))));
    ----  raise_application_error(-20001,V_ANHO||' '||V_DIAS||' '||V_MES);
    IF P_CONT.CONT_EMPL_SEXO = 'M' THEN
      V_EMPL_DIS := 'el sr.';
    ELSE
      V_EMPL_DIS := 'la sra.';
    END IF;
    -- V_CONT_EMPR_DESC := 'HILAGRO S.A.';
    SELECT PC.CONF_CONT_GEREN_DIR, --PC.CONF_CONT_DIREC,
           'el sr.',
           PC.CONF_CONT_GEREN_GEN,
           PC.CONF_CONT_GEREN_DIR,
           --50,
           'masculino',
           'casado',
           'EMPLEADO',
           'paraguaya'
      into V_CONT_CIUDAD,
           V_CONT_REP_DIST,
           V_CONT_REP_NOMBRE,
           V_CONT_REP_DOMICILIO,
           ---    V_CONT_REP_EDAD,
           V_CONT_REP_SEXO,
           V_CONT_REP_EST_CIVIL,
           V_CONT_REP_OFICIO,
           V_CONT_REP_NAC
      FROM PER_CONFIGURACION PC
     WHERE PC.CONF_EMPR = P_EMPRESA;

   -- raise_application_error(-20001,'lkajsdflkjasdflkjasdk?fljlksdfj');
    IF P_EMPRESA = 1 THEN
      SELECT TRUNC((TRUNC(SYSDATE) - A.EMPL_FEC_NAC) / 365) EDAD
        INTO V_CONT_REP_EDAD
        FROM PER_EMPLEADO A
       WHERE EMPL_SITUACION in ('A')
         AND EMPL_EMPRESA = 1
         AND EMPL_CARGO = 151;
    ELSE
      SELECT TRUNC((to_date(SYSDATE) - A.EMPL_FEC_NAC) / 365) EDAD
        INTO V_CONT_REP_EDAD
        FROM PER_EMPLEADO A
       WHERE EMPL_SITUACION in ('A')
         AND EMPL_EMPRESA = 2-- 1
         AND EMPL_CARGO = 134; --  AND EMPL_CARGO = 9;
--raise_application_error(-20001,'lkajsdflkjasdflkjasdk?fljlksdfj');
    END IF;

    SELECT E.EMPR_RAZON_SOCIAL
      INTO V_DESC_EMPRESA
      FROM GEN_EMPRESA E
     WHERE E.EMPR_CODIGO = P_EMPRESA;
/*raise_application_error(-20001,P_CONT.CONT_QUI_A||'*'||
         P_CONT.CONT_QUI_B||'*'||
         P_CONT.CONT_QUI_C||'*'||
         P_CONT.CONT_QUI_A1||'*'||
         P_CONT.CONT_QUI_B1||'*'||
         P_CONT.CONT_QUI_C1||'*'||
         P_CONT.CONT_QUI_A2);*/
    IF P_OPERACION = 'INSERT' THEN
      --   raise_application_error(-20001,'lkajsdflkjasdflkjasdk?fljlksdfj');
      SELECT SEQ_PER_CONTRATO.NEXTVAL INTO V_SEQ_PER_CONTRATO FROM DUAL;

      INSERT INTO PER_CONTRATO_MTESS
        (CONT_CIUDAD,
         CONT_DIAS,
         CONT_MES,
         CONT_ANHO,
         CONT_REP_DIST,
         CONT_REP_NOMBRE,
         CONT_EMPR_DESC,
         CONT_REP_EDAD,
         CONT_REP_SEXO,
         CONT_REP_EST_CIVIL,
         CONT_REP_OFICIO,
         CONT_REP_NAC,
         CONT_REP_DOMICILIO,
         CONT_EMPL_DIST,
         CONT_EMPL_NOMBRE,
         CONT_EMPL_EDAD,
         CONT_EMPL_SEXO,
         CONT_EMPL_EST_CIVIL,
         CONT_EMPL_OFICIO,
         CONT_EMPL_NAC,
         CONT_EMPL_DOMICILIO,
         CONT_PRIM_SERVICIO,
         CONT_PRIM_LUGAR,
         CONT_SEG_A,
         CONT_SEG_B,
         CONT_SEG_C,
         CONT_SEG_D,
         CONT_TER_A,
         CONT_TER_B,
         CONT_TER_C,
         CONT_TER_D,
         CONT_CUA_A,
         CONT_CUA_B,
         CONT_CUA_B1,
         CONT_CUA_C,
         CONT_QUI_A,
         CONT_QUI_B,
         CONT_QUI_C,
         CONT_QUI_A1,
         CONT_QUI_B1,
         CONT_QUI_C1,
         CONT_QUI_A2,
         CONT_SEXT_A,
         CONT_SEXT_B,
         CONT_SEXT_C,
         CONT_SEXT_A1,
         CONT_SEXT_A2,
         CONT_SEXT_B1,
         CONT_SEXT_B2,
         CONT_SEXT_C1,
         CONT_SEXT_C2,
         CONT_SEXT_D1,
         CONT_SEXT_D2,
         CONT_SEXT_E1,
         CONT_SEXT_E2,
         CONT_SEXT_F,
         CONT_SEP_A,
         CONT_SEP_A1,
         CONT_SEP_B,
         CONT_SEP_B1,
         CONT_SEP_C,
         CONT_SEP_C1,
         CONT_OCT_A,
         CONT_OCT_B,
         CONT_NOV_A,
         CONT_NOV_B,
         CONT_NOV_C,
         CONT_FIRM_CONF,
         CONT_OBS,
         CONT_TES_NOMB,
         CONT_TES_EDAD,
         CONT_TES_PROF,
         CONT_TES_DIR,
         CONT_TES_NOMB1,
         CONT_TES_EDAD1,
         CONT_TES_PROF1,
         CONT_TES_DIR1,
         CONT_CLAVE, --------
         CONT_EMPR, ----------
         CONT_TES_NAC,
         CONT_TES_NAC1,
         CONT_COD_POST,
         CONT_COD_EMPL,
         CONT_EMPL_CARGO_COD,
         CONT_EMPL_AREA,
         CONT_EMPL_INGRESO,
         CONT_EMPL_PAIS,
         CONT_EMPL_PROF,
         CONT_SEG_OPCION,
         CONT_TER_OPCION,
         CONT_CUA_OPCION,
         CONT_CARGO,
         CONT_AREA,
         CONT_SEXT_DIV)
      VALUES
        (V_CONT_CIUDAD,
         V_DIAS,
         V_MES,
         V_ANHO,
         V_CONT_REP_DIST,
         V_CONT_REP_NOMBRE,
         V_DESC_EMPRESA,
         V_CONT_REP_EDAD,
         V_CONT_REP_SEXO,
         V_CONT_REP_EST_CIVIL,
         V_CONT_REP_OFICIO,
         V_CONT_REP_NAC,
         V_CONT_REP_DOMICILIO,
         V_EMPL_DIS,
         P_CONT.CONT_EMPL_NOMBRE,
         P_CONT.CONT_EMPL_EDAD,
         P_CONT.CONT_EMPL_SEXO,
         P_CONT.CONT_EMPL_EST_CIVIL,
         P_CONT.CONT_EMPL_OFICIO,
         P_CONT.CONT_EMPL_NAC,
         P_CONT.CONT_EMPL_DOMICILIO,
         P_CONT.CONT_PRIM_SERVICIO,
         P_CONT.CONT_PRIM_LUGAR,
         P_CONT.CONT_SEG_A,
         P_CONT.CONT_SEG_B,
         P_CONT.CONT_SEG_C,
         P_CONT.CONT_SEG_D,
         P_CONT.CONT_TER_A,
         P_CONT.CONT_TER_B,
         P_CONT.CONT_TER_C,
         P_CONT.CONT_TER_D,
         P_CONT.CONT_CUA_A,
         P_CONT.CONT_CUA_B,
         P_CONT.CONT_CUA_B1,
         P_CONT.CONT_CUA_C,
         P_CONT.CONT_QUI_A,
         P_CONT.CONT_QUI_B,
         P_CONT.CONT_QUI_C,
         P_CONT.CONT_QUI_A1,
         P_CONT.CONT_QUI_B1,
         P_CONT.CONT_QUI_C1,
         P_CONT.CONT_QUI_A2,
         P_CONT.CONT_SEXT_A,
         P_CONT.CONT_SEXT_B,
         P_CONT.CONT_SEXT_C,
         P_CONT.CONT_SEXT_A1,
         P_CONT.CONT_SEXT_A2,
         P_CONT.CONT_SEXT_B1,
         P_CONT.CONT_SEXT_B2,
         P_CONT.CONT_SEXT_C1,
         P_CONT.CONT_SEXT_C2,
         P_CONT.CONT_SEXT_D1,
         P_CONT.CONT_SEXT_D2,
         P_CONT.CONT_SEXT_E1,
         P_CONT.CONT_SEXT_E2,
         P_CONT.CONT_SEXT_F,
         P_CONT.CONT_SEP_A,
         P_CONT.CONT_SEP_A1,
         P_CONT.CONT_SEP_B,
         P_CONT.CONT_SEP_B1,
         P_CONT.CONT_SEP_C,
         P_CONT.CONT_SEP_C1,
         P_CONT.CONT_OCT_A,
         P_CONT.CONT_OCT_B,
         P_CONT.CONT_NOV_A,
         P_CONT.CONT_NOV_B,
         P_CONT.CONT_NOV_C,
         P_CONT.CONT_FIRM_CONF,
         P_CONT.CONT_OBS,
         P_CONT.CONT_TES_NOMB,
         P_CONT.CONT_TES_EDAD,
         P_CONT.CONT_TES_PROF,
         P_CONT.CONT_TES_DIR,
         P_CONT.CONT_TES_NOMB1,
         P_CONT.CONT_TES_EDAD1,
         P_CONT.CONT_TES_PROF1,
         P_CONT.CONT_TES_DIR1,
         V_SEQ_PER_CONTRATO, ---
         P_EMPRESA,
         P_CONT.CONT_TES_NAC,
         P_CONT.CONT_TES_NAC1,
         P_CONT.CONT_COD_POST,
         P_CONT.CONT_COD_EMPL,
         P_CONT.CONT_EMPL_CARGO_COD,
         P_CONT.CONT_EMPL_AREA,
         P_CONT.CONT_EMPL_INGRESO,
         P_CONT.CONT_EMPL_PAIS,
         P_CONT.CONT_EMPL_PROF,
         P_CONT.CONT_SEG_OPCION,
         P_CONT.CONT_TER_OPCION,
         P_CONT.CONT_CUA_OPCION,
         P_CONT.CONT_CARGO,
         P_CONT.CONT_AREA,
         P_CONT.CONT_SEXT_DIV);

    ELSIF P_OPERACION = 'UPDATE' THEN
      UPDATE PER_CONTRATO_MTESS
         SET CONT_CIUDAD         = P_CONT.CONT_CIUDAD,
             CONT_DIAS           = V_DIAS, -- P_CONT.CONT_DIAS,
             CONT_MES            = V_MES, --P_CONT.CONT_MES,
             CONT_ANHO           = V_ANHO, ---P_CONT.CONT_ANHO,
             CONT_EMPL_DIST      = P_CONT.CONT_EMPL_DIST,
             CONT_EMPL_NOMBRE    = P_CONT.CONT_EMPL_NOMBRE,
             CONT_EMPL_EDAD      = P_CONT.CONT_EMPL_EDAD,
             CONT_EMPL_SEXO      = P_CONT.CONT_EMPL_SEXO,
             CONT_EMPL_EST_CIVIL = P_CONT.CONT_EMPL_EST_CIVIL,
             CONT_EMPL_OFICIO    = P_CONT.CONT_EMPL_OFICIO,
             CONT_EMPL_NAC       = P_CONT.CONT_EMPL_NAC,
             CONT_EMPL_DOMICILIO = P_CONT.CONT_EMPL_DOMICILIO,
             CONT_PRIM_SERVICIO  = P_CONT.CONT_PRIM_SERVICIO,
             CONT_PRIM_LUGAR     = P_CONT.CONT_PRIM_LUGAR,
             CONT_SEG_A          = P_CONT.CONT_SEG_A,
             CONT_SEG_B          = P_CONT.CONT_SEG_B,
             CONT_SEG_C          = P_CONT.CONT_SEG_C,
             CONT_SEG_D          = P_CONT.CONT_SEG_D,
             CONT_TER_A          = P_CONT.CONT_TER_A,
             CONT_TER_B          = P_CONT.CONT_TER_B,
             CONT_TER_C          = P_CONT.CONT_TER_C,
             CONT_TER_D          = P_CONT.CONT_TER_D,
             CONT_CUA_A          = P_CONT.CONT_CUA_A,
             CONT_CUA_B          = P_CONT.CONT_CUA_B,
             CONT_CUA_B1         = P_CONT.CONT_CUA_B1,
             CONT_CUA_C          = P_CONT.CONT_CUA_C,
             CONT_QUI_A          = P_CONT.CONT_QUI_A,
             CONT_QUI_B          = P_CONT.CONT_QUI_B,
             CONT_QUI_C          = P_CONT.CONT_QUI_C,
             CONT_QUI_A1         = P_CONT.CONT_QUI_A1,
             CONT_QUI_B1         = P_CONT.CONT_QUI_B1,
             CONT_QUI_C1         = P_CONT.CONT_QUI_C1,
             CONT_QUI_A2         = P_CONT.CONT_QUI_A2,
             CONT_SEXT_A         = P_CONT.CONT_SEXT_A,
             CONT_SEXT_B         = P_CONT.CONT_SEXT_B,
             CONT_SEXT_C         = P_CONT.CONT_SEXT_C,
             CONT_SEXT_A1        = P_CONT.CONT_SEXT_A1,
             CONT_SEXT_A2        = P_CONT.CONT_SEXT_A2,
             CONT_SEXT_B1        = P_CONT.CONT_SEXT_B1,
             CONT_SEXT_B2        = P_CONT.CONT_SEXT_B2,
             CONT_SEXT_C1        = P_CONT.CONT_SEXT_C1,
             CONT_SEXT_C2        = P_CONT.CONT_SEXT_C2,
             CONT_SEXT_D1        = P_CONT.CONT_SEXT_D1,
             CONT_SEXT_D2        = P_CONT.CONT_SEXT_D2,
             CONT_SEXT_E1        = P_CONT.CONT_SEXT_E1,
             CONT_SEXT_E2        = P_CONT.CONT_SEXT_E2,
             CONT_SEXT_F         = P_CONT.CONT_SEXT_F,
             CONT_SEP_A          = P_CONT.CONT_SEP_A,
             CONT_SEP_A1         = P_CONT.CONT_SEP_A1,
             CONT_SEP_B          = P_CONT.CONT_SEP_B,
             CONT_SEP_B1         = P_CONT.CONT_SEP_B1,
             CONT_SEP_C          = P_CONT.CONT_SEP_C,
             CONT_SEP_C1         = P_CONT.CONT_SEP_C1,
             CONT_OCT_A          = P_CONT.CONT_OCT_A,
             CONT_OCT_B          = P_CONT.CONT_OCT_B,
             CONT_NOV_A          = P_CONT.CONT_NOV_A,
             CONT_NOV_B          = P_CONT.CONT_NOV_B,
             CONT_NOV_C          = P_CONT.CONT_NOV_C,
             CONT_FIRM_CONF      = P_CONT.CONT_FIRM_CONF,
             CONT_OBS            = P_CONT.CONT_OBS,
             CONT_TES_NOMB       = P_CONT.CONT_TES_NOMB,
             CONT_TES_EDAD       = P_CONT.CONT_TES_EDAD,
             CONT_TES_PROF       = P_CONT.CONT_TES_PROF,
             CONT_TES_DIR        = P_CONT.CONT_TES_DIR,
             CONT_TES_NOMB1      = P_CONT.CONT_TES_NOMB1,
             CONT_TES_EDAD1      = P_CONT.CONT_TES_EDAD1,
             CONT_TES_PROF1      = P_CONT.CONT_TES_PROF1,
             CONT_TES_DIR1       = P_CONT.CONT_TES_DIR1,
             CONT_TES_NAC        = P_CONT.CONT_TES_NAC,
             CONT_TES_NAC1       = P_CONT.CONT_TES_NAC1,
             CONT_COD_POST       = P_CONT.CONT_COD_POST,
             CONT_COD_EMPL       = P_CONT.CONT_COD_EMPL,
             CONT_EMPL_CARGO_COD = P_CONT.CONT_EMPL_CARGO_COD,
             CONT_EMPL_AREA      = P_CONT.CONT_EMPL_AREA,
             CONT_EMPL_INGRESO   = P_CONT.CONT_EMPL_INGRESO,
             CONT_EMPL_PAIS      = P_CONT.CONT_EMPL_PAIS,
             CONT_EMPL_PROF      = P_CONT.CONT_EMPL_PROF,
             CONT_SEG_OPCION     = P_CONT.CONT_SEG_OPCION,
             CONT_TER_OPCION     = P_CONT.CONT_TER_OPCION,
             CONT_CUA_OPCION     = P_CONT.CONT_CUA_OPCION,
             CONT_CARGO          = P_CONT.CONT_CARGO,
             CONT_AREA           = P_CONT.CONT_AREA,
             CONT_SEXT_DIV       = P_CONT.CONT_SEXT_DIV
       WHERE CONT_CLAVE = P_CONT.CONT_CLAVE
         AND CONT_EMPR = P_EMPRESA;

    ELSE
      DELETE PER_CONTRATO_MTESS
       WHERE CONT_CLAVE = P_CONT.CONT_CLAVE
         AND CONT_EMPR = P_EMPRESA;

    END IF;

  END PP_ACTUALIZAR_MTESS;

  PROCEDURE PP_LLAMAR_CONTRATO_MJT(P_EMPRESA    IN NUMBER,
                                   P_CLAVE_CONT IN NUMBER) IS

    V_HTML            VARCHAR2(5000) := '';
    V_CIUDAD          VARCHAR2(20);
    V_MES             VARCHAR2(20);
    V_DIA             VARCHAR2(2);
    V_ANIO            VARCHAR2(4);
    V_DESC_EMPLEADO   VARCHAR2(500);
    V_CONT_REP_NOMBRE VARCHAR2(500);
    V_CON_FEC_NAC     DATE;
    v_anos            NUMBER := 0;
    v_cont_cod_empl   varchar2(20);
    V_COD_LOC         VARCHAR(10);
    V_DESC_LOC        VARCHAR2(50);
    V_DESC_EMPRESA    VARCHAR(50);

    --I PER_CONTRATO_MTESS%ROWTYPE;
    V_AMPER      VARCHAR2(2) := '&';
    V_PARAMETROS VARCHAR2(30000);
    V_USER       VARCHAR2(20);
    l_report_name varchar2(50 char);
  BEGIN
    IF P_EMPRESA = co_transagro THEN
      --DATOS DEL REPRESENTANTE
      BEGIN
        SELECT L.EMPL_NOMBRE || ' ' || L.EMPL_APE DESC_NOMBRE, EMPL_FEC_NAC
          INTO V_CONT_REP_NOMBRE, V_CON_FEC_NAC
          FROM PER_EMPLEADO L
         WHERE L.EMPL_EMPRESA = co_transagro
           AND L.EMPL_LEGAJO = 45;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      --CALCULAR EDAD DEL REPRESENTANTE
      BEGIN
        /* Calcula los a?os de diferencia */
        v_anos := FLOOR(MONTHS_BETWEEN(TO_CHAR(SYSDATE, 'DD/MM/YYYY'),
                                       V_CON_FEC_NAC) / 12);
      END;

      else --> diferentes a Tagro:
      
         --DATOS DEL REPRESENTANTE
         -- 21/07/2022 9:33:16 @PabloACespedes \(^-^)/
         -- se_ajusta para el holding que no sea hilagro y transagro
        if P_EMPRESA = co_hilagro then -- hILAGRO
          BEGIN
            SELECT L.EMPL_NOMBRE || ' ' || L.EMPL_APE DESC_NOMBRE, EMPL_FEC_NAC
              INTO V_CONT_REP_NOMBRE, V_CON_FEC_NAC
              FROM PER_EMPLEADO L
             WHERE L.EMPL_EMPRESA = co_hilagro
               AND L.EMPL_LEGAJO = 237; --> este es CHRISTIAN	GOSSEN HIEBERT
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              NULL;
          END;
        else -- > TODO EL HOLDING
          <<get_data_representante>>
          begin
            select p.conf_cont_geren_gen, p.conf_fecha_nac_rep
            into v_cont_rep_nombre, v_con_fec_nac
            from per_configuracion p
            where p.conf_empr= p_empresa;
          exception
            when no_data_found then
              null;
          end get_data_representante;
        end if; --> Fin Busqueda representante
        
        --CALCULAR EDAD DEL REPRESENTANTE
        begin
          v_anos := FLOOR(MONTHS_BETWEEN(TO_CHAR(SYSDATE, 'DD/MM/YYYY'),
                                         V_CON_FEC_NAC) / 12);
        END;
     END IF;

      --DATOS DEL DIA ACTUAL
      BEGIN
        SELECT TO_CHAR(SYSDATE, 'DD') INTO V_DIA FROM DUAL;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;
      --DATOS DEL MES ACTUAL EN FORMATO NOMBRE
      BEGIN
        SELECT TO_CHAR(SYSDATE, 'MONTH') INTO V_MES FROM DUAL;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      --DATOS DEL A?O ACTUAL
      BEGIN
        SELECT TO_CHAR(SYSDATE, 'YYYY') INTO V_ANIO FROM DUAL;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      --COD DEL EMPLEADO

      BEGIN
        select t.cont_cod_empl
          into v_cont_cod_empl
          from PER_CONTRATO_MTESS t
         WHERE t.cont_empr = P_EMPRESA
           and t.cont_clave = P_CLAVE_CONT;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      --DESCRIPCION DEL EMPLEADO

      BEGIN
        SELECT L.EMPL_NOMBRE || ' ' || L.EMPL_APE DESC_EMPL,
               L.EMPL_LOCALIDAD
          INTO V_DESC_EMPLEADO, V_COD_LOC
          FROM PER_EMPLEADO L
         WHERE L.EMPL_EMPRESA = P_EMPRESA
           AND L.EMPL_LEGAJO = v_cont_cod_empl;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

    -- LOCALIDAD(CIUDAD)

      BEGIN
        SELECT G.LOC_DESC
          INTO V_DESC_LOC
          FROM GEN_LOCALIDAD G
         WHERE G.LOC_EMPR = P_EMPRESA
           AND G.LOC_CODIGO = V_COD_LOC;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

    -- EMPRESA DESCRIPCION

      BEGIN
        SELECT EMPR_RAZON_SOCIAL
          INTO V_DESC_EMPRESA
          FROM GEN_EMPRESA L
         WHERE L.EMPR_CODIGO = P_EMPRESA;
      END;

      V_USER := gen_devuelve_user;

      V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_EMPRESA=' ||
                      URL_ENCODE(P_EMPRESA);
      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAVE=' ||
                      URL_ENCODE(P_CLAVE_CONT);
      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_DIA=' ||
                      URL_ENCODE(V_DIA);
      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_MES=' ||
                      URL_ENCODE(V_MES);
      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_ANIO=' ||
                      URL_ENCODE(V_ANIO);
      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_DESC_EMPLEADO=' ||
                      URL_ENCODE(V_DESC_EMPLEADO);
      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CONT_REP_NOMBRE=' ||
                      URL_ENCODE(V_CONT_REP_NOMBRE);

      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CON_FEC_NAC=' ||
                      URL_ENCODE(v_anos);
      V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_DESC_CIU=' ||
                      URL_ENCODE(V_DESC_LOC);
     V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_DESC_EMPRESA=' ||
                      URL_ENCODE(V_DESC_EMPRESA);

      INSERT INTO X (CAMPO1, OTRO) VALUES (V_PARAMETROS, 'ELBC');
      COMMIT;

      DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = V_USER;
      
      -- 21/07/2022 9:52:27 @PabloACespedes \(^-^)/
      -- obtiene el nombre de reporte, distinto para Hilagro TransAgro, se_ajusto para el Holding too
      if p_empresa in (co_hilagro, co_transagro) then
         l_report_name := 'ELBC';
      else
         l_report_name := 'ELBC_HOLDING'; 
      end if;
      
      INSERT INTO GEN_PARAMETROS_REPORT
        (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
      VALUES
        (V_PARAMETROS, V_USER, l_report_name  , 'pdf');
      COMMIT;

  END PP_LLAMAR_CONTRATO_MJT;

END PERI088;
/
