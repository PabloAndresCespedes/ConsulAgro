CREATE OR REPLACE PACKAGE PERC002 AS

  PROCEDURE PP_TRAER_EMPLEADO_REG(V_EMPRESA        IN NUMBER,
                                  V_EMPL_LEG       IN NUMBER,
                                  V_FORMA_PAG_DESC OUT VARCHAR2,
                                  V_IMP_X_DIA      OUT NUMBER,
                                  V_ANTIGUE        OUT VARCHAR2,
                                  V_DIAS_CORRES    OUT NUMBER,
                                  V_DIAS_CAUSAD    OUT NUMBER,
                                  V_DIAS_CONC      OUT NUMBER,
                                  V_DIAS_PEND      OUT NUMBER,
                                  V_PROXIMO_VAC    OUT DATE,
                                  V_TRAER_IMPORTE  IN VARCHAR2 DEFAULT NULL,
                                  V_FECHA_DESV     IN DATE,
                                  V_FEC_INGR       OUT DATE);

  FUNCTION FP_RETORNA_CANT_DIA_HABIL(I_FECHA_INI IN DATE,
                                     I_FECHA_FIN IN DATE,
                                     I_EMPRESA   IN NUMBER) RETURN NUMBER;

  FUNCTION FP_RETORNA_IMPORTE_DIARIO(P_EMPRESA IN NUMBER,
                                     P_LEGAJO  IN NUMBER) RETURN NUMBER;
  FUNCTION FP_RETURN_TABLE_VACACIONES(P_EMPRESA IN NUMBER DEFAULT NULL,
                                      P_LEGAJO  IN NUMBER DEFAULT NULL)
    RETURN T_NESTED_TABLE_VAC_PERC002;

  PROCEDURE PP_RECARGAR_DATOS(P_EMPRESA                IN NUMBER,
                              P_LEGAJO                 IN NUMBER,
                              P_TIPO_DESVINCULACION    IN NUMBER,
                              P_IND_OMISION_PREAVISO   IN VARCHAR2,
                              P_IND_PAGA_OMIS_PREAVISO IN VARCHAR2,
                              P_FECHA_DESVINCULACION   IN DATE,
                              P_CLAVE_IN               IN NUMBER,
                              P_CLAVE_OUT              OUT NUMBER);

  PROCEDURE PP_AGREGAR_DETALLE(P_EMPRESA     IN NUMBER,
                               P_LEGAJO      IN NUMBER,
                               P_CONCEPTO    IN NUMBER,
                               P_IMPORTE     IN NUMBER,
                               P_IMPORTE_IPS IN NUMBER,
                               P_CLAVE       IN NUMBER,
                               P_FECHA       IN DATE,
                               P_AFEC_CAL_AG IN VARCHAR2,
                               P_MONEDA      IN NUMBER,
                               P_TASA        IN NUMBER,
                               P_CAJA_COD    IN NUMBER,
                               P_NRO_DOC     IN NUMBER,
                               P_OBSERV      IN VARCHAR2);

  PROCEDURE PP_ELIMINAR_DETALLE(P_EMPRESA  IN NUMBER,
                                P_CLAVE    IN NUMBER,
                                P_NRO_ITEM IN NUMBER);

  FUNCTION FP_CANT_DIAS_VACACIONES(V_EMPRESA  IN NUMBER,
                                   V_EMPL_LEG IN NUMBER) RETURN NUMBER;

  PROCEDURE PP_LLAMAR_REPORTE(P_EMPRESA IN NUMBER, P_EMPL_COD IN NUMBER, P_CLAVE IN NUMBER);

  FUNCTION FP_TRAER_ANTIGUEDAD(P_EMPRESA              IN NUMBER,
                               P_LEGAJO               IN NUMBER,
                               P_FECHA_DESVINCULACION IN DATE)
    RETURN VARCHAR2;
 PROCEDURE PP_DETALLE_CONCEPTO (P_EMPRESA      IN NUMBER,
                                P_LEGAJO       IN NUMBER,
                                P_FECHA        IN DATE,
                               -- P_FORMA_PAGO   IN NUMBER,
                                P_TIPO_DESVINCULACION    IN NUMBER,
                                P_IND_OMISION_PREAVISO   IN VARCHAR2,
                                P_IND_PAGA_OMIS_PREAVISO IN VARCHAR2,
                                P_CLAVE                  IN OUT NUMBER,
                                P_EXONERAR               IN VARCHAR2,
                                P_FEC_RENUNCIA           IN DATE,
                                P_FEC_REN_HASTA          IN DATE,
                                P_FAC_CALIDAD            IN VARCHAR2,
                                P_CUMPLIO_PRE_AVISO      IN VARCHAR2);


 PROCEDURE PP_DEUDAS_EMPL (P_EMPRESA      IN NUMBER,
                           P_LEGAJO       IN NUMBER,
                           P_COD_CLI      IN NUMBER,
                           P_COD_PROV     IN NUMBER,
                           P_CLAVE        IN NUMBER,
                           P_FECHA        IN DATE);

 PROCEDURE PP_COBRO_CUOTA (P_EMPRESA       IN NUMBER,
                           P_LEGAJO        IN NUMBER,
                           P_PERIODO       IN NUMBER,
                           P_FEC_DOCUMENTO IN DATE,
                           P_NRO_DOC       IN NUMBER,
                           P_BANCO         IN NUMBER,
                           P_MONEDA        IN NUMBER,
                           P_TASA          IN NUMBER,
                           P_SUCURAL       IN NUMBER,
                           P_OBS           IN VARCHAR2,
                           P_CLAVE         IN NUMBER);

 PROCEDURE PP_ELIMINAR_REGISTROS (P_EMPRESA IN  NUMBER,
                                  P_LEGAJO  IN NUMBER,
                                  P_CLAVE   IN NUMBER,
                                  P_TIPO    IN NUMBER,
                                  P_FECHA   IN DATE ,
                                  P_NRO     IN NUMBER,
                                  P_CONCEPTO IN NUMBER);



 PROCEDURE PP_BUSCAR_CONCEPTO (P_EMPRESA IN NUMBER,
                              P_CONCEPTO IN NUMBER,
                              P_CON_DES  OUT VARCHAR2,
                              P_IND_IPS  OUT VARCHAR2,
                              P_TIPO_MOV OUT NUMBER,
                              P_TIPO_MOV_dES OUT VARCHAR2);


PROCEDURE PP_AGUINALDO_MES_ACT (P_EMPRESA IN NUMBER,
                                P_LEGAJO  IN NUMBER,
                                P_CLAVE   IN NUMBER,
                                P_DPTO    IN NUMBER,
                                P_SUC     IN NUMBER,
                                P_FECHA   IN DATE);


 PROCEDURE PP_GUARDAR_RRHH (P_EMPRESA    IN NUMBER,
                           P_LEGAJO     IN NUMBER,
                           P_CLAVE_DES  IN NUMBER,
                           P_FECHA      IN DATE,
                           P_NRO_DOC    IN NUMBER,
                           P_MONEDA     IN NUMBER,
                           P_TASA       IN NUMBER,
                           P_OBS        IN VARCHAR2);


PROCEDURE PP_BORRAR_DATOS (P_EMPRESA IN  NUMBER,
                           P_CLAVE   IN NUMBER,
                           P_ACT     IN VARCHAR2);


PROCEDURE PP_TRANSFERIR_A_FINANZAS (P_EMPRESA       IN NUMBER,
                                    P_LEGAJO        IN NUMBER,
                                    P_PERIODO       IN NUMBER,
                                    P_FEC_DOCUMENTO IN DATE,
                                    P_NRO_DOC       IN NUMBER,
                                    P_BANCO         IN NUMBER,
                                    P_MONEDA        IN NUMBER,
                                    P_TASA          IN NUMBER,
                                    P_SUCURAL       IN NUMBER,
                                    P_OBS           IN VARCHAR2,
                                    P_CLAVE         IN NUMBER,
                                    P_SESSION       IN NUMBER);

PROCEDURE PP_CALCULAR_CANTIDAD_TRA (P_EMPRESA         IN NUMBER,
                                    P_LEGAJO          IN NUMBER,
                                    P_FECHA           IN DATE,
                                    P_ANHOS           OUT NUMBER,
                                    P_MES             OUT NUMBER,
                                    P_DIAS             OUT NUMBER);

 PROCEDURE  PP_DETALLE_CONCEPTO_TRA (P_EMPRESA                         IN NUMBER,
                                     P_LEGAJO                          IN NUMBER,
                                     P_FECHA                           IN DATE,
                                     P_TIPO_DESVINCULACION             IN NUMBER,
                                     P_IND_OMISION_PREAVISO            IN VARCHAR2,
                                     P_IND_PAGA_OMIS_PREAVISO          IN VARCHAR2,
                                     P_CLAVE                           IN OUT NUMBER,
                                     P_EXONERAR                        IN VARCHAR2,
                                     P_FEC_RENUNCIA                    IN DATE,
                                     P_FEC_REN_HASTA                   IN DATE,
                                     P_FAC_CALIDAD                     IN VARCHAR2,
                                     P_RDE_IMP_CERT                    IN VARCHAR2);


PROCEDURE PP_MOSTAR_EN_LIQ (P_EMPRESA IN NUMBER,
                            P_CLAVE   IN NUMBER,
                            P_NRO     IN NUMBER,
                            P_ESTADO  IN VARCHAR2,
                            P_CUOTA   IN VARCHAR2);



PROCEDURE PP_COBRO_CUOTA_TRA(P_EMPRESA       IN NUMBER,
                             P_LEGAJO        IN NUMBER,
                             P_PERIODO       IN NUMBER,
                             P_FEC_DOCUMENTO IN DATE,
                             P_NRO_DOC       IN NUMBER,
                             P_BANCO         IN NUMBER,
                             P_MONEDA        IN NUMBER,
                             P_TASA          IN NUMBER,
                             P_SUCURAL       IN NUMBER,
                             P_OBS           IN VARCHAR2,
                             P_CLAVE         IN NUMBER);
                             
                             
 
PROCEDURE PP_SALARIO_PROMEDIO  (I_EMPRESA            IN NUMBER,
                                I_LEGAJO             IN NUMBER,
                                I_FEC_CORTE          IN DATE,
                                I_TIPO_SALARIO       IN NUMBER,
                                I_FORMA_PAGO         IN NUMBER,
                                O_IMP_DIARIO         OUT NUMBER,
                                O_SAL_PROMEDIO       OUT NUMBER);
                                
                                
PROCEDURE PP_CALCULO_PRE_AVISO (I_ANHOS          IN NUMBER,
                                I_MESES          IN NUMBER,
                                I_DIAS           IN NUMBER,
                                I_IMPORTE        IN NUMBER,
                                O_DIAS           OUT NUMBER,
                                O_IMPORTE        OUT NUMBER);
                                
                                
PROCEDURE PP_CALCULO_INDERNIZACION (I_ANHOS          IN NUMBER,
                                    I_MESES          IN NUMBER,
                                    I_DIAS           IN NUMBER,
                                    I_IMPORTE        IN NUMBER,
                                    O_DIAS           OUT NUMBER,
                                    O_IMPORTE        OUT NUMBER);                                 
                             
END PERC002;
/
CREATE OR REPLACE PACKAGE BODY PERC002 AS
  PROCEDURE PP_TRAER_EMPLEADO_REG(V_EMPRESA        IN NUMBER,
                                  V_EMPL_LEG       IN NUMBER,
                                  V_FORMA_PAG_DESC OUT VARCHAR2,
                                  V_IMP_X_DIA      OUT NUMBER,
                                  V_ANTIGUE        OUT VARCHAR2,
                                  V_DIAS_CORRES    OUT NUMBER,
                                  V_DIAS_CAUSAD    OUT NUMBER,
                                  V_DIAS_CONC      OUT NUMBER,
                                  V_DIAS_PEND      OUT NUMBER,
                                  V_PROXIMO_VAC    OUT DATE,
                                  V_TRAER_IMPORTE  IN VARCHAR2 DEFAULT NULL,
                                  V_FECHA_DESV     IN DATE,
                                  V_FEC_INGR       OUT DATE) IS

    V_FORMA_PAGO          NUMBER;
    V_EMPL_SALARIO_BASE   NUMBER;
    V_EMPL_IMP_HORA_N_D   NUMBER;
    V_FEC_INGRESO         DATE;
    V_FEC_SALIDA          DATE;
    V_SITUACION           VARCHAR2(50);
    V_ANHOS               NUMBER;
    V_VAC_DIAS_VACACIONES NUMBER;
    V_TOTAL_DIAS_VAC      NUMBER;
    V_ANHO                NUMBER;
    V_COUNT_ANHO          NUMBER;
    V_ANHO_INGRESO        NUMBER;
    V_CANT_DIAS_AJUSTE    NUMBER; ---ESTE AJUSTE ES PARA LOS ENTRARON ANTES DEL 2015
    V_IMP_DIARIO_PROM     NUMBER;
    V_TIPO_SALARIO        NUMBER;
    V_DIAS_TRABAJADOS     NUMBER;
    V_EXISTE              NUMBER;

  begin
    IF V_EMPL_LEG IS NOT NULL THEN

      SELECT EMPL_FORMA_PAGO,
             EMPL_SALARIO_BASE,
             EMPL_IMP_HORA_N_D,
             EMPL_FEC_INGRESO,
             EMPL_FEC_SALIDA,
             EMPL_SITUACION,
             EMPL_TIPO_SALARIO
        INTO V_FORMA_PAGO,
             V_EMPL_SALARIO_BASE,
             V_EMPL_IMP_HORA_N_D,
             V_FEC_INGRESO,
             V_FEC_SALIDA,
             V_SITUACION,
             V_TIPO_SALARIO
        FROM PER_EMPLEADO P
       WHERE P.EMPL_LEGAJO = V_EMPL_LEG
         AND P.EMPL_EMPRESA = V_EMPRESA;


         V_FEC_INGR := V_FEC_INGRESO;

     IF V_FORMA_PAGO = 1 THEN
        --JORNALEROS
        V_FORMA_PAG_DESC := 'JORNAL';
       -- V_IMP_X_DIA      := V_EMPL_IMP_HORA_N_D * 8;
      ELSIF V_FORMA_PAGO = 2 THEN
        --MENSUALEROS Y SERVICIOS PERSONALES.
        V_FORMA_PAG_DESC := 'MENSUAL';
       -- V_IMP_X_DIA      := ROUND(NVL(V_EMPL_SALARIO_BASE, 0) / 30);
      ELSE
        --SERVICIOS PERSONALES.
        V_FORMA_PAG_DESC := 'SERVICIOS PERSONALES';
       -- V_IMP_X_DIA      := ROUND(NVL(V_EMPL_SALARIO_BASE, 0) / 30);

      END IF;


       IF  V_EMPRESA  = 2 THEN
       SELECT CASE WHEN V_FORMA_PAGO IN (1) THEN
                                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 26),8)
                              ELSE
                                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 30),8)
                              END IMPORTE_DIARIO
                    INTO V_IMP_X_DIA
                    FROM PERI052_V_T       A,
                         PER_CONFIGURACION B,
                         PER_PERIODO       C,
                         PER_CONCEPTO      D,
                         PER_EMPLEADO      E
                   WHERE A.EMPL_LEGAJO = V_EMPL_LEG
                     AND A.FECHA BETWEEN TO_CHAR(ADD_MONTHS(TRUNC(V_FECHA_DESV,'mm'), -6), 'DD/MM/YYYY') AND
                                         TO_CHAR(ADD_MONTHS(LAST_DAY(V_FECHA_DESV), -1), 'DD/MM/YYYY')
                     AND CONF_EMPR = V_EMPRESA
                     AND B.CONF_PERI_ACT = PERI_CODIGO
                     AND B.CONF_EMPR = PERI_EMPR
                     AND A.COD_CONCEPTO = D.PCON_CLAVE
                     AND B.CONF_EMPR = PCON_EMPR
                     AND D.PCON_IND_IPS = 'S'
                     AND A.EMPL_LEGAJO = E.EMPL_LEGAJO
                     AND CONF_EMPR = E.EMPL_EMPRESA
                     AND  A.FECHA >= CASE WHEN  E.EMPL_FEC_INGRESO <= '03/'|| TO_CHAR(E.EMPL_FEC_INGRESO,'MM/YYYY') THEN
                                                 EMPL_FEC_INGRESO
                                              ELSE
                                                 ADD_MONTHS (EMPL_FEC_INGRESO,1)
                                              END;

      else -- Holding
         SELECT CASE WHEN V_FORMA_PAGO IN (1) THEN
                                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 26),8)
                              ELSE
                                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 30),8)
                              END IMPORTE_DIARIO
                    INTO V_IMP_X_DIA
                    FROM PERI052_V         A,
                         PER_CONFIGURACION B,
                         PER_PERIODO       C,
                         PER_CONCEPTO      D,
                         PER_EMPLEADO      E
                   WHERE A.EMPL_LEGAJO = V_EMPL_LEG
                   -- documentos de los ultimos 6 meses antes de la fecha de desvinculacion
                     AND (A.FECHA BETWEEN TO_CHAR(ADD_MONTHS(TRUNC(V_FECHA_DESV,'mm'), -6), 'DD/MM/YYYY') 
                                  AND
                                  TO_CHAR(ADD_MONTHS(LAST_DAY(V_FECHA_DESV), -1), 'DD/MM/YYYY')
                         )
                     AND B.CONF_EMPR     = V_EMPRESA
                     AND B.CONF_EMPR     = C.PERI_EMPR
                     AND B.CONF_EMPR     = d.pcon_empr
                     and B.conf_empr     = A.EMPL_EMPRESA -- @PabloACespedes 19/07/2022 17.03hs
                     AND B.CONF_PERI_ACT = C.PERI_CODIGO
                     AND A.COD_CONCEPTO  = D.PCON_CLAVE
                     AND D.PCON_IND_IPS  = 'S' -- afecta IPS
                     AND A.EMPL_LEGAJO   = E.EMPL_LEGAJO
                     -- Fecha de documentos (A.FECHA) mayores o iguales a la fecha de ingreso del empleado
                     -- en el caso que sea mayor al 3er dia se_usa 1 mes mas adelantado de la fecha de ingreso
                     -- OJO con los anios bisiestos y demas yerba
                     AND A.FECHA >= CASE WHEN  E.EMPL_FEC_INGRESO <= '03/'|| TO_CHAR(E.EMPL_FEC_INGRESO,'MM/YYYY') THEN
                                                 EMPL_FEC_INGRESO
                                              ELSE
                                                 ADD_MONTHS (E.EMPL_FEC_INGRESO,1)
                                              END;

    
      END IF;

      V_ANTIGUE := PERC002.FP_TRAER_ANTIGUEDAD(P_EMPRESA => v_EMPRESA,
                                                 P_LEGAJO => V_EMPL_LEG,
                                                 P_FECHA_DESVINCULACION =>V_FECHA_DESV);--trunc(sysdate));

      SELECT TRUNC((MONTHS_BETWEEN(TO_DATE(SYSDATE, 'dd/mm/yyyy'),
                                   V_FEC_INGRESO)) / 12)
        INTO V_ANHOS
        FROM DUAL;

      BEGIN

        SELECT VAC_DIAS_VACACIONES
          INTO V_VAC_DIAS_VACACIONES
          FROM PER_CONF_VACACIONES
         WHERE V_ANHOS BETWEEN VAC_ANTIGUEDAD_DESDE AND
               VAC_ANTIGUEDAD_HASTA
           AND VAC_EMPR = V_EMPRESA;

        V_DIAS_CORRES := V_VAC_DIAS_VACACIONES;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          V_DIAS_CORRES := 0;
      END;

      V_TOTAL_DIAS_VAC      := 0;
      V_VAC_DIAS_VACACIONES := 0;

      V_COUNT_ANHO := 0;

      V_ANHO_INGRESO := TO_NUMBER(TO_CHAR(V_FEC_INGRESO, 'yyyy')) + 1;

      FOR V_ANHO IN 1 .. V_ANHOS LOOP
        BEGIN

          V_COUNT_ANHO := V_COUNT_ANHO + 1;
          SELECT NVL(VAC_DIAS_VACACIONES, 0)
            INTO V_VAC_DIAS_VACACIONES
            FROM PER_CONF_VACACIONES
           WHERE V_COUNT_ANHO BETWEEN VAC_ANTIGUEDAD_DESDE AND
                 VAC_ANTIGUEDAD_HASTA
             AND VAC_EMPR = V_EMPRESA;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            V_VAC_DIAS_VACACIONES := 0;
        END;
        V_TOTAL_DIAS_VAC := V_TOTAL_DIAS_VAC + V_VAC_DIAS_VACACIONES;

        IF V_ANHO_INGRESO <= 2015 THEN
          V_CANT_DIAS_AJUSTE := NVL(V_CANT_DIAS_AJUSTE, 0) +
                                NVL(V_VAC_DIAS_VACACIONES, 0);
        END IF;

        V_ANHO_INGRESO := V_ANHO_INGRESO + 1;

      END LOOP;

      V_DIAS_CAUSAD := NVL(V_TOTAL_DIAS_VAC, 0);

      SELECT NVL(SUM(T.VACINT_CANT_DIAS), 0)
        INTO V_DIAS_CONC
        FROM PER_VACACION_REG_INT T
       WHERE T.VACINT_EMPL_LEG = V_EMPL_LEG
         AND T.VACINT_EMPR = V_EMPRESA
         AND T.VACINT_DESDE >= V_FEC_INGRESO;

      IF V_DIAS_CONC > 0 THEN
        V_DIAS_PEND := NVL(V_DIAS_CAUSAD, 0) - (NVL(V_DIAS_CONC, 0));
        IF V_DIAS_PEND < 0 THEN
          V_DIAS_PEND := 0;
        END IF;
      ELSE
        V_DIAS_PEND := NVL(V_DIAS_CAUSAD, 0);
      END IF;

      V_DIAS_PEND := NVL(V_DIAS_PEND, 0);
      V_DIAS_CONC := NVL(V_DIAS_CONC, 0);

    END IF; --> Fin V_EMPL_LEG IS NOT NULL

    IF TO_DATE(TO_CHAR(V_FEC_INGRESO, 'DD/MM') || '/' ||
               TO_CHAR(SYSDATE, 'YYYY'),
               'DD/MM/YYYY') < TO_DATE(SYSDATE, 'DD/MM/YYYY') THEN
      V_PROXIMO_VAC := TO_DATE(TO_CHAR(V_FEC_INGRESO, 'DD/MM') || '/' ||
                               (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) + 1),
                               'dd/mm/yyyy');
    ELSE
      V_PROXIMO_VAC := TO_DATE(TO_CHAR(V_FEC_INGRESO, 'DD/MM') || '/' ||
                               TO_CHAR(SYSDATE, 'YYYY'),
                               'DD/MM/YYYY');
    END IF;

    BEGIN
      SELECT ROUND(ROUND(SUM(IMPORTE) / 6) /
                   DECODE(V_FORMA_PAGO, 1, 26, 30)) IMPORTE_DIARIO
        INTO V_IMP_DIARIO_PROM
        FROM PERC002_V         A,
             PER_CONFIGURACION B,
             PER_PERIODO       C,
             PER_CONCEPTO      D,
             PER_EMPLEADO      E
       WHERE A.EMPL_LEGAJO = V_EMPL_LEG
         AND A.FECHA BETWEEN
             TO_DATE(ADD_MONTHS(C.PERI_FEC_INI, -5), 'DD/MM/YYYY') AND
             C.PERI_FEC_FIN
         AND CONF_EMPR = V_EMPRESA
        AND B.CONF_PERI_ACT = PERI_CODIGO
         AND B.CONF_EMPR = PERI_EMPR
         AND A.COD_CONCEPTO = D.PCON_CLAVE
         AND B.CONF_EMPR = PCON_EMPR
         AND D.PCON_IND_IPS = 'S'
         AND A.EMPL_LEGAJO = E.EMPL_LEGAJO
         AND CONF_EMPR = E.EMPL_EMPRESA;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN

        V_IMP_DIARIO_PROM := 0;

    end;
    
  END PP_TRAER_EMPLEADO_REG;

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

  IF I_FECHA_FIN-   I_FECHA_INI >365 THEN
    RAISE_APPLICAtION_ERROR(-20001,'El rango de fechas es muy elevado, revisa las fechas!');
  END IF;


    V_FEC_MES_AUX := I_FECHA_INI;--ACUMULADOR DE FECHAS PARA SABER CUANTOS MESES SON

    LOOP

      V_CANT_MESES  := NVL(V_CANT_MESES, 0) + 1;

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

  FUNCTION FP_RETORNA_IMPORTE_DIARIO(P_EMPRESA IN NUMBER,
                                     P_LEGAJO  IN NUMBER) RETURN NUMBER AS
    V_FORMA_PAGO          NUMBER;
    V_EMPL_SALARIO_BASE   NUMBER;
    V_EMPL_IMP_HORA_N_D   NUMBER;
    V_FEC_INGRESO         DATE;
    V_FEC_SALIDA          DATE;
    V_SITUACION           VARCHAR2(50);
    V_ANHOS               NUMBER;
    V_VAC_DIAS_VACACIONES NUMBER;
    V_TOTAL_DIAS_VAC      NUMBER;
    V_ANHO                NUMBER;
    V_COUNT_ANHO          NUMBER;
    V_ANHO_INGRESO        NUMBER;
    V_CANT_DIAS_AJUSTE    NUMBER; ---ESTE AJUSTE ES PARA LOS ENTRARON ANTES DEL 2015
    V_IMP_DIARIO_PROM     NUMBER;
    V_TIPO_SALARIO        NUMBER;
    V_FORMA_PAG_DESC      VARCHAR2(100);
    V_IMP_X_DIA           NUMBER;
  BEGIN

    IF P_LEGAJO IS NOT NULL THEN

      SELECT EMPL_FORMA_PAGO,
             EMPL_SALARIO_BASE,
             EMPL_IMP_HORA_N_D,
             EMPL_FEC_INGRESO,
             EMPL_FEC_SALIDA,
             EMPL_SITUACION,
             EMPL_TIPO_SALARIO
        INTO V_FORMA_PAGO,
             V_EMPL_SALARIO_BASE,
             V_EMPL_IMP_HORA_N_D,
             V_FEC_INGRESO,
             V_FEC_SALIDA,
             V_SITUACION,
             V_TIPO_SALARIO
        FROM PER_EMPLEADO P
       WHERE P.EMPL_LEGAJO = P_LEGAJO
         AND P.EMPL_EMPRESA = P_EMPRESA;

      IF V_FORMA_PAGO = 1 THEN
        --JORNALEROS
        V_FORMA_PAG_DESC := 'JORNAL';
        V_IMP_X_DIA      := V_EMPL_IMP_HORA_N_D * 8;
      ELSIF V_FORMA_PAGO = 2 THEN
        --MENSUALEROS Y SERVICIOS PERSONALES.
        V_FORMA_PAG_DESC := 'MENSUAL';
        V_IMP_X_DIA      := ROUND(NVL(V_EMPL_SALARIO_BASE, 0) / 30);
      ELSE
        --SERVICIOS PERSONALES.
        V_FORMA_PAG_DESC := 'SERVICIOS PERSONALES';
        V_IMP_X_DIA      := ROUND(NVL(V_EMPL_SALARIO_BASE, 0) / 30);

      END IF;

      --TODOS LOS QUE SON COMISIONISTAS O MENSUALEROS SE HACE UN PROMEDIO DE 6 MESES
      --IF V_TIPO_SALARIO NOT IN (2, 3--,5
      -- ) THEN

      BEGIN
        SELECT ROUND(ROUND(SUM(IMPORTE) / 6) /
                     DECODE(V_FORMA_PAGO, 1, 26, 30)) IMPORTE_DIARIO
          INTO V_IMP_DIARIO_PROM
          FROM PERP016_V         A,
               PER_CONFIGURACION B,
               PER_PERIODO       C,
               PER_CONCEPTO      D,
               PER_EMPLEADO      E
         WHERE A.EMPL_LEGAJO = P_LEGAJO
           AND A.FECHA BETWEEN
               TO_DATE(ADD_MONTHS(C.PERI_FEC_INI, -5), 'DD/MM/YYYY') AND
               C.PERI_FEC_FIN
           AND CONF_EMPR = P_EMPRESA
          -- AND B.CONF_PERI_SGTE - 1 = PERI_CODIGO
           AND B.CONF_PERI_ACT = PERI_CODIGO
           AND B.CONF_EMPR = PERI_EMPR
           AND A.COD_CONCEPTO = D.PCON_CLAVE
           AND B.CONF_EMPR = PCON_EMPR
           AND D.PCON_IND_IPS = 'S'
           AND A.EMPL_LEGAJO = E.EMPL_LEGAJO
        --   AND CONF_EMPR = E.EMPL_EMPRESA
           ;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN

          V_IMP_DIARIO_PROM := 0;

      END;

      V_IMP_X_DIA := V_IMP_DIARIO_PROM;
      --END IF;

      RETURN V_IMP_X_DIA;
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, 'No se encuentra el Empleado');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20000, 'Error en FP_TRAER_IMPORTE_DIARIO');

  END;

  FUNCTION FP_RETURN_TABLE_VACACIONES(P_EMPRESA IN NUMBER DEFAULT NULL,
                                      P_LEGAJO  IN NUMBER DEFAULT NULL)
    RETURN T_NESTED_TABLE_VAC_PERC002 AS

    V_RET            T_NESTED_TABLE_VAC_PERC002;
    V_EMPRESA        NUMBER;
    V_EMPL_LEG       NUMBER;
    V_FORMA_PAG_DESC VARCHAR2(100);
    V_IMP_X_DIA      NUMBER;
    V_ANTIGUE        VARCHAR2(100);
    V_DIAS_CORRES    NUMBER;
    V_DIAS_CAUSAD    NUMBER;
    V_DIAS_CONC      NUMBER;
    V_DIAS_PEND      NUMBER;
    V_PROXIMO_VAC    DATE;

    CURSOR EMPLEADO IS
      SELECT A.EMPL_LEGAJO,
             EMPL_NOMBRE || ' ' || EMPL_APE EMPLEADO,
             EMPL_EMPRESA
        FROM PER_EMPLEADO A
       WHERE A.EMPL_EMPRESA = P_EMPRESA
            -- AND A.EMPL_SITUACION = 'A'
            --   AND EMPL_SUCURSAL = 1
         AND (EMPL_LEGAJO = P_LEGAJO --OR P_LEGAJO IS NULL
         )
         AND A.EMPL_FEC_INGRESO IS NOT NULL
       ORDER BY 1;

  BEGIN
    V_RET := T_NESTED_TABLE_VAC_PERC002();

    FOR R IN EMPLEADO LOOP

      BEGIN

        /*PERC002.PP_TRAER_EMPLEADO_REG(V_EMPRESA        => R.EMPL_EMPRESA,
                                      V_EMPL_LEG       => R.EMPL_LEGAJO,
                                      V_FORMA_PAG_DESC => V_FORMA_PAG_DESC,
                                      V_IMP_X_DIA      => V_IMP_X_DIA,
                                      V_ANTIGUE        => V_ANTIGUE,
                                      V_DIAS_CORRES    => V_DIAS_CORRES,
                                      V_DIAS_CAUSAD    => V_DIAS_CAUSAD,
                                      V_DIAS_CONC      => V_DIAS_CONC,
                                      V_DIAS_PEND      => V_DIAS_PEND,
                                      V_PROXIMO_VAC    => V_PROXIMO_VAC);*/

        V_RET.EXTEND;
        V_RET(V_RET.COUNT) := T_COL_TABLE_VAC_PERC002(R.EMPL_LEGAJO,
                                                      V_DIAS_CONC,
                                                      V_DIAS_PEND,
                                                      V_ANTIGUE,
                                                      V_DIAS_CAUSAD,
                                                      V_PROXIMO_VAC,
                                                      R.EMPL_EMPRESA,
                                                      R.EMPLEADO,
                                                      V_IMP_X_DIA,
                                                      V_DIAS_CORRES);
      EXCEPTION
        WHEN OTHERS THEN
          NULL;

      END;

    END LOOP;

    RETURN V_RET;
  END;

  PROCEDURE PP_RECARGAR_DATOS(P_EMPRESA                IN NUMBER,
                              P_LEGAJO                 IN NUMBER,
                              P_TIPO_DESVINCULACION    IN NUMBER,
                              P_IND_OMISION_PREAVISO   IN VARCHAR2,
                              P_IND_PAGA_OMIS_PREAVISO IN VARCHAR2,
                              P_FECHA_DESVINCULACION   IN DATE,
                              P_CLAVE_IN               IN NUMBER,
                              P_CLAVE_OUT              OUT NUMBER) IS

    V_CLAVE          NUMBER;
    V_NRO_ITEM       NUMBER;
    V_IMPORTE_SEGURO NUMBER;
    V_TIPO_DBCR      VARCHAR2(1);
    V_ANTIGUEDAD     VARCHAR2(200);

    /*EN EL CASO DE RENUNCIA SE PAGA EL 50% POR LOS DIAS DE PREAVISO, EN EL CASO DE
    QUE LA EMPRESA QUIERA COBRARLE AL FUNCIONARIO*/

    CURSOR DETALLE IS
      SELECT A.LEGAJO,
             A.NOMBRE,
             CASE
               WHEN P_TIPO_DESVINCULACION IN (1) AND COD_CONCEPTO = 25 THEN
                DECODE(P_IND_PAGA_OMIS_PREAVISO,
                       'S',
                       ROUND(A.IMPORTE / 2),
                       0)
               ELSE
                A.IMPORTE
             END IMPORTE,
             A.TIPO,
             A.COD_CONCEPTO,
             A.EMPR,
             A.CONCEPTO,
             PCON_IND_IPS,
             EMPL_FORMA_PAGO,
             CASE
               WHEN PCON_IND_IPS = 'S' AND EMPL_FORMA_PAGO = 5 THEN --LOS APORTAN AMH
                31
               WHEN PCON_IND_IPS = 'S' AND EMPL_FORMA_PAGO <> 5 THEN --TODOS LOS QUE APORTAN IPS
                4
               ELSE
                NULL
             END COD_CONCEPTO_SEGURO,

             CASE
               WHEN PCON_IND_IPS = 'S' AND EMPL_FORMA_PAGO = 5 THEN --LOS APORTAN AMH
                'AMH'
               WHEN PCON_IND_IPS = 'S' AND EMPL_FORMA_PAGO <> 5 THEN --TODOS LOS QUE APORTAN IPS
                'I.P.S. OBRERO'
               ELSE
                NULL
             END TIPO_SEGURO,
             CANT_DIAS
        FROM PERC002_DETALLE_V A, PER_CONCEPTO B, PER_EMPLEADO C
       WHERE A.COD_CONCEPTO = B.PCON_CLAVE(+)
         AND EMPR = PCON_EMPR(+)
         AND A.LEGAJO = EMPL_LEGAJO
         AND A.EMPR = EMPL_EMPRESA
         AND LEGAJO = P_LEGAJO
         AND EMPR = P_EMPRESA
       ORDER BY CONCEPTO;

  BEGIN
    IF P_CLAVE_IN IS NULL THEN
      SELECT SEQ_PERREGDESVFUNCIONARIO.NEXTVAL INTO V_CLAVE FROM DUAL;
    ELSE
      V_CLAVE := P_CLAVE_IN; --REUTILIZAR LA CLAVE SI YA EXISTE
    END IF;
    P_CLAVE_OUT := V_CLAVE; --ASIGNAR CLAVE PARA DEVOLVER

    IF P_LEGAJO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001,'Ingrese el legajo!');
    END IF;

    --1= RENUNCIA
    --2=DESPIDO INJUSTIFICADO
    --3=DESPIDO JUSTIFICADO
    --4=TERMINO DE CONTRATO
    DELETE PER_REGISTRO_DESVINC_EMPL_DET
     WHERE (RDED_CLAVE, RDED_EMPR) IN
           (SELECT A.RDED_CLAVE, A.RDED_EMPR
              FROM PER_REGISTRO_DESVINC_EMPL_DET A,
                   PER_REGISTRO_DESVINC_EMPL     B
             WHERE A.RDED_EMPR = P_EMPRESA
               AND B.RDE_EMPLEADO = P_LEGAJO
               AND A.RDED_CLAVE = B.RDE_CLAVE
               AND A.RDED_EMPR = B.RDE_EMPR);

    DELETE PER_REGISTRO_DESVINC_EMPL
     WHERE RDE_EMPR = P_EMPRESA
       AND RDE_EMPLEADO = P_LEGAJO;

    V_ANTIGUEDAD := FP_TRAER_ANTIGUEDAD(P_EMPRESA,
                                        P_LEGAJO,
                                        P_FECHA_DESVINCULACION);

    INSERT INTO PER_REGISTRO_DESVINC_EMPL
      (RDE_CLAVE,
       RDE_TIPO_DESVINCULACION,
       RDE_EMPLEADO,
       RDE_FECHA,
       RDE_LOGIN,
       RDE_EMPR,
       RDE_FECHA_GRAB,
       RDE_IND_OMISION_PREAVISO,
       RDE_IND_PAGA_OMIS_PREAVISO,
       RDE_ANTIGUEDAD)
    VALUES
      (V_CLAVE,
       P_TIPO_DESVINCULACION,
       P_LEGAJO,
       P_FECHA_DESVINCULACION,
       GEN_DEVUELVE_USER,
       P_EMPRESA,
       SYSDATE,
       P_IND_OMISION_PREAVISO,
       P_IND_PAGA_OMIS_PREAVISO,
       V_ANTIGUEDAD);

    FOR R IN DETALLE LOOP

      IF (R.COD_CONCEPTO = 25 AND P_IND_OMISION_PREAVISO = 'S' AND
         P_IND_PAGA_OMIS_PREAVISO = 'S') OR R.COD_CONCEPTO <> 25 THEN
        --SI SE OMITE EL PREAVISO O SI ES OTRO CONCEPTO

        IF (P_TIPO_DESVINCULACION IN (1, 4) AND R.COD_CONCEPTO = 23) OR
           (P_TIPO_DESVINCULACION IN (4) AND R.COD_CONCEPTO = 6) --NO PAGAR VACACIONES SI ES TERMINO DE CONTRATO
         THEN
          --SI ES RENUNCIA O TERMINO DE CONTRATO NO SE PAGA NADA
          NULL;
        ELSE
          --SOLO INDEMNIZAR SI ES QUE SE DESPIDIO

          V_NRO_ITEM       := NVL(V_NRO_ITEM, 0) + 1;
          V_IMPORTE_SEGURO := 0; --INICIALIZAR EN 0
          /*SI ES (RENUNCIA,DESPIDO JUSTIFICADO) ENTONCES SE HACE PAGA EL 50%
          DEL PREAVISO SI ES DESPIDO INJUSTIFICADO SE PAGA LA TOTALIDAD*/

          IF R.PCON_IND_IPS = 'S' AND R.EMPL_FORMA_PAGO = 5 AND
             R.IMPORTE > 0 THEN
            --LOS QUE APORTAN AMH
            V_IMPORTE_SEGURO := ROUND(R.IMPORTE * 0.05);
          ELSIF R.PCON_IND_IPS = 'S' AND R.EMPL_FORMA_PAGO <> 5 AND
                R.IMPORTE > 0 THEN
            --TODOS LOS QUE APORTAN IPS
            V_IMPORTE_SEGURO := ROUND(R.IMPORTE * 0.09);
          ELSE
            V_IMPORTE_SEGURO := 0;
          END IF;

          IF NVL(R.IMPORTE, 0) > 0 THEN

            INSERT INTO PER_REGISTRO_DESVINC_EMPL_DET
              (RDED_CLAVE,
               RDED_EMPR,
               RDED_CONCEPTO,
               RDED_TIPO,
               RDED_IMPORTE,
               RDED_NRO_ITEM,
               RDED_DESCRIPCION,
               RDED_TIPO_CALCULO,
               RDED_CANT_DIAS)
            VALUES
              (V_CLAVE,
               P_EMPRESA,
               R.COD_CONCEPTO,
               CASE WHEN
               R.COD_CONCEPTO = 25 AND P_TIPO_DESVINCULACION IN (1) THEN --SI ES PREAVISO Y ES UNA RENUNCA ENTONCES EL EMPLEADO PAGA
               DECODE(R.TIPO, 'D', 'C', 'D') ELSE R.TIPO END,
               R.IMPORTE,
               V_NRO_ITEM,
               R.CONCEPTO,
               'A',
               R.CANT_DIAS);

          END IF;

          IF R.PCON_IND_IPS = 'S' AND NVL(V_IMPORTE_SEGURO, 0) > 0 THEN

            V_NRO_ITEM := NVL(V_NRO_ITEM, 0) + 1;

            INSERT INTO PER_REGISTRO_DESVINC_EMPL_DET
              (RDED_CLAVE,
               RDED_EMPR,
               RDED_CONCEPTO,
               RDED_TIPO,
               RDED_IMPORTE,
               RDED_NRO_ITEM,
               RDED_DESCRIPCION,
               RDED_TIPO_CALCULO,
               RDED_NRO_ITEM_PADRE)
            VALUES
              (V_CLAVE,
               P_EMPRESA,
               R.COD_CONCEPTO_SEGURO,
               DECODE(R.TIPO, 'D', 'C', 'D'),
               V_IMPORTE_SEGURO,
               V_NRO_ITEM,
               R.TIPO_SEGURO,
               'A',
               V_NRO_ITEM - 1);

          END IF;

        END IF;
      END IF;

    END LOOP;

    COMMIT;
  EXCEPTION
    WHEN others THEN
     rollback;


   --------------------------------------------***** DETALLE POR CONCEPTO



   /* CONSULTA AGUINALDO
   SELECT
       TO_CHAR(A.PDOC_FEC,'MM/YYYY') MES,
      EMPL_LEGAJO,
       A.PDOC_PERIODO,
       SUM(ROUND(B.PDDET_IMP))
  FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_CONCEPTO C,PER_EMPLEADO E
 WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
   AND A.PDOC_EMPR = B.PDDET_EMPR
   AND B.PDDET_CLAVE_CONCEPTO = C.PCON_CLAVE
   AND B.PDDET_EMPR = C.PCON_EMPR
   AND A.PDOC_EMPLEADO = E.EMPL_LEGAJO
   AND A.PDOC_EMPR = EMPL_EMPRESA
   AND NVL(B.PDDET_CLAVE_FIN,   A.PDOC_CLAVE_FIN) IS NOT NULL
   AND A.PDOC_EMPR =1
   AND C.PCON_IND_AGUINALDO = 'S'
   AND TO_CHAR(A.PDOC_FEC,'YYYY')= '2021'
   AND EMPL_LEGAJO = 104021
GROUP BY   TO_CHAR(A.PDOC_FEC,'MM/YYYY') ,
       EMPL_LEGAJO,
       A.PDOC_PERIODO*/


  ---------------------------------------------------------------* IMPORTE DIARIO
  /*
  BEGIN

  PERI052.FP_TRAER_EMPLEADO_REG(V_EMPRESA => :V_EMPRESA,
                                V_EMPL_LEG => :V_EMPL_LEG,
                                V_FORMA_PAG_DESC => :V_FORMA_PAG_DESC,
                                V_IMP_X_DIA => :V_IMP_X_DIA,
                                V_ANTIGUE => :V_ANTIGUE,
                                V_DIAS_CORRES => :V_DIAS_CORRES,
                                V_DIAS_CAUSAD => :V_DIAS_CAUSAD,
                                V_DIAS_CONC => :V_DIAS_CONC,
                                V_DIAS_PEND => :V_DIAS_PEND,
                                V_DIAS_CAUSAD2 => :V_DIAS_CAUSAD2);
END;




     */



  END;

  PROCEDURE PP_AGREGAR_DETALLE(P_EMPRESA     IN NUMBER,
                               P_LEGAJO      IN NUMBER,
                               P_CONCEPTO    IN NUMBER,
                               P_IMPORTE     IN NUMBER,
                               P_IMPORTE_IPS IN NUMBER,
                               P_CLAVE       IN NUMBER,
                               P_FECHA       IN DATE,
                               P_AFEC_CAL_AG IN VARCHAR2,
                               P_MONEDA      IN NUMBER,
                               P_TASA        IN NUMBER,
                               P_CAJA_COD    IN NUMBER,
                               P_NRO_DOC     IN NUMBER,
                               P_OBSERV      IN VARCHAR2) IS

    V_DESC_CONCEPTO   VARCHAR2(200);
    V_IND_IPS         VARCHAR2(1);
    V_TIPO_DBCR       VARCHAR2(1);
    V_NRO_ITEM        NUMBER;
    V_CONCEPTO_SEGURO NUMBER;
    V_TIPO_SEGURO     VARCHAR2(200);
    V_IMPORTE_SEGURO  NUMBER;
    V_FORMA_PAGO      NUMBER;
    V_DPTO            NUMBER;
    V_SUC             NUMBER;
    V_AGUINALDO       VARCHAR2(1);
    V_TIPO_MOV        NUMBER;
    V_EMPL_PROV        NUMBER;
    V_EMPL_CLIENTE     NUMBER;
    I_PCON_CLAVE_CONCEPTO_FIN  NUMBER;
    I_PCON_CLAVE_CTACO         NUMBER;
    I_FCON_TIPO_SALDO          VARCHAR2(1);
    V_QUINCENA                 NUMBER;
    V_PERIODO                  NUMBER;
    V_DESC_EMPR               VARCHAR2(200);
  BEGIN

