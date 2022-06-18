-- Create table
create table STK_DOC_EXCEPTION
(
  nro_clave     NUMBER not null,
  motivo        VARCHAR2(255),
  identificador VARCHAR2(25) not null
)
tablespace DATOS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table STK_DOC_EXCEPTION
  is 'Se creo para no mostrar claves en casos especificos';
-- Add comments to the columns 
comment on column STK_DOC_EXCEPTION.nro_clave
  is 'Es la clave que no se querra mostrar o evitara';
comment on column STK_DOC_EXCEPTION.motivo
  is 'Motivo, donde se utiliza, etc';
comment on column STK_DOC_EXCEPTION.identificador
  is 'Necesario para no mezclar nro de claves iguales';
-- Create/Recreate primary, unique and foreign key constraints 
alter table STK_DOC_EXCEPTION
  add constraint STK_DOC_EXCEPTION_PK primary key (NRO_CLAVE, IDENTIFICADOR)
  using index 
  tablespace DATOS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
/
insert into stk_doc_exception(nro_clave,
                              motivo,
                              identificador)
                     values(55555430101, 'En el consumo comb se filtra para que no se vea', 'STK_DOCUMENTO');
/                     
insert into stk_doc_exception(nro_clave,
                              motivo,
                              identificador)
                     values(56632740101, 'En el consumo comb se filtra para que no se vea', 'STK_DOCUMENTO');
/
commit;
/
CREATE OR REPLACE PACKAGE FACI244 IS

  -- AUTHOR  : PROGRAMACION4
  -- CREATED : 30/09/2021 16:02:45
  -- PURPOSE : FACTURACION COMBUSTIBLE  
 
  co_petrobras_comb constant varchar2(22 char) := 'COMBUSTIBLES_PETROBRAS';
  co_faci_det       constant varchar2(11 char) := 'FACI244_DET';            
  
  PROCEDURE PP_INIT_COLLECTION;

  FUNCTION FP_FORMAT_NUM(I_VALOR IN NUMBER) RETURN VARCHAR2;

  PROCEDURE PP_CNTRL_MON_CLI(I_EMPRESA      IN NUMBER,
                             I_DOC_CLI      IN NUMBER,
                             I_TIPO_FACTURA IN NUMBER,
                             O_DOC_MON      OUT NUMBER,
                             O_BLOQ_MON     OUT VARCHAR2);

  PROCEDURE PP_DATOS_CLIENTE(I_EMPRESA           IN NUMBER,
                             I_DOC_CLI           IN NUMBER,
                             I_TIPO_FACTURA      IN NUMBER,
                             O_DOC_CLI_NOM       OUT VARCHAR2,
                             O_DOC_CLI_DIR       OUT VARCHAR2,
                             O_DOC_CLI_RUC       OUT VARCHAR2,
                             O_DOC_CLI_TEL       OUT VARCHAR2,
                             O_CLI_IND_RESP      OUT VARCHAR2,
                             O_DOC_RESP_NOM      OUT VARCHAR2,
                             O_DOC_RESP_CI       OUT VARCHAR2,
                             O_DOC_RESP_TEL      OUT VARCHAR2,
                             O_DOC_PORC_INTERES  OUT NUMBER,
                             O_DOC_TIPO_FEC_INT  OUT VARCHAR2,
                             O_DOC_LEGAJO        OUT NUMBER,
                             O_DOC_CLI_CATEGORIA OUT NUMBER);

  PROCEDURE PP_BUSCAR_COSECHA(I_EMPRESA         IN NUMBER,
                              I_DOC_COSECHA_COD IN NUMBER,
                              O_DOC_PRODUCTO    OUT NUMBER,
                              O_COSECHA_NOMBRE  OUT VARCHAR2,
                              O_COSECHA_VTO     OUT DATE);

  PROCEDURE PP_COTIZACION_COMBUSTIBLE(I_EMPRESA       IN NUMBER,
                                      I_DOC_FEC_DOC   IN DATE,
                                      I_DOC_MON       IN NUMBER,
                                      O_DOC_TASA_US   OUT NUMBER,
                                      O_DOC_TASA_COMB OUT NUMBER);

  PROCEDURE PP_BUSCAR_SALDO_LINEA_CRED(I_EMPRESA           IN NUMBER,
                                       I_DOC_MON           IN NUMBER,
                                       I_DOC_CLI           IN NUMBER,
                                       I_DOC_TASA_US       IN NUMBER,
                                       I_DOC_FEC_DOC       IN DATE,
                                       I_DOC_LINEA_CREDITO IN NUMBER,
                                       O_LIN_CRED_DISP_MD  OUT NUMBER);

  PROCEDURE PP_BUSCAR_LPRECIO(I_EMPRESA     IN NUMBER,
                              I_DOC_CLI     IN NUMBER,
                              I_DOC_MON     IN NUMBER,
                              O_NRO_LPRECIO OUT NUMBER);

  FUNCTION FP_IND_CLI_HILAGRO(I_EMPRESA IN NUMBER, I_DOC_CLI IN NUMBER)
    RETURN VARCHAR2;

  PROCEDURE PP_DATOS_CAMION(I_EMPRESA       IN NUMBER,
                            I_DOC_CAMION    IN NUMBER,
                            O_CAM_DESC      OUT VARCHAR2,
                            O_CAM_CHAPA     OUT VARCHAR2,
                            O_KM_OBLIG      OUT VARCHAR2,
                            O_DOC_HA_CAMION OUT NUMBER,
                            O_NRO_MOVIL_HA  OUT NUMBER);

  PROCEDURE PP_IND_DEP_FLOTA(I_EMPRESA   IN NUMBER,
                             I_SUCURSAL  IN NUMBER,
                             I_DEPOSITO  IN NUMBER,
                             O_IND_FLOTA OUT VARCHAR2);

  PROCEDURE PP_BORRAR_dET(i_seq IN NUMBER);

  PROCEDURE PP_ADD_DET(I_EMPRESA           IN NUMBER,
                       I_SUCURSAL          IN NUMBER,
                       I_NRO_LISTA_PRECIO  IN NUMBER,
                       I_ARTICULO          IN NUMBER,
                       I_CANTIDAD          IN NUMBER,
                       I_PRECIO            IN NUMBER,
                       I_IMPORTE           IN NUMBER,
                       I_DOC_MON           IN NUMBER,
                       I_CLI_PORC_EXEN_IVA IN NUMBER,
                       I_DOC_TASA          IN NUMBER,
                       I_DESCUENTO_GS      IN NUMBER,
                       I_RECARGO           IN NUMBER,
                       I_DOC_TASA_COMB     IN NUMBER,
                       in_es_comb_petrobras in boolean := false
                       );

  PROCEDURE PP_BUSCAR_PRECIO(I_EMPRESA          IN NUMBER,
                             I_ARTICULO         IN NUMBER,
                             I_NRO_LISTA_PRECIO IN NUMBER,
                             I_SUCURSAL         IN NUMBER,
                             I_DOC_MON          IN NUMBER,
                             I_IMPU_PORCENTAJE  IN NUMBER,
                             I_RECARGO          IN NUMBER,
                             I_DOC_TASA_COMB    IN NUMBER,
                             O_PRECIO_VENTA     OUT NUMBER);

  PROCEDURE PP_BUSCAR_IMPUESTO(I_EMPRESA                  IN NUMBER,
                               I_ART_IMPU                 IN NUMBER,
                               O_IMPU_PORCENTAJE          OUT NUMBER,
                               O_IMPU_PORC_BASE_IMPONIBLE OUT NUMBER);

  PROCEDURE PP_DATOS_ARTICULO(I_EMPRESA           IN NUMBER,
                              I_ART_CODIGO        IN NUMBER,
                              I_LIN_NEGOC         IN NUMBER,
                              O_ART_DESC          OUT VARCHAR2,
                              O_ART_CLASIFICACION OUT NUMBER,
                              O_ART_IMPU          OUT NUMBER);

  PROCEDURE PP_HAB_DESCUENTO(I_EMPRESA       IN NUMBER,
                             I_TIPO_FACTURA  IN NUMBER,
                             O_IND_DESCUENTO OUT VARCHAR2);

  PROCEDURE PP_VALIDAR_LINEA_CRED(I_EMPRESA           IN NUMBER,
                                  I_DOC_LINEA_CREDITO IN NUMBER,
                                  I_DOC_FEC_DOC       IN DATE,
                                  I_DOC_CLI_NOM       IN VARCHAR2,
                                  I_DOC_CLI           IN NUMBER,
                                  I_DOC_LINEA_NEGOCIO IN NUMBER,
                                  I_DOC_MON           IN NUMBER,
                                  O_DOC_COSECHA_COD   OUT NUMBER,
                                  O_DOC_TIPO_CREDITO  OUT NUMBER);

  PROCEDURE PP_GENERAR_CUOTA(I_EMPRESA          IN NUMBER,
                             I_FIRTS_VTO        IN DATE,
                             I_CANT_CUOTA       IN NUMBER,
                             I_DOC_MON          IN NUMBER,
                             I_IMPORTE          IN NUMBER,
                             I_TIPO_VENCIMIENTO IN VARCHAR2,
                             I_DIAS_ENTRE       IN NUMBER);

  PROCEDURE PP_BUSCAR_CTA_BCO(I_EMPRESA  IN NUMBER,
                              I_SUCURSAL IN NUMBER,
                              I_DOC_MON  IN NUMBER,
                              O_CTA_BCO  OUT NUMBER);

  PROCEDURE PP_CARGAR_LINEA_NEG(I_EMPRESA           IN NUMBER,
                                I_DOC_LINEA_NEGOCIO IN NUMBER,
                                O_DOC_CONC_CRED     OUT NUMBER);

  PROCEDURE PP_IMPRIMIR_FACTURA(I_EMPRESA IN NUMBER, I_CLAVE IN NUMBER);

  PROCEDURE PP_IMPRIMIR_PAGARE(I_DOC_CLAVE IN NUMBER, I_EMPRESA IN NUMBER);

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_EMPRESA                IN NUMBER,
                                   I_SUCURSAL               IN NUMBER,
                                   I_DEPOSITO               IN NUMBER,
                                   I_TIPO_FACTURA           IN NUMBER,
                                   I_DOC_MON                IN NUMBER,
                                   I_DOC_FEC_DOC            IN DATE,
                                   I_DOC_NRO_DOC            IN NUMBER,
                                   I_DOC_CLI                IN NUMBER,
                                   I_DOC_CLI_NOM            IN VARCHAR2,
                                   I_DOC_CLI_DIR            IN VARCHAR2,
                                   I_DOC_CLI_TEL            IN VARCHAR2,
                                   I_DOC_CLI_RUC            IN VARCHAR2,
                                   I_DOC_NRO_TIMBRADO       IN NUMBER,
                                   I_DOC_PORC_INTERES       IN NUMBER,
                                   I_DOC_TIPO_FEC_INT       IN VARCHAR2,
                                   I_DOC_LINEA_CREDITO      IN NUMBER,
                                   I_LINEA_CRED_IMP_DISP_MD IN NUMBER,
                                   I_DOC_NRO_PCOMPRA_FLOTA  IN NUMBER,
                                   I_DOC_TASA_US            IN NUMBER,
                                   I_DOC_RESP_NOM           IN VARCHAR2,
                                   I_DOC_RESP_CI            IN VARCHAR2,
                                   I_DOC_RESP_TEL           IN VARCHAR2,
                                   I_DOC_LINEA_NEGOCIO      IN NUMBER,
                                   I_DOC_OBS                IN VARCHAR2,
                                   I_DOC_PRODUCTO           IN NUMBER,
                                   I_DOC_CLI_CATEG          IN NUMBER,
                                   I_DOC_LEGAJO             IN NUMBER,
                                   I_DOC_HA_CAMION          IN NUMBER,
                                   I_DOC_HA_KM_ACTUAL       IN NUMBER);

  PROCEDURE PP_IMPRIMIR_FAC_TMU(I_EMPRESA IN NUMBER, I_DOC_CLAVE IN NUMBER);

--------------------------------
  PROCEDURE PP_TRAER_DESC_TARJETA(I_EMPRESA       IN NUMBER,
                                    I_TARJ_CODIGO IN NUMBER,
                                    O_TARJ_DESC   OUT VARCHAR2,
                                    O_TRAJ_TIPO   OUT VARCHAR2);

  PROCEDURE PP_ADD_DET_TARJETA(  I_CODIGO      IN NUMBER,
                              I_DESCRIPCION IN VARCHAR2,
                              I_TIPO        IN VARCHAR2,
                              I_NRO_TARJETA IN NUMBER,
                              I_VENCIMIENTO IN VARCHAR2,
                              I_ORIGEN      IN VARCHAR2,
                              I_IMPORTE     IN NUMBER,
                              I_DOC_FEC_DOC IN VARCHAR2,
                              I_TOTAL_DOC   IN VARCHAR2);

  PROCEDURE PP_BORRAR_TARJETA(I_SEQ IN NUMBER);

  PROCEDURE PP_GUARDAR_TARJETA(I_EMPRESA      IN NUMBER,
                                  I_SUCURSAL     IN NUMBER,
                                  I_DOC_MON      IN NUMBER,
                                  I_DOC_TASA_USD IN NUMBER,
                                  I_DOC_CTA_BCO  IN NUMBER,
                                  I_DOC_NRO_DOC  IN NUMBER,
                                  I_DOC_FEC_DOC  IN VARCHAR2,
                                  I_TIPO_FACTURA IN NUMBER);


  /*
    Author  : @PabloACespedes \(^-^)/
    Created : 17/06/2022 15:58:10
    procedimiento agrega y genera una coleccion con los datos de
    stk_documentos seleccionados
  */
  procedure add_stk_doc_combustible(
    in_datos   varchar2,
    in_empresa number,
    in_sucursal number,
    in_fecha_doc date,
    in_linea_negocio number,
    in_doc_cli       number,
    in_moneda        number
  );
  
  procedure truncate_collection_petrobras;
  
