CREATE OR REPLACE PACKAGE FACI052 IS

  -- Author  : PROGRAMACION12
  -- Created : 28/09/2021 16:25:06
  -- Purpose : Migracion del program 3-2-70 & 3-2-71 JB

  FUNCTION FP_COTIZACION RETURN NUMBER;
  FUNCTION FL_OBTENER_ULT_NRO(I_TIPO_MOV  IN NUMBER,
                              I_IMPRESORA IN VARCHAR2,
                              I_EMPRESA   IN NUMBER) RETURN CHAR;
  FUNCTION FP_DIAS_DE_ATRASO RETURN NUMBER;

  PROCEDURE PP_TRAER_DESC_CLI(P_DOC_CLI                     IN NUMBER,
                              P_EMPRESA                     IN NUMBER,
                              P_DOC_FEC_DOC                 IN DATE,
                              P_W_IMP_LIM_CR_EMPR           IN OUT NUMBER,
                              P_W_IMP_LIM_CR_DISP_GRUPO     IN OUT NUMBER,
                              P_W_IMP_LIM_CR_DISP_EMPR      IN OUT NUMBER,
                              P_W_IMP_CHEQ_DIFERIDO         IN OUT NUMBER,
                              P_W_IMP_CHEQ_RECHAZADO        IN OUT NUMBER,
                              P_CLI_NOM                     OUT VARCHAR2,
                              P_CLI_DIR                     OUT VARCHAR2,
                              P_DOC_CLI_TEL                 OUT VARCHAR2,
                              P_DOC_CLI_RUC                 OUT VARCHAR2,
                              P_CLI_PERS_REPRESENTANTE      OUT VARCHAR2,
                              P_CLI_DOC_IDENT_REPRESENTANTE OUT VARCHAR2,
                              P_W_CLI_MAX_DIAS_ATRASO       OUT NUMBER,
                              P_CLI_LOCALIDAD               OUT NUMBER,
                              W_CLI_MAX_DIAS_ATRASO         OUT NUMBER,
                              P_DOC_CANAL                   OUT NUMBER,
                              P_CLI_IND_MOD_CANAL           OUT VARCHAR2,
                              O_CLI_DOC_TIPO                OUT NUMBER);

  PROCEDURE PP_TRAER_CTACO_ARTICULO(I_EMPRESA           IN NUMBER,
                                    I_ART_CLASIFICACION IN NUMBER,
                                    O_ART_CTA_CONTABLE  OUT NUMBER);

  PROCEDURE PP_VALIDA_CANAL;

  PROCEDURE PP_CONTROL_CLIENTE(INDICADOR OUT NUMBER);

  FUNCTION FP_MOSTRAR_CANAL RETURN VARCHAR2;

  PROCEDURE PP_RECALCULAR_PRECIO;
  PROCEDURE PP_RECALCULAR_DETALLES(SECUENCIA NUMBER);

  --PROCEDURE PP_CALCULAR_PRECIO_UNITARIO;
  PROCEDURE PP_CALCULAR_TOTALES_CONCEPTO;

  PROCEDURE PP_VERIF_EXIST_CTA_BCO(P_EMPRESA               IN NUMBER,
                                   P_DOC_CTA_BCO           IN NUMBER,
                                   P_BCO_DESC              OUT VARCHAR2,
                                   P_CTA_DESC              OUT VARCHAR2,
                                   P_DOC_MON               OUT NUMBER,
                                   P_CTA_CHEQ_DIF_RESPALDO OUT NUMBER);

  PROCEDURE PP_VAL_CTA_BCO_MES_ACTUAL;
  PROCEDURE PP_BUSCAR_CLI_EMPR_MONEDA;
  PROCEDURE PP_BUSCAR_IMPUESTO;
  PROCEDURE PP_BUSCAR_PRECIO;
  PROCEDURE PP_BUSCAR_OFERTA;
  PROCEDURE PP_BUSCAR_DESCUENTO_PLAZOPAGO;
  PROCEDURE PP_BUSCAR_EXISTENCIA;
  PROCEDURE PP_BUSCAR_PED_SUC_IMP;
  PROCEDURE PP_BUSCAR_CANT_REMITIDO;
  PROCEDURE PP_BUSCAR_NRO_FACTURA;

  PROCEDURE PP_DESHABILITAR_TASA;
  PROCEDURE PP_CTRL_LIM_CR;

  PROCEDURE PP_VALIDAR_LISTA_PRECIOS;
  PROCEDURE PP_VALIDAR_LISTA_PRECIO;
  PROCEDURE PP_VALIDAR_RUC(P_VALOR OUT NUMBER);
  PROCEDURE PP_VALIDA_PLAZO;
  PROCEDURE PP_VALIDAR_REMI;
  PROCEDURE PP_VALIDAR_REMI_DET;
  PROCEDURE PP_VALIDAR_CHEQ_DIF;
  PROCEDURE PP_VALIDAR_CHEQREC;
  PROCEDURE PP_VALIDAR_REMI_DET_ACUM;
  PROCEDURE PP_VALIDAR_DETA;
  PROCEDURE PP_VALIDAR_VENCIMIENTOS(V_MAX_DIAS_ATRASO IN NUMBER,
                                    VALIDAR           IN VARCHAR2,
                                    VALOR             OUT NUMBER);
  PROCEDURE PP_VALIDAR_MONEDA;

  PROCEDURE PP_CARGAR_DATOS_FLETE;
  PROCEDURE PP_CARGAR_EXISTENCIAS;
  PROCEDURE PP_CARGAR_CANT_KILOS;
  PROCEDURE PP_CARGAR_DATOS;

  PROCEDURE PP_CONTROL_ARTICULO;

  PROCEDURE PP_COLLECTION_ADICIONAR_ITEM;
  PROCEDURE PP_COLLECTION_BORRAR_DETALLE(I_SEQ IN NUMBER);
  PROCEDURE PP_COLLECTION_UPDATE;

  PROCEDURE PP_GENERAR_CUOTAS;
  PROCEDURE PP_ADICIONAR_CUOTA(P_CUO_FEC_VTO IN DATE,
                               P_CUO_IMP_MON IN NUMBER);

  PROCEDURE PP_GUARDAR_CHEQUE;
  PROCEDURE PP_GUARDAR_TARJETA;

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_FIN(FIN_DATOS FIN_DOCUMENTO%ROWTYPE);
  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_DOC_CLAVE  IN NUMBER,
                                   I_DOCU_CLAVE IN NUMBER);
  PROCEDURE PP_ACTUALIZAR_CUOTAS(I_CUO_CLAVE IN NUMBER);
  PROCEDURE PP_ACTUALIZAR_AUTORIZ_ESPEC;
  PROCEDURE PP_ACTUALIZAR_DOC_CONCEPTO(P_DOC_CLAVE IN NUMBER);
  PROCEDURE PP_ACTUALIZAR_FAC_DOCU_DET(I_DOC_CLAVE_FAC IN NUMBER);
  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_STK(I_DOCU_CLAVE IN NUMBER);

  --PROCEDURE PP_UNLOCK_IMPRESORA; DIRECTAMENTE IMPLEMENTADO EN EL PROCESO
  FUNCTION FP_BUSCAR_ART_COD_ALFANUM RETURN BOOLEAN;
  PROCEDURE PP_BUSCAR_FLETE_DET;

  --PROCEDURE PP_LLAMAR_REPORTE;
  PROCEDURE PP_LLAMAR_REPORTE(I_P_CLAVE   IN NUMBER,
                              I_P_CLIENTE IN NUMBER,
                              I_P_EMPRESA IN NUMBER);

