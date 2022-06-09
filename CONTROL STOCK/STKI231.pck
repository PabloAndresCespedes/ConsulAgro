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