END FACI244;
/
CREATE OR REPLACE PACKAGE BODY FACI244 IS

  TFIN_DOCUMENTO  FIN_DOCUMENTO%ROWTYPE;
  XP_MON_LOC      NUMBER := 1;
  XP_PROGRAMA     VARCHAR2(100) := 'FACI244';
  XP_DOC_OPERADOR NUMBER := 2;
  SIN_PARAMETRO EXCEPTION;
 --
  XP_DOC_CLAVE_PADRE NUMBER;
 --

  PROCEDURE PP_INIT_COLLECTION AS
  BEGIN
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'FACI244_DET');
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'FACI244_CUOTA');
   --
    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'FACI244_TARJETA');
   --
  END PP_INIT_COLLECTION;

  FUNCTION FP_FORMAT_NUM(I_VALOR IN NUMBER) RETURN VARCHAR2 IS
  BEGIN
    NULL;
    RETURN TO_CHAR(I_VALOR, '999G999G999G999G999D00');
  END FP_FORMAT_NUM;

  PROCEDURE PP_UNLOCK_IMPRESORA(I_EMPRESA IN NUMBER, I_NRO_DOC IN NUMBER) IS

  BEGIN

    UPDATE GEN_IMPRESORA
       SET IMP_ULT_FACT = I_NRO_DOC, IMP_LOR = GEN_LUGAR_ORIGEN
     WHERE IMPR_IP = FP_IP_USER
       AND IMP_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'No se puede desbloquar la impresora!.');
  END PP_UNLOCK_IMPRESORA;

  PROCEDURE PP_CNTRL_MON_CLI(I_EMPRESA      IN NUMBER,
                             I_DOC_CLI      IN NUMBER,
                             I_TIPO_FACTURA IN NUMBER,
                             O_DOC_MON      OUT NUMBER,
                             O_BLOQ_MON     OUT VARCHAR2) AS

    V_CLI_FACT_COMB_GS VARCHAR2(2);
    V_CLI_CATEGORIA    NUMBER;
    V_MONEDA           NUMBER := 1;
    V_BLOQ             VARCHAR2(2) := 'N';
  BEGIN

    IF I_DOC_CLI IS NULL THEN
      RAISE SIN_PARAMETRO;
    END IF;

    SELECT NVL(CLI_FACT_COMB_GS, 'N'), T.CLI_CATEG
      INTO V_CLI_FACT_COMB_GS, V_CLI_CATEGORIA
      FROM FIN_CLIENTE T
     WHERE CLI_CODIGO = I_DOC_CLI
       AND T.CLI_EMPR = I_EMPRESA;

    IF I_TIPO_FACTURA = 2 THEN
      --CREDITO
      IF V_CLI_CATEGORIA IN (3, 4, 5) THEN
        --EMPLEADOS DEL GRUPO HILAGRO.
        V_MONEDA := 1; --GS
        V_BLOQ   := 'S';
      ELSE
        V_MONEDA := 2; --USD
        V_BLOQ   := 'S';
      END IF;

      IF V_CLI_FACT_COMB_GS = 'S' THEN
        V_MONEDA := 1; --GS
        V_BLOQ   := 'S';

      END IF;
    ELSE
      --CONTADO
      V_MONEDA := 1; --GS X DEFECTO
      V_BLOQ   := 'S';
    END IF;

    O_BLOQ_MON := V_BLOQ;
    O_DOC_MON  := V_MONEDA;
  EXCEPTION
    WHEN SIN_PARAMETRO THEN
      O_BLOQ_MON := V_BLOQ;
      O_DOC_MON  := V_MONEDA;
  END PP_CNTRL_MON_CLI;

  PROCEDURE PP_DATOS_CLIENTE(I_EMPRESA           IN NUMBER,
                             I_DOC_CLI           IN NUMBER,
                             I_TIPO_FACTURA      IN NUMBER,
                             O_DOC_CLI_NOM       OUT VARCHAR2,
                             O_DOC_CLI_DIR       OUT VARCHAR2,
                             O_DOC_CLI_RUC       OUT VARCHAR2,
                             O_DOC_CLI_TEL       OUT VARCHAR2,
                             O_CLI_IND_RESP      OUT VARCHAR2,
                             O_DOC_RESP_NOM      OUT VARCHAR2,
                             O_DOC_RESP_CI       OUT VARCHAR2,
                             O_DOC_RESP_TEL      OUT VARCHAR2,
                             O_DOC_PORC_INTERES  OUT NUMBER,
                             O_DOC_TIPO_FEC_INT  OUT VARCHAR2,
                             O_DOC_LEGAJO        OUT NUMBER,
                             O_DOC_CLI_CATEGORIA OUT NUMBER) AS

    V_REQ_RESPONSABLE      VARCHAR2(20);
    V_CLI                  FIN_CLIENTE%ROWTYPE;
    V_FLING                FAC_LINEA_NEGOCIO%ROWTYPE;
    V_SEGMENTO_ABREV       VARCHAR2(100);
    V_CLI_PORC_INT_LIN_NEG NUMBER;
  BEGIN
    IF I_TIPO_FACTURA IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Tipo de documento no valido.');
    END IF;

    SELECT *

      INTO V_FLING
      FROM FAC_LINEA_NEGOCIO
     WHERE LIN_CODIGO = 1
       AND LIN_EMPR = I_EMPRESA;

    SELECT T.CLI_NOM,
           T.CLI_DIR,
           T.CLI_RUC,
           T.CLI_TEL,
           CLI_IND_EXIGIR_RESP_FCRED
      INTO V_CLI.CLI_NOM, --O_DOC_CLI_NOM,
           V_CLI.CLI_DIR, --O_DOC_CLI_DIR,
           V_CLI.CLI_RUC, --O_DOC_CLI_RUC,
           V_CLI.CLI_TEL, --O_DOC_CLI_TEL,
           V_REQ_RESPONSABLE
      FROM FIN_CLIENTE T
     WHERE CLI_CODIGO = I_DOC_CLI
       AND T.CLI_EMPR = I_EMPRESA;

    SELECT NVL(SEG_ABREV, 'GEN') SEGMENTO_ABREV
      INTO V_SEGMENTO_ABREV
      FROM FIN_PERSONA P, FIN_SEGMENTO S
     WHERE P.PNA_SEGMENTO = S.SEG_CODIGO(+)
       AND P.PNA_EMPR = S.SEG_EMPR(+)
       AND P.PNA_EMPR = I_EMPRESA
       AND P.PNA_CODIGO = I_DOC_CLI;

    O_DOC_CLI_NOM := V_CLI.CLI_NOM;
    O_DOC_CLI_DIR := V_CLI.CLI_DIR;
    O_DOC_CLI_RUC := V_CLI.CLI_RUC;
    O_DOC_CLI_TEL := V_CLI.CLI_TEL;

    IF I_TIPO_FACTURA = 2 /*AND O_CLI_IND_RESP = 'S'*/
     THEN
      O_CLI_IND_RESP := V_REQ_RESPONSABLE;
      O_DOC_RESP_NOM := V_CLI.CLI_NOM;
      O_DOC_RESP_CI  := V_CLI.CLI_RUC;
      O_DOC_RESP_TEL := V_CLI.CLI_TEL;

    END IF;

    ----------------------------------------------------------------------------
    IF V_SEGMENTO_ABREV = 'VIP' THEN
      V_CLI_PORC_INT_LIN_NEG := NVL(V_FLING.LIN_PORC_INT_VIP, 0);
    ELSE
      V_CLI_PORC_INT_LIN_NEG := NVL(V_FLING.LIN_PORC_INT_GEN, 0);
    END IF;
    ----------------------------------------------------------------------------
    IF NVL(I_TIPO_FACTURA, 1) = 1 THEN
      O_DOC_PORC_INTERES := 0;
    ELSE
      O_DOC_PORC_INTERES := V_CLI_PORC_INT_LIN_NEG;
    END IF;
    ----------------------------------------------------------------------------
    O_DOC_TIPO_FEC_INT := V_FLING.LIN_TIPO_FEC_INT;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
  END PP_DATOS_CLIENTE;

  PROCEDURE PP_BUSCAR_COSECHA(I_EMPRESA         IN NUMBER,
                              I_DOC_COSECHA_COD IN NUMBER,
                              O_DOC_PRODUCTO    OUT NUMBER,
                              O_COSECHA_NOMBRE  OUT VARCHAR2,
                              O_COSECHA_VTO     OUT DATE) IS
    COSECHA_INACTIVA   EXCEPTION;
    COSECHA_SIN_VTO    EXCEPTION;
    SELECCIONAR_VENCIM EXCEPTION;
    SIN_PARAMETRO      EXCEPTION;
    V_ESTADO    VARCHAR2(1);
    V_VENCIM_01 DATE;
    V_VENCIM_02 DATE;

    ----------------------------------------------------------------------------------------
  BEGIN

    IF I_DOC_COSECHA_COD IS NULL THEN
      RAISE SIN_PARAMETRO;
    END IF;

    SELECT PROD_CLAVE,
           PROD_DESC,
           PROD_ESTADO,
           PROD_FECVTO_FAC_IN,
           PROD_FEC_SDO_VTO_FAC_IN

      INTO O_DOC_PRODUCTO,
           O_COSECHA_NOMBRE,
           V_ESTADO,
           V_VENCIM_01,
           V_VENCIM_02

      FROM ACO_PRODUCTO PD
     WHERE PD.PROD_CODIGO = I_DOC_COSECHA_COD
       AND PD.PROD_EMPR = I_EMPRESA;

    IF V_ESTADO = 'I' THEN
      RAISE COSECHA_INACTIVA;
    END IF;

    IF V_VENCIM_01 IS NULL THEN
      RAISE COSECHA_SIN_VTO;
    END IF;

    O_COSECHA_VTO := V_VENCIM_01;

  EXCEPTION
    WHEN SIN_PARAMETRO THEN
      NULL;
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'Cosecha Inexistente!');

    WHEN COSECHA_INACTIVA THEN
      RAISE_APPLICATION_ERROR(-20010, 'Cosecha Inactiva!');

    WHEN COSECHA_SIN_VTO THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Primero debe configurar la fecha de vencimiento para la cosecha [en la opcion 11-1-5 ACOM001]!');
  END PP_BUSCAR_COSECHA;
  ----------------------------------------------------------------------------------------

  PROCEDURE PP_DATOS_LINEA_CREDITO(I_EMPRESA IN NUMBER) AS
  BEGIN

    NULL;
    /*  SELECT NVL(PD.PROD_DESC, TC.TIPC_DESC) || ' |fecLim: ' ||
           NVL(LINC_FEC_LIM_OPER, PD.PROD_FECVTO_FAC_IN) || ' |Nro: ' ||
           LC.LINC_CLAVE A,
           LC.LINC_CLAVE LINC_CLAVE
      FROM FIN_TIPO_CREDITO TC, ACO_PRODUCTO PD, FIN_LINEA_CREDITO LC
     WHERE TC.TIPC_CODIGO = LC.LINC_TIPO_CRED
       AND TC.TIPC_EMPR = LC.LINC_EMPR
       AND PD.PROD_CLAVE(+) = LC.LINC_COSECHA
       AND PD.PROD_EMPR(+) = LC.LINC_EMPR
       AND LINC_ESTADO = 'A'
       AND LC.LINC_EMPR = :P_EMPRESA
       AND LC.LINC_PERSONA = :P6475_DOC_CLI
       AND (TC.TIPC_IND_MULTIM = 'S' OR LC.LINC_MONEDA = :P6475_DOC_CLI)
       AND (LINC_FEC_LIM_OPER >= :P6475_DOC_CLI OR LINC_FEC_LIM_OPER IS NULL)

    */

  END PP_DATOS_LINEA_CREDITO;

  PROCEDURE PP_COTIZACION_COMBUSTIBLE(I_EMPRESA       IN NUMBER,
                                      I_DOC_FEC_DOC   IN DATE,
                                      I_DOC_MON       IN NUMBER,
                                      O_DOC_TASA_US   OUT NUMBER,
                                      O_DOC_TASA_COMB OUT NUMBER) IS

    --V_TASA           STK_COTIZACION.COT_TASA%TYPE;
    V_COMB_DESCUENTO NUMBER;
    V_DOC_MON        NUMBER := 2;
  BEGIN

    SELECT NVL(CONF_DESC_COMBU_PRECIO, 0) A
      INTO V_COMB_DESCUENTO
      FROM FAC_CONFIGURACION
     WHERE CONF_EMPR = I_EMPRESA;

    --PARA FACTURACION DE COMBUSTIBLES SE UTILIZA 100 PUNTOS MENOS SOLICITADO POR GERENCIA.

    SELECT NVL(COT_COMPRA, 0), ROUND(NVL(COT_COMPRA, 0) - V_COMB_DESCUENTO)
      INTO O_DOC_TASA_US, O_DOC_TASA_COMB
      FROM STK_COTIZACION
     WHERE COT_FEC = I_DOC_FEC_DOC
       AND COT_MON = V_DOC_MON
       AND COT_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Primero debe ingresar la cotizacion del ' ||
                              'dia ' || I_DOC_FEC_DOC || ' para la moneda ' ||
                              I_DOC_MON || '!');
  END PP_COTIZACION_COMBUSTIBLE;

  PROCEDURE PP_BUSCAR_SALDO_LINEA_CRED(I_EMPRESA           IN NUMBER,
                                       I_DOC_MON           IN NUMBER,
                                       I_DOC_CLI           IN NUMBER,
                                       I_DOC_TASA_US       IN NUMBER,
                                       I_DOC_FEC_DOC       IN DATE,
                                       I_DOC_LINEA_CREDITO IN NUMBER,
                                       O_LIN_CRED_DISP_MD  OUT NUMBER) IS
    ---------------------------------------------------------------------------------------
    LINEA_SIN_SALDO    EXCEPTION;
    SALDO_INSUFICIENTE EXCEPTION;

    FALTA_PARAMETRO EXCEPTION;

    V_CONCEPTO_CRED      NUMBER;
    V_CLI_CATEG          NUMBER;
    V_CLI_COD_EMPL       NUMBER;
    V_CLI_RAMO           NUMBER;
    V_IMP_CHEQ_DIFERIDO  NUMBER;
    V_IMP_CHEQ_RECHAZADO NUMBER;
    V_IMP_LIM_DISP_GRUPO NUMBER;
    V_IMP_LIM_CR_EMPR    NUMBER;
    V_USAR_LIM_EMPLEADO  NUMBER;

    V_LIMITE_EMPLEADO NUMBER;

    V_LIMITE_CLIENTE   NUMBER;
    V_LIN_CRED_DISP_MD NUMBER;
    ---------------------------------------------------------------------------------------
  BEGIN

    IF I_DOC_MON IS NULL OR I_DOC_CLI IS NULL OR I_DOC_TASA_US IS NULL OR
       I_DOC_FEC_DOC IS NULL OR I_DOC_LINEA_CREDITO IS NULL THEN
      RAISE FALTA_PARAMETRO;
    END IF;

    PK_CU_PERSONA_LC.INICIAR(I_DOC_CLI, NULL, 'DIA', NULL);

    -------------------VALIDAR SI EL CLIENTE ES EMPLEADO Y DEACUERDO A ESO TRAER LA LINEA DE CREDITO

    IF I_EMPRESA = 2 THEN

      SELECT CLI_CATEG, CLI_COD_EMPL_EMPR_ORIG, CLI_RAMO
        INTO V_CLI_CATEG, V_CLI_COD_EMPL, V_CLI_RAMO
        FROM FIN_CLIENTE S
       WHERE CLI_EMPR = 2
         AND CLI_CODIGO = I_DOC_CLI;

      IF V_CLI_CATEG = 4 THEN
        
      if V_CLI_COD_EMPL is null THEN
        RAISE_APPLICATION_ERROR(-20010,'La ficha persona esta incompleta, falta el codigo del empleado a la cual pertenece, favor configurar');
      
      END IF;
        FIN_LIM_CREDITO_EMPLEADO(V_FEC_DOC            => LAST_DAY(I_DOC_FEC_DOC),
                                 V_CLI                => I_DOC_CLI,
                                 V_IMP_LIM_CR_EMPR    => V_IMP_LIM_CR_EMPR,
                                 V_EMPR               => I_EMPRESA,
                                 V_IMP_LIM_DISP_GRUPO => V_IMP_LIM_DISP_GRUPO,
                                 V_IMP_LIM_DISP_EMPR  => V_LIMITE_EMPLEADO, ---:LINEA_CRED_IMP_DISP_MD,
                                 V_IMP_CHEQ_DIFERIDO  => V_IMP_CHEQ_DIFERIDO,
                                 V_IMP_CHEQ_RECHAZADO => V_IMP_CHEQ_RECHAZADO);

      ELSIF V_CLI_CATEG = 3 THEN
        SELECT COUNT(*)
          INTO V_USAR_LIM_EMPLEADO
          FROM PER_EMPLEADO T
         WHERE T.EMPL_CODIGO_CLI = I_DOC_CLI
           AND T.EMPL_CHEK_LIM_CD = 'S'
           AND EMPL_EMPRESA = 2;

        IF V_USAR_LIM_EMPLEADO = 1 THEN
          FIN_LIM_CREDITO_EMPLEADO(V_FEC_DOC            => LAST_DAY(I_DOC_FEC_DOC),
                                   V_CLI                => I_DOC_CLI,
                                   V_IMP_LIM_CR_EMPR    => V_IMP_LIM_CR_EMPR,
                                   V_EMPR               => I_EMPRESA,
                                   V_IMP_LIM_DISP_GRUPO => V_IMP_LIM_DISP_GRUPO,
                                   V_IMP_LIM_DISP_EMPR  => V_LIMITE_EMPLEADO, ---:LINEA_CRED_IMP_DISP_MD,
                                   V_IMP_CHEQ_DIFERIDO  => V_IMP_CHEQ_DIFERIDO,
                                   V_IMP_CHEQ_RECHAZADO => V_IMP_CHEQ_RECHAZADO);

        END IF;

      END IF;
    END IF;

    ------------------****

    ------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------
    V_CONCEPTO_CRED := 3; -- COMBUSTIBLE
    BEGIN
      --COMPROBACION LINEA COMBUSTIBLES
      FIN_IMP_DISP_LINEA(IN_NRO_LIN_CRED => I_DOC_LINEA_CREDITO,
                         IN_CONCEPTO_CRE => V_CONCEPTO_CRED,
                         IN_MONEDA_REQ   => I_DOC_MON,
                         OU_IMPORTE      => V_LIMITE_CLIENTE, ---:LINEA_CRED_IMP_DISP_MD,
                         IN_EMPRESA      => I_EMPRESA);

    END;

    ------------------------------------------------------------------------------------

    IF V_CLI_CATEG = 4 AND I_EMPRESA = 2 THEN

      IF I_DOC_MON = 1 THEN
        V_LIN_CRED_DISP_MD := V_LIMITE_EMPLEADO;
      ELSE
        V_LIN_CRED_DISP_MD := V_LIMITE_EMPLEADO / I_DOC_TASA_US;
      END IF;
    ELSIF V_CLI_CATEG = 3 AND V_USAR_LIM_EMPLEADO = 1 AND I_EMPRESA = 2 THEN
      IF V_LIMITE_EMPLEADO < V_LIMITE_CLIENTE THEN
        V_LIN_CRED_DISP_MD := V_LIMITE_EMPLEADO;
      ELSE
        V_LIN_CRED_DISP_MD := V_LIMITE_CLIENTE;
      END IF;
    ELSE
      V_LIN_CRED_DISP_MD := V_LIMITE_CLIENTE;
    END IF;

    IF NVL(V_LIN_CRED_DISP_MD, 0) <= 0 THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'La cuenta no dispone de saldos  para lineas de Combustibles u Otros creditos!' ||
                              I_DOC_LINEA_CREDITO || '!.');
    END IF;

    O_LIN_CRED_DISP_MD := V_LIN_CRED_DISP_MD;
  EXCEPTION
    WHEN FALTA_PARAMETRO THEN
      NULL;
  END PP_BUSCAR_SALDO_LINEA_CRED;

  PROCEDURE PP_BUSCAR_LPRECIO(I_EMPRESA     IN NUMBER,
                              I_DOC_CLI     IN NUMBER,
                              I_DOC_MON     IN NUMBER,
                              O_NRO_LPRECIO OUT NUMBER) IS

  BEGIN

    SELECT NVL(CLEM_NRO_LISTA_PRECIO, 1)
      INTO O_NRO_LPRECIO
      FROM FIN_CLI_EMPRESA
     WHERE CLEM_EMPR = I_EMPRESA
       AND CLEM_CLI = I_DOC_CLI
       AND CLEM_MON = I_DOC_MON;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_NRO_LPRECIO := 1;

  END PP_BUSCAR_LPRECIO;

  FUNCTION FP_IND_CLI_HILAGRO(I_EMPRESA IN NUMBER, I_DOC_CLI IN NUMBER)
    RETURN VARCHAR2 IS
  BEGIN
    IF I_DOC_CLI = 6 AND I_EMPRESA IS NOT NULL THEN
      RETURN 'S';
    ELSE
      RETURN 'N';
    END IF;

  END FP_IND_CLI_HILAGRO;

  PROCEDURE PP_DATOS_CAMION(I_EMPRESA       IN NUMBER,
                            I_DOC_CAMION    IN NUMBER,
                            O_CAM_DESC      OUT VARCHAR2,
                            O_CAM_CHAPA     OUT VARCHAR2,
                            O_KM_OBLIG      OUT VARCHAR2,
                            O_DOC_HA_CAMION OUT NUMBER,
                            O_NRO_MOVIL_HA  OUT NUMBER) AS
    SIN_PARAMETRO EXCEPTION;
  BEGIN

    IF I_DOC_CAMION IS NULL THEN
      RAISE SIN_PARAMETRO;
    END IF;

    SELECT A.RMAR_VEH_DESC,
           A.RMAR_VEH_CHAPA,
           A.RMAR_VEH_KM_OBLIG,
           A.RMAR_VEH_COD,
           A.RMAR_VEH_NRO_MOVIL
      INTO O_CAM_DESC,
           O_CAM_CHAPA,
           O_KM_OBLIG,
           O_DOC_HA_CAMION,
           O_NRO_MOVIL_HA
      FROM STK_REMI_VEHICULO A
     WHERE A.RMAR_VEH_NRO_MOVIL = I_DOC_CAMION
       AND A.RMAR_EMPR = I_EMPRESA
       AND A.RMAR_VEH_ESTADO = 'A';
  EXCEPTION
    WHEN SIN_PARAMETRO THEN
      NULL;
  END PP_DATOS_CAMION;

  PROCEDURE PP_CTA_CONTABLE(I_EMPRESA          IN NUMBER,
                            I_FCON_CLAVE       IN NUMBER,
                            O_FCON_CLAVE_CTACO OUT NUMBER) IS
  BEGIN
    SELECT FCON_CLAVE_CTACO
      INTO O_FCON_CLAVE_CTACO
      FROM FIN_CONCEPTO
     WHERE FCON_CLAVE = I_FCON_CLAVE
       AND FCON_EMPR = I_EMPRESA;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Error en pp_cta_contable = ' || SQLERRM);

  END PP_CTA_CONTABLE;

  PROCEDURE PP_CONTROL_INFRACCIONES IS
  BEGIN

    FOR C IN (SELECT C.SEQ_ID ITEM,
                     TO_NUMBER(C.C001) ART,
                     TO_NUMBER(C.C001) ARTICULO,
                     TO_NUMBER(C.C002) CANTIDAD,
                     TO_NUMBER(C.C003) PRECIO,
                     TO_NUMBER(C.C004) IMPORTE,
                     TO_NUMBER(C.C005) PRBR_PRODUCTO,
                     TO_NUMBER(C.C010) DOC_EXENTA_MON,
                     TO_NUMBER(C.C011) DOC_EXENTA_LOC,
                     TO_NUMBER(C.C012) DOC_GRAV_MON,
                     TO_NUMBER(C.C013) DOC_GRAV_LOC,
                     TO_NUMBER(C.C014) DOC_IVA_MON,
                     TO_NUMBER(C.C015) DOC_IVA_LOC,
                     TO_NUMBER(C023) ART_IMPU
                FROM APEX_COLLECTIONS C
               WHERE C.COLLECTION_NAME = 'FACI244_DET')

     LOOP
      IF (NVL(C.CANTIDAD, 0) = 0 OR NVL(C.PRECIO, 0) = 0) THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Cantidad y precio debe ser mayor a cero.');
      END IF;
    END LOOP;
  END PP_CONTROL_INFRACCIONES;

  PROCEDURE PP_INSERTAR_CLIENTE(I_EMPRESA     IN NUMBER,
                                I_SUCURSAL    IN NUMBER,
                                I_DOC_CLI_RUC IN VARCHAR2,
                                I_DOC_CLI_NOM IN VARCHAR2,
                                I_DOC_CLI_DIR IN VARCHAR2,
                                I_DOC_CLI_TEL IN VARCHAR2,
                                O_DOC_CLI     OUT NUMBER) IS
    V_DESDE   NUMBER := 1;
    V_RUC     VARCHAR2(20);
    V_RUC_DV  VARCHAR2(20);
    V_DV      VARCHAR2(2);
    V_DOC_CLI NUMBER;
  BEGIN
    --===========================
    IF I_SUCURSAL <> 1 THEN
      V_DESDE := I_SUCURSAL * 10000;
    END IF;

    GEN_CODIGO_LIBRE(COLUMNA         => 'PNA_CODIGO',
                     TABLA           => 'FIN_PERSONA',
                     VALORDESDE      => V_DESDE,
                     CODIGO          => V_DOC_CLI,
                     COLUMNA_EMPRESA => 'PNA_EMPR',
                     EMPRESA         => I_EMPRESA);

    IF I_DOC_CLI_RUC IS NULL THEN

      RAISE_APPLICATION_ERROR(-20010,
                              'El ruc del cliente no puede ser nulo');
    END IF;

    V_RUC := GEN_EXTRAE_SOLO_NROS(I_DOC_CLI_RUC);

    IF I_DOC_CLI_RUC = V_RUC THEN
      V_RUC_DV := I_DOC_CLI_RUC;
      V_DV     := 0;
    ELSE
      V_RUC_DV := SUBSTR(V_RUC, 1, LENGTH(V_RUC) - 1);
      V_DV     := SUBSTR(V_RUC, LENGTH(V_RUC));
    END IF;

    --===========================

    INSERT INTO FIN_PERSONA C
      (PNA_CODIGO,
       PNA_NOMBRE,
       PNA_DIRECCION,
       PNA_TELEFONO,
       PNA_FAX,
       PNA_RUC_DV,
       PNA_DV,
       PNA_PAIS,
       PNA_LUGAR_ORIGEN_REPLICA,
       PNA_EMPR,
       PNA_DOC_TIPO)
    VALUES
      (V_DOC_CLI,
       NVL(I_DOC_CLI_NOM, '.'),
       NVL(I_DOC_CLI_DIR, '.'),
       NVL(I_DOC_CLI_TEL, '.'),
       NULL,
       V_RUC_DV,
       V_DV,
       1,
       GEN_LUGAR_ORIGEN,
       I_EMPRESA,
       2);

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
       CLI_DV,
       CLI_EMPR,
       CLI_DOC_TIPO)
    VALUES
      (V_DOC_CLI,
       NVL(I_DOC_CLI_NOM, '.'),
       NVL(I_DOC_CLI_DIR, '.'),
       NVL(I_DOC_CLI_TEL, '.'),
       NVL(I_DOC_CLI_RUC, '.'),
       2,
       'A',
       1,
       0,
       'N',
       0,
       GEN_LUGAR_ORIGEN,
       V_RUC_DV,
       V_DV,
       I_EMPRESA,
       2);

    INSERT INTO FIN_CLI_EMPRESA
      (CLEM_EMPR,
       CLEM_CLI,
       CLEM_MON,
       CLEM_IMP_LIM_CR,
       CLEM_BLOQ_LIM_CR,
       CLEM_LUGAR_ORIGEN_REPLICA)
    VALUES
      (I_EMPRESA, V_DOC_CLI, 1, 0, 'N', GEN_LUGAR_ORIGEN);

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
       PROV_DOC_TIPO)
    VALUES
      (V_DOC_CLI,
       1,
       NVL(I_DOC_CLI_NOM, '.'),
       NVL(I_DOC_CLI_DIR, '.'),
       NVL(I_DOC_CLI_TEL, '.'),
       NULL,
       NVL(I_DOC_CLI_RUC, '.'),
       'A',
       9,
       NULL,
       GEN_LUGAR_ORIGEN,
       V_DV,
       V_RUC_DV,
       'S',
       'S',
       I_EMPRESA,
       2);

    INSERT INTO FIN_PROV_EMPRESA
      (PREM_EMPR, PREM_PROV, PREM_MON, PREM_LUGAR_ORIGEN_REPLICA)
    VALUES
      (I_EMPRESA, V_DOC_CLI, 1, GEN_LUGAR_ORIGEN);

    O_DOC_CLI := V_DOC_CLI;

  END PP_INSERTAR_CLIENTE;

  PROCEDURE PP_VALIDAR_DUPLICACION_DOC(I_EMPRESA          IN NUMBER,
                                       I_DOC_NRO_DOC      IN NUMBER,
                                       I_DOC_NRO_TIMBRADO IN NUMBER) IS
    V_EXIST NUMBER;
  BEGIN

    SELECT DISTINCT 1
      INTO V_EXIST
      FROM FIN_DOCUMENTO
     WHERE DOC_NRO_DOC = I_DOC_NRO_DOC
       AND DOC_TIPO_MOV IN (9, 10)
       AND DOC_EMPR = I_EMPRESA
       AND NVL(DOC_NRO_TIMBRADO, 0) = NVL(I_DOC_NRO_TIMBRADO, 0);

    RAISE_APPLICATION_ERROR(-20010, 'Numero de factura ya existe');

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
  END PP_VALIDAR_DUPLICACION_DOC;

  PROCEDURE PP_ACT_REL_FIN_STK(I_DOC_NRO_PCOMPRA_FLOTA IN NUMBER) IS
  BEGIN
    IF I_DOC_NRO_PCOMPRA_FLOTA IS NOT NULL THEN
      /*
        Author  : @PabloACespedes \(^-^)/
        Created : 18/06/2022 8:45:44
        registrar consumo de Facturas de PETROBRAS
      */   
      if apex_collection.collection_exists(p_collection_name => co_petrobras_comb) then
        insert into fin_doc_stk_doc(fsd_clave_fin,
                                    fsd_clave_stk,
                                    fsd_empr
                                    )
        select i_doc_nro_pcompra_flota,-->TFIN_DOCUMENTO.DOC_CLAVE
               to_number(a.c001),      --> stk_documento
               to_number(a.c002)       --> empresa
        from apex_collections a
        where a.collection_name = co_petrobras_comb
        and   a.c001 is not null;
      end if;
    END IF;
  END PP_ACT_REL_FIN_STK;

  PROCEDURE PP_ACTUALIZAR_CUOTAS IS
    --V_TOT_DOC_LOC NUMBER := 0;
    --V_TOT_CUO_LOC NUMBER := 0;
    --V_DIFERENCIA  NUMBER := 0;
    V_MON_DEC_IMP NUMBER;
    V_FCUO        FIN_CUOTA%ROWTYPE;
  BEGIN
    NULL;

    BEGIN
      SELECT M.MON_DEC_IMP
        INTO V_MON_DEC_IMP
        FROM GEN_MONEDA M
       WHERE M.MON_CODIGO = TFIN_DOCUMENTO.DOC_MON
         AND M.MON_EMPR = TFIN_DOCUMENTO.DOC_EMPR;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010, 'Error no se encontro la moneda');
    END;

    -- ASIGNAR DATOS A LOS DEMAS ELEMENTOS DEL BLOQUE
    FOR C IN (SELECT TO_DATE(C.C001, 'DD/MM/YYYY') FEC_VTO,
                     TO_NUMBER(C.C002) IMP_CUOTA
                FROM APEX_COLLECTIONS C
               WHERE C.COLLECTION_NAME = 'FACI244_CUOTA') LOOP
      V_FCUO.CUO_CLAVE_DOC := TFIN_DOCUMENTO.DOC_CLAVE;
      V_FCUO.CUO_EMPR      := TFIN_DOCUMENTO.DOC_EMPR;
      V_FCUO.CUO_FEC_VTO   := C.FEC_VTO;
      V_FCUO.CUO_IMP_MON   := C.IMP_CUOTA;

      IF TFIN_DOCUMENTO.DOC_MON = XP_MON_LOC THEN
        V_FCUO.CUO_IMP_LOC := ROUND(V_FCUO.CUO_IMP_MON,
                                    V_MON_DEC_IMP);
        V_FCUO.CUO_IMP_MON := ROUND(V_FCUO.CUO_IMP_MON,
                                    V_MON_DEC_IMP);
      ELSE
        V_FCUO.CUO_IMP_LOC := ROUND(V_FCUO.CUO_IMP_MON *
                                    TFIN_DOCUMENTO.DOC_TASA,
                                    V_MON_DEC_IMP);

        V_FCUO.CUO_IMP_MON := ROUND(V_FCUO.CUO_IMP_MON,
                                    V_MON_DEC_IMP);
      END IF;
      INSERT INTO FIN_CUOTA VALUES V_FCUO;
    END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, 'error cuotas');
  END PP_ACTUALIZAR_CUOTAS;

  PROCEDURE PP_ACTUALIZAR_DOC_CONCEPTO(I_EMPRESA   IN NUMBER,
                                       I_DOC_CLAVE IN NUMBER) IS
    V_ITEM        NUMBER := 0;
    V_DCON        FIN_DOC_CONCEPTO%ROWTYPE;
    V_FACCONF     FAC_CONFIGURACION%ROWTYPE;
    V_CLAVE_CTACO NUMBER;

    PROCEDURE AGREGAR_CONCEPTO(IN_CONC     IN NUMBER,
                               IN_CTACO    IN NUMBER,
                               IN_GRAV_LOC IN NUMBER,
                               IN_GRAV_MON IN NUMBER,
                               IN_EXEN_LOC IN NUMBER,
                               IN_EXEN_MON IN NUMBER,
                               IN_IVA_LOC  IN NUMBER,
                               IN_IVA_MON  IN NUMBER,
                               IN_PORC_IVA IN NUMBER) IS

    BEGIN

      IF (IN_GRAV_LOC + IN_EXEN_LOC + IN_IVA_LOC) > 0 THEN
        V_ITEM                     := V_ITEM + 1;
        V_DCON.DCON_EMPR           := I_EMPRESA;
        V_DCON.DCON_CLAVE_DOC      := I_DOC_CLAVE;
        V_DCON.DCON_ITEM           := V_ITEM;
        V_DCON.DCON_CLAVE_CONCEPTO := IN_CONC;
        V_DCON.DCON_TIPO_SALDO     := 'D';
        V_DCON.DCON_CLAVE_CTACO    := IN_CTACO;
        V_DCON.DCON_GRAV_LOC       := IN_GRAV_LOC;
        V_DCON.DCON_GRAV_MON       := IN_GRAV_MON;
        V_DCON.DCON_EXEN_LOC       := IN_EXEN_LOC;
        V_DCON.DCON_EXEN_MON       := IN_EXEN_MON;
        V_DCON.DCON_IVA_LOC        := IN_IVA_LOC;
        V_DCON.DCON_IVA_MON        := IN_IVA_MON;
        V_DCON.DCON_PORC_IVA       := IN_PORC_IVA;

        INSERT INTO FIN_DOC_CONCEPTO VALUES V_DCON;

      END IF;
    END AGREGAR_CONCEPTO;

  BEGIN

    SELECT *
      INTO V_FACCONF
      FROM FAC_CONFIGURACION
     WHERE CONF_EMPR = I_EMPRESA;

    -- PP_CALCULAR_TOTALES_CONCEPTO;
    -- PROCESAR CONCEPTOS PARA VENTA DE MERCADERIAS, CONTADO
    -- PROCESAR CONCEPTOS GRAVADO

    FOR C IN (SELECT C.SEQ_ID ITEM,
                     TO_NUMBER(C.C001) ART,
                     TO_NUMBER(C.C001) ARTICULO,
                     TO_NUMBER(C.C002) CANTIDAD,
                     TO_NUMBER(C.C003) PRECIO,
                     TO_NUMBER(C.C004) IMPORTE,
                     TO_NUMBER(C.C010) DOC_EXENTA_MON,
                     TO_NUMBER(C.C011) DOC_EXENTA_LOC,
                     TO_NUMBER(C.C012) DOC_GRAV_MON,
                     TO_NUMBER(C.C013) DOC_GRAV_LOC,
                     TO_NUMBER(C.C014) DOC_IVA_MON,
                     TO_NUMBER(C.C015) DOC_IVA_LOC,
                     C020 ART_CLASIFICACION,
                     C021 ART_CTA_CONTABLE,
                     C022 IMPU_PORCENTAJE
                FROM APEX_COLLECTIONS C
               WHERE C.COLLECTION_NAME = 'FACI244_DET') LOOP

      IF C.DOC_GRAV_LOC <> 0 THEN

        AGREGAR_CONCEPTO(IN_CONC     => V_FACCONF.CONF_CONC_VTA_MERC,
                         IN_CTACO    => C.ART_CTA_CONTABLE,
                         IN_GRAV_LOC => NVL(C.DOC_GRAV_LOC, 0),
                         IN_GRAV_MON => NVL(C.DOC_GRAV_MON, 0),
                         IN_EXEN_LOC => 0,
                         IN_EXEN_MON => 0,
                         IN_IVA_LOC  => 0,
                         IN_IVA_MON  => 0,
                         IN_PORC_IVA => NVL(C.IMPU_PORCENTAJE, 0));
      END IF;

      IF C.DOC_EXENTA_LOC <> 0 THEN
        AGREGAR_CONCEPTO(IN_CONC     => V_FACCONF.CONF_CONC_VTA_MERC,
                         IN_CTACO    => C.ART_CTA_CONTABLE,
                         IN_GRAV_LOC => 0,
                         IN_GRAV_MON => 0,
                         IN_EXEN_LOC => NVL(C.DOC_EXENTA_LOC, 0),
                         IN_EXEN_MON => NVL(C.DOC_EXENTA_MON, 0),
                         IN_IVA_LOC  => 0,
                         IN_IVA_MON  => 0,
                         IN_PORC_IVA => NVL(C.IMPU_PORCENTAJE, 0));
      END IF;

      IF C.DOC_IVA_LOC <> 0 THEN
        -- IF C.IMPU_PORCENTAJE = 10 THEN
        PP_CTA_CONTABLE(I_EMPRESA          => I_EMPRESA,
                        I_FCON_CLAVE       => V_FACCONF.CONF_CONC_IMPU_VTA,
                        O_FCON_CLAVE_CTACO => V_CLAVE_CTACO);

        AGREGAR_CONCEPTO(IN_CONC     => V_FACCONF.CONF_CONC_IMPU_VTA,
                         IN_CTACO    => V_CLAVE_CTACO,
                         IN_GRAV_LOC => 0,
                         IN_GRAV_MON => 0,
                         IN_EXEN_LOC => 0,
                         IN_EXEN_MON => 0,
                         IN_IVA_LOC  => NVL(C.DOC_IVA_LOC, 0),
                         IN_IVA_MON  => NVL(C.DOC_IVA_MON, 0),
                         IN_PORC_IVA => NVL(C.IMPU_PORCENTAJE, 0));
        /*ELSE

          PP_CTA_CONTABLE(I_EMPRESA          => I_EMPRESA,
                          I_FCON_CLAVE       => V_FACCONF.CONF_CONC_IMPU_VTA_5,
                          O_FCON_CLAVE_CTACO => V_CLAVE_CTACO);

          AGREGAR_CONCEPTO(IN_CONC     => V_FACCONF.CONF_CONC_IMPU_VTA_5,
                           IN_CTACO    => V_CLAVE_CTACO,
                           IN_GRAV_LOC => 0,
                           IN_GRAV_MON => 0,
                           IN_EXEN_LOC => 0,
                           IN_EXEN_MON => 0,
                           IN_IVA_LOC  => NVL(C.DOC_IVA_LOC, 0),
                           IN_IVA_MON  => NVL(C.DOC_IVA_MON, 0),
                           IN_PORC_IVA => NVL(C.IMPU_PORCENTAJE, 0));
        END IF;-**/
      END IF;

    END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, 'error en conceptos');
  END PP_ACTUALIZAR_DOC_CONCEPTO;

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_STK(I_DEPOSITO         IN NUMBER,
                                        I_DOC_HA_CAMION    IN NUMBER,
                                        I_DOC_HA_KM_ACTUAL IN NUMBER) IS

    V_IMPU             VARCHAR2(5) := ' ';
    VSTK_DOCUMENTO     STK_DOCUMENTO%ROWTYPE;
    VSTK_DOCUMENTO_DET STK_DOCUMENTO_DET%ROWTYPE;
  BEGIN

    VSTK_DOCUMENTO.DOCU_CLAVE            := TFIN_DOCUMENTO.DOC_CLAVE_STK;
    VSTK_DOCUMENTO.DOCU_CODIGO_OPER      := 3;
    VSTK_DOCUMENTO.DOCU_NRO_DOC          := TFIN_DOCUMENTO.DOC_NRO_DOC;
    VSTK_DOCUMENTO.DOCU_EMPR             := TFIN_DOCUMENTO.DOC_EMPR;
    VSTK_DOCUMENTO.DOCU_SUC_ORIG         := TFIN_DOCUMENTO.DOC_SUC;
    VSTK_DOCUMENTO.DOCU_DEP_ORIG         := I_DEPOSITO;
    VSTK_DOCUMENTO.DOCU_MON              := TFIN_DOCUMENTO.DOC_MON;
    VSTK_DOCUMENTO.DOCU_CLI              := TFIN_DOCUMENTO.DOC_CLI;
    VSTK_DOCUMENTO.DOCU_CLI_NOM          := TFIN_DOCUMENTO.DOC_CLI_NOM;
    VSTK_DOCUMENTO.DOCU_CLI_RUC          := TFIN_DOCUMENTO.DOC_CLI_RUC;
    VSTK_DOCUMENTO.DOCU_LEGAJO           := TFIN_DOCUMENTO.DOC_LEGAJO;
    VSTK_DOCUMENTO.DOCU_FEC_EMIS         := TFIN_DOCUMENTO.DOC_FEC_DOC;
    VSTK_DOCUMENTO.DOCU_TIPO_MOV         := TFIN_DOCUMENTO.DOC_TIPO_MOV;
    VSTK_DOCUMENTO.DOCU_TASA_US          := TFIN_DOCUMENTO.DOC_TASA_USD;
    VSTK_DOCUMENTO.DOCU_IND_CUOTA        := TFIN_DOCUMENTO.DOC_IND_CUOTA;
    VSTK_DOCUMENTO.DOCU_FEC_GRAB         := TFIN_DOCUMENTO.DOC_FEC_GRAB;
    VSTK_DOCUMENTO.DOCU_IND_CONSIGNACION := TFIN_DOCUMENTO.DOC_IND_CONSIGNACION;
    VSTK_DOCUMENTO.DOCU_LOGIN            := TFIN_DOCUMENTO.DOC_LOGIN;
    VSTK_DOCUMENTO.DOCU_SIST             := TFIN_DOCUMENTO.DOC_SIST;
    VSTK_DOCUMENTO.DOCU_OPERADOR         := TFIN_DOCUMENTO.DOC_OPERADOR;
    VSTK_DOCUMENTO.DOCU_GRAV_NETO_LOC    := TFIN_DOCUMENTO.DOC_NETO_GRAV_LOC;
    VSTK_DOCUMENTO.DOCU_GRAV_NETO_MON    := TFIN_DOCUMENTO.DOC_NETO_GRAV_MON;
    VSTK_DOCUMENTO.DOCU_GRAV_BRUTO_LOC   := TFIN_DOCUMENTO.DOC_BRUTO_GRAV_LOC;
    VSTK_DOCUMENTO.DOCU_GRAV_BRUTO_MON   := TFIN_DOCUMENTO.DOC_BRUTO_GRAV_MON;
    VSTK_DOCUMENTO.DOCU_EXEN_NETO_LOC    := TFIN_DOCUMENTO.DOC_NETO_EXEN_LOC;
    VSTK_DOCUMENTO.DOCU_EXEN_NETO_MON    := TFIN_DOCUMENTO.DOC_NETO_EXEN_MON;
    VSTK_DOCUMENTO.DOCU_EXEN_BRUTO_LOC   := TFIN_DOCUMENTO.DOC_BRUTO_EXEN_LOC;
    VSTK_DOCUMENTO.DOCU_EXEN_BRUTO_MON   := TFIN_DOCUMENTO.DOC_BRUTO_EXEN_MON;
    VSTK_DOCUMENTO.DOCU_IVA_LOC          := TFIN_DOCUMENTO.DOC_IVA_LOC;
    VSTK_DOCUMENTO.DOCU_IVA_MON          := TFIN_DOCUMENTO.DOC_IVA_MON;
    VSTK_DOCUMENTO.DOCU_HA_CAMION        := I_DOC_HA_CAMION;
    VSTK_DOCUMENTO.DOCU_HA_KM_ACTUAL     := I_DOC_HA_KM_ACTUAL;
    VSTK_DOCUMENTO.DOCU_OBS              := TFIN_DOCUMENTO.DOC_RESP_NOM;

    VSTK_DOCUMENTO.DOCU_TIPO_DOC_CLI_PROV  := TFIN_DOCUMENTO.DOC_TIPO_DOC_CLI_PROV;---LV
    VSTK_DOCUMENTO.DOCU_TIPO_FACTURA       := TFIN_DOCUMENTO.DOC_TIPO_FACTURA;
    INSERT INTO STK_DOCUMENTO VALUES VSTK_DOCUMENTO;

    FOR C IN (SELECT C.SEQ_ID ITEM,
                     TO_NUMBER(C.C001) ART,
                     TO_NUMBER(C.C002) CANTIDAD,
                     TO_NUMBER(C.C003) PRECIO,
                     TO_NUMBER(C.C004) IMPORTE,
                     TO_NUMBER(C.C006) DESCUENTO_GS,
                     TO_NUMBER(C.C010) DOC_EXENTA_MON,
                     TO_NUMBER(C.C011) DOC_EXENTA_LOC,
                     TO_NUMBER(C.C012) DOC_GRAV_MON,
                     TO_NUMBER(C.C013) DOC_GRAV_LOC,
                     TO_NUMBER(C.C014) DOC_IVA_MON,
                     TO_NUMBER(C.C015) DOC_IVA_LOC,
                     TO_NUMBER(C023) ART_IMPU
                FROM APEX_COLLECTIONS C
               WHERE C.COLLECTION_NAME = 'FACI244_DET') LOOP

      VSTK_DOCUMENTO_DET.DETA_CLAVE_DOC     := VSTK_DOCUMENTO.DOCU_CLAVE;
      VSTK_DOCUMENTO_DET.DETA_NRO_ITEM      := C.ITEM;
      VSTK_DOCUMENTO_DET.DETA_ART           := C.ART;
      VSTK_DOCUMENTO_DET.DETA_EMPR          := VSTK_DOCUMENTO.DOCU_EMPR;
      VSTK_DOCUMENTO_DET.DETA_NRO_REM       := NULL;
      VSTK_DOCUMENTO_DET.DETA_CANT          := C.CANTIDAD;
      VSTK_DOCUMENTO_DET.DETA_IMP_BRUTO_LOC := NVL(C.DOC_GRAV_LOC, 0) +
                                               NVL(C.DOC_EXENTA_LOC, 0);
      VSTK_DOCUMENTO_DET.DETA_IMP_BRUTO_MON := NVL(C.DOC_GRAV_MON, 0) +
                                               NVL(C.DOC_EXENTA_MON, 0);
      VSTK_DOCUMENTO_DET.DETA_IMP_NETO_MON  := NVL(C.DOC_GRAV_MON, 0) +
                                               NVL(C.DOC_EXENTA_MON, 0);
      VSTK_DOCUMENTO_DET.DETA_IMP_NETO_LOC  := NVL(C.DOC_GRAV_LOC, 0) +
                                               NVL(C.DOC_EXENTA_LOC, 0);
      VSTK_DOCUMENTO_DET.DETA_IVA_LOC       := C.DOC_IVA_LOC;
      VSTK_DOCUMENTO_DET.DETA_IVA_MON       := C.DOC_IVA_MON;
      VSTK_DOCUMENTO_DET.DETA_PORC_COMISION := 0;
      VSTK_DOCUMENTO_DET.DETA_DESC_POR_CANT := C.DESCUENTO_GS;

      IF NVL(C.ART_IMPU, 0) = 1 THEN
        V_IMPU := 'N';
      ELSE
        V_IMPU := 'S';
      END IF;

      VSTK_DOCUMENTO_DET.DETA_IMPU := V_IMPU;

      INSERT INTO STK_DOCUMENTO_DET VALUES VSTK_DOCUMENTO_DET;
    END LOOP;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010, 'Codigo operacion inexistente.');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Error en pp_actualizar_documento_stk ' ||
                              SQLERRM);
  END PP_ACTUALIZAR_DOCUMENTO_STK;

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_FIN(I_EMPRESA               IN NUMBER,
                                        I_SUCURSAL              IN NUMBER,
                                        I_DEPOSITO              IN NUMBER,
                                        I_TIPO_FACTURA          IN NUMBER,
                                        I_DOC_MON               IN NUMBER,
                                        I_DOC_NRO_TIMBRADO      IN NUMBER,
                                        I_DOC_FEC_DOC           IN DATE,
                                        I_DOC_NRO_DOC           IN NUMBER,
                                        I_DOC_CTA_BCO           IN NUMBER,
                                        I_DOC_TASA_US           IN NUMBER,
                                        I_DOC_CLI               IN NUMBER,
                                        I_DOC_CLI_NOM           IN VARCHAR2,
                                        I_DOC_CLI_DIR           IN VARCHAR2,
                                        I_DOC_CLI_TEL           IN VARCHAR2,
                                        I_DOC_CLI_RUC           IN VARCHAR2,
                                        I_DOC_RESP_NOM          IN VARCHAR2,
                                        I_DOC_RESP_CI           IN VARCHAR2,
                                        I_DOC_RESP_TEL          IN VARCHAR2,
                                        I_DOC_LINEA_NEGOCIO     IN NUMBER,
                                        I_DOC_PORC_INTERES      IN NUMBER,
                                        I_DOC_TIPO_FEC_INT      IN VARCHAR2,
                                        I_DOC_OBS               IN VARCHAR2,
                                        I_DOC_NRO_PCOMPRA_FLOTA IN NUMBER,
                                        I_DOC_PRODUCTO          IN NUMBER,
                                        I_DOC_CONC_CRED         IN NUMBER,
                                        I_DOC_TIPO_CREDITO      IN NUMBER,
                                        I_DOC_LINEA_CREDITO     IN NUMBER,
                                        I_DOC_CLI_CATEG         IN NUMBER,
                                        I_DOC_LEGAJO            IN NUMBER) IS
    V_CLAVE_PRUEBA_FIN NUMBER;
    V_CLAVE_PRUEBA_STK NUMBER;
    V_NRO_DOC          NUMBER;
    V_TASA             NUMBER;
    V_FDET             FAC_DOCUMENTO_DET%ROWTYPE;
    V_TOT_DOC          NUMBER;
    V_TIPO_DOC_PROV_CLI NUMBER;
  BEGIN


     IF  V('P_EMPRESA') IN (1,2) THEN-------------LV
            IF I_DOC_CLI IS NOT NULL THEN
               SELECT CLI_DOC_TIPO
                 INTO V_TIPO_DOC_PROV_CLI
                 FROM FIN_CLIENTE
                WHERE CLI_EMPR = V('P_EMPRESA')
                  AND CLI_CODIGO = I_DOC_CLI;
          IF V_TIPO_DOC_PROV_CLI IS NULL THEN
                     RAISE_APPLICATION_ERROR (-20001,'!FAVOR, CONFIGURAR EL TIPO DE DOCUMENTO DEL CLIENTE ANTES DE CONTINUAR- PROG 2-1-100!');
                  END IF;
           IF V_TIPO_DOC_PROV_CLI IS NULL THEN
                RAISE_APPLICATION_ERROR (-20001,'!FAVOR, CONFIGURAR EL TIPO DE DOCUMENTO DEL CLIENTE ANTES DE CONTINUAR- PROG 2-1-100!');
           END IF;
           END IF;
      END IF;



    IF I_DOC_MON = XP_MON_LOC THEN
      V_TASA := 1;
    ELSE
      V_TASA := I_DOC_TASA_US;
    END IF;

    -- CARGA CAMPOS DE PARAMETROS PARA EL REPORT --*

    IF I_TIPO_FACTURA IN (1, 3) THEN
      --:BDOC_ENCA.W_TIPO_FAC  := 'CONTADO';
      --:BDOC_ENCA.W_TIPO_FAC  := 'IVA INCLUIDO';
      TFIN_DOCUMENTO.DOC_CTA_BCO := I_DOC_CTA_BCO;
    ELSE
      --:BDOC_ENCA.W_TIPO_FAC  := 'CREDITO';
      TFIN_DOCUMENTO.DOC_CTA_BCO := NULL;
    END IF;

    IF I_TIPO_FACTURA IN (1, 3) THEN
      TFIN_DOCUMENTO.DOC_COND_VTA := 1;
      TFIN_DOCUMENTO.DOC_TIPO_MOV := 9;
    ELSE
      TFIN_DOCUMENTO.DOC_COND_VTA := 2;
      TFIN_DOCUMENTO.DOC_TIPO_MOV := 10;
    END IF;

    SELECT TMOV_TIPO
      INTO TFIN_DOCUMENTO.DOC_TIPO_SALDO
      FROM GEN_TIPO_MOV
     WHERE TMOV_CODIGO = TFIN_DOCUMENTO.DOC_TIPO_MOV
       AND TMOV_EMPR = I_EMPRESA;

    V_CLAVE_PRUEBA_FIN         := FIN_SEQ_DOC_NEXTVAL;
   --
    XP_DOC_CLAVE_PADRE          :=V_CLAVE_PRUEBA_FIN;
   --
    V_CLAVE_PRUEBA_STK         := STK_SEQ_DOCU_NEXTVAL;
    V_NRO_DOC                  := I_DOC_NRO_DOC;
    TFIN_DOCUMENTO.DOC_CLAVE   := V_CLAVE_PRUEBA_FIN;
    TFIN_DOCUMENTO.DOC_EMPR    := I_EMPRESA;
    TFIN_DOCUMENTO.DOC_SUC     := I_SUCURSAL;
    TFIN_DOCUMENTO.DOC_NRO_DOC := V_NRO_DOC;
    TFIN_DOCUMENTO.DOC_MON     := I_DOC_MON;
    TFIN_DOCUMENTO.DOC_CLI_NOM := I_DOC_CLI_NOM;
    TFIN_DOCUMENTO.DOC_CLI_DIR := I_DOC_CLI_DIR;
    TFIN_DOCUMENTO.DOC_CLI_RUC := I_DOC_CLI_RUC;
    TFIN_DOCUMENTO.DOC_CLI_TEL := I_DOC_CLI_TEL;
    TFIN_DOCUMENTO.DOC_CLI     := I_DOC_CLI;
    TFIN_DOCUMENTO.DOC_LEGAJO  := I_DOC_LEGAJO;

    TFIN_DOCUMENTO.DOC_FEC_GRAB := SYSDATE;
    TFIN_DOCUMENTO.DOC_FEC_OPER := I_DOC_FEC_DOC;
    TFIN_DOCUMENTO.DOC_FEC_DOC  := I_DOC_FEC_DOC;

    TFIN_DOCUMENTO.DOC_TIPO_DOC_CLI_PROV := V_TIPO_DOC_PROV_CLI; ---LV
    TFIN_DOCUMENTO.DOC_TIPO_FACTURA      := 1;

    SELECT SUM(to_number(C.C011)) DOC_EXENTA_LOC,
           SUM(to_number(C.C010)) DOC_EXENTA_MON,
           SUM(to_number(C.C013)) DOC_GRAV_LOC,
           SUM(to_number(C.C012)) DOC_GRAV_MON,
           SUM(to_number(C.C014)) DOC_IVA_MON,
           SUM(to_number(C.C015)) DOC_IVA_LOC,
           SUM(to_number(C.C004)) IMPORTE
      INTO TFIN_DOCUMENTO.DOC_NETO_EXEN_LOC,
           TFIN_DOCUMENTO.DOC_NETO_EXEN_MON,
           TFIN_DOCUMENTO.DOC_NETO_GRAV_LOC,
           TFIN_DOCUMENTO.DOC_NETO_GRAV_MON,
           TFIN_DOCUMENTO.DOC_IVA_MON,
           TFIN_DOCUMENTO.DOC_IVA_LOC,
           V_TOT_DOC
      FROM APEX_COLLECTIONS C
     WHERE C.COLLECTION_NAME = 'FACI244_DET';

 --  raise_application_error(-20001, TFIN_DOCUMENTO.DOC_NETO_EXEN_MON||' '||TFIN_DOCUMENTO.DOC_NETO_GRAV_MON|| TFIN_DOCUMENTO.DOC_IVA_MON);
    TFIN_DOCUMENTO.DOC_BRUTO_EXEN_LOC := TFIN_DOCUMENTO.DOC_NETO_EXEN_LOC;
    TFIN_DOCUMENTO.DOC_BRUTO_EXEN_MON := TFIN_DOCUMENTO.DOC_NETO_EXEN_MON;
    TFIN_DOCUMENTO.DOC_BRUTO_GRAV_LOC := TFIN_DOCUMENTO.DOC_NETO_GRAV_LOC;
    TFIN_DOCUMENTO.DOC_BRUTO_GRAV_MON := TFIN_DOCUMENTO.DOC_NETO_GRAV_MON;

    TFIN_DOCUMENTO.DOC_BASE_IMPON_LOC    := NULL;
    TFIN_DOCUMENTO.DOC_BASE_IMPON_MON    := NULL;
    TFIN_DOCUMENTO.DOC_IND_STK           := 'S';
    TFIN_DOCUMENTO.DOC_CLAVE_STK         := V_CLAVE_PRUEBA_STK;
    TFIN_DOCUMENTO.DOC_LOGIN             := GEN_DEVUELVE_USER;
    TFIN_DOCUMENTO.DOC_SIST              := SUBSTR(XP_PROGRAMA, 1, 3);
    TFIN_DOCUMENTO.DOC_OPERADOR          := XP_DOC_OPERADOR;
    TFIN_DOCUMENTO.DOC_NRO_TIMBRADO      := I_DOC_NRO_TIMBRADO;
    TFIN_DOCUMENTO.DOC_RESP_NOM          := I_DOC_RESP_NOM;
    TFIN_DOCUMENTO.DOC_RESP_CI           := I_DOC_RESP_CI;
    TFIN_DOCUMENTO.DOC_RESP_TEL          := I_DOC_RESP_TEL;
    TFIN_DOCUMENTO.DOC_LINEA_NEGOCIO     := I_DOC_LINEA_NEGOCIO;
    TFIN_DOCUMENTO.DOC_PORC_INTERES      := I_DOC_PORC_INTERES;
    TFIN_DOCUMENTO.DOC_TIPO_FEC_INT      := I_DOC_TIPO_FEC_INT;
    TFIN_DOCUMENTO.DOC_OBS               := I_DOC_OBS;
    TFIN_DOCUMENTO.DOC_NRO_PCOMPRA_FLOTA := I_DOC_NRO_PCOMPRA_FLOTA;
    --------------------
    IF I_TIPO_FACTURA = 2 THEN
      IF I_DOC_CLI_CATEG = 3 THEN
        --PARA SEPARAR COMBUSTIBLE DE AUTOSERVICE POR EL MOMENTO DEPOSITO 2 AUTOSERVICE
        IF I_DEPOSITO = 2 AND I_DOC_LINEA_NEGOCIO = 4 AND I_SUCURSAL = 3 THEN
          TFIN_DOCUMENTO.DOC_PER_CONCEPTO := 2; ---PARA SABER QUE ES EESS PERO AUTOSERVICE;
        END IF;
      END IF;
    END IF;

    ---===========================================================================================================================
    TFIN_DOCUMENTO.DOC_PRODUCTO_ACO  := I_DOC_PRODUCTO;
    TFIN_DOCUMENTO.DOC_TASA_USD      := I_DOC_TASA_US;
    TFIN_DOCUMENTO.DOC_TASA          := V_TASA;
    TFIN_DOCUMENTO.DOC_CONC_CRED     := I_DOC_CONC_CRED;
    TFIN_DOCUMENTO.DOC_TIPO_CREDITO  := I_DOC_TIPO_CREDITO;
    TFIN_DOCUMENTO.DOC_LINEA_CREDITO := I_DOC_LINEA_CREDITO;
    ---===========================================================================================================================
    IF TFIN_DOCUMENTO.DOC_MON = 2 THEN
      TFIN_DOCUMENTO.DOC_IMP_TOT_USD := V_TOT_DOC;
    ELSE
      TFIN_DOCUMENTO.DOC_IMP_TOT_USD := ROUND(V_TOT_DOC / I_DOC_TASA_US, 2);
    END IF;
    ---===========================================================================================================================

    INSERT INTO FIN_DOCUMENTO VALUES TFIN_DOCUMENTO;

    FOR C IN (SELECT C.SEQ_ID ITEM,
                     TO_NUMBER(C.C001) ART,
                     TO_NUMBER(C.C001) ARTICULO,
                     TO_NUMBER(C.C002) CANTIDAD,
                     TO_NUMBER(C.C003) PRECIO,
                     TO_NUMBER(C.C004) IMPORTE,
                     TO_NUMBER(C.C005) PRBR_PRODUCTO,
                     TO_NUMBER(C.C010) DOC_EXENTA_MON,
                     TO_NUMBER(C.C011) DOC_EXENTA_LOC,
                     TO_NUMBER(C.C012) DOC_GRAV_MON,
                     TO_NUMBER(C.C013) DOC_GRAV_LOC,
                     TO_NUMBER(C.C014) DOC_IVA_MON,
                     TO_NUMBER(C.C015) DOC_IVA_LOC,
                     TO_NUMBER(C023) ART_IMPU
                FROM APEX_COLLECTIONS C
               WHERE C.COLLECTION_NAME = 'FACI244_DET')

     LOOP

      V_FDET.DET_CLAVE_DOC     := TFIN_DOCUMENTO.DOC_CLAVE;
      V_FDET.DET_EMPR          := I_EMPRESA;
      V_FDET.DET_NRO_ITEM      := C.ITEM;
      V_FDET.DET_ART           := C.ART;
      V_FDET.DET_CANT          := C.CANTIDAD;
      V_FDET.DET_TIPO_COMISION := 'N';
      V_FDET.DET_PORC_DTO      := 0;
      V_FDET.DET_PORC_COMISION := 0;
      V_FDET.DET_NRO_REMISION  := TFIN_DOCUMENTO.DOC_REMISION;
      V_FDET.DET_PRECIO_UNIT   := C.PRECIO;
      V_FDET.DET_IVA_MON       := C.DOC_IVA_MON;
      V_FDET.DET_IVA_LOC       := C.DOC_IVA_LOC;
      V_FDET.DET_COD_IVA       := C.ART_IMPU;
      V_FDET.DET_BRUTO_MON     := NVL(C.DOC_GRAV_MON, 0) +
                                  NVL(C.DOC_EXENTA_MON, 0);
      V_FDET.DET_BRUTO_LOC     := NVL(C.DOC_GRAV_LOC, 0) +
                                  NVL(C.DOC_EXENTA_LOC, 0);
      V_FDET.DET_NETO_MON      := NVL(C.DOC_GRAV_MON, 0) +
                                  NVL(C.DOC_EXENTA_MON, 0);
      V_FDET.DET_NETO_LOC      := NVL(C.DOC_GRAV_LOC, 0) +
                                  NVL(C.DOC_EXENTA_LOC, 0);

      INSERT INTO FAC_DOCUMENTO_DET VALUES V_FDET;

    END LOOP;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'No se pudo encontrar el tipo de movimiento!.');

    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, '-fin- ' || SQLERRM);
  END PP_ACTUALIZAR_DOCUMENTO_FIN;

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

  PROCEDURE PP_IND_DEP_FLOTA(I_EMPRESA   IN NUMBER,
                             I_SUCURSAL  IN NUMBER,
                             I_DEPOSITO  IN NUMBER,
                             O_IND_FLOTA OUT VARCHAR2) IS
    V_DEP NUMBER;

  BEGIN
    SELECT T.CONF_DEP_FLOTA
      INTO V_DEP
      FROM STK_CONFIGURACION T
     WHERE T.CONF_EMPR = I_EMPRESA
       AND T.CONF_SUC_FLOTA = I_SUCURSAL
       AND T.CONF_DEP_FLOTA = I_DEPOSITO;

    O_IND_FLOTA := 'S';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_IND_FLOTA := 'N';
  END PP_IND_DEP_FLOTA;

  PROCEDURE PP_BORRAR_DET(I_SEQ IN NUMBER) AS
    l_is_petrobras number := 0;
  BEGIN
    <<is_petrobras>>
    begin
      select c024
      into l_is_petrobras
      from apex_collections
      where collection_name = co_faci_det
      and   seq_id          = i_seq;
      
      -- si es consumo de PETROBRAS elimina todo los registros asociados
      if l_is_petrobras = 1 then
        truncate_collection_petrobras;
      end if;
      
    exception
      when no_data_found then
        l_is_petrobras := 0;
    end is_petrobras;
    
    if l_is_petrobras = 0 then
      APEX_COLLECTION.DELETE_MEMBER(P_COLLECTION_NAME => co_faci_det,
                                    P_SEQ             => I_SEQ);
    end if;
                                  
    APEX_COLLECTION.RESEQUENCE_COLLECTION(P_COLLECTION_NAME => co_faci_det);

  END PP_BORRAR_DET;

  PROCEDURE PP_ADD_DET(I_EMPRESA           IN NUMBER,
                       I_SUCURSAL          IN NUMBER,
                       I_NRO_LISTA_PRECIO  IN NUMBER,
                       I_ARTICULO          IN NUMBER,
                       I_CANTIDAD          IN NUMBER,
                       I_PRECIO            IN NUMBER,
                       I_IMPORTE           IN NUMBER,
                       I_DOC_MON           IN NUMBER,
                       I_CLI_PORC_EXEN_IVA IN NUMBER,
                       I_DOC_TASA          IN NUMBER,
                       I_DESCUENTO_GS      IN NUMBER,
                       I_RECARGO           IN NUMBER,
                       I_DOC_TASA_COMB     IN NUMBER,
                       in_es_comb_petrobras in boolean := false --> se utilizar para identificar la carga, si luego es eliminado
                       ) AS

    V_PRECIO_AUX               NUMBER :=0;
    V_AREM_PRECIO_VTA          NUMBER;
    V_ART_DESC                 VARCHAR2(300);
    V_ART_IMPU                 NUMBER;
    V_IMPU_PORC_BASE_IMPONIBLE NUMBER;
    V_IMPU_PORCENTAJE          NUMBER;
    V_ART_CTA_CONTABLE         NUMBER;
    V_ART_CLASIFICACION        NUMBER;
    V_MON_DEC_IMP              NUMBER := 1;
    V_DOC_EXENTA_MON           NUMBER;
    V_DOC_EXENTA_LOC           NUMBER;
    V_DOC_GRAV_MON             NUMBER;
    V_DOC_GRAV_LOC             NUMBER;
    V_DOC_IVA_MON              NUMBER;
    V_DOC_IVA_LOC              NUMBER;
    v_doc_tasa                 number;
  BEGIN

    BEGIN
      SELECT M.MON_DEC_IMP
        INTO V_MON_DEC_IMP
        FROM GEN_MONEDA M
       WHERE M.MON_CODIGO = I_DOC_MON
         AND M.MON_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010, 'Error no se encontro la moneda');
    END;
    if I_DOC_MON = XP_MON_LOC then
      v_DOC_TASA := 1;
    else
      v_DOC_TASA := i_DOC_TASA;
    end if;

    IF NVL(I_CANTIDAD, 0) = 0 THEN
      RAISE_APPLICATION_ERROR(-20010, 'Cantidad no puede ser cero');
    END IF;

    BEGIN
      -- CALL THE PROCEDURE
      FACI244.PP_DATOS_ARTICULO(I_EMPRESA           => I_EMPRESA,
                                I_ART_CODIGO        => I_ARTICULO,
                                I_LIN_NEGOC         => NULL,
                                O_ART_DESC          => V_ART_DESC,
                                O_ART_CLASIFICACION => V_ART_CLASIFICACION,
                                O_ART_IMPU          => V_ART_IMPU);
    END;

    BEGIN
      -- CALL THE PROCEDURE
      FACI244.PP_BUSCAR_IMPUESTO(I_EMPRESA                  => I_EMPRESA,
                                 I_ART_IMPU                 => V_ART_IMPU,
                                 O_IMPU_PORCENTAJE          => V_IMPU_PORCENTAJE,
                                 O_IMPU_PORC_BASE_IMPONIBLE => V_IMPU_PORC_BASE_IMPONIBLE);
    END;

    BEGIN
      -- CALL THE PROCEDURE
      FACI244.PP_BUSCAR_PRECIO(I_EMPRESA          => I_EMPRESA,
                               I_ARTICULO         => I_ARTICULO,
                               I_NRO_LISTA_PRECIO => I_NRO_LISTA_PRECIO,
                               I_SUCURSAL         => I_SUCURSAL,
                               I_DOC_MON          => I_DOC_MON,
                               I_IMPU_PORCENTAJE  => V_IMPU_PORCENTAJE,
                               I_RECARGO          => I_RECARGO,
                               I_DOC_TASA_COMB    => I_DOC_TASA_COMB,
                               O_PRECIO_VENTA     => V_PRECIO_AUX);
    END;

    PP_TRAER_CTACO_ARTICULO(I_EMPRESA           => I_EMPRESA,
                            I_ART_CLASIFICACION => V_ART_CLASIFICACION,
                            O_ART_CTA_CONTABLE  => V_ART_CTA_CONTABLE);

    IF I_PRECIO < V_PRECIO_AUX /*AND :BDOC_ENCA.DOC_NRO_PCOMPRA_FLOTA IS NULL*/
     THEN

   --  RAISE_APPLICATION_ERROR(-20010,I_ARTICULO||' '||' '||I_NRO_LISTA_PRECIO||' '||I_SUCURSAL ||' '|| I_DOC_MON||' '||V_ART_IMPU||' '||I_DOC_TASA_COMB||' '||I_RECARGO);
      RAISE_APPLICATION_ERROR(-20010,
                              'El precio de venta es inferior al precio de venta establecido!');
    END IF;

    DECLARE
      V_BRUTO          NUMBER := 0; -- CANTIDAD POR PRECIO UNITARIO INGRESADO
      V_VAL_DTO        NUMBER := 0; -- V_BRUTO POR EL PORCENTAJE DE DESCUENTO
      V_NETO           NUMBER := 0; -- V_BRUTO MENOS V_VAL_DTO
      V_NETO_GRAV      NUMBER := 0; -- V_BRUTO MENOS V_VAL_DTO
      V_NETO_EXEN      NUMBER := 0; -- V_BRUTO MENOS V_VAL_DTO
      V_PRECIO         NUMBER := 0;
      V_PORC_DTO       NUMBER := 0;
      V_PRECIO_CON_IVA NUMBER := 0;
      V_PREC_UNITARIO  NUMBER := 0;
      V_AUX            NUMBER := 0;
    BEGIN
      V_PRECIO_CON_IVA := I_PRECIO;

      V_AUX             := (1 + ((V_IMPU_PORC_BASE_IMPONIBLE / 100) *
                           (V_IMPU_PORCENTAJE / 100)));
      V_PREC_UNITARIO   := V_PRECIO_CON_IVA / V_AUX;
      V_AREM_PRECIO_VTA := V_PREC_UNITARIO;
      V_PRECIO          := V_AREM_PRECIO_VTA;
      V_BRUTO           := (NVL(I_CANTIDAD, 0)) * NVL(V_PRECIO, 0);
      V_VAL_DTO         := ((V_BRUTO * NVL(V_PORC_DTO, 0)) / 100);
      V_NETO            := NVL(V_BRUTO, 0) - NVL(V_VAL_DTO, 0);

      IF NVL(V_IMPU_PORCENTAJE, 0) > 0 THEN
        IF I_CLI_PORC_EXEN_IVA IS NOT NULL THEN
          V_NETO_EXEN := ((V_NETO * I_CLI_PORC_EXEN_IVA) / 100);
          V_NETO_GRAV := V_NETO - V_NETO_EXEN;
        ELSE
          V_NETO_EXEN := V_NETO -
                         (V_NETO * (V_IMPU_PORC_BASE_IMPONIBLE / 100));
          V_NETO_GRAV := V_NETO - V_NETO_EXEN;
        END IF;
      ELSE

        V_NETO_GRAV := 0;
        V_NETO_EXEN := V_NETO;
      END IF;

      IF I_DOC_MON = XP_MON_LOC THEN
        V_DOC_EXENTA_MON := ROUND(V_NETO_EXEN, V_MON_DEC_IMP);
        V_DOC_EXENTA_LOC := ROUND(V_NETO_EXEN, V_MON_DEC_IMP);
        V_DOC_GRAV_MON   := ROUND(V_NETO_GRAV, V_MON_DEC_IMP);
        V_DOC_GRAV_LOC   := ROUND(V_NETO_GRAV, V_MON_DEC_IMP);
      ELSE
        V_DOC_EXENTA_MON := ROUND(V_NETO_EXEN, V_MON_DEC_IMP);
        V_DOC_EXENTA_LOC := ROUND((NVL(V_NETO_EXEN, 0) * v_DOC_TASA),
                                  V_MON_DEC_IMP);
        V_DOC_GRAV_MON   := ROUND(V_NETO_GRAV, V_MON_DEC_IMP);
        V_DOC_GRAV_LOC   := ROUND((NVL(V_NETO_GRAV, 0) * v_DOC_TASA),
                                  V_MON_DEC_IMP);
      END IF;
      V_DOC_IVA_MON := ROUND((((V_DOC_GRAV_MON) * V_IMPU_PORCENTAJE) / 100),
                             V_MON_DEC_IMP);
      V_DOC_IVA_LOC := ROUND((((V_DOC_GRAV_LOC) * V_IMPU_PORCENTAJE) / 100),
                             V_MON_DEC_IMP);
      V_DOC_GRAV_MON   := ROUND(V_NETO_GRAV, V_MON_DEC_IMP);
      V_DOC_GRAV_LOC   := ROUND((NVL(V_NETO_GRAV, 0) * v_DOC_TASA),
                                  V_MON_DEC_IMP);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010, SQLERRM);
    END;

    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'FACI244_DET',
                               P_C001            => I_ARTICULO,
                               P_C002            => I_CANTIDAD,
                               P_C003            => I_PRECIO,
                               P_C004            => I_IMPORTE,
                               P_C005            => '',
                               P_C006            => NVL(I_DESCUENTO_GS, 0),
                               P_C007            => '',
                               P_C008            => '',
                               P_C009            => '',
                               P_C010            => V_DOC_EXENTA_MON,
                               P_C011            => V_DOC_EXENTA_LOC,
                               P_C012            => V_DOC_GRAV_MON,
                               P_C013            => V_DOC_GRAV_LOC,
                               P_C014            => V_DOC_IVA_MON,
                               P_C015            => V_DOC_IVA_LOC,
                               P_C020            => V_ART_CLASIFICACION,
                               P_C021            => V_ART_CTA_CONTABLE,
                               P_C022            => V_IMPU_PORCENTAJE,
                               P_C023            => V_ART_IMPU,
                               p_c024            => case when in_es_comb_petrobras then 1 else 0 end
                               );

  END PP_ADD_DET;

  PROCEDURE PP_BUSCAR_PRECIO(I_EMPRESA          IN NUMBER,
                             I_ARTICULO         IN NUMBER,
                             I_NRO_LISTA_PRECIO IN NUMBER,
                             I_SUCURSAL         IN NUMBER,
                             I_DOC_MON          IN NUMBER,
                             I_IMPU_PORCENTAJE  IN NUMBER,
                             I_RECARGO          IN NUMBER,
                             I_DOC_TASA_COMB    IN NUMBER,
                             O_PRECIO_VENTA     OUT NUMBER) IS

    --V_MENSAJE         VARCHAR2(200);
    --V_PRECIO          NUMBER := 0;
    --V_UNITARIO        VARCHAR(20);
    V_PRECIO_CTRL NUMBER;
    V_RETURN      VARCHAR2(200);
    S_PRECIO      NUMBER;
    --V_AREM_PRECIO_VTA NUMBER;
    SIN_PARAMETRO EXCEPTION;

  BEGIN
    IF I_ARTICULO IS NULL THEN
      RAISE SIN_PARAMETRO;
    END IF;

    ----ARTICULO, LISTA_PRECIO, SUCURSAL

    V_RETURN := FAC_PRECIO_ARTICULO(I_ART_CODIGO => I_ARTICULO,
                                    I_LISTA      => I_NRO_LISTA_PRECIO,
                                    I_SUC        => I_SUCURSAL,
                                    I_IVA        => I_IMPU_PORCENTAJE,
                                    I_EMPRESA    => I_EMPRESA);

    BEGIN
      V_PRECIO_CTRL := V_RETURN;
      IF NVL(V_PRECIO_CTRL, 0) > 0 THEN
        S_PRECIO := V_PRECIO_CTRL;
      ELSE
        RAISE_APPLICATION_ERROR(-20010,
                                'El articulo no tiene precio en la lista ' ||
                                TO_CHAR(I_NRO_LISTA_PRECIO));
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'El articulo no tiene precio en la lista ' ||
                                TO_CHAR(I_NRO_LISTA_PRECIO));
    END;

    IF I_DOC_MON = 2 THEN
      S_PRECIO := ROUND(S_PRECIO / I_DOC_TASA_COMB, 2);
      --V_PRECIO_CTRL := S_PRECIO;
    END IF;

    S_PRECIO       := NVL(S_PRECIO, 0) + NVL(I_RECARGO, 0);
    O_PRECIO_VENTA := S_PRECIO;

   --  RAISE_APPLICATION_ERROR(-20010,S_PRECIO);
  EXCEPTION
    WHEN SIN_PARAMETRO THEN
      NULL;
  END PP_BUSCAR_PRECIO;

  PROCEDURE PP_BUSCAR_IMPUESTO(I_EMPRESA                  IN NUMBER,
                               I_ART_IMPU                 IN NUMBER,
                               O_IMPU_PORCENTAJE          OUT NUMBER,
                               O_IMPU_PORC_BASE_IMPONIBLE OUT NUMBER) IS

    SIN_PARAMETRO EXCEPTION;
  BEGIN
    IF I_ART_IMPU IS NULL THEN
      RAISE SIN_PARAMETRO;
    END IF;

    SELECT IMPU_PORCENTAJE, IMPU_PORC_BASE_IMPONIBLE
      INTO O_IMPU_PORCENTAJE, O_IMPU_PORC_BASE_IMPONIBLE
      FROM GEN_IMPUESTO
     WHERE IMPU_CODIGO = I_ART_IMPU
       AND IMPU_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'El articulo debe estar sujeto a un impuesto !.');

    WHEN SIN_PARAMETRO THEN
      NULL;
  END PP_BUSCAR_IMPUESTO;

  PROCEDURE PP_DATOS_ARTICULO(I_EMPRESA    IN NUMBER,
                              I_ART_CODIGO IN NUMBER,
                              I_LIN_NEGOC  IN NUMBER,

                              O_ART_DESC          OUT VARCHAR2,
                              O_ART_CLASIFICACION OUT NUMBER,
                              O_ART_IMPU          OUT NUMBER) AS
    SIN_PARAMETRO EXCEPTION;
  BEGIN
    IF I_ART_CODIGO IS NULL THEN
      RAISE SIN_PARAMETRO;
    END IF;

    /*SELECT ART_DESC, ART_IMPU, ART_CLASIFICACION
      INTO O_ART_DESC, O_ART_IMPU, O_ART_CLASIFICACION
      FROM STK_ARTICULO
     WHERE ART_CODIGO = I_ART_CODIGO
       AND ART_EMPR = I_EMPRESA
       AND (ART_LINEA_NEGOCIO = I_LIN_NEGOC OR I_LIN_NEGOC IS NULL);*/
    
    SELECT DISTINCT ART_DESC, ART_IMPU, ART_CLASIFICACION
      INTO O_ART_DESC, O_ART_IMPU, O_ART_CLASIFICACION
      FROM STK_ARTICULO A, STK_ART_SUC SO, STK_ART_COD_BARRA COBA
     WHERE A.ART_CODIGO = SO.ART_CODIGO
       AND A.ART_EMPR = SO.EMPR
       AND A.ART_CODIGO = COBA.COBA_ART(+)
       AND A.ART_EMPR = COBA.COBA_EMPR(+)
       AND ART_EMPR = 2
       AND A.ART_EST = 'A'
       AND SO.SUC_DEP = V('P6475_DOC_DEPOSITO')
       AND (ART_LINEA_NEGOCIO in (I_LIN_NEGOC,7) OR I_LIN_NEGOC IS NULL)
       AND SO.SUC_CODIGO = V('P_SUCURSAL')
       AND A.ART_CODIGO = I_ART_CODIGO
     ORDER BY A.ART_COD_ALFANUMERICO;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Articulo no encontrado, verifique a que linea de negocio pertenece! '||V('P_SUCURSAL')||' '||V(':P6475_DOC_DEPOSITO'));
    WHEN SIN_PARAMETRO THEN
      NULL;
  END PP_DATOS_ARTICULO;

  PROCEDURE PP_HAB_DESCUENTO(I_EMPRESA       IN NUMBER,
                             I_TIPO_FACTURA  IN NUMBER,
                             O_IND_DESCUENTO OUT VARCHAR2) AS
    V_HAB_DESCUENTO VARCHAR2(20);
  BEGIN
    SELECT NVL(CONF_HAB_DESCUENTO_COMB, 'N') A
      INTO V_HAB_DESCUENTO
      FROM FAC_CONFIGURACION
     WHERE CONF_EMPR = I_EMPRESA;

    IF V_HAB_DESCUENTO = 'S' AND I_TIPO_FACTURA = 2 THEN
      O_IND_DESCUENTO := 'S';
    ELSE
      O_IND_DESCUENTO := 'N';

    END IF;
  END PP_HAB_DESCUENTO;

  PROCEDURE PP_VALIDAR_LINEA_CRED(I_EMPRESA           IN NUMBER,
                                  I_DOC_LINEA_CREDITO IN NUMBER,
                                  I_DOC_FEC_DOC       IN DATE,
                                  I_DOC_CLI_NOM       IN VARCHAR2,
                                  I_DOC_CLI           IN NUMBER,
                                  I_DOC_LINEA_NEGOCIO IN NUMBER,
                                  I_DOC_MON           IN NUMBER,
                                  O_DOC_COSECHA_COD   OUT NUMBER,
                                  O_DOC_TIPO_CREDITO  OUT NUMBER) IS

    V_RECUENTO_LIN NUMBER;
    V_COSECHA_COD  NUMBER;
    SIN_LINEA_CREDITO    EXCEPTION;
    INCON_HAB_LIN_CRED   EXCEPTION;
    LINEA_CRED_INACTIVA  EXCEPTION;
    LINEA_CRED_VENCIDA   EXCEPTION;
    LINEA_NEG_INCORRECTA EXCEPTION;
    LINEA_MON_ERR        EXCEPTION;

    ---====================================================================
    CURSOR CUR_LINEA_CRED IS

      SELECT PROD_CODIGO COSECHA_COD,
             PROD_DESC COSECHA_NOM,
             TIPC_LIN_NEGOCIO LIN_NEGOCIO,
             TIPC_CODIGO TIPC_CODIGO,
             TIPC_DESC TIPC_DESC,
             TIPC_IND_MULTIM TIPC_IND_MULTIM,
             LINC_MONEDA LINC_MONEDA,
             LINC_ESTADO LINC_ESTADO,
             LINC_PERSONA LINC_PERSONA,
             NVL(LINC_FEC_LIM_OPER, PROD_FECVTO_FAC_IN) FEC_LIM_OPER
        FROM FIN_TIPO_CREDITO TC, ACO_PRODUCTO PD, FIN_LINEA_CREDITO LC
       WHERE TC.TIPC_EMPR = I_EMPRESA

         AND TC.TIPC_CODIGO = LC.LINC_TIPO_CRED
         AND TC.TIPC_EMPR = LC.LINC_EMPR

         AND PD.PROD_CLAVE(+) = LC.LINC_COSECHA
         AND PD.PROD_EMPR(+) = LC.LINC_EMPR

         AND LC.LINC_CLAVE = I_DOC_LINEA_CREDITO

         AND LC.LINC_PERSONA = I_DOC_CLI;

  BEGIN
    IF I_DOC_LINEA_CREDITO IS NULL THEN
      RAISE SIN_PARAMETRO;
    END IF;
    ------------------------------------------------------------------------
    V_RECUENTO_LIN := 0;
    ---------
    FOR R IN CUR_LINEA_CRED LOOP
      --------------------------------------------------------------------
      V_RECUENTO_LIN := V_RECUENTO_LIN + 1;
      --------------------------------------------------------------------
      IF R.LINC_ESTADO = 'I' THEN
        RAISE LINEA_CRED_INACTIVA;
      END IF;
      --------------------------------------------------------------------
      IF R.FEC_LIM_OPER < I_DOC_FEC_DOC THEN
        RAISE LINEA_CRED_VENCIDA;
      END IF;
      --------------------------------------------------------------------
      IF R.LIN_NEGOCIO IS NOT NULL THEN
        IF R.LIN_NEGOCIO <> I_DOC_LINEA_NEGOCIO THEN
          RAISE LINEA_NEG_INCORRECTA;
        END IF;
      END IF;
      --------------------------------------------------------------------
      IF R.TIPC_IND_MULTIM = 'N' THEN
        IF R.LINC_MONEDA <> I_DOC_MON THEN
          RAISE LINEA_MON_ERR;
        END IF;
      END IF;
      --------------------------------------------------------------------
      V_COSECHA_COD := R.COSECHA_COD;
      -- O_LINEA_CRED_COSECHA_COD := V_COSECHA_COD;
      O_DOC_COSECHA_COD  := V_COSECHA_COD;
      O_DOC_TIPO_CREDITO := R.TIPC_CODIGO;
      --------------------------------------------------------------------
    END LOOP;
    ------------------------------------------------------------------------
    IF V_RECUENTO_LIN = 0 THEN
      RAISE SIN_LINEA_CREDITO;
    END IF;
    -------
    IF V_RECUENTO_LIN > 1 THEN
      RAISE INCON_HAB_LIN_CRED;
    END IF;
    ------------------------------------------------------------------------
    O_DOC_COSECHA_COD := V_COSECHA_COD;
    ------------------------------------------------------------------------

  EXCEPTION
    WHEN SIN_PARAMETRO THEN
      NULL;

    WHEN SIN_LINEA_CREDITO THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Linea de credito inexistente para : ' ||
                              I_DOC_CLI_NOM || ' !');

    WHEN LINEA_CRED_INACTIVA THEN
      RAISE_APPLICATION_ERROR(-20010, 'La Linea de credito esta Inactiva!');

    WHEN LINEA_CRED_VENCIDA THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'La Linea de credito ya esta vencida!');

    WHEN LINEA_NEG_INCORRECTA THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Linea de Credito no permite operaciones en Linea de Negocio' ||
                              I_DOC_LINEA_NEGOCIO || '!.');

    WHEN LINEA_MON_ERR THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'La linea de credito no permite operaciones para moneda ' ||
                              I_DOC_MON || '!.');

  END PP_VALIDAR_LINEA_CRED;

  PROCEDURE PP_VALIDAR_CABECERA(I_EMPRESA           IN NUMBER,
                                I_TIPO_FACTURA      IN NUMBER,
                                I_DOC_MON           IN NUMBER,
                                I_DOC_LINEA_CREDITO IN NUMBER,
                                I_DOC_FEC_DOC       IN DATE,
                                I_DOC_COSECHA_COD   IN NUMBER,
                                I_DOC_CLI           IN NUMBER,
                                I_DOC_CLI_NOM       IN VARCHAR2,
                                I_DOC_TASA_USD      IN NUMBER) AS
    V_LIM_CRED_DISP NUMBER;
  BEGIN
    IF I_DOC_CLI IS NULL AND I_DOC_CLI_NOM IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Cliente no puede ser nulo');
    END IF;

    IF I_TIPO_FACTURA = 2 THEN

      IF I_DOC_LINEA_CREDITO IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'La linea de credito no puede ser nulo');
      END IF;

      FACI244.PP_BUSCAR_SALDO_LINEA_CRED(I_EMPRESA           => I_EMPRESA,
                                         I_DOC_MON           => I_DOC_MON,
                                         I_DOC_CLI           => I_DOC_CLI,
                                         I_DOC_TASA_US       => I_DOC_TASA_USD,
                                         I_DOC_FEC_DOC       => I_DOC_FEC_DOC,
                                         I_DOC_LINEA_CREDITO => I_DOC_LINEA_CREDITO,
                                         O_LIN_CRED_DISP_MD  => V_LIM_CRED_DISP);

      --RAISE_APPLICATION_ERROR('El importe de la venta es mayor al importe disponible de credito!');

    END IF;
  END PP_VALIDAR_CABECERA;

  PROCEDURE PP_GENERAR_CUOTA(I_EMPRESA          IN NUMBER,
                             I_FIRTS_VTO        IN DATE,
                             I_CANT_CUOTA       IN NUMBER,
                             I_DOC_MON          IN NUMBER,
                             I_IMPORTE          IN NUMBER,
                             I_TIPO_VENCIMIENTO IN VARCHAR2,
                             I_DIAS_ENTRE       IN NUMBER) AS
    V_MON_IMP_DEC NUMBER;
  BEGIN

    BEGIN
      SELECT M.MON_DEC_IMP
        INTO V_MON_IMP_DEC
        FROM GEN_MONEDA M
       WHERE M.MON_CODIGO = I_DOC_MON
         AND M.MON_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010, 'Error no se encontro la moneda');
    END;
    --VALIDAR CANTIDAD DE CUOTAS SELECCIONADA

    IF NVL(I_CANT_CUOTA, 0) < 1 THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Debe ingresar la cantidad de cuotas que desea generar!');
    END IF;

    IF MOD(I_CANT_CUOTA, 1) <> 0 THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Error favor verificar cantidad cuota');
    END IF;
    --VALIDAR FECHA DEL PRIMER VENCIMIENTO
    IF I_FIRTS_VTO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Debe ingresar la fecha del primer vencimiento!');
    END IF;

    --VALIDAR TIPO DE VENCIMIENTO
    IF I_CANT_CUOTA > 1 THEN
      IF NVL(I_TIPO_VENCIMIENTO, ' ') NOT IN ('F', 'V') THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Tipo de vencimiento debe ser F=Fijo, V=Variable!');
      END IF;
    END IF;

    --VALIDAR LOS DIAS ENTRE UNA CUOTA Y LA SIGUIENTE
    --SOLO SI S_TIPO_VENCIMIENTO = 'V' (VARIABLE)
    --Y SI LA CANTIDAD DE CUOTAS ES MAYOR QUE 1
    IF I_CANT_CUOTA > 1 AND I_TIPO_VENCIMIENTO = 'V' THEN
      IF I_DIAS_ENTRE IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Debe ingresar los dias entre una cuota y la otra!');
      END IF;
      IF I_DIAS_ENTRE <= 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Los dias entre cuotas debe ser un numero > que cero!');
      END IF;
    END IF;

    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(P_COLLECTION_NAME => 'FACI244_CUOTA');
    DECLARE
      --I             NUMBER;
      V_FECHA       DATE := I_FIRTS_VTO;
      V_CUO_IMP     NUMBER := ROUND(I_IMPORTE / I_CANT_CUOTA, V_MON_IMP_DEC);
      V_TOT_CUO_IMP NUMBER := 0;
    BEGIN
      FOR I IN 1 .. I_CANT_CUOTA LOOP
        IF I = I_CANT_CUOTA THEN
          V_CUO_IMP := (I_IMPORTE - V_TOT_CUO_IMP);
        END IF;

        APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'FACI244_CUOTA',
                                   P_C001            => V_FECHA,
                                   P_C002            => V_CUO_IMP);

        -- :BCUO_DET.CUO_FEC_VTO   := V_FECHA;
        IF I_TIPO_VENCIMIENTO = 'V' THEN
          V_FECHA := V_FECHA + I_DIAS_ENTRE;
        ELSE
          V_FECHA := ADD_MONTHS(I_FIRTS_VTO, I);
        END IF;
        --   :BCUO_DET.CUO_IMP_MON := V_CUO_IMP;

        V_TOT_CUO_IMP := V_TOT_CUO_IMP + V_CUO_IMP;
      END LOOP;

      --AJUSTAR LA DIFERENCIA POR REDONDEO A LA ULTIMA CUOTA;
      /**/

    END;

  END PP_GENERAR_CUOTA;

  PROCEDURE PP_BUSCAR_CTA_BCO(I_EMPRESA  IN NUMBER,
                              I_SUCURSAL IN NUMBER,
                              I_DOC_MON  IN NUMBER,
                              O_CTA_BCO  OUT NUMBER) IS
    V_SIMBOLO     VARCHAR2(5);
    V_OPER_CODIGO NUMBER;
  BEGIN

    SELECT OPER_CODIGO
      INTO V_OPER_CODIGO
      FROM GEN_OPERADOR, GEN_OPERADOR_EMPRESA
     WHERE OPER_LOGIN = GEN_DEVUELVE_USER
       AND OPER_CODIGO = OPEM_OPER
       AND OPEM_EMPR = I_EMPRESA;

    SELECT SUMO_CAJA_VTA --, SUMO_MON
      INTO O_CTA_BCO --, :BDOC_ENCA.CTA_MON
      FROM FAC_SUC_MON_CAJA
     WHERE SUMO_EMPR = I_EMPRESA
       AND SUMO_SUC = I_SUCURSAL
       AND SUMO_MON = I_DOC_MON
       AND SUMO_OPER = V_OPER_CODIGO;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'No existe libro de caja habilitado para la empresa/sucursal/moneda/operador!');
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Existe mas de una caja asignada para la facturacion en moneda ' ||
                              V_SIMBOLO || ' !');

  END PP_BUSCAR_CTA_BCO;

  PROCEDURE PP_CARGAR_LINEA_NEG(I_EMPRESA           IN NUMBER,
                                I_DOC_LINEA_NEGOCIO IN NUMBER,
                                O_DOC_CONC_CRED     OUT NUMBER) IS
    CONC_CRED_NO_PERMITIDO EXCEPTION;
    V_DOC_CONC_CRED NUMBER;
  BEGIN

    SELECT LIN_CONC_CREDITO
      INTO V_DOC_CONC_CRED
      FROM FAC_LINEA_NEGOCIO
     WHERE LIN_CODIGO = I_DOC_LINEA_NEGOCIO
       AND LIN_EMPR = I_EMPRESA;

    IF V_DOC_CONC_CRED IN (1, 2) THEN
      RAISE CONC_CRED_NO_PERMITIDO;
    END IF;
    O_DOC_CONC_CRED := V_DOC_CONC_CRED;

  EXCEPTION

    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Codigo de Linea de Negocios no existe!');
    WHEN CONC_CRED_NO_PERMITIDO THEN
      RAISE_APPLICATION_ERROR(-20010,
                              'Primero debe verificar la configuracion de la linea de negocio. El concepto credito asociado(efectivo o insumo) al mismo no esta permitido en este programa!');

  END PP_CARGAR_LINEA_NEG;

  PROCEDURE PP_VALIDAR_CUOTA(I_TIPO_FACTURA IN NUMBER) AS
    V_IMPORTE_FACT NUMBER;
    V_IMPORTE_CUO  NUMBER;
  BEGIN
    IF I_TIPO_FACTURA = 2 THEN
      SELECT NVL(SUM(C.C004), 0) NUMERO
        INTO V_IMPORTE_FACT
        FROM APEX_COLLECTIONS C
       WHERE C.COLLECTION_NAME = 'FACI244_DET';

      SELECT NVL(SUM(C.C002), 0) NUMERO
        INTO V_IMPORTE_CUO
        FROM APEX_COLLECTIONS C
       WHERE C.COLLECTION_NAME = 'FACI244_CUOTA';
      IF V_IMPORTE_FACT <> V_IMPORTE_CUO THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Error la cuota no coincide con el documento');
      END IF;
    END IF;
  END PP_VALIDAR_CUOTA;

  PROCEDURE PP_GENERAR_PAGARE_EMITIDO(I_EMPRESA   IN NUMBER,
                                      I_DOC_CLAVE IN NUMBER) IS
    --V_PAGA_CANT    NUMBER;
    V_SUC_ABREV    VARCHAR2(10);
    V_CLAVE_PAGARE NUMBER;
    --V_SESISON_ID   NUMBER;
    V_DOC_CLI NUMBER;
    V_DOC_MON NUMBER;
    V_DOC_SUC NUMBER;

    CURSOR CUR_CUOTAS IS
      SELECT CUO_CLAVE_DOC, CUO_FEC_VTO, CUO_IMP_MON IMPORTE
        FROM FIN_CUOTA
       WHERE CUO_CLAVE_DOC = I_DOC_CLAVE
         AND CUO_EMPR = I_EMPRESA;

  BEGIN

    SELECT F.DOC_SUC, F.DOC_MON, F.DOC_CLI
      INTO V_DOC_SUC, V_DOC_MON, V_DOC_CLI
      FROM FIN_DOCUMENTO F
     WHERE F.DOC_CLAVE = I_DOC_CLAVE
       AND F.DOC_EMPR = I_EMPRESA;

    SELECT SEQ_PAGARE_EMITIDO.NEXTVAL INTO V_CLAVE_PAGARE FROM DUAL;

    SELECT SUC_ABREV
      INTO V_SUC_ABREV
      FROM GEN_SUCURSAL
     WHERE SUC_CODIGO = V_DOC_SUC
       AND SUC_EMPR = I_EMPRESA;

    FOR P IN CUR_CUOTAS LOOP
      INSERT INTO FIN_PAGARE_DOC_EMIT
        (PAGADOC_EMPR,
         PAGADOC_CLAVE,
         PAGADOC_DOC_CLAVE,
         PAGADOC_VENCIMIENTO,
         PAGADOC_NRO_PAGARE,
         PAGADOC_IMPORTE,
         PAGADOC_FEC_EMIS,
         PAGADOC_ESTADO,
         PAGADOC_MON,
         PAGADOC_ARCHIVO,
         PAGADOC_NEGOCIADO,
         PAGADOC_CLIENTE,
         PAGADOC_SUC)
      VALUES
        (I_EMPRESA,
         V_CLAVE_PAGARE,
         P.CUO_CLAVE_DOC,
         P.CUO_FEC_VTO,
         SEQ_PAGARE_EMITIDO_NRO.NEXTVAL,
         P.IMPORTE,
         SYSDATE,
         'F',
         V_DOC_MON,
         V_SUC_ABREV,
         NULL,
         V_DOC_CLI,
         V_DOC_SUC);
    END LOOP;

  END PP_GENERAR_PAGARE_EMITIDO;

  PROCEDURE PP_IMPRIMIR_FACTURA(I_EMPRESA IN NUMBER, I_CLAVE IN NUMBER) IS
    V_PARAMETROS    VARCHAR2(600);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    V_REPORT        VARCHAR2(40) := 'faci235_autoimpresor';
  BEGIN

    V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLAVE=' ||
                    APEX_UTIL.URL_ENCODE(I_CLAVE);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    APEX_UTIL.URL_ENCODE(I_EMPRESA);

    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, V_REPORT, 'pdf');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, SQLERRM);
  END PP_IMPRIMIR_FACTURA;

  PROCEDURE PP_IMPRIMIR_PAGARE(I_DOC_CLAVE IN NUMBER, I_EMPRESA IN NUMBER) IS

    V_PARAMETROS    VARCHAR2(32767);
    V_IDENTIFICADOR VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    V_EMPR_DESC     VARCHAR2(50);
    V_DESC_SUCURSAL VARCHAR2(100);
    V_SALDO         VARCHAR2(40);
    V_SESISON_ID    NUMBER := V('APP_SESSION');

    V_DOC_MON NUMBER;
    V_DOC_SUC NUMBER;

    V_DOC_CLI           NUMBER;
    V_CLI_DIR           VARCHAR2(3000);
    V_CLI_NOM           VARCHAR2(3000);
    V_CLI_RUC           VARCHAR2(200);
    V_CLI_PERS_CONTACTO VARCHAR2(3000);
    V_CLI_TEL           VARCHAR2(3000);

    V_MON_DESC VARCHAR2(200);
    V_MON_DEC  NUMBER;

    V_CONF_ADELANTO_CLI NUMBER;
    V_CONF_FACT_CO_EMIT NUMBER;
  BEGIN

    SELECT F.DOC_SUC, F.DOC_MON, F.DOC_CLI
      INTO V_DOC_SUC, V_DOC_MON, V_DOC_CLI
      FROM FIN_DOCUMENTO F
     WHERE F.DOC_CLAVE = I_DOC_CLAVE
       AND F.DOC_EMPR = I_EMPRESA;

    BEGIN
      SELECT SUC_DESC
        INTO V_DESC_SUCURSAL
        FROM GEN_SUCURSAL
       WHERE SUC_CODIGO = V_DOC_SUC
         AND SUC_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    SELECT CLI_NOM, CLI_DIR, CLI_RUC, CLI_PERS_CONTACTO, CLI_TEL
      INTO V_CLI_NOM, V_CLI_DIR, V_CLI_RUC, V_CLI_PERS_CONTACTO, V_CLI_TEL
      FROM FIN_CLIENTE C
     WHERE C.CLI_CODIGO = V_DOC_CLI
       AND C.CLI_EMPR = I_EMPRESA;

    SELECT CONF_ADELANTO_CLI, CONF_FACT_CO_EMIT
      INTO V_CONF_ADELANTO_CLI, V_CONF_FACT_CO_EMIT
      FROM FIN_CONFIGURACION T
     WHERE T.CONF_EMPR = I_EMPRESA;

    DECLARE
      V_EXIST NUMBER;
    BEGIN
      SELECT PAGADOC_DOC_CLAVE
        INTO V_EXIST
        FROM FIN_PAGARE_DOC_EMIT T
       WHERE T.PAGADOC_DOC_CLAVE = I_DOC_CLAVE
         AND T.PAGADOC_EMPR = I_EMPRESA
         AND ROWNUM = 1;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        PP_GENERAR_PAGARE_EMITIDO(I_EMPRESA   => I_EMPRESA,
                                  I_DOC_CLAVE => I_DOC_CLAVE);
    END VALIDAR_SI_EXISTE_PAGARE;

    SELECT M.MON_DEC_IMP, M.MON_DESC
      INTO V_MON_DEC, V_MON_DESC
      FROM GEN_MONEDA M
     WHERE M.MON_CODIGO = V_DOC_MON
       AND M.MON_EMPR = I_EMPRESA;

    DELETE FIN_FINC218_TEMP WHERE SESSION_ID = V_SESISON_ID;
    DELETE FIN_FINC218_TEMP_1 WHERE SESSION_ID = V_SESISON_ID;

    FOR V IN (SELECT CLAVE,
                     FECHA_EMISION,
                     ESTADO,
                     MONEDA,
                     VENCIMIENTO,
                     NRO_PAGARE,
                     IMPORTE,
                     CLI_CODIGO,
                     CLI_NOM,
                     RUC,
                     DOCUMENTADO,
                     ARCHIVO,
                     NEGOCIADO,
                     MONEDA        MON,
                     CLAVE_DOC,
                     TM,
                     FACTURA,
                     ARTICULO,
                     CANTIDAD,
                     DOC_SIST,
                     ROWNUM        REGISTRO
                FROM (SELECT DOC_CLAVE CLAVE,
                             DOC_FEC_DOC FECHA_EMISION,
                             PAGADOC_ESTADO ESTADO,
                             PAGADOC_MON MONEDA,
                             CUO_FEC_VTO VENCIMIENTO,
                             PAGADOC_NRO_PAGARE NRO_PAGARE,
                             DECODE(NVL(DETA_IMP_NETO_MON, 0) +
                                    NVL(DETA_IVA_MON, 0),
                                    0,
                                    PAGADOC_IMPORTE,
                                    NVL(DETA_IMP_NETO_MON, 0) +
                                    NVL(DETA_IVA_MON, 0)) IMPORTE,
                             CLI_CODIGO,
                             INITCAP(CLI_NOM) CLI_NOM,
                             C.CLI_RUC_DV RUC,
                             'S' DOCUMENTADO,
                             PAGADOC_ARCHIVO ARCHIVO,
                             PAGADOC_NEGOCIADO NEGOCIADO,
                             PAGADOC_DOC_CLAVE CLAVE_DOC,
                             D.DOC_TIPO_MOV TM,
                             DOC_NRO_DOC FACTURA,
                             DECODE(ART_CODIGO,
                                    NULL,
                                    NULL,
                                    ART_CODIGO || '-' || ART_DESC_ABREV) ARTICULO,
                             DETA_CANT CANTIDAD,
                             DOC_SIST,
                             DETA_NRO_ITEM
                        FROM FIN_PAGARE_DOC_EMIT A,
                             FIN_DOCUMENTO D,
                             FIN_CLIENTE C,
                             STK_DOCUMENTO_DET,
                             STK_ARTICULO,
                             (SELECT CUO_EMPR,
                                     CUO_CLAVE_DOC,
                                     MAX(CUO_FEC_VTO) CUO_FEC_VTO
                                FROM FIN_UNION_CUOTA
                               WHERE CUO_EMPR = I_EMPRESA
                               GROUP BY CUO_EMPR, CUO_CLAVE_DOC) VENCIMIENTO
                       WHERE PAGADOC_DOC_CLAVE = DOC_CLAVE
                         AND PAGADOC_EMPR = DOC_EMPR
                         AND (DOC_CLI = CLI_CODIGO OR DOC_PROV = CLI_CODIGO)
                         AND DOC_EMPR = CLI_EMPR
                         AND DOC_CLAVE_STK = DETA_CLAVE_DOC(+)
                         AND DOC_EMPR = DETA_EMPR(+)
                         AND DETA_ART = ART_CODIGO(+)
                         AND DETA_EMPR = ART_EMPR(+)
                         AND DOC_CLAVE = CUO_CLAVE_DOC(+)
                         AND DOC_EMPR = CUO_EMPR(+)
                       GROUP BY DOC_CLAVE,
                                DOC_FEC_DOC,
                                PAGADOC_ESTADO,
                                PAGADOC_MON,
                                PAGADOC_CLAVE,
                                CUO_FEC_VTO,
                                PAGADOC_NRO_PAGARE,
                                CLI_CODIGO,
                                INITCAP(CLI_NOM),
                                C.CLI_RUC_DV,
                                PAGADOC_ARCHIVO,
                                PAGADOC_NEGOCIADO,
                                PAGADOC_DOC_CLAVE,
                                DOC_TIPO_MOV,
                                DOC_NRO_DOC,
                                DECODE(ART_CODIGO,
                                       NULL,
                                       NULL,
                                       ART_CODIGO || '-' || ART_DESC_ABREV),
                                DETA_CANT,
                                DOC_SIST,
                                DETA_NRO_ITEM,
                                DECODE(NVL(DETA_IMP_NETO_MON, 0) +
                                       NVL(DETA_IVA_MON, 0),
                                       0,
                                       PAGADOC_IMPORTE,
                                       NVL(DETA_IMP_NETO_MON, 0) +
                                       NVL(DETA_IVA_MON, 0)))
               WHERE CLAVE = I_DOC_CLAVE
               ORDER BY REGISTRO) LOOP

      INSERT INTO FIN_FINC218_TEMP
        (CLAVE,
         FECHA_EMISION,
         ESTADO,
         MONEDA,
         VENCIMIENTO,
         NRO_PAGARE,
         IMPORTE,
         CLI_CODIGO,
         CLI_NOM,
         RUC,
         DOCUMENTADO,
         ARCHIVO,
         NEGOCIADO,
         MON,
         CLAVE_DOC,
         TM,
         FACTURA,
         ARTICULO,
         CANTIDAD,
         DOC_SIST,
         REGISTRO,
         SESSION_ID)
      VALUES
        (V.CLAVE,
         V.FECHA_EMISION,
         V.ESTADO,
         V.MONEDA,
         V.VENCIMIENTO,
         V.NRO_PAGARE,
         V.IMPORTE,
         V.CLI_CODIGO,
         V.CLI_NOM,
         V.RUC,
         V.DOCUMENTADO,
         V.ARCHIVO,
         V.NEGOCIADO,
         V.MON,
         V.CLAVE_DOC,
         V.TM,
         V.FACTURA,
         V.ARTICULO,
         V.CANTIDAD,
         V.DOC_SIST,
         V.REGISTRO,
         V_SESISON_ID);

    END LOOP;

    -- END IF;
    FOR T IN (SELECT PAGADOC_CLAVE,
                     TO_DATE(PAGADOC_FEC_EMIS, 'DD/MM/YY') EMISION,
                     PAGADOC_ESTADO,
                     PAGADOC_MON,
                     TO_DATE(PAGADOC_VENCIMIENTO, 'dd/mm/yyyy') PAGADOC_VENCIMIENTO,
                     PAGADOC_NRO_PAGARE,
                     SUM(PAGADOC_IMPORTE) IMPORTE,
                     CLI_CODIGO,
                     INITCAP(CLI_NOM) CLI_NOM,
                     C.CLI_RUC,
                     INITCAP(P.PNA_NOM_CONYUGE) PNA_NOM_CONYUGE,
                     P.PNA_DOC_IDENT_CONYUGE,
                     PAGADOC_SUC,
                     P.PNA_NRODOC_CODEUDOR1,
                     P.PNA_NRODOC_CODEUDOR2,
                     INITCAP(P.PNA_NOM_CODEUDOR1) PNA_NOM_CODEUDOR1,
                     INITCAP(P.PNA_NOM_CODEUDOR2) PNA_NOM_CODEUDOR2,
                     NVL(G.PAGEMIT_TIPO, PAGADOC_TIPO) PAGADOC_TIPO,
                     PAGADOC_USER
                FROM FIN_PAGARE_DOC_EMIT A,
                     FIN_DOCUMENTO,
                     FIN_CLIENTE         C,
                     FIN_PERSONA         P,
                     FIN_PAGARE_EMIT     G
               WHERE G.PAGEMIT_CLAVE(+) = A.PAGADOC_CLAVE
                 AND G.PAGEMIT_EMPR(+) = A.PAGADOC_EMPR

                 AND PAGADOC_DOC_CLAVE = DOC_CLAVE
                 AND PAGADOC_EMPR = DOC_EMPR

                 AND CLI_CODIGO = PNA_CODIGO
                 AND CLI_EMPR = PNA_EMPR

                 AND (DOC_CLI = CLI_CODIGO OR DOC_PROV = CLI_CODIGO)
                 AND DOC_EMPR = CLI_EMPR
                 AND PAGADOC_EMPR = I_EMPRESA
                 AND DOC_CLAVE = I_DOC_CLAVE
               GROUP BY PAGADOC_CLAVE,
                        TO_DATE(PAGADOC_FEC_EMIS, 'DD/MM/YY'),
                        PAGADOC_ESTADO,
                        PAGADOC_MON,
                        PAGADOC_CLAVE,
                        TO_DATE(PAGADOC_VENCIMIENTO, 'dd/mm/yyyy'),
                        PAGADOC_NRO_PAGARE,
                        CLI_CODIGO,
                        INITCAP(CLI_NOM),
                        C.CLI_RUC,
                        P.PNA_NOM_CONYUGE,
                        P.PNA_DOC_IDENT_CONYUGE,
                        PAGADOC_SUC,
                        P.PNA_NRODOC_CODEUDOR1,
                        P.PNA_NRODOC_CODEUDOR2,
                        INITCAP(P.PNA_NOM_CODEUDOR1),
                        INITCAP(P.PNA_NOM_CODEUDOR2),
                        NVL(G.PAGEMIT_TIPO, PAGADOC_TIPO),
                        PAGADOC_USER) LOOP

      INSERT INTO FIN_FINC218_TEMP_1
        (PAGADOC_CLAVE,
         EMISION,
         PAGADOC_ESTADO,
         PAGADOC_MON,
         PAGADOC_VENCIMIENTO,
         PAGADOC_NRO_PAGARE,
         IMPORTE,
         CLI_CODIGO,
         CLI_NOM,
         CLI_RUC,
         PNA_NOM_CONYUGE,
         PNA_DOC_IDENT_CONYUGE,
         PAGADOC_SUC,
         PNA_NRODOC_CODEUDOR1,
         PNA_NRODOC_CODEUDOR2,
         PNA_NOM_CODEUDOR1,
         PNA_NOM_CODEUDOR2,
         PAGADOC_TIPO,
         PAGADOC_USER,
         SESSION_ID)
      VALUES
        (T.PAGADOC_CLAVE,
         T.EMISION,
         T.PAGADOC_ESTADO,
         T.PAGADOC_MON,
         T.PAGADOC_VENCIMIENTO,
         T.PAGADOC_NRO_PAGARE,
         T.IMPORTE,
         T.CLI_CODIGO,
         T.CLI_NOM,
         T.CLI_RUC,
         T.PNA_NOM_CONYUGE,
         T.PNA_DOC_IDENT_CONYUGE,
         T.PAGADOC_SUC,
         T.PNA_NRODOC_CODEUDOR1,
         T.PNA_NRODOC_CODEUDOR2,
         T.PNA_NOM_CODEUDOR1,
         T.PNA_NOM_CODEUDOR2,
         T.PAGADOC_TIPO,
         T.PAGADOC_USER,
         V_SESISON_ID);

    END LOOP;

    BEGIN
      SELECT A.EMPR_RAZON_SOCIAL
        INTO V_EMPR_DESC
        FROM GEN_EMPRESA A
       WHERE A.EMPR_CODIGO = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN

        RAISE_APPLICATION_ERROR(-20016, 'Empresa no valida!');
    END;

    V_PARAMETROS := 'P_FORMATO=' || URL_ENCODE('pdf');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_SESSION_ID=' ||
                    URL_ENCODE(V_SESISON_ID);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                    URL_ENCODE(I_EMPRESA);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESCRIP_EMPR=' ||
                    URL_ENCODE(V_EMPR_DESC);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_PROGRAMA=' ||
                    URL_ENCODE('FINC218');
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_SUCURSAL=' ||
                    URL_ENCODE(V_DESC_SUCURSAL);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_USUARIO=' ||
                    URL_ENCODE(GEN_DEVUELVE_USER);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                    'P_CONF_ADELANTO_CLI=' ||
                    URL_ENCODE(V_CONF_ADELANTO_CLI);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR ||
                    'P_CONF_FACT_CO_EMIT=' ||
                    URL_ENCODE(V_CONF_FACT_CO_EMIT);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DESC_PROGRAMA=' ||
                    URL_ENCODE('EMISION DE PAGARE');

    --DEL BLOQUE BSEL
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_OPC_INFORME=' ||
                    URL_ENCODE(V_SALDO);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLI=' ||
                    URL_ENCODE(V_DOC_CLI);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLI_NOM=' ||
                    URL_ENCODE(V_CLI_NOM);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLI_DIR=' ||
                    URL_ENCODE(V_CLI_DIR);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLI_RUC=' ||
                    URL_ENCODE(V_CLI_RUC);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_PERS_CONTACTO=' ||
                    URL_ENCODE(V_CLI_PERS_CONTACTO);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_CLI_TEL=' ||
                    URL_ENCODE(V_CLI_TEL);
    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_MON=' ||
                    URL_ENCODE(V_DOC_MON);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_MON_DEC_IMP=' ||
                    URL_ENCODE(V_MON_DEC);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_MON_DESC=' ||
                    URL_ENCODE(V_MON_DESC);

    /* V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_IMP_LIM_CR=' ||
                    URL_ENCODE(I_CLEM_IMP_LIM_CR);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_BLOQ_LIM_CR=' ||
                    URL_ENCODE(I_BLOQ_LIM_CR);

    V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DIAS_GRACIA=' ||
                    URL_ENCODE(I_DIAS_GRACIA);*/

    INSERT INTO X (CAMPO1, OTRO) VALUES (V_PARAMETROS, 'FINC218');

    DELETE FROM GEN_PARAMETROS_REPORT WHERE USUARIO = GEN_DEVUELVE_USER;
    INSERT INTO GEN_PARAMETROS_REPORT
      (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
    VALUES
      (V_PARAMETROS, GEN_DEVUELVE_USER, 'FINC218', 'pdf');

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'JSON ='||SQLERRM);
  END PP_IMPRIMIR_PAGARE;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_EMPRESA      IN NUMBER,
                                   I_SUCURSAL     IN NUMBER,
                                   I_DEPOSITO     IN NUMBER,
                                   I_TIPO_FACTURA IN NUMBER,
                                   I_DOC_MON      IN NUMBER,
                                   I_DOC_FEC_DOC  IN DATE,
                                   -- I_DOC_CTA_BCO            IN NUMBER,
                                   I_DOC_NRO_DOC            IN NUMBER,
                                   I_DOC_CLI                IN NUMBER,
                                   I_DOC_CLI_NOM            IN VARCHAR2,
                                   I_DOC_CLI_DIR            IN VARCHAR2,
                                   I_DOC_CLI_TEL            IN VARCHAR2,
                                   I_DOC_CLI_RUC            IN VARCHAR2,
                                   I_DOC_NRO_TIMBRADO       IN NUMBER,
                                   I_DOC_PORC_INTERES       IN NUMBER,
                                   I_DOC_TIPO_FEC_INT       IN VARCHAR2,
                                   I_DOC_LINEA_CREDITO      IN NUMBER,
                                   I_LINEA_CRED_IMP_DISP_MD IN NUMBER,
                                   I_DOC_NRO_PCOMPRA_FLOTA  IN NUMBER,
                                   I_DOC_TASA_US            IN NUMBER,
                                   I_DOC_RESP_NOM           IN VARCHAR2,
                                   I_DOC_RESP_CI            IN VARCHAR2,
                                   I_DOC_RESP_TEL           IN VARCHAR2,
                                   I_DOC_LINEA_NEGOCIO      IN NUMBER,
                                   I_DOC_OBS                IN VARCHAR2,
                                   I_DOC_PRODUCTO           IN NUMBER,
                                   -- I_DOC_TIPO_CREDITO       IN NUMBER,
                                   I_DOC_CLI_CATEG IN NUMBER,
                                   I_DOC_LEGAJO    IN NUMBER,
                                   -- I_TOTAL_FACT       IN NUMBER,
                                   I_DOC_HA_CAMION    IN NUMBER,
                                   I_DOC_HA_KM_ACTUAL IN NUMBER) IS

    --V_CLI_CATEGORIA    NUMBER;
    V_DOC_CLI          NUMBER;
    V_DOC_COSECHA_COD  NUMBER;
    V_DOC_TIPO_CREDITO NUMBER;
    V_DOC_CONC_CRED    NUMBER;
    V_DOC_CTA_BCO      NUMBER;
    V_MENSAJE          VARCHAR2(3000);
    V_LIN_CRED_DISP_MD NUMBER;
    V_IMPORTE_FACTURA  NUMBER;

    V_AUX_NRO_DOC      NUMBER;
    V_AUX_CLAVE        NUMBER;

    PROCEDURE PP_VALIDAR_DATOS IS
    BEGIN

      ------------------------------------------------------------------------------------
      IF V_IMPORTE_FACTURA = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'Debe ingresar por lo menos un articulo, el importe de la venta debe ser mayor a 0 cero');
      END IF;

      IF I_DOC_NRO_DOC IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'El numero de documento no puede ser nulo');

      END IF;

      IF I_DOC_NRO_TIMBRADO IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010,
                                'El numero de timbrado no puede ser nulo');
      END IF;

      IF I_DOC_MON IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010, 'La moneda no puede ser nulo.');
      END IF;

      ------------------------------------------------------------------------------------
      PP_VALIDAR_DUPLICACION_DOC(I_EMPRESA          => I_EMPRESA,
                                 I_DOC_NRO_DOC      => I_DOC_NRO_DOC,
                                 I_DOC_NRO_TIMBRADO => I_DOC_NRO_TIMBRADO);

      ------------------------------------------------------------------------------------
      IF I_TIPO_FACTURA = 2 THEN
        -------------------------------------------------------------------------------
        IF I_DOC_PORC_INTERES IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'Debe ingresar el porcentaje de interes!');
        END IF;
        -------------------------------------------------------------------------------
        IF I_DOC_TIPO_FEC_INT IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'Debe ingresar el tipo de fecha para calculo de interes!');
        END IF;
        -------------------------------------------------------------------------------
        IF I_TIPO_FACTURA = 2 AND I_DOC_LINEA_CREDITO IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'Ingrese la linea de credito del productor. Dato requerido en facturas de tipo credito!');
        END IF;

        BEGIN
          -- CALL THE PROCEDURE
          FACI244.PP_BUSCAR_SALDO_LINEA_CRED(I_EMPRESA           => I_EMPRESA,
                                             I_DOC_MON           => I_DOC_MON,
                                             I_DOC_CLI           => I_DOC_CLI,
                                             I_DOC_TASA_US       => I_DOC_TASA_US,
                                             I_DOC_FEC_DOC       => I_DOC_FEC_DOC,
                                             I_DOC_LINEA_CREDITO => I_DOC_LINEA_CREDITO,
                                             O_LIN_CRED_DISP_MD  => V_LIN_CRED_DISP_MD);
        END;

        IF V_IMPORTE_FACTURA > NVL(V_LIN_CRED_DISP_MD, 0) THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'El importe de la venta es mayor al importe disponible de credito!');
        END IF;
      END IF;

    END PP_VALIDAR_DATOS;

  BEGIN

    SELECT NVL(SUM(C.C004), 0) IMPORTE
      INTO V_IMPORTE_FACTURA
      FROM APEX_COLLECTIONS C
     WHERE C.COLLECTION_NAME = 'FACI244_DET';

    PP_VALIDAR_DATOS;

    PP_VALIDAR_CUOTA(I_TIPO_FACTURA => I_TIPO_FACTURA);

    ------------------------------------------------------------------------------------
    IF I_DOC_CLI IS NULL THEN
      PP_INSERTAR_CLIENTE(I_EMPRESA     => I_EMPRESA,
                          I_SUCURSAL    => I_SUCURSAL,
                          I_DOC_CLI_RUC => I_DOC_CLI_RUC,
                          I_DOC_CLI_NOM => I_DOC_CLI_NOM,
                          I_DOC_CLI_DIR => I_DOC_CLI_DIR,
                          I_DOC_CLI_TEL => I_DOC_CLI_TEL,
                          O_DOC_CLI     => V_DOC_CLI);
    ELSE
      V_DOC_CLI := I_DOC_CLI;
    END IF;

    IF I_TIPO_FACTURA = 2 THEN
      PP_VALIDAR_LINEA_CRED(I_EMPRESA           => I_EMPRESA,
                            I_DOC_LINEA_CREDITO => I_DOC_LINEA_CREDITO,
                            I_DOC_FEC_DOC       => I_DOC_FEC_DOC,
                            I_DOC_CLI_NOM       => I_DOC_CLI_NOM,
                            I_DOC_CLI           => I_DOC_CLI,
                            I_DOC_LINEA_NEGOCIO => I_DOC_LINEA_NEGOCIO,
                            I_DOC_MON           => I_DOC_MON,
                            O_DOC_COSECHA_COD   => V_DOC_COSECHA_COD,
                            O_DOC_TIPO_CREDITO  => V_DOC_TIPO_CREDITO);
    ELSE
      PP_BUSCAR_CTA_BCO(I_EMPRESA  => I_EMPRESA,
                        I_SUCURSAL => I_SUCURSAL,
                        I_DOC_MON  => I_DOC_MON,
                        O_CTA_BCO  => V_DOC_CTA_BCO);
    END IF;

    FACI244.PP_CARGAR_LINEA_NEG(I_EMPRESA           => I_EMPRESA,
                                I_DOC_LINEA_NEGOCIO => I_DOC_LINEA_NEGOCIO,
                                O_DOC_CONC_CRED     => V_DOC_CONC_CRED);

    ------------------------------------------------------------------------------------

    PP_ACTUALIZAR_DOCUMENTO_FIN(I_EMPRESA               => I_EMPRESA,
                                I_SUCURSAL              => I_SUCURSAL,
                                I_DEPOSITO              => I_DEPOSITO,
                                I_TIPO_FACTURA          => I_TIPO_FACTURA,
                                I_DOC_MON               => I_DOC_MON,
                                I_DOC_NRO_TIMBRADO      => I_DOC_NRO_TIMBRADO,
                                I_DOC_FEC_DOC           => I_DOC_FEC_DOC,
                                I_DOC_NRO_DOC           => I_DOC_NRO_DOC,
                                I_DOC_CTA_BCO           => V_DOC_CTA_BCO,
                                I_DOC_TASA_US           => I_DOC_TASA_US,
                                I_DOC_CLI               => V_DOC_CLI,
                                I_DOC_CLI_NOM           => I_DOC_CLI_NOM,
                                I_DOC_CLI_DIR           => I_DOC_CLI_DIR,
                                I_DOC_CLI_TEL           => I_DOC_CLI_TEL,
                                I_DOC_CLI_RUC           => I_DOC_CLI_RUC,
                                I_DOC_RESP_NOM          => I_DOC_RESP_NOM,
                                I_DOC_RESP_CI           => I_DOC_RESP_CI,
                                I_DOC_RESP_TEL          => I_DOC_RESP_TEL,
                                I_DOC_LINEA_NEGOCIO     => I_DOC_LINEA_NEGOCIO,
                                I_DOC_PORC_INTERES      => I_DOC_PORC_INTERES,
                                I_DOC_TIPO_FEC_INT      => I_DOC_TIPO_FEC_INT,
                                I_DOC_OBS               => I_DOC_OBS,
                                I_DOC_NRO_PCOMPRA_FLOTA => I_DOC_NRO_PCOMPRA_FLOTA,
                                I_DOC_PRODUCTO          => I_DOC_PRODUCTO,
                                I_DOC_CONC_CRED         => V_DOC_CONC_CRED,
                                I_DOC_TIPO_CREDITO      => V_DOC_TIPO_CREDITO,
                                I_DOC_LINEA_CREDITO     => I_DOC_LINEA_CREDITO,
                                I_DOC_CLI_CATEG         => I_DOC_CLI_CATEG,
                                I_DOC_LEGAJO            => I_DOC_LEGAJO);

    ------------------------------------------------------------------------------------

    PP_ACTUALIZAR_DOC_CONCEPTO(I_EMPRESA   => I_EMPRESA,
                               I_DOC_CLAVE => TFIN_DOCUMENTO.DOC_CLAVE);
    ------------------------------------------------------------------------------------
    IF I_TIPO_FACTURA = 2 THEN
      PP_ACTUALIZAR_CUOTAS;
    END IF;

    PP_CONTROL_INFRACCIONES;

    PP_ACTUALIZAR_DOCUMENTO_STK(I_DEPOSITO         => I_DEPOSITO,
                                I_DOC_HA_CAMION    => I_DOC_HA_CAMION,
                                I_DOC_HA_KM_ACTUAL => I_DOC_HA_KM_ACTUAL);

    PP_ACT_REL_FIN_STK(I_DOC_NRO_PCOMPRA_FLOTA => TFIN_DOCUMENTO.DOC_CLAVE);

    --PP_ACTUALIZAR_TARJ_CHEQ_1;

    ----
    /*SE HACE USO DE ESTOS AUXILIARES YA QUE LAS VARIABLES
      -TFIN_DOCUMENTO.DOC_NRO_DOC
      -TFIN_DOCUMENTO.DOC_CLAVE
      SON LLAMADAS EN EL PROCEDIMIENTO PP_GUARDAR_TARJETA Y LOS VALORES SON MODIFICADOS LO QUE
      IMPIDE QUE SE PUEDAN LLAMAR A LOS REPORTES
    */
    V_AUX_NRO_DOC:=TFIN_DOCUMENTO.DOC_NRO_DOC;
    V_AUX_CLAVE:=TFIN_DOCUMENTO.DOC_CLAVE;
    -----

    PP_GUARDAR_TARJETA(I_EMPRESA       => I_EMPRESA,
                        I_SUCURSAL     => I_SUCURSAL,
                        I_DOC_MON      => I_DOC_MON,
                        I_DOC_TASA_USD => I_DOC_TASA_US,
                        I_DOC_CTA_BCO  => V_DOC_CTA_BCO,
                        I_DOC_NRO_DOC  => I_DOC_NRO_DOC,
                        I_DOC_FEC_DOC  => I_DOC_FEC_DOC,
                        I_TIPO_FACTURA => I_TIPO_FACTURA);


    PP_UNLOCK_IMPRESORA(I_EMPRESA => TFIN_DOCUMENTO.DOC_EMPR,
                        I_NRO_DOC => TFIN_DOCUMENTO.DOC_NRO_DOC);


                    
                     
    --  COMMIT_FORM;

    --PARA QUE LOS DISPARADORES QUE PREGUNTAN POR ESTA PARAMENTRO
    --FUNCIONEN ADECUADAMENTE, SE VUELVE A PONER A 'N'

    /*
    IF NVL(:PARAMETER.P_TIPO_IMPRESORA, 'N') = 'T' THEN
         --T ES DE TMU   --N NO ESEPECIFICO VA A CARGAR MENSAJE PARA ELEGIR A QUE IMPRIMIR
         PP_IMPRIMIR_FAC_TMU;
       ELSE
         PL_AUTOIMPRESOR_FACTURA(TFIN_DOCUMENTO.DOC_CLAVE, I_EMPRESA);
       END IF;

       WHILE FP_CONFIRMAR_SI_NO('?Desea imprimir FACTURA?') = 'SI' LOOP
         IF NVL(:PARAMETER.P_TIPO_IMPRESORA, 'N') = 'T' THEN
           --T ES DE TMU   --N NO ESEPECIFICO VA A CARGAR MENSAJE PARA ELEGIR A QUE IMPRIMIR
           PP_IMPRIMIR_FAC_TMU;
         ELSE
           PL_AUTOIMPRESOR_FACTURA(TFIN_DOCUMENTO.DOC_CLAVE, I_EMPRESA);
         END IF;
       END LOOP;

    -- EMISION DE PAGARES
       IF I_TIPO_FACTURA = 2 THEN
         PP_IMPRIMIR_PAGARE_EMITIDO;
       END IF;
     */

    --V_AUX_NRO_DOC
   -- V_AUX_CLAVE
    V_MENSAJE := 'Guardado correctamente numero :' ||
                 V_AUX_NRO_DOC--TFIN_DOCUMENTO.DOC_NRO_DOC
                 || '</br>' ||
                 '<a href="javascript:$s(''P6475_IMPRIMIR_FACTURA'',' ||
                 V_AUX_CLAVE--TFIN_DOCUMENTO.DOC_CLAVE
                 ||
                 ');">Imprimir FACTURA</a></br>';

    V_MENSAJE := V_MENSAJE ||
                 '<a href="javascript:$s(''P6475_IMPRIMIR_TMU'',' ||
                 V_AUX_CLAVE--TFIN_DOCUMENTO.DOC_CLAVE
                 ||
                 ');">Imprimir FACTURA TMU</a></br>';

    IF I_TIPO_FACTURA = 2 THEN
      V_MENSAJE := V_MENSAJE ||
                   '<a href="javascript:$s(''P6475_IMPRIMIR_PAGARE'',' ||
                   V_AUX_CLAVE--TFIN_DOCUMENTO.DOC_CLAVE
                   ||
                   ');">Imprimir PAGARE</a></br>';
    END IF;

    APEX_APPLICATION.G_PRINT_SUCCESS_MESSAGE := V_MENSAJE;

    --*****************************************************************

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20010, 'Error -' || SQLERRM);
  END PP_ACTUALIZAR_REGISTRO;

  PROCEDURE PP_IMPRIMIR_FAC_TMU(I_EMPRESA IN NUMBER, I_DOC_CLAVE IN NUMBER) IS
    CURSOR C IS
      SELECT E.EMPR_RAZON_SOCIAL,
             E.EMPR_RUC,
             CC.SUC_DIR SUC_CASA_MATRIZ,
             S.SUC_DESC,
             S.SUC_DIR,
             D.DOC_NRO_TIMBRADO,
             T.TIMB_FECH_INIC TIMB_DESDE,
             T.TIMB_FECH_FIN TIMB_HASTA,
             DECODE(D.DOC_TIPO_MOV, 9, 'CONTADO', 10, 'CREDITO') TIPO_MOV,
             D.DOC_NRO_DOC,
             D.DOC_CLI,
             D.DOC_FEC_GRAB FECHA,
             D.DOC_CLI_RUC,
             D.DOC_CLI_NOM,
             (D.DOC_NETO_EXEN_MON + D.DOC_NETO_GRAV_MON + D.DOC_IVA_MON) TOTAL,
             D.DOC_GRAV_10_MON,
             D.DOC_GRAV_5_MON,
             D.DOC_NETO_EXEN_MON,
             D.DOC_IVA_10_MON,
             D.DOC_IVA_5_MON,
             (D.DOC_IVA_10_MON + D.DOC_IVA_5_MON) TOTAL_IVA,
             D.DOC_LOGIN,
             D.DOC_MON,
             M.MON_SIMBOLO,
             NVL(IMPORTE_TARJETA, 0) IMPORTE_TARJETA,
             NVL(IMPORTE_CHEQUE, 0) IMPORTE_CHEQUE,
             D.DOC_RESP_NOM,
             D.DOC_RESP_CI,
             D.DOC_RESP_TEL,
             DOCU_HA_KM_ACTUAL,
             DOC_LINEA_NEGOCIO
        FROM GEN_EMPRESA E,
             STK_DOCUMENTO,
             (SELECT GEN_SUCURSAL.SUC_DIR
                FROM GEN_SUCURSAL
               WHERE SUC_CODIGO = 1
                 AND SUC_EMPR = I_EMPRESA) CC,
             FIN_DOCUMENTO D,
             GEN_SUCURSAL S,
             FIN_TIMBRADO T,
             GEN_MONEDA M,
             GEN_TIPO_MOV V,
             (SELECT DOC_CLAVE_PADRE, SUM(CUP_IMP_LOC) IMPORTE_TARJETA
                FROM FIN_DOCUMENTO, FIN_TC_CUPON
               WHERE DOC_CLAVE = CUP_CLAVE_FIN
                 AND DOC_EMPR = CUP_EMPR

                 AND DOC_EMPR = I_EMPRESA

               GROUP BY DOC_CLAVE_PADRE) TARJETAS,
             (SELECT DOC_CLAVE_PADRE, SUM(E.CHEQ_IMPORTE) IMPORTE_CHEQUE
                FROM FIN_DOCUMENTO C, FIN_CHEQUE_DOCUMENTO D, FIN_CHEQUE E
               WHERE C.DOC_EMPR = I_EMPRESA

                 AND C.DOC_CLAVE = D.CHDO_CLAVE_DOC
                 AND C.DOC_EMPR = D.CHDO_EMPR

                 AND D.CHDO_CLAVE_CHEQ = E.CHEQ_CLAVE
                 AND D.CHDO_EMPR = E.CHEQ_EMPR

               GROUP BY DOC_CLAVE_PADRE) CHEQUES
       WHERE D.DOC_EMPR = I_EMPRESA

         AND D.DOC_EMPR = E.EMPR_CODIGO

         AND D.DOC_SUC = S.SUC_CODIGO
         AND D.DOC_EMPR = S.SUC_EMPR

         AND D.DOC_CLAVE = I_DOC_CLAVE

         AND T.TIMB_CLASE_MOV = V.TMOV_CLASE
         AND T.TIMB_EMPR = V.TMOV_EMPR

         AND DOCU_CLAVE = DOC_CLAVE_STK
         AND DOCU_EMPR = DOC_EMPR

         AND D.DOC_TIPO_MOV = V.TMOV_CODIGO
         AND D.DOC_EMPR = V.TMOV_EMPR

         AND D.DOC_NRO_DOC BETWEEN T.TIMB_DOCU_INIC AND T.TIMB_DOCU_FIN
         AND D.DOC_NRO_TIMBRADO = T.TIMB_NUMERO
         AND D.DOC_EMPR = T.TIMB_EMPR

         AND D.DOC_MON = M.MON_CODIGO
         AND D.DOC_EMPR = M.MON_EMPR

         AND D.DOC_CLAVE = TARJETAS.DOC_CLAVE_PADRE(+)

         AND D.DOC_CLAVE = CHEQUES.DOC_CLAVE_PADRE(+);

    CURSOR D IS
      SELECT ROUND(C.DET_CANT,2)DET_CANT,
             SUBSTR(A.ART_DESC,1,18) ART_DESC,
             (C.DET_NETO_MON + C.DET_IVA_MON) / C.DET_CANT PU,
             (C.DET_NETO_MON + C.DET_IVA_MON) IMPORTE,
             I.IMPU_PORCENTAJE
        FROM FAC_DOCUMENTO_DET C, STK_ARTICULO A, GEN_IMPUESTO I
       WHERE C.DET_EMPR = I_EMPRESA

         AND C.DET_ART = A.ART_CODIGO
         AND C.DET_EMPR = A.ART_EMPR

         AND C.DET_COD_IVA = I.IMPU_CODIGO
         AND C.DET_EMPR = I.IMPU_EMPR

         AND C.DET_CLAVE_DOC = I_DOC_CLAVE;

    V_IMPRESORA CLOB;
    --V_PATH_IMPRESORA  VARCHAR2(50) := NULL;
    V_MONTO_TEXTO VARCHAR2(32767);
    --V_MONTO_TEXTO_RES VARCHAR2(1000);
    V_MONTO_TEXTO_LIN VARCHAR2(32767);

    V_CAR_INI    NUMBER := 1;
    V_CAR_FIN    NUMBER := 40;
    V_LAST_SPACE NUMBER;

    IMPRESORANOREGISTRADA EXCEPTION;
    PRAGMA EXCEPTION_INIT(IMPRESORANOREGISTRADA, -302000);
    --V_ALERT NUMBER;
    SALIR EXCEPTION;
    V_VENCIMIENTOS VARCHAR2(32767);

    FUNCTION CENTRAR(I_TEXTO VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
      RETURN LPAD(' ', (40 - LENGTH(I_TEXTO)) / 2, ' ') || I_TEXTO;
    END;

    FUNCTION FORMATEAR(I_MON NUMBER, I_VALOR NUMBER) RETURN VARCHAR2 IS
      V_FORMATO VARCHAR2(40);
    BEGIN
      IF I_MON = 1 THEN
        V_FORMATO := '999G999G999G990';
      ELSE
        --PROCESA CON 4 DECIMALES
        V_FORMATO := '999G999G990D0000';
      END IF;
      RETURN TO_CHAR(I_VALOR, V_FORMATO, 'NLS_NUMERIC_CHARACTERS = '',.''');
    END;

  BEGIN

    FOR V IN C LOOP
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR(V.EMPR_RAZON_SOCIAL));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR('R.U.C.: ' || V.EMPR_RUC));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         CENTRAR('Casa Matriz: ' || V.SUC_CASA_MATRIZ));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR('Sucursal: ' || V.SUC_DESC));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR(V.SUC_DIR));

      PRINT_TMU.NEW_LINE(V_IMPRESORA, 1); --1
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         CENTRAR('TIMBRADO: ' || V.DOC_NRO_TIMBRADO));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         CENTRAR('Fecha Inicio Vigencia: ' || V.TIMB_DESDE));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         CENTRAR('Fecha Fin Vigencia: ' || V.TIMB_HASTA));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR('FACTURA ' || V.TIPO_MOV));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR('Nro.: ' || V.DOC_NRO_DOC));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         CENTRAR('Fecha: ' ||
                                 TO_CHAR(V.FECHA, 'dd/mm/yyyy') ||
                                 ' Hora: ' || TO_CHAR(V.FECHA, 'hh24:mi')));

      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, 'CI/RUC : ' || V.DOC_CLI_RUC);
      PRINT_TMU.PUT_LINE(V_IMPRESORA, 'Cliente: ' || V.DOC_CLI_NOM);
      IF V.DOC_CLI = 6 THEN
        -- PRINT_TMU.PUT_LINE(V_IMPRESORA, 'Veh-Chapa: ' || :W_CHAPA);
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           'Km Actual: ' || V.DOCU_HA_KM_ACTUAL);
      END IF;
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         'Cant   Desc     P.U.        Total  Tasa%');
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      FOR X IN D LOOP
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           RPAD(X.DET_CANT, 7, ' ') || X.ART_DESC);
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           LPAD(FORMATEAR(V.DOC_MON, X.PU), 20, ' ') ||
                           LPAD(FORMATEAR(V.DOC_MON, X.IMPORTE), 13, ' ') ||
                           LPAD(X.IMPU_PORCENTAJE, 7, ' '));
      END LOOP;
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         'Total a pagar en ' || V.MON_SIMBOLO || ' ' ||
                         FORMATEAR(V.DOC_MON, V.TOTAL));

      --IMPRESION DE MONTO EN LETRAS--40CARACTERES--
      --
      V_MONTO_TEXTO := GENERAL.FP_CONV_NRO_TXT(V.TOTAL) || ' '; --
      LOOP
        V_MONTO_TEXTO_LIN := SUBSTR(V_MONTO_TEXTO, V_CAR_INI, 40);
        FOR C IN V_CAR_INI .. V_CAR_FIN LOOP
          IF SUBSTR(V_MONTO_TEXTO_LIN, C, 1) = ' ' THEN
            V_LAST_SPACE := C;
          END IF;
        END LOOP;
        V_MONTO_TEXTO_LIN := SUBSTR(V_MONTO_TEXTO, V_CAR_INI, V_LAST_SPACE);
        PRINT_TMU.PUT_LINE(V_IMPRESORA, V_MONTO_TEXTO_LIN);
        EXIT WHEN V_CAR_FIN > LENGTH(V_MONTO_TEXTO);
        V_CAR_INI := V_CAR_INI + V_LAST_SPACE;
        V_CAR_FIN := V_CAR_INI + 40;
      END LOOP;
      --
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         'Total Grav. 10%: ' ||
                         FORMATEAR(V.DOC_MON, V.DOC_GRAV_10_MON));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         'Total Grav. 5% : ' ||
                         FORMATEAR(V.DOC_MON, V.DOC_GRAV_5_MON));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         'Total Exenta   : ' ||
                         FORMATEAR(V.DOC_MON, V.DOC_NETO_EXEN_MON));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, 'Liquidacion del I.V.A.');
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         '10 % : ' ||
                         FORMATEAR(V.DOC_MON, V.DOC_IVA_10_MON));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         '5  % : ' || FORMATEAR(V.DOC_MON, V.DOC_IVA_5_MON));
      PRINT_TMU.PUT_LINE(V_IMPRESORA,
                         'Total I.V.A. : ' ||
                         FORMATEAR(V.DOC_MON, V.TOTAL_IVA));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      IF V.TIPO_MOV = 'CONTADO' THEN
        PRINT_TMU.PUT_LINE(V_IMPRESORA, 'Forma de Pago: ');
        IF V.IMPORTE_TARJETA > 0 THEN
          PRINT_TMU.PUT_LINE(V_IMPRESORA,
                             'Tarjeta  : ' ||
                             FORMATEAR(V.DOC_MON, V.IMPORTE_TARJETA));
        END IF;
        IF V.IMPORTE_CHEQUE > 0 THEN
          PRINT_TMU.PUT_LINE(V_IMPRESORA,
                             'Cheque   : ' ||
                             FORMATEAR(V.DOC_MON, V.IMPORTE_CHEQUE));
        END IF;
        IF (V.TOTAL - V.IMPORTE_TARJETA - V.IMPORTE_CHEQUE) > 0 THEN
          PRINT_TMU.PUT_LINE(V_IMPRESORA,
                             'Efectivo : ' ||
                             FORMATEAR(V.DOC_MON,
                                       V.TOTAL - V.IMPORTE_TARJETA -
                                       V.IMPORTE_CHEQUE));
        END IF;
      END IF;
      IF V.TIPO_MOV = 'CREDITO' THEN
        BEGIN
          FOR C IN (SELECT CUO_FEC_VTO
                      FROM FIN_CUOTA
                     WHERE CUO_CLAVE_DOC = I_DOC_CLAVE
                       AND CUO_EMPR = I_EMPRESA) LOOP
            V_VENCIMIENTOS := V_VENCIMIENTOS ||
                              TO_CHAR(C.CUO_FEC_VTO, 'dd/mm/yyyy') || ';';
          END LOOP;
          IF V_VENCIMIENTOS IS NOT NULL THEN
            V_VENCIMIENTOS := SUBSTR(V_VENCIMIENTOS,
                                     1,
                                     LENGTH(V_VENCIMIENTOS) - 1);
            PRINT_TMU.PUT_LINE(V_IMPRESORA,
                               'Vencimiento: ' || V_VENCIMIENTOS);
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            PRINT_TMU.PUT_LINE(V_IMPRESORA, 'Vencimiento: ');
            PRINT_TMU.NEW_LINE(V_IMPRESORA, 1);
        END;
      END IF;

      IF V.DOC_RESP_NOM IS NOT NULL THEN
        PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
        PRINT_TMU.NEW_LINE(V_IMPRESORA, 5);
        PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR(LPAD('-', 30, '-')));
        PRINT_TMU.PUT_LINE(V_IMPRESORA,
                           CENTRAR('Responsable: ' || V.DOC_RESP_NOM));
        PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR('CI: ' || V.DOC_RESP_CI));
        PRINT_TMU.PUT_LINE(V_IMPRESORA, CENTRAR('Tel: ' || V.DOC_RESP_TEL));
      END IF;
      PRINT_TMU.PUT_LINE(V_IMPRESORA, LPAD('-', 40, '-'));
      PRINT_TMU.PUT_LINE(V_IMPRESORA, 'Usuario : ' || V.DOC_LOGIN);

      IF V.TIPO_MOV = 'CREDITO' THEN
        PRINT_TMU.NEW_LINE(V_IMPRESORA, 1);
        IF v.DOC_LINEA_NEGOCIO = 4 THEN
          --EE.SS
          PRINT_TMU.PUT_LINE(V_IMPRESORA,
                             CENTRAR('*Interes a partir de la fecha de emision.'));
        ELSE
          --OTRAS LINEAS DE NEGOCIO.
          PRINT_TMU.PUT_LINE(V_IMPRESORA,
                             CENTRAR('*Interes a partir de la fecha de vencimiento.'));
        END IF;
      END IF;
      PRINT_TMU.NEW_LINE(V_IMPRESORA, 1);
      PRINT_TMU.FCLOSE(V_IMPRESORA);
      DBMS_OUTPUT.PUT_LINE(V_IMPRESORA);
    END LOOP;

  EXCEPTION
    WHEN SALIR THEN
      NULL;
    WHEN OTHERS THEN
      PRINT_TMU.FCLOSE(V_IMPRESORA); --CERRAR IMPRESORA
  END PP_IMPRIMIR_FAC_TMU;