--RAISE_APPLICATION_ERROR (-20001, P_LEGAJO);


 IF P_IMPORTE IS NULL or P_IMPORTE  = 0 THEN
    RAISE_APPLICATION_ERROR (-20001, 'El importe no puede quedar vacio o ser igual a cero');
  END IF;

   IF P_CONCEPTO IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'El concepto no puede quedar vacio');
  END IF;

    SELECT PCON_DESC, PCON_IND_IPS, A.PCON_IND_DBCR, A.PCON_IND_AGUINALDO, NVL(A.PCON_FIN_TMOV,0)
      INTO V_DESC_CONCEPTO, V_IND_IPS, V_TIPO_DBCR, V_AGUINALDO,V_TIPO_MOV
      FROM PER_CONCEPTO A
     WHERE PCON_CLAVE = P_CONCEPTO
       AND PCON_EMPR = P_EMPRESA;
    BEGIN
      SELECT NVL(MAX(A.DES_NRO),0)+1
        INTO V_NRO_ITEM
        FROM PER_DESVINCULACION_DETALLE A
       WHERE A.DES_CODIGO = P_CLAVE
         AND A.DES_EMPR = P_EMPRESA
          AND A.DES_TIPO = 30;
    EXCEPTION
      WHEN OTHERS THEN
        V_NRO_ITEM := 0;
    END;

    SELECT EMPL_FORMA_PAGO, EMPL_DEPARTAMENTO, EMPL_SUCURSAL, EMPL_CODIGO_PROV, EMPL_COD_CLIENTE
      INTO V_FORMA_PAGO,V_DPTO, V_SUC,V_EMPL_PROV,V_EMPL_CLIENTE
      FROM PER_EMPLEADO
     WHERE EMPL_EMPRESA = P_EMPRESA
       AND EMPL_LEGAJO = P_LEGAJO;

    IF V_FORMA_PAGO = 5 THEN
      V_CONCEPTO_SEGURO := 31;
      V_TIPO_SEGURO     := 'A.M.H. OBRERO';
      V_IMPORTE_SEGURO  := ROUND(P_IMPORTE * 0.05);
    ELSE
      V_CONCEPTO_SEGURO := 4;
      V_TIPO_SEGURO     := 'I.P.S. OBRERO';
      V_IMPORTE_SEGURO  := ROUND(P_IMPORTE * 0.09);
    END IF;
--RAISE_APPLICATION_ERROR (-20001, P_AFEC_CAL_AG);

   IF V_TIPO_MOV <> 31 THEN
        INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_AFC_AG,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          P_CONCEPTO,
                          V_DESC_CONCEPTO,
                          ROUND(P_IMPORTE),
                          P_CLAVE,
                          30,
                          V_DPTO,
                          V_SUC,
                          P_AFEC_CAL_AG,
                          V_NRO_ITEM);

     IF V_IND_IPS ='S' THEN

                 INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          V_CONCEPTO_SEGURO,
                          V_TIPO_SEGURO,
                          ROUND(V_IMPORTE_SEGURO),
                          P_CLAVE,
                          30,
                          V_DPTO,
                          V_SUC,
                          V_NRO_ITEM);

      END IF;
   END IF;

    ---------------------------------------------*****************

  IF V_TIPO_MOV  = 31 THEN

  IF P_MONEDA IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'La moneda no puede quedar vacia');
  END IF;
   IF P_TASA IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'La tasa no puede quedar vacia');
  END IF;
   IF P_CAJA_COD IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'El banco no puede quedar vacio');
  END IF;
   IF P_NRO_DOC IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'El nro de documento no puede quedar vacio');
  END IF;
   IF P_OBSERV IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'La observacion no puede quedar vacia');
  END IF;

      BEGIN

        SELECT FCON_CLAVE, FCON_CLAVE_CTACO, FCON_TIPO_SALDO
          INTO I_PCON_CLAVE_CONCEPTO_FIN,
               I_PCON_CLAVE_CTACO,
               I_FCON_TIPO_SALDO
          FROM PER_EMPLEADO, PER_DPTO_CONC, FIN_CONCEPTO, PER_CONCEPTO
         WHERE DPTOC_DPTO = EMPL_DEPARTAMENTO
           AND DPTOC_EMPR = EMPL_EMPRESA

           AND DPTOC_FIN_CONC = FCON_CLAVE
           AND DPTOC_EMPR = FCON_EMPR

           AND DPTOC_PER_CONC = PCON_CLAVE
           AND DPTOC_EMPR = PCON_EMPR

           AND DPTOC_PER_CONC = P_CONCEPTO
           AND EMPL_LEGAJO = P_LEGAJO

           AND EMPL_EMPRESA = P_EMPRESA;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN

          RAISE_APPLICATION_ERROR(-20012,
                                  'Falta definir el departamento/concepto para este empleado!');
      END;

          SELECT PERI_CODIGO
          INTO V_PERIODO
          FROM  PER_PERIODO
         WHERE PERI_EMPR= P_EMPRESA
         AND P_FECHA BETWEEN PERI_FEC_INI AND  PERI_FEC_FIN;


    IF TO_CHAR(P_FECHA,'DD') > '15' THEN
        V_QUINCENA:= 2;
    ELSE
        V_QUINCENA:= 1;
    END IF;

      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'PERI005') THEN
        APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'PERI005');
      END IF;
        APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'PERI005');

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'PERI005',
                                 P_N001            => P_LEGAJO,
                                 P_C001            => null,
                                 P_C002            => null,
                                 P_N002            => V_EMPL_PROV,
                                 P_N003            => ROUND(P_IMPORTE),
                                 P_N004            => NULL,
                                 P_C003            => I_PCON_CLAVE_CONCEPTO_FIN,
                                 P_N005            => I_PCON_CLAVE_CTACO,
                                 P_C004            => I_FCON_TIPO_SALDO,
                                 P_C005            => V_DPTO,
                                 P_C006            => V_FORMA_PAGO);

  IF P_EMPRESA = 1 THEN
      V_DESC_EMPR :='HILAGRO S.A.';
    ELSE
      V_DESC_EMPR:='TRANSAGRO S.A.';
  END IF;
     PERI005.PP_ACTUALIZAR_REGISTRO(I_EMPRESA            => P_EMPRESA,
                                    I_DESC_EMPRESA       => V_DESC_EMPR,
                                    I_DOC_CTA_BCO        => P_CAJA_COD,
                                    I_PCON_DESC          => 'ADELANTO',
                                    I_PDOC_FEC           => P_FECHA,
                                    S_TASA_OFIC          => P_TASA,
                                    I_S_TIP_MOV_ADEL_PRO => 31,
                                    I_S_TIPO_MOV         => V_TIPO_MOV,
                                    I_SUCURSAL           => V_SUC,
                                    I_PDOC_NRO_DOC       => P_NRO_DOC,
                                    I_DOC_OBS            => P_OBSERV,
                                    I_PDOC_QUINCENA      => V_QUINCENA,
                                    W_PERIODO            => V_PERIODO,
                                    I_CLAVE_CONCEPTO     => P_CONCEPTO,
                                    I_S_MON              => P_MONEDA,
                                    I_PDOC_FEC_OPER      => P_FECHA, --Para que no cargue la fecha de operaci?n null en fin_documento, porque genera problemas en la hora de la aprobaci?n. 18/05/2021
                                    I_MON_LOC            => 1,
                                    I_CUOTA              => 'S',
                                    I_FEC_VTO_ADELANTO   => NULL);



    BEGIN

        PERC002.PP_DEUDAS_EMPL(P_EMPRESA  => P_EMPRESA,
                               P_LEGAJO   => P_LEGAJO,
                               P_COD_CLI  => V_EMPL_CLIENTE,
                               P_COD_PROV => V_EMPL_PROV,
                               P_CLAVE    => P_CLAVE,
                               P_FECHA    => P_FECHA);
      END;


   END IF;


    ---------------------------------------------------------------

IF V_TIPO_MOV  <> 31 THEN

      PERC002.PP_AGUINALDO_MES_ACT(P_EMPRESA => P_EMPRESA,
                                   P_LEGAJO  => P_LEGAJO,
                                   P_CLAVE   => P_CLAVE,
                                   P_DPTO    => V_DPTO,
                                   P_SUC     => V_SUC,
                                   P_FECHA   => P_FECHA);


END IF;

 /*   V_NRO_ITEM := NVL(V_NRO_ITEM, 0) + 1;

    INSERT INTO PER_REGISTRO_DESVINC_EMPL_DET
      (RDED_CLAVE,
       RDED_EMPR,
       RDED_CONCEPTO,
       RDED_TIPO,
       RDED_IMPORTE,
       RDED_NRO_ITEM,
       RDED_DESCRIPCION,
       RDED_TIPO_CALCULO)
    VALUES
      (P_CLAVE,
       P_EMPRESA,
       P_CONCEPTO,
       V_TIPO_DBCR,
       P_IMPORTE,
       V_NRO_ITEM,
       V_DESC_CONCEPTO,
       'M') -- EL ITEM ANTERIOR ES EL PADRE
    ;

    IF V_IND_IPS = 'S' THEN

      V_NRO_ITEM := NVL(V_NRO_ITEM, 0) + 1;

      INSERT INTO PER_REGISTRO_DESVINC_EMPL_DET
        (RDED_CLAVE,
         RDED_EMPR,
         RDED_CONCEPTO,
         RDED_TIPO,
         RDED_IMPORTE,
         RDED_NRO_ITEM,
         RDED_DESCRIPCION,
         RDED_TIPO_CALCULO,
         RDED_NRO_ITEM_PADRE)
      VALUES
        (P_CLAVE,
         P_EMPRESA,
         V_CONCEPTO_SEGURO,
         DECODE(V_TIPO_DBCR, 'D', 'C', 'D'),
         V_IMPORTE_SEGURO,
         V_NRO_ITEM,
         V_TIPO_SEGURO,
         'M',
         V_NRO_ITEM - 1 --EL ITEM_ANTERIOR ES EL PADRE
         );

    END IF;*/

  END;

  PROCEDURE PP_ELIMINAR_DETALLE(P_EMPRESA  IN NUMBER,
                                P_CLAVE    IN NUMBER,
                                P_NRO_ITEM IN NUMBER
                                ) IS

  BEGIN

    DELETE PER_REGISTRO_DESVINC_EMPL_DET A
     WHERE A.RDED_CLAVE = P_CLAVE
       AND A.RDED_EMPR = P_EMPRESA
       AND (A.RDED_NRO_ITEM = P_NRO_ITEM OR
           A.RDED_NRO_ITEM_PADRE = P_NRO_ITEM);

  END;

  FUNCTION FP_CANT_DIAS_VACACIONES(V_EMPRESA  IN NUMBER,
                                   V_EMPL_LEG IN NUMBER) RETURN NUMBER IS

    V_FORMA_PAGO          NUMBER;
    V_EMPL_SALARIO_BASE   NUMBER;
    V_EMPL_IMP_HORA_N_D   NUMBER;
    V_FEC_INGRESO         DATE;
    V_FEC_SALIDA          DATE;
    V_SITUACION           VARCHAR2(50);
    V_ANHOS               NUMBER;
    V_VAC_DIAS_VACACIONES NUMBER;
    V_TOTAL_DIAS_VAC      NUMBER;
    V_ANHO                NUMBER;
    V_COUNT_ANHO          NUMBER;
    V_ANHO_INGRESO        NUMBER;
    V_CANT_DIAS_AJUSTE    NUMBER; ---ESTE AJUSTE ES PARA LOS ENTRARON ANTES DEL 2015
    V_IMP_DIARIO_PROM     NUMBER;
    V_TIPO_SALARIO        NUMBER;
    V_DIAS_TRABAJADOS     NUMBER;
    V_ANTIGUE             NUMBER;
    V_DIAS_CORRES         NUMBER;
    V_DIAS_CAUSAD         NUMBER;
    V_DIAS_CONC           NUMBER;
    V_DIAS_PEND           NUMBER;
  BEGIN

    IF V_EMPL_LEG IS NOT NULL THEN

      SELECT EMPL_FORMA_PAGO,
             EMPL_SALARIO_BASE,
             EMPL_IMP_HORA_N_D,
             EMPL_FEC_INGRESO,
             EMPL_FEC_SALIDA,
             EMPL_SITUACION,
             EMPL_TIPO_SALARIO
        INTO V_FORMA_PAGO,
             V_EMPL_SALARIO_BASE,
             V_EMPL_IMP_HORA_N_D,
             V_FEC_INGRESO,
             V_FEC_SALIDA,
             V_SITUACION,
             V_TIPO_SALARIO
        FROM PER_EMPLEADO P
       WHERE P.EMPL_LEGAJO = V_EMPL_LEG
         AND P.EMPL_EMPRESA = V_EMPRESA;

      SELECT TRUNC((MONTHS_BETWEEN(TO_DATE(SYSDATE, 'dd/mm/yyyy'),
                                   V_FEC_INGRESO)) / 12)
        INTO V_ANHOS
        FROM DUAL;

      BEGIN

        SELECT VAC_DIAS_VACACIONES
          INTO V_VAC_DIAS_VACACIONES
          FROM PER_CONF_VACACIONES
         WHERE V_ANHOS BETWEEN VAC_ANTIGUEDAD_DESDE AND
               VAC_ANTIGUEDAD_HASTA
           AND VAC_EMPR = V_EMPRESA;

        V_DIAS_CORRES := V_VAC_DIAS_VACACIONES;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          V_DIAS_CORRES := 0;
      END;

      V_TOTAL_DIAS_VAC      := 0;
      V_VAC_DIAS_VACACIONES := 0;

      V_COUNT_ANHO := 0;

      V_ANHO_INGRESO := TO_NUMBER(TO_CHAR(V_FEC_INGRESO, 'yyyy')) + 1;

      FOR V_ANHO IN 1 .. V_ANHOS LOOP
        BEGIN

          V_COUNT_ANHO := V_COUNT_ANHO + 1;
          SELECT NVL(VAC_DIAS_VACACIONES, 0)
            INTO V_VAC_DIAS_VACACIONES
            FROM PER_CONF_VACACIONES
           WHERE V_COUNT_ANHO BETWEEN VAC_ANTIGUEDAD_DESDE AND
                 VAC_ANTIGUEDAD_HASTA
             AND VAC_EMPR = V_EMPRESA;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            V_VAC_DIAS_VACACIONES := 0;
        END;
        V_TOTAL_DIAS_VAC := V_TOTAL_DIAS_VAC + V_VAC_DIAS_VACACIONES;

        V_ANHO_INGRESO := V_ANHO_INGRESO + 1;

      END LOOP;

      V_DIAS_CAUSAD := NVL(V_TOTAL_DIAS_VAC, 0);

      SELECT NVL(SUM(T.VACINT_CANT_DIAS), 0)
        INTO V_DIAS_CONC
        FROM PER_VACACION_REG_INT T
       WHERE T.VACINT_EMPL_LEG = V_EMPL_LEG
         AND T.VACINT_EMPR = V_EMPRESA
         AND T.VACINT_DESDE >= V_FEC_INGRESO;

      IF V_DIAS_CONC > 0 THEN
        V_DIAS_PEND := NVL(V_DIAS_CAUSAD, 0) - (NVL(V_DIAS_CONC, 0));
        IF V_DIAS_PEND < 0 THEN
          V_DIAS_PEND := 0;
        END IF;
      ELSE
        V_DIAS_PEND := NVL(V_DIAS_CAUSAD, 0);
      END IF;

      V_DIAS_PEND := NVL(V_DIAS_PEND, 0);
      V_DIAS_CONC := NVL(V_DIAS_CONC, 0);

    END IF;

    RETURN V_DIAS_PEND;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

  PROCEDURE PP_LLAMAR_REPORTE(P_EMPRESA IN NUMBER, P_EMPL_COD IN NUMBER, P_CLAVE IN NUMBER) IS
    V_PARAMETROS    VARCHAR2(600);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    V_REPORT        VARCHAR2(15);
    V_USUARIO       VARCHAR2(100);
    V_EMPR_DESC     VARCHAR2(600);


  BEGIN
    V_USUARIO := GEN_DEVUELVE_USER;
    IF P_EMPRESA  = 1 THEN
    V_REPORT  := 'PERC002_R';
    ELSE
    V_REPORT  :='PERC002_RT';
    END IF;
    SELECT A.EMPR_RAZON_SOCIAL
      INTO V_EMPR_DESC
      FROM GEN_EMPRESA A
     WHERE A.EMPR_CODIGO = P_EMPRESA;
    /*
    IMPORTANTE TENER EN CUENTA QUE LOS PARAMETROS DEBEN SER ESACTAMENTE IGUALES A COMO ESTA ESCRITO
    EN EL JASPER (MAYUSCULAS Y MINUSCULAS)
    */

    -- CONCATENAR LOS PARAMETROS PARA LLAMAR EL REPORTE EN JASPER
    V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    (P_EMPRESA);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESC_EMPRESA=' ||
                    APEX_UTIL.URL_ENCODE(V_EMPR_DESC);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_PROGRAMA=' ||
                    APEX_UTIL.URL_ENCODE('PERC002');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESC_PROGRAMA=' ||
                    APEX_UTIL.URL_ENCODE('LIQUIDACION DE FUNCIONARIOS');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPLEADO=' ||
                    (P_EMPL_COD);
     V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                    (P_CLAVE);

     V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                    (P_CLAVE);

  
  


    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = V_USUARIO;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, V_USUARIO, V_REPORT, 'pdf');
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END PP_LLAMAR_REPORTE;

  FUNCTION FP_TRAER_ANTIGUEDAD(P_EMPRESA              IN NUMBER,
                               P_LEGAJO               IN NUMBER,
                               P_FECHA_DESVINCULACION IN DATE)
    RETURN VARCHAR2 IS

    V_ANTIGUEDAD VARCHAR2(200);
  BEGIN
    BEGIN
 IF P_EMPRESA != 2 then -- @PabloACespedes 19/07/2022 17.08hs
 
 if P_LEGAJO =104206 then
   V_ANTIGUEDAD :='1';
   else

            select case when SUBSTR(antiguedad, 1,2) = ' Y' THEN
                REPLACE(antiguedad,' Y ','')
               ELSE
                 antiguedad
         END  antiguedad
         INTO V_ANTIGUEDAD
         from (
              SELECT UPPER(CASE
                             WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       EMPL_FEC_INGRESO) / 12) > 1 THEN
                              TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                   EMPL_FEC_INGRESO) / 12) || ' A'||chr(241)||'os, '
                             WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       EMPL_FEC_INGRESO) / 12) = 1 THEN
                              TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                   EMPL_FEC_INGRESO) / 12) || ' A'||chr(241)||'o, '
                           END || CASE
                             WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                       'DD/MM') || '/' ||
                                                               TO_CHAR(P_FECHA_DESVINCULACION,
                                                                       'YYYY')))) > 1 THEN
                              TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                   TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                   'DD/MM') || '/' ||
                                                           TO_CHAR(P_FECHA_DESVINCULACION,
                                                                   'YYYY')))) || ' meses '

                             WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                       'DD/MM') || '/' ||
                                                               TO_CHAR(P_FECHA_DESVINCULACION,
                                                                       'YYYY')))) = 1 THEN
                              TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                   TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                   'DD/MM') || '/' ||
                                                           TO_CHAR(P_FECHA_DESVINCULACION,
                                                                   'YYYY')))) || ' mes '

                             WHEN (MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                       'DD/MM') || '/' ||
                                                               TO_CHAR(P_FECHA_DESVINCULACION,
                                                                       'YYYY')))) <0 THEN

                              CASE
                                WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                          TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                          'DD/MM') || '/' ||
                                                                  TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                                     -12),
                                                                          'YYYY')))) > 1 THEN

                                 TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                      TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                      'DD/MM') || '/' ||
                                                              TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                                 -12),
                                                                      'YYYY')))) || ' meses'

                                WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                          TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                          'DD/MM') || '/' ||
                                                                  TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                                     -12),
                                                                          'YYYY')))) = 1 THEN

                                 TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                      TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                      'DD/MM') || '/' ||
                                                              TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                                 -12),
                                                                      'YYYY')))) || ' mes'

                              END

                           END || CASE
                             WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                        TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) > 1 THEN

                              ' y ' ||
                              TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                    TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                            TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) ||
                              ' dias '
                             WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                        TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) = 1 THEN
                              ' y ' ||
                              TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                    TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                            TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) ||
                              ' dia'
                             WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                        TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) < 0 THEN

                              CASE
                                WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                           TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                   TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                      -1),
                                                           'MM/YYYY'))) = 1 THEN

                               ' y ' ||  TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                       TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                               TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION, -1),
                                                       'MM/YYYY'))) || ' dia'
                                WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                           TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                   TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                      -1),
                                                           'MM/YYYY'))) > 1 THEN
                               ' y ' ||  TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                       TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                               TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION, -1),
                                                       'MM/YYYY'))) || ' dias'
                              END
                           END

                           ) ANTIGUEDAD

                FROM PER_EMPLEADO A
               WHERE EMPL_LEGAJO = P_LEGAJO
                 AND EMPL_EMPRESA = P_EMPRESA);
   end if;
     ELSE

       select case when SUBSTR(antiguedad,2,1) = 'Y' THEN
                REPLACE(antiguedad,'Y ','')
               ELSE
                 antiguedad
         END  antiguedad
         INTO V_ANTIGUEDAD
         from (
              SELECT UPPER(CASE
                             WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       EMPL_FEC_INGRESO) / 12) > 1 THEN
                              TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                   EMPL_FEC_INGRESO) / 12) || ' A'||chr(241)||'os, '
                             WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       EMPL_FEC_INGRESO) / 12) = 1 THEN
                              TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                   EMPL_FEC_INGRESO) / 12) || ' A'||chr(241)||'o, '
                           END || CASE
                             WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                       'DD/MM') || '/' ||
                                                               TO_CHAR(P_FECHA_DESVINCULACION,
                                                                       'YYYY')))) > 1 THEN
                              TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                   TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                   'DD/MM') || '/' ||
                                                           TO_CHAR(P_FECHA_DESVINCULACION,
                                                                   'YYYY')))) || ' meses '

                             WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                       'DD/MM') || '/' ||
                                                               TO_CHAR(P_FECHA_DESVINCULACION,
                                                                       'YYYY')))) = 1 THEN
                              TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                   TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                   'DD/MM') || '/' ||
                                                           TO_CHAR(P_FECHA_DESVINCULACION,
                                                                   'YYYY')))) || ' mes '

                             WHEN (MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                       TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                       'DD/MM') || '/' ||
                                                               TO_CHAR(P_FECHA_DESVINCULACION,
                                                                       'YYYY')))) < 0 THEN

                              CASE
                                WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                          TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                          'DD/MM') || '/' ||
                                                                  TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                                     -12),
                                                                          'YYYY')))) > 1 THEN

                                 TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                      TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                      'DD/MM') || '/' ||
                                                              TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                                 -12),
                                                                      'YYYY')))) || ' meses'

                                WHEN TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                          TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                          'DD/MM') || '/' ||
                                                                  TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                                     -12),
                                                                          'YYYY')))) = 1 THEN

                                 TRUNC(MONTHS_BETWEEN(P_FECHA_DESVINCULACION,
                                                      TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                      'DD/MM') || '/' ||
                                                              TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                                 -12),
                                                                      'YYYY')))) || ' mes'

                              END

                           END || CASE
                             WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                        TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) > 1 THEN

                              ' y ' ||
                              TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                    TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                            TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) ||
                              ' dias '
                             WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                        TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) = 1 THEN
                              ' y ' ||
                              TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                    TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                            TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) ||
                              ' dia'
                             WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                        TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                TO_CHAR(P_FECHA_DESVINCULACION, 'MM/YYYY'))) < 0 THEN

                              CASE
                                WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                           TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                   TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                      -1),
                                                           'MM/YYYY'))) = 1 THEN

                               ' y ' ||  TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                       TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                               TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION, -1),
                                                       'MM/YYYY'))) || ' dia'
                                WHEN TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                           TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                                   TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION,
                                                                      -1),
                                                           'MM/YYYY'))) > 1 THEN
                               ' y ' ||  TRUNC((P_FECHA_DESVINCULACION + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                       TO_DATE(decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                               TO_CHAR(ADD_MONTHS(P_FECHA_DESVINCULACION, -1),
                                                       'MM/YYYY'))) || ' dias'
                              END
                           END

                           ) ANTIGUEDAD

                FROM PER_EMPLEADO A
               WHERE EMPL_LEGAJO = P_LEGAJO
                 AND EMPL_EMPRESA = P_EMPRESA);


     END IF;



    /*EXCEPTION
      WHEN OTHERS THEN
        NULL;*/
    END;

    RETURN V_ANTIGUEDAD;

  END;





 PROCEDURE PP_DETALLE_CONCEPTO (P_EMPRESA      IN NUMBER,
                                P_LEGAJO       IN NUMBER,
                                P_FECHA        IN DATE,
                              --  P_FORMA_PAGO   IN NUMBER,
                                P_TIPO_DESVINCULACION    IN NUMBER,
                                P_IND_OMISION_PREAVISO   IN VARCHAR2,
                                P_IND_PAGA_OMIS_PREAVISO IN VARCHAR2,
                                P_CLAVE                  IN OUT NUMBER,
                                P_EXONERAR               IN VARCHAR2,
                                P_FEC_RENUNCIA           IN DATE,
                                P_FEC_REN_HASTA          IN DATE,
                                p_FAC_CALIDAD            IN VARCHAR2,
                                P_CUMPLIO_PRE_AVISO      IN VARCHAR2) IS

