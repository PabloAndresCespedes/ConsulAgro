CREATE OR REPLACE PACKAGE STKI206 AS

  PROCEDURE PP_MOSTRAR_NOM_CONDUCT(PIN_P_EMPRESA               IN NUMBER,
                                   PIN_DOCU_TRA_CHOFER         IN NUMBER,
                                   POUT_DOCU_TRA_CHOFER_NOMBRE OUT VARCHAR2);

  PROCEDURE PP_MOSTRAR_DESC_CAMION(PIN_S_DOCU_TRA_CAMION         IN NUMBER,
                                   PIN_P_EMPRESA                 IN NUMBER,
                                   PIN_P_CONF_IND_CON_KMGPS      IN VARCHAR2,
                                   PIN_P_CONS_GPS                IN VARCHAR2,
                                   POUT_DOCU_TRA_CAMION          OUT NUMBER,
                                   POUT_DOCU_TRA_CHOFER          OUT NUMBER,
                                   POUT_S_CLAVE_GPS              OUT VARCHAR2,
                                   POUT_S_DESC_CAMION            OUT VARCHAR2,
                                   POUT_P_IND_KM                 OUT VARCHAR2,
                                   POUT_P_IND_HS                 OUT VARCHAR2,
                                   POUT_DOCU_TRA_CHOFER_NOMBRE   OUT VARCHAR2,
                                   POUT_S_DOCU_FEC_CONS_ANTERIOR OUT DATE,
                                   POUT_S_DOCU_TRA_KM_ANTERIOR   OUT NUMBER,
                                   POUT_S_DOCU_TRA_HORA_ANTERIOR OUT NUMBER,
                                   POUT_S_LITROS_PREVIOS         OUT NUMBER,
                                   POUT_S_FEC_GPS                OUT VARCHAR2,
                                   POUT_S_KM_GPS                 OUT NUMBER,
                                   POUT_CONTROL_KM_ACTUAL        OUT VARCHAR2,
                                   POUT_CONTROL_HS_ACTUAL        OUT VARCHAR2);

  PROCEDURE PP_CARGAR_CAM_POR_CARRETA(PIN_DOCU_TRA_CAMION           IN NUMBER,
                                      PIN_P_EMPRESA                 IN NUMBER,
                                      PIN_P_CONF_IND_CON_KMGPS      IN VARCHAR2,
                                      PIN_P_CONS_GPS                IN VARCHAR2,
                                      POUT_DOCU_TRA_CHOFER          OUT NUMBER,
                                      POUT_S_CLAVE_GPS              OUT VARCHAR2,
                                      POUT_P_IND_KM                 OUT VARCHAR2,
                                      POUT_P_IND_HS                 OUT VARCHAR2,
                                      POUT_DOCU_TRA_CHOFER_NOMBRE   OUT VARCHAR2,
                                      POUT_S_DOCU_FEC_CONS_ANTERIOR OUT DATE,
                                      POUT_S_DOCU_TRA_KM_ANTERIOR   OUT NUMBER,
                                      POUT_S_DOCU_TRA_HORA_ANTERIOR OUT NUMBER,
                                      POUT_S_LITROS_PREVIOS         OUT NUMBER,
                                      POUT_S_FEC_GPS                OUT VARCHAR2,
                                      POUT_S_KM_GPS                 OUT NUMBER,
                                      POUT_S_DESC_CAMION            OUT VARCHAR2,
                                      POUT_CONTROL_KM_ACTUAL        OUT VARCHAR2,
                                      POUT_CONTROL_HS_ACTUAL        OUT VARCHAR2);

  PROCEDURE PP_MOSTRAR_DESC_SUCU_ORIG(PIN_P_EMPRESA        IN NUMBER,
                                      PIN_DOCU_SUC_ORIG    IN NUMBER,
                                      POUT_S_DESC_SUC_ORIG OUT VARCHAR2);

  PROCEDURE PP_MOSTRAR_DESC_DEPO_ORIG(PIN_P_EMPRESA        IN NUMBER,
                                      PIN_DOCU_SUC_ORIG    IN NUMBER,
                                      PIN_DOCU_DEP_ORIG    IN NUMBER,
                                      POUT_S_DESC_DEP_ORIG OUT VARCHAR2);

  PROCEDURE PP_MOSTRAR_DESC_CAMION1(PIN_P_EMPRESA                 IN NUMBER,
                                    PIN_P_CONF_IND_CON_KMGPS      IN VARCHAR2,
                                    PIN_P_CONS_GPS                IN VARCHAR2,
                                    PIN_DOCU_TRA_CAMION           IN NUMBER,
                                    POUT_DOCU_TRA_CHOFER          OUT NUMBER,
                                    POUT_S_CLAVE_GPS              OUT VARCHAR2,
                                    POUT_S_DESC_CAMION            OUT VARCHAR2,
                                    POUT_P_IND_KM                 OUT VARCHAR2,
                                    POUT_P_IND_HS                 OUT VARCHAR2,
                                    POUT_DOCU_TRA_CHOFER_NOMBRE   OUT VARCHAR2,
                                    POUT_S_DOCU_FEC_CONS_ANTERIOR OUT DATE,
                                    POUT_S_DOCU_TRA_KM_ANTERIOR   OUT NUMBER,
                                    POUT_S_DOCU_TRA_HORA_ANTERIOR OUT NUMBER,
                                    POUT_S_LITROS_PREVIOS         OUT NUMBER,
                                    POUT_S_FEC_GPS                OUT VARCHAR2,
                                    POUT_S_KM_GPS                 OUT NUMBER,
                                    POUT_CONTROL_KM_ACTUAL        OUT VARCHAR2,
                                    POUT_CONTROL_HS_ACTUAL        OUT VARCHAR2,
                                    POUT_S_DOCU_TRA_CAMION        OUT NUMBER);

  PROCEDURE PP_GET_FEC_SIST_FIN(I_EMPRESA          IN NUMBER,
                                O_FEC_INIC_SISTEMA OUT DATE,
                                O_FEC_FIN_SISTEMA  OUT DATE);

  PROCEDURE PP_CARGAR_DATOS(PIN_P_DESC_EMPRESA        IN VARCHAR2,
                            PIN_P_DESC_SUCURSAL       IN VARCHAR2,
                            PIN_S_DESC_PROGRAMA       IN VARCHAR2,
                            PIN_S_PROGRAMA            IN VARCHAR2,
                            PIN_P_EMPRESA             IN VARCHAR2,
                            PIN_P_SUCURSAL            IN NUMBER,
                            POUT_W_FLAG_COMMIT        OUT VARCHAR2,
                            POUT_S_USUARIO            OUT VARCHAR2,
                            POUT_S_FECHA              OUT VARCHAR2,
                            POUT_S_DOCU_FEC_EMIS      OUT VARCHAR2,
                            POUT_S_DESC_EMPRESA       OUT VARCHAR2,
                            POUT_S_DESC_SUCURSAL      OUT VARCHAR2,
                            POUT_S_DESC_PROGRAMA      OUT VARCHAR2,
                            POUT_S_PROGRAMA           OUT VARCHAR2,
                            POUT_S_LOGIN              OUT VARCHAR2,
                            POUT_P_IND_FEC_CONS_INT   OUT VARCHAR2,
                            POUT_DOCU_SUC_ORIG        OUT NUMBER,
                            POUT_S_OPERADOR           OUT VARCHAR2,
                            POUT_P_TIPO_IMPRESORA     OUT VARCHAR2,
                            POUT_P_FEC_INIC_SISTEMA   OUT DATE,
                            POUT_P_FEC_FIN_SISTEMA    OUT DATE,
                            POUT_P_CONF_IND_CON_KMGPS OUT VARCHAR2,
                            POUT_P_CONS_GPS           OUT VARCHAR2,
                            POUT_S_DESC_SUC_ORIG      OUT VARCHAR2,
                            POUT_HAB_HS_GPS           OUT VARCHAR2,
                            POUT_P_OPER               OUT VARCHAR2);

  PROCEDURE PP_INICIAR_COLLECTION;

  PROCEDURE PP_ADD_ITEM(I_EMPRESA       IN NUMBER,
                        I_SEQ           NUMBER,
                        I_ARTICULO_COD  IN NUMBER,
                        I_ARTICULO_DESC IN VARCHAR2,
                        I_CANT          IN NUMBER,
                        I_SERIE         IN VARCHAR2);

  PROCEDURE PP_BORRAR_DET(I_SEQ IN NUMBER);

  /*PROCEDURE PP_EXHIBIR_DESC_ARTICULO(Pin_P_EMPRESA           IN VARCHAR2,
  Pin_DETA_ART            IN NUMBER,
  Pout_ART_CONTROL_KM     OUT VARCHAR2,
  Pout_ART_IND_COMBUS     OUT VARCHAR2,
  Pout_ART_IND_COMBUS_NUM OUT VARCHAR2,
  Pout_ART_DESC           OUT VARCHAR2,
  Pout_S_ORILINK          OUT NUMBER);*/

  PROCEDURE PP_VALIDAR_ART(PIN_DETA_ART  IN NUMBER,
                           PIN_DESC_ART  IN VARCHAR2,
                           PIN_DETA_CANT IN NUMBER);

  PROCEDURE PP_IMPRIMIR_DOC(I_EMPRESA IN NUMBER, I_DOCUT_CLAVE IN NUMBER);

  PROCEDURE PP_ESTABL_VARIABLES_BDOCU(PIN_P_SUCURSAL             IN VARCHAR2,
                                      PIN_P_EMPRESA              IN VARCHAR2,
                                      PIN_P_CONF_IND_CON_KMGPS   IN VARCHAR2,
                                      PIN_P_IND_EXCL_ADITIVO     IN VARCHAR2,
                                      PIN_S_KM_GPS               IN NUMBER,
                                      PIN_S_HORA                 IN VARCHAR2,
                                      PIN_P_SISTEMA              IN NUMBER,
                                      PIN_S_DOCU_TRA_CAMION      IN NUMBER,
                                      PIN_S_SUM_ORILINK          IN NUMBER,
                                      PIN_S_USUARIO              IN VARCHAR2,
                                      PIN_S_DOCU_TRA_KM_ANTERIOR IN NUMBER,
                                      PIN_S_KM_RECORRIDOS        IN NUMBER,
                                      PIN_P_PROGRAMA             IN NUMBER,
                                      PIN_DETA_CANT_COMBU_SUM    IN NUMBER,
                                      POUT_DOCU_NRO_DOC          OUT NUMBER,
                                      POUT_DOCU_KM_GPS           OUT VARCHAR2,
                                      POUT_DOCU_FEC_GPS          OUT DATE,
                                      POUT_DOCU_ESTADO_CONS      OUT VARCHAR2,
                                      POUT_DOCU_IND_ORILINK      OUT VARCHAR2,
                                      POUT_DOCU_EMPR             OUT NUMBER,
                                      POUT_DOCU_LOGIN            OUT VARCHAR2,
                                      POUT_DOCU_FEC_GRAB         OUT DATE,
                                      POUT_DOCU_KM_ANT           OUT NUMBER,
                                      POUT_DOCU_KM_RECORRIDO     OUT NUMBER,
                                      POUT_DOCU_LTS_COMBU        OUT VARCHAR2);

  PROCEDURE PP_BAJA_ART_SERIE(PIN_S_DOCU_TAL_OT_TRAB IN VARCHAR2,
                              PIN_DOCU_CLAVE         IN NUMBER,
                              PIN_P_EMPRESA          IN VARCHAR2);

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_P_SUCURSAL                   IN VARCHAR2,
                                   I_P_EMPRESA                    IN VARCHAR2,
                                   I_P_CONF_IND_CON_KMGPS         IN VARCHAR2,
                                   I_P_IND_EXCL_ADITIVO           IN VARCHAR2,
                                   I_S_KM_GPS                     IN NUMBER,
                                   I_S_HORA                       IN VARCHAR2,
                                   I_P_SISTEMA                    IN NUMBER,
                                   I_S_DOCU_TRA_CAMION            IN NUMBER,
                                   I_S_SUM_ORILINK                IN NUMBER,
                                   I_S_USUARIO                    IN VARCHAR2,
                                   I_S_DOCU_TRA_KM_ANTERIOR       IN NUMBER,
                                   I_S_KM_RECORRIDOS              IN NUMBER,
                                   I_P_PROGRAMA                   IN NUMBER,
                                   I_DETA_CANT_COMBU_SUM          IN NUMBER,
                                   O_DOCU_NRO_DOC                 OUT NUMBER,
                                   O_DOCU_KM_GPS                  OUT VARCHAR2,
                                   O_DOCU_FEC_GPS                 OUT DATE,
                                   O_DOCU_ESTADO_CONS             OUT VARCHAR2,
                                   O_DOCU_IND_ORILINK             OUT VARCHAR2,
                                   O_DOCU_EMPR                    OUT NUMBER,
                                   O_DOCU_LOGIN                   OUT VARCHAR2,
                                   O_DOCU_FEC_GRAB                OUT DATE,
                                   O_DOCU_KM_ANT                  OUT NUMBER,
                                   O_DOCU_KM_RECORRIDO            OUT NUMBER,
                                   I_DOCU_SIST                    IN VARCHAR2,
                                   O_DOCU_LTS_COMBU               OUT VARCHAR2,
                                   I_S_DOCU_TAL_OT_TRAB           IN VARCHAR2,
                                   I_DOCU_CLAVE                   IN NUMBER,
                                   O_W_FLAG_COMMIT                OUT VARCHAR2,
                                   O_DOCU_CLAVE                   OUT NUMBER,
                                   O_DETA_CLAVE_DOC               OUT NUMBER,
                                   I_DOCU_FEC_EMIS                IN DATE,
                                   I_DOCU_SUC_ORIG                IN NUMBER,
                                   I_DOCU_DEP_ORIG                IN NUMBER,
                                   I_DOCU_TRA_CARRETA             IN NUMBER,
                                   I_DOCU_TRA_CAMION              IN NUMBER,
                                   I_DOCU_TAL_OT                  IN NUMBER,
                                   I_DOCU_TRA_KM_ACTUAL           IN NUMBER,
                                   I_DOCU_TRA_HORA_ACTUAL         IN NUMBER,
                                   I_DOCU_TRA_CHOFER              IN NUMBER,
                                   I_DOCU_TRA_CHOFER_NOMBRE       IN VARCHAR2,
                                   I_DOCU_OBS                     IN VARCHAR2,
                                   I_DOCU_SUC_DEST                IN NUMBER,
                                   I_DOCU_DEP_DEST                IN NUMBER,
                                   I_DOCU_LEGAJO                  IN NUMBER,
                                   I_DOCU_MON                     IN NUMBER,
                                   I_DOCU_TIPO_MOV                IN NUMBER,
                                   I_DOCU_EXEN_NETO_MON           IN NUMBER,
                                   I_DOCU_GRAV_NETO_MON           IN NUMBER,
                                   I_DOCU_IVA_MON                 IN NUMBER,
                                   I_DOCU_EXEN_NETO_LOC           IN NUMBER,
                                   I_DOCU_GRAV_NETO_LOC           IN NUMBER,
                                   I_DOCU_IVA_LOC                 IN NUMBER,
                                   I_DOCU_CLI                     IN NUMBER,
                                   I_DOCU_PROV                    IN NUMBER,
                                   I_DOCU_GRAV_BRUTO_LOC          IN NUMBER,
                                   I_DOCU_GRAV_BRUTO_MON          IN NUMBER,
                                   I_DOCU_EXEN_BRUTO_LOC          IN NUMBER,
                                   I_DOCU_EXEN_BRUTO_MON          IN NUMBER,
                                   I_DOCU_IND_NO_FUNC_ODOMETRO    IN VARCHAR2,
                                   I_DOCU_IND_NO_FUNC_HORIMETRO   IN VARCHAR2,
                                   I_DOCU_IND_NO_FUNC_VELOCIMETRO IN VARCHAR2,
                                   I_DETA_OT_IND_CAR_CAM          IN VARCHAR2,
                                   I_DETA_NRO_REM                 IN NUMBER,
                                   I_DETA_IMP_NETO_LOC            IN NUMBER,
                                   I_DETA_IMP_NETO_MON            IN NUMBER,
                                   I_DETA_IMPU                    IN NUMBER,
                                   I_DETA_IVA_LOC                 IN NUMBER,
                                   I_DETA_IVA_MON                 IN NUMBER,
                                   I_DETA_PORC_DTO                IN NUMBER,
                                   I_DETA_IMP_BRUTO_LOC           IN NUMBER,
                                   I_DETA_IMP_BRUTO_MON           IN NUMBER,
                                   O_MOSTRAR_BTN                  OUT VARCHAR2,
                                   O_ESTADO                       OUT VARCHAR2);

  PROCEDURE PP_IMPRIMIR_CONSUMO(I_CLAVE                    IN NUMBER,
                                I_S_DOCU_TRA_KM_ANTERIOR   NUMBER,
                                I_S_KM_RECORRIDOS          NUMBER,
                                I_S_RENDIMIENTO            NUMBER,
                                I_S_DOCU_TRA_HORA_ANTERIOR NUMBER,
                                I_DOCU_TRA_HORA_ACTUAL     NUMBER,
                                I_S_TIEMPO                 NUMBER,
                                I_S_RENDIMIENTO_HORA       NUMBER);
  PROCEDURE PP_VALIDAR_DETALLES(O_P_IND_EXCL_ADITIVO OUT VARCHAR2,
                                O_DETA_CANT_COMBU    OUT VARCHAR2);

  PROCEDURE PP_EXHIBIR_DESC_ARTICULO(I_SEQ      IN NUMBER,
                                     I_EMPRESA  IN NUMBER,
                                     I_DETA_ART IN NUMBER,
                                     I_CANT     IN NUMBER,
                                     I_SERIE    IN VARCHAR2);
  PROCEDURE PP_VALIDAR_IMPRESORA;
  PROCEDURE PP_RECUPERAR_REG(I_DOCU_CLAVE IN NUMBER,
                             I_EMPRESA    IN NUMBER,
                             O_DOCU       OUT STK_DOCUMENTO%ROWTYPE);

  FUNCTION FP_RENDIMIENTO(I_KM_RECORRIDOS IN NUMBER, I_CANT_COMB IN NUMBER)
    RETURN NUMBER;