--------------------------------

    PROCEDURE PP_TRAER_DESC_TARJETA(I_EMPRESA     IN NUMBER,
                                    I_TARJ_CODIGO IN NUMBER,
                                    O_TARJ_DESC   OUT VARCHAR2,
                                    O_TRAJ_TIPO   OUT VARCHAR2) IS
    BEGIN
      SELECT T.TARJ_DESC, T.TARJ_TIPO
      INTO O_TARJ_DESC, O_TRAJ_TIPO
       FROM FIN_TC_TARJETA T
       WHERE TARJ_EMPR=I_EMPRESA
       AND T.TARJ_CODIGO=I_TARJ_CODIGO;

     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20010, 'Tarjeta inexistente!');

       WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20010, 'Error, contactese con el soporte!');


    END;

    PROCEDURE PP_ADD_DET_TARJETA(I_CODIGO      IN NUMBER,
                              I_DESCRIPCION IN VARCHAR2,
                              I_TIPO        IN VARCHAR2,
                              I_NRO_TARJETA IN NUMBER,
                              I_VENCIMIENTO IN VARCHAR2,
                              I_ORIGEN      IN VARCHAR2,
                              I_IMPORTE     IN NUMBER,
                              I_DOC_FEC_DOC IN VARCHAR2,
                              I_TOTAL_DOC   IN VARCHAR2) IS

      V_CONF_PER_ACT_INI  VARCHAR2(12);
      V_CONF_PER_SGTE_FIN VARCHAR2(12);

      BEGIN

        IF I_CODIGO IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, el codigo no puede ser nulo!');
        END IF;
        IF I_DESCRIPCION IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, la descripcion no puede ser nula!');
        END IF;
        IF I_TIPO IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, el tipo no puede ser nulo!');
        END IF;
        IF I_NRO_TARJETA IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, el numero de tarjeta no puede ser nula!');
        END IF;

        IF I_VENCIMIENTO IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, el vencimiento no puede ser nulo!');
        ELSE
          SELECT CONF_PER_ACT_INI, CONF_PER_SGTE_FIN
            INTO V_CONF_PER_ACT_INI, V_CONF_PER_SGTE_FIN
            FROM FIN_CONFIGURACION
             WHERE CONF_EMPR = V('P_EMPRESA');

          IF NOT TO_DATE(I_VENCIMIENTO,'dd/mm/yy') BETWEEN
            TO_DATE(V_CONF_PER_ACT_INI,'dd/mm/yy') AND TO_DATE(V_CONF_PER_SGTE_FIN,'dd/mm/yy') THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error, La fecha debe estar comprendida entre el '||V_CONF_PER_ACT_INI||
                                            ' y el '||V_CONF_PER_SGTE_FIN||' !');
          END IF;

          --FECHA DE VTO NO DEBE SER MENOR A LA DEL DOCUMENTO
          IF TO_DATE(I_VENCIMIENTO,'dd/mm/yy') < TO_DATE(I_DOC_FEC_DOC,'dd/mm/yy') THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error, Fecha de vencimiento no puede ser menor que la fecha del documento!');
          END IF;

          --FECHA DE VTO NO DEBE SER MAYOR A RENDICION +30
          IF TO_DATE(I_VENCIMIENTO,'dd/mm/yy') > TO_DATE(I_DOC_FEC_DOC,'dd/mm/yy')+30 THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error, Fecha de vencimiento no puede ser mayor a mas de 30 dias despues de la rendicion!');
          END IF;


        END IF;

        IF I_ORIGEN IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, el origen no puede ser nulo!');
        END IF;
        IF I_IMPORTE IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, el importe no puede ser nulo!');
        END IF;
        IF I_TOTAL_DOC IS NULL THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, no se ha cargado ningun articulo en el detalle!');
        END IF;

        --RAISE_APPLICATION_ERROR(-20010, 'I_IMPORTE: '||I_IMPORTE||' ; '||'I_TOTAL_DOC: '||I_TOTAL_DOC);

        IF I_IMPORTE < TO_NUMBER(I_TOTAL_DOC, '9999999999999D99','NLS_NUMERIC_CHARACTERS='',.''') THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, el importe es menor al total!');
        END IF;
        IF I_IMPORTE > TO_NUMBER(I_TOTAL_DOC, '9999999999999D99','NLS_NUMERIC_CHARACTERS='',.''') THEN
          RAISE_APPLICATION_ERROR(-20010, 'Error, el importe es mayor al total!');
        END IF;


        APEX_COLLECTION.ADD_MEMBER( P_COLLECTION_NAME => 'FACI244_TARJETA',
         P_C001 => I_CODIGO,
         P_C002 => I_DESCRIPCION,
         P_C003 => I_TIPO,
         P_C004 => I_NRO_TARJETA,
         P_C005 => I_VENCIMIENTO,
         P_C006 => I_ORIGEN,
         P_C007 => I_IMPORTE);

      END;

    PROCEDURE PP_BORRAR_TARJETA(I_SEQ IN NUMBER) IS

      BEGIN

        APEX_COLLECTION.delete_member(P_COLLECTION_NAME=> 'FACI244_TARJETA',
                                      P_SEQ => I_SEQ);

        APEX_COLLECTION.resequence_collection(P_COLLECTION_NAME=>'FACI244_TARJETA');

      END;

     PROCEDURE PP_GUARDAR_TARJETA(I_EMPRESA      IN NUMBER,
                                  I_SUCURSAL     IN NUMBER,
                                  I_DOC_MON      IN NUMBER, --P6475_DOC_MON
                                  I_DOC_TASA_USD IN NUMBER, --P6475_DOC_TASA_USD
                                  I_DOC_CTA_BCO  IN NUMBER,
                                  I_DOC_NRO_DOC  IN NUMBER,
                                  I_DOC_FEC_DOC  IN VARCHAR2,
                                  I_TIPO_FACTURA IN NUMBER) IS

        F_TOT_TARJETA          NUMBER;
        MON_DEC_IMP            NUMBER;
        V_IMP_LOC              NUMBER;
        V_IMP_MON              NUMBER;
        V_CLAVE_FIN            NUMBER;
        V_CONF_COD_EXTRACCION  NUMBER;
        V_CONF_CONC_TC_INGRESO NUMBER;
        V_REG                  NUMBER :=0;
        V_CONF_CTA_TC_INGRESO  NUMBER;
        V_CLAVE_TARJ           NUMBER;
        V_CANT_DECIMALES_LOC  NUMBER;

       BEGIN

         SELECT SUM(C.C007) IMPORTE
         INTO F_TOT_TARJETA
         FROM APEX_COLLECTIONS C
         WHERE C.COLLECTION_NAME = 'FACI244_TARJETA';

         IF NVL(F_TOT_TARJETA,0) > 0 THEN

           --RAISE_APPLICATION_ERROR(-20010,'XP_DOC_CLAVE_PADRE: '||XP_DOC_CLAVE_PADRE);
           --RAISE_APPLICATION_ERROR(-20010,'F_TOT_TARJETA: '||F_TOT_TARJETA);

          --
          SELECT SUM(to_number(C.C011)) DOC_EXENTA_LOC,
           SUM(to_number(C.C010)) DOC_EXENTA_MON,
           SUM(to_number(C.C013)) DOC_GRAV_LOC,--
           SUM(to_number(C.C012)) DOC_GRAV_MON,--
           SUM(to_number(C.C014)) DOC_IVA_MON,--
           SUM(to_number(C.C015)) DOC_IVA_LOC--
           --,SUM(to_number(C.C004)) IMPORTE
            INTO TFIN_DOCUMENTO.DOC_NETO_EXEN_LOC,
                 TFIN_DOCUMENTO.DOC_NETO_EXEN_MON,--
                 TFIN_DOCUMENTO.DOC_NETO_GRAV_LOC,--
                 TFIN_DOCUMENTO.DOC_NETO_GRAV_MON,--
                 TFIN_DOCUMENTO.DOC_IVA_MON,--
                 TFIN_DOCUMENTO.DOC_IVA_LOC--
                 --,F_TOT_TARJETA
            FROM APEX_COLLECTIONS C
           WHERE C.COLLECTION_NAME = 'FACI244_DET';

           --RAISE_APPLICATION_ERROR(-20010,'TFIN_DOCUMENTO.DOC_NETO_EXEN_LOC= '||TFIN_DOCUMENTO.DOC_NETO_EXEN_LOC||' ; TFIN_DOCUMENTO.DOC_NETO_EXEN_MON= '||TFIN_DOCUMENTO.DOC_NETO_EXEN_MON);

          --
           BEGIN
              SELECT MON_DEC_IMP
                INTO MON_DEC_IMP
                FROM GEN_MONEDA
               WHERE MON_CODIGO = I_DOC_MON AND MON_EMPR = I_EMPRESA;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20010,'Error de integridad referencial: Moneda del documento no existe!');
            END;
          --
            BEGIN
              SELECT MON_DEC_IMP
                INTO V_CANT_DECIMALES_LOC
                FROM GEN_MONEDA
               WHERE MON_CODIGO = I_DOC_MON
                 AND MON_EMPR = I_EMPRESA;

            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20010,
                                        'Codigo de moneda '||I_DOC_MON||' inexistente en GEN_MONEDA!');
              WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20010, 'Error, ' || SQLERRM);
            END;
          --

            V_IMP_LOC   := ROUND(NVL(F_TOT_TARJETA,V_CANT_DECIMALES_LOC));
            V_IMP_MON   := ROUND(V_IMP_LOC/I_DOC_TASA_USD,MON_DEC_IMP);
            V_CLAVE_FIN := FIN_SEQ_DOC_NEXTVAL;
           --
            SELECT CONF_COD_EXTRACCION, CONF_CONC_TC_INGRESO
            INTO V_CONF_COD_EXTRACCION, V_CONF_CONC_TC_INGRESO
            FROM FIN_CONFIGURACION
            WHERE CONF_EMPR = I_EMPRESA;
           --
            BEGIN
              SELECT FCON_CLAVE_CTACO
                INTO V_CONF_CTA_TC_INGRESO
                FROM FIN_CONCEPTO
               WHERE FCON_CLAVE = V_CONF_CONC_TC_INGRESO
                 AND FCON_EMPR = I_EMPRESA;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20010,'No existe el concepto: '||V_CONF_CONC_TC_INGRESO||
                                   ' o falta asignarle la cuenta contable de tarjetas de credito a cobrar!');
            END;
          --

        --FIN_DOCUMENTO