V_COLOR            VARCHAR2(60);
V_SALARIO_BASE     NUMBER;
V_LISTA            VARCHAR2(3);
V_CANT_DIAS        NUMBER;
V_IPS_IMPORTE      NUMBER;
V_FORMA_PAGO       NUMBER;
V_MES              VARCHAR2(60) := TO_CHAR(P_FECHA,'MM/YYYY');
V_SALARIO          NUMBER;
V_DESC_CODIGO      NUMBER;
V_DESC_SEGURO      VARCHAR2(60);
V_CONP_COD         VARCHAR2(60);

----EMPL
V_EMPL_FORMA_PAGO      NUMBER;
V_EMPL_TIPO_SALARIO    NUMBER;
V_EMPL_IND_HORA_EXTRA  VARCHAR2(1);
V_EMPL_TIPO_COMIS      VARCHAR2(1);
V_EMPL_MARC_COMIS_SIST VARCHAR2(1);
V_EMPL_CODIGO_PROV     NUMBER;
V_EMPL_COD_CLIENTE     NUMBER;
V_EMPL_CARGO           NUMBER;
V_FEC_INGRESO          DATE;
V_DPTO                 NUMBER;
V_SUC                  NUMBER;
VAC_IMP_X_DIA3         number;
V_COD_CLIENTE_TRA      NUMBER;
V_PERIODO              NUMBER;
V_PERIODO2              NUMBER;

V_SALARIO_MEN           NUMBER;
V_IMPORTE_DIARIO        NUMBER;


VAC_EMPL_DESC      VARCHAR2(100);
VAC_FORMA_PAG_DESC VARCHAR2(100);
VAC_IMP_X_DIA      NUMBEr;
VAC_ANTIGUE        VARCHAR2(100);
VAC_DIAS_CORRES    NUMBER;
VAC_DIAS_CAUSAD    NUMBER;
VAC_DIAS_CONC      NUMBER;
VAC_DIAS_PEND      NUMBER;
VAC_FECHA_INGRESO  DATE;
VAC_SUCURSAL_DESC  VARCHAR2(100);
VAC_DIAS_CAUSAD2   NUMBER;
VAC_EMPL_SITUACION VARCHAR2(100);
VAC_CANT_ANHOS     NUMBER;
VAC_CANT_MESES NUMBER;

V_PRO VARCHAR2(20);
V_VAC_MONTO NUMBER;
V_VAC_IPS   NUMBER;

v_agui number;
---------------***

IND_MONTO NUMBER;
PRE_MONTO NUMBER;
PRE_DIAS NUMBER;
IND_DIAS NUMBER;
AG_IMPORTE_TOT NUMBER;
AG_IMPORTE NUMBER;

V_IMP_DIARIO_PROM NUMBER;
V_FEC_INI_LOG DATE;
V_ANTIGUEDAD VARCHAR2(60);
X_EDITAR NUMBER :=P_CLAVE;
X_CONTADOR NUMBER;


V_SEG_CONCEPTO NUMBER;
V_SEG_CON_DESC VARCHAR2(60);
V_SEG_PORCENTAJE NUMBER;



ANT_CANT_ANHOS NUMBER;
ANT_CANT_MESES NUMBER;
ANT_CANT_DIAS NUMBER;


X_OMISION_PRE_AVISO NUMBER;
X_OMI_IMPR          NUMBER;
X_OMI_IPS           NUMBER;

AUSE_CONT           number;

X_CANT_CUMPL          NUMBER;
XDIAS_OMI             NUMBER;
 BEGIN

 ------TIPO
 ---1 SALARIO
 ---2 SALARIO SALARIO JORNAL - HS EXTRAS
 ---3 PLUS
 ---4 COMISION DETALLE
 ---5 COMISION
 ---6 LICENCIA
 ---7 VACACION CAUSADA
 ---8 VACACION PROPORCIONAL
 ---9 CONCEPTOS FIJOS
 ---10 PRE AVISO
 ---11 INDERNIZACION
 ---12 AGUINALDO_DETALLE
 ---13 AGUINALDO
 ---14 DEUDAS SIN COBRAR
 ---15 DEUDAS QUE YA ESTAN EN RRHH


 ---RAISE_APPLICATION_ERROR (-20001, P_LEGAJO||' '||P_FECHA||' '||P_TIPO_DESVINCULACION||' '||P_IND_OMISION_PREAVISO||' '||P_IND_PAGA_OMIS_PREAVISO);

    DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA;


IF P_CLAVE  IS NULL THEN
    SELECT NVL(MAX(T.RDE_CLAVE),0)+1
    INTO V_DESC_CODIGO
    FROM PER_REGISTRO_DESVINC_EMPL T
    WHERE T.RDE_EMPR = P_EMPRESA;
P_CLAVE := V_DESC_CODIGO;
END IF;

P_CLAVE := P_CLAVE;

 if V('P3514_RDE_FIRMA_EMPR') is null then
   
 raise_application_error (-20001, 'La firma no puede quedar vacia');
 end if;
  if   V('P3514_RDE_CARGO_EMPR') is null then
   
 raise_application_error (-20001, 'El cargo de la firma no puede quedar vacio');
 end if;                
                   
                   
                   
                 SELECT A.EMPL_FORMA_PAGO,
                        A.EMPL_TIPO_SALARIO,
                        A.EMPL_IND_HORA_EXTRA,
                        A.EMPL_TIPO_COMIS,
                        A.EMPL_MARC_COMIS_SIST,
                        A.EMPL_CODIGO_PROV,
                        A.EMPL_COD_CLIENTE,
                        A.EMPL_CARGO,
                        A.EMPL_DEPARTAMENTO,
                        A.EMPL_SUCURSAL,
                        A.EMPL_SALARIO_BASE,
                        A.EMPL_IMP_HORA_N_D,
                        A.EMPL_FEC_INGRESO

                     INTO
                        V_EMPL_FORMA_PAGO,
                        V_EMPL_TIPO_SALARIO,
                        V_EMPL_IND_HORA_EXTRA,
                        V_EMPL_TIPO_COMIS,
                        V_EMPL_MARC_COMIS_SIST,
                        V_EMPL_CODIGO_PROV,
                        V_EMPL_COD_CLIENTE,
                        V_EMPL_CARGO,
                        V_DPTO,
                        V_SUC,
                        V_SALARIO_MEN,
                        V_IMPORTE_DIARIO,
                        V_FEC_INGRESO
                    FROM PER_EMPLEADO A
                   WHERE A.EMPL_LEGAJO  = P_LEGAJO
                     AND A.EMPL_EMPRESA = P_EMPRESA;


     V_ANTIGUEDAD := PERC002.FP_TRAER_ANTIGUEDAD(P_EMPRESA => P_EMPRESA,
                                                 P_LEGAJO => P_LEGAJO,
                                                 P_FECHA_DESVINCULACION => P_FECHA);
 
          IF V_EMPL_FORMA_PAGO  = 5 THEN
           V_SEG_CONCEPTO := 31;
           V_SEG_CON_DESC := 'A.M.H';
           V_SEG_PORCENTAJE := 0.05;

         ELSE
           V_SEG_CONCEPTO := 4;
           V_SEG_CON_DESC := 'I.P.S. OBRERO';
           V_SEG_PORCENTAJE := 0.09;
         END IF;

       BEGIN

          PERC002.PP_CALCULAR_CANTIDAD_TRA(P_EMPRESA => P_EMPRESA,    -- in
                                           P_LEGAJO => P_LEGAJO,      -- in
                                           P_FECHA => P_FECHA,        -- in
                                           P_ANHOS => ANT_CANT_ANHOS, -- out
                                           P_MES => ANT_CANT_MESES,   -- out
                                           P_DIAS => ANT_CANT_DIAS    -- out
                                           );
        END;

 IF X_EDITAR IS NULL THEN
                INSERT INTO PER_REGISTRO_DESVINC_EMPL
                  (RDE_CLAVE,
                   RDE_TIPO_DESVINCULACION,
                   RDE_EMPLEADO,
                   RDE_FECHA,
                   RDE_LOGIN,
                   RDE_EMPR,
                   RDE_FECHA_GRAB,
                   RDE_IND_OMISION_PREAVISO,
                   RDE_IND_PAGA_OMIS_PREAVISO,
                   RDE_ANTIGUEDAD,
                   RDE_REN_EXONERADA,
                   RDE_DEPARTAMENTO,
                   RDE_SUCURSAL,
                   RDE_FECHA_RENUNCIA,
                   RDE_FECHA_REN_HASTA,
                   RDE_FECHA_INGRESO,
                   RDE_FAC_CALIDAD,
                   RDE_CUMPLIO_PRE_AVISO,
                   RDE_FIRMA_EMPR,
                   RDE_CARGO_EMPR)
                VALUES
                  (V_DESC_CODIGO,
                   P_TIPO_DESVINCULACION,
                   P_LEGAJO,
                   P_FECHA,
                   gen_devuelve_user,
                   P_EMPRESA,
                   SYSDATE,
                   P_IND_OMISION_PREAVISO,
                   P_IND_PAGA_OMIS_PREAVISO,
                   V_ANTIGUEDAD,
                   P_EXONERAR,
                   V_DPTO,
                   V_SUC,
                   P_FEC_RENUNCIA,
                   P_FEC_REN_HASTA,
                   V_FEC_INGRESO,
                   P_FAC_CALIDAD,
                   P_CUMPLIO_PRE_AVISO,
                   V('P3514_RDE_FIRMA_EMPR'),
                   V('P3514_RDE_CARGO_EMPR'));

 END IF;


     V_FEC_INI_LOG :=TRUNC(ADD_MONTHS(P_FECHA,-1),'MM');



    IF TO_CHAR(P_FECHA,'DD/MM/YYYY') > '25/'||TO_CHAR(P_FECHA,'MM/YYYY') THEN

    BEGIN
      SELECT  P.PERI_CODIGO-1,P.PERI_CODIGO
        INTO V_PERIODO, V_PERIODO2
        FROM  PER_PERIODO P
       WHERE P.PERI_EMPR= P_EMPRESA
         AND P_FECHA BETWEEN P.PERI_JORN_INI AND P.PERI_JORN_FIN;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR (-20001,'Favor configurar el periodo Jornal');

      END;

   ELSE
      SELECT P.PERI_CODIGO
        INTO V_PERIODO
        FROM  PER_PERIODO P
       WHERE P.PERI_EMPR= P_EMPRESA
         AND P_FECHA BETWEEN P.PERI_JORN_INI AND P.PERI_JORN_FIN;

    END IF;

 IF  V_EMPL_TIPO_SALARIO NOT IN (2) AND P_EMPRESA = 1 THEN
      BEGIN

     SELECT case when V_EMPL_FORMA_PAGO in (1) then
                 ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 26)
                 else
                     ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 30)
                   end IMPORTE_DIARIO
          INTO VAC_IMP_X_DIA---V_IMP_DIARIO_PROM
              FROM PERI052_V         A,
                   PER_CONFIGURACION B,
                   PER_PERIODO       C,
                   PER_CONCEPTO      D,
                   PER_EMPLEADO      E
             where (A.FECHA BETWEEN
                   TO_CHAR(ADD_MONTHS(TRUNC(P_FECHA,'mm'), -6), 'DD/MM/YYYY') AND
                   TO_CHAR(ADD_MONTHS(LAST_DAY(P_FECHA), -1), 'DD/MM/YYYY')
                   )
               and A.EMPL_LEGAJO   = P_LEGAJO
               AND B.CONF_EMPR     = P_EMPRESA
               AND B.CONF_PERI_ACT = PERI_CODIGO
               AND B.CONF_EMPR     = PERI_EMPR
               AND A.COD_CONCEPTO  = D.PCON_CLAVE
               AND B.CONF_EMPR     = PCON_EMPR
               AND A.EMPL_LEGAJO   = E.EMPL_LEGAJO
               AND B.CONF_EMPR     = E.EMPL_EMPRESA
               
               AND D.PCON_IND_IPS = 'S'
               and A.FECHA >= CASE WHEN  E.EMPL_FEC_INGRESO <= '03/'|| TO_CHAR(E.EMPL_FEC_INGRESO,'MM/YYYY') THEN
                                          EMPL_FEC_INGRESO
                                     ELSE
                                         ADD_MONTHS (EMPL_FEC_INGRESO,1)
                                        END
               ;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN

          VAC_IMP_X_DIA := 0;

      END;
 ELSE
   VAC_IMP_X_DIA := (V_IMPORTE_DIARIO * 8);
 END IF;


 IF V_EMPL_FORMA_PAGO  = 2  then --AND V_EMPL_TIPO_SALARIO NOT IN (1) THEN
 ------------------------------SALARIO MENSUALERO

         PER_CALCULA_SAL_BASE_PRO2 (P_LEGAJO,P_EMPRESA,V_COLOR,V_SALARIO_BASE,V_LISTA,2,V_CANT_DIAS, P_FECHA);
 
 
 
                            
                            
           IF V_LISTA = 'S' THEN

             IF V_EMPL_FORMA_PAGO = 5 THEN
                V_IPS_IMPORTE :=  ROUND(V_SALARIO_BASE * 0.05);
                V_DESC_SEGURO := 'A.H.M';
                V_CONP_COD    := 31;
             ELSE
                V_IPS_IMPORTE := ROUND(V_SALARIO_BASE * 0.09);
                V_DESC_SEGURO :=  'I.P.S. OBRERO';
                V_CONP_COD    := 4;
             END IF;

                       INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_DIAS,
                          DES_IMP_DIARIO,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          2,
                          'SALARIO',
                          V_MES,
                          ROUND(V_SALARIO_BASE),
                          V_CANT_DIAS,
                          ROUND(V_SALARIO_BASE/V_CANT_DIAS),
                          V_DESC_CODIGO,
                          1,
                          V_DPTO,
                          V_SUC,
                          1);



                 INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          V_CONP_COD,
                          V_DESC_SEGURO,
                          V_MES,
                          ROUND(V_IPS_IMPORTE),
                          V_DESC_CODIGO,
                          1 ,
                          V_DPTO,
                          V_SUC,
                          1);

      END IF;


 END IF;



 ------------------------------SALARIO JORNALERO

 --------------------------DETALLE
                FOR HS IN (
SELECT 'HORAS' DETALLE,
        EMPL_SUCURSAL,
       T.DPTO_CODIGO,
       T.DPTO_DESC,
       T.PERIODO,
       T.EMPR EMPL_EMPRESA,
       TO_CHAR(T.HD)HD,
       TO_CHAR(T.HDE)HDE,
       TO_CHAR(T.HN)HN,
       TO_CHAR(T.HNE)HNE,
       TO_CHAR(T.HME)HME,
       TO_CHAR(T.HFD)HFD,
       TO_CHAR(T.HFN)HFN,
       TO_CHAR(T.HTOT) HTOT,
       1 ORDEN

  FROM PER_PERL029_FINAL_TEMP T, PER_EMPLEADO A
 WHERE T.EMPL_LEGAJO = A.EMPL_LEGAJO
   AND T.EMPR = A.EMPL_EMPRESA
   AND T.NIVEL = 'EMPLEADO'
   AND EMPL_EMPRESA = P_EMPRESA
  AND PERIODO IN (V_PERIODO, V_PERIODO2)
   AND T.EMPL_LEGAJO =P_LEGAJO
UNION ALL
SELECT 'GS POR HORA',
       EMPL_SUCURSAL,
       T.DPTO_CODIGO,
       T.DPTO_DESC,
       T.PERIODO,
       T.EMPR,
       TO_CHAR(T.IMP_HD, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HDE, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HN, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HNE, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HME, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HFD, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HFN, '999G999G999G999G999G999G990'),
       NULL TOTAL,
       2
  FROM PER_PERL029_FINAL_TEMP T, PER_EMPLEADO A
 WHERE T.EMPL_LEGAJO = A.EMPL_LEGAJO
   AND T.EMPR = A.EMPL_EMPRESA
   AND T.NIVEL = 'EMPLEADO'
   AND EMPL_EMPRESA = P_EMPRESA
   AND PERIODO IN (V_PERIODO, V_PERIODO2)
   AND T.EMPL_LEGAJO =P_LEGAJO
  

  
UNION ALL
SELECT 'IMPORTE',
       EMPL_SUCURSAL,
       T.DPTO_CODIGO,
       T.DPTO_DESC,
       T.PERIODO,
       T.EMPR,
       TO_CHAR(T.TOTIMPHD, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHDE, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHN, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHNE, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHME, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHFD, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHFN, '999G999G999G999G999G999G990'),
       
       TO_CHAR(CASE
                 WHEN EMPL_IND_HORA_EXTRA = 'S' THEN
                  NVL(TOTIMPHDE, 0) + NVL(TOTIMPHNE, 0) + NVL(TOTIMPHME, 0) +
                  NVL(TOTIMPHFD, 0) + NVL(TOTIMPHFN, 0)
                 ELSE
                  T.TOTIMPGRAL
               END,
               '999G999G999G999G999G999G990') TOTAL,
       3
     
  FROM PER_PERL029_FINAL_TEMP T, PER_EMPLEADO A
 WHERE T.EMPL_LEGAJO = A.EMPL_LEGAJO
   AND T.EMPR = A.EMPL_EMPRESA
   AND T.NIVEL = 'EMPLEADO'
   AND EMPL_EMPRESA = P_EMPRESA
   AND PERIODO IN (V_PERIODO, V_PERIODO2)
   AND T.EMPL_LEGAJO =P_LEGAJO
  
)  LOOP

        INSERT INTO PER_DESVINCULACION_DETALLE
                  (DES_EMPR,
                   DES_LEGAJO,
                   DES_CODIGO,
                   DES_TIPO,
                   DES_DPTO,
                   DES_SUC,
                   DES_PERIODO,
                   DES_DPTO_DESC,
                   DES_DETALLE,
                   DES_DIURNA,
                   DES_DIURNA_EXT,
                   DES_NOCTURNA,
                   DES_NOCT_EXT,
                   DES_MIXTA,
                   DES_FER_DIURNO,
                   DES_FER_NOCT,
                   DES_HS_TOTAL,
                   DES_HS_ORDEN)
                VALUES
                  (P_EMPRESA,
                   P_LEGAJO,
                   V_DESC_CODIGO,
                   20,
                   HS.EMPL_SUCURSAL,
                   HS.DPTO_CODIGO,
                   HS.PERIODO,
                   HS.DPTO_DESC,
                   HS.DETALLE,
                   HS.HD,
                   HS.HDE,
                   HS.HN,
                   HS.HNE,
                   HS.HME,
                   HS.HFD,
                   HS.HFN,
                   HS.HTOT,
                   HS.ORDEN
                  );


      END LOOP;

 ---------------------------TOTAL
   X_CONTADOR :=0;
        FOR X  IN (SELECT T.EMPL_LEGAJO,
                          T.EMPL_PAGA_IPS,
                          T.EMPL_SUCURSAL,
                          T.DPTO_CODIGO,
                          (T.HD * T.IMP_HD) + (T.HDE * T.IMP_HDE) +
                          (T.HN * T.IMP_HN) + (T.HNE * T.IMP_HNE) +
                          (T.HME * T.IMP_HME) +
                          (T.HFD * T.IMP_HFD) +
                          (T.HFN * T.IMP_HFN) TOT_GEN,
                           CASE WHEN  TIPO =  'J' THEN
                                          2
                                         ELSE
                                           5
                                         END CONCEPTO,
                           CASE WHEN TIPO =  'J'  THEN
                                  'SALARIO'
                                ELSE
                                   'HORAS EXTRAS'
                                END CON_DESC
                      FROM PER_PERL034_V_ACT T
                     WHERE EMPL_EMPRESA = P_EMPRESA
                       AND PERIODO IN (V_PERIODO, V_PERIODO2)
                       AND EMPL_LEGAJO = P_LEGAJO---100628
                       ) LOOP
               X_CONTADOR :=   X_CONTADOR+1;
                          INSERT INTO PER_DESVINCULACION_DETALLE
                               (DES_EMPR,
                                DES_LEGAJO,
                                DES_CON_COD,
                                DES_CON_DESC,
                                DES_MES,
                                DES_IMPORTE,
                                DES_CODIGO,
                                DES_TIPO,
                                DES_SUC,
                                DES_DPTO,
                                DES_NRO)
                             VALUES
                               (P_EMPRESA,
                                P_LEGAJO,
                                X.CONCEPTO,
                                X.CON_DESC,
                                V_MES,
                                ROUND(X.TOT_GEN),
                                V_DESC_CODIGO,
                                2,
                                X.EMPL_SUCURSAL,
                                X.DPTO_CODIGO,
                                X_CONTADOR);

                       INSERT INTO PER_DESVINCULACION_DETALLE
                               (DES_EMPR,
                                DES_LEGAJO,
                                DES_CON_COD,
                                DES_CON_DESC,
                                DES_MES,
                                DES_IMPORTE,
                                DES_CODIGO,
                                DES_TIPO,
                                DES_DPTO,
                                DES_SUC,
                                DES_NRO)
                             VALUES
                               (P_EMPRESA,
                                P_LEGAJO,
                                V_SEG_CONCEPTO,
                                V_SEG_CON_DESC,
                                V_MES,
                                ROUND(X.TOT_GEN*V_SEG_PORCENTAJE),
                                V_DESC_CODIGO,
                                2,
                                X.DPTO_CODIGO,
                                X.EMPL_SUCURSAL,
                                X_CONTADOR);





            END LOOP;

         X_CONTADOR :=0;
 ----------------------------------------------REVISAMOS SI SE CARGO ALGUN PLUS
      FOR P IN (SELECT EPS_EMPLEADO LEGAJO,
                       PCON_DESC CONCEPTO,
                       PCON_CLAVE,
                       EPS_IMPORTE,
                       DECODE(V_EMPL_FORMA_PAGO, 5, 'A.M.H', 'I.P.S. OBRERO') SEGURO_MEDICO,
                       DECODE(V_EMPL_FORMA_PAGO,5,31, 4) SEGURO_MEDICO_COD,
                       ROUND(DECODE(V_EMPL_FORMA_PAGO,5,(EPS_IMPORTE * 4) / 100, (EPS_IMPORTE * 9) / 100)) IMPORTE_IPS,
                       EPS_OBSERVACION,
                       EPS_ESTADO,
                       EPS_CLAVE
                  FROM PER_EMPL_PLUS_SALARIAL A,
                       PER_CONCEPTO C
                 WHERE EPS_EMPR = P_EMPRESA
                   AND EPS_CLAVE_CONCEPTO = PCON_CLAVE(+)
                   AND EPS_EMPR = PCON_EMPR(+)
                   AND EPS_EMPR = EPS_EMPR
                   AND A.EPS_EMPLEADO = P_LEGAJO
                   AND A.EPS_ESTADO = 'C'
                   AND nvl(EPS_ESTADO_RRHH,'P')  = 'P')LOOP
         X_CONTADOR :=   X_CONTADOR+1;
                INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_OBSERVACION,
                          DES_EST_PLUS,
                          DES_NRO,
                          DES_COD_PLUS)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          P.PCON_CLAVE,
                          P.CONCEPTO,
                          V_MES,
                          ROUND(P.EPS_IMPORTE),
                          V_DESC_CODIGO,
                          3,
                          V_DPTO,
                          V_SUC,
                          P.EPS_OBSERVACION,
                           P.EPS_ESTADO,
                          X_CONTADOR,
                          P.EPS_CLAVE);

                 INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_OBSERVACION,
                          DES_EST_PLUS,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          P.SEGURO_MEDICO_COD,
                          P.SEGURO_MEDICO,
                          V_MES,
                          ROUND(P.IMPORTE_IPS),
                          V_DESC_CODIGO,
                          3,
                          V_DPTO,
                          V_SUC,
                          NULL,
                          NULL,
                         X_CONTADOR);



       END LOOP;
 ----------------------------------COMISIONES LOGISTICA
 ---IF V_EMPL_MARC_COMIS_SIST  = 'S' THEN


  X_CONTADOR :=0;
    FOR X IN (SELECT T.ORDEN,
                       T.OCA_FECHA,
                       T.OCA_OBS,
                       DECODE(T.PERFIL_ASIG_COD, 47, 0, T.PAGAR_KILOS) KILOGRAMOS,
                       T.TASA_MONT,
                       CALCULO,
                       NVL(COMISIONADO,0)COMISIONADO,
                       T.PERFIL_ASIG_COD,
                       T.PERIODO,
                       NULL IPS,
                       1 TIPO
                  FROM PER_CALCULO_COMISION_LOGISTICA T
                 WHERE T.EMPR = P_EMPRESA
                   AND T.EMPLEADO = P_LEGAJO
                   AND OCA_FECHA BETWEEN V_FEC_INI_LOG AND P_FECHA
                   UNION ALL
                   SELECT NULL,
                          NULL,
                          NULL,
                          NULL,
                          NULL,
                          NULL,
                          SUM(COMISIONADO),
                          NULL,
                          NULL,
                          ROUND(SUM(COMISIONADO)*V_SEG_PORCENTAJE) IPS,
                          2 TIPO
                      FROM PER_CALCULO_COMISION_LOGISTICA T
                     WHERE T.EMPR = 1
                       AND T.EMPLEADO =P_LEGAJO---
                       AND OCA_FECHA BETWEEN V_FEC_INI_LOG AND P_FECHA) LOOP

  IF X.TIPO  = 1 THEN
           X_CONTADOR :=   X_CONTADOR+1;
             INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_OBSERVACION,
                          DES_FECHA,
                          DES_KG,
                          DES_TASA,
                          DES_MONTO,
                          DES_CALCULO,
                          DES_PERFIL,
                          DES_PERIODO,
                          CANT_ORDEN,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          12,
                          'COMISION',
                          V_MES,
                          X.COMISIONADO,
                          V_DESC_CODIGO,
                          4,
                          V_DPTO,
                          V_SUC,
                          X.OCA_OBS,
                          X.OCA_FECHA,
                          X.KILOGRAMOS,
                          X.TASA_MONT,
                          X.TASA_MONT,
                          X.CALCULO,
                          X.PERFIL_ASIG_COD,
                          X.PERIODO,
                          X.ORDEN,
                          X_CONTADOR);

   ELSE
        IF X.COMISIONADO >0 THEN
           X_CONTADOR :=   X_CONTADOR+1;
            INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_OBSERVACION,
                          DES_FECHA,
                          DES_KG,
                          DES_TASA,
                          DES_MONTO,
                          DES_CALCULO,
                          DES_PERFIL,
                          DES_PERIODO,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          12,
                          'COMISION',
                          V_MES,
                          ROUND(X.COMISIONADO),
                          V_DESC_CODIGO,
                          5,
                          V_DPTO,
                          V_SUC,
                          X.OCA_OBS,
                          X.OCA_FECHA,
                          X.KILOGRAMOS,
                          X.TASA_MONT,
                          X.TASA_MONT,
                          X.CALCULO,
                          X.PERFIL_ASIG_COD,
                          X.PERIODO,
                          X_CONTADOR );

              INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_PERIODO,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          V_SEG_CONCEPTO,
                          V_SEG_CON_DESC,
                          V_MES,
                          ROUND(X.IPS),
                          V_DESC_CODIGO,
                          5,
                          V_DPTO,
                          V_SUC,
                          X.PERIODO,
                         X_CONTADOR);



           END IF;

    END IF;
   END LOOP;

 --END IF;
 
  
        SELECT COUNT(T.AUSE_EMPR)
              INTO AUSE_CONT 
              FROM PER_AUSENCIAS_JUSTIFICADAS T, PER_TIPOS_AUSENC_JUST A
             WHERE T.AUSE_TIPO = A.TIPAUS_CLAVE
               AND T.AUSE_EMPR = A.TIPAUS_EMPR
               AND T.AUSE_EMPR = 1
               AND T.AUSE_EMPL_LEGAJO = P_LEGAJO
               AND T.AUSE_MOTIVO = 'L'
               AND A.TIPAUS_MARC_PAGA = 'S'
               AND T.AUSE_ESTADO_APROB_ES = 'P'
               AND TO_CHAR(T.AUSE_DESDE, 'MM/YYYY') = V_MES;
     IF AUSE_CONT  > 0 THEN
       RAISE_APPLICATION_ERROR (-20001, 'El empleado cuenta con una ausencia pendiente favor confirmar o rechazar');
     END IF;

    X_CONTADOR := 0;
   --------------------------REVISAMOS SI TUVO LICENCIA
 FOR L IN (SELECT (T.AUSE_HASTA + 1) - T.AUSE_DESDE CANT_DIAS,
                   T.AUSE_DESDE,
                   T.AUSE_HASTA,
                   CASE
                     WHEN V_EMPL_FORMA_PAGO = 1 THEN
                       V_IMPORTE_DIARIO * 8
                     ELSE
                      ROUND(NVL(V_SALARIO_MEN, 0) / 30)
                   END IMPORTE_DIARIO,
                   A.TIPAUS_DESC,
                   AUSE_ESTADO_APROB_ES,
                   NULL CLAVE_RRHH,
                   NULL CLAVE_RRHH_IPS
              FROM PER_AUSENCIAS_JUSTIFICADAS T, PER_TIPOS_AUSENC_JUST A
             WHERE T.AUSE_TIPO = A.TIPAUS_CLAVE
               AND T.AUSE_EMPR = A.TIPAUS_EMPR
               AND T.AUSE_EMPR = 1
               AND T.AUSE_EMPL_LEGAJO = P_LEGAJO
               AND T.AUSE_MOTIVO = 'L'
               AND A.TIPAUS_MARC_PAGA = 'S'
               AND T.AUSE_ESTADO_APROB_ES = 'P'
               AND TO_CHAR(T.AUSE_DESDE, 'MM/YYYY') = V_MES
              /* UNION ALL
               SELECT (T.AUSE_HASTA + 1) -TRUNC(T.AUSE_HASTA,'MM'),
                     T.AUSE_DESDE,
                     T.AUSE_HASTA,
                     CASE
                       WHEN V_EMPL_FORMA_PAGO = 1 THEN
                        V_IMPORTE_DIARIO * 8
                       ELSE
                        ROUND(NVL(V_SALARIO_MEN, 0) / 30)
                     END IMPORTE_DIARIO,
                    A.TIPAUS_DESC,
                    AUSE_ESTADO_APROB_ES,
                    NVL(T.AUSE_PDOC_CLAVE2,AUSE_PDOC_CLAVE1) CLAVE_RRHH,
                    NVL(T.AUSE_PDOC_CLAVE2,AUSE_PDOC_CLAVE1)+1 CLAVE_RRHH_IPS
                FROM PER_AUSENCIAS_JUSTIFICADAS T, PER_TIPOS_AUSENC_JUST A
               WHERE T.AUSE_TIPO = A.TIPAUS_CLAVE
                 AND T.AUSE_EMPR = A.TIPAUS_EMPR
                 AND T.AUSE_EMPR = 1
                 AND T.AUSE_EMPL_LEGAJO = P_LEGAJO
                 AND T.AUSE_MOTIVO = 'L'
                 AND A.TIPAUS_MARC_PAGA = 'S'
                 AND T.AUSE_ESTADO_APROB_ES = 'C'
                 AND TO_CHAR(T.AUSE_HASTA, 'MM/YYYY') = V_MES*/



               ) LOOP
          X_CONTADOR :=   X_CONTADOR+1;
              IF V_EMPL_FORMA_PAGO = 5 THEN
                V_IPS_IMPORTE :=  ROUND((L.IMPORTE_DIARIO*L.CANT_DIAS)  * 0.05);
             ELSE
                V_IPS_IMPORTE := ROUND((L.IMPORTE_DIARIO*L.CANT_DIAS) * 0.09);
             END IF;
   ----------------------------------------------------

         INSERT INTO PER_DESVINCULACION_DETALLE
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_EST_PLUS,
                                DES_DESDE,
                               DES_HASTA,
                               DES_MOT_AUSE,
                               DES_NRO,
                               DES_CLAVE_RRHH)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               14,
                               'LICENCIA',
                               V_MES,
                               ROUND(L.IMPORTE_DIARIO*L.CANT_DIAS),
                               L.CANT_DIAS,
                               L.IMPORTE_DIARIO,
                               V_DESC_CODIGO,
                               6,
                               V_DPTO,
                               V_SUC,
                               L.AUSE_ESTADO_APROB_ES,
                               L.AUSE_DESDE,
                               L.AUSE_HASTA,
                               L.TIPAUS_DESC,
                               X_CONTADOR ,
                               L.CLAVE_RRHH);

      INSERT INTO PER_DESVINCULACION_DETALLE
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_EST_PLUS,
                               DES_DESDE,
                               DES_HASTA,
                               DES_MOT_AUSE,
                               DES_NRO,
                               DES_CLAVE_RRHH)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               V_CONP_COD,
                               V_DESC_SEGURO,
                               V_MES,
                               ROUND(V_IPS_IMPORTE),
                               L.CANT_DIAS,
                               NULL,
                               V_DESC_CODIGO,
                               6,
                               V_DPTO,
                               V_SUC,
                               L.AUSE_ESTADO_APROB_ES,
                               L.AUSE_DESDE,
                               L.AUSE_HASTA,
                               L.TIPAUS_DESC,
                               X_CONTADOR,
                               L.CLAVE_RRHH );

      END LOOP;