END FACI052;
/
CREATE OR REPLACE PACKAGE BODY FACI052 IS

  V_DCON_MERC_EXEN_LOC NUMBER;
  V_DCON_MERC_EXEN_MON NUMBER;
  V_DCON_MERC_GRAV_LOC NUMBER;
  V_DCON_MERC_GRAV_MON NUMBER;
  V_DCON_MERC_IVA_LOC  NUMBER;
  V_DCON_MERC_IVA_MON  NUMBER;

  FUNCTION FP_COTIZACION RETURN NUMBER IS
  
    V_TASA NUMBER;
  
  BEGIN
  
    SELECT COT_TASA
      INTO V_TASA
      FROM STK_COTIZACION
     WHERE TRUNC(COT_FEC) = V('P2986_DOC_FEC_DOC')
       AND COT_MON = V('P2986_DOC_MON')
       AND COT_EMPR = V('P_EMPRESA');
  
    RETURN V_TASA;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Primero debe ingresar la cotizaci?n del d?a para la moneda ' ||
                              TO_CHAR(V('P_MON_US')) || '!');
  END;

  FUNCTION FL_OBTENER_ULT_NRO(I_TIPO_MOV  IN NUMBER,
                              I_IMPRESORA IN VARCHAR2,
                              I_EMPRESA   IN NUMBER) RETURN CHAR IS
    /*
    Retorna el ultimo nro grabado de acuerdo al tipo de movimiento por impresora en formto de 13 digitos.
    */
    V_NRO NUMBER := 0;
  BEGIN
  
    IF I_TIPO_MOV IN (9, 10) THEN
      --FACTURAS, CONTADO Y CREDITO
      INSERT INTO X
        (CAMPO1, OTRO)
      VALUES
        ('SELECT IMP_ULT_FACT FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
         I_EMPRESA || ' AND IMPR_IP = ' || I_IMPRESORA,
         'INSERTAR EN FACI052');
      COMMIT;
      GEN_EXEC_SELECT('SELECT IMP_ULT_FACT FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                      I_EMPRESA || ' AND IMPR_IP = ' || I_IMPRESORA,
                      V_NRO);
    END IF;
    IF I_TIPO_MOV = 7 THEN
      --AUTOFACTURAS
      GEN_EXEC_SELECT('SELECT IMP_ULT_FACT_COMPRA FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                      I_EMPRESA || ' AND IMPR_IP=' || I_IMPRESORA,
                      V_NRO);
    END IF;
    IF I_TIPO_MOV = 16 THEN
      --NOTA DE CREDITO
      GEN_EXEC_SELECT('SELECT IMP_ULT_NOTA_CREDITO FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                      I_EMPRESA || ' AND IMPR_IP=' || I_IMPRESORA,
                      V_NRO);
    END IF;
    IF I_TIPO_MOV IN (61, 62, 64) THEN
      --RETENCIONES IVA Y RENTA
      GEN_EXEC_SELECT('SELECT IMP_ULT_RETENCION FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                      I_EMPRESA || ' AND IMPR_IP=' || I_IMPRESORA,
                      V_NRO);
    END IF;
  
    IF I_TIPO_MOV = 15 THEN
      --NOTA DE DEBITO
      GEN_EXEC_SELECT('SELECT IMP_ULT_NOTA_DEBITO FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                      I_EMPRESA || ' AND IMPR_IP=' || I_IMPRESORA,
                      V_NRO);
    END IF;
    IF I_TIPO_MOV = 23 THEN
      --RETENCIONES
      GEN_EXEC_SELECT('SELECT IMP_ULT_RETENCION FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                      I_EMPRESA || ' AND IMPR_IP=' || I_IMPRESORA,
                      V_NRO);
    END IF;
    IF I_TIPO_MOV = 68 THEN
      --RETENCIONES
      GEN_EXEC_SELECT('SELECT IMP_ULT_NRO_REMISION FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                      I_EMPRESA || ' AND IMPR_IP=' || I_IMPRESORA,
                      V_NRO);
    END IF;
    IF I_TIPO_MOV = 6 THEN
      --RECIBOS
      GEN_EXEC_SELECT('SELECT IMP_ULT_REC_PAGO_EMIT FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                      I_EMPRESA || ' AND IMPR_IP=' || I_IMPRESORA,
                      V_NRO);
    END IF;
  
    --raise_application_error(-20010, 'V_NRO: '||V_NRO);
  
    RETURN LPAD(NVL(V_NRO, 0) + 1, 13, '0');
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              SQLCODE || ' error en buscar nro factura ' ||
                              SQLERRM);
  END;

  FUNCTION FP_DIAS_DE_ATRASO RETURN NUMBER IS
    V_CANT_DIAS NUMBER;
    V_SYSDATE   DATE;
  BEGIN
    V_SYSDATE := TO_DATE(TO_CHAR(SYSDATE, 'DD/MM/YYYY'), 'DD/MM/YYYY');
    SELECT MAX(V_SYSDATE - CUO_FEC_VTO)
      INTO V_CANT_DIAS
      FROM FIN_DOCUMENTO, FIN_CUOTA
     WHERE DOC_CLAVE = CUO_CLAVE_DOC
       AND DOC_EMPR = V('P_EMPRESA')
       AND DOC_CLI = V('P2986_DOC_CLI')
       AND DOC_TIPO_MOV = V('P2986_CONF_COD_FAC_CRED')
       AND CUO_SALDO_LOC > 0
       AND CUO_SALDO_MON > 0
       AND DOC_EMPR = CUO_EMPR;
  
    RETURN V_CANT_DIAS;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, 'ERROR CON FP_DIAS_DE_ATRASO');
  END;

  PROCEDURE PP_TRAER_DESC_CLI(P_DOC_CLI                     IN NUMBER,
                              P_EMPRESA                     IN NUMBER,
                              P_DOC_FEC_DOC                 IN DATE,
                              P_W_IMP_LIM_CR_EMPR           IN OUT NUMBER,
                              P_W_IMP_LIM_CR_DISP_GRUPO     IN OUT NUMBER,
                              P_W_IMP_LIM_CR_DISP_EMPR      IN OUT NUMBER,
                              P_W_IMP_CHEQ_DIFERIDO         IN OUT NUMBER,
                              P_W_IMP_CHEQ_RECHAZADO        IN OUT NUMBER,
                              P_CLI_NOM                     OUT VARCHAR2,
                              P_CLI_DIR                     OUT VARCHAR2,
                              P_DOC_CLI_TEL                 OUT VARCHAR2,
                              P_DOC_CLI_RUC                 OUT VARCHAR2,
                              P_CLI_PERS_REPRESENTANTE      OUT VARCHAR2,
                              P_CLI_DOC_IDENT_REPRESENTANTE OUT VARCHAR2,
                              P_W_CLI_MAX_DIAS_ATRASO       OUT NUMBER,
                              P_CLI_LOCALIDAD               OUT NUMBER,
                              W_CLI_MAX_DIAS_ATRASO         OUT NUMBER,
                              P_DOC_CANAL                   OUT NUMBER,
                              P_CLI_IND_MOD_CANAL           OUT VARCHAR2,
                              O_CLI_DOC_TIPO                OUT NUMBER) IS
  
    V_CLI_NOM           VARCHAR2(80);
    V_CLI_DIR           VARCHAR2(80);
    V_CLI_CANAL         NUMBER;
    V_CLI_IND_MOD_CANAL VARCHAR2(1);
    CLIENTE_SIN_CANAL EXCEPTION;
    --*
  BEGIN
  
    SELECT CLI_NOM,
           CLI_DIR,
           SUBSTR(CLI_TEL, 1, 15),
           CLI_RUC,
           CLI_PERS_REPRESENTANTE,
           CLI_DOC_IDENT_REPRESENTANTE,
           CLI_LOCALIDAD,
           CLI_MAX_DIAS_ATRASO,
           CLI_CANAL,
           NVL(CLI_IND_MOD_CANAL, 'N'),
           CLI_DOC_TIPO
    
      INTO V_CLI_NOM,
           V_CLI_DIR,
           P_DOC_CLI_TEL,
           P_DOC_CLI_RUC,
           P_CLI_PERS_REPRESENTANTE,
           P_CLI_DOC_IDENT_REPRESENTANTE,
           P_CLI_LOCALIDAD,
           P_W_CLI_MAX_DIAS_ATRASO,
           V_CLI_CANAL,
           V_CLI_IND_MOD_CANAL,
           O_CLI_DOC_TIPO
      FROM FIN_CLIENTE
     WHERE CLI_CODIGO = P_DOC_CLI
       AND CLI_EMPR = P_EMPRESA;
  
    IF V_CLI_CANAL IS NULL THEN
      IF P_EMPRESA = 1 THEN
        RAISE CLIENTE_SIN_CANAL;
      END IF;
      P_DOC_CANAL         := NULL;
      P_CLI_IND_MOD_CANAL := 'S';
    ELSE
      P_DOC_CANAL         := V_CLI_CANAL;
      P_CLI_IND_MOD_CANAL := NVL(V_CLI_IND_MOD_CANAL, 'N');
    END IF;
  
    P_CLI_NOM := V_CLI_NOM;
    P_CLI_DIR := V_CLI_DIR;
  
    FIN_LIM_CREDITO(P_DOC_FEC_DOC,
                    P_DOC_CLI,
                    P_W_IMP_LIM_CR_EMPR,
                    P_EMPRESA,
                    P_W_IMP_LIM_CR_DISP_GRUPO,
                    P_W_IMP_LIM_CR_DISP_EMPR,
                    P_W_IMP_CHEQ_DIFERIDO,
                    P_W_IMP_CHEQ_RECHAZADO);
  
    --*
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'Cliente inexistente.');
    WHEN CLIENTE_SIN_CANAL THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Cliente sin canal. Asigne el canal al client en el mantenimiento de clientes!.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE || '  ' || SQLERRM);
  END;

  PROCEDURE PP_TRAER_CTACO_ARTICULO(I_EMPRESA           IN NUMBER,
                                    I_ART_CLASIFICACION IN NUMBER,
                                    O_ART_CTA_CONTABLE  OUT NUMBER) IS
    V_ART_CTA_CONTABLE NUMBER;
  BEGIN
    SELECT CLAS_CTACO_VENTA
      INTO V_ART_CTA_CONTABLE
      FROM STK_CLASIFICACION
     WHERE CLAS_CODIGO = I_ART_CLASIFICACION
       AND CLAS_EMPR = I_EMPRESA;
  
    IF V_ART_CTA_CONTABLE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Debe asignar una CtaContable para mercaderias en Stkm008 - Cuentas por articulos!.');
    END IF;
  
    O_ART_CTA_CONTABLE := V_ART_CTA_CONTABLE;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'No existe cta contable para mercaderia o el articulo no tiene asignado Ctas Contables!.');
  END PP_TRAER_CTACO_ARTICULO;

  PROCEDURE PP_VALIDA_CANAL IS
    V_CANAL NUMBER;
  BEGIN
    SELECT MAX(CLI_CANAL)
      INTO V_CANAL
      FROM FIN_CLIENTE
     WHERE CLI_CODIGO = V('P2986_DOC_CLI')
       AND CLI_EMPR = V('P_EMPRESA');
  
    IF V_CANAL IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Cliente sin CANAL, actualizar el cliente para facturar..!');
    END IF;
  END;

  FUNCTION FP_MOSTRAR_CANAL RETURN VARCHAR2 IS
    DESCRIPCION VARCHAR2(50);
  BEGIN
    SELECT CAN_DESC
      INTO DESCRIPCION
      FROM FAC_CANAL_VENTA
     WHERE CAN_CODIGO = V('P2986_DOC_CANAL')
       AND CAN_EMPR = V('P_EMPRESA');
  
    RETURN DESCRIPCION;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
      RAISE_APPLICATION_ERROR(-20010, 'Canal Inexistente!');
  END;
  /*
  PROCEDURE PP_RECALCULAR_TOTALES IS
  
  BEGIN
  
    :BDOC_ENCA.W_BRUTO_EXEN_PRECIO_MON := :BDOC_DET.W_TOT_BRUTO_EXEN_PRECIO_MON;
    :BDOC_ENCA.W_BRUTO_GRAV_PRECIO_MON := :BDOC_DET.W_TOT_BRUTO_GRAV_PRECIO_MON;
  
    :BDOC_ENCA.DOC_BRUTO_EXEN_LOC := NVL(:BDOC_DET.W_TOT_BRUTO_EXEN_LOC, 0);
    :BDOC_ENCA.DOC_BRUTO_EXEN_MON := NVL(:BDOC_DET.W_TOT_BRUTO_EXEN_MON, 0);
    :BDOC_ENCA.DOC_BRUTO_GRAV_LOC := NVL(:BDOC_DET.W_TOT_BRUTO_GRAV_LOC, 0);
    :BDOC_ENCA.DOC_BRUTO_GRAV_MON := NVL(:BDOC_DET.W_TOT_BRUTO_GRAV_MON, 0);
    :BDOC_ENCA.DOC_NETO_EXEN_LOC  := NVL(:BDOC_DET.W_TOT_NETO_EXEN_LOC, 0);
    :BDOC_ENCA.DOC_NETO_EXEN_MON  := NVL(:BDOC_DET.W_TOT_NETO_EXEN_MON, 0);
    :BDOC_ENCA.DOC_NETO_GRAV_LOC  := NVL(:BDOC_DET.W_TOT_NETO_GRAV_LOC, 0);
    :BDOC_ENCA.DOC_NETO_GRAV_MON  := NVL(:BDOC_DET.W_TOT_NETO_GRAV_MON, 0);
  
    IF V('P2986_DOC_MON') = :PARAMETER.P_MON_LOC THEN
      :BDOC_ENCA.DOC_IVA_LOC := :BDOC_ENCA.F_TOT_IVA;
      :BDOC_ENCA.DOC_IVA_MON := :BDOC_ENCA.DOC_IVA_LOC;
    ELSE
  
      :BDOC_ENCA.DOC_IVA_MON := :BDOC_ENCA.F_TOT_IVA;
      :BDOC_ENCA.DOC_IVA_LOC := ROUND(:BDOC_ENCA.DOC_IVA_MON *
                                      :BDOC_ENCA.W_DOC_TASA_US,
                                      :PARAMETER.P_CANT_DECIMALES_LOC);
    END IF;
  EXCEPTION
    WHEN FORM_TRIGGER_FAILURE THEN
      RAISE FORM_TRIGGER_FAILURE;
    WHEN OTHERS THEN
      PL_EXHIBIR_ERROR_PLSQL;
  END;
  */
  PROCEDURE PP_RECALCULAR_PRECIO IS
    V_PRECIO_CON_IVA NUMBER := 0;
    V_PREC_UNITARIO  NUMBER := 0;
    V_AUX            NUMBER := 0;
  BEGIN
  
    V_PRECIO_CON_IVA := V('P2986_S_PRECIO') * (-1);
    V_AUX            := (1 + ((V('P2986_IMPU_PORC_BASE_IMPO') / 100) *
                        (V('P2986_IMPU_PORCENTAJE') / 100)));
    V_PREC_UNITARIO  := V_PRECIO_CON_IVA / V_AUX;
    SETITEM('P2986_S_PRECIO', V_PREC_UNITARIO);
    --RAISE_APPLICATION_ERROR(-20002, 'AQUI ' || V('P2986_S_PRECIO'));
  END;

  PROCEDURE PP_RECALCULAR_DETALLES(SECUENCIA NUMBER) IS
    V_BRUTO_LISTA              NUMBER := 0; -- cantidad por precio unitario de lista
    V_BRUTO                    NUMBER := 0; -- cantidad por precio unitario ingresado
    V_BRUTO_GRAV_LISTA         NUMBER := 0; -- bruto gravado segun precio de lista
    V_BRUTO_EXEN_LISTA         NUMBER := 0; -- bruto exento  segun precio de lista
    V_BRUTO_GRAV               NUMBER := 0; -- bruto gravado segun precio ingresado
    V_BRUTO_EXEN               NUMBER := 0; -- bruto exento  segun precio ingresado
    V_VAL_DTO                  NUMBER := 0; -- V_BRUTO por el porcentaje de descuento
    V_NETO                     NUMBER := 0; -- V_BRUTO menos V_VAL_DTO
    V_NETO_GRAV                NUMBER := 0; -- V_BRUTO menos V_VAL_DTO
    V_NETO_EXEN                NUMBER := 0; -- V_BRUTO menos V_VAL_DTO
    V_IVA                      NUMBER := 0; -- V_NETO por porcentaje de IVA
    V_CANT_DECI                NUMBER := 0;
    V_PRECIO                   NUMBER := 0;
    UNIDAD_MEDIDA              VARCHAR2(4500);
    FACTOR_CONVERSION          NUMBER;
    P_IMPU_PORC_BASE_IMPONIBLE NUMBER;
    P_IMPU_PORCENTAJE          NUMBER;
    P_ART_CLASIFICACION        NUMBER;
    P_ART_IMPU                 NUMBER;
    UNIDAD_VTA                 VARCHAR2(50);
    ARTICULO                   VARCHAR2(50);
    CANTIDAD                   NUMBER;
    PRECIO                     NUMBER;
    X                          VARCHAR2(8000);
    VALORES                    NUMBER;
    VALORES1                   NUMBER;
  BEGIN
  
    P_IMPU_PORC_BASE_IMPONIBLE := V('P2986_IMPU_PORC_BASE_IMPO');
    P_IMPU_PORCENTAJE          := V('P2986_IMPU_PORCENTAJE');
  
    V_CANT_DECI := V('P2986_W_MON_DEC_IMP'); --cantidad de decimales
  
    UNIDAD_VTA := V('P2986_S_UNIDAD_VTA');
    ARTICULO   := V('P2986_S_ART');
    CANTIDAD   := V('P2986_DET_CANT');
    PRECIO     := V('P2986_S_PRECIO');
  
    SELECT ART_UNID_MED, ART_FACTOR_CONVERSION, ART_CLASIFICACION, ART_IMPU
      INTO UNIDAD_MEDIDA,
           FACTOR_CONVERSION,
           P_ART_CLASIFICACION,
           P_ART_IMPU
      FROM GEN_IMPUESTO IM, STK_ENVASES EN, STK_LINEA LI, STK_ARTICULO AR
     WHERE LIN_EMPR = ART_EMPR
       AND LIN_CODIGO = ART_LINEA
       AND IMPU_EMPR = ART_EMPR
       AND IMPU_CODIGO = ART_IMPU
       AND ENVA_EMPR(+) = ART_EMPR
       AND ENVA_LINEA(+) = ART_LINEA
       AND ENVA_CODIGO(+) = ART_ENVASE
       AND ART_EMPR = V('P_EMPRESA')
       AND ART_CODIGO = ARTICULO;
  
    X := (PRECIO / FACTOR_CONVERSION);
    -- RAISE_APPLICATION_ERROR(-20010, X||' PRECIO '||PRECIO||' FACTOR '||FACTOR_CONVERSION||' ART '||ARTICULO||' EMPRESA '||V('P_EMPRESA')||'  HOLAAA ');
    IF UNIDAD_VTA = 'U' AND UNIDAD_MEDIDA = 'KG' THEN
    
      IF FACTOR_CONVERSION <> 0 THEN
      
        SETITEM('P2986_AREM_PRECIO_VTA', X);
      
      ELSE
        RAISE_APPLICATION_ERROR(-20010,
                                'ERROR CON EL FACTOR DE LA CONVERSION');
      END IF;
    
      V_PRECIO      := PRECIO / NVL(FACTOR_CONVERSION, 1);
      V_BRUTO_LISTA := ROUND((NVL(CANTIDAD, 0) * NVL(FACTOR_CONVERSION, 1)) *
                             NVL(X /*V('P2986_AREM_PRECIO_VTA')*/, 0),
                             V_CANT_DECI);
      V_BRUTO       := ROUND((NVL(CANTIDAD, 0) * NVL(FACTOR_CONVERSION, 1)) *
                             NVL(V_PRECIO, 0),
                             V_CANT_DECI);
    
    ELSE
    
      V_PRECIO      := PRECIO;
      V_BRUTO_LISTA := ROUND((NVL(CANTIDAD, 0)) *
                             NVL(X /*V('P2986_AREM_PRECIO_VTA')*/, 0),
                             V_CANT_DECI);
      V_BRUTO       := ROUND((NVL(CANTIDAD, 0)) * NVL(V_PRECIO, 0),
                             V_CANT_DECI);
    
    END IF;
  
    V_VAL_DTO := ROUND(((V_BRUTO * NVL(V('P2986_S_PORC_DTO'), 0)) / 100),
                       V_CANT_DECI);
    V_NETO    := NVL(V_BRUTO, 0) - NVL(V_VAL_DTO, 0);
  
    IF NVL(P_IMPU_PORCENTAJE, 0) > 0 THEN
    
      IF V('P2986_W_CLI_PORC_EXEN_IVA') IS NOT NULL THEN
        V_BRUTO_EXEN_LISTA := ROUND(((V_BRUTO_LISTA *
                                    V('P2986_W_CLI_PORC_EXEN_IVA')) / 100),
                                    V_CANT_DECI);
        V_BRUTO_GRAV_LISTA := V_BRUTO_LISTA - V_BRUTO_EXEN_LISTA;
        V_BRUTO_EXEN       := ROUND(((V_BRUTO *
                                    V('P2986_W_CLI_PORC_EXEN_IVA')) / 100),
                                    V_CANT_DECI);
        V_BRUTO_GRAV       := V_BRUTO - V_BRUTO_EXEN;
        V_NETO_EXEN        := ROUND(((V_NETO *
                                    V('P2986_W_CLI_PORC_EXEN_IVA')) / 100),
                                    V_CANT_DECI);
        V_NETO_GRAV        := V_NETO - V_NETO_EXEN;
      
      ELSE
      
        V_BRUTO_EXEN_LISTA := V_BRUTO_LISTA -
                              ROUND((V_BRUTO_LISTA *
                                    (P_IMPU_PORC_BASE_IMPONIBLE / 100)),
                                    V_CANT_DECI);
        V_BRUTO_GRAV_LISTA := V_BRUTO_LISTA - V_BRUTO_EXEN_LISTA;
        V_BRUTO_EXEN       := V_BRUTO - ROUND((V_BRUTO *
                                              (P_IMPU_PORC_BASE_IMPONIBLE / 100)),
                                              V_CANT_DECI);
        V_BRUTO_GRAV       := V_BRUTO - V_BRUTO_EXEN;
        V_NETO_EXEN        := V_NETO - ROUND((V_NETO *
                                             (P_IMPU_PORC_BASE_IMPONIBLE / 100)),
                                             V_CANT_DECI);
        V_NETO_GRAV        := V_NETO - V_NETO_EXEN;
      
      END IF;
    
    ELSE
    
      V_BRUTO_GRAV_LISTA := 0;
      V_BRUTO_EXEN_LISTA := V_BRUTO_LISTA;
      V_BRUTO_GRAV       := 0;
      V_BRUTO_EXEN       := V_BRUTO;
      V_NETO_GRAV        := 0;
      V_NETO_EXEN        := V_NETO;
    
    END IF;
    /*P_IMPU_PORCENTAJE := (P_IMPU_PORCENTAJE + 100) / P_IMPU_PORCENTAJE;
    V_IVA             := ROUND((V_NETO_GRAV / P_IMPU_PORCENTAJE),
                               V_CANT_DECI);*/
    V_IVA := ROUND(((V_NETO_GRAV * P_IMPU_PORCENTAJE) / 100), V_CANT_DECI);
  
    -- Carga los valores para el bloque de detalle
  
    IF V('P2986_DOC_MON') = V('P_MON_LOC') THEN
      -- si la moneda del documento es moneda local
      SETITEM('P2986_DET_BRUTO_LOC', V_BRUTO_LISTA);
      SETITEM('P2986_DET_BRUTO_MON', V_BRUTO_LISTA);
      SETITEM('P2986_DET_NETO_LOC', V_NETO);
      SETITEM('P2986_DET_NETO_MON', V_NETO);
      SETITEM('P2986_DET_IVA_LOC', V_IVA);
      SETITEM('P2986_DET_IVA_MON', V_IVA);
    ELSE
      -- si la moneda del documento es U$
      SETITEM('P2986_DET_BRUTO_MON', V_BRUTO_LISTA);
      SETITEM('P2986_DET_BRUTO_LOC',
              ROUND((V('P2986_DET_BRUTO_MON') * V('P2986_W_DOC_TASA_US')),
                    V('P2986_W_MON_DEC_IMP')));
      SETITEM('P2986_DET_NETO_MON', V_NETO);
      SETITEM('P2986_DET_NETO_LOC',
              ROUND((V('P2986_DET_NETO_MON') * V('P2986_W_DOC_TASA_US')),
                    V('P2986_W_MON_DEC_IMP')));
      SETITEM('P2986_DET_IVA_MON', V_IVA);
      SETITEM('P2986_DET_IVA_LOC',
              ROUND((V('P2986_DET_IVA_MON') * V('P2986_W_DOC_TASA_US')),
                    V('P2986_W_MON_DEC_IMP')));
    END IF;
  
    -- CALCULA LOS TOTALES EXENTOS, GRAVADOS Y EL IVA
  
    SETITEM('P2986_W_BRUTO_EXEN_PRECIO_MON', V_BRUTO_EXEN);
  
    IF V('P2986_S_TIPO_FACTURA') = 3 THEN
      -- factura IVA incluido
      SETITEM('P2986_W_BRUTO_EXEN_PRECIO_MON',
              V_BRUTO_GRAV + ROUND(((V_BRUTO_GRAV * P_IMPU_PORCENTAJE) / 100),
                                   V('P2986_W_MON_DEC_IMP')));
    ELSE
    
      SETITEM('P2986_W_BRUTO_EXEN_PRECIO_MON', V_BRUTO_GRAV);
    
    END IF;
  
    SETITEM('P2986_W_BRUTO_EXEN_MON', V_BRUTO_EXEN_LISTA);
    SETITEM('P2986_W_BRUTO_GRAV_MON', V_BRUTO_GRAV_LISTA);
  
    IF V('P2986_DOC_MON') = V('P_MON_LOC') THEN
      -- si la moneda del documento es local
      SETITEM('P2986_W_BRUTO_EXEN_LOC', V_BRUTO_EXEN_LISTA);
      SETITEM('P2986_W_BRUTO_GRAV_LOC', V_BRUTO_GRAV_LISTA);
    
    ELSE
    
      VALORES  := ROUND((NVL(V_BRUTO_EXEN_LISTA, 0) *
                        V('P2986_W_DOC_TASA_US')),
                        1);
      VALORES1 := ROUND((NVL(V_BRUTO_GRAV_LISTA, 0) *
                        V('P2986_W_DOC_TASA_US')),
                        V('P2986_W_MON_DEC_IMP'));
    
      SETITEM('P2986_W_BRUTO_EXEN_LOC', VALORES);
      SETITEM('P2986_W_BRUTO_GRAV_LOC', VALORES1);
    
    END IF;
  
    IF V('P2986_DOC_MON') = 1 THEN
    
      SETITEM('P2986_W_NETO_EXEN_LOC', V_NETO_EXEN);
      SETITEM('P2986_W_NETO_EXEN_MON', V_NETO_EXEN);
      SETITEM('P2986_W_NETO_GRAV_LOC', V_NETO_GRAV);
      SETITEM('P2986_W_NETO_GRAV_MON', V_NETO_GRAV);
    
    ELSE
    
      SETITEM('P2986_W_NETO_EXEN_MON', V_NETO_EXEN);
      SETITEM('P2986_W_NETO_EXEN_LOC',
              ROUND((NVL(V('P2986_W_NETO_EXEN_MON'), 0) *
                    V('P2986_W_DOC_TASA_US')),
                    1));
      SETITEM('P2986_W_NETO_GRAV_MON', V_NETO_GRAV);
      SETITEM('P2986_W_NETO_GRAV_LOC',
              ROUND((NVL(V('P2986_W_NETO_GRAV_MON'), 0) *
                    V('P2986_W_DOC_TASA_US')),
                    1));
    
    END IF;
  
    SETITEM('P2986_W_IVA_MON',
            ROUND((((V('P2986_W_NETO_GRAV_MON')) * P_IMPU_PORCENTAJE) / 100),
                  V('P2986_W_MON_DEC_IMP')));
    SETITEM('P2986_W_IVA_LOC',
            ROUND((((V('P2986_W_NETO_GRAV_LOC')) * P_IMPU_PORCENTAJE) / 100),
                  1));
  
    BEGIN
    
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '9',
                                                P_ATTR_VALUE      => V('P2986_W_NETO_EXEN_MON'));
      END;
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '10',
                                                P_ATTR_VALUE      => V('P2986_W_NETO_EXEN_LOC'));
      END;
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '11',
                                                P_ATTR_VALUE      => V('P2986_W_NETO_GRAV_MON'));
      END;
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '12',
                                                P_ATTR_VALUE      => V('P2986_W_NETO_GRAV_LOC'));
      END;
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '13',
                                                P_ATTR_VALUE      => V('P2986_W_IVA_MON'));
      END;
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '14',
                                                P_ATTR_VALUE      => V('P2986_W_IVA_LOC'));
      END;
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '15',
                                                P_ATTR_VALUE      => P_ART_CLASIFICACION);
      END;
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '16',
                                                P_ATTR_VALUE      => P_IMPU_PORCENTAJE);
      END;
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '17',
                                                P_ATTR_VALUE      => P_ART_IMPU);
      END;
    
      ------ DETALLES FAC_DOC_DET
      BEGIN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                P_SEQ             => SECUENCIA,
                                                P_ATTR_NUMBER     => '18',
                                                P_ATTR_VALUE      => V('P2986_DET_BRUTO_LOC'));
        BEGIN
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                  P_SEQ             => SECUENCIA,
                                                  P_ATTR_NUMBER     => '19',
                                                  P_ATTR_VALUE      => V('P2986_DET_BRUTO_MON'));
        END;
        BEGIN
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                  P_SEQ             => SECUENCIA,
                                                  P_ATTR_NUMBER     => '20',
                                                  P_ATTR_VALUE      => V('P2986_DET_NETO_LOC'));
        END;
        BEGIN
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                  P_SEQ             => SECUENCIA,
                                                  P_ATTR_NUMBER     => '21',
                                                  P_ATTR_VALUE      => V('P2986_DET_NETO_MON'));
        END;
        BEGIN
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                  P_SEQ             => SECUENCIA,
                                                  P_ATTR_NUMBER     => '22',
                                                  P_ATTR_VALUE      => V('P2986_DET_IVA_LOC'));
        END;
        BEGIN
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                  P_SEQ             => SECUENCIA,
                                                  P_ATTR_NUMBER     => '23',
                                                  P_ATTR_VALUE      => V('P2986_DET_IVA_MON'));
        END;
        BEGIN
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                  P_SEQ             => SECUENCIA,
                                                  P_ATTR_NUMBER     => '30',
                                                  P_ATTR_VALUE      => V('P2986_KG_GANCHO'));
        END;
        BEGIN
          APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                                  P_SEQ             => SECUENCIA,
                                                  P_ATTR_NUMBER     => '31',
                                                  P_ATTR_VALUE      => V('P2986_DET_RENDIMIENTO'));
        END;
      END;
    
    END;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Error al momento de recalcular detalles' ||
                              SQLCODE || ' ' || SQLERRM);
  END;

  /* PROCEDURE PP_CALCULAR_PRECIO_UNITARIO IS
  BEGIN
    IF V('P2986_DOC_MON') = V('P_MON_US') THEN
      -- si documento es en U$
      IF V('P2986_AREM_MON') = V('P_MON_LOC') THEN
        -- si el precio esta en Gs. convertirlo a U$
        SETITEM('P2986_S_PRECIO',
                ROUND((V('P2986_S_PRECIO') / V('P2986_W_DOC_TASA_US')),
                      V('P2986_W_MON_DEC_IMP')));
      END IF;
    ELSE
      -- si documento es en Gs.
      IF V('P2986_AREM_MON') = V('P_MON_US') THEN
        -- si el precio esta en U$. convertirlo a Gs.
        SETITEM('P2986_S_PRECIO',
                ROUND((V('P2986_S_PRECIO') * V('P2986_W_DOC_TASA_US')),
                      V('P2986_W_MON_DEC_IMP')));
      END IF;
    END IF;
  
  END;*/
  ----------------------------

  PROCEDURE PP_CALCULAR_TOTALES_CONCEPTO IS
    CURSOR DETALLES IS
      SELECT SEQ_ID ITEM,
             C001 UNIDAD_VTA,
             C002 ARTICULO,
             TO_NUMBER(C003) NRO_REMISION,
             TO_NUMBER(C004) CANTIDAD,
             TO_NUMBER(C005) PRECIO,
             TO_NUMBER(C007) PESO_UNIDAD,
             TO_NUMBER(C008) PESO_TONELADA,
             TO_NUMBER(C009) V_DOC_EXENTA_MON,
             TO_NUMBER(C010) V_DOC_EXENTA_LOC,
             TO_NUMBER(C011) V_DOC_GRAV_MON,
             TO_NUMBER(C012) V_DOC_GRAV_LOC,
             TO_NUMBER(C013) V_DOC_IVA_MON,
             TO_NUMBER(C014) V_DOC_IVA_LOC,
             C015 ART_CLASIFICACION,
             C016 V_ART_CTA_CONTABLE,
             C017 V_IMPU_PORCENTAJE,
             TO_NUMBER(C018) DET_BRUTO_LOC,
             TO_NUMBER(C019) DET_BRUTO_MON,
             TO_NUMBER(C020) DET_NETO_LOC,
             TO_NUMBER(C021) DET_NETO_MON,
             TO_NUMBER(C022) DET_IVA_LOC,
             TO_NUMBER(C023) DET_IVA_MON,
             C028 IND_FLETE,
             C030 KG_GANCHO,
             C031 DET_RENDIMIENTO
        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'DETALLES_FACI052';
  
    C_VARIABLE  NUMBER := 0;
    C_VARIABLE1 NUMBER := 0;
    C_VARIABLE2 NUMBER := 0;
    C_VARIABLE3 NUMBER := 0;
    C_VARIABLE4 NUMBER := 0;
    C_VARIABLE5 NUMBER := 0;
  
  BEGIN
  
    SETITEM('P2986_DCON_MERC_EXEN_LOC', 0);
    SETITEM('P2986_DCON_MERC_EXEN_MON', 0);
    SETITEM('P2986_DCON_MERC_GRAV_LOC', 0);
    SETITEM('P2986_DCON_MERC_GRAV_MON', 0);
    SETITEM('P2986_DCON_IVA_LOC', 0);
    SETITEM('P2986_DCON_IVA_MON', 0);
  
    FOR I IN DETALLES LOOP
    
      IF NVL(I.IND_FLETE, 'U') <> 'F' THEN
        C_VARIABLE  := C_VARIABLE + NVL(I.V_DOC_EXENTA_MON, 0);
        C_VARIABLE1 := C_VARIABLE1 + NVL(I.V_DOC_EXENTA_LOC, 0);
        C_VARIABLE2 := C_VARIABLE2 + NVL(I.V_DOC_GRAV_LOC, 0);
        C_VARIABLE3 := C_VARIABLE3 + NVL(I.V_DOC_GRAV_MON, 0);
        C_VARIABLE4 := C_VARIABLE4 + NVL(I.V_DOC_IVA_LOC, 0);
        C_VARIABLE5 := C_VARIABLE5 + NVL(I.V_DOC_IVA_MON, 0);
      
      END IF;
    
    END LOOP;
  
    SETITEM('P2986_DCON_MERC_EXEN_LOC', C_VARIABLE1); --c_variable
    SETITEM('P2986_DCON_MERC_EXEN_MON', C_VARIABLE); --c_variable1
    SETITEM('P2986_DCON_MERC_GRAV_LOC', C_VARIABLE2);
    SETITEM('P2986_DCON_MERC_GRAV_MON', C_VARIABLE3);
  
    SETITEM('P2986_DCON_IVA_LOC', V('P2986_DOC_IVA_LOC'));
    SETITEM('P2986_DCON_IVA_MON', V('P2986_DOC_IVA_MON'));
  
    V_DCON_MERC_EXEN_LOC := C_VARIABLE1;
    V_DCON_MERC_EXEN_MON := C_VARIABLE;
    V_DCON_MERC_GRAV_LOC := C_VARIABLE2;
    V_DCON_MERC_GRAV_MON := C_VARIABLE3;
    V_DCON_MERC_IVA_LOC  := C_VARIABLE4;
    V_DCON_MERC_IVA_MON  := C_VARIABLE5;
  
  END;

  PROCEDURE PP_VERIF_EXIST_CTA_BCO(P_EMPRESA               IN NUMBER,
                                   P_DOC_CTA_BCO           IN NUMBER,
                                   P_BCO_DESC              OUT VARCHAR2,
                                   P_CTA_DESC              OUT VARCHAR2,
                                   P_DOC_MON               OUT NUMBER,
                                   P_CTA_CHEQ_DIF_RESPALDO OUT NUMBER) IS
  BEGIN
    SELECT BCO_DESC, CTA_DESC, CTA_MON, CTA_CHEQ_DIF_RESPALDO
      INTO P_BCO_DESC, P_CTA_DESC, P_DOC_MON, P_CTA_CHEQ_DIF_RESPALDO
      FROM FIN_BANCO, GEN_MONEDA, FIN_CUENTA_BANCARIA
     WHERE CTA_BCO = BCO_CODIGO(+)
       AND CTA_MON = MON_CODIGO(+)
       AND CTA_CODIGO = P_DOC_CTA_BCO
       AND CTA_EMPR = BCO_EMPR(+)
       AND CTA_EMPR = MON_EMPR(+)
       AND CTA_EMPR = P_EMPRESA;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      P_BCO_DESC := NULL;
      P_CTA_DESC := NULL;
      P_DOC_MON  := NULL;
      RAISE_APPLICATION_ERROR(-20010, 'Cuenta bancaria inexistente!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE || ' Error ' || SQLERRM);
  END;

  PROCEDURE PP_VAL_CTA_BCO_MES_ACTUAL IS
    V_HABILITADO VARCHAR2(1);
    V_VARIABLE   VARCHAR2(1);
    OPEM_OPER    NUMBER;
  BEGIN
  
    SELECT A.OPER_CODIGO
      INTO OPEM_OPER
      FROM GEN_OPERADOR A
     WHERE A.OPER_LOGIN = V('APP_LOGIN')
       AND (A.OPER_EMPR = V('P_EMPRESA') OR A.OPER_EMPR IS NULL);
  
    SELECT 'X'
      INTO V_VARIABLE
      FROM FIN_CONFIGURACION
     WHERE V('P2986_DOC_FEC_DOC') BETWEEN CONF_FEC_LIM_MOD AND
           CONF_PER_ACT_FIN
       AND CONF_EMPR = V('P_EMPRESA');
  
    IF V_VARIABLE = 'X' THEN
    
      SELECT OP_CTA_MES_ACTUAL
        INTO V_HABILITADO
        FROM GEN_OPERADOR, FIN_OPER_CTA_BCO
       WHERE OPER_CODIGO = OP_CTA_OPER
         AND OPER_LOGIN = V('APP_USER')
         AND OP_CTA_CTA_CODIGO = V('P2986_DOC_CTA_BCO')
         AND OP_CTA_EMPR = V('P_EMPRESA');
    
      IF V_HABILITADO = 'N' THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'La Caja/Banco no esta habilitada en la fecha para este usuario!.');
      END IF;
    
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
  END;

  PROCEDURE PP_BUSCAR_CLI_EMPR_MONEDA IS
    V_BLOQUEADO VARCHAR2(1) := ' ';
  BEGIN
  
    SELECT HOL_BLOQ_LIMI_CR
      INTO V_BLOQUEADO
      FROM FIN_FICHA_HOLDING
     WHERE HOL_CODIGO = (SELECT C.CLI_COD_FICHA_HOLDING
                           FROM FIN_CLIENTE C
                          WHERE C.CLI_CODIGO = V('P2986_DOC_CLI')
                            AND CLI_EMPR = V('P_EMPRESA'))
       AND HOL_EMPR = V('P_EMPRESA');
    --*
    IF V_BLOQUEADO = 'S' THEN
      IF V('P2986_S_TIPO_FACTURA') = 2 THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'La cuenta del cliente en la empresa se encuentra bloqueada para esta moneda.!');
      ELSE
        NULL;
      END IF;
    END IF;
    --*
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Cliente no se encuentra habilitado para operar con esta moneda!.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              SQLCODE || ' PP_BUSCAR_CLI_EMPR_MONEDA');
  END PP_BUSCAR_CLI_EMPR_MONEDA;

  PROCEDURE PP_BUSCAR_DESCUENTO_PLAZOPAGO IS
  
    V_LISTA_PRECIO NUMBER;
    C_VARIABLE     VARCHAR2(10000);
    C_VARIABLE1    VARCHAR2(10000);
    C_VARIABLE2    VARCHAR2(10000);
  
  BEGIN
  
    SELECT HOL_PORC_DESCUENTO,
           HOL_DIAS_PLAZO_PAGO,
           HOL_RECARGO,
           HOL_NRO_LISTA_PRECIO
      INTO C_VARIABLE, C_VARIABLE1, C_VARIABLE2, V_LISTA_PRECIO
      FROM FIN_FICHA_HOLDING
     WHERE HOL_CODIGO = (SELECT C.CLI_COD_FICHA_HOLDING
                           FROM FIN_CLIENTE C
                          WHERE C.CLI_CODIGO = V('P2986_DOC_CLI')
                            AND CLI_EMPR = V('P_EMPRESA'))
       AND HOL_EMPR = V('P_EMPRESA');
  
    SETITEM('P2986_S_PORC_DTO', C_VARIABLE);
    SETITEM('P2986_S_PLAZO_PAGO', C_VARIABLE1);
    SETITEM('P2986_S_RECARGO', C_VARIABLE2);
  
    IF V('P2986_S_NRO_PEDIDO') IS NULL THEN
      SETITEM('P2986_LIPR_NRO_LISTA_PRECIO', V_LISTA_PRECIO);
    END IF;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'descuento a largo plazo error ' || SQLCODE);
  END;

  PROCEDURE PP_BUSCAR_IMPUESTO IS
    C_VARIABLE  VARCHAR2(5000);
    C_VARIABLE1 VARCHAR2(5000);
  BEGIN
  
    IF NVL(V('P2986_EXPORTACION'), 'N') = 'S' THEN
      SETITEM('P2986_DET_COD_IVA', 1); --Exento
    END IF;
  
    SELECT IMPU_PORCENTAJE, IMPU_PORC_BASE_IMPONIBLE
      INTO C_VARIABLE, C_VARIABLE1
      FROM GEN_IMPUESTO
     WHERE IMPU_CODIGO = V('P2986_DET_COD_IVA')
       AND IMPU_EMPR = V('P_EMPRESA');
  
    SETITEM('P2986_IMPU_PORCENTAJE', C_VARIABLE);
    SETITEM('P2986_IMPU_PORC_BASE_IMPO', C_VARIABLE1);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'El articulo debe estar sujeto a un impuesto !.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE);
  END;

  PROCEDURE PP_BUSCAR_PRECIO IS
    V_MENSAJE    VARCHAR2(200);
    C_VARIABLE   VARCHAR2(5000);
    C_VARIABLE1  VARCHAR2(5000);
    CC_VARIABLE  VARCHAR2(5000);
    CC_VARIABLE1 VARCHAR2(5000);
  BEGIN
  
    V_MENSAJE := 'El articulo no tiene precio en la lista ' ||
                 TO_CHAR(V('P2986_LIPR_NRO_LISTA_PRECIO'));
  
    IF V('P2986_LIPR_NRO_LISTA_PRECIO') IS NOT NULL THEN
    
      SELECT LIPR_PRECIO_UNITARIO, LIPE_MON
        INTO C_VARIABLE, C_VARIABLE1
        FROM FAC_LISTA_PRECIO, FAC_LISTA_PRECIO_DET
       WHERE LIPE_EMPR = LIPR_EMPR
         AND LIPE_NRO_LISTA_PRECIO = LIPR_NRO_LISTA_PRECIO
         AND LIPE_EMPR = V('P_EMPRESA')
         AND LIPE_MON = V('P2986_DOC_MON')
         AND LIPR_ART = V('P2986_DET_ART')
         AND LIPE_NRO_LISTA_PRECIO = V('P2986_LIPR_NRO_LISTA_PRECIO');
    
      ---- agregue esto para igualar el comportamiento del FACI039 pedio Josue/Diego
      SETITEM('P2986_S_PRECIO',
              V('P2986_S_PRECIO') + NVL(V('P2986_S_RECARGO'), 0));
    
      BEGIN
        FACI052.PP_BUSCAR_OFERTA;
      END;
    
      SETITEM('P2986_S_PRECIO', V('P2986_S_PRECIO') * (-1));
    
      BEGIN
        FACI052.PP_RECALCULAR_PRECIO;
      END;
      ----
    
      SETITEM('P2986_S_PRECIO', C_VARIABLE);
      SETITEM('P2986_AREM_MON', C_VARIABLE1);
    
    ELSE
    
      SELECT AREM_PRECIO_VTA, AREM_MON
        INTO CC_VARIABLE, CC_VARIABLE1
        FROM STK_ARTICULO_EMPRESA
       WHERE AREM_EMPR = V('P_EMPRESA')
         AND AREM_ART = V('P2986_DET_ART');
    
      SETITEM('P2986_S_PRECIO', CC_VARIABLE);
      SETITEM('P2986_AREM_MON', CC_VARIABLE1);
    
      ---- agregue esto para igualar el comportamiento del FACI039 pedio Josue/Diego
      SETITEM('P2986_S_PRECIO',
              V('P2986_S_PRECIO') + NVL(V('P2986_S_RECARGO'), 0));
      BEGIN
        FACI052.PP_BUSCAR_OFERTA;
      END;
      ---
    END IF;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      IF V('P2986_LIPR_NRO_LISTA_PRECIO') IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20010, V_MENSAJE);
      ELSE
        NULL; -- RAISE_APPLICATION_ERROR(-20010,'Articulo no esta habilitado en esta moneda '||V('P2986_MON_SIMBOLO')||'!.');
      END IF;
    
  END;

  PROCEDURE PP_BUSCAR_OFERTA IS
    V_PREC_OFER NUMBER := 0;
  BEGIN
    /* Busca precio de oferta del art?culo para el
    art?culo de detalle y la fecha de documento entre
    la fecha de inicio y fin de la oferta */
  
    SELECT OFER_PRECIO
      INTO V_PREC_OFER
      FROM FAC_OFERTA
     WHERE OFER_ART = V('P2986_DET_ART')
       AND V('P2986_DOC_FEC_DOC') BETWEEN OFER_FEC_INI AND OFER_FEC_FIN
       AND OFER_EMPR = V('P_EMPRESA');
  
    --*
    SETITEM('P2986_S_PRECIO', V_PREC_OFER);
  
    --*
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SETITEM('P2986_S_PRECIO', 0);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE);
  END;

  PROCEDURE PP_BUSCAR_EXISTENCIA IS
    C_VARIABLE  VARCHAR2(5000);
    C_VARIABLE1 VARCHAR2(5000);
  BEGIN
    SELECT SUM(ARDE_CANT_ACT)
      INTO C_VARIABLE
      FROM STK_ARTICULO_DEPOSITO
     WHERE ARDE_EMPR = V('P_EMPRESA')
       AND ARDE_SUC = V('P_SUCURSAL')
       AND ARDE_DEP = V('P2986_S_DEP')
       AND ARDE_ART = V('P2986_DET_ART');
  
    SETITEM('P2986_ARDE_CANT_ACT', C_VARIABLE);
  
    SELECT ARDE_UBIC
      INTO C_VARIABLE1
      FROM STK_ARTICULO_DEPOSITO
     WHERE ARDE_EMPR = V('P_EMPRESA')
       AND ARDE_SUC = V('P_SUCURSAL')
       AND ARDE_DEP = V('P2986_S_DEP')
       AND ARDE_ART = V('P2986_DET_ART');
  
    SETITEM('P2986_ARDE_UBIC', C_VARIABLE1);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SETITEM('P2986_ARDE_CANT_ACT', 0);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE || 'BUSCAR EXISTENCIA');
  END;

  PROCEDURE PP_BUSCAR_PED_SUC_IMP IS
    C_VARIABLE VARCHAR2(5000);
  BEGIN
    SELECT SUM(DPED_CANT_PED - DPED_CANT_REC)
      INTO C_VARIABLE
      FROM STK_PED_SUC_IMP, STK_PED_SUC_IMP_DET
     WHERE PED_NRO_PED = DPED_NRO_PED
       AND PED_EMPR = DPED_EMPR
       AND PED_EMPR = V('P_EMPRESA')
       AND PED_SUC_PED = V('P_SUCURSAL')
       AND PED_DEP_PED = V('P2986_S_DEP')
       AND DPED_ART = V('P2986_DET_ART');
  
    SETITEM('P2986_W_SALDO_PED_SUC_IMP', C_VARIABLE);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SETITEM('P2986_W_SALDO_PED_SUC_IMP', 0);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE || 'BUSCAR PED SUC IMP');
  END;

  PROCEDURE PP_BUSCAR_CANT_REMITIDO IS
    C_VARIABLE VARCHAR2(5000);
  BEGIN
    SELECT SUM(DETR_CANT_REM - DETR_CANT_FACT)
      INTO C_VARIABLE
      FROM STK_REMISION, STK_REMISION_DET
     WHERE REM_EMPR = DETR_EMPR
       AND REM_NRO = DETR_REM
       AND REM_EMPR = V('P_EMPRESA')
       AND REM_SUC = V('P_SUCURSAL')
       AND REM_DEP = V('P2986_S_DEP')
       AND DETR_ART = V('P2986_DET_ART');
  
    SETITEM('P2986_W_CANT_REM', C_VARIABLE);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SETITEM('P2986_W_CANT_REM', 0);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE || 'PP_BUSCAR_CANT_REMITIDO');
  END;

  PROCEDURE PP_BUSCAR_NRO_FACTURA IS
    C_VARIABLE  VARCHAR2(5000);
    C_VARIABLET VARCHAR2(5000);
    -- IP_MAQUINA VARCHAR2(500);
  BEGIN
  
    BEGIN
      C_VARIABLE := FL_OBTENER_ULT_NRO(I_TIPO_MOV  => V('P2986_DOC_TIPO_MOV'),
                                       I_IMPRESORA => CHR(39) ||
                                                      V('P0_IP_MAQUINA') ||
                                                      CHR(39),
                                       I_EMPRESA   => V('P_EMPRESA'));
    END;
  
    --RAISE_APPLICATION_ERROR(-20010,'C_VARIABLE: '||C_VARIABLE);
  
    SETITEM('P2986_DOC_NRO_DOC', C_VARIABLE);
  
    GEN_EXEC_SELECT('SELECT IMP_NRO_TIMBRADO FROM GEN_IMPRESORA WHERE IMP_EMPR = ' ||
                    V('P_EMPRESA') || ' AND IMPR_IP = ' || CHR(39) ||
                    V('P0_IP_MAQUINA') || CHR(39),
                    C_VARIABLET);
  
    /*SELECT N.IMP_NRO_TIMBRADO INTO C_VARIABLET FROM GEN_IMPRESORA N
    WHERE N.IMP_EMPR = V('P_EMPRESA') AND N.IMPR_IP = CHR(39)||V('P0_IP_MAQUINA')||CHR(39);*/
  
    SETITEM('P2986_DOC_TIMBRADO', C_VARIABLET);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Primero debe ingresar un registro para la impresora o IP!');
  END;

  PROCEDURE PP_DESHABILITAR_TASA IS
    V_IND VARCHAR2(1);
  BEGIN
    SELECT NVL(OPEM_MOD_TASA, 'N')
      INTO V_IND
      FROM GEN_OPERADOR, GEN_OPERADOR_EMPRESA B
     WHERE OPER_CODIGO = OPEM_OPER
       AND OPER_LOGIN = USER
       AND B.OPEM_EMPR = V('P_EMPRESA');
  
    IF V_IND = 'S' THEN
    
      /*UPDATE WWV_FLOW_STEP_ITEMS
        SET TAG_ATTRIBUTES = TAG_ATTRIBUTES || ' enabled '
      WHERE FLOW_ID = V('APP_ID')
        AND FLOW_STEP_ID = V('APP_PAGE_ID')
        AND NAME IN ('P2986_W_DOC_TASA_US');*/
      NULL;
    
    ELSE
    
      /*UPDATE WWV_FLOW_STEP_ITEMS
             SET TAG_ATTRIBUTES = TAG_ATTRIBUTES || ' disabled '
           WHERE FLOW_ID = V('APP_ID')
             AND FLOW_STEP_ID = V('APP_PAGE_ID')
             AND NAME IN ('P2986_W_DOC_TASA_US');
      */
      NULL;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'ERROR: PP_DESHABILITAR_TASA. ' || SQLERRM);
  END PP_DESHABILITAR_TASA;

  PROCEDURE PP_CTRL_LIM_CR IS
    V_FEC_GRAB DATE;
  BEGIN
  
    SELECT HOL_FEC_GRAB_LIM_CR
      INTO V_FEC_GRAB
      FROM FIN_FICHA_HOLDING
     WHERE HOL_CODIGO = (SELECT C.CLI_COD_FICHA_HOLDING
                           FROM FIN_CLIENTE C
                          WHERE C.CLI_CODIGO = V('P2986_DOC_CLI')
                            AND CLI_EMPR = V('P_EMPRESA'))
       AND HOL_EMPR = V('P_EMPRESA');
  
    IF TO_CHAR(SYSDATE, 'DD/MM/YYYY') <> TO_CHAR(V_FEC_GRAB, 'DD/MM/YYYY') THEN
      FIN_BLOQ_FAC_CR(V('P2986_DOC_CLI'), V('P_EMPRESA'));
    END IF;
  
  END;

  PROCEDURE PP_VALIDAR_LISTA_PRECIOS IS
  BEGIN
    IF V('P2986_CONF_IND_MODIFICAR_PRECIO') = 'N' THEN
      IF V('P2986_LIPR_NRO_LISTA_PRECIO') IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010, 'No puede quedar en blanco!');
      ELSE
        FACI052.PP_VALIDAR_LISTA_PRECIO;
      END IF;
    ELSE
      IF V('P2986_LIPR_NRO_LISTA_PRECIO') IS NOT NULL THEN
        FACI052.PP_VALIDAR_LISTA_PRECIO;
      END IF;
    END IF;
  
  END;

  PROCEDURE PP_VALIDAR_LISTA_PRECIO IS
  
    V_LIS_MON NUMBER;
  
  BEGIN
    SELECT LIPE_MON
      INTO V_LIS_MON
      FROM FAC_LISTA_PRECIO
     WHERE LIPE_EMPR = V('P_EMPRESA')
       AND LIPE_NRO_LISTA_PRECIO = V('P2986_LIPR_NRO_LISTA_PRECIO');
  
    IF V_LIS_MON <> V('P2986_DOC_MON') THEN
    
      --      SETITEM('P2986_RETORNO_VALIDAR3_MON',1);
      /*
      RAISE_APPLICATION_ERROR(-20010,
                              'La moneda de la lista de precio ' ||
                              V('P2986_LIPR_NRO_LISTA_PRECIO') ||
                              ' es distinta a la moneda de la factura!.');
                             */
      --Swal.fire('La moneda de la lista de precio '+apex.item( "P2986_LIPR_NRO_LISTA_PRECIO" ).getValue()+' es distinta a la moneda de la factura!.');
      /*
      APEX_ERROR.ADD_ERROR(
      p_message            =>'La moneda de la lista de precio '|| V('P2986_LIPR_NRO_LISTA_PRECIO')||
                              ' es distinta a la moneda de la factura!.',
      p_display_location   => apex_error.c_inline_in_notification );
      */
    
      NULL;
    
    END IF;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'Lista de Precios Inexistente!.');
    
  END;

  PROCEDURE PP_VALIDAR_RUC(P_VALOR OUT NUMBER) IS
  BEGIN
    IF V('P2986_DOC_CLI_RUC') IS NOT NULL THEN
    
      IF NOT FL_RUC_VALIDO(V('P2986_DOC_CLI_RUC')) THEN
        P_VALOR := 1;
      END IF;
    END IF;
  
  END;

  PROCEDURE PP_VALIDA_PLAZO IS
  
    V_PLAZO NUMBER := 0;
  
  BEGIN
  
    SELECT HOL_DIAS_PLAZO_PAGO
      INTO V_PLAZO
      FROM FIN_FICHA_HOLDING
     WHERE HOL_CODIGO = (SELECT C.CLI_COD_FICHA_HOLDING
                           FROM FIN_CLIENTE C
                          WHERE C.CLI_CODIGO = V('P2986_DOC_CLI')
                            AND CLI_EMPR = V('P_EMPRESA'))
       AND HOL_EMPR = V('P_EMPRESA');
  
    IF V('P2986_S_PLAZO_PAGO') IS NULL THEN
      SETITEM('P2986_S_PLAZO_PAGO', 0);
    ELSE
      IF V_PLAZO < V('P2986_S_PLAZO_PAGO') THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'El valor ingresado es mayor al plazo de pago!' ||
                                TO_CHAR(V_PLAZO) || ' DIAS ');
      END IF;
    END IF;
  
  END;

  PROCEDURE PP_VALIDAR_REMI IS
    C_VARIABLE  NUMBER;
    C_VARIABLE1 VARCHAR2(500);
  BEGIN
    --
    IF V('P2986_DET_NRO_REMIS') IS NOT NULL THEN
    
      SELECT 0, REM_FEC_EMIS
        INTO C_VARIABLE, C_VARIABLE1
        FROM STK_REMISION
       WHERE REM_EMPR = V('P_EMPRESA')
         AND REM_NRO = V('P2986_DET_NRO_REMIS')
         AND REM_SUC = V('P_SUCURSAL')
         AND REM_DEP = V('P2986_S_DEP')
         AND (REM_CLI = V('P2986_DOC_CLI') OR REM_CLI IS NULL);
    
    END IF;
  
    SETITEM('P2986_FECHA_REMISION', C_VARIABLE1);
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'N?mero de remisi?n inexistente o no pertenece a la empresa/sucursal/deposito/cliente ingresados!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE || ' PP_VALIDAR_REMI ');
  END;

  PROCEDURE PP_VALIDAR_REMI_DET IS
    V_CANT_REM  NUMBER := 0;
    V_CANT_FACT NUMBER := 0;
    V_SALD_REM  NUMBER := 0;
    --
  BEGIN
    SELECT DETR_CANT_REM, DETR_CANT_FACT
      INTO V_CANT_REM, V_CANT_FACT
      FROM STK_REMISION_DET
     WHERE DETR_EMPR = V('P_EMPRESA')
       AND DETR_REM = V('P2986_DET_NRO_REMIS')
       AND DETR_ART = V('P2986_DET_ART');
    --
    V_SALD_REM := V_CANT_REM - V_CANT_FACT;
    IF V_SALD_REM < V('P2986_DET_CANT') THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'El saldo del articulo en la remision es de : ' ||
                              TO_CHAR(V_SALD_REM));
    END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'Detalle de remision inexistente!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE || ' VALIDAR REMI DET');
  END;

  PROCEDURE PP_VALIDAR_CHEQ_DIF IS
  
    V_SUM_CHEQ_DIF NUMBER := 0;
    C_VARIABLE     NUMBER;
    C_VARIABLE1    NUMBER;
    C_VARIABLE2    NUMBER;
    C_VARIABLE3    NUMBER;
    C_VARIABLE4    NUMBER;
  
  BEGIN
  
    C_VARIABLE  := V('P2986_W_IMP_LIM_CR_EMPR');
    C_VARIABLE1 := V('P2986_W_IMP_LIM_CR_DISP_GRUPO');
    C_VARIABLE2 := V('P2986_W_IMP_LIM_CR_DISP_EMPR');
    C_VARIABLE3 := V('P2986_W_IMP_CHEQ_DIFERIDO');
    C_VARIABLE4 := V('P2986_W_IMP_CHEQ_RECHAZADO');
  
    IF TO_DATE(V('P3000_CHEQ_FEC_DEPOSITAR'), 'dd/mm/yyyy') <>
       TO_DATE(SYSDATE, 'dd/mm/yyyy') THEN
      V_SUM_CHEQ_DIF := V_SUM_CHEQ_DIF + V('P3000_CHEQ_IMPORTE_LOC');
    END IF;
  
    IF V_SUM_CHEQ_DIF > 0 THEN
      --Consultamos el limite de credito
      FIN_LIM_CREDITO(V('P2986_DOC_FEC_DOC'),
                      V('P2986_DOC_CLI'),
                      C_VARIABLE,
                      V('P_EMPRESA'),
                      C_VARIABLE1,
                      C_VARIABLE2,
                      C_VARIABLE3,
                      C_VARIABLE4);
    
      SETITEM('P2986_W_IMP_LIM_CR_EMPR', C_VARIABLE);
      SETITEM('P2986_W_IMP_LIM_CR_DISP_GRUPO', C_VARIABLE1);
      SETITEM('P2986_W_IMP_LIM_CR_DISP_EMPR', C_VARIABLE2);
      SETITEM('P2986_W_IMP_CHEQ_DIFERIDO', C_VARIABLE3);
      SETITEM('P2986_W_IMP_CHEQ_RECHAZADO', C_VARIABLE4);
    
      --Restamos los intereses de las cuotas vencidas.
      SETITEM('P2986_W_IMP_LIM_CR_DISP_EMPR',
              (V('P2986_W_IMP_LIM_CR_DISP_EMPR') -
              FIN_INTERES_FACTURA(V('P2986_DOC_CLI'), V('P_EMPRESA'))));
    
      --Validar cobros con cheques diferidos que superen el limite de credito disponible para facturas para el cliente.
      IF V_SUM_CHEQ_DIF > V('P2986_W_IMP_LIM_CR_DISP_EMPR') THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Total cobro cheque diferido: ' ||
                                V_SUM_CHEQ_DIF ||
                                ' ,supera el limite de cr?dito disponible: ' ||
                                V('P2986_W_IMP_LIM_CR_DISP_EMPR'));
      END IF;
    END IF;
  END;

  PROCEDURE PP_VALIDAR_CHEQREC IS
  BEGIN
    --Primero se busca en la tabla temporal de cheques
    FOR R IN (SELECT 1
                FROM FIN_PLCO_CHEQUES
               WHERE PLCH_BCO = V('P3000_W_CHEQ_BCO')
                 AND PLCH_SERIE = V('P3000_CHEQ_SERIE')
                 AND PLCH_NRO = V('P3000_CHEQ_NRO')
                 AND PLCH_EMPR = V('P_EMPRESA')) LOOP
      RAISE_APPLICATION_ERROR(-20010,
                              'El cheque ya ha sido cargado para esta rendici?n.');
    END LOOP;
    --Luego en la tabla de cheques
    FOR R IN (SELECT 1
                FROM FIN_CHEQUE
               WHERE CHEQ_BCO = V('P3000_W_CHEQ_BCO')
                 AND CHEQ_SERIE = V('P3000_CHEQ_SERIE')
                 AND CHEQ_NRO = V('P3000_CHEQ_NRO')
                 AND CHEQ_EMPR = V('P_EMPRESA')) LOOP
      RAISE_APPLICATION_ERROR(-20010, 'El cheque ya existe.');
    END LOOP;
  
  END;

  PROCEDURE PP_VALIDAR_REMI_DET_ACUM IS
    V_CANT_REM  NUMBER := 0;
    V_CANT_FACT NUMBER := 0;
    V_SALD_REM  NUMBER := 0;
    V_CANT      NUMBER := 0;
  
    CURSOR CONTROL_DETALLES_REMISION IS
      SELECT SEQ_ID ITEM,
             C001 UNIDAD_VTA,
             C002 ARTICULO,
             TO_NUMBER(C003) NRO_REMISION,
             TO_NUMBER(C004) CANTIDAD,
             TO_NUMBER(C005) PRECIO,
             TO_NUMBER(C007) PESO_UNIDAD,
             TO_NUMBER(C008) PESO_TONELADA
        FROM APEX_COLLECTIONS A
       WHERE A.COLLECTION_NAME = 'DETALLES_FACI052';
  
  BEGIN
  
    FOR I IN CONTROL_DETALLES_REMISION LOOP
    
      IF I.NRO_REMISION IS NOT NULL THEN
      
        V_CANT := V_CANT + I.CANTIDAD;
      
        SELECT DETR_CANT_REM, DETR_CANT_FACT
          INTO V_CANT_REM, V_CANT_FACT
          FROM STK_REMISION_DET
         WHERE DETR_EMPR = V('P_EMPRESA')
           AND DETR_REM = I.NRO_REMISION
           AND DETR_ART = I.ARTICULO;
      
        V_SALD_REM := V_CANT_REM - V_CANT_FACT;
      
        IF V_SALD_REM < V_CANT THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'El saldo del art?culo en la remisi?n es de: ' ||
                                  TO_CHAR(V_SALD_REM) || ' REMISION NRO: ' ||
                                  I.NRO_REMISION);
        END IF;
      END IF;
    
    END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE);
  END;

  PROCEDURE PP_VALIDAR_DETA IS
  
    CURSOR CONTROL_DETALLES_DET IS
      SELECT SEQ_ID ITEM,
             C001 UNIDAD_VTA,
             C002 ARTICULO,
             TO_NUMBER(C003) NRO_REMISION,
             TO_NUMBER(C004) CANTIDAD,
             TO_NUMBER(C005) PRECIO,
             TO_NUMBER(C007) PESO_UNIDAD,
             TO_NUMBER(C008) PESO_TONELADA
        FROM APEX_COLLECTIONS A
       WHERE A.COLLECTION_NAME = 'DETALLES_FACI052';
  BEGIN
  
    FOR I IN CONTROL_DETALLES_DET LOOP
    
      IF V('P2986_ART_IND_ANIMAL') = 'S' THEN
        IF I.PESO_UNIDAD IS NULL OR I.PESO_TONELADA IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'Primero debe asignar el Peso Vivo al Art. Cod. ' ||
                                  I.ARTICULO || '!');
        END IF;
      END IF;
    
    END LOOP;
  
  END;

  PROCEDURE PP_VALIDAR_VENCIMIENTOS(V_MAX_DIAS_ATRASO IN NUMBER,
                                    VALIDAR           IN VARCHAR2,
                                    VALOR             OUT NUMBER) IS
    V_CANT_DIAS NUMBER;
  BEGIN
    V_CANT_DIAS := FP_DIAS_DE_ATRASO;
  
    IF V_CANT_DIAS > V_MAX_DIAS_ATRASO THEN
      IF VALIDAR = 'VALIDAR' THEN
        VALOR := TO_CHAR(V_CANT_DIAS);
      ELSE
        VALOR := 1;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
  END;

  PROCEDURE PP_VALIDAR_MONEDA IS
  
  BEGIN
  
    IF V('P2986_DOC_MON') NOT IN (V('P_MON_LOC'), V('P_MON_US')) THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Debe ser: ' || TO_CHAR(V('P_MON_LOC')) ||
                              ' o ' || TO_CHAR(V('P_MON_US')));
    END IF;
  
    IF V('P2986_S_TIPO_FACTURA') = 1 OR V('P2986_S_TIPO_FACTURA') = 3 THEN
      NULL;
    ELSE
    
      DECLARE
        V_MAX_DIAS_ATRASO NUMBER;
        C_VARIABLE        NUMBER;
        C_VARIABLE1       NUMBER := 0;
      BEGIN
        /* Ver si existe una autorizacion especial en la fecha para el limite de credito del cliente */
      
        SELECT SUM(AUES_IMP), NVL(MAX(AUES_MAX_DIAS_ATRASO), 0)
          INTO C_VARIABLE, V_MAX_DIAS_ATRASO
          FROM FIN_AUTORIZ_ESPEC
         WHERE AUES_CLI = V('P2986_DOC_CLI')
           AND AUES_FEC_AUTORIZ =
               TO_DATE(V('P2986_DOC_FEC_DOC'), 'DD/MM/YYYY')
           AND AUES_MON = V('P2986_DOC_MON')
           AND AUES_UTILIZADA = 'N'
           AND AUES_EMPR = V('P_EMPRESA');
      
        SETITEM('P2986_W_LIM_CR_ESPECIAL', C_VARIABLE);
      
        IF V('P2986_W_CLI_MAX_DIAS_ATRASO') > V_MAX_DIAS_ATRASO THEN
          V_MAX_DIAS_ATRASO := V('P2986_W_CLI_MAX_DIAS_ATRASO');
        ELSE
          SETITEM('P2986_W_CLI_MAX_DIAS_ATRASO', V_MAX_DIAS_ATRASO);
        END IF;
      
        IF V('P2986_S_TIPO_FACTURA') = 2 THEN
          -- si es factura credito
          --RAISE_APPLICATION_ERROR(-20010, 'V_MAX_DIAS_ATRASO: '||V_MAX_DIAS_ATRASO);
        
          PP_VALIDAR_VENCIMIENTOS(NVL(V_MAX_DIAS_ATRASO, 0),
                                  'VALIDAR',
                                  C_VARIABLE1);
        ELSE
          PP_VALIDAR_VENCIMIENTOS(NVL(V_MAX_DIAS_ATRASO, 0),
                                  'NO VALIDAR',
                                  C_VARIABLE1);
        END IF;
      
        SETITEM('P2986_RETORNO_VALIDAR_MON', C_VARIABLE1);
      
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
        WHEN TOO_MANY_ROWS THEN
          NULL;
      END;
    END IF;
  
    BEGIN
      FACI052.PP_BUSCAR_DESCUENTO_PLAZOPAGO;
    END;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'ERROR EN VALIDAR MONEDA PACKAGE' || SQLCODE ||
                              SQLERRM);
  END;

  PROCEDURE PP_CARGAR_DATOS_FLETE IS
  
    C_VARIABLE  VARCHAR2(500);
    C_VARIABLE1 VARCHAR2(500);
  BEGIN
  
    --SETITEM('P2986_S_UNIDAD_VTA', 'U');
  
    SELECT S.ART_CODIGO, S.ART_DESC
      INTO C_VARIABLE, C_VARIABLE1
      FROM STK_ARTICULO S
     WHERE S.ART_CODIGO = V('P2986_PROF_ARTIC_FLETE')
       AND ART_EMPR = V('P_EMPRESA');
  
    SETITEM('P2986_S_UNIDAD_VTA', 'U');
  
    SETITEM('P2986_S_ART', C_VARIABLE);
  
    SETITEM('P2986_D_ART_COD', C_VARIABLE);
    SETITEM('P2986_D_ART_DESC', C_VARIABLE1);
  
    SETITEM('P2986_DET_CANT', V('P2986_W_TOTAL_KG'));
    SETITEM('P2986_S_PRECIO', V('P2986_PROF_PREC_FLETE'));
    SETITEM('P2986_S_TOTAL',
            (NVL(V('P2986_DET_CANT_KILOS'), 0) * V('P2986_PROF_PREC_FLETE')));
  
    /*
    RAISE_APPLICATION_ERROR(-20010,'P2986_S_UNIDAD_VTA ='||V('P2986_S_UNIDAD_VTA')||';'||
                                   'P2986_D_ART_DESC ='||V('P2986_D_ART_DESC')||';'||
                                   'P2986_DET_CANT ='||V('P2986_DET_CANT')||';'||
                                   'P2986_S_PRECIO ='||V('P2986_S_PRECIO')||';'||
                                   'P2986_S_TOTAL'||V('P2986_S_TOTAL')
                            );
                            */
  
  END;

  PROCEDURE PP_CARGAR_EXISTENCIAS IS
  
    -- cursor para mostrar la cantidad existente por cada deposito
    CURSOR EXIST_CUR IS
      SELECT ARDE_EMPR,
             ARDE_SUC,
             ARDE_DEP,
             ARDE_CANT_ACT,
             EMPR_RAZON_SOCIAL,
             SUC_DESC
        FROM GEN_EMPRESA, GEN_SUCURSAL, STK_ARTICULO_DEPOSITO
       WHERE EMPR_CODIGO = ARDE_EMPR
         AND SUC_EMPR = ARDE_EMPR
         AND SUC_CODIGO = ARDE_SUC
         AND ARDE_EMPR = V('P2986_S_DEP')
         AND ARDE_ART = V('P2986_DET_ART')
         AND EMPR_CODIGO = V('P_EMPRESA')
       ORDER BY 1, 2, 3;
  
    -- cursor para mostrar la cantidad remitida por empresa,suc,dep
    CURSOR REMI_CUR IS
      SELECT REM_EMPR,
             REM_SUC,
             REM_DEP,
             SUM(DETR_CANT_REM - DETR_CANT_FACT) CANT_REM
        FROM STK_REMISION, STK_REMISION_DET
       WHERE REM_EMPR = DETR_EMPR
         AND REM_NRO = DETR_REM
         AND DETR_ART = V('P2986_DET_ART')
         AND REM_EMPR = V('P_EMPRESA')
       GROUP BY REM_EMPR, REM_SUC, REM_DEP
      HAVING SUM(DETR_CANT_REM - DETR_CANT_FACT) > 0;
  
    -- cursor para mostrar la cantidad pedida por empresa,suc,dep
    CURSOR PED_CUR IS
      SELECT PED_EMPR,
             PED_SUC_PED,
             PED_DEP_PED,
             SUM(DPED_CANT_PED - DPED_CANT_REC) CANT_PED
        FROM STK_PED_SUC_IMP, STK_PED_SUC_IMP_DET
       WHERE PED_NRO_PED = DPED_NRO_PED
         AND DPED_ART = V('P2986_DET_ART')
         AND DPED_EMPR = PED_EMPR
         AND DPED_EMPR = V('P_EMPRESA')
       GROUP BY PED_EMPR, PED_SUC_PED, PED_DEP_PED
      HAVING SUM(DPED_CANT_PED - DPED_CANT_REC) > 0;
  
  BEGIN
    FOR REXIS IN EXIST_CUR LOOP
    
      SETITEM('P2986_W_EMPR', REXIS.ARDE_EMPR);
      --SETITEM('P2986_EMPR_DESC', SUBSTR(REXIS.EMPR_RAZON_SOCIAL, 1, LONG));
      SETITEM('P2986_W_SUC', REXIS.ARDE_SUC);
      SETITEM('P2986_SUC_DESC', REXIS.SUC_DESC);
      SETITEM('P2986_BX_S_DEP', REXIS.ARDE_DEP);
      SETITEM('P2986_S_EXISTENCIA', REXIS.ARDE_CANT_ACT);
      SETITEM('P2986_S_MAX_FACTURAR', REXIS.ARDE_CANT_ACT);
    
    END LOOP;
  
    --agregar cantidad remitida por empr,suc,dep al bloque :BEXIS
    FOR RREM IN REMI_CUR LOOP
      --para cada registro de remision buscar su registro en :BEXIS
      IF V('P2986_W_EMPR') = RREM.REM_EMPR AND
         V('P2986_W_SUC') = RREM.REM_SUC AND
         V('P2986_BX_S_DEP') = RREM.REM_DEP THEN
        SETITEM('P2986_S_REMITIDO', RREM.CANT_REM);
        SETITEM('P2986_S_MAX_FACTURAR',
                (V('P2986_S_MAX_FACTURAR') - RREM.CANT_REM));
      END IF;
    END LOOP;
  
    --agregar cantidad pedida por empr,suc,dep al bloque :BEXIS
    FOR RPED IN PED_CUR LOOP
      --para cada registro de pedido buscar su registro en :BEXIS
      IF V('P2986_W_EMPR') = RPED.PED_EMPR AND
         V('P2986_W_SUC') = RPED.PED_SUC_PED AND
         V('P2986_BX_S_DEP') = RPED.PED_DEP_PED THEN
        SETITEM('P2986_BX_S_PEDIDO', RPED.CANT_PED);
        SETITEM('P2986_S_MAX_FACTURAR',
                (V('P2986_S_MAX_FACTURAR') + RPED.CANT_PED));
      END IF;
    
    END LOOP;
  END;

  PROCEDURE PP_CARGAR_CANT_KILOS IS
    V_CANT_KILOS NUMBER;
  BEGIN
  
    IF V('P2986_DET_ART') = V('P2986_PROF_ARTIC_FLETE') THEN
      SETITEM('P2986_S_PRECIO', V('P2986_PROF_PREC_FLETE'));
      --NULL;
    ELSE
    
      SELECT NVL(S.ART_KG_CONTENIDO, 1)
        INTO V_CANT_KILOS
        FROM STK_ARTICULO S
       WHERE S.ART_CODIGO = V('P2986_DET_ART')
         AND ART_EMPR = V('P_EMPRESA');
    
      IF V('P2986_S_UNIDAD_VTA') = 'U' THEN
        SETITEM('P2986_DET_CANT_KILOS', V('P2986_DET_CANT') * V_CANT_KILOS);
      ELSE
        SETITEM('P2986_DET_CANT_KILOS', V('P2986_DET_CANT'));
      END IF;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
  END;

  PROCEDURE PP_CARGAR_DATOS IS
  
    V_PER_ACT            NUMBER; -- codigo del periodo actual del sistema de stock
    V_PER_SGTE           NUMBER; -- codigo del periodo sig. del sist.de stock
    C_VARIABLE_GANADERIA VARCHAR2(2);
  
  BEGIN
  
    SETITEM('P2986_W_IND_LISTVAL', 'N');
    SETITEM('P2986_IND_TRAER_PRESUPUESTO', 'S');
  
    DECLARE
      P_IND_SUCURSAL VARCHAR2(50);
    BEGIN
    
      SELECT CONF_IND_SUC
        INTO P_IND_SUCURSAL
        FROM GEN_CONFIGURACION
       WHERE CONF_EMPR = V('P_EMPRESA');
    
      SETITEM('P2986_P_IND_SUCURSAL', P_IND_SUCURSAL);
    
    END;
  
    DECLARE
      P_IND_OPERADOR VARCHAR2(20);
    BEGIN
      SELECT CONF_IND_OPERADOR
        INTO P_IND_OPERADOR
        FROM GEN_CONFIGURACION
       WHERE CONF_EMPR = V('P_EMPRESA');
    
      SETITEM('P0_P_IND_OPERADOR', P_IND_OPERADOR);
    END;
  
    DECLARE
      CONF_VARIABLE1  VARCHAR2(2000);
      CONF_VARIABLE2  VARCHAR2(2000);
      CONF_VARIABLE3  VARCHAR2(2000);
      CONF_VARIABLE4  VARCHAR2(2000);
      CONF_VARIABLE5  VARCHAR2(2000);
      CONF_VARIABLE6  VARCHAR2(2000);
      CONF_VARIABLE7  VARCHAR2(2000);
      CONF_VARIABLE8  VARCHAR2(2000);
      CONF_VARIABLE9  VARCHAR2(2000);
      CONF_VARIABLE10 VARCHAR2(2000);
      CONF_VARIABLE11 VARCHAR2(2000);
      CONF_VARIABLE12 VARCHAR2(2000);
      CONF_VARIABLE13 VARCHAR2(2000);
      CONF_VARIABLE14 VARCHAR2(2000);
      CONF_VARIABLE15 VARCHAR2(2000);
      CONF_VARIABLE16 VARCHAR2(2000);
      CONF_VARIABLE17 VARCHAR2(2000);
      CONF_VARIABLE18 VARCHAR2(2000);
    BEGIN
    
      SELECT CONF_PERIODO,
             CONF_IVA,
             CONF_FACT_CERO,
             CONF_ACT_STK,
             CONF_IMPR,
             
             CONF_COD_FAC_CONT,
             CONF_COD_FAC_CRED,
             CONF_CONC_VTA_MERC,
             
             CONF_CONC_VTA_EXPORT,
             CONF_CONC_VTA_SERV,
             CONF_CONC_DEV,
             CONF_CONC_IMPU_VTA,
             CONF_CONC_IMPU_DEV,
             CONF_CATEG_CLI_ESPORADICO,
             CONF_IND_CUOTA_AUTOMATICA,
             CONF_IND_MODIFICAR_PRECIO,
             CONF_MAX_ITEMS_FAC_CO,
             CONF_MAX_ITEMS_FAC_CR
        INTO CONF_VARIABLE1,
             CONF_VARIABLE2,
             CONF_VARIABLE3,
             CONF_VARIABLE4,
             CONF_VARIABLE5,
             CONF_VARIABLE6,
             CONF_VARIABLE7,
             CONF_VARIABLE8,
             CONF_VARIABLE9,
             CONF_VARIABLE10,
             CONF_VARIABLE11,
             CONF_VARIABLE12,
             CONF_VARIABLE13,
             CONF_VARIABLE14,
             CONF_VARIABLE15,
             CONF_VARIABLE16,
             CONF_VARIABLE17,
             CONF_VARIABLE18
        FROM FAC_CONFIGURACION
       WHERE CONF_EMPR = V('P_EMPRESA');
    
      SETITEM('P2986_CONF_PERIODO', CONF_VARIABLE1);
      SETITEM('P2986_CONF_IVA', CONF_VARIABLE2);
      SETITEM('P2986_CONF_FACT_CERO', CONF_VARIABLE3);
      SETITEM('P2986_CONF_ACT_STK', CONF_VARIABLE4);
      SETITEM('P2986_CONF_IMPR', CONF_VARIABLE5);
      SETITEM('P2986_CONF_COD_FAC_CONT', CONF_VARIABLE6);
      SETITEM('P2986_CONF_COD_FAC_CRED', CONF_VARIABLE7);
      SETITEM('P2986_CONF_CONC_VTA_MERC', CONF_VARIABLE8);
      SETITEM('P2986_CONF_CONC_VTA_EXPORT', CONF_VARIABLE9);
      SETITEM('P2986_CONF_CONC_VTA_SERV', CONF_VARIABLE10);
      SETITEM('P2986_CONF_CONC_DEV', CONF_VARIABLE11);
      SETITEM('P2986_CONF_CONC_IMPU_VTA', CONF_VARIABLE12);
      SETITEM('P2986_CONF_CONC_IMPU_DEV', CONF_VARIABLE13);
      SETITEM('P2986_CONF_CATEG_CLI_ESPO', CONF_VARIABLE14);
      SETITEM('P2986_CONF_IND_CUOTA_AUTOMATICA', CONF_VARIABLE15);
      SETITEM('P2986_CONF_IND_MODIFICAR_PRECIO', CONF_VARIABLE16);
      SETITEM('P2986_P_MAX_ITEMS_FAC_CO', CONF_VARIABLE17);
      SETITEM('P2986_P_MAX_ITEMS_FAC_CR', CONF_VARIABLE18);
      --RAISE_APPLICATION_ERROR(-20010,  V('P2986_CONF_CONC_VTA_EXPORT'));
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'No fue cargada la tabla de configuracion del sistema de facturaci?n!.');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010,
                                SQLCODE || 'Error al cargar datos' ||
                                SQLERRM);
    END;
  
    ----
    -------------------------------------------------
    IF V('P2986_CONF_CONC_VTA_EXPORT') IS NULL AND V('P_EMPRESA') = 1 THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Concepto para Exportacion no esta configurado, acceda a 3-1-40 Configuracion del Sistema!');
    
    ELSIF V('P2986_CONF_CONC_VTA_EXPORT') IS NOT NULL AND
          V('P_EMPRESA') = 1 THEN
    
      DECLARE
        V_CTA_CONT  NUMBER;
        V_CONC_DESC VARCHAR2(60);
      BEGIN
      
        SELECT FCON_CLAVE_CTACO, FCON_DESC
          INTO V_CTA_CONT, V_CONC_DESC
          FROM FIN_CONCEPTO
         WHERE FCON_CLAVE = V('P2986_CONF_CONC_VTA_EXPORT')
           AND FCON_EMPR = V('P_EMPRESA');
        /*
        RAISE_APPLICATION_ERROR(-20010,
                              'LA CUENTA ' || V_CTA_CONT ||
                              ' no tiene asignado una Cta Contable!!');*/
      
        IF V_CTA_CONT IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'El concepto ' || V_CONC_DESC ||
                                  ' no tiene asignado una Cta Contable!!');
        END IF;
      
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'Cta Contable no encontrada para Concepto de Exportacion!');
      END;
    
    END IF;
    -------------------------------------------------
    DECLARE
      C_VARIABLE_SUC  VARCHAR2(2000);
      C_VARIABLE_SUC1 VARCHAR2(2000);
      C_VARIABLE_SUC2 VARCHAR2(2000);
      C_VARIABLE_SUC3 VARCHAR2(2000);
      C_VARIABLE_SUC4 VARCHAR2(2000);
      --C_VARIABLE_SUC5 VARCHAR2(2000);
    BEGIN
    
      /*SELECT SUC_CTA_MERC_CONT,
            SUC_CTA_MERC_CRED,
            SUC_CTA_IMPU,
            SUC_CTA_MERC_CONT_EX,
            SUC_CTA_MERC_CRED_EX,
            SUC_LOCALIDAD
       INTO C_VARIABLE_SUC,
            C_VARIABLE_SUC1,
            C_VARIABLE_SUC2,
            C_VARIABLE_SUC3,
            C_VARIABLE_SUC4,
            C_VARIABLE_SUC5
       FROM GEN_SUCURSAL
      WHERE SUC_EMPR = V('P_EMPRESA')
        AND SUC_CODIGO = V('P_SUCURSAL');*/
      /*
      SELECT A.CONF_CONC_VTA_MERC,
             A.CONF_CONC_VTA_MERC,
             A.CONF_CONC_IMPU_VTA,
             A.CONF_CONC_VTA_MERC,
             A.CONF_CONC_VTA_MERC
        INTO C_VARIABLE_SUC,
             C_VARIABLE_SUC1,
             C_VARIABLE_SUC2,
             C_VARIABLE_SUC3,
             C_VARIABLE_SUC4
        FROM FAC_CONFIGURACION A
       WHERE A.CONF_EMPR = V('P_EMPRESA');
       */
      SELECT FCON_CLAVE_CTACO
        INTO C_VARIABLE_SUC
        FROM FIN_CONCEPTO
       WHERE FCON_EMPR = V('P_EMPRESA')
         AND FCON_CLAVE = V('P2986_CONF_CONC_VTA_MERC');
    
      SELECT FCON_CLAVE_CTACO
        INTO C_VARIABLE_SUC1
        FROM FIN_CONCEPTO
       WHERE FCON_EMPR = V('P_EMPRESA')
         AND FCON_CLAVE = V('P2986_CONF_CONC_VTA_MERC');
    
      SELECT FCON_CLAVE_CTACO
        INTO C_VARIABLE_SUC2
        FROM FIN_CONCEPTO
       WHERE FCON_EMPR = V('P_EMPRESA')
         AND FCON_CLAVE = V('P2986_CONF_CONC_IMPU_VTA');
    
      SELECT FCON_CLAVE_CTACO
        INTO C_VARIABLE_SUC3
        FROM FIN_CONCEPTO
       WHERE FCON_EMPR = V('P_EMPRESA')
         AND FCON_CLAVE = V('P2986_CONF_CONC_VTA_MERC');
    
      SELECT FCON_CLAVE_CTACO
        INTO C_VARIABLE_SUC4
        FROM FIN_CONCEPTO
       WHERE FCON_EMPR = V('P_EMPRESA')
         AND FCON_CLAVE = V('P2986_CONF_CONC_VTA_MERC');
    
      SETITEM('P2986_W_CTA_MERC_CONT', C_VARIABLE_SUC);
      SETITEM('P2986_W_CTA_MERC_CRED', C_VARIABLE_SUC1);
      SETITEM('P2986_W_CTA_IMPU', C_VARIABLE_SUC2);
      SETITEM('P2986_W_CTA_MERC_CONT_EX', C_VARIABLE_SUC3);
      SETITEM('P2986_W_CTA_MERC_CRED_EX', C_VARIABLE_SUC4);
      --SETITEM('P2986_P_SUC_LOCALIDAD', C_VARIABLE_SUC5);
      --RAISE_APPLICATION_ERROR(-20010,  V('P2986_W_CTA_MERC_CONT'));
    
      IF V('P2986_W_CTA_MERC_CONT') IS NULL OR
         V('P2986_W_CTA_MERC_CONT_EX') IS NULL OR
         V('P2986_W_CTA_MERC_CRED') IS NULL OR
         V('P2986_W_CTA_MERC_CRED_EX') IS NULL OR
         V('P2986_W_CTA_IMPU') IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Primero debe definir las cuentas contables de ventas en mantenimiento de sucursales!');
      END IF;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'No fue cargada la tabla de sucursales!.');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010, V('P2986_W_CTA_MERC_CONT'));
        RAISE_APPLICATION_ERROR(-20010,
                                SQLCODE ||
                                ' Error al definir cuentas contables');
    END;
  
    DECLARE
      C_VARIABLE_CONF  VARCHAR2(2000);
      C_VARIABLE_CONF1 VARCHAR2(2000);
      C_VARIABLE_CONF2 VARCHAR2(2000);
      C_VARIABLE_CONF3 VARCHAR2(2000);
      C_VARIABLE_CONF4 VARCHAR2(2000);
    BEGIN
      SELECT CONF_PER_ACT_INI,
             CONF_PER_ACT_FIN,
             CONF_PER_SGTE_INI,
             CONF_PER_SGTE_FIN,
             CONF_CTA_CONT_DEUDORES_FCON
        INTO C_VARIABLE_CONF,
             C_VARIABLE_CONF1,
             C_VARIABLE_CONF2,
             C_VARIABLE_CONF3,
             C_VARIABLE_CONF4
        FROM FIN_CONFIGURACION
       WHERE CONF_EMPR = V('P_EMPRESA');
    
      SETITEM('P2986_CONF_PER_ACT_INI', C_VARIABLE_CONF);
      SETITEM('P2986_CONF_PER_ACT_FIN', C_VARIABLE_CONF1);
      SETITEM('P2986_CONF_PER_SGTE_INI', C_VARIABLE_CONF2);
      SETITEM('P2986_CONF_PER_SGTE_FIN', C_VARIABLE_CONF3);
      SETITEM('P2986_CONF_CTA_CONT_DEU_FCON', C_VARIABLE_CONF4);
    
      IF NOT V('P2986_CONF_PERIODO') BETWEEN V('P2986_CONF_PER_ACT_INI') AND
         V('P2986_CONF_PER_SGTE_FIN') THEN
        NULL; --   RAISE_APPLICATION_ERROR(-20010,
        --                           'Periodo no coincide con sistema de finanzas!');
      END IF;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'No fue cargada la tabla de configuraci?n del sistema de finanzas!.');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010,
                                SQLCODE ||
                                'Error al momento de validar periodo' ||
                                SQLERRM);
    END;
  
    ------------------------------------------------
    ------------------------------------------------
    ------------------------------------------------
  
    DECLARE
      V_PER_ACT  NUMBER;
      V_PER_SGTE NUMBER;
    BEGIN
    
      SELECT CONF_PERIODO_ACT, CONF_PERIODO_SGTE
        INTO V_PER_ACT, V_PER_SGTE
        FROM STK_CONFIGURACION
       WHERE CONF_EMPR = V('P_EMPRESA');
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'No fue cargada la tabla de configuraci?n del sistema de stock!.');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010, SQLCODE);
    END;
  
    DECLARE
      C_VARIABLE_CONF_PER VARCHAR2(500);
    BEGIN
      SELECT PERI_FEC_INI
        INTO C_VARIABLE_CONF_PER
        FROM STK_PERIODO
       WHERE PERI_CODIGO = V_PER_ACT
         AND PERI_EMPR = V('P_EMPRESA');
    
      SETITEM('P2986_CONF_STK_PER_ACT_INI', C_VARIABLE_CONF_PER);
    
      SELECT PERI_FEC_FIN
        INTO C_VARIABLE_CONF_PER
        FROM STK_PERIODO
       WHERE PERI_CODIGO = V_PER_SGTE
         AND PERI_EMPR = V('P_EMPRESA');
    
      SETITEM('P2986_CONF_STK_PER_SGTE_FIN', C_VARIABLE_CONF_PER);
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL; -- RAISE_APPLICATION_ERROR(-20010, 'No fue cargada la tabla de periodos del sistema de stock!.' ||V('P_EMPRESA'));
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010, SQLCODE);
    END;
  
    C_VARIABLE_GANADERIA := GEN_IND_GANADERA(V('P_EMPRESA'));
    IF C_VARIABLE_GANADERIA IS NULL OR C_VARIABLE_GANADERIA <> 'S' THEN
      C_VARIABLE_GANADERIA := 'N';
    END IF;
    SETITEM('P2986_EMPR_IND_GANADERA', C_VARIABLE_GANADERIA);
  
  END;

  PROCEDURE PP_CONTROL_ARTICULO IS
  BEGIN
  
    DECLARE
      C_VARIABLE  VARCHAR2(50);
      C_VARIABLE1 VARCHAR2(50);
    BEGIN
    
      SELECT
      /*ART_CODIGO,
      ART_DESC,
      ART_CODIGO_FABRICA,
      ART_MARCA,*/
       ART_IMPU, LIN_IND_ANIM
      /*ART_EST,
      ART_UNID_MED,
      ART_TIPO_COMISION,
      ART_COD_ALFANUMERICO,
      C,
      IMPU_PORCENTAJE,
      IMPU_PORC_BASE_IMPONIBLE,
      ART_IND_FACT_NEGATIVO,
      ART_COD_BARRA,
      DECODE(NVL(ENVA_IND_HA, 'N'), 'S',1,0),
      LIN_IND_ANIM*/
      
        INTO /*:BDOC_DET.DET_ART,
             :BDOC_DET.ART_DESC,
             :BDOC_DET.ART_CODIGO_FABRICA,
             :BDOC_DET.ART_MARCA,
             :BDOC_DET.DET_COD_IVA,
             :BDOC_DET.ART_EST,
             :BDOC_DET.ART_UNID_MED,
             :BDOC_DET.DET_TIPO_COMISION,
             :BDOC_DET.W_ART_COD_ALFANUMERICO,
             :BDOC_DET.ART_FACTOR_CONVERSION,
             :BDOC_DET.S_IMPU,
             :BDOC_DET.S_BASE,
             :BDOC_DET.ART_IND_FACT_NEGATIVO,
             :BDOC_DET.ART_COD_BARRA,
             :BDOC_DET.ENVA_IND_HA,
             :BDOC_DET.ART_IND_ANIMAL*/ C_VARIABLE,
             C_VARIABLE1
        FROM GEN_IMPUESTO IM, STK_ENVASES EN, STK_LINEA LI, STK_ARTICULO AR
       WHERE LIN_EMPR = ART_EMPR
         AND LIN_CODIGO = ART_LINEA
         AND IMPU_EMPR = ART_EMPR
         AND IMPU_CODIGO = ART_IMPU
         AND ENVA_EMPR(+) = ART_EMPR
         AND ENVA_LINEA(+) = ART_LINEA
         AND ENVA_CODIGO(+) = ART_ENVASE
         AND ART_EMPR = V('P_EMPRESA')
         AND ART_CODIGO = V('P2986_S_ART');
      --  RAISE_APPLICATION_ERROR(-20010, 'ERROR ACA ');
    
      SETITEM('P2986_DET_COD_IVA', C_VARIABLE);
      SETITEM('P2986_ART_IND_ANIMAL', C_VARIABLE1);
    
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010,
                                ' ERRO AL MOMENTOS DE FP_BUSCAR_ART_COD_NUMERICO ');
    END;
    --RAISE_APPLICATION_ERROR(-20010, 'ERROR ACA ');
    --
    --PP_VALIDAR_ARTICULO
    --IF V('P2986_S_UNIDAD_VTA')= 'F' THEN
    IF FP_BUSCAR_ART_COD_ALFANUM = FALSE THEN
      RAISE_APPLICATION_ERROR(-20010, 'No existe el articulo');
    END IF;
    --END IF;
    IF V('P2986_S_UNIDAD_VTA') = 'F' THEN
      PP_BUSCAR_FLETE_DET;
    END IF;
    --
  
    --- agregue esto para igualar el funcionamiento del FACI039 pedido Josue/Diego
    FACI052.PP_BUSCAR_IMPUESTO;
  
    IF V('P2986_S_NRO_PEDIDO') IS NULL THEN
      FACI052.PP_BUSCAR_PRECIO;
    END IF;
  
    IF V('P2986_AREM_MON') NOT IN (V('P_MON_US'), V('P_MON_LOC')) THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'El precio de un articulo solo puede ser en moneda local o US$');
    END IF;
  
    BEGIN
      FACI052.PP_BUSCAR_EXISTENCIA;
    END;
  
    BEGIN
      FACI052.PP_BUSCAR_PED_SUC_IMP;
    END;
  
    BEGIN
      FACI052.PP_BUSCAR_CANT_REMITIDO;
    END;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              SQLCODE || ' ERROR EN CONTROL ARTICULOS');
    
  END;

  PROCEDURE PP_CONTROL_CLIENTE(INDICADOR OUT NUMBER) IS
    V_CATEGORIA NUMBER;
  BEGIN
  
    SELECT MAX(CLI_CATEG)
      INTO V_CATEGORIA
      FROM FIN_CLIENTE
     WHERE CLI_CODIGO = V('P2986_DOC_CLI')
       AND CLI_EMPR = V('P_EMPRESA');
  
    IF V('P2986_S_TIPO_FACTURA') = 2 --si es factura credito
       AND V_CATEGORIA = 13 THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Los clientes con categoria OCASIONAL no pueden comprar a credito!');
    END IF;
  
    IF V_CATEGORIA = 13 THEN
      INDICADOR := 1;
    ELSE
      INDICADOR := 2;
    END IF;
  
  END;

  PROCEDURE PP_COLLECTION_ADICIONAR_ITEM IS
  
    V_IMPU_PORCENTAJE NUMBER;
    V_DOC_EXENTA_MON  NUMBER;
    V_DOC_EXENTA_LOC  NUMBER;
    V_DOC_GRAV_MON    NUMBER;
    V_DOC_GRAV_LOC    NUMBER;
    V_DOC_IVA_MON     NUMBER;
    V_DOC_IVA_LOC     NUMBER;
    V_ART             STK_ARTICULO%ROWTYPE;
    PRECIO            NUMBER;
    --
    V_S_UNIDAD_VTA VARCHAR2(1);
    V_IND_FLETE    VARCHAR2(1);
    --
  
  BEGIN
  
    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLES_FACI052') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'DETALLES_FACI052');
    END IF;
  
    IF V('P2986_S_UNIDAD_VTA') = 'F' THEN
      V_IND_FLETE    := V('P2986_S_UNIDAD_VTA');
      V_S_UNIDAD_VTA := 'U';
    ELSE
      V_S_UNIDAD_VTA := V('P2986_S_UNIDAD_VTA');
    END IF;
    IF V('P2986_S_PORC_DTO') IS NOT NULL THEN
    
      PRECIO := V('P2986_S_PRECIO') -
                (V('P2986_S_PRECIO') * V('P2986_S_PORC_DTO') / 100);
    
      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                 P_C001            => V_S_UNIDAD_VTA, --V('P2986_S_UNIDAD_VTA'),
                                 P_C002            => V('P2986_S_ART'),
                                 P_C003            => V('P2986_D_NRO_REMIS'),
                                 P_C004            => V('P2986_DET_CANT'),
                                 P_C005            => PRECIO, --V('P2986_S_PRECIO'),
                                 P_C006            => V('P2986_S_IMPORTE'),
                                 P_C007            => V('P2986_DETA_PESO_UN'),
                                 P_C008            => V('P2986_DETA_PESO_TT'),
                                 P_C009            => V_DOC_EXENTA_MON,
                                 P_C010            => V_DOC_EXENTA_LOC,
                                 P_C011            => V_DOC_GRAV_MON,
                                 P_C012            => V_DOC_GRAV_LOC,
                                 P_C013            => V_DOC_IVA_MON,
                                 P_C014            => V_DOC_IVA_LOC,
                                 P_C015            => V_ART.ART_CLASIFICACION,
                                 P_C016            => V_IMPU_PORCENTAJE,
                                 P_C017            => V_ART.ART_IMPU,
                                 P_C018            => 0, --P2986_DET_BRUTO_LOC
                                 P_C019            => 0, --P2986_DET_BRUTO_MON
                                 P_C020            => 0, --P2986_DET_NETO_LOC
                                 P_C021            => 0, --P2986_DET_NETO_MON
                                 P_C022            => 0, --P2986_DET_IVA_LOC
                                 P_C023            => 0, --P2986_DET_IVA_MON
                                 P_C024            => V('P2986_S_PORC_DTO'), -- PORCENTAJE DE DESCUENTO
                                 P_C025            => V('P2986_S_PRECIO'),
                                 P_C026            => 0, -- DOC_BRUTO_EXCEN_MON
                                 P_C027            => 0, /*DOC_BRUTO_EXCEN_LOC*/ -- precio bruto, para calculos
                                 --
                                 P_C028 => V_IND_FLETE,
                                 
                                 P_C030 => V('P2986_KG_GANCHO')
                                 --
                                 );
    
    ELSE
    
      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                 P_C001            => V_S_UNIDAD_VTA, --V('P2986_S_UNIDAD_VTA'),
                                 P_C002            => V('P2986_S_ART'),
                                 P_C003            => V('P2986_D_NRO_REMIS'),
                                 P_C004            => V('P2986_DET_CANT'),
                                 P_C005            => V('P2986_S_PRECIO'),
                                 P_C006            => V('P2986_S_IMPORTE'),
                                 P_C007            => V('P2986_DETA_PESO_UN'),
                                 P_C008            => V('P2986_DETA_PESO_TT'),
                                 P_C009            => V_DOC_EXENTA_MON,
                                 P_C010            => V_DOC_EXENTA_LOC,
                                 P_C011            => V_DOC_GRAV_MON,
                                 P_C012            => V_DOC_GRAV_LOC,
                                 P_C013            => V_DOC_IVA_MON,
                                 P_C014            => V_DOC_IVA_LOC,
                                 P_C015            => V_ART.ART_CLASIFICACION,
                                 P_C016            => V_IMPU_PORCENTAJE,
                                 P_C017            => V_ART.ART_IMPU,
                                 P_C018            => 0, --P2986_DET_BRUTO_LOC
                                 P_C019            => 0, --P2986_DET_BRUTO_MON
                                 P_C020            => 0, --P2986_DET_NETO_LOC
                                 P_C021            => 0, --P2986_DET_NETO_MON
                                 P_C022            => 0, --P2986_DET_IVA_LOC
                                 P_C023            => 0, --P2986_DET_IVA_MON
                                 P_C024            => 0, -- PORCENTAJE DE DESCUENTO
                                 P_C025            => V('P2986_S_PRECIO'), -- precio bruto, para calculos
                                 --
                                 P_C028 => V_IND_FLETE,
                                 P_C030 => V('P2986_KG_GANCHO')
                                 --
                                 );
    
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLERRM);
    
  END PP_COLLECTION_ADICIONAR_ITEM;

  PROCEDURE PP_COLLECTION_BORRAR_DETALLE(I_SEQ IN NUMBER) AS
  BEGIN
    APEX_COLLECTION.DELETE_MEMBER(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                  P_SEQ             => I_SEQ);
  
    APEX_COLLECTION.RESEQUENCE_COLLECTION(P_COLLECTION_NAME => 'DETALLES_FACI052');
  
  END PP_COLLECTION_BORRAR_DETALLE;

  PROCEDURE PP_COLLECTION_UPDATE IS
  BEGIN
  
    APEX_COLLECTION.UPDATE_MEMBER(P_COLLECTION_NAME => 'DETALLES_FACI052',
                                  P_SEQ             => V('P2986_IND_ITEM_EDIT'),
                                  P_C001            => V('P2986_S_UNIDAD_VTA'),
                                  P_C002            => V('P2986_S_ART'),
                                  P_C003            => V('P2986_D_NRO_REMIS'),
                                  P_C004            => V('P2986_DET_CANT'),
                                  P_C005            => V('P2986_S_PRECIO'),
                                  P_C006            => V('P2986_S_IMPORTE'),
                                  P_C007            => V('P2986_DETA_PESO_UN'),
                                  P_C008            => V('P2986_DETA_PESO_TT'),
                                  P_C030            => V('P2986_KG_GANCHO'));
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Ocurrio un error al momento de editar');
  END PP_COLLECTION_UPDATE;

  PROCEDURE PP_GENERAR_CUOTAS IS
    I             NUMBER;
    V_FECHA       DATE := V('P2_S_FEC_PRIM_VTO');
    V_CUO_IMP     NUMBER := ROUND(V('P2_S_TOTAL') / V('P2_S_CANT_CUOTAS'),
                                  V('P2986_W_MON_DEC_IMP'));
    V_TOT_CUO_IMP NUMBER := 0;
    V_CUO_FEC_VTO DATE;
  BEGIN
  
    FOR I IN 1 .. V('P2_S_CANT_CUOTAS') LOOP
    
      V_CUO_FEC_VTO := V_FECHA;
    
      IF V('P2_S_TIPO_VENCIMIENTO') = 'V' THEN
        V_FECHA := V_FECHA + V('P2_S_DIAS_ENTRE_CUOTAS');
      ELSE
        V_FECHA := ADD_MONTHS(V('P2_S_FEC_PRIM_VTO'), I);
      END IF;
      --raise_application_error(-20010, V_CUO_IMP);
      --AJUSTAR LA DIFERENCIA POR REDONDEO A LA ULTIMA CUOTA;
      IF I = V('P2_S_CANT_CUOTAS') THEN
        V_CUO_IMP := (V('P2_S_TOTAL') - V_TOT_CUO_IMP);
      END IF;
      --*
    
      V_TOT_CUO_IMP := V_TOT_CUO_IMP + V_CUO_IMP;
    
      FACI052.PP_ADICIONAR_CUOTA(P_CUO_FEC_VTO => V_CUO_FEC_VTO,
                                 P_CUO_IMP_MON => V_CUO_IMP);
    END LOOP;
  
  END PP_GENERAR_CUOTAS;

  PROCEDURE PP_ADICIONAR_CUOTA(P_CUO_FEC_VTO IN DATE,
                               P_CUO_IMP_MON IN NUMBER) IS
  BEGIN
    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CUOTA_FACI052') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'CUOTA_FACI052');
    END IF;
    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'CUOTA_FACI052',
                               P_N001            => P_CUO_IMP_MON,
                               P_D001            => P_CUO_FEC_VTO);
  
  END PP_ADICIONAR_CUOTA;

  PROCEDURE PP_GUARDAR_CHEQUE IS
  BEGIN
  
    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUES_FACI052') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'CHEQUES_FACI052');
    END IF;
  
    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'CHEQUES_FACI052',
                               P_C001            => V('P3000_CHEQ_SERIE'),
                               P_C002            => V('P3000_CHEQ_NRO'),
                               P_C003            => V('P3000_CHEQ_NRO_CTA_CHEQ'),
                               P_C004            => V('P3000_CHEQ_TITULAR'),
                               P_D001            => V('P3000_CHEQ_FEC_DEPOSITAR'),
                               P_N001            => V('P3000_W_CHEQ_BCO'),
                               P_N002            => V('P3000_CHEQ_MON'),
                               P_N003            => V('P3000_IMPORTE'),
                               P_N004            => V('P3000_TASA'),
                               P_N005            => V('P3000_CHEQ_IMPORTE_LOC'));
  END PP_GUARDAR_CHEQUE;

  PROCEDURE PP_GUARDAR_TARJETA IS
  BEGIN
  
    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TARJETA_FACI052') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'TARJETA_FACI052');
    END IF;
  
    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'TARJETA_FACI052',
                               P_C001            => V('P3000_TARJ_NRO_TARJETA'),
                               P_D001            => V('P3000_S_TARJ_FEC_VTO'),
                               P_N001            => V('P3000_W_TARJ_TARJETA'),
                               P_N002            => V('P3000_TARJ_IMP_LOC'));
  END PP_GUARDAR_TARJETA;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_DOC_CLAVE  IN NUMBER,
                                   I_DOCU_CLAVE IN NUMBER) IS
    V_NRO_PEDIDO VARCHAR2(500);
  
  BEGIN
  
    BEGIN
      FACI052.PP_BUSCAR_NRO_FACTURA;
    END;
  
    IF V('P2986_F_TOTAL') = 0 THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Debe ingresar por lo menos un articulo!');
    END IF;
  
    IF V('P2986_DOC_OPERADOR') = '1' THEN
      SETITEM('P2986_P_FAC_NEGRO', 'S');
    ELSE
      SETITEM('P2986_P_FAC_NEGRO', 'N');
    END IF;
  
    BEGIN
      FACI052.PP_VALIDAR_REMI_DET_ACUM;
    END;
  
    BEGIN
      FACI052.PP_VALIDAR_DETA;
    END;
  
    SETITEM('P2986_W_LIM_AUTORIZADO', 'N');
  
    IF V('P2986_DOC_CLAVE') IS NULL THEN
      SETITEM('P2986_DOC_CLAVE', FIN_SEQ_DOC_NEXTVAL);
    END IF;
  
    IF V('P2986_W_LIM_AUTORIZADO') = 'S' THEN
      BEGIN
        FACI052.PP_ACTUALIZAR_AUTORIZ_ESPEC;
      END;
    END IF;
  
    --actualizar cuotas solo si existen cuotas para el documento
  
    FACI052.PP_ACTUALIZAR_CUOTAS(I_CUO_CLAVE => I_DOC_CLAVE);
  
    BEGIN
      FACI052.PP_ACTUALIZAR_DOC_CONCEPTO(P_DOC_CLAVE => I_DOC_CLAVE);
    END;
  
    BEGIN
      FACI052.PP_ACTUALIZAR_FAC_DOCU_DET(I_DOC_CLAVE_FAC => I_DOC_CLAVE);
    END;
    COMMIT;
  
    IF V('P2986_CONF_ACT_STK') = 'S' THEN
      ---- SI ES EXPORTACION NO AFECTA STOCK PARA NO EVITAR PROBLEMAS AL CALCULAR PRECIOS DE COSTOS
      IF NVL(V('P2986_EXPORTACION'), 'N') != 'S' THEN
        BEGIN
          FACI052.PP_ACTUALIZAR_DOCUMENTO_STK(I_DOCU_CLAVE => I_DOCU_CLAVE);
        END;
      END IF;
    
    END IF;
  
    --RAISE_APPLICATION_ERROR(-20010,/*'AQUI' ||' - '|| V('P2986_CONF_ACT_STK') ||' - '|| */V('P2986_EXPORTACION'));
  
    IF V('P2986_S_NRO_PEDIDO') IS NOT NULL THEN
    
      UPDATE FAC_PEDIDO
         SET PED_ESTADO = 'F'
       WHERE PED_NRO = V('P2986_S_NRO_PEDIDO')
         AND PED_EMPR = V('P_EMPRESA');
    
    END IF;
  
    IF V('P2986_IND_PED_AUTO') = 'S' THEN
      V_NRO_PEDIDO := FAC_GENERAR_PEDIDO(V('P2986_DOC_CLI'));
      IF V_NRO_PEDIDO = -1 THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'No se ha podido generar el pedido automatico.');
      ELSE
        RAISE_APPLICATION_ERROR(-20010,
                                'El numero de pedido generado fu? el N?= ' ||
                                V_NRO_PEDIDO);
      END IF;
    END IF;
  
    BEGIN
      IF V('P2986_P_LIM_FAC_ADIC') = 'S' THEN
      
        UPDATE FIN_AUTORIZ_ESPEC
           SET AUES_UTILIZADA = 'S'
         WHERE AUES_CLI = V('P2986_DOC_CLI')
           AND AUES_FEC_AUTORIZ =
               TO_DATE(TO_CHAR(V('P2986_DOC_FEC_DOC'), 'DD/MM/YYYY'),
                       'DD/MM/YYYY')
           AND AUES_MON = V('P2986_DOC_MON')
           AND AUES_UTILIZADA = 'N'
           AND AUES_EMPR = V('P_EMPRESA');
      
        SETITEM('P2986_P_LIM_FAC_ADIC', 'N');
      
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
      WHEN OTHERS THEN
        NULL;
    END;
  
    /*EXCEPTION
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20010, SQLCODE||' ERROR EN ACTUALIZAR REGISTROS'); */
  
  END;

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_FIN(FIN_DATOS FIN_DOCUMENTO%ROWTYPE) IS
  
    NETO_EXEN_LOC NUMBER;
    NETO_EXEN_MON NUMBER;
    NETO_GRAV_LOC NUMBER;
    NETO_GRAV_MON NUMBER;
    IVA_MON       NUMBER;
    IVA_LOC       NUMBER;
  
  BEGIN
  
    SELECT SUM(C.C009) DOC_EXENTA_MON,
           SUM(C.C010) DOC_EXENTA_LOC,
           SUM(C.C011) V_DOC_GRAV_MON,
           SUM(C.C012) V_DOC_GRAV_LOC,
           SUM(C.C013) DOC_IVA_MON,
           SUM(C.C014) DOC_IVA_LOC
      INTO NETO_EXEN_MON,
           NETO_EXEN_LOC,
           NETO_GRAV_MON,
           NETO_GRAV_LOC,
           IVA_MON,
           IVA_LOC
      FROM APEX_COLLECTIONS C
     WHERE C.COLLECTION_NAME = 'DETALLES_FACI052';
  
    IF V('P_EMPRESA') = 1 THEN
    
      IF NVL(V('P2986_EXPORTACION'), 'N') != 'S' THEN
      
        INSERT INTO FIN_DOCUMENTO FIN
          (FIN.DOC_CLAVE,
           FIN.DOC_EMPR,
           FIN.DOC_CTA_BCO,
           FIN.DOC_SUC,
           FIN.DOC_TIPO_MOV,
           FIN.DOC_FEC_DOC,
           FIN.DOC_CLI,
           FIN.DOC_CLI_NOM,
           FIN.DOC_NRO_DOC,
           FIN.DOC_MON,
           FIN.DOC_CLI_DIR,
           FIN.DOC_CLI_RUC,
           FIN.DOC_OBS,
           FIN.DOC_SALDO_LOC,
           FIN.DOC_SALDO_MON,
           FIN.DOC_SALDO_PER_ACT_LOC,
           FIN.DOC_SALDO_PER_ACT_MON,
           FIN.DOC_FEC_OPER,
           FIN.DOC_LOGIN,
           FIN.DOC_FEC_GRAB,
           FIN.DOC_SIST,
           FIN.DOC_IND_EXPORT,
           FIN.DOC_CLAVE_STK,
           FIN.DOC_IND_STK,
           FIN.DOC_CTACO,
           FIN.DOC_TIPO_SALDO,
           FIN.DOC_LEGAJO,
           FIN.DOC_CLI_TEL,
           FIN.DOC_NETO_EXEN_LOC,
           FIN.DOC_NETO_EXEN_MON,
           FIN.DOC_NETO_GRAV_LOC,
           FIN.DOC_NETO_GRAV_MON,
           FIN.DOC_IVA_MON,
           FIN.DOC_IVA_LOC,
           FIN.DOC_SERIE,
           FIN.DOC_COND_VTA,
           FIN.DOC_CANAL,
           FIN.DOC_EXP_PROFORMA,
           FIN.DOC_CTA_BCO_FCON,
           FIN.DOC_IND_IMPR_CONYUGUE,
           FIN.DOC_IND_IMPR_VENDEDOR,
           FIN.DOC_BRUTO_EXEN_MON,
           FIN.DOC_BRUTO_EXEN_LOC,
           FIN.DOC_BRUTO_GRAV_LOC,
           FIN.DOC_BRUTO_GRAV_MON,
           FIN.DOC_PLAN_FINAN,
           FIN.DOC_IND_CUOTA,
           FIN.DOC_TIMBRADO,
           FIN.DOC_TIPO_DOC_CLI_PROV,
           FIN.DOC_SISTEMA_AUX,
           FIN.DOC_TIPO_FACTURA)
        VALUES
          (FIN_DATOS.DOC_CLAVE,
           FIN_DATOS.DOC_EMPR,
           FIN_DATOS.DOC_CTA_BCO,
           FIN_DATOS.DOC_SUC,
           FIN_DATOS.DOC_TIPO_MOV,
           FIN_DATOS.DOC_FEC_DOC,
           FIN_DATOS.DOC_CLI,
           FIN_DATOS.DOC_CLI_NOM,
           FIN_DATOS.DOC_NRO_DOC,
           FIN_DATOS.DOC_MON,
           FIN_DATOS.DOC_CLI_DIR,
           FIN_DATOS.DOC_CLI_RUC,
           FIN_DATOS.DOC_OBS,
           ROUND(FIN_DATOS.DOC_SALDO_LOC),
           FIN_DATOS.DOC_SALDO_MON,
           FIN_DATOS.DOC_SALDO_PER_ACT_LOC,
           FIN_DATOS.DOC_SALDO_PER_ACT_MON,
           FIN_DATOS.DOC_FEC_OPER,
           FIN_DATOS.DOC_LOGIN,
           FIN_DATOS.DOC_FEC_GRAB,
           FIN_DATOS.DOC_SIST,
           FIN_DATOS.DOC_IND_EXPORT,
           FIN_DATOS.DOC_CLAVE_STK,
           FIN_DATOS.DOC_IND_STK,
           FIN_DATOS.DOC_CTACO,
           FIN_DATOS.DOC_TIPO_SALDO,
           FIN_DATOS.DOC_LEGAJO,
           FIN_DATOS.DOC_CLI_TEL,
           ROUND(NETO_EXEN_LOC), ---
           NETO_EXEN_MON, ---
           NETO_GRAV_LOC,
           NETO_GRAV_MON,
           IVA_MON,
           IVA_LOC,
           FIN_DATOS.DOC_SERIE,
           FIN_DATOS.DOC_COND_VTA,
           FIN_DATOS.DOC_CANAL,
           FIN_DATOS.DOC_EXP_PROFORMA,
           FIN_DATOS.DOC_CTA_BCO_FCON,
           FIN_DATOS.DOC_IND_IMPR_CONYUGUE,
           FIN_DATOS.DOC_IND_IMPR_VENDEDOR,
           FIN_DATOS.DOC_BRUTO_EXEN_MON,
           ROUND(FIN_DATOS.DOC_BRUTO_EXEN_LOC),
           FIN_DATOS.DOC_BRUTO_GRAV_LOC,
           FIN_DATOS.DOC_BRUTO_GRAV_MON,
           FIN_DATOS.DOC_PLAN_FINAN,
           FIN_DATOS.DOC_IND_CUOTA,
           FIN_DATOS.DOC_TIMBRADO,
           FIN_DATOS.DOC_TIPO_DOC_CLI_PROV,
           'FACI052',
           1);
      
      ELSE
      
        INSERT INTO FIN_DOCUMENTO FIN
          (FIN.DOC_CLAVE,
           FIN.DOC_EMPR,
           FIN.DOC_CTA_BCO,
           FIN.DOC_SUC,
           FIN.DOC_TIPO_MOV,
           FIN.DOC_FEC_DOC,
           FIN.DOC_CLI,
           FIN.DOC_CLI_NOM,
           FIN.DOC_NRO_DOC,
           FIN.DOC_MON,
           FIN.DOC_CLI_DIR,
           FIN.DOC_CLI_RUC,
           FIN.DOC_OBS,
           FIN.DOC_SALDO_LOC,
           FIN.DOC_SALDO_MON,
           FIN.DOC_SALDO_PER_ACT_LOC,
           FIN.DOC_SALDO_PER_ACT_MON,
           FIN.DOC_FEC_OPER,
           FIN.DOC_LOGIN,
           FIN.DOC_FEC_GRAB,
           FIN.DOC_SIST,
           FIN.DOC_IND_EXPORT,
           FIN.DOC_CLAVE_STK,
           FIN.DOC_IND_STK,
           FIN.DOC_CTACO,
           FIN.DOC_TIPO_SALDO,
           FIN.DOC_LEGAJO,
           FIN.DOC_CLI_TEL,
           FIN.DOC_NETO_EXEN_LOC,
           FIN.DOC_NETO_EXEN_MON,
           FIN.DOC_NETO_GRAV_LOC,
           FIN.DOC_NETO_GRAV_MON,
           FIN.DOC_IVA_MON,
           FIN.DOC_IVA_LOC,
           FIN.DOC_SERIE,
           FIN.DOC_COND_VTA,
           FIN.DOC_CANAL,
           FIN.DOC_EXP_PROFORMA,
           FIN.DOC_CTA_BCO_FCON,
           FIN.DOC_IND_IMPR_CONYUGUE,
           FIN.DOC_IND_IMPR_VENDEDOR,
           FIN.DOC_BRUTO_EXEN_MON,
           FIN.DOC_BRUTO_EXEN_LOC,
           FIN.DOC_BRUTO_GRAV_LOC,
           FIN.DOC_BRUTO_GRAV_MON,
           FIN.DOC_PLAN_FINAN,
           FIN.DOC_IND_CUOTA,
           FIN.DOC_TIMBRADO,
           FIN.DOC_TIPO_DOC_CLI_PROV,
           FIN.DOC_SISTEMA_AUX,
           FIN.DOC_TIPO_FACTURA)
        VALUES
          (FIN_DATOS.DOC_CLAVE,
           FIN_DATOS.DOC_EMPR,
           FIN_DATOS.DOC_CTA_BCO,
           FIN_DATOS.DOC_SUC,
           FIN_DATOS.DOC_TIPO_MOV,
           FIN_DATOS.DOC_FEC_DOC,
           FIN_DATOS.DOC_CLI,
           FIN_DATOS.DOC_CLI_NOM,
           FIN_DATOS.DOC_NRO_DOC,
           FIN_DATOS.DOC_MON,
           FIN_DATOS.DOC_CLI_DIR,
           FIN_DATOS.DOC_CLI_RUC,
           FIN_DATOS.DOC_OBS,
           ROUND(FIN_DATOS.DOC_SALDO_LOC),
           FIN_DATOS.DOC_SALDO_MON,
           FIN_DATOS.DOC_SALDO_PER_ACT_LOC,
           FIN_DATOS.DOC_SALDO_PER_ACT_MON,
           FIN_DATOS.DOC_FEC_OPER,
           FIN_DATOS.DOC_LOGIN,
           FIN_DATOS.DOC_FEC_GRAB,
           FIN_DATOS.DOC_SIST,
           FIN_DATOS.DOC_IND_EXPORT,
           FIN_DATOS.DOC_CLAVE_STK,
           NULL, --FIN_DATOS.DOC_IND_STK,
           FIN_DATOS.DOC_CTACO,
           FIN_DATOS.DOC_TIPO_SALDO,
           FIN_DATOS.DOC_LEGAJO,
           FIN_DATOS.DOC_CLI_TEL,
           ROUND(NETO_EXEN_LOC), ---
           NETO_EXEN_MON, ---
           NETO_GRAV_LOC,
           NETO_GRAV_MON,
           IVA_MON,
           IVA_LOC,
           FIN_DATOS.DOC_SERIE,
           FIN_DATOS.DOC_COND_VTA,
           FIN_DATOS.DOC_CANAL,
           FIN_DATOS.DOC_EXP_PROFORMA,
           FIN_DATOS.DOC_CTA_BCO_FCON,
           FIN_DATOS.DOC_IND_IMPR_CONYUGUE,
           FIN_DATOS.DOC_IND_IMPR_VENDEDOR,
           FIN_DATOS.DOC_BRUTO_EXEN_MON, --
           ROUND(FIN_DATOS.DOC_BRUTO_EXEN_LOC),
           0,
           0,
           FIN_DATOS.DOC_PLAN_FINAN,
           FIN_DATOS.DOC_IND_CUOTA,
           FIN_DATOS.DOC_TIMBRADO,
           FIN_DATOS.DOC_TIPO_DOC_CLI_PROV,
           'FACI052',
           1);
      
      END IF;
    ELSE
    
      INSERT INTO FIN_DOCUMENTO FIN
        (FIN.DOC_CLAVE,
         FIN.DOC_EMPR,
         FIN.DOC_CTA_BCO,
         FIN.DOC_SUC,
         FIN.DOC_TIPO_MOV,
         FIN.DOC_FEC_DOC,
         FIN.DOC_CLI,
         FIN.DOC_CLI_NOM,
         FIN.DOC_NRO_DOC,
         FIN.DOC_MON,
         FIN.DOC_CLI_DIR,
         FIN.DOC_CLI_RUC,
         FIN.DOC_OBS,
         FIN.DOC_SALDO_LOC,
         FIN.DOC_SALDO_MON,
         FIN.DOC_SALDO_PER_ACT_LOC,
         FIN.DOC_SALDO_PER_ACT_MON,
         FIN.DOC_FEC_OPER,
         FIN.DOC_LOGIN,
         FIN.DOC_FEC_GRAB,
         FIN.DOC_SIST,
         FIN.DOC_IND_EXPORT,
         FIN.DOC_CLAVE_STK,
         FIN.DOC_IND_STK,
         FIN.DOC_CTACO,
         FIN.DOC_TIPO_SALDO,
         FIN.DOC_LEGAJO,
         FIN.DOC_CLI_TEL,
         FIN.DOC_NETO_EXEN_LOC,
         FIN.DOC_NETO_EXEN_MON,
         FIN.DOC_NETO_GRAV_LOC,
         FIN.DOC_NETO_GRAV_MON,
         FIN.DOC_IVA_MON,
         FIN.DOC_IVA_LOC,
         FIN.DOC_SERIE,
         FIN.DOC_COND_VTA,
         FIN.DOC_CANAL,
         FIN.DOC_CTA_BCO_FCON,
         FIN.DOC_IND_IMPR_CONYUGUE,
         FIN.DOC_IND_IMPR_VENDEDOR,
         FIN.DOC_BRUTO_EXEN_MON,
         FIN.DOC_BRUTO_EXEN_LOC,
         FIN.DOC_BRUTO_GRAV_LOC,
         FIN.DOC_BRUTO_GRAV_MON,
         FIN.DOC_PLAN_FINAN,
         FIN.DOC_IND_CUOTA,
         FIN.DOC_TIMBRADO,
         FIN.DOC_TIPO_DOC_CLI_PROV,
         FIN.DOC_SISTEMA_AUX,
         FIN.DOC_TIPO_FACTURA)
      VALUES
        (FIN_DATOS.DOC_CLAVE,
         FIN_DATOS.DOC_EMPR,
         FIN_DATOS.DOC_CTA_BCO,
         FIN_DATOS.DOC_SUC,
         FIN_DATOS.DOC_TIPO_MOV,
         FIN_DATOS.DOC_FEC_DOC,
         FIN_DATOS.DOC_CLI,
         FIN_DATOS.DOC_CLI_NOM,
         FIN_DATOS.DOC_NRO_DOC,
         FIN_DATOS.DOC_MON,
         FIN_DATOS.DOC_CLI_DIR,
         FIN_DATOS.DOC_CLI_RUC,
         FIN_DATOS.DOC_OBS,
         ROUND(FIN_DATOS.DOC_SALDO_LOC),
         FIN_DATOS.DOC_SALDO_MON,
         FIN_DATOS.DOC_SALDO_PER_ACT_LOC,
         FIN_DATOS.DOC_SALDO_PER_ACT_MON,
         FIN_DATOS.DOC_FEC_OPER,
         FIN_DATOS.DOC_LOGIN,
         FIN_DATOS.DOC_FEC_GRAB,
         FIN_DATOS.DOC_SIST,
         FIN_DATOS.DOC_IND_EXPORT,
         FIN_DATOS.DOC_CLAVE_STK,
         NULL, --FIN_DATOS.DOC_IND_STK,
         FIN_DATOS.DOC_CTACO,
         FIN_DATOS.DOC_TIPO_SALDO,
         FIN_DATOS.DOC_LEGAJO,
         FIN_DATOS.DOC_CLI_TEL,
         ROUND(NETO_EXEN_LOC), ---
         NETO_EXEN_MON, ---
         NETO_GRAV_LOC,
         NETO_GRAV_MON,
         IVA_MON,
         IVA_LOC,
         FIN_DATOS.DOC_SERIE,
         FIN_DATOS.DOC_COND_VTA,
         FIN_DATOS.DOC_CANAL,
         FIN_DATOS.DOC_CTA_BCO_FCON,
         FIN_DATOS.DOC_IND_IMPR_CONYUGUE,
         FIN_DATOS.DOC_IND_IMPR_VENDEDOR,
         FIN_DATOS.DOC_BRUTO_EXEN_MON, --
         ROUND(FIN_DATOS.DOC_BRUTO_EXEN_LOC), --
         NETO_GRAV_MON,
         NETO_GRAV_LOC,
         FIN_DATOS.DOC_PLAN_FINAN,
         FIN_DATOS.DOC_IND_CUOTA,
         FIN_DATOS.DOC_TIMBRADO,
         FIN_DATOS.DOC_TIPO_DOC_CLI_PROV,
         'FACI052',
         1);
    
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              SQLCODE ||
                              'Error al momento de insertar en fin_documento ' ||
                              SQLERRM);
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20010,
                              SQLCODE ||
                              'error al momento de insertar en fin_documento ' ||
                              SQLERRM);
    
  END;

  PROCEDURE PP_ACTUALIZAR_CUOTAS(I_CUO_CLAVE IN NUMBER) IS
  
    CURSOR CUOTAS IS
      SELECT SEQ_ID, N001 IMPORTE, D001 FECHA_VENCIMIENTO
        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'CUOTA_FACI052';
  
  BEGIN
  
    FOR I IN CUOTAS LOOP
    
      INSERT INTO FIN_CUOTA
        (CUO_CLAVE_DOC, CUO_FEC_VTO, CUO_IMP_LOC, CUO_IMP_MON, CUO_EMPR)
      VALUES
        (I_CUO_CLAVE, --V('P2986_DOCU_CLAVE'),
         I.FECHA_VENCIMIENTO,
         ROUND(I.IMPORTE * V('P2986_W_DOC_TASA_US')),
         I.IMPORTE,
         V('P_EMPRESA'));
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              SQLCODE || 'ERROR EN ACTUALIZAR CUOTAS');
  END;

  PROCEDURE PP_ACTUALIZAR_AUTORIZ_ESPEC IS
  BEGIN
  
    UPDATE FIN_AUTORIZ_ESPEC
       SET AUES_UTILIZADA = 'S'
     WHERE AUES_CLI = V('P2986_DOC_CLI')
       AND AUES_FEC_AUTORIZ =
           TO_DATE(TO_CHAR(V('P2986_DOC_FEC_DOC'), 'DD/MM/YYYY'),
                   'DD/MM/YYYY')
       AND AUES_MON = V('P2986_DOC_MON')
       AND AUES_EMPR = V('P_EMPRESA');
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'No existe registro de autorizaci?n especial para actualizarse!.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE);
  END;

  PROCEDURE PP_ACTUALIZAR_DOC_CONCEPTO(P_DOC_CLAVE IN NUMBER) IS
    V_ITEM                 NUMBER := 0;
    V_CLAVE_CTACONT_EXPORT NUMBER;
  
    CURSOR CURSOR_DET IS
      SELECT SEQ_ID ITEM,
             C001 UNIDAD_VTA,
             C002 ARTICULO,
             TO_NUMBER(C003) NRO_REMISION,
             TO_NUMBER(C004) CANTIDAD,
             TO_NUMBER(C005) PRECIO,
             TO_NUMBER(C007) PESO_UNIDAD,
             TO_NUMBER(C008) PESO_TONELADA,
             TO_NUMBER(C030) KG_GANCHO
        FROM APEX_COLLECTIONS A
       WHERE A.COLLECTION_NAME = 'DETALLES_FACI052';
  
    PROCEDURE AGREGAR_CONCEPTO(IN_CONC     IN NUMBER,
                               IN_CTACO    IN NUMBER,
                               IN_GRAV_LOC IN NUMBER,
                               IN_GRAV_MON IN NUMBER,
                               IN_EXEN_LOC IN NUMBER,
                               IN_EXEN_MON IN NUMBER,
                               IN_IVA_LOC  IN NUMBER,
                               IN_IVA_MON  IN NUMBER) IS
    
      V_ART_CONCEPTO     NUMBER;
      V_ART_CTA_CONTABLE NUMBER;
      V_CLAVE_CONCEPTO   NUMBER;
    
    BEGIN
      IF (IN_GRAV_LOC + IN_EXEN_LOC + IN_IVA_LOC) > 0 THEN
      
        V_ITEM := V_ITEM + 1;
      
        INSERT INTO FIN_DOC_CONCEPTO
          (DCON_ITEM,
           DCON_CLAVE_DOC,
           DCON_CLAVE_CONCEPTO,
           DCON_TIPO_SALDO,
           DCON_CLAVE_CTACO,
           DCON_GRAV_LOC,
           DCON_GRAV_MON,
           DCON_EXEN_LOC,
           DCON_EXEN_MON,
           DCON_IVA_LOC,
           DCON_IVA_MON,
           DCON_EMPR)
        VALUES
          (V_ITEM,
           P_DOC_CLAVE, --V('P2986_DOC_CLAVE'),
           IN_CONC,
           'D',
           IN_CTACO,
           IN_GRAV_LOC,
           IN_GRAV_MON,
           ROUND(IN_EXEN_LOC),
           IN_EXEN_MON,
           IN_IVA_LOC,
           IN_IVA_MON,
           V('P_EMPRESA'));
      
        -- RAISE_APPLICATION_ERROR(-20010, 'IN_CONC');
      
      END IF;
    
    END;
  
  BEGIN
  
    BEGIN
      FACI052.PP_CALCULAR_TOTALES_CONCEPTO;
    END;
  
    /*BEGIN
     --------POR SI LA CUENTA CONTABLE TIENE ASIGNADO MAS DE UN CONCEPTO DE DEBITO LEER DE LA TABLA CLASIFICACION
     BEGIN
       SELECT CLAS_CONC_ARTICULO
         INTO V_CLAVE_CONCEPTO
         FROM STK_CLASIFICACION A, STK_ARTICULO B
        WHERE CLAS_CODIGO = ART_CLASIFICACION
          AND CLAS_EMPR = ART_EMPR
          AND ART_CODIGO = I.ARTICULO
          AND ART_EMPR = V('P_EMPRESA');
    
     EXCEPTION
       WHEN OTHERS THEN
         NULL;
     END;
    
     SELECT FC.FCON_CLAVE, CLAS_CTACO_VENTA
       INTO V_ART_CONCEPTO, V_ART_CTA_CONTABLE
       FROM STK_CLASIFICACION C, STK_ARTICULO A, FIN_CONCEPTO FC
      WHERE C.CLAS_CODIGO = A.ART_CLASIFICACION
        AND C.CLAS_CTACO_VENTA = FC.FCON_CLAVE_CTACO(+)
        AND CLAS_EMPR = ART_EMPR
        AND C.CLAS_EMPR = FCON_EMPR(+)
        AND ART_EMPR = V('P_EMPRESA')
        AND FCON_TIPO_SALDO = 'D'
        AND (FCON_CLAVE = V_CLAVE_CONCEPTO OR V_CLAVE_CONCEPTO IS NULL)
        AND A.ART_CODIGO = I.ARTICULO;
    
     IF V_ART_CTA_CONTABLE IS NULL THEN
       RAISE_APPLICATION_ERROR(-20010, 'Debe asignar una CtaContable para el articulo!.');
     END IF;
    
    EXCEPTION
     WHEN TOO_MANY_ROWS THEN
       RAISE_APPLICATION_ERROR(-20010,'Existe mas de un concepto asociado a la cuenta contable del Articulo!.');
     WHEN NO_DATA_FOUND THEN
       RAISE_APPLICATION_ERROR(-20010,'No existe cta contable para mercaderia o el articulo no tiene asignado Ctas Contables!.');
     WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010, SQLCODE||' ' ||SQLERRM||' ERROR EN BUSQUEDA DE CUENTA CONTABLE DE ARTICULO!');
    
    END;*/
  
    DECLARE
      V_CONC_DESC VARCHAR2(50);
    BEGIN
    
      SELECT FCON_CLAVE_CTACO, FCON_DESC
        INTO V_CLAVE_CTACONT_EXPORT, V_CONC_DESC
        FROM FIN_CONCEPTO
       WHERE FCON_CLAVE = V('P2986_CONF_CONC_VTA_EXPORT')
         AND FCON_EMPR = V('P_EMPRESA');
      --RAISE_APPLICATION_ERROR(-20010, 'ACA ' || V_CLAVE_CTACONT_EXPORT || ' X '|| V('P2986_CONF_CONC_VTA_EXPORT'));
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Defina una cta contable para el concepto ' ||
                                V_CONC_DESC);
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010,
                                SQLCODE || ' PROBLEMA CON CONCEPTO ' ||
                                SQLERRM);
    END;
  
    --------------
  
    --procesar conceptos para venta de mercader?as, contado, credito
    IF V('P2986_DOC_TIPO_MOV') = V('P2986_CONF_COD_FAC_CONT') THEN
    
      --si es contado
      IF NVL(V('P2986_EXPORTACION'), 'N') = 'N' THEN
      
        -- procesar conceptos gravados
        --IF V('P2986_DCON_MERC_GRAV_LOC') <> 0 THEN
        IF V_DCON_MERC_GRAV_LOC <> 0 THEN
          AGREGAR_CONCEPTO(V('P2986_CONF_CONC_VTA_MERC'),
                           V('P2986_W_CTA_MERC_CONT'),
                           V_DCON_MERC_GRAV_LOC, --V('P2986_DCON_MERC_GRAV_LOC'),
                           V_DCON_MERC_GRAV_MON, --V('P2986_DCON_MERC_GRAV_MON'),
                           0,
                           0,
                           0,
                           0);
        END IF;
      
        -- procesar conceptos exentos
        --IF V('P2986_DCON_MERC_EXEN_LOC') <> 0 THEN
        IF V_DCON_MERC_EXEN_LOC <> 0 THEN
          AGREGAR_CONCEPTO(V('P2986_CONF_CONC_VTA_MERC'),
                           V('P2986_W_CTA_MERC_CONT_EX'),
                           0,
                           0,
                           V_DCON_MERC_EXEN_LOC, --V('P2986_DCON_MERC_EXEN_LOC'),
                           V_DCON_MERC_EXEN_MON, --V('P2986_DCON_MERC_EXEN_MON'),
                           0,
                           0);
        END IF;
      ELSE
        --IF V('P2986_DCON_MERC_EXEN_LOC') <> 0 THEN
        IF V_DCON_MERC_EXEN_LOC <> 0 THEN
          AGREGAR_CONCEPTO(V('P2986_CONF_CONC_VTA_EXPORT'),
                           V_CLAVE_CTACONT_EXPORT,
                           0,
                           0,
                           V_DCON_MERC_EXEN_LOC, --V('P2986_DCON_MERC_EXEN_LOC'),
                           V_DCON_MERC_EXEN_MON, --V('P2986_DCON_MERC_EXEN_MON'),
                           0,
                           0);
        END IF;
      END IF;
    ELSE
    
      -- si es credito
      -- procesar conceptos gravados
      IF NVL(V('P2986_EXPORTACION'), 'N') = 'N' THEN
        --IF V('P2986_DCON_MERC_GRAV_LOC') <> 0 THEN
        IF V_DCON_MERC_GRAV_LOC <> 0 THEN
          AGREGAR_CONCEPTO(V('P2986_CONF_CONC_VTA_MERC'),
                           V('P2986_W_CTA_MERC_CRED'),
                           V_DCON_MERC_GRAV_LOC, --V('P2986_DCON_MERC_GRAV_LOC'),
                           V_DCON_MERC_GRAV_MON, --V('P2986_DCON_MERC_GRAV_MON'),
                           0,
                           0,
                           0,
                           0);
        END IF;
        -- procesar conceptos exentos
        --IF V('P2986_DCON_MERC_EXEN_LOC') <> 0 THEN
        IF V_DCON_MERC_EXEN_LOC <> 0 THEN
          AGREGAR_CONCEPTO(V('P2986_CONF_CONC_VTA_MERC'),
                           V('P2986_W_CTA_MERC_CRED_EX'),
                           0,
                           0,
                           V_DCON_MERC_EXEN_LOC, --V('P2986_DCON_MERC_EXEN_LOC'),
                           V_DCON_MERC_EXEN_MON, --V('P2986_DCON_MERC_EXEN_MON'),
                           0,
                           0);
        
        END IF;
      
      ELSE
      
        IF V_DCON_MERC_EXEN_LOC = 0 THEN
          RAISE_APPLICATION_ERROR(-20009, 'ERROR');
        END IF;
      
        IF V_DCON_MERC_EXEN_LOC <> 0 THEN
          --IF V('P2986_DCON_MERC_EXEN_LOC') <> 0 THEN
        
          AGREGAR_CONCEPTO(V('P2986_CONF_CONC_VTA_EXPORT'),
                           V_CLAVE_CTACONT_EXPORT,
                           0,
                           0,
                           V_DCON_MERC_EXEN_LOC, --V('P2986_DCON_MERC_EXEN_LOC')
                           V_DCON_MERC_EXEN_MON, --V('P2986_DCON_MERC_EXEN_MON')
                           0,
                           0);
        END IF;
      
        --  RAISE_APPLICATION_ERROR(-20009,'IF ACTIVADO');
      END IF;
    END IF;
  
    IF NVL(V('P2986_EXPORTACION'), 'N') = 'N' THEN
      --Procesar concepto para impuestos por ventas
      --RAISE_APPLICATION_ERROR(-20010, ' ESTA ES LA PARTE DE IVA ' || V('P2986_EXPORTACION')||' '||V('P2986_DET_IVA_LOC')||' '||V('P2986_DET_IVA_MON'));
    
      AGREGAR_CONCEPTO(V('P2986_CONF_CONC_IMPU_VTA'),
                       V('P2986_W_CTA_IMPU'),
                       0,
                       0,
                       0,
                       0,
                       V_DCON_MERC_IVA_LOC, --V('P2986_DET_IVA_LOC'),
                       V_DCON_MERC_IVA_MON); --V('P2986_DET_IVA_MON'));
    END IF;
  
    IF V('P2986_EXPORTACION') = 'S' AND
       V('P2986_S_TOTAL_FLETE_LOC') IS NOT NULL THEN
      --RAISE_APPLICATION_ERROR(-20010, 'error');
      AGREGAR_CONCEPTO(V('P2986_S_CONC_FLETE'),
                       V('P2986_S_CTACO_FLETE'),
                       0,
                       0,
                       V('P2986_S_TOTAL_FLETE_LOC'),
                       V('P2986_S_TOTAL_FLETE_MON'),
                       0,
                       0);
    
    END IF;
    --------------
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, V('P2986_W_CTA_MERC_CONT'));
      RAISE_APPLICATION_ERROR(-20010,
                              'ACA ' || V('P2986_W_CTA_IMPU') || ' X ' ||
                              V('P2986_CONF_CONC_VTA_EXPORT'));
      RAISE_APPLICATION_ERROR(-20010,
                              SQLCODE || ' PROBLEMAS AL CARGAR CONCEPTO');
  END;

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_STK(I_DOCU_CLAVE IN NUMBER) IS
  
    V_IMPU            VARCHAR2(1) := ' ';
    V_COD_OPER        NUMBER := 3;
    ART_UNID_MED      STK_ARTICULO.ART_UNID_MED%TYPE;
    FACTOR_CONVERSION STK_ARTICULO.ART_FACTOR_CONVERSION%TYPE;
  
    NETO_EXEN_LOC NUMBER;
    NETO_EXEN_MON NUMBER;
    NETO_GRAV_LOC NUMBER;
    NETO_GRAV_MON NUMBER;
    IVA_MON       NUMBER;
    IVA_LOC       NUMBER;
    BRUTO_LOC     NUMBER;
    BRUTO_MON     NUMBER;
    NETO_LOC      NUMBER;
    NETO_MON      NUMBER;
    TASA          NUMBER;
  
    CURSOR DETALLES IS
      SELECT SEQ_ID ITEM,
             C001 UNIDAD_VTA,
             C002 ARTICULO,
             TO_NUMBER(C003) NRO_REMISION,
             TO_NUMBER(C004) CANTIDAD,
             TO_NUMBER(C005) PRECIO,
             TO_NUMBER(C007) PESO_UNIDAD,
             TO_NUMBER(C008) PESO_TONELADA,
             TO_NUMBER(C009) DOC_EXENTA_MON,
             TO_NUMBER(C010) DOC_EXENTA_LOC,
             TO_NUMBER(C011) V_DOC_GRAV_MON,
             TO_NUMBER(C012) V_DOC_GRAV_LOC,
             TO_NUMBER(C013) DOC_IVA_MON,
             TO_NUMBER(C014) DOC_IVA_LOC,
             TO_NUMBER(C018) DOC_BRUTO_LOC,
             TO_NUMBER(C019) DOC_BRUTO_MON,
             TO_NUMBER(C020) DOC_NETO_LOC,
             TO_NUMBER(C021) DOC_NETO_MON,
             TO_NUMBER(C030) KG_GANCHO,
             TO_NUMBER(C031) RENDIMIENTO
        FROM APEX_COLLECTIONS A
       WHERE A.COLLECTION_NAME = 'DETALLES_FACI052';
  
  BEGIN
  
    SELECT SUM(C.C009),
           SUM(C.C010),
           SUM(C.C011),
           SUM(C.C012),
           SUM(C.C013),
           SUM(C.C014),
           SUM(C.C018),
           SUM(C.C019),
           SUM(C.C020),
           SUM(C.C021)
      INTO NETO_EXEN_LOC,
           NETO_EXEN_MON,
           NETO_GRAV_MON,
           NETO_GRAV_LOC,
           IVA_MON,
           IVA_LOC,
           BRUTO_LOC,
           BRUTO_MON,
           NETO_LOC,
           NETO_MON
      FROM APEX_COLLECTIONS C
     WHERE C.COLLECTION_NAME = 'DETALLES_FACI052';
  
    /*IF V('P2986_DOC_MON') = 1 THEN
    
    BEGIN
      SELECT COT_TASA
         INTO TASA
         FROM STK_COTIZACION
        WHERE TRUNC(COT_FEC) = V('P2986_DOC_FEC_DOC')
          AND COT_MON = 2
          AND COT_EMPR = V('P_EMPRESA');
    EXCEPTION
         WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20010, SQLCODE||'ERROR EN OBTENER TASA AL MOMENTO DE INSERTAR EN STK_DOCUMENTOS');
    END;
    
     ELSIF V('P2986_DOC_MON') = 2 THEN**/
    TASA := V('P2986_W_DOC_TASA_US');
    --END IF;
  
    -- CARGAMOS CABECERA
    INSERT INTO STK_DOCUMENTO
      (DOCU_CLAVE,
       DOCU_CODIGO_OPER,
       DOCU_NRO_DOC,
       DOCU_EMPR,
       DOCU_SUC_ORIG,
       DOCU_DEP_ORIG,
       DOCU_MON,
       DOCU_CLI,
       DOCU_CLI_NOM,
       DOCU_LEGAJO,
       DOCU_CLAVE_STOPES,
       DOCU_FEC_EMIS,
       DOCU_FEC_OPER,
       DOCU_TIPO_MOV,
       DOCU_TASA_US,
       DOCU_IND_CUOTA,
       DOCU_FEC_GRAB,
       --DOCU_IND_CONSIGNACION,
       DOCU_LOGIN,
       DOCU_SIST,
       DOCU_EXEN_NETO_LOC,
       DOCU_EXEN_NETO_MON,
       DOCU_EXEN_BRUTO_LOC,
       DOCU_EXEN_BRUTO_MON,
       DOCU_GRAV_NETO_LOC,
       DOCU_GRAV_NETO_MON,
       DOCU_GRAV_BRUTO_LOC,
       DOCU_GRAV_BRUTO_MON,
       DOCU_IVA_LOC,
       DOCU_IVA_MON,
       DOCU_OPERADOR)
    VALUES
      (I_DOCU_CLAVE,
       V_COD_OPER,
       V('P2986_DOC_NRO_DOC'),
       V('P_EMPRESA'),
       V('P_SUCURSAL'),
       V('P2986_S_DEP'),
       V('P2986_DOC_MON'),
       V('P2986_DOC_CLI'),
       V('P2986_DOC_CLI_NOM'),
       V('P2986_DOC_LEGAJO'),
       V('P2986_CLAVE_STOPES'),
       V('P2986_DOC_FEC_DOC'),
       V('P2986_DOC_FEC_DOC'),
       V('P2986_DOC_TIPO_MOV'),
       TASA, --V('P2986_W_DOC_TASA_US'),
       V('P2986_IND_CUOTA'),
       SYSDATE,
       V('APP_USER'),
       'FAC',
       NETO_EXEN_LOC,
       NETO_EXEN_MON,
       0, --BRUTO_LOC,
       0, --BRUTO_MON,
       NETO_LOC,
       NETO_MON,
       NETO_GRAV_LOC,
       NETO_GRAV_MON,
       IVA_LOC,
       IVA_MON,
       V('P2986_DOC_OPERADOR'));
  
    -- CARGAMOS DETALLES
    FOR I IN DETALLES LOOP
    
      SELECT ART_UNID_MED, ART_FACTOR_CONVERSION
        INTO ART_UNID_MED, FACTOR_CONVERSION
        FROM GEN_IMPUESTO IM, STK_ENVASES EN, STK_LINEA LI, STK_ARTICULO AR
       WHERE LIN_EMPR = ART_EMPR
         AND LIN_CODIGO = ART_LINEA
         AND IMPU_EMPR = ART_EMPR
         AND IMPU_CODIGO = ART_IMPU
         AND ENVA_EMPR(+) = ART_EMPR
         AND ENVA_LINEA(+) = ART_LINEA
         AND ENVA_CODIGO(+) = ART_ENVASE
         AND ART_EMPR = V('P_EMPRESA')
         AND ART_CODIGO = I.ARTICULO;
    
      IF NVL(V('P2986_IMPU_PORCENTAJE'), 0) = 0 THEN
        V_IMPU := 'N';
      ELSE
        V_IMPU := 'S';
      END IF;
    
      INSERT INTO STK_DOCUMENTO_DET SD
        (SD.DETA_CLAVE_DOC,
         SD.DETA_NRO_ITEM,
         SD.DETA_ART,
         SD.DETA_EMPR,
         SD.DETA_NRO_REM,
         DETA_CANT,
         --DETA_CANT_FACT,
         DETA_IMP_NETO_LOC,
         DETA_IMP_NETO_MON,
         DETA_IMPU,
         DETA_IVA_LOC,
         DETA_IVA_MON,
         DETA_PORC_DTO,
         DETA_IMP_BRUTO_LOC,
         DETA_IMP_BRUTO_MON,
         DETA_PESO_UN,
         DETA_PESO_TT)
      VALUES
        (I_DOCU_CLAVE,
         I.ITEM,
         I.ARTICULO,
         V('P_EMPRESA'),
         I.NRO_REMISION,
         CASE WHEN I.UNIDAD_VTA = 'U' AND ART_UNID_MED = 'KG' THEN
         I.CANTIDAD * NVL(FACTOR_CONVERSION, 1) ELSE I.CANTIDAD END,
         I.DOC_NETO_LOC,
         I.DOC_NETO_MON,
         V_IMPU,
         I.DOC_IVA_LOC,
         I.DOC_IVA_MON,
         V('P2986_S_PORC_DTO'),
         I.DOC_BRUTO_LOC,
         I.DOC_BRUTO_MON,
         I.PESO_UNIDAD,
         I.PESO_TONELADA);
    
    END LOOP;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'Codigo operacion inexistente.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLERRM || ' Error ' || SQLCODE);
  END;

  PROCEDURE PP_ACTUALIZAR_FAC_DOCU_DET(I_DOC_CLAVE_FAC IN NUMBER) IS
    CURSOR DETALLES IS
      SELECT SEQ_ID ITEM,
             C001 UNIDAD_VTA,
             C002 ARTICULO,
             TO_NUMBER(C003) NRO_REMISION,
             TO_NUMBER(C004) CANTIDAD,
             TO_NUMBER(C005) PRECIO,
             TO_NUMBER(C007) PESO_UNIDAD,
             TO_NUMBER(C008) PESO_TONELADA,
             TO_NUMBER(C009) V_DOC_EXENTA_MON,
             TO_NUMBER(C010) V_DOC_EXENTA_LOC,
             TO_NUMBER(C011) V_DOC_GRAV_MON,
             TO_NUMBER(C012) V_DOC_GRAV_LOC,
             TO_NUMBER(C013) V_DOC_IVA_MON,
             TO_NUMBER(C014) V_DOC_IVA_LOC,
             C015 ART_CLASIFICACION,
             C016 V_ART_CTA_CONTABLE,
             C017 V_IMPU_PORCENTAJE,
             TO_NUMBER(C018) DET_BRUTO_LOC,
             TO_NUMBER(C019) DET_BRUTO_MON,
             TO_NUMBER(C020) DET_NETO_LOC,
             TO_NUMBER(C021) DET_NETO_MON,
             TO_NUMBER(C022) DET_IVA_LOC,
             TO_NUMBER(C023) DET_IVA_MON,
             TO_NUMBER(C030) KG_GANCHO,
             TO_NUMBER(C031) RENDIMIENTO
        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'DETALLES_FACI052';
  
  BEGIN
  
    FOR I IN DETALLES LOOP
    
      IF V('P_EMPRESA') = 1 THEN
      
        INSERT INTO FAC_DOCUMENTO_DET FDET
          (DET_CLAVE_DOC,
           DET_NRO_ITEM,
           DET_TIPO_COMISION,
           DET_PORC_DTO,
           DET_CANT,
           DET_CLAVE_PED,
           DET_EMPR,
           DET_COD_IVA,
           DET_ART,
           DET_BRUTO_LOC,
           DET_BRUTO_MON,
           DET_NETO_LOC,
           DET_NETO_MON,
           DET_IVA_LOC,
           DET_IVA_MON)
        VALUES
          (I_DOC_CLAVE_FAC, --V('P2986_DOC_CLAVE'),
           I.ITEM,
           'N',
           V('S_PORC_DTO'),
           I.CANTIDAD,
           V('P2986_DOC_CLI_NRO_PED'),
           V('P_EMPRESA'),
           V('P2986_DET_COD_IVA'),
           I.ARTICULO,
           ROUND(I.DET_BRUTO_LOC),
           I.DET_BRUTO_MON,
           ROUND(I.DET_NETO_LOC),
           I.DET_NETO_MON,
           I.DET_IVA_LOC,
           I.DET_IVA_MON);
      
      ELSE
      
        INSERT INTO FAC_DOCUMENTO_DET FDET
          (DET_CLAVE_DOC,
           DET_NRO_ITEM,
           DET_TIPO_COMISION,
           DET_PORC_DTO,
           DET_CANT,
           DET_CLAVE_PED,
           DET_EMPR,
           DET_COD_IVA,
           DET_ART,
           DET_BRUTO_LOC,
           DET_BRUTO_MON,
           DET_NETO_LOC,
           DET_NETO_MON,
           DET_IVA_LOC,
           DET_IVA_MON,
           DET_PESO_UN,
           DET_PESO_TT,
           DET_KG_GANCHO,
           DET_RENDIMIENTO)
        VALUES
          (I_DOC_CLAVE_FAC, --V('P2986_DOC_CLAVE'),
           I.ITEM,
           'N',
           V('S_PORC_DTO'),
           I.CANTIDAD,
           V('P2986_DOC_CLI_NRO_PED'),
           V('P_EMPRESA'),
           V('P2986_DET_COD_IVA'),
           I.ARTICULO,
           ROUND(I.DET_BRUTO_LOC),
           I.DET_BRUTO_MON,
           ROUND(I.DET_NETO_LOC),
           I.DET_NETO_MON,
           I.DET_IVA_LOC,
           I.DET_IVA_MON,
           I.PESO_UNIDAD,
           I.PESO_TONELADA,
           I.KG_GANCHO,
           I.RENDIMIENTO);
      
      END IF;
    
    END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLCODE || ' Error ' || SQLERRM);
    
  END;

  FUNCTION FP_BUSCAR_ART_COD_ALFANUM RETURN BOOLEAN IS
    V_DET_ART VARCHAR2(60);
  
  BEGIN
  
    SELECT ART_CODIGO
    /*,
    ART_DESC,
    ART_CODIGO_FABRICA,
    ART_MARCA,
    ART_IMPU,
    ART_EST,
    ART_UNID_MED,
    ART_TIPO_COMISION,
    ART_COD_ALFANUMERICO,
    ART_FACTOR_CONVERSION,
    IMPU_PORCENTAJE,
    IMPU_PORC_BASE_IMPONIBLE,
    ART_IND_FACT_NEGATIVO,
    ART_COD_BARRA,
    DECODE(NVL(ENVA_IND_HA, 'N'), 'S',1,0)
    */
    
      INTO V_DET_ART --:BDOC_DET.DET_ART
    /*,
               :BDOC_DET.ART_DESC,
               :BDOC_DET.ART_CODIGO_FABRICA,
               :BDOC_DET.ART_MARCA,
               :BDOC_DET.DET_COD_IVA,
               :BDOC_DET.ART_EST,
               :BDOC_DET.ART_UNID_MED,
               :BDOC_DET.DET_TIPO_COMISION,
               :BDOC_DET.W_ART_COD_ALFANUMERICO,
               :BDOC_DET.ART_FACTOR_CONVERSION,
               :BDOC_DET.S_IMPU,
               :BDOC_DET.S_BASE,
               :BDOC_DET.ART_IND_FACT_NEGATIVO,
               :BDOC_DET.ART_COD_BARRA,
               :BDOC_DET.ENVA_IND_HA
    */
      FROM STK_ARTICULO, GEN_IMPUESTO, STK_ENVASES
     WHERE ART_CODIGO = V('P2986_S_ART') --:BDOC_DET.S_ART
       AND ART_IMPU = IMPU_CODIGO
       AND ENVA_LINEA(+) = ART_LINEA
       AND ENVA_CODIGO(+) = ART_ENVASE
       AND ENVA_EMPR(+) = ART_EMPR
       AND ART_EMPR = IMPU_EMPR
       AND ART_EMPR = V('P_EMPRESA');
  
    SETITEM('P2986_DET_ART', V_DET_ART);
  
    RETURN TRUE;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, 'ERROR CON BUSCAR ARTICULO CODIGO'); --
  
  END;

  PROCEDURE PP_BUSCAR_FLETE_DET IS
  
    V_CONCEPTO     NUMBER;
    V_CTA_CONTABLE NUMBER;
  
  BEGIN
  
    SELECT FC.FCON_CLAVE, CLAS_CTACO_VENTA
      INTO V_CONCEPTO, V_CTA_CONTABLE
      FROM STK_CLASIFICACION C, STK_ARTICULO A, FIN_CONCEPTO FC
     WHERE C.CLAS_CODIGO = A.ART_CLASIFICACION
       AND C.CLAS_CTACO_VENTA = FC.FCON_CLAVE_CTACO(+)
       AND CLAS_EMPR = ART_EMPR
       AND C.CLAS_EMPR = FCON_EMPR(+)
       AND ART_EMPR = V('P_EMPRESA') --1--:parameter.p_empresa
       AND FCON_TIPO_SALDO = 'D'
          --AND (FCON_CLAVE=V_CLAVE_CONCEPTO OR V_CLAVE_CONCEPTO IS NULL)
       AND A.ART_CODIGO = V('P2986_S_ART'); --615282;--articulo;
  
    SETITEM('P2986_S_CONC_FLETE', V_CONCEPTO);
    SETITEM('P2986_S_CTACO_FLETE', V_CTA_CONTABLE);
  
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Existe mas de un concepto asociado a la cuenta contable del Articulo!.');
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'No existe cta contable para mercaderia o el articulo no tiene asignado Ctas Contables!.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, 'Error en PP_BUSCAR_FLETE_DET');
    
  END;
  -------------------------------------------
  PROCEDURE PP_LLAMAR_REPORTE(I_P_CLAVE   IN NUMBER,
                              I_P_CLIENTE IN NUMBER,
                              I_P_EMPRESA IN NUMBER) IS
  
    V_PARAMETROS VARCHAR2(25000);
    V_AMPER      VARCHAR2(2) := '&';
    V_USER       VARCHAR2(60);
    l_report_name varchar2(255 char);
  BEGIN
  
    V_USER := GEN_DEVUELVE_USER;
  
    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = V('APP_USER');
    COMMIT;
  
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_CLAVE=' ||
                    URL_ENCODE(I_P_CLAVE);
  
    V_PARAMETROS := V_PARAMETROS || V_AMPER || 'P_EMPRESA=' ||
                    URL_ENCODE(I_P_EMPRESA);
  
    -- 23/07/2022 8:43:01 @PabloACespedes \(^-^)/
    -- obtiene el nombre del reporte
    -- hilagro transagro 
    if I_P_EMPRESA in (1,2) then
      l_report_name := 'FACP008_1';
    else --> Holding
      l_report_name := 'FACP008_PREIMPRESO';
    end if;
    
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
    --(V_PARAMETROS, V('APP_USER'), 'FACP008', 'pdf');
      (V_PARAMETROS, V_USER, l_report_name, 'pdf');
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, 'Error al generar reporte '||sqlerrm);
    
    /*
      RAISE_APPLICATION_ERROR(-20010,'P_EMPRESA= '||V('P_EMPRESA')||';'||
                                     'P2986_DOC_CLAVE= '|| V('P2986_DOC_CLAVE')||';'||
                                     'P2986_DOC_CLI= '|| V('P2986_DOC_CLI')
                              );
    */
  
  END;

-------------------------------------------

END FACI052;
/