-----------------------------------------------------------------------------------------
            /*
            INSERT INTO FIN_DOCUMENTO (DOC_CLAVE, DOC_EMPR,
                           DOC_SUC, DOC_CTA_BCO,
                           DOC_TIPO_MOV, DOC_NRO_DOC,
                           DOC_TIPO_SALDO, DOC_MON,
                           DOC_FEC_OPER, DOC_FEC_DOC,
                           DOC_BRUTO_EXEN_LOC, DOC_BRUTO_EXEN_MON,
                           DOC_BRUTO_GRAV_LOC, DOC_BRUTO_GRAV_MON,
                           DOC_NETO_EXEN_LOC, DOC_NETO_EXEN_MON,
                           DOC_NETO_GRAV_LOC, DOC_NETO_GRAV_MON,
                           DOC_IVA_LOC, DOC_IVA_MON, DOC_OBS,
                           DOC_CLAVE_PADRE,DOC_LOGIN, DOC_FEC_GRAB,
                           DOC_SIST, DOC_SERIE)
                     VALUES(V_CLAVE_FIN,I_EMPRESA,
                            I_SUCURSAL,I_DOC_CTA_BCO,
                            V_CONF_COD_EXTRACCION,I_DOC_NRO_DOC,
                            'C',I_DOC_MON,
                            I_DOC_FEC_DOC,I_DOC_FEC_DOC,);
              */

            --RAISE_APPLICATION_ERROR(-20010,'V_CONF_COD_EXTRACCION= '||V_CONF_COD_EXTRACCION);

            TFIN_DOCUMENTO.DOC_CLAVE      := V_CLAVE_FIN;--doc_clave,
            TFIN_DOCUMENTO.DOC_EMPR       := I_EMPRESA;--doc_empr,
            TFIN_DOCUMENTO.DOC_SUC        := I_SUCURSAL;--doc_suc,
          --  TFIN_DOCUMENTO.DOC_CTA_BCO := I_DOC_CTA_BCO;--doc_cta_bco,
            TFIN_DOCUMENTO.DOC_TIPO_MOV   := V_CONF_COD_EXTRACCION;--doc_tipo_mov,
            TFIN_DOCUMENTO.DOC_NRO_DOC    := I_DOC_NRO_DOC;--doc_nro_doc,
            TFIN_DOCUMENTO.DOC_TIPO_SALDO := 'C';--doc_tipo_saldo,
            TFIN_DOCUMENTO.DOC_MON        := I_DOC_MON;--doc_mon,
            TFIN_DOCUMENTO.DOC_FEC_OPER   := I_DOC_FEC_DOC;--doc_fec_oper,
            TFIN_DOCUMENTO.DOC_FEC_DOC    := I_DOC_FEC_DOC;--doc_fec_doc,

            /*
            TFIN_DOCUMENTO.DOC_NETO_GRAV_LOC:=0;
            TFIN_DOCUMENTO.DOC_NETO_GRAV_MON:=0;
            TFIN_DOCUMENTO.DOC_IVA_MON:=0;
            TFIN_DOCUMENTO.DOC_IVA_LOC:=0;
            */


            TFIN_DOCUMENTO.DOC_BRUTO_EXEN_LOC := TFIN_DOCUMENTO.DOC_NETO_EXEN_LOC;
            TFIN_DOCUMENTO.DOC_BRUTO_EXEN_MON := TFIN_DOCUMENTO.DOC_NETO_EXEN_MON;
            TFIN_DOCUMENTO.DOC_BRUTO_GRAV_LOC := TFIN_DOCUMENTO.DOC_NETO_GRAV_LOC;--0;--
            TFIN_DOCUMENTO.DOC_BRUTO_GRAV_MON := TFIN_DOCUMENTO.DOC_NETO_GRAV_MON; --0;--


          IF I_TIPO_FACTURA IN (1, 3) THEN
            TFIN_DOCUMENTO.DOC_CTA_BCO := I_DOC_CTA_BCO;
          ELSE
            TFIN_DOCUMENTO.DOC_CTA_BCO := NULL;
          END IF;

          /*
          IF I_TIPO_FACTURA IN (1, 3) THEN
            TFIN_DOCUMENTO.DOC_TIPO_MOV := 9;
          ELSE
            TFIN_DOCUMENTO.DOC_TIPO_MOV := 10;
          END IF;
          */

         --TFIN_DOCUMENTO.DOC_CTA_BCO := I_DOC_CTA_BCO;

            TFIN_DOCUMENTO.DOC_OBS         := 'Tarjetas/Cheques.Doc.'||I_DOC_NRO_DOC||',Tipo:'||TFIN_DOCUMENTO.DOC_TIPO_MOV;
            TFIN_DOCUMENTO.DOC_CLAVE_PADRE :=XP_DOC_CLAVE_PADRE;

            TFIN_DOCUMENTO.DOC_LOGIN    := GEN_DEVUELVE_USER;
            TFIN_DOCUMENTO.DOC_FEC_GRAB := SYSDATE;
            TFIN_DOCUMENTO.DOC_SIST     := 'FIN';
            TFIN_DOCUMENTO.DOC_SERIE    := NULL;

            INSERT INTO FIN_DOCUMENTO VALUES TFIN_DOCUMENTO;