--------------------si se cargo algun concepto que aun no se transfirio a finanzas
 INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO,
                               DES_CLAVE_RRHH)

                SELECT a.pdoc_empr,
                       A.PDOC_EMPLEADO,
                       C.PCON_CLAVE,
                       C.PCON_DESC,
                       to_char(a.pdoc_fec,'mm/yyyy'),
                       ROUND(B.PDDET_IMP),
                       V_DESC_CODIGO,
                       40,
                       a.pdoc_departamento,
                       V_SUC,
                       rownum,
                       A.PDOC_CLAVE
                  FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_CONCEPTO C,PER_EMPLEADO E
                 WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
                   AND A.PDOC_EMPR = B.PDDET_EMPR
                   AND B.PDDET_CLAVE_CONCEPTO = C.PCON_CLAVE
                   AND B.PDDET_EMPR = C.PCON_EMPR
                   AND A.PDOC_EMPLEADO = E.EMPL_LEGAJO
                   AND A.PDOC_EMPR = EMPL_EMPRESA
                   AND A.PDOC_EMPR =1
                   and a.pdoc_empleado = P_LEGAJO
                   and nvl(c.pcon_fin_tmov,33) not in (31,33)
                   and NVL(B.PDDET_CLAVE_FIN,   A.PDOC_CLAVE_FIN) is null
                   AND PDOC_PERIODO >=  V_PERIODO
                 ORDER BY 1, 3, 2;


-------------------
     ---------------------------------------------REVISAMOS SI CUENTA CON CONCEPTOS FIJOS
  X_CONTADOR := 0;
  FOR CON IN (SELECT T.PERCON_CONCEPTO,
                           T.PERCON_IMP,
                           A.PCON_DESC,
                           CASE
                             WHEN V_EMPL_FORMA_PAGO = 5 THEN
                              T.PERCON_IMP * 0.05
                             ELSE
                              T.PERCON_IMP * 0.09
                           END IMPORTE_IPS
                      FROM PER_EMPL_CONC T, PER_CONCEPTO A
                     WHERE T.PERCON_EMPR = A.PCON_EMPR
                       AND T.PERCON_CONCEPTO = A.PCON_CLAVE
                       AND T.PERCON_EMPLEADO = P_LEGAJO
                       AND T.PERCON_CONCEPTO NOT IN (1, 2)
                       AND T.PERCON_EMPR = P_EMPRESA ) LOOP
             X_CONTADOR :=   X_CONTADOR+1;
                  INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               CON.PERCON_CONCEPTO,
                               CON.PCON_DESC,
                               V_MES,
                               ROUND(CON.PERCON_IMP),
                               V_DESC_CODIGO,
                               9,
                               V_DPTO,
                               V_SUC,
                                X_CONTADOR  );


                      INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               V_CONP_COD,
                               V_DESC_SEGURO,
                               V_MES,
                               ROUND(CON.IMPORTE_IPS),
                               V_DESC_CODIGO,
                               9,
                               V_DPTO,
                               V_SUC,
                               X_CONTADOR );


   END LOOP;


       ---------------------------------------------------------------------VACACION

    PERI052.FP_TRAER_EMPLEADO(V_EMPRESA               => P_EMPRESA,
                              V_EMPL_LEG              => P_LEGAJO,
                              V_EMPL_DESC             => VAC_EMPL_DESC,
                              V_FORMA_PAG_DESC        => VAC_FORMA_PAG_DESC,
                              V_IMP_X_DIA             => VAC_IMP_X_DIA3,
                              V_ANTIGUE               => VAC_ANTIGUE,
                              V_DIAS_CORRES           => VAC_DIAS_CORRES,
                              V_DIAS_CAUSAD           => VAC_DIAS_CAUSAD,
                              V_DIAS_CONC             => VAC_DIAS_CONC,
                              V_DIAS_PEND             => VAC_DIAS_PEND,
                              V_FECHA_INGRESO         => VAC_FECHA_INGRESO,
                              V_SUCURSAL_DESC         => VAC_SUCURSAL_DESC,
                              V_DIAS_CAUSAD2          => VAC_DIAS_CAUSAD2,
                              V_EMPL_SITUACION        => VAC_EMPL_SITUACION,
                              V_CANT_ANHOS            => VAC_CANT_ANHOS);











  IF TO_CHAR(V_FEC_INGRESO,'MM') > TO_CHAR(P_FECHA,'MM') THEN
        VAC_CANT_ANHOS:= VAC_CANT_ANHOS-1;
     ELSE
        VAC_CANT_ANHOS:= VAC_CANT_ANHOS;
    END IF;
--RAISE_APPLICATION_ERROR (-20001, P_LEGAJO||' '||V_FEC_INGRESO||' '||VAC_CANT_ANHOS||' '||P_FECHA||' '||P_IND_PAGA_OMIS_PREAVISO);


SELECT SUM(CANT_MES)
  INTO VAC_CANT_MESES
  FROM (SELECT ADD_MONTHS(TO_CHAR(TO_dATE(V_FEC_INGRESO), 'DD/MM/') ||
                          (TO_CHAR(TO_DATE(V_FEC_INGRESO), 'YYYY') + VAC_CANT_ANHOS),
                          LEVEL) MESES,
               LEVEL,
               CASE
                 WHEN P_FECHA >=
                      ADD_MONTHS(TO_CHAR(TO_dATE(V_FEC_INGRESO), 'DD/MM/') ||
                                 (TO_CHAR(TO_DATE(V_FEC_INGRESO), 'YYYY') +
                                   VAC_CANT_ANHOS),
                                 LEVEL) THEN
                  1
                 ELSE
                  0
               END CANT_MES
          FROM DUAL
        CONNECT BY LEVEL <= 12);



                 IF VAC_DIAS_PEND > 0 THEN

                    V_VAC_MONTO := VAC_IMP_X_DIA * VAC_DIAS_PEND;

                      IF V_EMPL_FORMA_PAGO = 5 THEN
                        V_VAC_IPS :=  ROUND(V_VAC_MONTO  * 0.05);
                      ELSE
                        V_VAC_IPS := ROUND(V_VAC_MONTO * 0.09);
                      END IF;

                       INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_AFC_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               6,
                               'VACACION CAUSADAS',
                               V_MES,
                               ROUND(V_VAC_MONTO),
                               VAC_DIAS_PEND,
                               VAC_IMP_X_DIA,
                               V_DESC_CODIGO,
                               7,
                               V_DPTO,
                               V_SUC,
                               'S',
                               1);


                      INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_AFC_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               V_SEG_CONCEPTO,
                               V_SEG_CON_DESC,
                               V_MES,
                               ROUND(V_VAC_IPS),
                               NULL,
                               NULL,
                               V_DESC_CODIGO,
                               7,
                               V_DPTO,
                               V_SUC,
                               'S',
                               1);

                 END IF;
IF P_TIPO_DESVINCULACION = 2 THEN
  IF ANT_CANT_MESES >0 THEN
     IF ANT_CANT_ANHOS <=5 THEN
       V_PRO  := 1;
       V_VAC_MONTO := VAC_IMP_X_DIA * ANT_CANT_MESES;

     END IF;

     IF ANT_CANT_ANHOS >5 AND ANT_CANT_ANHOS <=10 THEN
       V_PRO  := '1,5';
        V_VAC_MONTO  := VAC_IMP_X_DIA * (ANT_CANT_MESES*1.5);
     END IF;

     IF ANT_CANT_ANHOS > 10 THEN
       V_PRO  := '2,5';
       V_VAC_MONTO  := VAC_IMP_X_DIA * (ANT_CANT_MESES*2.5);
     END IF;

       IF V_EMPL_FORMA_PAGO = 5 THEN
          V_VAC_IPS :=  ROUND(V_VAC_MONTO  * 0.05);
       ELSE
          V_VAC_IPS := ROUND(V_VAC_MONTO * 0.09);
       END IF;

       INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_CANT_PRO,
                               DES_AFC_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               6,
                               'VACACION PROPORCIONAL',
                               V_MES,
                               ROUND(V_VAC_MONTO),
                               ANT_CANT_MESES*TO_NUMBER(V_PRO), ---VAC_CANT_MESES,
                               VAC_IMP_X_DIA,
                               V_DESC_CODIGO,
                               8,
                               V_DPTO,
                               V_SUC,
                               V_PRO,
                               'S',
                               2);


                      INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               4,
                               'I.P.S. OBRERO',
                               V_MES,
                               ROUND(V_VAC_IPS),
                               NULL,
                               NULL,
                               V_DESC_CODIGO,
                               8,
                               V_DPTO,
                               V_SUC,
                               2);


  END IF;




   IF P_IND_OMISION_PREAVISO  = 'S' AND P_IND_PAGA_OMIS_PREAVISO ='S' THEN
------------------------------*********** PRE AVISO


             IF  NVL(ANT_CANT_ANHOS,0) > 0 THEN
             IF ANT_CANT_MESES  >= 1 OR ANT_CANT_DIAS > 0  THEN
               VAC_CANT_ANHOS := ANT_CANT_ANHOS+1;
             ELSE
                VAC_CANT_ANHOS := ANT_CANT_ANHOS;
             END IF;
           END IF;
      IF  NVL(ANT_CANT_ANHOS,0) = 0 THEN
              VAC_CANT_ANHOS := 1;
      END IF;

               IF VAC_CANT_ANHOS <= 1 THEN
                   PRE_DIAS := 30;
                   PRE_MONTO := VAC_IMP_X_DIA * PRE_DIAS;
               ELSIF VAC_CANT_ANHOS >=1 AND  VAC_CANT_ANHOS <6  THEN
                  PRE_DIAS :=45;
                  PRE_MONTO := VAC_IMP_X_DIA * PRE_DIAS;
               ELSIF VAC_CANT_ANHOS > 5 THEN
                  PRE_DIAS :=60;
                  PRE_MONTO := VAC_IMP_X_DIA * PRE_DIAS;

               END IF;

                INSERT INTO PER_DESVINCULACION_DETALLE f
                                      (DES_EMPR,
                                       DES_LEGAJO,
                                       DES_CON_COD,
                                       DES_CON_DESC,
                                       DES_MES,
                                       DES_IMPORTE,
                                       DES_DIAS,
                                       DES_IMP_DIARIO,
                                       DES_CODIGO,
                                       DES_TIPO,
                                       DES_DPTO,
                                       DES_SUC,
                                       DES_NRO)
                                    VALUES
                                      (P_EMPRESA,
                                       P_LEGAJO,
                                       V_SEG_CONCEPTO,
                                       V_SEG_CON_DESC,
                                       V_MES,
                                       ROUND(PRE_MONTO*V_SEG_PORCENTAJE),
                                       NULL,
                                       NULL,
                                       V_DESC_CODIGO,
                                       10,
                                       V_DPTO,
                                       V_SUC,
                                       1);
                                   INSERT INTO PER_DESVINCULACION_DETALLE f
                                      (DES_EMPR,
                                       DES_LEGAJO,
                                       DES_CON_COD,
                                       DES_CON_DESC,
                                       DES_MES,
                                       DES_IMPORTE,
                                       DES_DIAS,
                                       DES_IMP_DIARIO,
                                       DES_CODIGO,
                                       DES_TIPO,
                                       DES_DPTO,
                                       DES_SUC,
                                       DES_NRO)
                                    VALUES
                                      (P_EMPRESA,
                                       P_LEGAJO,
                                       25,
                                       'PRE AVISO',
                                       V_MES,
                                       ROUND(PRE_MONTO),
                                       PRE_DIAS,
                                       VAC_IMP_X_DIA,
                                       V_DESC_CODIGO,
                                       10,
                                       V_DPTO,
                                       V_SUC,
                                       1);



       -- END IF;

 END IF;

        --  PRE_MONTO
         /*IF VAC_CANT_MESES  > 6 THEN
               VAC_CANT_ANHOS+1;
             END IF;*/
------------------------------********** INDERNIZACION


       IF ANT_CANT_ANHOS > 0  THEN

             IF ANT_CANT_MESES  >=6 THEN
               VAC_CANT_ANHOS := ANT_CANT_ANHOS+1;
            else
              VAC_CANT_ANHOS := ANT_CANT_ANHOS;
             END IF;
       end if;
      IF  ANT_CANT_ANHOS = 0 THEN
              VAC_CANT_ANHOS := 1;
      END IF;



   IND_DIAS  := VAC_CANT_ANHOS*15;
   IND_MONTO := VAC_IMP_X_DIA * IND_DIAS;

   INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               23,
                               'INDEMNIZACION',
                               V_MES,
                               ROUND(IND_MONTO),
                               IND_DIAS,
                               VAC_IMP_X_DIA,
                               V_DESC_CODIGO,
                               11,
                               V_DPTO,
                               V_SUC,
                               1);

     IF V_EMPL_FORMA_PAGO = 5 THEN
          V_VAC_IPS :=  ROUND(IND_MONTO  * 0.05);
          V_DESC_SEGURO :=  'A.M.H';
          V_CONP_COD    := 31;
        ELSE
          V_VAC_IPS := ROUND(IND_MONTO * 0.09);
          V_DESC_SEGURO :=  'I.P.S. OBRERO';
          V_CONP_COD    := 4;
        END IF;
           INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               V_CONP_COD,
                               V_DESC_SEGURO,
                               V_MES,
                               ROUND(V_VAC_IPS),
                               NULL,
                               NULL,
                               V_DESC_CODIGO,
                               11,
                               V_DPTO,
                               V_SUC,
                               1);



END IF;

----------------------------------------AGUINALDO****
X_CONTADOR := 0;


SELECT COUNT(*) 
  into v_agui
  FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_EMPLEADO E, PER_CONCEPTO F
 WHERE PDOC_CLAVE = B.PDDET_CLAVE_DOC
   AND PDOC_EMPR = B.PDDET_EMPR
   AND A.PDOC_EMPLEADO = E.EMPL_LEGAJO
   AND PDOC_EMPR = EMPL_EMPRESA
   AND PDOC_EMPR = P_EMPRESA
   AND B.PDDET_CLAVE_CONCEPTO = PCON_CLAVE
   AND B.PDDET_EMPR = PCON_EMPR
   AND EMPL_LEGAJO = P_LEGAJO
   AND PCON_CLAVE = 3
   AND A.PDOC_PERIODO = V_PERIODO;
 if v_agui = 0 then  
    FOR AG IN (SELECT TO_CHAR(A.PDOC_FEC,'MM/YYYY') MES,
                         ROUND(SUM(B.PDDET_IMP)) IMPORTE
                    FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_CONCEPTO C
                   WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
                     AND A.PDOC_EMPR = B.PDDET_EMPR
                     AND B.PDDET_CLAVE_CONCEPTO = C.PCON_CLAVE
                     AND B.PDDET_EMPR = C.PCON_EMPR
                     AND A.PDOC_EMPR =P_EMPRESA
                     and a.pdoc_fec > V_FEC_INGRESO
                     AND C.PCON_IND_AGUINALDO = 'S'
                     AND A.PDOC_FEC BETWEEN '01/01'||TO_CHAR(P_FECHA,'/YYYY') AND P_FECHA
                     AND A.PDOC_EMPLEADO = P_LEGAJO
                     and NVL(B.PDDET_CLAVE_FIN,   A.PDOC_CLAVE_FIN) is not null
                  GROUP BY TO_CHAR(A.PDOC_FEC,'MM/YYYY') )LOOP
                X_CONTADOR :=   X_CONTADOR+1;
              INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               3,
                               'AGUINALDO',
                               AG.MES,
                               ROUND(AG.IMPORTE),
                               V_DESC_CODIGO,
                               12,
                               V_DPTO,
                               V_SUC,
                               X_CONTADOR);


  END LOOP;

end if;



  PERC002.PP_AGUINALDO_MES_ACT(P_EMPRESA => P_EMPRESA,
                               P_LEGAJO  => P_LEGAJO,
                               P_CLAVE   => V_DESC_CODIGO,
                               P_DPTO    => V_DPTO,
                               P_SUC     => V_SUC,
                               P_FECHA   => P_FECHA);


-----------------------------------------------------------****
----------------DEUDAS DEL EMPLEADO CON LA EMPRESA
      BEGIN

        PERC002.PP_DEUDAS_EMPL(P_EMPRESA  => P_EMPRESA,
                               P_LEGAJO   => P_LEGAJO,
                               P_COD_CLI  => V_EMPL_COD_CLIENTE,
                               P_COD_PROV => V_EMPL_CODIGO_PROV,
                               P_CLAVE    => V_DESC_CODIGO,
                               P_FECHA    => P_FECHA);
      END;


  IF P_EXONERAR = 'N' AND P_TIPO_DESVINCULACION=1  THEN ---= 1



  SELECT ROUND(SUM(T.DES_IMPORTE))
    INTO X_OMI_IMPR
    FROM PER_DESVINCULACION_DETALLE T, PER_CONCEPTO A
    WHERE T.DES_CON_COD = A.PCON_CLAVE
    AND T.DES_EMPR = A.PCON_EMPR
    AND A.PCON_IND_AGUINALDO = 'S'
    AND T.DES_EMPR = P_EMPRESA
    AND T.DES_LEGAJO =  P_LEGAJO
    AND T.DES_CODIGO = P_CLAVE
   -- AND NVL(T.DES_AFC_AG,'N') = 'N'
    AND T.DES_TIPO IN (1,2,3,5,6,7,8,9,30,32,34,40);


       SELECT ROUND(SUM(T.DES_IMPORTE))
          INTO X_OMI_IPS
          FROM PER_DESVINCULACION_DETALLE T, PER_CONCEPTO A
          WHERE T.DES_CON_COD = A.PCON_CLAVE
          AND T.DES_EMPR = A.PCON_EMPR
          AND T.DES_EMPR = P_EMPRESA
          AND T.DES_LEGAJO = P_LEGAJO
          AND T.DES_CODIGO =  P_CLAVE
         AND T.DES_CON_COD = 4;


       /*  X_OMI_IMPR := X_OMI_IMPR-X_OMI_IPS;

    IF ANT_CANT_ANHOS <= 1 THEN
           X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*15;
     ELSIF ANT_CANT_ANHOS > 1 AND  ANT_CANT_ANHOS <6 THEN
           X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*22.5;
     ELSE
           X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*30;

     END IF;

     if X_OMISION_PRE_AVISO >  X_OMI_IMPR  then

        X_OMISION_PRE_AVISO :=X_OMI_IMPR;
     else

      X_OMISION_PRE_AVISO := X_OMISION_PRE_AVISO;
     end if;*/
              X_OMI_IMPR := X_OMI_IMPR-X_OMI_IPS;
         
         x_cant_cumpl := P_FECHA-P_FEC_RENUNCIA;
   
   
   
    IF  NVL(ANT_CANT_ANHOS,0) > 0 THEN
            IF ANT_CANT_MESES  >= 1 OR ANT_CANT_DIAS > 0  THEN
               VAC_CANT_ANHOS := ANT_CANT_ANHOS+1;
             ELSE
               VAC_CANT_ANHOS := ANT_CANT_ANHOS;
             END IF;
           END IF;
      IF  NVL(ANT_CANT_ANHOS,0) = 0 THEN
              VAC_CANT_ANHOS := 1;
      END IF;

    IF VAC_CANT_ANHOS <= 1 THEN
      XDIAS_OMI := (30-nvl(x_cant_cumpl,0))/2;
    
     -- X_DIAS_OMI := 15;
      X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*XDIAS_OMI;
     ELSIF VAC_CANT_ANHOS > 1 AND  VAC_CANT_ANHOS <6 THEN
          XDIAS_OMI := (45-nvl(x_cant_cumpl,0))/2;
          X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*XDIAS_OMI;
       --   raise_application_error (-20001,P_FECHA||'**'||P_FEC_RENUNCIA||'---'||x_cant_cumpl||'*--'||VAC_IMP_X_DIA);  
     ELSE
      -- X_DIAS_OMI :=30;
        XDIAS_OMI := (60-nvl(x_cant_cumpl,0))/2;
        X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*XDIAS_OMI;

     END IF;
 --   
      --   raise_application_error (-20001,P_FECHA||'**'||P_FEC_RENUNCIA||'---'||x_cant_cumpl||'*--'||VAC_IMP_X_DIA);  
       
     

     if X_OMISION_PRE_AVISO >  X_OMI_IMPR  then

        X_OMISION_PRE_AVISO :=X_OMI_IMPR;
     else

      X_OMISION_PRE_AVISO := X_OMISION_PRE_AVISO;
     end if;
     
     
        INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               32,
                               'OMISION DE PREAVISO',
                               TO_CHAR(P_FECHA,'MM/YYYY'),
                               ROUND(X_OMISION_PRE_AVISO),
                               P_CLAVE,
                               30,
                               V_DPTO,
                               V_SUC,
                               1,
                               1);

  END IF;



 END PP_DETALLE_CONCEPTO;

 PROCEDURE PP_DEUDAS_EMPL (P_EMPRESA      IN NUMBER,
                           P_LEGAJO       IN NUMBER,
                           P_COD_CLI      IN NUMBER,
                           P_COD_PROV     IN NUMBER,
                           P_CLAVE        IN NUMBER,
                           P_FECHA        IN DATE)IS
  X_CONTADOR NUMBER;
 V_COD_CLIENTE_TRA NUMBER;
 X_CATEGORIA NUMBER;
 BEGIN

 ---RAISE_APPLICATION_ERROR (-20001,P_FECHA);
   -----------------------------------------------------------****
----------------DEUDAS DEL EMPLEADO CON LA EMPRESA
IF P_EMPRESA = 1 THEN
    BEGIN
     SELECT CLI_CODIGO
        INTO V_COD_CLIENTE_TRA
        FROM FIN_CLIENTE
       WHERE CLI_COD_EMPL_EMPR_ORIG = P_LEGAJO
         AND CLI_CATEG IN (4)
         AND CLI_EMPR = 2;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       V_COD_CLIENTE_TRA := NULL;
     END;


    DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   IN (14,15);

    X_CONTADOR :=0;
    FOR C IN ( select  P_EMPRESA,
                         EMPL_LEGAJO,
                         A.PCON_CLAVE,
                         A.PCON_DESC,
                         P_CLAVE,
                         14 TIPO,
                         CUO_FEC_VTO,
                         EMPL_MON_PAGO,
                         CUO_IMP_MON,
                         CUO_SALDO_MON,
                         FIN_OBS,
                         1 EMPR_CORR,
                         CUO_CLAVE_DOC,
                         NULL TIPO_MOV
                    from PER_PERI047_V t,PER_CONCEPTO A
                      WHERE A.PCON_CLAVE = T.PCON_CANCELADO_POR_CONC
                      AND A.PCON_EMPR = 1
                      AND  T.EMPL_LEGAJO = P_LEGAJO
                UNION ALL
                SELECT P_EMPRESA,
                       P_LEGAJO,
                       NVL(PCON_CANCELADO_POR_CONC,1),
                       NVL((select PCON_DESC
                          from PER_CONCEPTO t
                          WHERE T.PCON_EMPR = P_EMPRESA
                          AND T.PCON_CLAVE = C.PCON_CANCELADO_POR_CONC),'ADELANTO'),
                       P_CLAVE,
                       14,
                       CUO.CUO_FEC_VTO,
                       A.DOC_MON,
                       CUO.CUO_IMP_MON,
                       CUO.CUO_IMP_MON,
                       'Pend. Aprobaci?n',
                       1,
                       CUO.CUO_CLAVE_DOC ,
                       null
                  FROM FIN_DOCUMENTO_COMI015_TEMP A, FIN_CUOTA_COMI015_TEMP CUO, GEN_TIPO_MOV M,PER_DOCUMENTO_ADEL_TEMP t, PER_DOCUMENTO_DET_ADEL_TEMP A, PER_CONCEPTO C
                 WHERE DOC_CLAVE = CUO_CLAVE_DOC
                   AND DOC_EMPR = CUO_EMPR
                   AND DOC_EMPR = 1
                   AND A.DOC_TIPO_MOV = M.TMOV_CODIGO
                   AND A.DOC_EMPR = M.TMOV_EMPR

                   AND T.PDOC_CLAVE = A.PDDET_CLAVE_DOC(+)
                   AND T.PDOC_EMPR = A.PDDET_EMPR(+)
                   AND A.PDDET_CLAVE_CONCEPTO=C.PCON_CLAVE(+)
                   AND A.PDDET_EMPR = C.PCON_EMPR(+)
                   AND T.PDOC_CLAVE_FIN(+) = DOC_CLAVE
                   AND T.PDOC_EMPR(+) = DOC_EMPR

                   AND DOC_TIPO_MOV IN (81, 31)
                   AND CUO_IMP_MON > 0
                   AND NVL(A.COMI005_ESTADO,'P') = 'P'
                  -- AND CUO_FEC_VTO <= '''||P_FEC_FIN||'''
                   AND DOC_FEC_DOC >='01/'||TO_CHAR(TO_DATE (P_FECHA),'MM/YYYY')
                   AND DOC_PROV =  P_COD_PROV
            UNION ALL
                SELECT P_EMPRESA,
                       P_LEGAJO,
                       CASE WHEN C.DOC_LINEA_NEGOCIO = 4 THEN
                         28
                         ELSE
                          38
                        END DOC_TIPO_MOV,
                       CASE WHEN C.DOC_LINEA_NEGOCIO = 4 THEN
                            'COMBUSTIBLES(-)'
                            else
                            'EGRESOS VARIOS TRANS(-)'
                       END DETALLE,
                       P_CLAVE,
                       14,
                       E.CUO_FEC_VTO,
                       C.DOC_MON,
                       E.CUO_IMP_MON,
                       E.CUO_SALDO_MON,
                       C.DOC_OBS,
                       2,
                       null,
                       null
                  FROM FIN_DOCUMENTO C, FIN_CUOTA E, GEN_TIPO_MOV M
                 WHERE C.DOC_EMPR =  2
                   AND C.DOC_CLAVE = E.CUO_CLAVE_DOC
                   AND C.DOC_EMPR = E.CUO_EMPR
                   AND C.DOC_TIPO_MOV = M.TMOV_CODIGO
                   AND C.DOC_EMPR = M.TMOV_EMPR
                   AND C.DOC_SALDO_MON > 0
                   AND E.CUO_SALDO_MON > 0
                   AND C.DOC_CLI = V_COD_CLIENTE_TRA
                UNION ALL
                SELECT P_EMPRESA,
                       P_LEGAJO,
                        CASE WHEN C.DOC_LINEA_NEGOCIO = 4 THEN
                         28
                         ELSE
                          38
                        END DOC_TIPO_MOV,
                       CASE WHEN C.DOC_LINEA_NEGOCIO = 4 THEN
                            'COMBUSTIBLES(-)'
                            else
                            'EGRESOS VARIOS TRANS(-)'
                       END DETALLE,
                       P_CLAVE,
                       14,
                       E.CUO_FEC_VTO,
                       C.DOC_MON,
                       E.CUO_IMP_MON,
                       E.CUO_SALDO_MON,
                       C.DOC_OBS,
                       2,
                       null,
                       null
                  FROM FIN_DOCUMENTO C, FIN_CUOTA E, GEN_TIPO_MOV M
                 WHERE C.DOC_EMPR =  2
                   AND C.DOC_CLAVE = E.CUO_CLAVE_DOC
                   AND C.DOC_EMPR = E.CUO_EMPR
                   AND C.DOC_TIPO_MOV = M.TMOV_CODIGO
                   AND C.DOC_EMPR = M.TMOV_EMPR
                   AND C.DOC_SALDO_MON > 0
                   AND E.CUO_SALDO_MON > 0
                   AND C.DOC_TIPO_MOV IN (31)
                   AND C.DOC_PROV = V_COD_CLIENTE_TRA
             UNION ALL
                SELECT P_EMPRESA,
                       P_LEGAJO,
                       36,
                       'EGRESOS VARIOS(-)',
                       P_CLAVE,
                       14,
                       CUO.CUO_FEC_VTO,
                       A.DOC_MON,
                       CUO.CUO_IMP_MON,
                       CUO.CUO_SALDO_MON,
                       A.DOC_OBS,
                       1,
                       CUO_CLAVE_DOC,
                       m.tmov_codigo
                  FROM FIN_DOCUMENTO A, FIN_CUOTA CUO, GEN_TIPO_MOV M
                 WHERE DOC_CLAVE = CUO_CLAVE_DOC
                   AND DOC_EMPR = CUO_EMPR
                   AND DOC_EMPR = 1
                   AND A.DOC_TIPO_MOV = M.TMOV_CODIGO
                   AND A.DOC_EMPR = M.TMOV_EMPR
                   AND DOC_CLI =P_COD_CLI
                 AND DOC_TIPO_MOV NOT IN
                       (9, 11, 70, 22, 25, 12, 13, 48, 47, 24, 16, 75, 8)
                   AND CUO_SALDO_LOC > 0) LOOP

      X_CONTADOR:= X_CONTADOR+1;
         INSERT INTO PER_DESVINCULACION_DETALLE f
                      (DES_EMPR,
                       DES_LEGAJO,
                       DES_CON_COD,
                       DES_CON_DESC,
                       DES_CODIGO,
                       DES_TIPO,
                       DES_VENCIMIENTO,
                       DES_MONEDA,
                       DES_IMPORTE_CUO,
                       DES_IMPORTE,
                       DES_OBSERVACION,
                       DES_CUO_EMPR,
                       DES_NRO,
                       DES_COBRAR_CUO,
                       DES_CUO_CLAVE,
                       DES_LINEA_CRE )
                VALUES(C.P_EMPRESA,
                       C.EMPL_LEGAJO,
                       C.PCON_CLAVE,
                       C.PCON_DESC,
                       C.P_CLAVE,
                       C.TIPO,
                       C.CUO_FEC_VTO,
                       C.EMPL_MON_PAGO,
                       C.CUO_IMP_MON,
                       C.CUO_SALDO_MON,
                       C.FIN_OBS,
                       C.EMPR_CORR,
                       X_CONTADOR,
                       'N',
                       C.CUO_CLAVE_DOC,
                       C.TIPO_MOV);


  END LOOP;


X_CONTADOR:= 0;
------------------------*****
      FOR CP IN ( SELECT P_EMPRESA,
                         P_LEGAJO,
                         C.PCON_CLAVE,
                         C.PCON_DESC,
                         PDOC_MON,
                         B.PDDET_IMP,
                         B.PDDET_IMP IMPRT,
                         PDOC_OBS,
                         1 EMPRESA,
                         P_CLAVE,
                         15 TIPO,
                         PDOC_PERIODO,
                         'S' AFECTA_RRHH,
                         A.PDOC_CLAVE,
                         NVL(A.PDOC_CLAVE_FIN,B.PDDET_CLAVE_FIN) FINANZAS
                    FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_CONCEPTO C
                   WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
                     AND A.PDOC_EMPR = B.PDDET_EMPR
                     AND B.PDDET_CLAVE_CONCEPTO = C.PCON_CLAVE
                     AND B.PDDET_EMPR = C.PCON_EMPR
                     AND A.PDOC_EMPR = 1
                     AND PDOC_FEC >= '01/'||TO_CHAR(TO_DATE (P_FECHA),'MM/YYYY')
                     AND A.PDOC_EMPLEADO =P_LEGAJO
                     AND C.PCON_IND_DBCR= 'D'
                     AND C.PCON_CLAVE NOT IN (31,4))LOOP

                         X_CONTADOR:= X_CONTADOR+1;

                   INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MONEDA,
                               DES_IMPORTE_CUO,
                               DES_IMPORTE,
                               DES_OBSERVACION,
                               DES_CUO_EMPR,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_PERIODO,
                               DES_ACT_RRHH,
                               DES_NRO,
                               DES_CLAVE_RRHH,
                               DES_CLAVE_FIN)
                         VALUES(
                               CP.P_EMPRESA,
                               CP.P_LEGAJO,
                               CP.PCON_CLAVE,
                               CP.PCON_DESC,
                               CP.PDOC_MON,
                               CP.PDDET_IMP,
                               CP.PDDET_IMP,
                               CP.PDOC_OBS,
                               CP.EMPRESA,
                               CP.P_CLAVE,
                               CP.TIPO,
                               CP.PDOC_PERIODO,
                               CP.AFECTA_RRHH,
                               X_CONTADOR,
                               CP.PDOC_CLAVE,
                               CP.FINANZAS);

      END LOOP;

 ELSIF P_EMPRESA = 2 THEN
   BEGIN
      SELECT CLI_CATEG
        INTO X_CATEGORIA
        FROM FIN_CLIENTE
       WHERE CLI_CODIGO = P_COD_CLI
         AND CLI_CATEG IN (3)
         AND CLI_EMPR = 2;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      X_CATEGORIA := NULL;
    END;

    DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   IN (15,14,144);

    X_CONTADOR :=0;
     FOR C IN ( SELECT P_EMPRESA,
                       EMPL_LEGAJO,
                       A.PCON_CLAVE,
                       A.PCON_DESC,
                       P_CLAVE,
                       14 TIPO,
                       CUO_FEC_VTO,
                       EMPL_MON_PAGO,
                       CUO_IMP_MON,
                       CUO_SALDO_MON,
                       FIN_OBS,
                       2 EMPR_CORR,
                       31 TIPO_MOV,
                       CUO_CLAVE_DOC DOC_CLAVE,
                       NULL FAC_cATEGORIA,
                       NULL LINEA,
                       NULL NRO_DOC,
                       NULL DES_C_FEC_DOC
                  FROM PER_PERI047_V_TAGRO T,PER_CONCEPTO A
                    WHERE A.PCON_CLAVE = T.PCON_CANCELADO_POR_CONC
                    AND A.PCON_EMPR = 2
                    AND  T.EMPL_LEGAJO =P_LEGAJO
                    UNION ALL
                 SELECT P_EMPRESA,
                        P_LEGAJO,
                     CASE WHEN DOC_LINEA_NEGOCIO IN (9, 4, 1,7) AND DOC_PER_CONCEPTO  = 1 THEN
                          13
                      WHEN DOC_LINEA_NEGOCIO IN (9,1,7) OR (DOC_PER_CONCEPTO  = 2  AND DOC_LINEA_NEGOCIO =4) THEN
                         32
                      WHEN DOC_LINEA_NEGOCIO IN (4) THEN
                          29
                      WHEN DOC_LINEA_NEGOCIO =5 THEN
                         35
                    END CONCEPTO_CLAVE,
                     CASE WHEN DOC_LINEA_NEGOCIO IN (9, 4, 1,7) AND DOC_PER_CONCEPTO  = 1 THEN
                          'UNIFORMES(-)'
                      WHEN DOC_LINEA_NEGOCIO IN (9,1,7) OR (DOC_PER_CONCEPTO  = 2  AND DOC_LINEA_NEGOCIO =4) THEN
                          'AUTOSERVICE(-)'
                      WHEN DOC_LINEA_NEGOCIO IN (4) THEN
                          'COMBUSTIBLE(-)'
                        WHEN DOC_LINEA_NEGOCIO =5 THEN
                          'REPUESTOS(-)'
                    END CONCEPTO_DES,
                    P_CLAVE,
                    144 TIPO,
                     CUO.CUO_FEC_VTO,
                     A.DOC_MON,
                     CUO.CUO_IMP_MON,
                     CUO.CUO_SALDO_MON,
                     F.LIN_DESC,--A.DOC_OBS,
                     2,
                     DOC_TIPO_MOV,
                     DOC_CLAVE,
                     3,
                 CASE WHEN DOC_LINEA_NEGOCIO IN (9, 4, 1,7) AND DOC_PER_CONCEPTO  = 1 THEN
                          0
                      WHEN DOC_LINEA_NEGOCIO IN (9,  1,7) OR (DOC_PER_CONCEPTO  = 2  AND DOC_LINEA_NEGOCIO =4) THEN
                          9
                      WHEN DOC_LINEA_NEGOCIO IN (4) THEN
                          4
                      WHEN DOC_LINEA_NEGOCIO = 5 THEN
                          5
                    END LINEA,
                    DOC_NRO_DOC,
                    DOC_FEC_DOC
                FROM FIN_DOCUMENTO A, FIN_CUOTA CUO, GEN_TIPO_MOV M, FAC_LINEA_NEGOCIO F
               WHERE DOC_CLAVE = CUO_CLAVE_DOC
                 AND DOC_EMPR = CUO_EMPR
                 AND DOC_EMPR = 2
                 AND A.DOC_TIPO_MOV = M.TMOV_CODIGO
                 AND A.DOC_EMPR = M.TMOV_EMPR
                 AND DOC_CLI =P_COD_CLI
                AND DOC_TIPO_MOV NOT IN
                     (9, 11, 70, 22, 25, 12, 13, 48, 47, 24, 16, 75, 8)
                 AND CUO_SALDO_LOC > 0
                 AND DOC_LINEA_NEGOCIO = F.LIN_CODIGO(+)
                 AND DOC_EMPR = F.LIN_EMPR(+)
                 AND X_CATEGORIA = 3 ) LOOP



         X_CONTADOR:= X_CONTADOR+1;
         INSERT INTO PER_DESVINCULACION_DETALLE f
                      (DES_EMPR,
                       DES_LEGAJO,
                       DES_CON_COD,
                       DES_CON_DESC,
                       DES_CODIGO,
                       DES_TIPO,
                       DES_VENCIMIENTO,
                       DES_MONEDA,
                       DES_IMPORTE_CUO,
                       DES_IMPORTE,
                       DES_OBSERVACION,
                       DES_CUO_EMPR,
                       DES_NRO,
                       DES_CUO_TIPO_MOV,
                       DES_CUO_CLAVE,
                       DES_CUO_MOSTRAR,
                       DES_LINEA_CRE,
                       DES_C_DOC_NRO_DOC,
                       DES_C_FEC_DOC )
                VALUES(C.P_EMPRESA,
                       C.EMPL_LEGAJO,
                       C.PCON_CLAVE,
                       C.PCON_DESC,
                       C.P_CLAVE,
                       C.TIPO,
                       C.CUO_FEC_VTO,
                       C.EMPL_MON_PAGO,
                       C.CUO_IMP_MON,
                       C.CUO_SALDO_MON,
                       C.FIN_OBS,
                       C.EMPR_CORR,
                       X_CONTADOR,
                       C.TIPO_MOV,
                       C.DOC_CLAVE,
                       'S',
                       C.LINEA,
                       C.NRO_DOC,
                       C.DES_C_FEC_DOC);


  END LOOP;


   X_CONTADOR:= 0;