END STKI206;
/
CREATE OR REPLACE PACKAGE BODY STKI206 AS

  PROCEDURE PP_MOSTRAR_NOM_CONDUCT(PIN_P_EMPRESA               IN NUMBER,
                                   PIN_DOCU_TRA_CHOFER         IN NUMBER,
                                   POUT_DOCU_TRA_CHOFER_NOMBRE OUT VARCHAR2) IS
  
  BEGIN
  
    SELECT C.COF_NOMBRE
      INTO POUT_DOCU_TRA_CHOFER_NOMBRE
      FROM TRA_CHOFER C
     WHERE C.COF_CODIGO = PIN_DOCU_TRA_CHOFER
       AND C.COF_EMPR = PIN_P_EMPRESA;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      POUT_DOCU_TRA_CHOFER_NOMBRE := NULL;
      RAISE_APPLICATION_ERROR(-20201, 'Conductor inexistente!');
    
  END PP_MOSTRAR_NOM_CONDUCT;

  PROCEDURE PP_MOSTRAR_DESC_CAMION(PIN_S_DOCU_TRA_CAMION         IN NUMBER,
                                   PIN_P_EMPRESA                 IN NUMBER,
                                   PIN_P_CONF_IND_CON_KMGPS      IN VARCHAR2,
                                   PIN_P_CONS_GPS                IN VARCHAR2,
                                   POUT_DOCU_TRA_CAMION          OUT NUMBER,
                                   POUT_DOCU_TRA_CHOFER          OUT NUMBER,
                                   POUT_S_CLAVE_GPS              OUT VARCHAR2,
                                   POUT_S_DESC_CAMION            OUT VARCHAR2,
                                   POUT_P_IND_KM                 OUT VARCHAR2,
                                   POUT_P_IND_HS                 OUT VARCHAR2,
                                   POUT_DOCU_TRA_CHOFER_NOMBRE   OUT VARCHAR2,
                                   POUT_S_DOCU_FEC_CONS_ANTERIOR OUT DATE,
                                   POUT_S_DOCU_TRA_KM_ANTERIOR   OUT NUMBER,
                                   POUT_S_DOCU_TRA_HORA_ANTERIOR OUT NUMBER,
                                   POUT_S_LITROS_PREVIOS         OUT NUMBER,
                                   POUT_S_FEC_GPS                OUT VARCHAR2,
                                   POUT_S_KM_GPS                 OUT NUMBER,
                                   POUT_CONTROL_KM_ACTUAL        OUT VARCHAR2,
                                   POUT_CONTROL_HS_ACTUAL        OUT VARCHAR2) AS
    V_CHAPA        VARCHAR2(40);
    V_MARCA        VARCHAR2(40);
    V_CONTROL_KM   VARCHAR2(1);
    V_CONTROL_HORA VARCHAR2(1);
    V_CANTIDAD     NUMBER;
    V_FECHA        VARCHAR2(100);
    V_KM           VARCHAR2(100);
    V_CANT_COMA    NUMBER;
    V_COD_CHOF     NUMBER;
    V_CAM_CODIGO   NUMBER;
    V_MENSAJE      VARCHAR2(32767);
    V_LINEA        VARCHAR2(32767);
  BEGIN
    BEGIN 
      SELECT CAM_CHAPA,
             CAM_MARCA,
             CAM_CODIGO,
             NVL(CAM_CONTROL_KM, 'S') CAM_CONTROL_KM,
             NVL(CAM_CONTROL_HORA, 'S') CAM_CONTROL_HORA,
             CAM_COF_CODIGO,
             CAM_CLAVE_GPS
        INTO V_CHAPA,
             V_MARCA,
             V_CAM_CODIGO,
             V_CONTROL_KM,
             V_CONTROL_HORA,
             V_COD_CHOF,
             POUT_S_CLAVE_GPS
        FROM TRA_CAMION
       WHERE CAM_PROPIO_COD = PIN_S_DOCU_TRA_CAMION
         AND CAM_EMPR = PIN_P_EMPRESA;
    
      IF LENGTH(V_CHAPA) < 5 THEN
        POUT_S_DESC_CAMION := V_MARCA;
      ELSE
        POUT_S_DESC_CAMION := V_CHAPA;
      END IF;
    
      IF NVL(V_CONTROL_KM, 'S') = 'S' THEN
        POUT_CONTROL_KM_ACTUAL := 'TRUE';
        POUT_P_IND_KM          := 'S';
      ELSE
        POUT_CONTROL_KM_ACTUAL := 'FALSE';
        POUT_P_IND_KM          := 'N';
      END IF;
    
      IF NVL(V_CONTROL_HORA, 'S') = 'S' THEN
        POUT_P_IND_HS          := 'S';
        POUT_CONTROL_HS_ACTUAL := 'TRUE';
      ELSE
        POUT_CONTROL_HS_ACTUAL := 'FALSE';
        POUT_P_IND_HS          := 'N';
      END IF;
    
      IF V_COD_CHOF IS NOT NULL THEN
        PP_MOSTRAR_NOM_CONDUCT(PIN_P_EMPRESA,
                               V_COD_CHOF,
                               POUT_DOCU_TRA_CHOFER_NOMBRE);
        POUT_DOCU_TRA_CHOFER := V_COD_CHOF;
      END IF;
    
      --=================
      FOR V IN (SELECT T.CANTIDAD, T.KM_ACTUAL, T.HORA_ACTUAL, T.FECHA
                  FROM LONDON_REND_CAMION_TAGRO T
                 WHERE T.CAM_CODIGO = V_CAM_CODIGO
                   AND CAM_EMPR = PIN_P_EMPRESA
                 ORDER BY T.FECHA DESC, T.KM_ACTUAL DESC) LOOP
      
        POUT_S_DOCU_FEC_CONS_ANTERIOR := V.FECHA;
        POUT_S_DOCU_TRA_KM_ANTERIOR   := V.KM_ACTUAL;
        POUT_S_DOCU_TRA_HORA_ANTERIOR := V.HORA_ACTUAL;
        POUT_S_LITROS_PREVIOS         := V.CANTIDAD;
        EXIT;
      END LOOP;
    
      --=================
      --  raise_application_error(-20010,PIN_P_CONF_IND_CON_KMGPS);
      IF NVL(PIN_P_CONF_IND_CON_KMGPS, 'N') = 'S' THEN
        BEGIN
          SELECT MAX(TO_CHAR(FECHA, 'YYYY-MM-DD') || '%20' ||
                     TO_CHAR(FECHA, 'HH24:MI:SS'))
            INTO V_FECHA
            FROM (SELECT MAX(A.DOCU_FEC_GPS) FECHA
                    FROM STK_DOCUMENTO A
                   WHERE A.DOCU_EMPR = PIN_P_EMPRESA
                     AND DOCU_TRA_CAMION = V_CAM_CODIGO
                  UNION
                  SELECT MAX(B.TCKM_FECHA) FECHA
                    FROM TRA_CAMION_COMB_KM_TMP B
                   WHERE B.TCKM_CAMION = V_CAM_CODIGO
                     AND B.TCKM_UTILIZADO = 'N'
                     AND B.TCKM_EMPR = PIN_P_EMPRESA
                  UNION
                  SELECT MAX(DCON_TRA_FEC_GPS)
                    FROM FIN_DOCUMENTO_TMP, FIN_DOC_CONCEPTO_TMP
                   WHERE DOC_TIPO_MOV IN (1, 2)
                     AND DOC_TMP_ESTADO NOT IN ('T', 'A')
                     AND DOC_EMPR = DCON_EMPR
                     AND DOC_CLAVE = DCON_CLAVE_DOC
                     AND DCON_TRA_CAMION = V_CAM_CODIGO
                     AND DOC_EMPR = PIN_P_EMPRESA
                  UNION
                  SELECT MAX(DCON_TRA_FEC_GPS)
                    FROM FIN_DOCUMENTO, FIN_DOC_CONCEPTO
                   WHERE DOC_TIPO_MOV IN (1, 2)
                     AND DOC_EMPR = DCON_EMPR
                     AND DOC_CLAVE = DCON_CLAVE_DOC
                     AND DCON_TRA_CAMION = V_CAM_CODIGO
                     AND DOC_EMPR = PIN_P_EMPRESA);
        
          IF V_FECHA = '%20' THEN
            V_FECHA := NULL;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_FECHA := NULL;
        END;
        POUT_S_FEC_GPS := V_FECHA;
      
        IF POUT_S_CLAVE_GPS IS NOT NULL AND V_FECHA IS NOT NULL THEN
          IF PIN_P_CONS_GPS = 'S' THEN
          
            BEGIN
              POUT_S_KM_GPS := FP_CONSULTA_KM_GPS(POUT_S_CLAVE_GPS,
                                                  V_FECHA,
                                                  TO_CHAR(TRUNC(SYSDATE) + 1,
                                                          'YYYY-MM-DD'));
            EXCEPTION
              WHEN OTHERS THEN
                V_MENSAJE := '<span style = "color: red;"> ' ||
                             'Falta registrar IMP_TICKET en el Register de Windows! B' ||
                             ' </span>';
                V_LINEA   := '<span style = "color: white;"> ' ||
                             RPAD('_', 50, '_') || ' </span>';
                --===============================================================================================================
                V_MENSAJE := V_MENSAJE || '<br>' || V_LINEA;
              
                --'<span style = "color: yellow;"> Imprimir Factura ! </span>' ;
              
                APEX_APPLICATION.G_PRINT_SUCCESS_MESSAGE := V_MENSAJE;
            END;
          ELSE
            POUT_S_KM_GPS := 0;
          END IF;
        ELSE
          POUT_S_KM_GPS := 0;
        END IF;
      
      END IF;
    
      POUT_DOCU_TRA_CAMION := V_CAM_CODIGO;
    END;
    ---------------------------------
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      POUT_S_DESC_CAMION   := NULL;
      POUT_DOCU_TRA_CAMION := NULL;
      RAISE_APPLICATION_ERROR(-20201, 'Camion inexistente!');
    
  END PP_MOSTRAR_DESC_CAMION;

  PROCEDURE PP_CARGAR_CAM_POR_CARRETA(PIN_DOCU_TRA_CAMION           IN NUMBER,
                                      PIN_P_EMPRESA                 IN NUMBER,
                                      PIN_P_CONF_IND_CON_KMGPS      IN VARCHAR2,
                                      PIN_P_CONS_GPS                IN VARCHAR2,
                                      POUT_DOCU_TRA_CHOFER          OUT NUMBER,
                                      POUT_S_CLAVE_GPS              OUT VARCHAR2,
                                      POUT_P_IND_KM                 OUT VARCHAR2,
                                      POUT_P_IND_HS                 OUT VARCHAR2,
                                      POUT_DOCU_TRA_CHOFER_NOMBRE   OUT VARCHAR2,
                                      POUT_S_DOCU_FEC_CONS_ANTERIOR OUT DATE,
                                      POUT_S_DOCU_TRA_KM_ANTERIOR   OUT NUMBER,
                                      POUT_S_DOCU_TRA_HORA_ANTERIOR OUT NUMBER,
                                      POUT_S_LITROS_PREVIOS         OUT NUMBER,
                                      POUT_S_FEC_GPS                OUT VARCHAR2,
                                      POUT_S_KM_GPS                 OUT NUMBER,
                                      POUT_S_DESC_CAMION            OUT VARCHAR2,
                                      POUT_CONTROL_KM_ACTUAL        OUT VARCHAR2,
                                      POUT_CONTROL_HS_ACTUAL        OUT VARCHAR2) IS
  
    V_CHAPA        VARCHAR2(40);
    V_MARCA        VARCHAR2(40);
    V_CONTROL_KM   VARCHAR2(1);
    V_CONTROL_HORA VARCHAR2(1);
    V_CANTIDAD     NUMBER;
    V_FECHA        VARCHAR2(100);
    V_KM           VARCHAR2(100);
    V_CANT_COMA    NUMBER;
  BEGIN
    SELECT NVL(CAM_CONTROL_KM, 'S') CAM_CONTROL_KM,
           NVL(CAM_CONTROL_HORA, 'S') CAM_CONTROL_HORA,
           CAM_COF_CODIGO,
           CAM_CLAVE_GPS
      INTO V_CONTROL_KM,
           V_CONTROL_HORA,
           POUT_DOCU_TRA_CHOFER,
           POUT_S_CLAVE_GPS
      FROM TRA_CAMION
     WHERE CAM_CODIGO = PIN_DOCU_TRA_CAMION
       AND CAM_EMPR = PIN_P_EMPRESA;
  
    IF NVL(V_CONTROL_KM, 'S') = 'S' THEN
      POUT_CONTROL_KM_ACTUAL := 'TRUE';
      POUT_P_IND_KM          := 'S';
    ELSE
      POUT_CONTROL_KM_ACTUAL := 'FALSE';
      POUT_P_IND_KM          := 'N';
    END IF;
  
    IF NVL(V_CONTROL_HORA, 'S') = 'S' THEN
      POUT_CONTROL_HS_ACTUAL := 'TRUE';
      POUT_P_IND_HS          := 'S';
    ELSE
      POUT_CONTROL_HS_ACTUAL := 'FALSE';
      POUT_P_IND_HS          := 'N';
    END IF;
  
    IF POUT_DOCU_TRA_CHOFER IS NOT NULL THEN
      PP_MOSTRAR_NOM_CONDUCT(PIN_P_EMPRESA,
                             POUT_DOCU_TRA_CHOFER,
                             POUT_DOCU_TRA_CHOFER_NOMBRE);
    END IF;
  
    --=================
    FOR V IN (SELECT T.CANTIDAD, T.KM_ACTUAL, T.HORA_ACTUAL, T.FECHA
                FROM LONDON_REND_CAMION_TAGRO T
               WHERE T.CAM_CODIGO = PIN_DOCU_TRA_CAMION
                 AND CAM_EMPR = PIN_P_EMPRESA
               ORDER BY T.FECHA DESC, T.KM_ACTUAL DESC) LOOP
    
      POUT_S_DOCU_FEC_CONS_ANTERIOR := V.FECHA;
      POUT_S_DOCU_TRA_KM_ANTERIOR   := V.KM_ACTUAL;
      POUT_S_DOCU_TRA_HORA_ANTERIOR := V.HORA_ACTUAL;
      POUT_S_LITROS_PREVIOS         := V.CANTIDAD;
      EXIT;
    END LOOP;
  
    --=================
  
    IF NVL(PIN_P_CONF_IND_CON_KMGPS, 'N') = 'S' THEN
      BEGIN
        SELECT MAX(TO_CHAR(FECHA, 'YYYY-MM-DD') || '%20' ||
                   TO_CHAR(FECHA, 'HH24:MI:SS'))
          INTO V_FECHA
          FROM (SELECT MAX(A.DOCU_FEC_GPS) FECHA
                  FROM STK_DOCUMENTO A
                 WHERE A.DOCU_EMPR = PIN_P_EMPRESA
                   AND DOCU_TRA_CAMION = PIN_DOCU_TRA_CAMION
                UNION
                SELECT MAX(B.TCKM_FECHA) FECHA
                  FROM TRA_CAMION_COMB_KM_TMP B
                 WHERE B.TCKM_CAMION = PIN_DOCU_TRA_CAMION
                   AND B.TCKM_UTILIZADO = 'N'
                   AND B.TCKM_EMPR = PIN_P_EMPRESA
                UNION
                SELECT MAX(DCON_TRA_FEC_GPS)
                  FROM FIN_DOCUMENTO_TMP, FIN_DOC_CONCEPTO_TMP
                 WHERE DOC_TIPO_MOV IN (1, 2)
                   AND DOC_TMP_ESTADO NOT IN ('T', 'A')
                   AND DOC_EMPR = DCON_EMPR
                   AND DOC_CLAVE = DCON_CLAVE_DOC
                   AND DCON_TRA_CAMION = PIN_DOCU_TRA_CAMION
                   AND DOC_EMPR = PIN_P_EMPRESA
                UNION
                SELECT MAX(DCON_TRA_FEC_GPS)
                  FROM FIN_DOCUMENTO, FIN_DOC_CONCEPTO
                 WHERE DOC_TIPO_MOV IN (1, 2)
                   AND DOC_EMPR = DCON_EMPR
                   AND DOC_CLAVE = DCON_CLAVE_DOC
                   AND DCON_TRA_CAMION = PIN_DOCU_TRA_CAMION
                   AND DOC_EMPR = PIN_P_EMPRESA);
      
        IF V_FECHA = '%20' THEN
          V_FECHA := NULL;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          V_FECHA := NULL;
      END;
      POUT_S_FEC_GPS := V_FECHA;
      IF POUT_S_CLAVE_GPS IS NOT NULL AND V_FECHA IS NOT NULL THEN
        IF PIN_P_CONS_GPS = 'S' THEN
          POUT_S_KM_GPS := FP_CONSULTA_KM_GPS(POUT_S_CLAVE_GPS,
                                              V_FECHA,
                                              TO_CHAR(TRUNC(SYSDATE) + 1,
                                                      'YYYY-MM-DD'));
        
        ELSE
          POUT_S_KM_GPS := 0;
        END IF;
      ELSE
        POUT_S_KM_GPS := 0;
      END IF;
    
    END IF;
  
    -------------------------------------
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      POUT_S_DESC_CAMION := NULL;
      RAISE_APPLICATION_ERROR(-20201, 'Camion inexistente!');
    
  END PP_CARGAR_CAM_POR_CARRETA;

  PROCEDURE PP_MOSTRAR_DESC_SUCU_ORIG(PIN_P_EMPRESA        IN NUMBER,
                                      PIN_DOCU_SUC_ORIG    IN NUMBER,
                                      POUT_S_DESC_SUC_ORIG OUT VARCHAR2) IS
    R_SUCURSAL GEN_SUCURSAL%ROWTYPE;
  BEGIN
    SELECT *
      INTO R_SUCURSAL
      FROM GEN_SUCURSAL
     WHERE SUC_EMPR = PIN_P_EMPRESA
       AND SUC_CODIGO = PIN_DOCU_SUC_ORIG;
  
    POUT_S_DESC_SUC_ORIG := R_SUCURSAL.SUC_DESC;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      POUT_S_DESC_SUC_ORIG := NULL;
      RAISE_APPLICATION_ERROR(-20201, 'Sucursal inexistente!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20201, 'ERROR1!');
    
  END PP_MOSTRAR_DESC_SUCU_ORIG;

  PROCEDURE PP_MOSTRAR_DESC_DEPO_ORIG(PIN_P_EMPRESA        IN NUMBER,
                                      PIN_DOCU_SUC_ORIG    IN NUMBER,
                                      PIN_DOCU_DEP_ORIG    IN NUMBER,
                                      POUT_S_DESC_DEP_ORIG OUT VARCHAR2) IS
    R_DEPOSITO STK_DEPOSITO%ROWTYPE;
  BEGIN
    SELECT *
      INTO R_DEPOSITO
      FROM STK_DEPOSITO
     WHERE DEP_EMPR = PIN_P_EMPRESA
       AND DEP_SUC = PIN_DOCU_SUC_ORIG
       AND DEP_CODIGO = PIN_DOCU_DEP_ORIG;
  
    POUT_S_DESC_DEP_ORIG := R_DEPOSITO.DEP_DESC;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      POUT_S_DESC_DEP_ORIG := NULL;
      RAISE_APPLICATION_ERROR(-20201, 'Depi??sito inexistente!');
  END PP_MOSTRAR_DESC_DEPO_ORIG;

  PROCEDURE PP_MOSTRAR_DESC_CAMION1(PIN_P_EMPRESA                 IN NUMBER,
                                    PIN_P_CONF_IND_CON_KMGPS      IN VARCHAR2,
                                    PIN_P_CONS_GPS                IN VARCHAR2,
                                    PIN_DOCU_TRA_CAMION           IN NUMBER,
                                    POUT_DOCU_TRA_CHOFER          OUT NUMBER,
                                    POUT_S_CLAVE_GPS              OUT VARCHAR2,
                                    POUT_S_DESC_CAMION            OUT VARCHAR2,
                                    POUT_P_IND_KM                 OUT VARCHAR2,
                                    POUT_P_IND_HS                 OUT VARCHAR2,
                                    POUT_DOCU_TRA_CHOFER_NOMBRE   OUT VARCHAR2,
                                    POUT_S_DOCU_FEC_CONS_ANTERIOR OUT DATE,
                                    POUT_S_DOCU_TRA_KM_ANTERIOR   OUT NUMBER,
                                    POUT_S_DOCU_TRA_HORA_ANTERIOR OUT NUMBER,
                                    POUT_S_LITROS_PREVIOS         OUT NUMBER,
                                    POUT_S_FEC_GPS                OUT VARCHAR2,
                                    POUT_S_KM_GPS                 OUT NUMBER,
                                    POUT_CONTROL_KM_ACTUAL        OUT VARCHAR2,
                                    POUT_CONTROL_HS_ACTUAL        OUT VARCHAR2,
                                    POUT_S_DOCU_TRA_CAMION        OUT NUMBER) AS
    V_CONTROL_KM   VARCHAR2(1);
    V_CONTROL_HORA VARCHAR2(1);
    V_CANTIDAD     NUMBER;
    V_FECHA        VARCHAR2(100);
    V_KM           VARCHAR2(100);
    V_CANT_COMA    NUMBER;
  BEGIN
    BEGIN
      SELECT CAM_CHAPA,
             NVL(CAM_CONTROL_KM, 'S') CAM_CONTROL_KM,
             NVL(CAM_CONTROL_HORA, 'S') CAM_CONTROL_HORA,
             CAM_COF_CODIGO,
             CAM_CLAVE_GPS,
             CAM_PROPIO_COD
        INTO POUT_S_DESC_CAMION,
             V_CONTROL_KM,
             V_CONTROL_HORA,
             POUT_DOCU_TRA_CHOFER,
             POUT_S_CLAVE_GPS,
             POUT_S_DOCU_TRA_CAMION
        FROM TRA_CAMION
       WHERE CAM_CODIGO = PIN_DOCU_TRA_CAMION
         AND CAM_EMPR = PIN_P_EMPRESA;
    
      IF NVL(V_CONTROL_KM, 'S') = 'S' THEN
        POUT_CONTROL_KM_ACTUAL := 'TRUE';
        POUT_P_IND_KM          := 'S';
      ELSE
        POUT_CONTROL_KM_ACTUAL := 'FALSE';
        POUT_P_IND_KM          := 'N';
      END IF;
    
      IF NVL(V_CONTROL_HORA, 'S') = 'S' THEN
        POUT_P_IND_HS          := 'S';
        POUT_CONTROL_HS_ACTUAL := 'TRUE';
      ELSE
        POUT_CONTROL_HS_ACTUAL := 'FALSE';
        POUT_P_IND_HS          := 'N';
      END IF;
    
      IF POUT_DOCU_TRA_CHOFER IS NOT NULL THEN
        PP_MOSTRAR_NOM_CONDUCT(PIN_P_EMPRESA,
                               POUT_DOCU_TRA_CHOFER,
                               POUT_DOCU_TRA_CHOFER_NOMBRE);
      END IF;
    
      --=================
      FOR V IN (SELECT T.CANTIDAD, T.KM_ACTUAL, T.HORA_ACTUAL, T.FECHA
                  FROM LONDON_REND_CAMION_TAGRO T
                 WHERE T.CAM_CODIGO = PIN_DOCU_TRA_CAMION
                   AND CAM_EMPR = PIN_P_EMPRESA
                 ORDER BY T.FECHA DESC, T.KM_ACTUAL DESC) LOOP
      
        POUT_S_DOCU_FEC_CONS_ANTERIOR := V.FECHA;
        POUT_S_DOCU_TRA_KM_ANTERIOR   := V.KM_ACTUAL;
        POUT_S_DOCU_TRA_HORA_ANTERIOR := V.HORA_ACTUAL;
        POUT_S_LITROS_PREVIOS         := V.CANTIDAD;
        EXIT;
      END LOOP;
    
      --=================
    
      IF NVL(PIN_P_CONF_IND_CON_KMGPS, 'N') = 'S' THEN
        BEGIN
          SELECT MAX(TO_CHAR(FECHA, 'YYYY-MM-DD') || '%20' ||
                     TO_CHAR(FECHA, 'HH24:MI:SS'))
            INTO V_FECHA
            FROM (SELECT MAX(A.DOCU_FEC_GPS) FECHA
                    FROM STK_DOCUMENTO A
                   WHERE A.DOCU_EMPR = PIN_P_EMPRESA
                     AND DOCU_TRA_CAMION = PIN_DOCU_TRA_CAMION
                  UNION
                  SELECT MAX(B.TCKM_FECHA) FECHA
                    FROM TRA_CAMION_COMB_KM_TMP B
                   WHERE B.TCKM_CAMION = PIN_DOCU_TRA_CAMION
                     AND B.TCKM_UTILIZADO = 'N'
                     AND B.TCKM_EMPR = PIN_P_EMPRESA
                  UNION
                  SELECT MAX(DCON_TRA_FEC_GPS)
                    FROM FIN_DOCUMENTO_TMP, FIN_DOC_CONCEPTO_TMP
                   WHERE DOC_TIPO_MOV IN (1, 2)
                     AND DOC_TMP_ESTADO NOT IN ('T', 'A')
                     AND DOC_EMPR = DCON_EMPR
                     AND DOC_CLAVE = DCON_CLAVE_DOC
                     AND DCON_TRA_CAMION = PIN_DOCU_TRA_CAMION
                     AND DOC_EMPR = PIN_P_EMPRESA
                  UNION
                  SELECT MAX(DCON_TRA_FEC_GPS)
                    FROM FIN_DOCUMENTO, FIN_DOC_CONCEPTO
                   WHERE DOC_TIPO_MOV IN (1, 2)
                     AND DOC_EMPR = DCON_EMPR
                     AND DOC_CLAVE = DCON_CLAVE_DOC
                     AND DCON_TRA_CAMION = PIN_DOCU_TRA_CAMION
                     AND DOC_EMPR = PIN_P_EMPRESA);
        
          IF V_FECHA = '%20' THEN
            V_FECHA := NULL;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_FECHA := NULL;
        END;
        POUT_S_FEC_GPS := V_FECHA;
        IF POUT_S_CLAVE_GPS IS NOT NULL AND V_FECHA IS NOT NULL THEN
          IF PIN_P_CONS_GPS = 'S' THEN
            POUT_S_KM_GPS := FP_CONSULTA_KM_GPS(POUT_S_CLAVE_GPS,
                                                V_FECHA,
                                                TO_CHAR(TRUNC(SYSDATE) + 1,
                                                        'YYYY-MM-DD'));
          ELSE
            POUT_S_KM_GPS := 0;
          END IF;
        ELSE
          POUT_S_KM_GPS := 0;
        END IF;
      
      END IF;
    END;
    ---------------------------------
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      POUT_S_DESC_CAMION     := NULL;
      POUT_S_DOCU_TRA_CAMION := NULL;
      RAISE_APPLICATION_ERROR(-20201, 'Camion inexistente!');
    
  END PP_MOSTRAR_DESC_CAMION1;

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
                                'No existe periodo actual o registro de configuracii??n en sistema');
    END;
  
    --*
    BEGIN
    
      SELECT PERI_FEC_FIN
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
                                'No existe periodo actual o registro de configuracii??n en sistema');
    END;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Problema PP_GET_FEC_SIST_FIN' || SQLCODE || '-' ||
                              SQLERRM);
    
  END PP_GET_FEC_SIST_FIN;

  PROCEDURE PP_CARGAR_DATOS(PIN_P_DESC_EMPRESA        IN VARCHAR2,
                            PIN_P_DESC_SUCURSAL       IN VARCHAR2,
                            PIN_S_DESC_PROGRAMA       IN VARCHAR2,
                            PIN_S_PROGRAMA            IN VARCHAR2,
                            PIN_P_EMPRESA             IN VARCHAR2,
                            PIN_P_SUCURSAL            IN NUMBER,
                            POUT_W_FLAG_COMMIT        OUT VARCHAR2,
                            POUT_S_USUARIO            OUT VARCHAR2,
                            POUT_S_FECHA              OUT VARCHAR2,
                            POUT_S_DOCU_FEC_EMIS      OUT VARCHAR2,
                            POUT_S_DESC_EMPRESA       OUT VARCHAR2,
                            POUT_S_DESC_SUCURSAL      OUT VARCHAR2,
                            POUT_S_DESC_PROGRAMA      OUT VARCHAR2,
                            POUT_S_PROGRAMA           OUT VARCHAR2,
                            POUT_S_LOGIN              OUT VARCHAR2,
                            POUT_P_IND_FEC_CONS_INT   OUT VARCHAR2,
                            POUT_DOCU_SUC_ORIG        OUT NUMBER,
                            POUT_S_OPERADOR           OUT VARCHAR2,
                            POUT_P_TIPO_IMPRESORA     OUT VARCHAR2,
                            POUT_P_FEC_INIC_SISTEMA   OUT DATE,
                            POUT_P_FEC_FIN_SISTEMA    OUT DATE,
                            POUT_P_CONF_IND_CON_KMGPS OUT VARCHAR2,
                            POUT_P_CONS_GPS           OUT VARCHAR2,
                            POUT_S_DESC_SUC_ORIG      OUT VARCHAR2,
                            POUT_HAB_HS_GPS           OUT VARCHAR2,
                            POUT_P_OPER               OUT VARCHAR2) IS
  
  BEGIN
  
    POUT_W_FLAG_COMMIT := 'NO';
    POUT_S_USUARIO     := V('APP_USER');
    POUT_S_FECHA       := TO_CHAR(SYSDATE, 'DD-MM-YYYY');
  
    POUT_S_DOCU_FEC_EMIS := TO_CHAR(SYSDATE, 'DD-MM-YYYY');
  
    POUT_S_DESC_EMPRESA  := PIN_P_DESC_EMPRESA;
    POUT_S_DESC_SUCURSAL := PIN_P_DESC_SUCURSAL;
    POUT_S_DESC_PROGRAMA := PIN_S_DESC_PROGRAMA;
    POUT_S_PROGRAMA      := PIN_S_PROGRAMA;
  
    POUT_S_LOGIN := V('APP_USER');
  
    /* BEGIN
      -- CALL THE PROCEDURE
      STKI206.PP_VALIDAR_IMPRESORA;
    END;
    
    -- POUT_P_OPER  := 'TRANSP';
    /*
    IF :PARAMETER.P_OPER = 'TRANSP' THEN
      ACT_DEACT('S_DOCU_TRA_CAMION', 'A', 'N');
      ACT_DEACT('S_DESC_CAMION', 'A', 'S');
      ACT_DEACT('DOCU_TRA_CHOFER', 'A', 'N');
      ACT_DEACT('DOCU_TRA_CHOFER_NOMBRE', 'A', 'N');
      ACT_DEACT('DOCU_TRA_KM_ACTUAL', 'A', 'N');
      ACT_DEACT('DOCU_TRA_HORA_ACTUAL', 'A', 'N');
    ELSE
      ACT_DEACT('S_DOCU_TRA_CAMION', 'D', 'N');
      ACT_DEACT('S_DESC_CAMION', 'D', 'S');
      ACT_DEACT('DOCU_TRA_CHOFER', 'D', 'N');
      ACT_DEACT('DOCU_TRA_CHOFER_NOMBRE', 'D', 'N');
      ACT_DEACT('DOCU_TRA_KM_ACTUAL', 'D', 'N');
      ACT_DEACT('DOCU_TRA_HORA_ACTUAL', 'D', 'N');
    END IF;
      */
    BEGIN
      SELECT NVL(OPEM_IND_FEC_CONS_INT, 'N'),
             v('P_SUCURSAL'),--E.OPEM_SUC,
             OPER_CODIGO,
             NVL(OPEM_IMPRESORA, 'N'),
             NVL(OPEM_IND_MOD_HS_GPS, 'N')
        INTO POUT_P_IND_FEC_CONS_INT,
             POUT_DOCU_SUC_ORIG,
             POUT_S_OPERADOR,
             POUT_P_TIPO_IMPRESORA,
             POUT_HAB_HS_GPS
        FROM GEN_OPERADOR O, GEN_OPERADOR_EMPRESA E
       WHERE OPER_LOGIN = GEN_DEVUELVE_USER
         AND O.OPER_CODIGO = E.OPEM_OPER
         AND E.OPEM_EMPR = PIN_P_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20201, 'ERROR QUERY1');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20201, 'ERROR QUERY1');
    END;
  
    /*
      IF POUT_P_IND_FEC_CONS_INT = 'S' THEN
        SET_ITEM_PROPERTY('S_DOCU_FEC_EMIS', UPDATE_ALLOWED, PROPERTY_TRUE);
        SET_ITEM_PROPERTY('S_DOCU_FEC_EMIS', INSERT_ALLOWED, PROPERTY_TRUE);
      ELSIF POUT_P_IND_FEC_CONS_INT = 'N' THEN
        NULL;
        -- SET_ITEM_PROPERTY('S_DOCU_FEC_EMIS',UPDATE_ALLOWED,PROPERTY_FALSE);
        -- SET_ITEM_PROPERTY('S_DOCU_FEC_EMIS',INSERT_ALLOWED,PROPERTY_FALSE);
      END IF;
    */
    BEGIN
      SELECT I.PERI_FEC_INI,
             F.PERI_FEC_FIN,
             CONF_IND_CONSUMO_KMGPS,
             CONF_IND_CONSULTA_GPS
        INTO POUT_P_FEC_INIC_SISTEMA,
             POUT_P_FEC_FIN_SISTEMA,
             POUT_P_CONF_IND_CON_KMGPS,
             POUT_P_CONS_GPS
        FROM STK_CONFIGURACION O, STK_PERIODO I, STK_PERIODO F
       WHERE O.CONF_PERIODO_ACT = I.PERI_CODIGO
         AND O.CONF_EMPR = I.PERI_EMPR
         AND O.CONF_EMPR = PIN_P_EMPRESA
         AND O.CONF_PERIODO_SGTE = F.PERI_CODIGO
         AND O.CONF_EMPR = F.PERI_EMPR;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20201, 'ERROR QUERY2');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20201, 'ERROR QUERY2');
    END;
  
    -- POUT_DOCU_SUC_ORIG := PIN_P_SUCURSAL;
    PP_MOSTRAR_DESC_SUCU_ORIG(PIN_P_EMPRESA,
                              POUT_DOCU_SUC_ORIG,
                              POUT_S_DESC_SUC_ORIG);
    /*
    IF V_HAB_HS_GPS = 'S' THEN
        SET_ITEM_PROPERTY('S_HORA',UPDATE_ALLOWED,PROPERTY_TRUE);
        SET_ITEM_PROPERTY('S_HORA',ENABLED,PROPERTY_TRUE);
        SET_ITEM_PROPERTY('S_HORA',INSERT_ALLOWED,PROPERTY_TRUE);
        SET_ITEM_PROPERTY('S_MIN',UPDATE_ALLOWED,PROPERTY_TRUE);
        SET_ITEM_PROPERTY('S_MIN',INSERT_ALLOWED,PROPERTY_TRUE);
        SET_ITEM_PROPERTY('S_MIN',ENABLED,PROPERTY_TRUE);
    ELSE
        SET_ITEM_PROPERTY('S_MIN',UPDATE_ALLOWED,PROPERTY_FALSE);
        SET_ITEM_PROPERTY('S_MIN',ENABLED,PROPERTY_FALSE);
        SET_ITEM_PROPERTY('S_MIN',INSERT_ALLOWED,PROPERTY_FALSE);
        SET_ITEM_PROPERTY('S_HORA',UPDATE_ALLOWED,PROPERTY_FALSE);
        SET_ITEM_PROPERTY('S_HORA',ENABLED,PROPERTY_FALSE);
        SET_ITEM_PROPERTY('S_HORA',INSERT_ALLOWED,PROPERTY_FALSE);
    END IF;
      */
    /*
      IF PIN_P_SUCURSAL IN (3, 7) THEN
        DECLARE
          IMPRESORANOREGISTRADA EXCEPTION;
          PRAGMA EXCEPTION_INIT(IMPRESORANOREGISTRADA, -302000);
          V_ALERT          NUMBER;
          V_PATH_IMPRESORA VARCHAR2(50);
          V_IMPRESORA      PRINT_TMU.FILE_TYPE;
        BEGIN
          TOOL_ENV.GETVAR('IMP_CONSUMO', V_PATH_IMPRESORA); --OBTENER DIRECCION DE LA IMPRESORA
    
          IF V_PATH_IMPRESORA IS NULL THEN
            RAISE_APPLICATION_ERROR(-20010,'Debe ingresar en el registro de Windows un valor para IMP_CONSUMO');
          END IF;
        EXCEPTION
          WHEN IMPRESORANOREGISTRADA THEN
            SET_ALERT_PROPERTY('AL_MESSAGE',
                               ALERT_MESSAGE_TEXT,
                               'Falta registrar IMP_CONSUMO en el Register de Windows! B');
            V_ALERT := SHOW_ALERT('AL_MESSAGE');
        END;
      ELSE
        DECLARE
          IMPRESORANOREGISTRADA EXCEPTION;
          PRAGMA EXCEPTION_INIT(IMPRESORANOREGISTRADA, -302000);
          V_ALERT          NUMBER;
          V_PATH_IMPRESORA VARCHAR2(50);
          V_IMPRESORA      PRINT_TMU.FILE_TYPE;
        BEGIN
          TOOL_ENV.GETVAR('IMP_TICKET', V_PATH_IMPRESORA); --OBTENER DIRECCION DE LA IMPRESORA
    
          IF V_PATH_IMPRESORA IS NULL THEN
            RAISE_APPLICATION_ERROR(-20010,'Debe ingresar en el registro de Windows un valor para IMP TICKET');
          END IF;
        EXCEPTION
          WHEN IMPRESORANOREGISTRADA THEN
            SET_ALERT_PROPERTY('AL_MESSAGE',
                               ALERT_MESSAGE_TEXT,
                               'Falta registrar IMP_TICKET en el Register de Windows! B');
            V_ALERT := SHOW_ALERT('AL_MESSAGE');
        END;
      END IF;
    GO_ITEM('DOCU_SUC_ORIG');
    */
  END PP_CARGAR_DATOS;

  PROCEDURE PP_INICIAR_COLLECTION AS
  BEGIN
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'STKI206_DETALLE');
  END PP_INICIAR_COLLECTION;

  PROCEDURE PP_ADD_ITEM(I_EMPRESA       IN NUMBER,
                        I_SEQ           NUMBER,
                        I_ARTICULO_COD  IN NUMBER,
                        I_ARTICULO_DESC IN VARCHAR2,
                        I_CANT          IN NUMBER,
                        I_SERIE         IN VARCHAR2) AS
  BEGIN
  
    BEGIN
      -- CALL THE PROCEDURE
      STKI206.PP_EXHIBIR_DESC_ARTICULO(I_SEQ      => I_SEQ,
                                       I_EMPRESA  => I_EMPRESA,
                                       I_DETA_ART => I_ARTICULO_COD,
                                       I_CANT     => I_CANT,
                                       I_SERIE    => I_SERIE);
    END;
  
  END PP_ADD_ITEM;

  PROCEDURE PP_BORRAR_DET(I_SEQ IN NUMBER) AS
  BEGIN
    APEX_COLLECTION.DELETE_MEMBER(P_COLLECTION_NAME => 'STKI206_DETALLE',
                                  P_SEQ             => I_SEQ);
  
    APEX_COLLECTION.RESEQUENCE_COLLECTION(P_COLLECTION_NAME => 'STKI206_DETALLE');
  
  END PP_BORRAR_DET;

  /*PROCEDURE PP_EXHIBIR_DESC_ARTICULO(PIN_P_EMPRESA           IN VARCHAR2,
                                     PIN_DETA_ART            IN NUMBER,
                                     POUT_ART_CONTROL_KM     OUT VARCHAR2,
                                     POUT_ART_IND_COMBUS     OUT VARCHAR2,
                                     POUT_ART_IND_COMBUS_NUM OUT VARCHAR2,
                                     POUT_ART_DESC           OUT VARCHAR2,
                                     POUT_S_ORILINK          OUT NUMBER) IS
    V_EST   STK_ARTICULO.ART_EST%TYPE;
    V_MARCA NUMBER := 0;
  BEGIN
    SELECT ART_EST,
           /*ART_LINEA,
           ART_GRUPO,
           ART_CONTROL_KM,
           ART_IND_COMBUS,
           DECODE(ART_IND_COMBUS, 'S', 1, 0),
           ART_MARCA,
           ART_DESC,
           DECODE(NVL(ART_IND_ORILINK, 'N'), 'S', 1, 0)
      INTO V_EST,
           /*:ART_LINEA,
           :ART_GRUPO,
           POUT_ART_CONTROL_KM,
           POUT_ART_IND_COMBUS,
           POUT_ART_IND_COMBUS_NUM,
           V_MARCA,
           POUT_ART_DESC,
           POUT_S_ORILINK
      FROM STK_ARTICULO, STK_ARTICULO_EMPRESA
     WHERE ART_CODIGO = AREM_ART
       AND ART_EMPR = AREM_EMPR
       AND AREM_EMPR = PIN_P_EMPRESA
       AND ART_CODIGO = PIN_DETA_ART;
  
    IF V_EST = 'I' THEN
      POUT_ART_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20201, 'Arti??culo inactivo!.');
    END IF;
    IF V_MARCA = 1 THEN
      RAISE_APPLICATION_ERROR(-20201,
                              'No se puede realizar el ingreso de insumos por este programa!.');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      POUT_ART_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20201, 'Arti??culo inexistente!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20201, 'ERROR: ' || SQLERRM);
  
  END PP_EXHIBIR_DESC_ARTICULO;*/

  PROCEDURE PP_VALIDAR_ART(PIN_DETA_ART  IN NUMBER,
                           PIN_DESC_ART  IN VARCHAR2,
                           PIN_DETA_CANT IN NUMBER) IS
  BEGIN
    IF PIN_DETA_ART IS NULL THEN
      RAISE_APPLICATION_ERROR(-20201,
                              'El ci??digo de arti??culo no debe ser nulo!');
    END IF;
  
    IF PIN_DESC_ART IS NULL THEN
      RAISE_APPLICATION_ERROR(-20201, 'Arti??culo inactivo!');
    END IF;
  
    IF PIN_DETA_CANT IS NULL THEN
      RAISE_APPLICATION_ERROR(-20201,
                              'La cantidad del arti??culo no debe ser nula!');
    END IF;
  
    IF PIN_DETA_CANT < 1 THEN
      RAISE_APPLICATION_ERROR(-20201,
                              'La cantidad del arti??culo debe ser 1 o superior!');
    END IF;
  
  END PP_VALIDAR_ART;

  PROCEDURE PP_IMPRIMIR_DOC(I_EMPRESA IN NUMBER, I_DOCUT_CLAVE IN NUMBER) AS
    V_REPORT        VARCHAR2(10) := 'STKI206GR';
    V_PARAMETROS    VARCHAR2(600);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
  
  BEGIN
  
    V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
  
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    APEX_UTIL.URL_ENCODE(I_EMPRESA);
  
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                    APEX_UTIL.URL_ENCODE(I_DOCUT_CLAVE);
  
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
  
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, V_REPORT, 'pdf');
  
  END PP_IMPRIMIR_DOC;

  PROCEDURE PP_ESTABL_VARIABLES_BDOCU(PIN_P_SUCURSAL             IN VARCHAR2,
                                      PIN_P_EMPRESA              IN VARCHAR2,
                                      PIN_P_CONF_IND_CON_KMGPS   IN VARCHAR2,
                                      PIN_P_IND_EXCL_ADITIVO     IN VARCHAR2,
                                      PIN_S_KM_GPS               IN NUMBER,
                                      PIN_S_HORA                 IN VARCHAR2,
                                      PIN_P_SISTEMA              IN NUMBER,
                                      PIN_S_DOCU_TRA_CAMION      IN NUMBER,
                                      PIN_S_SUM_ORILINK          IN NUMBER,
                                      PIN_S_USUARIO              IN VARCHAR2,
                                      PIN_S_DOCU_TRA_KM_ANTERIOR IN NUMBER,
                                      PIN_S_KM_RECORRIDOS        IN NUMBER,
                                      PIN_P_PROGRAMA             IN NUMBER,
                                      PIN_DETA_CANT_COMBU_SUM    IN NUMBER,
                                      POUT_DOCU_NRO_DOC          OUT NUMBER,
                                      POUT_DOCU_KM_GPS           OUT VARCHAR2,
                                      POUT_DOCU_FEC_GPS          OUT DATE,
                                      POUT_DOCU_ESTADO_CONS      OUT VARCHAR2,
                                      POUT_DOCU_IND_ORILINK      OUT VARCHAR2,
                                      POUT_DOCU_EMPR             OUT NUMBER,
                                      POUT_DOCU_LOGIN            OUT VARCHAR2,
                                      POUT_DOCU_FEC_GRAB         OUT DATE,
                                      POUT_DOCU_KM_ANT           OUT NUMBER,
                                      POUT_DOCU_KM_RECORRIDO     OUT NUMBER,
                                      POUT_DOCU_LTS_COMBU        OUT VARCHAR2) IS
    V_NRO   NUMBER;
    V_FECHA VARCHAR2(50);
  BEGIN
  
    SELECT SUC_ULT_NRO_CONSUMO
      INTO V_NRO
      FROM GEN_SUCURSAL
     WHERE SUC_CODIGO = PIN_P_SUCURSAL
       AND SUC_EMPR = PIN_P_EMPRESA;
  
    IF V_NRO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20201,
                              'Error de numeracion, avise al departamento de informatica!');
    END IF;
  
    POUT_DOCU_NRO_DOC := V_NRO + 1;
  
    UPDATE GEN_SUCURSAL
       SET SUC_ULT_NRO_CONSUMO = POUT_DOCU_NRO_DOC
     WHERE SUC_CODIGO = PIN_P_SUCURSAL
       AND SUC_EMPR = PIN_P_EMPRESA;
  
    IF NVL(PIN_P_CONF_IND_CON_KMGPS, 'N') = 'S' AND
       NVL(PIN_P_IND_EXCL_ADITIVO, 'S') <> 'N' THEN
      POUT_DOCU_KM_GPS := TO_CHAR(PIN_S_KM_GPS);
      IF POUT_DOCU_FEC_GPS IS NULL OR PIN_S_HORA IS NULL THEN
        POUT_DOCU_FEC_GPS := SYSDATE;
      END IF;
    END IF;
  --   RAISE_APPLICATION_ERROR(-20201,POUT_DOCU_ESTADO_CONS||' - '||V('P8009_IND_CONSUMO_TRANS')||' - '||V('P8009_P_SUCURSAL')||' - '||PIN_S_DOCU_TRA_CAMION);
    
    IF V('P8009_IND_CONSUMO_TRANS') = 'S' AND V('P8009_P_SUCURSAL') = 7 AND
       PIN_S_DOCU_TRA_CAMION <= 999 THEN
    
      POUT_DOCU_ESTADO_CONS := 'P';
   --   RAISE_APPLICATION_ERROR(-20201,POUT_DOCU_ESTADO_CONS);
    END IF;
  
    IF PIN_S_SUM_ORILINK > 0 THEN
      POUT_DOCU_IND_ORILINK := 'S';
    END IF;
  
    POUT_DOCU_EMPR         := PIN_P_EMPRESA;
    POUT_DOCU_LOGIN        := PIN_S_USUARIO;
    POUT_DOCU_FEC_GRAB     := SYSDATE;
    POUT_DOCU_KM_ANT       := PIN_S_DOCU_TRA_KM_ANTERIOR;
    POUT_DOCU_KM_RECORRIDO := PIN_S_KM_RECORRIDOS;
    /*POUT_DOCU_SIST := SUBSTR(PIN_P_PROGRAMA,1,3);*/
    POUT_DOCU_LTS_COMBU := PIN_DETA_CANT_COMBU_SUM;
  
  END PP_ESTABL_VARIABLES_BDOCU;

  PROCEDURE PP_BAJA_ART_SERIE(PIN_S_DOCU_TAL_OT_TRAB IN VARCHAR2,
                              PIN_DOCU_CLAVE         IN NUMBER,
                              PIN_P_EMPRESA          IN VARCHAR2) IS
  BEGIN
    FOR C IN (SELECT N001 I_ARTICULO_COD,
                     C001 I_ARTICULO_DESC,
                     N002 I_CANT,
                     C001 I_SERIE
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'STKI206_DETALLE') LOOP
      IF C.I_SERIE IS NOT NULL AND PIN_S_DOCU_TAL_OT_TRAB = 'N' THEN
        UPDATE STK_ART_SERIE
           SET SER_SALIDA = PIN_DOCU_CLAVE
         WHERE SER_SERIE = C.I_SERIE
           AND SER_EMPR = PIN_P_EMPRESA;
      END IF;
    END LOOP;
  END PP_BAJA_ART_SERIE;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_P_SUCURSAL                   IN VARCHAR2,
                                   I_P_EMPRESA                    IN VARCHAR2,
                                   I_P_CONF_IND_CON_KMGPS         IN VARCHAR2,
                                   I_P_IND_EXCL_ADITIVO           IN VARCHAR2,
                                   I_S_KM_GPS                     IN NUMBER,
                                   I_S_HORA                       IN VARCHAR2,
                                   I_P_SISTEMA                    IN NUMBER,
                                   I_S_DOCU_TRA_CAMION            IN NUMBER,
                                   I_S_SUM_ORILINK                IN NUMBER,
                                   I_S_USUARIO                    IN VARCHAR2,
                                   I_S_DOCU_TRA_KM_ANTERIOR       IN NUMBER,
                                   I_S_KM_RECORRIDOS              IN NUMBER,
                                   I_P_PROGRAMA                   IN NUMBER,
                                   I_DETA_CANT_COMBU_SUM          IN NUMBER,
                                   O_DOCU_NRO_DOC                 OUT NUMBER,
                                   O_DOCU_KM_GPS                  OUT VARCHAR2,
                                   O_DOCU_FEC_GPS                 OUT DATE,
                                   O_DOCU_ESTADO_CONS             OUT VARCHAR2,
                                   O_DOCU_IND_ORILINK             OUT VARCHAR2,
                                   O_DOCU_EMPR                    OUT NUMBER,
                                   O_DOCU_LOGIN                   OUT VARCHAR2,
                                   O_DOCU_FEC_GRAB                OUT DATE,
                                   O_DOCU_KM_ANT                  OUT NUMBER,
                                   O_DOCU_KM_RECORRIDO            OUT NUMBER,
                                   I_DOCU_SIST                    IN VARCHAR2,
                                   O_DOCU_LTS_COMBU               OUT VARCHAR2,
                                   I_S_DOCU_TAL_OT_TRAB           IN VARCHAR2,
                                   I_DOCU_CLAVE                   IN NUMBER,
                                   O_W_FLAG_COMMIT                OUT VARCHAR2,
                                   O_DOCU_CLAVE                   OUT NUMBER,
                                   O_DETA_CLAVE_DOC               OUT NUMBER,
                                   I_DOCU_FEC_EMIS                IN DATE,
                                   I_DOCU_SUC_ORIG                IN NUMBER,
                                   I_DOCU_DEP_ORIG                IN NUMBER,
                                   I_DOCU_TRA_CARRETA             IN NUMBER,
                                   I_DOCU_TRA_CAMION              IN NUMBER,
                                   I_DOCU_TAL_OT                  IN NUMBER,
                                   I_DOCU_TRA_KM_ACTUAL           IN NUMBER,
                                   I_DOCU_TRA_HORA_ACTUAL         IN NUMBER,
                                   I_DOCU_TRA_CHOFER              IN NUMBER,
                                   I_DOCU_TRA_CHOFER_NOMBRE       IN VARCHAR2,
                                   I_DOCU_OBS                     IN VARCHAR2,
                                   I_DOCU_SUC_DEST                IN NUMBER,
                                   I_DOCU_DEP_DEST                IN NUMBER,
                                   I_DOCU_LEGAJO                  IN NUMBER,
                                   I_DOCU_MON                     IN NUMBER,
                                   I_DOCU_TIPO_MOV                IN NUMBER,
                                   I_DOCU_EXEN_NETO_MON           IN NUMBER,
                                   I_DOCU_GRAV_NETO_MON           IN NUMBER,
                                   I_DOCU_IVA_MON                 IN NUMBER,
                                   I_DOCU_EXEN_NETO_LOC           IN NUMBER,
                                   I_DOCU_GRAV_NETO_LOC           IN NUMBER,
                                   I_DOCU_IVA_LOC                 IN NUMBER,
                                   I_DOCU_CLI                     IN NUMBER,
                                   I_DOCU_PROV                    IN NUMBER,
                                   I_DOCU_GRAV_BRUTO_LOC          IN NUMBER,
                                   I_DOCU_GRAV_BRUTO_MON          IN NUMBER,
                                   I_DOCU_EXEN_BRUTO_LOC          IN NUMBER,
                                   I_DOCU_EXEN_BRUTO_MON          IN NUMBER,
                                   I_DOCU_IND_NO_FUNC_ODOMETRO    IN VARCHAR2,
                                   I_DOCU_IND_NO_FUNC_HORIMETRO   IN VARCHAR2,
                                   I_DOCU_IND_NO_FUNC_VELOCIMETRO IN VARCHAR2,
                                   I_DETA_OT_IND_CAR_CAM          IN VARCHAR2,
                                   I_DETA_NRO_REM                 IN NUMBER,
                                   I_DETA_IMP_NETO_LOC            IN NUMBER,
                                   I_DETA_IMP_NETO_MON            IN NUMBER,
                                   I_DETA_IMPU                    IN NUMBER,
                                   I_DETA_IVA_LOC                 IN NUMBER,
                                   I_DETA_IVA_MON                 IN NUMBER,
                                   I_DETA_PORC_DTO                IN NUMBER,
                                   I_DETA_IMP_BRUTO_LOC           IN NUMBER,
                                   I_DETA_IMP_BRUTO_MON           IN NUMBER,
                                   O_MOSTRAR_BTN                  OUT VARCHAR2,
                                   O_ESTADO                       OUT VARCHAR2) IS
    V_MENSAJE          VARCHAR2(1000);
    V_ESTADO           VARCHAR2(1);
    V_RESULTADO        VARCHAR2(1000);
    V_NRO_DOCUMENTO    NUMBER;
    V_IND_EXCL_ADITIVO VARCHAR2(1000);
    V_DETA_CANT_COMBU  VARCHAR2(1000);
    V_PATH_IMPRESORA   VARCHAR2(1000);
    V_IP               VARCHAR2(1000);
    V_CONTADOR         NUMBER;
    V_INDICADOR        VARCHAR2(1000);
    V_RENDIMIENTO      NUMBER;
    V_EXISTE           NUMBER := 0;
    V_NRO_DOCU         NUMBER := 0;
    V_SEQ_TAL_OT_NRO   NUMBER := 0;
    V_ESTADO_1         VARCHAR2(1);
    V_CONTADOR_ORI     NUMBER;
    l_tasa_us stk_documento.docu_tasa_us%type;
    /*
      Author  : @PabloACespedes \(^-^)/
      Modified : 09/06/2022 10:07:06
      se agrega la variable 
       * l_tasa_us >> donde se registra la tasa de venta en USD del dia
    */
    co_hoy    constant date := current_date;
    
    co_mnd_usd constant gen_moneda.mon_codigo%type := 2; -- USD
    
  BEGIN
  
    IF I_DOCU_TRA_CARRETA IS NULL AND I_DOCU_TRA_CAMION IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Favor seleccionar un cami?n o una carreta!');
    END IF;
  
    V_IP := OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR');
    /*  SELECT NVL(IMP_TICKET_TMU,'N')
      INTO V_PATH_IMPRESORA
      FROM GEN_IMPRESORA G
     WHERE G.IMPR_IP = v_ip--V('P0_IP_MAQUINA')
     AND G.IMP_EMPR = V('P_EMPRESA')
     AND IMP_TICKET_TMU = 'S';
    
    IF V_PATH_IMPRESORA IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010,'Falta configuracion de impresora, comunicarse con Informatica!!');
    END IF;*/
    BEGIN
      -- CALL THE PROCEDURE
      STKI206.PP_VALIDAR_DETALLES(O_P_IND_EXCL_ADITIVO => V_IND_EXCL_ADITIVO,
                                  O_DETA_CANT_COMBU    => V_DETA_CANT_COMBU);
    END;
  
    PP_ESTABL_VARIABLES_BDOCU(PIN_P_SUCURSAL             => I_P_SUCURSAL,
                              PIN_P_EMPRESA              => I_P_EMPRESA,
                              PIN_P_CONF_IND_CON_KMGPS   => I_P_CONF_IND_CON_KMGPS,
                              PIN_P_IND_EXCL_ADITIVO     => I_P_IND_EXCL_ADITIVO,
                              PIN_S_KM_GPS               => I_S_KM_GPS,
                              PIN_S_HORA                 => I_S_HORA,
                              PIN_P_SISTEMA              => I_P_SISTEMA,
                              PIN_S_DOCU_TRA_CAMION      => I_S_DOCU_TRA_CAMION,
                              PIN_S_SUM_ORILINK          => I_S_SUM_ORILINK,
                              PIN_S_USUARIO              => I_S_USUARIO,
                              PIN_S_DOCU_TRA_KM_ANTERIOR => I_S_DOCU_TRA_KM_ANTERIOR,
                              PIN_S_KM_RECORRIDOS        => I_S_KM_RECORRIDOS,
                              PIN_P_PROGRAMA             => I_P_PROGRAMA,
                              PIN_DETA_CANT_COMBU_SUM    => I_DETA_CANT_COMBU_SUM,
                              POUT_DOCU_NRO_DOC          => O_DOCU_NRO_DOC,
                              POUT_DOCU_KM_GPS           => O_DOCU_KM_GPS,
                              POUT_DOCU_FEC_GPS          => O_DOCU_FEC_GPS,
                              POUT_DOCU_ESTADO_CONS      => O_DOCU_ESTADO_CONS,
                              POUT_DOCU_IND_ORILINK      => O_DOCU_IND_ORILINK,
                              POUT_DOCU_EMPR             => O_DOCU_EMPR,
                              POUT_DOCU_LOGIN            => O_DOCU_LOGIN,
                              POUT_DOCU_FEC_GRAB         => O_DOCU_FEC_GRAB,
                              POUT_DOCU_KM_ANT           => O_DOCU_KM_ANT,
                              POUT_DOCU_KM_RECORRIDO     => O_DOCU_KM_RECORRIDO,
                              POUT_DOCU_LTS_COMBU        => O_DOCU_LTS_COMBU); /* ASIGNAR VALORES A ALGUNOS ITEMS*/
  
    /* ASIGNO SECUENCIA AL BLOQUE :BDOCU Y :BDETA */
  
    O_DOCU_CLAVE     := STK_SEQ_DOCU_NEXTVAL;
    O_DETA_CLAVE_DOC := O_DOCU_CLAVE;
  
    PP_BAJA_ART_SERIE(PIN_S_DOCU_TAL_OT_TRAB => I_S_DOCU_TAL_OT_TRAB,
                      PIN_DOCU_CLAVE         => I_DOCU_CLAVE,
                      PIN_P_EMPRESA          => I_P_EMPRESA);
    /* ASIGNAR 'SI' A W_FLAG_COMMIT PARA QUE NO EJECUTE LOS
    TRIGGERS POST_CHANGE */
    O_W_FLAG_COMMIT := 'SI';
  
   /* SELECT COUNT(1)
      INTO V_CONTADOR
      FROM APEX_COLLECTIONS, STK_ARTICULO V
     WHERE COLLECTION_NAME = 'STKI206_DETALLE'
       AND N001 = V.ART_CODIGO
       AND V.ART_EMPR = 2
       AND V.ART_LINEA_NEGOCIO = 7;*/
       
    SELECT COUNT(1)
      INTO V_CONTADOR
      FROM APEX_COLLECTIONS
      WHERE COLLECTION_NAME = 'STKI206_DETALLE'
      AND TO_NUMBER(C007) = 7 ;  
       
  
    IF V_CONTADOR > 0 AND O_DOCU_ESTADO_CONS = 'P' THEN
      V_INDICADOR := 'P';
    ELSE
      V_INDICADOR := NULL;
    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,V_INDICADOR);
    /*VERIFICAMOS SI EL DOCUMENTO YA EXISTE O NO EN LA BASE, SI YA EXISTE, HARA UN UPDATE, SI NO, UN INSERT */
    BEGIN
      SELECT COUNT(DOCU_CLAVE), d.docu_nro_doc
        INTO V_EXISTE, V_NRO_DOCU
        FROM STK_DOCUMENTO D
       WHERE D.DOCU_CLAVE = v('P8009_DOCU_CLAVE')
         AND D.DOCU_EMPR = I_P_EMPRESA
       GROUP BY d.docu_nro_doc;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_EXISTE := 0;
    END;
    --COMMIT_FORM;
    IF V_EXISTE = 0 THEN
      -- get tasa usd
      l_tasa_us := GEN_COTIZACION(P_EMPRESA   => I_P_EMPRESA,
               P_MONEDA    => co_mnd_usd,
               P_FECHA     => co_hoy,
               P_TIPO_TASA => 'V', --> Venta
               P_MAX_COT   => 'S'  --> Si
               ); 
               
      INSERT INTO STK_DOCUMENTO
        (DOCU_NRO_DOC,
         DOCU_FEC_EMIS,
         DOCU_SUC_ORIG,
         DOCU_DEP_ORIG,
         DOCU_TRA_CARRETA,
         DOCU_TRA_CAMION,
         DOCU_TAL_OT,
         DOCU_TRA_KM_ACTUAL,
         DOCU_TRA_HORA_ACTUAL,
         DOCU_TRA_CHOFER,
         DOCU_TRA_CHOFER_NOMBRE,
         DOCU_OBS,
         DOCU_SUC_DEST,
         DOCU_DEP_DEST,
         DOCU_LEGAJO,
         DOCU_MON,
         DOCU_TIPO_MOV,
         DOCU_EXEN_NETO_MON,
         DOCU_GRAV_NETO_MON,
         DOCU_IVA_MON,
         DOCU_EXEN_NETO_LOC,
         DOCU_GRAV_NETO_LOC,
         DOCU_IVA_LOC,
         DOCU_CLAVE,
         DOCU_EMPR,
         DOCU_CLI,
         DOCU_PROV,
         DOCU_GRAV_BRUTO_LOC,
         DOCU_GRAV_BRUTO_MON,
         DOCU_EXEN_BRUTO_LOC,
         DOCU_EXEN_BRUTO_MON,
         DOCU_LOGIN,
         DOCU_FEC_GRAB,
         DOCU_SIST,
         DOCU_IND_NO_FUNC_ODOMETRO,
         DOCU_IND_NO_FUNC_HORIMETRO,
         DOCU_IND_NO_FUNC_VELOCIMETRO,
         DOCU_KM_ANT,
         DOCU_KM_RECORRIDO,
         DOCU_LTS_COMBU,
         DOCU_KM_GPS,
         DOCU_FEC_GPS,
         DOCU_ESTADO_CONS,
         DOCU_IND_ORILINK,
         DOCU_CODIGO_OPER,
         docu_tasa_us)
      VALUES
        (O_DOCU_NRO_DOC,
         V('P8009_S_DOCU_FEC_EMIS'),
         I_DOCU_SUC_ORIG,
         I_DOCU_DEP_ORIG,
         I_DOCU_TRA_CARRETA,
         I_DOCU_TRA_CAMION,
         I_DOCU_TAL_OT,
         I_DOCU_TRA_KM_ACTUAL,
         I_DOCU_TRA_HORA_ACTUAL,
         I_DOCU_TRA_CHOFER,
         I_DOCU_TRA_CHOFER_NOMBRE,
         I_DOCU_OBS,
         I_DOCU_SUC_DEST,
         I_DOCU_DEP_DEST,
         I_DOCU_LEGAJO,
         NVL(I_DOCU_MON, 1),
         I_DOCU_TIPO_MOV,
         I_DOCU_EXEN_NETO_MON,
         I_DOCU_GRAV_NETO_MON,
         I_DOCU_IVA_MON,
         I_DOCU_EXEN_NETO_LOC,
         I_DOCU_GRAV_NETO_LOC,
         I_DOCU_IVA_LOC,
         O_DOCU_CLAVE,
         O_DOCU_EMPR,
         I_DOCU_CLI,
         I_DOCU_PROV,
         I_DOCU_GRAV_BRUTO_LOC,
         I_DOCU_GRAV_BRUTO_MON,
         I_DOCU_EXEN_BRUTO_LOC,
         I_DOCU_EXEN_BRUTO_MON,
         O_DOCU_LOGIN,
         O_DOCU_FEC_GRAB,
         'STK',
         I_DOCU_IND_NO_FUNC_ODOMETRO,
         I_DOCU_IND_NO_FUNC_HORIMETRO,
         I_DOCU_IND_NO_FUNC_VELOCIMETRO,
         O_DOCU_KM_ANT,
         O_DOCU_KM_RECORRIDO,
         O_DOCU_LTS_COMBU,
         O_DOCU_KM_GPS,
         O_DOCU_FEC_GPS,
         V_INDICADOR,
         O_DOCU_IND_ORILINK,
         10, -- consumo
         l_tasa_us);
    
      FOR C IN (SELECT SEQ_ID NRO_ITEM,
                       N001   DETA_ART,
                       C001   I_ARTICULO_DESC,
                       N002   DETA_CANT,
                       C002   DETA_SERIE
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'STKI206_DETALLE') LOOP
      
        INSERT INTO STK_DOCUMENTO_DET
          (DETA_NRO_ITEM,
           DETA_OT_IND_CAR_CAM,
           DETA_ART,
           DETA_CANT,
           DETA_NRO_REM,
           DETA_EMPR,
           DETA_IMP_NETO_LOC,
           DETA_IMP_NETO_MON,
           DETA_IMPU,
           DETA_IVA_LOC,
           DETA_IVA_MON,
           DETA_PORC_DTO,
           DETA_IMP_BRUTO_LOC,
           DETA_IMP_BRUTO_MON,
           DETA_CLAVE_DOC,
           DETA_SERIE)
        VALUES
          (C.NRO_ITEM,
           I_DETA_OT_IND_CAR_CAM,
           C.DETA_ART,
           C.DETA_CANT,
           I_DETA_NRO_REM,
           I_P_EMPRESA,
           I_DETA_IMP_NETO_LOC,
           I_DETA_IMP_NETO_MON,
           I_DETA_IMPU,
           I_DETA_IVA_LOC,
           I_DETA_IVA_MON,
           I_DETA_PORC_DTO,
           I_DETA_IMP_BRUTO_LOC,
           I_DETA_IMP_BRUTO_MON,
           O_DETA_CLAVE_DOC,
           C.DETA_SERIE);
      END LOOP;
    ELSE
      UPDATE STK_DOCUMENTO
         SET DOCU_FEC_EMIS                = to_date(V('P8009_S_DOCU_FEC_EMIS'),
                                                    'DD/MM/YYYY'),
             DOCU_SUC_ORIG                = I_DOCU_SUC_ORIG,
             DOCU_DEP_ORIG                = I_DOCU_DEP_ORIG,
             DOCU_TRA_CARRETA             = I_DOCU_TRA_CARRETA,
             DOCU_TRA_CAMION              = I_DOCU_TRA_CAMION,
             DOCU_TAL_OT                  = I_DOCU_TAL_OT,
             DOCU_TRA_KM_ACTUAL           = I_DOCU_TRA_KM_ACTUAL,
             DOCU_TRA_HORA_ACTUAL         = I_DOCU_TRA_HORA_ACTUAL,
             DOCU_TRA_CHOFER              = I_DOCU_TRA_CHOFER,
             DOCU_TRA_CHOFER_NOMBRE       = I_DOCU_TRA_CHOFER_NOMBRE,
             DOCU_OBS                     = I_DOCU_OBS,
             DOCU_SUC_DEST                = I_DOCU_SUC_DEST,
             DOCU_DEP_DEST                = I_DOCU_DEP_DEST,
             DOCU_LEGAJO                  = I_DOCU_LEGAJO,
             DOCU_MON                     = NVL(I_DOCU_MON, 1),
             DOCU_TIPO_MOV                = I_DOCU_TIPO_MOV,
             DOCU_EXEN_NETO_MON           = I_DOCU_EXEN_NETO_MON,
             DOCU_GRAV_NETO_MON           = I_DOCU_GRAV_NETO_MON,
             DOCU_IVA_MON                 = I_DOCU_IVA_MON,
             DOCU_EXEN_NETO_LOC           = I_DOCU_EXEN_NETO_LOC,
             DOCU_GRAV_NETO_LOC           = I_DOCU_GRAV_NETO_LOC,
             DOCU_IVA_LOC                 = I_DOCU_IVA_LOC,
             DOCU_GRAV_BRUTO_LOC          = I_DOCU_GRAV_BRUTO_LOC,
             DOCU_GRAV_BRUTO_MON          = I_DOCU_GRAV_BRUTO_MON,
             DOCU_EXEN_BRUTO_LOC          = I_DOCU_EXEN_BRUTO_LOC,
             DOCU_EXEN_BRUTO_MON          = I_DOCU_EXEN_BRUTO_MON,
             DOCU_LOGIN                   = gen_devuelve_user,
             DOCU_FEC_GRAB                = O_DOCU_FEC_GRAB,
             DOCU_SIST                    = 'STK',
             DOCU_IND_NO_FUNC_ODOMETRO    = I_DOCU_IND_NO_FUNC_ODOMETRO,
             DOCU_IND_NO_FUNC_HORIMETRO   = I_DOCU_IND_NO_FUNC_HORIMETRO,
             DOCU_IND_NO_FUNC_VELOCIMETRO = I_DOCU_IND_NO_FUNC_VELOCIMETRO,
             DOCU_KM_ANT                  = V('P8009_S_DOCU_TRA_KM_ANTERIOR'),
             DOCU_KM_RECORRIDO            = V('P8009_S_KM_RECORRIDOS'),
             DOCU_LTS_COMBU               = V('P8009_S_LITROS_PREVIOS'),
             DOCU_KM_GPS                  = V('P8009_S_KM_GPS'),
             DOCU_FEC_GPS                 = O_DOCU_FEC_GPS,
             DOCU_ESTADO_CONS             = V_INDICADOR,
             DOCU_IND_ORILINK             = O_DOCU_IND_ORILINK,
             DOCU_CODIGO_OPER             = 10
       WHERE DOCU_CLAVE = V('P8009_DOCU_CLAVE')
         AND DOCU_EMPR = I_P_EMPRESA;
    
      delete stk_documento_det
       where deta_clave_doc = V('P8009_DOCU_CLAVE')
         and deta_empr = I_P_EMPRESA;
    
      FOR x IN (SELECT SEQ_ID NRO_ITEM,
                       N001   DETA_ART,
                       C001   I_ARTICULO_DESC,
                       N002   DETA_CANT,
                       C002   DETA_SERIE
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'STKI206_DETALLE') LOOP
      
        INSERT INTO STK_DOCUMENTO_DET
          (DETA_NRO_ITEM,
           DETA_OT_IND_CAR_CAM,
           DETA_ART,
           DETA_CANT,
           DETA_NRO_REM,
           DETA_EMPR,
           DETA_IMP_NETO_LOC,
           DETA_IMP_NETO_MON,
           DETA_IMPU,
           DETA_IVA_LOC,
           DETA_IVA_MON,
           DETA_PORC_DTO,
           DETA_IMP_BRUTO_LOC,
           DETA_IMP_BRUTO_MON,
           DETA_CLAVE_DOC,
           DETA_SERIE)
        VALUES
          (x.NRO_ITEM,
           I_DETA_OT_IND_CAR_CAM,
           x.DETA_ART,
           x.DETA_CANT,
           I_DETA_NRO_REM,
           I_P_EMPRESA,
           I_DETA_IMP_NETO_LOC,
           I_DETA_IMP_NETO_MON,
           I_DETA_IMPU,
           I_DETA_IVA_LOC,
           I_DETA_IVA_MON,
           I_DETA_PORC_DTO,
           I_DETA_IMP_BRUTO_LOC,
           I_DETA_IMP_BRUTO_MON,
           V('P8009_DOCU_CLAVE'),
           x.DETA_SERIE);
      END LOOP;
    
    END IF;
    
    
      SELECT SUM(DECODE(NVL(ART_IND_ORILINK, 'N'), 'S', 1, 0))
      INTO V_CONTADOR_ORI
      FROM APEX_COLLECTIONS, STK_ARTICULO V
     WHERE COLLECTION_NAME = 'STKI206_DETALLE'
       AND N001 = V.ART_CODIGO
       AND V.ART_EMPR = V('P_EMPRESA');
    
    
    IF V_CONTADOR_ORI > 0 THEN
      
    SELECT SEQ_TAL_OT_NRO.NEXTVAL INTO V_SEQ_TAL_OT_NRO FROM DUAL;

      V_RESULTADO := TAL_CREAR_ORDEN_ACCESS(V_SEQ_TAL_OT_NRO);
    END IF;
  
    IF V('P8009_IND_CONSUMO_TRANS') = 'S' AND V('P_SUCURSAL') = 7 AND
       I_S_DOCU_TRA_CAMION <= 999 THEN
      BEGIN
        SELECT NVL(O.DOCU_ESTADO_CONS, 'P'),O.DOCU_ESTADO_CONS
          INTO V_ESTADO, V_ESTADO_1
          FROM STK_DOCUMENTO O
         WHERE O.DOCU_CLAVE = I_DOCU_CLAVE
           AND DOCU_EMPR = V('P_EMPRESA');
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;
      O_MOSTRAR_BTN := 'N';
      O_ESTADO      := V_ESTADO;
    END IF;
    IF V_EXISTE = 0 AND V_CONTADOR = 0 THEN
      V_MENSAJE := 'Guardado correctamente numero :' || O_DOCU_NRO_DOC || ' OT ORILINK: '||V_SEQ_TAL_OT_NRO||
                   '</br>' ||
                   '<a href="javascript:$s(''P8009_IMPRIMIR_CONSUMO'',' ||
                   O_DETA_CLAVE_DOC || ');">Imprimir Consumo</a></br>';
      --IF V('P_SUCURSAL') IN (3, 7) THEN
     
      V_MENSAJE := V_MENSAJE ||
                   '<a href="javascript:$s(''P8009_IMPRIMIR_CONSUMO_TMU'',' ||
                   O_DETA_CLAVE_DOC || ');">Imprimir Consumo TMU</a></br>';
      --ELSE
    
    ELSIF V_EXISTE <> 0  AND V_CONTADOR = 0 THEN
      V_MENSAJE := 'Guardado correctamente numero :' || V_NRO_DOCU ||
                   '</br>' ||
                   '<a href="javascript:$s(''P8009_IMPRIMIR_CONSUMO'',' ||
                   V('P8009_DOCU_CLAVE') || ');">Imprimir Consumo</a></br>';
      --IF V('P_SUCURSAL') IN (3, 7) THEN
      V_MENSAJE := V_MENSAJE ||
                   '<a href="javascript:$s(''P8009_IMPRIMIR_CONSUMO_TMU'',' ||
                   V('P8009_DOCU_CLAVE') ||
                   ');">Imprimir Consumo TMU</a></br>';
     -- END IF;             
    ELSE
         V_MENSAJE := 'Guardado correctamente numero :' || O_DOCU_NRO_DOC || ' OT ORILINK: '||V_SEQ_TAL_OT_NRO||
                   '</br>';            
                   
    END IF;
    APEX_APPLICATION.G_PRINT_SUCCESS_MESSAGE := V_MENSAJE;
  
  END PP_ACTUALIZAR_REGISTRO;

  PROCEDURE PP_IMPRIMIR_CONSUMO(I_CLAVE                    IN NUMBER,
                                I_S_DOCU_TRA_KM_ANTERIOR   NUMBER,
                                I_S_KM_RECORRIDOS          NUMBER,
                                I_S_RENDIMIENTO            NUMBER,
                                I_S_DOCU_TRA_HORA_ANTERIOR NUMBER,
                                I_DOCU_TRA_HORA_ACTUAL     NUMBER,
                                I_S_TIEMPO                 NUMBER,
                                I_S_RENDIMIENTO_HORA       NUMBER) IS
    CURSOR C IS
    
      SELECT E.EMPR_RAZON_SOCIAL, --OK
             D.DOCU_NRO_DOC, --OK
             D.DOCU_FEC_GRAB, --OK
             C.CAM_MARCA, --OK
             C.CAM_PROPIO_COD,
             C.CAM_CHAPA, --OK
             D.DOCU_TRA_CHOFER_NOMBRE,
             C.CAM_CONTROL_CONSUMO,
             C.CAM_CONTROL_KM,
             C.CAM_CONTROL_HORA,
             D.DOCU_TRA_KM_ACTUAL,
             D.DOCU_TRA_HORA_ACTUAL, --OK
             S.SUC_DESC, --OK,
             D.DOCU_OBS
        FROM STK_DOCUMENTO D, GEN_EMPRESA E, TRA_CAMION C, GEN_SUCURSAL S
       WHERE D.DOCU_EMPR = V('P_EMPRESA')
            
         AND D.DOCU_CLAVE = I_CLAVE
         AND D.DOCU_EMPR = EMPR_CODIGO
         AND D.DOCU_TRA_CAMION = C.CAM_CODIGO
         AND D.DOCU_EMPR = C.CAM_EMPR
            
         AND D.DOCU_SUC_ORIG = S.SUC_CODIGO
         AND D.DOCU_EMPR = S.SUC_EMPR;
  
    CURSOR D IS
      SELECT STK_ARTICULO.ART_DESC, STK_DOCUMENTO_DET.DETA_CANT
        FROM STK_DOCUMENTO_DET, STK_ARTICULO
       WHERE STK_ARTICULO.ART_EMPR = V('P_EMPRESA')
            
         AND STK_ARTICULO.ART_CODIGO = STK_DOCUMENTO_DET.DETA_ART
         AND STK_ARTICULO.ART_EMPR = STK_DOCUMENTO_DET.DETA_EMPR
            
         AND STK_DOCUMENTO_DET.DETA_CLAVE_DOC = I_CLAVE
      
       ORDER BY STK_DOCUMENTO_DET.DETA_NRO_ITEM;
  
    V_ALERT       NUMBER;
    V_LONG_PAGINA NUMBER := 31;
    V_CANT_LINEA  NUMBER := 0;
    V_NOMBRE      VARCHAR2(50);
    I             INTEGER;
    J             INTEGER;
    -- VARIABLES
    V_NUM_TXT   VARCHAR2(200) := ' ';
    V_NUM_TXT_1 VARCHAR2(70) := ' ';
    V_NUM_TXT_2 VARCHAR2(85) := ' ';
    V_NUM_TXT_3 VARCHAR2(85) := ' ';
  
    V_FORMATO   VARCHAR2(20);
    V_FORMATO2  VARCHAR2(20);
    V_PRECIO    NUMBER;
    V_NETO      NUMBER;
    V_PUNTAJE   NUMBER;
    V_PORC_DCTO NUMBER;
    V_DESCUENTO NUMBER;
    V_IND_SUM   VARCHAR2(50);
    V_MENSAJE   VARCHAR2(200) := ' ';
  
    -- OBVIAMOS ESTAS VARIABLES YA QUE SE ENVIARAN COMO PARAMETROS
    --V_IMPRESORA PRINT_TMU.FILE_TYPE;
    V_IMPRESORA CLOB;
    --V_PATH_IMPRESORA VARCHAR2(50) := NULL;
  
    IMPRESORANOREGISTRADA EXCEPTION;
    PRAGMA EXCEPTION_INIT(IMPRESORANOREGISTRADA, -302000);
  
    V_OPERACION VARCHAR2(20);
  
    FUNCTION CENTRAR(I_TEXTO VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
      RETURN LPAD(' ', (40 - LENGTH(I_TEXTO)) / 2, ' ') || I_TEXTO;
    END;
  
    FUNCTION FORMATEAR(CANT_DEC NUMBER, I_VALOR NUMBER) RETURN VARCHAR2 IS
      V_FORMATO VARCHAR2(40);
    BEGIN
      IF CANT_DEC = 0 THEN
        V_FORMATO := '999G999G999G999';
      ELSE
        V_FORMATO := '999G999G999D9';
      END IF;
      RETURN TO_CHAR(I_VALOR, V_FORMATO, 'NLS_NUMERIC_CHARACTERS = '',.''');
    END;
  
  BEGIN
  
    /*IF V('P_SUCURSAL IN') IN (3,7) THEN
      TOOL_ENV.GETVAR('IMP_CONSUMO', V_PATH_IMPRESORA); --OBTENER DIRECCION DE LA IMPRESORA
    ELSE
      TOOL_ENV.GETVAR('IMP_TICKET', V_PATH_IMPRESORA); --OBTENER DIRECCION DE LA IMPRESORA
    END IF; */
  
    ---IF :PARAMETER.P_SUCURSAL IN (7) AND :PARAMETER.P_SISTEMA=1 THEN
  
    --V_IMPRESORA := PRINT_TMU.FOPEN(V_PATH_IMPRESORA, 'W'); --ABRIR PUERTO DE IMPRESORA
  
    -- SE ENVIA DOS VECES LA MISMA INSTRUCCION, PORQUE SI SE ENCIENDE
    -- LA IMPRESORA DESPUES DE INICIADO WINDOWS , ENTONCES LA PRIMERA
    -- INSTRUCCION NO SE EJECUTA.
  
    --  PRINT_TMU.NEW_LINE(V_IMPRESORA,2);
    FOR V IN C LOOP
    
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR(V.EMPR_RAZON_SOCIAL));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR(V.SUC_DESC));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR('CONSUMO INTERNO'));
      --
      PRINT_TMU.NEW_LINE(V_IMPRESORA, 2);
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         LPAD(' ', 2, ' ') || 'Nro :' || LPAD(' ', 14, ' ') ||
                         V.DOCU_NRO_DOC);
    
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         LPAD(' ', 2, ' ') || 'Fecha :' ||
                         LPAD(' ', 12, ' ') ||
                         TO_CHAR(V.DOCU_FEC_GRAB, 'DD/MM/YYYY HH24:MI'));
    
      IF LENGTH(V.CAM_CHAPA) < 5 THEN
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'Movil :' ||
                           LPAD(' ', 12, ' ') || V.CAM_PROPIO_COD || ' - ' ||
                           V.CAM_MARCA);
      ELSE
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'Movil :' ||
                           LPAD(' ', 12, ' ') || V.CAM_PROPIO_COD || ' - ' ||
                           V.CAM_CHAPA);
      END IF;
    
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         LPAD(' ', 2, ' ') || 'Chapa :' ||
                         LPAD(' ', 12, ' ') || V.CAM_CHAPA);
    
      IF V.DOCU_OBS IS NOT NULL THEN
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'Obs:' || V.DOCU_OBS);
      END IF;
    
      PRINT_TMU.PUT(V_IMPRESORA, 'Oi' || 'E');
    
      IF NVL(V.CAM_CONTROL_KM, 'N') = 'S' THEN
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'KM ANTERIOR: ' ||
                           LPAD(' ', 6, ' ') ||
                           FORMATEAR(2, I_S_DOCU_TRA_KM_ANTERIOR));
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'KM ACTUAL: ' ||
                           LPAD(' ', 8, ' ') ||
                           FORMATEAR(0, V.DOCU_TRA_KM_ACTUAL));
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'KM RECORRIDO: ' ||
                           LPAD(' ', 5, ' ') ||
                           FORMATEAR(2, I_S_KM_RECORRIDOS));
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'RENDIMIENTO KM: ' ||
                           LPAD(' ', 3, ' ') ||
                           FORMATEAR(2, I_S_RENDIMIENTO));
      END IF;
    
      IF NVL(V.CAM_CONTROL_HORA, 'N') = 'S' THEN
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'HORA ANTERIOR: ' ||
                           LPAD(' ', 4, ' ') ||
                           FORMATEAR(0, I_S_DOCU_TRA_HORA_ANTERIOR));
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'HORA ACTUAL: ' ||
                           LPAD(' ', 6, ' ') ||
                           FORMATEAR(0, I_DOCU_TRA_HORA_ACTUAL));
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'HORAS TRABAJO: ' ||
                           LPAD(' ', 4, ' ') || FORMATEAR(2, I_S_TIEMPO));
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(' ', 2, ' ') || 'RENDIMIENTO HORAS: ' ||
                           FORMATEAR(2, I_S_RENDIMIENTO_HORA));
      END IF;
    
      PRINT_TMU.PUT(V_IMPRESORA, 'Oi' || 'F');
    
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, RPAD('Articulo', 40, ' '));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('Cantidad', 40, ' '));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
    
      FOR X IN D LOOP
        PRINT_TMU.PUT_LINE(V_IMPRESORA, X.ART_DESC);
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(FORMATEAR(1, X.DETA_CANT), 40, ' '));
      END LOOP;
    
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
    
      PRINT_TMU.NEW_LINE(V_IMPRESORA, 5);
    
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR(LPAD('-', 30, '-')));
    
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR(V.DOCU_TRA_CHOFER_NOMBRE));
    
      PRINT_TMU.NEW_LINE(V_IMPRESORA, 7);
      PRINT_TMU.PUT(V_IMPRESORA, 'Oi');
    
    END LOOP;
    --MESSAGE(TO_CHAR(V_CANT_LINEA));PAUSE;
    PRINT_TMU.FCLOSE(V_IMPRESORA); --CERRAR IMPRESORA
  EXCEPTION
    WHEN IMPRESORANOREGISTRADA THEN
      IF V('P_SUCURSAL') IN (3, 7) THEN
        V_MENSAJE := 'Falta registrar IMP_CONSUMO en el Register de Windows! ';
      ELSE
        V_MENSAJE := 'Falta registrar IMP_TICKET en el Register de Windows! ';
      END IF;
    
      APEX_APPLICATION.G_PRINT_SUCCESS_MESSAGE := V_MENSAJE;
  END;

  PROCEDURE PP_VALIDAR_DETALLES(O_P_IND_EXCL_ADITIVO OUT VARCHAR2,
                                O_DETA_CANT_COMBU    OUT VARCHAR2) IS
    V_IND_CONTROL_GRUPO VARCHAR2(1);
  BEGIN
  
    FOR K IN (SELECT SEQ_ID NRO_ITEM,
                     N001   ARTICULO,
                     C001   DESCRIPCION,
                     N002   CANTIDAD,
                     C002   SERIE,
                     N003   ART_LINEA,
                     N004   ART_GRUPO,
                     N005   MARCA,
                     C003   ART_CONTROL_KM,
                     C004   ART_IND_COMBUS,
                     C005   ART_IND_COMBUS_NUM,
                     C006   S_ORILINK
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'STKI206_DETALLE') LOOP
      --:BDETA.DETA_EMPR := VP_EMPRESA;
    
      SELECT NVL(GRUP_EXIGE_CONTROL, 'N')
        INTO V_IND_CONTROL_GRUPO
        FROM STK_ARTICULO, STK_GRUPO
       WHERE ART_EMPR = V('P_EMPRESA')
            
         AND ART_LINEA = GRUP_LINEA
         AND ART_EMPR = GRUP_EMPR
            
         AND ART_GRUPO = GRUP_CODIGO
            
         AND ART_CODIGO = K.ARTICULO;
    
      IF V_IND_CONTROL_GRUPO = 'S' THEN
      
        IF V('P8009_P_IND_KM') = 'S' THEN
          --  IF GET_ITEM_PROPERTY('DOCU_TRA_KM_ACTUAL',UPDATE_ALLOWED)='TRUE' THEN
          IF V('P8009_DOCU_TRA_KM_ACTUAL') IS NULL THEN
            --GO_ITEM('DOCU_TRA_KM_ACTUAL');
            RAISE_APPLICATION_ERROR(-20010,
                                    'El articulo ' || K.DESCRIPCION ||
                                    ' requiere que se indique el Km actual del movil');
          ELSE
            IF V('P8009_P_IND_FEC_CONS_INT') = 'N' THEN
              IF NVL(V('P8009_S_DOCU_TRA_KM_ANTERIOR'), 0) > 0 THEN
                IF NVL(V('P8009_DOCU_TRA_KM_ACTUAL'), 0) NOT BETWEEN
                   NVL(V('P8009_S_DOCU_TRA_KM_ANTERIOR'), 0) + 6 AND
                   V('P8009_S_DOCU_TRA_KM_ANTERIOR') + 2500 THEN
                  -- GO_ITEM('DOCU_TRA_KM_ACTUAL');
                  RAISE_APPLICATION_ERROR(-20010, 'KM no valido');
                END IF;
              END IF;
            END IF;
          END IF;
        
          --  ELSIF GET_ITEM_PROPERTY('DOCU_TRA_HORA_ACTUAL',UPDATE_ALLOWED)='TRUE' THEN
        ELSIF V('P8009_P_IND_HS') = 'S' THEN
          IF V('P8009_DOCU_TRA_HORA_ACTUAL') IS NULL THEN
            --GO_ITEM('DOCU_TRA_HORA_ACTUAL');
            RAISE_APPLICATION_ERROR(-20010,
                                    'El articulo ' || K.DESCRIPCION ||
                                    ' requiere que se indique la Hora actual del movil');
          ELSE
            IF V('P8009_P_IND_FEC_CONS_INT') = 'N' THEN
              IF NVL(V('P8009_S_DOCU_TRA_HORA_ANTERIOR'), 0) > 0 THEN
                IF NVL(V('P8009_DOCU_TRA_HORA_ACTUAL'), 0) NOT BETWEEN
                   NVL(V('P8009_S_DOCU_TRA_HORA_ANTERIOR'), 0) AND
                   V('P8009_S_DOCU_TRA_HORA_ANTERIOR') + 200 THEN
                  --GO_ITEM('DOCU_TRA_HORA_ACTUAL');
                  RAISE_APPLICATION_ERROR(-20010, 'HORA no valida');
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    
      IF K.ART_LINEA <> 27 AND K.ART_GRUPO <> 1 THEN
        O_P_IND_EXCL_ADITIVO := 'N';
      END IF;
    
      O_DETA_CANT_COMBU := 0;
    
      IF K.ART_IND_COMBUS = 'S' THEN
        O_DETA_CANT_COMBU := K.CANTIDAD;
      END IF;
    END LOOP;
  
  END;

  PROCEDURE PP_EXHIBIR_DESC_ARTICULO(I_SEQ      IN NUMBER,
                                     I_EMPRESA  IN NUMBER,
                                     I_DETA_ART IN NUMBER,
                                     I_CANT     IN NUMBER,
                                     I_SERIE    IN VARCHAR2) IS
    V_EST   STK_ARTICULO.ART_EST%TYPE;
    V_MARCA NUMBER := 0;
  
    V_ART_LINEA          NUMBER;
    V_ART_GRUPO          NUMBER;
    V_ART_CONTROL_KM     VARCHAR2(500);
    V_ART_IND_COMBUS     VARCHAR2(500);
    V_ART_IND_COMBUS_NUM VARCHAR2(500);
    V_ART_DESC           VARCHAR2(500);
    V_S_ORILINK          VARCHAR2(500);
    V_RENDIMIENTO        NUMBER := 0;
    V_CANT_COMBS         NUMBER := 0;
    V_LIN_NEGO           NUMBER;
  BEGIN
    SELECT ART_EST,
           ART_LINEA,
           ART_GRUPO,
           ART_CONTROL_KM,
           ART_IND_COMBUS,
           DECODE(ART_IND_COMBUS, 'S', 1, 0),
           ART_MARCA,
           ART_DESC,
           DECODE(NVL(ART_IND_ORILINK, 'N'), 'S', 1, 0),
           STK_ARTICULO.Art_Linea_Negocio
      INTO V_EST,
           V_ART_LINEA,
           V_ART_GRUPO,
           V_ART_CONTROL_KM,
           V_ART_IND_COMBUS,
           V_ART_IND_COMBUS_NUM,
           V_MARCA,
           V_ART_DESC,
           V_S_ORILINK,
           V_LIN_NEGO
      FROM STK_ARTICULO, STK_ARTICULO_EMPRESA
     WHERE ART_CODIGO = AREM_ART
       AND ART_EMPR = AREM_EMPR
          
       AND AREM_EMPR = I_EMPRESA
          
       AND ART_CODIGO = I_DETA_ART
       AND ART_EMPR = I_EMPRESA;
  
    IF V_ART_LINEA = 27 THEN
      BEGIN
        V_CANT_COMBS := NVL(V('P8009_DETA_CANT_COMBU_SUM'), 0) + I_CANT;
        -- RAISE_APPLICATION_ERROR(-20001,V_CANT_COMBS);
        SETITEM('P8009_DETA_CANT_COMBU_SUM', V_CANT_COMBS);
      
        V_RENDIMIENTO := STKI206.FP_RENDIMIENTO(I_KM_RECORRIDOS => V('P8009_S_KM_RECORRIDOS'),
                                                I_CANT_COMB     => V_CANT_COMBS);
      
        SETITEM('P8009_S_RENDIMIENTO', V_RENDIMIENTO);
      END;
    
    END IF;
  
    IF V_EST = 'I' THEN
      V_ART_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20010, 'Articulo inactivo!.');
    END IF;
    IF V_MARCA = 1 THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'No se puede realizar el ingreso de insumos por este programa!.');
    END IF;
  
    IF I_SEQ IS NULL THEN
    
      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'STKI206_DETALLE',
                                 P_N001            => I_DETA_ART,
                                 P_C001            => V_ART_DESC,
                                 P_N002            => I_CANT,
                                 P_C002            => I_SERIE,
                                 P_N003            => V_ART_LINEA,
                                 P_N004            => V_ART_GRUPO,
                                 P_N005            => V_MARCA,
                                 P_C003            => V_ART_CONTROL_KM,
                                 P_C004            => V_ART_IND_COMBUS,
                                 P_C005            => V_ART_IND_COMBUS_NUM,
                                 P_C006            => V_S_ORILINK,
                                 P_C007            => V_LIN_NEGO);
    END IF;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ART_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20010, 'Articulo inexistente!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, 'ERROR: ' || SQLERRM);
  END;

  PROCEDURE PP_VALIDAR_IMPRESORA IS
    V_MENSAJE VARCHAR2(32767);
    V_LINEA   VARCHAR2(100);
  
    IMPRESORANOREGISTRADA EXCEPTION;
    PRAGMA EXCEPTION_INIT(IMPRESORANOREGISTRADA, -302000);
    V_ALERT          NUMBER;
    V_PATH_IMPRESORA VARCHAR2(1);
    --V_IMPRESORA      PRINT_TMU.FILE_TYPE;
    V_IP VARCHAR2(30);
  BEGIN
    V_IP := OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR');
    -- raise_application_error(-20001,||v_ip);
    SELECT NVL(IMP_TICKET_TMU, 'N')
      INTO V_PATH_IMPRESORA
      FROM GEN_IMPRESORA G
     WHERE G.IMPR_IP = V_IP --V('P0_IP_MAQUINA')
       AND G.IMP_EMPR = V('P_EMPRESA')
       AND IMP_TICKET_TMU = 'S';
    IF V_PATH_IMPRESORA = 'N' THEN
      -- IMPRESORANOREGISTRADA;
      -- RAISE_APPLICATION_ERROR(-20010,'Debe ingresar en el registro de Windows un valor para IMP TICKET');
      V_MENSAJE := '<span style = "color: red;"> ' ||
                   'Falta registrar IMP_TICKET en el Register de Windows! B' ||
                   ' </span>';
      V_LINEA   := '<span style = "color: white;"> ' || RPAD('_', 50, '_') ||
                   ' </span>';
      --===============================================================================================================
      V_MENSAJE := V_MENSAJE || '<br>' || V_LINEA;
    
      --'<span style = "color: yellow;"> Imprimir Factura ! </span>' ;
    
      APEX_APPLICATION.G_PRINT_SUCCESS_MESSAGE := V_MENSAJE;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_MENSAJE := '<span style = "color: white;"> ' ||
                   'Falta registrar IMP_TICKET en el Register de Windows, comunicarsed con Informatica!' || V_IP ||
                   ' </span>';
      V_LINEA   := '<span style = "color: white;"> ' || RPAD('_', 35, '_') ||
                   ' </span>';
      --===============================================================================================================
      V_MENSAJE := V_MENSAJE || '<br>' || V_LINEA;
    
      --'<span style = "color: yellow;"> Imprimir Factura ! </span>' ;
    
      APEX_APPLICATION.G_PRINT_SUCCESS_MESSAGE := '<span style="color:RED">' ||
                                                  V_MENSAJE || '</span>';
      /*WHEN IMPRESORANOREGISTRADA THEN
      V_MENSAJE := '<span style = "color: white;"> ' || 'Falta registrar IMP_TICKET en el Register de Windows, comunicarse con Informatica!' || ' </span>'  ;
      V_LINEA    := '<span style = "color: white;"> ' || RPAD('_', 35, '_') || ' </span>'  ;
      --===============================================================================================================
      V_MENSAJE := V_MENSAJE || '<br>' ||
                   V_LINEA   ; */
    
      --'<span style = "color: yellow;"> Imprimir Factura ! </span>' ;
    
      APEX_APPLICATION.G_PRINT_SUCCESS_MESSAGE := '<span style="color:RED">' ||
                                                  V_MENSAJE || '</span>';
  END;

  PROCEDURE PP_RECUPERAR_REG(I_DOCU_CLAVE IN NUMBER,
                             I_EMPRESA    IN NUMBER,
                             O_DOCU       OUT STK_DOCUMENTO%ROWTYPE) IS
  BEGIN
  
    SELECT DOCU_NRO_DOC,
           DOCU_FEC_EMIS,
           DOCU_SUC_ORIG,
           DOCU_DEP_ORIG,
           DOCU_TRA_CARRETA,
           DOCU_TRA_CAMION,
           DOCU_TAL_OT,
           DOCU_TRA_KM_ACTUAL,
           DOCU_TRA_HORA_ACTUAL,
           DOCU_TRA_CHOFER,
           DOCU_TRA_CHOFER_NOMBRE,
           DOCU_OBS,
           DOCU_SUC_DEST,
           DOCU_DEP_DEST,
           DOCU_LEGAJO,
           DOCU_MON,
           DOCU_TIPO_MOV,
           DOCU_EXEN_NETO_MON,
           DOCU_GRAV_NETO_MON,
           DOCU_IVA_MON,
           DOCU_EXEN_NETO_LOC,
           DOCU_GRAV_NETO_LOC,
           DOCU_IVA_LOC,
           DOCU_CLAVE,
           DOCU_EMPR,
           DOCU_CLI,
           DOCU_PROV,
           DOCU_GRAV_BRUTO_LOC,
           DOCU_GRAV_BRUTO_MON,
           DOCU_EXEN_BRUTO_LOC,
           DOCU_EXEN_BRUTO_MON,
           DOCU_LOGIN,
           DOCU_FEC_GRAB,
           DOCU_SIST,
           DOCU_IND_NO_FUNC_ODOMETRO,
           DOCU_IND_NO_FUNC_HORIMETRO,
           DOCU_IND_NO_FUNC_VELOCIMETRO,
           DOCU_KM_ANT,
           DOCU_KM_RECORRIDO,
           DOCU_LTS_COMBU,
           DOCU_KM_GPS,
           DOCU_FEC_GPS,
           DOCU_ESTADO_CONS,
           DOCU_IND_ORILINK,
           DOCU_CODIGO_OPER,
           DOCU_ESTADO_CONS
      INTO O_DOCU.DOCU_NRO_DOC,
           O_DOCU.DOCU_FEC_EMIS,
           O_DOCU.DOCU_SUC_ORIG,
           O_DOCU.DOCU_DEP_ORIG,
           O_DOCU.DOCU_TRA_CARRETA,
           O_DOCU.DOCU_TRA_CAMION,
           O_DOCU.DOCU_TAL_OT,
           O_DOCU.DOCU_TRA_KM_ACTUAL,
           O_DOCU.DOCU_TRA_HORA_ACTUAL,
           O_DOCU.DOCU_TRA_CHOFER,
           O_DOCU.DOCU_TRA_CHOFER_NOMBRE,
           O_DOCU.DOCU_OBS,
           O_DOCU.DOCU_SUC_DEST,
           O_DOCU.DOCU_DEP_DEST,
           O_DOCU.DOCU_LEGAJO,
           O_DOCU.DOCU_MON,
           O_DOCU.DOCU_TIPO_MOV,
           O_DOCU.DOCU_EXEN_NETO_MON,
           O_DOCU.DOCU_GRAV_NETO_MON,
           O_DOCU.DOCU_IVA_MON,
           O_DOCU.DOCU_EXEN_NETO_LOC,
           O_DOCU.DOCU_GRAV_NETO_LOC,
           O_DOCU.DOCU_IVA_LOC,
           O_DOCU.DOCU_CLAVE,
           O_DOCU.DOCU_EMPR,
           O_DOCU.DOCU_CLI,
           O_DOCU.DOCU_PROV,
           O_DOCU.DOCU_GRAV_BRUTO_LOC,
           O_DOCU.DOCU_GRAV_BRUTO_MON,
           O_DOCU.DOCU_EXEN_BRUTO_LOC,
           O_DOCU.DOCU_EXEN_BRUTO_MON,
           O_DOCU.DOCU_LOGIN,
           O_DOCU.DOCU_FEC_GRAB,
           O_DOCU.DOCU_SIST,
           O_DOCU.DOCU_IND_NO_FUNC_ODOMETRO,
           O_DOCU.DOCU_IND_NO_FUNC_HORIMETRO,
           O_DOCU.DOCU_IND_NO_FUNC_VELOCIMETRO,
           O_DOCU.DOCU_KM_ANT,
           O_DOCU.DOCU_KM_RECORRIDO,
           O_DOCU.DOCU_LTS_COMBU,
           O_DOCU.DOCU_KM_GPS,
           O_DOCU.DOCU_FEC_GPS,
           O_DOCU.DOCU_ESTADO_CONS,
           O_DOCU.DOCU_IND_ORILINK,
           O_DOCU.DOCU_CODIGO_OPER,
           O_DOCU.DOCU_ESTADO_CONS
      FROM STK_DOCUMENTO T
    
     WHERE DOCU_CLAVE = I_DOCU_CLAVE
       AND DOCU_EMPR = I_EMPRESA;
    FOR DET IN (SELECT *
                  FROM STK_DOCUMENTO_DET D
                 WHERE D.DETA_CLAVE_DOC = I_DOCU_CLAVE
                   AND D.DETA_EMPR = I_EMPRESA) LOOP
      BEGIN
        -- CALL THE PROCEDURE
        STKI206.PP_EXHIBIR_DESC_ARTICULO(I_SEQ      => NULL,
                                         I_EMPRESA  => DET.DETA_EMPR,
                                         I_DETA_ART => DET.DETA_ART,
                                         I_CANT     => DET.DETA_CANT,
                                         I_SERIE    => DET.DETA_SERIE);
      END;
    
    END LOOP;
  END;

  FUNCTION FP_RENDIMIENTO(I_KM_RECORRIDOS IN NUMBER, I_CANT_COMB IN NUMBER)
    RETURN NUMBER AS
    V_DIVISOR NUMBER;
  BEGIN
    RETURN I_KM_RECORRIDOS / I_CANT_COMB;
  EXCEPTION
    WHEN ZERO_DIVIDE THEN
      RETURN 0;
    
  END FP_RENDIMIENTO;