-----------------------------------------------------------------------------------------
          --FIN_DOC_CONCEPTO
-----------------------------------------------------------------------------------------
            V_REG := V_REG+1;

             INSERT INTO FIN_DOC_CONCEPTO
            (DCON_CLAVE_DOC,
             DCON_ITEM,
             DCON_CLAVE_CONCEPTO,
             DCON_CLAVE_CTACO,
             DCON_TIPO_SALDO,
             DCON_EXEN_MON,
             DCON_EXEN_LOC,
             DCON_GRAV_LOC,
             DCON_GRAV_MON,
             DCON_IVA_LOC,
             DCON_IVA_MON,
             DCON_EMPR )
             VALUES
            (V_CLAVE_FIN,
             V_REG,
             V_CONF_CONC_TC_INGRESO,
             V_CONF_CTA_TC_INGRESO,
             'C',
             ROUND(F_TOT_TARJETA / I_DOC_TASA_USD,MON_DEC_IMP),
             F_TOT_TARJETA,
             0, 0,
             0, 0,
             I_EMPRESA);
-----------------------------------------------------------------------------------------
           --FIN_TC_CUPON
-----------------------------------------------------------------------------------------
             FOR C IN (SELECT C.SEQ_ID ITEM,
                 TO_NUMBER(C001) CODIGO,
                 C002 DESCRIPCION,
                 C003 TIPO,
                 TO_NUMBER(C004) NRO_TARJETA,
                 C005 VENCIMIENTO,
                 C006 ORIGEN,
                 TO_NUMBER(C007) IMPORTE
                 FROM APEX_COLLECTIONS C
                 WHERE COLLECTION_NAME = 'FACI244_TARJETA') LOOP

                  V_CLAVE_TARJ := FIN_SEQ_NRO_TARJ_NEXTVAL;

                  --RAISE_APPLICATION_ERROR(-20010,'V_CLAVE_TARJ: '||V_CLAVE_TARJ);

                  INSERT INTO FIN_TC_CUPON
                    (CUP_CLAVE, CUP_TARJETA,
                     CUP_NRO_TARJETA, CUP_FEC_VTO,
                     CUP_IMP_LOC, CUP_ORIGEN,
                     CUP_CLAVE_FIN,CUP_NRO_CAJA,
                     CUP_NRO_Z, CUP_LOR,
                     CUP_TARJ_ORIGEN,CUP_EMPR,CUP_LOGIN
                    ) values
                    (V_CLAVE_TARJ,C.CODIGO,
                     C.NRO_TARJETA, C.VENCIMIENTO,
                     C.IMPORTE, 'CJ',
                     V_CLAVE_FIN,I_DOC_CTA_BCO,
                     null, GEN_LUGAR_ORIGEN,
                     C.ORIGEN,I_EMPRESA,GEN_DEVUELVE_USER);

            END LOOP;