------------------------*****
      FOR CP IN ( SELECT P_EMPRESA,
                         P_LEGAJO,
                         C.PCON_CLAVE,
                         C.PCON_DESC,
                         PDOC_MON,
                         B.PDDET_IMP,
                         B.PDDET_IMP IMPRT,
                         PDOC_OBS,
                         1 EMPRESA,
                         P_CLAVE,
                         15 TIPO,
                         PDOC_PERIODO,
                         'S' AFECTA_RRHH,
                         A.PDOC_CLAVE,
                         NVL(A.PDOC_CLAVE_FIN,B.PDDET_CLAVE_FIN) FINANZAS
                    FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_CONCEPTO C
                   WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
                     AND A.PDOC_EMPR = B.PDDET_EMPR
                     AND B.PDDET_CLAVE_CONCEPTO = C.PCON_CLAVE
                     AND B.PDDET_EMPR = C.PCON_EMPR
                     AND A.PDOC_EMPR = 2
                     AND PDOC_FEC >= '01/'||TO_CHAR(TO_DATE (P_FECHA),'MM/YYYY')
                     AND A.PDOC_EMPLEADO =P_LEGAJO
                     AND C.PCON_IND_DBCR= 'D'
                     AND C.PCON_CLAVE NOT IN (31,4))LOOP

                         X_CONTADOR:= X_CONTADOR+1;

                   INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MONEDA,
                               DES_IMPORTE_CUO,
                               DES_IMPORTE,
                               DES_OBSERVACION,
                               DES_CUO_EMPR,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_PERIODO,
                               DES_ACT_RRHH,
                               DES_NRO,
                               DES_CLAVE_RRHH,
                               DES_CLAVE_FIN)
                         VALUES(
                               CP.P_EMPRESA,
                               CP.P_LEGAJO,
                               CP.PCON_CLAVE,
                               CP.PCON_DESC,
                               CP.PDOC_MON,
                               CP.PDDET_IMP,
                               CP.PDDET_IMP,
                               CP.PDOC_OBS,
                               CP.EMPRESA,
                               CP.P_CLAVE,
                               CP.TIPO,
                               CP.PDOC_PERIODO,
                               CP.AFECTA_RRHH,
                               X_CONTADOR,
                               CP.PDOC_CLAVE,
                               CP.FINANZAS);

      END LOOP;


   END IF;



 END PP_DEUDAS_EMPL;
 PROCEDURE PP_COBRO_CUOTA (P_EMPRESA       IN NUMBER,
                           P_LEGAJO        IN NUMBER,
                           P_PERIODO       IN NUMBER,
                           P_FEC_DOCUMENTO IN DATE,
                           P_NRO_DOC       IN NUMBER,
                           P_BANCO         IN NUMBER,
                           P_MONEDA        IN NUMBER,
                           P_TASA          IN NUMBER,
                           P_SUCURAL       IN NUMBER,
                           P_OBS           IN VARCHAR2,
                           P_CLAVE         IN NUMBER) IS

V_PERI_INI DATE;
V_PERI_FIN DATE;
V_CLIENTE NUMBER;
V_EMPL_CODIGO_PROV NUMBER;
V_SITUACION VARCHAR2(10);
BEGIN


IF P_FEC_DOCUMENTO is null THEN
    RAISE_APPLICATION_ERROR (-20001, 'La fecha del documento no puede quedar vacia');
  END IF;

   IF P_NRO_DOC IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'El nro de documento no puede quedar vacio');
  END IF;
  IF P_BANCO IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'El banco no puede quedar vacio');
  END IF;

  IF P_MONEDA IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'la moneda no puede quedar vacia');
  END IF;

   SELECT EMPL_COD_CLIENTE, EMPL_CODIGO_PROV, EMPL_SITUACION 
   INTO V_CLIENTE, V_EMPL_CODIGO_PROV, V_SITUACION
   FROM PER_EMPLEADO A
   WHERE EMPL_LEGAJO = P_LEGAJO
     AND EMPL_EMPRESA = P_EMPRESA;


  IF V_SITUACION = 'I' THEN
     RAISE_APPLICATION_ERROR (-20001, 'El empleado esta inactivo');
  END IF;
   SELECT PERI_FEC_INI, PERI_FEC_FIN
    INTO V_PERI_INI, V_PERI_FIN
    FROM  PER_PERIODO
   WHERE PERI_EMPR= P_EMPRESA
   AND PERI_CODIGO = P_PERIODO;


         FOR X IN (SELECT T.DES_CUO_CLAVE||'-'||TO_CHAR(T.DES_VENCIMIENTO,'DD/MM/YYYY') CLAV_VTO
                     FROM PER_DESVINCULACION_DETALLE T
                    WHERE T.DES_LEGAJO = P_LEGAJO
                      AND T.DES_TIPO = 14
                      AND T.DES_EMPR = P_EMPRESA
                      AND T.DES_COBRAR_CUO ='S'
                      AND DES_LINEA_CRE  IS NOT NULL
                      AND T.DES_CODIGO = P_CLAVE) LOOP


              IF V_CLIENTE IS NOT NULL THEN

                BEGIN

                  FINI003.PP_DAR_BAJA_FACT_CRED_EMPL(I_EMPRESA    => P_EMPRESA,
                                                     I_CLIENTE    => V_CLIENTE,
                                                     I_CLAVE_VTO  => X.CLAV_VTO);
                END;

              END IF;
        END LOOP;

      BEGIN

      /*  PERI247.PP_CARGAR_DETALLE(PERI_FEC_FIN           => V_PERI_FIN,
                                  S_PDDET_CLAVE_CONCEPTO => NULL,
                                  TEC_LEGAJO             => P_LEGAJO,
                                  S_MON                  => P_MONEDA,
                                  I_EMPRESA              => P_EMPRESA,
                                  RADIO_GROUP            => 3,
                                  I_SUCURSAL             => P_SUCURAL,
                                  I_PROG                 => 'PERC002');*/
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'PERI247') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'PERI247');
    END IF;
    APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'PERI247',
                                                   P_QUERY           => 'SELECT EMPL_LEGAJO,
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
                                                                         WHERE EMPL_EMPRESA = '||P_EMPRESA||'
                                                                           AND EMPL_LEGAJO = '||P_LEGAJO||'
                                                                           AND CUO_CLAVE_DOC ||''-''|| TO_CHAR(CUO_FEC_VTO, ''DD/MM/YYYY'') NOT IN
                                                                               (SELECT T.DES_CUO_CLAVE ||''-''||TO_CHAR(T.DES_VENCIMIENTO, ''DD/MM/YYYY'')
                                                                                  FROM PER_DESVINCULACION_DETALLE T
                                                                                 WHERE T.DES_LEGAJO ='||P_LEGAJO||'
                                                                                   AND T.DES_EMPR = '||P_EMPRESA||'
                                                                                   AND T.DES_TIPO = 14
                                                                                   AND NVL(T.DES_COBRAR_CUO,''N'') = ''N''
                                                                                   AND T.DES_CODIGO = '||P_CLAVE||')');



      END;


      BEGIN
        PERI247.PP_ACTUALIZAR_REGISTRO(I_PDOC_FEC      => P_FEC_DOCUMENTO,
                                       I_PDOC_NRO_DOC  => P_NRO_DOC,
                                       I_EMPRESA       => P_EMPRESA,
                                       I_PERIODO       => P_PERIODO,
                                       I_MON_LOC       => 1,
                                       I_TASA_OFIC     => P_TASA,
                                       I_DOC_CTA_BCO   => P_BANCO,
                                       I_MON           => P_MONEDA,
                                       I_COD_SUCURSAL  => P_SUCURAL,
                                       I_DOC_OBS       => P_OBS);
      END;


  PERC002.PP_DEUDAS_EMPL(P_EMPRESA  => P_EMPRESA,
                         P_LEGAJO   => P_LEGAJO,
                         P_COD_CLI  => V_CLIENTE,
                         P_COD_PROV => V_EMPL_CODIGO_PROV,
                         P_CLAVE    => P_CLAVE,
                         P_FECHA    => V_PERI_FIN);

 END PP_COBRO_CUOTA;




PROCEDURE PP_ELIMINAR_REGISTROS (P_EMPRESA IN  NUMBER,
                                 P_LEGAJO  IN NUMBER,
                                 P_CLAVE   IN NUMBER,
                                 P_TIPO    IN NUMBER,
                                 P_FECHA   IN DATE,
                                 P_NRO     IN NUMBER,
                                 P_CONCEPTO IN NUMBER)IS
V_FORMA_PAGO NUMBER;
V_DPTO NUMBER;
V_SUC NUMBER;

V_CLAVE_FIN  NUMBER;
V_CLAVE_RRHH NUMBER;
V_CTA_BCO    NUMBER;
V_DOC_NRO    NUMBER;
BEGIN

---  RAISE_APPLICATION_ERROR (-20001,P_NRO||'-'||P_TIPO);

SELECT EMPL_FORMA_PAGO, EMPL_DEPARTAMENTO, EMPL_SUCURSAL
      INTO V_FORMA_PAGO,V_DPTO, V_SUC
      FROM PER_EMPLEADO
     WHERE EMPL_EMPRESA = P_EMPRESA
       AND EMPL_LEGAJO = P_LEGAJO;

     SELECT  A.DES_CLAVE_RRHH
     INTO V_CLAVE_RRHH
     FROM PER_DESVINCULACION_DETALLE A
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_CON_COD = P_CONCEPTO
       AND DES_TIPO   = P_TIPO
       AND DES_NRO    = P_NRO;

  ------------------------------------------****

  IF V_CLAVE_RRHH IS NOT NULL THEN
     SELECT NVL(B.PDDET_CLAVE_FIN, A.PDOC_CLAVE_FIN) CLAVE, A.PDOC_NRO_DOC
       INTO V_CLAVE_FIN, V_DOC_NRO
       FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B
      WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
        AND A.PDOC_EMPR = B.PDDET_EMPR
        AND A.PDOC_CLAVE = V_CLAVE_RRHH
        AND A.PDOC_EMPR = P_EMPRESA;


         IF V_CLAVE_FIN IS NOT NULL THEN

           SELECT DOC_CTA_BCO
             INTO V_CTA_BCO
             FROM FIN_DOCUMENTO
            WHERE DOC_EMPR = P_EMPRESA
              AND DOC_CLAVE = V_CLAVE_FIN;

         END IF;
              BEGIN
                -- CALL THE PROCEDURE
                PERI206.PP_BORRAR_REGISTRO(I_DOC_CTA_BCO => V_CTA_BCO,
                                           I_EMPRESA     => P_EMPRESA,
                                           W_CLAVE       => V_CLAVE_RRHH,
                                           I_CHK_OC      => NULL,
                                           I_DOC_CLAVE   => V_CLAVE_FIN,
                                           I_NRODOC      => V_DOC_NRO);
              END;

    END IF;
   -------------------------------------------------*****


--RAISE_APPLICATION_ERROR (-20001,'ADFAD');
    DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   = P_TIPO
       AND DES_NRO    = P_NRO;


    IF P_TIPO = 13 THEN
      DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   = 14
       AND DES_NRO    = P_NRO;

    END  IF;

    IF P_TIPO = 13 THEN
      DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   = 12
       AND DES_NRO    = P_NRO;

    END  IF;

   IF P_TIPO = 2 THEN
      DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   =20
       AND DES_NRO    = P_NRO;
    END  IF;

   IF P_TIPO = 5 THEN
      DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   = 4
       AND DES_NRO    = P_NRO;
    END  IF;


    IF P_TIPO = 32  THEN
      UPDATE TRA_ORDEN_CARGA
         SET OCA_CLAVE_PER_PAGO = NULL
       WHERE OCA_EMPR = P_EMPRESA
         AND OCA_CLAVE IN (SELECT DES_TRA_OR_CLAVE
                             FROM  PER_DESVINCULACION_DETALLE
                           WHERE DES_CODIGO = P_CLAVE
                             AND DES_EMPR   = P_EMPRESA
                             AND DES_LEGAJO = P_LEGAJO
                             AND DES_TIPO   = 31);





     DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   = 31;
    ---   AND DES_NRO    = P_NRO;

    END IF;


   IF P_TIPO = 34  THEN

   DELETE TRA_ODEN_CARGA_EMPL
    WHERE OCC_LEGAJO = P_LEGAJO
      AND OCC_EMPR = P_EMPRESA
      AND OCC_ORDEN_CLAVE IN  (SELECT DES_TRA_OR_CLAVE
                                 FROM PER_DESVINCULACION_DETALLE
                                WHERE DES_CODIGO = P_CLAVE
                                  AND DES_EMPR   = P_EMPRESA
                                  AND DES_LEGAJO = P_LEGAJO
                                  AND DES_TIPO   = 33);



     DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   = 33;
    ---   AND DES_NRO    = P_NRO;

    END IF;

    PERC002.PP_AGUINALDO_MES_ACT(P_EMPRESA => P_EMPRESA,
                                   P_LEGAJO  => P_LEGAJO,
                                   P_CLAVE   => P_CLAVE,
                                   P_DPTO    => V_DPTO,
                                   P_SUC     => V_SUC,
                                   P_FECHA   => P_FECHA);

END PP_ELIMINAR_REGISTROS;


PROCEDURE PP_BUSCAR_CONCEPTO (P_EMPRESA IN NUMBER,
                              P_CONCEPTO IN NUMBER,
                              P_CON_DES  OUT VARCHAR2,
                              P_IND_IPS  OUT VARCHAR2,
                              P_TIPO_MOV OUT NUMBER,
                              P_TIPO_MOV_dES OUT VARCHAR2) IS

BEGIN
  SELECT T.PCON_DESC,  T.PCON_IND_IPS, PCON_FIN_TMOV
  INTO P_CON_DES,P_IND_IPS, P_TIPO_MOV
    FROM PER_CONCEPTO T
   WHERE T.PCON_EMPR=P_EMPRESA
     AND PCON_CLAVE =P_CONCEPTO;


    IF P_TIPO_MOV IS NOT NULL THEN
      SELECT TMOV_DESC
        INTO P_TIPO_MOV_dES
        FROM GEN_TIPO_MOV
       WHERE TMOV_CODIGO = P_TIPO_MOV
         AND TMOV_EMPR = P_EMPRESA;
    END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN
RAISE_APPLICATION_ERROR(-20001,'Concepto inexistente');
END PP_BUSCAR_CONCEPTO ;






PROCEDURE PP_AGUINALDO_MES_ACT (P_EMPRESA IN NUMBER,
                                P_LEGAJO  IN NUMBER,
                                P_CLAVE   IN NUMBER,
                                P_DPTO    IN NUMBER,
                                P_SUC     IN NUMBER,
                                P_FECHA   IN DATE)IS

AG_IMPORTE NUMBER;
AG_IMPORTE_TOT NUMBER;
BEGIN

    DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA
       AND DES_LEGAJO = P_LEGAJO
       AND DES_TIPO   IN (12,13)
       AND DES_AG = 1;


SELECT ROUND(SUM(T.DES_IMPORTE))
    INTO AG_IMPORTE
    FROM PER_DESVINCULACION_DETALLE T, PER_CONCEPTO A
    WHERE T.DES_CON_COD = A.PCON_CLAVE
    AND T.DES_EMPR = A.PCON_EMPR
    AND A.PCON_IND_AGUINALDO = 'S'
    AND T.DES_EMPR = P_EMPRESA
    AND T.DES_LEGAJO =  P_LEGAJO
    AND T.DES_CODIGO = P_CLAVE
    AND NVL(T.DES_AFC_AG,'N') = 'N'
    AND T.DES_TIPO IN (1,2,3,5,6,7,8,9,30,32,34,40);--33,31);

                   INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               3,
                               'AGUINALDO',
                               TO_CHAR(P_FECHA,'MM/YYYY'),
                               ROUND(AG_IMPORTE),
                               P_CLAVE,
                               12,
                               P_DPTO,
                               P_SUC,
                               1,
                               13);




  SELECT ROUND(SUM(T.DES_IMPORTE) /12)
    INTO AG_IMPORTE_TOT
    FROM PER_DESVINCULACION_DETALLE T
    WHERE  T.DES_EMPR = P_EMPRESA
    AND T.DES_LEGAJO =  P_LEGAJO
    AND T.DES_CODIGO = P_CLAVE
    AND NVL(T.DES_AFC_AG,'N') = 'N'
    AND T.DES_TIPO IN (12);

                   INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               3,
                               'AGUINALDO',
                               TO_CHAR(P_FECHA,'MM/YYYY'),
                               ROUND(AG_IMPORTE_TOT),
                               P_CLAVE,
                               13,
                               P_DPTO,
                               P_SUC,
                               1,
                               1);


END PP_AGUINALDO_MES_ACT;


PROCEDURE PP_GUARDAR_RRHH (P_EMPRESA    IN NUMBER,
                           P_LEGAJO     IN NUMBER,
                           P_CLAVE_DES  IN NUMBER,
                           P_FECHA      IN DATE,
                           P_NRO_DOC    IN NUMBER,
                           P_MONEDA     IN NUMBER,
                           P_TASA       IN NUMBER,
                           P_OBS        IN VARCHAR2) IS


V_CLAVE NUMBER;

V_PERIODO NUMBER;

V_QUINCENA NUMBER;

V_SALARIO_cHOFER NUMBER;

V_SALARIO_TRANS NUMBER;
BEGIN


 IF  P_FECHA  IS NULL THEN
   RAISE_APPLICATION_ERROR (-20001, 'La fecha no puede quedar vacia');
 END IF;
 IF  P_NRO_DOC  IS NULL THEN
   RAISE_APPLICATION_ERROR (-20001, 'El numero de documento no puede quedar vacio');
 END IF;
  IF  P_MONEDA  IS NULL THEN
   RAISE_APPLICATION_ERROR (-20001, 'La moneda no puede quedar vacia');
 END IF;
  IF  P_OBS  IS NULL THEN
   RAISE_APPLICATION_ERROR (-20001, 'La observacion no puede quedar vacia');
 END IF;


    SELECT PERI_CODIGO
    INTO V_PERIODO
    FROM  PER_PERIODO
   WHERE PERI_EMPR= P_EMPRESA
   AND P_FECHA BETWEEN PERI_FEC_INI AND  PERI_FEC_FIN;

V_CLAVE := PERI005.FP_CLAVE_DOC(I_EMPRESA => P_EMPRESA);


      IF TO_NUMBER(TO_CHAR(P_FECHA,'DD')) > 15 THEN
        V_QUINCENA := 2;
      ELSE
        V_QUINCENA := 1;
      END IF;
IF P_EMPRESA =1 THEN--IS NULL THEN
  
 
 

           FOR K IN (
                    SELECT T.DES_SUC,
                           T.DES_DPTO,
                           T.DES_CON_COD,
                           T.DES_CON_COD||'- '||T.DES_CON_DESC CONCEPTO,
                           T.DES_IMPORTE,
                           DES_DIAS,
                           T.DES_IMP_DIARIO,
                           T.DES_EST_PLUS,
                           T.DES_DESDE,
                           T.DES_HASTA,
                           T.DES_MOT_AUSE,
                           T.DES_CANT_PRO,
                           T.DES_CODIGO,
                           T.DES_TIPO,
                           CASE WHEN DES_CON_COD = 4 THEN
                             100
                             ELSE
                               DES_TIPO END ORDEN,
                                A.PCON_IND_DBCR,
                                T.DES_NRO,
                                T.DES_COD_PLUS
                      FROM PER_DESVINCULACION_DETALLE T, PER_CONCEPTO A
                     WHERE T.DES_EMPR = A.PCON_EMPR
                       AND T.DES_CON_COD = A.PCON_CLAVE
                       AND T.DES_EMPR =  P_EMPRESA
                       AND T.DES_LEGAJO =P_LEGAJO
                       AND T.DES_CODIGO = P_CLAVE_DES
                       AND T.DES_TIPO NOT IN (12,20,4,14,15,144)
                       AND T.DES_CLAVE_RRHH IS NULL
                       ORDER BY 13, 14 ) LOOP






                  V_CLAVE := V_CLAVE + 1;

                PERI005.PP_INS_PER_DOC(V_CLAVE,
                                       V_QUINCENA,
                                       P_LEGAJO,
                                       P_FECHA,
                                       P_NRO_DOC,
                                       SYSDATE,
                                       GEN_DEVUELVE_USER,
                                       'PERC002',
                                       V_PERIODO,
                                       NULL,
                                       1,
                                       K.DES_CON_COD,
                                       K.DES_IMPORTE,
                                       K.DES_IMPORTE * P_TASA,
                                       P_MONEDA,
                                       K.DES_DPTO,
                                       P_EMPRESA,
                                       26,
                                       31,
                                       'HILAGRO S.A.',
                                       P_OBS,
                                       K.DES_DIAS);


               UPDATE PER_DESVINCULACION_DETALLE T
              SET  DES_ACT_RRHH = 'S',
                   T.DES_CLAVE_RRHH  = V_CLAVE
            WHERE  T.DES_EMPR =  P_EMPRESA
               AND T.DES_LEGAJO =P_LEGAJO
               AND T.DES_CODIGO = P_CLAVE_DES
               AND T.DES_CON_COD =  K.DES_CON_COD
               AND T.DES_NRO = K.DES_NRO
               AND T.DES_TIPO   =K.DES_TIPO;
               
   
 IF  K.DES_TIPO = 3 and p_empresa = 1 THEN 
      UPDATE PER_EMPL_PLUS_SALARIAL A
        SET EPS_FEC_DOC            = TO_CHAR(SYSDATE, 'DD-MM-YYYY'),
               A.EPS_ESTADO_RRHH      = 'C',
               A.EPS_OPER_RRHH        = GEN_DEVUELVE_USER,
               A.EPS_FEC_APRO_RRHH    = SYSDATE
         WHERE A.EPS_CLAVE = K.DES_COD_PLUS
           AND A.EPS_EMPR = P_EMPRESA;
 END IF;
            
  IF  K.DES_CON_COD = 12 AND  K.DES_TIPO IN (4,5) THEN         

   UPDATE PER_COMISIONES_LOG_PROC PR
               SET PR.PROCOM_MONTO         = K.DES_IMPORTE,
                   PR.PROCOM_IPS           = K.DES_IMPORTE*0.09,
                   PR.PROCOM_FECHA         = TO_CHAR(SYSDATE, 'DD-MM-YYYY'),
                   PR.PROCOM_OPER          = GEN_DEVUELVE_USER,
                   PR.PROCOM_CLAVE_PER_DOC = V_CLAVE
             WHERE PR.PROCOM_LEG_EMPL = P_LEGAJO
               AND PR.PROCOM_EMPR = P_EMPRESA
               AND PR.PROCOM_PERI = V_PERIODO;
 END IF;




           END LOOP;
 ELSE
              FOR K IN (
                    SELECT T.DES_SUC,
                           T.DES_DPTO,
                           T.DES_CON_COD,
                           T.DES_CON_COD||'- '||T.DES_CON_DESC CONCEPTO,
                           T.DES_IMPORTE,
                           DES_DIAS,
                           T.DES_IMP_DIARIO,
                           T.DES_EST_PLUS,
                           T.DES_DESDE,
                           T.DES_HASTA,
                           T.DES_MOT_AUSE,
                           T.DES_CANT_PRO,
                           T.DES_CODIGO,
                           T.DES_TIPO,
                           CASE WHEN DES_CON_COD = 4 THEN
                             100
                             ELSE
                               DES_TIPO END ORDEN,
                                A.PCON_IND_DBCR,
                                T.DES_NRO
                      FROM PER_DESVINCULACION_DETALLE T, PER_CONCEPTO A
                     WHERE T.DES_EMPR = A.PCON_EMPR
                       AND T.DES_CON_COD = A.PCON_CLAVE
                       AND T.DES_EMPR =  P_EMPRESA
                       AND T.DES_LEGAJO =P_LEGAJO
                       AND T.DES_CODIGO = P_CLAVE_DES
                       AND T.DES_TIPO NOT IN (12,20,4,14,15,32)
                       AND T.DES_CLAVE_RRHH IS NULL
                       ORDER BY 13, 14 ) LOOP





               V_CLAVE := V_CLAVE + 1;

                PERI005.PP_INS_PER_DOC(V_CLAVE,
                                       V_QUINCENA,
                                       P_LEGAJO,
                                       P_FECHA,
                                       P_NRO_DOC,
                                       SYSDATE,
                                       GEN_DEVUELVE_USER,
                                       'PERC002',
                                       V_PERIODO,
                                       NULL,
                                       1,
                                       K.DES_CON_COD,
                                       K.DES_IMPORTE,
                                       K.DES_IMPORTE * P_TASA,
                                       P_MONEDA,
                                       K.DES_DPTO,
                                       P_EMPRESA,
                                       26,
                                       31,
                                       'TRANSAGRO S.A.',
                                       P_OBS,
                                       K.DES_DIAS);


           UPDATE PER_DESVINCULACION_DETALLE T
              SET  DES_ACT_RRHH = 'S',
                   T.DES_CLAVE_RRHH  = V_CLAVE
            WHERE  T.DES_EMPR =  P_EMPRESA
               AND T.DES_LEGAJO =P_LEGAJO
               AND T.DES_CODIGO = P_CLAVE_DES
               AND T.DES_CON_COD =  K.DES_CON_COD
               AND T.DES_NRO = K.DES_NRO
               AND T.DES_TIPO   =K.DES_TIPO;

           END LOOP;





  SELECT COUNT(*)
  INTO V_SALARIO_cHOFER
  FROM PER_DESVINCULACION_DETALLE T
 WHERE T.DES_EMPR =  P_EMPRESA
   AND T.DES_LEGAJO =P_LEGAJO
   AND T.DES_TIPO IN (32);
   V_CLAVE := V_CLAVE +1;
 IF V_SALARIO_cHOFER > 0 THEN
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
                     --PDOC_CLAVE_FIN,
                     PDOC_MON,
                     PDOC_EMPR,
                     PDOC_OBS)
                  VALUES
                    (V_CLAVE,
                     V_QUINCENA,
                     P_LEGAJO,
                     P_FECHA,
                     P_NRO_DOC,
                     SYSDATE,
                     GEN_DEVUELVE_USER,
                     'PERC002',
                     V_PERIODO,
                     --IPDOC_CLAVE_FIN,
                     P_MONEDA,
                     P_EMPRESA,
                     P_OBS);

          UPDATE PER_DESVINCULACION_DETALLE T
              SET  DES_ACT_RRHH = 'S',
                   T.DES_CLAVE_RRHH  = V_CLAVE
            WHERE  T.DES_EMPR =  P_EMPRESA
               AND T.DES_LEGAJO =P_LEGAJO
               AND T.DES_CODIGO = P_CLAVE_DES
               AND T.DES_CON_COD IN (2,4)----  K.DES_CON_COD
               AND T.DES_NRO = 1--K.DES_NRO
               AND T.DES_TIPO   =32;



       FOR CAR IN ( SELECT T.DES_NRO,
                           2 CONCEPTO,
                           T.DES_TRA_SUELDO,
                           1  PDDET_CANTIDAD,
                           0  PDDET_PORCENTAJE,
                           'N' PDDET_PROCESO_IPS,
                           T.DES_TRA_SUELDO SUELDO,
                           T.DES_TRA_CAMION,
                           T.DES_TRA_ORDEN,
                           T.DES_TRA_OR_CLAVE
                      FROM PER_DESVINCULACION_DETALLE T
                     WHERE T.DES_EMPR = P_EMPRESA
                       AND T.DES_LEGAJO = P_LEGAJO
                      -- AND T.DES_CODIGO = 2
                       AND T.DES_TIPO = 31
                    UNION ALL
                    SELECT COUNT(DES_NRO) + 1 DES_NRO,
                           4 CONCEPTO,
                           SUM(T.DES_TRA_IPS) DES_TRA_SUELDO,
                           1 PDDET_CANTIDAD,
                           0 PDDET_PORCENTAJE,
                           'N' PDDET_PROCESO_IPS ,
                           SUM(T.DES_TRA_IPS)SUELDO ,
                           null,
                           MAX(T.DES_TRA_ORDEN),
                           NULL
                      FROM PER_DESVINCULACION_DETALLE T
                     WHERE T.DES_EMPR = P_EMPRESA
                       AND T.DES_LEGAJO = P_LEGAJO
                     ---  AND T.DES_CODIGO = 4
                       AND T.DES_TIPO = 31) LOOP

       INSERT INTO PER_DOCUMENTO_DET
                    (PDDET_CLAVE_DOC,
                     PDDET_ITEM,
                     PDDET_CLAVE_CONCEPTO,
                     PDDET_IMP,
                     PDDET_CANTIDAD,
                     PDDET_PORCENTAJE,
                     PDDET_PROCESO_IPS,
                     PDDET_IMP_LOC,
                     PDDET_CAMION,
                     PDDET_OC,
                     PDDET_EMPR)
                 VALUES
                     (V_CLAVE ,
                      CAR.DES_NRO,
                      CAR.CONCEPTO,
                      CAR.DES_TRA_SUELDO,
                      CAR.PDDET_CANTIDAD,
                      CAR.PDDET_PORCENTAJE,
                      CAR.PDDET_PROCESO_IPS,
                      CAR.SUELDO,
                      CAR.DES_TRA_CAMION,
                      CAR.DES_TRA_ORDEN,
                      P_EMPRESA);







     IF CAR.DES_TRA_OR_CLAVE IS NOT NULL AND CAR.CONCEPTO = 2 THEN
      UPDATE TRA_ORDEN_CARGA
         SET OCA_CLAVE_PER_PAGO = V_CLAVE
       WHERE OCA_CLAVE = CAR.DES_TRA_OR_CLAVE
       AND OCA_EMPR = P_EMPRESA;
     END IF;
  END LOOP;

 SELECT COUNT(*)
  INTO V_SALARIO_TRANS
  FROM PER_DESVINCULACION_DETALLE T
 WHERE T.DES_EMPR =  P_EMPRESA
   AND T.DES_LEGAJO =P_LEGAJO
   AND T.DES_TIPO IN (33);

   IF V_SALARIO_TRANS >0 THEN
        INSERT INTO TRA_ODEN_CARGA_EMPL
        (OCC_ORDEN_CLAVE, OCC_LEGAJO, OCC_EMPR)
        (SELECT  T.DES_TRA_OR_CLAVE, T.DES_LEGAJO, P_EMPRESA
          FROM PER_DESVINCULACION_DETALLE T
         WHERE T.DES_EMPR = P_EMPRESA
           AND T.DES_LEGAJO = P_LEGAJO
           AND T.DES_TIPO = 33);
   END IF;
  END IF;

 END IF;


END PP_GUARDAR_RRHH;



PROCEDURE PP_BORRAR_DATOS (P_EMPRESA IN NUMBER,
                           P_CLAVE   IN NUMBER,
                           P_ACT     IN VARCHAR2) IS


BEGIN

IF NVL(P_ACT,'N')  <> 'S' THEN
    DELETE PER_REGISTRO_DESVINC_EMPL_DET
     WHERE  RDED_CLAVE=P_CLAVE
      AND RDED_EMPR=P_EMPRESA;

    DELETE PER_DESVINCULACION_DETALLE
     WHERE DES_CODIGO = P_CLAVE
       AND DES_EMPR   = P_EMPRESA;
