CREATE OR REPLACE PROCEDURE PER_IMPRIMIR_AUSENC_JUST(V_EMPRESA     IN NUMBER,
                                                     V_EMPL_LEG    IN NUMBER,
                                                     V_NRO_AUS     IN NUMBER,
                                                     V_USER        IN VARCHAR2,
                                                     V_TIPO_SALIDA IN VARCHAR2,
                                                     V_INCLUIR_CH  IN VARCHAR2) IS

  V_FECHA_AUS   DATE;
  V_NOMBRE      VARCHAR2(200);
  V_DOC_IDEN    NUMBER;
  V_CARGO_DESC  VARCHAR2(200);
  V_AREA_DESC   VARCHAR2(200);
  V_JEFE_APROB  VARCHAR2(200);
  V_TIPO        VARCHAR2(50);
  V_MOTIVO      VARCHAR2(50);
  V_FECHA_DESDE VARCHAR2(50);
  V_FECHA_HASTA VARCHAR2(50);
  V_CANT_DIAS   NUMBER;
  V_OBSER       VARCHAR2(2500);
  V_PARAMETROS  VARCHAR2(20000);
  V_AMPER       VARCHAR2(2) := '&';
  ERR_NUM       NUMBER;
  ERR_MSG       VARCHAR2(255);
  V_INDICA      VARCHAR2(2);
  l_report_name varchar2(60 char);
BEGIN

  SELECT P.AUSE_FECHA_GRAB,
         PE.EMPL_NOMBRE || ' ' || PE.EMPL_APE,
         PE.EMPL_DOC_IDENT,
         PC.CAR_DESC,
         AR.AREDPP_DESC,
         GE.OPER_NOMBRE,
         DECODE(P.AUSE_MOTIVO,
                'L',
                'Licencia',
                'R',
                'Reposo',
                'P',
                'Permiso',
                'A',
                'Ausente') TIPO,
         MOT.TIPAUS_DESC MOTIVO,
         CASE WHEN p.ause_indicador_hs = 'D' THEN
             TO_cHAR(P.AUSE_DESDE,'DD/MM/YYYY') 
         ELSE
             TO_cHAR(P.AUSE_HORA_DESDE,'DD/MM/YYYY HH24:MI:SS')
         END DESDE,
         CASE WHEN p.ause_indicador_hs = 'D' THEN
              TO_cHAR(P.AUSE_HASTA,'DD/MM/YYYY') 
         ELSE
              TO_cHAR(P.AUSE_HORA_HASTA,'DD/MM/YYYY HH24:MI:SS')
         END HASTA,
         nvl(P.AUSE_CANT_DIAS, p.ause_cant_hs),
         P.AUSE_OBS,
         ause_indicador_hs
    INTO V_FECHA_AUS,
         V_NOMBRE,
         V_DOC_IDEN,
         V_CARGO_DESC,
         V_AREA_DESC,
         V_JEFE_APROB,
         V_TIPO,
         V_MOTIVO,
         V_FECHA_DESDE,
         V_FECHA_HASTA,
         V_CANT_DIAS,
         V_OBSER,
         V_INDICA
    FROM PER_AUSENCIAS_JUSTIFICADAS P,
         PER_EMPLEADO               PE,
         PER_CARGO                  PC,
         PER_AREA_DPP               AR,
         GEN_OPERADOR               GE,
         PER_TIPOS_AUSENC_JUST      MOT
   WHERE P.AUSE_EMPR = V_EMPRESA
     AND P.AUSE_EMPL_LEGAJO = V_EMPL_LEG
     AND P.AUSE_NRO = V_NRO_AUS
     AND P.AUSE_EMPR = PE.EMPL_EMPRESA
     AND P.AUSE_EMPL_LEGAJO = PE.EMPL_LEGAJO
     AND PE.EMPL_EMPRESA = PC.CAR_EMPR(+)
     AND PE.EMPL_CARGO = PC.CAR_CODIGO(+)
     AND PE.EMPL_EMPRESA = AR.AREDPP_EMPR(+)
     AND PE.EMPL_AREA_ORGANI = AR.AREDPP_CLAVE(+)
     AND P.AUSE_OPER_APROB = GE.OPER_LOGIN(+)
     AND P.AUSE_EMPR = MOT.TIPAUS_EMPR(+)
     AND P.AUSE_TIPO = MOT.TIPAUS_CLAVE(+);

 /* V_OBSER := REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(V_OBSER,
                                                                     'a',
                                                                     'a'),
                                                             'e',
                                                             'e'),
                                                     'i',
                                                     'i'),
                                             'o',
                                             'o'),
                                     'u',
                                     'u'),
                             CHR(13),
                             ''),
                     CHR(10),
                     '');*/

  --REPLACE(col_name, CHR(13) + CHR(10), '')--Quitando enter del texto

  -- concatenar los parametros para llamar el reporte en jasper
  V_PARAMETROS := 'P_FORMATO=' || URL_ENCODE('pdf');
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_EMPRESA=' ||
                  URL_ENCODE(V_EMPRESA);
  --V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FECHA_SOL=' ||
    --              URL_ENCODE(V_FECHA_AUS);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_NOMBRE_EMPL=' ||
                  URL_ENCODE(V_NOMBRE);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CARGO=' ||
                  URL_ENCODE(V_CARGO_DESC);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CI=' ||
                  URL_ENCODE(V_DOC_IDEN);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_AREA=' ||
                  URL_ENCODE(V_AREA_DESC);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_JEFE_AUTORIZ=' ||
                  URL_ENCODE(V_JEFE_APROB);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_MOTIVO_AUSENCIA=' ||
                  URL_ENCODE(V_MOTIVO);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_TIPO_AUSENCIA=' ||
                  URL_ENCODE(V_TIPO);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FECHA_DESDE=' ||
                  URL_ENCODE(V_FECHA_DESDE);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_FECHA_HASTA=' ||
                  URL_ENCODE(V_FECHA_HASTA);
  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CANT_DIAS=' ||
                  URL_ENCODE(V_CANT_DIAS);
 -- V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_OBSERVACION=' ||
  --                URL_ENCODE(V_OBSER);

  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_INCLUIR_CH=' ||
                  URL_ENCODE(V_INCLUIR_CH);

  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_LEGAJO=' ||
                  URL_ENCODE(V_EMPL_LEG);

  V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_NRO_AUS=' ||
                  URL_ENCODE(V_NRO_AUS);
 V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_IND=' ||
                  URL_ENCODE(V_INDICA);
  DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = V_USER;
  ---RAISE_APPLICATION_ERROR(-20001,V_PARAMETROS);
  
  -- 25/07/2022 13:51:45 @PabloACespedes \(^-^)/
  -- Ajuste para todo el holding
  IF V_EMPRESA = 1 then
    l_report_name := 'PERI091';
  elsif V_EMPRESA = 2 then
    l_report_name := 'PERI091_T';
  else --> Holding
    l_report_name := 'PERI091_HOLDING';
  end if;
  
  INSERT INTO GEN_PARAMETROS_REPORT
    (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
  VALUES
    (V_PARAMETROS, V_USER, l_report_name, V_TIPO_SALIDA);
  
  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    ERR_NUM := SQLCODE;
    ERR_MSG := SQLERRM;

    RAISE_APPLICATION_ERROR(-20001,
                            'Problemas al encontrar la Ausencia Justificada');

END PER_IMPRIMIR_AUSENC_JUST;
/