END STKI206;
/
CREATE OR REPLACE PACKAGE STKI231 AS

  -- AUTHOR  : INTHEGRA
  -- CREATED : 04/08/2021 15:42:37

  PROCEDURE PP_INICIAR_COLLECTION;

  PROCEDURE PP_INICIAR_COLLECTION_SERIE;

  PROCEDURE PP_ADD_ITEM_SERIE(I_SEQ        NUMBER,
                              I_SER_ART    IN NUMBER,
                              I_SER_SERIE  IN VARCHAR2,
                              I_SER_FECHA  IN DATE,
                              I_SER_SUC    IN NUMBER,
                              I_SER_EMPR   IN NUMBER,
                              I_SER_DEP    IN NUMBER,
                              I_SER_ESTADO IN VARCHAR2);

  PROCEDURE PP_BORRAR_DET(I_SEQ IN NUMBER);

  PROCEDURE PP_ADD_ITEM(I_EMPRESA       IN NUMBER,
                        I_SEQ           NUMBER,
                        I_DETA_ART      IN NUMBER,
                        I_S_CONCEPTO    IN NUMBER,
                        I_DETA_CONCEPTO IN VARCHAR2,
                        I_DETA_CTACO    IN VARCHAR2,
                        I_DETA_CANT     IN NUMBER,
                        I_IMP_NETO_MON  IN NUMBER,
                        I_IMP_NETO_LOC  IN NUMBER,
                        I_DETA_LOTE     IN VARCHAR2,
                        I_LOTE_FEC_VENC IN DATE,
                        I_DETA_REG_ART  IN VARCHAR2,
                        I_DETA_OBS      IN VARCHAR2,
                        I_S_PRECIO      IN NUMBER);

  PROCEDURE PP_VAL_CAB(I_DESC_DEP IN NUMBER,
                       I_DESC_SUC IN NUMBER,
                       I_NRO_DOC  IN NUMBER,
                       I_FEC_EMI  IN DATE);

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_EMPRESA  IN NUMBER,
                                   I_SUCURSAL IN NUMBER,
                                   I_SUC_ORIG IN NUMBER,
                                   I_DEP_ORIG IN NUMBER,
                                   I_NRO_COMP IN NUMBER,
                                   I_FEC_EMIS IN DATE,
                                   I_OBSERV   IN VARCHAR2);

  PROCEDURE PP_ACTUALIZAR_NEUMATICOS(I_EMPRESA    IN NUMBER,
                                     I_DOCU_CLAVE IN NUMBER);
  PROCEDURE PP_IMPRIMIR_DOC(I_EMPRESA     IN NUMBER,
                            I_DOCUT_CLAVE IN NUMBER,
                            I_RENDIMIENTO IN VARCHAR2);


  PROCEDURE PP_IMPRIMIR_TMU(I_EMPRESA   IN NUMBER,
                           I_DOC_CLAVE IN NUMBER);


  FUNCTION VALIDAR_ART(I_EMPRESA NUMBER, I_ARTICULO NUMBER) RETURN BOOLEAN;

  PROCEDURE PP_VALIDAR_SI_EXISTE_DOCUMENTO(I_EMPRESA      IN NUMBER,
                                           I_DOCU_NRO_DOC IN NUMBER);

  FUNCTION FP_BUSCAR_COD_OP(I_DESC_OPER_IN IN VARCHAR2,
                            I_EMPRESA      IN NUMBER) RETURN NUMBER;

  FUNCTION PP_VALIDAR_LOTE(I_LIN_IND_CONTROL_LOTE IN VARCHAR2,
                           I_DETA_LOTE            IN VARCHAR2,
                           I_DETA_ART             IN NUMBER,
                           I_DOCU_SUC_ORIG        IN NUMBER,
                           I_DOCU_DEP_ORIG        IN NUMBER,
                           I_DETA_CANT            IN NUMBER) RETURN BOOLEAN;

  FUNCTION PP_GENERAR_NRO_SGTE(I_P_EMPRESA IN NUMBER) RETURN NUMBER;