ELSE

 RAISE_APPLICATION_ERROR (-20001, 'La desvinculacion ya fue registrada en documentos de Recursos Humano, ya no puede Eliminar');

END IF;

EXCEPTION
WHEN OTHERS THEN
NULL;

END PP_BORRAR_DATOS;


PROCEDURE PP_TRANSFERIR_A_FINANZAS (P_EMPRESA       IN NUMBER,
                                    P_LEGAJO        IN NUMBER,
                                    P_PERIODO       IN NUMBER,
                                    P_FEC_DOCUMENTO IN DATE,
                                    P_NRO_DOC       IN NUMBER,
                                    P_BANCO         IN NUMBER,
                                    P_MONEDA        IN NUMBER,
                                    P_TASA          IN NUMBER,
                                    P_SUCURAL       IN NUMBER,
                                    P_OBS           IN VARCHAR2,
                                    P_CLAVE         IN NUMBER,
                                    P_SESSION       IN NUMBER) IS
V_INICIO DATE;
V_FIN DATE;
V_SITUACION VARCHAR2(1);

V_CAPITAL_HUMANO NUMBER;
V_DESVINCULACION NUMBER;
BEGIN


SELECT EMPL_SITUACION 
  INTO V_SITUACION
  FROM PER_EMPLEADO
 WHERE EMPL_EMPRESA =P_EMPRESA
   AND EMPL_LEGAJO = P_LEGAJO;


IF V_SITUACION = 'I' THEN
  RAISE_APPLICATION_ERROR(-20001, 'El empleado esta inactivo, no puede realizar ninguna transaccion');
END IF;

   SELECT T.PERI_FEC_INI, T.PERI_FEC_FIN
        INTO V_INICIO,V_FIN
        FROM  PER_PERIODO T
       WHERE PERI_EMPR= P_EMPRESA
         AND PERI_CODIGO = P_PERIODO;

 IF P_EMPRESA = 1 THEN
  SELECT NVL(SUM(PER_DOCUMENTO_DET.PDDET_IMP), 0)
    INTO V_CAPITAL_HUMANO
    FROM PER_DOCUMENTO,
         PER_DOCUMENTO_DET,
         PER_CONCEPTO,
         PER_EMPLEADO      E,
         GEN_DEPARTAMENTO  O,
         FIN_CONCEPTO      C,
         PER_DPTO_CONC     D,
         CNT_CUENTA        A,
         FIN_CONCEPTO      F,
         GEN_SUCURSAL      S,
         GEN_EMPRESA       M,
         GEN_MONEDA        GM
   WHERE PER_DOCUMENTO_DET.PDDET_CLAVE_CONCEPTO = PER_CONCEPTO.PCON_CLAVE
     AND PER_DOCUMENTO.PDOC_CLAVE = PER_DOCUMENTO_DET.PDDET_CLAVE_DOC
     AND E.EMPL_SUCURSAL = S.SUC_CODIGO
     AND PER_DOCUMENTO.PDOC_EMPLEADO = E.EMPL_LEGAJO
     AND PER_DOCUMENTO.PDOC_DEPARTAMENTO = O.DPTO_CODIGO
     AND PDOC_FEC BETWEEN V_INICIO AND V_FIN
     AND C.FCON_CLAVE_CTACO = A.CTAC_CLAVE
     AND PDOC_CLAVE_FIN IS NULL
     AND O.DPTO_CODIGO = D.DPTOC_DPTO
     AND D.DPTOC_PER_CONC = PER_CONCEPTO.PCON_CLAVE
     AND D.DPTOC_FIN_CONC = C.FCON_CLAVE
     AND E.EMPL_FORMA_PAGO <> 3
     AND E.EMPL_SITUACION = 'A'
     AND E.EMPL_SUCURSAL = P_SUCURAL
     AND PDOC_MON = P_MONEDA
     AND PDDET_CLAVE_FIN IS NULL --QUIERE DECIR QUE NO FUE TRASPASADO AUN A FINANZAS
     AND DPTOC_FCONC_IPS_PATR = F.FCON_CLAVE(+)
     AND PDOC_MON = GM.MON_CODIGO
     AND PDOC_EMPR = P_EMPRESA
     AND PDOC_EMPR = M.EMPR_CODIGO
     AND GM.MON_EMPR = PDOC_EMPR
     AND PER_DOCUMENTO_DET.PDDET_EMPR = PER_CONCEPTO.PCON_EMPR
     AND PER_DOCUMENTO.PDOC_EMPR = PER_DOCUMENTO_DET.PDDET_EMPR
     AND E.EMPL_EMPRESA = S.SUC_EMPR
     AND PER_DOCUMENTO.PDOC_EMPR = E.EMPL_EMPRESA
     AND E.EMPL_EMPRESA = O.DPTO_EMPR
     AND C.FCON_EMPR = A.CTAC_EMPR
     AND O.DPTO_EMPR = D.DPTOC_EMPR
     AND D.DPTOC_EMPR = PER_CONCEPTO.PCON_EMPR
     AND D.DPTOC_EMPR = C.FCON_EMPR
     AND DPTOC_EMPR = F.FCON_EMPR(+)
     AND EMPL_LEGAJO =P_LEGAJO;
         
         
         SELECT NVL(SUM(T.DES_IMPORTE),0)
           INTO V_DESVINCULACION
          FROM PER_DESVINCULACION_DETALLE T, PER_CONCEPTO A
         WHERE T.DES_EMPR = A.PCON_EMPR
           AND T.DES_CON_COD = A.PCON_CLAVE
           AND T.DES_EMPR = P_EMPRESA
          AND T.DES_LEGAJO = P_LEGAJO
          AND T.DES_CODIGO = P_CLAVE
           AND T.DES_TIPO NOT IN (12, 20, 4, 14, 15, 144);

  ---- IF V_DESVINCULACION <>V_CAPITAL_HUMANO THEN
  ---  RAISE_APPLICATION_ERROR(-20001, 'Montos diferentes entre capital humano y desvinculacion favor revisar el 17-4-55');
 -- END IF;


END IF;
      BEGIN
        PERP209.PP_GENERAR_CONSULTA(I_FEC_ENT_INI => V_INICIO,
                                    I_FEC_ENT_FIN => V_FIN,
                                    I_EMPRESA     => P_EMPRESA,
                                    I_CONCEPTO    => NULL,
                                    I_DOC_SUC     => P_SUCURAL,
                                    I_MON         => P_MONEDA,
                                    I_SESSION_ID  => P_SESSION,
                                    I_GRUPO       => 3,
                                    I_LEGAJO      => P_LEGAJO,
                                    I_EXCLUIR     => 'N',
                                    I_PERIODO     => P_PERIODO);
      END;

      BEGIN
        PERP209.PP_ACTUALIZAR_REGISTRO(I_EMPRESA       => P_EMPRESA,
                                       I_SESSION_ID    => P_SESSION,
                                       I_DOC_CTA_BCO   => P_BANCO,
                                       I_PDOC_FEC      => P_FEC_DOCUMENTO,
                                       I_DOC_SUC       => P_SUCURAL,
                                       I_PDOC_NRO_DOC  => P_NRO_DOC,
                                       I_MON           => P_MONEDA,
                                       I_PDOC_FEC_OPER => P_FEC_DOCUMENTO,
                                       I_TASA_OFIC     => P_TASA,
                                       I_PROGRAMA      => 'PERC002');
      END;

          UPDATE PER_EMPL_PLUS_SALARIAL A
             SET EPS_ESTADO_RRHH = 'C'
           WHERE EPS_EMPR = P_EMPRESA
             AND A.EPS_OPER_RRHH = GEN_DEVUELVE_USER
             AND A.EPS_EMPLEADO = P_LEGAJO
             AND NVL(EPS_ESTADO_RRHH, 'P') = 'P';

      

END PP_TRANSFERIR_A_FINANZAS;





PROCEDURE PP_CALCULAR_CANTIDAD_TRA (P_EMPRESA         IN NUMBER,
                                    P_LEGAJO          IN NUMBER,
                                    P_FECHA           IN DATE,
                                    P_ANHOS           OUT NUMBER,
                                    P_MES             OUT NUMBER,
                                    P_DIAS             OUT NUMBER) IS


BEGIN





IF P_EMPRESA != 2 then -- @PabloACespedes 20/07/2022 13.13 todo el Holding menos Transagro
  


 SELECT NVL(CASE
                     WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                               EMPL_FEC_INGRESO) / 12) > 1 THEN
                      TRUNC(MONTHS_BETWEEN(P_FECHA,
                                           EMPL_FEC_INGRESO) / 12)
                     WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                               EMPL_FEC_INGRESO) / 12) = 1 THEN
                      TRUNC(MONTHS_BETWEEN(P_FECHA,
                                           EMPL_FEC_INGRESO) / 12)
                   END,0) Cant_aHos,


                NVL(    CASE
                     WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                               TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                               'DD/MM') || '/' ||
                                                       TO_CHAR(P_FECHA,
                                                               'YYYY')))) > 1 THEN
                      TRUNC(MONTHS_BETWEEN(P_FECHA,
                                           TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                           'DD/MM') || '/' ||
                                                   TO_CHAR(P_FECHA,
                                                           'YYYY'))))

                     WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                               TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                               'DD/MM') || '/' ||
                                                       TO_CHAR(P_FECHA,
                                                               'YYYY')))) = 1 THEN
                      TRUNC(MONTHS_BETWEEN(P_FECHA,
                                           TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                           'DD/MM') || '/' ||
                                                   TO_CHAR(P_FECHA,
                                                           'YYYY'))))

                     WHEN (MONTHS_BETWEEN(P_FECHA,
                                               TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                               'DD/MM') || '/' ||
                                                       TO_CHAR(P_FECHA,
                                                               'YYYY')))) < 0 THEN

                      CASE
                        WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                                  TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                  'DD/MM') || '/' ||
                                                          TO_CHAR(ADD_MONTHS(P_FECHA,
                                                                             -12),
                                                                  'YYYY')))) > 1 THEN

                         TRUNC(MONTHS_BETWEEN(P_FECHA,
                                              TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                              'DD/MM') || '/' ||
                                                      TO_CHAR(ADD_MONTHS(P_FECHA,
                                                                         -12),
                                                              'YYYY'))))

                        WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                                  TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                  'DD/MM') || '/' ||
                                                          TO_CHAR(ADD_MONTHS(P_FECHA,
                                                                             -12),
                                                                  'YYYY')))) = 1 THEN

                         TRUNC(MONTHS_BETWEEN(P_FECHA,
                                              TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                              'DD/MM') || '/' ||
                                                      TO_CHAR(ADD_MONTHS(P_FECHA,
                                                                         -12),
                                                              'YYYY'))))

                      END

                   END,0) cantidad_meses,


                  NVL( CASE
                     WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                        TO_CHAR(P_FECHA, 'MM/YYYY'))) > 1 THEN

                    TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                            TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                    TO_CHAR(P_FECHA, 'MM/YYYY')))

                     WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                        TO_CHAR(P_FECHA, 'MM/YYYY'))) = 1 THEN
                      TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                            TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                    TO_CHAR(P_FECHA, 'MM/YYYY')))
                     WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                        TO_CHAR(P_FECHA, 'MM/YYYY'))) < -1 THEN

                      CASE
                        WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                   TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                           TO_CHAR(ADD_MONTHS(P_FECHA,
                                                              -1),
                                                   'MM/YYYY'))) = 1 THEN

                       TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                               TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                       TO_CHAR(ADD_MONTHS(P_FECHA, -1),
                                               'MM/YYYY')))
                        WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                                   TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                           TO_CHAR(ADD_MONTHS(P_FECHA,
                                                              -1),
                                                   'MM/YYYY'))) > 1 THEN
                       TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,1)) -
                               TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                       TO_CHAR(ADD_MONTHS(P_FECHA, -1),
                                               'MM/YYYY')))
                      END
                   END,0) dias
          INTO P_ANHOS, P_MES, P_DIAS
        FROM PER_EMPLEADO A
       WHERE EMPL_LEGAJO = P_LEGAJO
         AND EMPL_EMPRESA = P_EMPRESA;
ELSE
   SELECT NVL(CASE
                     WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                               EMPL_FEC_INGRESO) / 12) > 1 THEN
                      TRUNC(MONTHS_BETWEEN(P_FECHA,
                                           EMPL_FEC_INGRESO) / 12)
                     WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                               EMPL_FEC_INGRESO) / 12) = 1 THEN
                      TRUNC(MONTHS_BETWEEN(P_FECHA,
                                           EMPL_FEC_INGRESO) / 12)
                   END,0) Cant_aNos,


                NVL(    CASE
                     WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                               TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                               'DD/MM') || '/' ||
                                                       TO_CHAR(P_FECHA,
                                                               'YYYY')))) > 1 THEN
                      TRUNC(MONTHS_BETWEEN(P_FECHA,
                                           TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                           'DD/MM') || '/' ||
                                                   TO_CHAR(P_FECHA,
                                                           'YYYY'))))

                     WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                               TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                               'DD/MM') || '/' ||
                                                       TO_CHAR(P_FECHA,
                                                               'YYYY')))) = 1 THEN
                      TRUNC(MONTHS_BETWEEN(P_FECHA,
                                           TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                           'DD/MM') || '/' ||
                                                   TO_CHAR(P_FECHA,
                                                           'YYYY'))))

                     WHEN (MONTHS_BETWEEN(P_FECHA,
                                               TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                               'DD/MM') || '/' ||
                                                       TO_CHAR(P_FECHA,
                                                               'YYYY')))) < 0 THEN

                      CASE
                        WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                                  TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                  'DD/MM') || '/' ||
                                                          TO_CHAR(ADD_MONTHS(P_FECHA,
                                                                             -12),
                                                                  'YYYY')))) > 1 THEN

                         TRUNC(MONTHS_BETWEEN(P_FECHA,
                                              TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                              'DD/MM') || '/' ||
                                                      TO_CHAR(ADD_MONTHS(P_FECHA,
                                                                         -12),
                                                              'YYYY'))))

                        WHEN TRUNC(MONTHS_BETWEEN(P_FECHA,
                                                  TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                                  'DD/MM') || '/' ||
                                                          TO_CHAR(ADD_MONTHS(P_FECHA,
                                                                             -12),
                                                                  'YYYY')))) = 1 THEN

                         TRUNC(MONTHS_BETWEEN(P_FECHA,
                                              TO_DATE(TO_CHAR(EMPL_FEC_INGRESO,
                                                              'DD/MM') || '/' ||
                                                      TO_CHAR(ADD_MONTHS(P_FECHA,
                                                                         -12),
                                                              'YYYY'))))

                      END

                   END,0) cantidad_meses,


                  NVL( CASE
                     WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                        TO_CHAR(P_FECHA, 'MM/YYYY'))) > 1 THEN

                    TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                            TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                    TO_CHAR(P_FECHA, 'MM/YYYY')))

                     WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                        TO_CHAR(P_FECHA, 'MM/YYYY'))) = 1 THEN
                      TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                            TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                    TO_CHAR(P_FECHA, 'MM/YYYY')))
                     WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                        TO_CHAR(P_FECHA, 'MM/YYYY'))) < -1 THEN

                      CASE
                        WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                   TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                           TO_CHAR(ADD_MONTHS(P_FECHA,
                                                              -1),
                                                   'MM/YYYY'))) = 1 THEN

                       TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                               TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                       TO_CHAR(ADD_MONTHS(P_FECHA, -1),
                                               'MM/YYYY')))
                        WHEN TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                                   TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd'))|| '/' ||
                                           TO_CHAR(ADD_MONTHS(P_FECHA,
                                                              -1),
                                                   'MM/YYYY'))) > 1 THEN
                       TRUNC((P_FECHA + decode( to_char(EMPL_FEC_INGRESO,'dd'),31,0,0)) -
                               TO_DATE( decode( to_char(EMPL_FEC_INGRESO,'dd'),31,30,29,28,to_char(EMPL_FEC_INGRESO,'dd')) || '/' ||
                                       TO_CHAR(ADD_MONTHS(P_FECHA, -1),
                                               'MM/YYYY')))
                      END
                   END,0) dias
          INTO P_ANHOS, P_MES, P_DIAS
        FROM PER_EMPLEADO A
       WHERE EMPL_LEGAJO = P_LEGAJO
         AND EMPL_EMPRESA = P_EMPRESA;

END IF;
END PP_CALCULAR_CANTIDAD_TRA;


 PROCEDURE PP_DETALLE_CONCEPTO_TRA(P_EMPRESA                         IN NUMBER,
                                     P_LEGAJO                          IN NUMBER,
                                     P_FECHA                           IN DATE,
                                     P_TIPO_DESVINCULACION             IN NUMBER,
                                     P_IND_OMISION_PREAVISO            IN VARCHAR2,
                                     P_IND_PAGA_OMIS_PREAVISO          IN VARCHAR2,
                                     P_CLAVE                           IN OUT NUMBER,
                                     P_EXONERAR                        IN VARCHAR2,
                                     P_FEC_RENUNCIA                    IN DATE,
                                     P_FEC_REN_HASTA                   IN DATE,
                                     P_FAC_CALIDAD                     IN VARCHAR2,
                                     P_RDE_IMP_CERT                    IN VARCHAR2) IS



V_COLOR            VARCHAR2(60);
V_SALARIO_BASE     NUMBER;
V_LISTA            VARCHAR2(3);
V_CANT_DIAS        NUMBER;
V_IPS_IMPORTE      NUMBER;
V_FORMA_PAGO       NUMBER;
V_MES              VARCHAR2(60) := TO_CHAR(P_FECHA,'MM/YYYY');
V_SALARIO          NUMBER;
V_DESC_CODIGO      NUMBER;
V_DESC_SEGURO      VARCHAR2(60);
V_CONP_COD         VARCHAR2(60);
v_agui             number;
----EMPL
V_EMPL_FORMA_PAGO      NUMBER;
V_EMPL_TIPO_SALARIO    NUMBER;
V_EMPL_IND_HORA_EXTRA  VARCHAR2(1);
V_EMPL_TIPO_COMIS      VARCHAR2(1);
V_EMPL_MARC_COMIS_SIST VARCHAR2(1);
V_EMPL_CODIGO_PROV     NUMBER;
V_EMPL_COD_CLIENTE     NUMBER;
V_EMPL_CARGO           NUMBER;
V_FEC_INGRESO          DATE;
V_DPTO                 NUMBER;
V_SUC                  NUMBER;
V_COD_CHOFER           NUMBER;
V_COMI_TRASPORTE       VARCHAR2(2);
VAC_IMP_X_DIA3         number;
V_COD_CLIENTE_TRA      NUMBER;
V_PERIODO              NUMBER;
V_PERIODO2              NUMBER;

V_SALARIO_MEN           NUMBER;
V_IMPORTE_DIARIO        NUMBER;


VAC_EMPL_DESC      VARCHAR2(100);
VAC_FORMA_PAG_DESC VARCHAR2(100);
VAC_IMP_X_DIA      NUMBEr;
VAC_ANTIGUE        VARCHAR2(100);
VAC_DIAS_CORRES    NUMBER;
VAC_DIAS_CAUSAD    NUMBER;
VAC_DIAS_CONC      NUMBER;
VAC_DIAS_PEND      NUMBER;
VAC_FECHA_INGRESO  DATE;
VAC_SUCURSAL_DESC  VARCHAR2(100);
VAC_DIAS_CAUSAD2   NUMBER;
VAC_EMPL_SITUACION VARCHAR2(100);
VAC_CANT_ANHOS     NUMBER;
VAC_CANT_MESES NUMBER;

V_PRO VARCHAR2(20);
V_VAC_MONTO NUMBER;
V_VAC_IPS   NUMBER;


---------------***

IND_MONTO NUMBER;
PRE_MONTO NUMBER;
PRE_DIAS NUMBER;
IND_DIAS NUMBER;
AG_IMPORTE_TOT NUMBER;
AG_IMPORTE NUMBER;

V_IMP_DIARIO_PROM NUMBER;
V_FEC_INI_LOG DATE;
V_ANTIGUEDAD VARCHAR2(60);
X_EDITAR NUMBER :=P_CLAVE;
X_CONTADOR NUMBER;


V_SEG_CONCEPTO NUMBER;
V_SEG_CON_DESC VARCHAR2(60);
V_SEG_PORCENTAJE NUMBER;



ANT_CANT_ANHOS NUMBER;
ANT_CANT_MESES NUMBER;
ANT_CANT_DIAS  NUMBER;


V_TOTAL_OC NUMBER:=0;
V_COF_SUELDO NUMBER:=0;
V_COF_DESCUENTO_IPS NUMBER:=0;
V_OCA_TOTAL NUMBER:=0;
V_OCA_TOTAL_IPS NUMBER :=0;
V_OCA_TOTAL_MOT NUMBER :=0;



X_OMISION_PRE_AVISO NUMBER;
X_OMI_IMPR          NUMBER;
X_OMI_IPS           NUMBER;
AUSE_CONT           number;

X_CANT_CUMPL          NUMBER;
XDIAS_OMI             NUMBER;

BEGIN
  IF P_CLAVE  IS NULL THEN
        SELECT NVL(MAX(T.RDE_CLAVE),0)+1
        INTO V_DESC_CODIGO
        FROM PER_REGISTRO_DESVINC_EMPL T
        WHERE T.RDE_EMPR = P_EMPRESA;

     P_CLAVE := V_DESC_CODIGO;
  END IF;

    P_CLAVE := P_CLAVE;


                 SELECT A.EMPL_FORMA_PAGO,
                        A.EMPL_TIPO_SALARIO,
                        A.EMPL_IND_HORA_EXTRA,
                        A.EMPL_TIPO_COMIS,
                        A.EMPL_MARC_COMIS_SIST,
                        A.EMPL_CODIGO_PROV,
                        A.EMPL_CODIGO_CLI,
                        A.EMPL_CARGO,
                        A.EMPL_DEPARTAMENTO,
                        A.EMPL_SUCURSAL,
                        A.EMPL_SALARIO_BASE,
                        A.EMPL_IMP_HORA_N_D,
                        A.EMPL_FEC_INGRESO,
                        A.EMPL_IND_COM_TRANS,
                        A.EMPL_CODIGO_CHOFER
                     INTO
                        V_EMPL_FORMA_PAGO,
                        V_EMPL_TIPO_SALARIO,
                        V_EMPL_IND_HORA_EXTRA,
                        V_EMPL_TIPO_COMIS,
                        V_EMPL_MARC_COMIS_SIST,
                        V_EMPL_CODIGO_PROV,
                        V_EMPL_COD_CLIENTE,
                        V_EMPL_CARGO,
                        V_DPTO,
                        V_SUC,
                        V_SALARIO_MEN,
                        V_IMPORTE_DIARIO,
                        V_FEC_INGRESO,
                        V_COMI_TRASPORTE,
                        V_COD_CHOFER
                    FROM PER_EMPLEADO A
                   WHERE A.EMPL_LEGAJO  = P_LEGAJO
                     AND A.EMPL_EMPRESA = P_EMPRESA;

          V_ANTIGUEDAD := PERC002.FP_TRAER_ANTIGUEDAD(P_EMPRESA              => P_EMPRESA,
                                                      P_LEGAJO               => P_LEGAJO,
                                                      P_FECHA_DESVINCULACION => P_FECHA);


     BEGIN

          PERC002.PP_CALCULAR_CANTIDAD_TRA(P_EMPRESA                   => P_EMPRESA,
                                           P_LEGAJO                    => P_LEGAJO,
                                           P_FECHA                     => P_FECHA,
                                           P_ANHOS                     => ANT_CANT_ANHOS,
                                           P_MES                       => ANT_CANT_MESES,
                                           P_DIAS                      => ANT_CANT_DIAS);
     END;


          IF V_EMPL_FORMA_PAGO  = 5 THEN
             V_SEG_CONCEPTO := 31;
             V_SEG_CON_DESC := 'A.M.H';
             V_SEG_PORCENTAJE := 0.05;
         ELSE
             V_SEG_CONCEPTO := 4;
             V_SEG_CON_DESC := 'I.P.S. OBRERO';
             V_SEG_PORCENTAJE := 0.09;
         END IF;


     V_FEC_INI_LOG :=TRUNC(ADD_MONTHS(P_FECHA,-1),'MM');



    IF TO_CHAR(P_FECHA,'DD/MM/YYYY') > '23/'||TO_CHAR(P_FECHA,'MM/YYYY') THEN

    BEGIN
      SELECT P.PERI_CODIGO-1,P.PERI_CODIGO
        INTO V_PERIODO, V_PERIODO2
        FROM  PER_PERIODO P
       WHERE P.PERI_EMPR= P_EMPRESA
         AND P_FECHA BETWEEN P.PERI_JORN_INI AND P.PERI_JORN_FIN;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR (-20001,'Favor configurar el periodo Jornal');

      END;

   ELSE
      SELECT P.PERI_CODIGO
        INTO V_PERIODO
        FROM  PER_PERIODO P
       WHERE P.PERI_EMPR= P_EMPRESA
         AND P_FECHA BETWEEN P.PERI_JORN_INI AND P.PERI_JORN_FIN;

    END IF;




                IF X_EDITAR IS NULL THEN
                              INSERT INTO PER_REGISTRO_DESVINC_EMPL
                                (RDE_CLAVE,
                                 RDE_TIPO_DESVINCULACION,
                                 RDE_EMPLEADO,
                                 RDE_FECHA,
                                 RDE_LOGIN,
                                 RDE_EMPR,
                                 RDE_FECHA_GRAB,
                                 RDE_IND_OMISION_PREAVISO,
                                 RDE_IND_PAGA_OMIS_PREAVISO,
                                 RDE_ANTIGUEDAD,
                                 RDE_REN_EXONERADA,
                                 RDE_DEPARTAMENTO,
                                 RDE_SUCURSAL,
                                 RDE_FECHA_RENUNCIA,
                                 RDE_FECHA_REN_HASTA,
                                 RDE_FECHA_INGRESO,
                                 RDE_FAC_CALIDAD,
                                 RDE_IMP_CERT)
                              VALUES
                                (V_DESC_CODIGO,
                                 P_TIPO_DESVINCULACION,
                                 P_LEGAJO,
                                 P_FECHA,
                                 gen_devuelve_user,
                                 P_EMPRESA,
                                 SYSDATE,
                                 P_IND_OMISION_PREAVISO,
                                 P_IND_PAGA_OMIS_PREAVISO,
                                 V_ANTIGUEDAD,
                                 P_EXONERAR,
                                 V_DPTO,
                                 V_SUC,
                                 P_FEC_RENUNCIA,
                                 P_FEC_REN_HASTA,
                                 V_FEC_INGRESO,
                                 P_FAC_CALIDAD,
                                 P_RDE_IMP_CERT);

               END IF;


               BEGIN

                  SELECT CASE WHEN V_EMPL_FORMA_PAGO IN (1) THEN
                                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 26),8)
                              ELSE
                                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 30),8)
                              END IMPORTE_DIARIO
                    INTO VAC_IMP_X_DIA
                    FROM PERI052_V_T         A,
                         PER_CONFIGURACION B,
                         PER_PERIODO       C,
                         PER_CONCEPTO      D,
                         PER_EMPLEADO      E
                   WHERE A.EMPL_LEGAJO = P_LEGAJO
                     AND A.FECHA BETWEEN TO_CHAR(ADD_MONTHS(TRUNC(P_FECHA,'mm'), -6), 'DD/MM/YYYY') AND
                                         TO_CHAR(ADD_MONTHS(LAST_DAY(P_FECHA), -1), 'DD/MM/YYYY')
                     AND CONF_EMPR = P_EMPRESA
                     AND B.CONF_PERI_ACT = PERI_CODIGO
                     AND B.CONF_EMPR = PERI_EMPR
                     AND A.COD_CONCEPTO = D.PCON_CLAVE
                     AND B.CONF_EMPR = PCON_EMPR
                     AND D.PCON_IND_IPS = 'S'
                     AND A.EMPL_LEGAJO = E.EMPL_LEGAJO
                     AND CONF_EMPR = E.EMPL_EMPRESA
                     AND  A.FECHA >= CASE WHEN  E.EMPL_FEC_INGRESO <= '03/'|| TO_CHAR(E.EMPL_FEC_INGRESO,'MM/YYYY') THEN
                                                 EMPL_FEC_INGRESO
                                              ELSE
                                                 ADD_MONTHS (EMPL_FEC_INGRESO,1)
                                              END;
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN

                    VAC_IMP_X_DIA := 0;

                END;

------------------------------SALARIO MENSUALERO
  IF V_EMPL_FORMA_PAGO  = 2 AND V_EMPL_TIPO_SALARIO  <> 5 THEN
         PER_CALCULA_SAL_BASE_PRO2 (P_LEGAJO,P_EMPRESA,V_COLOR,V_SALARIO_BASE,V_LISTA,2,V_CANT_DIAS, P_FECHA);

           IF V_LISTA = 'S' THEN

                V_IPS_IMPORTE :=  ROUND(V_SALARIO_BASE * V_SEG_PORCENTAJE);

           END IF;
                       INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_DIAS,
                          DES_IMP_DIARIO,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          2,
                          'SALARIO',
                          V_MES,
                          ROUND(V_SALARIO_BASE),
                          V_CANT_DIAS,
                          ROUND(V_SALARIO_BASE/V_CANT_DIAS),
                          V_DESC_CODIGO,
                          1,
                          V_DPTO,
                          V_SUC,
                          1);



                 INSERT INTO PER_DESVINCULACION_DETALLE
                         (DES_EMPR,
                          DES_LEGAJO,
                          DES_CON_COD,
                          DES_CON_DESC,
                          DES_MES,
                          DES_IMPORTE,
                          DES_CODIGO,
                          DES_TIPO,
                          DES_DPTO,
                          DES_SUC,
                          DES_NRO)
                       VALUES
                         (P_EMPRESA,
                          P_LEGAJO,
                          V_SEG_CONCEPTO,
                          V_SEG_CON_DESC,
                          V_MES,
                          ROUND(V_IPS_IMPORTE),
                          V_DESC_CODIGO,
                          1 ,
                          V_DPTO,
                          V_SUC,
                          1);

      END IF;