-----------------------------------------------------------------------------------------
         END IF;

       END;

  procedure add_stk_doc_combustible(
    in_datos   varchar2,
    in_empresa number,
    in_sucursal number,
    in_fecha_doc date,
    in_linea_negocio number,
    in_doc_cli       number,
    in_moneda        number
  )as  
  l_art_desc     varchar2(4000);
  l_art_clasif   number;
  l_art_impuesto number;
  
  l_impuesto_porc     number;
  l_impuesto_base_imp number;
  
  l_lipr_nro_lista_precio number;
  
  l_tasa_usd  number;
  l_tasa_comb number;
  
  l_precio_venta_art number;
  
  l_precio_final_art number;
  begin
     if in_datos is null then
       Raise_application_error(-20000, 'Es necesario que seleccione alg'||chr(250)||'n registro para que se agregue');
     end if;
         
     truncate_collection_petrobras;
     
     -- datos para el articulo
     PP_BUSCAR_IMPUESTO(
          I_EMPRESA                  => in_empresa,
          I_ART_IMPU                 => l_art_impuesto,
          O_IMPU_PORCENTAJE          => l_impuesto_porc,
          O_IMPU_PORC_BASE_IMPONIBLE => l_impuesto_base_imp
     );
       
     PP_BUSCAR_LPRECIO(I_EMPRESA     => in_empresa,
                       I_DOC_CLI     => in_doc_cli,
                       I_DOC_MON     => in_moneda,
                       O_NRO_LPRECIO => l_lipr_nro_lista_precio
                       );
        
     PP_COTIZACION_COMBUSTIBLE(I_EMPRESA       => in_empresa,
                               I_DOC_FEC_DOC   => in_fecha_doc,
                               I_DOC_MON       => in_moneda,
                               O_DOC_TASA_US   => l_tasa_usd,
                               O_DOC_TASA_COMB => l_tasa_comb
                               );
    
    -- agrega de forma global                            
    for j in (
      select d.deta_art,
             sum(d.deta_cant) cantidad
      from stk_documento_det d
      where d.deta_clave_doc in (select column_value stk_doc_clave
                from table(apex_string.split(p_str   => in_datos,
                                             p_sep   => ':'
                                             )
                          ))
      group by d.deta_art
    )
    loop
       PP_DATOS_ARTICULO(I_EMPRESA          => in_empresa,
                         I_ART_CODIGO        => j.deta_art,
                         I_LIN_NEGOC         => in_linea_negocio,
                         O_ART_DESC          => l_art_desc,
                         O_ART_CLASIFICACION => l_art_clasif,
                         O_ART_IMPU          => l_art_impuesto
                         );
                                                        
       PP_BUSCAR_PRECIO(
          I_EMPRESA          => in_empresa,
          I_ARTICULO         => j.deta_art,
          I_NRO_LISTA_PRECIO => l_lipr_nro_lista_precio,
          I_SUCURSAL         => in_sucursal,
          I_DOC_MON          => in_moneda,
          I_IMPU_PORCENTAJE  => l_impuesto_porc,
          I_RECARGO          => null,
          I_DOC_TASA_COMB    => l_tasa_comb,
          O_PRECIO_VENTA     => l_precio_venta_art
          );   
          
       l_precio_final_art := (l_precio_venta_art * j.cantidad);
        
       PP_ADD_DET(I_EMPRESA           => in_empresa,
                  I_SUCURSAL          => in_sucursal,
                  I_NRO_LISTA_PRECIO  => l_lipr_nro_lista_precio,
                  I_ARTICULO          => j.deta_art,
                  I_CANTIDAD          => j.cantidad,
                  I_PRECIO            => l_precio_venta_art,
                  I_IMPORTE           => l_precio_final_art,
                  I_DOC_MON           => in_moneda,
                  I_CLI_PORC_EXEN_IVA => null,
                  I_DOC_TASA          => l_tasa_usd,
                  I_DESCUENTO_GS      => 0,                    
                  I_RECARGO           => 0,
                  I_DOC_TASA_COMB     => l_tasa_comb,
                  in_es_comb_petrobras => true
                 );
    end loop;
        
    <<f_add_members>>
    for i in (select column_value stk_doc_clave
              from table(apex_string.split(p_str   => in_datos,
                                           p_sep   => ':'
                                           )
                        )
             )
    loop
      apex_collection.add_member(p_collection_name => co_petrobras_comb,
                                 p_c001            => i.stk_doc_clave,
                                 p_c002            => in_empresa
                                 );
    end loop f_add_members;
    
  end add_stk_doc_combustible; 
  
  procedure truncate_collection_petrobras as
  begin
    -- elimina todos los registros de las selecciones de consumo de petrobras
    apex_collection.create_or_truncate_collection(p_collection_name => co_petrobras_comb);
    
    -- si existe ya detalle y alguno es de PETROBRAS los elimina completamente
    if apex_collection.collection_exists ( p_collection_name => co_faci_det) then
      <<del_det_member>>
      for i in (
        select c.seq_id
         from apex_collections c
        where c.collection_name = co_faci_det
        and   to_number(nvl(c.c024, '0')) = 1
      )loop
        apex_collection.delete_member(p_collection_name => co_faci_det,
                                      p_seq             => i.seq_id);   
      end loop del_det_member;
    end if;
    
  end truncate_collection_petrobras;
  
END FACI244;
/
