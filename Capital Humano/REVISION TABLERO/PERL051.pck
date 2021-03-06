create or replace package PERL051 is

 PROCEDURE PP_GRAFICO1_DOTACION(P_EMPRESA NUMBER, P_FECHA DATE);

 PROCEDURE PP_GRAFICO2_ESTRUCTURA(P_EMPRESA IN NUMBER, P_FECHA IN DATE);

 PROCEDURE PP_PROCESO_SELECCION_VAC(P_EMPRESA IN NUMBER, P_FECHA IN DATE);

 PROCEDURE PP_PROCESO_SELECCION_CONT(P_EMPRESA IN NUMBER, P_FECHA IN DATE);
  PROCEDURE PP_PROCESO_SELECCION_SELC(P_EMPRESA IN NUMBER, P_FECHA IN DATE);

 PROCEDURE PP_PROCESO_SELECCION_RSC(P_EMPRESA IN NUMBER, P_FECHA IN DATE);

 PROCEDURE PP_PROCESO_CONTRATACIONES(P_EMPRESA IN NUMBER, P_FECHA IN DATE);

 PROCEDURE PP_PROCESO_DESVINCULACION(P_EMPRESA IN NUMBER, P_FECHA IN DATE);
 PROCEDURE PP_PROCESO_INDICE_ROTACION (P_EMPRESA IN NUMBER, P_FECHA IN DATE);

 PROCEDURE PP_PROCESO_MARCACIONES (P_EMPRESA IN NUMBER, P_FECHA IN DATE);
 PROCEDURE ORDEN_MES (P_FECHA IN DATE);

 PROCEDURE PP_GUARDAR_DATOS_MARCACIONES (P_OPCION VARCHAR2,
                                         P_FECHA  IN DATE,
                                         P_EMPRESA IN NUMBER);


  PROCEDURE PP_ESTRUCTURA_DETALLE (P_FECHA  IN DATE,
                                  P_EMPRESA   IN NUMBER,
                                  P_DIAS_LABORAL   OUT NUMBER,
                                  P_DIAS_HABILES   OUT NUMBER,
                                  P_DOTAC_M3       OUT NUMBER,
                                  P_OBJETIVO_KG       OUT NUMBER,
                                  P_OBJETIVO_GS       OUT NUMBER);



  PROCEDURE PP_ESTRUCTURA_HIPER(P_EMPRESA IN NUMBER,
                                P_FECHA  IN DATE,
                                P_OPCION  IN NUMBER,
                                P_MES IN NUMBER ,
                                P_DIAS_HABILES OUT VARCHAR2,
                                P_DIAS_TRABADOS OUT VARCHAR2,
                                P_IMPORTE OUT VARCHAR2,
                                P_DOTACION     OUT VARCHAR2,
                                P_FEC_CORTE    OUT VARCHAR2,
                                P_KILO          OUT VARCHAR2);


 PROCEDURE PP_ESTURURA_HIPER2 (P_EMPRESA       IN NUMBER,
                               P_FECHA         IN DATE,
                               P_OPCION        IN NUMBER,
                               P_MES           IN NUMBER,
                               P_DIAS_HABILES  OUT VARCHAR2,
                               P_DIAS_TRABADOS OUT VARCHAR2,
                               P_IMPORTE       OUT VARCHAR2,
                               P_DOTACION      OUT VARCHAR2,
                               P_FEC_CORTE     OUT VARCHAR2,
                               P_KILO          OUT VARCHAR2,
                               P_MES2          IN VARCHAR2) ;

  PROCEDURE PP_EDIT_DOT_PRODUCCION (P_EMPRESA IN NUMBER,
                                   P_SELC_LEGAJO IN VARCHAR2);

 PROCEDURE PP_TABLERO_COMERCIAL  (P_EMPRESA  IN NUMBER,
                                 P_FECHA    IN DATE);


 PROCEDURE PP_TABLERO_INDUSTRIAL (P_EMPRESA  IN NUMBER,
                                  P_FECHA    IN DATE);


 PROCEDURE PP_DOTACION (P_EMPRESA IN NUMBER,
                        P_FECHA   IN DATE);

  PROCEDURE PP_VAC_SEL_CONT (P_EMPRESA IN NUMBER,
                            P_FECHA IN DATE);



 PROCEDURE PP_MARCACION_NUEVO (P_EMPRESA      IN NUMBER,
                               P_FECHA        IN DATE);

 PROCEDURE PP_NUEVO_ESTRUCTURA (P_EMPRESA IN NUMBER,
                                P_FECHA IN DATE );


   PROCEDURE PP_AUSENCIAS (P_EMPRESA              IN NUMBER,
                           P_FECHA                IN DATE,
                           P_SESSION              IN NUMBER );


  PROCEDURE PP_NUEVO_IND_ROTACION (P_EMPRESA     IN NUMBER,
                                   P_FECHA       IN DATE);
                                   
FUNCTION PP_ESTADO_VAC  (P_EMPRESA IN NUMBER,
                         P_NRO      IN NUMBER )RETURN VARCHAR2;                                 
PROCEDURE PP_ROTACION_CARGO;

procedure add_hist_query(in_nombre varchar2, in_query clob);

end PERL051;
/
create or replace package body PERL051 is

 PROCEDURE PP_GRAFICO1_DOTACION (P_EMPRESA NUMBER,
                                 P_FECHA DATE)IS

 P_QUERY1 VARCHAR2(21000);
 P_QUERY2 VARCHAR2(21000);
 P_QUERY3 VARCHAR2(21000);
 V_FECHA DATE;
 V_CONTADOR NUMBER;

 BEGIN

   V_FECHA := TO_DATE(P_FECHA);
   ----------------------------------------------------------------------------------------------------VERIFICADO
     P_QUERY1 := 'SELECT DEPARTAMENTO,
                         MES1,
                         MES1_VALOR,
                         SUM(MES1_VALOR) OVER(PARTITION BY MES1) MES1_TOTAL,
                         MES2,
                         MES2_VALOR,
                         SUM(MES2_VALOR) OVER(PARTITION BY MES2) MES2_TOTAL,
                         MES3,
                         MES3_VALOR,
                         SUM(MES3_VALOR) OVER(PARTITION BY MES3) MES3_TOTAL,
                         MES_1,
                         MES_2,
                         MES_3
                    FROM (SELECT CASE
                            WHEN DPTO_SUC = 2 THEN
                                 ''CDA''
                            WHEN DPTO_CODIGO = 1 THEN
                                 ''ADM''
                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN
                                ''COMERCIAL''
                            ELSE
                               ''INDUSTRIAL''
                            END DEPARTAMENTO,

                       TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2), ''MM/YYYY'') MES1,
                                 SUM(CASE
                                       WHEN EMPL_SITUACION = ''A'' AND
                                            EMPL_FEC_INGRESO <=
                                            LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                                        1
                                       ELSE
                                        0
                                     END) + SUM(CASE
                                                  WHEN EMPL_SITUACION = ''I'' AND
                                                       EMPL_FEC_INGRESO <=
                                                       LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) AND
                                                       EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                                                   1
                                                  ELSE
                                                   0
                                                END) MES1_VALOR,
                                 ----VALOR MES 2
                                 TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1), ''MM/YYYY'') MES2,
                                 SUM(CASE
                                       WHEN EMPL_SITUACION = ''A'' AND
                                            EMPL_FEC_INGRESO <=
                                            LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                                        1
                                       ELSE
                                        0
                                     END) + SUM(CASE
                                                  WHEN EMPL_SITUACION = ''I'' AND
                                                       EMPL_FEC_INGRESO <=
                                                       LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) AND
                                                       EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                                                   1
                                                  ELSE
                                                   0
                                                END) MES2_VALOR,
                                 -----VALOR MES 3
                                 TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') MES3,
                                 SUM(CASE
                                       WHEN EMPL_SITUACION = ''A'' AND
                                            EMPL_FEC_INGRESO <= '''||P_FECHA||''' THEN
                                        1
                                       ELSE
                                        0
                                     END) + SUM(CASE
                                                  WHEN EMPL_SITUACION = ''I'' AND
                                                       EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                                       EMPL_FEC_SALIDA > '''||P_FECHA||''' THEN
                                                   1
                                                  ELSE
                                                   0
                                                END) MES3_VALOR,
                                                --DESDE AQUI MES PARA PODER HACER LOS DEMAS GRAFICOS--
                                     EXTRACT(MONTH FROM TO_DATE('''||P_FECHA||''')) || ''/'' ||
                                     EXTRACT(YEAR FROM TO_DATE('''||P_FECHA||''')) MES_3,
                                     EXTRACT(MONTH FROM TO_DATE(ADD_MONTHS('''||P_FECHA||''', -1))) || ''/'' ||
                                     EXTRACT(YEAR FROM TO_DATE(ADD_MONTHS('''||P_FECHA||''', -1))) MES_2,
                                     EXTRACT(MONTH FROM TO_DATE(ADD_MONTHS('''||P_FECHA||''', -2))) || ''/'' ||
                                     EXTRACT(YEAR FROM TO_DATE(ADD_MONTHS('''||P_FECHA||''', -2))) MES_1
                    FROM PER_EMPLEADO E, GEN_DEPARTAMENTO DPTO
                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                     AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                     AND EMPL_CODIGO_PROV <> 0
                     AND EMPL_TIPO_CONT <> ''T''
                     AND EMPL_FORMA_PAGO <> 0
                     AND EMPL_EMPRESA = 1
                     GROUP BY CASE
                            WHEN DPTO_SUC = 2 THEN
                                 ''CDA''
                            WHEN DPTO_CODIGO = 1 THEN
                                 ''ADM''
                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN
                                ''COMERCIAL''
                            ELSE
                               ''INDUSTRIAL''
                            END)';

P_QUERY2 := 'SELECT DOT_DEPARTAMENTO, MAX(PB), MAX(MES1), MAX(MES2)
              FROM(SELECT T.DOT_DEPARTAMENTO,
              ROUND(COUNT(*)/12) PB,NULL MES1, NULL MES2
              FROM PER_DOTACION_JSA T
              WHERE DOT_MES_ANHO IN (''01/2017'',''02/2017'',''03/2017'',''04/2017'',''05/2017'',''06/2017'',
              ''07/2017'',''08/2017'',''09/2017'',''10/2017'',''11/2017'',''12/2017'')
              GROUP BY DOT_DEPARTAMENTO
              UNION ALL
              SELECT T.DOT_DEPARTAMENTO,NULL, COUNT(*) MES2, NULL
              FROM PER_DOTACION_JSA T
              WHERE DOT_MES_ANHO = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''MM/YYYY'')
              GROUP BY DOT_DEPARTAMENTO
              UNION ALL
              SELECT T.DOT_DEPARTAMENTO, NULL, NULL, COUNT(*) MES3
              FROM PER_DOTACION_JSA T
              WHERE DOT_MES_ANHO =TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1),''MM/YYYY'')
              GROUP BY DOT_DEPARTAMENTO)
              GROUP BY DOT_DEPARTAMENTO';

------------------------------------------------------------------------------------------------verificado
     P_QUERY3 := 'SELECT DPTO_CODIGO||'' - ''||DECODE(DPTO_CODIGO,29,''P.J.C'',DPTO_DESC) DEPARTAMENTO,

                  TO_CHAR(TO_DATE('''||P_FECHA||'''), ''DD/MM/YYYY'')SEMANA_ACT,
                       ''ACTUAL'' INDICADOR,
                       SUM(CASE
                             WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' THEN
                              1
                             ELSE
                              0
                           END) + SUM(CASE
                                        WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                             EMPL_FEC_SALIDA > '''||P_FECHA||''' THEN
                                         1
                                        ELSE
                                         0
                                      END) TOTAL_ACT,
                       TO_CHAR(TO_DATE('''||P_FECHA||''')-7, ''DD/MM/YYYY'')SEMANA_PASADA,
                       ''ANTERIOR'' INDICADOR,
                       SUM(CASE
                             WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= TO_DATE('''||P_FECHA||''')-7 THEN
                              1
                             ELSE
                              0
                           END) + SUM(CASE
                                        WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= TO_DATE('''||P_FECHA||''')-7 AND
                                             EMPL_FEC_SALIDA > TO_DATE('''||P_FECHA||''')-7 THEN
                                         1
                                        ELSE
                                         0
                                      END) TOTAL_SEM
              FROM PER_EMPLEADO E, GEN_DEPARTAMENTO DPTO
             WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
               AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
               AND EMPL_CODIGO_PROV <> 0
               AND EMPL_TIPO_CONT <> ''T''
               AND EMPL_FORMA_PAGO <> 0
               AND EMPL_EMPRESA = 1
               AND DPTO_SUC NOT IN (1,2,8)
               GROUP BY DPTO_DESC, DPTO_CODIGO';


   IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TAB_DOTACION') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TAB_DOTACION');
   END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TAB_DOTACION',
                                                       P_QUERY           => P_QUERY1);

  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TAB_DOTACION1') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TAB_DOTACION1');
  END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TAB_DOTACION1',
                                                       P_QUERY           => P_QUERY2);

 IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TAB_DOTACION3') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TAB_DOTACION3');
  END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TAB_DOTACION3',
                                                       P_QUERY           => P_QUERY3);
 END PP_GRAFICO1_DOTACION;

 PROCEDURE PP_GRAFICO2_ESTRUCTURA (P_EMPRESA IN NUMBER,
                                   P_FECHA IN DATE) IS

  P_QUERY VARCHAR2(21000);
  P_QUERY2 VARCHAR2(21000);
  P_QUERY3 VARCHAR2(21000); ---TODOS LOS MONTOS DE LOS MESES DESDE ENERO 2018 SIRVE PARA EL OBJETIVO
  P_QUERY4 VARCHAR2(21000);
  P_QUERY5 VARCHAR(21000);
  P_QUERY6 VARCHAR(21000);
  P_QUERY7 VARCHAR(21000);
  p_QUERY10 VARCHAR2(21000);
  P_QUERY8 VARCHAR(21000); --SIRVE PARA CALCULAR LA PROYECCION QUE SERIA EL (TOTAL_VENTA/DIAS_TRAB)*DIAS_HABILES23 y divide por la dotacion
  P_QUERY9 VARCHAR(21000); ---CALCULA LA CANTIDAD DE DIAS TRABAJADOS, ESPERO QUE SEA EL ULTIMO PQUERY
  V_MES1 VARCHAR2(15);
  V_MES2 VARCHAR2(15);
  V_MES3 VARCHAR2(15);
  V_MES_1 VARCHAR2(15);
  V_MES_2 VARCHAR2(15);
  V_MES_3 VARCHAR2(15);
  CONT NUMBER :=0;
  V_FECHA DATE;
  V_MES_ANHO VARCHAR2(20);
  V_VALOR VARCHAR2(20);
  V_IND VARCHAR2(20);
  V_VALOR_IND  VARCHAR2(20);
  V_FECHA2 VARCHAR2(60);
  V_FECHA_HAB DATE;
  X_CONF_TABLEAU_DESDE DATE;
 BEGIN
   SELECT EXTRACT(MONTH FROM TO_DATE(P_FECHA)) || '/' ||
       EXTRACT(YEAR FROM TO_DATE(P_FECHA)) MES3,
       EXTRACT(MONTH FROM TO_DATE(ADD_MONTHS(P_FECHA, -1))) || '/' ||
       EXTRACT(YEAR FROM TO_DATE(ADD_MONTHS(P_FECHA, -1))) MES2,
       EXTRACT(MONTH FROM TO_DATE(ADD_MONTHS(P_FECHA, -2))) || '/' ||
       EXTRACT(YEAR FROM TO_DATE(ADD_MONTHS(P_FECHA, -2))) MES1
   INTO V_MES3, V_MES2, V_MES1
  FROM DUAL;

   V_FECHA_HAB := TBL_ULT_DIA_LAB_SUCURSAL(I_FECHA => P_FECHA);

    select T.CONF_TABLEAU_DESDE
    INTO X_CONF_TABLEAU_DESDE
      from GEN_CONFIGURACION t
      WHERE T.CONF_EMPR = P_EMPRESA;


 P_QUERY7 := 'SELECT SUM(A.ART_KG_CONTENIDO * A.CANTIDAD), TO_CHAR(FECHA, ''MM/YYYY'') FECHA1,
               EXTRACT(MONTH FROM TO_DATE(FECHA)) || ''/'' ||
               EXTRACT(YEAR FROM TO_DATE(FECHA)) MES_ANHO
                FROM ADCS.CUBO_OPERACIONES_STK_COSTOS_V A, STK_ARTICULO B
               WHERE A.ART_CODIGO = B.ART_CODIGO
                 AND B.ART_EMPR = 1
                 AND B.ART_IND_CONS_PB = ''S''
                 AND A.FECHA BETWEEN  '''||X_CONF_TABLEAU_DESDE||''' AND '''||V_FECHA_HAB||'''
                 AND OPERACION_CODIGO = 9
                 GROUP BY TO_CHAR(FECHA, ''MM/YYYY''),
                 EXTRACT(MONTH FROM TO_DATE(FECHA)) || ''/'' ||
                  EXTRACT(YEAR FROM TO_DATE(FECHA))';


 P_QUERY5 := 'SELECT SUM(A.ART_KG_CONTENIDO * A.CANTIDAD),
                     TO_CHAR(A.FECHA, ''MM/YYYY'') MES,
                     ROW_NUMBER() OVER (ORDER BY TO_CHAR(A.FECHA, ''MM/YYYY''))
                FROM ADCS.CUBO_OPERACIONES_STK_COSTOS_V A, STK_ARTICULO B
               WHERE A.ART_CODIGO = B.ART_CODIGO
                 AND B.ART_EMPR = 1
                 AND B.ART_IND_CONS_PB = ''S''
                 AND A.FECHA BETWEEN ADD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''),-2)
                 AND '''||V_FECHA_HAB||'''
                 AND OPERACION_CODIGO = 9
               GROUP BY TO_CHAR(A.FECHA, ''MM/YYYY'')';

 P_QUERY6 := 'SELECT SUM(A.ART_KG_CONTENIDO * A.CANTIDAD) M
                FROM ADCS.CUBO_OPERACIONES_STK_COSTOS_V A, STK_ARTICULO B
               WHERE A.ART_CODIGO = B.ART_CODIGO
                 AND B.ART_EMPR = 1
                 AND B.ART_IND_CONS_PB = ''S''
                 AND A.FECHA BETWEEN '''||X_CONF_TABLEAU_DESDE||'''  AND LAST_DAY(ADD_MONTHS(TRUNC(TO_DATE('''||X_CONF_TABLEAU_DESDE||'''), ''MM''),+11))
                 AND OPERACION_CODIGO = 9' ;

  P_QUERY8:= 'SELECT SUM(DET_TOTAL_GS), SUM(CANT_KG) GS,  MES||''/''||ANHO, MES, ANHO
                FROM(
                SELECT VE.SU_VT,
                       VE.ANHO,
                       VE.MES,
                       VE.MARCA,
                       MARC_CODIGO,
                       VE.LINEA,
                       ve.LIN_CODIGO,
                       VE.ENVASE,
                       VE.COD_ART,
                       VE.ART_DESC,
                       VE.DOC_TIPO,
                       ------------------------------------------------------------------------

                       SUM(DECODE(VE.DOC_TIPO,''NCR'',-1,1) * VE.CANT_ENV)              CANT_ENV,
                       SUM(DECODE(VE.DOC_TIPO,''NCR'',-1,1) * VE.CANT_KG)               CANT_KG,
                       SUM(DECODE(VE.DOC_TIPO,''NCR'',-1,1) * VE.DET_TOTAL_GS)          DET_TOTAL_GS,
                       ------------------------------------------------------------------------

                       DOC_LEGAJO


                FROM-----------------------------------------------------------

                    (
                  SELECT SUVE.SUC_DESC SU_VT,


                         CASE
                           WHEN FA.DOC_TIPO_MOV IN (9, 10) THEN
                            ''FAC''
                           ELSE
                            ''NCR''
                         END DOC_TIPO,

                         FA.DOC_FEC_DOC FECHA,
                         TO_CHAR(FA.DOC_FEC_DOC, ''DD'') DIA,
                         TO_CHAR(FA.DOC_FEC_DOC, ''YYYY'') ANHO,
                         TO_NUMBER(TO_CHAR(FA.DOC_FEC_DOC, ''MM'')) MES,
                         FA.DOC_NRO_DOC NUMERO_DOC,
                         DOC_CLAVE CLAVE,
                         DOC_SIST SIST,
                         DOC_CLI DOC_CLI,


                         FA.DET_NRO_ITEM DET_ITEM,
                         ------------------------------------------------------------
                         MA.MARC_DESC MARCA,
                         MA.MARC_CODIGO,
                         LI.LIN_CODIGO LIN_CODIGO,
                         LI.LIN_DESC LINEA,
                         ------------------------------------------------------------
                           EN.ENVA_DESC        ENVASE,
                         ------------------------------------------------------------

                         AR.ART_CODIGO       COD_ART,
                         AR.ART_DESC         ART_DESC,
                         AR.ART_KG_CONTENIDO PESO,
                         ------------------------------------------------------------
                         DECODE(DOC_MON, 2, FA.DET_NETO_MON, NULL) DET_TOTAL_US,
                         ----
                         FA.DET_NETO_LOC DET_TOTAL_GS,
                         ------------------------------------------------------------
                         ROUND(FA.DET_NETO_LOC /
                               DECODE(FA.DET_CANT, 0, 1, FA.DET_CANT, FA.DET_CANT),
                               4) PRECIO_GS_ENV,
                         ------------------------------------------------------------
                         CASE
                           WHEN NVL(AR.ART_KG_CONTENIDO, 0) > 0 AND FA.DET_CANT > 0 THEN
                            ROUND((FA.DET_NETO_LOC) / (FA.DET_CANT * AR.ART_KG_CONTENIDO), 4)
                           ELSE
                            NULL
                         END PRECIO_GS_KG,
                         ------------------------------------------------------------
                         FA.DET_CANT CANT_ENV,
                         ------------------------------------------------------------
                         CASE
                           WHEN NVL(AR.ART_KG_CONTENIDO, 0) > 0 AND FA.DET_CANT > 0 THEN
                            ROUND(FA.DET_CANT * AR.ART_KG_CONTENIDO, 4)
                           ELSE
                            NULL
                         END CANT_KG,

                         ------------------------------------------------------------

                         DOC_EMPR,
                         DOC_LEGAJO

                    FROM GEN_SUCURSAL    SUVE,

                         ----
                         STK_ARTICULO AR,
                         ----
                         STK_MARCA        MA,
                         STK_LINEA        LI,

                         STK_ENVASES      EN,

                         (SELECT DOC_MON,
                                 DOC_CLI,
                                 DOC_CANAL,
                                 C.DOC_EMPR,
                                 DOC_SUC,
                                 DOC_LEGAJO,
                                 DOC_FEC_DOC,
                                 DOC_NRO_DOC,
                                 DOC_TIPO_MOV,
                                 DET_ART,
                                 DET_CANT,
                                 DET_NETO_LOC,
                                 DET_NETO_MON,
                                 DET_NRO_ITEM,
                                 DOC_CLI_NOM,
                                 DOC_SIST,
                                 DOC_CLAVE
                            FROM FIN_DOCUMENTO C, FAC_DOCUMENTO_DET D, STK_DOCUMENTO E, (SELECT DOC_CLAVE_PADRE, DOC_EMPR
                                                                                          FROM FIN_DOCUMENTO D
                                                                                         WHERE D.DOC_TIPO_MOV in (47,48)
                                                                                           AND D.DOC_EMPR = 1) ANUL
                           WHERE C.DOC_CLAVE = D.DET_CLAVE_DOC
                             AND C.DOC_EMPR = D.DET_EMPR
                             AND C.DOC_CLAVE_STK = E.DOCU_CLAVE
                             AND C.DOC_EMPR = E.DOCU_EMPR
                             AND C.DOC_EMPR = 1
                             AND C.DOC_TIPO_MOV IN (9, 10, 16)
                             AND C.DOC_CLAVE = ANUL.DOC_CLAVE_PADRE (+)
                             AND C.DOC_EMPR = ANUL.DOC_EMPR (+)
                             AND ANUL.DOC_CLAVE_PADRE IS NULL
                             AND C.DOC_FEC_DOC BETWEEN  ADD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''),-2)
                             AND '''||V_FECHA_HAB||'''


                          UNION ALL
                          SELECT DOC_MON,
                                 DOC_CLI,
                                 DOC_CANAL,
                                 C.DOC_EMPR,
                                 DOC_SUC,
                                 DOC_LEGAJO,
                                 DOCU_FEC_EMIS,
                                 DOC_NRO_DOC,
                                 DOC_TIPO_MOV,
                                 DETA_ART,
                                 DETA_CANT,
                                 DETA_IMP_NETO_LOC,
                                 DETA_IMP_NETO_MON,
                                 DETA_NRO_ITEM,
                                 DOC_CLI_NOM,
                                 DOC_SIST,
                                 DOCU_CLAVE
                            FROM FIN_DOCUMENTO C, STK_DOCUMENTO_DET D, STK_DOCUMENTO E, (SELECT DOC_CLAVE_PADRE, DOC_EMPR
                                                                                          FROM FIN_DOCUMENTO D
                                                                                         WHERE D.DOC_TIPO_MOV in (47,48)
                                                                                         AND D.DOC_EMPR = 1) ANUL
                           WHERE C.DOC_CLAVE = E.DOCU_CLAVE_FIN
                             AND C.DOC_EMPR = E.DOCU_EMPR
                             AND E.DOCU_CLAVE = D.DETA_CLAVE_DOC
                             AND E.DOCU_EMPR = D.DETA_EMPR
                             AND C.DOC_EMPR = 1
                             AND C.DOC_TIPO_MOV IN (9, 10, 16)
                             AND C.DOC_CLAVE = ANUL.DOC_CLAVE_PADRE (+)
                             AND C.DOC_EMPR = ANUL.DOC_EMPR (+)
                             AND ANUL.DOC_CLAVE_PADRE IS NULL
                             AND C.DOC_FEC_DOC BETWEEN  ADD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''),-2)
                             AND '''||V_FECHA_HAB||'''

                          ) FA
                   WHERE  SUVE.SUC_EMPR(+) = FA.DOC_EMPR
                     AND SUVE.SUC_CODIGO(+) = FA.DOC_SUC

                        -----
                     AND AR.ART_CODIGO(+) = FA.DET_ART
                     AND AR.ART_EMPR(+) = FA.DOC_EMPR
                        -----
                     AND MA.MARC_CODIGO(+) = ART_MARCA
                     AND MA.MARC_EMPR(+) = ART_EMPR


                     AND EN.ENVA_LINEA(+) = ART_LINEA
                     AND EN.ENVA_CODIGO(+) = AR.ART_ENVASE
                     AND EN.ENVA_EMPR(+) = AR.ART_EMPR

                     AND LI.LIN_CODIGO(+)=ART_LINEA
                     AND LI.LIN_EMPR(+)=ART_EMPR

                     AND FA.DOC_EMPR = 1
                     AND AR.ART_EMPR = 1

                    )  VE
                GROUP BY
                VE.SU_VT,VE.DOC_TIPO,
                       VE.ANHO,
                       VE.MES,
                       VE.MARCA,
                       VE.LINEA,
                       VE.ENVASE,
                       LIN_CODIGO,
                       VE.COD_ART,
                       VE.ART_DESC,MARC_CODIGO,
                       DOC_LEGAJO,
                       FECHA)
                       GROUP BY MES, ANHO';

  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'EST_PRODUCTO') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EST_PRODUCTO');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'EST_PRODUCTO',
                                                         P_QUERY           => P_QUERY5);

   IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'EST_PROD_PB') THEN
        APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EST_PROD_PB');
     END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'EST_PROD_PB',
                                                        P_QUERY           => P_QUERY6);


      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'OBJETIVO_PB_PRO') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'OBJETIVO_PB_PRO');
          END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'OBJETIVO_PB_PRO',
                                                       P_QUERY           => P_QUERY7);


     ----PROYECCION
        IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'EST_PROYECCION') THEN
            APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EST_PROYECCION');
        END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'EST_PROYECCION',
                                                       P_QUERY           => P_QUERY8);


  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'OBJETIVO2') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'OBJETIVO2');
   END IF;
      APEX_COLLECTION.CREATE_COLLECTION (P_COLLECTION_NAME => 'OBJETIVO2');

   V_FECHA := X_CONF_TABLEAU_DESDE;

    WHILE TO_DATE(LAST_DAY(V_FECHA)) <= ADD_MONTHS(to_DATE(LAST_DAY(P_FECHA)),+1)  LOOP


           SELECT MES, MES_VALOR, DEPARTAMENTO,INDUSTRIAL_VALOR , FECHA2
           INTO V_MES_ANHO, V_VALOR, V_IND, V_VALOR_IND, V_FECHA2
           FROM
                (SELECT CASE
                 WHEN EMPL_DEPARTAMENTO IN (3,4,5,6,7,8,13,21,23,24,27,28,33) THEN

                  'INDUSTRIAL'
               END DEPARTAMENTO,
               EXTRACT(MONTH FROM TO_DATE(V_FECHA)) || '/' ||
               EXTRACT(YEAR FROM TO_DATE(V_FECHA)) MES,
              SUM( SUM(CASE
                     WHEN EMPL_SITUACION = 'A' AND
                          EMPL_FEC_INGRESO <= LAST_DAY(V_FECHA) THEN
                      1
                     ELSE
                      0
                   END) + SUM(CASE
                                WHEN EMPL_SITUACION = 'I' AND
                                     EMPL_FEC_INGRESO <= LAST_DAY(V_FECHA) AND
                                     EMPL_FEC_SALIDA > LAST_DAY(V_FECHA) THEN
                                 1
                                ELSE
                                 0
                              END)) OVER (PARTITION BY 2)  MES_VALOR,
              SUM(CASE
                     WHEN EMPL_SITUACION = 'A' AND
                          EMPL_FEC_INGRESO <= LAST_DAY(V_FECHA) THEN
                      1
                     ELSE
                      0
                   END) + SUM(CASE
                                WHEN EMPL_SITUACION = 'I' AND
                                     EMPL_FEC_INGRESO <= LAST_DAY(V_FECHA) AND
                                     EMPL_FEC_SALIDA > LAST_DAY(V_FECHA) THEN
                                 1
                                ELSE
                                 0
                              END) INDUSTRIAL_VALOR,
                TO_CHAR(V_FECHA,'MM/YYYY') FECHA2
          FROM per_empleado
         WHERE EMPL_CODIGO_PROV <> 0
           AND EMPL_TIPO_CONT <> 'T'
           AND EMPL_FORMA_PAGO <> 0
           AND EMPL_EMPRESA = 1

           GROUP BY  CASE WHEN EMPL_DEPARTAMENTO IN (3,4,5,6,7,8,13,21,23,24,27,28,33) THEN

                  'INDUSTRIAL'
               END) WHERE DEPARTAMENTO IS NOT NULL;

      IF  V_FECHA >= ADD_MONTHS(to_DATE(LAST_DAY(P_FECHA)),-13 )THEN
         CONT := CONT+ 1;
      END IF;
     APEX_COLLECTION.ADD_MEMBER (
      p_collection_name => 'OBJETIVO2',
                 p_C001 => V_MES_ANHO,
                 P_C002 => V_VALOR,
                 P_C003 => V_IND,
                 P_C004 => V_VALOR_IND,
                 P_C005 => CONT,
                 P_C006 => V_FECHA2);


     V_FECHA := ADD_MONTHS(V_FECHA,+1);
    END LOOP;



 END PP_GRAFICO2_ESTRUCTURA;
   
   PROCEDURE PP_PROCESO_SELECCION_VAC (P_EMPRESA IN NUMBER,
                                  P_FECHA IN DATE) IS

   P_QUERY VARCHAR2(21000);
   P_QUERY2 VARCHAR2(21000);
   P_QUERY5 VARCHAR2(31000);
   V_MES3            VARCHAR2(60);
   V_MES2            VARCHAR2(60);
   V_MES1            VARCHAR2(60);
   V_SEMANA          VARCHAR2(60);
   V_FECHA1          DATE;
   V_FECHA2          DATE;
   V_FECHA_PB        DATE;
   V_MES_PB           VARCHAR2(60);
   V_MES0            VARCHAR2(60);
   P_AND VARCHAR2(2000);
   P_AND_SOL VARCHAR2(2000);
   P_AND_SEL VARCHAR2(2000);
   p_and_transagro  VARCHAR2(2000);
 BEGIN
 SELECT  TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY'),
         TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)),'DD/MM/YYYY'),
         TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)),'DD/MM/YYYY'),
         TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-12)),'DD/MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-12),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-3),'MM/YYYY')
   INTO V_MES1, V_MES2, V_MES3,V_SEMANA,V_FECHA1, V_FECHA2, V_FECHA_PB,V_MES_PB,V_MES0
  FROM DUAL;


 if  P_FECHA = last_day(TO_DATE(P_FECHA))  then
   p_and_transagro := p_and_transagro ||' semana is null and MES || ''/'' || ANHO = '''||V_MES3||'''';
    P_AND := P_AND||'and semana is null AND MES || ''/'' || ANHO = '''||V_MES3||'''';
    P_AND_SOL := P_AND_SOL|| 'and SOL.semana is null AND SOL.MES||''/''||SOL.ANHO = '''||V_MES3||'''';
    P_AND_SEL := P_AND_SEL|| 'and SEL.semana is null AND SEL.MES||''/''||SEL.ANHO = '''||V_MES3||'''';
 else
    p_and_transagro := p_and_transagro||' SEMANA || ''/'' || ANHO = '''||V_SEMANA||'''';
    P_AND := P_AND||'AND MES IS NULL AND SEMANA || ''/'' || ANHO = '''||V_SEMANA||'''';
    P_AND_SOL := P_AND_SOL|| 'AND SOL.MES IS NULL AND SOL.SEMANA||''/''||SOL.ANHO ='''||V_SEMANA||'''';
    P_AND_SEL := P_AND_SEL|| 'AND SEL.MES IS NULL AND SEL.SEMANA||''/''||SEL.ANHO ='''||V_SEMANA||'''';
 end if;
 
IF P_EMPRESA = 1 THEN
    P_QUERY :=' SELECT ''VACANCIAS DEL MES'' DETALLE, ''Q''UM, PB PB,NVL(MES1,0), NVL(MES2,0), NVL(MES3,0),'''||V_MES1||''','''||V_MES2||''','''||V_MES3||'''
                 FROM
                  (SELECT SUM(SOLPER_CANT) MES1
                   FROM PER_SOLICITUD_PERSONAL_HIST T
                  WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') = '''||V_MES1||'''
                  AND T.SOLPER_ESTADO_APROB = ''C''
                   and SOLPER_ESTADO_FINAL <> ''A''
                  and  SOLPER_EMPR ='||P_EMPRESA||'
                  AND T.SEMANA IS NULL
                   AND T.MES || ''/'' || ANHO = '''||V_MES1||''') A ,
                   ( SELECT SUM(SOLPER_CANT) MES2
                             FROM PER_SOLICITUD_PERSONAL_HIST T
                            WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') ='''||V_MES2||'''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                             AND T.semana IS NULL
                            and  SOLPER_EMPR ='||P_EMPRESA||'
                              AND T.MES || ''/'' || ANHO ='''||V_MES2||''')B,
                   (SELECT SUM(SOLPER_CANT) MES3
                             FROM PER_SOLICITUD_PERSONAL_HIST T
                            WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') ='''||V_MES3||'''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                            and  SOLPER_EMPR ='||P_EMPRESA||'
                            '||P_AND||'

                              ) C,
                  (SELECT SUM(SOLPER_CANT) PB
                             FROM PER_SOLICITUD_PERSONAL_HIST T
                            WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') ='''||V_MES_PB||'''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                            and  SOLPER_EMPR ='||P_EMPRESA||'
                            and t.semana is null
                              AND T.MES || ''/'' || ANHO = '''||V_MES_PB||''') D

                 UNION ALL
                   SELECT ''VACANCIAS ACUM.'' DETALLE, ''Q''UM,PB PB ,NVL(MES1,0), NVL(MES2,0), NVL(MES3,0), null, null, null
                 FROM
                  (select sum(MES1) MES1 from
                  (SELECT ((SOLPER_CANT)) MES1
                             FROM PER_SOLICITUD_PERSONAL_HIST T
                            WHERE  T.MES || ''/'' || ANHO =  '''||V_MES0||'''
                            and t.semana is null
                             AND NVL(SOLPER_ESTADO_FINAL,''EP'')in ( ''EP'',''EE'',''P'',''ER'')-- = ''EP''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                            and  SOLPER_EMPR ='||P_EMPRESA||' ))A,
                    ( select SUM(MES2)  MES2-- SUM(MES2) MES2
                    FROM( select SOLPER_CANT MES2--, ''b'',''VACANCIAS ACUM.''
                             from per_solicitud_personal_hist T
                            WHERE t.mes || ''/'' || anho =  '''||V_MES1||'''
                            and t.semana is null
                            and  SOLPER_EMPR ='||P_EMPRESA||'
                              AND NVL(SOLPER_ESTADO_FINAL,''EP'') in ( ''EP'',''EE'',''P'',''ER'') --= ''EP''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A'')
                           
                           
                            )B,
                     (select 
                               SUM(MES3)   MES3
                    FROM (select SOLPER_CANT MES3--, ''b'',''VACANCIAS ACUM.''
                             from per_solicitud_personal_hist T
                            WHERE t.mes || ''/'' || anho =  '''||V_MES2||'''
                            and  SOLPER_EMPR ='||P_EMPRESA||'
                            and t.semana is null
                              AND NVL(SOLPER_ESTADO_FINAL,''EP'') in ( ''EP'',''EE'',''P'',''ER'') --= ''EP''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                       )  )C,
                 ( select SUM(PB) PB
                    FROM( select SUM(CASE
                                       WHEN T.SOLPER_FECHA_SOL <=LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -12)) THEN
                                       (SOLPER_CANT)
                                     END) PB--, ''b'',''VACANCIAS ACUM.''
                             from per_solicitud_personal_hist T
                            WHERE t.mes || ''/'' || anho =  '''||V_MES_PB||'''
                            and t.semana is null
                              AND NVL(SOLPER_ESTADO_FINAL,''EP'') in ( ''EP'',''EE'',''P'',''ER'')
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                            and  SOLPER_EMPR ='||P_EMPRESA||'
                            union all
                            SELECT count(*) MES2
                            FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                                 PER_AREA_DPP                AR,
                                 PER_CARGO                   PC,
                                 PER_SELECCION_PERSONAL_HIST SEL,
                                 PER_CONTRATO_PROC_SEL       CON
                           WHERE SOL.SOLPER_EMPR = 1
                             AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                             AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                             AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                             AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                             AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                             AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                             AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI(+)
                             AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL(+)
                             AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR(+)
                             AND SEL.SELEPER_ESTADO_GRAL = ''C''
                             AND SOLPER_ESTADO_FINAL = ''F''
                              and SOLPER_ESTADO_FINAL <> ''A''
                             and  SOLPER_EMPR ='||P_EMPRESA||'
                             AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)
                             and sel.semana is null
                             and sol.semana is null
                             AND SOL.MES||''/''||SOL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-12),''MM/YYYY'')
                             AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-12),''MM/YYYY'')
                             AND SOLPER_FECHA_APROB  < ''01/''||TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-12),''MM/YYYY'')
                             and CONSEL_FECHA_INICIO >= ''01/''||TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-12),''MM/YYYY''))
                              )D ';

    -----------------------------NUEVOS
    P_QUERY2 := '  SELECT SUM(T.SOLPER_CANT),
                          A.AREDPP_DESC,
                          TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),
                          DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'',''ER'',  ''En Reclutamiento'', ''A'',''ANULADO'') ESTADO_FINAL,
                          1 fecha
                       FROM PER_SOLICITUD_PERSONAL_HIST T, PER_AREA_DPP A
                      WHERE T.SOLPER_AREA = A.AREDPP_CLAVE
                        AND T.SOLPER_EMPR = A.AREDPP_EMPR
                        AND TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') =  '''||V_MES1||'''
                        AND T.MES || ''/'' || ANHO =  '''||V_MES1||'''
                        and t.semana is null
                        AND T.SOLPER_ESTADO_APROB = ''C''
                        and  SOLPER_EMPR ='||P_EMPRESA||'
                         and SOLPER_ESTADO_FINAL <> ''A''
                        GROUP BY AREDPP_DESC,TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),  SOLPER_ESTADO_FINAL
                       UNION ALL
                     SELECT   SUM(T.SOLPER_CANT),
                              A.AREDPP_DESC,
                              TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),
                              DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'',''ER'',  ''En Reclutamiento'', ''A'',''ANULADO'') ESTADO_FINAL,
                              2 fecha
                       FROM PER_SOLICITUD_PERSONAL_HIST T, PER_AREA_DPP A
                      WHERE T.SOLPER_AREA = A.AREDPP_CLAVE(+)
                        AND T.SOLPER_EMPR = A.AREDPP_EMPR
                        AND TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') =  '''||V_MES2||'''
                        AND T.MES || ''/'' || ANHO =  '''||V_MES2||'''
                        and t.semana is null
                        AND T.SOLPER_ESTADO_APROB = ''C''
                         and SOLPER_ESTADO_FINAL <> ''A''
                        and  SOLPER_EMPR ='||P_EMPRESA||'
                        GROUP BY AREDPP_DESC,TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),  SOLPER_ESTADO_FINAL
                       UNION ALL
                          SELECT SUM(T.SOLPER_CANT),
                           A.AREDPP_DESC,
                           TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),
                           DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'',''ER'',  ''En Reclutamiento'', ''A'',''ANULADO'') ESTADO_FINAL,
                           3 fecha
                           FROM PER_SOLICITUD_PERSONAL_HIST T, PER_AREA_DPP A
                          WHERE T.SOLPER_AREA = A.AREDPP_CLAVE(+)
                            AND T.SOLPER_EMPR = A.AREDPP_EMPR
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                            and  SOLPER_EMPR ='||P_EMPRESA||'
                            AND TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = '''||V_MES3||'''
                            '||P_AND||'
                        GROUP BY AREDPP_DESC,TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),  SOLPER_ESTADO_FINAL';

    -----------------------------------
  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'VACANCIA_1') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'VACANCIA_1');
    END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'VACANCIA_1',
                                                         P_QUERY           => P_QUERY);

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'VAC_DEPARTAMENTO') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'VAC_DEPARTAMENTO');
    END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'VAC_DEPARTAMENTO',
                                                         P_QUERY           => P_QUERY2);
                                                         
  P_QUERY5 :=                                                        
     'SELECT T.SOLPER_CLAVE NRO_SOL,
       T.SOLPER_FECHA_SOL FECHA_SOLICITUD,
       T.SOLPER_OPERADOR_SOL SOLICITANTE,
       DECODE(SOLPER_NIVEL_URGENCIA, ''M'', ''MEDIO'', ''A'', ''ALTO'', ''B'', ''BAJO'') NIVEL_URGENCIA,
       T.SOLPER_AREA AREA,
       T.SOLPER_CARGO CARGO,
       DECODE(SOLPER_TIPO_CONT, ''IN'', ''Indefinido'', ''TE'', ''Temporal'') TIPO_CONTRATO,
       DECODE(SOLPER_TIPO_CONTRATACION,
              ''PR'',
              ''Programada'',
              ''DR'',
              ''Directa'',
              ''RC'',
              ''Re-Contratacion'') TIPO_CONTRATACION,
       DECODE(SOLPER_TIPO_SELEC,
              ''PR'',
              ''Programada'',
              ''AN'',
              ''Anticipada'',
              ''RC'',
              ''Re-Contratacion'') TIPO_SELECCION,
       T.SOLPER_CANT CANT_VACANCIA,
       DECODE(SOLPER_ESTADO_APROB,
              ''C'',
              ''Confirmado'',
              ''P'',
              ''Pendiente'',
              ''R'',
              ''Rechazado'',
              NULL,
              ''Pendiente'') ESTADO_APROB_SOL,
       T.SOLPER_FECHA_APROB FECHA_APROBACION,
       DECODE(SOLPER_ESTADO_FINAL,
              ''F'',
              ''Finalizado'',
              ''EP'',
              ''En Proceso'',
              ''R'',
              ''Rechazado'',
              ''P'',
              ''Pendiente'',
              ''EE'',
              ''En Espera'',
              ''ER'',
              ''En Reclutamiento'',
              ''A'',
              ''ANULADO'') ESTADO_FIN_SOL,
       ''VACANCIAS DEL MES'',
       T.MES || ''/'' || ANHO mes
  FROM PER_SOLICITUD_PERSONAL_HIST T
 WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') = '''||V_MES1||'''
   AND T.SOLPER_ESTADO_APROB = ''C''
   and SOLPER_ESTADO_FINAL <> ''A''
   and SOLPER_EMPR = 1
   AND T.SEMANA IS NULL
   AND T.MES || ''/'' || ANHO = '''||V_MES1||'''
union all

SELECT T.SOLPER_CLAVE NRO_SOL,
       T.SOLPER_FECHA_SOL FECHA_SOLICITUD,
       T.SOLPER_OPERADOR_SOL SOLICITANTE,
       DECODE(SOLPER_NIVEL_URGENCIA, ''M'', ''MEDIO'', ''A'', ''ALTO'', ''B'', ''BAJO'') NIVEL_URGENCIA,
       T.SOLPER_AREA AREA,
       T.SOLPER_CARGO CARGO,
       DECODE(SOLPER_TIPO_CONT, ''IN'', ''Indefinido'', ''TE'', ''Temporal'') TIPO_CONTRATO,
       DECODE(SOLPER_TIPO_CONTRATACION,
              ''PR'',
              ''Programada'',
              ''DR'',
              ''Directa'',
              ''RC'',
              ''Re-Contratacion'') TIPO_CONTRATACION,
       DECODE(SOLPER_TIPO_SELEC,
              ''PR'',
              ''Programada'',
              ''AN'',
              ''Anticipada'',
              ''RC'',
              ''Re-Contratacion'') TIPO_SELECCION,
       T.SOLPER_CANT CANT_VACANCIA,
       DECODE(SOLPER_ESTADO_APROB,
              ''C'',
              ''Confirmado'',
              ''P'',
              ''Pendiente'',
              ''R'',
              ''Rechazado'',
              NULL,
              ''Pendiente'') ESTADO_APROB_SOL,
       T.SOLPER_FECHA_APROB FECHA_APROBACION,
       DECODE(SOLPER_ESTADO_FINAL,
              ''F'',
              ''Finalizado'',
              ''EP'',
              ''En Proceso'',
              ''R'',
              ''Rechazado'',
              ''P'',
              ''Pendiente'',
              ''EE'',
              ''En Espera'',
              ''ER'',
              ''En Reclutamiento'',
              ''A'',
              ''ANULADO'') ESTADO_FIN_SOL,
       ''VACANCIAS DEL MES'',
       T.MES || ''/'' || ANHO mes
  FROM PER_SOLICITUD_PERSONAL_HIST T
 WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') = '''||V_MES2||'''
   AND T.SOLPER_ESTADO_APROB = ''C''
   and SOLPER_ESTADO_FINAL <> ''A''
   and SOLPER_EMPR = 1
   and t.semana is null
   AND T.MES || ''/'' || ANHO = '''||V_MES2||'''

union all
SELECT T.SOLPER_CLAVE NRO_SOL,
       T.SOLPER_FECHA_SOL FECHA_SOLICITUD,
       T.SOLPER_OPERADOR_SOL SOLICITANTE,
       DECODE(SOLPER_NIVEL_URGENCIA, ''M'', ''MEDIO'', ''A'', ''ALTO'', ''B'', ''BAJO'') NIVEL_URGENCIA,
       T.SOLPER_AREA AREA,
       T.SOLPER_CARGO CARGO,
       DECODE(SOLPER_TIPO_CONT, ''IN'', ''Indefinido'', ''TE'', ''Temporal'') TIPO_CONTRATO,
       DECODE(SOLPER_TIPO_CONTRATACION,
              ''PR'',
              ''Programada'',
              ''DR'',
              ''Directa'',
              ''RC'',
              ''Re-Contratacion'') TIPO_CONTRATACION,
       DECODE(SOLPER_TIPO_SELEC,
              ''PR'',
              ''Programada'',
              ''AN'',
              ''Anticipada'',
              ''RC'',
              ''Re-Contratacion'') TIPO_SELECCION,
       T.SOLPER_CANT CANT_VACANCIA,
       DECODE(SOLPER_ESTADO_APROB,
              ''C'',
              ''Confirmado'',
              ''P'',
              ''Pendiente'',
              ''R'',
              ''Rechazado'',
              NULL,
              ''Pendiente'') ESTADO_APROB_SOL,
       T.SOLPER_FECHA_APROB FECHA_APROBACION,
       DECODE(SOLPER_ESTADO_FINAL,
              ''F'',
              ''Finalizado'',
              ''EP'',
              ''En Proceso'',
              ''R'',
              ''Rechazado'',
              ''P'',
              ''Pendiente'',
              ''EE'',
              ''En Espera'',
              ''ER'',
              ''En Reclutamiento'',
              ''A'',
              ''ANULADO'') ESTADO_FIN_SOL,
       ''VACANCIAS DEL MES'',
      '''||V_MES3||''' mes
  FROM PER_SOLICITUD_PERSONAL_HIST T
 WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') = '''||V_MES3||'''
   AND T.SOLPER_ESTADO_APROB = ''C''
   and SOLPER_ESTADO_FINAL <> ''A''
   and SOLPER_EMPR = 1
   '||P_AND||'
  union all
---------------------------------------------------****                
                  SELECT 
                          T.SOLPER_CLAVE NRO_SOL, 
                          T.SOLPER_FECHA_SOL FECHA_SOLICITUD,
                          T.SOLPER_OPERADOR_SOL SOLICITANTE, 
                          DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'')NIVEL_URGENCIA,
                          T.SOLPER_AREA AREA,
                          T.SOLPER_CARGO CARGO,
                          DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                          DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'') TIPO_CONTRATACION,
                          DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')TIPO_SELECCION,
                          T.SOLPER_CANT CANT_VACANCIA,
                          DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                          T.SOLPER_FECHA_APROB FECHA_APROBACION,
                          DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'',  ''En Reclutamiento'', ''A'',''ANULADO'') ESTADO_FIN_SOL,
                          ''VACANCIAS ACUM.'',
                         '''||V_MES1||'''--  T.MES || ''/'' || ANHO mes
                             
                             FROM PER_SOLICITUD_PERSONAL_HIST T
                            WHERE  T.MES || ''/'' || ANHO =  '''||V_MES0||'''
                            and t.semana is null
                             AND NVL(SOLPER_ESTADO_FINAL,''EP'')in ( ''EP'',''EE'',''P'',''ER'')-- = ''EP''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                            and  SOLPER_EMPR =1
       union all                    
                           
  select  T.SOLPER_CLAVE NRO_SOL, 
                          T.SOLPER_FECHA_SOL FECHA_SOLICITUD,
                          T.SOLPER_OPERADOR_SOL SOLICITANTE, 
                          DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'')NIVEL_URGENCIA,
                          T.SOLPER_AREA AREA,
                          T.SOLPER_CARGO CARGO,
                          DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                          DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'') TIPO_CONTRATACION,
                          DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')TIPO_SELECCION,
                          T.SOLPER_CANT CANT_VACANCIA,
                          DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                          T.SOLPER_FECHA_APROB FECHA_APROBACION,
                          DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'',  ''En Reclutamiento'', ''A'',''ANULADO'') ESTADO_FIN_SOL,
                          ''VACANCIAS ACUM.'',
                           '''||V_MES2||'''mes
  
  
                             from per_solicitud_personal_hist T
                            WHERE t.mes || ''/'' || anho =  '''||V_MES1||'''
                            and t.semana is null
                            and  SOLPER_EMPR =1
                              AND NVL(SOLPER_ESTADO_FINAL,''EP'') in ( ''EP'',''EE'',''P'',''ER'') --= ''EP''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                                union all                    
                           
  select  T.SOLPER_CLAVE NRO_SOL, 
                          T.SOLPER_FECHA_SOL FECHA_SOLICITUD,
                          T.SOLPER_OPERADOR_SOL SOLICITANTE, 
                          DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'')NIVEL_URGENCIA,
                          T.SOLPER_AREA AREA,
                          T.SOLPER_CARGO CARGO,
                          DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                          DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'') TIPO_CONTRATACION,
                          DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')TIPO_SELECCION,
                          T.SOLPER_CANT CANT_VACANCIA,
                          DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                          T.SOLPER_FECHA_APROB FECHA_APROBACION,
                          DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'',  ''En Reclutamiento'', ''A'',''ANULADO'') ESTADO_FIN_SOL,
                          ''VACANCIAS ACUM.'',
                          '''||V_MES3||'''
                             from per_solicitud_personal_hist T
                            WHERE t.mes || ''/'' || anho =  '''||V_MES2||'''
                            and t.semana is null
                            and  SOLPER_EMPR =1
                              AND NVL(SOLPER_ESTADO_FINAL,''EP'') in ( ''EP'',''EE'',''P'',''ER'') --= ''EP''
                            AND T.SOLPER_ESTADO_APROB = ''C''
                             and SOLPER_ESTADO_FINAL <> ''A''
                             ';

                        
                             
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_VACANCIAS') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_VACANCIAS');
    END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DET_VACANCIAS',
                                                         P_QUERY           => P_QUERY5);                      
                                                                                 
                                                  
                                                         
 ELSE
   P_QUERY2 :=   'SELECT SOLPER_FECHA_APROB,
                         SOLPER_AREA,
                         SOLPER_CARGO,
                         SOLPER_CANT,
                         SOLPER_FECHA_SOL,
                         SOLPER_ESTADO_APROB,
                         SOLPER_VAC_CUBIERTA,
                         ANHO,
                         SEMANA,
                         MES,
                         CASE
                           WHEN to_char(SOLPER_FECHA_SOL,''mm/yyyy'')=  '''||V_MES3||''' and '||p_and_transagro||' THEN
                            3 --- TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
                           WHEN to_char(SOLPER_FECHA_SOL,''mm/yyyy'')=  '''||V_MES1||'''   and MES || ''/'' || ANHO = '''||V_MES1||'''  THEN
                            1 --- '''||V_MES1||'''
                           WHEN to_char(SOLPER_FECHA_SOL,''mm/yyyy'')=  '''||V_MES2||'''  and MES || ''/'' || ANHO = '''||V_MES2||'''  THEN
                            2 --- '''||V_MES2||'''

                         END ANHO,
                         '''||V_MES1||''' MES1,
                         '''||V_MES2||''' MES2,
                         '''||V_MES3||''' MES3,
                         SOLPER_SUCURSAL,
                         CASE
                             WHEN SOLPER_AREA IN (4) THEN
                              1 ---ADMINISTACION
                             WHEN SOLPER_AREA IN (7) THEN
                              2 ---GRANOS
                             WHEN SOLPER_AREA IN (6) THEN
                              3 ---INSUMOS
                             WHEN SOLPER_AREA IN (2) THEN
                              4 ---UNIDADES
                             WHEN SOLPER_AREA IN (1, 3, 5) THEN
                              5 ---TRANSPORTE
                             WHEN SOLPER_AREA IN (8) THEN
                              6 ---REPUESTO
                           END NUEVAS_AREAS,

                           CASE
                             WHEN SOLPER_AREA IN (4) THEN
                              ''ADMINISTACION''
                             WHEN SOLPER_AREA IN (7) THEN
                             ''GRANOS''
                             WHEN SOLPER_AREA IN (6) THEN
                              ''INSUMOS''
                             WHEN SOLPER_AREA IN (2) THEN
                              ''UNIDADES''
                             WHEN SOLPER_AREA IN (1, 3, 5) THEN
                              ''TRANSPORTE''
                             WHEN SOLPER_AREA IN (8)  THEN
                             ''REPUESTO''
                           END NUEVAS_DESC
                    FROM PER_SOLICITUD_PERSONAL_HIST T
                   WHERE T.SOLPER_EMPR = 2
                     AND SOLPER_FECHA_APROB >= ''01/''||'''||V_MES1||'''
                     AND CASE
                           WHEN '||p_and_transagro||' THEN
                            1
                           WHEN MES || ''/'' || ANHO = '''||V_MES1||''' THEN

                            1
                           WHEN MES || ''/'' || ANHO = '''||V_MES2||''' THEN
                            1
                         END = 1';

END IF;


 delete x
 where otro = 'DET_VACANCIAS';

                            insert into x
                         (campo1,  otro)
                       values
                         (P_QUERY5, 'DET_VACANCIAS');


IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'VACANCIAS_TRANS') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'VACANCIAS_TRANS');
    END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'VACANCIAS_TRANS',
                                                         P_QUERY           => P_QUERY2);

 END PP_PROCESO_SELECCION_VAC;

PROCEDURE PP_PROCESO_SELECCION_CONT(P_EMPRESA IN NUMBER, P_FECHA IN DATE)IS
     P_QUERY VARCHAR2(21000);
     P_QUERY2 VARCHAR2(21000);
     P_QUERY3 VARCHAR2(21000);
     P_QUERY7 VARCHAR2(21000);
     P_AND VARCHAR2(2000);
     P_AND_SOL VARCHAR2(2000);
     P_AND_SEL VARCHAR2(2000);
 BEGIN

  P_QUERY2:='SELECT
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY''),
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY''),
                 TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
              FROM DUAL';
    P_QUERY3 :='SELECT ''Directa'',4
                  FROM DUAL
                 UNION ALL
                 SELECT ''Programada'', 5
                  FROM DUAL
                  UNION ALL
                  SELECT ''Acumulada'', 7
                  FROM DUAL ';

 IF  P_FECHA = LAST_DAY(TO_DATE(P_FECHA))  THEN
    P_AND := P_AND||'AND SEMANA IS NULL AND MES || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';

    P_AND_SOL := P_AND_SOL|| 'and sol.semana is null AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';
    P_AND_SEL := P_AND_SEL|| 'and sel.semana is null AND SEL.MES||''/''||SEL.ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';

 ELSE
   P_AND := P_AND||'and mes is null AND SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
    P_AND_SOL := P_AND_SOL|| 'and sol.mes is null AND SOL.SEMANA||''/''||SOL.ANHO =TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
    P_AND_SEL := P_AND_SEL|| 'and sel.mes is null AND SEL.SEMANA||''/''||SEL.ANHO =TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
 END IF;

  P_QUERY7 := 
              ' SELECT   1 Q_VACANT,
                     SOL.SOLPER_CLAVE NRO_SOL,
                     TO_CHAR(CONSEL_FECHA_INICIO, ''MON/YYYY'') MES_ANHO,
                     AR.AREDPP_DESC AREA,
                     CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_CONTRATACION,
                      CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_SELEC_SOL,
                     SOL.SOLPER_CARGO,
                     SOLPER_FECHA_SOL,
                     SOL.SOLPER_OPERADOR_SOL,
                     DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                     DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                     DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                     SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                     SOLPER_FECHA_APROB FECHA_APROB_SOL,
                     DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                     1 ORDEN,
                     TO_CHAR(CONSEL_FECHA_INICIO, ''MM/YYYY'') MES_ANHOG
                  FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                       PER_AREA_DPP                AR,
                       PER_CARGO                   PC,
                       PER_SELECCION_PERSONAL_HIST SEL,
                       PER_CONTRATO_PROC_SEL       CON
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                   AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                   AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                   AND SEL.SELEPER_ESTADO_GRAL = ''C''
                   AND SOLPER_ESTADO_FINAL = ''F''
                   and SOLPER_TIPO_CONTRATACION <>''RC''
                   and sol.semana is null 
                   and sel.semana is null
                   AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                   AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                   AND TO_CHAR(CON.CONSEL_FECHA_INICIO,''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
               UNION ALL
                SELECT   1 Q_VACANT,
                     SOL.SOLPER_CLAVE NRO_SOL,
                     TO_CHAR(CONSEL_FECHA_INICIO, ''MON/YYYY'') MES_ANHO,
                     AR.AREDPP_DESC AREA,
                     CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_CONTRATACION,
                      CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_SELEC_SOL,
                     SOL.SOLPER_CARGO,
                     SOLPER_FECHA_SOL,
                     SOL.SOLPER_OPERADOR_SOL,
                     DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                     DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                     DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                     SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                     SOLPER_FECHA_APROB FECHA_APROB_SOL,
                     DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                     2 ORDEN,
                     TO_CHAR(CONSEL_FECHA_INICIO, ''MM/YYYY'') MES_ANHOG
                  FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                       PER_AREA_DPP                AR,
                       PER_CARGO                   PC,
                       PER_SELECCION_PERSONAL_HIST SEL,
                       PER_CONTRATO_PROC_SEL       CON
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                   AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                   AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                   and SOLPER_TIPO_CONTRATACION <>''RC''
                   AND SEL.SELEPER_ESTADO_GRAL = ''C''
                   AND SOLPER_ESTADO_FINAL = ''F''
                   and sol.semana is null 
                   and sel.semana is null
                   AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                   AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                   AND TO_CHAR(CON.CONSEL_FECHA_INICIO,''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
              union all
               SELECT   1 Q_VACANT,
                     SOL.SOLPER_CLAVE NRO_SOL,
                     TO_CHAR(CONSEL_FECHA_INICIO, ''MON/YYYY'') MES_ANHO,
                     AR.AREDPP_DESC AREA,
                     CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_CONTRATACION,
                      CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_SELEC_SOL,
                     SOL.SOLPER_CARGO,
                     SOLPER_FECHA_SOL,
                     SOL.SOLPER_OPERADOR_SOL,
                     DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                     DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                     DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                     SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                     SOLPER_FECHA_APROB FECHA_APROB_SOL,
                     DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                     3 ORDEN,
                     TO_CHAR(CONSEL_FECHA_INICIO, ''MM/YYYY'') MES_ANHOG
                  FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                       PER_AREA_DPP                AR,
                       PER_CARGO                   PC,
                       PER_SELECCION_PERSONAL_HIST SEL,
                       PER_CONTRATO_PROC_SEL       CON
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                   AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                   AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                   AND SEL.SELEPER_ESTADO_GRAL = ''C''
                   and SOLPER_TIPO_CONTRATACION <>''RC''
                   AND SOLPER_ESTADO_FINAL = ''F''
                     '||P_AND_SOL||'
                     '||P_AND_SEL ||'
                   AND TO_CHAR(CON.CONSEL_FECHA_INICIO,''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')';

       IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SEL_CONTRATACION') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SEL_CONTRATACION');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SEL_CONTRATACION',
                                                         P_QUERY           => P_QUERY7);

        P_QUERY:='SELECT SUM(C001) VACA,
                C004 AREA,
                C003 MES,
                C005 TIPO_CONT,
                SUM(SUM(C001)) OVER(PARTITION BY C004, C003 ORDER BY C003) TOTAL_VAC_AREA,
                (SUM(C001) /NVL(SUM(SUM(C001)) OVER(PARTITION BY C004, C003 ORDER BY C003), 1)) POR_CONT,
                C016 ORDEN,
                 CASE
                    WHEN C005 = ''Directa'' AND C016 = 1 THEN
                    SUM(C001)
                    WHEN C005 = ''Programada'' AND C016= 1 THEN
                    SUM(C001)
                    WHEN C005 = ''Acumulada'' AND C016 = 1 THEN
                    SUM(C001)
                 END MES1_CONT,
                CASE
                    WHEN C005 = ''Directa'' AND C016 = 2 THEN
                    SUM(C001)
                    WHEN C005 = ''Programada'' AND C016= 2 THEN
                    SUM(C001)
                   WHEN C005 = ''Acumulada'' AND C016 = 2 THEN
                    SUM(C001)
                 END MES2_CONT,
                CASE
                    WHEN C005 = ''Directa'' AND C016 = 3 THEN
                    SUM(C001)
                    WHEN C005 = ''Programada'' AND C016= 3 THEN
                    SUM(C001)
                    WHEN C005 = ''Acumulada'' AND C016 = 3 THEN
                    SUM(C001)
               END MES3_CONT
                FROM APEX_collections
                WHERE collection_name = ''SEL_CONTRATACION''
                GROUP BY C004 , C003, C005,C016';



          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SELECCION_CONT') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SELECCION_CONT');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SELECCION_CONT',
                                                         P_QUERY           => P_QUERY);

           IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'FECHA_CONTRATACION') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'FECHA_CONTRATACION');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'FECHA_CONTRATACION',
                                      P_QUERY           => P_QUERY2);

      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TIPOS_CONTRATACION') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TIPOS_CONTRATACION');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TIPOS_CONTRATACION',
                                      P_QUERY           => P_QUERY3);
 END PP_PROCESO_SELECCION_CONT;

PROCEDURE PP_PROCESO_SELECCION_SELC(P_EMPRESA IN NUMBER, P_FECHA IN DATE)IS
     P_QUERY VARCHAR2(21000);
     P_QUERY2 VARCHAR2(21000);
     P_QUERY3 VARCHAR2(21000);
     P_QUERY7 VARCHAR2(21000);
     P_AND VARCHAR2(2000);
     P_AND_SOL VARCHAR2(2000);
     P_AND_SEL VARCHAR2(2000);
 begin

 IF  P_FECHA = LAST_DAY(TO_DATE(P_FECHA))  THEN
    P_AND := P_AND||'and semana is null AND MES || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';
    P_AND_SOL := P_AND_SOL|| 'and sol.semana is null AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';
    P_AND_SEL := P_AND_SEL|| 'and sel.semana is null AND SEL.MES||''/''||SEL.ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';

 ELSE
    P_AND := P_AND||' and mes is null AND SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
    P_AND_SOL := P_AND_SOL|| 'and sol.mes is null AND SOL.SEMANA||''/''||SOL.ANHO =TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
    P_AND_SEL := P_AND_SEL|| 'and sol.mes is null AND SEL.SEMANA||''/''||SEL.ANHO =TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
 END IF;


P_QUERY7 := 'SELECT   1 Q_VACANT,
                     SOL.SOLPER_CLAVE NRO_SOL,
                     TO_CHAR(seleper_fecha_estado_gral, ''MON/YYYY'') MES_ANHO,
                     AR.AREDPP_DESC AREA,
                     CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_CONTRATACION,
                      CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_SELEC_SOL,
                     SOL.SOLPER_CARGO,
                     SOLPER_FECHA_SOL,
                     SOL.SOLPER_OPERADOR_SOL,
                     DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                     DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                     DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                     SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                     SOLPER_FECHA_APROB FECHA_APROB_SOL,
                     DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                     1 ORDEN,
                     TO_CHAR(seleper_fecha_estado_gral, ''MM/YYYY'') MES_ANHOG
                  FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                       PER_AREA_DPP                AR,
                       PER_CARGO                   PC,
                       PER_SELECCION_PERSONAL_HIST SEL,
                       PER_CONTRATO_PROC_SEL       CON
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                   AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                   AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                   AND SEL.SELEPER_ESTADO_GRAL = ''C''
                   AND SOLPER_ESTADO_FINAL = ''F''
                   and SOLPER_TIPO_CONTRATACION <>''RC''
                   AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)---SON ALGUNOS QUE MARCEK HABIA CERRADO ESTADO Y QUE LA FECHA DE CONTRATACION FUE ATNES DE LA FECHA DE CIERRE
                   and sol.semana is null
                   and sel.semana is null
                   AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                   AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                   AND TO_CHAR(sel.seleper_fecha_estado_gral,''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                 union all
                 SELECT   1 Q_VACANT,
                     SOL.SOLPER_CLAVE NRO_SOL,
                     TO_CHAR(seleper_fecha_estado_gral, ''MON/YYYY'') MES_ANHO,
                     AR.AREDPP_DESC AREA,
                     CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_CONTRATACION,
                      CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_SELEC_SOL,
                     SOL.SOLPER_CARGO,
                     SOLPER_FECHA_SOL,
                     SOL.SOLPER_OPERADOR_SOL,
                     DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                     DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                     DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                     SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                     SOLPER_FECHA_APROB FECHA_APROB_SOL,
                     DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                     2 ORDEN,
                     TO_CHAR(seleper_fecha_estado_gral, ''MM/YYYY'') MES_ANHOG
                  FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                       PER_AREA_DPP                AR,
                       PER_CARGO                   PC,
                       PER_SELECCION_PERSONAL_HIST SEL,
                       PER_CONTRATO_PROC_SEL       CON
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                   AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                   AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                   AND SEL.SELEPER_ESTADO_GRAL = ''C''
                   AND SOLPER_ESTADO_FINAL = ''F''
                   and SOLPER_TIPO_CONTRATACION <>''RC''
                   AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)---SON ALGUNOS QUE MARCEK HABIA CERRADO ESTADO Y QUE LA FECHA DE CONTRATACION FUE ATNES DE LA FECHA DE CIERRE
                   and sol.semana is null
                   and sel.semana is null
                   AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                   AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                   AND TO_CHAR(sel.seleper_fecha_estado_gral,''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                UNION ALL
                  SELECT   1 Q_VACANT,
                     SOL.SOLPER_CLAVE NRO_SOL,
                     TO_CHAR(seleper_fecha_estado_gral, ''MON/YYYY'') MES_ANHO,
                     AR.AREDPP_DESC AREA,
                     CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  THEN
                     DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_CONTRATACION,
                      CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') THEN
                     DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                     ELSE
                       ''Acumulada''
                     END  TIPO_SELEC_SOL,
                     SOL.SOLPER_CARGO,
                     SOLPER_FECHA_SOL,
                     SOL.SOLPER_OPERADOR_SOL,
                     DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                     DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                     DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                     SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                     SOLPER_FECHA_APROB FECHA_APROB_SOL,
                     DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                     3 ORDEN,
                     TO_CHAR(seleper_fecha_estado_gral, ''MM/YYYY'') MES_ANHOG
                  FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                       PER_AREA_DPP                AR,
                       PER_CARGO                   PC,
                       PER_SELECCION_PERSONAL_HIST SEL,
                       PER_CONTRATO_PROC_SEL       CON
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                   AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                   AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                   AND SEL.SELEPER_ESTADO_GRAL = ''C''
                   AND SOLPER_ESTADO_FINAL = ''F''
                   and SOLPER_TIPO_CONTRATACION <>''RC''
                   AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)---SON ALGUNOS QUE MARCEK HABIA CERRADO ESTADO Y QUE LA FECHA DE CONTRATACION FUE ATNES DE LA FECHA DE CIERRE
                   '||P_AND_SOL||'
                   '||P_AND_SEL ||'
                   AND TO_CHAR(sel.seleper_fecha_estado_gral,''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')';

   P_QUERY2:='SELECT
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY''),
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY''),
                 TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ,
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MON/YYYY''),
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MON/YYYY''),
                 TO_CHAR(TO_DATE('''||P_FECHA||'''),''MON/YYYY'')
              FROM DUAL';
    P_QUERY3 :='SELECT ''Anticipada'',4
                  FROM DUAL
                 UNION ALL
                 SELECT ''Programada'', 5
                  FROM DUAL
                  UNION ALL
                 SELECT ''Acumulada'', 7
                  FROM DUAL  ';

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SEL_SELECCION') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SEL_SELECCION');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SEL_SELECCION',
                                                         P_QUERY           => P_QUERY7);

        P_QUERY:='SELECT SUM(C001) VACA,
                C004 AREA,
                C003 MES,
                C006 TIPO_SELEC,
                SUM(SUM(C001)) OVER(PARTITION BY C004, C003 ORDER BY C003) TOTAL_VAC_AREA,
                ROUND(SUM(C001)/NVL(SUM(SUM(C001)) OVER(PARTITION BY C004, C003 ORDER BY C003), 1) * 100) POR_CONT,
                C016 ORDEN,
                 CASE
                    WHEN C006 = ''Anticipada'' AND C016 = 1 THEN
                    SUM(C001)
                    WHEN C006 = ''Programada'' AND C016= 1 THEN
                    SUM(C001)
                     WHEN C006 = ''Acumulada'' AND C016 = 1 THEN
                    SUM(C001)
                 END MES1_CONT,
                CASE
                    WHEN C006 = ''Anticipada'' AND C016 = 2 THEN
                    SUM(C001)
                    WHEN C006 = ''Programada'' AND C016= 2 THEN
                    SUM(C001)
                    WHEN C006 = ''Acumulada'' AND C016 = 2 THEN
                    SUM(C001)
                 END MES2_CONT,
                CASE
                    WHEN C006 = ''Anticipada'' AND C016 = 3 THEN
                    SUM(C001)
                    WHEN C006 = ''Programada'' AND C016= 3 THEN
                    SUM(C001)
                    WHEN C006 = ''Acumulada'' AND C016 = 3 THEN
                    SUM(C001)
               END MES3_CONT
                FROM APEX_collections
                WHERE collection_name = ''SEL_SELECCION''
                GROUP BY C004 , C003, C006,C016';


          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SELECCION_SECT') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SELECCION_SECT');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SELECCION_SECT',
                                                         P_QUERY           => P_QUERY);

           IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'FECHA_SELECCION') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'FECHA_SELECCION');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'FECHA_SELECCION',
                                      P_QUERY           => P_QUERY2);

      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TIPOS_SELECCION') THEN
          APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TIPOS_SELECCION');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TIPOS_SELECCION',
                                      P_QUERY           => P_QUERY3);



 END PP_PROCESO_SELECCION_SELC;


   PROCEDURE PP_PROCESO_SELECCION_RSC(P_EMPRESA IN NUMBER, P_FECHA IN DATE) IS


   V_MES3            VARCHAR2(60);
   V_MES2            VARCHAR2(60);
   V_MES1            VARCHAR2(60);
   V_SEMANA          VARCHAR2(60);
   V_SEMANA_ANT      VARCHAR2(60);
   V_FECHA1          DATE;
   V_FECHA2          DATE;

 P_QUERY VARCHAR2(21000);
 P_QUERY1 VARCHAR2(21000);
 P_QUERY2 VARCHAR2(21000);
 P_QUERY20 VARCHAR2(21000);----PRIMERA_ENTREVISTA
 P_QUERY21 VARCHAR2(21000);----REFERENCIA
 P_QUERY22 VARCHAR2(21000);----ENTREVISTA_AREA
 P_QUERY23 VARCHAR2(21000);----ENTREVISTA_ESPECIAL
 P_QUERY24 VARCHAR2(21000);----EN_LIST_PRIMERA_ENTREVISTA
 P_QUERY25 VARCHAR2(21000);----EN_LIST_REFERENCIA
 P_QUERY26 VARCHAR2(21000);----EN_LIST_ENTREVISTA_AREA
 P_QUERY27 VARCHAR2(21000);----EN_LIST_ENTREVISTA_ESPECIAL

     P_AND_T VARCHAR2(2000);
     P_AND_P VARCHAR2(2000);
     P_AND_SOL VARCHAR2(2000);
     P_AND_SEL VARCHAR2(2000);
  BEGIN

  SELECT TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA)-7,'IW/YYYY'),
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)),'DD/MM/YYYY'),
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)),'DD/MM/YYYY')
   INTO V_MES1, V_MES2, V_MES3,V_SEMANA,V_SEMANA_ANT,V_FECHA1, V_FECHA2
  FROM DUAL;


 IF P_FECHA = LAST_DAY(TO_DATE(P_FECHA)) THEN

    P_AND_T := P_AND_T||' and t.semana is null AND T.MES || ''/'' || T.ANHO = '''||V_MES3||'''';
    P_AND_P := P_AND_P||' and p.semana is null AND P.MES || ''/'' || P.ANHO = '''||V_MES3||'''';
    P_AND_SOL := P_AND_SOL|| ' and sol.semana is null AND SOL.MES||''/''||SOL.ANHO = '''||V_MES3||'''';
    P_AND_SEL := P_AND_SEL|| ' and sel.semana is null AND SEL.MES||''/''||SEL.ANHO = '''||V_MES3||'''';

 ELSE
    P_AND_T := P_AND_T||' and t.mes is null AND T.semana || ''/'' || T.ANHO = '''||V_SEMANA||'''';
    P_AND_P := P_AND_P||' and p.mes is null AND P.semana || ''/'' || P.ANHO = '''||V_SEMANA||'''';
    P_AND_SOL := P_AND_SOL|| ' and sol.mes is null AND SOL.SEMANA||''/''||SOL.ANHO ='''||V_SEMANA||'''';
    P_AND_SEL := P_AND_SEL|| ' and sel.mes is null AND SEL.SEMANA||''/''||SEL.ANHO ='''||V_SEMANA||'''';
 END if;
  ----------------PRIMERA ENTREVISTA
  P_QUERY20 := 'SELECT P.PER_ENT_CODIGO,
                       TO_CHAR(T.ENTPER_REQUIS_FECHA, ''mm/yyyy''),
                       S.AREDPP_DESC,
                       C.CARDPP_DESC,
                       P.PER_ENT_POSTULANTE,
                       T.ENTPER_REQUIS_FECHA,
                       DECODE(ENTPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REQUIS_ACCION) ACCION,
                       T.ENTPER_PERF_OPER,
                       DECODE(ENTPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       NULL EST_FINAL,
                       DECODE(T.ENTPER_REQUIS_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto''),
                       ''ENTREVISTA'',
                       ENTPER_REQUIS_OBS
                    FROM PER_ENTREVISTA_PERSONAL_HIST T, PER_ENTREVISTA_POST_HIST P , PER_CARGO_DPP C,  PER_AREA_DPP S
                   WHERE T.ENTPER_ENTREVISTA = P.PER_ENT_CODIGO
                      AND T.ENTPER_EMPR = P.PER_ENT_EMPR
                      AND P.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                      AND P.PER_ENT_EMPR = C.CARDPP_EMPR
                      AND C.CARDPP_AREA = S.AREDPP_CLAVE
                      AND C.CARDPP_EMPR = S.AREDPP_EMPR
                      AND ENTPER_EMPR = 1
                      and t.semana is null
                      and p.semana is null
                      AND T.MES||''/''||T.ANHO = '''||V_MES1||'''
                      AND P.MES||''/''||P.ANHO = '''||V_MES1||'''
                      AND TO_CHAR(T.ENTPER_REQUIS_FECHA, ''mm/yyyy'') ='''||V_MES1||'''
                  UNION ALL
                  SELECT P.PER_ENT_CODIGO,
                       TO_CHAR(T.ENTPER_REQUIS_FECHA, ''mm/yyyy''),
                       S.AREDPP_DESC,
                       C.CARDPP_DESC,
                       P.PER_ENT_POSTULANTE,
                       T.ENTPER_REQUIS_FECHA,
                       DECODE(ENTPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REQUIS_ACCION) ACCION,
                       T.ENTPER_PERF_OPER,
                       DECODE(ENTPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       NULL EST_FINAL,
                       DECODE(T.ENTPER_REQUIS_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                        ,''ENTREVISTA'',
                       ENTPER_REQUIS_OBS
                        FROM PER_ENTREVISTA_PERSONAL_HIST T, PER_ENTREVISTA_POST_HIST P , PER_CARGO_DPP C,  PER_AREA_DPP S
                       WHERE T.ENTPER_ENTREVISTA = P.PER_ENT_CODIGO
                          AND T.ENTPER_EMPR = P.PER_ENT_EMPR
                          AND P.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                          AND P.PER_ENT_EMPR = C.CARDPP_EMPR
                          AND ENTPER_EMPR = 1
                          AND C.CARDPP_AREA = S.AREDPP_CLAVE
                          AND C.CARDPP_EMPR = S.AREDPP_EMPR
                          and t.semana is null
                          and p.semana is null
                          AND T.MES||''/''||T.ANHO = '''||V_MES2||'''
                          AND P.MES||''/''||P.ANHO = '''||V_MES2||'''
                          AND TO_CHAR(T.ENTPER_REQUIS_FECHA, ''mm/yyyy'') ='''||V_MES2||'''
                   UNION ALL
                  SELECT P.PER_ENT_CODIGO,
                       TO_CHAR(T.ENTPER_REQUIS_FECHA, ''mm/yyyy''),
                       S.AREDPP_DESC,
                       C.CARDPP_DESC,
                       P.PER_ENT_POSTULANTE,
                       T.ENTPER_REQUIS_FECHA,
                       DECODE(ENTPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REQUIS_ACCION) ACCION,
                       T.ENTPER_PERF_OPER,
                       DECODE(ENTPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       NULL EST_FINAL,
                       DECODE(T.ENTPER_REQUIS_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                        ,''ENTREVISTA'',
                       ENTPER_REQUIS_OBS
                    FROM PER_ENTREVISTA_PERSONAL_HIST T, PER_ENTREVISTA_POST_HIST P , PER_CARGO_DPP C,  PER_AREA_DPP S
                   WHERE T.ENTPER_ENTREVISTA = P.PER_ENT_CODIGO
                      AND T.ENTPER_EMPR = P.PER_ENT_EMPR
                      AND P.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                      AND P.PER_ENT_EMPR = C.CARDPP_EMPR
                      AND C.CARDPP_AREA = S.AREDPP_CLAVE
                      AND C.CARDPP_EMPR = S.AREDPP_EMPR
                      AND ENTPER_EMPR = 1
                        '||P_AND_T||'
                        '||P_AND_P||'
                      AND TO_CHAR(T.ENTPER_REQUIS_FECHA, ''mm/yyyy'') ='''||V_MES3||'''
                UNION ALL
                SELECT SOLPER_CLAVE,
                       TO_CHAR(SELEPER_REQUIS_FECHA, ''mm/yyyy''),
                       AREDPP_DESC,
                       PC.CAR_DESC,
                       SELPER_POSTUL,
                       SELEPER_REQUIS_FECHA,
                       DECODE(SELEPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REQUIS_ACCION) ACCION,
                       SELEPER_REQUIS_OPER,
                       DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                       DECODE(SELEPER_REQUIS_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                ,''SELECCION'',
                SEL.SELEPER_REQUIS_OBS
                 FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                     '||P_AND_SOL||'
                     '||P_AND_SEL ||'
                   AND TO_CHAR(SELEPER_REQUIS_FECHA, ''mm/yyyy'') ='''||V_MES3||'''
                UNION ALL
                SELECT SOLPER_CLAVE,
                       TO_CHAR(SELEPER_REQUIS_FECHA, ''mm/yyyy''),
                       AREDPP_DESC,
                       PC.CAR_DESC,
                       SELPER_POSTUL,
                       SELEPER_REQUIS_FECHA,
                       DECODE(SELEPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REQUIS_ACCION) ACCION,
                       SELEPER_REQUIS_OPER,
                       DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                       DECODE(SELEPER_REQUIS_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                 ,''SELECCION'',
                 SEL.SELEPER_REQUIS_OBS
                 FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   and sol.semana is null 
                   and sel.semana is null
                   AND SOL.MES||''/''||SOL.ANHO = '''||V_MES2||'''
                   AND SEL.MES||''/''||SEL.ANHO = '''||V_MES2||'''
                   AND TO_CHAR(SELEPER_REQUIS_FECHA, ''mm/yyyy'') ='''||V_MES2||'''
                UNION ALL
                SELECT SOLPER_CLAVE,
                       TO_CHAR(SELEPER_REQUIS_FECHA, ''mm/yyyy''),
                       AREDPP_DESC,
                       PC.CAR_DESC,
                       SELPER_POSTUL,
                       SELEPER_REQUIS_FECHA,
                       DECODE(SELEPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REQUIS_ACCION) ACCION,
                       SELEPER_REQUIS_OPER,
                       DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                       DECODE(SELEPER_REQUIS_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                 ,''SELECCION'',
                 SEL.SELEPER_REQUIS_OBS
                 FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   and sol.semana is null
                   and sel.semana is null
                   AND SOL.MES||''/''||SOL.ANHO = '''||V_MES1||'''
                   AND SEL.MES||''/''||SEL.ANHO = '''||V_MES1||'''
                   AND TO_CHAR(SELEPER_REQUIS_FECHA, ''mm/yyyy'') ='''||V_MES1||'''' ;
   ----------------REFERENCIA
   P_QUERY21:= 'SELECT P.PER_ENT_CODIGO,
                   TO_CHAR(T.ENTPER_REF_FECHA, ''mm/yyyy''),
                   S.AREDPP_DESC,
                   C.CARDPP_DESC,
                   P.PER_ENT_POSTULANTE,
                   T.ENTPER_REF_FECHA,
                   DECODE(ENTPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REF_ACCION) ACCION,
                   T.ENTPER_REF_OPER,
                   DECODE(ENTPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   NULL EST_FINAL,
                   DECODE(T.ENTPER_REF_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                ,''ENTREVISTA'',
                  ENTPER_REF_OBS
                FROM PER_ENTREVISTA_PERSONAL_HIST T, PER_ENTREVISTA_POST_HIST P , PER_CARGO_DPP C,  PER_AREA_DPP S
               WHERE T.ENTPER_ENTREVISTA = P.PER_ENT_CODIGO
                  AND T.ENTPER_EMPR = P.PER_ENT_EMPR
                  AND P.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                  AND P.PER_ENT_EMPR = C.CARDPP_EMPR
                  AND C.CARDPP_AREA = S.AREDPP_CLAVE
                  AND C.CARDPP_EMPR = S.AREDPP_EMPR
                  AND ENTPER_EMPR = 1
                  and t.semana is null
                  and p.semana is null
                  AND T.MES||''/''||T.ANHO = '''||V_MES1||'''
                  AND P.MES||''/''||P.ANHO = '''||V_MES1||'''
                  AND TO_CHAR(T.ENTPER_REF_FECHA, ''mm/yyyy'') ='''||V_MES1||'''
              UNION ALL
              SELECT P.PER_ENT_CODIGO,
                   TO_CHAR(T.ENTPER_REF_FECHA, ''mm/yyyy''),
                   S.AREDPP_DESC,
                   C.CARDPP_DESC,
                   P.PER_ENT_POSTULANTE,
                   T.ENTPER_REF_FECHA,
                   DECODE(ENTPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REF_ACCION) ACCION,
                   T.ENTPER_REF_OPER,
                   DECODE(ENTPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   NULL EST_FINAL,
                   DECODE(T.ENTPER_REF_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                    ,''ENTREVISTA'',
                   ENTPER_REF_OBS
                    FROM PER_ENTREVISTA_PERSONAL_HIST T, PER_ENTREVISTA_POST_HIST P , PER_CARGO_DPP C,  PER_AREA_DPP S
                   WHERE T.ENTPER_ENTREVISTA = P.PER_ENT_CODIGO
                      AND T.ENTPER_EMPR = P.PER_ENT_EMPR
                      AND P.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                      AND P.PER_ENT_EMPR = C.CARDPP_EMPR
                      AND C.CARDPP_AREA = S.AREDPP_CLAVE
                      AND C.CARDPP_EMPR = S.AREDPP_EMPR
                      AND ENTPER_EMPR = 1
                      and t.semana is null
                      and p.semana is null
                      AND T.MES||''/''||T.ANHO = '''||V_MES2||'''
                      AND P.MES||''/''||P.ANHO = '''||V_MES2||'''
                      AND TO_CHAR(T.ENTPER_REF_FECHA, ''mm/yyyy'') ='''||V_MES2||'''
               UNION ALL
              SELECT P.PER_ENT_CODIGO,
                   TO_CHAR(T.ENTPER_REF_FECHA, ''mm/yyyy''),
                   S.AREDPP_DESC,
                   C.CARDPP_DESC,
                   P.PER_ENT_POSTULANTE,
                   T.ENTPER_REF_FECHA,
                   DECODE(ENTPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REF_ACCION) ACCION,
                   T.ENTPER_REF_OPER,
                   DECODE(ENTPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   NULL EST_FINAL,
                   DECODE(T.ENTPER_REF_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                ,''ENTREVISTA'',
                 ENTPER_REF_OBS
                FROM PER_ENTREVISTA_PERSONAL_HIST T, PER_ENTREVISTA_POST_HIST P , PER_CARGO_DPP C,  PER_AREA_DPP S
               WHERE T.ENTPER_ENTREVISTA = P.PER_ENT_CODIGO
                  AND T.ENTPER_EMPR = P.PER_ENT_EMPR
                  AND P.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                  AND P.PER_ENT_EMPR = C.CARDPP_EMPR
                  AND C.CARDPP_AREA = S.AREDPP_CLAVE
                  AND C.CARDPP_EMPR = S.AREDPP_EMPR
                  AND ENTPER_EMPR = 1
                  '||P_AND_T||'
                  '||P_AND_P||'
                  AND TO_CHAR(T.ENTPER_REF_FECHA, ''mm/yyyy'') ='''||V_MES3||'''
            -----------------------------------------------------------------------***
            UNION ALL
            SELECT SOLPER_CLAVE,
                   TO_CHAR(SEL.SELEPER_REF_FECHA, ''mm/yyyy''),
                   AREDPP_DESC,
                   PC.CAR_DESC,
                   SELPER_POSTUL,
                   SELEPER_REF_FECHA,
                   DECODE(SELEPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REF_ACCION) ACCION,
                   SELEPER_REF_OPER,
                   DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                   DECODE(SELEPER_REF_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
             ,''SELECCION'',
             SEL.SELEPER_REF_OBS
             FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
             WHERE SOL.SOLPER_EMPR = 1
               AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
               AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
               AND SOL.SOLPER_EMPR = PC.CAR_EMPR
               AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
               AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
               AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                '||P_AND_SOL||'
                '||P_AND_SEL ||'
               AND TO_CHAR(SELEPER_REF_FECHA, ''mm/yyyy'') ='''||V_MES3||'''
            UNION ALL
            SELECT SOLPER_CLAVE,
                   TO_CHAR(SELEPER_REF_FECHA, ''mm/yyyy''),
                   AREDPP_DESC,
                   PC.CAR_DESC,
                   SELPER_POSTUL,
                   SELEPER_REF_FECHA,
                   DECODE(SELEPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REF_ACCION) ACCION,
                   SELEPER_REF_OPER,
                   DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                   DECODE(SELEPER_REF_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
             ,''SELECCION'',
             SEL.SELEPER_REF_OBS
             FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
             WHERE SOL.SOLPER_EMPR = 1
               AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
               AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
               AND SOL.SOLPER_EMPR = PC.CAR_EMPR
               AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
               AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
               AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
               and sol.semana is null
               and sel.semana is null
               AND SOL.MES||''/''||SOL.ANHO = '''||V_MES1||'''
               AND SEL.MES||''/''||SEL.ANHO = '''||V_MES1||'''
               AND TO_CHAR(SELEPER_REF_FECHA, ''mm/yyyy'') ='''||V_MES1||'''
            UNION ALL
            SELECT SOLPER_CLAVE,
                   TO_CHAR(SELEPER_REF_FECHA, ''mm/yyyy''),
                   AREDPP_DESC,
                   PC.CAR_DESC,
                   SELPER_POSTUL,
                   SELEPER_REF_FECHA,
                   DECODE(SELEPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REF_ACCION) ACCION,
                   SELEPER_REF_OPER,
                   DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                   DECODE(SELEPER_REF_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
            ,''SELECCION'',
            SEL.SELEPER_REF_OBS
             FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
             WHERE SOL.SOLPER_EMPR = 1
               AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
               AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
               AND SOL.SOLPER_EMPR = PC.CAR_EMPR
               AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
               AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
               AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
               and sol.semana is null
               and sel.semana is null
               AND SOL.MES||''/''||SOL.ANHO = '''||V_MES2||'''
               AND SEL.MES||''/''||SEL.ANHO = '''||V_MES2||'''
               AND TO_CHAR(SELEPER_REF_FECHA, ''mm/yyyy'') ='''||V_MES2||''' ';
  ----------------ENTREVISTA AREA
  P_QUERY22 := 'SELECT SOLPER_CLAVE,
                       TO_CHAR(SEL.SELEPER_EAR_FECHA, ''mm/yyyy''),
                       AREDPP_DESC,
                       PC.CAR_DESC,
                       SELPER_POSTUL,
                       SELEPER_EAR_FECHA,
                      DECODE(SEL.SELEPER_EAR_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'') ACCION,
                       SELEPER_EAR_OPER,
                       DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                      DECODE(SEL.SELEPER_EAR_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'',''RE'',''Redireccionado'')ESTADO_EAR,
                       SOL.SOLPER_FECHA_SOL,
                       CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                             WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                             WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                             WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Referencia- Obs& ''||SELEPER_REF_OBS
                             WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                             WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                             END DESCARTADO
                 FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                    '||P_AND_SOL||'
                    '||P_AND_SEL ||'
                   AND TO_CHAR(SELEPER_EAR_FECHA, ''mm/yyyy'') ='''||V_MES3||'''

                UNION ALL
                SELECT SOLPER_CLAVE,
                       TO_CHAR(SELEPER_EAR_FECHA, ''mm/yyyy''),
                       AREDPP_DESC,
                       PC.CAR_DESC,
                       SELPER_POSTUL,
                       SELEPER_EAR_FECHA,
                      DECODE(SEL.SELEPER_EAR_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'') ACCION,
                       SEL.SELEPER_EAR_OPER,
                       DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                       DECODE(SEL.SELEPER_EAR_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'',''RE'',''Redireccionado'')ESTADO_EAR,
                        SOL.SOLPER_FECHA_SOL,
                       CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                             WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                             WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                             WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Referencia- Obs& ''||SELEPER_REF_OBS
                             WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                             WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                             END DESCARTADO
                 FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   and sol.semana is null
                   and sel.semana is null
                   AND SOL.MES||''/''||SOL.ANHO = '''||V_MES1||'''
                   AND SEL.MES||''/''||SEL.ANHO = '''||V_MES1||'''
                   AND TO_CHAR(SELEPER_EAR_FECHA, ''mm/yyyy'') ='''||V_MES1||'''
                UNION ALL
                SELECT SOLPER_CLAVE,
                       TO_CHAR(SELEPER_EAR_FECHA, ''mm/yyyy''),
                       AREDPP_DESC,
                       PC.CAR_DESC,
                       SELPER_POSTUL,
                       SELEPER_EAR_FECHA,
                       DECODE(SEL.SELEPER_EAR_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'') ACCION,
                       SELEPER_EAR_OPER,
                       DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                       DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                       DECODE(SEL.SELEPER_EAR_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'',''RE'',''Redireccionado'')ESTADO_EAR,
                        SOL.SOLPER_FECHA_SOL,
                       CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                             WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                             WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                             WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Referencia- Obs& ''||SELEPER_REF_OBS
                             WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                             WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                                 ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                             END DESCARTADO
                 FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                 WHERE SOL.SOLPER_EMPR = 1
                   AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                   AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                   AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                   AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                   AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                   AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                   and sol.semana is null 
                   and sel.semana is null
                   AND SOL.MES||''/''||SOL.ANHO = '''||V_MES2||'''
                   AND SEL.MES||''/''||SEL.ANHO = '''||V_MES2||'''
                   AND TO_CHAR(SELEPER_EAR_FECHA, ''mm/yyyy'') ='''||V_MES2||''' ';
  -------------------ENTRVISTA ESPECIAL
   P_QUERY23 := 'SELECT SOLPER_CLAVE,
                 TO_CHAR(SEL.SELEPER_EES_FECHA, ''mm/yyyy''),
                 AREDPP_DESC,
                 PC.CAR_DESC,
                 SELPER_POSTUL,
                 SELEPER_EES_FECHA,
                 DECODE(SEL.SELEPER_EES_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''A'',''Anulado'') ACCION,
                 SELEPER_EES_OPER,
                 DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                 DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                 DECODE(SEL.SELEPER_EES_ESTADO,''A'',''Abierto'',''C'',''Cerrado'',null,''Pendiente'',''D'',''Descartado'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_EES,
                 SOL.SOLPER_FECHA_SOL,
                 CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                           ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                       WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                           ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                       WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                           ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                       WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                           ''Descartado Etapa Referencia- Obs& ''||SELEPER_REF_OBS
                       WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                           ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                       WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                           ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                       END DESCARTADO
           FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
           WHERE SOL.SOLPER_EMPR = 1
             AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
             AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
             AND SOL.SOLPER_EMPR = PC.CAR_EMPR
             AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
             AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
             AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
              '||P_AND_SOL||'
              '||P_AND_SEL ||'
             AND TO_CHAR(SELEPER_EES_FECHA, ''mm/yyyy'') ='''||V_MES3||'''

          UNION ALL
          SELECT SOLPER_CLAVE,
                 TO_CHAR(SEL.SELEPER_EES_FECHA, ''mm/yyyy''),
                 AREDPP_DESC,
                 PC.CAR_DESC,
                 SELPER_POSTUL,
                 SELEPER_EES_FECHA,
                 DECODE(SEL.SELEPER_EES_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''A'',''Anulado'') ACCION,
                 SELEPER_EES_OPER,
                 DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                 DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                 DECODE(SEL.SELEPER_EES_ESTADO,''A'',''Abierto'',''C'',''Cerrado'',null,''Pendiente'',''D'',''Descartado'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_EES,
                 SOL.SOLPER_FECHA_SOL,
                 CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                           ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                       WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                           ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                       WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                           ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                       WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                           ''Descartado Etapa Referencia- Obs& ''||SELEPER_REF_OBS
                       WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                           ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                       WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                           ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                       END DESCARTADO
           FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
           WHERE SOL.SOLPER_EMPR = 1
             AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
             AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
             AND SOL.SOLPER_EMPR = PC.CAR_EMPR
             AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
             AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
             AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
             and sol.semana is null
             and sel.semana is null
             AND SOL.MES||''/''||SOL.ANHO ='''||V_MES2||'''
             AND SEL.MES||''/''||SEL.ANHO = '''||V_MES2||'''
             AND TO_CHAR(SELEPER_EES_FECHA, ''mm/yyyy'') ='''||V_MES2||'''
          UNION ALL
          SELECT SOLPER_CLAVE,
                 TO_CHAR(SEL.SELEPER_EES_FECHA, ''mm/yyyy''),
                 AREDPP_DESC,
                 PC.CAR_DESC,
                 SELPER_POSTUL,
                 SELEPER_EES_FECHA,
                 DECODE(SEL.SELEPER_EES_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''A'',''Anulado'') ACCION,
                 SELEPER_EES_OPER,
                 DECODE(SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                 DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                 DECODE(SEL.SELEPER_EES_ESTADO,''A'',''Abierto'',''C'',''Cerrado'',null,''Pendiente'',''D'',''Descartado'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_EES,
                 SOL.SOLPER_FECHA_SOL,
                 CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                           ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                       WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                           ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                       WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                           ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                       WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                           ''Descartado Etapa Referencia- Obs& ''||SELEPER_REF_OBS
                       WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                           ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                       WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                           ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                       END DESCARTADO
           FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
           WHERE SOL.SOLPER_EMPR = 1
             AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
             AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
             AND SOL.SOLPER_EMPR = PC.CAR_EMPR
             AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
             AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
             AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
             and sol.semana is null
             and sel.semana is null
             AND SOL.MES||''/''||SOL.ANHO ='''||V_MES1||'''
             AND SEL.MES||''/''||SEL.ANHO = '''||V_MES1||'''
             AND TO_CHAR(SELEPER_EES_FECHA, ''mm/yyyy'') ='''||V_MES1||'''  ';

  ---------------EN FILA PRIMERA ENTREVISTA
   P_QUERY24 := 'SELECT SOL.SOLPER_CLAVE NRO_SOL,
                         AR.AREDPP_DESC AREA_DESC,
                         PC.CAR_DESC CARGO_DESC,
                         SELPER_POSTUL NOMBRE_POST,
                         DECODE(SEL.SELEPER_REQUIS_ESTADO ,''A'',''Abierto'',''C'',''Cerrado'',null,''Abierto'',''D'',''Descartado'') ESTADO_REQ,
                         DECODE(SEL.SELEPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REQUIS_ACCION) ACCION,
                         SEL.SELEPER_REQUIS_FECHA FECHA_REQUIS,
                         SEL.SELEPER_REQUIS_OBS,
                         SEL.SELEPER_REQUIS_OPER,
                         ''SELECCION PERSONAL'' programa,
                          CASE  when sol.solper_fecha_aprob is not null then
                                    1
                                end falta,
                         CASE
                          WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                    ''ADM''
                           ELSE
                          AREDPP_DESC
                          END AREA_DOT,
                          TO_CHAR(sol.solper_fecha_sol,''MM/YYYY'')
                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                   WHERE SOL.SOLPER_EMPR = 1
                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                     AND SELEPER_REQUIS_FECHA IS NULL
                     AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                     AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
                     AND TO_CHAR(sol.solper_fecha_sol,''MM/YYYY'') ='''||V_MES1||'''
                     and sol.semana is null
                     and sel.semana is null
                     AND SOL.MES||''/''||SOL.ANHO ='''||V_MES1||'''
                     AND SEL.MES||''/''||SEL.ANHO = '''||V_MES1||'''
                  UNION ALL
                  SELECT SOL.SOLPER_CLAVE NRO_SOL,
                         AR.AREDPP_DESC AREA_DESC,
                         PC.CAR_DESC CARGO_DESC,
                         SELPER_POSTUL NOMBRE_POST,
                         DECODE(SEL.SELEPER_REQUIS_ESTADO ,''A'',''Abierto'',''C'',''Cerrado'',null,''Abierto'',''D'',''Descartado'') ESTADO_REQ,
                         DECODE(SEL.SELEPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REQUIS_ACCION) ACCION,
                         SEL.SELEPER_REQUIS_FECHA FECHA_REQUIS,
                         SEL.SELEPER_REQUIS_OBS,
                         SEL.SELEPER_REQUIS_OPER,
                         ''SELECCION PERSONAL'' programa,
                          CASE  when sol.solper_fecha_aprob is not null then
                                    1
                                end falta,
                           CASE
                          WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                    ''ADM''
                           ELSE
                          AREDPP_DESC
                          END AREA_DOT,
                          TO_CHAR(sol.solper_fecha_sol,''MM/YYYY'')
                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                   WHERE SOL.SOLPER_EMPR = 1
                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                     AND SELEPER_REQUIS_FECHA IS NULL
                     AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                     AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
                     AND TO_CHAR(sol.solper_fecha_sol,''MM/YYYY'') = '''||V_MES2||'''
                     and sol.semana is null
                     and sel.semana is null
                     AND SOL.MES||''/''||SOL.ANHO ='''||V_MES2||'''
                     AND SEL.MES||''/''||SEL.ANHO ='''||V_MES2||'''
                   UNION ALL
                   SELECT SOL.SOLPER_CLAVE NRO_SOL,
                         AR.AREDPP_DESC AREA_DESC,
                         PC.CAR_DESC CARGO_DESC,
                         SELPER_POSTUL NOMBRE_POST,
                         DECODE(SEL.SELEPER_REQUIS_ESTADO ,''A'',''Abierto'',''C'',''Cerrado'',null,''Abierto'',''D'',''Descartado'') ESTADO_REQ,
                         DECODE(SEL.SELEPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SELEPER_REQUIS_ACCION) ACCION,
                         SEL.SELEPER_REQUIS_FECHA FECHA_REQUIS,
                         SEL.SELEPER_REQUIS_OBS,
                         SEL.SELEPER_REQUIS_OPER,
                         ''SELECCION PERSONAL'' programa,
                          CASE  when sol.solper_fecha_aprob is not null then
                                    1
                                end falta,
                            CASE
                          WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                    ''ADM''
                           ELSE
                          AREDPP_DESC
                          END AREA_DOT ,
                          TO_CHAR(sol.solper_fecha_sol,''MM/YYYY'')
                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                   WHERE SOL.SOLPER_EMPR = 1
                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                     AND SELEPER_REQUIS_FECHA IS NULL
                     AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                     AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
                     AND TO_CHAR(sol.solper_fecha_sol,''MM/YYYY'') ='''||V_MES3||'''
                   '||P_AND_SOL||'
                   '||P_AND_SEL ||'
                     AND CASE WHEN solper_fecha_sol >''01/05/2020'' AND AREDPP_DESC <> ''CDA''  THEN 0
                      WHEN solper_fecha_sol >''01/06/2020'' AND AREDPP_DESC = ''CDA''  THEN   0
                      ELSE 1 END = 1

                  UNION ALL
                  ----------------
                  select A.ENTPER_ENTREVISTA,
                         D.AREDPP_DESC,
                         C.CARDPP_DESC,
                         PER_ENT_POSTULANTE  POSTULANTE,
                         DECODE(A.ENTPER_REQUIS_ESTADO ,''A'',''Abierto'',''C'',''Cerrado'',null,''Abierto'',''D'',''Descartado'') ESTADO_REQ,
                         DECODE(A.ENTPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REQUIS_ACCION) ACCION,
                         A.ENTPER_REQUIS_FECHA,
                         A.ENTPER_REQUIS_OBS,
                         A.ENTPER_REQUIS_OPER,
                          ''ENTREVISTA'',
                           null,
                         CASE
                          WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                    ''ADM''
                           ELSE
                          AREDPP_DESC
                          END AREA_DOT ,
                          TO_CHAR(PER_ENT_FECHA,''MM/YYYY'')
                    from PER_ENTREVISTA_PERSONAL_HIST A,
                         PER_ENTREVISTA_POST_HIST     T,
                         PER_CARGO_DPP           C,
                         PER_AREA_DPP            D
                   WHERE A.ENTPER_ENTREVISTA = T.PER_ENT_CODIGO
                     AND A.ENTPER_EMPR = T.PER_ENT_EMPR
                     AND T.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                     AND T.PER_ENT_EMPR = C.CARDPP_EMPR
                     AND C.CARDPP_AREA = D.AREDPP_CLAVE
                     AND C.CARDPP_EMPR = D.AREDPP_EMPR
                     AND ENTPER_REQUIS_FECHA IS NULL
                     AND TO_CHAR(PER_ENT_FECHA,''MM/YYYY'') ='''||V_MES1||'''
                     and A.semana is null
                     and T.semana is null
                     AND A.MES||''/''||A.ANHO ='''||V_MES1||'''
                     AND T.MES||''/''||T.ANHO = '''||V_MES1||'''
                   UNION ALL
                   select A.ENTPER_ENTREVISTA,
                         D.AREDPP_DESC,
                         C.CARDPP_DESC,
                         PER_ENT_POSTULANTE POSTULANTE,
                         DECODE(A.ENTPER_REQUIS_ESTADO ,''A'',''Abierto'',''C'',''Cerrado'',null,''Abierto'',''D'',''Descartado'') ESTADO_REQ,
                         DECODE(A.ENTPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REQUIS_ACCION) ACCION,
                         A.ENTPER_REQUIS_FECHA,
                         A.ENTPER_REQUIS_OBS,
                         A.ENTPER_REQUIS_OPER,
                          ''ENTREVISTA'',
                           null,
                         CASE
                          WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                    ''ADM''
                           ELSE
                          AREDPP_DESC
                          END AREA_DOT  ,
                          TO_CHAR(PER_ENT_FECHA,''MM/YYYY'')
                    from PER_ENTREVISTA_PERSONAL_HIST A,
                         PER_ENTREVISTA_POST_HIST     T,
                         PER_CARGO_DPP           C,
                         PER_AREA_DPP            D
                   WHERE A.ENTPER_ENTREVISTA = T.PER_ENT_CODIGO
                     AND A.ENTPER_EMPR = T.PER_ENT_EMPR
                     AND T.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                     AND T.PER_ENT_EMPR = C.CARDPP_EMPR
                     AND C.CARDPP_AREA = D.AREDPP_CLAVE
                     AND C.CARDPP_EMPR = D.AREDPP_EMPR
                     AND ENTPER_REQUIS_FECHA IS NULL
                     AND TO_CHAR(PER_ENT_FECHA,''MM/YYYY'') ='''||V_MES2||'''
                     and A.semana is null
                     and T.semana is null
                     AND A.MES||''/''||A.ANHO ='''||V_MES2||'''
                     AND T.MES||''/''||T.ANHO = '''||V_MES2||'''

                  UNION ALL
                  select P.ENTPER_ENTREVISTA,
                         D.AREDPP_DESC,
                         C.CARDPP_DESC,
                         PER_ENT_POSTULANTE  POSTULANTE,
                         DECODE(P.ENTPER_REQUIS_ESTADO ,''A'',''Abierto'',''C'',''Cerrado'',null,''Abierto'',''D'',''Descartado'') ESTADO_REQ,
                         DECODE(P.ENTPER_REQUIS_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REQUIS_ACCION) ACCION,
                         P.ENTPER_REQUIS_FECHA,
                         P.ENTPER_REQUIS_OBS,
                         P.ENTPER_REQUIS_OPER,
                          ''ENTREVISTA'',
                           null,
                         CASE
                          WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                    ''ADM''
                           ELSE
                          AREDPP_DESC
                          END AREA_DOT  ,
                          TO_CHAR(PER_ENT_FECHA,''MM/YYYY'')
                    from PER_ENTREVISTA_PERSONAL_HIST P,
                         PER_ENTREVISTA_POST_HIST     T,
                         PER_CARGO_DPP           C,
                         PER_AREA_DPP            D
                   WHERE P.ENTPER_ENTREVISTA = T.PER_ENT_CODIGO
                     AND P.ENTPER_EMPR = T.PER_ENT_EMPR
                     AND T.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                     AND T.PER_ENT_EMPR = C.CARDPP_EMPR
                     AND C.CARDPP_AREA = D.AREDPP_CLAVE
                     AND C.CARDPP_EMPR = D.AREDPP_EMPR
                     AND ENTPER_REQUIS_FECHA IS NULL
                     AND TO_CHAR(PER_ENT_FECHA,''MM/YYYY'') ='''||V_MES3||'''
                     '||P_AND_T||'
                     '||P_AND_P||'
                     ';



  ------EN FILA REFERENCIA
   P_QUERY25 := 'SELECT SOL.SOLPER_CLAVE NRO_SOL,
                         ''SELECCION'' PROGRAMA,
                         AR.AREDPP_DESC AREA_DESC,
                         PC.CAR_DESC CARGO_DESC,
                         SELPER_POSTUL NOMBRE_POST,
                         DECODE(SEL.SELEPER_ref_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'')ESTADO_REF,
                         DECODE(SEL.SELEPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SEL.SELEPER_REF_ACCION) ACCION_REF,
                         SEL.SELEPER_REF_FECHA FECHA_REF,
                      CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                               WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                              WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                              WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Referencia- Obs: ''||SELEPER_REF_OBS
                             WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                             WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                             END DESCARTADO ,
                                    DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                         DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                          CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT,
                            TO_CHAR(SEL.SELEPER_REQUIS_FECHA,''MM/YYYY'')
                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                   WHERE SOL.SOLPER_EMPR = 1
                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                     AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                     AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
                     AND TO_CHAR(SEL.SELEPER_REQUIS_FECHA,''MM/YYYY'') ='''||V_MES1||'''
                     and sol.semana is null
                     and sel.semana is null
                     AND SOL.MES||''/''||SOL.ANHO ='''||V_MES1||'''
                     AND SEL.MES||''/''||SEL.ANHO = '''||V_MES1||'''
                     AND SEL.SELEPER_REF_FECHA IS NULL
                     AND SELEPER_ref_ESTADO IS NULL
                   UNION ALL
                  SELECT SOL.SOLPER_CLAVE NRO_SOL,
                         ''SELECCION'' PROGRAMA,
                         AR.AREDPP_DESC AREA_DESC,
                         PC.CAR_DESC CARGO_DESC,
                         SELPER_POSTUL NOMBRE_POST,
                         DECODE(SEL.SELEPER_ref_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'')ESTADO_REF,
                         DECODE(SEL.SELEPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SEL.SELEPER_REF_ACCION) ACCION_REF,
                         SEL.SELEPER_REF_FECHA FECHA_REF,
                      CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                               WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                              WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                              WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Referencia- Obs: ''||SELEPER_REF_OBS
                             WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                             WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                             END DESCARTADO ,
                                    DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                         DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                          CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT ,
                            TO_CHAR(SEL.SELEPER_REQUIS_FECHA,''MM/YYYY'')
                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                   WHERE SOL.SOLPER_EMPR = 1
                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                     AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                     AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
                     AND TO_CHAR(SEL.SELEPER_REQUIS_FECHA,''MM/YYYY'') = '''||V_MES2||'''
                     and sol.semana is null
                     and sel.semana is null
                     AND SOL.MES||''/''||SOL.ANHO ='''||V_MES2||'''
                     AND SEL.MES||''/''||SEL.ANHO = '''||V_MES2||'''
                     AND SEL.SELEPER_REF_FECHA IS NULL
                     AND SELEPER_ref_ESTADO IS NULL
                     UNION ALL
                   SELECT SOL.SOLPER_CLAVE NRO_SOL,
                         ''SELECCION'' PROGRAMA,
                         AR.AREDPP_DESC AREA_DESC,
                         PC.CAR_DESC CARGO_DESC,
                         SELPER_POSTUL NOMBRE_POST,
                         DECODE(SEL.SELEPER_ref_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'')ESTADO_REF,
                         DECODE(SEL.SELEPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',SEL.SELEPER_REF_ACCION) ACCION_REF,
                         SEL.SELEPER_REF_FECHA FECHA_REF,
                      CASE  WHEN SELEPER_REQUIS_ESTADO = ''D'' AND SELEPER_REQUIS_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Requisitos- Obs:''||SELEPER_REQUIS_OBS
                               WHEN SELEPER_PERF_ESTADO = ''D'' AND SELEPER_PERF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Perfil- Obs: ''||SELEPER_PERF_OBS
                              WHEN SELEPER_PRES_ESTADO = ''D'' AND SELEPER_PRES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Pre-Selccion - Obs: ''||SELEPER_PRES_OBS
                              WHEN SELEPER_REF_ESTADO = ''D'' AND SELEPER_REF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Referencia- Obs: ''||SELEPER_REF_OBS
                             WHEN SELEPER_EAR_ESTADO = ''D'' AND SELEPER_EAR_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Entrevista de Area- Obs: ''||SELEPER_EAR_OBS
                             WHEN SELEPER_EES_ESTADO = ''D'' AND SELEPER_EES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Entrevista Especial- Obs: ''||SELEPER_EES_OBS
                             END DESCARTADO ,
                                    DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                         DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                          CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT,
                            TO_CHAR(SEL.SELEPER_REQUIS_FECHA,''MM/YYYY'')
                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
                   WHERE SOL.SOLPER_EMPR = 1
                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                     AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                     AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
                     AND TO_CHAR(SEL.SELEPER_REQUIS_FECHA,''MM/YYYY'') = '''||V_MES3||'''
                     '||P_AND_SOL||'
                     '||P_AND_SEL ||'
                     AND SELEPER_ref_ESTADO IS NULL
                     AND SEL.SELEPER_REF_FECHA IS NULL
                     AND CASE WHEN solper_fecha_sol >''01/05/2020'' AND AREDPP_DESC <> ''CDA''  THEN 0
                                        WHEN solper_fecha_sol >''01/06/2020'' AND AREDPP_DESC = ''CDA''  THEN   0
                                        ELSE 1 END = 1
                  UNION ALL

                  select P.ENTPER_ENTREVISTA,
                         ''ENTREVISTA'',
                         D.AREDPP_DESC,
                         C.CARDPP_DESC,
                         PER_ENT_POSTULANTE,
                         DECODE(ENTPER_ref_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'')ESTADO_REF,
                         DECODE(ENTPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REF_ACCION) ACCION,
                         ENTPER_REF_FECHA FECHA_REF,
                          CASE  WHEN ENTPER_REQUIS_ESTADO = ''D'' AND ENTPER_REQUIS_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Requisitos- Obs: ''||ENTPER_REQUIS_OBS
                                WHEN ENTPER_PERF_ESTADO = ''D'' AND ENTPER_PERF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Perfil- Obs: ''||ENTPER_PERF_OBS
                                WHEN ENTPER_PRES_ESTADO = ''D'' AND ENTPER_PRES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Pre-Selccion - Obs: ''||ENTPER_PRES_OBS
                                WHEN ENTPER_REF_ESTADO = ''D'' AND ENTPER_REF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Referencia- Obs: ''||ENTPER_REF_OBS
                          end DESCARTADO   , null, null,
                          CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT ,
                            TO_CHAR(P.ENTPER_REQUIS_FECHA,''MM/YYYY'')
                    from PER_ENTREVISTA_PERSONAL_HIST P,
                         PER_ENTREVISTA_POST_HIST     T,
                         PER_CARGO_DPP           C,
                         PER_AREA_DPP            D
                   WHERE P.ENTPER_ENTREVISTA = T.PER_ENT_CODIGO
                     AND P.ENTPER_EMPR = T.PER_ENT_EMPR
                     AND T.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                     AND T.PER_ENT_EMPR = C.CARDPP_EMPR
                     AND C.CARDPP_AREA = D.AREDPP_CLAVE
                     AND C.CARDPP_EMPR = D.AREDPP_EMPR
                     AND ENTPER_ref_ESTADO IS NULL
                     AND ENTPER_REF_FECHA IS NULL
                     AND ENTPER_EMPR = 1
                     AND TO_CHAR(P.ENTPER_REQUIS_FECHA,''MM/YYYY'') ='''||V_MES3||'''
                       '||P_AND_T||'
                       '||P_AND_P||'

                    UNION ALL
                  select A.ENTPER_ENTREVISTA,
                         ''ENTREVISTA'',
                         D.AREDPP_DESC,
                         C.CARDPP_DESC,
                         PER_ENT_POSTULANTE POSTULANTE,
                         DECODE(ENTPER_ref_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'')ESTADO_REF,
                         DECODE(ENTPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REF_ACCION) ACCION,
                         ENTPER_REF_FECHA FECHA_REF,
                          CASE  WHEN ENTPER_REQUIS_ESTADO = ''D'' AND ENTPER_REQUIS_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Requisitos- Obs: ''||ENTPER_REQUIS_OBS
                                WHEN ENTPER_PERF_ESTADO = ''D'' AND ENTPER_PERF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Perfil- Obs: ''||ENTPER_PERF_OBS
                                WHEN ENTPER_PRES_ESTADO = ''D'' AND ENTPER_PRES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Pre-Selccion - Obs: ''||ENTPER_PRES_OBS
                                WHEN ENTPER_REF_ESTADO = ''D'' AND ENTPER_REF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Referencia- Obs: ''||ENTPER_REF_OBS
                          end DESCARTADO   , null, null,
                          CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT ,
                            TO_CHAR(A.ENTPER_REQUIS_FECHA,''MM/YYYY'')
                    from PER_ENTREVISTA_PERSONAL_HIST A,
                         PER_ENTREVISTA_POST_HIST     T,
                         PER_CARGO_DPP           C,
                         PER_AREA_DPP            D
                   WHERE A.ENTPER_ENTREVISTA = T.PER_ENT_CODIGO
                     AND A.ENTPER_EMPR = T.PER_ENT_EMPR
                     AND T.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                     AND T.PER_ENT_EMPR = C.CARDPP_EMPR
                     AND C.CARDPP_AREA = D.AREDPP_CLAVE
                     AND C.CARDPP_EMPR = D.AREDPP_EMPR
                     AND ENTPER_ref_ESTADO IS NULL
                     AND ENTPER_REF_FECHA IS NULL
                     AND ENTPER_EMPR = 1
                     AND TO_CHAR(A.ENTPER_REQUIS_FECHA,''MM/YYYY'') = '''||V_MES1||'''
                     and a.semana is null
                     and t.semana is null
                     AND A.MES||''/''||A.ANHO ='''||V_MES1||'''
                     AND T.MES||''/''||T.ANHO = '''||V_MES1||'''

                    UNION ALL
                  select A.ENTPER_ENTREVISTA,
                         ''ENTREVISTA'',
                         D.AREDPP_DESC,
                         C.CARDPP_DESC,
                         PER_ENT_POSTULANTE,
                         DECODE(ENTPER_ref_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'')ESTADO_REF,
                         DECODE(ENTPER_REF_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',ENTPER_REF_ACCION) ACCION,
                         ENTPER_REF_FECHA FECHA_REF,
                          CASE  WHEN ENTPER_REQUIS_ESTADO = ''D'' AND ENTPER_REQUIS_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Requisitos- Obs: ''||ENTPER_REQUIS_OBS
                                WHEN ENTPER_PERF_ESTADO = ''D'' AND ENTPER_PERF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Perfil- Obs: ''||ENTPER_PERF_OBS
                                WHEN ENTPER_PRES_ESTADO = ''D'' AND ENTPER_PRES_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Pre-Selccion - Obs: ''||ENTPER_PRES_OBS
                                WHEN ENTPER_REF_ESTADO = ''D'' AND ENTPER_REF_OPER IS NOT NULL THEN
                                   ''Descartado Etapa Referencia- Obs: ''||ENTPER_REF_OBS
                          end DESCARTADO   , null, null,
                          CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT ,
                            TO_CHAR(A.ENTPER_REQUIS_FECHA,''MM/YYYY'')
                    from PER_ENTREVISTA_PERSONAL_HIST A,
                         PER_ENTREVISTA_POST_HIST     T,
                         PER_CARGO_DPP           C,
                         PER_AREA_DPP            D
                   WHERE A.ENTPER_ENTREVISTA = T.PER_ENT_CODIGO
                     AND A.ENTPER_EMPR = T.PER_ENT_EMPR
                     AND T.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                     AND T.PER_ENT_EMPR = C.CARDPP_EMPR
                     AND C.CARDPP_AREA = D.AREDPP_CLAVE
                     AND C.CARDPP_EMPR = D.AREDPP_EMPR
                     AND ENTPER_ref_ESTADO IS NULL
                     AND ENTPER_REF_FECHA IS NULL
                     AND ENTPER_EMPR = 1
                     AND TO_CHAR(A.ENTPER_REQUIS_FECHA,''MM/YYYY'') ='''||V_MES2||'''
                     and a.semana is null
                     and t.semana is null
                     AND A.MES||''/''||A.ANHO ='''||V_MES2||'''
                     AND T.MES||''/''||T.ANHO ='''||V_MES2||'''  ';

  --------------------------ENTREVISTA AREA
   P_QUERY26 := 'SELECT SOL.SOLPER_CLAVE NRO_SOL,
                     ''SELECCION'' PROGRAMA,
                     AR.AREDPP_DESC AREA_DESC,
                     PC.CAR_DESC CARGO_DESC,
                     SELPER_POSTUL NOMBRE_POST,
                     DECODE(SEL.SELEPER_EAR_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'',''RE'',''Redireccionado'')ESTADO_EAR,
                     DECODE(SEL.SELEPER_EAR_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'') ACCION,
                     SEL.SELEPER_EAR_FECHA FECHA_EAR,
                     SEL.SELEPER_EAR_OPER,
                     SEL.SELEPER_ETAPA_DECIS_GRAL ETAPA_ESTADO_GRAL,
                     SEL.SELEPER_FECHA_ESTADO_GRAL FECHA_ESTADO_GRAL,
                   CASE  WHEN SELEPER_ETAPA_DECIS_GRAL = ''REQ'' THEN
                               ''Etapa Requisitos''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PER''  THEN
                               ''Etapa Perfil''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PRES'' THEN
                               ''Etapa Pre-Selccion''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''REF'' THEN
                               ''Etapa Referencia''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''EAR'' THEN
                               ''Etapa Entrevista de Area''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''EES'' THEN
                               ''Etapa Entrevista Especial''
                         END  ETAPA_ESTADO_GRAL2 ,
                         DECODE (SELEPER_EAR_ESTADO, ''C'',1,2) ORDEN,
                     DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                     DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                     sol.SOLPER_FECHA_SOL,
                     TO_CHAR(SELEPER_REF_FECHA,''MM/YYYY'') ,
                      CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT
                FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
               WHERE SOL.SOLPER_EMPR = 1
                 AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                 AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                 AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                 AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                 AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                 AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                 AND TO_CHAR(SELEPER_REF_FECHA,''MM/YYYY'') = '''||V_MES2||'''
                 and sol.semana is null
                 and sel.semana is null
                 AND SOL.MES||''/''||SOL.ANHO ='''||V_MES2||'''
                 AND SEL.MES||''/''||SEL.ANHO ='''||V_MES2||'''
                 AND sel.seleper_ref_accion = ''PS''
                 AND SEL.SELEPER_EAR_FECHA IS NULL
                 and sel.seleper_ref_estado= ''C''
                 AND NVL(SOL.SOLPER_ESTADO_FINAL, ''EP'') = ''EP''
                 AND NVL(SELEPER_ESTADO_GRAL, ''EP'') <> ''D''
              UNION ALL
              SELECT SOL.SOLPER_CLAVE NRO_SOL,
                     ''SELECCION'' PROGRAMA,
                     AR.AREDPP_DESC AREA_DESC,
                     PC.CAR_DESC CARGO_DESC,
                     SELPER_POSTUL NOMBRE_POST,
                     DECODE(SEL.SELEPER_EAR_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'',''RE'',''Redireccionado'')ESTADO_EAR,
                     DECODE(SEL.SELEPER_EAR_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'') ACCION,
                     SEL.SELEPER_EAR_FECHA FECHA_EAR,
                     SEL.SELEPER_EAR_OPER,
                     SEL.SELEPER_ETAPA_DECIS_GRAL ETAPA_ESTADO_GRAL,
                     SEL.SELEPER_FECHA_ESTADO_GRAL FECHA_ESTADO_GRAL,
                   CASE  WHEN SELEPER_ETAPA_DECIS_GRAL = ''REQ'' THEN
                               ''Etapa Requisitos''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PER''  THEN
                               ''Etapa Perfil''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PRES'' THEN
                               ''Etapa Pre-Selccion''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''REF'' THEN
                               ''Etapa Referencia''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''EAR'' THEN
                               ''Etapa Entrevista de Area''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''EES'' THEN
                               ''Etapa Entrevista Especial''
                         END  ETAPA_ESTADO_GRAL2 ,
                         DECODE (SELEPER_EAR_ESTADO, ''C'',1,2) ORDEN,
                     DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                     DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                     sol.SOLPER_FECHA_SOL,
                     TO_CHAR(SELEPER_REF_FECHA,''MM/YYYY''),
                      CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT
                FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
               WHERE SOL.SOLPER_EMPR = 1
                 AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                 AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                 AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                 AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                 AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                 AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                 AND TO_CHAR(SELEPER_REF_FECHA,''MM/YYYY'') = '''||V_MES1||'''
                 and sol.semana is null
                 and sel.semana is null
                 AND SOL.MES||''/''||SOL.ANHO ='''||V_MES1||'''
                 AND SEL.MES||''/''||SEL.ANHO = '''||V_MES1||'''
                 AND sel.seleper_ref_accion = ''PS''
                 AND SEL.SELEPER_EAR_FECHA IS NULL
                 and sel.seleper_ref_estado= ''C''
                 AND NVL(SOL.SOLPER_ESTADO_FINAL, ''EP'') = ''EP''
                 AND NVL(SELEPER_ESTADO_GRAL, ''EP'') <> ''D''
               UNION ALL
               SELECT SOL.SOLPER_CLAVE NRO_SOL,
                     ''SELECCION'' PROGRAMA,
                     AR.AREDPP_DESC AREA_DESC,
                     PC.CAR_DESC CARGO_DESC,
                     SEL.SELPER_POSTUL NOMBRE_POST,
                     DECODE(SEL.SELEPER_EAR_ESTADO,''C'',''Cerrado'',''A'',''Abierto'',null,''Pendiente'',''D'',''Descartado'',''AN'',''Anulado'',''RE'',''Redireccionado'')ESTADO_EAR,
                     DECODE(SEL.SELEPER_EAR_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'') ACCION,
                     SEL.SELEPER_EAR_FECHA FECHA_EAR,
                     SEL.SELEPER_EAR_OPER,
                     SEL.SELEPER_ETAPA_DECIS_GRAL ETAPA_ESTADO_GRAL,
                     SEL.SELEPER_FECHA_ESTADO_GRAL FECHA_ESTADO_GRAL,
                   CASE  WHEN SELEPER_ETAPA_DECIS_GRAL = ''REQ'' THEN
                               ''Etapa Requisitos''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PER''  THEN
                               ''Etapa Perfil''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PRES'' THEN
                               ''Etapa Pre-Selccion''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''REF'' THEN
                               ''Etapa Referencia''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''EAR'' THEN
                               ''Etapa Entrevista de Area''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''EES'' THEN
                               ''Etapa Entrevista Especial''
                         END  ETAPA_ESTADO_GRAL2 ,
                         DECODE (SELEPER_EAR_ESTADO, ''C'',1,2) ORDEN,
                     DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                     DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                     sol.SOLPER_FECHA_SOL,
                     TO_CHAR(SELEPER_REF_FECHA,''MM/YYYY''),
                      CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT
                FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
               WHERE SOL.SOLPER_EMPR = 1
                 AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
                 AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
                 AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
                 AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
                 AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
                 AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
                 AND TO_CHAR(SELEPER_REF_FECHA,''MM/YYYY'') = '''||V_MES3||'''
                '||P_AND_SOL||'
                 '||P_AND_SEL ||'
                 and sel.seleper_ref_estado= ''C''
                 AND NVL(SOL.SOLPER_ESTADO_FINAL, ''EP'') = ''EP''
                 AND NVL(SELEPER_ESTADO_GRAL, ''EP'') <> ''D'' ';

   P_QUERY27 := 'SELECT SOL.SOLPER_CLAVE NRO_SOL,             -----------------------ENTREVISTA ESPECIAL
                   ''SELECCION'' PROGRAMA,
                   AR.AREDPP_DESC AREA_DESC,
                   PC.CAR_DESC CARGO_DESC,
                   SEL.SELPER_POSTUL NOMBRE_POST,
                   DECODE(SEL.SELEPER_EES_ESTADO,''A'',''Abierto'',''C'',''Cerrado'',null,''Pendiente'',''D'',''Descartado'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_EES,
                   DECODE(SEL.SELEPER_EES_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''A'',''Anulado'') ACCION,
                   SEL.SELEPER_EES_FECHA FECHA_EES,
                   SEL.SELEPER_EES_OPER,
                   SEL.SELEPER_ETAPA_DECIS_GRAL ETAPA_ESTADO_GRAL,
                   SEL.SELEPER_FECHA_ESTADO_GRAL FECHA_ESTADO_GRAL,
               CASE  WHEN SELEPER_ETAPA_DECIS_GRAL = ''REQ'' THEN
                             ''Etapa Requisitos''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PER''  THEN
                             ''Etapa Perfil''
                        WHEN SELEPER_ETAPA_DECIS_GRAL = ''PRES'' THEN
                             ''Etapa Pre-Selccion''
                        WHEN SELEPER_ETAPA_DECIS_GRAL = ''REF'' THEN
                             ''Etapa Referencia''
                       WHEN SELEPER_ETAPA_DECIS_GRAL = ''EAR'' THEN
                             ''Etapa Entrevista de Area''
                       WHEN SELEPER_ETAPA_DECIS_GRAL = ''EES'' THEN
                             ''Etapa Entrevista Especial''
                       END  ETAPA_ESTADO_GRAL2 ,
                       DECODE (SELEPER_EES_ESTADO, ''C'',1,2) ORDEN,
                        DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                   TO_CHAR(SELEPER_EAR_FECHA,''MM/YYYY'') ,
               CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT
              FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
             WHERE SOL.SOLPER_EMPR = 1
               AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
               AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
               AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
               AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
               AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
               AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
               AND NVL(SOLPER_ESTADO_FINAL,''EP'')  = ''EP''
               AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
               AND SELEPER_EAR_ACCION = ''PS''
               AND TO_CHAR(SELEPER_EAR_FECHA,''MM/YYYY'') = '''||V_MES3||'''
               '||P_AND_SOL||'
                '||P_AND_SEL ||'
               AND SELEPER_EES_FECHA IS NULL
               UNION ALL
               SELECT SOL.SOLPER_CLAVE NRO_SOL,             -----------------------ENTREVISTA ESPECIAL
                   ''SELECCION'' PROGRAMA,
                   AR.AREDPP_DESC AREA_DESC,
                   PC.CAR_DESC CARGO_DESC,
                   SEL.SELPER_POSTUL NOMBRE_POST,
                   DECODE(SEL.SELEPER_EES_ESTADO,''A'',''Abierto'',''C'',''Cerrado'',null,''Pendiente'',''D'',''Descartado'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_EES,
                   DECODE(SEL.SELEPER_EES_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''A'',''Anulado'') ACCION,
                   SEL.SELEPER_EES_FECHA FECHA_EES,
                   SEL.SELEPER_EES_OPER,
                   SEL.SELEPER_ETAPA_DECIS_GRAL ETAPA_ESTADO_GRAL,
                   SEL.SELEPER_FECHA_ESTADO_GRAL FECHA_ESTADO_GRAL,
               CASE  WHEN SELEPER_ETAPA_DECIS_GRAL = ''REQ'' THEN
                             ''Etapa Requisitos''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PER''  THEN
                             ''Etapa Perfil''
                        WHEN SELEPER_ETAPA_DECIS_GRAL = ''PRES'' THEN
                             ''Etapa Pre-Selccion''
                        WHEN SELEPER_ETAPA_DECIS_GRAL = ''REF'' THEN
                             ''Etapa Referencia''
                       WHEN SELEPER_ETAPA_DECIS_GRAL = ''EAR'' THEN
                             ''Etapa Entrevista de Area''
                       WHEN SELEPER_ETAPA_DECIS_GRAL = ''EES'' THEN
                             ''Etapa Entrevista Especial''
                       END  ETAPA_ESTADO_GRAL2 ,
                       DECODE (SELEPER_EES_ESTADO, ''C'',1,2) ORDEN,
                        DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                   TO_CHAR(SELEPER_EAR_FECHA,''MM/YYYY''),
                    CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT
              FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
             WHERE SOL.SOLPER_EMPR = 1
               AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
               AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
               AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
               AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
               AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
               AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
               AND NVL(SOLPER_ESTADO_FINAL,''EP'')  = ''EP''
               AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
               AND SELEPER_EAR_ACCION = ''PS''
               AND TO_CHAR(SELEPER_EAR_FECHA,''MM/YYYY'') ='''||V_MES2||'''
               and sol.semana is null
               and sel.semana is null
               AND SOL.MES||''/''||SOL.ANHO ='''||V_MES2||'''
               AND SEL.MES||''/''||SEL.ANHO = '''||V_MES2||'''
               AND SELEPER_EES_FECHA IS NULL
               UNION ALL
               SELECT SOL.SOLPER_CLAVE NRO_SOL,             -----------------------ENTREVISTA ESPECIAL
                   ''SELECCION'' PROGRAMA,
                   AR.AREDPP_DESC AREA_DESC,
                   PC.CAR_DESC CARGO_DESC,
                   SEL.SELPER_POSTUL NOMBRE_POST,
                   DECODE(SEL.SELEPER_EES_ESTADO,''A'',''Abierto'',''C'',''Cerrado'',null,''Pendiente'',''D'',''Descartado'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_EES,
                   DECODE(SEL.SELEPER_EES_ACCION,''PS'',''Pasa a la siguiente etapa'', ''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''A'',''Anulado'') ACCION,
                   SEL.SELEPER_EES_FECHA FECHA_EES,
                   SEL.SELEPER_EES_OPER,
                   SEL.SELEPER_ETAPA_DECIS_GRAL ETAPA_ESTADO_GRAL,
                   SEL.SELEPER_FECHA_ESTADO_GRAL FECHA_ESTADO_GRAL,
               CASE  WHEN SELEPER_ETAPA_DECIS_GRAL = ''REQ'' THEN
                             ''Etapa Requisitos''
                         WHEN SELEPER_ETAPA_DECIS_GRAL = ''PER''  THEN
                             ''Etapa Perfil''
                        WHEN SELEPER_ETAPA_DECIS_GRAL = ''PRES'' THEN
                             ''Etapa Pre-Selccion''
                        WHEN SELEPER_ETAPA_DECIS_GRAL = ''REF'' THEN
                             ''Etapa Referencia''
                       WHEN SELEPER_ETAPA_DECIS_GRAL = ''EAR'' THEN
                             ''Etapa Entrevista de Area''
                       WHEN SELEPER_ETAPA_DECIS_GRAL = ''EES'' THEN
                             ''Etapa Entrevista Especial''
                       END  ETAPA_ESTADO_GRAL2 ,
                       DECODE (SELEPER_EES_ESTADO, ''C'',1,2) ORDEN,
                        DECODE(SEL.SELEPER_ESTADO_GRAL,''EP'',''En Proceso'',''D'',''Descartado'',''C'',''Contratado'',null,''En Proceso'',''RE'',''Redireccionado'',''AN'',''Anulado'')ESTADO_GRAL,
                   DECODE(SOL.SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FIN_SOL,
                   TO_CHAR(SELEPER_EAR_FECHA,''MM/YYYY''),
                    CASE
                            WHEN AREDPP_DESC IN (''GERENCIA GENERAL'', ''ADMINISTRATIVA'') THEN
                                      ''ADM''
                             ELSE
                            AREDPP_DESC
                            END AREA_DOT
              FROM PER_SOLICITUD_PERSONAL_HIST SOL,PER_AREA_DPP AR,PER_CARGO PC,PER_SELECCION_PERSONAL_HIST SEL
             WHERE SOL.SOLPER_EMPR = 1
               AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR (+)
               AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE (+)
               AND SOL.SOLPER_EMPR = PC.CAR_EMPR (+)
               AND SOL.SOLPER_CARGO = PC.CAR_CODIGO (+)
               AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR (+)
               AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI (+)
               AND NVL(SOLPER_ESTADO_FINAL,''EP'')  = ''EP''
               AND NVL(SELEPER_ESTADO_GRAL,''EP'') = ''EP''
               AND SELEPER_EAR_ACCION = ''PS''
               AND TO_CHAR(SELEPER_EAR_FECHA,''MM/YYYY'') = '''||V_MES1||'''
               and sol.semana is null
               and sel.semana is null
               AND SOL.MES||''/''||SOL.ANHO ='''||V_MES1||'''
               AND SEL.MES||''/''||SEL.ANHO = '''||V_MES1||'''
               AND SELEPER_EES_FECHA IS NULL ';

    P_QUERY:= 'SELECT ''1RA. ENTREVISTA'' DETALLE,''Q'' UM, NULL PB, COUNT (NOMBRE_POST) CANTIDAD, MES_ANHO
                FROM
                (SELECT ----1ra entrevista
                NOMBRE_POST,MES_ANHO,AREA_DESC, ESTADO
                FROM
                CUBO_LONDON_PROCESO_SELEC
                WHERE NOMBRE_POST <>'' ''
                AND FECHA_SOL BETWEEN ADD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''), -2) AND  TO_DATE('''||P_FECHA||''')
                AND ETAPA = ''1 -REQUISITOS''
                AND ESTADO_APROB_SOL <> ''Rechazado''
                AND CASE WHEN ESTADO_FIN_SOL = ''En Proceso'' AND ESTADO_GRAL = ''En Proceso'' AND ESTADO = ''Abierto'' THEN
                         1
                         ELSE
                           0 END =0
                union all
                SELECT to_char(p.per_ent_codigo), TO_CHAR(T.ENTPER_REQUIS_FECHA, ''mm/yyyy''), S.AREDPP_DESC,
                       DECODE(T.ENTPER_REQUIS_ESTADO, ''C'', ''Cerrado'', ''A'', ''Abierto'')
                  FROM PER_ENTREVISTA_PERSONAL T, PER_ENTREVISTA_POST P , PER_CARGO_DPP C,  PER_AREA_DPP S
                 WHERE T.ENTPER_ENTREVISTA = P.PER_ENT_CODIGO
                    AND T.ENTPER_EMPR = P.PER_ENT_EMPR
                    AND P.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                    AND P.PER_ENT_EMPR = C.CARDPP_EMPR
                    AND C.CARDPP_AREA = S.AREDPP_CLAVE
                    AND C.CARDPP_EMPR = S.AREDPP_EMPR
                    AND TRUNC(ENTPER_REQUIS_FECHA) BETWEEN
                       ADD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''), -2) AND
                       TO_DATE('''||P_FECHA||''')
                )
                GROUP BY MES_ANHO';

    P_QUERY1 := 'select
                    CASE
                       WHEN ESTADO IN (''Abierto'', ''Pendiente'')
                          AND ETAPA IN (''1 -REQUISITOS'',''2 -PERFIL'',''3 -PRESELECCION'')
                          AND FECHA_INICIO IS NOT NULL
                          AND ESTADO_GRAL = ''En Proceso''
                          AND ESTADO_FIN_SOL = ''En Proceso''  THEN
                         1
                    END PRI_ENTREVISTA_EN_LISTA,
                          CASE
                             WHEN estado = ''Cerrado'' AND etapa = ''4 -REFERENCIAS'' AND T.FECHA_REF IS NOT NULL  THEN
                              1
                           END REFER_TOTAL,
                           CASE
                             WHEN estado = ''Abierto'' and etapa = ''4 -REFERENCIAS'' AND ESTADO_GRAL = ''En Proceso''
                          AND ESTADO_FIN_SOL = ''En Proceso'' THEN
                              1
                           END REFER_EN_FILA,
                           CASE
                             when ESTADO = ''Cerrado'' and etapa like ''%5 -ENTREVISTA%''  AND T.FECHA_EAR IS NOT NULL  then
                              1
                           end ENT_AREA_TOTAL,
                           case
                             when ESTADO = ''Abierto'' and etapa like ''%5 -ENTREVISTA%'' AND ESTADO_GRAL = ''En Proceso''
                          AND ESTADO_FIN_SOL = ''En Proceso''then
                              1
                           end ENT_AREA_EN_FILA,
                           CASE
                             WHEN ESTADO = ''Cerrado'' AND etapa LIKE ''%6 -ENTREVISTA ESPECIAL%'' AND T.FECHA_EES IS NOT NULL  THEN
                              1
                           end ENT_ESPECIAL_TOTAL,
                           CASE
                             WHEN ESTADO = ''Abierto'' AND etapa like ''%6 -ENTREVISTA%'' AND ESTADO_GRAL = ''En Proceso''
                          AND ESTADO_FIN_SOL = ''En Proceso'' THEN
                              1
                           end ENT_ESPECIAL_EN_FILA,

                           CASE
                             WHEN area_desc IN ( ''GERENCIA GENERAL'',''ADMINISTRATIVA'') THEN
                                ''ADM''
                              ELSE AREA_dESC
                                END  AREA,
                           mes_anho
                      from CUBO_LONDON_PROCESO_SELEC T
                     where nombre_post <> '' ''
                        AND FECHA_SOL BETWEEN ADD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''), -2) AND  TO_DATE('''||P_FECHA||''')

                            UNION ALL
                            select  CASE
                                    WHEN  NVL(A.ENTPER_REQUIS_ESTADO, ''P'') IN (''A'',''P'') THEN
                                      1
                                    END PENDIENTES,

                                    CASE WHEN NVL(A.ENTPER_REF_ESTADO,''P'') IN (''C'') THEN
                                     1
                                    END REF_TOTAL,
                                     CASE WHEN NVL(A.ENTPER_REF_ESTADO,''P'') IN (''A'',''P'') THEN
                                     1
                                    END REF_EN_FILA,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                   D.AREDPP_DESC,
                                   TO_CHAR(T.PER_ENT_FECHA,''MM/YYYY'') fecha

                              from PER_ENTREVISTA_PERSONAL A,
                                   PER_ENTREVISTA_POST     T,
                                   PER_CARGO_DPP           C,
                                   PER_AREA_DPP            D
                             WHERE A.ENTPER_ENTREVISTA = T.PER_ENT_CODIGO
                               AND A.ENTPER_EMPR = T.PER_ENT_EMPR
                               AND T.PER_ENT_CARGO_RAL = C.CARDPP_CLAVE
                               AND T.PER_ENT_EMPR = C.CARDPP_EMPR
                               AND C.CARDPP_AREA = D.AREDPP_CLAVE
                               AND C.CARDPP_EMPR = D.AREDPP_EMPR
                               AND TRUNC(PER_ENT_FECHA) BETWEEN ADD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''), -2) AND  TO_DATE('''||P_FECHA||''')';

      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'PRI_ENTR') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'PRI_ENTR');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'PRI_ENTR',
                                                         P_QUERY           => P_QUERY20);

         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'REFERENCIA') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'REFERENCIA');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'REFERENCIA',
                                                         P_QUERY           => P_QUERY21);

         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'ENT_AREA') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'ENT_AREA');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'ENT_AREA',
                                                         P_QUERY           => P_QUERY22);

         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'ENTR_ESPECIAL') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'ENTR_ESPECIAL');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'ENTR_ESPECIAL',
                                                         P_QUERY           => P_QUERY23);

         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'EN_LIS_PRI_ENTR') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EN_LIS_PRI_ENTR');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'EN_LIS_PRI_ENTR',
                                                         P_QUERY           => P_QUERY24);

         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'EN_LIST_REF') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EN_LIST_REF');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'EN_LIST_REF',
                                                         P_QUERY           => P_QUERY25);

         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'EN_LIST_AREA') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EN_LIST_AREA');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'EN_LIST_AREA',
                                                         P_QUERY           => P_QUERY26);


       IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'EN_LIST_ESPECIAL') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'EN_LIST_ESPECIAL');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'EN_LIST_ESPECIAL',
                                                         P_QUERY           => P_QUERY27);

P_QUERY2 := 'SELECT DETALLE,
       CANTIDAD,
       CASE
         WHEN MES_ANHO = '''||V_MES1||''' THEN
          CANTIDAD
       END MES1,
       CASE
         WHEN MES_ANHO = '''||V_MES2||''' THEN
          CANTIDAD
       END MES2,
       CASE
         WHEN MES_ANHO = '''||V_MES3||''' THEN
          CANTIDAD
       END MES3,
       ORDEN
  FROM (SELECT '' 1RA. ENTREVISTA '' DETALLE,
               COUNT(c001) CANTIDAD,
               C002 MES_ANHO,
               1 ORDEN
          FROM APEX_collections
         WHERE collection_name = ''PRI_ENTR''
         GROUP BY C002
        UNION ALL
        SELECT ''REFERENCIAS'' DETALLE,
               COUNT(c001) CANTIDAD,
               C002 MES_ANHO,
               4 ORDEN
          FROM APEX_collections
         WHERE collection_name = ''REFERENCIA''
         GROUP BY C002
        UNION ALL
        SELECT ''ENTREVISTA AREA'' DETALLE,
               COUNT(c001) CANTIDAD,
               C002 MES_ANHO,
               7 ORDEN
          FROM APEX_collections
         WHERE collection_name = ''ENT_AREA''
         GROUP BY C002
        UNION ALL
        SELECT ''ENTREVISTA ESPECIAL'' DETALLE,
               COUNT(c001) CANTIDAD,
               C002 MES_ANHO,
               10 ORDEN
          FROM APEX_collections
         WHERE collection_name = ''ENTR_ESPECIAL''
         GROUP BY C002
        UNION ALL
        SELECT AREA_DESC, CANTIDAD, MES_ANHO, B.ORDEN
          FROM (SELECT c012 DETALLE,
                       COUNT(C001) CANTIDAD,
                       C013 MES_ANHO,
                       3 ORDEN
                  FROM APEX_collections
                 WHERE collection_name = ''EN_LIS_PRI_ENTR ''
                 GROUP BY C012, C013) A,
               (select AREA_DESC, 3 ORDEN
                  from PER_AREA_JSA t
                 WHERE T.AREA_TIPO = 1
                   AND T.AREA_EMPR = 1) B
         WHERE B.AREA_DESC = A.DETALLE(+)
        UNION ALL
        SELECT AREA_DESC, CANTIDAD, MES_ANHO, B.ORDEN
          FROM (SELECT c012 DETALLE,
                       COUNT(C001) CANTIDAD,
                       C013 MES_ANHO,
                       6 ORDEN
                  FROM APEX_collections
                 WHERE collection_name = ''EN_LIST_REF''
                 GROUP BY C012, C013) A,
               (select AREA_DESC,6 ORDEN
                  from PER_AREA_JSA t
                 WHERE T.AREA_TIPO = 1
                   AND T.AREA_EMPR = 1) B
         WHERE B.AREA_DESC = A.DETALLE(+)
        UNION ALL
        SELECT AREA_DESC, CANTIDAD, MES_ANHO, B.ORDEN
          FROM (SELECT c018 DETALLE,
                       COUNT(C001) CANTIDAD,
                       C017 MES_ANHO,
                       9 ORDEN
                  FROM APEX_collections
                 WHERE collection_name = ''EN_LIST_AREA''
                 GROUP BY C018, C017) A,
               (select AREA_DESC, 9 ORDEN
                  from PER_AREA_JSA t
                 WHERE T.AREA_TIPO = 1
                   AND T.AREA_EMPR = 1) B
         WHERE B.AREA_DESC = A.DETALLE(+)
        UNION ALL
        SELECT AREA_DESC, CANTIDAD, MES_ANHO, B.ORDEN
          FROM (SELECT c017 DETALLE,
                       COUNT(C002) CANTIDAD,
                       C016 MES_ANHO,
                       12 ORDEN
                  FROM APEX_collections
                 WHERE collection_name = ''EN_LIST_ESPECIAL''
                 GROUP BY C017, C016) A,
               (select AREA_DESC,12 ORDEN
                  from PER_AREA_JSA t
                 WHERE T.AREA_TIPO = 1
                   AND T.AREA_EMPR = 1) B
         WHERE B.AREA_DESC = A.DETALLE(+))';

         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'ENTREVISTA_PROCESO') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'ENTREVISTA_PROCESO');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'ENTREVISTA_PROCESO',
                                                         P_QUERY           => P_QUERY2);


          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'RSC_ENTREV') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'RSC_ENTREV');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'RSC_ENTREV',
                                                         P_QUERY           => P_QUERY);

            IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'RSC_ENTREVISTA') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'RSC_ENTREVISTA');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'RSC_ENTREVISTA',
                                                         P_QUERY           => P_QUERY1);

  END PP_PROCESO_SELECCION_RSC;
  
  
  
    PROCEDURE PP_PROCESO_CONTRATACIONES (P_EMPRESA IN NUMBER,
                                      P_FECHA IN DATE) IS
  P_QUERY VARCHAR2(21000);
  P_QUERY1 VARCHAR2(21000);
  P_QUERY2 VARCHAR2(21000);
  P_QUERY7 VARCHAR2(21000);
  P_AND VARCHAR2(2000);

  BEGIN
   if P_FECHA = LAST_DAY(TO_DATE(P_FECHA))  THEN
       P_AND := P_AND||'AND SEMANA IS NULL AND MES || ''/'' || ANHO =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';
   ELSE
       P_AND := P_AND||' and mes is null AND SEMANA || ''/'' || ANHO =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
   END IF;

   P_QUERY:=  'SELECT TO_CHAR(ADD_MONTHS(('''||P_FECHA||'''), -2),''MM/YYYY'') MES_1,
                     TO_CHAR(ADD_MONTHS(('''||P_FECHA||'''), -1),''MM/YYYY'') MES_2,
                     TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') MES_3
               FROM DUAL';

    P_QUERY7:='SELECT TRUNC(B.EMPL_FEC_INGRESO) FECHA_INGRESO,
                     DECODE(B.EMPL_TIPO_CONT, ''I'', ''TIEMPO INDEFINIDO'', ''TEMPORAL'') TIPO_CONTRATO,
                     B.EMPL_AREA_ORGANI,
                     UPPER(DECODE(B.EMPL_CONTRATADO_POR,''RC'',''RE-CONTRATACION'',NVL(EMPL_CONTRATADO_POR, ''RRHH''))) CONTATADO_POR,
                     CASE WHEN TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'') = ''03/2020'' AND EMPL_LEGAJO = 104322 THEN
                       ''TE''
                       ELSE

                     DECODE(EMPL_TIPO_CONT, ''I'', ''IN'', ''TE'')
                     END TIPO_CONT,
                     TO_CHAR(EMPL_FEC_INGRESO, ''MM/YYYY'') MES_ANHO,
                     B.EMPL_FEC_SALIDA,
                     B.EMPL_LEGAJO,
                     B.EMPL_NOMBRE||'' - ''||EMPL_APE,
                     DECODE(B.EMPL_SITUACION,''A'',''ACTIVO'',''I'',''INACTIVO'') SITUACION,
                     EMPL_CARGO,
                     EMPL_SUCURSAL,
                     CASE WHEN TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'') = ''03/2020'' AND EMPL_LEGAJO = 104322 THEN
                       ''T''
                       ELSE
                       EMPL_TIPO_CONT
                       END
                  FROM PER_EMPLEADO_HIST B
               WHERE B.EMPL_EMPRESA = '||P_EMPRESA||'
                 AND EMPL_CODIGO_PROV IS NOT NULL
                 AND TO_CHAR(EMPL_FEC_INGRESO, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                 AND MES|| ''/'' || ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                 and semana is null
              UNION ALL
              SELECT TRUNC(B.EMPL_FEC_INGRESO) FECHA_INGRESO,
                     DECODE(B.EMPL_TIPO_CONT, ''I'', ''TIEMPO INDEFINIDO'', ''TEMPORAL'') TIPO_CONTRATO,
                     B.EMPL_AREA_ORGANI,
                    UPPER(DECODE(B.EMPL_CONTRATADO_POR,''RC'',''RE-CONTRATACION'',NVL(EMPL_CONTRATADO_POR, ''RRHH''))) CONTATADO_POR,
                     DECODE(EMPL_TIPO_CONT, ''I'', ''IN'', ''TE'') TIPO_CONT,
                     TO_CHAR(EMPL_FEC_INGRESO, ''MM/YYYY'') MES_ANHO,
                     B.EMPL_FEC_SALIDA,
                     B.EMPL_LEGAJO,
                     B.EMPL_NOMBRE||'' - ''||EMPL_APE,
                     DECODE(B.EMPL_SITUACION,''A'',''ACTIVO'',''I'',''INACTIVO'') SITUACION,
                     EMPL_CARGO,
                     EMPL_SUCURSAL,
                     EMPL_TIPO_CONT
                FROM PER_EMPLEADO_HIST B
               WHERE B.EMPL_EMPRESA = '||P_EMPRESA||'
                 AND EMPL_CODIGO_PROV IS NOT NULL
                 AND TO_CHAR(EMPL_FEC_INGRESO, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                 AND MES || ''/'' || ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                 and semana is null
              UNION ALL
              SELECT TRUNC(B.EMPL_FEC_INGRESO) FECHA_INGRESO,
                     DECODE(B.EMPL_TIPO_CONT, ''I'', ''TIEMPO INDEFINIDO'', ''TEMPORAL'') TIPO_CONTRATO,
                     B.EMPL_AREA_ORGANI,
                     UPPER(DECODE(B.EMPL_CONTRATADO_POR,''RC'',''RE-CONTRATACION'',NVL(EMPL_CONTRATADO_POR, ''RRHH''))) CONTATADO_POR,
                     DECODE(EMPL_TIPO_CONT, ''I'', ''IN'', ''TE'') TIPO_CONT,
                     TO_CHAR(EMPL_FEC_INGRESO, ''MM/YYYY'') MES_ANHO,
                     B.EMPL_FEC_SALIDA,
                     B.EMPL_LEGAJO,
                     B.EMPL_NOMBRE||'' - ''||EMPL_APE,
                     DECODE(B.EMPL_SITUACION,''A'',''ACTIVO'',''I'',''INACTIVO'') SITUACION,
                     EMPL_CARGO,
                     EMPL_SUCURSAL,
                     EMPL_TIPO_CONT
                FROM PER_EMPLEADO_HIST B
               WHERE B.EMPL_EMPRESA = '||P_EMPRESA||'
                 AND EMPL_CODIGO_PROV IS NOT NULL
                  AND EMPL_FEC_INGRESO <= '''||P_FECHA||'''
                 '||P_AND||'
                 AND TO_CHAR(EMPL_FEC_INGRESO, ''MM/YYYY'') =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
               ';
               
P_QUERY2 :='SELECT SUM(TIPO_CONTRA_INDEFINIDO), SUM(TIPO_CONTRA_TEMPORAL), SUM(CONTR_RRHH),
                SUM(CONTR_OTROS), SUM(TIPO_CONTRA_INDEFINIDO)+ SUM(TIPO_CONTRA_TEMPORAL)
                FROM(
                SELECT
                CASE
                  WHEN EMPL_TIPO_CONT <> ''T'' THEN
                 1
                  END TIPO_CONTRA_INDEFINIDO,
                CASE
                   WHEN EMPL_TIPO_CONT = ''T'' THEN
                  1
                END TIPO_CONTRA_TEMPORAL,
                CASE
                   WHEN EMPL_CONTRATADO_POR = ''RRHH'' THEN
                  1
                END CONTR_RRHH,
               CASE
                   WHEN EMPL_CONTRATADO_POR <> ''RRHH'' THEN
                  1
                END CONTR_OTROS
            FROM PER_EMPLEADO_HIST
             WHERE EMPL_EMPRESA = '||P_EMPRESA||'
             AND MES || ''/'' || ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-12),''MM/YYYY'')
             and semana is null
             AND TO_CHAR(EMPL_FEC_INGRESO,''MM/YYYY'' ) =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-12),''MM/YYYY''))';




          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TAB_CONTRATACIONES') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TAB_CONTRATACIONES');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TAB_CONTRATACIONES',
                                                         P_QUERY           => P_QUERY7);

            P_QUERY1:= 'select CASE WHEN C005 = ''IN'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') THEN  1 ELSE  0 END MES1_INDEFINIDO,
                         CASE WHEN C005 = ''IN'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') THEN  1 ELSE  0 END MES2_INDEFINIDO,
                         CASE WHEN C005 = ''IN'' AND C006 = TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') THEN  1 ELSE  0 END MES3_INDEFINIDO,
                         CASE WHEN C005 = ''TE'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') THEN  1 ELSE  0 END MES1_TEMPORAL,
                         CASE WHEN C005 = ''TE'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') THEN  1 ELSE  0 END MES2_TEMPORAL,
                         CASE WHEN C005 = ''TE'' AND C006 = TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') THEN  1 ELSE  0 END MES3_TEMPORAL,
                         CASE WHEN C004 = ''RRHH'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') THEN  1 ELSE  0 END MES1_RRHH,
                         CASE WHEN C004 = ''RRHH'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') THEN  1 ELSE  0 END MES2_RRHH,
                         CASE WHEN C004 = ''RRHH'' AND C006 = TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') THEN  1 ELSE  0 END MES3_RRHH,
                         CASE WHEN C004 = ''OTROS'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') THEN  1 ELSE  0 END MES1_OTROS,
                         CASE WHEN C004 = ''OTROS'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') THEN  1 ELSE  0 END MES2_OTROS,
                         CASE WHEN C004 = ''OTROS'' AND C006 = TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') THEN  1 ELSE  0 END MES3_OTROS,
                         C006 MES_ANHO,
                         CASE WHEN C004 = ''RE-CONTRATACION'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') THEN  1 ELSE  0 END MES1_OTROS,
                         CASE WHEN C004 = ''RE-CONTRATACION'' AND C006 = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') THEN  1 ELSE  0 END MES2_OTROS,
                         CASE WHEN C004 = ''RE-CONTRATACION'' AND C006 = TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') THEN  1 ELSE  0 END MES3_OTROS

                  FROM
                  (SELECT c001,c002,c003,c004,C006, c005,c007,c008, c009, c010, c011, c012, c013, c014, c015
                   FROM APEX_collections
                  WHERE collection_name = ''TAB_CONTRATACIONES'')';
  delete from x
  where otro = 'contrataciones';
    insert into x
      (campo1, otro)
    values
      (P_QUERY7, 'contrataciones');

          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CONTR_MES') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'CONTR_MES');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'CONTR_MES',
                                                         P_QUERY           => P_QUERY);
          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CONTRATACIONES') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'CONTRATACIONES');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'CONTRATACIONES',
                                                         P_QUERY           => P_QUERY1);


          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CONTRATA_ANHO') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'CONTRATA_ANHO');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'CONTRATA_ANHO',
                                                         P_QUERY           => P_QUERY2);

  END PP_PROCESO_CONTRATACIONES;


   PROCEDURE PP_PROCESO_DESVINCULACION(P_EMPRESA IN NUMBER, P_FECHA IN DATE) is

   P_QUERY VARCHAR2(21000);
   P_QUERY1 VARCHAR2(21000);
   P_QUERY2 VARCHAR2(21000);
   P_QUERY3 VARCHAR2(21000);
   P_QUERY7 VARCHAR2(21000);
    P_AND   VARCHAR2(2000);
   BEGIN


 IF  P_FECHA = LAST_DAY(TO_DATE(P_FECHA))  THEN
    P_AND := P_AND||' AND MES || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';
 ELSE
   P_AND := P_AND||' AND SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
 END IF;

   P_QUERY7:= 'SELECT EMPL_LEGAJO,NOMBRE,INGRESO, SALIDA, SUCURSAL, DEPARTAMENTO,
                          CARGO,TIPO_DESV,FACTOR_DESCV,MOTIVO_DESCV,TIPDESV_DESC,
                          Motivo,TIPO_CONTRATO,MES, IMPORTE, CONCEPTO, VALOR, EMPL_TIPO_CONT,
                          SEMANA_ANHO,SEMANA
                 FROM
                   (SELECT EMPL_LEGAJO,
                         EMPL_NOMBRE||'' ''||EMPL_APE NOMBRE,
                         EMPL_FEC_INGRESO INGRESO,
                         EMPL_FEC_SALIDA SALIDA,
                         EMPL_SUCURSAL SUCURSAL,
                         EMPL_DEPARTAMENTO DEPARTAMENTO,
                         EMPL_CARGO CARGO,
                         DECODE(empl_tipo_desv,''DJ'',''Despido Justificado'',''DI'',''Despido Injustificado'',''RV'',''Renuncia Voluntaria'',''TC'',''Termino de Contrato'',''JU'',''Judicial'',
                                ''JB'',''Jubilacion'',''TM'',''Termino de Zafra'',''PM'', ''Por Muerte'', ''PP'',''Periodo de Prueba'')TIPO_DESV,
                         (SELECT FAC.FACDES_DESC FROM PER_FACTOR_DESVINCULACION FAC WHERE FAC.FACDES_EMPR = '||P_EMPRESA||' AND FAC.FACDES_CLAVE = DESV.TIPDESV_FACTOR)FACTOR_DESCV,
                         (SELECT MOT.MOTDESV_DESC FROM PER_MOTIVO_DESVINCULACION MOT WHERE MOT.MOTDESV_EMPR = '||P_EMPRESA||' AND MOT.MOTDESV_CLAVE = DESV.TIPDESV_MOTIVO)MOTIVO_DESCV,
                         DESV.TIPDESV_DESC,
                         EM.EMPL_MOTIVO_SALIDA Motivo,
                         DECODE(EM.EMPL_TIPO_CONT,''I'',''TIEMPO INDEFINIDO'',''T'',''TEMPORAL'') TIPO_CONTRATO,
                         TO_CHAR(EMPL_FEC_SALIDA, ''MM/YYYY'') MES,
                         TO_CHAR(EMPL_FEC_SALIDA, ''IW/YYYY'') SEMANA_ANHO,
                         TO_NUMBER(TO_CHAR(EMPL_FEC_SALIDA, ''IW'')) SEMANA,
                          CASE WHEN TO_CHAR(PDOC_FEC, ''MM/YYYY'') =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') THEN
                              PDDET_IMP
                              END IMPORTE,
                         CASE WHEN TO_CHAR(PDOC_FEC, ''MM/YYYY'') =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') THEN
                         PDDET_CLAVE_CONCEPTO
                        END CONCEPTO,
                         3 VALOR,
                         EMPL_TIPO_CONT
                    FROM PER_EMPLEADO_HIST EM,
                         PER_TIPO_DESVINCULACION DESV,
                         PER_DOCUMENTO A,
                         PER_DOCUMENTO_DET B,
                         PER_CONCEPTO
                   WHERE EMPL_SITUACION = ''I''
                     AND EMPL_EMPRESA = '||P_EMPRESA||'
                     AND EMPL_EMPRESA =  DESV.TIPDESV_EMPR (+)
                     AND EMPL_MOT_DESV = DESV.TIPDESV_MOTIVO (+)
                     AND EMPL_FAC_DESV = DESV.TIPDESV_FACTOR (+)
                     AND EMPL_TIPO_DESV = DESV.TIPDESV_TIP_DESV (+)
                     AND EMPL_LEGAJO =  A.PDOC_EMPLEADO(+)
                     AND EMPL_EMPRESA = PDOC_EMPR(+)
                     AND PDOC_CLAVE = PDDET_CLAVE_DOC(+)
                     AND PDOC_EMPR = PDDET_EMPR(+)
                     AND PDDET_CLAVE_CONCEPTO = PCON_CLAVE
                     AND PDDET_EMPR = PCON_EMPR
                     AND PCON_IND_DBCR=''C''
                     AND PCON_FIN_TMOV <> 31
                     AND PDOC_FEC >= EMPL_FEC_SALIDA
                     AND TO_CHAR(EMPL_FEC_SALIDA, ''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
                     AND TO_CHAR(PDOC_FEC(+) , ''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
                       '||P_AND||'
                     UNION ALL
                     SELECT EMPL_LEGAJO,
                         EMPL_NOMBRE||'' ''||EMPL_APE,
                         EMPL_FEC_INGRESO,
                         EMPL_FEC_SALIDA,
                         EMPL_SUCURSAL,
                         EMPL_DEPARTAMENTO,
                         EMPL_CARGO CARGO,
                         DECODE(empl_tipo_desv,''DJ'',''Despido Justificado'',''DI'',''Despido Injustificado'',''RV'',''Renuncia Voluntaria'',''TC'',''Termino de Contrato'',''JU'',''Judicial'',
                                ''JB'',''Jubilacion'',''TM'',''Termino de Zafra'',''PM'', ''Por Muerte'', ''PP'',''Periodo de Prueba'')TIPO_DESV,
                         (SELECT FAC.FACDES_DESC FROM PER_FACTOR_DESVINCULACION FAC WHERE FAC.FACDES_EMPR = '||P_EMPRESA||' AND FAC.FACDES_CLAVE = DESV.TIPDESV_FACTOR)FACTOR_DESCV,
                         (SELECT MOT.MOTDESV_DESC FROM PER_MOTIVO_DESVINCULACION MOT WHERE MOT.MOTDESV_EMPR ='||P_EMPRESA||' AND MOT.MOTDESV_CLAVE = DESV.TIPDESV_MOTIVO)MOTIVO_DESCV,
                         DESV.TIPDESV_DESC,
                         EM.EMPL_MOTIVO_SALIDA Motivo,
                         DECODE(EM.EMPL_TIPO_CONT,''I'',''TIEMPO INDEFINIDO'',''T'',''TEMPORAL'') TIPO_CONTRATO,
                         TO_CHAR(EMPL_FEC_SALIDA, ''MM/YYYY'') HH,
                         TO_CHAR(EMPL_FEC_SALIDA, ''IW/YYYY'') HHS,
                         TO_NUMBER(TO_CHAR(EMPL_FEC_SALIDA, ''IW'')) HHSA,
                         CASE WHEN TO_CHAR(PDOC_FEC, ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'') THEN
                              PDDET_IMP
                              END IMPORTE,
                         CASE WHEN TO_CHAR(PDOC_FEC, ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'') THEN
                         PDDET_CLAVE_CONCEPTO
                        END CONCEPTO,
                         2 VALOR,
                         EMPL_TIPO_CONT
                    FROM PER_EMPLEADO_HIST EM,
                         PER_TIPO_DESVINCULACION DESV,
                         PER_DOCUMENTO A,
                         PER_DOCUMENTO_DET B,
                         PER_CONCEPTO
                   WHERE (EMPL_SITUACION = ''I'' or empl_legajo = 103999)
                     AND EMPL_EMPRESA = '||P_EMPRESA||'
                     AND EMPL_EMPRESA =  DESV.TIPDESV_EMPR (+)
                     AND EMPL_MOT_DESV = DESV.TIPDESV_MOTIVO (+)
                     AND EMPL_FAC_DESV = DESV.TIPDESV_FACTOR (+)
                     AND EMPL_TIPO_DESV = DESV.TIPDESV_TIP_DESV (+)
                     AND EMPL_LEGAJO =  A.PDOC_EMPLEADO(+)
                     AND PDOC_FEC >= EMPL_FEC_SALIDA
                     AND EMPL_EMPRESA = PDOC_EMPR(+)
                     AND PDOC_CLAVE = PDDET_CLAVE_DOC(+)
                     AND PDOC_EMPR = PDDET_EMPR(+)
                     AND PDDET_CLAVE_CONCEPTO = PCON_CLAVE
                     AND PDDET_EMPR = PCON_EMPR
                     AND PCON_IND_DBCR=''C''
                     AND PCON_FIN_TMOV <> 31
                     --AND EMPL_TIPO_DESV= ''DI''
                    -- AND B.PDDET_CLAVE_CONCEPTO(+) IN (25, 23,27)
                     AND TO_CHAR(EMPL_FEC_SALIDA , ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'')
                     AND TO_CHAR(PDOC_FEC(+), ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'')
                     AND MES|| ''/'' || ANHO =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'')
                     UNION ALL
                     SELECT EMPL_LEGAJO,
                         EMPL_NOMBRE||'' ''||EMPL_APE,
                         EMPL_FEC_INGRESO,
                         EMPL_FEC_SALIDA,
                         EMPL_SUCURSAL,
                         EMPL_DEPARTAMENTO,
                         EMPL_CARGO CARGO,
                         DECODE(empl_tipo_desv,''DJ'',''Despido Justificado'',''DI'',''Despido Injustificado'',''RV'',''Renuncia Voluntaria'',''TC'',''Termino de Contrato'',''JU'',''Judicial'',
                                ''JB'',''Jubilacion'',''TM'',''Termino de Zafra'',''PM'', ''Por Muerte'', ''PP'',''Periodo de Prueba'')TIPO_DESV,
                        (SELECT FAC.FACDES_DESC FROM PER_FACTOR_DESVINCULACION FAC WHERE FAC.FACDES_EMPR = '||P_EMPRESA||' AND FAC.FACDES_CLAVE = DESV.TIPDESV_FACTOR)FACTOR_DESCV,
                         (SELECT MOT.MOTDESV_DESC FROM PER_MOTIVO_DESVINCULACION MOT WHERE MOT.MOTDESV_EMPR = '||P_EMPRESA||' AND MOT.MOTDESV_CLAVE = DESV.TIPDESV_MOTIVO)MOTIVO_DESCV,
                         DESV.TIPDESV_DESC,
                         EM.EMPL_MOTIVO_SALIDA Motivo,
                         DECODE(EM.EMPL_TIPO_CONT,''I'',''TIEMPO INDEFINIDO'',''T'',''TEMPORAL'') TIPO_CONTRATO,
                         TO_CHAR(EMPL_FEC_SALIDA, ''MM/YYYY'') HH,
                         TO_CHAR(EMPL_FEC_SALIDA, ''IW/YYYY'') HHS,
                         TO_NUMBER(TO_CHAR(EMPL_FEC_SALIDA, ''IW'')) HHSA,
                          CASE WHEN TO_CHAR(PDOC_FEC, ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2),''MM/YYYY'') THEN
                              PDDET_IMP
                              END IMPORTE,
                         CASE WHEN TO_CHAR(PDOC_FEC, ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2),''MM/YYYY'') THEN
                         PDDET_CLAVE_CONCEPTO
                        END CONCEPTO,
                         1 VALOR,
                         EMPL_TIPO_CONT
                    FROM PER_EMPLEADO_HIST EM,
                         PER_TIPO_DESVINCULACION DESV,
                         PER_DOCUMENTO A,
                         PER_DOCUMENTO_DET B,
                         PER_CONCEPTO
                   WHERE EMPL_SITUACION = ''I''
                     AND EMPL_EMPRESA = '||P_EMPRESA||'
                     AND EMPL_EMPRESA =  DESV.TIPDESV_EMPR (+)
                     AND EMPL_MOT_DESV = DESV.TIPDESV_MOTIVO (+)
                     AND EMPL_FAC_DESV = DESV.TIPDESV_FACTOR (+)
                     AND EMPL_TIPO_DESV = DESV.TIPDESV_TIP_DESV (+)
                     AND EMPL_LEGAJO =  A.PDOC_EMPLEADO(+)
                     AND EMPL_EMPRESA = PDOC_EMPR(+)
                     AND PDOC_CLAVE = PDDET_CLAVE_DOC(+)
                     AND PDOC_FEC >= EMPL_FEC_SALIDA
                     AND PDDET_CLAVE_CONCEPTO = PCON_CLAVE
                     AND PDDET_EMPR = PCON_EMPR
                     AND PCON_IND_DBCR=''C''
                     AND PCON_FIN_TMOV <> 31
                     AND PDOC_EMPR = PDDET_EMPR(+)
                     AND TO_CHAR(EMPL_FEC_SALIDA , ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2),''MM/YYYY'')
                     AND TO_CHAR(PDOC_FEC(+), ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2),''MM/YYYY'')
                     AND MES|| ''/'' || ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2),''MM/YYYY'')
                  ----------------------------------------------07/04/2021
                     UNION ALL
                     SELECT EMPL_LEGAJO,
                         EMPL_NOMBRE||'' ''||EMPL_APE,
                         EMPL_FEC_INGRESO,
                         EMPL_FEC_SALIDA,
                         EMPL_SUCURSAL,
                         EMPL_DEPARTAMENTO,
                         EMPL_CARGO CARGO,
                         DECODE(empl_tipo_desv,''DJ'',''Despido Justificado'',''DI'',''Despido Injustificado'',''RV'',''Renuncia Voluntaria'',''TC'',''Termino de Contrato'',''JU'',''Judicial'',
                                ''JB'',''Jubilacion'',''TM'',''Termino de Zafra'', ''PM'', ''Por Muerte'', ''PP'',''Periodo de Prueba'')TIPO_DESV,
                        (SELECT FAC.FACDES_DESC FROM PER_FACTOR_DESVINCULACION FAC WHERE FAC.FACDES_EMPR = '||P_EMPRESA||' AND FAC.FACDES_CLAVE = DESV.TIPDESV_FACTOR)FACTOR_DESCV,
                         (SELECT MOT.MOTDESV_DESC FROM PER_MOTIVO_DESVINCULACION MOT WHERE MOT.MOTDESV_EMPR = '||P_EMPRESA||' AND MOT.MOTDESV_CLAVE = DESV.TIPDESV_MOTIVO)MOTIVO_DESCV,
                         DESV.TIPDESV_DESC,
                         EM.EMPL_MOTIVO_SALIDA Motivo,
                         DECODE(EM.EMPL_TIPO_CONT,''I'',''TIEMPO INDEFINIDO'',''T'',''TEMPORAL'') TIPO_CONTRATO,
                         TO_CHAR(EMPL_FEC_SALIDA, ''MM/YYYY'') HH,
                         TO_CHAR(EMPL_FEC_SALIDA, ''IW/YYYY'') HHS,
                         TO_NUMBER(TO_CHAR(EMPL_FEC_SALIDA, ''IW'')) HHSA,
                          CASE WHEN TO_CHAR(PDOC_FEC, ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -12),''MM/YYYY'') THEN
                              PDDET_IMP
                              END IMPORTE,
                         CASE WHEN TO_CHAR(PDOC_FEC, ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -12),''MM/YYYY'') THEN
                         PDDET_CLAVE_CONCEPTO
                        END CONCEPTO,
                         4 VALOR,
                         EMPL_TIPO_CONT
                    FROM PER_EMPLEADO_HIST EM,
                         PER_TIPO_DESVINCULACION DESV,
                         PER_DOCUMENTO A,
                         PER_DOCUMENTO_DET B,
                         PER_CONCEPTO
                   WHERE EMPL_SITUACION = ''I''
                     AND EMPL_EMPRESA = '||P_EMPRESA||'
                     AND EMPL_EMPRESA =  DESV.TIPDESV_EMPR (+)
                     AND EMPL_MOT_DESV = DESV.TIPDESV_MOTIVO (+)
                     AND EMPL_FAC_DESV = DESV.TIPDESV_FACTOR (+)
                     AND EMPL_TIPO_DESV = DESV.TIPDESV_TIP_DESV (+)
                     AND EMPL_LEGAJO =  A.PDOC_EMPLEADO(+)
                     AND EMPL_EMPRESA = PDOC_EMPR(+)
                     AND PDOC_CLAVE = PDDET_CLAVE_DOC(+)
                     AND PDOC_EMPR = PDDET_EMPR(+)
                     AND PDOC_FEC >= EMPL_FEC_SALIDA
                     AND PDDET_CLAVE_CONCEPTO = PCON_CLAVE
                     AND PDDET_EMPR = PCON_EMPR
                     AND PCON_IND_DBCR=''C''
                     AND PCON_FIN_TMOV <> 31
                     AND TO_CHAR(EMPL_FEC_SALIDA , ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -12),''MM/YYYY'')
                     AND TO_CHAR(PDOC_FEC(+), ''MM/YYYY'') =  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -12),''MM/YYYY'')
                     AND MES|| ''/'' || ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -12),''MM/YYYY'')
                     ----------------------------------------------07/04/2021
                     )
                     GROUP BY EMPL_LEGAJO,NOMBRE,INGRESO, SALIDA, SUCURSAL, DEPARTAMENTO,
                          CARGO,TIPO_DESV,FACTOR_DESCV,MOTIVO_DESCV,TIPDESV_DESC,
                          Motivo,TIPO_CONTRATO,MES, IMPORTE, CONCEPTO, VALOR, EMPL_TIPO_CONT,
                 SEMANA_ANHO,SEMANA';

           IF P_EMPRESA = 1 THEN
              P_QUERY:=' SELECT
                        CASE WHEN C017 = 1 THEN  1 END CANT1,
                          TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') MES1,
                         CASE WHEN C017 = 2 THEN  1  END CANT2,
                         TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') MES3,
                         CASE WHEN C017 = 3 THEN  1  END CANT3,
                           TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') MES3,
                           C014 MES_SALIDA,
                           C008 TIPO_DESV,
                          COUNT (C008) OVER(PARTITION BY C014,C008) CANT_MOTV,
                           C018 EMPL_TIPO_CONT,
                          C020 SEMM,
                           COUNT (C008) OVER(PARTITION BY C020,C008) SEM_MOTV,
                           CASE WHEN C017 = 4 THEN  1 END CANT_pb
                          FROM APEX_collections
                         WHERE collection_name = ''DESVINC_SALARIO''
                         GROUP BY C017,C014,C008,C018,C020, C001
                         UNION ALL
                      SELECT
                      count(*), TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2),''MM/YYYY'') MES1,
                       COUNT(*),TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'') MES2,
                       COUNT(*), TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') MES3, NULL, TIPO_DESV, NULL,''I'', NULL,NULL,
                        count(*)pb
                        FROM CUBO_EMPLEADO_V_DESV
                       WHERE EMPL_EMPRESA = 1
                       AND TIPO_DESV = ''Judicial''
                       GROUP BY TIPO_DESV';
             END IF;

             IF P_EMPRESA = 2 THEN
                 P_QUERY:=' SELECT
                        CASE WHEN C017 = 1 THEN  1 END CANT1,
                          TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') MES1,
                         CASE WHEN C017 = 2 THEN  1  END CANT2,
                         TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') MES3,
                         CASE WHEN C017 = 3 THEN  1  END CANT3,
                           TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') MES3,
                           C014 MES_SALIDA,
                           C008 TIPO_DESV,
                          COUNT (C008) OVER(PARTITION BY C014,C008) CANT_MOTV,
                           C018 EMPL_TIPO_CONT,
                          C020 SEMM,
                           COUNT (C008) OVER(PARTITION BY C020,C008) SEM_MOTV,
                           CASE WHEN C017 = 4 THEN  1 END CANT_pb
                          FROM APEX_collections
                         WHERE collection_name = ''DESVINC_SALARIO''
                         GROUP BY C017,C014,C008,C018,C020, C001
                         UNION ALL
                      SELECT
                      count(*), TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2),''MM/YYYY'') MES1,
                       COUNT(*),TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'') MES2,
                       COUNT(*), TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') MES3, NULL, TIPO_DESV, NULL,''I'', NULL,NULL,
                        count(*)pb
                        FROM CUBO_EMPLEADO_V_DESV
                       WHERE EMPL_EMPRESA = 2
                       AND TIPO_DESV = ''Judicial''
                       GROUP BY TIPO_DESV';
             END IF;

 delete x
  where otro = 'DESVINCULACINES';
 delete x
 where otro = 'VACANCIA_1';

P_QUERY1:='SELECT
                        CASE WHEN C017 = 1 THEN  SUM(C015) ELSE 0 END CANT1,
                           TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') MES1,
                         CASE WHEN C017 = 2 THEN  SUM(C015) ELSE 0 END CANT2,
                           TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') MES2,
                         CASE WHEN C017 = 3 THEN  SUM(C015) ELSE 0 END CANT3,
                           TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') MES3,
                           CASE WHEN C017 = 4 THEN  SUM(C015) ELSE 0 END PB
                          FROM APEX_collections
                         WHERE collection_name = ''DESVINC_SALARIO''
                           --AND C016 IN(23,25)
                           AND C008 = ''Despido Injustificado''
                           and C018 <>''T''
                         GROUP BY C017,C015,C001';

     P_QUERY2 := 'SELECT TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')) SEMANA_1,
                           CASE
                             WHEN TO_CHAR(TO_DATE('''||P_FECHA||'''),''D'') = 6 THEN
                               ''S''
                             ELSE
                               ''N''
                             END DIA,
                           1 ORDEN,
                           CASE
                             WHEN TO_CHAR(TO_DATE('''||P_FECHA||'''),''D'') = 6 THEN
                               ''S''
                             ELSE
                               ''N''
                             END P_MES
                     FROM DUAL
                     UNION ALL
                     SELECT CASE
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-1) = 0 THEN
                               52
                               WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-1) = -1 THEN
                                51
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-1) = -1 THEN
                                50
                              ELSE
                                (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-1)
                               END SEMANA_1,
                            ''S'',
                            2 ORDEN,
                            ''S''
                     FROM DUAL
                     UNION ALL
                      SELECT CASE
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-2) = 0 THEN
                               52
                               WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-2) = -1 THEN
                                51
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-2) = -2 THEN
                                50
                              ELSE
                                (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-2)
                               END SEMANA_1,
                           ''S'',
                            3 ORDEN,
                            ''S''
                     FROM DUAL
                     UNION ALL
                      SELECT
                            CASE
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-3) = 0 THEN
                               52
                               WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-3) = -1 THEN
                                51
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-3) = -2 THEN
                                50
                              ELSE
                                (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-3)
                               END SEMANA_1,
                            CASE
                             WHEN TO_CHAR(TO_DATE('''||P_FECHA||'''),''D'') = 6 THEN
                               ''N''
                             ELSE
                               ''S''
                             END DIA,
                             4 ORDEN,
                             ''S''
                     FROM DUAL ';

          P_QUERY3 := 'SELECT
                        CASE WHEN C017 = 1 THEN  SUM(C015) ELSE 0 END CANT1,
                           TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') MES1,
                         CASE WHEN C017 = 2 THEN  SUM(C015)  ELSE 0 END CANT2,
                           TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') MES2,
                         CASE WHEN C017 = 3 THEN  SUM(C015) ELSE 0 END CANT3,
                           TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') MES3,
                           CASE WHEN C017 = 4 THEN  SUM(C015) ELSE 0 END PB
                          FROM APEX_collections
                         WHERE collection_name = ''DESVINC_SALARIO''
                           AND C016 IN(27)
                           and C018 <>''T''
                         GROUP BY C017,C015,C001';


         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DESVINC_SALARIO') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DESVINC_SALARIO');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DESVINC_SALARIO',
                                                         P_QUERY           => P_QUERY7);

          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DESVINCULACION_MES') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DESVINCULACION_MES');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DESVINCULACION_MES',
                                                         P_QUERY           => P_QUERY);


          IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DESVINCULACION_MONTO') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DESVINCULACION_MONTO');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DESVINCULACION_MONTO',
                                                         P_QUERY           => P_QUERY1);

           IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DESVINCULACION_GRAT') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DESVINCULACION_GRAT');
          END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DESVINCULACION_GRAT',
                                                         P_QUERY           => P_QUERY3);


       IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'GRAF_SEMANA') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'GRAF_SEMANA');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'GRAF_SEMANA',
                                                         P_QUERY           => P_QUERY2);


   END PP_PROCESO_DESVINCULACION;
PROCEDURE PP_PROCESO_INDICE_ROTACION (P_EMPRESA NUMBER,
                                        P_FECHA DATE) is
     P_QUERY VARCHAR2(21000);
     P_QUERY1 VARCHAR2(21000);
     P_QUERY2 VARCHAR2(21000);
     P_QUERY3 VARCHAR2(21000); ---para pb
     P_QUERY5 VARCHAR2(21000);
     P_QUERY13 VARCHAR2(21000);
     P_QUERY6 VARCHAR2(21000);

   V_MES3            VARCHAR2(60);
   V_MES2            VARCHAR2(60);
   V_MES1            VARCHAR2(60);
   V_SEMANA          VARCHAR2(60);
   V_FECHA1          DATE;
   V_FECHA2          DATE;
   V_MA_PASADO     VARCHAR2(60);
   FEC_PASADO      DATE;

     P_AND VARCHAR2(2000);

 BEGIN

  SELECT  TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY'),
         TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)),'DD/MM/YYYY'),
         TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)),'DD/MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM')||'/'||(TO_CHAR(TO_DATE(P_FECHA), 'YYYY')-1),
          TO_CHAR(TO_DATE(P_FECHA), 'DD/MM')||'/'||(TO_CHAR(TO_DATE(P_FECHA), 'YYYY')-1)
   INTO V_MES1, V_MES2, V_MES3,V_SEMANA,V_FECHA1, V_FECHA2, V_MA_PASADO,FEC_PASADO
  FROM DUAL;

 IF  P_FECHA = LAST_DAY(TO_DATE(P_FECHA))  THEN
    P_AND := P_AND||' semana is null and MES || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';

 ELSE
   P_AND := P_AND||' mes is null and SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
 END IF;

IF P_EMPRESA = 1 THEN
      P_QUERY :='SELECT DPTO_CODIGO||''-''||DPTO_DESC DEPARTAMENTO,
  TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2), ''MM/YYYY'') MES1,
               SUM(CASE
                     WHEN EMPL_SITUACION = ''A'' AND
                          EMPL_FEC_INGRESO <=
                          LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                      1
                     ELSE
                      0
                   END) + SUM(CASE
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <=
                                     LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) AND
                                     EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                                 1
                                ELSE
                                 0
                              END) MES1_VALOR,
               ----VALOR MES 2
               TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1), ''MM/YYYY'') MES2,
               SUM(CASE
                     WHEN EMPL_SITUACION = ''A'' AND
                          EMPL_FEC_INGRESO <=
                          LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                      1
                     ELSE
                      0
                   END) + SUM(CASE
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <=
                                     LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) AND
                                     EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                                 1
                                ELSE
                                 0
                              END) MES2_VALOR,
               -----VALOR MES 3
               TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') MES3,
               SUM(CASE
                     WHEN EMPL_SITUACION = ''A'' AND
                          EMPL_FEC_INGRESO <= '''||P_FECHA||''' THEN
                      1
                     ELSE
                      0
                   END) + SUM(CASE
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                     EMPL_FEC_SALIDA > '''||P_FECHA||''' THEN
                                 1
                                ELSE
                                 0
                              END) MES3_VALOR,
                       CASE WHEN DPTO_SUC = 2 THEN
                                ''CDA''
                            WHEN DPTO_CODIGO = 1 THEN
                                ''ADMINISTRATIVA''
                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN
                                ''COMERCIAL''
                            ELSE
                              ''INDUSTRIAL''
                            END DEPARTAMENTO_codigo
          FROM PER_EMPLEADO A, GEN_DEPARTAMENTO B
           WHERE  EMPL_DEPARTAMENTO = DPTO_CODIGO
             AND EMPL_EMPRESA = DPTO_EMPR
             AND EMPL_CODIGO_PROV is not null
             AND EMPL_TIPO_CONT = ''I''
             AND EMPL_FORMA_PAGO is not null
             AND EMPL_EMPRESA = '||P_EMPRESA||'
           GROUP BY  DPTO_CODIGO||''-''||DPTO_DESC,DPTO_SUC,DPTO_CODIGO';

     P_QUERY1:= 'SELECT CASE
                     WHEN TO_CHAR(B.EMPL_FEC_SALIDA, ''MM/YYYY'') =
                          TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'')  THEN
                      1
                   END CANT1,
                   TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -2), ''MM/YYYY'') MES1,
                   CASE
                     WHEN TO_CHAR(B.EMPL_FEC_SALIDA, ''MM/YYYY'') =
                          TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'')  THEN
                      1
                   END CANT2,
                   TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1), ''MM/YYYY'') MES2,
                   CASE
                     WHEN TO_CHAR(B.EMPL_FEC_SALIDA, ''MM/YYYY'') =
                          TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'')  THEN
                      1
                   END CANT3,
                   TO_CHAR(TO_DATE('''||P_FECHA||'''), ''MM/YYYY'') MES3,
                   TO_CHAR(B.EMPL_FEC_SALIDA, ''MM/YYYY'') MES_ANHO,
                   B.TIPO_DESV,
                   COUNT(B.TIPO_DESV) OVER(PARTITION BY TO_CHAR(B.EMPL_FEC_SALIDA, ''MM/YYYY''),(B.TIPO_DESV)) CANT_MOTV,
                   EMPL_TIPO_CONT,
                   A.EMPL_DEPARTAMENTO||''-''||DPTO_DESC,
                   DPTO_CODIGO,
                    CASE WHEN DPTO_SUC = 2 THEN
                                ''CDA''
                            WHEN DPTO_CODIGO = 1 THEN
                                ''ADMINISTRATIVA''
                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN
                                ''COMERCIAL''
                            ELSE
                              ''INDUSTRIAL''
                            END DEPARTAMENTO_codigo,
                   CASE
                      WHEN DPTO_CODIGO =1 THEN
                         1
                      WHEN DPTO_CODIGO IN(3,6) THEN
                         3
                      WHEN DPTO_CODIGO = 13 THEN
                         4
                      WHEN DPTO_CODIGO IN(27,28) THEN
                         5
                      WHEN DPTO_CODIGO = 21 THEN
                         6
                      WHEN DPTO_CODIGO = 4 THEN
                         7
                      WHEN DPTO_CODIGO = 5 THEN
                         8
                      WHEN DPTO_CODIGO IN(8,24)  THEN
                         9
                      WHEN DPTO_CODIGO  in(33,23) THEN
                        10
                      WHEN DPTO_CODIGO =7 THEN
                         11
                      WHEN DPTO_CODIGO IN (12,16,0) THEN
                        13
                       WHEN DPTO_CODIGO IN (9,10) THEN
                        14
                     WHEN DPTO_CODIGO = 11 THEN
                        15
                      WHEN DPTO_CODIGO = 31 THEN
                       16
                      WHEN DPTO_CODIGO =2 THEN
                        18
                     WHEN DPTO_CODIGO = 22 THEN
                        19
                       WHEN DPTO_CODIGO = 17 THEN
                        20
                     WHEN DPTO_CODIGO = 29 THEN
                        21
                     WHEN DPTO_CODIGO = 19 THEN
                        24
                    WHEN DPTO_CODIGO = 14 THEN
                        25
                    WHEN DPTO_CODIGO = 32 THEN
                        23
                    WHEN DPTO_CODIGO = 15 THEN
                      22
                    END COD_DEP
                  FROM CUBO_EMPLEADO_V_DESV B, PER_EMPLEADO A, GEN_DEPARTAMENTO
                 WHERE B.EMPL_LEGAJO(+) = A.EMPL_LEGAJO
                   AND B.EMPL_EMPRESA(+) = A.EMPL_EMPRESA
                   AND A.EMPL_DEPARTAMENTO(+) =DPTO_CODIGO
                   AND A.EMPL_EMPRESA(+) = DPTO_EMPR
                   AND EMPL_TIPO_CONT = ''I''
               AND B.EMPL_FEC_SALIDA(+) BETWEEN
                   ADD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''), -2) AND TO_DATE('''||P_FECHA||''')
               AND B.EMPL_EMPRESA(+) = 1
               AND DPTO_EMPR = 1'
                ;

  P_QUERY2:=  'SELECT DEPARTAMENTO,COD_DEP,DPTO_SUC,DESCRIPCION,COD_DEPATA2
    FROM (SELECT
                    CASE
                      WHEN DPTO_CODIGO =1 THEN
                         ''ADM''
                      WHEN DPTO_CODIGO IN(3,6) THEN
                         ''Molino 1''
                      WHEN DPTO_CODIGO = 13 THEN
                         ''Molino 2''
                      WHEN DPTO_CODIGO IN(27,28) THEN
                         ''Planta 3''
                      WHEN DPTO_CODIGO = 21 THEN
                         ''Fracionado''
                      WHEN DPTO_CODIGO = 4 THEN
                         ''Balanceados''
                      WHEN DPTO_CODIGO = 5 THEN
                         ''Fideria''
                      WHEN DPTO_CODIGO IN(8,24) THEN
                         ''Silos''
                      WHEN DPTO_CODIGO in(33,23) THEN
                         ''Laboratorio''
                      WHEN DPTO_CODIGO =7 THEN
                         ''Taller''
                      WHEN DPTO_CODIGO IN (12,16,0) THEN
                        ''Logistica''
                       WHEN DPTO_CODIGO IN (9,10) THEN
                        ''Comercial''
                      WHEN DPTO_CODIGO = 11 THEN
                        ''Adm''
                      WHEN DPTO_CODIGO = 31 THEN
                        ''Marketing''
                      WHEN DPTO_CODIGO =2 THEN
                        ''Comercial''
                     WHEN DPTO_CODIGO = 22 THEN
                        ''Logistica''
                       WHEN DPTO_CODIGO = 17 THEN
                        ''Loma Plata''
                     WHEN DPTO_CODIGO = 29 THEN
                        ''PJC''
                     WHEN DPTO_CODIGO = 19 THEN
                        ''Santa Rosa''
                    WHEN DPTO_CODIGO = 14 THEN
                        ''SAC''
                    WHEN DPTO_CODIGO = 32 THEN
                       ''Encarnacion''
                    WHEN DPTO_CODIGO = 15 THEN
                       ''Concepcion''
                    END DEPARTAMENTO,
                    CASE
                      WHEN DPTO_CODIGO =1 THEN
                         1
                      WHEN DPTO_CODIGO IN(3,6) THEN
                         3
                      WHEN DPTO_CODIGO = 13 THEN
                         4
                      WHEN DPTO_CODIGO IN(27,28) THEN
                         5
                      WHEN DPTO_CODIGO = 21 THEN
                         6
                      WHEN DPTO_CODIGO = 4 THEN
                         7
                      WHEN DPTO_CODIGO = 5 THEN
                         8
                      WHEN DPTO_CODIGO IN(8,24)  THEN
                         9
                      WHEN DPTO_CODIGO  in(33,23) THEN
                        10
                      WHEN DPTO_CODIGO =7 THEN
                         11
                      WHEN DPTO_CODIGO IN (12,16,0) THEN
                        13
                       WHEN DPTO_CODIGO IN (9,10) THEN
                        14
                     WHEN DPTO_CODIGO = 11 THEN
                        15
                      WHEN DPTO_CODIGO = 31 THEN
                       16
                      WHEN DPTO_CODIGO =2 THEN
                        18
                     WHEN DPTO_CODIGO = 22 THEN
                        19
                       WHEN DPTO_CODIGO = 17 THEN
                        20
                     WHEN DPTO_CODIGO = 29 THEN
                        21
                     WHEN DPTO_CODIGO = 19 THEN
                        24
                    WHEN DPTO_CODIGO = 14 THEN
                        25
                    WHEN DPTO_CODIGO = 32 THEN
                        23
                    WHEN DPTO_CODIGO = 15 THEN
                      22
                    END COD_DEP,
                    DPTO_CODIGO,
                    DPTO_SUC,
                    
                    CASE
                     WHEN DPTO_SUC = 2 THEN
                        ''CDA''
                    WHEN (DPTO_CODIGO IN(9,10,15) OR DPTO_SUC NOT IN (1,2)) THEN
                        ''COMERCIAL''
                   ELSE
                        ''INDUSTRIAL''
                    END DESCRIPCION,
                  CASE
                    WHEN DPTO_SUC = 2 THEN
                        12
                    WHEN (DPTO_CODIGO IN(9,10,15) OR DPTO_SUC NOT IN (1,2)) THEN
                        17
                   ELSE
                        2
                    END COD_DEPATA2
                    FROM GEN_DEPARTAMENTO A
                    WHERE A.DPTO_EMPR = 1
                    AND DPTO_CODIGO NOT IN (18,25,20,30,26))
                GROUP BY DEPARTAMENTO,COD_DEP,DPTO_SUC,DESCRIPCION,COD_DEPATA2';


   P_QUERY3 := 'SELECT CASE
       WHEN DEPARTAMENTO = ''1 - ADMINISTRATIVA'' THEN
         1
       WHEN DEPARTAMENTO = ''3 - COMERCIAL'' THEN
         17
         WHEN DEPARTAMENTO = ''4 - CDA'' THEN
           12
         WHEN DEPARTAMENTO = ''5 - INDUSTRIAL'' THEN
           2
       END CODIGO,
   ROUND((ANHO_TOT/nvl(PB,1))*100,1) des_dep,round((( total_des/nvl(TOTAL,1))*100),2) des_total
  FROM
 (SELECT DEPARTAMENTO,
           ''2017'' ANHO,
          ROUND((MES1+MES2+MES3+MES4+MES5+MES6+MES7+MES8+MES9+MES10+MES11+MES12)/12)PB,
          SUM(ROUND((MES1+MES2+MES3+MES4+MES5+MES6+MES7+MES8+MES9+MES10+MES11+MES12)/12)) OVER (ORDER BY 2) TOTAL

          FROM (SELECT CASE WHEN DPTO_SUC = 2 THEN
                                ''4 - CDA''
                            WHEN DPTO_CODIGO = 1 THEN
                               ''1 - ADMINISTRATIVA''
                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN
                               ''3 - COMERCIAL''
                            ELSE
                              ''5 - INDUSTRIAL''
                            END DEPARTAMENTO,
                 SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''31/01/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''31/01/2017'' AND
                                       EMPL_FEC_SALIDA > ''31/01/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES1,

                   ---
                      SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''28/02/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''28/02/2017'' AND
                                       EMPL_FEC_SALIDA > ''28/02/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES2,
                  ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''31/03/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''31/03/2017'' AND
                                       EMPL_FEC_SALIDA > ''31/03/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES3,
                  ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''30/04/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''30/04/2017'' AND
                                       EMPL_FEC_SALIDA > ''30/04/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES4,
                 ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''31/05/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''31/05/2017'' AND
                                       EMPL_FEC_SALIDA > ''31/05/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES5,
                  ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''30/06/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''30/06/2017'' AND
                                       EMPL_FEC_SALIDA > ''30/06/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES6,
                   ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''31/07/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''31/07/2017'' AND
                                       EMPL_FEC_SALIDA > ''31/07/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES7,
                         ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''31/08/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''31/08/2017'' AND
                                       EMPL_FEC_SALIDA > ''31/08/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES8,
                  ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''30/09/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''30/09/2017'' AND
                                       EMPL_FEC_SALIDA > ''30/09/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES9,
                   ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''31/10/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''31/10/2017'' AND
                                       EMPL_FEC_SALIDA > ''31/10/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES10,
                    ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''30/11/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''30/11/2017'' AND
                                       EMPL_FEC_SALIDA > ''30/11/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES11,
                                        ---
                   SUM(CASE
                       WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= ''31/12/2017'' THEN
                        1
                       ELSE
                        0
                     END) + SUM(CASE
                                  WHEN EMPL_SITUACION = ''I'' AND
                                       EMPL_FEC_INGRESO <= ''31/12/2017'' AND
                                       EMPL_FEC_SALIDA > ''31/12/2017'' THEN
                                   1
                                  ELSE
                                   0
                                END) MES12
            FROM PER_EMPLEADO_HIST A, GEN_DEPARTAMENTO B
           WHERE  EMPL_DEPARTAMENTO = DPTO_CODIGO
             AND EMPL_EMPRESA = DPTO_EMPR
             AND EMPL_CODIGO_PROV <> 0
             AND EMPL_TIPO_CONT = ''I''
             AND EMPL_FORMA_PAGO <> 0
             AND ANHO IS NULL
           GROUP BY CASE WHEN DPTO_SUC = 2 THEN
                                ''4 - CDA''
                            WHEN DPTO_CODIGO = 1 THEN
                                ''1 - ADMINISTRATIVA''
                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN
                                ''3 - COMERCIAL''
                            ELSE
                              ''5 - INDUSTRIAL''
                            END))A,
                 (SELECT ROUND((COUNT(empl_legajo) / 12)) ANHO_TOT, A.AREA, SUM(ROUND((COUNT(*) / 12))) over (order by 1) total_des
                    FROM CUBO_EMPLEADO_V_DESV A
                   WHERE EMPL_EMPRESA = 1
                     AND TO_CHAR(EMPL_FEC_SALIDA, ''YYYY'') = ''2017''
                   GROUP BY AREA) B
              WHERE DEPARTAMENTO = AREA';

P_QUERY5 :=' SELECT DEPARTAMENTO_CODIGO,
                    DEPARTAMENTO,
                    CANT_DESVIN,
                    CANT_DOTACION,
                  round((NVL(CANT_DESVIN,0)/DECODE(NVL(CANT_DOTACION,0),0,1,NVL(CANT_DOTACION,0)))*100,1)porcentaje,
                  DPTO_CODIGO
               FROM
               (SELECT SUM(CANT_DOTACION) CANT_DOTACION, DEPARTAMENTO_COD, EMPL_DEPARTAMENTO
               FROM (SELECT COUNT(EMPL_LEGAJO) CANT_DOTACION, EMPL_DEPARTAMENTO ,
               cASE WHEN EMPL_SUCURSAL = 2 THEN
                                              ''CDA''
                                          WHEN EMPL_DEPARTAMENTO = 1 THEN
                                              ''ADMINISTRATIVA''
                                          WHEN (EMPL_DEPARTAMENTO IN(14,22,2) OR EMPL_SUCURSAL NOT IN (1,2)) THEN
                                              ''COMERCIAL''
                                          ELSE
                                            ''INDUSTRIAL''
                                          END DEPARTAMENTO_COD
                  FROM PER_EMPLEADO E
                  WHERE EMPL_EMPRESA = 1
                  AND E.EMPL_CODIGO_PROV IS NOT NULL
                  AND EMPL_FEC_INGRESO <= ''01/01/''||to_char(TO_DATE('''||P_FECHA||'''), ''YYYY'')
                  AND EMPL_TIPO_CONT  = ''I''
                  and case when empl_situacion = ''I'' and  empl_fec_salida>= ''01/01/''||to_char(TO_DATE('''||P_FECHA||'''), ''YYYY'') then
                     1
                     when empl_situacion = ''A'' THEN
                     1 else 0 end = 1
                  GROUP BY  EMPL_SUCURSAL, EMPL_DEPARTAMENTO
                  UNION ALL
                  SELECT COUNT(T.EMPSOL_EMPL_LEG) CANT_DOTACION, T.EMPSOL_DEPART_COP ,
                  cASE WHEN EMPSOL_SUC_COP = 2 THEN
                                              ''CDA''
                                          WHEN EMPSOL_DEPART_COP = 1 THEN
                                              ''ADMINISTRATIVA''
                                          WHEN (EMPSOL_DEPART_COP IN(14,22,2) OR EMPSOL_SUC_COP NOT IN (1,2)) THEN
                                              ''COMERCIAL''
                                          ELSE
                                            ''INDUSTRIAL''
                                          END DEPARTAMENTO_COD
                  FROM PER_EMPL_SOL_CAMBIO_ESTADO T, PER_EMPLEADO E
                  where T.EMPSOL_EMPR = EMPL_EMPRESA
                    AND T.EMPSOL_EMPL_LEG = EMPL_LEGAJO
                    AND T.EMPSOL_EMPR = 1
                    AND T.EMPSOL_ESTADO_EMP_SOL = ''A''
                    AND T.EMPSOL_ESTADO_VERIF  = ''C''
                    AND TO_CHAR(T.EMPSOL_FECHA_ING_COP,''YYYY'') =to_char(TO_DATE('''||P_FECHA||'''), ''YYYY'')
                    AND EMPL_TIPO_CONT = ''I''
                    GROUP BY  T.EMPSOL_SUC_COP, T.EMPSOL_DEPART_COP
                    union all
                   SELECT count(EMPL_LEGAJO), T.EMPSOL_DEPART_COP ,
                               cASE WHEN EMPSOL_SUC_COP = 2 THEN
                                              ''CDA''
                                          WHEN EMPSOL_DEPART_COP = 1 THEN
                                              ''ADMINISTRATIVA''
                                          WHEN (EMPSOL_DEPART_COP IN(14,22,2) OR EMPSOL_SUC_COP NOT IN (1,2)) THEN
                                              ''COMERCIAL''
                                          ELSE
                                            ''INDUSTRIAL''
                                          END DEPARTAMENTO_COD
                  FROM PER_EMPL_SOL_CAMBIO_ESTADO T, PER_EMPLEADO E
                  where T.EMPSOL_EMPR = EMPL_EMPRESA
                    AND T.EMPSOL_EMPL_LEG = EMPL_LEGAJO
                    AND T.EMPSOL_EMPR = 1
                    AND T.EMPSOL_ESTADO_EMP_SOL = ''I''
                    AND T.EMPSOL_ESTADO_VERIF  = ''C''
                    AND EMPL_SITUACION = ''A''
                    AND TO_CHAR(T.EMPSOL_FECHA_SAL_COP,''YYYY'') =to_char(TO_DATE('''||P_FECHA||'''), ''YYYY'')
                    AND TO_CHAR(T.EMPSOL_FECHA_INC_PER,''YYYY'') <> to_char(TO_DATE('''||P_FECHA||'''), ''YYYY'')
                    AND EMPL_TIPO_CONT = ''I''
                    GROUP BY  T.EMPSOL_SUC_COP, T.EMPSOL_DEPART_COP
                    )
                    WHERE EMPL_DEPARTAMENTO IS NOT NULL
                    GROUP BY DEPARTAMENTO_COD, EMPL_DEPARTAMENTO  ) A,

               (SELECT COUNT(T.EMPSOL_EMPL_LEG) CANT_DESVIN, T.EMPSOL_DEPART_COP,
               cASE WHEN EMPSOL_SUC_COP = 2 THEN
                                              ''CDA''
                                          WHEN EMPSOL_DEPART_COP = 1 THEN
                                              ''ADMINISTRATIVA''
                                          WHEN (EMPSOL_DEPART_COP IN(14,22,2) OR EMPSOL_SUC_COP NOT IN (1,2)) THEN
                                              ''COMERCIAL''
                                          ELSE
                                            ''INDUSTRIAL''
                                          END DEPARTAMENTO_CODd
              FROM PER_EMPL_SOL_CAMBIO_ESTADO T, PER_EMPLEADO E
              where T.EMPSOL_EMPR = EMPL_EMPRESA
                AND T.EMPSOL_EMPL_LEG = EMPL_LEGAJO
                AND T.EMPSOL_EMPR = 1
                AND T.EMPSOL_ESTADO_EMP_SOL = ''I''
                AND T.EMPSOL_ESTADO_VERIF  = ''C''
                AND EMPL_TIPO_CONT = ''I''
                AND TO_CHAR(T.EMPSOL_FECHA_SAL_COP,''YYYY'') =to_char(TO_DATE('''||P_FECHA||'''), ''YYYY'')
                GROUP BY T.EMPSOL_SUC_COP, T.EMPSOL_DEPART_COP)B,
                    (SELECT DPTO_CODIGO||''-''||DPTO_DESC DEPARTAMENTO,   CASE WHEN DPTO_SUC = 2 THEN
                                              ''CDA''
                                          WHEN DPTO_CODIGO = 1 THEN
                                              ''ADMINISTRATIVA''
                                          WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN
                                              ''COMERCIAL''
                                          ELSE
                                            ''INDUSTRIAL''
                                          END DEPARTAMENTO_CODIGO, DPTO_CODIGO
              FROM GEN_DEPARTAMENTO A
              WHERE A.DPTO_EMPR = 1
              AND DPTO_CODIGO NOT IN (18,25,20,30,26)) C
              WHERE C.DPTO_CODIGO = A.EMPL_DEPARTAMENTO(+)
              AND C.DPTO_CODIGO = B.EMPSOL_DEPART_COP(+)';



P_QUERY6 := 'SELECT DPTO_CODIGO||''-''||DPTO_DESC DEPARTAMENTO,
       ''07/2020'',--'''||V_MA_PASADO||''' MES1,
              NVL( SUM(CASE
                     WHEN EMPL_SITUACION = ''A'' AND
                          EMPL_FEC_INGRESO <=''30/07/2020'' THEN--'''||FEC_PASADO||''' THEN
                      1
                     ELSE
                      0
                   END) + SUM(CASE
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <=''30/07/2020'' AND--'''||FEC_PASADO||''' AND
                                     EMPL_FEC_SALIDA >''30/07/2020'' THEN-- LAST_DAY(TO_DATE('''||FEC_PASADO||''')) THEN
                                 1
                                ELSE
                                 0
                              END),0) ACTIVO,
                  NVL(SUM(CASE
                   WHEN TO_CHAR(EMPL_FEC_SALIDA, ''MM/YYYY'') = ''07/2020'' THEN-- '''||V_MA_PASADO||'''  THEN
                      1
                   END),0) DESV,
                       CASE WHEN DPTO_SUC = 2 THEN
                                ''CDA''
                            WHEN DPTO_CODIGO = 1 THEN
                                ''ADMINISTRATIVA''
                            WHEN (DPTO_CODIGO IN(14,22,2) OR DPTO_SUC NOT IN (1,2)) THEN
                                ''COMERCIAL''
                            ELSE
                              ''INDUSTRIAL''
                            END DEPARTAMENTO_codigo,
                            DPTO_CODIGO
          FROM PER_EMPLEADO_HIST , GEN_DEPARTAMENTO
           WHERE  EMPL_DEPARTAMENTO = DPTO_CODIGO
             AND EMPL_EMPRESA = DPTO_EMPR
             AND EMPL_CODIGO_PROV is not null
             AND EMPL_TIPO_CONT = ''I''
             AND EMPL_FORMA_PAGO is not null
              AND MES||''/''||ANHO =''07/2020''--'''||V_MA_PASADO||'''
             AND EMPL_EMPRESA = 1
           GROUP BY  DPTO_CODIGO||''-''||DPTO_DESC,DPTO_SUC,DPTO_CODIGO';





       IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DOTACION_INDICE') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DOTACION_INDICE');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DOTACION_INDICE',
                                                         P_QUERY           => P_QUERY);

      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DESVIN_INDICE') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DESVIN_INDICE');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DESVIN_INDICE',
                                                         P_QUERY           => P_QUERY1);


       IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DEPARTAMENTO_INDICE') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DEPARTAMENTO_INDICE');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DEPARTAMENTO_INDICE',
                                                         P_QUERY           => P_QUERY2);

      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'PB_INDICE') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'PB_INDICE');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'PB_INDICE',
                                                         P_QUERY           => P_QUERY3);

  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DOT_ANHO') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DOT_ANHO');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DOT_ANHO',
                                                         P_QUERY           => P_QUERY5);

  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'INTER_ANUAL') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'INTER_ANUAL');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'INTER_ANUAL',
                                                         P_QUERY           => P_QUERY6);


    P_QUERY13 := 'SELECT T.EMPL_LEGAJO,
                         T.EMPL_NOMBRE,
                         T.EMPL_APE,
                         X.EMPSOL_SUC_COP,
                         G.SUC_DESC,
                         X.EMPSOL_DEPART_COP,
                         D.DPTO_DESC,
                         X.EMPSOL_CARGO_COP,
                         M.CARDPP_DESC,
                         DECODE(T.EMPL_TIPO_CONT,''I'',''INDEFINIDO'', ''T'',''TEMPORAL'') TIPO_CONTRATO,
                         T.EMPL_CONTRATADO_POR,
                         T.EMPL_FEC_INGRESO,
                         empsol_fecha_inc_per,
                         X.EMPSOL_FECHA_SAL_COP,
                         CASE WHEN  X.EMPSOL_FECHA_SAL_COP- EMPL_FEC_INGRESO <60 THEN
                            ''No paso el periodo de prueba''
                            ELSE
                            ''Paso el periodo de prueba''
                         END PASO_PERIODO,
                         (X.EMPSOL_FECHA_SAL_COP- empsol_fecha_inc_per) DIAS,
                          trunc(MONTHS_BETWEEN(X.EMPSOL_FECHA_SAL_COP,x.empsol_fecha_inc_per)) mes,
                         TO_CHAR(empsol_fecha_inc_per,''MM/YYYY''),
                         X.EMPSOL_MOT_DESV_COP,
                         X.EMPSOL_FECHA_SAL_COP,
                         PERM001.F_CALC_ANTIGUEDAD(empsol_fecha_inc_per,
                                                      EMPSOL_FECHA_SAL_COP,
                                                      ''I'') ANTIGUEDAD,

                        CASE WHEN X.EMPSOL_FECHA_SAL_COP- EMPL_FEC_INGRESO <= 30 THEN
                                   1
                             WHEN X.EMPSOL_FECHA_SAL_COP- EMPL_FEC_INGRESO BETWEEN  31 AND 59 THEN
                                   2
                             WHEN X.EMPSOL_FECHA_SAL_COP- EMPL_FEC_INGRESO BETWEEN 60 AND 89 THEN
                                   3
                             WHEN X.EMPSOL_FECHA_SAL_COP- EMPL_FEC_INGRESO = 90 THEN
                                   4
                            ELSE
                                   5
                         END MAS_MESES,

                         M.CARDPP_AREA,
                         F.AREDPP_DESC

                    FROM PER_EMPLEADO T,PER_EMPL_SOL_CAMBIO_ESTADO X, GEN_SUCURSAL G, GEN_DEPARTAMENTO D, PER_CARGO_DPP M, PER_AREA_DPP F
                   WHERE X.EMPSOL_FECHA_VERIF BETWEEN ''01/''||TO_CHAR((TO_DATE('''||P_FECHA||''')),''MM/YYYY'') AND  TO_DATE('''||P_FECHA||''')
                   AND EMPL_LEGAJO = X.EMPSOL_EMPL_LEG
                    AND EMPL_EMPRESA = X.EMPSOL_EMPR
                    AND X.EMPSOL_ESTADO_EMP_SOL = ''I''
                    AND X.EMPSOL_ESTADO_VERIF = ''C''
                    AND X.EMPSOL_SUC_COP = G.SUC_CODIGO
                    AND X.EMPSOL_EMPR = G.SUC_EMPR
                    AND X.EMPSOL_DEPART_COP= D.DPTO_CODIGO
                    AND X.EMPSOL_EMPR = D.DPTO_EMPR
                    AND X.EMPSOL_CARGO_COP = M.CARDPP_CLAVE
                    AND X.EMPSOL_EMPR = M.CARDPP_EMPR
                    AND M.CARDPP_AREA = F.AREDPP_CLAVE
                    AND M.CARDPP_EMPR = F.AREDPP_EMPR
                    AND EMPL_EMPRESA = 1';

        IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'IND_ROTACION') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'IND_ROTACION');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'IND_ROTACION',
                                                      P_QUERY           => P_QUERY13);

ELSE

P_QUERY1 :='SELECT 0 ORDEN,
                   NULL,
                   ''INDICE ROTACION'' DETALLE,
                   '''||V_MES1||''' MES1,
                   '''||V_MES2||'''  MES2,
                   '''||V_MES3||''' MES3,
                   ''A'' PINTAR
              FROM DUAL
            UNION ALL
            SELECT ORDEN,
                   NUEVAS_AREAS,
                   NUEVAS_DESC,
                   TO_CHAR(ROUND(((SUM(NVL(VAR_MES1, 0)) - SUM(NVL(MES_TOT1, 0))) /
                                 DECODE(SUM(NVL(MES_TOT1, 0)),
                                         0,
                                         1,
                                         SUM(NVL(MES_TOT1, 0)))) * 100,
                                 2)) MES1,
                   TO_CHAR(ROUND(((SUM(NVL(VAR_MES2, 0)) - SUM(NVL(MES_TOT2, 0))) /
                                 DECODE(SUM(NVL(MES_TOT1, 0)),
                                         0,
                                         1,
                                         SUM(NVL(MES_TOT2, 0)))) * 100,
                                 2)) MES2,
                   TO_CHAR(ROUND(((SUM(NVL(VAR_MES3, 0)) - SUM(NVL(MES_TOT3, 0))) /
                                 DECODE(SUM(NVL(MES_TOT3, 0)),
                                         0,
                                         1,
                                         SUM(NVL(MES_TOT3, 0)))) * 100,
                                 2)) MES3,
                   ''B'' PINTAR

            --, SUM(NVL(VAR_MES1,0)), SUM(NVL(MES_TOT1,0))
            /* SUM(MES_TOT2), SUM(VAR_MES2),
            SUM(MES_TOT3), SUM(VAR_MES3), ''A'' PINTAR*/

              FROM (SELECT CASE
                             WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                              1 ---ADMINISTACION
                             WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                              2 ---GRANOS
                             WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                              3 ---INSUMOS
                             WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                              4 ---UNIDADES
                             WHEN E.EMPL_AREA_ORGANI IN (1, 3, 5) THEN
                              5 ---TRANSPORTE
                             WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                              6 ---REPUESTO
                           END NUEVAS_AREAS,

                           CASE
                             WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                              ''ADMINISTACION''
                             WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                              ''GRANOS''
                             WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                              ''INSUMOS''
                             WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                              ''UNIDADES''
                             WHEN E.EMPL_AREA_ORGANI IN (1, 3, 5) THEN
                              ''TRANSPORTE''
                             WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                              ''REPUESTO''
                           END NUEVAS_DESC,
                           CASE
                             WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                              1 ---ADMINISTACION
                             WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                              3 ---GRANOS
                             WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                              5 ---INSUMOS
                             WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                              7 ---UNIDADES
                             WHEN E.EMPL_AREA_ORGANI IN (1, 3, 5) THEN
                              9 ---TRANSPORTE
                             WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                              11 ---REPUESTO
                           END ORDEN,

                           ----------------------------------*MES 1
                           CASE
                             WHEN MES || ''/'' || ANHO = '''||V_MES1||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA1||''')) THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA1||'''))  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||V_FECHA1||''')) THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT1,
                           CASE
                             WHEN MES || ''/'' || ANHO = '''||V_MES1||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA1||''' THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||V_FECHA1||''')) THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES1,

                           ----------------------------------*MES2
                           CASE
                             WHEN MES || ''/'' || ANHO = '''||V_MES2||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA2||''')) THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA2||'''))  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||V_FECHA2||'''))  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT2,
                           CASE
                             WHEN MES || ''/'' || ANHO = '''||V_MES2||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA2||''' THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA2||'''  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||V_FECHA2||'''))  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES2,

                           -------------------------------*MES 3
                           CASE
                             WHEN '||P_AND||' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||P_FECHA||'''))  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||P_FECHA||''')) AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||P_FECHA||''')) THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT3,
                           CASE
                             WHEN '||P_AND||' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||P_FECHA||''' THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||P_FECHA||''')) THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES3,

                           CASE
                             WHEN '||P_AND||' THEN
                              1
                             WHEN MES || ''/'' || ANHO = '''||V_MES1||''' THEN

                              1
                             WHEN MES || ''/''|| ANHO = '''||V_MES2||''' THEN
                              1

                           END ANHO,
                           EMPL_AREA_ORGANI
                      FROM PER_EMPLEADO_HIST E
                     WHERE EMPL_CODIGO_PROV <> 0
                       AND EMPL_TIPO_CONT = ''I''
                       AND EMPL_FORMA_PAGO <> 0
                       AND EMPL_EMPRESA = 2)
             WHERE ANHO = 1
               AND NUEVAS_AREAS IS NOT NULL
             GROUP BY NUEVAS_AREAS, ORDEN, NUEVAS_DESC
            UNION ALL

            SELECT ORDEN,
                   EMPL_DEPARTAMENTO,
                   DPTO_DESC,
                   TO_CHAR(ROUND(((SUM(NVL(VAR_MES1, 0)) - SUM(NVL(MES_TOT1, 0))) /
                                 DECODE(SUM(NVL(MES_TOT1, 0)),
                                         0,
                                         1,
                                         SUM(NVL(MES_TOT1, 0)))) * 100,
                                 2)) MES1,
                   TO_CHAR(ROUND(((SUM(NVL(VAR_MES2, 0)) - SUM(NVL(MES_TOT2, 0))) /
                                 DECODE(SUM(NVL(MES_TOT1, 0)),
                                         0,
                                         1,
                                         SUM(NVL(MES_TOT2, 0)))) * 100,
                                 2)) MES2,
                   TO_CHAR(ROUND(((SUM(NVL(VAR_MES3, 0)) - SUM(NVL(MES_TOT3, 0))) /
                                 DECODE(SUM(NVL(MES_TOT3, 0)),
                                         0,
                                         1,
                                         SUM(NVL(MES_TOT3, 0)))) * 100,
                                 2)) MES3,
                   ''C'' PINTAR

            --SUM(MES_TOT1), SUM(VAR_MES1),SUM(MES_TOT2), SUM(VAR_MES2),SUM(MES_TOT3), SUM(VAR_MES3),--, EMPL_AREA_ORGANI

              FROM (SELECT CASE
                             WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                              2 ---ADMINISTACION
                             WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                              4 ---GRANOS
                             WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                              6 ---INSUMOS
                             WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                              8 ---UNIDADES
                             WHEN E.EMPL_AREA_ORGANI IN (1, 3, 5) THEN
                              10 ---TRANSPORTE
                             WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                              12 ---REPUESTO
                           END ORDEN,
                           ----------------------------------*MES 1
                           CASE
                             WHEN MES || ''/'' || ANHO = '''||V_MES1||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA1||'''))  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA1||'''))  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||V_FECHA1||'''))  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT1,
                           CASE
                             WHEN MES || ''/'' || ANHO = '''||V_MES1||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||V_FECHA1||'''))  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES1,

                           ----------------------------------*MES2
                           CASE
                             WHEN MES || ''/'' || ANHO =  '''||V_MES2||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA2||'''))  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA2||'''))  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||V_FECHA2||'''))  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT2,
                           CASE
                             WHEN MES || ''/'' || ANHO =  '''||V_MES2||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA2||'''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA2||'''  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||V_FECHA2||'''))  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES2,

                           -------------------------------*MES 3
                           CASE
                             WHEN '||P_AND||' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||P_FECHA||'''))  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||P_FECHA||'''))  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||P_FECHA||'''))  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT3,
                           CASE
                             WHEN '||P_AND||' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||P_FECHA||'''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||P_FECHA||'''  AND
                                     EMPL_FEC_SALIDA > trunc(TO_DATE('''||P_FECHA||'''))  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES3,

                           CASE
                             WHEN '||P_AND||' THEN
                              1
                             WHEN MES || ''/'' || ANHO =  '''||V_MES1||''' THEN

                              1
                             WHEN MES || ''/'' || ANHO =  '''||V_MES2||''' THEN
                              1

                           END ANHO,
                           EMPL_DEPARTAMENTO,
                           DPTO_DESC

                      FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO

                     WHERE EMPL_DEPARTAMENTO = DPTO_CODIGO
                       AND EMPL_EMPRESA = DPTO_EMPR
                       AND EMPL_CODIGO_PROV <> 0
                       AND EMPL_TIPO_CONT = ''I''
                       AND EMPL_FORMA_PAGO <> 0

                       AND EMPL_EMPRESA = 2)
             WHERE ANHO = 1
               AND ORDEN IS NOT NULL
             GROUP BY EMPL_DEPARTAMENTO, DPTO_DESC, ORDEN
             ORDER BY 1, 7';

P_QUERY13 :='SELECT CASE
                             WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                              1 ---ADMINISTACION
                             WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                              2 ---GRANOS
                             WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                              3 ---INSUMOS
                             WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                              4 ---UNIDADES
                             WHEN E.EMPL_AREA_ORGANI IN (1, 3, 5) THEN
                              5 ---TRANSPORTE
                             WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                              6 ---REPUESTO
                           END NUEVAS_AREAS,

                           CASE
                             WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                              ''ADMINISTACION''
                             WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                              ''GRANOS''
                             WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                              ''INSUMOS''
                             WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                              ''UNIDADES''
                             WHEN E.EMPL_AREA_ORGANI IN (1, 3, 5) THEN
                              ''TRANSPORTE''
                             WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                              ''REPUESTO''
                           END NUEVAS_DESC,
                           CASE
                             WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                              1 ---ADMINISTACION
                             WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                              3 ---GRANOS
                             WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                              5 ---INSUMOS
                             WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                              7 ---UNIDADES
                             WHEN E.EMPL_AREA_ORGANI IN (1, 3, 5) THEN
                              9 ---TRANSPORTE
                             WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                              11 ---REPUESTO
                           END ORDEN,

                         CASE  WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                              2 ---ADMINISTACION
                             WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                              4 ---GRANOS
                             WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                              6 ---INSUMOS
                             WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                              8 ---UNIDADES
                             WHEN E.EMPL_AREA_ORGANI IN (1, 3, 5) THEN
                              10 ---TRANSPORTE
                             WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                              12 ---REPUESTO
                           END ORDEN2,
                           ----------------------------------*MES 1
                           CASE
                             WHEN MES || ''/'' || ANHO = '''||V_MES1||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA1||'''),''MM'')  THEN
                                 0
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA1||'''),''MM'')  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE('''||V_FECHA1||'''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT1,
                           CASE
                             WHEN MES || ''/'' || ANHO = '''||V_MES1||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE('''||V_FECHA1||'''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES1,

                           ----------------------------------*MES2
                           CASE
                             WHEN MES || ''/'' || ANHO =  '''||V_MES2||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA2||'''),''MM'')  THEN
                                 0
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||V_FECHA2||'''),''MM'')  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE('''||V_FECHA2||'''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT2,
                           CASE
                             WHEN MES || ''/'' || ANHO =  '''||V_MES2||''' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA2||'''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||V_FECHA2||'''  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE('''||V_FECHA2||'''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES2,

                           -------------------------------*MES 3
                           CASE
                             WHEN  '||P_AND||' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||P_FECHA||'''),''MM'')  THEN
                                0
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE('''||P_FECHA||'''),''MM'')  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE('''||P_FECHA||'''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT3,
                           CASE
                             WHEN  '||P_AND||' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= '''||P_FECHA||'''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= '''||P_FECHA||'''  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE('''||P_FECHA||'''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES3,

                           CASE
                             WHEN '||P_AND||' THEN
                                   3--- TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
                             WHEN MES || ''/'' || ANHO =  '''||V_MES1||''' THEN
                                    1--- '''||V_MES1||'''
                             WHEN MES || ''/'' || ANHO =  '''||V_MES2||''' THEN
                                    2--- '''||V_MES2||'''

                           END ANHO,

                           EMPL_DEPARTAMENTO,
                           DPTO_DESC,
                            '''||V_MES1||''' MES1,
                             '''||V_MES2||'''  MES2,
                             '''||V_MES3||''' MES3,
                           EMPL_NOMBRE,
                           EMPL_APE,
                           EMPL_SUCURSAL,
                           EMPL_DEPARTAMENTO
                           EMPL_FEC_INGRESO,
                           EMPL_FEC_SALIDA,
                           EMPL_SITUACION,
                           EMPL_LEGAJO
                      FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO

                     WHERE EMPL_DEPARTAMENTO = DPTO_CODIGO
                       AND EMPL_EMPRESA = DPTO_EMPR
                       AND EMPL_CODIGO_PROV <> 0
                       AND EMPL_TIPO_CONT = ''I''
                       AND EMPL_FORMA_PAGO <> 0
                         AND CASE
                             WHEN '||P_AND||' THEN
                              1
                             WHEN semana is null and MES || ''/'' || ANHO =  '''||V_MES1||''' THEN

                              1
                             WHEN semana is null and MES || ''/'' || ANHO =  '''||V_MES2||''' THEN
                              1 END = 1
                              AND EMPL_AREA_ORGANI IS NOT NULL
                       AND EMPL_EMPRESA = 2
                       ';


 delete x
   where OTRO = 'IND_ROTACION_TRANS' ;

 COMMIT;

   IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'IND_ROTACION_TRANS') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'IND_ROTACION_TRANS');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'IND_ROTACION_TRANS',
                                                      P_QUERY           => P_QUERY13);


END IF;

  END PP_PROCESO_INDICE_ROTACION;



  PROCEDURE PP_PROCESO_MARCACIONES (P_EMPRESA IN NUMBER, P_FECHA IN DATE) IS
  P_QUERY VARCHAR2(21000);
  P_QUERY1 VARCHAR2(21000);
  P_QUERY2 VARCHAR2(21000);
  P_MES1 VARCHAR2(20);
  P_IND_PUNT VARCHAR2(20);
  P_POR_PUN VARCHAR2(20);
  P_IND_AUSE VARCHAR2(20);
  P_POR_AUSE VARCHAR2(20);
  P_EXIST NUMBER;
  P_QUERY3 VARCHAR2(21000);
  P_QUERY4 VARCHAR2(21000);
  P_QUERY10 VARCHAR2(32000);
  P_QUERY1000 VARCHAR2(32000);

BEGIN

if P_EMPRESA = 1 then
  P_QUERY10 :='SELECT  FECHA_HOR,---1
                EMPL_LEGAJO,---2
                EMPLEADO,---3
                NULL,---4
                NULL,---5
                AREA_CLAVE,---6
                AREA,---7
                CARGO,---8
                NULL,---9
                SUCURSAL,---10
                DESC_SUCURSAL,--11
                NULL,---12
               to_char(MAX(ENTRADA),''dd/mm/yyyy HH24:MI:SS'') ,---13
                DEPARTAMENTO,---14
                EMPL_FORMA_PAGO,---15
                DEPARTAMENTO2,---16
                EMPL_SITUACION,---17
                CAR_CODIGO CAR_CODIGO,---18
                 to_char(FECHA_HOR,''D'') DIA,---19
                 CASE WHEN DETALLE = ''PRESENTE'' AND
                     (CASE WHEN  NRO_DIA = 6 AND EMPL_FORMA_PAGO = 2 AND ENTRADA_HOR >= ''08:00'' THEN
                       ''07:00''
                       ELSE
                      ENTRADA_HOR
                      END) >=  TO_CHAR(MAX(ENTRADA),''HH24:MI'') THEN
                      ''PUNTUAL''
               ELSE
                 ''IMPUNTUAL''
               END  PUNTUALIDAD,---20
               DETALLE AUSENTE,---21
                CASE WHEN  NRO_DIA = 6 AND EMPL_FORMA_PAGO = 2 AND ENTRADA_HOR >= ''07:00'' THEN
                   ''07:00''
                   ELSE
                  ENTRADA_HOR
               END ENTRADA_HOR,---22
                CASE WHEN  NRO_DIA = 6 AND EMPL_FORMA_PAGO = 2 THEN
                   ''12:00''
                   ELSE
                     SALIDA_HOR
                END SALIDA_HOR ,---23
                JSA_COD_AREA,---24
                JSA_DESC_AREA, ---25
               EMPL_FEC_INGRESO,---26
                to_char(FECHA_HOR,''iw'') semana,---27
                to_char(FECHA_HOR,''MM/YYYY'') semana---28
                               FROM (
                             SELECT FECHA_HOR,
                                    EMPL_LEGAJO,
                                    EMPLEADO,
                                    AREA,
                                    AREA_CLAVE,
                                    CARGO,
                                    SUCURSAL,
                                    DESC_SUCURSAL,
                                    DEPARTAMENTO,
                                    COD_DPTO,
                                    EMPL_FORMA_PAGO,
                                    DEPARTAMENTO2,
                                    EMPL_SITUACION,
                                    SITUACION,
                                    ALMUERZO,
                                    JSA_COD_AREA,
                                    JSA_DESC_AREA,
                                    EMPL_EMPRESA,
                                    OPCION,
                                    CASE
                                       WHEN OPCION = ''D'' THEN ''DOMINGO''
                                       WHEN OPCION = ''H'' THEN ''SABADO''
                                       WHEN OPCION = ''X'' THEN ''FICHA INACTIVA''
                                       WHEN OPCION = ''F'' THEN ''FERIADO''
                                       WHEN OPCION = ''V'' THEN ''VAC. R .LEG''
                                       WHEN OPCION = ''T'' THEN ''VAC. R. INT''
                                       WHEN OPCION = ''L'' THEN ''LICENCIA''
                                       WHEN OPCION = ''R'' THEN ''REPOSO''
                                       WHEN OPCION = ''P'' THEN ''PERMISO''
                                       WHEN OPCION = ''A'' THEN ''AUSENCIA JUST.''
                                       WHEN OPCION = ''G'' THEN ''VIAJE LABORAL''
                                       WHEN OPCION = ''U'' THEN ''SUSPENCION''
                                       WHEN OPCION = ''S'' AND EVENTO  IS NULL THEN
                                         ''AUSENTE''
                                         ELSE
                                          ''PRESENTE''
                                       END DETALLE,
                                   CASE   WHEN   EVENTO = ''E'' AND NRO_DIA = ''6'' AND EMPL_FORMA_PAGO = 2 AND HORA BETWEEN ''05:00'' AND ''11:00'' THEN
                                      HORA_RELOJ
                                     WHEN    EVENTO = ''E'' AND HORA BETWEEN COMP_ENTRADA_MENOS AND COMP_ENTRADA_MAS THEN
                                      HORA_RELOJ
                                    END ENTRADA,
                                    CASE WHEN   EVENTO = ''S'' AND HORA BETWEEN COMP_SALIDA_MENOS AND COMP_SALIDA_MAS THEN
                                      HORA_RELOJ
                                    END SALIDA,
                                    CASE WHEN   EVENTO = ''S'' AND HORA BETWEEN COMP_SAL_ALM_MENOS AND COMP_SAL_ALM_MAS THEN
                                      HORA_RELOJ
                                    END SALIDA_ALMUERZO,
                                    CASE WHEN   EVENTO = ''E'' AND HORA BETWEEN COMP_ENT_ALM_MENOS AND COMP_ENT_ALM_MAS THEN
                                      HORA_RELOJ
                                    END ENTRADA_ALMUERZO,


                                    ------***

                                    CASE  WHEN   EVENTO = ''E'' AND NRO_DIA = ''6'' AND EMPL_FORMA_PAGO = 2 AND HORA BETWEEN ''05:00'' AND ''11:00'' THEN
                                      HORA_RELOJ
                                    END ENTRADA_SAB,
                                    CASE WHEN   EVENTO = ''S'' AND NRO_DIA = ''6'' AND EMPL_FORMA_PAGO = 2  AND HORA BETWEEN ''09:00''  AND ''14:00'' THEN
                                      HORA_RELOJ
                                    END SALIDA_SAB,
                                    ---------***
                                   HORA_RELOJ,
                                   COMP_SALIDA_MAS,
                                   COMP_SALIDA_MENOS,
                                   EVENTO,
                                   ENTRADA_HOR,
                                   SALIDA_HOR,
                                   SALIDA_ALM,
                                   ENTR_ALM,
                                   NRO_DIA,
                                   CAR_CODIGO,
                                   EMPL_FEC_INGRESO
                              FROM
                                    (SELECT DIAS.FECHA FECHA_HOR,
                                           P.EMPL_LEGAJO,
                                           P.EMPL_LEGAJO || '' - '' || P.EMPL_NOMBRE || '' '' || P.EMPL_APE EMPLEADO,
                                          -------------------------------horario comparativo
                                            CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA THEN
                                              TO_CHAR((TUR.TUREMP_ENT- 3/24), ''HH24:MI:SS'')
                                           END COMP_ENTRADA_MENOS,
                                           CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA THEN
                                              TO_CHAR((TUR.TUREMP_ENT+ 4/24), ''HH24:MI:SS'')
                                           END COMP_ENTRADA_MAS,
                                           CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA THEN
                                             TO_CHAR(TUR.TUREMP_SAL-3/24,''HH24:MI:SS'')
                                           END COMP_SALIDA_MENOS,
                                            CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA THEN
                                              CASE WHEN TO_CHAR(TUREMP_SAL, ''HH24:MI'') BETWEEN ''17:00'' AND ''23:00'' THEN
                                                   ''23:59''
                                                 ELSE
                                                TO_CHAR(TUR.TUREMP_SAL +6/24, ''HH24:MI:SS'')
                                                END
                                           END COMP_SALIDA_MAS,
                                           CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA AND
                                                  P.EMPL_MARC_ALMUERZO = ''S'' THEN
                                              TO_CHAR(TUREMP_SAL_ALMUERZO- 3/24, ''HH24:MI:SS'')
                                           END COMP_SAL_ALM_MENOS,
                                            CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA AND
                                                  P.EMPL_MARC_ALMUERZO = ''S'' THEN
                                              TO_CHAR(TUREMP_ent_ALMUERZO+ 3/24, ''HH24:MI:SS'')
                                           END COMP_SAL_ALM_MAS,
                                           CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA AND
                                                  P.EMPL_MARC_ALMUERZO = ''S'' THEN
                                              TO_CHAR(TUREMP_ENT_ALMUERZO-2/24, ''HH24:MI:SS'')
                                           END COMP_ENT_ALM_MENOS,
                                            CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA AND
                                                  P.EMPL_MARC_ALMUERZO = ''S'' THEN
                                              TO_CHAR(TUREMP_ENT_ALMUERZO+2/24, ''HH24:MI:SS'')
                                           END COMP_ENT_ALM_MAS,
                                        -------------------------------------------------------------HORARIO NORMAL

                                          CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA THEN
                                              TO_CHAR((TUR.TUREMP_ENT), ''HH24:MI'')
                                           END ENTRADA_HOR,
                                           CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA THEN
                                              TO_CHAR(TUR.TUREMP_SAL, ''HH24:MI'')
                                           END SALIDA_HOR,
                                           CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA AND
                                                  P.EMPL_MARC_ALMUERZO = ''S'' THEN
                                              TO_CHAR(TUREMP_SAL_ALMUERZO, ''HH24:MI'')
                                           END SALIDA_ALM,
                                           CASE
                                             WHEN DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA AND
                                                  P.EMPL_MARC_ALMUERZO = ''S'' THEN
                                              TO_CHAR(TUREMP_ENT_ALMUERZO, ''HH24:MI'')
                                           END ENTR_ALM,
                                           P.EMPL_FEC_INGRESO,
                                           P.EMPL_FEC_SALIDA,
                                           AREA.AREDPP_CLAVE || '' - '' || AREA.AREDPP_DESC AREA,
                                           AREDPP_CLAVE AREA_CLAVE,
                                           CAR.CAR_CODIGO || '' - '' || CAR.CAR_DESC CARGO,
                                           NIV.NIVORG_DESC NIVEL,
                                           P.EMPL_SUCURSAL SUCURSAL,
                                           SUC_CODIGO || '' - '' || SUC_DESC DESC_SUCURSAL,
                                           DEP.DPTO_DESC DEPARTAMENTO,
                                           DEP.DPTO_CODIGO COD_DPTO,
                                           EMPL_FORMA_PAGO,
                                           CASE
                                             WHEN DPTO_SUC = 2 THEN
                                              ''CDA''
                                             WHEN DPTO_CODIGO = 1 THEN
                                              ''ADMINISTRATIVO''
                                             WHEN (DPTO_CODIGO IN (14, 2) OR DPTO_SUC NOT IN (1, 2)) THEN
                                              ''COMERCIAL''
                                             WHEN DPTO_CODIGO = 22 THEN
                                              ''LOGISTICA''
                                             ELSE
                                              ''INDUSTRIAL''
                                           END DEPARTAMENTO2,
                                           EMPL_SITUACION,
                                           DECODE(EMPL_SITUACION, ''I'', ''INACTIVO'', ''A'', ''ACTIVO'', NULL) SITUACION,
                                           NVL(EMPL_MARC_ALMUERZO, ''N'') ALMUERZO,

                                           CASE
                                                 WHEN AREDPP_CLAVE = 1 THEN
                                                  2
                                                 WHEN AREDPP_CLAVE IN (2,6) THEN
                                                 10
                                                 WHEN AREDPP_CLAVE = 5 THEN
                                                  5
                                                 WHEN AREDPP_CLAVE = 4 THEN
                                                 3
                                                 WHEN AREDPP_CLAVE = 3 THEN
                                                  4
                                                  WHEN AREDPP_CLAVE = 8 THEN
                                                  8
                                                   WHEN AREDPP_CLAVE = 9 THEN
                                                 9
                                                END JSA_COD_AREA,
                                                CASE
                                                 WHEN AREDPP_CLAVE = 1 THEN
                                                  ''ADM''
                                                 WHEN AREDPP_CLAVE IN (2,6)   THEN
                                                  ''GERENCIA GENERAL''
                                                 WHEN AREDPP_CLAVE = 5 THEN
                                                  ''INDUSTRIAL''
                                                 WHEN AREDPP_CLAVE = 4  THEN
                                                  ''CDA''
                                                 WHEN AREDPP_CLAVE = 3  THEN
                                                 ''COMERCIAL''
                                                  WHEN AREDPP_CLAVE = 8  THEN
                                                 ''CAPITAL HUMANO''
                                                   WHEN AREDPP_CLAVE = 9  THEN
                                                 ''GERENCIA IT''
                                               END JSA_DESC_AREA,
                                           EMPL_EMPRESA,
                                           TO_CHAR(DIAS.FECHA,''D'') NRO_DIA,
                                           PER_VER_DIA_LABORAL(P.EMPL_LEGAJO,
                                                               1,
                                                               DIAS.FECHA,
                                                               P.EMPL_FEC_INGRESO,
                                                               P.EMPL_FEC_SALIDA,
                                                               DECODE(EMPL_FORMA_PAGO, 1, ''J'', 2, ''M'')) OPCION,
                                           CAR_CODIGO

                                      FROM PER_EMPLEADO P,
                                           (SELECT I_DIA FECHA
                                              FROM TABLE(RETURN_TABLE_DIA_PROF(TO_NUMBER(TO_CHAR(SYSDATE, ''YYYY''))))) DIAS,
                                           PER_AREA_DPP AREA,
                                           PER_CARGO_DPP CARDPP,
                                           PER_CARGO CAR,
                                           PER_NIVEL_ORGANI NIV,
                                           GEN_DEPARTAMENTO DEP,
                                           GEN_SUCURSAL SUC,
                                           PER_TURNOS_EMPL TUR
                                     WHERE P.EMPL_EMPRESA = 1
                                       AND P.EMPL_EMPRESA = DEP.DPTO_EMPR(+)
                                       AND P.EMPL_DEPARTAMENTO = DEP.DPTO_CODIGO(+)
                                       AND P.EMPL_SUCURSAL = DEP.DPTO_SUC(+)
                                       AND P.EMPL_SUCURSAL = SUC_CODIGO(+)
                                       AND P.EMPL_EMPRESA = SUC_EMPR(+)
                                       AND EMPL_FEC_INGRESO IS NOT NULL
                                       AND EMPL_CODIGO_PROV <> 0
                                       AND EMPL_FORMA_PAGO <> 0
                                       AND EMPL_SITUACION IS NOT NULL
                                       AND P.EMPL_CONS_MARC = ''S''
                                       AND TUR.TUREMP_EMPR = EMPL_EMPRESA
                                       AND TUR.TUREMP_EMPLEADO = EMPL_LEGAJO
                                       AND P.EMPL_SITUACION = ''A''
                                       AND DIAS.FECHA BETWEEN SYSDATE - 100 AND SYSDATE
                                       AND DIAS.FECHA BETWEEN TUR.TUREMP_DESDE AND TUR.TUREMP_HASTA
                                       AND P.EMPL_EMPRESA = AREA.AREDPP_EMPR(+)
                                       AND P.EMPL_AREA_ORGANI = AREA.AREDPP_CLAVE(+)
                                       AND P.EMPL_EMPRESA = CARDPP.CARDPP_EMPR(+)
                                       AND P.EMPL_CARGO = CARDPP.CARDPP_CLAVE(+)
                                       AND CARDPP.CARDPP_EMPR = CAR.CAR_EMPR(+)
                                       AND CARDPP.CARDPP_CLAVE = CAR.CAR_CODIGO(+)
                                       AND CARDPP.CARDPP_EMPR = NIV.NIVORG_EMPR(+)
                                       AND CARDPP.CARDPP_NIV_ORGANI = NIV.NIVORG_CLAVE(+)
                                       ) HOR,
                                    (SELECT T.MARC_FECHA,
                                            T.MARC_EVENTO EVENTO,
                                            T.MARC_EMPLEADO,
                                            T.MARC_EMPR,
                                            T.HORA_RELOJ,
                                            TO_CHAR(T.HORA_RELOJ, ''HH24:MI:SS'') HORA,
                                            CASE
                                              WHEN  MARC_EVENTO = ''S'' AND  to_date(to_char(HORA_RELOJ, ''hh24:mi:ss''), ''hh24:mi:ss'') between to_date(''00:00:00'', ''hh24:mi:ss'') and to_date(''01:00:00'', ''hh24:mi:ss'') THEN
                                                    MARC_FECHA-1
                                              WHEN  MARC_EVENTO = ''E'' AND  to_date(to_char(HORA_RELOJ, ''hh24:mi:ss''), ''hh24:mi:ss'') between to_date(''00:00:00'', ''hh24:mi:ss'') and to_date(''01:00:00'', ''hh24:mi:ss'') THEN
                                                  MARC_FECHA+1
                                              ELSE
                                                 MARC_FECHA
                                              END FECHA_HORARIO
                                  FROM PER_MARCACION_DIARIA_V T
                                 WHERE T.MARC_FECHA BETWEEN SYSDATE-100 AND SYSDATE
                                 ) MAR

                               WHERE HOR.EMPL_LEGAJO   = MAR.MARC_EMPLEADO (+)
                                 AND HOR.EMPL_EMPRESA  = MAR.MARC_EMPR (+)
                                 AND HOR.FECHA_HOR     = MARC_FECHA(+)
                                 AND EMPL_EMPRESA = 1
                                 AND OPCION =''S''
                                 AND EMPL_FORMA_PAGO =2
                                 AND HOR.FECHA_HOR BETWEEN aDD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''), -2) AND  TO_DATE('''||P_FECHA||''')
                                AND FECHA_HOR <> ''16/04/2022''
              )
                                 GROUP BY FECHA_HOR,
                                    EMPL_LEGAJO,
                                    EMPLEADO,
                                    AREA,
                                    AREA_CLAVE,
                                    CARGO,
                                    SUCURSAL,
                                    DESC_SUCURSAL,
                                    DEPARTAMENTO,
                                    COD_DPTO,
                                    EMPL_FORMA_PAGO,
                                    DEPARTAMENTO2,
                                    EMPL_SITUACION,
                                    SITUACION,
                                    ALMUERZO,
                                    JSA_COD_AREA,
                                    JSA_DESC_AREA,
                                    EMPL_EMPRESA,
                                    OPCION,
                                    DETALLE,
                                    ENTRADA_HOR,
                                    SALIDA_HOR,
                                    SALIDA_ALM,
                                    ENTR_ALM,
                                    NRO_DIA,
                                    CAR_CODIGO,
                                    EMPL_FEC_INGRESO
                                    ORDER BY FECHA_HOR,EMPL_LEGAJO';
else

           P_QUERY10:= ' SELECT FECHA,--1
                                EMPL_LEGAJO,--2
                                EMPLEADO, --3
                                CLAV_AREA,--4
                                AREA, --5
                                CARGO,--6
                                NIVEL, --7
                                SUCURSAL,--8
                                DPTO_CODIGO, --9
                                DEPARTAMENTO,--10
                                MARC_FECHA,--11
                                MARC_EMPLEADO,--12
                                to_char( ENTRADA, ''DD/MM/YYYY HH24:MI:SS''), --13
                                to_char(SALIDA, ''HH24:MI:SS''),--14
                                MARCADOR_ENTRADA,--15
                                MARCADOR_SALIDA, --16
                                CUMPLE, --17
                                ESTADO_DIAS,  --18
                          TO_CHAR(FECHA,''D'') DIA,--19
                         CASE----------PUNTUALIDAD
                          WHEN TO_CHAR(  ENTRADA, ''HH24:MI'') <= HORA_ENT   AND ESTADO_DIAS = ''S'' THEN ''PUNTUAL''
                           WHEN TO_CHAR(  ENTRADA, ''HH24:MI'')  > HORA_ENT   AND ESTADO_DIAS = ''S'' THEN ''IMPUNTUAL''
                          END PUNTUALIDAD,                                   --20
                         CASE
                               WHEN (ENTRADA IS NULL AND SALIDA IS NULL AND ESTADO_DIAS = ''S'') or ESTADO_DIAS = ''W'' THEN ''AUSENTE''
                               WHEN ENTRADA IS NULL AND ESTADO_DIAS = ''P'' THEN ''PERMISO''
                               WHEN ENTRADA IS NULL AND ESTADO_DIAS = ''R'' THEN ''REPOSO''
                               WHEN ENTRADA IS NULL AND ESTADO_DIAS = ''V'' THEN ''VACACION''
                               WHEN ENTRADA IS NULL AND ESTADO_DIAS = ''L'' THEN ''LICENCIA''
                               WHEN ENTRADA IS NULL AND ESTADO_DIAS = ''T'' THEN ''VIAJE''
                               WHEN (ENTRADA IS NOT NULL OR SALIDA IS NOT NULL) AND ESTADO_DIAS = ''S'' THEN ''PRESENTE''
                              END AUSENTE,                                    --21
                         HORA_ENT,                                 --22
                         SUC_DESC,                  --23
                         AREA1, ---24
                         AREA_Des1,  --25 ,
                         FECHA_INGRESO,--26
                         TO_CHAR(FECHA,''IW''), --27
                          TO_CHAR(FECHA,''MM/YYYY'') --28
                      FROM(
                      SELECT DIAS_HABILES."FECHA",
                             DIAS_HABILES."EMPL_LEGAJO",
                             DIAS_HABILES."EMPLEADO",
                             DIAS_HABILES."AREA",
                             DIAS_HABILES."CARGO",
                             DIAS_HABILES."NIVEL",
                             DIAS_HABILES."SUCURSAL",
                             DIAS_HABILES."DEPARTAMENTO",
                             MARCADOS."MARC_FECHA",
                             MARCADOS."MARC_EMPLEADO",
                             MARCADOS."ENTRADA",
                             MARCADOS."SALIDA",
                             MARCADOS."ENTRADA_MENS",
                             MARCADOS."SALIDA_MENS",
                             MARCADOS."MARCADOR_ENTRADA",
                             MARCADOS."MARCADOR_SALIDA",

                             CASE
                               WHEN MARCADOS.MARCADOR_ENTRADA = ''S'' AND
                                    MARCADOS.MARCADOR_SALIDA = ''S'' THEN
                                ''S''
                               ELSE
                                ''N''
                             END CUMPLE,

                          CASE
                               WHEN ESTADO_DIAS= ''S'' THEN
                                     PER_VERIFICAR_VAC_RINTERNO(EMPL_LEGAJO,
                                                                '||P_EMPRESA||',
                                                                FECHA,
                                                                FECHA_INGRESO,
                                                                FECHA_SALIDA,
                                                                ''M'')
                              ELSE
                                ESTADO_DIAS
                              END ESTADO_DIAS,

                          FECHA_SALIDA,
                          FECHA_INGRESO,
                          CLAV_AREA,
                          DPTO_CODIGO,
                          EMPL_MARC_ENTRADA,
                          EMPL_MARC_SALIDA,
                          SUC_DESC,
                          AREA1,
                          AREA_Des1,
                            -------------------------------------------------------------HORARIOS DE ENTRADA
                            -----------------------------------------primeramene los baculeros
                         CASE
                            WHEN   to_char(EMPL_MARC_ENTRADA, ''HH24:MI'') IS NULL or cargo_codigo = 143  THEN
                              CASE
                         /*  WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''05:30'' ---bascula
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''11:30''
                            AND CARGO_CODIGO = 7  THEN
                                ''06:00''
                           WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''11:30''  ---bascula
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''15:30''
                            AND CARGO_CODIGO = 7  THEN
                                ''13:00''*/

                           WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''06:05''--- horario normal
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''07:30''  THEN---AND CARGO_CODIGO <> 7 THEN
                               ''07:00''
                           WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''05:30''---horario ratotativo 1
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''06:05''  THEN---AND CARGO_CODIGO <> 7 THEN
                               ''06:00''
                            WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''13:30''---horario ratotativo 2
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''14:30'' THEN--- AND CARGO_CODIGO <> 7 THEN
                               ''14:00''
                            WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''21:00''---horario ratotativo 3
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''22:50'' THEN---AND CARGO_CODIGO <> 7 THEN
                               ''22:00''
                           WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''05:30'' ---- Horario opcional 1
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''06:35''   THEN---AND CARGO_CODIGO <> 7 THEN
                             ''06:00''
                            WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''07:30'' ---- Horario opcional 2
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''08:35''   THEN---AND CARGO_CODIGO <> 7 THEN
                             ''08:00''
                           WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''08:30'' ---- Horario opcional 3
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''09:35''   THEN---AND CARGO_CODIGO <> 7 THEN
                             ''09:00''
                            WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''09:30'' ---- Horario opcional 4
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''10:35''   THEN---AND CARGO_CODIGO <> 7 THEN
                             ''10:00''
                            WHEN TO_CHAR(  MARCADOS."ENTRADA", ''HH24:MI'') >= ''11:30'' ---- Horario opcional 5
                            AND TO_CHAR(MARCADOS."ENTRADA", ''HH24:MI'') <= ''12:35''   THEN---AND CARGO_CODIGO <> 7 THEN
                             ''12:00''
                             END
                        ELSE
                           to_char(EMPL_MARC_ENTRADA, ''HH24:MI'')
                           END  HORA_ENT

                        FROM (SELECT DIAS.FECHA,
                                     P.EMPL_LEGAJO,
                                     P.EMPL_LEGAJO || '' - '' || P.EMPL_NOMBRE || '' '' || P.EMPL_APE EMPLEADO,
                                     AREA.AREDPP_CLAVE || '' - '' || AREA.AREDPP_DESC AREA,
                                     CAR.CAR_CODIGO || '' - '' || CAR.CAR_DESC CARGO,
                                     NIV.NIVORG_DESC NIVEL,
                                     P.EMPL_SUCURSAL SUCURSAL,
                                     DEP.DPTO_DESC DEPARTAMENTO,
                                      CAR.CAR_CODIGO cargo_codigo,
                                     CASE
                                      WHEN DPTO_SUC = 2 and '||P_EMPRESA||' = 1 THEN
                                           ''CDA''
                                      WHEN DPTO_CODIGO = 1 and '||P_EMPRESA||' = 1 THEN
                                           ''ADMINISTRATIVO''
                                      WHEN (DPTO_CODIGO IN(14,2) OR DPTO_SUC NOT IN (1,2))  and '||P_EMPRESA||' = 1 THEN
                                          ''COMERCIAL''
                                      WHEN DPTO_CODIGO = 22 and '||P_EMPRESA||' = 1 THEN
                                          ''LOGISTICA''
                                      when  '||P_EMPRESA||' = 1 then
                                         ''INDUSTRIAL''
                                      when  '||P_EMPRESA||' <> 1 then
                                        DEP.DPTO_DESC
                                      END DEPARTAMENTO2, --------LV

                                      PER_VERIFICAR_DIA_LABORAL(P.EMPL_LEGAJO,
                                                                    2,
                                                                     DIAS.FECHA,
                                                                     P.EMPL_FEC_INGRESO,
                                                                     P.EMPL_FEC_SALIDA,
                                                                     ''M'') ESTADO_DIAS,
                                     P.EMPL_FEC_SALIDA FECHA_SALIDA,
                                     P.EMPL_FEC_INGRESO FECHA_INGRESO,
                                     AREDPP_CLAVE CLAV_AREA,
                                     DEP.DPTO_CODIGO DPTO_CODIGO,
                                     EMPL_MARC_ENTRADA,
                                     EMPL_MARC_SALIDA,
                                     SUC_DESC,
                                   CASE
                                           WHEN AREDPP_CLAVE = 1 and '||P_EMPRESA||' = 1 THEN
                                            2
                                           WHEN AREDPP_CLAVE IN (2,6) and '||P_EMPRESA||' = 1 THEN
                                           1
                                           WHEN AREDPP_CLAVE = 5 and '||P_EMPRESA||' = 1  THEN
                                            5
                                           WHEN AREDPP_CLAVE = 4 and '||P_EMPRESA||' = 1THEN
                                           3
                                           WHEN AREDPP_CLAVE = 3 and '||P_EMPRESA||' = 1 THEN
                                            4
                                          WHEN  EMPL_AREA_ORGANI =8 and '||P_EMPRESA||' = 1 THEN
                                            6
                                          when '||P_EMPRESA||' <> 1 then
                                            AREDPP_CLAVE
                                         END AREA1,
                                          CASE
                                           WHEN AREDPP_CLAVE = 1 and '||P_EMPRESA||' = 1 THEN
                                            ''ADM''
                                           WHEN AREDPP_CLAVE IN (2,6)  and '||P_EMPRESA||' = 1 THEN
                                            ''FIN E INFO''
                                           WHEN AREDPP_CLAVE = 5  and '||P_EMPRESA||' = 1 THEN
                                            ''INDUSTRIAL''
                                           WHEN AREDPP_CLAVE = 4 and '||P_EMPRESA||' = 1 THEN
                                            ''CDA''
                                           WHEN AREDPP_CLAVE = 3 and '||P_EMPRESA||' = 1 THEN
                                            ''COMERCIAL''
                                              WHEN  EMPL_AREA_ORGANI =8 and '||P_EMPRESA||' = 1 THEN
                                                   ''CAPITAL HUMANO''
                                            when '||P_EMPRESA||' <> 1 then
                                            AREDPP_DESC
                                         END AREA_Des1
                                FROM PER_CONFIGURACION PCON,
                                     PER_PERIODO PPER,
                                     (SELECT I_DIA FECHA
                                        FROM TABLE(RETURN_TABLE_DIA_PROF(TO_NUMBER(TO_CHAR(SYSDATE,
                                                                                           ''YYYY''))))) DIAS,
                                     PER_EMPLEADO P,
                                     PER_AREA_DPP AREA,
                                     PER_CARGO_DPP CARDPP,
                                     PER_CARGO CAR,
                                     PER_NIVEL_ORGANI NIV,
                                     GEN_DEPARTAMENTO DEP,
                                     GEN_SUCURSAL SUC
                               WHERE P.EMPL_EMPRESA = '||P_EMPRESA||'
                                 AND P.EMPL_EMPRESA = DEP.DPTO_EMPR(+)
                                 AND P.EMPL_DEPARTAMENTO = DEP.DPTO_CODIGO(+)
                                 AND P.EMPL_SUCURSAL = DEP.DPTO_SUC(+)
                                 AND P.EMPL_SUCURSAL = SUC.SUC_CODIGO(+)
                                 AND P.EMPL_EMPRESA = SUC.SUC_EMPR (+)
                                -- AND P.EMPL_FEC_INGRESO >= fecha1
                                 AND P.EMPL_FORMA_PAGO <> 1
                                 AND P.EMPL_SITUACION = ''A''
                                 and empl_legajo not in ( 167,546,596)
                                 AND P.EMPL_CONS_MARC = ''S''
                                 AND PCON.CONF_EMPR = P.EMPL_EMPRESA
                                 AND PCON.CONF_EMPR = PPER.PERI_EMPR
                                 AND (PCON.CONF_PERI_SGTE - 3) = PPER.PERI_CODIGO
                                 AND DIAS.FECHA BETWEEN PPER.PERI_FEC_INI AND SYSDATE
                                 AND P.EMPL_EMPRESA = AREA.AREDPP_EMPR(+)
                                 AND P.EMPL_AREA_ORGANI = AREA.AREDPP_CLAVE(+)
                                 AND P.EMPL_EMPRESA = CARDPP.CARDPP_EMPR(+)
                                 AND P.EMPL_CARGO = CARDPP.CARDPP_CLAVE(+)
                                 AND CARDPP.CARDPP_EMPR = CAR.CAR_EMPR(+)
                                 AND CARDPP.CARDPP_CLAVE = CAR.CAR_CODIGO(+)
                                 AND CARDPP.CARDPP_EMPR = NIV.NIVORG_EMPR(+)
                                 AND CARDPP.CARDPP_NIV_ORGANI = NIV.NIVORG_CLAVE(+)) DIAS_HABILES,

                             (SELECT CALC.*,
                                     CASE
                                       WHEN CALC.ENTRADA IS NOT NULL THEN
                                        CASE
                                          WHEN TO_DATE(''01/01/2018 '' ||
                                                       TO_CHAR(CALC.ENTRADA, ''HH24:MI:SS''),
                                                       ''DD/MM/YYYY HH24:MI:SS'') >=
                                               TO_DATE(''01/01/2018 '' ||
                                                       TO_CHAR(CALC.ENTRADA_MENS, ''HH24:MI:SS''),
                                                       ''DD/MM/YYYY HH24:MI:SS'') THEN
                                           ''N''
                                          ELSE
                                           ''S''
                                        END
                                       ELSE
                                        ''N''
                                     END MARCADOR_ENTRADA,
                                     CASE
                                       WHEN CALC.SALIDA IS NOT NULL THEN
                                        CASE
                                          WHEN TO_DATE(''01/01/2018 '' ||
                                                       TO_CHAR(CALC.SALIDA, ''HH24:MI:SS''),
                                                       ''DD/MM/YYYY HH24:MI:SS'') <=
                                               TO_DATE(''01/01/2018 '' ||
                                                       TO_CHAR(CALC.SALIDA_MENS, ''HH24:MI:SS''),
                                                       ''DD/MM/YYYY HH24:MI:SS'') THEN
                                           ''N''
                                          ELSE
                                           ''S''
                                        END
                                       ELSE
                                        ''N''
                                     END MARCADOR_SALIDA
                                FROM (SELECT CONS.MARC_FECHA,
                                             CONS.MARC_EVENTO,
                                             CONS.MARC_HORA,
                                             CONS.MARC_EMPLEADO,
                                             (SELECT MIN(EN.HORA_RELOJ)
                                                FROM PER_MARCACION_DIARIA_V EN
                                               WHERE EN.MARC_FECHA = CONS.MARC_FECHA
                                                 AND EN.MARC_EMPLEADO = CONS.MARC_EMPLEADO
                                                 and MARC_EMPR =2
                                                 AND EN.MARC_EVENTO = ''E'') ENTRADA,
                                             (SELECT MAX(EN.HORA_RELOJ)
                                                FROM PER_MARCACION_DIARIA_V EN
                                               WHERE EN.MARC_FECHA = CONS.MARC_FECHA
                                               and MARC_EMPR =2
                                                 AND EN.MARC_EMPLEADO = CONS.MARC_EMPLEADO
                                                 AND EN.MARC_EVENTO = ''S'') SALIDA,
                                             TO_DATE(TO_CHAR(CONS.MARC_FECHA, ''DD/MM/YYYY'') || '' '' ||
                                                     TO_CHAR(CONS.CONF_ENTRADA, ''HH24:MI:SS''),
                                                     ''DD/MM/YYYY HH24:MI:SS'') ENTRADA_MENS,
                                             TO_DATE(TO_CHAR(CONS.MARC_FECHA, ''DD/MM/YYYY'') || '' '' ||
                                                     TO_CHAR(CONS.CONF_SALIDA, ''HH24:MI:SS''),
                                                     ''DD/MM/YYYY HH24:MI:SS'') SALIDA_MENS,
                                                    HORA_RELOJ---
                                        FROM (SELECT T.MARC_FECHA,
                                                     T.MARC_EVENTO,
                                                     T.MARC_HORA,
                                                     T.MARC_EMPLEADO,
                                                     T.MARC_EMPR,
                                                     T.HORA_RELOJ,
                                                     EM.EMPL_MARC_ENTRADA CONF_ENTRADA,
                                                     EM.EMPL_MARC_SALIDA  CONF_SALIDA
                                                FROM PER_MARCACION_DIARIA_V T,
                                                     PER_CONFIGURACION      PC,
                                                     PER_PERIODO            PE,
                                                     PER_EMPLEADO           EM
                                               WHERE PC.CONF_EMPR = '||P_EMPRESA||'
                                                 AND PC.CONF_EMPR = PE.PERI_EMPR
                                                 AND EM.EMPL_EMPRESA = PC.CONF_EMPR
                                                 AND EM.EMPL_LEGAJO = T.MARC_EMPLEADO
                                                 AND EM.EMPL_FORMA_PAGO <> 1
                                                 AND EM.EMPL_SITUACION = ''A''
                                                 AND EM.EMPL_CONS_MARC = ''S''
                                                 AND (PC.CONF_PERI_SGTE - 3) = PE.PERI_CODIGO
                                                 AND PC.CONF_EMPR = T.MARC_EMPR

                                                 AND T.MARC_FECHA BETWEEN PE.PERI_FEC_INI AND
                                                     SYSDATE) CONS,
                                             PER_EMPLEADO EMP
                                       WHERE CONS.MARC_EMPR = '||P_EMPRESA||'
                                         AND EMP.EMPL_FORMA_PAGO <> 1
                                         AND CONS.MARC_EMPR = EMP.EMPL_EMPRESA
                                         AND CONS.MARC_EMPLEADO = EMP.EMPL_LEGAJO
                                       GROUP BY MARC_FECHA,
                                                CONS.MARC_EVENTO,
                                                CONS.MARC_HORA,
                                                CONS.MARC_EMPLEADO,
                                                CONS.MARC_EMPLEADO,
                                                CONS.CONF_ENTRADA,
                                                CONS.CONF_SALIDA,
                                                HORA_RELOJ
                                       ORDER BY CONS.MARC_FECHA) CALC) MARCADOS
                       WHERE DIAS_HABILES.FECHA = MARCADOS.MARC_FECHA(+)
                         AND DIAS_HABILES.EMPL_LEGAJO = MARCADOS.MARC_EMPLEADO(+))
                         WHERE FECHA BETWEEN aDD_MONTHS(TRUNC(TO_DATE('''||P_FECHA||'''), ''MM''), -2) AND TO_DATE('''||P_FECHA||''')
                          AND TO_CHAR(FECHA,''D'') NOT IN (7)
                          and empl_legajo not in ( 167,546,596)
                          AND ESTADO_DIAS IN (''S'',''W'')
                          and fecha not in (''13/11/2020'',''14/11/2020'',''16/04/2022'')
                         GROUP BY  FECHA, EMPL_LEGAJO, EMPLEADO, AREA, CARGO,NIVEL,SUCURSAL,DEPARTAMENTO,
                         MARC_FECHA,MARC_EMPLEADO,ENTRADA,SALIDA,ENTRADA_MENS,SALIDA_MENS,MARCADOR_ENTRADA,
                         MARCADOR_SALIDA,CUMPLE,ESTADO_DIAS, FECHA_INGRESO, FECHA_SALIDA, TO_CHAR(FECHA,''D''),
                         CLAV_AREA,DPTO_CODIGO, EMPL_MARC_ENTRADA,
                         EMPL_MARC_SALIDA,SUC_DESC,SALIDA,AREA1, AREA_Des1,HORA_ENT,TO_CHAR(FECHA,''IW''),
                         TO_CHAR(FECHA,''MM/YYYY''), empleado';
end if;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TABLERO_MARCACION') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TABLERO_MARCACION');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TABLERO_MARCACION',
                                                         P_QUERY           => P_QUERY10);

insert into x
  (campo1, otro)
values
  (P_QUERY10, 'TABLERO_MARCACION111');

       p_query := 'SELECT  CASE
                           WHEN C021 = ''PRESENTE'' AND C020 = ''PUNTUAL'' THEN
                             1
                            ELSE
                              0
                         END SI_PUNTUALIDAD_TOTAL,--1

                             NULL SI_PUNTUALIDAD_M1,--2
                   CASE
                       WHEN C020 = ''PUNTUAL'' AND TO_CHAR (to_Date(c001),''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'') THEN
                       1
                       ELSE
                          0
                     END SI_PUNTUALIDAD_M2,--3
                     CASE
                       WHEN C020 = ''PUNTUAL'' AND TO_CHAR (to_Date(c001),''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') THEN
                       1
                       ELSE
                          0
                     END SI_PUNTUALIDAD_M3,--4
                     CASE
                       WHEN C020 = ''IMPUNTUAL'' THEN
                         1
                        ELSE
                          0
                     END NO_PUNTUALIDAD_TOTAL,--5
                     NULL NO_PUNTUALIDAD1,--6
                              CASE
                 WHEN C020 = ''IMPUNTUAL''  AND TO_CHAR (to_Date(c001),''MM/YYYY'')  = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'') THEN
                 1
                 ELSE
                    0
               END NO_PUNTUALIDAD2,--7
                CASE
                 WHEN C020 = ''IMPUNTUAL''  AND TO_CHAR (to_Date(c001),''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') THEN
                  1
                  ELSE
                    0
               END NO_PUNTUALIDAD3,--8

               CASE
                 WHEN C021 = ''AUSENTE'' THEN
                  ''A''
                 ELSE
                  ''P''
               END AUSENTE,--9
               C025 AREA,--10
               C024  COD_AREA,--11
               C027 SEMANA,---12
               C028 MES,--13
               NULL PRESENCIA_M1,--14
               CASE
                 WHEN C021 = ''AUSENTE'' AND  TO_CHAR (to_Date(c001),''MM/YYYY'')  = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'')
                   AND TO_DATE (c001) >=  TO_DATE (c026) THEN
                  1
                  ELSE
                    0
               END PRESENCIA_M2,--15
               CASE
                 WHEN C021 = ''AUSENTE'' AND  TO_CHAR (to_Date(c001),''MM/YYYY'')= TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
                    AND TO_DATE (c001) >=  TO_DATE (c026) THEN
                 1
                 ELSE
                    0
               END PRESENCIA_M3,--16
               NULL MES_1 ,--17

              CASE
                   WHEN TO_CHAR (to_Date(c001),''MM/YYYY'')= TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''), -1),''MM/YYYY'') THEN
                    1
                   ELSE
                     0
              END MES_2 ,--18

              CASE
                   WHEN TO_CHAR (to_Date(c001),''MM/YYYY'')= TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') AND TO_DATE (C001) >=  TO_DATE(C026) THEN
                     1
                   ELSE
                     0
              END MES_3,--19
              CASE
                 WHEN C021 = ''AUSENTE'' AND TO_DATE (C001) >=  TO_DATE(C026)  THEN
                  1
                  ELSE
                    0
               END ausencias,--20
               TO_NUMBER(C019) DIA--21
      FROM APEX_collections F
     WHERE collection_name = ''TABLERO_MARCACION''';

       P_QUERY1:=  'SELECT TO_CHAR(ADD_MONTHS(('''||P_FECHA||'''), -2),''MM/YYYY'') MES_1,
                     TO_CHAR(ADD_MONTHS(('''||P_FECHA||'''), -1),''MM/YYYY'') MES_2,
                     TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') MES_3
               FROM DUAL';


     P_QUERY2 := 'SELECT TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')) SEMANA_1,
                           CASE
                             WHEN TO_CHAR(TO_DATE('''||P_FECHA||'''),''D'') = 6 THEN
                               ''S''
                             ELSE
                               ''S''
                             END DIA,
                           1 ORDEN,
                           CASE
                             WHEN TO_CHAR(TO_DATE('''||P_FECHA||'''),''D'') = 6 THEN
                               ''S''
                             ELSE
                               ''S''
                             END P_MES
                     FROM DUAL
                     UNION ALL
                     SELECT CASE
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-1) = 0 THEN
                               53
                               WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-1) = -1 THEN
                                52
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-1) = -1 THEN
                                51
                              ELSE
                                (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-1)
                               END SEMANA_1,
                            ''S'',
                            2 ORDEN,
                            ''S''
                     FROM DUAL
                     UNION ALL
                      SELECT CASE
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-2) = 0 THEN
                               53
                               WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-2) = -1 THEN
                                52
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-2) = -2 THEN
                                51
                              ELSE
                                (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-2)
                               END SEMANA_1,
                           ''S'',
                            3 ORDEN,
                            ''S''
                     FROM DUAL
                     UNION ALL
                      SELECT
                            CASE
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-3) = 0 THEN
                               53
                               WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-3) = -1 THEN
                                52
                              WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-3) = -2 THEN
                                51
                              ELSE
                                (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW''))-3)
                               END SEMANA_1,
                            CASE
                             WHEN TO_CHAR(TO_DATE('''||P_FECHA||'''),''D'') = 6 THEN
                               ''N''
                             ELSE
                               ''N''
                             END DIA,
                             4 ORDEN,
                             ''N''
                     FROM DUAL
                    ';

        P_QUERY3:=  'SELECT TMARC_FECHA,DETALLE,PORC,FECHA
                       FROM (SELECT TMARC_FECHA, TMARC_DETALLE DETALLE, T.TMARC_PROC PORC,
                        CASE
                         WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'') THEN
                              1
                         WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'') THEN
                              2
                         WHEN T.TMARC_FECHA||T.ANHO =(SELECT  C001||C004
                                                         FROM APEX_collections S
                                                         WHERE collection_name = ''ORDEN''
                                                          AND S.C003= 1
                                                          AND S.C002 =5)THEN
                            4
                          WHEN T.TMARC_FECHA||T.ANHO =(SELECT  C001||C004
                                                         FROM APEX_collections S
                                                         WHERE collection_name = ''ORDEN''
                                                          AND S.C003= 1
                                                          AND S.C002 =6)THEN
                            5


                         END FECHA
                        FROM PER_TABLERO_MARCACION T
                        WHERE TMARC_EMPR ='||P_EMPRESA||'
                        AND INDICADOR IS NULL
                        AND OPCION = 3)
                    WHERE FECHA IS NOT NULL' ;

   P_QUERY4:=  'SELECT TMARC_FECHA,DETALLE,PORC,FECHA
                       FROM (SELECT TMARC_FECHA, TMARC_DETALLE DETALLE, T.TMARC_PROC PORC,
                        CASE
                         WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'') THEN
                              1
                         WHEN T.TMARC_FECHA = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'') THEN
                              2
                         WHEN T.TMARC_FECHA||T.ANHO =(SELECT  C001||C004
                                                         FROM APEX_collections S
                                                         WHERE collection_name = ''ORDEN''
                                                          AND S.C003= 1
                                                          AND S.C002 =5)THEN
                            4
                          WHEN T.TMARC_FECHA||T.ANHO =(SELECT  C001||C004
                                                         FROM APEX_collections S
                                                         WHERE collection_name = ''ORDEN''
                                                          AND S.C003= 1
                                                          AND S.C002 =6)THEN
                            5


                         END FECHA
                        FROM PER_TABLERO_MARCACION T
                        WHERE TMARC_EMPR ='||P_EMPRESA||'
                        AND INDICADOR IS NULL
                        AND OPCION = 4)
                    WHERE FECHA IS NOT NULL' ;




     IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MAR_PUNTUALIDAD') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MAR_PUNTUALIDAD');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MAR_PUNTUALIDAD',
                                                         P_QUERY           => P_QUERY);


      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MAR_SEMANA') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MAR_SEMANA');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MAR_SEMANA',
                                                         P_QUERY           => P_QUERY2);


      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MAR_MES') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MAR_MES');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MAR_MES',
                                                            P_QUERY           => P_QUERY1);

         IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MAR_ANT_PUNT') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MAR_ANT_PUNT');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MAR_ANT_PUNT',
                                                            P_QUERY           => P_QUERY3);

      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MAR_ANT_ASIST') THEN
             APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MAR_ANT_ASIST');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MAR_ANT_ASIST',
                                                            P_QUERY           => P_QUERY4);




  END PP_PROCESO_MARCACIONES;

 PROCEDURE ORDEN_MES (P_FECHA IN DATE) IS

   P_QUERY VARCHAR2(20000);

   begin
   P_QUERY := 'SELECT mes, orden , lin,/* case
                    when mes >  TO_CHAR(TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW''))) then
                      TO_CHAR(TO_dATE('''||P_FECHA||'''),''YYYY'')-1
                     else
                      to_number(TO_CHAR(TO_dATE('''||P_FECHA||'''),''YYYY''))
                     end ANHO*/ 2020 anho


FROM
(SELECT TO_CHAR(EXTRACT(MONTH FROM TO_DATE('''||P_FECHA||''')) || ''/'' ||
               EXTRACT(YEAR FROM TO_DATE('''||P_FECHA||'''))) MES,
                            3 ORDEN, 2 lin
              FROM DUAL
            UNION ALL
            SELECT TO_CHAR(EXTRACT(MONTH FROM
                                   TO_DATE(ADD_MONTHS('''||P_FECHA||''', -1))) ||
                           ''/'' ||
                           EXTRACT(YEAR FROM TO_DATE(ADD_MONTHS('''||P_FECHA||''', -1)))) MES2,
                   2 ORDEN, 2
              FROM DUAL
            UNION ALL
            SELECT TO_CHAR(EXTRACT(MONTH FROM
                                   TO_DATE(ADD_MONTHS('''||P_FECHA||''', -2))) ||
                           ''/'' ||
                           EXTRACT(YEAR FROM TO_DATE(ADD_MONTHS('''||P_FECHA||''', -2)))) MES1,
                   1 ORDEN, 2
              FROM DUAL

            UNION ALL
            SELECT TO_CHAR(CASE
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 3) = 0 THEN
                              53
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 3) = -1 THEN
                              52
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 3) = -2 THEN
                              51
                             ELSE
                              (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 3)
                           END) SEMANA_1,
                   4 ORDEN, 1
            FROM DUAL
            UNION ALL
            SELECT TO_CHAR(CASE
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 2) = 0 THEN
                              53
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 2) = -1 THEN
                              52
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 2) = -2 THEN
                              51
                             ELSE
                              (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 2)
                           END) SEMANA_1,

                   5 ORDEN, 1
              FROM DUAL
            UNION ALL
            SELECT TO_CHAR(CASE
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 1) = 0 THEN
                              53
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 1) = -1 THEN
                              52
                             WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 1) = -2 THEN
                              51
                             ELSE
                              (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 1)
                           END) SEMANA_1,
                   6 ORDEN, 1
              FROM DUAL
              UNION ALL
              SELECT
                   TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'') , 7, 2
              FROM DUAL
              UNION ALL
                SELECT
                    TO_CHAR(TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW''))), 7, 1
                FROM DUAL
            UNION ALL
            SELECT  TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||''',''DD/MM/YYYY''), -2),''MM/YYYY'')MES3,1, 1
             FROM DUAL
            UNION ALL
            SELECT TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||''',''DD/MM/YYYY''), -1),''MM/YYYY'')MES4, 2  , 1
            FROM DUAL
            UNION ALL
            SELECT
                TO_CHAR(TO_DATE('''||P_FECHA||''',''DD/MM/YYYY''),''MM/YYYY'')MES5,3 ,1
                FROM DUAL

            UNION ALL
          SELECT CASE
                 WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 1) = 0 THEN
                  ''53''
                 WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 1) = -1 THEN
                  ''52''
                 WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 1) = -2 THEN
                  ''51''
                 ELSE
                  case when TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-1 <= 9 then
                        ''0''||(tO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-1)
                   else
                     to_char (TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-1)
                   end
               END SEMANA_1,
       6 ORDEN, 2
          FROM DUAL
         union all
          SELECT CASE
                         WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 3) = 0 THEN
                          ''53''
                         WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 3) = -1 THEN
                          ''52''
                         WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 3) = -2 THEN
                          ''51''
                         ELSE
                          case when TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-3 <= 9 then
                                ''0''||(tO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-3)
                           else
                             to_char (TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-3)
                           end
                       END SEMANA_1,
               4 ORDEN, 2
          FROM DUAL
          union all
          SELECT CASE
                         WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 2) = 0 THEN
                          ''53''
                         WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 2) = -1 THEN
                          ''52''
                         WHEN (TO_NUMBER(TO_CHAR(TO_DATE('''||P_FECHA||'''), ''IW'')) - 2) = -2 THEN
                          ''51''
                         ELSE
                          case when TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-2 <= 9 then
                                ''0''||(tO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-2)
                           else
                             to_char (TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW'')-2)
                           end
                       END SEMANA_1,
              5 ORDEN, 2
          FROM DUAL)';


                  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'ORDEN') THEN
                         APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'ORDEN');
                   END IF;
                      APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'ORDEN',
                                                                     P_QUERY           => P_QUERY);



 END ORDEN_MES;
 PROCEDURE PP_GUARDAR_DATOS_MARCACIONES (P_OPCION VARCHAR2,
                                         P_FECHA  IN DATE,
                                         P_EMPRESA IN NUMBER) IS


  v_sem number;
  v_mes number;

 BEGIN
 ---------------------------------------------------***SEMANA***----------------------------------------------------------
 ----------------------------------------------PUNTUALIDAD Y AUSENCIAS----------------------------------------------------
 ------------------------------------------------------GRAFICO------------------------------------------------------------



-- IF P_OPCION = 'S' THEN

IF TO_CHAR(SYSDATE,'DY','NLS_DATE_LANGUAGE=ENGLISH') = 'MON' AND TO_CHAR(SYSDATE, 'HH24:MI') >= '12:30'  THEN
   SELECT COUNT(*)
           INTO v_sem
           FROM PER_TABLERO_MARCACION X
           WHERE TMARC_FECHA = to_char(to_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW')))
            AND ANHO = TO_CHAR(P_FECHA, 'YYYY')
             AND TMARC_EMPR =P_EMPRESA
            AND NVL(INDICADOR, 'N') = 'N';
  IF V_SEM > 0 THEN
   null;-- RAISE_APPLICATION_ERROR(-20001, 'Ya existen registros de la semana actual');
 else

  INSERT INTO PER_TABLERO_MARCACION
            (TMARC_EMPR,     TMARC_DETALLE,          TMARC_PROC,
             TMARC_FECHA,    OPCION,                 ORDEN,          ANHO)
      SELECT P_EMPRESA,              'CUMPLE',               ROUND ((SUM(C001)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100),
             C012,            3,                      NULL,          TO_CHAR(P_FECHA, 'YYYY')
         FROM APEX_collections F
         WHERE collection_name = 'MAR_PUNTUALIDAD'
         AND C009 <> 'A'
         AND TO_NUMBER(C012) =  to_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))
        GROUP BY C012
     UNION ALL
     SELECT P_EMPRESA,               'NO CUMPLE',       ROUND ((SUM(C005)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100),
            C012,            3,                      NULL,          TO_CHAR(P_FECHA, 'YYYY')
         FROM APEX_collections F
         WHERE collection_name = 'MAR_PUNTUALIDAD'
         AND C009 <> 'A'
        AND TO_NUMBER(C012) = to_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))
        GROUP BY C012
     UNION ALL
      SELECT P_EMPRESA,            'AUSENCIA',              ROUND((sum(C020)/DECODE(count(C020),0,1,count(C020)))*100),
              C012,            4,                      NULL,          TO_CHAR(P_FECHA, 'YYYY')
           FROM APEX_collections F
           WHERE collection_name = 'MAR_PUNTUALIDAD'
           and c021 NOT IN('7','6')
           AND TO_NUMBER(C012) =  to_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))
          GROUP BY C012
      UNION ALL
       SELECT P_EMPRESA,               'PRESENCIA',            ROUND(((count(C020)-sum(C020))/DECODE(count(C020),0,1,count(C020)))*100),
              C012,            4,                      NULL,          TO_CHAR(P_FECHA, 'YYYY')
           FROM APEX_collections F
           WHERE collection_name = 'MAR_PUNTUALIDAD'
           and c021 NOT IN('7','6')
            AND TO_NUMBER(C012)  =  to_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))
          GROUP BY C012;
    end if;

  END IF;
 ---------------------------------------------------***MES***------------------------------------------------------------
 ----------------------------------------------PUNTUALIDAD Y AUSENCIAS----------------------------------------------------



 --IF TO_CHAR(P_FECHA,'MM/YYYY') = 'M' THEN
    SELECT COUNT(*)
           INTO v_mes
           FROM PER_TABLERO_MARCACION
           WHERE TMARC_FECHA = TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY')
            AND TMARC_EMPR =P_EMPRESA;-- TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY');
           -- AND OPCION = 2;
  IF V_mes > 0 THEN
   null;-- RAISE_APPLICATION_ERROR(-20001, 'Ya existen registros del mes actual');
  ELSE

         INSERT INTO PER_TABLERO_MARCACION
            (TMARC_EMPR,     TMARC_DETALLE,          TMARC_PROC,
             TMARC_FECHA,    OPCION,                 ORDEN,          ANHO)

         SELECT  P_EMPRESA,          'CUMPLE',       TO_CHAR(ROUND((SUM(C001)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100)),
                 C013,                  3,                      NULL,           NULL
            FROM APEX_collections F
             WHERE collection_name = 'MAR_PUNTUALIDAD'
             AND C009 <> 'A'
            AND C013  = TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY')
            GROUP BY C013----------------------------------------------GRAFICO PUNTUALIDAD
         UNION ALL
         SELECT P_EMPRESA,            'NO CUMPLE',  TO_CHAR(ROUND ((SUM(C005)/DECODE((SUM(C001)+SUM(C005)),0,1,(SUM(C001)+SUM(C005))))*100)),
                C013,                 3,                      NULL,           NULL
             FROM APEX_collections F
             WHERE collection_name = 'MAR_PUNTUALIDAD'
             AND C009 <> 'A'
             AND C013  = TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY')
         GROUP BY C013----------------------------------------------GRAFICO PUNTUALIDAD
        UNION ALL
        SELECT  P_EMPRESA,              'AUSENCIA',  TO_CHAR(ROUND((sum(C020)/DECODE(count(C020),0,1,count(C020)))*100)),
                C013,                   4,                  NULL,           NULL
         FROM APEX_collections F
         WHERE collection_name = 'MAR_PUNTUALIDAD'
         and c021 NOT IN('7','6')
         AND C013  =TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY')
        GROUP BY C013----------------------------------------------GRAFICO AUSENCIA
        UNION ALL
        SELECT  P_EMPRESA,               'PRESENCIA',     TO_CHAR(ROUND(((count(C020)-sum(C020))/DECODE(count(C020),0,1,count(C020)))*100)),
                C013,                    4,                  NULL,           NULL
         FROM APEX_collections F
         WHERE collection_name = 'MAR_PUNTUALIDAD'
         AND C013  = TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY')
         and c021 NOT IN('7','6')
        GROUP BY C013----------------------------------------------GRAFICO AUSENCIA
        UNION ALL
        SELECT  P_EMPRESA,               'NIVEL DE AUSENTISMO',  ROUND((SUM(C015)/decode(SUM(C018),0,1,SUM(C018)))*100)||'%',
                 TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY'),  2,         0,        NULL
         FROM APEX_collections
         WHERE collection_name = 'MAR_PUNTUALIDAD'
          and c021 NOT IN('7','6')
     UNION ALL
        SELECT P_EMPRESA,                 C010,                   ROUND((SUM(C015)/decode(SUM(C018),0,1,SUM(C018)))*100)||'%',
                TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY'),  2,         TO_NUMBER(C011),       NULL
             FROM APEX_collections
             WHERE collection_name = 'MAR_PUNTUALIDAD'
              and c021 NOT IN('7','6')
        GROUP BY C011, C010  ----------------------------------------------TABLERO AUSENCIAS
      UNION ALL
         SELECT P_EMPRESA,               'PUNTUALIDAD',         ROUND((nvl(SUM(C003),0)/decode((SUM(nvl(C003,0))+SUM(nvl(C007,0))),0,1,(SUM(nvl(C003,0))+SUM(nvl(C007,0))))*100),0)||'%',
                 TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY'),  1,         0,    NULL
          FROM APEX_collections
             WHERE collection_name = 'MAR_PUNTUALIDAD'
             AND C009 <> 'A'
        UNION ALL
        SELECT P_EMPRESA,                 C010,                 ROUND ((nvl(SUM(C003),0)/decode((SUM(nvl(C003,0))+SUM(nvl(C007,0))),0,1,(SUM(nvl(C003,0))+SUM(nvl(C007,0))))*100),0)||'%',
              TO_CHAR(ADD_MONTHS(P_FECHA, -1),'MM/YYYY'),  1,           TO_NUMBER(C011),    NULL
             FROM APEX_collections
             WHERE collection_name = 'MAR_PUNTUALIDAD'
             AND C009 <> 'A'
           GROUP BY C010, C011;--------------------------------------------TABLERO PUNTUALIDAD
 END IF;

 END PP_GUARDAR_DATOS_MARCACIONES;

 PROCEDURE PP_ESTRUCTURA_DETALLE (P_FECHA             IN DATE,
                                  P_EMPRESA           IN NUMBER,
                                  P_DIAS_LABORAL      OUT NUMBER,
                                  P_DIAS_HABILES      OUT NUMBER,
                                  P_DOTAC_M3          OUT NUMBER,
                                  P_OBJETIVO_KG       OUT NUMBER,
                                  P_OBJETIVO_GS       OUT NUMBER) IS

   V_FECHA_LABORAL                DATE;
   V_DIAS_TRABAJADOS              NUMBER;
   V_DIAS_HABILES                 NUMBER;
   V_DOT_MES1                     NUMBER;
   V_DOT_MES2                     NUMBER;
   V_DOT_MES3                     NUMBER;
   V_DOT_PB                       NUMBER;
   V_MES3                         VARCHAR2(60);
   V_MES2                         VARCHAR2(60);
   V_MES1                         VARCHAR2(60);
   V_MES1_DIA                     DATE;
   P_QUERY                        VARCHAR(20000);
   P_QUERY1                       VARCHAR(20000);
   P_QUERY2                       VARCHAR(20000);
   P_QUERY3                       VARCHAR(20000);
   P_QUERY4                       VARCHAR(20000);
   P_QUERY5                       VARCHAR(20000);
   P_QUERY6                       VARCHAR(20000);
   P_QUERY7                       VARCHAR(20000);
   X_CONF_TABLEAU_DESDE           DATE;
   X_CONF_TABLEAU_HASTA           DATE;-----ESTE ESTA ES DEL MES EN QUE COMINEZA
   X_MES_CONF_TABLEU              VARCHAR2(60);
   P_MES_DOT                      VARCHAR2(60);
   P_MES_DOT_M                    VARCHAR2(60);
   V_FECHA                        DATE;
   CONT                           NUMBER;
   V_MES33                         VARCHAR2(60);
   V_MES22                         VARCHAR2(60);
   V_MES11                         VARCHAR2(60);
   V_PRIMER_DIA                    DATE;
   V_SEMANA                        VARCHAR2(60);
 BEGIN
  -------------------------CANTIDAD DE DIAS HABILES DEL MES CORRIENTE
  V_FECHA_LABORAL := TBL_ULT_DIA_LAB_SUCURSAL(I_FECHA => P_FECHA);
  V_DIAS_TRABAJADOS := TBL_DIAS_LABURADOS_SUCURSAL(IN_DATE => P_FECHA,IND_REST_DIA  =>0);

   SELECT PHE_DIAS_HAB
    INTO V_DIAS_HABILES
   FROM TBL_CONF_TABLERO_COMERCIAL TD
    WHERE PHE_FECHA = TO_DATE(LAST_DAY(P_FECHA));

    P_DIAS_HABILES := V_DIAS_HABILES;
    P_DIAS_LABORAL := V_DIAS_TRABAJADOS;

 SELECT TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
        TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
        TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
        '01/'||TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
        TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MON/YYYY'),
        TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MON/YYYY'),
        TO_CHAR(TO_DATE(P_FECHA),'MON/YYYY'),
        '01/'||TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY'),
         '01/'||TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-12),'MM/YYYY'),
        TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-12),'MM/YYYY')
   INTO V_MES1, V_MES2, V_MES3,V_MES1_DIA,V_MES11, V_MES22, V_MES33, V_PRIMER_DIA,V_SEMANA,
        X_CONF_TABLEAU_DESDE, X_MES_CONF_TABLEU
  FROM DUAL;

    P_QUERY7:= 'SELECT null FECHA,
                     null DOCU_NRO_DOC,
                     null DETA_ART,
                     null ART_DESC,
                     sum(CANTIDAD_KG) CANTIDAD_KG,
                     sum(VENTA_GS)  VENTA_GS,
                     DECODE(SUC_DESC,''ASUNCION'',''CDA'',''CASA CENTRAL'', ''CENTRAL'',SUC_DESC),
                     ART_LINEA,
                     LINEA,
                     MES || ''/''|| ANHO,
                     ANHO|| ''/''||MES
                FROM TBL_VENTA f
        WHERE ART_LINEA NOT IN (27,20)
        AND  FECHA BETWEEN '''|| X_CONF_TABLEAU_DESDE||''' AND  '''||V_FECHA_LABORAL||'''
        GROUP BY DECODE(SUC_DESC,''ASUNCION'',''CDA'',''CASA CENTRAL'', ''CENTRAL'',SUC_DESC),
                 ART_LINEA,
                 LINEA,
                 MES || ''/''|| ANHO,
                 ANHO|| ''/''||MES';




  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_VENTA') THEN
         APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_VENTA');
        END IF;
         APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DETALLE_VENTA',
                                                        P_QUERY           => P_QUERY7);
 if  P_FECHA = last_day(TO_DATE(P_FECHA))  then
    SELECT MES1_VALOR,MES2_VALOR,MES3_VALOR, MESPB_VALOR---594 PB
    INTO  V_DOT_MES1,V_DOT_MES2,V_DOT_MES3,V_DOT_PB
    FROM(
    SELECT    SUM(CASE
                                         WHEN EMPL_SITUACION = 'A' AND
                                              EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -2))THEN
                                      1
                                     WHEN EMPL_SITUACION = 'I' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -2)) AND
                                          EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS(P_FECHA, -2)) THEN
                                      1
                                     ELSE
                                      0
                                   END) MES1_VALOR
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_TIPO_CONT <> 'T'
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           and SEMANA is null
                           AND MES || '/' || ANHO = V_MES1) A,
                       (SELECT SUM(CASE
                                     WHEN EMPL_SITUACION = 'A' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -1)) THEN
                                      1
                                     WHEN EMPL_SITUACION = 'I' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -1)) AND
                                          EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS(P_FECHA, -1)) THEN
                                      1
                                     ELSE
                                      0
                                   END) MES2_VALOR
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_TIPO_CONT <> 'T'
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           and semana is null
                           AND MES || '/' || ANHO = V_MES2) B,
                       (SELECT SUM(CASE
                                     WHEN EMPL_SITUACION = 'A' AND
                                          EMPL_FEC_INGRESO <= P_FECHA THEN
                                      1
                                     WHEN EMPL_SITUACION = 'I' AND
                                          EMPL_FEC_INGRESO <= P_FECHA AND
                                          EMPL_FEC_SALIDA > P_FECHA THEN
                                      1
                                     ELSE
                                      0
                                   END) MES3_VALOR
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_TIPO_CONT <> 'T'
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           and semana is null
                          AND MES || '/' || ANHO = V_MES3
                           ) C,
                        (SELECT SUM(CASE
                                     WHEN EMPL_SITUACION = 'A' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -12)) THEN
                                      1
                                     WHEN EMPL_SITUACION = 'I' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -12)) AND
                                          EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS(P_FECHA, -12)) THEN
                                      1
                                     ELSE
                                      0
                                   END) MESPB_VALOR
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_TIPO_CONT <> 'T'
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           and semana is null
                           AND MES || '/' || ANHO = X_MES_CONF_TABLEU)D  ;

    else -- SEMANAL 

      SELECT MES1_VALOR,MES2_VALOR,MES3_VALOR, MESPB_VALOR---594 PB
      INTO  V_DOT_MES1,V_DOT_MES2,V_DOT_MES3,V_DOT_PB
      FROM(
      SELECT    SUM(CASE
                              WHEN EMPL_SITUACION = 'A' AND
                                    EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -2))THEN
                                                     1
                                     WHEN EMPL_SITUACION = 'I' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -2)) AND
                                          EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS(P_FECHA, -2)) THEN
                                      1
                                     ELSE
                                      0
                                   END) MES1_VALOR
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_TIPO_CONT <> 'T'
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           and semana is null
                           AND MES || '/' || ANHO = V_MES1) A,
                       (SELECT SUM(CASE
                                     WHEN EMPL_SITUACION = 'A' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -1)) THEN
                                      1
                                     WHEN EMPL_SITUACION = 'I' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -1)) AND
                                          EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS(P_FECHA, -1)) THEN
                                      1
                                     ELSE
                                      0
                                   END) MES2_VALOR
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_TIPO_CONT <> 'T'
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           and semana is null
                           AND MES || '/' || ANHO = V_MES2) B,
                       (SELECT SUM(CASE
                                     WHEN EMPL_SITUACION = 'A' AND
                                          EMPL_FEC_INGRESO <= P_FECHA THEN
                                      1
                                     WHEN EMPL_SITUACION = 'I' AND
                                          EMPL_FEC_INGRESO <= P_FECHA AND
                                          EMPL_FEC_SALIDA > P_FECHA THEN
                                      1
                                     ELSE
                                      0
                                   END) MES3_VALOR
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_TIPO_CONT <> 'T'
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                          AND SEMANA || '/' || ANHO =V_SEMANA
                           AND MES is null
                           ) C,
                        (SELECT SUM(CASE
                                     WHEN EMPL_SITUACION = 'A' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -12)) THEN
                                      1
                                     WHEN EMPL_SITUACION = 'I' AND
                                          EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS(P_FECHA, -12)) AND
                                          EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS(P_FECHA, -12)) THEN
                                      1
                                     ELSE
                                      0
                                   END) MESPB_VALOR
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_TIPO_CONT <> 'T'
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           and e.semana is null
                           AND MES || '/' || ANHO = X_MES_CONF_TABLEU)D  ;

       END IF;



   P_DOTAC_M3 := V_DOT_MES3;



------------------------------------------------------------------------------------------
P_QUERY1 :='SELECT ROUND(MAX(CANTIDAD_KG_M1)/'||V_DOT_MES1||') KG_MES1,
                   ROUND(MAX(CANTIDAD_KG_M2)/'||V_DOT_MES2||') KG_MES2,
                   ROUND(((MAX(CANTIDAD_KG_M33)/'||V_DIAS_TRABAJADOS||')*'||V_DIAS_HABILES||')/'||V_DOT_MES3||') KG_MES3,
                   ROUND(MAX(VENTA_GS_M1)/'||V_DOT_MES1||') VENTA_MES1,
                   ROUND(MAX(VENTA_GS_M2)/'||V_DOT_MES2||') VENTA_MES2,
                   ROUND(((MAX(VENTA_GS_M33)/'||V_DIAS_TRABAJADOS||')*'||V_DIAS_HABILES||')/'||V_DOT_MES3||') VENTA_MES3,
                   ROUND(MAX(CANTIDAD_KG_PB)/'||V_DOT_PB||') KG_PB,
                   ROUND(MAX(VENTA_GS_PB)/'||V_DOT_PB||') GS_PB,
                   '''||V_MES1||''','''||V_MES2||''' ,'''||V_MES3||''' ,
                   ROUND(MAX(CANTIDAD_KG_M33)/'||V_DOT_MES3||') KG_MES3_3,
                   ROUND(MAX(VENTA_GS_M33)/'||V_DOT_MES3||')VENTA_MES3_3,
                   '''||V_MES11||''','''||V_MES22||''' ,'''||V_MES33||'''
              FROM(

              SELECT
                   CASE WHEN C010 = '''||V_MES1||''' THEN
                        SUM(C005)
                     END CANTIDAD_KG_M1,
                   CASE WHEN C010 = '''||V_MES2||''' THEN
                        SUM(C005)
                   END CANTIDAD_KG_M2,
                   CASE WHEN C010 = '''||V_MES3||''' THEN
                        SUM(C005)
                   END CANTIDAD_KG_M33,
                  ----------------VENTA
                    CASE WHEN C010 = '''||V_MES1||''' THEN
                        SUM(C006)
                   END VENTA_GS_M1 ,
                    CASE WHEN C010 = '''||V_MES2||''' THEN
                        SUM(C006)
                   END VENTA_GS_M2,
                    CASE WHEN C010 ='''||V_MES3||''' THEN
                        SUM(C006)
                   END VENTA_GS_M33,
                   ------PB
                    CASE WHEN C010 = '''||X_MES_CONF_TABLEU||''' THEN
                        SUM(C005)
                     END CANTIDAD_KG_PB,
                    CASE WHEN C010='''||X_MES_CONF_TABLEU||''' THEN
                        SUM(C006)
                   END VENTA_GS_PB
                FROM APEX_collections
                  WHERE collection_name = ''DETALLE_VENTA''
                  GROUP BY C010),

         (SELECT
                   SUM(C005)    CANTIDAD_KG_M3,
                   SUM(C006)    VENTA_GS_M3
              FROM APEX_collections
              WHERE collection_name = ''DETALLE_VENTA'')';



 P_QUERY3 := 'SELECT '''||V_MES1||''','''||V_MES2||''','''||V_MES3||'''
               FROM DUAL';


      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'ESTRUCTURA_DETALLE') THEN
         APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'ESTRUCTURA_DETALLE');
      END IF;
         APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'ESTRUCTURA_DETALLE',
                                                         P_QUERY           => P_QUERY1);


     IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'FECHA_ESTRUCTURA') THEN
         APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'FECHA_ESTRUCTURA');
      END IF;
         APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'FECHA_ESTRUCTURA',
                                                         P_QUERY           => P_QUERY3);

add_hist_query(in_nombre => 'FECHA_ESTRUCTURA', in_query => P_QUERY3 );

-------------------el objetivo ahora va a depender del tablero comercial
  SELECT SUM(A.IMPORTE_VENTA)/V_DOT_MES3 MES, SUM (CANTIDAD)/V_DOT_MES3
  INTO P_OBJETIVO_GS, P_OBJETIVO_KG
  FROM FAC_LONDON_PRES_RES_GRAL_V_F2 A
  WHERE A.MES||'/'||A.ANHO = EXTRACT(month FROM TO_DATE(P_FECHA))||TO_CHAR(TO_DATE(P_FECHA),'/YYYY');---'3/2021';


 END PP_ESTRUCTURA_DETALLE;

 PROCEDURE PP_ESTRUCTURA_HIPER (P_EMPRESA       IN NUMBER,
                                P_FECHA         IN DATE,
                                P_OPCION        IN NUMBER,
                                P_MES           IN NUMBER,
                                P_DIAS_HABILES  OUT VARCHAR2,
                                P_DIAS_TRABADOS OUT VARCHAR2,
                                P_IMPORTE       OUT VARCHAR2,
                                P_DOTACION      OUT VARCHAR2,
                                P_FEC_CORTE     OUT VARCHAR2,
                                P_KILO          OUT VARCHAR2) IS

   V_FECHA_LABORAL DATE;
   V_DIAS_TRABAJADOS NUMBER;
   V_DIAS_HABILES    NUMBER;
   V_DOT_MES1        NUMBER;
   V_DOT_MES2        NUMBER;
   V_DOT_MES3        NUMBER;
   V_MES3            VARCHAR2(60);
   V_MES2            VARCHAR2(60);
   V_MES1            VARCHAR2(60);
   V_MES1_DIA        DATE;
   P_QUERY           VARCHAR2(20000);
   P_QUERY1           VARCHAR2(20000);
   P_QUERY2           VARCHAR2(20000);
   P_MESFINAL1        DATE;
   P_MESFINAL2        DATE;
   X_FECHA            DATE;
   X_MES              VARCHAR2(60);
   X_MES_VAL              VARCHAR2(20000);
   X_CONF_TABLEAU_DESDE         DATE;
   X_sEMANA                     VARCHAR2(60);
 BEGIN

   V_FECHA_LABORAL := TBL_ULT_DIA_LAB_SUCURSAL(I_FECHA => P_FECHA);

 --RAISE_APPLICATION_ERROR (-20001, 'PASO POR AQUI');
  /*  select T.CONF_TABLEAU_DESDE
    INTO X_CONF_TABLEAU_DESDE
      from GEN_CONFIGURACION t
      WHERE T.CONF_EMPR = P_EMPRESA;*/

  SELECT TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
        '01/'||TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)),'DD/MM/YYYY'),
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)),'DD/MM/YYYY'),
        TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY'),
         '01/'||TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-12),'MM/YYYY')
   INTO V_MES1, V_MES2, V_MES3,V_MES1_DIA, P_MESFINAL1, P_MESFINAL2,X_SEMANA, X_CONF_TABLEAU_DESDE
  FROM DUAL;

 IF P_MES = 1 THEN
   X_FECHA := P_MESFINAL1;
   X_MES := V_MES1;
   X_MES_VAL :=X_MES_VAL || 'AND MES || ''/'' || ANHO = ''' ||V_MES1|| '''';
  P_FEC_CORTE := P_MESFINAL1;
   SELECT PHE_DIAS_HAB
     INTO P_DIAS_HABILES
     FROM TBL_CONF_TABLERO_COMERCIAL TD
    WHERE PHE_FECHA = TO_DATE(P_MESFINAL1);
     P_DIAS_TRABADOS := P_DIAS_HABILES;


 ELSIF P_MES = 2 THEN
    X_FECHA := P_MESFINAL2;
    X_MES := V_MES2;
    X_MES_VAL :=X_MES_VAL ||'AND MES || ''/'' ||ANHO = ''' ||V_MES2|| '''';
    P_FEC_CORTE := P_MESFINAL2;
   SELECT PHE_DIAS_HAB
     INTO P_DIAS_HABILES
     FROM TBL_CONF_TABLERO_COMERCIAL TD
    WHERE PHE_FECHA = TO_DATE(P_MESFINAL2);
     P_DIAS_TRABADOS := P_DIAS_HABILES;

  ELSIF P_MES = 10 THEN
    X_FECHA := LAST_DAY(X_CONF_TABLEAU_DESDE);
    X_MES :=TO_CHAR(X_FECHA,'MM/YYYY');
    P_FEC_CORTE := X_FECHA;
     X_MES_VAL :=X_MES_VAL || 'AND ANHO IS NULL';
   SELECT PHE_DIAS_HAB
     INTO P_DIAS_HABILES
     FROM TBL_CONF_TABLERO_COMERCIAL TD
    WHERE PHE_FECHA = TO_DATE(X_FECHA);
     P_DIAS_TRABADOS := P_DIAS_HABILES;

 ELSIF P_MES = 3 THEN
    X_FECHA := P_FECHA;
    X_MES := V_MES3;
    P_FEC_CORTE := V_FECHA_LABORAL;
    X_MES_VAL :=X_MES_VAL || 'AND SEMANA || ''/''|| ANHO = ''' ||X_SEMANA|| '''';
   SELECT PHE_DIAS_HAB
     INTO P_DIAS_HABILES
     FROM TBL_CONF_TABLERO_COMERCIAL TD
    WHERE PHE_FECHA = TO_DATE(LAST_DAY(P_FECHA));

     P_DIAS_TRABADOS := TBL_DIAS_LABURADOS_SUCURSAL(IN_DATE => P_FECHA,IND_REST_DIA =>  0);

 END IF;


  P_QUERY :=' SELECT EMPL_LEGAJO, EMPL_NOMBRE||'' ''||EMPL_APE EMPLEADO, DECODE(EMPL_SITUACION, ''A'',''ACTIVO'', ''INACTIVO''),
       EMPL_FEC_INGRESO,
       EMPL_FEC_SALIDA,
        CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND empl_departamento <> 31 THEN
                                          ''CDA''
                                         WHEN EMPL_DEPARTAMENTO IN (2,14,22,30) THEN
                                          ''CENTRAL''
                                         WHEN EMPL_DEPARTAMENTO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN EMPL_DEPARTAMENTO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN EMPL_DEPARTAMENTO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN EMPL_DEPARTAMENTO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN EMPL_DEPARTAMENTO IN (32) THEN
                                          ''ENCARNACION''
                                         WHEN EMPL_DEPARTAMENTO IN (35) THEN
                                          ''CAACUPE''
                                        END DEPARTAMENTO
        FROM PER_EMPLEADO_HIST E_HIST
       WHERE EMPL_CODIGO_PROV <> 0
         AND EMPL_TIPO_CONT <> ''T''
         AND EMPL_FORMA_PAGO <> 0
         AND EMPL_EMPRESA = '||P_EMPRESA||'
         AND EMPL_CODIGO_PROV <> 0
         '||X_MES_VAL||'
       --  AND EMPL_INCLUYE_TVC = ''S''
         AND CASE
               WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <=  '''||X_FECHA||''' THEN
                EMPL_LEGAJO
               ELSE
                CASE
                   WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||X_FECHA||''' AND
                       EMPL_FEC_SALIDA > '''||X_FECHA||''' THEN
                      EMPL_LEGAJO
                  END
              END IS NOT NULL';

             /*   insert into x
                  (campo1, orden, nombre, otro)
                values
                  (P_QUERY, null, 'dotacion',  'dotacion123');*/
   IF X_MES = V_MES3 THEN
    P_QUERY2:= ' SELECT C001,
                   C002,
                   C003,
                   C004,
                   C005    CANTIDAD_KG,
                   C006      VENTA_GS,
                   C007,
                   C008,
                   C009,
                   C010
              FROM APEX_collections
              WHERE collection_name = ''DETALLE_VENTA''
               AND C010 ='''||X_MES||'''';
     ELSE
        P_QUERY2:= ' SELECT C001,
                   C002,
                   C003,
                   C004,
                   C005    CANTIDAD_KG,
                   C006      VENTA_GS,
                   C007,
                   C008,
                   C009,
                   C010
              FROM APEX_collections
              WHERE collection_name = ''DETALLE_VENTA''
               AND C010 ='''||X_MES||'''';
     /*
  P_QUERY2:= ' SELECT null FECHA,
               null DOCU_NRO_DOC,
               null DETA_ART,
               null ART_DESC,
               sum (CANTIDAD_KG)    CANTIDAD_KG,
               sum (VENTA_GS)      VENTA_GS,
               DECODE(SUC_DESC,''ASUNCION'',''CDA'',''CASA CENTRAL'', ''CENTRAL'',SUC_DESC),
               ART_LINEA,
               LINEA,
               MES || ''/''|| ANHO
          FROM TBL_VENTA f
         WHERE FECHA <= '''||X_FECHA||'''
           and ART_LINEA NOT IN (27,20)
           AND MES || ''/''|| ANHO ='''||X_MES||'''
           group by DECODE(SUC_DESC,''ASUNCION'',''CDA'',''CASA CENTRAL'', ''CENTRAL'',SUC_DESC),
               ART_LINEA,
               LINEA,
               MES || ''/''|| ANHO';*/
       END IF;

             IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_VENTA') THEN
                   APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_VENTA');
                END IF;
                   APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DET_VENTA',
                                                                   P_QUERY           => P_QUERY2);

             IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_LEGAJO') THEN
                   APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_LEGAJO');
                END IF;
                   APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DET_LEGAJO',
                                                                   P_QUERY           => P_QUERY);


        SELECT  TO_CHAR(sum(c006),'999G999G999G999'),TO_CHAR(sum(c005),'999G999G999G999')
          into P_IMPORTE, P_KILO
           FROM APEX_collections
        WHERE collection_name = 'DET_VENTA' ;

          SELECT  count(c001)
          into P_DOTACION
           FROM APEX_collections
        WHERE collection_name = 'DET_LEGAJO' ;


        /*
          P_QUERY5 := 'SELECT A.ART_KG_CONTENIDO * A.CANTIDAD CANITDAD,
                     TO_CHAR(A.FECHA, ''MM/YYYY'') MES,
                     B.ART_CODIGO||''||B.ART_DESC ARTICULO
                FROM ADCS.CUBO_OPERACIONES_STK_COSTOS_V A, STK_ARTICULO B
               WHERE A.ART_CODIGO = B.ART_CODIGO
                 AND B.ART_EMPR = 1
                 AND B.ART_IND_CONS_PB = ''S''
                 AND A.FECHA BETWEEN '''||V_MES1_DIA||''' AND  '''||V_FECHA_LABORAL||'''
                 AND OPERACION_CODIGO = 9';*/

 END PP_ESTRUCTURA_HIPER;


 PROCEDURE PP_ESTURURA_HIPER2 (P_EMPRESA       IN NUMBER,
                               P_FECHA         IN DATE,
                               P_OPCION        IN NUMBER,
                               P_MES           IN NUMBER,
                               P_DIAS_HABILES  OUT VARCHAR2,
                               P_DIAS_TRABADOS OUT VARCHAR2,
                               P_IMPORTE       OUT VARCHAR2,
                               P_DOTACION      OUT VARCHAR2,
                               P_FEC_CORTE     OUT VARCHAR2,
                               P_KILO          OUT VARCHAR2,
                               P_MES2          IN VARCHAR2) IS



   V_FECHA_LABORAL   DATE;
   V_DIAS_TRABAJADOS NUMBER;
   V_DIAS_HABILES    NUMBER;
   V_DOT_MES1        NUMBER;
   V_DOT_MES2        NUMBER;
   V_DOT_MES3        NUMBER;
   V_MES3            VARCHAR2(60);
   V_MES2            VARCHAR2(60);
   V_MES1            VARCHAR2(60);
   V_MES1_DIA        DATE;
   P_QUERY           VARCHAR2(20000);
   P_QUERY1           VARCHAR2(20000);
   P_QUERY2           VARCHAR2(20000);
   P_MESFINAL1        DATE;
   P_MESFINAL2        DATE;
   X_FECHA            DATE;
   X_MES              VARCHAR2(60);
   X_MES_VAL     VARCHAR2(2000);
   X_SEMANA      VARCHAR2(20);
 BEGIN

V_FECHA_LABORAL := TBL_ULT_DIA_LAB_INDUSTRIAL(I_FECHA => P_FECHA);
 IF P_OPCION <> 5 THEN

  SELECT TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
        '01/'||TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)),'DD/MM/YYYY'),
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)),'DD/MM/YYYY'),
        TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY')
   INTO V_MES1, V_MES2, V_MES3,V_MES1_DIA, P_MESFINAL1, P_MESFINAL2,X_SEMANA
  FROM DUAL;


 IF P_MES = 1 THEN
   X_FECHA := P_MESFINAL1;
   X_MES := V_MES1;
    P_FEC_CORTE := P_MESFINAL1;
     P_DIAS_HABILES :=TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => LAST_DAY(P_MESFINAL1));
     P_DIAS_TRABADOS := P_DIAS_HABILES;
     X_MES_VAL :=X_MES_VAL ||'AND MES || ''/'' ||ANHO = ''' ||V_MES1|| '''';

 ELSIF P_MES = 2 THEN
    X_FECHA := P_MESFINAL2;
    X_MES := V_MES2;
    P_FEC_CORTE := P_MESFINAL2;
     P_DIAS_HABILES :=TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => LAST_DAY(P_MESFINAL2));
     P_DIAS_TRABADOS := P_DIAS_HABILES;
      X_MES_VAL :=X_MES_VAL ||'AND MES || ''/'' ||ANHO = ''' ||V_MES2|| '''';
 ELSIF P_MES = 3 THEN
    X_FECHA := P_FECHA;
     X_MES:= V_MES3;
      X_MES_VAL :=X_MES_VAL ||'AND SEMANA || ''/'' ||ANHO = ''' ||X_SEMANA|| '''';
    P_FEC_CORTE := V_FECHA_LABORAL;
     P_DIAS_HABILES :=TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => LAST_DAY(P_FECHA));

     P_DIAS_TRABADOS := TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => P_FECHA);

 END IF;

 ELSE

       X_MES := P_MES2;
   IF P_MES2 = TO_CHAR(P_FECHA,'MM/YYYY')  THEN
      X_FECHA :=V_FECHA_LABORAL;
      X_SEMANA:= TO_CHAR(P_FECHA,'IW/YYYY');
      P_DIAS_HABILES :=TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => LAST_DAY(X_FECHA));
      P_DIAS_TRABADOS := TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => P_FECHA);
      P_FEC_CORTE := V_FECHA_LABORAL;
       X_MES_VAL :=X_MES_VAL ||'AND SEMANA || ''/'' ||ANHO = ''' ||X_SEMANA|| '''';
   ELSE

        X_FECHA :=LAST_DAY(TO_DATE('01/'||P_MES2));
        P_FEC_CORTE := X_FECHA;
        P_DIAS_HABILES :=TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => LAST_DAY(X_FECHA));
        P_DIAS_TRABADOS := P_DIAS_HABILES;
         X_MES_VAL :=X_MES_VAL ||'AND ANHO IS NULL';
   END IF;

   --RAISE_APPLICATION_ERROR (-20001, X_FECHA);

 END  IF;

 P_QUERY :=' SELECT EMPL_LEGAJO, EMPL_NOMBRE||'' ''||EMPL_APE EMPLEADO,
                    DECODE(EMPL_SITUACION, ''A'',''ACTIVO'', ''INACTIVO''),
                    EMPL_FEC_INGRESO,
                    EMPL_FEC_SALIDA,
                  CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND EMPL_DEPARTAMENTO <> 31 THEN
                                          ''CDA''
                                         WHEN EMPL_DEPARTAMENTO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN EMPL_DEPARTAMENTO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN EMPL_DEPARTAMENTO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN EMPL_DEPARTAMENTO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN EMPL_DEPARTAMENTO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN EMPL_DEPARTAMENTO IN (32) THEN
                                          ''ENCARNACION''
                                        WHEN EMPL_DEPARTAMENTO IN (35) THEN
                                          ''CAACUPE''
                                        END DEPARTAMENTO,
                                        EMPL_DEPARTAMENTO,
                                         CASE
                                       WHEN EMPL_DEPARTAMENTO IN (3,4,5,6,7,8,13,21,23,24,27,28,33) THEN

                                        ''INDUSTRIAL''
                                     END DEP_INDUSTRIAL
        FROM PER_EMPLEADO_HIST E
       WHERE EMPL_CODIGO_PROV <> 0
         AND EMPL_TIPO_CONT <> ''T''
         AND EMPL_FORMA_PAGO <> 0
         AND EMPL_EMPRESA = '||P_EMPRESA||'
         '||X_MES_VAL||'
         AND CASE
               WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <=  '''||X_FECHA||''' THEN
                EMPL_LEGAJO
               ELSE
                CASE
                   WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||X_FECHA||''' AND
                       EMPL_FEC_SALIDA > '''||X_FECHA||''' THEN
                      EMPL_LEGAJO
                  END
              END IS NOT NULL';


     P_QUERY2:=  'SELECT A.ART_KG_CONTENIDO * A.CANTIDAD CANTIDAD,
                         TO_CHAR(A.FECHA, ''MM/YYYY'') MES,
                       --  ROW_NUMBER() OVER(ORDER BY TO_CHAR(A.FECHA, ''MM/YYYY'')),
                        ART_CODIGO,
                        ART_DESC,
                         A.NRO_DOCUMENTO,
                         A.FECHA,
                         NULL,
                         A.LINEA
                    FROM TVC_OPERACIONES_STK_COSTOS A
                   WHERE A.FECHA <='''||P_FECHA||'''
                     AND  TO_CHAR(A.FECHA, ''MM/YYYY'') = '''||X_MES||'''';




            IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_KG2') THEN
                   APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_KG2');
                END IF;
                   APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DET_KG2',
                                                                   P_QUERY           => P_QUERY2);

             IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_LEGAJO2') THEN
                   APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_LEGAJO2');
                END IF;
                   APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DET_LEGAJO2',
                                                                   P_QUERY           => P_QUERY);


   SELECT  TO_CHAR(sum(C001),'999G999G999G999'), NULL
          into P_KILO,P_IMPORTE
           FROM APEX_collections
        WHERE collection_name = 'DET_KG2' ;
 IF P_OPCION   = 2 THEN
      SELECT  count(c001)
          into P_DOTACION
           FROM APEX_collections
        WHERE collection_name = 'DET_LEGAJO2' ;
 ELSE
   SELECT  count(c001)
          into P_DOTACION
           FROM APEX_collections
        WHERE collection_name = 'DET_LEGAJO2'
         AND C008 = 'INDUSTRIAL' ;
  END IF;



  /*
  SELECT Q_VACANT,
                                  NRO_SOL,
                                  to_char(v.FECHA_APROB_SOL,'MM/YYYY')MES_ANHO,
                                  AREA_DESC AREA,
                                  CARGO_DESC,
                                  TIPO_SELEC_SOL,
                                  TIPO_CONTRATACION
                                  NIVEL_URGENCIA,
                                  FECHA_SOL,
                                  OPERADOR_SOL,
                                  TIPO_CONTRATO,
                                  ESTADO_APROB_SOL,
                                  OPERADOR_APROB_SOL,
                                  FECHA_APROB_SOL,
                                  ESTADO_FIN_SOL
                            FROM CUBO_LONDON_PROCESO_SELEC v
                            WHERE FECHA_SOL BETWEEN (&P_FECHA1) AND TO_DATE(&P_FECHA2)
                            GROUP BY  Q_VACANT,
                                  NRO_SOL,
                                  to_char(v.FECHA_APROB_SOL,'MM/YYYY'),
                                  AREA_DESC,
                                  TIPO_SELEC_SOL,
                                  TIPO_CONTRATACION,
                                   OPERADOR_SOL,
                                   NIVEL_URGENCIA,
                                   AREA_DESC,
                                   CARGO_DESC,
                                   TIPO_CONTRATO,
                                   ESTADO_APROB_SOL,
                                  OPERADOR_APROB_SOL,
                                   FECHA_APROB_SOL,
                                   ESTADO_FIN_SOL,FECHA_SOL

 */
 END PP_ESTURURA_HIPER2;

 PROCEDURE PP_EDIT_DOT_PRODUCCION (P_EMPRESA IN NUMBER,
                                   P_SELC_LEGAJO IN VARCHAR2) IS

  BEGIN
--   RAISE_APPLICATION_ERROR (-20001, P_EMPRESA);
   update per_empleado
       set empl_incluye_tvc = 'S'
     where empl_empresa  = P_EMPRESA
       and empl_legajo in (P_SELC_LEGAJO);


  END PP_EDIT_DOT_PRODUCCION;



PROCEDURE PP_TABLERO_COMERCIAL  (P_EMPRESA  IN NUMBER,
                                 P_FECHA    IN DATE) IS
   V_FECHA_LABORAL   DATE;
   V_MES             VARCHAR2(60);
   P_QUERY2          VARCHAR2(20000);

   P_QUERY3          VARCHAR2(20000);
   P_AND             VARCHAR2(2000);
BEGIN

 if  P_FECHA = last_day(TO_DATE(P_FECHA))  then
    P_AND := P_AND||' and semana is null AND MES || ''/'' || ANHO =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') ';
 else
   P_AND := P_AND||' and mes is null AND SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'') ';
 end if;

V_FECHA_LABORAL := TBL_ULT_DIA_LAB_SUCURSAL(I_FECHA => P_FECHA);

V_MES := TO_CHAR(TO_DATE(V_FECHA_LABORAL), 'MM/YYYY');
P_QUERY2 :='SELECT A.DOTACION, B.CANTIDAD_KG, B.VENTA_GS,SUC_DESC, VTA_OBJETIVO, CANT_OBJETIVO
               FROM
               (SELECT CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                                          ''CDA''
                                         WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN DPTO.DPTO_CODIGO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN DPTO.DPTO_CODIGO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN DPTO.DPTO_CODIGO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN DPTO.DPTO_CODIGO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN DPTO.DPTO_CODIGO IN (32) THEN
                                          ''ENCARNACION''
                                         WHEN DPTO.DPTO_CODIGO IN (35) THEN
                                          ''CAACUPE''
                                        END DEPARTAMENTO,
                                       SUM(CASE
                                             WHEN EMPL_SITUACION = ''A'' AND
                                                  EMPL_FEC_INGRESO <=  '''||P_FECHA||''' THEN
                                              1
                                             ELSE
                                              0
                                           END) + SUM(CASE
                                                        WHEN EMPL_SITUACION = ''I'' AND
                                                             EMPL_FEC_INGRESO <=  '''||P_FECHA||''' AND
                                                             EMPL_FEC_SALIDA >  '''||P_FECHA||''' THEN
                                                         1
                                                        ELSE
                                                         0
                                                      END) DOTACION
                                   FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                                     AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                                     AND EMPL_CODIGO_PROV <> 0
                                     AND EMPL_TIPO_CONT = ''I''
                                     AND EMPL_FORMA_PAGO <> 0
                                     AND EMPL_EMPRESA = 1
                                   '||P_AND||'
                                 GROUP BY CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                                          ''CDA''
                                         WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN DPTO.DPTO_CODIGO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN DPTO.DPTO_CODIGO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN DPTO.DPTO_CODIGO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN DPTO.DPTO_CODIGO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN DPTO.DPTO_CODIGO IN (32) THEN
                                          ''ENCARNACION''
                                       WHEN DPTO.DPTO_CODIGO IN (35) THEN
                                          ''CAACUPE''
                                       END) A,
                                      (SELECT
                                         SUM(C005)    CANTIDAD_KG,
                                         SUM(C006)    VENTA_GS,
                                         C007 SUC_DESC
                                    FROM APEX_collections
                                    WHERE collection_name = ''DETALLE_VENTA''
                                    AND  C010 = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
                                     GROUP BY C007)B,

                                     (SELECT CASE WHEN a.sucursal = ''ASUNCION'' THEN
                                                ''CDA''
                                                WHEN a.sucursal = ''CASA CENTRAL'' THEN
                                                 ''CENTRAL''
                                                ELSE
                                                   a.sucursal
                                                   END SUCURSAL,
                                          sum(a.importe_venta) VTA_OBJETIVO,
                                          SUM(A.cantidad) CANT_OBJETIVO
                                    FROM FAC_LONDON_PRES_RES_GRAL_V_F2 a
                                    where  a.mes||''/''||a.anho = EXTRACT(month FROM TO_DATE('''||P_FECHA||'''))||TO_CHAR(TO_DATE('''||P_FECHA||'''),''/YYYY'')
                                    group by a.sucursal) C
                                 WHERE B.SUC_DESC = A.DEPARTAMENTO
                                   AND B.SUC_DESC = C.SUCURSAL';


  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'VENTA_DEPART') THEN
     APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'VENTA_DEPART');
  END IF;
  
  APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'VENTA_DEPART',
                                                 P_QUERY           => P_QUERY2);


END PP_TABLERO_COMERCIAL;

 PROCEDURE PP_TABLERO_INDUSTRIAL (P_EMPRESA  IN NUMBER,
                                  P_FECHA    IN DATE) IS
   V_DIAS_TRABAJADOS              NUMBER;
   V_DIAS_HABILES                 NUMBER;
   P_QUERY1                       VARCHAR(20000);
   P_QUERY2                       VARCHAR(20000);
   P_QUERY3                       VARCHAR(20000);
   P_QUERY4                       VARCHAR(20000);
   V_FECHA_LABORAL                DATE;
   V_FECHA_DESDE                  DATE;
   V_FECHA                        DATE;

   V_MES_ANHO                     VARCHAR2(20);
   V_VALOR                        VARCHAR2(20);
   V_IND                          VARCHAR2(20);
   V_VALOR_IND                    VARCHAR2(20);
   V_FECHA2                       VARCHAR2(60);
   CONT                           NUMBER :=0;
   V_FEC_HASTA                    DATE;

   V_DOCT_ULTIMO_MES               VARCHAR2(20);
   P_AND                            VARCHAR2(2000);

 BEGIN

 V_FECHA_LABORAL := TBL_ULT_DIA_LAB_INDUSTRIAL (I_FECHA => P_FECHA);
 V_DIAS_TRABAJADOS := TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => V_FECHA_LABORAL);
 V_DIAS_HABILES :=TBL_DIAS_LABURADOS_INDUSTRIAL(IN_DATE => LAST_DAY(P_FECHA));

  if  P_FECHA = last_day(TO_DATE(P_FECHA))  then
    P_AND := P_AND||' AND MES || ''/'' || ANHO =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') ';
 else
   P_AND := P_AND||' AND SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'') ';
 end if;

/*
 SELECT C.CONF_EXCEL_DESDE , LAST_DAY(CONF_EXCEL_DESDE)
 INTO V_FECHA_DESDE,V_FEC_HASTA
 FROM GEN_CONFIGURACION C WHERE C.CONF_EMPR = P_EMPRESA;*/


    P_QUERY1 := 'SELECT SUM(A.ART_KG_CONTENIDO * A.CANTIDAD),
                     TO_CHAR(A.FECHA, ''MM/YYYY'') MES,
                     ROW_NUMBER() OVER (ORDER BY TO_CHAR(A.FECHA, ''MM/YYYY'')),
                     CASE WHEN TO_CHAR(A.FECHA, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''MM/YYYY'')  THEN
                       SUM(A.ART_KG_CONTENIDO * A.CANTIDAD)
                     END   DD,
                     CASE WHEN TO_CHAR(A.FECHA, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1),''MM/YYYY'')  THEN
                       SUM(A.ART_KG_CONTENIDO * A.CANTIDAD)
                     END   DD,
                     CASE WHEN TO_CHAR(A.FECHA, ''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  THEN
                       SUM(A.ART_KG_CONTENIDO * A.CANTIDAD)
                     END   DD,
                     CASE WHEN TO_CHAR(A.FECHA, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -12),''MM/YYYY'') THEN--TO_CHAR(TO_DATE('''||V_FECHA_DESDE||'''),''MM/YYYY'')  THEN
                       SUM(A.ART_KG_CONTENIDO * A.CANTIDAD)
                     END   DD
                FROM TVC_OPERACIONES_STK_COSTOS A
               WHERE A.FECHA < '''||P_FECHA||'''
                -- AND OPERACION_CODIGO = 9
               GROUP BY TO_CHAR(A.FECHA, ''MM/YYYY'')';

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'FACTOR_PRODUCCION') THEN
        APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'FACTOR_PRODUCCION');
    END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'FACTOR_PRODUCCION',
                                                       P_QUERY           => P_QUERY1);



       P_QUERY3 := 'SELECT SUM(CASE
                               WHEN EMPL_SITUACION = ''A'' AND MES || ''/''|| ANHO = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''MM/YYYY'')
                                  AND   EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                                1
                              WHEN EMPL_SITUACION = ''I''  AND MES || ''/''|| ANHO = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''MM/YYYY'')
                                              AND  EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) AND
                                               EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                                           1
                                          ELSE
                                           0
                                        END) MES1_VALOR,
                         ----VALOR MES 2
                         SUM(CASE
                               WHEN EMPL_SITUACION = ''A''  AND MES || ''/''|| ANHO = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1),''MM/YYYY'')
                                   AND  EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                                1
                              WHEN EMPL_SITUACION = ''I''  AND MES || ''/''|| ANHO = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1),''MM/YYYY'')
                                            AND   EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) AND
                                               EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                                           1
                                          ELSE
                                           0
                                        END) MES2_VALOR,
                         SUM(CASE
                               WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||'''
                                     '||P_AND||'  THEN
                                1
                               WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                               EMPL_FEC_SALIDA > '''||P_FECHA||'''
                                            '||P_AND||'
                                               THEN
                                           1
                                          ELSE
                                           0
                                        END) MES3_VALOR,
                         SUM(CASE
                               WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -12))  AND ANHO IS NULL THEN
                                1
                              WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -12)) AND ANHO IS NULL AND
                                               EMPL_FEC_SALIDA > LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -12)) THEN
                                           1
                                          ELSE
                                           0
                                        END) PB,
                         CASE
                           WHEN EMPL_DEPARTAMENTO IN (3,4,5,6,7,8,13,21,23,24,27,28,33) THEN
                            ''I''
                         END DEPARTAMENTO_I
                    FROM PER_EMPLEADO_HIST E
                   WHERE EMPL_CODIGO_PROV <> 0
                     AND EMPL_TIPO_CONT <> ''T''
                     AND EMPL_FORMA_PAGO <> 0
                     AND EMPL_EMPRESA = 1
                   GROUP BY EMPL_DEPARTAMENTO';






    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DOTACION_INDUSTRIAL2') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DOTACION_INDUSTRIAL2');
   END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DOTACION_INDUSTRIAL2',
                                                                P_QUERY           => P_QUERY3);



   IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DOTACION_INDUSTRIAL') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DOTACION_INDUSTRIAL');
   END IF;
      APEX_COLLECTION.CREATE_COLLECTION (P_COLLECTION_NAME => 'DOTACION_INDUSTRIAL');

   V_FECHA :=  ADD_MONTHS(to_DATE((P_FECHA)),-12) ;

    WHILE TO_DATE(LAST_DAY(V_FECHA)) <= ADD_MONTHS(to_DATE(LAST_DAY(P_FECHA)),+1)  LOOP

    IF LAST_DAY(V_FECHA) < '31/03/2020' THEN
           SELECT DEPARTAMENTO,INDUSTRIAL_VALOR , FECHA2
           INTO  V_IND, V_VALOR_IND, V_FECHA2
           FROM
                (SELECT CASE
                 WHEN EMPL_DEPARTAMENTO IN (3,4,5,6,7,8,13,21,23,24,27,28,33) THEN

                  'INDUSTRIAL'
               END DEPARTAMENTO,
               SUM(CASE
                     WHEN EMPL_SITUACION = 'A' AND
                          EMPL_FEC_INGRESO <= LAST_DAY(V_FECHA) THEN
                      1
                     ELSE
                      0
                   END) + SUM(CASE
                                WHEN EMPL_SITUACION = 'I' AND
                                     EMPL_FEC_INGRESO <= LAST_DAY(V_FECHA) AND
                                     EMPL_FEC_SALIDA > LAST_DAY(V_FECHA) THEN
                                 1
                                ELSE
                                 0
                              END) INDUSTRIAL_VALOR,
                TO_CHAR(V_FECHA,'MM/YYYY') FECHA2
          FROM PER_EMPLEADO_HIST
         WHERE EMPL_CODIGO_PROV <> 0
           AND EMPL_TIPO_CONT <> 'T'
           AND EMPL_FORMA_PAGO <> 0
           AND ANHO IS NULL
           AND EMPL_FEC_INGRESO <= LAST_DAY(P_FECHA)
           AND EMPL_EMPRESA = 1
           GROUP BY  CASE WHEN EMPL_DEPARTAMENTO IN (3,4,5,6,7,8,13,21,23,24,27,28,33) THEN
                     'INDUSTRIAL'
               END) WHERE DEPARTAMENTO IS NOT NULL;

     ELSE

        BEGIN
          SELECT DEPARTAMENTO,INDUSTRIAL_VALOR , FECHA2
           INTO  V_IND, V_VALOR_IND, V_FECHA2
           FROM
                (SELECT CASE
                 WHEN EMPL_DEPARTAMENTO IN (3,4,5,6,7,8,13,21,23,24,27,28,33) THEN

                  'INDUSTRIAL'
               END DEPARTAMENTO,
               SUM(CASE
                     WHEN EMPL_SITUACION = 'A' AND
                          EMPL_FEC_INGRESO <= LAST_DAY(V_FECHA) THEN
                      1
                     ELSE
                      0
                   END) + SUM(CASE
                                WHEN EMPL_SITUACION = 'I' AND
                                     EMPL_FEC_INGRESO <= LAST_DAY(V_FECHA) AND
                                     EMPL_FEC_SALIDA > LAST_DAY(V_FECHA) THEN
                                 1
                                ELSE
                                 0
                              END) INDUSTRIAL_VALOR,
                TO_CHAR(V_FECHA,'MM/YYYY') FECHA2
          FROM PER_EMPLEADO_HIST
         WHERE EMPL_CODIGO_PROV <> 0
           AND EMPL_TIPO_CONT <> 'T'
           AND EMPL_FORMA_PAGO <> 0
           and semana is null
           AND  MES||'/'||ANHO = TO_CHAR(TO_DATE(V_FECHA,'DD/MM/YYYY'),'MM/YYYY')
           AND EMPL_FEC_INGRESO <= LAST_DAY(P_FECHA)
           AND EMPL_EMPRESA = 1
           GROUP BY  CASE WHEN EMPL_DEPARTAMENTO IN (3,4,5,6,7,8,13,21,23,24,27,28,33) THEN
                     'INDUSTRIAL'
               END) WHERE DEPARTAMENTO IS NOT NULL;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
             NULL;
             V_IND :=NULL;
             V_VALOR_IND:=NULL;
             V_FECHA2:=NULL;
           END;

          END IF;

      IF  V_FECHA >= ADD_MONTHS(to_DATE(LAST_DAY(P_FECHA)),-12 )THEN
         CONT := CONT+ 1;
      END IF;

      IF CONT = 13  THEN

      SELECT  SUM(C003)DOTI_M3
        INTO V_DOCT_ULTIMO_MES
        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'DOTACION_INDUSTRIAL2'
         AND C005 IS NOT NULL;

        V_VALOR_IND := V_DOCT_ULTIMO_MES;
        V_FECHA2 := TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY');
      END IF;
     APEX_COLLECTION.ADD_MEMBER (
      p_collection_name => 'DOTACION_INDUSTRIAL',
                 P_C001 => V_VALOR_IND,
                 P_C002 => CONT,
                 P_C003 => V_FECHA2);

     V_FECHA := ADD_MONTHS(V_FECHA,+1);
    END LOOP;

   P_QUERY4 :=
            'SELECT TO_CHAR(ROUND(PRO_PB/DOT_PB), ''999G999G999G999G999''),
                    TO_CHAR(ROUND(PRO_M1/DOT_M1), ''999G999G999G999G999''),
                    TO_CHAR(ROUND(PRO_M2/DOT_M2), ''999G999G999G999G999''),
                    TO_CHAR(ROUND(((PRO_M3/'||V_DIAS_TRABAJADOS||')*'||V_DIAS_HABILES||')/DOT_M3), ''999G999G999G999G999''),
                    TO_CHAR(ROUND(PRO_PB/DOTI_PB), ''999G999G999G999G999''),
                    TO_CHAR(ROUND(PRO_M1/DOTI_M1), ''999G999G999G999G999''),
                    TO_CHAR(ROUND(PRO_M2/DOTI_M2), ''999G999G999G999G999''),
                    TO_CHAR(ROUND(((PRO_M3/'||V_DIAS_TRABAJADOS||')*'||V_DIAS_HABILES||')/DOTI_M3), ''999G999G999G999G999''),
                    TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''MM/YYYY''),
                    TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1),''MM/YYYY''),
                    TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
               FROM (SELECT MAX(C004) PRO_M1,  MAX(C005)PRO_M2,  MAX(C006)PRO_M3,  MAX(C007)PRO_PB
                       FROM APEX_COLLECTIONS
                      WHERE COLLECTION_NAME = ''FACTOR_PRODUCCION'') PRO,
                     (SELECT SUM(C001)DOT_M1,  SUM(C002)DOT_M2,  SUM(C003)DOT_M3,  SUM(C004)DOT_PB
                        FROM APEX_COLLECTIONS
                       WHERE COLLECTION_NAME = ''DOTACION_INDUSTRIAL2'') DOT,
                       (SELECT SUM(C001)DOTI_M1,  SUM(C002)DOTI_M2,  SUM(C003)DOTI_M3,  SUM(C004)DOTI_PB
                        FROM APEX_COLLECTIONS
                       WHERE COLLECTION_NAME = ''DOTACION_INDUSTRIAL2''
                         AND C005 IS NOT NULL) DOTI';


  IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TABLERO_INDUSTRIAL') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TABLERO_INDUSTRIAL');
   END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TABLERO_INDUSTRIAL',
                                                                P_QUERY           => P_QUERY4);


 END PP_TABLERO_INDUSTRIAL;

 PROCEDURE PP_DOTACION (P_EMPRESA IN NUMBER,
                        P_FECHA   IN DATE) IS


   V_MES3            VARCHAR2(60);
   V_MES2            VARCHAR2(60);
   V_MES1            VARCHAR2(60);
   V_SEMANA          VARCHAR2(60);
   V_SEMANA_ANT          VARCHAR2(60);
   V_FECHA1          DATE;
   V_FECHA2          DATE;
   P_QUERY1          VARCHAR2(20000);
   P_QUERY2          VARCHAR2(20000);

   V_MES_PB          VARCHAR2(60);
   V_FECHA_PB        DATE;

   P_AND               VARCHAR2(20000);
 BEGIN

 SELECT TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY')  mes1,
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY') mes2,
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY')                mes3,
         TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY')                semana,
         
        CASE WHEN TO_CHAR(TO_DATE(P_FECHA),'IW') = 1 then
          TO_CHAR(TO_DATE(P_FECHA)-7,'IW/')||TO_CHAR((TO_CHAR(TO_DATE(P_FECHA),'YYYY'))-1)
        else
          TO_CHAR(TO_DATE(P_FECHA)-7,'IW/YYYY')
        end  DDD, -- semana antes
           
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)),'DD/MM/YYYY') fecha1,
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)),'DD/MM/YYYY') fecha2,

        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-12)),'DD/MM/YYYY') fecha_pb,
        TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-12),'MM/YYYY') mes_pb
        
   INTO V_MES1, V_MES2, V_MES3,V_SEMANA,V_SEMANA_ANT,V_FECHA1, V_FECHA2, V_FECHA_PB, V_MES_PB
   FROM DUAL;

 if  P_FECHA = last_day(TO_DATE(P_FECHA))  then
    P_AND := P_AND||'and semana is null AND MES || ''/'' || ANHO = '''||V_MES3||'''';
 else
    P_AND := P_AND||'and mes is null AND SEMANA || ''/'' || ANHO = '''||V_SEMANA||'''';
 end if;

 IF P_EMPRESA =1 THEN

P_QUERY1 := 'SELECT
                ''INDICADOR'',''PB'','''||V_MES1||''','''||V_MES2||''' ,'''||V_MES3||''',''A'',  NULL M1_TOT, NULL M2_TOT, NULL M3_TOT, NULL PB_TOT
                FROM DUAL
                UNION ALL
                SELECT JA.AREA_DESC,
                       TO_CHAR(PB_VALOR) PB,
                       TO_CHAR(MES1_VALOR),
                       TO_CHAR(MES2_VALOR),
                       TO_CHAR(MES3_VALOR),
                       CASE
                       WHEN JA.AREA_COD = 1 THEN
                          ''C''
                         WHEN JA.AREA_COD = 2 THEN
                          ''DA''
                         WHEN JA.AREA_COD = 3 THEN
                          ''E''
                         WHEN JA.AREA_COD = 4 THEN
                         ''F''
                           WHEN JA.AREA_COD = 5 THEN
                         ''G''
                            WHEN JA.AREA_COD = 6 THEN
                         ''H''
                       END ddd,
                       TO_CHAR(MES1_TOT),
                       TO_CHAR(MES2_TOT),
                       TO_CHAR(MES3_TOT),
                       TO_CHAR(PB_TOT)
                  FROM (SELECT AREA_DESC DEPARTAMENTO,
                               SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  AND  EMPL_TIPO_CONT = ''I''   THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA1||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA1||''' AND  EMPL_TIPO_CONT = ''I''  THEN
                                      1
                                     ELSE
                                      0
                                   END) MES1_VALOR,
                                   SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA1||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA1||'''  THEN
                                      1
                                     ELSE
                                      0
                                   END) MES1_TOT
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           AND MES || ''/'' || ANHO = '''||V_MES1||'''
                           and semana is null
                         GROUP BY AREA_DESC) A,
                         
                       (SELECT AREA_DESC DEPARTAMENTO,
                               SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA2||''' AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA2||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA2||''' AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     ELSE
                                      0
                                   END) MES2_VALOR,
                                   SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA2||'''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA2||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA2||''' THEN
                                      1
                                     ELSE
                                      0
                                   END) MES2_TOT
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           AND MES || ''/'' || ANHO = '''||V_MES2||'''
                           and semana is null
                         GROUP BY AREA_DESC) B,
                         
                       (SELECT AREA_DESC DEPARTAMENTO,
                               SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND EMPL_TIPO_CONT = ''I''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                          EMPL_FEC_SALIDA > '''||P_FECHA||'''  AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     ELSE
                                      0
                                   END) MES3_VALOR,
                                   SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||P_FECHA||'''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                          EMPL_FEC_SALIDA > '''||P_FECHA||'''  THEN
                                      1
                                     ELSE
                                      0
                                   END) MES3_TOT
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           '||P_AND||'
                         GROUP BY AREA_DESC) C,
                      (SELECT AREA_DESC DEPARTAMENTO,
                               SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA_PB||'''  AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA_PB||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA_PB||''' AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     ELSE
                                      0
                                   END) PB_VALOR,
                                   SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA_PB||'''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA_PB||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA_PB||''' THEN
                                      1
                                     ELSE
                                      0
                                   END) PB_TOT
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 1
                           AND MES || ''/'' || ANHO = '''||V_MES_PB||'''
                           and semana is null
                         GROUP BY AREA_DESC) D,

                       PER_AREA_JSA JA
                 WHERE JA.AREA_DESC = A.DEPARTAMENTO(+)
                   AND JA.AREA_DESC = B.DEPARTAMENTO(+)
                   AND JA.AREA_DESC = C.DEPARTAMENTO(+)
                   AND JA.AREA_DESC = D.DEPARTAMENTO(+)
                   AND JA.AREA_EMPR = 1
                   AND JA.AREA_TIPO = 1';



   P_QUERY2 := 'SELECT A.DEPARTAMENTO, NULL, A.INDICADOR, A.TOTAL_ACT, NULL,  B.INDICADOR, B.TOTAL_ACT
                  FROM
                  (SELECT DPTO_CODIGO||'' - ''||DECODE(DPTO_CODIGO,29,''P.J.C'',DPTO_DESC) DEPARTAMENTO,
                                         ''ACTUAL'' INDICADOR,
                                         SUM(CASE
                                               WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' THEN
                                                1
                                               WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                                    EMPL_FEC_SALIDA > '''||P_FECHA||''' THEN
                                                   1
                                                ELSE
                                                           0
                                                END) TOTAL_ACT, NULL, NULL
                                 FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                               WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                                 AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                                 AND EMPL_CODIGO_PROV <> 0
                                 AND EMPL_TIPO_CONT <> ''T''
                                 AND EMPL_FORMA_PAGO <> 0
                                 AND EMPL_EMPRESA = 1
                                '||P_AND||'
                                 AND DPTO_SUC NOT IN (1,2,8)
                                 GROUP BY DPTO_DESC, DPTO_CODIGO) A,
                                 (SELECT DPTO_CODIGO||'' - ''||DECODE(DPTO_CODIGO,29,''P.J.C'',DPTO_DESC) DEPARTAMENTO,
                                         ''ANTERIOR'' INDICADOR,
                                         SUM(CASE
                                               WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= TO_DATE('''||P_FECHA||''')-7 THEN
                                                1
                                               WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= TO_DATE('''||P_FECHA||''')-7 AND
                                                    EMPL_FEC_SALIDA > TO_DATE('''||P_FECHA||''')-7 THEN
                                                   1
                                                ELSE
                                                       0
                                            END) TOTAL_ACT
                             FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                           WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                             AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                             AND EMPL_CODIGO_PROV <> 0
                             AND EMPL_TIPO_CONT <> ''T''
                             AND EMPL_FORMA_PAGO <> 0
                             AND EMPL_EMPRESA = 1
                             AND SEMANA ||''/''|| ANHO = '''||V_SEMANA_ANT||'''
                             and mes is null
                             AND DPTO_SUC NOT IN (1,2,8)
                             GROUP BY DPTO_DESC, DPTO_CODIGO) B
                        WHERE A.DEPARTAMENTO= B.DEPARTAMENTO ';
 END IF;
 IF P_EMPRESA =2 THEN
    P_QUERY1 :=  'SELECT
                ''INDICADOR'',''PB'','''||V_MES1||''','''||V_MES2||''' ,'''||V_MES3||''',''A'',  NULL M1_TOT, NULL M2_TOT, NULL M3_TOT, NULL PB_TOT
                FROM DUAL
                UNION ALL
                SELECT JA.AREA_DESC,
                       TO_CHAR(PB_VALOR) PB,
                       TO_CHAR(MES1_VALOR),
                       TO_CHAR(MES2_VALOR),
                       TO_CHAR(MES3_VALOR),
                       CASE
                       WHEN JA.AREA_COD = 1 THEN
                          ''C''
                         WHEN JA.AREA_COD = 2 THEN
                          ''DA''
                         WHEN JA.AREA_COD = 3 THEN
                          ''E''
                         WHEN JA.AREA_COD = 4 THEN
                         ''F''
                          WHEN JA.AREA_COD = 5 THEN
                         ''G''
                            WHEN JA.AREA_COD = 6 THEN
                         ''H''
                       END ddd,
                       TO_CHAR(MES1_TOT),
                       TO_CHAR(MES2_TOT),
                       TO_CHAR(MES3_TOT),
                       TO_CHAR(PB_TOT)
                  FROM (SELECT CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                             1---ADMINISTACION
                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                             2---GRANOS
                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                             3---INSUMOS
                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                             4---UNIDADES
                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN
                             5---TRANSPORTE
                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                             6---REPUESTO
                        end  DEPARTAMENTO,
                               SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  AND  EMPL_TIPO_CONT = ''I''   THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA1||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA1||''' AND  EMPL_TIPO_CONT = ''I''  THEN
                                      1
                                     ELSE
                                      0
                                   END) MES1_VALOR,
                                   SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA1||'''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA1||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA1||'''  THEN
                                      1
                                     ELSE
                                      0
                                   END) MES1_TOT
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA =2
                           and semana is null
                           AND MES || ''/'' || ANHO = '''||V_MES1||'''
                         GROUP BY CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                             1---ADMINISTACION
                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                             2---GRANOS
                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                             3---INSUMOS
                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                             4---UNIDADES
                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN
                             5---TRANSPORTE
                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                             6---REPUESTO
                        end) A,
                        
                       (SELECT CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                             1---ADMINISTACION
                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                             2---GRANOS
                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                             3---INSUMOS
                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                             4---UNIDADES
                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN
                             5---TRANSPORTE
                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                             6---REPUESTO
                        end  DEPARTAMENTO,
                               SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA2||''' AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA2||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA2||''' AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     ELSE
                                      0
                                   END) MES2_VALOR,
                                   SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA2||'''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA2||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA2||''' THEN
                                      1
                                     ELSE
                                      0
                                   END) MES2_TOT
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 2
                           and semana is null
                           AND MES || ''/'' || ANHO = '''||V_MES2||'''
                         GROUP BY CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                             1---ADMINISTACION
                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                             2---GRANOS
                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                             3---INSUMOS
                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                             4---UNIDADES
                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN
                             5---TRANSPORTE
                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                             6---REPUESTO
                        end) B,
                        
                       (SELECT CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                             1---ADMINISTACION
                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                             2---GRANOS
                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                             3---INSUMOS
                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                             4---UNIDADES
                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN
                             5---TRANSPORTE
                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                             6---REPUESTO
                        end DEPARTAMENTO,
                               SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND EMPL_TIPO_CONT = ''I''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                          EMPL_FEC_SALIDA > '''||P_FECHA||'''  AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     ELSE
                                      0
                                   END) MES3_VALOR,
                                   SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||P_FECHA||'''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                          EMPL_FEC_SALIDA > '''||P_FECHA||'''  THEN
                                      1
                                     ELSE
                                      0
                                   END) MES3_TOT
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 2
                           '||P_AND||'
                         GROUP BY CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                             1---ADMINISTACION
                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                             2---GRANOS
                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                             3---INSUMOS
                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                             4---UNIDADES
                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN
                             5---TRANSPORTE
                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                             6---REPUESTO
                        end) C,
                        
                      (SELECT CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                             1---ADMINISTACION
                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                             2---GRANOS
                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                             3---INSUMOS
                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                             4---UNIDADES
                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN
                             5---TRANSPORTE
                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                             6---REPUESTO
                        end DEPARTAMENTO,
                               SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA_PB||'''  AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA_PB||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA_PB||''' AND  EMPL_TIPO_CONT = ''I'' THEN
                                      1
                                     ELSE
                                      0
                                   END) PB_VALOR,
                                   SUM(CASE
                                     WHEN EMPL_SITUACION = ''A'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA_PB||'''  THEN
                                      1
                                     WHEN EMPL_SITUACION = ''I'' AND
                                          EMPL_FEC_INGRESO <= '''||V_FECHA_PB||''' AND
                                          EMPL_FEC_SALIDA > '''||V_FECHA_PB||''' THEN
                                      1
                                     ELSE
                                      0
                                   END) PB_TOT
                          FROM PER_EMPLEADO_HIST E
                         WHERE EMPL_CODIGO_PROV <> 0
                           AND EMPL_FORMA_PAGO <> 0
                           AND EMPL_EMPRESA = 2
                           and semana is null
                           AND MES || ''/'' || ANHO = '''||V_MES_PB||'''
                         GROUP BY CASE WHEN E.EMPL_AREA_ORGANI IN (4) THEN
                             1---ADMINISTACION
                        WHEN E.EMPL_AREA_ORGANI IN (7) THEN
                             2---GRANOS
                        WHEN E.EMPL_AREA_ORGANI IN (6) THEN
                             3---INSUMOS
                        WHEN E.EMPL_AREA_ORGANI IN (2) THEN
                             4---UNIDADES
                        WHEN E.EMPL_AREA_ORGANI IN (1,3,5) THEN
                             5---TRANSPORTE
                        WHEN E.EMPL_AREA_ORGANI IN (8) THEN
                             6---REPUESTO
                        end) D,
                       PER_AREA_JSA JA
                 WHERE JA.AREA_COD = A.DEPARTAMENTO(+)
                   AND JA.AREA_COD = B.DEPARTAMENTO(+)
                   AND JA.AREA_COD = C.DEPARTAMENTO(+)
                   AND JA.AREA_COD = D.DEPARTAMENTO(+)
                   AND JA.AREA_EMPR = 2
                   AND JA.AREA_TIPO = 1';

       P_QUERY2 := 'SELECT A.DEPARTAMENTO, NULL, A.INDICADOR, A.TOTAL_ACT, NULL,  B.INDICADOR, B.TOTAL_ACT
                  FROM
                  (SELECT DPTO_CODIGO||'' - ''||DECODE(DPTO_CODIGO,29,''P.J.C'',DPTO_DESC) DEPARTAMENTO,
                                         ''ACTUAL'' INDICADOR,
                                         SUM(CASE
                                               WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' THEN
                                                1
                                               WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                                                    EMPL_FEC_SALIDA > '''||P_FECHA||''' THEN
                                                   1
                                                ELSE
                                                           0
                                                END) TOTAL_ACT, NULL, NULL
                                 FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                               WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                                 AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                                 AND EMPL_CODIGO_PROV <> 0
                                 AND EMPL_TIPO_CONT <> ''T''
                                 AND EMPL_FORMA_PAGO <> 0
                                 AND EMPL_EMPRESA = 2
                                 and mes is null
                              AND SEMANA ||''/''|| ANHO ='''||V_SEMANA||'''
                                 GROUP BY DPTO_DESC, DPTO_CODIGO) A,
                                 (SELECT DPTO_CODIGO||'' - ''||DECODE(DPTO_CODIGO,29,''P.J.C'',DPTO_DESC) DEPARTAMENTO,
                                         ''ANTERIOR'' INDICADOR,
                                         SUM(CASE
                                               WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= TO_DATE('''||P_FECHA||''')-7 THEN
                                                1
                                               WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= TO_DATE('''||P_FECHA||''')-7 AND
                                                    EMPL_FEC_SALIDA > TO_DATE('''||P_FECHA||''')-7 THEN
                                                   1
                                                ELSE
                                                       0
                                            END) TOTAL_ACT
                             FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                           WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                             AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                             AND EMPL_CODIGO_PROV <> 0
                             AND EMPL_TIPO_CONT <> ''T''
                             AND EMPL_FORMA_PAGO <> 0
                             AND EMPL_EMPRESA = 2
                             and mes is null
                             AND SEMANA ||''/''|| ANHO ='''||V_SEMANA_ANT||'''
                             GROUP BY DPTO_DESC, DPTO_CODIGO) B
                        WHERE A.DEPARTAMENTO= B.DEPARTAMENTO ';
  END IF;

   IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DOT_CANTIDAD') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DOT_CANTIDAD');
   END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DOT_CANTIDAD',
                                                                P_QUERY           => P_QUERY1);


    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DOT_SEMANA') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DOT_SEMANA');
   END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DOT_SEMANA',
                                                                P_QUERY           => P_QUERY2);



 END PP_DOTACION;

 PROCEDURE PP_VAC_SEL_CONT (P_EMPRESA IN NUMBER,
                            P_FECHA IN DATE) IS

   P_QUERY     VARCHAR2(21000);
   P_QUERY2    VARCHAR2(21000);
   P_QUERY7    VARCHAR2(21000);
   P_QUERY3    VARCHAR2(21000);
   P_QUERY8    VARCHAR2(21000);
   P_QUERY10   VARCHAR2(21000);
   P_QUERY11   VARCHAR2(21000);
   P_QUERY12   VARCHAR2(21000);
   P_QUERY13   VARCHAR2(21000);
   V_MES3            VARCHAR2(60);
   V_MES2            VARCHAR2(60);
   V_MES1            VARCHAR2(60);
   V_SEMANA          VARCHAR2(60);
   V_FECHA1          DATE;
   V_FECHA2          DATE;
   
   l_and varchar2(2000);
   
 BEGIN
  
  SELECT  TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY'),
         TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)),'DD/MM/YYYY'),
         TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)),'DD/MM/YYYY')
   INTO V_MES1, V_MES2, V_MES3,V_SEMANA,V_FECHA1, V_FECHA2
  FROM DUAL;

    P_QUERY2:='SELECT
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY''),
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY''),
                 TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
              FROM DUAL';

  P_QUERY :='SELECT decode (D.DETALLE,''ANTICIPADA/DIRECTA'',3,4) ORDEN,
               D.DETALLE,
               ''Q'' UM,
               NULL PB,
               MES1,
               MES2,
               MES3,
               '''||V_MES1||''',
               '''||V_MES2||''',
               '''||V_MES3||'''
          FROM (SELECT SUM(SOLPER_CANT) MES1,
                       DECODE(T.SOLPER_TIPO_SELEC, ''PR'', ''PROGRAMADA'', ''ANTICIPADA'') || ''/'' ||
                       DECODE(T.SOLPER_TIPO_CONTRATACION, ''PR'', ''PROGRAMADA'', ''DIRECTA'') DETALLE1
                  FROM PER_SOLICITUD_PERSONAL_HIST T
                 WHERE TO_CHAR(T.SOLPER_FECHA_APROB, ''MM/YYYY'') = '''||V_MES1||'''
                  AND T.SOLPER_ESTADO_APROB = ''C''
                   AND T.MES || ''/'' || ANHO = '''||V_MES1||'''
                   GROUP BY DECODE(T.SOLPER_TIPO_SELEC, ''PR'', ''PROGRAMADA'', ''ANTICIPADA'') || ''/'' ||
                          DECODE(T.SOLPER_TIPO_CONTRATACION, ''PR'', ''PROGRAMADA'', ''DIRECTA'')) A,
               (SELECT SUM(SOLPER_CANT) MES2,
                       DECODE(T.SOLPER_TIPO_SELEC, ''PR'', ''PROGRAMADA'', ''ANTICIPADA'') || ''/'' ||
                       DECODE(T.SOLPER_TIPO_CONTRATACION, ''PR'', ''PROGRAMADA'', ''DIRECTA'') DETALLE2
                  FROM PER_SOLICITUD_PERSONAL_HIST T
                 WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') = '''||V_MES2||'''
                   AND T.MES || ''/'' || ANHO = '''||V_MES2||'''
                   AND T.SOLPER_ESTADO_APROB = ''C''
                   GROUP BY DECODE(T.SOLPER_TIPO_SELEC, ''PR'', ''PROGRAMADA'', ''ANTICIPADA'') || ''/'' ||
                          DECODE(T.SOLPER_TIPO_CONTRATACION, ''PR'', ''PROGRAMADA'', ''DIRECTA'')) B,
               (SELECT SUM(SOLPER_CANT) MES3,
                       DECODE(T.SOLPER_TIPO_SELEC, ''PR'', ''PROGRAMADA'', ''ANTICIPADA'') || ''/'' ||
                       DECODE(T.SOLPER_TIPO_CONTRATACION, ''PR'', ''PROGRAMADA'', ''DIRECTA'') DETALLE3
                  FROM PER_SOLICITUD_PERSONAL_HIST T
                 WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') = '''||V_MES3||'''
                   AND SEMANA || ''/'' || ANHO ='''||V_SEMANA||'''
                   AND T.SOLPER_ESTADO_APROB = ''C''
                   GROUP BY DECODE(T.SOLPER_TIPO_SELEC, ''PR'', ''PROGRAMADA'', ''ANTICIPADA'') || ''/'' ||
                          DECODE(T.SOLPER_TIPO_CONTRATACION, ''PR'', ''PROGRAMADA'', ''DIRECTA'')) C,
           (SELECT ''PROGRAMADA/PROGRAMADA'' DETALLE FROM DUAL
           UNION ALL
           SELECT ''ANTICIPADA/DIRECTA''  DETALLE FROM DUAL) D
         WHERE D.DETALLE =DETALLE1(+)
         AND D.DETALLE =DETALLE2(+)
         AND D.DETALLE =DETALLE3(+)
         UNION ALL
         SELECT 6 ORDEN, ''ACUMULADAS'' DETALLE, ''Q''UM ,NULL PB,NVL(MES1,0), NVL(MES2,0), NVL(MES3,0), null, null, null
                         FROM
                          (select sum(MES1) MES1 from
                          (SELECT SUM(CASE
                                       WHEN T.SOLPER_FECHA_SOL <=LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -3)) THEN
                                       (SOLPER_CANT)
                                     END) MES1
                                     FROM PER_SOLICITUD_PERSONAL_HIST T
                                    WHERE  T.MES || ''/'' || ANHO =  '''||V_MES1||'''
                                     AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                                    AND T.SOLPER_ESTADO_APROB = ''C''
                                    union all
                                    SELECT count(*) MES1
                                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                                         PER_AREA_DPP                AR,
                                         PER_CARGO                   PC,
                                         PER_SELECCION_PERSONAL_HIST SEL,
                                         PER_CONTRATO_PROC_SEL       CON
                                   WHERE SOL.SOLPER_EMPR = 1
                                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                                     AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI(+)
                                     AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL(+)
                                     AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR(+)
                                     AND SEL.SELEPER_ESTADO_GRAL = ''C''
                                     AND SOLPER_ESTADO_FINAL = ''F''
                                     AND SOL.MES||''/''||SOL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                                     AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                                     AND SOLPER_FECHA_APROB  < ''01/''||TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                                     and CONSEL_FECHA_INICIO >= ''01/''||TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')))A,
                            ( select SUM(MES2) MES2
                            FROM( select SUM(CASE
                                               WHEN T.SOLPER_FECHA_SOL <=LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                                               (SOLPER_CANT)
                                             END) MES2--, ''b'',''VACANCIAS ACUM.''
                                     from per_solicitud_personal_hist T
                                    WHERE t.mes || ''/'' || anho =  '''||V_MES2||'''
                                      AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                                    AND T.SOLPER_ESTADO_APROB = ''C''
                                    union all
                                    SELECT count(*) MES2
                                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                                         PER_AREA_DPP                AR,
                                         PER_CARGO                   PC,
                                         PER_SELECCION_PERSONAL_HIST SEL,
                                         PER_CONTRATO_PROC_SEL       CON
                                   WHERE SOL.SOLPER_EMPR = 1
                                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                                     AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI(+)
                                     AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL(+)
                                     AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR(+)
                                     AND SEL.SELEPER_ESTADO_GRAL = ''C''
                                     AND SOLPER_ESTADO_FINAL = ''F''
                                     AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)
                                     AND SOL.MES||''/''||SOL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                                     AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                                     AND SOLPER_FECHA_APROB  < ''01/''||TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                                     and CONSEL_FECHA_INICIO >= ''01/''||TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY''))
                                     )B,
                             (select SUM(MES3) MES3
                            FROM (select SUM(CASE
                                               WHEN T.SOLPER_FECHA_SOL <=LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                                               (SOLPER_CANT)
                                             END)MES3--, ''C'',''VACANCIAS ACUM.''
                                     from per_solicitud_personal_hist T
                                    WHERE  semana || ''/'' || anho ='''||V_SEMANA||'''
                                        AND NVL(SOLPER_ESTADO_FINAL,''EP'') = ''EP''
                                    AND T.SOLPER_ESTADO_APROB = ''C''
                                    union all
                                    SELECT count(*) MES3
                                    FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                                         PER_AREA_DPP                AR,
                                         PER_CARGO                   PC,
                                         PER_SELECCION_PERSONAL_HIST SEL,
                                         PER_CONTRATO_PROC_SEL       CON
                                   WHERE SOL.SOLPER_EMPR = 1
                                     AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                                     AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                                     AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                                     AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                                     AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                                     AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                                     AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI(+)
                                     AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL(+)
                                     AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR(+)
                                     AND SEL.SELEPER_ESTADO_GRAL = ''C''
                                     AND SOLPER_ESTADO_FINAL = ''F''
                                     AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)
                                     AND SOL.semana||''/''||SOL.ANHO ='''||V_SEMANA||'''
                                     AND SEL.semana||''/''||SEL.ANHO ='''||V_SEMANA||'''
                                     AND SOLPER_FECHA_APROB  < ''01/''||TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
                                     and CONSEL_FECHA_INICIO >= ''01/''||TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')))

           UNION ALL
           SELECT 5 ORDEN, ''RECHAZADO'' DETALLE, ''Q''UM,NULL PB, MES1, MES2, MES3, NULL, NULL, NULL
                         FROM
                          (SELECT SUM(SOLPER_CANT) MES1
                           FROM PER_SOLICITUD_PERSONAL_HIST T
                          WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') ='''||V_MES1||'''
                          AND T.SOLPER_ESTADO_APROB = ''R''
                           AND T.MES || ''/'' || ANHO = '''||V_MES1||''') A ,
                           ( SELECT SUM(SOLPER_CANT) MES2
                                     FROM PER_SOLICITUD_PERSONAL_HIST T
                                    WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') ='''||V_MES2||'''
                                    AND T.SOLPER_ESTADO_APROB = ''R''
                                      AND T.MES || ''/'' || ANHO ='''||V_MES2||''')B,
                           (SELECT SUM(SOLPER_CANT) MES3
                                     FROM PER_SOLICITUD_PERSONAL_HIST T
                                    WHERE TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') ='''||V_MES3||'''
                                    AND T.SOLPER_ESTADO_APROB = ''R''
                                      AND SEMANA || ''/'' || ANHO = '''||V_SEMANA||''') C
           ORDER BY 1';


   P_QUERY7 := ' SELECT   1 Q_VACANT,
                         SOL.SOLPER_CLAVE NRO_SOL,
                         TO_CHAR(seleper_fecha_estado_gral, ''MON/YYYY'') MES_ANHO,
                         AR.AREDPP_DESC AREA,
                         CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')  THEN
                         DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                         ELSE
                           ''ACUMULADAS''
                         END  TIPO_CONTRATACION,
                          CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')  THEN
                         DECODE(SOLPER_TIPO_SELEC,''PR'',''PROGRAMADA/PROGRAMADA'',''AN'',''ANTICIPADA/DIRECTA'', ''RC'', ''Re-Contratacion'')
                         ELSE
                           ''ACUMULADAS''
                         END  TIPO_SELEC_SOL,
                         SOL.SOLPER_CARGO,
                         SOLPER_FECHA_SOL,
                         SOL.SOLPER_OPERADOR_SOL,
                         DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                         DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                         DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                         SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                         SOLPER_FECHA_APROB FECHA_APROB_SOL,
                         DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                         1 ORDEN,
                         TO_CHAR(seleper_fecha_estado_gral, ''MM/YYYY'') MES_ANHOG
                      FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                           PER_AREA_DPP                AR,
                           PER_CARGO                   PC,
                           PER_SELECCION_PERSONAL_HIST SEL,
                           PER_CONTRATO_PROC_SEL       CON
                     WHERE SOL.SOLPER_EMPR = 1
                       AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                       AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                       AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                       AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                       AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                       AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                       AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                       AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                       AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                       AND SEL.SELEPER_ESTADO_GRAL = ''C''
                       AND SOLPER_ESTADO_FINAL = ''F''
                       AND SOLPER_TIPO_SELEC <> ''RC''
                       AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)---SON ALGUNOS QUE MARCEK HABIA CERRADO ESTADO Y QUE LA FECHA DE CONTRATACION FUE ATNES DE LA FECHA DE CIERRE
                       AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                       AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                       AND TO_CHAR(sel.seleper_fecha_estado_gral,''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                       UNION ALL
                       SELECT   1 Q_VACANT,
                         SOL.SOLPER_CLAVE NRO_SOL,
                         TO_CHAR(seleper_fecha_estado_gral, ''MON/YYYY'') MES_ANHO,
                         AR.AREDPP_DESC AREA,
                         CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')  THEN
                         DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                         ELSE
                           ''ACUMULADAS''
                         END  TIPO_CONTRATACION,
                          CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')  THEN
                         DECODE(SOLPER_TIPO_SELEC,''PR'',''PROGRAMADA/PROGRAMADA'',''AN'',''ANTICIPADA/DIRECTA'', ''RC'', ''Re-Contratacion'')
                         ELSE
                           ''ACUMULADAS''
                         END  TIPO_SELEC_SOL,
                         SOL.SOLPER_CARGO,
                         SOLPER_FECHA_SOL,
                         SOL.SOLPER_OPERADOR_SOL,
                         DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                         DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                         DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                         SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                         SOLPER_FECHA_APROB FECHA_APROB_SOL,
                         DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                         2 ORDEN,
                         TO_CHAR(seleper_fecha_estado_gral, ''MM/YYYY'') MES_ANHOG
                      FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                           PER_AREA_DPP                AR,
                           PER_CARGO                   PC,
                           PER_SELECCION_PERSONAL_HIST SEL,
                           PER_CONTRATO_PROC_SEL       CON
                     WHERE SOL.SOLPER_EMPR = 1
                       AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                       AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                       AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                       AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                       AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                       AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                       AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                       AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                       AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                       AND SEL.SELEPER_ESTADO_GRAL = ''C''
                       AND SOLPER_ESTADO_FINAL = ''F''
                       AND SOLPER_TIPO_SELEC <> ''RC''
                       AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)---SON ALGUNOS QUE MARCEK HABIA CERRADO ESTADO Y QUE LA FECHA DE CONTRATACION FUE ATNES DE LA FECHA DE CIERRE
                       AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                       AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                       AND TO_CHAR(sel.seleper_fecha_estado_gral,''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')

                    UNION ALL
                      SELECT   1 Q_VACANT,
                         SOL.SOLPER_CLAVE NRO_SOL,
                         TO_CHAR(seleper_fecha_estado_gral, ''MON/YYYY'') MES_ANHO,
                         AR.AREDPP_DESC AREA,
                         CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  THEN
                         DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''Programada'',''DR'',''Directa'',''RC'',''Re-Contratacion'')
                         ELSE
                           ''ACUMULADAS''
                         END  TIPO_CONTRATACION,
                          CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'') THEN
                         DECODE(SOLPER_TIPO_SELEC,''PR'',''PROGRAMADA/PROGRAMADA'',''AN'',''ANTICIPADA/DIRECTA'', ''RC'', ''Re-Contratacion'')
                         ELSE
                           ''ACUMULADAS''
                         END  TIPO_SELEC_SOL,
                         SOL.SOLPER_CARGO,
                         SOLPER_FECHA_SOL,
                         SOL.SOLPER_OPERADOR_SOL,
                         DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                         DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                         DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                         SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                         SOLPER_FECHA_APROB FECHA_APROB_SOL,
                         DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                         3 ORDEN,
                         TO_CHAR(seleper_fecha_estado_gral, ''MM/YYYY'') MES_ANHOG
                      FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                           PER_AREA_DPP                AR,
                           PER_CARGO                   PC,
                           PER_SELECCION_PERSONAL_HIST SEL,
                           PER_CONTRATO_PROC_SEL       CON
                     WHERE SOL.SOLPER_EMPR = 1
                       AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                       AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                       AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                       AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                       AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                       AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                       AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                       AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                       AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                       AND SEL.SELEPER_ESTADO_GRAL = ''C''
                       AND SOLPER_ESTADO_FINAL = ''F''
                       AND SOLPER_TIPO_SELEC <> ''RC''
                       AND SOL.SOLPER_CLAVE NOT IN (439,444,445,448,452,460,466)---SON ALGUNOS QUE MARCEK HABIA CERRADO ESTADO Y QUE LA FECHA DE CONTRATACION FUE ATNES DE LA FECHA DE CIERRE
                       AND SOL.SEMANA||''/''||SOL.ANHO =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')
                       AND SEL.SEMANA||''/''||SEL.ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')
                       AND TO_CHAR(sel.seleper_fecha_estado_gral,''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')';



        P_QUERY10 :=  ' SELECT   1 Q_VACANT,
                           SOL.SOLPER_CLAVE NRO_SOL,
                           TO_CHAR(CONSEL_FECHA_INICIO, ''MON/YYYY'') MES_ANHO,
                           AR.AREDPP_DESC AREA,
                           CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')  THEN
                           DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''PROGRAMADA/PROGRAMADA'',''DR'',''ANTICIPADA/DIRECTA'',''RC'',''Re-Contratacion'')
                           ELSE
                             ''ACUMULADAS''
                           END  TIPO_CONTRATACION,
                            CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')  THEN
                           DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                           ELSE
                             ''ACUMULADAS''
                           END  TIPO_SELEC_SOL,
                           SOL.SOLPER_CARGO,
                           SOLPER_FECHA_SOL,
                           SOL.SOLPER_OPERADOR_SOL,
                           DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                           DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                           DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                           SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                           SOLPER_FECHA_APROB FECHA_APROB_SOL,
                           DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                           1 ORDEN,
                           TO_CHAR(CONSEL_FECHA_INICIO, ''MM/YYYY'') MES_ANHOG
                        FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                             PER_AREA_DPP                AR,
                             PER_CARGO                   PC,
                             PER_SELECCION_PERSONAL_HIST SEL,
                             PER_CONTRATO_PROC_SEL       CON
                       WHERE SOL.SOLPER_EMPR = 1
                         AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                         AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                         AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                         AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                         AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                         AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                         AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                         AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                         AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                         AND SEL.SELEPER_ESTADO_GRAL = ''C''
                         AND SOLPER_ESTADO_FINAL = ''F''
                         AND SOLPER_TIPO_SELEC <>''RC''
                         AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                         AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                         AND TO_CHAR(CON.CONSEL_FECHA_INICIO,''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY'')
                    UNION ALL
                      SELECT   1 Q_VACANT,
                           SOL.SOLPER_CLAVE NRO_SOL,
                           TO_CHAR(CONSEL_FECHA_INICIO, ''MON/YYYY'') MES_ANHO,
                           AR.AREDPP_DESC AREA,
                           CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')  THEN
                           DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''PROGRAMADA/PROGRAMADA'',''DR'',''ANTICIPADA/DIRECTA'',''RC'',''Re-Contratacion'')
                           ELSE
                             ''ACUMULADAS''
                           END  TIPO_CONTRATACION,
                            CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')  THEN
                           DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                           ELSE
                             ''ACUMULADAS''
                           END  TIPO_SELEC_SOL,
                           SOL.SOLPER_CARGO,
                           SOLPER_FECHA_SOL,
                           SOL.SOLPER_OPERADOR_SOL,
                           DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                           DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                           DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                           SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                           SOLPER_FECHA_APROB FECHA_APROB_SOL,
                           DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                           2 ORDEN,
                           TO_CHAR(CONSEL_FECHA_INICIO, ''MM/YYYY'') MES_ANHOG
                        FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                             PER_AREA_DPP                AR,
                             PER_CARGO                   PC,
                             PER_SELECCION_PERSONAL_HIST SEL,
                             PER_CONTRATO_PROC_SEL       CON
                       WHERE SOL.SOLPER_EMPR = 1
                         AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                         AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                         AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                         AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                         AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                         AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                         AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                         AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                         AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                         AND SEL.SELEPER_ESTADO_GRAL = ''C''
                         AND SOLPER_ESTADO_FINAL = ''F''
                         AND SOLPER_TIPO_SELEC <>''RC''
                         AND SOL.MES||''/''||SOL.ANHO = TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                         AND SEL.MES||''/''||SEL.ANHO =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                         AND TO_CHAR(CON.CONSEL_FECHA_INICIO,''MM/YYYY'') =TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY'')
                    UNION ALL
                     SELECT   1 Q_VACANT,
                           SOL.SOLPER_CLAVE NRO_SOL,
                           TO_CHAR(CONSEL_FECHA_INICIO, ''MON/YYYY'') MES_ANHO,
                           AR.AREDPP_DESC AREA,
                           CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  THEN
                           DECODE(SOLPER_TIPO_CONTRATACION,''PR'',''PROGRAMADA/PROGRAMADA'',''DR'',''ANTICIPADA/DIRECTA'',''RC'',''Re-Contratacion'')
                           ELSE
                             ''ACUMULADAS''
                           END  TIPO_CONTRATACION,
                            CASE  WHEN TO_CHAR(SOLPER_FECHA_SOL, ''MM/YYYY'') =TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  THEN
                           DECODE(SOLPER_TIPO_SELEC,''PR'',''Programada'',''AN'',''Anticipada'', ''RC'', ''Re-Contratacion'')
                           ELSE
                             ''ACUMULADAS''
                           END  TIPO_SELEC_SOL,
                           SOL.SOLPER_CARGO,
                           SOLPER_FECHA_SOL,
                           SOL.SOLPER_OPERADOR_SOL,
                           DECODE(SOLPER_NIVEL_URGENCIA,''M'',''MEDIO'',''A'',''ALTO'',''B'',''BAJO'') URGENCIA,
                           DECODE(SOLPER_TIPO_CONT,''IN'',''Indefinido'',''TE'',''Temporal'') TIPO_CONTRATO,
                           DECODE(SOLPER_ESTADO_APROB,''C'',''Confirmado'',''P'',''Pendiente'',''R'',''Rechazado'',NULL,''Pendiente'') ESTADO_APROB_SOL,
                           SOLPER_OPERADOR_APROB OPERADOR_APROB_SOL,
                           SOLPER_FECHA_APROB FECHA_APROB_SOL,
                           DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'', ''ER'', ''En Reclutamiento'', ''A'',''Anulado'') ESTADO_FIN_SOL,
                           3 ORDEN,
                           TO_CHAR(CONSEL_FECHA_INICIO, ''MM/YYYY'') MES_ANHOG
                        FROM PER_SOLICITUD_PERSONAL_HIST SOL,
                             PER_AREA_DPP                AR,
                             PER_CARGO                   PC,
                             PER_SELECCION_PERSONAL_HIST SEL,
                             PER_CONTRATO_PROC_SEL       CON
                       WHERE SOL.SOLPER_EMPR = 1
                         AND SOL.SOLPER_EMPR = AR.AREDPP_EMPR
                         AND SOL.SOLPER_AREA = AR.AREDPP_CLAVE
                         AND SOL.SOLPER_EMPR = PC.CAR_EMPR
                         AND SOL.SOLPER_CARGO = PC.CAR_CODIGO
                         AND SOL.SOLPER_EMPR = SEL.SELEPER_EMPR
                         AND SOL.SOLPER_CLAVE = SEL.SELPER_SOLICI
                         AND SEL.SELPER_SOLICI = CON.CONSEL_SOLI
                         AND SEL.SELPER_POSTUL = CON.CONSEL_POSTUL
                         AND SEL.SELEPER_EMPR = CON.CONSEL_EMPR
                         AND SEL.SELEPER_ESTADO_GRAL = ''C''
                         AND SOLPER_ESTADO_FINAL = ''F''
                         AND SOLPER_TIPO_SELEC <>''RC''
                         AND SOL.SEMANA||''/''||SOL.ANHO = TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')
                         AND SEL.SEMANA||''/''||SEL.ANHO =TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')
                         AND TO_CHAR(CON.CONSEL_FECHA_INICIO,''MM/YYYY'') = TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')';


       P_QUERY3 :='SELECT ''ANTICIPADA/DIRECTA'',3
                  FROM DUAL
                  UNION ALL
                  SELECT ''PROGRAMADA/PROGRAMADA'', 4
                   FROM DUAL
                  UNION ALL
                  SELECT ''ACUMULADAS'', 6
                  FROM DUAL
                  UNION ALL
                  SELECT ''RECHAZADO'', 5
                  FROM DUAL  ';

     IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'VACANCIA_MES') THEN
        APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'VACANCIA_MES');
     END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'VACANCIA_MES',
                                                       P_QUERY           => P_QUERY);

      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'FECHA_VSC') THEN
         APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'FECHA_VSC');
       END IF;
          APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'FECHA_VSC',
                                      P_QUERY           => P_QUERY2);

     IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SEL_SELECCION_DET') THEN
        APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SEL_SELECCION_DET');
     END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SEL_SELECCION_DET',
                                                       P_QUERY           => P_QUERY3);

     IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SEL_SELECCION_MES') THEN
        APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SEL_SELECCION_MES');
     END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SEL_SELECCION_MES',
                                                        P_QUERY           => P_QUERY7);

     IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SEL_CONTRATACION_MES') THEN
        APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SEL_CONTRATACION_MES');
     END IF;
        APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SEL_CONTRATACION_MES',
                                                       P_QUERY           => P_QUERY10);

        P_QUERY8:='SELECT SUM(C001) VACA,
                C004 AREA,
                C003 MES,
                C006 TIPO_SELEC,
                SUM(SUM(C001)) OVER(PARTITION BY C004, C003 ORDER BY C003) TOTAL_VAC_AREA,
                ROUND(SUM(C001)/NVL(SUM(SUM(C001)) OVER(PARTITION BY C004, C003 ORDER BY C003), 1) * 100) POR_CONT,
                C016 ORDEN,
                 CASE
                    WHEN C006 = ''ANTICIPADA/DIRECTA'' AND C016 = 1 THEN
                    SUM(C001)
                    WHEN C006 = ''PROGRAMADA/PROGRAMADA'' AND C016= 1 THEN
                    SUM(C001)
                     WHEN C006 = ''ACUMULADAS'' AND C016 = 1 THEN
                    SUM(C001)
                 END MES1_CONT,
                CASE
                    WHEN C006 = ''ANTICIPADA/DIRECTA'' AND C016 = 2 THEN
                    SUM(C001)
                    WHEN C006 = ''PROGRAMADA/PROGRAMADA'' AND C016= 2 THEN
                    SUM(C001)
                    WHEN C006 = ''ACUMULADAS'' AND C016 = 2 THEN
                    SUM(C001)
                 END MES2_CONT,
                CASE
                    WHEN C006 = ''ANTICIPADA/DIRECTA'' AND C016 = 3 THEN
                    SUM(C001)
                    WHEN C006 = ''PROGRAMADA/PROGRAMADA'' AND C016= 3 THEN
                    SUM(C001)
                    WHEN C006 = ''ACUMULADAS'' AND C016 = 3 THEN
                    SUM(C001)
               END MES3_CONT
                FROM APEX_collections
                WHERE collection_name = ''SEL_SELECCION_MES''
                GROUP BY C004 , C003, C006,C016';





        P_QUERY11:='SELECT SUM(C001) VACA,
                C004 AREA,
                C003 MES,
                C005 TIPO_CONT,
                SUM(SUM(C001)) OVER(PARTITION BY C004, C003 ORDER BY C003) TOTAL_VAC_AREA,
                ROUND(SUM(C001) /NVL(SUM(SUM(C001)) OVER(PARTITION BY C004, C003 ORDER BY C003), 1) * 100) POR_CONT,
                C016 ORDEN,
                 CASE
                    WHEN C005 = ''ANTICIPADA/DIRECTA'' AND C016 = 1 THEN
                    SUM(C001)
                    WHEN C005 = ''PROGRAMADA/PROGRAMADA'' AND C016= 1 THEN
                    SUM(C001)
                    WHEN C005 = ''ACUMULADAS'' AND C016 = 1 THEN
                    SUM(C001)
                 END MES1_CONT,
                CASE
                    WHEN C005 = ''ANTICIPADA/DIRECTA'' AND C016 = 2 THEN
                    SUM(C001)
                    WHEN C005 = ''PROGRAMADA/PROGRAMADA'' AND C016= 2 THEN
                    SUM(C001)
                   WHEN C005 = ''ACUMULADAS'' AND C016 = 2 THEN
                    SUM(C001)
                 END MES2_CONT,
                CASE
                    WHEN C005 = ''ANTICIPADA/DIRECTA'' AND C016 = 3 THEN
                    SUM(C001)
                    WHEN C005 = ''PROGRAMADA/PROGRAMADA'' AND C016= 3 THEN
                    SUM(C001)
                    WHEN C005 = ''ACUMULADAS'' AND C016 = 3 THEN
                    SUM(C001)
               END MES3_CONT
                FROM APEX_collections
                WHERE collection_name = ''SEL_CONTRATACION_MES''
                GROUP BY C004 , C003, C005,C016';


    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SELECCION_SECTT') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SELECCION_SECTT');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SELECCION_SECTT',
                                                      P_QUERY           => P_QUERY8);


    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'SELECCION_CONTT') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'SELECCION_CONTT');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'SELECCION_CONTT',
                                                      P_QUERY           => P_QUERY11);




     P_QUERY12:= 'SELECT SUM(T.SOLPER_CANT),
                          A.AREDPP_DESC,
                          TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),
                          DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FINAL,
                          1 fecha,
                          A.AREDPP_CLAVE
                       FROM PER_SOLICITUD_PERSONAL_HIST T, PER_AREA_DPP A
                      WHERE T.SOLPER_AREA = A.AREDPP_CLAVE
                        AND T.SOLPER_EMPR = A.AREDPP_EMPR
                        AND TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') =  '''||V_MES1||'''
                        AND T.MES || ''/'' || ANHO =  '''||V_MES1||'''
                        GROUP BY AREDPP_DESC,A.AREDPP_CLAVE,TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),  SOLPER_ESTADO_FINAL
                       UNION ALL
                     SELECT   SUM(T.SOLPER_CANT),
                              A.AREDPP_DESC,
                              TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),
                              DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FINAL,
                              2 fecha,
                              A.AREDPP_CLAVE
                       FROM PER_SOLICITUD_PERSONAL_HIST T, PER_AREA_DPP A
                      WHERE T.SOLPER_AREA = A.AREDPP_CLAVE(+)
                        AND T.SOLPER_EMPR = A.AREDPP_EMPR
                        AND TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY'') =  '''||V_MES2||'''
                        AND T.MES || ''/'' || ANHO =  '''||V_MES2||'''
                        GROUP BY AREDPP_DESC,A.AREDPP_CLAVE,TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),  SOLPER_ESTADO_FINAL
                       UNION ALL
                          SELECT SUM(T.SOLPER_CANT),
                           A.AREDPP_DESC,
                           TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),
                           DECODE(SOLPER_ESTADO_FINAL,''F'',''Finalizado'',''EP'',''En Proceso'',''R'',''Rechazado'',''P'',''Pendiente'',''EE'',''En Espera'') ESTADO_FINAL,
                           3 fecha,
                           A.AREDPP_CLAVE
                           FROM PER_SOLICITUD_PERSONAL_HIST T, PER_AREA_DPP A
                          WHERE T.SOLPER_AREA = A.AREDPP_CLAVE(+)
                            AND T.SOLPER_EMPR = A.AREDPP_EMPR
                            AND TO_CHAR(T.SOLPER_FECHA_APROB, ''MM/YYYY'') = '''||V_MES3||'''
                        AND SEMANA || ''/'' || ANHO =  '''||V_SEMANA||'''
                        GROUP BY AREDPP_DESC,A.AREDPP_CLAVE,TO_CHAR(SOLPER_FECHA_APROB, ''MM/YYYY''),  SOLPER_ESTADO_FINAL';



    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'VAC_DEPARTAMENTO2') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'VAC_DEPARTAMENTO2');
    END IF;
    
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'VAC_DEPARTAMENTO2',
                                                      P_QUERY           => P_QUERY12);

 END   PP_VAC_SEL_CONT;


 PROCEDURE PP_MARCACION_NUEVO (P_EMPRESA      IN NUMBER,
                               P_FECHA        IN DATE) IS

   V_SEMANA1     VARCHAR2(10);
   V_SEMANA2     VARCHAR2(10);
   V_SEMANA3     VARCHAR2(10);
   P_QUERY       VARCHAR2(21000);
   P_QUERY2      VARCHAR2(21000);
   P_QUERY3      VARCHAR2(21000);
    P_QUERY5      VARCHAR2(21000);
   P_QUERY30     VARCHAR2(21000);
   P_QUERY31     VARCHAR2(21000);
   P_QUERY50     VARCHAR2(21000);
   P_QUERY51     VARCHAR2(21000);
   V_MES3        VARCHAR2(60);
   V_MES2        VARCHAR2(60);
   V_MES1        VARCHAR2(60);
 BEGIN


              SELECT     --------------------MES
                     TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA,'DD/MM/YYYY'), -2),'MM/YYYY')MES3,--3
                     TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA,'DD/MM/YYYY'), -1),'MM/YYYY')MES4,--4
                     TO_CHAR(TO_DATE(P_FECHA,'DD/MM/YYYY'),'MM/YYYY')MES5,                --5
                     --------------------SEMANA

                       CASE ---8
                            WHEN (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-2) = 0 THEN   52
                            WHEN (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-2) = -1 THEN  51
                            WHEN (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-2) = -2 THEN  50
                            WHEN (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-4) = -3 THEN  49
                            ELSE (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-2)
                       END SEM3,
                       CASE--9
                            WHEN (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-1) = 0 THEN   52
                            WHEN (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-1) = -1 THEN  51
                            WHEN (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-1) = -2 THEN  50
                            WHEN (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-4) = -3 THEN  49
                            ELSE (TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA),'IW'))-1)
                       END SEM2,
                        TO_NUMBER(TO_CHAR(TO_DATE(P_FECHA), 'IW')) SEM1

                   INTO V_MES1,V_MES2,V_MES3,V_SEMANA1,V_SEMANA2, V_SEMANA3

                   FROM DUAL;





    P_QUERY := 'SELECT FECHA_HOR,
                       FECHA_FILTRO,
                       EMPL_LEGAJO,
                       EMPLEADO,
                       CARGO,
                       DESC_SUCURSAL,
                       DEPARTAMENTO,
                       EMPL_FORMA_PAGO,
                       DEPARTAMENTO2,
                       MARC_FECHA,
                       ENTRADA_HOR,
                       SALIDA_HOR,
                       SALIDA_ALM,
                       ENTR_ALM,
                       ENTRADA,
                       SALIDA,
                       SALIDA_ALMUERZO,
                       ENTRADA_ALMUERZO,
                       ENTRADA_HORA,
                       SALIDA_HORA,
                       SALIDA_ALMUERZO_HORA,
                       ENTRADA_ALMUERZO_HORA,
                       JSA_COD_AREA,
                       JSA_DESC_AREA,
                       CASE
                         WHEN T.ENTRADA IS NULL AND T.SALIDA IS NULL THEN
                          1
                         ELSE
                          0
                       END AUSENTE,
                       CASE
                         WHEN ENTRADA_HORA > ENTRADA_HOR THEN
                          1
                         ELSE
                          0
                       END IMPUNTUAL,
                      to_Char(FECHA_HOR,''MM/YYYY''),
                       to_Char(FECHA_HOR,''IW'')
                  from CUBO_CUMPLIMIENTO_MARCACIONES T
                 WHERE T.FECHA_HOR BETWEEN ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2) AND '''||P_FECHA||'''
                 AND T.SITUACION = ''ACTIVO''';



    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MARCACION') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MARCACION');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MARCACION',
                                                      P_QUERY           => P_QUERY);


         P_QUERY2:='SELECT
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-2),''MM/YYYY''),
                 TO_CHAR(ADD_MONTHS(TO_DATE('''||P_FECHA||'''),-1),''MM/YYYY''),
                 TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')
              FROM DUAL';



        P_QUERY3 :='SELECT ''ADM'',2
                  FROM DUAL
                  UNION ALL
                  SELECT ''FIN E INFO'', 1
                   FROM DUAL
                  UNION ALL
                  SELECT ''INDUSTRIAL'', 5
                  FROM DUAL
                  UNION ALL
                  SELECT ''CDA'', 3
                  FROM DUAL
                  UNION ALL
                  SELECT ''COMERCIAL'', 4
                  FROM DUAL
                 UNION ALL
                  SELECT ''NIVEL DE AUSENTISMO'', 0
                  FROM DUAL
                  UNION ALL
                  SELECT ''PUNTUALIDAD'', 0
                  FROM DUAL        ';


    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MAR_FECHA') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MAR_FECHA');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MAR_FECHA',
                                                      P_QUERY           => P_QUERY2);


     IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MAR_DETALLE') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MAR_DETALLE');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MAR_DETALLE',
                                                      P_QUERY           => P_QUERY3);






    ----------------------------------------------MESES



 P_QUERY30 := '  SELECT 0 ORDEN, ''INDICADOR'' DETALLE,  '''||V_MES1||''' , '''||V_MES2||''', '''||V_MES3||'''
                  FROM DUAL
                 UNION ALL
                 SELECT F.ORDEN, F.DETALLE,  MES1, MES2, DECODE(F.ORDEN,0,D.MES3,C.MES3)
                  FROM
                       (SELECT T.ORDEN, T.TMARC_PROC MES1
                        FROM PER_TABLERO_MARCACION T
                        WHERE T.TMARC_FECHA =  '''||V_MES1||'''
                         AND OPCION = 2
                         AND T.INDICADOR IS NOT NULL) A,
                        (SELECT T.ORDEN, T.TMARC_PROC MES2
                        FROM PER_TABLERO_MARCACION T
                        WHERE T.TMARC_FECHA =  '''||V_MES2||'''
                         AND OPCION = 2
                         AND T.INDICADOR IS NOT NULL) B,
                        (SELECT C023 COD_AREA, TO_CHAR(ROUND((SUM(C025)/COUNT(C025))*100))||''%'' MES3
                           FROM APEX_COLLECTIONS
                          WHERE COLLECTION_NAME = ''MARCACION''
                           AND C027 = '''||V_MES3||'''
                          GROUP BY  C023) C,
                          (SELECT 0 COD_AREA, TO_CHAR(ROUND((SUM(C025)/COUNT(C025))*100))||''%'' MES3
                           FROM APEX_COLLECTIONS
                          WHERE COLLECTION_NAME = ''MARCACION''
                           AND C027 = '''||V_MES3||''') D,
                        (SELECT TO_NUMBER(C002) ORDEN, C001 DETALLE
                             FROM APEX_COLLECTIONS
                             WHERE COLLECTION_NAME = ''MAR_DETALLE''
                             AND C001 <> ''PUNTUALIDAD'') F
                     WHERE F.ORDEN = A.ORDEN(+)
                       AND F.ORDEN = B.ORDEN(+)
                       AND F.ORDEN = C.COD_AREA(+)
                       AND F.ORDEN = D.COD_AREA(+)  ';



P_QUERY31 := '  SELECT 0 ORDEN, ''INDICADOR'' DETALLE,  '''||V_MES1||''' , '''||V_MES2||''', '''||V_MES3||'''
                  FROM DUAL
                 UNION ALL
                 SELECT F.ORDEN, F.DETALLE,  MES1, MES2, DECODE(F.ORDEN,''0'',D.MES3,C.MES3)
                  FROM
                       (SELECT T.ORDEN, T.TMARC_PROC MES1
                        FROM PER_TABLERO_MARCACION T
                        WHERE T.TMARC_FECHA =  '''||V_MES1||'''
                         AND OPCION = 1
                         AND T.INDICADOR IS NOT NULL) A,
                        (SELECT T.ORDEN, T.TMARC_PROC MES2
                        FROM PER_TABLERO_MARCACION T
                        WHERE T.TMARC_FECHA =  '''||V_MES2||'''
                         AND OPCION = 1
                         AND T.INDICADOR IS NOT NULL) B,
                        (SELECT C023 COD_AREA, TO_CHAR(ROUND(((COUNT(C026)-SUM(C026))/COUNT(C026))*100))||''%'' MES3
                           FROM APEX_COLLECTIONS
                          WHERE COLLECTION_NAME = ''MARCACION''
                           AND C027 = '''||V_MES3||'''
                           AND C025 =''0''
                          GROUP BY  C023) C,
                          (SELECT 0 COD_AREA, TO_CHAR(ROUND(((COUNT(C026)-SUM(C026))/COUNT(C026))*100))||''%'' MES3
                           FROM APEX_COLLECTIONS
                          WHERE COLLECTION_NAME = ''MARCACION''
                           AND C027 = '''||V_MES3||'''
                           AND C025 =''0'') D,
                        (SELECT TO_NUMBER(C002) ORDEN, C001 DETALLE
                             FROM APEX_COLLECTIONS
                             WHERE COLLECTION_NAME = ''MAR_DETALLE''
                              AND C001 <> ''NIVEL DE AUSENTISMO'') F
                     WHERE F.ORDEN = A.ORDEN(+)
                       AND F.ORDEN = B.ORDEN(+)
                       AND F.ORDEN = C.COD_AREA(+)
                       AND F.ORDEN = D.COD_AREA(+) ';


    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TABLA_PUNT') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TABLA_PUNT');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TABLA_PUNT',
                                                      P_QUERY           => P_QUERY30);



   IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TABLA_ASIS') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TABLA_ASIS');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'TABLA_ASIS',
                                                      P_QUERY           => P_QUERY31);


 P_QUERY50 :='SELECT TO_NUMBER(T.TMARC_PROC), T.TMARC_DETALLE, TMARC_FECHA, ''a- '',1
              FROM PER_TABLERO_MARCACION T
             WHERE T.TMARC_FECHA = '''||V_MES1||'''
               AND OPCION IN (4)
               AND T.INDICADOR IS NOT NULL
            UNION ALL
            SELECT TO_NUMBER(T.TMARC_PROC), T.TMARC_DETALLE, TMARC_FECHA,''b- '',2
              FROM PER_TABLERO_MARCACION T
             WHERE T.TMARC_FECHA = '''||V_MES2||'''
               AND OPCION IN (4)
                AND T.INDICADOR IS NOT NULL
               UNION ALL
            SELECT TO_NUMBER(T.TMARC_PROC), T.TMARC_DETALLE, TMARC_FECHA, ''d- Sem '',5
              FROM PER_TABLERO_MARCACION T
             WHERE T.TMARC_FECHA ='''||V_SEMANA1||'''
               AND OPCION IN (4)
                AND T.INDICADOR IS NOT NULL
               UNION ALL
             SELECT  TO_NUMBER(T.TMARC_PROC), T.TMARC_DETALLE, TMARC_FECHA, ''e- Sem '',5
              FROM PER_TABLERO_MARCACION T
             WHERE T.TMARC_FECHA = '''||V_SEMANA2||'''
               AND OPCION IN (4)
                AND T.INDICADOR IS NOT NULL
            union all

            SELECT ROUND(((COUNT(C025)-SUM(C025))/COUNT(C025))*100) porc, ''PRESENCIA'','''||V_MES3||''' ,''c- '',3
             FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = ''MARCACION''
             AND C027 = '''||V_MES3||'''
            UNION ALL
            SELECT ROUND((SUM(C025)/COUNT(C025))*100) porc, ''AUSENCIA'', '''||V_MES3||''', ''c- '',3
             FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = ''MARCACION''
             AND C027 = '''||V_MES3||'''

             UNION ALL
            SELECT ROUND(((COUNT(C025)-SUM(C025))/COUNT(C025))*100) porc, ''PRESENCIA'','''||V_SEMANA3||''',''f- Sem '',6
             FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = ''MARCACION''
             AND C028 = '''||V_SEMANA3||'''
            UNION ALL
            SELECT ROUND((SUM(C025)/COUNT(C025))*100) porc, ''AUSENCIA'','''||V_SEMANA3||''', ''f- Sem '',6
             FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = ''MARCACION''
             AND C028 = '''||V_SEMANA3||''' ';


       IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MARC_GRAF_ASISTENCIA') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MARC_GRAF_ASISTENCIA');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MARC_GRAF_ASISTENCIA',
                                                      P_QUERY           => P_QUERY50);




 P_QUERY51 :='SELECT TO_NUMBER(T.TMARC_PROC), T.TMARC_DETALLE, TMARC_FECHA, ''a- '',1
              FROM PER_TABLERO_MARCACION T
             WHERE T.TMARC_FECHA = '''||V_MES1||'''
               AND OPCION IN (3)
                AND T.INDICADOR IS NOT NULL
            UNION ALL
            SELECT TO_NUMBER(T.TMARC_PROC), T.TMARC_DETALLE, TMARC_FECHA,''b- '',2
              FROM PER_TABLERO_MARCACION T
             WHERE T.TMARC_FECHA = '''||V_MES2||'''
               AND OPCION IN (3)
                AND T.INDICADOR IS NOT NULL
               UNION ALL
            SELECT TO_NUMBER(T.TMARC_PROC), T.TMARC_DETALLE, TMARC_FECHA, ''d- Sem '',4
              FROM PER_TABLERO_MARCACION T
             WHERE T.TMARC_FECHA ='''||V_SEMANA1||'''
               AND OPCION IN (3)
                AND T.INDICADOR IS NOT NULL
               UNION ALL
             SELECT  TO_NUMBER(T.TMARC_PROC), T.TMARC_DETALLE, TMARC_FECHA, ''e- Sem '',5
              FROM PER_TABLERO_MARCACION T
             WHERE T.TMARC_FECHA = '''||V_SEMANA2||'''
               AND OPCION IN (3)
                AND T.INDICADOR IS NOT NULL
            union all

            SELECT ROUND(((COUNT(C026)-SUM(C026))/COUNT(C026))*100) porc, ''CUMPLE'','''||V_MES3||''' ,''c- '',3
             FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = ''MARCACION''
              AND C027 = '''||V_MES3||'''
              AND C025 =''0''
            UNION ALL
            SELECT ROUND((SUM(C026)/COUNT(C026))*100) porc, ''NO CUMPLE'', '''||V_MES3||''', ''c- '',3
             FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = ''MARCACION''
              AND C027 = '''||V_MES3||'''
              AND C025 =''0''

             UNION ALL
            SELECT ROUND(((COUNT(C026)-SUM(C026))/COUNT(C026))*100) porc, ''CUMPLE'','''||V_SEMANA3||''',''f- Sem '',6
             FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = ''MARCACION''
             AND C025 =''0''
             AND C028 = '''||V_SEMANA3||'''
            UNION ALL
            SELECT ROUND((SUM(C026)/COUNT(C026))*100) porc, ''NO CUMPLE'','''||V_SEMANA3||''', ''f- Sem '',6
             FROM APEX_COLLECTIONS
            WHERE COLLECTION_NAME = ''MARCACION''
             AND C025 =''0''
             AND C028 = '''||V_SEMANA3||''' ';


       IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MARC_GRAF_PUNTUALIDAD') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MARC_GRAF_PUNTUALIDAD');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MARC_GRAF_PUNTUALIDAD',
                                                      P_QUERY           => P_QUERY51);


        p_query5:='       SELECT '''||V_MES1||''', ''a- '',1
           FROM DUAL
           UNION ALL
           SELECT '''||V_MES2||''', ''b- '',2
           FROM DUAL
           UNION ALL
           SELECT '''||V_MES3||''', ''c- '',3
           FROM DUAL
           UNION ALL
           SELECT '''||V_SEMANA1||''', ''d- Sem '',4
           FROM DUAL
           UNION ALL
           SELECT '''||V_SEMANA2||''', ''e- Sem '',5
           FROM DUAL
           UNION ALL
           SELECT '''||V_SEMANA3||''', ''f- Sem '',6
           FROM DUAL';
      IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'MARC_FECHA1') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'MARC_FECHA1');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'MARC_FECHA1',
                                                      P_QUERY           => P_QUERY5);

    /*
                    SELECT T.TMARC_PROC, T.TMARC_DETALLE, TMARC_FECHA, 1
                      FROM PER_TABLERO_MARCACION T
                     WHERE T.TMARC_FECHA ='''||V_MES1||'''
                       AND OPCION IN (4)
                       AND T.INDICADOR IS NULL
                    UNION ALL
                    SELECT T.TMARC_PROC, T.TMARC_DETALLE, TMARC_FECHA, 2
                      FROM PER_TABLERO_MARCACION T
                     WHERE T.TMARC_FECHA = '''||V_MES1||'''
                       AND OPCION IN (4)
                       AND T.INDICADOR IS NULL
                       UNION ALL
                    SELECT T.TMARC_PROC, T.TMARC_DETALLE, TMARC_FECHA, 4
                      FROM PER_TABLERO_MARCACION T
                     WHERE T.TMARC_FECHA||'/'||T.ANHO = '''||V_MES1||'''
                       AND OPCION IN (4)
                       AND T.INDICADOR IS NULL
                       UNION ALL
                     SELECT  T.TMARC_PROC, T.TMARC_DETALLE, TMARC_FECHA, 5
                      FROM PER_TABLERO_MARCACION T
                     WHERE T.TMARC_FECHA||'/'||T.ANHO = '24/2020'
                       AND OPCION IN (4)
                       AND T.INDICADOR IS NULL






    */





     /*    SELECT SUM(AUSENTE), COUNT(AUSENTE), SUM(IMPUNTUAL), count(IMPUNTUAL), AREA_JSA,
                (SUM(AUSENTE)/COUNT(AUSENTE))*100 por_ausencia,
                (SUM(IMPUNTUAL)/COUNT(IMPUNTUAL))*100 por_impuntual
                FROM
              (select T.*,
               CASE WHEN T.ENTRADA IS NULL AND T.SALIDA IS NULL THEN
                          1
                    ELSE
                           0
                    END AUSENTE,
                  CASE WHEN ENTRADA_HORA > ENTRADA_HOR THEN
                          1
                    ELSE
                           0
                    END IMPUNTUAL,
                   -- JSA_COD_AREA CODIGO,
                    JSA_DESC_AREA AREA_JSA
              from CUBO_CUMPLIMIENTO_MARCACIONES  T
              WHERE T.FECHA_HOR BETWEEN '01/06/2020' AND '21/06/2020'
              AND T.SITUACION = 'ACTIVO')
              group by AREA_JSA ;



SELECT SUM(AUSENTE), COUNT(AUSENTE), SUM(IMPUNTUAL), count(IMPUNTUAL),
  (SUM(AUSENTE)/COUNT(AUSENTE))*100 por_ausencia,
  (SUM(IMPUNTUAL)/COUNT(IMPUNTUAL))*100 por_impuntual
  FROM
(select T.*,
 CASE WHEN T.ENTRADA IS NULL AND T.SALIDA IS NULL THEN
            1
      ELSE
             0
      END AUSENTE,
    CASE WHEN ENTRADA_HORA > ENTRADA_HOR THEN
            1
      ELSE
             0
      END IMPUNTUAL,
     -- JSA_COD_AREA CODIGO,
      JSA_DESC_AREA AREA_JSA
from CUBO_CUMPLIMIENTO_MARCACIONES  T
WHERE TO_CHAR(T.FECHA_HOR,'IW') =TO_CHAR(to_Date('19/06/2020', 'DD/MM/YYYY'), 'IW')
AND T.SITUACION = 'ACTIVO')


 */

 END PP_MARCACION_NUEVO;

  PROCEDURE PP_NUEVO_ESTRUCTURA (P_EMPRESA IN NUMBER,
                                P_FECHA IN DATE ) IS

 P_QUERY1 VARCHAR2(2000);
 P_QUERY2 VARCHAR2(21000);
 P_QUERY3 VARCHAR2(21000);
 P_QUERY4 VARCHAR2(21000);
  P_QUERY5 VARCHAR2(21000);
 V_DIAS_HABILES number;
 V_DIAS_TRABAJADOS number;


  V_MES3            VARCHAR2(60);
  V_MES2            VARCHAR2(60);
  V_MES1            VARCHAR2(60);
  V_MES_PASADO      VARCHAR2(60);
  V_FECHA_PASADO      VARCHAR2(60);
  P_AND VARCHAR2(2100);
  V_SEMANA   VARCHAR2(60);
 BEGIN


  SELECT TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM')||'/'||(TO_CHAR(TO_DATE(P_FECHA), 'YYYY')-1),
         TO_CHAR(TO_DATE(P_FECHA), 'DD/MM')||'/'||(TO_CHAR(TO_DATE(P_FECHA), 'YYYY')-1),
         TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY')
   INTO V_MES1, V_MES2, V_MES3,V_MES_PASADO, V_FECHA_PASADO, V_SEMANA
  FROM DUAL;


 V_DIAS_TRABAJADOS := TBL_DIAS_LABURADOS_SUCURSAL(IN_DATE => P_FECHA,IND_REST_DIA  =>0);
  SELECT PHE_DIAS_HAB
    INTO V_DIAS_HABILES
  FROM TBL_CONF_TABLERO_COMERCIAL TD
 WHERE PHE_FECHA = TO_DATE(LAST_DAY(P_FECHA));


  if  P_FECHA = last_day(TO_DATE(P_FECHA))  then
    P_AND := P_AND||' AND MES || ''/'' || ANHO = '''||V_MES3||'''';
 else
   P_AND := P_AND||' AND SEMANA || ''/'' || ANHO = '''||V_SEMANA||'''';
 end if;


   --RAISE_APPLICATION_ERROR (-20001, 'PASA SPOR AQUI POERO DSLKFJSADKLFJ');
 /* P_QUERY1:= 'SELECT FECHA,
                     DOCU_NRO_DOC,
                     DETA_ART,
                     ART_DESC,
                     CANTIDAD_KG    CANTIDAD_KG,
                     VENTA_GS      VENTA_GS,
                     DECODE(SUC_DESC,''ASUNCION'',''CDA'',''CASA CENTRAL'', ''CENTRAL'',SUC_DESC),
                     ART_LINEA,
                     LINEA,
                     MES || ''/''|| ANHO,
                     ANHO || ''/''|| MES
                FROM TBL_VENTA f
        WHERE ART_LINEA NOT IN (27,20)
        AND  TO_CHAR(FECHA,''MM/YYYY'') IN ('''||V_MES1||''', '''||V_MES2||''', '''||V_MES3||''', '''||V_MES_PASADO||''')
        AND FECHA <=  '''||P_FECHA||'''';*/
        P_QUERY1:= 'SELECT C001 FECHA,
                          C002 DOCU_NRO_DOC,
                          C003 DETA_ART,
                          C004 ART_DESC,
                          C005  CANTIDAD_KG,
                          C006  VENTA_GS,
                          C007 SUCURSAL,
                          C008 ART_LINEA,
                          C009 LINEA,
                          C010 ANHO,
                          C011  MES
                    FROM APEX_collections
                    WHERE collection_name = ''DETALLE_VENTA''';



        ---BETWEEN ''01''||TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''MM/YYYY'')  AND  '''||P_FECHA||'''';

    P_QUERY2 := 'SELECT CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                                          ''CDA''
                                         WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN DPTO.DPTO_CODIGO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN DPTO.DPTO_CODIGO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN DPTO.DPTO_CODIGO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN DPTO.DPTO_CODIGO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN DPTO.DPTO_CODIGO IN (32) THEN
                                          ''ENCARNACION''
                                        END DEPARTAMENTO,
                                       SUM(CASE
                                             WHEN EMPL_SITUACION = ''A'' AND
                                                  EMPL_FEC_INGRESO <=  '''||P_FECHA||''' THEN
                                              1
                                             ELSE
                                              0
                                           END) + SUM(CASE
                                                        WHEN EMPL_SITUACION = ''I'' AND
                                                             EMPL_FEC_INGRESO <=  '''||P_FECHA||''' AND
                                                             EMPL_FEC_SALIDA >  '''||P_FECHA||''' THEN
                                                         1
                                                        ELSE
                                                         0
                                                      END) DOTACION,
                                            TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY''),
                                            TO_CHAR(TO_DATE('''||P_FECHA||'''),''YYYY/MM'')
                                   FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                                     AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                                     AND EMPL_CODIGO_PROV <> 0
                                    -- AND EMPL_TIPO_CONT = ''I''
                                     AND EMPL_FORMA_PAGO <> 0
                                     AND EMPL_EMPRESA = 1
                                  ---   AND SEMANA||''/''||ANHO  =TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')
                                  '||P_AND||'
                                 GROUP BY CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                                          ''CDA''
                                         WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN DPTO.DPTO_CODIGO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN DPTO.DPTO_CODIGO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN DPTO.DPTO_CODIGO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN DPTO.DPTO_CODIGO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN DPTO.DPTO_CODIGO IN (32) THEN
                                          ''ENCARNACION''
                                       END
     UNION ALL
     SELECT CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                                          ''CDA''
                                         WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN DPTO.DPTO_CODIGO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN DPTO.DPTO_CODIGO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN DPTO.DPTO_CODIGO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN DPTO.DPTO_CODIGO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN DPTO.DPTO_CODIGO IN (32) THEN
                                          ''ENCARNACION''
                                        END DEPARTAMENTO,
                                       SUM(CASE
                                             WHEN EMPL_SITUACION = ''A'' AND
                                                  EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                                              1
                                             ELSE
                                              0
                                           END) + SUM(CASE
                                                        WHEN EMPL_SITUACION = ''I'' AND
                                                             EMPL_FEC_INGRESO <=  LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) AND
                                                             EMPL_FEC_SALIDA >  LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -1)) THEN
                                                         1
                                                        ELSE
                                                         0
                                                      END) DOTACION,
                                          TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1),''MM/YYYY'')    GG    ,
                                          TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1),''YYYY/MM'')
                                   FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                                     AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                                     AND EMPL_CODIGO_PROV <> 0
                                   --  AND EMPL_TIPO_CONT = ''I''
                                     AND EMPL_FORMA_PAGO <> 0
                                     AND EMPL_EMPRESA = 1
                                     AND MES||''/''||ANHO   = TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -1),''MM/YYYY'')
                                     GROUP BY CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                                          ''CDA''
                                         WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN DPTO.DPTO_CODIGO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN DPTO.DPTO_CODIGO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN DPTO.DPTO_CODIGO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN DPTO.DPTO_CODIGO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN DPTO.DPTO_CODIGO IN (32) THEN
                                          ''ENCARNACION''
                                       END
          UNION ALL
          SELECT CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                                          ''CDA''
                                         WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN DPTO.DPTO_CODIGO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN DPTO.DPTO_CODIGO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN DPTO.DPTO_CODIGO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN DPTO.DPTO_CODIGO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN DPTO.DPTO_CODIGO IN (32) THEN
                                          ''ENCARNACION''
                                        END DEPARTAMENTO,
                                       SUM(CASE
                                             WHEN EMPL_SITUACION = ''A'' AND
                                                  EMPL_FEC_INGRESO <=  LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                                              1
                                             ELSE
                                              0
                                           END) + SUM(CASE
                                                        WHEN EMPL_SITUACION = ''I'' AND
                                                             EMPL_FEC_INGRESO <= LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) AND
                                                             EMPL_FEC_SALIDA >  LAST_DAY(ADD_MONTHS('''||P_FECHA||''', -2)) THEN
                                                         1
                                                        ELSE
                                                         0
                                                      END) DOTACION,
                                       TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''MM/YYYY''),
                                        TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''YYYY/MM'')
                                   FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                                   WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                                     AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                                     AND EMPL_CODIGO_PROV <> 0
                                   --  AND EMPL_TIPO_CONT = ''I''
                                     AND EMPL_FORMA_PAGO <> 0
                                     AND EMPL_EMPRESA = 1
                                     AND MES||''/''||ANHO  =TO_CHAR(ADD_MONTHS('''||P_FECHA||''', -2),''MM/YYYY'')

                                 GROUP BY CASE
                                         WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                                          ''CDA''
                                         WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                                          ''CENTRAL''
                                         WHEN DPTO.DPTO_CODIGO IN (19) THEN
                                          ''STA ROSA''
                                         WHEN DPTO.DPTO_CODIGO IN (29) THEN
                                          ''PEDRO JUAN CABALLERO''
                                         WHEN DPTO.DPTO_CODIGO IN (17) THEN
                                          ''LOMA PLATA''
                                         WHEN DPTO.DPTO_CODIGO IN (15) THEN
                                          ''CONCEPCION''
                                        WHEN DPTO.DPTO_CODIGO IN (32) THEN
                                          ''ENCARNACION''
                                       END
         UNION ALL
                      SELECT CASE
                           WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                            ''CDA''
                           WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                            ''CENTRAL''
                           WHEN DPTO.DPTO_CODIGO IN (19) THEN
                            ''STA ROSA''
                           WHEN DPTO.DPTO_CODIGO IN (29) THEN
                            ''PEDRO JUAN CABALLERO''
                           WHEN DPTO.DPTO_CODIGO IN (17) THEN
                            ''LOMA PLATA''
                           WHEN DPTO.DPTO_CODIGO IN (15) THEN
                            ''CONCEPCION''
                          WHEN DPTO.DPTO_CODIGO IN (32) THEN
                            ''ENCARNACION''
                          END DEPARTAMENTO,
                         SUM(CASE
                               WHEN EMPL_SITUACION = ''A'' AND
                                    EMPL_FEC_INGRESO <=  '''||V_FECHA_PASADO||''' THEN
                                1
                               ELSE
                                0
                             END) + SUM(CASE
                                          WHEN EMPL_SITUACION = ''I'' AND
                                               EMPL_FEC_INGRESO <=  '''||V_FECHA_PASADO||''' AND
                                               EMPL_FEC_SALIDA >  '''||V_FECHA_PASADO||''' THEN
                                           1
                                          ELSE
                                           0
                                        END) DOTACION,
                              TO_CHAR(TO_DATE('''||V_FECHA_PASADO||'''),''MM/YYYY''),
                              TO_CHAR(TO_DATE('''||V_FECHA_PASADO||'''),''YYYY/MM'')
                     FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO DPTO
                     WHERE E.EMPL_DEPARTAMENTO = DPTO.DPTO_CODIGO
                       AND E.EMPL_EMPRESA = DPTO.DPTO_EMPR
                       AND EMPL_CODIGO_PROV <> 0
                      -- AND EMPL_TIPO_CONT = ''I''
                       AND EMPL_FORMA_PAGO <> 0
                       AND EMPL_EMPRESA = 1
                       AND SEMANA||''/''||ANHO  =TO_CHAR(TO_DATE('''||V_FECHA_PASADO||'''),''IW/YYYY'')

                   GROUP BY CASE
                           WHEN EMPL_SUCURSAL IN (2) AND DPTO.DPTO_CODIGO <> 31 THEN
                            ''CDA''
                           WHEN DPTO.DPTO_CODIGO IN (2,14,22) THEN
                            ''CENTRAL''
                           WHEN DPTO.DPTO_CODIGO IN (19) THEN
                            ''STA ROSA''
                           WHEN DPTO.DPTO_CODIGO IN (29) THEN
                            ''PEDRO JUAN CABALLERO''
                           WHEN DPTO.DPTO_CODIGO IN (17) THEN
                            ''LOMA PLATA''
                           WHEN DPTO.DPTO_CODIGO IN (15) THEN
                            ''CONCEPCION''
                          WHEN DPTO.DPTO_CODIGO IN (32) THEN
                            ''ENCARNACION''
                         END';


     --('''||V_MES1||''', '''||V_MES2||''', '''||V_MES3||''', '''||V_MES_PASADO||''')


    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DOTACION_EST12') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DOTACION_EST12');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DOTACION_EST12',
                                                      P_QUERY           => P_QUERY2);



    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_VENTA12') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_VENTA12');
    END IF;
      APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DETALLE_VENTA12',
                                                      P_QUERY           => P_QUERY1);

     P_QUERY3 := ' select ''SUCURSAL'',
                            '''||V_MES1||''',
                            '''||V_MES2||''',
                            '''||V_MES3||''',
                             ''PROYECCION'' ,
                             ''VMA'',
                             ''SEMAFORO'',
                             ''VIA'',
                             '''||V_MES_PASADO||''',
                             ''TOTAL_VENTA'',
                             ''VMA_COLOR'',
                             ''VIA_COLOR''
                 FROM DUAL
             union all
            select SUCURSAL,
                   MES1,
                   to_Char(MES2,''999G999G999G999G999'') MES2,
                   to_Char(MES3,''999G999G999G999G999'')MES3,
                   TO_CHAR(PROYECCION,''999G999G999G999G999'') PROYECCION,
                  --- TO_CHAR(ROUND(((PROYECCION/MES2)-1)*100))||''%'' VMA,
                  TO_CHAR(ROUND(((PROYECCION-MES2)/MES2)*100))||''%'' VMA,
                   CASE WHEN  TO_NUMBER(PROYECCION) >  TO_NUMBER(NVL(PROY_ANT,0)) THEN  ''A''
                         WHEN TO_NUMBER(PROYECCION)  =  TO_NUMBER(NVL(PROY_ANT,0)) THEN ''B''
                         WHEN  TO_NUMBER(PROYECCION)  < TO_NUMBER(NVL(PROY_ANT,0)) THEN ''C''
                    end semaforo,
                   -- to_char(ROUND(((PROYECCION/VENTA_PASADO)-1)*100))||''%''  VIA,
                   to_char(ROUND(((PROYECCION-VENTA_PASADO)/VENTA_PASADO)*100))||''%''  VIA,
                    to_Char(VENTA_PASADO,''999G999G999G999G999'') VENTA_PASADO,
                    TOT_MESP,
                    CASE WHEN ROUND(((PROYECCION-MES2)/MES2)*100) >0 THEN
                       ''A''
                       WHEN ROUND(((PROYECCION-MES2)/MES2)*100) <0 THEN
                        ''B''
                        ELSE
                          NULL
                     END VMA_COLOR,
                    CASE WHEN ROUND(((PROYECCION-VENTA_PASADO)/VENTA_PASADO)*100) >0 THEN
                       ''A''
                       ELSE
                        ''B''
                     END VMI_COLOR
             FROM(
             SELECT SUCURSAL,  to_Char(ROUND(A.VENTA_GS),''999G999G999G999G999'') MES1,
                                  ROUND(B.VENTA_GS) MES2,
                                  ROUND(C.VENTA_GS) MES3,
                                  ROUND((D.VENTA_GS/'||V_DIAS_TRABAJADOS||')*'||V_DIAS_HABILES||') PROYECCION,
                                  to_char(ROUND((((F.VENTA_GS/'||V_DIAS_TRABAJADOS||')*'||V_DIAS_HABILES||')/G.VENTA_GS),2),''990d99'')||''%'' porcentaje,
                                  ROUND((F.VENTA_GS/'||V_DIAS_TRABAJADOS||')*'||V_DIAS_HABILES||') PROY_ANT,
                                  ROUND(G.VENTA_GS) VENTA_PASADO,
                                 to_Char(ROUND(G.VENTA_GS),''999G999G999G999G999'')TOT_MESP
                          FROM
                          (SELECT  SUM(C006)    VENTA_GS,
                                 C007 SUC_DESC,
                                 C010  MES
                          FROM APEX_collections
                          WHERE collection_name = ''DETALLE_VENTA12''
                            AND C010 ='''||V_MES1||'''
                           GROUP BY C007, C010) A,
                           (SELECT  SUM(C006)    VENTA_GS,
                                 C007 SUC_DESC,
                                 C010  MES
                          FROM APEX_collections
                          WHERE collection_name = ''DETALLE_VENTA12''
                            AND C010 = '''||V_MES2||'''
                           GROUP BY C007, C010)B,
                            (SELECT  SUM(C006)    VENTA_GS,
                                 C007 SUC_DESC,
                                 C010  MES
                          FROM APEX_collections
                          WHERE collection_name = ''DETALLE_VENTA12''
                            AND C010 = '''||V_MES3||'''
                           GROUP BY C007, C010)C,
                           (SELECT  SUM(C006)    VENTA_GS,
                                 C007 SUC_DESC,
                                 C010  MES
                          FROM APEX_collections
                          WHERE collection_name = ''DETALLE_VENTA12''
                            AND C010 = '''||V_MES3||'''
                           GROUP BY C007, C010)D,
                            (SELECT  SUM(C006)    VENTA_GS,
                                 C007 SUC_DESC,
                                 C010  MES
                          FROM APEX_collections
                          WHERE collection_name = ''DETALLE_VENTA12''
                            AND C010 = '''||V_MES_PASADO||'''
                            AND C001 <= '''||V_FECHA_PASADO||'''
                           GROUP BY C007, C010)F,
                          (SELECT  SUM(C006)    VENTA_GS,
                                 C007 SUC_DESC,
                                 C010  MES
                          FROM APEX_collections
                          WHERE collection_name = ''DETALLE_VENTA12''
                            AND C010 = '''||V_MES_PASADO||'''
                           GROUP BY C007, C010)g,
                          (SELECT DECODE(SUC_CODIGO, 2, ''CDA'', 1, ''CENTRAL'', SUC_DESC) SUCURSAL
                            FROM GEN_SUCURSAL
                           WHERE SUC_eMPR = 1
                             AND SUC_CODIGO NOT IN (5, 8)) E
                           WHERE E.SUCURSAL = A.SUC_DESC(+)
                           AND  E.SUCURSAL = B.SUC_DESC(+)
                           AND  E.SUCURSAL = C.SUC_DESC(+)
                           AND  E.SUCURSAL = D.SUC_DESC(+)
                           AND  E.SUCURSAL = F.SUC_DESC(+)
                           AND  E.SUCURSAL = g.SUC_DESC(+) )';


  /*insert into x
    (campo1,  otro)
  values
    (P_QUERY3, 'PERL051');
  */

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_SUCURSAL') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_SUCURSAL');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DET_SUCURSAL',
                                                      P_QUERY           => P_QUERY3);


     /*
        P_QUERY3 :=  'SELECT A.DOTACION, A.MES,  VENTA_GS,CANTIDAD_KG, ,SUC_DESC
                          FROM (  SELECT  C001 DEPARTAMENTO,
                                          C002 DOTACION,
                                          C003 MES
                                    FROM APEX_collections
                                    WHERE collection_name = ''DOTACION_EST12'') A,
                                 (SELECT SUM(C005)    CANTIDAD_KG,
                                         SUM(C006)    VENTA_GS,
                                         C007 SUC_DESC,
                                         C010  MES
                                    FROM APEX_collections
                                    WHERE collection_name = ''DETALLE_VENTA12''
                                     GROUP BY C007, C010)B
                                 WHERE B.SUC_DESC = A.DEPARTAMENTO
                                   AND A.MES =B.MES';

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_ESTRUCTURA_NRO23') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_ESTRUCTURA_NRO23');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'DET_ESTRUCTURA_NRO23',
                                                      P_QUERY           => P_QUERY3);
   */
 END PP_NUEVO_ESTRUCTURA;


 PROCEDURE PP_AUSENCIAS (P_EMPRESA              IN NUMBER,
                         P_FECHA                IN DATE,
                         P_SESSION              IN NUMBER )IS



V_MES3            VARCHAR2(60);
V_MES2            VARCHAR2(60);
V_MES1            VARCHAR2(60);
V_SEMANA          VARCHAR2(60);
V_SEMANA_ANT          VARCHAR2(60);
V_FECHA1          DATE;
V_FECHA2          DATE;
P_QUERY1          VARCHAR2(20000);
P_QUERY2          VARCHAR2(20000);

V_MES_PB          VARCHAR2(60);
V_FECHA_PB        DATE;

X_DIA_LABORAL VARCHAR2(60);
X_EST_DESC VARCHAR2(200);

V_SEMANA_3 VARCHAR2(60);
V_SEMANA_4 VARCHAR2(60);

V_SEM_TABLERO VARCHAR2(60);
 /* CURSOR EMPLEADO_MES3  IS (  SELECT EMPL_LEGAJO LEGAJO,
                                     EMPL_NOMBRE || ' ' || EMPL_APE NOMBRE,
                                     EMPL_FEC_INGRESO,
                                     EMPL_FEC_SALIDA,
                                     A.EMPL_CONS_MARC,
                                     DECODE(EMPL_FORMA_PAGO,1,'J',2,'M',5,'M') FOR_PAGO,
                                     EMPL_FORMA_PAGO
                                FROM PER_EMPLEADO A
                               WHERE EMPL_EMPRESA = 1
                                    --  AND EMPL_FORMA_PAGO <> 3
                                 AND EMPL_FEC_INGRESO IS NOT NULL
                                 AND EMPL_CODIGO_PROV <> 0
                                 AND CASE
                                       WHEN EMPL_FEC_SALIDA >= '01'||to_char(P_FECHA,'mm/yyyy') AND EMPL_SITUACION = 'I' THEN
                                        1
                                       WHEN EMPL_SITUACION = 'A' THEN
                                        1
                                       ELSE
                                        0
                                     END = 1);*/



P_AND VARCHAR2(200);

BEGIN

--
 SELECT TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY'),
         TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY'),
         TO_CHAR(TO_DATE(P_FECHA),'IW/YYYY'),
        -- TO_CHAR(TO_DATE(P_FECHA)-7,'IW/YYYY'),
        CASE WHEN TO_CHAR(TO_DATE(P_FECHA),'IW') = 1 then
            TO_CHAR(TO_DATE(P_FECHA)-7,'IW/')||TO_CHAR((TO_CHAR(TO_DATE(P_FECHA),'YYYY'))-1)
         else
            TO_CHAR(TO_DATE(P_FECHA)-7,'IW/YYYY')
           end  DDD,
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)),'DD/MM/YYYY'),
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)),'DD/MM/YYYY'),
        TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-12)),'DD/MM/YYYY'),
        TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-12),'MM/YYYY'),
        CASE WHEN TO_CHAR(TO_DATE(P_FECHA),'IW') = 1 then
            TO_CHAR(TO_DATE(P_FECHA)-14,'IW/')||TO_CHAR((TO_CHAR(TO_DATE(P_FECHA),'YYYY'))-1)
         else
            TO_CHAR(TO_DATE(P_FECHA)-14,'IW/YYYY')
           end  SEMANA3,
           CASE WHEN TO_CHAR(TO_DATE(P_FECHA),'IW') = 1 then
            TO_CHAR(TO_DATE(P_FECHA)-21,'IW/')||TO_CHAR((TO_CHAR(TO_DATE(P_FECHA),'YYYY'))-1)
         else
            TO_CHAR(TO_DATE(P_FECHA)-21,'IW/YYYY')
           end  SEMANA_4
   INTO V_MES1, V_MES2, V_MES3,V_SEMANA,V_SEMANA_ANT,V_FECHA1, V_FECHA2, V_FECHA_PB, V_MES_PB,V_SEMANA_3,V_SEMANA_4
  FROM DUAL;

 IF  P_FECHA = LAST_DAY(TO_DATE(P_FECHA))  THEN
    P_AND := V_MES3;                   
 ELSE
    P_AND := V_SEMANA;         
 END IF;

   delete perl051_empl_marc_temp
     where P_SESSION = P_SESSION;
     FOR X IN  (SELECT EMPL_LEGAJO LEGAJO,
                       EMPL_NOMBRE || ' ' || EMPL_APE NOMBRE,
                       EMPL_FEC_INGRESO,
                       EMPL_FEC_SALIDA,
                       A.EMPL_CONS_MARC,
                       DECODE(EMPL_FORMA_PAGO,1,'J',2,'M',5,'M', 'M') FOR_PAGO,
                       EMPL_FORMA_PAGO,
                       to_char(P_FECHA,'MM') mes,
                       to_char(P_FECHA,'YYYY') anho,
                      P_FECHA FECHA_D, 
                      empl_sucursal,
                      empl_departamento, 
                      empl_cargo
                  FROM PER_EMPLEADO_HIST A
                 WHERE EMPL_EMPRESA = P_EMPRESA
                   AND EMPL_FEC_INGRESO IS NOT NULL
                   AND EMPL_CODIGO_PROV <> 0
                   AND EMPL_FORMA_PAGO <> 0
                   AND semana|| '/' || ANHO = V_MES3
                  /* AND CASE WHEN  P_FECHA = LAST_DAY(TO_DATE(P_FECHA)) THEN
                             MES|| '/' || ANHO
                        ELSE 
                         SEMANA|| '/' || ANHO
                   END =P_AND*/
                ---   AND mes|| '/' || ANHO = V_MES3
                   AND CASE
                         WHEN EMPL_FEC_SALIDA > P_FECHA AND EMPL_SITUACION = 'I' AND  EMPL_FEC_INGRESO <= P_FECHA THEN
                          1
                         WHEN EMPL_SITUACION = 'A' AND EMPL_FEC_INGRESO <= P_FECHA THEN
                          1
                         ELSE
                          0
                       END = 1
                UNION ALL
                SELECT EMPL_LEGAJO LEGAJO,
                       EMPL_NOMBRE || ' ' || EMPL_APE NOMBRE,
                       EMPL_FEC_INGRESO,
                       EMPL_FEC_SALIDA,
                       A.EMPL_CONS_MARC,
                       DECODE(EMPL_FORMA_PAGO,1,'J',2,'M',5,'M', 'M') FOR_PAGO,
                       EMPL_FORMA_PAGO,
                       to_char(v_FECHA2,'MM') mes,
                       to_char(v_FECHA2,'YYYY') anho,
                       v_FECHA2 FECHA_D,
                        empl_sucursal,
                      empl_departamento,
                      empl_cargo
                  FROM PER_EMPLEADO_HIST A
                 WHERE EMPL_EMPRESA = P_EMPRESA
                   AND EMPL_FEC_INGRESO IS NOT NULL
                   AND EMPL_CODIGO_PROV <> 0
                   AND EMPL_FORMA_PAGO <> 0
                   AND MES|| '/' || ANHO =V_MES2
                  AND CASE
                         WHEN EMPL_FEC_SALIDA > P_FECHA AND EMPL_SITUACION = 'I' AND  EMPL_FEC_INGRESO <= V_FECHA2 THEN
                          1
                         WHEN EMPL_SITUACION = 'A' AND EMPL_FEC_INGRESO <= V_FECHA2 THEN
                          1
                         ELSE
                          0
                       END = 1
                 UNION ALL
                 SELECT EMPL_LEGAJO LEGAJO,
                       EMPL_NOMBRE || ' ' || EMPL_APE NOMBRE,
                       EMPL_FEC_INGRESO,
                       EMPL_FEC_SALIDA,
                       A.EMPL_CONS_MARC,
                       DECODE(EMPL_FORMA_PAGO,1,'J',2,'M',5,'M', 'M') FOR_PAGO,
                       EMPL_FORMA_PAGO,
                       to_char(v_FECHA1,'MM') mes,
                       to_char(v_FECHA1,'YYYY') anho,
                       v_FECHA1 FECHA_D,
                       empl_sucursal,
                       empl_departamento,
                       empl_cargo
                  FROM PER_EMPLEADO_HIST A
                 WHERE EMPL_EMPRESA = P_EMPRESA
                   AND EMPL_FEC_INGRESO IS NOT NULL
                   AND EMPL_CODIGO_PROV <> 0
                   AND EMPL_FORMA_PAGO <> 0
                   AND MES|| '/' || ANHO = V_MES1
                     AND CASE
                         WHEN EMPL_FEC_SALIDA > P_FECHA AND EMPL_SITUACION = 'I' AND  EMPL_FEC_INGRESO <= V_FECHA1 THEN
                          1
                         WHEN EMPL_SITUACION = 'A' AND EMPL_FEC_INGRESO <= V_FECHA1 THEN
                          1
                         ELSE
                          0
                       END = 1  )


       LOOP


       FOR V IN (
         SELECT I_DIA FECHA
           FROM TABLE(RETURN_TABLE_DIA_PROF(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))))
          WHERE I_DIA BETWEEN '01/'||x.mes||'/'||x.anho AND X.FECHA_D) LOOP

          IF X.EMPL_FORMA_PAGO IN (1,2,5)  THEN
            IF V.FECHA <'01/09/2021'THEN
                X_DIA_LABORAL:= PER_VER_DIA_LABORAL(X.LEGAJO,
                                                    P_EMPRESA,
                                                    V.FECHA,
                                                    X.EMPL_FEC_INGRESO,
                                                    X.EMPL_FEC_SALIDA,
                                                    X.FOR_PAGO );
                                                    
             ELSE                                        
               X_DIA_LABORAL:=     PER_AUSENCIAS_TABLERO(V_EMPL    => X.LEGAJO,
                                                         V_EMPRESA => P_EMPRESA,
                                                         V_FECHA   => V.FECHA,
                                                         V_FEC_INGRESO_FUN => X.EMPL_FEC_INGRESO,
                                                         V_FEC_SALIDA_FUN  => X.EMPL_FEC_SALIDA,
                                                         V_TIP_COB         => X.FOR_PAGO,
                                                         V_PAGADOS         => NULL);          
                                                             
                                                                                     
            END IF;                                        

         ELSE
           X_DIA_LABORAL :='S';
         END IF;


         IF X.EMPL_CONS_MARC ='N' AND X_DIA_LABORAL = 'W' THEN
            X_DIA_LABORAL :='S';
         ELSIF X.EMPL_CONS_MARC ='S' AND X_DIA_LABORAL = 'W' and P_EMPRESA = 1 THEN
                                  X_DIA_LABORAL :='S';
            
           ELSIF X.EMPL_CONS_MARC ='S' AND X_DIA_LABORAL = 'W' THEN
            X_DIA_LABORAL :='C';   
         END IF;
         
         
        IF V.FECHA = '16/04/2022' THEN
          X_DIA_LABORAL := 'F';
        END IF;



         IF    X_DIA_LABORAL = 'D' THEN X_EST_DESC:= 'DOMINGO' ;
         ELSIF X_DIA_LABORAL = 'H' THEN X_EST_DESC:= 'SABADO';
         ELSIF X_DIA_LABORAL = 'X' THEN X_EST_DESC:= 'FICHA INACTIVA';
         ELSIF X_DIA_LABORAL = 'F' THEN X_EST_DESC:= 'FERIADO';
         ELSIF X_DIA_LABORAL = 'V' THEN X_EST_DESC:= 'VAC. REG. LEGAL';
         ELSIF X_DIA_LABORAL = 'T' THEN X_EST_DESC:= 'VAC. REG. INTERNO';
         ELSIF X_DIA_LABORAL = 'L' THEN X_EST_DESC:= 'LICENCIA';
         ELSIF X_DIA_LABORAL = 'R' THEN X_EST_DESC:= 'REPOSO';
         ELSIF X_DIA_LABORAL = 'P' THEN X_EST_DESC:= 'PERMISO';
         ELSIF X_DIA_LABORAL = 'A' THEN X_EST_DESC:= 'AUSENCIA JUSTIFICADA';
         ELSIF X_DIA_LABORAL = 'B' THEN X_EST_DESC:= 'AUSENCIA NO SE PAGA';
         ELSIF X_DIA_LABORAL = 'C' THEN X_EST_DESC:= 'AUSENCIA INJUSTIFICADA';
         ELSIF X_DIA_LABORAL = 'G' THEN X_EST_DESC:= 'VIAJE LABORAL';
         ELSIF X_DIA_LABORAL = 'U' THEN X_EST_DESC:= 'SUSPENSION';
         ELSIF X_DIA_LABORAL = 'Q' THEN X_EST_DESC:= 'SUSP. AISLAMIENTO';
         ELSIF X_DIA_LABORAL = 'W' THEN X_EST_DESC:= 'AUSENCIA';
         ELSIF X_DIA_LABORAL = 'S'  THEN
           X_EST_DESC:='PRESENTE';
         ELSE
           X_EST_DESC:= 'AUSENTE';
         END IF;

 IF  TO_CHAR(V.FECHA,'IW/YYYY') =V_SEMANA  THEN
  V_SEM_TABLERO :=  4 ;
 ELSIF TO_CHAR(V.FECHA,'IW/YYYY') =V_SEMANA_ANT THEN 
  V_SEM_TABLERO:=3 ;
 ELSIF TO_CHAR(V.FECHA,'IW/YYYY') =V_SEMANA_3 THEN 
  V_SEM_TABLERO:=2 ;
 ELSIF TO_CHAR(V.FECHA,'IW/YYYY') =V_SEMANA_4 THEN  
 V_SEM_TABLERO:= 1 ;
 else 
   V_SEM_TABLERO:= null;
 END IF;

  ---  IF    X_DIA_LABORAL in ('V','T','L','R','P','A','U','W','B','C','Q') THEN
       INSERT INTO PERL051_EMPL_MARC_TEMP
         (LEGAJO,
          NOMBRE,
          FECHA,
          ESTADO,
          ESTADO_DESC,
          EMPRESA,
          MES,
          ANHO,
          P_SESSION,
          SUCURSAL,
          DEPARTAMENTO,
          SEMANA,
          SEMANA_TAB,
          CARGO)
       VALUES
         (X.LEGAJO,
          X.NOMBRE,
          V.FECHA,
          X_DIA_LABORAL,
          X_EST_DESC,
          P_EMPRESA,
          x.mes,
          x.anho,
          P_SESSION,
          x.empl_sucursal,
          x.empl_departamento,
          TO_CHAR(V.FECHA,'IW/YYYY'),
          V_SEM_TABLERO,
          X.EMPL_CARGO);
    ---   END IF; 
       
       END LOOP;
     END LOOP;

 END PP_AUSENCIAS;

PROCEDURE PP_NUEVO_IND_ROTACION (P_EMPRESA     IN NUMBER,
                                 P_FECHA       IN DATE) IS 
 
V_MES1       VARCHAR2(60);
V_MES2       VARCHAR2(60);
V_MES3       VARCHAR2(60);
V_DESDE      DATE;
V_FECHA1     DATE;
V_FECHA2     DATE;
P_AND        VARCHAR2(1000);
V_SQL        VARCHAR2(21000);

 BEGIN
  
   SELECT TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY') MES1,
        TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-1),'MM/YYYY') MES2,
        TO_CHAR(TO_DATE(P_FECHA),'MM/YYYY') MES3,
        '01/'||TO_CHAR(ADD_MONTHS(TO_DATE(P_FECHA),-2),'MM/YYYY') DESDE,
        LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-2)) MES1_FECHA,
        LAST_DAY(ADD_MONTHS(TO_DATE(P_FECHA),-1)) MES2_FECHA
        
        INTO V_MES1, V_MES2,V_MES3, V_DESDE, V_FECHA1, V_FECHA2
        
  FROM DUAL; 
 
  IF P_FECHA = LAST_DAY(TO_DATE(P_FECHA))  THEN
    
       P_AND := P_AND||' and semana is null AND MES || ''/'' || ANHO =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''MM/YYYY'')  ';                 
   ELSE
       P_AND := P_AND||' and mes is null AND SEMANA || ''/'' || ANHO =  TO_CHAR(TO_DATE('''||P_FECHA||'''),''IW/YYYY'')  ';
   END IF;
   
   V_SQL := 'SELECT EMPL_LEGAJO,
                    CASE WHEN EMPL_DEPARTAMENTO = 38 AND  '''||V_MES3||''' <>TO_CHAR(T.EMPSOL_FECHA_SAL_COP, ''MM/YYYY'')  THEN
                      22 ELSE EMPL_DEPARTAMENTO 
                    END  DEPARTAMENTO,
                     CASE WHEN EMPL_DEPARTAMENTO = 38 AND  '''||V_MES3||''' <>TO_CHAR(T.EMPSOL_FECHA_SAL_COP, ''MM/YYYY'')  THEN
                      ''LOGISTICA''  ELSE DPTO_DESC END
                   DPTO_DESC,
                   cASE
                     WHEN EMPSOL_SUC_COP = 2 THEN
                      ''CDA''
                     WHEN EMPSOL_DEPART_COP = 1 THEN
                      ''ADMINISTRATIVA''
                     WHEN (EMPSOL_DEPART_COP IN (14, 22, 2,38) OR
                          EMPSOL_SUC_COP NOT IN (1, 2)) THEN
                      ''COMERCIAL''
                     ELSE
                      ''INDUSTRIAL''
                   END AREA_DES,
                   TO_CHAR(T.EMPSOL_FECHA_SAL_COP, ''MM/YYYY'') MES,
                   ''DESVINCULADOS'',
                   T.EMPSOL_FECHA_INC_PER,
                   EMPSOL_FECHA_SAL_COP,
                   '''||V_MES1||''',
                   '''||V_MES2||''',
                   '''||V_MES3||'''
              FROM PER_EMPL_SOL_CAMBIO_ESTADO T, PER_EMPLEADO E, GEN_DEPARTAMENTO
             where T.EMPSOL_EMPR = EMPL_EMPRESA
               AND T.EMPSOL_EMPL_LEG = EMPL_LEGAJO
               AND EMPL_DEPARTAMENTO = DPTO_CODIGO
               AND EMPL_EMPRESA = DPTO_EMPR
               AND T.EMPSOL_EMPR = 1
               AND T.EMPSOL_ESTADO_EMP_SOL = ''I''
               AND T.EMPSOL_ESTADO_VERIF = ''C''
               AND T.EMPSOL_FECHA_SAL_COP BETWEEN '''||V_DESDE||''' AND '''||P_FECHA||'''
               AND EMPL_TIPO_CONT = ''I''

            UNION ALL
            select EMPL_LEGAJO, -------------------------------------------MES ACTUAL
                   empl_departamento,
                   DPTO_DESC,
                   cASE
                     WHEN EMPL_SUCURSAL = 2 THEN
                      ''CDA''
                     WHEN EMPL_DEPARTAMENTO = 1 THEN
                      ''ADMINISTRATIVA''
                     WHEN (EMPL_DEPARTAMENTO IN (14, 22, 2,38) OR
                          EMPL_SUCURSAL NOT IN (1, 2)) THEN
                      ''COMERCIAL''
                     ELSE
                      ''INDUSTRIAL''
                   END ATC_AREA,
                   '''||V_MES3||''',
                   ''DOTACION'',
                   E.EMPL_FEC_INGRESO,
                   NULL               FEC_SALIDA,
                    '''||V_MES1||''',
                   '''||V_MES2||''',
                   '''||V_MES3||'''
              from per_empleado_hist E, GEN_DEPARTAMENTO
             where empl_empresa = 1
               AND EMPL_DEPARTAMENTO = DPTO_CODIGO
               AND EMPL_EMPRESA = DPTO_EMPR
               AND EMPL_CODIGO_PROV is not null
               AND EMPL_TIPO_CONT = ''I''
               AND EMPL_FORMA_PAGO is not null
             '|| P_AND||'
               AND CASE
                     WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' THEN
                      1
                     WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||P_FECHA||''' AND
                          EMPL_FEC_SALIDA > '''||P_FECHA||''' THEN
                      1
                     ELSE
                      0
                   END = 1
            UNION ALL
            select EMPL_LEGAJO, -------------------------------------------MES ACTUAL
                   empl_departamento,
                   DPTO_DESC,
                   cASE
                     WHEN EMPL_SUCURSAL = 2 THEN
                      ''CDA''
                     WHEN EMPL_DEPARTAMENTO = 1 THEN
                      ''ADMINISTRATIVA''
                     WHEN (EMPL_DEPARTAMENTO IN (14, 22, 2,38) OR
                          EMPL_SUCURSAL NOT IN (1, 2)) THEN
                      ''COMERCIAL''
                     ELSE
                      ''INDUSTRIAL''
                   END ATC_AREA,
                   
                    '''||V_MES2||''',
                   ''DOTACION'',
                   E.EMPL_FEC_INGRESO,
                   NULL               FEC_SALIDA,
                    '''||V_MES1||''',
                   '''||V_MES2||''',
                   '''||V_MES3||'''
              from per_empleado_hist E, GEN_DEPARTAMENTO
             where empl_empresa = 1
               AND EMPL_DEPARTAMENTO = DPTO_CODIGO
               AND EMPL_EMPRESA = DPTO_EMPR
               AND EMPL_CODIGO_PROV is not null
               AND EMPL_TIPO_CONT = ''I''
               and semana is null
               AND MES || ''/'' || ANHO =   '''||V_MES2||'''
               AND EMPL_FORMA_PAGO is not null
               AND CASE
                     WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= '''||V_FECHA2||''' THEN
                      1
                     WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||V_FECHA2||''' AND
                          EMPL_FEC_SALIDA > '''||V_FECHA2||''' THEN
                      1
                     ELSE
                      0
                   END = 1

            UNION ALL -------------------------------------------MES ULTIMO MES
            select EMPL_LEGAJO, -------------------------------------------MES ACTUAL
                   empl_departamento,
                   DPTO_DESC,
                   cASE
                     WHEN EMPL_SUCURSAL = 2 THEN
                      ''CDA''
                     WHEN EMPL_DEPARTAMENTO = 1 THEN
                      ''ADMINISTRATIVA''
                     WHEN (EMPL_DEPARTAMENTO IN (14, 22, 2,38) OR
                          EMPL_SUCURSAL NOT IN (1, 2)) THEN
                      ''COMERCIAL''
                     ELSE
                      ''INDUSTRIAL''
                   END ATC_AREA,
                   
                   '''||V_MES1||''',
                   ''DOTACION'',
                   E.EMPL_FEC_INGRESO,
                   NULL               FEC_SALIDA,
                    '''||V_MES1||''',
                   '''||V_MES2||''',
                   '''||V_MES3||'''
              from per_empleado_hist E, GEN_DEPARTAMENTO
             where empl_empresa = 1
               AND EMPL_DEPARTAMENTO = DPTO_CODIGO
               AND EMPL_EMPRESA = DPTO_EMPR
               AND EMPL_CODIGO_PROV is not null
               AND EMPL_TIPO_CONT = ''I''
               and semana is null
               AND MES || ''/'' || ANHO = '''||V_MES1||'''
               AND EMPL_FORMA_PAGO is not null
               AND CASE
                     WHEN EMPL_SITUACION = ''A'' AND EMPL_FEC_INGRESO <= '''||V_FECHA1||''' THEN
                      1
                     WHEN EMPL_SITUACION = ''I'' AND EMPL_FEC_INGRESO <= '''||V_FECHA1||''' AND
                          EMPL_FEC_SALIDA > '''||V_FECHA1||'''  THEN
                      1
                     ELSE
                      0
                   END = 1';
             
    add_hist_query(in_nombre => 'ROT_NUEVO', in_query => V_SQL);
    
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'ROT_NUEVO') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'ROT_NUEVO');
    END IF;
    
    APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'ROT_NUEVO',
                                                   P_QUERY           => V_SQL
                                                   );


END PP_NUEVO_IND_ROTACION;



FUNCTION PP_ESTADO_VAC  (P_EMPRESA IN NUMBER,
                         P_NRO      IN NUMBER )RETURN VARCHAR2 IS
  
V_RETORNAR  VARCHAR2(60);
BEGIN
  
select  DECODE(SOLPER_ESTADO_FINAL,
              'F',
              'Finalizado',
              'EP',
              'En Proceso',
              'R',
              'Rechazado',
              'P',
              'Pendiente',
              'EE',
              'En Espera',
              'ER',
              'En Reclutamiento',
              'A',
              'ANULADO')
INTO V_RETORNAR
from PER_SOLICITUD_PERSONAL T
WHERE T.SOLPER_CLAVE =P_NRO
AND T.SOLPER_EMPR =P_EMPRESA ;

RETURN V_RETORNAR;
EXCEPTION WHEN NO_DATA_FOUND THEN
  
RETURN NULL;

END PP_ESTADO_VAC;


PROCEDURE PP_ROTACION_CARGO IS
  
P_QUERY13 VARCHAR2(30001);
BEGIN
  
P_QUERY13 :='SELECT      EMPL_CARGO,
            CAR_DESC,
            1,
            2,
----------------------------------*MES 1
                           CASE
                             WHEN MES || ''/'' || ANHO = ''03/2022'' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE(''31/03/2022''),''MM'')  THEN
                                 0
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE(''31/03/2022''),''MM'')  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE(''31/03/2022''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT1,
                           CASE
                             WHEN MES || ''/'' || ANHO = ''03/2022'' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= ''31/03/2022''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= ''31/03/2022''  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE(''31/03/2022''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES1,

                           ----------------------------------*MES2
                           CASE
                             WHEN MES || ''/'' || ANHO =  ''04/2022'' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE(''30/04/2022''),''MM'')  THEN
                                 0
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE(''30/04/2022''),''MM'')  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE(''30/04/2022''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT2,
                           CASE
                             WHEN MES || ''/'' || ANHO =  ''04/2022'' THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= ''30/04/2022''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= ''30/04/2022''  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE(''30/04/2022''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES2,

                           -------------------------------*MES 3
                           CASE
                             WHEN    SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE(''15/05/2022''),''IW/YYYY'')   THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE(''15/05/2022''),''MM'')  THEN
                                0
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO < trunc(TO_DATE(''15/05/2022''),''MM'')  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE(''15/05/2022''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END MES_TOT3,
                           CASE
                             WHEN    SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE(''15/05/2022''),''IW/YYYY'')   THEN
                              CASE
                                WHEN EMPL_SITUACION = ''A'' AND
                                     EMPL_FEC_INGRESO <= ''15/05/2022''  THEN
                                 1
                                WHEN EMPL_SITUACION = ''I'' AND
                                     EMPL_FEC_INGRESO <= ''15/05/2022''  AND
                                     EMPL_FEC_SALIDA >= trunc(TO_DATE(''15/05/2022''),''MM'')  THEN
                                 1
                                ELSE
                                 0
                              END
                           END VAR_MES3,

                           CASE
                             WHEN   SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE(''15/05/2022''),''IW/YYYY'')   THEN
                                   3--- TO_CHAR(TO_DATE(''15/05/2022''),''MM/YYYY'')
                             WHEN MES || ''/'' || ANHO =  ''03/2022'' THEN
                                    1--- ''03/2022''
                             WHEN MES || ''/'' || ANHO =  ''04/2022'' THEN
                                    2--- ''04/2022''

                           END ANHO,

                           EMPL_DEPARTAMENTO,
                           DPTO_DESC,
                            ''03/2022'' MES1,
                             ''04/2022''  MES2,
                             ''05/2022'' MES3,
                           EMPL_NOMBRE,
                           EMPL_APE,
                           EMPL_SUCURSAL,
                           EMPL_DEPARTAMENTO,
                           EMPL_FEC_INGRESO,
                           EMPL_FEC_SALIDA,
                           EMPL_SITUACION,
                           EMPL_LEGAJO,
                           SUC_dESC
                         
                      FROM PER_EMPLEADO_HIST E, GEN_DEPARTAMENTO, PER_CARGO A, GEN_SUCURSAL

                     WHERE EMPL_DEPARTAMENTO = DPTO_CODIGO
                       AND EMPL_EMPRESA = DPTO_EMPR
                       AND EMPL_CARGO = A.CAR_CODIGO
                       AND EMPL_EMPRESA = A.CAR_EMPR
                       AND EMPL_SUCURSAL = SUC_CODIGO
                       AND EMPL_EMPRESA =SUC_EMPR
                       AND EMPL_CODIGO_PROV <> 0
                       AND EMPL_TIPO_CONT = ''I''
                       AND EMPL_FORMA_PAGO <> 0
                         AND CASE
                             WHEN   SEMANA || ''/'' || ANHO = TO_CHAR(TO_DATE(''15/05/2022''),''IW/YYYY'')   THEN
                              1
                             WHEN MES || ''/'' || ANHO =  ''03/2022'' THEN

                              1
                             WHEN MES || ''/'' || ANHO =  ''04/2022'' THEN
                              1 END = 1
                              AND EMPL_AREA_ORGANI IS NOT NULL
                       AND EMPL_EMPRESA = 1';
                       
   IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'IND_ROTACION_CARGO') THEN
       APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'IND_ROTACION_CARGO');
    END IF;
       APEX_COLLECTION.CREATE_COLLECTION_FROM_QUERY_B(P_COLLECTION_NAME => 'IND_ROTACION_CARGO',
                                                      P_QUERY           => P_QUERY13);



END PP_ROTACION_CARGO;


procedure add_hist_query(in_nombre varchar2, in_query clob) as
begin
   delete from x where otro = in_nombre;
   insert into x (campo1, otro) values (in_query, in_nombre);
end add_hist_query;
  
end PERL051;
/