---------------------------------SALARIO JORNALERO

                FOR HS IN (
SELECT 'HORAS' DETALLE,
        EMPL_SUCURSAL,
       T.DPTO_CODIGO,
       T.DPTO_DESC,
       T.PERIODO,
       T.EMPR EMPL_EMPRESA,
       TO_CHAR(T.HD)HD,
       TO_CHAR(T.HDE)HDE,
       TO_CHAR(T.HN)HN,
       TO_CHAR(T.HNE)HNE,
       TO_CHAR(T.HME)HME,
       TO_CHAR(T.HFD)HFD,
       TO_CHAR(T.HFN)HFN,
       TO_CHAR(T.HTOT) HTOT,
       1 ORDEN

  FROM PER_PERL029_FINAL_TEMP T, PER_EMPLEADO A
 WHERE T.EMPL_LEGAJO = A.EMPL_LEGAJO
   AND T.EMPR = A.EMPL_EMPRESA
   AND T.NIVEL = 'EMPLEADO'
   AND EMPL_EMPRESA = P_EMPRESA
  AND PERIODO IN (V_PERIODO, V_PERIODO2)
   AND T.EMPL_LEGAJO =P_LEGAJO
UNION ALL
SELECT 'GS POR HORA',
       EMPL_SUCURSAL,
       T.DPTO_CODIGO,
       T.DPTO_DESC,
       T.PERIODO,
       T.EMPR,
       TO_CHAR(T.IMP_HD, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HDE, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HN, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HNE, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HME, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HFD, '999G999G999G999G999G999G990'),
       TO_CHAR(T.IMP_HFN, '999G999G999G999G999G999G990'),
       NULL TOTAL,
       2
  FROM PER_PERL029_FINAL_TEMP T, PER_EMPLEADO A
 WHERE T.EMPL_LEGAJO = A.EMPL_LEGAJO
   AND T.EMPR = A.EMPL_EMPRESA
   AND T.NIVEL = 'EMPLEADO'
   AND EMPL_EMPRESA = P_EMPRESA
   AND PERIODO IN (V_PERIODO, V_PERIODO2)
   AND T.EMPL_LEGAJO =P_LEGAJO
  

  
UNION ALL
SELECT 'IMPORTE',
       EMPL_SUCURSAL,
       T.DPTO_CODIGO,
       T.DPTO_DESC,
       T.PERIODO,
       T.EMPR,
       TO_CHAR(T.TOTIMPHD, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHDE, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHN, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHNE, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHME, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHFD, '999G999G999G999G999G999G990'),
       TO_CHAR(T.TOTIMPHFN, '999G999G999G999G999G999G990'),
       
       TO_CHAR(CASE
                 WHEN EMPL_IND_HORA_EXTRA = 'S' THEN
                  NVL(TOTIMPHDE, 0) + NVL(TOTIMPHNE, 0) + NVL(TOTIMPHME, 0) +
                  NVL(TOTIMPHFD, 0) + NVL(TOTIMPHFN, 0)
                 ELSE
                  T.TOTIMPGRAL
               END,
               '999G999G999G999G999G999G990') TOTAL,
       3
     
  FROM PER_PERL029_FINAL_TEMP T, PER_EMPLEADO A
 WHERE T.EMPL_LEGAJO = A.EMPL_LEGAJO
   AND T.EMPR = A.EMPL_EMPRESA
   AND T.NIVEL = 'EMPLEADO'
   AND EMPL_EMPRESA = P_EMPRESA
   AND PERIODO IN (V_PERIODO, V_PERIODO2)
   AND T.EMPL_LEGAJO =P_LEGAJO
                  
                ) LOOP
              /*    SELECT 'HORAS' DETALLE,
                                   T.EMPL_SUCURSAL,
                                   T.DPTO_CODIGO,
                                   T.DPTO_DESC,
                                   T.PERIODO,
                                   T.EMPL_EMPRESA,
                                   TO_CHAR(T.HD)HD,
                                   TO_CHAR(T.HDE)HDE,
                                   TO_CHAR(T.HN)HN,
                                   TO_CHAR(T.HNE)HNE,
                                   TO_CHAR(T.HME)HME,
                                   TO_CHAR(T.HFD)HFD,
                                   TO_CHAR(T.HFN)HFN,
                                   TO_CHAR(T.HD + T.HDE + T.HN + T.HNE + T.HME + T.HFD + T.HFN) HTOT,
                                   1 ORDEN
                              FROM PER_PERL034_V T
                             WHERE EMPL_EMPRESA = P_EMPRESA
                               AND PERIODO IN (V_PERIODO, V_PERIODO2)
                               AND EMPL_LEGAJO = P_LEGAJO
                            UNION ALL
                            SELECT 'GS. HORA',
                                   T.EMPL_SUCURSAL,
                                   T.DPTO_CODIGO,
                                   T.DPTO_DESC,
                                   T.PERIODO,
                                   T.EMPL_EMPRESA,
                                   TO_CHAR(T.IMP_HD,'999G999G999G999G999G999G990'),
                                   TO_CHAR(T.IMP_HDE,'999G999G999G999G999G999G990'),
                                   TO_CHAR(T.IMP_HN,'999G999G999G999G999G999G990'),
                                   TO_CHAR(T.IMP_HNE,'999G999G999G999G999G999G990'),
                                   TO_CHAR(T.IMP_HME,'999G999G999G999G999G999G990'),
                                   TO_CHAR(T.IMP_HFD,'999G999G999G999G999G999G990'),
                                   TO_CHAR(T.IMP_HFN,'999G999G999G999G999G999G990'),
                                   NULL,
                                   2
                              FROM PER_PERL034_V T
                             WHERE EMPL_EMPRESA = P_EMPRESA
                               AND PERIODO IN (V_PERIODO, V_PERIODO2)
                               AND EMPL_LEGAJO = P_LEGAJO
                            union all
                            SELECT 'IMPORTE',
                                   T.EMPL_SUCURSAL,
                                   T.DPTO_CODIGO,
                                   T.DPTO_DESC,
                                   T.PERIODO,
                                   T.EMPL_EMPRESA,
                                   TO_CHAR(T.HD * T.IMP_HD,'999G999G999G999G999G999G990') TOTIMPHD,
                                   TO_CHAR(T.HDE * T.IMP_HDE,'999G999G999G999G999G999G990') TOTIMPHDE,
                                   TO_CHAR(T.HN * T.IMP_HN,'999G999G999G999G999G999G990') TOTIMPHN,
                                   TO_CHAR(T.HNE * T.IMP_HNE,'999G999G999G999G999G999G990') TOTIMPHNE,
                                   TO_CHAR(T.HME * T.IMP_HME,'999G999G999G999G999G999G990') TOTIMPHME,
                                   TO_CHAR(T.HFD * T.IMP_HFD,'999G999G999G999G999G999G990') TOTIMPHFD,
                                   TO_CHAR(T.HFN * T.IMP_HFN,'999G999G999G999G999G999G990') TOTIMPHFN,
                                   TO_CHAR((T.HD * T.IMP_HD) + (T.HDE * T.IMP_HDE) +
                                           (T.HN * T.IMP_HN) + (T.HNE * T.IMP_HNE) +
                                           (T.HME * T.IMP_HME) + (T.HFD * T.IMP_HFD) +
                                           (T.HFN * T.IMP_HFN),'999G999G999G999G999G999G990') TOT,
                                   3
                              FROM PER_PERL034_V T
                             WHERE EMPL_EMPRESA = P_EMPRESA
                               AND PERIODO IN (V_PERIODO, V_PERIODO2)
                               AND EMPL_LEGAJO = P_LEGAJO)  LOOP*/

        INSERT INTO PER_DESVINCULACION_DETALLE
                  (DES_EMPR,
                   DES_LEGAJO,
                   DES_CODIGO,
                   DES_TIPO,
                   DES_DPTO,
                   DES_SUC,
                   DES_PERIODO,
                   DES_DPTO_DESC,
                   DES_DETALLE,
                   DES_DIURNA,
                   DES_DIURNA_EXT,
                   DES_NOCTURNA,
                   DES_NOCT_EXT,
                   DES_MIXTA,
                   DES_FER_DIURNO,
                   DES_FER_NOCT,
                   DES_HS_TOTAL,
                   DES_HS_ORDEN)
                VALUES
                  (P_EMPRESA,
                   P_LEGAJO,
                   V_DESC_CODIGO,
                   20,
                   HS.EMPL_SUCURSAL,
                   HS.DPTO_CODIGO,
                   HS.PERIODO,
                   HS.DPTO_DESC,
                   HS.DETALLE,
                   HS.HD,
                   HS.HDE,
                   HS.HN,
                   HS.HNE,
                   HS.HME,
                   HS.HFD,
                   HS.HFN,
                   HS.HTOT,
                   HS.ORDEN
                  );


      END LOOP;

 ---------------------------TOTAL
   X_CONTADOR :=0;
        FOR X  IN (SELECT T.EMPL_LEGAJO,
                          T.EMPL_PAGA_IPS,
                          T.EMPL_SUCURSAL,
                          T.DPTO_CODIGO,
                          (T.HD * T.IMP_HD) + (T.HDE * T.IMP_HDE) +
                          (T.HN * T.IMP_HN) + (T.HNE * T.IMP_HNE) +
                          (T.HME * T.IMP_HME) +
                          (T.HFD * T.IMP_HFD) +
                          (T.HFN * T.IMP_HFN) TOT_GEN,
                           CASE WHEN  TIPO =  'J' THEN
                                          2
                                         ELSE
                                           5
                                         END CONCEPTO,
                           CASE  WHEN TIPO =  'J' THEN
                                  'SALARIO'
                                ELSE
                                   'HORAS EXTRAS'
                                END CON_DESC
                      FROM PER_PERL034_V_ACT T
                     WHERE EMPL_EMPRESA = P_EMPRESA
                       AND PERIODO IN (V_PERIODO, V_PERIODO2)
                       AND EMPL_LEGAJO = P_LEGAJO---100628
                       ) LOOP
               X_CONTADOR :=   X_CONTADOR+1;
                          INSERT INTO PER_DESVINCULACION_DETALLE
                               (DES_EMPR,
                                DES_LEGAJO,
                                DES_CON_COD,
                                DES_CON_DESC,
                                DES_MES,
                                DES_IMPORTE,
                                DES_CODIGO,
                                DES_TIPO,
                                DES_SUC,
                                DES_DPTO,
                                DES_NRO)
                             VALUES
                               (P_EMPRESA,
                                P_LEGAJO,
                                X.CONCEPTO,
                                X.CON_DESC,
                                V_MES,
                                ROUND(X.TOT_GEN),
                                V_DESC_CODIGO,
                                2,
                                X.EMPL_SUCURSAL,
                                X.DPTO_CODIGO,
                                X_CONTADOR);

                       INSERT INTO PER_DESVINCULACION_DETALLE
                               (DES_EMPR,
                                DES_LEGAJO,
                                DES_CON_COD,
                                DES_CON_DESC,
                                DES_MES,
                                DES_IMPORTE,
                                DES_CODIGO,
                                DES_TIPO,
                                DES_DPTO,
                                DES_SUC,
                                DES_NRO)
                             VALUES
                               (P_EMPRESA,
                                P_LEGAJO,
                                V_SEG_CONCEPTO,
                                V_SEG_CON_DESC,
                                V_MES,
                                ROUND(X.TOT_GEN*V_SEG_PORCENTAJE),
                                V_DESC_CODIGO,
                                2,
                                X.DPTO_CODIGO,
                                X.EMPL_SUCURSAL,
                                X_CONTADOR);

            END LOOP;
----------------------------------REVISAMOS CONCEPTOS FIJOS

 X_CONTADOR := 0;
  FOR CON IN (SELECT T.PERCON_CONCEPTO,
                           T.PERCON_IMP,
                           A.PCON_DESC,
                           CASE
                             WHEN V_EMPL_FORMA_PAGO = 5 THEN
                              T.PERCON_IMP * 0.05
                             ELSE
                              T.PERCON_IMP * 0.09
                           END IMPORTE_IPS,
                           A.PCON_IND_IPS
                      FROM PER_EMPL_CONC T, PER_CONCEPTO A
                     WHERE T.PERCON_EMPR = A.PCON_EMPR
                       AND T.PERCON_CONCEPTO = A.PCON_CLAVE
                       AND T.PERCON_EMPLEADO = P_LEGAJO
                       AND T.PERCON_CONCEPTO NOT IN (1, 2)
                       AND NVL(A.PCON_FIN_TMOV,0) not in ( 31,33)
                       AND T.PERCON_EMPR = P_EMPRESA ) LOOP
             X_CONTADOR :=   X_CONTADOR+1;
                  INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               CON.PERCON_CONCEPTO,
                               CON.PCON_DESC,
                               V_MES,
                               ROUND(CON.PERCON_IMP),
                               V_DESC_CODIGO,
                               9,
                               V_DPTO,
                               V_SUC,
                                X_CONTADOR  );

                   IF CON.PCON_IND_IPS ='S' THEN
                      INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               V_CONP_COD,
                               V_DESC_SEGURO,
                               V_MES,
                               ROUND(CON.IMPORTE_IPS),
                               V_DESC_CODIGO,
                               9,
                               V_DPTO,
                               V_SUC,
                               X_CONTADOR );
                          END IF;
  END LOOP;

-------------------------------------------comision chofer
IF V_COD_CHOFER IS NOT NULL THEN
    X_CONTADOR := 0;
    FOR R IN (select OCA_CLAVE                OCA_CLAVE,
                     OCA_CODIGO               OCA_CODIGO,
                     OCA_LOC_ORIGEN           ORIGEN,
                     OCA_LOC_DESTINO          DESTINO,
                     OCA_FEC_SAL              FECHA,
                     OCA_PORC_CHOFER          OCA_COF_PORC_SUELDO,
                     COF_PORC_DESC_IPS        COF_PORC_DESC_IPS,
                     COF_CONTRIBUYENTE        COF_CONTRIBUYENTE,
                     OCA_PRECIO_KG            OCA_PRECIO,
                     OCA_CAM_CODIGO           OCA_CAMION,
                     OCA_PESO_KG              PESO_KG,
                     OCP_CANTIDAD             CANTIDAD,
                     NVL(OCA_PESO_KG , OCP_CANTIDAD)      PESO,
                     -------------------------------------------------------------
                     PESO_DCTO                OCA_PESO_DCTO,
                     IMPU_PORC_VTA            IMPU_PORC_VTA,
                     IMPU_BI_VTA              IMPU_BI_VTA,
                     ART_CTACO_VTA            ART_CTACO_VTA,
                     ART_CODIGO_STK           ART_CODIGO_STK,
                     PROD_CLAVE_ACO           PROD_CLAVE_ACO,
                     PROD_DESC                PROD_DESC,
                     PROD_PRECIO_MERMA_GS     PROD_PRECIO_DIA,
                     CONF_MAX_PORC_VAR_FE     CONF_MAX_PORC_VAR_FE
                FROM TRAI005_V V
               WHERE OCA_COF_CODIGO       =    V_COD_CHOFER
               and OCA_FEC_SAL >= '01/01/2021'
                --- AND TRUNC(OCA_FEC_SAL)   <=    trunc(sysdate)
                 AND EMPR = 2

               ORDER BY 2) LOOP

             IF NVL(R.CANTIDAD,0)>0 THEN
                V_TOTAL_OC  := nvl(R.OCA_PRECIO,0) * nvl(R.CANTIDAD,0);
              ELSE
                V_TOTAL_OC  := nvl(R.OCA_PRECIO,0) * nvl(R.PESO,0);
              END IF;

              if NVL(R.COF_CONTRIBUYENTE,'N') = 'S' then
                -- Si el chofer es CONTRIBUYENTE, al precio se le debe sumar el IVA
                V_TOTAL_OC  := V_TOTAL_OC + (V_TOTAL_OC / 10);
              end if;
              ------------------------------------------------------------------------------------
              V_COF_SUELDO         := ROUND(V_TOTAL_OC * (nvl(R.OCA_COF_PORC_SUELDO,0)/100));
              ------------------------------------------------------------------------------------
              IF NVL(R.COF_CONTRIBUYENTE,'N') = 'N' THEN
                 --IF :BSEL.S_APL_RETEN_IPS = 'S' then
              V_COF_DESCUENTO_IPS:= round(V_COF_SUELDO * (nvl(R.COF_PORC_DESC_IPS,0)/100));
                -- ELSE
                  --  :BORDCAR.COF_DESCUENTO_IPS:= 0;
                -- END IF;
                V_OCA_TOTAL         := V_COF_SUELDO - V_COF_DESCUENTO_IPS;
              ELSE
                V_COF_DESCUENTO_IPS  := 0;
                V_OCA_TOTAL          := V_COF_SUELDO;
              END IF;
              ------------------------------------------------------------------------------------
          X_CONTADOR := X_CONTADOR+1;
                 INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO,
                               DES_TRA_OR_CLAVE,
                               DES_TRA_ORDEN,
                               DES_TRA_CAMION,
                               DES_TRA_DESTINO,
                               DES_TRA_FEC_OC,
                               DES_TRA_PESO_DCTO,
                               DES_TRA_SUELDO,
                               DES_TRA_IPS,
                               DES_TRA_TOTAL,
                               DES_TRA_ORIGEN)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               NULL,
                               'DETALLE COMISION',
                               V_DESC_CODIGO,
                               31,
                               V_DPTO,
                               V_SUC,
                               X_CONTADOR,
                               R.OCA_CLAVE,
                               R.OCA_CODIGO,
                               R.OCA_CAMION,
                               R.DESTINO,
                               R.FECHA,
                               R.OCA_PESO_DCTO,
                               V_COF_SUELDO,
                               V_COF_DESCUENTO_IPS,
                               V_OCA_TOTAL,
                               R.ORIGEN );


       V_OCA_TOTAL_MOT := V_OCA_TOTAL_MOT+V_COF_SUELDO ;
       V_OCA_TOTAL_IPS :=V_OCA_TOTAL_IPS+V_COF_DESCUENTO_IPS;

  END LOOP;

       IF V_OCA_TOTAL_MOT >0 THEN
               INSERT INTO PER_DESVINCULACION_DETALLE f
                                (DES_EMPR,
                                 DES_LEGAJO,
                                 DES_CON_COD,
                                 DES_CON_DESC,
                                 DES_MES,
                                 DES_IMPORTE,
                                 DES_CODIGO,
                                 DES_TIPO,
                                 DES_DPTO,
                                 DES_SUC,
                                 DES_NRO)
                              VALUES
                                (P_EMPRESA,
                                 P_LEGAJO,
                                 2,
                                 'SALARIO',
                                 V_MES,
                                 ROUND(V_OCA_TOTAL_MOT),
                                 V_DESC_CODIGO,
                                 32,
                                 V_DPTO,
                                 V_SUC,
                                 1);


                   INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               V_SEG_CONCEPTO,
                               V_SEG_CON_DESC,
                               V_MES,
                               ROUND(V_OCA_TOTAL_IPS),
                               V_DESC_CODIGO,
                               32,
                               V_DPTO,
                               V_SUC,
                               1);
    END IF;

END IF;

IF V_COMI_TRASPORTE = 'S' THEN
       FOR R IN (  select OCA_CLAVE          OCA_CLAVE,
                         OCA_CODIGO         OCA_CODIGO,
                         OCA_LOC_ORIGEN     ORIGEN,
                         OCA_LOC_DESTINO    DESTINO,
                         OCA_FEC_SAL        FECHA,
                         COMISION_ENCARGADO OCA_COF_PORC_SUELDO,

                         COF_PORC_DESC_IPS COF_PORC_DESC_IPS,
                         'N' COF_CONTRIBUYENTE,

                         OCA_PRECIO_KG OCA_PRECIO,

                         OCA_CAM_CODIGO OCA_CAMION,

                         OCA_PESO_KG PESO_KG,
                         OCP_CANTIDAD CANTIDAD,
                         NVL(OCA_PESO_KG, OCP_CANTIDAD) PESO,
                         -------------------------------------------------------------
                         PESO_DCTO            OCA_PESO_DCTO,
                         IMPU_PORC_VTA        IMPU_PORC_VTA,
                         IMPU_BI_VTA          IMPU_BI_VTA,
                         ART_CTACO_VTA        ART_CTACO_VTA,
                         ART_CODIGO_STK       ART_CODIGO_STK,
                         PROD_CLAVE_ACO       PROD_CLAVE_ACO,
                         PROD_DESC            PROD_DESC,
                         PROD_PRECIO_MERMA_GS PROD_PRECIO_DIA,
                         CONF_MAX_PORC_VAR_FE CONF_MAX_PORC_VAR_FE,
                         --    -------------------------------------------------------------
                         nvl(round((NVL(OCA_PESO_KG, OCP_CANTIDAD) * OCA_PRECIO_KG) *
                                   (nvl(0.02, 0) / 100)),
                             0) COMISION
                    FROM TRAI005_V_COMISION V

                   WHERE OCA_CLAVE NOT IN (SELECT OCC_ORDEN_CLAVE
                                             FROM TRA_ODEN_CARGA_EMPL
                                            WHERE OCC_LEGAJO = P_LEGAJO
                                              AND OCC_EMPR = 2)
                     AND EMPR = 2
                     AND OCA_FEC_SAL >= '01/01/2021'
                                              )LOOP

          X_CONTADOR := X_CONTADOR+1;
                 INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO,
                               DES_TRA_OR_CLAVE,
                               DES_TRA_ORDEN,
                               DES_TRA_CAMION,
                               DES_TRA_DESTINO,
                               DES_TRA_FEC_OC,
                               DES_TRA_PESO_DCTO,
                               DES_TRA_COMISION,
                               DES_TRA_ORIGEN)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               NULL,
                               'DETALLE COMISION',
                               V_DESC_CODIGO,
                               33,
                               V_DPTO,
                               V_SUC,
                               X_CONTADOR,
                               R.OCA_CLAVE,
                               R.OCA_CODIGO,
                               R.OCA_CAMION,
                               R.DESTINO,
                               R.FECHA,
                               R.OCA_PESO_DCTO,
                               R.COMISION,
                               R.ORIGEN );


       V_OCA_TOTAL_MOT := V_OCA_TOTAL_MOT+R.COMISION ;
       END LOOP;

   IF V_OCA_TOTAL_MOT > 0 THEN
     INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               12,
                               'COMISIONES',
                               V_MES,
                               ROUND(V_OCA_TOTAL_MOT),
                               V_DESC_CODIGO,
                               34,
                               V_DPTO,
                               V_SUC,
                               1);

                 INSERT INTO PER_DESVINCULACION_DETALLE f
                            (DES_EMPR,
                             DES_LEGAJO,
                             DES_CON_COD,
                             DES_CON_DESC,
                             DES_MES,
                             DES_IMPORTE,
                             DES_CODIGO,
                             DES_TIPO,
                             DES_DPTO,
                             DES_SUC,
                             DES_NRO)
                          VALUES
                            (P_EMPRESA,
                             P_LEGAJO,
                             V_SEG_CONCEPTO,
                             V_SEG_CON_DESC,
                             V_MES,
                             ROUND(V_OCA_TOTAL_MOT*V_SEG_PORCENTAJE),
                             V_DESC_CODIGO,
                             34,
                             V_DPTO,
                             V_SUC,
                             1);


   END IF;



END IF;

---------------------------------------------------------------------------------------
    SELECT COUNT(T.AUSE_EMPR)
              INTO AUSE_CONT 
              FROM PER_AUSENCIAS_JUSTIFICADAS T, PER_TIPOS_AUSENC_JUST A
             WHERE T.AUSE_TIPO = A.TIPAUS_CLAVE
               AND T.AUSE_EMPR = A.TIPAUS_EMPR
               AND T.AUSE_EMPR = 2
               AND T.AUSE_EMPL_LEGAJO = P_LEGAJO
               AND T.AUSE_MOTIVO = 'L'
               AND A.TIPAUS_MARC_PAGA = 'S'
               AND T.AUSE_ESTADO_APROB_ES = 'P'
               AND TO_CHAR(T.AUSE_DESDE, 'MM/YYYY') = V_MES;
     IF AUSE_CONT  > 0 THEN
       RAISE_APPLICATION_ERROR (-20001, 'El empleado cuenta con una ausencia pendiente favor confirmar o rechazar');
     END IF;


--------------------si se cargo algun concepto que aun no se transfirio a finanzas
 INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO,
                               DES_CLAVE_RRHH)

                SELECT a.pdoc_empr,
                       A.PDOC_EMPLEADO,
                       C.PCON_CLAVE,
                       C.PCON_DESC,
                       to_char(a.pdoc_fec,'mm/yyyy'),
                       ROUND(B.PDDET_IMP),
                       V_DESC_CODIGO,
                       40,
                       a.pdoc_departamento,
                       V_SUC,
                       rownum,
                       A.PDOC_CLAVE
                  FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_CONCEPTO C,PER_EMPLEADO E
                 WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
                   AND A.PDOC_EMPR = B.PDDET_EMPR
                   AND B.PDDET_CLAVE_CONCEPTO = C.PCON_CLAVE
                   AND B.PDDET_EMPR = C.PCON_EMPR
                   AND A.PDOC_EMPLEADO = E.EMPL_LEGAJO
                   AND A.PDOC_EMPR = EMPL_EMPRESA
                   AND A.PDOC_EMPR =2
                   and a.pdoc_empleado = P_LEGAJO
                   and nvl(c.pcon_fin_tmov,33) not in (31,33)
                   and NVL(B.PDDET_CLAVE_FIN,   A.PDOC_CLAVE_FIN) is null
                   AND PDOC_PERIODO >=  V_PERIODO
                 ORDER BY 1, 3, 2;


   ---
       ---------------------------------------------------------------------VACACION

    PERI052.FP_TRAER_EMPLEADO(V_EMPRESA               => P_EMPRESA,
                              V_EMPL_LEG              => P_LEGAJO,
                              V_EMPL_DESC             => VAC_EMPL_DESC,
                              V_FORMA_PAG_DESC        => VAC_FORMA_PAG_DESC,
                              V_IMP_X_DIA             => VAC_IMP_X_DIA3,
                              V_ANTIGUE               => VAC_ANTIGUE,
                              V_DIAS_CORRES           => VAC_DIAS_CORRES,
                              V_DIAS_CAUSAD           => VAC_DIAS_CAUSAD,
                              V_DIAS_CONC             => VAC_DIAS_CONC,
                              V_DIAS_PEND             => VAC_DIAS_PEND,
                              V_FECHA_INGRESO         => VAC_FECHA_INGRESO,
                              V_SUCURSAL_DESC         => VAC_SUCURSAL_DESC,
                              V_DIAS_CAUSAD2          => VAC_DIAS_CAUSAD2,
                              V_EMPL_SITUACION        => VAC_EMPL_SITUACION,
                              V_CANT_ANHOS            => VAC_CANT_ANHOS);

  IF TO_CHAR(V_FEC_INGRESO,'MM') > TO_CHAR(P_FECHA,'MM') THEN
        VAC_CANT_ANHOS:= VAC_CANT_ANHOS-1;
     ELSE
        VAC_CANT_ANHOS:= VAC_CANT_ANHOS;
  END IF;

SELECT SUM(CANT_MES)
  INTO VAC_CANT_MESES
  FROM (SELECT ADD_MONTHS(TO_CHAR(TO_dATE(V_FEC_INGRESO), 'DD/MM/') ||
                          (TO_CHAR(TO_DATE(V_FEC_INGRESO), 'YYYY') + VAC_CANT_ANHOS),
                          LEVEL) MESES,
               LEVEL,
               CASE
                 WHEN P_FECHA >=
                      ADD_MONTHS(TO_CHAR(TO_dATE(V_FEC_INGRESO), 'DD/MM/') ||
                                 (TO_CHAR(TO_DATE(V_FEC_INGRESO), 'YYYY') +
                                   VAC_CANT_ANHOS),
                                 LEVEL) THEN
                  1
                 ELSE
                  0
               END CANT_MES
          FROM DUAL
        CONNECT BY LEVEL <= 12);




                 IF VAC_DIAS_PEND > 0 THEN

                    V_VAC_MONTO := VAC_IMP_X_DIA * VAC_DIAS_PEND;

                      IF V_EMPL_FORMA_PAGO = 5 THEN
                        V_VAC_IPS :=  ROUND(V_VAC_MONTO  * 0.05);
                      ELSE
                        V_VAC_IPS := ROUND(V_VAC_MONTO * 0.09);
                      END IF;

                       INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_AFC_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               6,
                               'VACACIONES CAUSADAS',
                               V_MES,
                               ROUND(V_VAC_MONTO),
                               VAC_DIAS_PEND,
                               VAC_IMP_X_DIA,
                               V_DESC_CODIGO,
                               7,
                               V_DPTO,
                               V_SUC,
                               'S',
                               1);


                      INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_AFC_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               V_SEG_CONCEPTO,
                               V_SEG_CON_DESC,
                               V_MES,
                               ROUND(V_VAC_IPS),
                               NULL,
                               NULL,
                               V_DESC_CODIGO,
                               7,
                               V_DPTO,
                               V_SUC,
                               'S',
                               1);
  END IF;
        --     
IF P_TIPO_DESVINCULACION = 2 THEN
  IF ANT_CANT_MESES >0 THEN
     IF ANT_CANT_ANHOS <=5 THEN
       V_PRO  := 1;
       V_VAC_MONTO := VAC_IMP_X_DIA * ANT_CANT_MESES;

     END IF;

     IF ANT_CANT_ANHOS >5 AND ANT_CANT_ANHOS <=10 THEN
       V_PRO  := '1,5';
        V_VAC_MONTO  := VAC_IMP_X_DIA * (ANT_CANT_MESES*1.5);
     END IF;

     IF ANT_CANT_ANHOS > 10 THEN
       V_PRO  := '2,5';
       V_VAC_MONTO  := VAC_IMP_X_DIA * (ANT_CANT_MESES*2.5);
     END IF;

       IF V_EMPL_FORMA_PAGO = 5 THEN
          V_VAC_IPS :=  ROUND(V_VAC_MONTO  * 0.05);
       ELSE
          V_VAC_IPS := ROUND(V_VAC_MONTO * 0.09);
       END IF;

       INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_CANT_PRO,
                               DES_AFC_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               6,
                               'VACACIONES PROPORCIONALES',
                               V_MES,
                               ROUND(V_VAC_MONTO),
                               ANT_CANT_MESES*TO_NUMBER(V_PRO), ---VAC_CANT_MESES,
                               VAC_IMP_X_DIA,
                               V_DESC_CODIGO,
                               8,
                               V_DPTO,
                               V_SUC,
                               V_PRO,
                               'S',
                               2);


                      INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               4,
                               'I.P.S. OBRERO',
                               V_MES,
                               ROUND(V_VAC_IPS),
                               NULL,
                               NULL,
                               V_DESC_CODIGO,
                               8,
                               V_DPTO,
                               V_SUC,
                               2);
end if;
 END IF;



  IF P_IND_OMISION_PREAVISO  = 'S' AND P_IND_PAGA_OMIS_PREAVISO ='S' THEN
------------------------------*********** PRE AVISO


             IF  NVL(ANT_CANT_ANHOS,0) > 0 THEN
             IF ANT_CANT_MESES  >= 1 OR ANT_CANT_DIAS > 0  THEN
               VAC_CANT_ANHOS := ANT_CANT_ANHOS+1;
             ELSE
                VAC_CANT_ANHOS := ANT_CANT_ANHOS;
             END IF;
           END IF;
      IF  NVL(ANT_CANT_ANHOS,0) = 0 THEN
              VAC_CANT_ANHOS := 1;
      END IF;

               IF VAC_CANT_ANHOS <= 1 THEN
                   PRE_DIAS := 30;
                   PRE_MONTO := VAC_IMP_X_DIA * PRE_DIAS;
               ELSIF VAC_CANT_ANHOS >=1 AND  VAC_CANT_ANHOS <6  THEN
                  PRE_DIAS :=45;
                  PRE_MONTO := VAC_IMP_X_DIA * PRE_DIAS;
               ELSIF VAC_CANT_ANHOS > 5 THEN
                  PRE_DIAS :=60;
                  PRE_MONTO := VAC_IMP_X_DIA * PRE_DIAS;

               END IF;

                INSERT INTO PER_DESVINCULACION_DETALLE f
                                      (DES_EMPR,
                                       DES_LEGAJO,
                                       DES_CON_COD,
                                       DES_CON_DESC,
                                       DES_MES,
                                       DES_IMPORTE,
                                       DES_DIAS,
                                       DES_IMP_DIARIO,
                                       DES_CODIGO,
                                       DES_TIPO,
                                       DES_DPTO,
                                       DES_SUC,
                                       DES_NRO)
                                    VALUES
                                      (P_EMPRESA,
                                       P_LEGAJO,
                                       V_SEG_CONCEPTO,
                                       V_SEG_CON_DESC,
                                       V_MES,
                                       ROUND(PRE_MONTO*V_SEG_PORCENTAJE),
                                       NULL,
                                       NULL,
                                       V_DESC_CODIGO,
                                       10,
                                       V_DPTO,
                                       V_SUC,
                                       1);
                                   INSERT INTO PER_DESVINCULACION_DETALLE f
                                      (DES_EMPR,
                                       DES_LEGAJO,
                                       DES_CON_COD,
                                       DES_CON_DESC,
                                       DES_MES,
                                       DES_IMPORTE,
                                       DES_DIAS,
                                       DES_IMP_DIARIO,
                                       DES_CODIGO,
                                       DES_TIPO,
                                       DES_DPTO,
                                       DES_SUC,
                                       DES_NRO)
                                    VALUES
                                      (P_EMPRESA,
                                       P_LEGAJO,
                                       25,
                                       'PRE AVISO',
                                       V_MES,
                                       ROUND(PRE_MONTO),
                                       PRE_DIAS,
                                       VAC_IMP_X_DIA,
                                       V_DESC_CODIGO,
                                       10,
                                       V_DPTO,
                                       V_SUC,
                                       1);



       -- END IF;

 END IF;

        --  PRE_MONTO
         /*IF VAC_CANT_MESES  > 6 THEN
               VAC_CANT_ANHOS+1;
             END IF;*/
------------------------------********** INDERNIZACION


       IF ANT_CANT_ANHOS > 0  THEN

             IF ANT_CANT_MESES  >=6 THEN
               VAC_CANT_ANHOS := ANT_CANT_ANHOS+1;
            else
              VAC_CANT_ANHOS := ANT_CANT_ANHOS;
             END IF;
       end if;
      IF  ANT_CANT_ANHOS = 0 THEN
              VAC_CANT_ANHOS := 1;
      END IF;



   IND_DIAS  := VAC_CANT_ANHOS*15;
   IND_MONTO := VAC_IMP_X_DIA * IND_DIAS;
IF P_TIPO_DESVINCULACION = 2 THEN
   INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               23,
                               'INDEMNIZACION',
                               V_MES,
                               ROUND(IND_MONTO),
                               IND_DIAS,
                               VAC_IMP_X_DIA,
                               V_DESC_CODIGO,
                               11,
                               V_DPTO,
                               V_SUC,
                               1);

     IF V_EMPL_FORMA_PAGO = 5 THEN
          V_VAC_IPS :=  ROUND(IND_MONTO  * 0.05);
          V_DESC_SEGURO :=  'A.M.H';
          V_CONP_COD    := 31;
        ELSE
          V_VAC_IPS := ROUND(IND_MONTO * 0.09);
          V_DESC_SEGURO :=  'I.P.S. OBRERO';
          V_CONP_COD    := 4;
        END IF;
           INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_DIAS,
                               DES_IMP_DIARIO,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               V_CONP_COD,
                               V_DESC_SEGURO,
                               V_MES,
                               ROUND(V_VAC_IPS),
                               NULL,
                               NULL,
                               V_DESC_CODIGO,
                               11,
                               V_DPTO,
                               V_SUC,
                               1);

END IF;

--END IF;

----------------------------------------AGUINALDO****
X_CONTADOR := 0;

SELECT COUNT(*) 
  into v_agui
  FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_EMPLEADO E, PER_CONCEPTO F
 WHERE PDOC_CLAVE = B.PDDET_CLAVE_DOC
   AND PDOC_EMPR = B.PDDET_EMPR
   AND A.PDOC_EMPLEADO = E.EMPL_LEGAJO
   AND PDOC_EMPR = EMPL_EMPRESA
   AND PDOC_EMPR = P_EMPRESA
   AND B.PDDET_CLAVE_CONCEPTO = PCON_CLAVE
   AND B.PDDET_EMPR = PCON_EMPR
   AND EMPL_LEGAJO = P_LEGAJO
   AND PCON_CLAVE = 3
   AND A.PDOC_PERIODO = V_PERIODO;
 if v_agui = 0 then  
    FOR AG IN (SELECT TO_CHAR(A.PDOC_FEC,'MM/YYYY') MES,
                         ROUND(SUM(B.PDDET_IMP)) IMPORTE
                    FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B, PER_CONCEPTO C
                   WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
                     AND A.PDOC_EMPR = B.PDDET_EMPR
                     AND B.PDDET_CLAVE_CONCEPTO = C.PCON_CLAVE
                     AND B.PDDET_EMPR = C.PCON_EMPR
                     AND A.PDOC_EMPR =P_EMPRESA
                     and a.pdoc_fec > V_FEC_INGRESO
                     AND C.PCON_IND_AGUINALDO = 'S'
                     AND A.PDOC_FEC BETWEEN '01/01'||TO_CHAR(P_FECHA,'/YYYY') AND P_FECHA
                     AND A.PDOC_EMPLEADO = P_LEGAJO
                  GROUP BY TO_CHAR(A.PDOC_FEC,'MM/YYYY') )LOOP
                X_CONTADOR :=   X_CONTADOR+1;
              INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               3,
                               'AGUINALDO',
                               AG.MES,
                               ROUND(AG.IMPORTE),
                               V_DESC_CODIGO,
                               12,
                               V_DPTO,
                               V_SUC,
                               X_CONTADOR);


  END LOOP;

end if;
  PERC002.PP_AGUINALDO_MES_ACT(P_EMPRESA => P_EMPRESA,
                               P_LEGAJO  => P_LEGAJO,
                               P_CLAVE   => V_DESC_CODIGO,
                               P_DPTO    => V_DPTO,
                               P_SUC     => V_SUC,
                               P_FECHA   => P_FECHA);