END STKI231;
/
CREATE OR REPLACE PACKAGE BODY STKI231 AS

  PROCEDURE PP_INICIAR_COLLECTION AS
  BEGIN
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'STKI231_DETALLE');
  END PP_INICIAR_COLLECTION;

  PROCEDURE PP_INICIAR_COLLECTION_SERIE AS
  BEGIN
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'STKI231_SERIE');
  END PP_INICIAR_COLLECTION_SERIE;

  PROCEDURE PP_ADD_ITEM_SERIE(I_SEQ        NUMBER,
                              I_SER_ART    IN NUMBER,
                              I_SER_SERIE  IN VARCHAR2,
                              I_SER_FECHA  IN DATE,
                              I_SER_SUC    IN NUMBER,
                              I_SER_EMPR   IN NUMBER,
                              I_SER_DEP    IN NUMBER,
                              I_SER_ESTADO IN VARCHAR2) AS
  BEGIN
    IF I_SEQ IS NULL THEN

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'STKI231_SERIE',
                                 P_N001            => I_SER_ART,
                                 P_C001            => I_SER_SERIE,
                                 P_D001            => I_SER_FECHA,
                                 P_N002            => I_SER_SUC,
                                 P_N003            => I_SER_EMPR,
                                 P_N004            => I_SER_DEP,
                                 P_C002            => I_SER_ESTADO);
    END IF;
  END PP_ADD_ITEM_SERIE;

  PROCEDURE PP_BORRAR_DET(I_SEQ IN NUMBER) AS
  BEGIN
    APEX_COLLECTION.DELETE_MEMBER(P_COLLECTION_NAME => 'STKI231_DETALLE',
                                  P_SEQ             => I_SEQ);

    APEX_COLLECTION.RESEQUENCE_COLLECTION(P_COLLECTION_NAME => 'STKI231_DETALLE');

  END PP_BORRAR_DET;

  PROCEDURE PP_ADD_ITEM(I_EMPRESA       IN NUMBER,
                        I_SEQ           NUMBER,
                        I_DETA_ART      IN NUMBER,
                        I_S_CONCEPTO    IN NUMBER,
                        I_DETA_CONCEPTO IN VARCHAR2,
                        I_DETA_CTACO    IN VARCHAR2,
                        I_DETA_CANT     IN NUMBER,
                        I_IMP_NETO_MON  IN NUMBER,
                        I_IMP_NETO_LOC  IN NUMBER,
                        I_DETA_LOTE     IN VARCHAR2,
                        I_LOTE_FEC_VENC IN DATE,
                        I_DETA_REG_ART  IN VARCHAR2,
                        I_DETA_OBS      IN VARCHAR2,
                        I_S_PRECIO      IN NUMBER) AS
  BEGIN
    IF I_SEQ IS NULL THEN

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'STKI231_DETALLE',
                                 P_N001            => I_DETA_ART,
                                 P_C001            => I_S_CONCEPTO,
                                 P_C002            => I_DETA_CONCEPTO,
                                 P_C003            => I_DETA_CTACO,
                                 P_C004            => I_DETA_CANT,
                                 P_C005            => I_IMP_NETO_MON,
                                 P_C006            => I_IMP_NETO_LOC,
                                 P_C007            => I_DETA_LOTE,
                                 P_D001            => I_LOTE_FEC_VENC,
                                 P_C008            => I_DETA_REG_ART,
                                 P_C009            => I_DETA_OBS,
                                 P_C010            => I_S_PRECIO);
    END IF;

  END PP_ADD_ITEM;

  FUNCTION VALIDAR_ART(I_EMPRESA NUMBER, I_ARTICULO NUMBER) RETURN BOOLEAN AS
    COD_ART NUMBER;
  BEGIN

    SELECT ART_CODIGO
      INTO COD_ART
      FROM STK_ARTICULO, STK_ARTICULO_EMPRESA
     WHERE ART_CODIGO = AREM_ART
       AND ART_EMPR = AREM_EMPR
       AND AREM_EMPR = I_EMPRESA
       AND ART_EST = 'A'
       AND ART_TIPO <> 2
       AND STK_ARTICULO.ART_EMPR = STK_ARTICULO_EMPRESA.AREM_EMPR
       AND ART_CODIGO = I_ARTICULO
     ORDER BY 1;

    RETURN TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END;

  PROCEDURE PP_VAL_CAB(I_DESC_DEP IN NUMBER,
                       I_DESC_SUC IN NUMBER,
                       I_NRO_DOC  IN NUMBER,
                       I_FEC_EMI  IN DATE) AS
    V_CLAVE NUMBER;
  BEGIN

    IF I_DESC_DEP IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'El Deposito no puede ser nulo.');
    END IF;

    IF I_NRO_DOC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'El documento no puede ser nulo.');
    END IF;

    IF I_DESC_SUC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'La Sucursal no puede ser nula.');
    END IF;

    IF I_FEC_EMI IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'La fecha no puede ser nula.');
    END IF;

  END PP_VAL_CAB;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_EMPRESA  IN NUMBER,
                                   I_SUCURSAL IN NUMBER,
                                   I_SUC_ORIG IN NUMBER,
                                   I_DEP_ORIG IN NUMBER,
                                   I_NRO_COMP IN NUMBER,
                                   I_FEC_EMIS IN DATE,
                                   I_OBSERV   IN VARCHAR2) AS

    V_CLAVE_AUT_ESP_EXT NUMBER;
    V_CLAVE_AUT_ESP_DEP NUMBER;
    V_COD_OPER          NUMBER;
    V_DOCUT_CLAVE       NUMBER;
    V_MENSAJE           VARCHAR2(1000);
    V_NRO_DOCUMENTO     NUMBER;
    
    l_tasa_us stk_documento.docu_tasa_us%type;
    
    /*
      Author  : @PabloACespedes \(^-^)/
      Modified : 09/06/2022 10:07:06
      se agrega la variable 
       * l_tasa_us >> donde se registra la tasa de venta en USD del dia
    */
    co_hoy    constant date := current_date;
    
    co_mnd_usd constant gen_moneda.mon_codigo%type := 2; -- USD
  BEGIN

    /*SELECT MAX(NRO) + 1
    INTO V_NRO_DOCUMENTO
    FROM (SELECT DOCU_NRO_DOC NRO
            FROM STK_DOCUMENTO
           WHERE DOCU_TIPO_TRASLADO IS NULL
             AND DOCU_CODIGO_OPER IN (10)
             AND DOCU_SUC_ORIG = I_SUC_ORIG
             AND DOCU_EMPR = I_EMPRESA
          UNION ALL
          SELECT DOCUT_NRO_DOC NRO
            FROM STK_DOCUMENTO_TEMP
           WHERE DOCUT_EMPR = I_EMPRESA);*/

    /*  FACI039.PL_CONTROL_OPER_DEP(I_EMPRESA   => I_EMPRESA,
    I_SUCURSAL  => I_SUC_ORIG,
    I_DEPOSITO  => I_DEP_ORIG,
    I_OPERACION => 'EXT',
    P_USUARIO   => GEN_DEVUELVE_USER,
    I_CLAVE     => V_CLAVE_AUT_ESP_DEP);*/

    SELECT OPER_CODIGO
      INTO V_COD_OPER
      FROM STK_OPERACION
     WHERE OPER_DESC = 'CONSUMO'
       AND OPER_EMPR = I_EMPRESA;
       
       
    l_tasa_us := GEN_COTIZACION(P_EMPRESA   => I_EMPRESA,
               P_MONEDA    => co_mnd_usd,
               P_FECHA     => co_hoy,
               P_TIPO_TASA => 'V', --> Venta
               P_MAX_COT   => 'S'  --> Si
               ); 
     
    V_DOCUT_CLAVE := STK_SEQ_DOCU_NEXTVAL;

    --INSERTO EN STK_DOCUMENTO
    INSERT INTO STK_DOCUMENTO
      (DOCU_CLAVE,
       DOCU_EMPR,
       DOCU_CODIGO_OPER,
       DOCU_NRO_DOC,
       DOCU_SUC_ORIG,
       DOCU_DEP_ORIG,
       DOCU_MON,
       DOCU_FEC_EMIS,
       DOCU_LOGIN,
       DOCU_FEC_GRAB,
       DOCU_SIST,
       DOCU_OBS,
       docu_tasa_us
       )
    VALUES
      (V_DOCUT_CLAVE,
       I_EMPRESA,
       V_COD_OPER,
       I_NRO_COMP,
       I_SUC_ORIG,
       I_DEP_ORIG,
       1,
       NVL(TRUNC(I_FEC_EMIS), TRUNC(SYSDATE)),
       GEN_DEVUELVE_USER,
       co_hoy,
       'STK',
       I_OBSERV,
       l_tasa_us
       );

    --INSERTO EN STK_DOCUMENTO_DET

    FOR C IN (SELECT A.SEQ_ID NRO_ITEM,
                     A.N001   DETA_ART,
                     A.C001   DETA_S_CONCEPTO,
                     A.C002   DETA_CONCEPTO,
                     A.C003   DETA_CTACO,
                     A.C004   DETA_CANT,
                     A.C005   DETA_IMP_NETO_MON,
                     A.C006   DETA_IMP_NETO_LOC,
                     A.C007   DETA_LOTE,
                     A.D001   DETA_FEC_VEN,
                     A.C008   DETA_REG_ART,
                     A.C009   DETA_OBS,
                     A.C010   DETA_PRECIO
                FROM APEX_COLLECTIONS A
               WHERE A.COLLECTION_NAME = 'STKI231_DETALLE') LOOP

      INSERT INTO STK_DOCUMENTO_DET
        (DETA_CLAVE_DOC,
         DETA_NRO_ITEM,
         DETA_ART,
         DETA_CANT,
         DETA_EMPR,
         DETA_IMP_NETO_MON,
         DETA_IMP_NETO_LOC,
         DETA_LOTE_FEC_VEN,
         DETA_LOTE,
         DETA_CTACO,
         DETA_CONCEPTO,
         DETA_REG_ART,
         DETA_OBS)
      VALUES
        (V_DOCUT_CLAVE,
         C.NRO_ITEM,
         C.DETA_ART,
         C.DETA_CANT,
         I_EMPRESA,
         C.DETA_IMP_NETO_MON,
         C.DETA_IMP_NETO_LOC,
         C.DETA_FEC_VEN,
         C.DETA_LOTE,
         C.DETA_CTACO,
         C.DETA_CONCEPTO,
         C.DETA_REG_ART,
         C.DETA_OBS);
    END LOOP;

    PP_ACTUALIZAR_NEUMATICOS(I_EMPRESA, V_DOCUT_CLAVE);

    V_MENSAJE := 'Guardado correctamente numero : </br>' || V_NRO_DOCUMENTO ||
                 '</br>' ||
                 '<a href="javascript:$s(''P8002_CLAVE_IMPRIMIR'',' ||
                 V_DOCUT_CLAVE || ');">IMPRIMIR PDF</a> ' ||
                 '</br>'||
                 '<a href="javascript:$s(''P8002_IMPRIMIR_TMU'',' ||
                 V_DOCUT_CLAVE ||');">IMPRIMIR TMU</a>';

    APEX_APPLICATION.G_PRINT_SUCCESS_MESSAGE := V_MENSAJE;
  END PP_ACTUALIZAR_REGISTRO;

  PROCEDURE PP_ACTUALIZAR_NEUMATICOS(I_EMPRESA    IN NUMBER,
                                     I_DOCU_CLAVE IN NUMBER) IS
  BEGIN
    FOR I IN (SELECT N001 ARTICULO, C001 SER_SERIE
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'STKI231_SERIE') LOOP
      UPDATE STK_ART_SERIE
         SET SER_ESTADO = 'T', SER_SALIDA = I_DOCU_CLAVE
       WHERE SER_ART = I.ARTICULO
         AND SER_SERIE = I.SER_SERIE
         AND SER_EMPR = I_EMPRESA;
    END LOOP;
  END PP_ACTUALIZAR_NEUMATICOS;

  PROCEDURE PP_IMPRIMIR_DOC(I_EMPRESA     IN NUMBER,
                            I_DOCUT_CLAVE IN NUMBER,
                            I_RENDIMIENTO IN VARCHAR2) AS

    v_REPORT        varchar2(10) := 'STKI231';
    V_PARAMETROS    VARCHAR2(600);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS

  BEGIN

    V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    APEX_UTIL.URL_ENCODE(I_EMPRESA);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                    APEX_UTIL.URL_ENCODE(I_DOCUT_CLAVE);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_RENDIMIENTO=' ||
                    APEX_UTIL.URL_ENCODE(I_RENDIMIENTO);

    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;

    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, v_REPORT, 'pdf');

  END PP_IMPRIMIR_DOC;

   PROCEDURE PP_IMPRIMIR_TMU (I_EMPRESA IN NUMBER,
                            I_DOC_CLAVE IN NUMBER) IS

  CURSOR CONSUMO_INTERNO IS
  SELECT E.EMPR_RAZON_SOCIAL,
       E.EMPR_RUC,
       S.SUC_DESC,
       D.DOCU_NRO_DOC,
       D.DOCU_CLAVE,
       D.DOCU_FEC_GRAB,
       D.DOCU_TRA_CHOFER_NOMBRE,
       D.DOCU_TRA_KM_ACTUAL,
       D.DOCU_TRA_HORA_ACTUAL,
       D.DOCU_OBS,
       D.DOCU_KM_ANT,
       D.DOCU_KM_RECORRIDO,
       Null CAM_MARCA, --OK
       Null CAM_PROPIO_COD,
       Null CAM_CHAPA, --OK
       Null CAM_CONTROL_CONSUMO,
       Null CAM_CONTROL_KM,
       Null CAM_CONTROL_HORA
  FROM STK_DOCUMENTO D, GEN_EMPRESA E, GEN_SUCURSAL S
 WHERE D.DOCU_EMPR = EMPR_CODIGO
   AND D.DOCU_SUC_ORIG = S.SUC_CODIGO
   AND D.DOCU_EMPR = S.SUC_EMPR
   AND D.DOCU_CLAVE = I_DOC_CLAVE -- clave doc
   AND D.DOCU_EMPR = I_EMPRESA; -- empresa

  CURSOR DETALLES (COD_EMPR NUMBER, CLAVE_DOC NUMBER)IS
  SELECT ART_DESC, DETA_CANT, DETA_SERIE
  FROM STK_DOCUMENTO D, STK_DOCUMENTO_DET, STK_ARTICULO
 WHERE DOCU_CLAVE = DETA_CLAVE_DOC
   AND DOCU_EMPR = DETA_EMPR
   AND DETA_ART = ART_CODIGO
   AND DETA_EMPR = ART_EMPR
   AND D.DOCU_CLAVE = CLAVE_DOC --- clave doc
   AND D.DOCU_EMPR = COD_EMPR; -- empresa

  V_IMPRESORA CLOB;

  IMPRESORANOREGISTRADA EXCEPTION;
    PRAGMA EXCEPTION_INIT(IMPRESORANOREGISTRADA, -302000);
    --V_ALERT NUMBER;
    SALIR EXCEPTION;

  FUNCTION CENTRAR(I_TEXTO VARCHAR2) RETURN VARCHAR2 IS
           BEGIN
                RETURN LPAD(' ', (42 - LENGTH(I_TEXTO)) / 2, ' ') || I_TEXTO;
           END;


  BEGIN

  --raise_application_error(-20010, 'imprimir ticket '|| I_DOC_CLAVE);

  FOR C IN CONSUMO_INTERNO
      LOOP

      PRINT_TMU.PUT_LINE (V_IMPRESORA,CENTRAR(C.EMPR_RAZON_SOCIAL));
      PRINT_TMU.PUT_LINE (V_IMPRESORA,CENTRAR(C.SUC_DESC));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR('R.U.C.: '|| C.EMPR_RUC));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');

      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR('CONSUMO INTERNO'));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR('N? '||C.DOCU_NRO_DOC));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');

      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('FECHA: '|| to_char(C.DOCU_FEC_GRAB, 'DD/MM/YYYY HH24:MI:SS'),38,' ' )));
   /* PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('MOVIL: '|| C.CAM_MARCA,38,' ')));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('CHAPA: '|| C.CAM_CHAPA,38,' ')));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('KM ANTERIOR: '|| C.DOCU_KM_ANT,38,' ')));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('KM ACTUAL: '|| C.DOCU_TRA_KM_ACTUAL,38,' ')));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('KM RECORRIDO: '|| C.DOCU_KM_RECORRIDO,38,' ')));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('RENDIMIENTO: ',38,' ')));
   */

      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('OBS: '|| C.DOCU_OBS ,38,' ')));

      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(LPAD('-', 38, '-')));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD('ARTICULO', 22,' ') || RPAD('SERIE',10, ' ') || LPAD('CANT',6, ' ')));

      FOR D IN DETALLES ( I_EMPRESA, C.DOCU_CLAVE) LOOP

          PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(RPAD(D.ART_DESC,22,' ') || RPAD(NVL(D.DETA_SERIE,' '), 10, ' ') || LPAD(D.DETA_CANT, 6, ' ') ));

      END LOOP;
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');
      PRINT_TMU.PUT_LINE (V_IMPRESORA, CENTRAR(LPAD(C.DOCU_TRA_CHOFER_NOMBRE,38, ' ')));


      END LOOP;
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');
      PRINT_TMU.PUT_LINE (V_IMPRESORA,CENTRAR(LPAD('-',15,'-')));
      PRINT_TMU.PUT_LINE (V_IMPRESORA,CENTRAR('RESPONSABLE'));
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');
      PRINT_TMU.PUT_LINE (V_IMPRESORA,'  ACLARACION:');
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');
      PRINT_TMU.PUT_LINE (V_IMPRESORA, ' ');
      PRINT_TMU.FCLOSE(V_IMPRESORA);
      DBMS_OUTPUT.PUT_LINE(V_IMPRESORA);

      EXCEPTION
          WHEN SALIR THEN
               NULL;
          WHEN OTHERS THEN
               PRINT_TMU.FCLOSE(V_IMPRESORA);

  END PP_IMPRIMIR_TMU;


  PROCEDURE PP_VALIDAR_SI_EXISTE_DOCUMENTO(I_EMPRESA      IN NUMBER,
                                           I_DOCU_NRO_DOC IN NUMBER) AS
    primary_dummy VARCHAR2(1);
    cursor dummy_cur(CodigoOperacion NUMBER) is
      select 'x'
        from STK_DOCUMENTO
       where DOCU_EMPR = I_EMPRESA
         and DOCU_NRO_DOC = I_DOCU_NRO_DOC
         and DOCU_CODIGO_OPER = CodigoOperacion; -- Consumo interno.
    V_COD_OP NUMBER; -- Codigo de operacion
  BEGIN
    V_COD_OP := FP_BUSCAR_COD_OP('CONSUMO', I_EMPRESA);
    open dummy_cur(V_COD_OP);
    fetch dummy_cur
      into primary_dummy;
    if (dummy_cur%found) then
      close dummy_cur;
      RAISE_APPLICATION_ERROR(-20010, 'Documento existente!');
    end if;
    close dummy_cur;
  END;

  FUNCTION FP_BUSCAR_COD_OP(I_DESC_OPER_IN IN VARCHAR2,
                            I_EMPRESA      IN NUMBER) RETURN NUMBER IS
    V_OPER_CODIGO NUMBER := 0;

  BEGIN
    SELECT OPER_CODIGO
      INTO V_OPER_CODIGO
      FROM STK_OPERACION
     WHERE OPER_DESC = I_DESC_OPER_IN
       AND OPER_EMPR = I_EMPRESA;

    RETURN V_OPER_CODIGO;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'Tipo operacion inexistente!');
  END;

  FUNCTION PP_VALIDAR_LOTE(I_LIN_IND_CONTROL_LOTE IN VARCHAR2,
                           I_DETA_LOTE            IN VARCHAR2,
                           I_DETA_ART             IN NUMBER,
                           I_DOCU_SUC_ORIG        IN NUMBER,
                           I_DOCU_DEP_ORIG        IN NUMBER,
                           I_DETA_CANT            IN NUMBER) RETURN BOOLEAN AS
    SALIR EXCEPTION;
    V_CANT NUMBER;
  BEGIN

    IF nvl(I_LIN_IND_CONTROL_LOTE, 'N') = 'N' THEN
      RAISE SALIR;
    END IF;

   /* IF I_DETA_LOTE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Lote no puede ser nulo!');
      RETURN FALSE;
    END IF;*/

    SELECT CANTIDAD
      INTO V_CANT
      FROM STK_LOTES_V
     WHERE ART_CODIGO = I_DETA_ART
       AND SUC_CODIGO = I_DOCU_SUC_ORIG
       AND DEP_CODIGO = I_DOCU_DEP_ORIG
       AND DETA_LOTE = I_DETA_LOTE;

    IF I_DETA_CANT > V_CANT THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Cantidad maxima permitida ' || V_CANT);
      RETURN FALSE;
    END IF;
    RETURN TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'El lote no existe en este deposito');
      RETURN FALSE;
    WHEN SALIR THEN
      NULL;
      RETURN FALSE;
  END;

  FUNCTION PP_GENERAR_NRO_SGTE(I_P_EMPRESA IN NUMBER) RETURN NUMBER IS
    v_cod number := 0;
    vcont number := 1;
  BEGIN
    select max(docu_nro_doc)
      into vcont
      from stk_documento
     where docu_tipo_mov is null
       and docu_empr = I_P_EMPRESA;

    Declare
      cursor cur_codigo is
        select docu_nro_doc
          from stk_documento
         where docu_tipo_mov is null
           and docu_nro_doc >= vcont
           and docu_empr = I_P_EMPRESA;

    Begin
      For x in cur_codigo LOOP
        v_cod := x.docu_nro_doc;
        if v_cod > vcont then
          exit;
        elsif v_cod < vcont then
          null;
        else
          vcont := vcont + 1;
        end if;
      end loop;
    end;
    v_cod := vcont;
    RETURN v_cod;
  END;

END STKI231;
/