-----------------------------------------------------------****
----------------DEUDAS DEL EMPLEADO CON LA EMPRESA
      BEGIN

        PERC002.PP_DEUDAS_EMPL(P_EMPRESA  => P_EMPRESA,
                               P_LEGAJO   => P_LEGAJO,
                               P_COD_CLI  => V_EMPL_COD_CLIENTE,
                               P_COD_PROV => V_EMPL_CODIGO_PROV,
                               P_CLAVE    => V_DESC_CODIGO,
                               P_FECHA    => P_FECHA);
      END;
      
 IF P_EXONERAR = 'N' AND P_TIPO_DESVINCULACION=1  THEN ---= 1



  SELECT ROUND(SUM(T.DES_IMPORTE))
    INTO X_OMI_IMPR
    FROM PER_DESVINCULACION_DETALLE T, PER_CONCEPTO A
    WHERE T.DES_CON_COD = A.PCON_CLAVE
    AND T.DES_EMPR = A.PCON_EMPR
    AND A.PCON_IND_AGUINALDO = 'S'
    AND T.DES_EMPR = P_EMPRESA
    AND T.DES_LEGAJO =  P_LEGAJO
    AND T.DES_CODIGO = P_CLAVE
    AND NVL(T.DES_AFC_AG,'N') = 'N'
    AND T.DES_TIPO IN (1,2,3,5,6,7,8,9,30,32,34,40);


       SELECT ROUND(SUM(T.DES_IMPORTE))
          INTO X_OMI_IPS
          FROM PER_DESVINCULACION_DETALLE T, PER_CONCEPTO A
          WHERE T.DES_CON_COD = A.PCON_CLAVE
          AND T.DES_EMPR = A.PCON_EMPR
          AND T.DES_EMPR = P_EMPRESA
          AND T.DES_LEGAJO = P_LEGAJO
          AND T.DES_CODIGO =  P_CLAVE
         AND T.DES_CON_COD = 4;


   /*      X_OMI_IMPR := X_OMI_IMPR-X_OMI_IPS;

    IF ANT_CANT_ANHOS <= 1 THEN
           X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*15;
     ELSIF ANT_CANT_ANHOS > 1 AND  ANT_CANT_ANHOS <6 THEN
           X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*22.5;
     ELSE
           X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*30;

     END IF;

     if X_OMISION_PRE_AVISO >  X_OMI_IMPR  then

        X_OMISION_PRE_AVISO :=X_OMI_IMPR;
     else

      X_OMISION_PRE_AVISO := X_OMISION_PRE_AVISO;
     end if;*/
     
     
        X_OMI_IMPR := X_OMI_IMPR-X_OMI_IPS;
         
        x_cant_cumpl := P_FECHA-P_FEC_RENUNCIA;
   
   
   
    IF  NVL(ANT_CANT_ANHOS,0) > 0 THEN
            IF ANT_CANT_MESES  >= 1 OR ANT_CANT_DIAS > 0  THEN
               VAC_CANT_ANHOS := ANT_CANT_ANHOS+1;
             ELSE
               VAC_CANT_ANHOS := ANT_CANT_ANHOS;
             END IF;
           END IF;
      IF  NVL(ANT_CANT_ANHOS,0) = 0 THEN
              VAC_CANT_ANHOS := 1;
      END IF;

    IF VAC_CANT_ANHOS <= 1 THEN
      XDIAS_OMI := (30-nvl(x_cant_cumpl,0))/2;
    
     -- X_DIAS_OMI := 15;
      X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*XDIAS_OMI;
     ELSIF VAC_CANT_ANHOS > 1 AND  VAC_CANT_ANHOS <6 THEN
          XDIAS_OMI := (45-nvl(x_cant_cumpl,0))/2;
          X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*XDIAS_OMI;
       --   raise_application_error (-20001,P_FECHA||'**'||P_FEC_RENUNCIA||'---'||x_cant_cumpl||'*--'||VAC_IMP_X_DIA);  
     ELSE
      -- X_DIAS_OMI :=30;
        XDIAS_OMI := (60-nvl(x_cant_cumpl,0))/2;
        X_OMISION_PRE_AVISO := VAC_IMP_X_DIA*XDIAS_OMI;

     END IF;
 --   
      --   raise_application_error (-20001,P_FECHA||'**'||P_FEC_RENUNCIA||'---'||x_cant_cumpl||'*--'||VAC_IMP_X_DIA);  
       
     

     if X_OMISION_PRE_AVISO >  X_OMI_IMPR  then

        X_OMISION_PRE_AVISO :=X_OMI_IMPR;
     else

      X_OMISION_PRE_AVISO := X_OMISION_PRE_AVISO;
     end if;
     
     
     
     
     
     
     
        INSERT INTO PER_DESVINCULACION_DETALLE f
                              (DES_EMPR,
                               DES_LEGAJO,
                               DES_CON_COD,
                               DES_CON_DESC,
                               DES_MES,
                               DES_IMPORTE,
                               DES_CODIGO,
                               DES_TIPO,
                               DES_DPTO,
                               DES_SUC,
                               DES_AG,
                               DES_NRO)
                            VALUES
                              (P_EMPRESA,
                               P_LEGAJO,
                               37,
                               'OMISION DE PREAVISO',
                               TO_CHAR(P_FECHA,'MM/YYYY'),
                               ROUND(X_OMISION_PRE_AVISO),
                               P_CLAVE,
                               30,
                               V_DPTO,
                               V_SUC,
                               1,
                               1);

  END IF;
     
      

END PP_DETALLE_CONCEPTO_TRA;

PROCEDURE PP_MOSTAR_EN_LIQ (P_EMPRESA IN NUMBER,
                            P_CLAVE   IN NUMBER,
                            P_NRO     IN NUMBER,
                            P_ESTADO  IN VARCHAR2,
                            P_CUOTA   IN VARCHAR2) IS


  BEGIN


  IF P_ESTADO IS NOT NULL THEN
           UPDATE PER_DESVINCULACION_DETALLE t
            SET DES_CUO_MOSTRAR = DECODE(P_ESTADO,'S','N','S')
           WHERE T.DES_EMPR =  P_EMPRESA
             AND T.DES_CODIGO = P_CLAVE
             AND T.DES_NRO = P_NRO
             AND T.DES_TIPO IN(144,14);


 ELSE

          UPDATE PER_DESVINCULACION_DETALLE t
            SET DES_COBRAR_CUO = DECODE(P_CUOTA,'true','S','N')
           WHERE T.DES_EMPR =  P_EMPRESA
             AND T.DES_CODIGO = P_CLAVE
             AND T.DES_NRO = P_NRO
             AND T.DES_TIPO IN(144,14);
  END IF;


END PP_MOSTAR_EN_LIQ;



PROCEDURE PP_COBRO_CUOTA_TRA(P_EMPRESA       IN NUMBER,
                             P_LEGAJO        IN NUMBER,
                             P_PERIODO       IN NUMBER,
                             P_FEC_DOCUMENTO IN DATE,
                             P_NRO_DOC       IN NUMBER,
                             P_BANCO         IN NUMBER,
                             P_MONEDA        IN NUMBER,
                             P_TASA          IN NUMBER,
                             P_SUCURAL       IN NUMBER,
                             P_OBS           IN VARCHAR2,
                             P_CLAVE         IN NUMBER) IS

V_PERI_INI DATE;
V_PERI_FIN DATE;
V_CLIENTE NUMBER;
V_EMPL_CODIGO_PROV NUMBER;
V_CLI_NOMBRE VARCHAR2(100);

V_CLAVE_FIN NUMBER;
BEGIN


  IF P_FEC_DOCUMENTO is null THEN
    RAISE_APPLICATION_ERROR (-20001, 'La fecha del documento no puede quedar vacia');
  END IF;

  IF P_NRO_DOC IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'El nro de documento no puede quedar vacio');
  END IF;

  IF P_BANCO IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'El banco no puede quedar vacio');
  END IF;

  IF P_MONEDA IS NULL THEN
    RAISE_APPLICATION_ERROR (-20001, 'la moneda no puede quedar vacia');
  END IF;

   SELECT EMPL_CODIGO_CLI, EMPL_CODIGO_PROV
     INTO V_CLIENTE, V_EMPL_CODIGO_PROV
     FROM PER_EMPLEADO A
    WHERE EMPL_LEGAJO = P_LEGAJO
      AND EMPL_EMPRESA = P_EMPRESA;


    SELECT CLI_NOM
      INTO V_CLI_NOMBRE
      FROM FIN_CLIENTE
     WHERE CLI_CODIGO = V_CLIENTE
       AND CLI_EMPR = P_EMPRESA;

   SELECT PERI_FEC_INI, PERI_FEC_FIN
     INTO V_PERI_INI, V_PERI_FIN
     FROM PER_PERIODO
    WHERE PERI_EMPR = P_EMPRESA
      AND PERI_CODIGO = P_PERIODO;







         ----------------------------------2-2-170





  ---V_RECIBO    := :BDOC.DOC_NRO_RECIBO_INICIAL;




  --V_CLAVE_FIN := FIN_SEQ_DOC_NEXTVAL;
FOR TL IN  (SELECT T.DES_LINEA_CRE
                FROM PER_DESVINCULACION_DETALLE T
                WHERE T.DES_EMPR = 2
                AND T.DES_TIPO = 144
                AND T.DES_CODIGO= P_CLAVE
                AND T.DES_LEGAJO =P_LEGAJO
                AND T.DES_COBRAR_CUO = 'S'
                group by DES_LINEA_CRE) LOOP
 IF TL.DES_LINEA_CRE  = 9 THEN
     DELETE FROM FIN_FINI037_TEMP WHERE EMPR = P_EMPRESA;
                   FOR  AUT IN  (SELECT 3            FAC_CODIGO,
                                     NULL         FAC_DESC,
                                     NULL         CLI_CODIGO ,
                                     NULL         CLI_NOM,
                                     T.DES_LEGAJO EMPL_CODIGO,
                                     NULL NRO_DOC,
                                     DES_C_DOC_NRO_DOC     DOC_NRO_DOC1,
                                     DES_C_FEC_DOC         DOC_FEC_DOC1,
                                     T.DES_VENCIMIENTO CUO_FEC_VTO,
                                     T.DES_IMPORTE     CUO_IMPORTE,
                                     NULL              V_CLAVE_FIN,
                                     NULL              NRO_RECIBO,
                                     T.DES_CUO_CLAVE   CLAVE_FAC,
                                     null              DOC_FEC_DOC,
                                     null              DOC_FEC_OPER,
                                     DES_EMPR          EMPRESA,
                                     T.DES_CUO_TIPO_MOV  DOC_TIPO_MOV,
                                     T.DES_LINEA_CRE,
                                     NULL DOC_F_HIL
                              FROM PER_DESVINCULACION_DETALLE T
                               WHERE T.DES_EMPR =  2
                                 AND T.DES_CODIGO= P_CLAVE
                                 AND T.DES_LEGAJO =P_LEGAJO
                                 AND T.DES_TIPO =144
                                 AND T.DES_COBRAR_CUO = 'S'
                                 AND DES_LINEA_CRE = 9) LOOP


                      V_CLAVE_FIN := FIN_SEQ_DOC_NEXTVAL;



                    INSERT INTO FIN_FINI037_TEMP
                                (FCAT_CODIGO,
                                 FCAT_DESC,
                                 CLI_CODIGO,
                                 CLI_NOM,
                                 CLI_COD_EMPL_EMPR_ORIG,
                                 DOC_NRO_DOC,
                                 DOC_FEC_DOC,
                                 CUO_FEC_VTO,
                                 CUO_IMP_MON,
                                 CLAVE_FIN,
                                 NRO_RECIBO,
                                 CLAVE_FAC,
                                 FECHA_DOC,
                                 FECHA_OPER,
                                 EMPR,
                                 TIPO_MOV,
                                 LINEA_NEGOCIO,
                                 LIN_CON_HIL)
                              VALUES
                                (3,
                                 null,
                                 V_CLIENTE,
                                 V_CLI_NOMBRE,
                                 P_LEGAJO,
                                 AUT.DOC_NRO_DOC1,
                                 AUT.DOC_FEC_DOC1,
                                 AUT.CUO_FEC_VTO,--:FIN_FINI037_V.CUO_FEC_VTO,
                                 AUT.CUO_IMPORTE,
                                 V_CLAVE_FIN,
                                 P_NRO_DOC,
                                 AUT.CLAVE_FAC,-----:FIN_FINI037_V.CLAVE_FAC,
                                 P_FEC_DOCUMENTO,
                                 P_FEC_DOCUMENTO,
                                 P_EMPRESA,
                                 AUT.DOC_TIPO_MOV,
                                 AUT.DES_LINEA_CRE,
                                 NULL);

                    END LOOP;


     FIN_INS_REC_VARIOS_FUNC('I', P_NRO_DOC,P_eMPRESA);


  ELSIF TL.DES_LINEA_CRE = 4 THEN
  --- RAISE_APPLICATION_ERROR (-20001, 'AFAD');
          DELETE FROM FIN_FINI037_TEMP WHERE EMPR = P_EMPRESA;
               FOR  AUT IN   (SELECT 3            FAC_CODIGO,
                                     NULL         FAC_DESC,
                                     NULL         CLI_CODIGO ,
                                     NULL         CLI_NOM,
                                     T.DES_LEGAJO EMPL_CODIGO,
                                     DES_C_DOC_NRO_DOC     DOC_NRO_DOC1,
                                     DES_C_FEC_DOC         DOC_FEC_DOC1,
                                     T.DES_VENCIMIENTO CUO_FEC_VTO,
                                     T.DES_IMPORTE     CUO_IMPORTE,
                                     NULL              V_CLAVE_FIN,
                                     NULL              NRO_RECIBO,
                                     T.DES_CUO_CLAVE   CLAVE_FAC,
                                     null              DOC_FEC_DOC,
                                     null              DOC_FEC_OPER,
                                     DES_EMPR          EMPRESA,
                                     T.DES_CUO_TIPO_MOV  DOC_TIPO_MOV,
                                     T.DES_LINEA_CRE,
                                     NULL DOC_F_HIL
                              FROM PER_DESVINCULACION_DETALLE T
                               WHERE T.DES_EMPR =  2
                                 AND T.DES_CODIGO= P_CLAVE
                                 AND T.DES_LEGAJO =P_LEGAJO
                                 AND T.DES_TIPO =144
                                 AND T.DES_COBRAR_CUO = 'S'
                                 AND DES_LINEA_CRE = 4) LOOP


                      V_CLAVE_FIN := FIN_SEQ_DOC_NEXTVAL;



                    INSERT INTO FIN_FINI037_TEMP
                                (FCAT_CODIGO,
                                 FCAT_DESC,
                                 CLI_CODIGO,
                                 CLI_NOM,
                                 CLI_COD_EMPL_EMPR_ORIG,
                                 DOC_NRO_DOC,
                                 DOC_FEC_DOC,
                                 CUO_FEC_VTO,
                                 CUO_IMP_MON,
                                 CLAVE_FIN,
                                 NRO_RECIBO,
                                 CLAVE_FAC,
                                 FECHA_DOC,
                                 FECHA_OPER,
                                 EMPR,
                                 TIPO_MOV,
                                 LINEA_NEGOCIO,
                                 LIN_CON_HIL)
                              VALUES
                                (3,
                                 null,
                                 V_CLIENTE,
                                 V_CLI_NOMBRE,
                                 P_LEGAJO,
                                 AUT.DOC_NRO_DOC1,
                                 AUT.DOC_FEC_DOC1,
                                 AUT.CUO_FEC_VTO,--:FIN_FINI037_V.CUO_FEC_VTO,
                                 AUT.CUO_IMPORTE,
                                 V_CLAVE_FIN,
                                 P_NRO_DOC,
                                 AUT.CLAVE_FAC,-----:FIN_FINI037_V.CLAVE_FAC,
                                 P_FEC_DOCUMENTO,
                                 P_FEC_DOCUMENTO,
                                 P_EMPRESA,
                                 AUT.DOC_TIPO_MOV,
                                 AUT.DES_LINEA_CRE,
                                 NULL);

                    END LOOP;
            FIN_INS_REC_FUN('I',3 ,P_NRO_DOC,P_eMPRESA);


  ELSIF  TL.DES_LINEA_CRE = 5 THEN
        DELETE FROM FIN_FINI037_TEMP WHERE EMPR = P_EMPRESA;
                FOR  AUT IN  (SELECT 3  FAC_CODIGO,
                                     NULL         FAC_DESC,
                                     NULL         CLI_CODIGO ,
                                     NULL         CLI_NOM,
                                     T.DES_LEGAJO EMPL_CODIGO,
                                     DES_C_DOC_NRO_DOC     DOC_NRO_DOC1,
                                     DES_C_FEC_DOC         DOC_FEC_DOC1,
                                     T.DES_VENCIMIENTO CUO_FEC_VTO,
                                     T.DES_IMPORTE     CUO_IMPORTE,
                                     NULL              V_CLAVE_FIN,
                                     NULL              NRO_RECIBO,
                                     T.DES_CUO_CLAVE   CLAVE_FAC,
                                     null              DOC_FEC_DOC,
                                     null              DOC_FEC_OPER,
                                     DES_EMPR          EMPRESA,
                                     T.DES_CUO_TIPO_MOV  DOC_TIPO_MOV,
                                     T.DES_LINEA_CRE,
                                     NULL DOC_F_HIL
                              FROM PER_DESVINCULACION_DETALLE T
                               WHERE T.DES_EMPR =  2
                                 AND T.DES_CODIGO= P_CLAVE
                                 AND T.DES_LEGAJO =P_LEGAJO
                                 AND T.DES_TIPO =144
                                 AND T.DES_COBRAR_CUO = 'S'
                                 AND DES_LINEA_CRE = 5) LOOP


                      V_CLAVE_FIN := FIN_SEQ_DOC_NEXTVAL;



                    INSERT INTO FIN_FINI037_TEMP
                                (FCAT_CODIGO,
                                 FCAT_DESC,
                                 CLI_CODIGO,
                                 CLI_NOM,
                                 CLI_COD_EMPL_EMPR_ORIG,
                                 DOC_NRO_DOC,
                                 DOC_FEC_DOC,
                                 CUO_FEC_VTO,
                                 CUO_IMP_MON,
                                 CLAVE_FIN,
                                 NRO_RECIBO,
                                 CLAVE_FAC,
                                 FECHA_DOC,
                                 FECHA_OPER,
                                 EMPR,
                                 TIPO_MOV,
                                 LINEA_NEGOCIO,
                                 LIN_CON_HIL)
                              VALUES
                                (3,
                                 null,
                                 V_CLIENTE,
                                 V_CLI_NOMBRE,
                                 P_LEGAJO,
                                 AUT.DOC_NRO_DOC1,
                                 AUT.DOC_FEC_DOC1,
                                 AUT.CUO_FEC_VTO,--:FIN_FINI037_V.CUO_FEC_VTO,
                                 AUT.CUO_IMPORTE,
                                 V_CLAVE_FIN,
                                 P_NRO_DOC,
                                 AUT.CLAVE_FAC,-----:FIN_FINI037_V.CLAVE_FAC,
                                 P_FEC_DOCUMENTO,
                                 P_FEC_DOCUMENTO,
                                 P_EMPRESA,
                                 AUT.DOC_TIPO_MOV,
                                 AUT.DES_LINEA_CRE,
                                 NULL);

                    END LOOP;
        FIN_INS_REC_REPUESTO_FUNC('I',P_NRO_DOC ,P_eMPRESA,3);

 ELSIF  TL.DES_LINEA_CRE = 0 THEN
        DELETE FROM FIN_FINI037_TEMP WHERE EMPR = P_EMPRESA;
                FOR  AUT IN   (SELECT 3            FAC_CODIGO,
                                     NULL         FAC_DESC,
                                     NULL         CLI_CODIGO ,
                                     NULL         CLI_NOM,
                                     T.DES_LEGAJO EMPL_CODIGO,
                                     DES_C_DOC_NRO_DOC     DOC_NRO_DOC1,
                                     DES_C_FEC_DOC         DOC_FEC_DOC1,
                                     T.DES_VENCIMIENTO CUO_FEC_VTO,
                                     T.DES_IMPORTE     CUO_IMPORTE,
                                     NULL              V_CLAVE_FIN,
                                     NULL              NRO_RECIBO,
                                     T.DES_CUO_CLAVE   CLAVE_FAC,
                                     null              DOC_FEC_DOC,
                                     null              DOC_FEC_OPER,
                                     DES_EMPR          EMPRESA,
                                     T.DES_CUO_TIPO_MOV  DOC_TIPO_MOV,
                                     T.DES_LINEA_CRE,
                                     NULL DOC_F_HIL
                              FROM PER_DESVINCULACION_DETALLE T
                               WHERE T.DES_EMPR =  2
                                 AND T.DES_CODIGO= P_CLAVE
                                 AND T.DES_LEGAJO =P_LEGAJO
                                 AND T.DES_TIPO =144
                                 AND T.DES_COBRAR_CUO = 'S'
                                 AND DES_LINEA_CRE = 0) LOOP


                      V_CLAVE_FIN := FIN_SEQ_DOC_NEXTVAL;



                    INSERT INTO FIN_FINI037_TEMP
                                (FCAT_CODIGO,
                                 FCAT_DESC,
                                 CLI_CODIGO,
                                 CLI_NOM,
                                 CLI_COD_EMPL_EMPR_ORIG,
                                 DOC_NRO_DOC,
                                 DOC_FEC_DOC,
                                 CUO_FEC_VTO,
                                 CUO_IMP_MON,
                                 CLAVE_FIN,
                                 NRO_RECIBO,
                                 CLAVE_FAC,
                                 FECHA_DOC,
                                 FECHA_OPER,
                                 EMPR,
                                 TIPO_MOV,
                                 LINEA_NEGOCIO,
                                 LIN_CON_HIL)
                              VALUES
                                (3,
                                 null,
                                 V_CLIENTE,
                                 V_CLI_NOMBRE,
                                 P_LEGAJO,
                                 AUT.DOC_NRO_DOC1,
                                 AUT.DOC_FEC_DOC1,
                                 AUT.CUO_FEC_VTO,--:FIN_FINI037_V.CUO_FEC_VTO,
                                 AUT.CUO_IMPORTE,
                                 V_CLAVE_FIN,
                                 P_NRO_DOC,
                                 AUT.CLAVE_FAC,-----:FIN_FINI037_V.CLAVE_FAC,
                                 P_FEC_DOCUMENTO,
                                 P_FEC_DOCUMENTO,
                                 P_EMPRESA,
                                 AUT.DOC_TIPO_MOV,
                                 AUT.DES_LINEA_CRE,
                                 NULL);

                    END LOOP;

        FIN_INS_REC_UNIFORME_FUNC('I', P_NRO_DOC,P_EMPRESA);
  END IF;

 END LOOP;

  ---RAISE_APPLICATION_ERROR (20001,'ADFASDF');
  ----------------------------------*COBRAR ADELANTOS

  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'PERI247') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'PERI247');
    END IF;
    APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'PERI247',
                                                   P_QUERY           =>
                                                            'SELECT EMPL_LEGAJO,
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
                                                                 EMPL_MON_PAGO,
                                                                 SITUACION,
                                                                 FORMA_PAGO
                                                            FROM PER_PERI047_V_TAGRO
                                                           WHERE EMPL_LEGAJO = ' ||P_LEGAJO||'
                                                             AND FORMA_PAGO <> 3
                                                             AND NVL(EMPL_MON_PAGO, 1) = 1
                                                             AND (CUO_CLAVE_DOC,CUO_FEC_VTO) NOT IN  (SELECT T.DES_CUO_CLAVE,
                                                                                                             T.DES_VENCIMIENTO
                                                                                                        FROM PER_DESVINCULACION_DETALLE T
                                                                                                       WHERE T.DES_EMPR =2
                                                                                                         AND T.DES_LEGAJO =' || P_LEGAJO||'
                                                                                                         AND T.DES_CODIGO =' ||P_CLAVE||'
                                                                                                         AND T.DES_TIPO = 14
                                                                                                         AND NVL(DES_COBRAR_CUO,''N'') = ''N'')');
               BEGIN
                    PERI247.PP_ACTUALIZAR_REGISTRO(I_PDOC_FEC      => P_FEC_DOCUMENTO,
                                                   I_PDOC_NRO_DOC  => P_NRO_DOC,
                                                   I_EMPRESA       => P_EMPRESA,
                                                   I_PERIODO       => P_PERIODO,
                                                   I_MON_LOC       => 1,
                                                   I_TASA_OFIC     => P_TASA,
                                                   I_DOC_CTA_BCO   => P_BANCO,
                                                   I_MON           => P_MONEDA,
                                                   I_COD_SUCURSAL  => P_SUCURAL,
                                                   I_DOC_OBS       => P_OBS);
              END;

     PERC002.PP_DEUDAS_EMPL(P_EMPRESA  => P_EMPRESA,
                            P_LEGAJO   => P_LEGAJO,
                            P_COD_CLI  => V_CLIENTE,
                             P_COD_PROV => V_EMPL_CODIGO_PROV,
                            P_CLAVE    => P_CLAVE,
                            P_FECHA    => V_PERI_FIN);
END PP_COBRO_CUOTA_TRA;


-----------------------------SE REALIZA POR SEPARADO-----------------------------------



PROCEDURE PP_SALARIO_PROMEDIO  (I_EMPRESA            IN NUMBER,
                                I_LEGAJO             IN NUMBER,
                                I_FEC_CORTE          IN DATE,
                                I_TIPO_SALARIO       IN NUMBER,
                                I_FORMA_PAGO         IN NUMBER,
                                O_IMP_DIARIO         OUT NUMBER,
                                O_SAL_PROMEDIO       OUT NUMBER)IS
  X_IMPORTE_DIARIO NUMBER;
  X_SAL_PROMEDIO NUMBER;
  X_FEC_CORTE DATE;
BEGIN


 IF I_FEC_CORTE  = LAST_DAY(I_FEC_CORTE) THEN
   X_FEC_CORTE := I_FEC_CORTE;
   ELSE
     X_FEC_CORTE :=  ADD_MONTHS(LAST_DAY(I_FEC_CORTE),-1);
 
 END IF;

 IF  I_TIPO_SALARIO NOT IN (2) THEN
  
  BEGIN
    IF I_EMPRESA = 1 THEN
     SELECT CASE WHEN I_FORMA_PAGO IN (1) THEN
                    NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 26),8)
                 ELSE
                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 30),8)
                   END IMPORTE_DIARIO,
               CASE WHEN I_FORMA_PAGO IN (1) THEN
                    NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy'))))),8)
                 ELSE
                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy'))))),8)
                   END IMPORTE_PROMEDIO   
          INTO X_IMPORTE_DIARIO, X_SAL_PROMEDIO
              FROM PERI052_V         A,
                   PER_CONFIGURACION B,
                   PER_PERIODO       C,
                   PER_CONCEPTO      D,
                   PER_EMPLEADO      E
             WHERE A.EMPL_LEGAJO = I_LEGAJO
               AND A.FECHA BETWEEN
                   TO_CHAR(ADD_MONTHS(TRUNC(X_FEC_CORTE,'mm'), -6), 'DD/MM/YYYY') AND X_FEC_CORTE
               AND CONF_EMPR =I_EMPRESA
               AND B.CONF_PERI_ACT  = PERI_CODIGO
               AND B.CONF_EMPR = PERI_EMPR
               AND A.COD_CONCEPTO = D.PCON_CLAVE
               AND B.CONF_EMPR = PCON_EMPR
               AND D.PCON_IND_IPS = 'S'
               AND  A.FECHA >= CASE WHEN  E.EMPL_FEC_INGRESO <= '03/'|| TO_CHAR(E.EMPL_FEC_INGRESO,'MM/YYYY') THEN
                                          EMPL_FEC_INGRESO
                                     ELSE
                                         ADD_MONTHS (EMPL_FEC_INGRESO,1)
                                     END
               AND A.EMPL_LEGAJO = E.EMPL_LEGAJO
               AND CONF_EMPR = E.EMPL_EMPRESA;
       ELSE
           SELECT CASE WHEN I_FORMA_PAGO IN (1) THEN
                    NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 26),8)
                 ELSE
                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy')))) / 30),8)
                   END IMPORTE_DIARIO,
               CASE WHEN I_FORMA_PAGO IN (1) THEN
                    NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy'))))),8)
                 ELSE
                     NVL(ROUND(ROUND(SUM(IMPORTE)/ COUNT (DISTINCT(TO_CHAR(A.FECHA,'mm/yyyy'))))),8)
                   END IMPORTE_PROMEDIO   
                   INTO X_IMPORTE_DIARIO, X_SAL_PROMEDIO
                    FROM PERI052_V_T         A,
                         PER_CONFIGURACION B,
                         PER_PERIODO       C,
                         PER_CONCEPTO      D,
                         PER_EMPLEADO      E
                   WHERE A.EMPL_LEGAJO = I_LEGAJO
                     AND A.FECHA BETWEEN  TO_CHAR(ADD_MONTHS(TRUNC(X_FEC_CORTE,'mm'), -6), 'DD/MM/YYYY') AND X_FEC_CORTE
                     AND CONF_EMPR =I_EMPRESA
                     AND B.CONF_PERI_ACT = PERI_CODIGO
                     AND B.CONF_EMPR = PERI_EMPR
                     AND A.COD_CONCEPTO = D.PCON_CLAVE
                     AND B.CONF_EMPR = PCON_EMPR
                     AND D.PCON_IND_IPS = 'S'
                     AND A.EMPL_LEGAJO = E.EMPL_LEGAJO
                     AND CONF_EMPR = E.EMPL_EMPRESA
                      AND  A.FECHA >= CASE WHEN  E.EMPL_FEC_INGRESO <= '03/'|| TO_CHAR(E.EMPL_FEC_INGRESO,'MM/YYYY') THEN
                                          EMPL_FEC_INGRESO
                                     ELSE
                                         ADD_MONTHS (EMPL_FEC_INGRESO,1)
                                     END;
       
       END IF;
   IF X_IMPORTE_DIARIO  = 8  or X_IMPORTE_DIARIO is null THEN
       X_IMPORTE_DIARIO := 0;
       X_SAL_PROMEDIO := 0;
    ELSE
        X_IMPORTE_DIARIO := X_IMPORTE_DIARIO;
        X_SAL_PROMEDIO := X_SAL_PROMEDIO;
    END IF; 
     
       O_IMP_DIARIO    :=  X_IMPORTE_DIARIO;   
       O_SAL_PROMEDIO  :=  X_SAL_PROMEDIO;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          O_IMP_DIARIO    :=  0;   
          O_SAL_PROMEDIO  :=  0;
      END;

 END IF;


END PP_SALARIO_PROMEDIO;


PROCEDURE PP_CALCULO_PRE_AVISO (I_ANHOS          IN NUMBER,
                                I_MESES          IN NUMBER,
                                I_DIAS           IN NUMBER,
                                I_IMPORTE        IN NUMBER,
                                O_DIAS           OUT NUMBER,
                                O_IMPORTE        OUT NUMBER) IS
  
 V_CANT_ANHOS NUMBER;
 V_PRE_DIAS   NUMBER;
 V_PRE_MONTO  NUMBER;                                 
BEGIN



------------------------------*********** PRE AVISO


    
    
      IF  NVL(I_ANHOS,0) > 0 THEN
             IF I_MESES  >= 1 OR I_DIAS > 0  THEN
               V_CANT_ANHOS := NVL(I_ANHOS,0)+1;
             ELSE
               V_CANT_ANHOS := NVL(I_ANHOS,0);
             END IF;
     END IF;
     
     
     IF  NVL(I_ANHOS,0)= 0 THEN
           V_CANT_ANHOS := 1;
     END IF;

     IF V_CANT_ANHOS <= 1 THEN
         V_PRE_DIAS := 30;
         V_PRE_MONTO := I_IMPORTE * V_PRE_DIAS;
     ELSIF V_CANT_ANHOS >=1 AND  V_CANT_ANHOS <6  THEN
        V_PRE_DIAS :=45;
        V_PRE_MONTO := I_IMPORTE * V_PRE_DIAS;
     ELSIF V_CANT_ANHOS > 5 THEN
        V_PRE_DIAS :=60;
        V_PRE_MONTO := I_IMPORTE * V_PRE_DIAS;
     END IF;
     
     O_DIAS  := V_PRE_DIAS;
     O_IMPORTE := V_PRE_MONTO;
               
END PP_CALCULO_PRE_AVISO;         




PROCEDURE PP_CALCULO_INDERNIZACION (I_ANHOS          IN NUMBER,
                                    I_MESES          IN NUMBER,
                                    I_DIAS           IN NUMBER,
                                    I_IMPORTE        IN NUMBER,
                                    O_DIAS           OUT NUMBER,
                                    O_IMPORTE        OUT NUMBER) IS
  
 V_CANT_ANHOS NUMBER;
 V_IND_DIAS   NUMBER;
 V_IND_MONTO  NUMBER;                                 
BEGIN



       IF I_ANHOS > 0  THEN
             IF I_MESES  >=6 THEN
               V_CANT_ANHOS := I_ANHOS+1;
            ELSE
              
                 V_CANT_ANHOS :=I_ANHOS;
              
             END IF;
       ELSIF I_ANHOS = 0 THEN
            V_CANT_ANHOS := 1;   
       END IF;
      IF  V_CANT_ANHOS = 0 THEN
              V_CANT_ANHOS := 1;
      END IF;



   V_IND_DIAS  := V_CANT_ANHOS*15;
   V_IND_MONTO := I_IMPORTE * V_IND_DIAS;

   O_DIAS      := V_IND_DIAS;
   O_IMPORTE   := V_IND_MONTO;
   
   IF V_IND_DIAS = 0 THEN
       O_DIAS      := 15;
      O_IMPORTE   := 15*V_IND_DIAS;
   END IF;


END PP_CALCULO_INDERNIZACION;     
               
/*


PROCEDURE PP_CALCULO_INDERNIZACION (I_EMPRESA        IN NUMBER,
                                    I_LEGAJO         IN NUMBER,
                                    I_ANTIGUEDAD     IN NUMBER,
                                    O_DIAS           OUT NUMBER,
                                    O_IMPORTE        OUT NUMBER) IS
                                    
BEGIN
  NULL;                                   
                                    
  

END PP_CALCULO_INDERNIZACION;

PROCEDURE PP_CALCULO_PRE_AVISO (I_EMPRESA        IN NUMBER,
                                I_LEGAJO         IN NUMBER,
                                I_ANTIGUEDAD     IN NUMBER,
                                O_DIAS           OUT NUMBER,
                                O_IMPORTE        OUT NUMBER) IS
                                    
BEGIN
  NULL;                                   
                                    
  

END PP_CALCULO_PRE_AVISO;


PROCEDURE PP_CALCULO_VACACIONES (I_EMPRESA        IN NUMBER,
                                 I_LEGAJO         IN NUMBER,
                                 I_ANTIGUEDAD     IN NUMBER,
                                 O_DIAS           OUT NUMBER,
                                 O_IMPORTE        OUT NUMBER) IS
                                    
BEGIN
  NULL;                                   
                                    
  

END PP_CALCULO_VACACIONES;

PROCEDURE PP_CALCULO_AGUINALDO (I_EMPRESA        IN NUMBER,
                                I_LEGAJO         IN NUMBER,
                                I_ANTIGUEDAD     IN NUMBER,
                                O_DIAS           OUT NUMBER,
                                O_IMPORTE        OUT NUMBER) IS
                                    
BEGIN
  NULL;                                   
                                    
  

END PP_CALCULO_VACACIONES;
*/


END;
/
