CREATE OR REPLACE PACKAGE COMI001 AS
  /******************************************************************************
     NAME:       COMI001
     PURPOSE:

     REVISIONS:
     VER        DATE        AUTHOR           DESCRIPTION
     ---------  ----------  ---------------  ------------------------------------
     1.0        29/12/2017      MONICA GODOY       1. CREATED THIS PACKAGE.
  ******************************************************************************/

  PROCEDURE PP_CARGAR_DATOS(O_W_FLAG_COMMIT           OUT VARCHAR2,
                            O_P_PAGO_BANCO            OUT VARCHAR2,
                            O_P_MON_US                OUT NUMBER,
                            O_P_MON_LOC               OUT NUMBER,
                            O_P_IND_OPERADOR          OUT VARCHAR2,
                            I_P_OPER                  IN VARCHAR2,
                            I_EMPRESA                 IN NUMBER,
                            I_OPCION                  IN NUMBER,
                            I_IMPUESTO                IN NUMBER,
                            I_IMPRESORA               IN NUMBER,
                            O_CONF_IND_INTEGRAR_STK   OUT COM_CONFIGURACION.CONF_IND_INTEGRAR_STK%TYPE,
                            O_CONF_IND_INTEGRAR_PRD   OUT COM_CONFIGURACION.CONF_IND_INTEGRAR_PRD%TYPE,
                            O_CONF_IND_INTEGRAR_ACT   OUT COM_CONFIGURACION.CONF_IND_INTEGRAR_ACT%TYPE,
                            O_CONF_CONC_MERC          OUT COM_CONFIGURACION.CONF_CONC_MERC%TYPE,
                            O_CONF_CONC_OT            OUT COM_CONFIGURACION.CONF_CONC_OT%TYPE,
                            O_CONF_CONC_ACT           OUT COM_CONFIGURACION.CONF_CONC_ACT%TYPE,
                            O_CONF_CONC_IMPU          OUT COM_CONFIGURACION.CONF_CONC_IMPU%TYPE,
                            O_CONF_CONC_IMPU_5        OUT COM_CONFIGURACION.CONF_CONC_IMPU_5%TYPE,
                            O_CONF_CONC_DEV_MERC      OUT COM_CONFIGURACION.CONF_CONC_DEV_MERC%TYPE,
                            O_CONF_CONC_DEV_OT        OUT COM_CONFIGURACION.CONF_CONC_DEV_OT%TYPE,
                            O_CONF_CONC_DEV_IMPU      OUT COM_CONFIGURACION.CONF_CONC_DEV_IMPU%TYPE,
                            O_CONF_CONC_DEV_IMPU_5    OUT COM_CONFIGURACION.CONF_CONC_DEV_IMPU_5%TYPE,
                            O_CONF_IND_CTACO_STK_CLAS OUT COM_CONFIGURACION.CONF_IND_CTACO_STK_CLAS%TYPE,
                            O_P_IND_CANT              OUT VARCHAR2,
                            O_P_IND_IMP               OUT VARCHAR2,
                            O_STK_CONF_FACT_CO_REC    OUT STK_CONFIGURACION.CONF_FACT_CO_REC%TYPE,
                            O_STK_CONF_FACT_CR_REC    OUT STK_CONFIGURACION.CONF_FACT_CR_REC%TYPE,
                            O_STK_CONF_NOTA_CR_REC    OUT STK_CONFIGURACION.CONF_NOTA_CR_REC%TYPE,
                            O_STK_CONF_PER_ACT_INI    OUT STK_PERIODO.PERI_FEC_INI%TYPE,
                            O_STK_CONF_PER_ACT_FIN    OUT STK_PERIODO.PERI_FEC_FIN%TYPE,
                            O_STK_CONF_PER_SGTE_INI   OUT STK_PERIODO.PERI_FEC_INI%TYPE,
                            O_STK_CONF_PER_SGTE_FIN   OUT STK_PERIODO.PERI_FEC_FIN%TYPE,
                            O_CONF_MES_ACT            OUT ACT_CONFIGURACION.CONF_MES_ACT%TYPE,
                            O_CONF_OPER_COMPRA        OUT ACT_CONFIGURACION.CONF_OPER_COMPRA%TYPE,
                            O_P_MAX_ITEMS_FAC_CO      OUT FAC_CONFIGURACION.CONF_MAX_ITEMS_FAC_CO%TYPE,
                            O_PORC_IMPU               OUT GEN_IMPUESTO.IMPU_PORCENTAJE%TYPE,
                            O_W_TIPO_IMPRESION        OUT VARCHAR2,
                            O_TIMBRADO                OUT NUMBER,
                            O_TIPO_IMPRESION          OUT VARCHAR2,
                            O_CANT_DECIMALES_LOC      OUT NUMBER,
                            O_CANT_DECIMALES_US       OUT NUMBER,
                            O_P_TABLAS                OUT VARCHAR2);

  PROCEDURE PP_FORMA_NRO_DOCU(I_S_ESTABLECIMIENTO   IN NUMBER,
                              I_S_EMISION           IN NUMBER,
                              I_S_DOC_NRO_DOC       IN NUMBER,
                              O_DOCU_NRO_DOC        OUT NUMBER,
                              O_DOCU_NRO_DOC_FORMAT OUT VARCHAR);

  PROCEDURE PP_BUSCAR_ORDEN_COMPRA(I_EMPRESA            IN NUMBER,
                                   I_ORDEN_COMPRA       IN VARCHAR2, ---LV
                                   O_OCOM_CLAVE         OUT VARCHAR2, --STK_ORDEN_COMPRA.OCOM_CLAVE%TYPE,
                                   O_S_ORDEN_COMPRA     OUT VARCHAR2, --STK_ORDEN_COMPRA.OCOM_NRO%TYPE,
                                   O_DOCU_MON           OUT STK_ORDEN_COMPRA.OCOM_MON%TYPE,
                                   O_DOCU_PROV          OUT STK_ORDEN_COMPRA.OCOM_PROV%TYPE,
                                   O_DOCU_DEP_ORIG      OUT STK_ORDEN_COMPRA.OCOM_DEPOSITO%TYPE,
                                   O_MON_SIMBOLO        OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                   O_DEP_DESC           OUT STK_DEPOSITO.DEP_DESC%TYPE,
                                   O_OCOM_PLAZO         OUT STK_ORDEN_COMPRA.OCOM_PLAZO%TYPE,
                                   O_S_RETEN_LOC        OUT NUMBER,
                                   O_S_RETEN_MON        OUT NUMBER,
                                   O_DOCU_EXEN_NETO_MON OUT NUMBER,
                                   O_DOCU_EXEN_NETO_LOC OUT NUMBER,
                                   O_DOC_GRAV_5_LOC     OUT NUMBER,
                                   O_DOC_GRAV_10_LOC    OUT NUMBER,
                                   O_DOC_GRAV_5_MON     OUT NUMBER,
                                   O_DOC_GRAV_10_MON    OUT NUMBER,
                                   O_DOCU_IVA_LOC       OUT NUMBER,
                                   O_DOCU_IVA_MON       OUT NUMBER,
                                   O_S_ORCOM_SUC        OUT NUMBER,
                                   I_NRO_DOCUMENTO      IN NUMBER,
                                   I_REC_NRO_ORDEN      OUT NUMBER);

  PROCEDURE PP_MOSTRAR_DATOS_PROVEEDOR(I_DOC_TIMBRADO     IN OUT NUMBER,
                                       I_DOCU_PROV        IN NUMBER,
                                       I_EMPRESA          IN NUMBER,
                                       I_DOCU_TIPO_MOV    IN NUMBER,
                                       I_CONF_FACT_COMPRA IN NUMBER,
                                       I_CONF_FACT_CR_REC IN NUMBER,
                                       I_CONF_FACT_CO_REC IN NUMBER,
                                       --I_W_IND_RETENCION    IN VARCHAR2,
                                       -- I_PROV_PAIS          IN NUMBER,
                                       O_DOCU_PROV_NOM     OUT FIN_PROVEEDOR.PROV_RAZON_SOCIAL%TYPE,
                                       O_S_DIRECCION       OUT FIN_PROVEEDOR.PROV_DIR%TYPE,
                                       O_S_TELEF           OUT FIN_PROVEEDOR.PROV_TEL%TYPE,
                                       O_P_PROV_PLAZO_PAGO OUT FIN_PROVEEDOR.PROV_PLAZO_PAGO%TYPE,
                                       O_DOC_RUC_DV        OUT FIN_PROVEEDOR.PROV_RUC_DV%TYPE,
                                       O_DOC_DV            OUT FIN_PROVEEDOR.PROV_DV%TYPE,
                                       O_DOC_TIMBRADO      OUT FIN_PROVEEDOR.PROV_TIMBRADO%TYPE,
                                       O_W_IND_RETENCION   OUT FIN_PROVEEDOR.PROV_IND_RETENCION%TYPE,
                                       O_W_PROV_PAIS       OUT FIN_PROVEEDOR.PROV_PAIS%TYPE,
                                       O_S_RETENCION       OUT VARCHAR2,
                                       O_S_RETENCION_RENTA OUT VARCHAR2,
                                       O_S_RETENCION_100   OUT VARCHAR2,
                                       O_S_PORC_RENTA      OUT NUMBER,
                                       O_DOCU_PROV_RUC     OUT NUMBER);

  PROCEDURE PP_VALIDAR_PROV_MON(I_EMPRESA   IN NUMBER,
                                I_DOCU_PROV IN NUMBER,
                                I_DOCU_MON  IN NUMBER);

  PROCEDURE PP_VALIDAR_DOC_EXIST(I_EMPRESA       IN NUMBER,
                                 I_DOCU_NRO_DOC  IN FIN_DOCUMENTO_COMI015_TEMP.DOC_NRO_DOC%TYPE,
                                 I_DOCU_PROV     IN NUMBER,
                                 I_DOCU_TIPO_MOV IN NUMBER,
                                 I_DOC_TIMBRADO  IN NUMBER);

  PROCEDURE PP_MOSTRAR_CTA_BANCARIA(I_EMPRESA          IN NUMBER,
                                    I_S_CTA_BCO        IN NUMBER,
                                    I_USER             IN VARCHAR2,
                                    I_TMOV_TIPO_SALDO  IN VARCHAR2,
                                    I_DOCU_FEC_EMIS    IN DATE,
                                    I_P_MON_LOC        IN NUMBER,
                                    I_DOCU_TIPO_MOV    IN NUMBER,
                                    I_CONF_FACT_CR_REC IN NUMBER,
                                    I_S_CREDITO        IN VARCHAR2,
                                    I_DOCU_PROV        IN NUMBER,
                                    O_P_CTA_DESC       OUT VARCHAR2,
                                    O_S_CTA_DESC       OUT VARCHAR2,
                                    O_S_BCO_DESC       OUT VARCHAR2,
                                    O_DOCU_MON         OUT NUMBER,
                                    O_P_CTA_BCO_DIA    OUT NUMBER,
                                    O_MON_SIMBOLO      OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                    O_MON_DEC_IMP      OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                    O_MON_DEC_PRECIO   OUT GEN_MONEDA.MON_DEC_PRECIO%TYPE,
                                    O_MON_DEC_TASA     OUT GEN_MONEDA.MON_DEC_TASA%TYPE,
                                    O_MON_DESC         OUT GEN_MONEDA.MON_DESC%TYPE,
                                    O_W_MON_DEC_IMP    OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                    O_S_TASA           OUT NUMBER,
                                    O_DES_TASA         OUT VARCHAR2
                                    /*IO_DOCU_EXEN_NETO_MON IN OUT NUMBER,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      IO_DOCU_GRAV_NETO_MON IN OUT NUMBER,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      IO_DOC_GRAV_5_MON     IN OUT NUMBER,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      IO_DOC_GRAV_10_MON    IN OUT NUMBER,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      IO_DOCU_IVA_MON       IN OUT NUMBER*/);

  PROCEDURE PP_MOSTRAR_DESC_TIPO_MOV(I_EMPRESA         IN NUMBER,
                                     I_DOCU_TIPO_MOV   IN NUMBER,
                                     O_TMOV_DESC       OUT GEN_TIPO_MOV.TMOV_DESC%TYPE,
                                     O_TMOV_TIPO_SALDO OUT GEN_TIPO_MOV.TMOV_TIPO%TYPE);

  PROCEDURE PP_CTA_CHEQ_EMIT_DIF(I_EMPRESA             IN NUMBER,
                                 I_S_CTA_BCO           IN NUMBER,
                                 I_DOCU_TIPO_MOV       IN NUMBER,
                                 I_CONF_FACT_CR_REC    IN NUMBER,
                                 I_CONF_NOTA_CR_REC    IN NUMBER,
                                 I_S_CREDITO           IN VARCHAR2,
                                 O_P_BANCO             OUT FIN_CUENTA_BANCARIA.CTA_BCO%TYPE,
                                 O_P_IND_CHEQUE_DIF    OUT FIN_CUENTA_BANCARIA.CTA_IND_CHEQ_DIF%TYPE,
                                 O_MOSTRAR_BTN_CHEQUES OUT NUMBER,
                                 O_P_IMP_CHEQUE        OUT VARCHAR2);

  PROCEDURE PP_BUSCAR_NRO_RETENCION(I_EMPRESA         IN NUMBER,
                                    O_S_NRO_RETENCION OUT GEN_IMPRESORA.IMP_ULT_RETENCION%TYPE);

  PROCEDURE PP_TRAER_DESC_FCON(I_CONCEPTO                   IN NUMBER,
                               I_EMPRESA                    IN NUMBER,
                               I_TMOV_TIPO_SALDO            IN VARCHAR2,
                               I_DOCU_PROV_NOM              IN VARCHAR2,
                               O_CLAVE_CONCEPTO             OUT NUMBER,
                               O_FCON_DESC                  OUT VARCHAR2,
                               O_CLAVE_CTACO                OUT NUMBER,
                               O_FCON_IND_CLAVE_IMPORTACION OUT VARCHAR2,
                               O_DETA_CANT                  OUT NUMBER,
                               O_DETA_KM_ACTUAL             OUT NUMBER,
                               O_CANAL_REQUERIDO            OUT VARCHAR2,
                               O_CAT_FCON                   OUT NUMBER,
                               O_IND_CANT_KM                OUT VARCHAR2);

  PROCEDURE PP_TRAER_CUENTA_CONTABLE(I_EMPRESA     IN NUMBER,
                                     I_CONCEPTO    IN NUMBER,
                                     I_CLAVE_CTACO IN CNT_CUENTA.CTAC_CLAVE%TYPE,
                                     O_DCON_CUENTA OUT CNT_CUENTA.CTAC_NRO%TYPE,
                                     O_CONT_DESC   OUT CNT_CUENTA.CTAC_DESC%TYPE);

  PROCEDURE PP_TRAER_DESC_CONT(I_EMPRESA     IN NUMBER,
                               I_DCON_CUENTA IN CNT_CUENTA.CTAC_NRO%TYPE,
                               O_CONT_DESC   OUT CNT_CUENTA.CTAC_DESC%TYPE,
                               O_CLAVE_CTACO OUT CNT_CUENTA.CTAC_CLAVE%TYPE);

  PROCEDURE PP_VALIDAR_TIPO_IMPU(I_IND_TIPO_IVA_COMPRA IN GEN_TIPO_IMPUESTO.TIMPU_CODIGO%TYPE,
                                 I_EMPRESA             IN NUMBER,
                                 O_TIPO_IVA_DESC       OUT GEN_TIPO_IMPUESTO.TIMPU_DESC%TYPE);

  PROCEDURE PP_VALIDAR_TOTAL(I_IMPU_PORCENTAJE          IN NUMBER,
                             I_IMPU_PORC_BASE_IMPONIBLE IN NUMBER,
                             I_DETA_CANT                IN NUMBER,
                             I_PREC_UNIT                IN NUMBER,
                             I_MON_DEC_IMP              IN NUMBER,
                             O_TOTAL                    IN OUT NUMBER,
                             O_EXENTO                   IN OUT NUMBER,
                             IO_IVA                     IN OUT NUMBER,
                             IO_GRAVADO                 IN OUT NUMBER);

  PROCEDURE PP_VALIDAR_GRAVADO(I_OPCION          IN VARCHAR2,
                               I_IMPU_PORCENTAJE IN NUMBER,
                               I_MON_DEC_IMP     IN NUMBER,
                               IO_GRAVADO        IN OUT NUMBER,
                               IO_IVA            IN OUT NUMBER,
                               IO_EXENTO         IN OUT NUMBER,
                               IO_TOTAL          IN OUT NUMBER);

  PROCEDURE PP_EXHIBIR_DESC_ART(I_EMPRESA                  IN NUMBER,
                                I_DETA_ART                 IN STK_ARTICULO.ART_CODIGO%TYPE,
                                O_ART_DESC_ABREV           OUT STK_ARTICULO.ART_DESC_ABREV%TYPE,
                                O_ART_DESC                 OUT STK_ARTICULO.ART_DESC%TYPE,
                                O_ART_IMPU                 OUT STK_ARTICULO.ART_IMPU%TYPE,
                                O_ART_TIPO_COMISION        OUT STK_ARTICULO.ART_TIPO_COMISION%TYPE,
                                O_IMPU_PORCENTAJE          OUT GEN_IMPUESTO.IMPU_PORCENTAJE%TYPE,
                                O_IMPU_PORC_BASE_IMPONIBLE OUT GEN_IMPUESTO.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                                O_IMPU_INCLUIDO            OUT GEN_IMPUESTO.IMPU_INCLUIDO%TYPE);
  -- O_CTL_SERIE                OUT STK_ARTICULO.ART_CONTROL_SERIE%TYPE);

  PROCEDURE PP_GUARDAR_COMI001_TMP(I_OPCION                   IN COMI001_DET_TMP.OPCION%TYPE,
                                   I_CONCEPTO                 IN COMI001_DET_TMP.CONCEPTO%TYPE,
                                   I_OT                       IN COMI001_DET_TMP.OT%TYPE,
                                   I_DCON_CUENTA              IN COMI001_DET_TMP.DCON_CUENTA%TYPE,
                                   I_DCON_CANAL               IN COMI001_DET_TMP.DCON_CANAL%TYPE,
                                   I_DCON_DIV_CANAL           IN COMI001_DET_TMP.DCON_DIV_CANAL%TYPE,
                                   I_NRO_IMPORTACION          IN COMI001_DET_TMP.NRO_IMPORTACION%TYPE,
                                   I_CANT                     IN COMI001_DET_TMP.CANT%TYPE,
                                   I_KM_ACTUAL                IN COMI001_DET_TMP.KM_ACTUAL%TYPE,
                                   I_PREC_UNIT                IN COMI001_DET_TMP.PREC_UNIT%TYPE,
                                   I_OBS                      IN COMI001_DET_TMP.OBS%TYPE,
                                   I_IND_TIPO_IVA_COMPRA      IN COMI001_DET_TMP.IND_TIPO_IVA_COMPRA%TYPE,
                                   I_PC_DCTO                  IN COMI001_DET_TMP.PC_DCTO%TYPE,
                                   I_IMPU_PORC_BASE_IMPONIBLE IN COMI001_DET_TMP.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                                   I_IMPU_PORCENTAJE          IN COMI001_DET_TMP.IMPU_PORCENTAJE%TYPE,
                                   I_TOTAL                    IN COMI001_DET_TMP.TOTAL%TYPE,
                                   I_EXENTO                   IN COMI001_DET_TMP.EXENTO%TYPE,
                                   I_GRAVADO                  IN COMI001_DET_TMP.GRAVADO%TYPE,
                                   I_IVA                      IN COMI001_DET_TMP.IVA%TYPE,
                                   I_SESSION_ID               IN COMI001_DET_TMP.SESSION_ID%TYPE,
                                   I_USUARIO                  IN COMI001_DET_TMP.USUARIO%TYPE,
                                   I_TIMBRADO                 IN COMI001_DET_TMP.TIMBRADO%TYPE,
                                   I_DESC_LARGA               IN COMI001_DET_TMP.DESC_LARGA%TYPE,
                                   I_CONT_DESC                IN COMI001_DET_TMP.CONT_DESC%TYPE,
                                   I_ART                      IN COMI001_DET_TMP.ART%TYPE,
                                   I_DCON_CLAVE_IMP           IN COMI001_DET_TMP.DCON_CLAVE_IMP%TYPE,
                                   I_EMPRESA                  IN NUMBER,
                                   I_NRO_ITEM                 IN COMI001_DET_TMP.NRO_ITEM%TYPE,
                                   I_IMP_AFECTA_COSTO         IN COMI001_DET_TMP.IMP_AFECTA_COSTO%TYPE,
                                   I_IND_ORDEN_COMPRA         IN VARCHAR2 DEFAULT NULL,
                                   I_CANT_FAC_ANT             IN NUMBER,
                                   I_IND_VIATICO              IN COMI001_DET_TMP.IND_RESPONSABLE_VIATICO%TYPE);

  PROCEDURE PP_MOSTRAR_DESC_MONEDA(I_EMPRESA          IN NUMBER,
                                   I_DOCU_MON         IN NUMBER,
                                   I_DOCU_TIPO_MOV    IN NUMBER,
                                   I_CONF_FACT_CR_REC IN NUMBER,
                                   I_S_CREDITO        IN VARCHAR2,
                                   I_DOCU_PROV        IN NUMBER,
                                   I_P_MON_LOC        IN NUMBER,
                                   I_DOCU_FEC_EMIS    IN DATE,
                                   I_USER             IN VARCHAR2,
                                   O_MON_SIMBOLO      OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                   O_MON_DEC_IMP      OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                   O_MON_DEC_PRECIO   OUT GEN_MONEDA.MON_DEC_PRECIO%TYPE,
                                   O_MON_DEC_TASA     OUT GEN_MONEDA.MON_DEC_TASA%TYPE,
                                   O_MON_DESC         OUT GEN_MONEDA.MON_DESC%TYPE,
                                   O_W_MON_DEC_IMP    OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                   O_S_TASA           OUT NUMBER,
                                   O_DES_TASA         OUT VARCHAR2
                                   /*IO_DOCU_EXEN_NETO_MON IN OUT NUMBER,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        IO_DOCU_GRAV_NETO_MON IN OUT NUMBER,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        IO_DOC_GRAV_5_MON     IN OUT NUMBER,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        IO_DOC_GRAV_10_MON    IN OUT NUMBER,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        IO_DOCU_IVA_MON       IN OUT NUMBER*/);

  PROCEDURE PP_VALIDAR_ENCABEZADO(I_DOCU_TIPO_MOV         IN NUMBER,
                                  I_DOCU_FEC_OPER         IN DATE,
                                  I_DOCU_NRO_DOC_FORMAT   IN VARCHAR2,
                                  I_DOCU_PROV             IN NUMBER,
                                  I_DOC_TIMBRADO          IN NUMBER,
                                  I_S_CTA_BCO             IN NUMBER,
                                  I_DOCU_MON              IN NUMBER,
                                  I_DOCU_DEP_ORIG         IN NUMBER,
                                  I_EMPRESA               IN NUMBER,
                                  I_USER                  IN VARCHAR2,
                                  I_DOCU_FEC_EMIS         IN DATE,
                                  I_CONF_PER_ACT_INI      IN DATE,
                                  I_CONF_PER_SGTE_FIN     IN DATE,
                                  I_CONF_MES_ACT          IN DATE,
                                  I_CONF_IND_INTEGRAR_PRD IN VARCHAR2,
                                  I_P_MON_US              IN NUMBER,
                                  I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                  I_ORDEN_COMPRA          IN VARCHAR2, --NUMBER,
                                  I_ORCOM_SUC             IN NUMBER,
                                  I_RETENCION_100         IN VARCHAR2,
                                  I_DOCU_EXEN_NETO_MON    IN NUMBER,
                                  I_DOCU_IVA_MON          IN NUMBER,
                                  I_TOT_DOC               IN NUMBER);

  PROCEDURE PP_FEC_PROX_VTO(I_IND_CHEQUE_DIF IN VARCHAR2,
                            I_DOCU_FEC_EMIS  IN DATE,
                            IO_FEC_PRIM_VTO  OUT DATE,
                            I_PLAZO_PAGO     IN NUMBER DEFAULT NULL,
                            I_EMPRESA        IN NUMBER DEFAULT NULL,
                            I_TIPO_MOV       IN NUMBER DEFAULT NULL);

  PROCEDURE PP_VALIDAR_FEC_VTO(I_IND_CHEQUE_DIF IN VARCHAR2,
                               I_FEC_PRIM_VTO   IN DATE,
                               I_DOCU_FEC_EMIS  IN DATE);

  PROCEDURE PP_GENERAR_CHEQUES(I_CANT_CHEQUES       IN NUMBER,
                               I_FEC_PRIM_VTO       IN DATE,
                               I_TIPO_VENCIMIENTO   IN VARCHAR2,
                               I_DIAS_ENTRE_CHEQUES IN NUMBER,
                               I_MON_DEC_IMP        IN NUMBER,
                               I_TOTAL_IMP          IN NUMBER,
                               I_BENEFICIARIO       IN VARCHAR2,
                               I_IND_CHEQUE_DIF     IN VARCHAR2,
                               I_CTA_BCO_DIA        IN NUMBER,
                               I_EMPRESA            IN NUMBER,
                               I_CTA_BCO            IN NUMBER,
                               I_PAGO_BANCO         IN VARCHAR2,
                               I_BANCO_CHEQUE       IN NUMBER);

  PROCEDURE PP_UPDATE_CHEQUES(I_CUO_FEC_VTO  IN DATE,
                              I_CUO_IMP_MON  IN NUMBER,
                              I_SERIE        IN VARCHAR2,
                              I_NRO_CHEQUE   IN NUMBER,
                              I_BENEFICIARIO IN VARCHAR2,
                              I_BANCO        IN NUMBER,
                              I_SEQ          IN NUMBER);

  PROCEDURE PP_GENERAR_CUOTA(I_FEC_PRIM_VTO      IN DATE,
                             I_FEC_OPER          IN DATE,
                             I_TOTAL             IN NUMBER,
                             I_OP_CUOTA          IN VARCHAR2,
                             I_CANT_CUOTAS       IN NUMBER,
                             I_TIPO_VENCIMIENTO  IN VARCHAR2,
                             I_DIAS_ENTRE_CUOTAS IN NUMBER,
                             I_MON_DEC_IMP       IN NUMBER,
                             I_PLAZO_PAGO        IN VARCHAR2,
                             I_EMPRESA           IN NUMBER,
                             I_PROV_PLAZO        IN NUMBER,
                             I_FEC_EMI           IN DATE,
                             I_TIPO_MOV          IN NUMBER);

  PROCEDURE PP_BUSCAR_ORDEN_COMPRA_DET(I_OCOM_CLAVE    IN VARCHAR2,
                                       I_EMPRESA       IN NUMBER,
                                       I_DOCU_MON      IN NUMBER,
                                       I_USUARIO       IN VARCHAR2,
                                       I_TIMBRADO      IN NUMBER,
                                       I_MON_DEC_IMP   IN NUMBER,
                                       I_SESSION_ID    IN NUMBER,
                                       I_REC_NRO_ORDEN IN NUMBER,
                                       I_NRO_DOCUMENTO IN NUMBER);

  PROCEDURE PP_VALIDAR_NRO_IMPORTACION(I_FCON_IND_CLAVE_IMPORTACION IN VARCHAR2,
                                       I_NRO_IMPORTACION            IN NUMBER,
                                       I_EMPRESA                    IN NUMBER,
                                       O_DCON_CLAVE_IMP             OUT IMP_IMPORTACION.IMP_CLAVE%TYPE);
  PROCEDURE PP_MOSTRAR_CANAL(P_EMPRESA        IN NUMBER,
                             I_DCON_CANAL     IN NUMBER,
                             O_DCON_DIV_CANAL OUT NUMBER);

  PROCEDURE PP_MOSTRAR_DIV_CANAL(P_EMPRESA        IN NUMBER,
                                 I_DCON_CANAL     IN NUMBER,
                                 I_DCON_DIV_CANAL IN NUMBER);

  PROCEDURE PP_TERMINAR_PROCESO(I_SESSION_ID IN COMI001_DET_TMP.SESSION_ID%TYPE,
                                I_USUARIO    IN COMI001_DET_TMP.USUARIO%TYPE,
                                I_TIMBRADO   IN COMI001_DET_TMP.TIMBRADO%TYPE);

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_FIN(I_EMPRESA               IN FIN_DOCUMENTO.DOC_EMPR%TYPE,
                                        I_SUCURSAL              IN FIN_DOCUMENTO.DOC_SUC%TYPE,
                                        I_DOCU_NRO_DOC          IN FIN_DOCUMENTO.DOC_NRO_DOC%TYPE,
                                        I_DOCU_MON              IN FIN_DOCUMENTO.DOC_MON%TYPE,
                                        I_DOCU_PROV             IN FIN_DOCUMENTO.DOC_PROV%TYPE,
                                        I_DOCU_CLI              IN FIN_DOCUMENTO.DOC_CLI%TYPE,
                                        I_DOCU_PROV_NOM         IN FIN_DOCUMENTO.DOC_CLI_NOM%TYPE,
                                        I_DOCU_PROV_RUC         IN FIN_DOCUMENTO.DOC_CLI_RUC%TYPE,
                                        I_S_TELEF               IN FIN_DOCUMENTO.DOC_CLI_TEL%TYPE,
                                        I_S_DIRECCION           IN FIN_DOCUMENTO.DOC_CLI_DIR%TYPE,
                                        I_DOC_RUC_DV            IN FIN_DOCUMENTO.DOC_RUC_DV%TYPE,
                                        I_DOC_DV                IN FIN_DOCUMENTO.DOC_DV%TYPE,
                                        I_DOC_TIMBRADO          IN FIN_DOCUMENTO.DOC_TIMBRADO%TYPE,
                                        I_OCOM_CLAVE            IN VARCHAR2,
                                        I_DOCU_FEC_OPER         IN FIN_DOCUMENTO.DOC_FEC_OPER%TYPE,
                                        I_DOCU_FEC_EMIS         IN FIN_DOCUMENTO.DOC_FEC_DOC%TYPE,
                                        I_DOCU_GRAV_NETO_LOC    IN FIN_DOCUMENTO.DOC_NETO_GRAV_LOC%TYPE,
                                        I_DOCU_GRAV_NETO_MON    IN FIN_DOCUMENTO.DOC_NETO_GRAV_MON%TYPE,
                                        I_DOCU_EXEN_NETO_LOC    IN FIN_DOCUMENTO.DOC_NETO_EXEN_LOC%TYPE,
                                        I_DOCU_EXEN_NETO_MON    IN FIN_DOCUMENTO.DOC_NETO_EXEN_MON%TYPE,
                                        I_DOCU_IVA_LOC          IN FIN_DOCUMENTO.DOC_IVA_LOC%TYPE,
                                        I_DOCU_IVA_MON          IN FIN_DOCUMENTO.DOC_IVA_MON%TYPE,
                                        I_DOCU_OBS              IN FIN_DOCUMENTO.DOC_OBS%TYPE,
                                        I_DOC_OPERADOR          IN FIN_DOCUMENTO.DOC_OPERADOR%TYPE,
                                        I_DOC_GRAV_5_MON        IN FIN_DOCUMENTO.DOC_GRAV_5_MON%TYPE,
                                        I_DOC_GRAV_5_LOC        IN FIN_DOCUMENTO.DOC_GRAV_5_LOC%TYPE,
                                        I_DOC_GRAV_10_MON       IN FIN_DOCUMENTO.DOC_GRAV_10_MON%TYPE,
                                        I_DOC_GRAV_10_LOC       IN FIN_DOCUMENTO.DOC_GRAV_10_LOC%TYPE,
                                        I_DOC_IVA_5_MON         IN FIN_DOCUMENTO.DOC_IVA_5_MON%TYPE,
                                        I_DOC_IVA_5_LOC         IN FIN_DOCUMENTO.DOC_IVA_5_LOC%TYPE,
                                        I_DOC_IVA_10_MON        IN FIN_DOCUMENTO.DOC_IVA_10_MON%TYPE,
                                        I_DOC_IVA_10_LOC        IN FIN_DOCUMENTO.DOC_IVA_10_LOC%TYPE,
                                        I_S_CTA_BCO             IN FIN_DOCUMENTO.DOC_CTA_BCO%TYPE,
                                        I_DOCU_TIPO_MOV         IN FIN_DOCUMENTO.DOC_TIPO_MOV%TYPE,
                                        I_DOCU_DEP_ORIG         IN STK_DOCUMENTO.DOCU_DEP_ORIG%TYPE,
                                        O_DOC_CLAVE             OUT FIN_DOCUMENTO.DOC_CLAVE%TYPE,
                                        O_DOC_CLAVE_STK         OUT FIN_DOCUMENTO.DOC_CLAVE_STK%TYPE,
                                        I_P_TABLAS              IN VARCHAR2,
                                        I_CLAVE_TMP             IN NUMBER DEFAULT NULL,
                                        I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                        I_TIPO_DOC_PRO_CLI      IN FIN_DOCUMENTO.DOC_TIPO_DOC_CLI_PROV%TYPE);

  PROCEDURE PP_ACTUALIZAR_DOC_RETEN(I_EMPRESA             IN FIN_DOCUMENTO.DOC_EMPR%TYPE,
                                    I_SUCURSAL            IN FIN_DOCUMENTO.DOC_SUC%TYPE,
                                    I_S_NRO_RETENCION     IN FIN_DOCUMENTO.DOC_NRO_DOC%TYPE,
                                    I_S_TIMBRADO          IN FIN_DOCUMENTO.DOC_TIMBRADO%TYPE,
                                    DOCU_MON              IN FIN_DOCUMENTO.DOC_MON%TYPE,
                                    DOCU_PROV             IN FIN_DOCUMENTO.DOC_PROV%TYPE,
                                    DOCU_CLI              IN FIN_DOCUMENTO.DOC_CLI%TYPE,
                                    DOCU_PROV_NOM         IN FIN_DOCUMENTO.DOC_CLI_NOM%TYPE,
                                    DOCU_PROV_RUC         IN FIN_DOCUMENTO.DOC_CLI_RUC%TYPE,
                                    S_TELEF               IN FIN_DOCUMENTO.DOC_CLI_TEL%TYPE,
                                    S_DIRECCION           IN FIN_DOCUMENTO.DOC_CLI_DIR%TYPE,
                                    DOCU_FEC_OPER         IN FIN_DOCUMENTO.DOC_FEC_OPER%TYPE,
                                    DOCU_FEC_EMIS         IN FIN_DOCUMENTO.DOC_FEC_DOC%TYPE,
                                    S_RETEN_LOC           IN FIN_DOCUMENTO.DOC_NETO_EXEN_LOC%TYPE,
                                    S_RETEN_MON           IN FIN_DOCUMENTO.DOC_NETO_EXEN_MON%TYPE,
                                    DOCU_OBS              IN FIN_DOCUMENTO.DOC_OBS%TYPE,
                                    I_DOC_OPERADOR        IN FIN_DOCUMENTO.DOC_OPERADOR%TYPE,
                                    I_S_CTA_BCO           IN FIN_DOCUMENTO.DOC_CTA_BCO%TYPE,
                                    I_NUMERO_DOC          IN FIN_DOCUMENTO.DOC_NRO_DOC%TYPE,
                                    I_DOC_CLAVE_COMPRA    IN FIN_DOCUMENTO.DOC_CLAVE_PADRE%TYPE, --DATO DE LA FACTURA DE COMPRA
                                    I_CONF_TMOV_RETENCION IN FIN_CONFIGURACION.CONF_TMOV_RETENCION%TYPE,
                                    I_S_RETENCION_100     IN VARCHAR2,
                                    I_P_TABLAS            IN VARCHAR2,
                                    I_P_IMPRESORA         IN GEN_IMPRESORA.IMP_CODIGO%TYPE,
                                    I_TIPO_DOC_PRO_CLI    IN FIN_DOCUMENTO.DOC_TIPO_DOC_CLI_PROV%TYPE);

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_STK(I_DOC_CLAVE_STK    IN STK_DOCUMENTO.DOCU_CLAVE%TYPE, --ES EL MISMO GENERADO POR COMI001.PP_ACTUALIZAR_DOCUMENTO_FIN  O_DOC_CLAVE_STK
                                        P_EMPRESA          IN STK_DOCUMENTO.DOCU_EMPR%TYPE,
                                        I_DOCU_CODIGO_OPER IN STK_DOCUMENTO.DOCU_CODIGO_OPER%TYPE,
                                        I_DOCU_NRO_DOC     IN STK_DOCUMENTO.DOCU_NRO_DOC%TYPE,
                                        I_DOC_TIMBRADO     IN STK_DOCUMENTO.DOCU_TIMBRADO%TYPE,
                                        P_SUCURSAL         IN STK_DOCUMENTO.DOCU_SUC_ORIG%TYPE,
                                        I_DOCU_DEP_ORIG    IN STK_DOCUMENTO.DOCU_DEP_ORIG%TYPE,
                                        I_DOCU_MON         IN STK_DOCUMENTO.DOCU_MON%TYPE,
                                        I_DOCU_PROV        IN STK_DOCUMENTO.DOCU_PROV%TYPE,
                                        I_DOC_CLI_NOM      IN STK_DOCUMENTO.DOCU_CLI_NOM%TYPE,
                                        I_DOCU_FEC_EMIS    IN STK_DOCUMENTO.DOCU_FEC_EMIS%TYPE,
                                        I_DOCU_TIPO_MOV    IN STK_DOCUMENTO.DOCU_TIPO_MOV%TYPE,
                                        --                                       I_DOC_IND_CUOTA      IN STK_DOCUMENTO.DOCU_CLAVE%TYPE,
                                        I_DOCU_OBS           IN STK_DOCUMENTO.DOCU_OBS%TYPE,
                                        I_DOC_OPERADOR       IN STK_DOCUMENTO.DOCU_OPERADOR%TYPE,
                                        I_DOCU_GRAV_NETO_MON IN STK_DOCUMENTO.DOCU_GRAV_NETO_MON%TYPE,
                                        I_DOCU_GRAV_NETO_LOC IN STK_DOCUMENTO.DOCU_GRAV_NETO_LOC%TYPE,
                                        I_DOCU_EXEN_NETO_MON IN STK_DOCUMENTO.DOCU_EXEN_NETO_MON%TYPE,
                                        I_DOCU_EXEN_NETO_LOC IN STK_DOCUMENTO.DOCU_EXEN_NETO_LOC%TYPE,
                                        I_DOCU_IVA_MON       IN STK_DOCUMENTO.DOCU_IVA_MON%TYPE,
                                        I_DOCU_IVA_LOC       IN STK_DOCUMENTO.DOCU_IVA_LOC%TYPE,
                                        I_DOCU_TASA_US       IN STK_DOCUMENTO.DOCU_TASA_US%TYPE,
                                        I_P_TABLAS           IN VARCHAR2,
                                        I_CLAVE_TMP          IN NUMBER DEFAULT NULL,
                                        I_TIPO_DOC_PRO_CLI   in NUMBER);

  PROCEDURE PP_ACTUALIZAR_CUOTAS(I_CLAVE_FIN IN NUMBER,
                                 I_FEC_VTO   IN DATE,
                                 I_IMP_MON   IN NUMBER,
                                 I_IMP_LOC   IN NUMBER,
                                 I_EMPR      IN NUMBER,
                                 I_P_TABLAS  IN VARCHAR2);

  PROCEDURE PP_ACTUALIZAR_DOC_DET_STK(I_DOCU_CLAVE      IN NUMBER,
                                      SEQ               IN NUMBER,
                                      DETA_ART          IN NUMBER,
                                      P_EMPRESA         IN NUMBER,
                                      DETA_CANT         IN NUMBER,
                                      DETA_IMP_NETO_LOC IN NUMBER,
                                      DETA_IMP_NETO_MON IN NUMBER,
                                      DETA_IMPU         IN VARCHAR2,
                                      DETA_IVA_LOC      IN NUMBER,
                                      DETA_IVA_MON      IN NUMBER,
                                      OCOM_CLAVE        IN NUMBER,
                                      SEQ_OCOMD         IN NUMBER,
                                      I_P_TABLAS        IN VARCHAR2,
                                      I_CLAVE_TMP       IN NUMBER DEFAULT NULL,
                                      ORD_COMP_CLAVE    IN NUMBER,
                                      ORD_COMP_ITEM     IN NUMBER);

  PROCEDURE PP_ACT_CTA_BAN(S_CH_EMIT_NRO IN NUMBER,
                           P_EMPRESA     IN NUMBER,
                           S_CTA_BCO     IN NUMBER,
                           S_BANCO       IN NUMBER --BBANCO.S_BANCO
                           );

  PROCEDURE PP_ACTUALIZA_TRANS(S_CTA_BCO      IN NUMBER,
                               S_BANCO        IN NUMBER,
                               P_EMPRESA      IN NUMBER,
                               P_SUCURSAL     IN NUMBER,
                               S_CH_EMIT_NRO  IN NUMBER,
                               S_MON          IN NUMBER, --BBANCO.S_MON
                               DOC_FEC_OPER   IN DATE,
                               S_TOTAL_IMP    IN NUMBER, --BPIE2.S_TOTAL_IMP
                               S_TASA         IN NUMBER,
                               S_BENEFICIARIO IN VARCHAR2,
                               DOC_TIMBRADO   IN NUMBER);

  PROCEDURE PP_INSERTAR_CH_EMIT(W_CLAVE           IN NUMBER,
                                S_CH_EMIT_SERIE   IN VARCHAR2,
                                S_CH_EMIT_NRO     IN NUMBER,
                                CH_EMIT_FEC_VTO1  IN DATE,
                                S_CH_EMIT_IMPORTE IN NUMBER,
                                DOC_CLAVE         IN NUMBER,
                                S_BENEFICIARIO    IN VARCHAR2,
                                P_EMPRESA         IN NUMBER);

  PROCEDURE PP_CARGAR_DOC_IMG(P_EMPRESA          IN NUMBER,
                              P_SUCURSAL         IN NUMBER,
                              DOC_TIMBRADO       IN NUMBER, --:BDOC_FIN.DOC_TIMBRADO
                              DOC_NRO_DOC        IN NUMBER, --:BDOC_FIN.DOC_NRO_DOC
                              DOC_PROV           IN NUMBER, --:BDOC_FIN.DOC_PROV
                              DOC_FEC_DOC        IN DATE, --:BDOC_FIN.DOC_FEC_DOC
                              DOC_TIPO_MOV       IN NUMBER, --:BDOC_FIN.DOC_TIPO_MOV
                              DOC_MON            IN NUMBER, --:BDOC_FIN.DOC_MON
                              DOC_GRAV_10_MON    IN NUMBER, --:BDOC.DOC_GRAV_10_MON
                              DOC_GRAV_5_MON     IN NUMBER, --:BDOC.DOC_GRAV_5_MON
                              DOCU_EXEN_NETO_MON IN NUMBER, --:BDOC.DOCU_EXEN_NETO_MON
                              S_TOT_MON          IN NUMBER, --:BDOC.S_TOT_MON
                              DOC_CLAVE          IN NUMBER, --:BDOC_FIN.DOC_CLAVE
                              S_CTA_BCO          IN NUMBER, --:BDOC.S_CTA_BCO
                              V_FAC_IMAGEN_BLOB  IN BLOB,
                              V_FAC_MODIFICADO   IN VARCHAR2);

  PROCEDURE PP_ACTUALIZAR_DOC_CONCEPTO(APP_SESSION      IN NUMBER,
                                       APP_USER         IN VARCHAR2,
                                       P1387_S_TIMBRADO IN NUMBER,
                                       P_OPER           IN VARCHAR2,
                                       V_DOC_CLAVE      IN NUMBER,
                                       V_TASA           IN NUMBER,
                                       P_EMPRESA        IN NUMBER,
                                       O_P_WHERE_DCON   OUT VARCHAR2,
                                       I_P_TABLAS       IN VARCHAR2,
                                       I_CLAVE_TMP      IN NUMBER DEFAULT NULL,
                                       I_FECHA_DOC      IN DATE,
                                       P_PROVEEDOR      IN NUMBER); ------**

  PROCEDURE PP_GUARDAR_REGISTRO(I_DOCU_TIPO_MOV IN NUMBER,
                                I_P_OPER        IN VARCHAR2,
                                I_CTA_BCO       IN NUMBER,
                                I_BANCO         IN NUMBER,
                                --I_TOT_CHEQUE              IN NUMBER,
                                I_TOT_MON               IN NUMBER,
                                I_RETEN_MON             IN NUMBER,
                                I_EMPRESA               IN NUMBER,
                                I_USUARIO               IN VARCHAR2,
                                I_TMOV_TIPO_SALDO       IN VARCHAR2,
                                I_DOCU_PROV             IN NUMBER,
                                I_DOC_TIMBRADO          IN NUMBER,
                                I_DOCU_NRO_DOC          IN NUMBER,
                                I_CTA_DESC              IN VARCHAR2,
                                I_APP_SESSION           IN NUMBER,
                                I_TIMBRADO              IN NUMBER,
                                I_CONF_IND_INTEGRAR_PRD IN VARCHAR2,
                                I_CONF_FACT_CR_REC      IN NUMBER,
                                I_CONF_NOTA_CR_REC      IN NUMBER,
                                I_S_CREDITO             IN VARCHAR2,
                                I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                I_DOCU_DEP_ORIG         IN NUMBER,
                                I_DOC_SERIE             IN VARCHAR2,
                                I_P_MON_LOC             IN NUMBER,
                                I_P_MON_US              IN NUMBER,
                                I_P_CANT_DECIMALES_US   IN NUMBER,
                                I_P_CANT_DECIMALES_LOC  IN NUMBER,
                                --I_DETA_IMP_NETO_LOC       IN NUMBER,
                                --I_OT_MON_COT              IN NUMBER,
                                I_DOCU_FEC_EMIS          IN DATE,
                                I_CONF_IND_INTEGRAR_ACT  IN VARCHAR2,
                                I_SUCURSAL               IN FIN_DOCUMENTO.DOC_SUC%TYPE,
                                I_DOCU_MON               IN FIN_DOCUMENTO.DOC_MON%TYPE,
                                I_DOCU_CLI               IN FIN_DOCUMENTO.DOC_CLI%TYPE,
                                I_DOCU_PROV_NOM          IN FIN_DOCUMENTO.DOC_CLI_NOM%TYPE,
                                I_DOCU_PROV_RUC          IN FIN_DOCUMENTO.DOC_CLI_RUC%TYPE,
                                I_S_TELEF                IN FIN_DOCUMENTO.DOC_CLI_TEL%TYPE,
                                I_S_DIRECCION            IN FIN_DOCUMENTO.DOC_CLI_DIR%TYPE,
                                I_DOC_RUC_DV             IN FIN_DOCUMENTO.DOC_RUC_DV%TYPE,
                                I_DOC_DV                 IN FIN_DOCUMENTO.DOC_DV%TYPE,
                                I_OCOM_CLAVE             IN VARCHAR2, --FIN_DOCUMENTO.DOC_ORDEN_COMPRA%TYPE,
                                I_DOCU_FEC_OPER          IN FIN_DOCUMENTO.DOC_FEC_OPER%TYPE,
                                I_DOCU_GRAV_NETO_LOC     IN FIN_DOCUMENTO.DOC_NETO_GRAV_LOC%TYPE,
                                I_DOCU_GRAV_NETO_MON     IN FIN_DOCUMENTO.DOC_NETO_GRAV_MON%TYPE,
                                I_DOCU_EXEN_NETO_LOC     IN FIN_DOCUMENTO.DOC_NETO_EXEN_LOC%TYPE,
                                I_DOCU_EXEN_NETO_MON     IN FIN_DOCUMENTO.DOC_NETO_EXEN_MON%TYPE,
                                I_DOCU_IVA_LOC           IN FIN_DOCUMENTO.DOC_IVA_LOC%TYPE,
                                I_DOCU_IVA_MON           IN FIN_DOCUMENTO.DOC_IVA_MON%TYPE,
                                I_DOCU_OBS               IN FIN_DOCUMENTO.DOC_OBS%TYPE,
                                I_DOC_OPERADOR           IN FIN_DOCUMENTO.DOC_OPERADOR%TYPE,
                                I_DOC_GRAV_5_MON         IN FIN_DOCUMENTO.DOC_GRAV_5_MON%TYPE,
                                I_DOC_GRAV_5_LOC         IN FIN_DOCUMENTO.DOC_GRAV_5_LOC%TYPE,
                                I_DOC_GRAV_10_MON        IN FIN_DOCUMENTO.DOC_GRAV_10_MON%TYPE,
                                I_DOC_GRAV_10_LOC        IN FIN_DOCUMENTO.DOC_GRAV_10_LOC%TYPE,
                                I_DOC_IVA_5_MON          IN FIN_DOCUMENTO.DOC_IVA_5_MON%TYPE,
                                I_DOC_IVA_5_LOC          IN FIN_DOCUMENTO.DOC_IVA_5_LOC%TYPE,
                                I_DOC_IVA_10_MON         IN FIN_DOCUMENTO.DOC_IVA_10_MON%TYPE,
                                I_DOC_IVA_10_LOC         IN FIN_DOCUMENTO.DOC_IVA_10_LOC%TYPE,
                                I_S_CTA_BCO              IN FIN_DOCUMENTO.DOC_CTA_BCO%TYPE,
                                I_CONF_NOTA_DB_EMIT_PROV IN FIN_CONFIGURACION.CONF_NOTA_DB_EMIT_PROV%TYPE,
                                I_CREDITO                IN VARCHAR2,
                                O_W_FLAG_COMMIT          OUT VARCHAR2,
                                I_TASA                   IN NUMBER,
                                O_P_WHERE_DCON           OUT VARCHAR2,
                                I_PAGO_BANCO             IN VARCHAR2,
                                I_P_BANCO                IN VARCHAR2,
                                I_CONF_FACT_COMPRA       IN NUMBER,
                                I_P_TABLAS               IN VARCHAR2,
                                I_DOC_CLI_NOM            IN VARCHAR2,
                                I_CONF_PER_ACT_INI       IN DATE,
                                I_CONF_PER_SGTE_FIN      IN DATE,
                                O_DOC_CLAVE              OUT NUMBER,
                                O_DOC_CLAVE_STK          OUT NUMBER,
                                I_RETEN_LOC              IN NUMBER,
                                I_NRO_RETENCION          IN VARCHAR2,
                                I_CONF_TMOV_RETENCION    IN NUMBER,
                                I_RETENCION_100          IN VARCHAR2);

  PROCEDURE PP_CALCULAR_VALORES(I_CANT_DECIMALES_LOC     IN NUMBER,
                                I_S_TASA                 IN NUMBER,
                                I_DOCU_EXEN_NETO_MON     IN NUMBER,
                                I_S_RETENCION_100        IN VARCHAR2,
                                I_DOCU_TIPO_MOV          IN NUMBER,
                                I_W_MON_DEC_IMP          IN NUMBER,
                                I_DOC_GRAV_10_MON        IN OUT NUMBER,
                                I_DOC_GRAV_10_LOC        IN OUT NUMBER,
                                I_DOC_IVA_10_MON         OUT NUMBER,
                                I_S_RETENCION            IN VARCHAR2,
                                I_MON_DEC_IMP            IN NUMBER,
                                P_EMPRESA                IN NUMBER,
                                I_DOCU_PROV              IN NUMBER,
                                I_S_DOCU_FEC_EMIS        IN DATE,
                                O_DOC_NETO_EXEN_LOC      OUT NUMBER,
                                O_DOCU_EXEN_NETO_LOC     OUT NUMBER,
                                O_DOC_GRAV_5_LOC         OUT NUMBER,
                                O_DOC_GRAV_5_MON         IN OUT NUMBER,
                                O_DOC_IVA_5_MON          OUT NUMBER,
                                O_DOC_IVA_5_LOC          OUT NUMBER,
                                O_DOCU_GRAV_NETO_MON     OUT NUMBER,
                                O_DOCU_GRAV_NETO_LOC     OUT NUMBER,
                                O_DOCU_IVA_MON           IN OUT NUMBER,
                                O_DOCU_IVA_LOC           IN OUT NUMBER,
                                O_DOC_IVA_10_LOC         OUT NUMBER,
                                O_S_RETEN_MON            OUT NUMBER,
                                O_S_RETEN_LOC            OUT NUMBER,
                                O_S_NRO_RETENCION_FORMAT OUT VARCHAR2,
                                O_S_NRO_RETENCION        OUT GEN_IMPRESORA.IMP_ULT_RETENCION%TYPE,
                                O_S_TOT_MON              OUT NUMBER,
                                O_S_TOT_LOC              OUT NUMBER,
                                O_S_PAGO                 OUT NUMBER);

  PROCEDURE PP_EDITAR_ITEM(I_NRO_ITEM                 IN COMI001_DET_TMP.NRO_ITEM%TYPE,
                           I_SESSION_ID               IN COMI001_DET_TMP.SESSION_ID%TYPE,
                           I_USUARIO                  IN COMI001_DET_TMP.USUARIO%TYPE,
                           I_TIMBRADO                 IN COMI001_DET_TMP.TIMBRADO%TYPE,
                           O_OPCION                   OUT COMI001_DET_TMP.OPCION%TYPE,
                           O_CONCEPTO                 OUT COMI001_DET_TMP.CONCEPTO%TYPE,
                           O_OT                       OUT COMI001_DET_TMP.OT%TYPE,
                           O_DCON_CUENTA              OUT COMI001_DET_TMP.DCON_CUENTA%TYPE,
                           O_DCON_CANAL               OUT COMI001_DET_TMP.DCON_CANAL%TYPE,
                           O_DCON_DIV_CANAL           OUT COMI001_DET_TMP.DCON_DIV_CANAL%TYPE,
                           O_NRO_IMPORTACION          OUT COMI001_DET_TMP.NRO_IMPORTACION%TYPE,
                           O_CANT                     OUT COMI001_DET_TMP.CANT%TYPE,
                           O_KM_ACTUAL                OUT COMI001_DET_TMP.KM_ACTUAL%TYPE,
                           O_PREC_UNIT                OUT COMI001_DET_TMP.PREC_UNIT%TYPE,
                           O_OBS                      OUT COMI001_DET_TMP.OBS%TYPE,
                           O_IND_TIPO_IVA_COMPRA      OUT COMI001_DET_TMP.IND_TIPO_IVA_COMPRA%TYPE,
                           O_PC_DCTO                  OUT COMI001_DET_TMP.PC_DCTO%TYPE,
                           O_IMPU_PORC_BASE_IMPONIBLE OUT COMI001_DET_TMP.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                           O_IMPU_PORCENTAJE          OUT COMI001_DET_TMP.IMPU_PORCENTAJE%TYPE,
                           O_TOTAL                    OUT COMI001_DET_TMP.TOTAL%TYPE,
                           O_EXENTO                   OUT COMI001_DET_TMP.EXENTO%TYPE,
                           O_GRAVADO                  OUT COMI001_DET_TMP.GRAVADO%TYPE,
                           O_IVA                      OUT COMI001_DET_TMP.IVA%TYPE,
                           O_DESC_LARGA               OUT COMI001_DET_TMP.DESC_LARGA%TYPE,
                           O_CONT_DESC                OUT COMI001_DET_TMP.CONT_DESC%TYPE,
                           O_ART                      OUT COMI001_DET_TMP.ART%TYPE,
                           O_OT_MON                   OUT COMI001_DET_TMP.OT_MON%TYPE,
                           O_OT_MON_COT               OUT COMI001_DET_TMP.OT_MON_COT%TYPE,
                           O_OT_MON_SIM               OUT COMI001_DET_TMP.OT_MON_SIM%TYPE,
                           O_OT_CLAVE                 OUT COMI001_DET_TMP.OT_CLAVE%TYPE,
                           O_DCON_CLAVE_IMP           OUT COMI001_DET_TMP.DCON_CLAVE_IMP%TYPE,
                           O_OCOM_CLAVE               OUT COMI001_DET_TMP.OCOM_CLAVE%TYPE,
                           O_OCOMD_NRO_ITEM           OUT COMI001_DET_TMP.OCOMD_NRO_ITEM%TYPE,
                           O_DETA_IMP_NETO_LOC        OUT COMI001_DET_TMP.DETA_IMP_NETO_LOC%TYPE,
                           O_DETA_IMP_NETO_MON        OUT COMI001_DET_TMP.DETA_IMP_NETO_MON%TYPE,
                           O_DETA_IMPU                OUT COMI001_DET_TMP.DETA_IMPU%TYPE,
                           O_DETA_IVA_LOC             OUT COMI001_DET_TMP.DETA_IVA_LOC%TYPE,
                           O_DETA_IVA_MON             OUT COMI001_DET_TMP.DETA_IVA_MON%TYPE,
                           O_IVA_10_LOC               OUT COMI001_DET_TMP.IVA_10_LOC%TYPE,
                           O_IVA_5_LOC                OUT COMI001_DET_TMP.IVA_5_LOC%TYPE,
                           O_CLAVE_CTACO              OUT COMI001_DET_TMP.CLAVE_CTACO%TYPE,
                           O_CLAVE_CONCEPTO           OUT COMI001_DET_TMP.CLAVE_CONCEPTO%TYPE,
                           O_IMP_AFECTA_COSTO         OUT COMI001_DET_TMP.IMP_AFECTA_COSTO%TYPE,
                           O_KM_FAC_ANT               OUT COMI001_DET_TMP.CANT_FAC_ANT%TYPE);

  PROCEDURE PP_GUARDAR_COMI001_TMP_CANAL(I_OPCION                   IN COMI001_DET_TMP.OPCION%TYPE,
                                         I_CONCEPTO                 IN COMI001_DET_TMP.CONCEPTO%TYPE,
                                         I_OT                       IN COMI001_DET_TMP.OT%TYPE,
                                         I_DCON_CUENTA              IN COMI001_DET_TMP.DCON_CUENTA%TYPE,
                                         I_DCON_CANAL               IN COMI001_DET_TMP.DCON_CANAL%TYPE,
                                         I_DCON_DIV_CANAL           IN COMI001_DET_TMP.DCON_DIV_CANAL%TYPE,
                                         I_NRO_IMPORTACION          IN COMI001_DET_TMP.NRO_IMPORTACION%TYPE,
                                         I_CANT                     IN COMI001_DET_TMP.CANT%TYPE,
                                         I_KM_ACTUAL                IN COMI001_DET_TMP.KM_ACTUAL%TYPE,
                                         I_PREC_UNIT                IN COMI001_DET_TMP.PREC_UNIT%TYPE,
                                         I_OBS                      IN COMI001_DET_TMP.OBS%TYPE,
                                         I_IND_TIPO_IVA_COMPRA      IN COMI001_DET_TMP.IND_TIPO_IVA_COMPRA%TYPE,
                                         I_PC_DCTO                  IN COMI001_DET_TMP.PC_DCTO%TYPE,
                                         I_IMPU_PORC_BASE_IMPONIBLE IN COMI001_DET_TMP.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                                         I_IMPU_PORCENTAJE          IN COMI001_DET_TMP.IMPU_PORCENTAJE%TYPE,
                                         I_TOTAL                    IN COMI001_DET_TMP.TOTAL%TYPE,
                                         I_EXENTO                   IN COMI001_DET_TMP.EXENTO%TYPE,
                                         I_GRAVADO                  IN COMI001_DET_TMP.GRAVADO%TYPE,
                                         I_IVA                      IN COMI001_DET_TMP.IVA%TYPE,
                                         I_SESSION_ID               IN COMI001_DET_TMP.SESSION_ID%TYPE,
                                         I_USUARIO                  IN COMI001_DET_TMP.USUARIO%TYPE,
                                         I_TIMBRADO                 IN COMI001_DET_TMP.TIMBRADO%TYPE,
                                         I_DESC_LARGA               IN COMI001_DET_TMP.DESC_LARGA%TYPE,
                                         I_CONT_DESC                IN COMI001_DET_TMP.CONT_DESC%TYPE,
                                         I_ART                      IN COMI001_DET_TMP.ART%TYPE,
                                         I_DCON_CLAVE_IMP           IN COMI001_DET_TMP.DCON_CLAVE_IMP%TYPE,
                                         I_EMPRESA                  IN NUMBER,
                                         I_NRO_ITEM                 IN COMI001_DET_TMP.NRO_ITEM%TYPE,
                                         I_IMP_AFECTA_COSTO         IN COMI001_DET_TMP.IMP_AFECTA_COSTO%TYPE,
                                         I_IND_ORDEN_COMPRA         IN VARCHAR2 DEFAULT NULL,
                                         I_CANAL1                   IN NUMBER,
                                         I_CANAL2                   IN NUMBER,
                                         I_CANAL3                   IN NUMBER,
                                         I_CANAL4                   IN NUMBER,
                                         I_CANAL5                   IN NUMBER,
                                         I_CANAL6                   IN NUMBER,
                                         I_CANAL7                   IN NUMBER,
                                         I_CANAL8                   IN NUMBER,
                                         I_CANAL9                   IN NUMBER,
                                         I_CANAL12                  IN NUMBER,
                                         I_FAC_ANTERIOR             IN NUMBER,
                                         I_IND_VIATICO              IN COMI001_DET_TMP.IND_RESPONSABLE_VIATICO%TYPE DEFAULT NULL); ----**

  PROCEDURE PP_VALIDAR_KM_OBLI(P_EMPRESA     NUMBER,
                               P_CONCEPTO    NUMBER,
                               P_CANT_LITROS NUMBER,
                               P_KM_REC      NUMBER,
                               P_OPCION      VARCHAR2,
                               P_FECHA_DOC   DATE,
                               P_FAC_ANT     NUMBER,
                               P_PROVEEDOR   NUMBER);

END COMI001;
/
CREATE OR REPLACE PACKAGE BODY COMI001 AS
  /******************************************************************************
     NAME:       COMI001
     PURPOSE:

     REVISIONS:
     VER        DATE        AUTHOR           DESCRIPTION
     ---------  ----------  ---------------  ------------------------------------
     1.0        29/12/2017      MONICA GODOY       1. CREATED THIS PACKAGE BODY.
  ******************************************************************************/

  PROCEDURE PP_BUSCAR_CTACO(I_CONCEPTO                IN NUMBER,
                            IO_CUENTA                 IN OUT NUMBER,
                            I_EMPRESA                 IN NUMBER,
                            I_CONF_IND_CTACO_STK_CLAS IN VARCHAR2,
                            I_OPCION                  IN VARCHAR2,
                            I_CONF_CONC_IMPU          IN NUMBER,
                            I_CONF_CONC_DEV_IMPU      IN NUMBER,
                            I_DETA_ART                IN NUMBER,
                            I_ART_DESC                IN VARCHAR2) IS
    V_DESC VARCHAR2(300);
  BEGIN

    --SI EL INDICADOR EN COMM001-CONFIGURACION DEL SISTEMA
    --COM_CONFIGURACION.CONF_IND_CTACO_STK_CLAS = 'N', SE HARA TODO
    --COMO SIEMPRE, SINO SE LE AGREGA AQUI PARA QUE BUSQUE LA CTACO
    --DE LA MERCADERIA.

    IF NVL(I_CONF_IND_CTACO_STK_CLAS, 'N') = 'N' OR I_OPCION <> 'M' OR
       I_CONCEPTO = I_CONF_CONC_IMPU OR I_CONCEPTO = I_CONF_CONC_DEV_IMPU THEN
      BEGIN
        SELECT FCON_CLAVE_CTACO, FCON_DESC
          INTO IO_CUENTA, V_DESC
          FROM FIN_CONCEPTO
         WHERE FCON_CLAVE = I_CONCEPTO
           AND FCON_EMPR = I_EMPRESA;

        IF IO_CUENTA IS NULL THEN
          APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Falta definir cuenta contable para el concepto: ' ||
                                                     V_DESC,
                               P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          RAISE_APPLICATION_ERROR(-20002,
                                  'Falta definir cuenta contable para el concepto: ' ||
                                  V_DESC);
        END IF;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Falta definir cuenta contable para el concepto: ' ||
                                                     V_DESC,
                               P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          RAISE_APPLICATION_ERROR(-20002,
                                  'Falta definir cuenta contable para el concepto: ' ||
                                  V_DESC);
      END;
    ELSE
      IF I_OPCION = 'M' THEN
        BEGIN
           IF I_EMPRESA = 1 THEN

            SELECT A.MARC_CTA_MERC
              INTO IO_CUENTA
              FROM STK_MARCA A, STK_ARTICULO B
             WHERE ART_MARCA = MARC_CODIGO
               AND ART_EMPR = MARC_EMPR
               AND ART_CODIGO = I_DETA_ART
               AND ART_EMPR = I_EMPRESA;

          ELSE

            SELECT CLAS_CTACO_MERCADERIA
              INTO IO_CUENTA
              FROM STK_CLASIFICACION, STK_ARTICULO
             WHERE ART_CLASIFICACION = CLAS_CODIGO
               AND ART_EMPR = CLAS_EMPR
               AND ART_CODIGO = I_DETA_ART
               AND ART_EMPR = I_EMPRESA;

          END IF;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Falta definir clasificacion de articulo para el articulo: ' ||
                                                       I_ART_DESC,
                                 P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
            RAISE_APPLICATION_ERROR(-20002,
                                    'Falta definir clasificacion de articulo para el articulo: ' ||
                                    I_ART_DESC);
        END;
      END IF;
    END IF;
  END PP_BUSCAR_CTACO;

  PROCEDURE PP_CARGAR_DATOS(O_W_FLAG_COMMIT           OUT VARCHAR2,
                            O_P_PAGO_BANCO            OUT VARCHAR2,
                            O_P_MON_US                OUT NUMBER,
                            O_P_MON_LOC               OUT NUMBER,
                            O_P_IND_OPERADOR          OUT VARCHAR2,
                            I_P_OPER                  IN VARCHAR2,
                            I_EMPRESA                 IN NUMBER,
                            I_OPCION                  IN NUMBER,
                            I_IMPUESTO                IN NUMBER,
                            I_IMPRESORA               IN NUMBER,
                            O_CONF_IND_INTEGRAR_STK   OUT COM_CONFIGURACION.CONF_IND_INTEGRAR_STK%TYPE,
                            O_CONF_IND_INTEGRAR_PRD   OUT COM_CONFIGURACION.CONF_IND_INTEGRAR_PRD%TYPE,
                            O_CONF_IND_INTEGRAR_ACT   OUT COM_CONFIGURACION.CONF_IND_INTEGRAR_ACT%TYPE,
                            O_CONF_CONC_MERC          OUT COM_CONFIGURACION.CONF_CONC_MERC%TYPE,
                            O_CONF_CONC_OT            OUT COM_CONFIGURACION.CONF_CONC_OT%TYPE,
                            O_CONF_CONC_ACT           OUT COM_CONFIGURACION.CONF_CONC_ACT%TYPE,
                            O_CONF_CONC_IMPU          OUT COM_CONFIGURACION.CONF_CONC_IMPU%TYPE,
                            O_CONF_CONC_IMPU_5        OUT COM_CONFIGURACION.CONF_CONC_IMPU_5%TYPE,
                            O_CONF_CONC_DEV_MERC      OUT COM_CONFIGURACION.CONF_CONC_DEV_MERC%TYPE,
                            O_CONF_CONC_DEV_OT        OUT COM_CONFIGURACION.CONF_CONC_DEV_OT%TYPE,
                            O_CONF_CONC_DEV_IMPU      OUT COM_CONFIGURACION.CONF_CONC_DEV_IMPU%TYPE,
                            O_CONF_CONC_DEV_IMPU_5    OUT COM_CONFIGURACION.CONF_CONC_DEV_IMPU_5%TYPE,
                            O_CONF_IND_CTACO_STK_CLAS OUT COM_CONFIGURACION.CONF_IND_CTACO_STK_CLAS%TYPE,
                            O_P_IND_CANT              OUT VARCHAR2,
                            O_P_IND_IMP               OUT VARCHAR2,
                            O_STK_CONF_FACT_CO_REC    OUT STK_CONFIGURACION.CONF_FACT_CO_REC%TYPE,
                            O_STK_CONF_FACT_CR_REC    OUT STK_CONFIGURACION.CONF_FACT_CR_REC%TYPE,
                            O_STK_CONF_NOTA_CR_REC    OUT STK_CONFIGURACION.CONF_NOTA_CR_REC%TYPE,
                            O_STK_CONF_PER_ACT_INI    OUT STK_PERIODO.PERI_FEC_INI%TYPE,
                            O_STK_CONF_PER_ACT_FIN    OUT STK_PERIODO.PERI_FEC_FIN%TYPE,
                            O_STK_CONF_PER_SGTE_INI   OUT STK_PERIODO.PERI_FEC_INI%TYPE,
                            O_STK_CONF_PER_SGTE_FIN   OUT STK_PERIODO.PERI_FEC_FIN%TYPE,
                            O_CONF_MES_ACT            OUT ACT_CONFIGURACION.CONF_MES_ACT%TYPE,
                            O_CONF_OPER_COMPRA        OUT ACT_CONFIGURACION.CONF_OPER_COMPRA%TYPE,
                            O_P_MAX_ITEMS_FAC_CO      OUT FAC_CONFIGURACION.CONF_MAX_ITEMS_FAC_CO%TYPE,
                            O_PORC_IMPU               OUT GEN_IMPUESTO.IMPU_PORCENTAJE%TYPE,
                            O_W_TIPO_IMPRESION        OUT VARCHAR2,
                            O_TIMBRADO                OUT NUMBER,
                            O_TIPO_IMPRESION          OUT VARCHAR2,
                            O_CANT_DECIMALES_LOC      OUT NUMBER,
                            O_CANT_DECIMALES_US       OUT NUMBER,
                            O_P_TABLAS                OUT VARCHAR2) IS
    V_PER_ACT  NUMBER := NULL;
    V_PER_SGTE NUMBER := NULL;

  BEGIN

    O_W_FLAG_COMMIT := 'NO';
    O_P_PAGO_BANCO  := 'N';

    BEGIN
      SELECT CONF_MON_US, CONF_MON_LOC, CONF_IND_OPERADOR
        INTO O_P_MON_US, O_P_MON_LOC, O_P_IND_OPERADOR
        FROM GEN_CONFIGURACION
       WHERE CONF_EMPR = I_EMPRESA;
      O_CANT_DECIMALES_LOC := GENERAL.FL_MON_DEC_IMP(MONEDA  => O_P_MON_LOC,
                                                     EMPRESA => I_EMPRESA);
      O_CANT_DECIMALES_US  := GENERAL.FL_MON_DEC_IMP(MONEDA  => O_P_MON_US,
                                                     EMPRESA => I_EMPRESA);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No fue cargada la tabla de configuracion general de sistemas!.',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'No fue cargada la tabla de configuracion general de sistemas!.');
    END;

    /* ESTABLECER VALORES DE PARAMETROS */
    IF I_P_OPER = 'COMPRA' THEN
      /* SI ES UNA VENTA CONTADO O CREDITO */
      O_P_IND_CANT := 'S';
      O_P_IND_IMP  := 'S';
    ELSIF I_P_OPER = 'DEV_COMPRA' THEN
      /* SI ES UNA DEVOLUCION DE VENTA */
      O_P_IND_CANT := NULL; -- NULL PORQUE DEBE PERMITIR CERO O MAYOR!
      O_P_IND_IMP  := 'S';
    ELSE
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'PARAMETER.P_OPER incorrecto! Operacion no contemplada: ' ||
                                                 I_P_OPER || '!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002,
                              'PARAMETER.P_OPER incorrecto! Operacion no contemplada: ' ||
                              I_P_OPER || '!');
    END IF;

    BEGIN
      SELECT CONF_IND_INTEGRAR_STK,
             CONF_IND_INTEGRAR_PRD,
             CONF_IND_INTEGRAR_ACT,
             CONF_CONC_MERC,
             CONF_CONC_OT,
             CONF_CONC_ACT,
             CONF_CONC_IMPU,
             CONF_CONC_IMPU_5,
             CONF_CONC_DEV_MERC,
             CONF_CONC_DEV_OT,
             CONF_CONC_DEV_IMPU,
             CONF_CONC_DEV_IMPU_5,
             CONF_IND_CTACO_STK_CLAS
        INTO O_CONF_IND_INTEGRAR_STK,
             O_CONF_IND_INTEGRAR_PRD,
             O_CONF_IND_INTEGRAR_ACT,
             O_CONF_CONC_MERC,
             O_CONF_CONC_OT,
             O_CONF_CONC_ACT,
             O_CONF_CONC_IMPU,
             O_CONF_CONC_IMPU_5,
             O_CONF_CONC_DEV_MERC,
             O_CONF_CONC_DEV_OT,
             O_CONF_CONC_DEV_IMPU,
             O_CONF_CONC_DEV_IMPU_5,
             O_CONF_IND_CTACO_STK_CLAS
        FROM COM_CONFIGURACION
       WHERE CONF_EMPR = I_EMPRESA;

      /*IF O_CONF_IND_INTEGRAR_STK = 'S' THEN
          PP_BUSCAR_CTACO(I_CONCEPTO           => O_CONF_CONC_MERC,
                          IO_CUENTA            => O_CTACO_MERC,
                          I_EMPRESA            => I_EMPRESA,
                          I_CONF_IND_CTACO_STK_CLAS => O_CONF_IND_CTACO_STK_CLAS,
                          I_OPCION             => I_OPCION,
                          I_CONF_CONC_IMPU     => O_CONF_CONC_IMPU,
                          I_CONF_CONC_DEV_IMPU => O_CONF_CONC_DEV_IMPU,
                          I_DETA_ART           IN NUMBER,
                          I_ART_DESC           IN VARCHAR2);
        --PP_BUSCAR_CTACO(O_CONF_CONC_MERC, O_CTACO_MERC);
        PP_BUSCAR_CTACO(O_CONF_CONC_DEV_MERC, O_CTACO_DEV_MERC);
      END IF;

      IF O_CONF_IND_INTEGRAR_PRD = 'S' THEN
        PP_BUSCAR_CTACO(:BCONF_COM.CONF_CONC_OT, :BCONF_COM.CTACO_OT);
        PP_BUSCAR_CTACO(:BCONF_COM.CONF_CONC_DEV_OT, :BCONF_COM.CTACO_DEV_OT);
      END IF;

      PP_BUSCAR_CTACO(:BCONF_COM.CONF_CONC_DEV_IMPU, :BCONF_COM.CTACO_DEV_IMPU);
      PP_BUSCAR_CTACO(:BCONF_COM.CONF_CONC_DEV_IMPU_5, :BCONF_COM.CTACO_DEV_IMPU_5);
      PP_BUSCAR_CTACO(:BCONF_COM.CONF_CONC_IMPU, :BCONF_COM.CTACO_IMPU);
      PP_BUSCAR_CTACO(:BCONF_COM.CONF_CONC_IMPU_5, :BCONF_COM.CTACO_IMPU_5);*/

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No fue cargada la tabla de configuracion del sistema de compras!.',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'No fue cargada la tabla de configuracion del sistema de compras!.');
    END;

    IF O_CONF_IND_INTEGRAR_STK = 'S' THEN
      BEGIN
        SELECT CONF_PERIODO_ACT,
               CONF_PERIODO_SGTE,
               CONF_FACT_CO_REC,
               CONF_FACT_CR_REC,
               CONF_NOTA_CR_REC
          INTO V_PER_ACT,
               V_PER_SGTE,
               O_STK_CONF_FACT_CO_REC,
               O_STK_CONF_FACT_CR_REC,
               O_STK_CONF_NOTA_CR_REC
          FROM STK_CONFIGURACION
         WHERE CONF_EMPR = I_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No fue cargada la tabla de configuracion del sistema de stock!.',
                               P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          RAISE_APPLICATION_ERROR(-20002,
                                  'No fue cargada la tabla de configuracion del sistema de stock!.');
        WHEN OTHERS THEN
          APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'ERROR: ' || SQLERRM,
                               P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          RAISE_APPLICATION_ERROR(-20002, 'ERROR: ' || SQLERRM);
      END;
    END IF;

    IF O_CONF_IND_INTEGRAR_STK = 'S' THEN
      BEGIN
        SELECT PERI_FEC_INI, PERI_FEC_FIN
          INTO O_STK_CONF_PER_ACT_INI, O_STK_CONF_PER_ACT_FIN
          FROM STK_PERIODO
         WHERE PERI_CODIGO = V_PER_ACT
           AND PERI_EMPR = I_EMPRESA;
        SELECT PERI_FEC_INI, PERI_FEC_FIN
          INTO O_STK_CONF_PER_SGTE_INI, O_STK_CONF_PER_SGTE_FIN
          FROM STK_PERIODO
         WHERE PERI_CODIGO = V_PER_SGTE
           AND PERI_EMPR = I_EMPRESA;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No fue cargada la tabla de periodos del sistema de stock!.',
                               P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          RAISE_APPLICATION_ERROR(-20002,
                                  'No fue cargada la tabla de periodos del sistema de stock!.');
      END;
    END IF;

    IF O_CONF_IND_INTEGRAR_ACT = 'S' THEN
      BEGIN
        SELECT CONF_MES_ACT, CONF_OPER_COMPRA
          INTO O_CONF_MES_ACT, O_CONF_OPER_COMPRA
          FROM ACT_CONFIGURACION
         WHERE CONF_EMPR = I_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No fue cargada la tabla de configuracion del sistema de finanzas!.' ||
                                                     O_CONF_MES_ACT ||
                                                     O_CONF_OPER_COMPRA ||
                                                     I_EMPRESA,
                               P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          RAISE_APPLICATION_ERROR(-20002,
                                  'No fue cargada la tabla de configuracion del sistema de finanzas!.');
      END;
    END IF;

    BEGIN
      SELECT CONF_MAX_ITEMS_FAC_CO
        INTO O_P_MAX_ITEMS_FAC_CO
        FROM FAC_CONFIGURACION
       WHERE CONF_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No fue cargada la tabla de configuracion del sistema de facturacion!.',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'No fue cargada la tabla de configuracion del sistema de facturacion!.');
    END;

    --PARA LA IMPRESION DE CHEQUES
    /*DECLARE
        V_NOMBRE_MAQUINA VARCHAR2(60);
      V_ALERT NUMBER;
    BEGIN
        TOOL_ENV.GETVAR('IMP_MAQUINA',V_NOMBRE_MAQUINA);
      IF V_NOMBRE_MAQUINA IS NULL THEN
        PL_EXHIBIR_MENSAJE('Falta registrar IMP_MAQUINA en el Register de Windows!');
        DO_KEY('exit');
      END IF;
      :PARAMETER.P_MAQUINA := V_NOMBRE_MAQUINA;
    END;*/

    BEGIN
      SELECT IMPU_PORCENTAJE
        INTO O_PORC_IMPU
        FROM GEN_IMPUESTO
       WHERE IMPU_CODIGO = I_IMPUESTO
         AND IMPU_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'GEN_IMPUESTO',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002, 'GEN_IMPUESTO');
    END;

    ----------------------------------------------------------------------------------------------------------------
    O_TIMBRADO := 11223651;

    --NRO DE TIMBRADO SIN VENCIMIENTO FIJO PARA RETENCIONES DE HILAGRO POR PARTE DE LA SET.
    ----------------------------------------------------------------------------------------------------------------

    --RECUPERANDO LOS DATOS DE LA EMPRESA, SUCURSAL, IMPRESORA Y EL TIPO DE DOCUMENTO, SI ES AUTOIMPRESOR O NO. A = AUTOIMPRESOR, P = PREIMPRESO
    /*BEGIN
             SELECT T.IMP_AF_TIPO_IMPRESION
             INTO O_W_TIPO_IMPRESION
             FROM GEN_IMPRESORA  T
             WHERE T.IMP_CODIGO = I_IMPRESORA
               AND T.IMP_EMPR = I_EMPRESA;
             O_TIPO_IMPRESION := NVL(O_W_TIPO_IMPRESION,'P');--PREGUNTAR POR EL VALOR QUE RECUPERO. EN EL CASO QUE SEA VACIO, SE LE ASIGNA P, SE ASUME QUE LA SUCURSAL DE LA EMPRESA, NO TIENE TODAVIA IMPLEMENTADO EL MODO DE AUTOIMPRESOR
    --ORDER BY 1 ASC
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
           APEX_ERROR.ADD_ERROR (P_MESSAGE          => 'El punto de expedicion, todavia no tiene configurado el tipo de impresion (Por defecto se usara el preimpreso)',
                                 P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION );
           RAISE_APPLICATION_ERROR(-20002, 'El punto de expedicion, todavia no tiene configurado el tipo de impresion (Por defecto se usara el preimpreso)');
         O_TIPO_IMPRESION := NVL(O_TIPO_IMPRESION,'P');--PREGUNTAR POR EL VALOR QUE RECUPERO. EN EL CASO QUE SEA VACIO, SE LE ASIGNA P, SE ASUME QUE LA SUCURSAL DE LA EMPRESA, NO TIENE TODAVIA IMPLEMENTADO EL MODO DE AUTOIMPRESOR
     END;*/

    O_W_TIPO_IMPRESION := 'P';

    IF I_EMPRESA = 8 THEN
      --HALTEN
      O_P_TABLAS := 'D';
    END IF;

  END PP_CARGAR_DATOS;

  PROCEDURE PP_FORMA_NRO_DOCU(I_S_ESTABLECIMIENTO   IN NUMBER,
                              I_S_EMISION           IN NUMBER,
                              I_S_DOC_NRO_DOC       IN NUMBER,
                              O_DOCU_NRO_DOC        OUT NUMBER,
                              O_DOCU_NRO_DOC_FORMAT OUT VARCHAR) IS
    V_ESTABLECIMIENTO VARCHAR(3);
    V_EMISION         VARCHAR(3);
    V_NUMERO          VARCHAR(7);

  BEGIN
    IF LENGTH(I_S_ESTABLECIMIENTO) > 3 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Excedido el tama?o del campo Establecimiento');
    ELSIF LENGTH(I_S_EMISION) > 3 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Excedido el tama?o del campo Emision');
    ELSIF LENGTH(I_S_DOC_NRO_DOC) > 7 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Excedido el tama?o del campo Nro de Documento');
    END IF;
    V_ESTABLECIMIENTO := RTRIM(LTRIM(TO_CHAR(I_S_ESTABLECIMIENTO, '000')));
    V_EMISION         := RTRIM(LTRIM(TO_CHAR(NVL(I_S_EMISION, 0), '000')));
    V_NUMERO          := RTRIM(LTRIM(TO_CHAR(NVL(I_S_DOC_NRO_DOC, 0),
                                             '0000000')));

    /*O_DOCU_NRO_DOC        := TO_NUMBER(V_ESTABLECIMIENTO || V_EMISION ||
    V_NUMERO);*/
    SELECT RTRIM(LTRIM(TO_CHAR(I_S_ESTABLECIMIENTO, '000'))) ||
           RTRIM(LTRIM(TO_CHAR(NVL(I_S_EMISION, 0), '000'))) ||
           RTRIM(LTRIM(TO_CHAR(NVL(I_S_DOC_NRO_DOC, 0), '0000000'))),
           RTRIM(LTRIM(TO_CHAR(I_S_ESTABLECIMIENTO, '000'))) || '-' ||
           RTRIM(LTRIM(TO_CHAR(NVL(I_S_EMISION, 0), '000'))) || '-' ||
           RTRIM(LTRIM(TO_CHAR(NVL(I_S_DOC_NRO_DOC, 0), '0000000')))
      INTO O_DOCU_NRO_DOC, O_DOCU_NRO_DOC_FORMAT
      FROM DUAL;
    /* O_DOCU_NRO_DOC_FORMAT := V_ESTABLECIMIENTO || '-' || V_EMISION || '-' ||
    V_NUMERO;*/

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, SQLERRM);
  END PP_FORMA_NRO_DOCU;

  PROCEDURE PP_BUSCAR_ORDEN_COMPRA(I_EMPRESA            IN NUMBER,
                                   I_ORDEN_COMPRA       IN VARCHAR2, ---LV
                                   O_OCOM_CLAVE         OUT VARCHAR2, --STK_ORDEN_COMPRA.OCOM_CLAVE%TYPE,
                                   O_S_ORDEN_COMPRA     OUT VARCHAR2, --STK_ORDEN_COMPRA.OCOM_NRO%TYPE,
                                   O_DOCU_MON           OUT STK_ORDEN_COMPRA.OCOM_MON%TYPE,
                                   O_DOCU_PROV          OUT STK_ORDEN_COMPRA.OCOM_PROV%TYPE,
                                   O_DOCU_DEP_ORIG      OUT STK_ORDEN_COMPRA.OCOM_DEPOSITO%TYPE,
                                   O_MON_SIMBOLO        OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                   O_DEP_DESC           OUT STK_DEPOSITO.DEP_DESC%TYPE,
                                   O_OCOM_PLAZO         OUT STK_ORDEN_COMPRA.OCOM_PLAZO%TYPE,
                                   O_S_RETEN_LOC        OUT NUMBER,
                                   O_S_RETEN_MON        OUT NUMBER,
                                   O_DOCU_EXEN_NETO_MON OUT NUMBER,
                                   O_DOCU_EXEN_NETO_LOC OUT NUMBER,
                                   O_DOC_GRAV_5_LOC     OUT NUMBER,
                                   O_DOC_GRAV_10_LOC    OUT NUMBER,
                                   O_DOC_GRAV_5_MON     OUT NUMBER,
                                   O_DOC_GRAV_10_MON    OUT NUMBER,
                                   O_DOCU_IVA_LOC       OUT NUMBER,
                                   O_DOCU_IVA_MON       OUT NUMBER,
                                   O_S_ORCOM_SUC        OUT NUMBER,
                                   I_NRO_DOCUMENTO      IN NUMBER,
                                   I_REC_NRO_ORDEN      OUT NUMBER) IS
    V_OBSER           VARCHAR2(100); --PARA PASAR EL NOMBRE DE ARTICULO U OBSERVACION DE CONCEPTOS
    V_TIPO            VARCHAR2(1); -- PARA SABER SI ES G O M
    V_TOTAL           NUMBER; -- CALCULA EL TOTAL DE LA FACTURA
    V_BASE_IMP        NUMBER; --BASE IMPONIBLE
    V_PORCE_IVA       NUMBER; --PORCENTAJE IVA
    V_GRAVADA         NUMBER; -- GRAVADA DEL REGISTRO-RECORD
    V_IVA             NUMBER := 0; --IVA DEL REGISTRO -RECORD
    V_EXENTO          NUMBER; -- EXENTA DEL REGISTRO-RECORD
    V_TOTALGRALOC     NUMBER := 0; -- TOTAL DE LA GRAVADA LOC PARA EL ENCABEZADO
    V_TOTALGRAMON     NUMBER := 0; -- TOTAL DE LA GRAVADA MON PARA EL ENCABEZADO
    V_TOTAEXLOC       NUMBER := 0; -- TOTAL DE LA EXENTA LOC PARA EL ENCABEZADO
    V_TOTALEXMON      NUMBER := 0; -- TOTAL DE LA EXENTA MON PARA EL ENCABEZADO
    V_TGRA5_LOC       NUMBER := 0; -- TOTAL DE LA GRAVADA 5 PARA EL ENCABEZADO
    V_TGRA5_MON       NUMBER := 0;
    V_TGRA10_LOC      NUMBER := 0; -- TOTAL DE LA GRAVADA10 PARA EL ENCABEZADO
    V_TGRA10_MON      NUMBER := 0;
    V_TIVA            NUMBER := 0; -- TOTAL DE LA IVA PARA EL ENCABEZADO
    V_TIVA_MON        NUMBER := 0;
    V_MON_DEC_IMP     NUMBER := 0;
    V_CLAVE_FIN       NUMBER;
    V_NRO_DOC_ENTRADA NUMBER;
    V_ESTADO_ORDEN    VARCHAR2(5);
    V_DEPOSITO        NUMBER;
    V_SUCURSAL        NUMBER;

  BEGIN

    BEGIN
      SELECT --DISTINCT OCOM.OCOM_CLAVE,---lv. comente esta parte par aque no duplique los datos en caso de que duplique
      --      OCOM.OCOM_NRO,------es por que son de diferentes proveedores o el deposito sea diferente  en ese
       OCOM.OCOM_MON, ----caso si debe presentar error
       OCOM.OCOM_PROV,
       OCOM.OCOM_DEPOSITO,
       MON.MON_SIMBOLO,
       DEP.DEP_DESC,
       OCOM.OCOM_PLAZO,
       MON_DEC_IMP /*,
                   OCOM.OCOM_ESTADO*/ -- COMENTADO POR ERDM '09/03/2021'
        INTO --O_OCOM_CLAVE,
             --O_S_ORDEN_COMPRA,
              O_DOCU_MON,
             O_DOCU_PROV,
             O_DOCU_DEP_ORIG,
             O_MON_SIMBOLO,
             O_DEP_DESC,
             O_OCOM_PLAZO,
             V_MON_DEC_IMP /*,
                         V_ESTADO_ORDEN*/ -- COMENTADO POR ERDM '09/03/2021'
        FROM STK_ORDEN_COMPRA OCOM, STK_DEPOSITO DEP, GEN_MONEDA MON
       WHERE OCOM.OCOM_EMPR = I_EMPRESA
         AND OCOM.OCOM_EMPR = MON.MON_EMPR
         AND TO_CHAR(OCOM.OCOM_NRO) IN
             (SELECT REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA, ',', ':'),
                                   '[^:]+',
                                   1,
                                   LEVEL) ORDEN_COMPRA
                FROM DUAL
              CONNECT BY REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA, ',', ':'),
                                       '[^:]+',
                                       1,
                                       LEVEL) IS NOT NULL)
            --= I_ORDEN_COMPRA  --para poder consultar dos ordenes de compra..
         AND OCOM.OCOM_MON = MON.MON_CODIGO
         AND OCOM.OCOM_DEPOSITO = DEP.DEP_CODIGO(+)
         AND OCOM.OCOM_SUC = DEP.DEP_SUC(+)
         AND OCOM.OCOM_EMPR = DEP.DEP_EMPR(+)
         AND OCOM.OCOM_ESTADO IN ('P', 'C')
       GROUP BY OCOM.OCOM_MON,
                OCOM.OCOM_PROV,
                OCOM.OCOM_DEPOSITO,
                MON.MON_SIMBOLO,
                DEP.DEP_DESC,
                OCOM.OCOM_PLAZO,
                MON_DEC_IMP /*,
                            OCOM.OCOM_ESTADO*/ -- COMENTADO POR ERDM '09/03/2021'
       ORDER BY 2;

      SELECT WM_CONCAT(OCOM.OCOM_CLAVE) CLAVE, --en lugar de los datos de la primera consulta
             WM_CONCAT(OCOM.OCOM_NRO) ORDEN
        INTO O_OCOM_CLAVE, O_S_ORDEN_COMPRA
        FROM STK_ORDEN_COMPRA OCOM, STK_DEPOSITO DEP, GEN_MONEDA MON
       WHERE OCOM.OCOM_EMPR = I_EMPRESA
         AND OCOM.OCOM_EMPR = MON.MON_EMPR
         AND OCOM.OCOM_NRO IN
             (SELECT REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA, ',', ':'),
                                   '[^:]+',
                                   1,
                                   LEVEL) ORDEN_COMPRA
                FROM DUAL
              CONNECT BY REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA, ',', ':'),
                                       '[^:]+',
                                       1,
                                       LEVEL) IS NOT NULL)
            --= I_ORDEN_COMPRA--para poder consultar dos ordenes de compra..

         AND OCOM.OCOM_MON = MON.MON_CODIGO
         AND OCOM.OCOM_DEPOSITO = DEP.DEP_CODIGO(+)
         AND OCOM.OCOM_SUC = DEP.DEP_SUC(+)
         AND OCOM.OCOM_EMPR = DEP.DEP_EMPR(+)
         AND OCOM.OCOM_ESTADO IN ('P', 'C');

    EXCEPTION
      WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Los datos de la orden de compra varian, puede ser por el tipo de moneda o el proveedor');
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'No existe la Orden de compra o aun no ha sido Verificado');
    END;

    --- ***** VERIFICAR SI TIENE ENTRADA

    DECLARE
      V_CANT_ART NUMBER;
    BEGIN
      SELECT COUNT(*)
        INTO V_CANT_ART
        FROM STK_ORDEN_COMPRA ORD, STK_ORDEN_COMPRA_DET ORDET
       WHERE ORD.OCOM_EMPR = I_EMPRESA
         AND ORD.OCOM_CLAVE IN
             (SELECT REGEXP_SUBSTR(REPLACE(O_OCOM_CLAVE, ',', ':'),
                                   '[^:]+',
                                   1,
                                   LEVEL) CLAVE
                FROM DUAL
              CONNECT BY REGEXP_SUBSTR(REPLACE(O_OCOM_CLAVE, ',', ':'),
                                       '[^:]+',
                                       1,
                                       LEVEL) IS NOT NULL) --= I_ORDEN_COMPRA
            -- O_OCOM_CLAVE
         AND ORD.OCOM_EMPR = ORDET.OCOMD_EMPR
         AND ORD.OCOM_CLAVE = ORDET.OCOMD_CLAVE_OCOM
         AND ORDET.OCOMD_ART IS NOT NULL;

      /*  IF V_CANT_ART > 0 AND V_ESTADO_ORDEN = 'P' THEN
        RAISE_APPLICATION_ERROR(-20003,
                                'La orden contiene articulos y no se encuentra la entrada');
      END IF;*/ -----  la orden puede estar en pendiente porque puede haber varias recepciones de mercaderias

      --- ***** VERIFICAR SI ENTRADA YA SE USO

      ------------------------------------------------------------------------------
      --      SI ES ARTICULO PUEDE TENER VARIAS ENTRADA, SE BUSCA POR DOCUMENTO Y POR ORDEN

      IF V_CANT_ART > 0 THEN
        SELECT T.ENTMER_NUM_DOC_FIN, T.ENTMER_CLAVE_DOC_FIN --, T.ENTMER_NUM_ENTR,T.ENTMER_DEPOSITO_ACT, T.ENTMER_DEP_SUC
          INTO V_NRO_DOC_ENTRADA, V_CLAVE_FIN --,I_REC_NRO_ORDEN, V_DEPOSITO,V_SUCURSAL
          FROM STK_ENTRADA_MERC T
         WHERE T.ENTMER_CLAVE_ORDEN IN
               (SELECT REGEXP_SUBSTR(REPLACE(O_OCOM_CLAVE, ',', ':'),
                                     '[^:]+',
                                     1,
                                     LEVEL) CLAVE
                  FROM DUAL
                CONNECT BY REGEXP_SUBSTR(REPLACE(O_OCOM_CLAVE, ',', ':'),
                                         '[^:]+',
                                         1,
                                         LEVEL) IS NOT NULL) --= I_ORDEN_COMPRA
              -- O_OCOM_CLAVE
           AND T.ENTMER_NUM_DOC_FIN = I_NRO_DOCUMENTO
           AND T.ENTMER_EMPR = I_EMPRESA
         GROUP BY T.ENTMER_NUM_DOC_FIN, T.ENTMER_CLAVE_DOC_FIN;

        IF V_DEPOSITO <> O_DOCU_DEP_ORIG THEN
          O_DOCU_DEP_ORIG := V_DEPOSITO;

        END IF;

        IF V_CLAVE_FIN IS NOT NULL THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Esta O.C ya posee una Entrada relacionada a una Factura!');
        END IF;
      ELSE
        BEGIN
          SELECT T.ENTMER_NUM_DOC_FIN, T.ENTMER_CLAVE_DOC_FIN
            INTO V_NRO_DOC_ENTRADA, V_CLAVE_FIN
            FROM STK_ENTRADA_MERC T
           WHERE T.ENTMER_CLAVE_ORDEN = O_OCOM_CLAVE
             AND T.ENTMER_EMPR = I_EMPRESA;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;

        IF V_CLAVE_FIN IS NOT NULL THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Esta O.C ya posee una Entrada relacionada a una Factura!');
        END IF;
      END IF; ---------------------------------------------------------------------------------------------------LV

    END;

    O_S_RETEN_LOC := 0;
    O_S_RETEN_MON := 0;

    DECLARE
      CURSOR V_ORDEN_COMP_DET IS
        SELECT OCOMD.OCOMD_CLAVE_OCOM,
               OCOMD.OCOMD_NRO_ITEM,
               OCOMD.OCOMD_ART,
               OCOMD.OCOMD_CANTIDAD,
               --OCOMD.OCOMD_CANAL,
               OCOMD.OCOMD_CANAL_BETA,
               OCOMD.OCOMD_DIV_CANAL,
               OCOMD.OCOMD_CLAVE_CONCEPTO,
               ART.ART_DESC,
               ART.ART_UNID_MED,
               FCON.FCON_DESC,
               IMP.IMPU_PORCENTAJE,
               IMP.IMPU_PORC_BASE_IMPONIBLE,
               OCOMD.OCOMD_EXEN_LOC,
               OCOMD.OCOMD_EXEN_MON,
               OCOMD.OCOMD_GRAV_LOC,
               OCOMD.OCOMD_GRAV_MON,
               OCOMD.OCOMD_IVA_LOC,
               OCOMD.OCOMD_IVA_MON,
               OCOMD.OCOMD_BASE_IMP,
               OCOMD.OCOMD_TIMP,
               OCOMD.OCOMD_PORC_IVA,
               UPPER(OCOMD.OCOMD_OBS) OBS,
               DECODE(OCOMD.OCOMD_PORC_IVA,
                      5,
                      DECODE(OCOMD.OCOMD_GRAV_LOC -
                             SUM(SDD.DETA_IMP_NETO_LOC),
                             '',
                             OCOMD.OCOMD_GRAV_LOC,
                             OCOMD.OCOMD_GRAV_LOC -
                             SUM(SDD.DETA_IMP_NETO_LOC))) GRAV5,
               DECODE(OCOMD.OCOMD_PORC_IVA,
                      10,
                      DECODE(OCOMD.OCOMD_GRAV_LOC -
                             SUM(SDD.DETA_IMP_NETO_LOC),
                             '',
                             OCOMD.OCOMD_GRAV_LOC,
                             OCOMD.OCOMD_GRAV_LOC -
                             SUM(SDD.DETA_IMP_NETO_LOC))) GRAV10,
               DECODE(OCOMD.OCOMD_PORC_IVA,
                      5,
                      DECODE(OCOMD.OCOMD_GRAV_MON -
                             SUM(SDD.DETA_IMP_NETO_MON),
                             '',
                             OCOMD.OCOMD_GRAV_MON,
                             OCOMD.OCOMD_GRAV_MON -
                             SUM(SDD.DETA_IMP_NETO_MON))) GRAV_MON_5,
               DECODE(OCOMD.OCOMD_PORC_IVA,
                      10,
                      DECODE(OCOMD.OCOMD_GRAV_MON -
                             SUM(SDD.DETA_IMP_NETO_MON),
                             '',
                             OCOMD.OCOMD_GRAV_MON,
                             OCOMD.OCOMD_GRAV_MON -
                             SUM(SDD.DETA_IMP_NETO_MON))) GRAV_MON_10,
               DECODE(OCOMD.OCOMD_CLAVE_CONCEPTO,
                      NULL,
                      OCOMD.OCOMD_CANTIDAD - NVL(SUM(SDD.DETA_CANT), 0),
                      NULL) SALDO,
               STK_COMP_DOC_CONCEPTO(OCOMD.OCOMD_CLAVE_OCOM,
                                     OCOMD.OCOMD_NRO_ITEM,
                                     I_EMPRESA) NOCONCEPTO
          FROM STK_ORDEN_COMPRA_DET OCOMD,
               STK_DOCUMENTO_DET    SDD,
               STK_ARTICULO         ART,
               GEN_IMPUESTO         IMP,
               FIN_CONCEPTO         FCON
         WHERE OCOMD.OCOMD_EMPR = I_EMPRESA
           AND (OCOMD.OCOMD_CLAVE_OCOM = SDD.DETA_OCOMD_CLAVE(+) AND
               OCOMD.OCOMD_NRO_ITEM = SDD.DETA_OCOMD_NRO_ITEM(+) AND
               OCOMD.OCOMD_EMPR = SDD.DETA_EMPR(+))
           AND OCOMD.OCOMD_CLAVE_OCOM IN
               (SELECT REGEXP_SUBSTR(REPLACE(O_OCOM_CLAVE, ',', ':'),
                                     '[^:]+',
                                     1,
                                     LEVEL) CLAVE
                  FROM DUAL
                CONNECT BY REGEXP_SUBSTR(REPLACE(O_OCOM_CLAVE, ',', ':'),
                                         '[^:]+',
                                         1,
                                         LEVEL) IS NOT NULL) --= I_ORDEN_COMPRA
              --= O_OCOM_CLAVE----------lv 23/06/2020
           AND OCOMD.OCOMD_ART = ART.ART_CODIGO(+)
           AND OCOMD.OCOMD_EMPR = ART.ART_EMPR(+)
           AND ART.ART_IMPU = IMP.IMPU_CODIGO(+)
           AND ART.ART_EMPR = IMP.IMPU_EMPR(+)
           AND FCON.FCON_CLAVE(+) = OCOMD.OCOMD_CLAVE_CONCEPTO
           AND FCON.FCON_EMPR(+) = OCOMD.OCOMD_EMPR
         GROUP BY OCOMD.OCOMD_ART,
                  OCOMD.OCOMD_CANTIDAD,
                  OCOMD.OCOMD_CANTIDAD,
                  OCOMD.OCOMD_CLAVE_OCOM,
                  OCOMD.OCOMD_NRO_ITEM,
                  --OCOMD.OCOMD_CANAL,
                  OCOMD.OCOMD_CANAL_BETA,
                  OCOMD.OCOMD_DIV_CANAL,
                  OCOMD.OCOMD_CLAVE_CONCEPTO,
                  ART.ART_DESC,
                  ART.ART_UNID_MED,
                  IMP.IMPU_PORCENTAJE,
                  FCON.FCON_DESC,
                  IMP.IMPU_PORC_BASE_IMPONIBLE,
                  OCOMD.OCOMD_EXEN_LOC,
                  OCOMD.OCOMD_EXEN_MON,
                  OCOMD.OCOMD_GRAV_LOC,
                  OCOMD.OCOMD_GRAV_MON,
                  OCOMD.OCOMD_IVA_LOC,
                  OCOMD.OCOMD_IVA_MON,
                  OCOMD.OCOMD_BASE_IMP,
                  OCOMD.OCOMD_TIMP,
                  OCOMD.OCOMD_PORC_IVA,
                  OCOMD.OCOMD_OBS;

      V_CANT_ENTRADA    NUMBER;
      V_PREC_UNIT       NUMBER;
      V_UNIT_IVA        NUMBER;
      V_UNIT_GRAVADA    NUMBER;
      V_UNIT_EXENTO     NUMBER;
      V_CANT_ENTR_COUNT NUMBER;

    BEGIN
      FOR REG IN V_ORDEN_COMP_DET LOOP
        BEGIN
          --------------------------------------------------lv 23/06/2020
          SELECT T.ENTMER_NUM_ENTR
            INTO I_REC_NRO_ORDEN
            FROM STK_ENTRADA_MERC T
           WHERE T.ENTMER_CLAVE_ORDEN = REG.OCOMD_CLAVE_OCOM
             AND T.ENTMER_NUM_DOC_FIN = I_NRO_DOCUMENTO
             AND T.ENTMER_EMPR = I_EMPRESA;

          SELECT SUM(E.ENTMERDET_CANT)
            INTO V_CANT_ENTR_COUNT
            FROM STK_ENTRADA_MERC_DET E
           WHERE ENTMERDET_ORDEN = REG.OCOMD_CLAVE_OCOM
             AND ENTMERDET_ITEM = REG.OCOMD_NRO_ITEM
             AND ENTMERDET_EMPR = I_EMPRESA
             AND ENTMERDET_NUM = I_REC_NRO_ORDEN; ---LV

        EXCEPTION
          WHEN OTHERS THEN
            V_CANT_ENTR_COUNT := NULL;
        END;

        IF V_CANT_ENTR_COUNT > 0 OR V_CANT_ENTR_COUNT IS NULL THEN
          BEGIN
            SELECT NVL(SUM(E.ENTMERDET_CANT), 0)
              INTO V_CANT_ENTRADA
              FROM STK_ENTRADA_MERC_DET E
             WHERE ENTMERDET_ORDEN = REG.OCOMD_CLAVE_OCOM
               AND ENTMERDET_ITEM = REG.OCOMD_NRO_ITEM
               AND ENTMERDET_EMPR = I_EMPRESA
               AND ENTMERDET_NUM = I_REC_NRO_ORDEN; ---LV;

            ------  RAISE_APPLICATION_ERROR(-20002,V_CANT_ENTRADA);
          EXCEPTION
            WHEN OTHERS THEN
              V_CANT_ENTRADA := 0;
          END;

          IF NVL(O_DOCU_MON, '') = 1 THEN

            IF REG.NOCONCEPTO IS NULL OR
               (REG.NOCONCEPTO = 0 AND REG.OCOMD_ART IS NOT NULL AND
               REG.SALDO > 0) THEN

              V_TOTAL := (REG.OCOMD_GRAV_LOC + REG.OCOMD_IVA_LOC +
                         REG.OCOMD_EXEN_LOC);


              IF V_CANT_ENTRADA > 0 THEN
                V_PREC_UNIT := V_TOTAL / REG.OCOMD_CANTIDAD;


                IF REG.OCOMD_PORC_IVA = 10 THEN
                  --SI ES IVA 10
                  V_UNIT_IVA     := ROUND((V_PREC_UNIT * V_CANT_ENTRADA) / 11, V_MON_DEC_IMP);
                  V_UNIT_GRAVADA := ROUND((V_PREC_UNIT * V_CANT_ENTRADA) - V_UNIT_IVA, V_MON_DEC_IMP);
                  V_TGRA10_LOC   := ROUND(V_TGRA10_LOC + V_UNIT_GRAVADA ,V_MON_DEC_IMP);
                  V_TGRA10_MON   := ROUND(V_TGRA10_MON + V_UNIT_GRAVADA,V_MON_DEC_IMP);
                  V_UNIT_EXENTO  := 0;

                ELSIF REG.OCOMD_PORC_IVA = 5 THEN
                  --SI ES IVA 5
                  V_UNIT_IVA     := ROUND((V_PREC_UNIT * V_CANT_ENTRADA) / 21,V_MON_DEC_IMP);
                  V_UNIT_GRAVADA := (V_PREC_UNIT * V_CANT_ENTRADA) - V_UNIT_IVA;
                  V_TGRA5_LOC    :=  V_TGRA5_LOC + V_UNIT_GRAVADA;
                  V_TGRA5_MON    :=  V_TGRA5_MON + V_UNIT_GRAVADA;

                  V_UNIT_EXENTO := 0;
                ELSIF REG.OCOMD_PORC_IVA = 0 THEN
                  --EXENTO
                  V_UNIT_EXENTO  := (V_PREC_UNIT * V_CANT_ENTRADA);
                  V_TOTAEXLOC    := V_TOTAEXLOC + V_UNIT_EXENTO;
                  V_TOTALEXMON   := V_TOTALEXMON + V_UNIT_EXENTO;
                  V_UNIT_IVA     := 0;
                  V_UNIT_GRAVADA := 0;

                END IF;

                V_TIVA     := V_TIVA + V_UNIT_IVA;
                V_TIVA_MON := V_TIVA;

              ELSE



                IF REG.OCOMD_ART IS NULL then
                  V_TGRA5_LOC  := V_TGRA5_LOC + NVL(REG.GRAV5, 0);
                  V_TGRA10_LOC := V_TGRA10_LOC + NVL(REG.GRAV10, 0);
                  V_TOTAEXLOC  := V_TOTAEXLOC + NVL(REG.OCOMD_EXEN_LOC, 0);
                  V_TOTALEXMON := V_TOTALEXMON + NVL(REG.OCOMD_EXEN_MON, 0);
                  V_TGRA5_MON  := V_TGRA5_LOC;
                  V_TGRA10_MON := V_TGRA10_LOC;
                  V_TIVA       := V_TIVA + V_IVA;
                  V_TIVA_MON   := V_TIVA; ---------------necesito que estire solo los items que tengan que no esten nulos
                  --raise_application_error(-20001,'pasa aca mary '||V_TGRA10_MON);
                else
                  --------------------------------LV
                  V_TGRA5_LOC  := NVL(V_TGRA5_LOC, 0);
                  V_TGRA10_LOC := NVL(V_TGRA10_LOC, 0);
                  V_TOTAEXLOC  := NVL(V_TOTAEXLOC, 0);
                  V_TOTALEXMON := NVL(V_TOTALEXMON, 0);
                  V_TGRA5_MON  := NVL(V_TGRA5_LOC, 0);
                  V_TGRA10_MON := NVL(V_TGRA10_LOC, 0);
                  V_TIVA       := NVL(V_TIVA, 0);
                  V_TIVA_MON   := NVL(V_TIVA, 0);

                end if;

                -- NULL;
                /*  V_TGRA5_LOC  := V_TGRA5_LOC + NVL(REG.GRAV5, 0);
                V_TGRA10_LOC := V_TGRA10_LOC +  NVL(REG.GRAV10, 0);
                V_TOTAEXLOC  := V_TOTAEXLOC + NVL(REG.OCOMD_EXEN_LOC, 0);
                V_TOTALEXMON := V_TOTALEXMON + NVL(REG.OCOMD_EXEN_MON, 0);
                V_TGRA5_MON  := V_TGRA5_LOC;
                V_TGRA10_MON := V_TGRA10_LOC;
                V_TIVA       := V_TIVA +  V_IVA;
                V_TIVA_MON   := V_TIVA;*/ ---------------necesito que estire solo los items que tengan que no esten nulos
                --------------------------------LV
                /* V_TGRA5_LOC  := NVL(V_TGRA5_LOC,0) ;
                V_TGRA10_LOC := NVL(V_TGRA10_LOC,0) ;
                V_TOTAEXLOC  := NVL(V_TOTAEXLOC,0) ;
                V_TOTALEXMON := NVL(V_TOTALEXMON,0) ;
                V_TGRA5_MON  := NVL(V_TGRA5_LOC,0);
                V_TGRA10_MON := NVL(V_TGRA10_LOC,0);
                V_TIVA       := NVL(V_TIVA,0);
                V_TIVA_MON   := NVL(V_TIVA,0);*/

              END IF;

            END IF;
          ELSE

            V_TOTAL := (REG.OCOMD_GRAV_MON + REG.OCOMD_IVA_MON +
                       REG.OCOMD_EXEN_MON);

            IF REG.NOCONCEPTO IS NULL OR
               (REG.NOCONCEPTO = 0 AND REG.OCOMD_ART IS NOT NULL AND
               REG.SALDO > 0) THEN

              IF V_CANT_ENTRADA > 0 THEN
                NULL;
              ELSE

                V_TGRA5_MON  := V_TGRA5_MON + NVL(REG.GRAV_MON_5, 0);
                V_TGRA10_MON := V_TGRA10_MON + NVL(REG.GRAV_MON_10, 0);
                V_TIVA_MON   := V_TIVA_MON + V_IVA;
                V_TOTALEXMON := V_TOTALEXMON + REG.OCOMD_EXEN_MON;

              END IF;
            ELSE
              V_TGRA5_MON  := V_TGRA5_MON + NVL(REG.GRAV_MON_5, 0);
              V_TGRA10_MON := V_TGRA10_MON + NVL(REG.GRAV_MON_10, 0);
              V_TIVA_MON   := V_TIVA_MON + V_IVA;
              V_TOTALEXMON := V_TOTALEXMON + REG.OCOMD_EXEN_MON;


              /*    V_TGRA5_MON  := V_TGRA5_MON;
              V_TGRA10_MON := V_TGRA10_MON;
              V_TIVA_MON   := V_TIVA_MON;
              V_TOTALEXMON := V_TOTALEXMON;*/
            END IF;
          END IF;
        END IF;
      END LOOP;

      O_DOCU_EXEN_NETO_MON := V_TOTALEXMON;
      O_DOCU_EXEN_NETO_LOC := V_TOTAEXLOC;
      O_DOC_GRAV_5_LOC     := V_TGRA5_LOC;
      O_DOC_GRAV_10_LOC    := ROUND(V_TGRA10_LOC, 4);
      O_DOC_GRAV_5_MON     := V_TGRA5_MON;
      O_DOC_GRAV_10_MON    := ROUND(V_TGRA10_MON, 4);
      O_DOCU_IVA_LOC       := V_TIVA;
      O_DOCU_IVA_MON       := V_TIVA_MON;
    END;

--RAISE_APPLICATION_ERROR(-20001,O_DOC_GRAV_10_MON);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, SQLERRM);
      IF SQLCODE = 100 THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No existe la Orden de compra o aun no ha sido Verificado',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'No existe la Orden de compra o aun no ha sido Verificado');
      END IF;
      O_DOCU_EXEN_NETO_MON := 0;
      O_DOCU_EXEN_NETO_LOC := 0;
      O_DOC_GRAV_5_LOC     := 0;
      O_DOC_GRAV_10_LOC    := 0;
      O_DOC_GRAV_5_MON     := 0;
      O_DOC_GRAV_10_MON    := 0;
      O_DOCU_IVA_LOC       := 0;
      O_DOCU_IVA_MON       := 0;
      O_S_ORCOM_SUC        := NULL;
      O_S_ORDEN_COMPRA     := NULL;

  END PP_BUSCAR_ORDEN_COMPRA;

  PROCEDURE PP_VALIDAR_PROV_MON(I_EMPRESA   IN NUMBER,
                                I_DOCU_PROV IN NUMBER,
                                I_DOCU_MON  IN NUMBER) IS
    V_VARIABLE VARCHAR2(1);
  BEGIN
    IF I_DOCU_PROV IS NOT NULL THEN
      SELECT 'X'
        INTO V_VARIABLE
        FROM FIN_PROV_EMPRESA
       WHERE PREM_EMPR = I_EMPRESA
         AND PREM_PROV = I_DOCU_PROV
         AND PREM_MON = I_DOCU_MON;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'El proveedor no esta habilitado a operar con esta moneda en esta empresa!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002,
                              'El proveedor' || I_DOCU_PROV ||
                              '  no esta habilitado a operar con esta moneda ' ||
                              I_DOCU_MON || '  en esta empresa!' ||
                              I_EMPRESA);
  END PP_VALIDAR_PROV_MON;

  PROCEDURE PP_MOSTRAR_DATOS_PROVEEDOR(I_DOC_TIMBRADO     IN OUT NUMBER,
                                       I_DOCU_PROV        IN NUMBER,
                                       I_EMPRESA          IN NUMBER,
                                       I_DOCU_TIPO_MOV    IN NUMBER,
                                       I_CONF_FACT_COMPRA IN NUMBER,
                                       I_CONF_FACT_CR_REC IN NUMBER,
                                       I_CONF_FACT_CO_REC IN NUMBER,
                                       --I_W_IND_RETENCION    IN VARCHAR2,
                                       --I_PROV_PAIS          IN NUMBER,
                                       O_DOCU_PROV_NOM     OUT FIN_PROVEEDOR.PROV_RAZON_SOCIAL%TYPE,
                                       O_S_DIRECCION       OUT FIN_PROVEEDOR.PROV_DIR%TYPE,
                                       O_S_TELEF           OUT FIN_PROVEEDOR.PROV_TEL%TYPE,
                                       O_P_PROV_PLAZO_PAGO OUT FIN_PROVEEDOR.PROV_PLAZO_PAGO%TYPE,
                                       O_DOC_RUC_DV        OUT FIN_PROVEEDOR.PROV_RUC_DV%TYPE,
                                       O_DOC_DV            OUT FIN_PROVEEDOR.PROV_DV%TYPE,
                                       O_DOC_TIMBRADO      OUT FIN_PROVEEDOR.PROV_TIMBRADO%TYPE,
                                       O_W_IND_RETENCION   OUT FIN_PROVEEDOR.PROV_IND_RETENCION%TYPE,
                                       O_W_PROV_PAIS       OUT FIN_PROVEEDOR.PROV_PAIS%TYPE,
                                       O_S_RETENCION       OUT VARCHAR2,
                                       O_S_RETENCION_RENTA OUT VARCHAR2,
                                       O_S_RETENCION_100   OUT VARCHAR2,
                                       O_S_PORC_RENTA      OUT NUMBER,
                                       O_DOCU_PROV_RUC     OUT NUMBER) IS

    V_NRO_TIMBRADO_AUTOFACTURA NUMBER := I_DOC_TIMBRADO;
    V_TIPO_DOC NUMBER;
  BEGIN
    SELECT PROV_RAZON_SOCIAL,
           PROV_DIR,
           PROV_TEL,
           PROV_PLAZO_PAGO,
           PROV_RUC_DV,
           PROV_DV,
           PROV_TIMBRADO,
           NVL(PROV_IND_RETENCION, 'S'),
           PROV_PAIS,
           PROV_DOC_TIPO
      INTO O_DOCU_PROV_NOM,
           O_S_DIRECCION,
           O_S_TELEF,
           O_P_PROV_PLAZO_PAGO,
           O_DOC_RUC_DV,
           O_DOC_DV,
           O_DOC_TIMBRADO,
           O_W_IND_RETENCION,
           O_W_PROV_PAIS,
           V_TIPO_DOC
      FROM FIN_PROVEEDOR
     WHERE PROV_CODIGO = I_DOCU_PROV
       AND PROV_EMPR = I_EMPRESA
       AND PROV_EST_PROV = 'A'; --Solo prov. activos 02/07/2020;;

IF   I_EMPRESA IN (1,2) THEN
   IF V_TIPO_DOC IS NULL THEN
     RAISE_APPLICATION_ERROR (-20001,'!FAVOR, CONFIGURAR EL TIPO DE DOCUMENTO DEL PROVEEDOR ANTES DE CONTINUAR- PROG 2-1-25!');
   END IF;

  IF V_TIPO_DOC = 2 THEN
    O_DOC_DV:=O_DOC_DV;
  ELSE
    O_DOC_DV  := NULL;
  END IF;
END IF;





    IF I_DOCU_TIPO_MOV IN (I_CONF_FACT_COMPRA) THEN
      I_DOC_TIMBRADO := V_NRO_TIMBRADO_AUTOFACTURA;
    END IF;
    --
    O_S_RETENCION       := 'N';
    O_S_RETENCION_RENTA := 'N';
    O_S_RETENCION_100   := 'N';
    O_S_PORC_RENTA      := NULL;
    --
    IF I_DOCU_TIPO_MOV IN
       (I_CONF_FACT_CR_REC, I_CONF_FACT_CO_REC, I_CONF_FACT_COMPRA) THEN
      IF NVL(O_W_IND_RETENCION, 'N') = 'S' THEN
        O_S_RETENCION := 'S';
        IF NVL(O_W_PROV_PAIS, 1) = 1 THEN
          --PARAGUAY
          IF I_DOCU_TIPO_MOV IN (1, 2) THEN
            --FACTURAS CO Y CR.

            NULL;
          ELSE
            --RENTA 4,5

            O_S_RETENCION_RENTA := 'S';
            O_S_PORC_RENTA      := 4.5;
          END IF;
        ELSE
          --PROVEEDORES DEL EXTERIOR
          IF I_DOCU_TIPO_MOV IN (1, 2) THEN
            --FACTURAS CO Y CR.

            O_S_RETENCION_RENTA := 'S';
            O_S_RETENCION_100   := 'S';
            O_S_PORC_RENTA      := 15;
          ELSE

            O_S_RETENCION_RENTA := 'S';
            O_S_RETENCION_100   := 'S';
            O_S_PORC_RENTA      := 10; --AUTOFACTURA A PROVEEDORES DEL EXTERIOR: PERSONA FISICA 10%
          END IF;
        END IF;
      END IF;
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_DOCU_PROV_NOM := NULL;
      O_DOCU_PROV_RUC := NULL;
      RAISE_APPLICATION_ERROR(-20002,
                              '!Proveedor inexistente y/o inactivo!');
    when others then
      raise_application_error(-20001,
                              'Error en PP_MOSTRAR_DATOS_PROVEEDOR- ' ||
                              SQLCODE || ' -ERROR- ' || SQLERRM);

  END PP_MOSTRAR_DATOS_PROVEEDOR;

  PROCEDURE PP_VALIDAR_DOC_EXIST(I_EMPRESA       IN NUMBER,
                                 I_DOCU_NRO_DOC  IN FIN_DOCUMENTO_COMI015_TEMP.DOC_NRO_DOC%TYPE,
                                 I_DOCU_PROV     IN NUMBER,
                                 I_DOCU_TIPO_MOV IN NUMBER,
                                 I_DOC_TIMBRADO  IN NUMBER) IS
    V_NRO_DOC NUMBER;
    V_ALERT   NUMBER;
  BEGIN
    BEGIN
      IF I_EMPRESA <> 2 THEN
        SELECT DOC_NRO_DOC
          INTO V_NRO_DOC
          FROM FIN_DOCUMENTO_COMI015_TEMP
         WHERE DOC_NRO_DOC = I_DOCU_NRO_DOC
           AND DOC_EMPR = I_EMPRESA
           AND NVL(DOC_TIMBRADO, 0) = NVL(I_DOC_TIMBRADO, 0)
           AND COMI005_ESTADO IS NULL;
      ELSE
        SELECT DOC_NRO_DOC
          INTO V_NRO_DOC
          FROM FIN_DOCUMENTO_TMP E
         WHERE DOC_NRO_DOC = I_DOCU_NRO_DOC
           AND DOC_EMPR = I_EMPRESA
           AND NVL(DOC_NRO_TIMBRADO, 0) = NVL(I_DOC_TIMBRADO, 0)
           AND DOC_TMP_ESTADO IS NULL;
      END IF;
      IF V_NRO_DOC IS NOT NULL THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Documento existente, pendiente de aprobacion',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'Documento existente, pendiente de aprobacion');
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
      WHEN TOO_MANY_ROWS THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Documento existente, pendiente de aprobacion',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'Documento existente, pendiente de aprobacion');
    END;

    SELECT DOC_NRO_DOC
      INTO V_NRO_DOC
      FROM FIN_DOCUMENTO
     WHERE DOC_NRO_DOC = I_DOCU_NRO_DOC
       AND DOC_EMPR = I_EMPRESA
       AND (DOC_PROV = I_DOCU_PROV OR I_DOCU_PROV IS NULL)
       AND DOC_TIPO_MOV = I_DOCU_TIPO_MOV --IN (1,2)
       AND NVL(DOC_TIMBRADO, 0) = NVL(I_DOC_TIMBRADO, 0);

    IF V_NRO_DOC IS NOT NULL THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Documento existente',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Documento existente!');
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN TOO_MANY_ROWS THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Documento existente',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Documento existente!');
  END PP_VALIDAR_DOC_EXIST;

  PROCEDURE PP_DESHABILITAR_TASA(I_EMPRESA IN NUMBER,
                                 I_USER    IN VARCHAR2,
                                 O_IND     OUT VARCHAR2) IS
    V_IND VARCHAR2(1);
  BEGIN
    SELECT NVL(OPEM_MOD_TASA, 'N')
      INTO O_IND
      FROM GEN_OPERADOR_EMPRESA E, GEN_OPERADOR O
     WHERE OPER_LOGIN = I_USER
       AND OPEM_OPER = OPER_CODIGO
       AND OPEM_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'ERROR: ' || SQLERRM);
  END PP_DESHABILITAR_TASA;

  /*PROCEDURE PP_VALIDAR_PROV_MON(I_EMPRESA   IN NUMBER,
                                I_DOCU_PROV IN FIN_PROV_EMPRESA.PREM_PROV%TYPE,
                                I_DOCU_MON  IN FIN_PROV_EMPRESA.PREM_MON%TYPE) IS
    V_VARIABLE VARCHAR2(1);
  BEGIN
    SELECT 'X'
      INTO V_VARIABLE
      FROM FIN_PROV_EMPRESA
     WHERE PREM_EMPR = I_EMPRESA
       AND PREM_PROV = I_DOCU_PROV
       AND PREM_MON  = I_DOCU_MON;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      APEX_ERROR.ADD_ERROR (P_MESSAGE          => 'El proveedor no esta habilitado a operar con esta moneda en esta empresa!',
                          P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION );
       RAISE_APPLICATION_ERROR(-20002,'El proveedor no esta habilitado a operar con esta moneda en esta empresa!');
  END PP_VALIDAR_PROV_MON;*/

  PROCEDURE PP_MOSTRAR_DESC_MONEDA(I_EMPRESA          IN NUMBER,
                                   I_DOCU_MON         IN NUMBER,
                                   I_DOCU_TIPO_MOV    IN NUMBER,
                                   I_CONF_FACT_CR_REC IN NUMBER,
                                   I_S_CREDITO        IN VARCHAR2,
                                   I_DOCU_PROV        IN NUMBER,
                                   I_P_MON_LOC        IN NUMBER,
                                   I_DOCU_FEC_EMIS    IN DATE,
                                   I_USER             IN VARCHAR2,
                                   O_MON_SIMBOLO      OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                   O_MON_DEC_IMP      OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                   O_MON_DEC_PRECIO   OUT GEN_MONEDA.MON_DEC_PRECIO%TYPE,
                                   O_MON_DEC_TASA     OUT GEN_MONEDA.MON_DEC_TASA%TYPE,
                                   O_MON_DESC         OUT GEN_MONEDA.MON_DESC%TYPE,
                                   O_W_MON_DEC_IMP    OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                   O_S_TASA           OUT NUMBER,
                                   O_DES_TASA         OUT VARCHAR2
                                   /*IO_DOCU_EXEN_NETO_MON IN OUT NUMBER,



                                                            IO_DOCU_GR




















                                                                      AV_NETO_MON IN OUT NUMBER,



                                                            IO_DOC_GRA




















                                                                      V_5_MON     IN OUT NUMBER,



                                                            IO_DOC_GRA




















                                                                      V_10_MON    IN OUT NUMBER,



                                                            IO_DOCU_IV




















                                                                      A_MON       IN OUT NUMBER*/) IS

  BEGIN

    SELECT MON_SIMBOLO, MON_DEC_IMP, MON_DEC_PRECIO, MON_DEC_TASA, MON_DESC
      INTO O_MON_SIMBOLO,
           O_MON_DEC_IMP,
           O_MON_DEC_PRECIO,
           O_MON_DEC_TASA,
           O_MON_DESC
      FROM GEN_MONEDA
     WHERE MON_CODIGO = I_DOCU_MON
       AND MON_EMPR = I_EMPRESA;

    O_W_MON_DEC_IMP := O_MON_DEC_IMP;
    IF I_DOCU_TIPO_MOV = I_CONF_FACT_CR_REC OR
       (I_DOCU_TIPO_MOV IN (I_CONF_FACT_CR_REC) AND I_S_CREDITO = 'S') AND
       I_DOCU_PROV IS NOT NULL THEN
      PP_VALIDAR_PROV_MON(I_EMPRESA   => I_EMPRESA,
                          I_DOCU_PROV => I_DOCU_PROV,
                          I_DOCU_MON  => I_DOCU_MON);
    END IF;

    IF I_DOCU_MON = I_P_MON_LOC THEN
      O_S_TASA := 1;

    ELSE
      O_S_TASA := GEN_COT_TIPO_MOV(p_empresa => I_empresa,
                            p_moneda => I_DOCU_MON,
                            p_tipo_mov => I_DOCU_TIPO_MOV,
                            p_fecha => I_DOCU_FEC_EMIS);
                      /*FACI039.FP_COTIZACION(P_MONEDA      => I_DOCU_MON,
                                        P_DOC_FEC_DOC => I_DOCU_FEC_EMIS,
                                        P_EMPRESA     => I_EMPRESA);*/

      PP_DESHABILITAR_TASA(I_EMPRESA => I_EMPRESA,
                           I_USER    => I_USER,
                           O_IND     => O_DES_TASA);
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_MON_SIMBOLO := NULL;
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Moneda inexistente!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Moneda inexistente!');
  END PP_MOSTRAR_DESC_MONEDA;
  PROCEDURE PP_MOSTRAR_CTA_BANCARIA(I_EMPRESA          IN NUMBER,
                                    I_S_CTA_BCO        IN NUMBER,
                                    I_USER             IN VARCHAR2,
                                    I_TMOV_TIPO_SALDO  IN VARCHAR2,
                                    I_DOCU_FEC_EMIS    IN DATE,
                                    I_P_MON_LOC        IN NUMBER,
                                    I_DOCU_TIPO_MOV    IN NUMBER,
                                    I_CONF_FACT_CR_REC IN NUMBER,
                                    I_S_CREDITO        IN VARCHAR2,
                                    I_DOCU_PROV        IN NUMBER,
                                    O_P_CTA_DESC       OUT VARCHAR2,
                                    O_S_CTA_DESC       OUT VARCHAR2,
                                    O_S_BCO_DESC       OUT VARCHAR2,
                                    O_DOCU_MON         OUT NUMBER,
                                    O_P_CTA_BCO_DIA    OUT NUMBER,
                                    O_MON_SIMBOLO      OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                    O_MON_DEC_IMP      OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                    O_MON_DEC_PRECIO   OUT GEN_MONEDA.MON_DEC_PRECIO%TYPE,
                                    O_MON_DEC_TASA     OUT GEN_MONEDA.MON_DEC_TASA%TYPE,
                                    O_MON_DESC         OUT GEN_MONEDA.MON_DESC%TYPE,
                                    O_W_MON_DEC_IMP    OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                    O_S_TASA           OUT NUMBER,
                                    O_DES_TASA         OUT VARCHAR2
                                    /*IO_DOCU_EXEN_NETO_MON IN OUT NUMBER,









                                                                                                                                                                                IO_D

























                                                                                                                                                                                    OCU_GRAV_NETO_MON IN OUT NUMBER,









                                                                                                                                                                                IO_D

























                                                                                                                                                                                    OC_GRAV_5_MON     IN OUT NUMBER,









                                                                                                                                                                                IO_D

























                                                                                                                                                                                    OC_GRAV_10_MON    IN OUT N                                                                                                                                                                                   OCU_IVA_MON       IN OUT NUMBER*/) IS
  BEGIN
    SELECT CTA_DESC, BCO_DESC, CTA_MON, CTA_BCO_DIA
      INTO O_S_CTA_DESC, O_S_BCO_DESC, O_DOCU_MON, O_P_CTA_BCO_DIA
      FROM FIN_CUENTA_BANCARIA, FIN_BANCO
     WHERE CTA_EMPR = I_EMPRESA
       AND CTA_CODIGO = I_S_CTA_BCO
       AND CTA_BCO = BCO_CODIGO(+)
       AND CTA_EMPR = BCO_EMPR(+);

    O_P_CTA_DESC := O_S_CTA_DESC;

    FACI039.PL_VALIDAR_OPCTA(P_CTA       => I_S_CTA_BCO,
                             P_EMPRESA   => I_EMPRESA,
                             P_LOGIN     => I_USER,
                             P_CTA_DESC  => O_P_CTA_DESC,
                             P_OPERACION => I_TMOV_TIPO_SALDO,
                             P_PROGRAMA  => 'COMI001');

    FACI039.PP_VAL_CTA_BCO_MES_ACTUAL(P_FECHA   => I_DOCU_FEC_EMIS,
                                      P_CTA_BCO => I_S_CTA_BCO,
                                      P_EMPRESA => I_EMPRESA,
                                      P_USUARIO => I_USER);

    PP_MOSTRAR_DESC_MONEDA(I_EMPRESA          => I_EMPRESA,
                           I_DOCU_MON         => O_DOCU_MON,
                           I_DOCU_TIPO_MOV    => I_DOCU_TIPO_MOV,
                           I_CONF_FACT_CR_REC => I_CONF_FACT_CR_REC,
                           I_S_CREDITO        => I_S_CREDITO,
                           I_DOCU_PROV        => I_DOCU_PROV,
                           I_P_MON_LOC        => I_P_MON_LOC,
                           I_DOCU_FEC_EMIS    => I_DOCU_FEC_EMIS,
                           I_USER             => I_USER,
                           O_MON_SIMBOLO      => O_MON_SIMBOLO,
                           O_MON_DEC_IMP      => O_MON_DEC_IMP,
                           O_MON_DEC_PRECIO   => O_MON_DEC_PRECIO,
                           O_MON_DEC_TASA     => O_MON_DEC_TASA,
                           O_MON_DESC         => O_MON_DESC,
                           O_W_MON_DEC_IMP    => O_W_MON_DEC_IMP,
                           O_S_TASA           => O_S_TASA,
                           O_DES_TASA         => O_DES_TASA
                           /*IO_DOCU_EXEN_NETO_MON => IO_DOCU_EXEN_NETO_MON,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            IO_DOCU_GRAV_NETO_MON => IO_DOCU_GRAV_NETO_MON,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            IO_DOC_GRAV_5_MON     => IO_DOC_GRAV_5_MON,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            IO_DOC_GRAV_10_MON    => IO_DOC_GRAV_10_MON,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            IO_DOCU_IVA_MON       => IO_DOCU_IVA_MON*/);

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_S_CTA_DESC := NULL;
      O_S_BCO_DESC := NULL;
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Cuenta bancaria inexistente!.',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Cuenta bancaria inexistente!.');
  END PP_MOSTRAR_CTA_BANCARIA;

  PROCEDURE PP_MOSTRAR_DESC_TIPO_MOV(I_EMPRESA         IN NUMBER,
                                     I_DOCU_TIPO_MOV   IN NUMBER,
                                     O_TMOV_DESC       OUT GEN_TIPO_MOV.TMOV_DESC%TYPE,
                                     O_TMOV_TIPO_SALDO OUT GEN_TIPO_MOV.TMOV_TIPO%TYPE) IS

  BEGIN
    SELECT TMOV_DESC, TMOV_TIPO
      INTO O_TMOV_DESC, O_TMOV_TIPO_SALDO
      FROM GEN_TIPO_MOV
     WHERE TMOV_CODIGO = I_DOCU_TIPO_MOV
       AND TMOV_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_TMOV_DESC := NULL;
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Tipo de documento inexistente!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Tipo de documento inexistente!');
  END PP_MOSTRAR_DESC_TIPO_MOV;

  PROCEDURE PP_CTA_CHEQ_EMIT_DIF(I_EMPRESA             IN NUMBER,
                                 I_S_CTA_BCO           IN NUMBER,
                                 I_DOCU_TIPO_MOV       IN NUMBER,
                                 I_CONF_FACT_CR_REC    IN NUMBER,
                                 I_CONF_NOTA_CR_REC    IN NUMBER,
                                 I_S_CREDITO           IN VARCHAR2,
                                 O_P_BANCO             OUT FIN_CUENTA_BANCARIA.CTA_BCO%TYPE,
                                 O_P_IND_CHEQUE_DIF    OUT FIN_CUENTA_BANCARIA.CTA_IND_CHEQ_DIF%TYPE,
                                 O_MOSTRAR_BTN_CHEQUES OUT NUMBER,
                                 O_P_IMP_CHEQUE        OUT VARCHAR2) IS
    V_BANCO NUMBER;
  BEGIN
    SELECT CTA_BCO, CTA_BCO, NVL(CTA_IND_CHEQ_DIF, 'N')
      INTO V_BANCO, O_P_BANCO, O_P_IND_CHEQUE_DIF
      FROM FIN_CUENTA_BANCARIA
     WHERE CTA_EMPR = I_EMPRESA
       AND CTA_CODIGO = I_S_CTA_BCO;

    IF I_DOCU_TIPO_MOV IN (I_CONF_FACT_CR_REC) OR
       (I_DOCU_TIPO_MOV = I_CONF_NOTA_CR_REC AND I_S_CREDITO = 'S') THEN

      IF V_BANCO IS NOT NULL THEN
        O_MOSTRAR_BTN_CHEQUES := 1;
      ELSE
        O_P_IND_CHEQUE_DIF    := NULL;
        O_P_IMP_CHEQUE        := 'N';
        O_MOSTRAR_BTN_CHEQUES := 0;
      END IF;
    END IF;
  END PP_CTA_CHEQ_EMIT_DIF;

  PROCEDURE PP_BUSCAR_NRO_RETENCION(I_EMPRESA         IN NUMBER,
                                    O_S_NRO_RETENCION OUT GEN_IMPRESORA.IMP_ULT_RETENCION%TYPE) IS
  BEGIN
    SELECT NVL(IMP_ULT_RETENCION, 0) + 1
      INTO O_S_NRO_RETENCION
      FROM GEN_IMPRESORA
     WHERE --IMP_CODIGO = :PARAMETER.P_IMPRESORA
     IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR')
     AND IMP_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_S_NRO_RETENCION := 1;
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20005, 'FALTA');
    when others then
      raise_application_error(-20001,
                              'PP_BUSCAR_NRO_RETENCION - ' || SQLCODE ||
                              ' -ERROR- ' || SQLERRM);

  END PP_BUSCAR_NRO_RETENCION;

  PROCEDURE PP_TRAER_DESC_FCON(I_CONCEPTO                   IN NUMBER,
                               I_EMPRESA                    IN NUMBER,
                               I_TMOV_TIPO_SALDO            IN VARCHAR2,
                               I_DOCU_PROV_NOM              IN VARCHAR2,
                               O_CLAVE_CONCEPTO             OUT NUMBER,
                               O_FCON_DESC                  OUT VARCHAR2,
                               O_CLAVE_CTACO                OUT NUMBER,
                               O_FCON_IND_CLAVE_IMPORTACION OUT VARCHAR2,
                               O_DETA_CANT                  OUT NUMBER,
                               O_DETA_KM_ACTUAL             OUT NUMBER,
                               O_CANAL_REQUERIDO            OUT VARCHAR2,
                               O_CAT_FCON                   OUT NUMBER,
                               O_IND_CANT_KM                OUT VARCHAR2) IS
    W_DESC_TIPO_FCON VARCHAR2(7);
    V_TIPO_SALDO     VARCHAR2(1);
    V_MOVIL          NUMBER;
    V_CONTROL_COMB   VARCHAR2(1);
    KM_OBL           VARCHAR2(1);

  BEGIN
    IF I_EMPRESA <> 2 THEN
      SELECT UPPER(FCON_DESC),
             FCON_CLAVE_CTACO,
             FCON_TIPO_SALDO,
             FCON_CLAVE,
             FCON_IND_CLAVE_IMPORTACION,
             FCON_MOVIL,
             NVL(RMAR_CNTRL_COMB, 'N'),
             CASE
               WHEN FCON_IND_CANAL_REQ = 'S' AND INDICADOR = 'S' THEN
                'S'
               WHEN FCON_IND_CANAL_REQ = 'S' AND INDICADOR = 'N' THEN
                'S'
               WHEN FCON_IND_CANAL_REQ = 'N' AND INDICADOR = 'S' THEN
                'S'
               ELSE
                'N'
             END MODALREQ
        INTO O_FCON_DESC,
             O_CLAVE_CTACO,
             V_TIPO_SALDO,
             O_CLAVE_CONCEPTO,
             O_FCON_IND_CLAVE_IMPORTACION,
             V_MOVIL,
             V_CONTROL_COMB,
             O_CANAL_REQUERIDO
        FROM FIN_CONCEPTO,
             STK_REMI_VEHICULO,
             (SELECT FCON_CLAVE CLAVE,
                     CASE
                       WHEN NVL(COUNT(FCD_CONC), 0) > 0 THEN
                        'S'
                       ELSE
                        'N'
                     END INDICADOR
                FROM FIN_CONCEPTO_CANAL, FIN_CONCEPTO
               WHERE FCD_CONC(+) = FCON_CLAVE
                 AND FCD_EMPR(+) = FCON_EMPR
                 AND FCON_CODIGO = I_CONCEPTO
                 AND FCON_EMPR = I_EMPRESA
               GROUP BY FCON_CLAVE) C
       WHERE FCON_CODIGO = I_CONCEPTO
         AND FCON_EMPR = I_EMPRESA
         AND FCON_CLAVE = CLAVE
         AND FCON_CODIGO IN (SELECT OPCO_CONCEPTO
                               FROM GEN_OPER_CONCEPTO    A,
                                    GEN_OPERADOR_EMPRESA B,
                                    GEN_OPERADOR
                              WHERE A.OPCO_OPERADOR = OPER_CODIGO
                                AND OPER_LOGIN LIKE GEN_DEVUELVE_USER
                                AND A.OPCO_EMPR = I_EMPRESA
                                AND OPER_CODIGO = B.OPEM_OPER
                                AND B.OPEM_EMPR = I_EMPRESA)
         AND FCON_MOVIL = RMAR_VEH_COD(+)
         AND FCON_EMPR = RMAR_EMPR(+);
    ELSE
      SELECT FCON_DESC,
             FCON_CLAVE_CTACO,
             FCON_TIPO_SALDO,
             FCON_CLAVE,
             FCON_IND_CLAVE_IMPORTACION,
             FCON_MOVIL,
             NVL(RMAR_CNTRL_COMB, 'N'),
             CASE
               WHEN FCON_IND_CANAL_REQ = 'S' AND INDICADOR = 'S' THEN
                'S'
               WHEN FCON_IND_CANAL_REQ = 'S' AND INDICADOR = 'N' THEN
                'S'
               WHEN FCON_IND_CANAL_REQ = 'N' AND INDICADOR = 'S' THEN
                'S'
               ELSE
                'N'
             END MODALREQ,
             FCON_CATEGORIA
        INTO O_FCON_DESC,
             O_CLAVE_CTACO,
             V_TIPO_SALDO,
             O_CLAVE_CONCEPTO,
             O_FCON_IND_CLAVE_IMPORTACION,
             V_MOVIL,
             V_CONTROL_COMB,
             O_CANAL_REQUERIDO,
             O_CAT_FCON
        FROM FIN_CONCEPTO,
             STK_REMI_VEHICULO,
             (SELECT FCON_CLAVE CLAVE,
                     CASE
                       WHEN NVL(COUNT(FCD_CONC), 0) > 0 THEN
                        'S'
                       ELSE
                        'N'
                     END INDICADOR
                FROM FIN_CONCEPTO_CANAL, FIN_CONCEPTO
               WHERE FCD_CONC(+) = FCON_CLAVE
                 AND FCD_EMPR(+) = FCON_EMPR
                 AND FCON_CODIGO = I_CONCEPTO
                 AND FCON_EMPR = I_EMPRESA
               GROUP BY FCON_CLAVE) C
       WHERE FCON_CODIGO = I_CONCEPTO
         AND FCON_EMPR = I_EMPRESA
         AND FCON_CLAVE = CLAVE

         AND FCON_MOVIL = RMAR_VEH_COD(+)
         AND FCON_EMPR = RMAR_EMPR(+);
    END IF;
    IF V_TIPO_SALDO <> I_TMOV_TIPO_SALDO THEN
      IF I_TMOV_TIPO_SALDO = 'D' THEN
        W_DESC_TIPO_FCON := 'debito';
      ELSE
        W_DESC_TIPO_FCON := 'credito';
      END IF;
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'El tipo del concepto tiene que ser: ' ||
                                                 W_DESC_TIPO_FCON || '!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002,
                              'El tipo del concepto tiene que ser: ' ||
                              W_DESC_TIPO_FCON || '!');
    END IF;

    IF O_FCON_DESC LIKE 'MOV%COMB%' AND
       I_DOCU_PROV_NOM NOT LIKE '%TRANSAGRO%' AND V_CONTROL_COMB = 'S' THEN
      IF V_MOVIL IS NULL THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Falta asignar movil al combustible en 2-1-45, avise al departamento de contabilidad.',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'Falta asignar movil al combustible en 2-1-45, avise al departamento de contabilidad.');
      ELSE
        O_DETA_CANT := NULL;
      END IF;
    ELSE
      O_DETA_CANT := 1;
    END IF;

    IF O_FCON_DESC LIKE '%MOV%COMB%' AND I_EMPRESA = 1 THEN
      ----------------**
      -- CAMBIO JB 01/04/2021
      BEGIN
        /*SELECT A.RHA_VEH_KM_OBLIG
          INTO KM_OBL
          FROM STK_VEHICULO_HILAGRO A
         WHERE A.RHA_VEH_EMPR = I_EMPRESA
           AND A.RHA_VEH_COD = V_MOVIL;*/
        --  AND RHA_VEH_SUC <> 2;


      SELECT A.RMAR_VEH_KM_OBLIG
      INTO KM_OBL
      FROM STK_REMI_VEHICULO A
      WHERE A.RMAR_EMPR = I_EMPRESA
        AND A.RMAR_VEH_COD =  V_MOVIL;

        IF KM_OBL = 'S' THEN
          O_IND_CANT_KM := 'S';
        ELSE
          O_IND_CANT_KM := 'N';
        END IF;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          O_IND_CANT_KM := 'N';
      END;
    ELSE
      O_IND_CANT_KM := 'N';
    END IF; ---------------------------------------------------**

    O_DETA_KM_ACTUAL := NULL;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_FCON_DESC                  := NULL;
      O_CLAVE_CTACO                := NULL;
      O_CLAVE_CONCEPTO             := NULL;
      O_FCON_IND_CLAVE_IMPORTACION := NULL;
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Concepto inexistente!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Concepto inexistente!');
  END PP_TRAER_DESC_FCON;

  PROCEDURE PP_TRAER_CUENTA_CONTABLE(I_EMPRESA     IN NUMBER,
                                     I_CONCEPTO    IN NUMBER,
                                     I_CLAVE_CTACO IN CNT_CUENTA.CTAC_CLAVE%TYPE,
                                     O_DCON_CUENTA OUT CNT_CUENTA.CTAC_NRO%TYPE,
                                     O_CONT_DESC   OUT CNT_CUENTA.CTAC_DESC%TYPE) IS
  BEGIN

    IF I_EMPRESA = 1 THEN
      --'%HILAGRO%' THEN
      --IF I_CONCEPTO NOT IN (1308, 609, 2406, 508, 608) THEN
      --CODIGOS DE CONCEPTOS DE PUBLICIDAD QUE SE PUEDEN ELEGIR LAS CUENTAS CONTABLES.
      IF I_CLAVE_CTACO IS NOT NULL THEN
        SELECT CTAC_NRO, CTAC_DESC
          INTO O_DCON_CUENTA, O_CONT_DESC
          FROM CNT_CUENTA
         WHERE CTAC_CLAVE = I_CLAVE_CTACO
           AND CTAC_EMPR = I_EMPRESA;
      ELSE
        O_DCON_CUENTA := NULL;
        O_CONT_DESC   := NULL;
      END IF;
      --END IF;
    ELSE
      --CUALQUIER OTRA EMPRESA QUE NO SEA HILAGRO.
      IF I_CLAVE_CTACO IS NOT NULL THEN
        SELECT CTAC_NRO, CTAC_DESC
          INTO O_DCON_CUENTA, O_CONT_DESC
          FROM CNT_CUENTA
         WHERE CTAC_CLAVE = I_CLAVE_CTACO
           AND CTAC_EMPR = I_EMPRESA;
      ELSE
        O_DCON_CUENTA := NULL;
        O_CONT_DESC   := NULL;
      END IF;

    END IF;

  END PP_TRAER_CUENTA_CONTABLE;

  PROCEDURE PP_TRAER_DESC_CONT(I_EMPRESA     IN NUMBER,
                               I_DCON_CUENTA IN CNT_CUENTA.CTAC_NRO%TYPE,
                               O_CONT_DESC   OUT CNT_CUENTA.CTAC_DESC%TYPE,
                               O_CLAVE_CTACO OUT CNT_CUENTA.CTAC_CLAVE%TYPE) IS
    V_IMPUTABLE VARCHAR2(1);
  BEGIN
    SELECT CTAC_DESC, CTAC_CLAVE, CTAC_IND_IMPUTABLE
      INTO O_CONT_DESC, O_CLAVE_CTACO, V_IMPUTABLE
      FROM CNT_CUENTA
     WHERE CTAC_NRO = I_DCON_CUENTA
       AND CTAC_EMPR = I_EMPRESA;

    IF V_IMPUTABLE = 'N' THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Cuenta no imputable',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Cuenta no imputable');
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_CONT_DESC := NULL;
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Cuenta contable inexistente!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Cuenta contable inexistente!');
  END PP_TRAER_DESC_CONT;

  PROCEDURE PP_VALIDAR_TIPO_IMPU(I_IND_TIPO_IVA_COMPRA IN GEN_TIPO_IMPUESTO.TIMPU_CODIGO%TYPE,
                                 I_EMPRESA             IN NUMBER,
                                 O_TIPO_IVA_DESC       OUT GEN_TIPO_IMPUESTO.TIMPU_DESC%TYPE) IS
    V_VARIABLE VARCHAR2(1);
  BEGIN
    SELECT TIMPU_DESC
      INTO O_TIPO_IVA_DESC
      FROM GEN_TIPO_IMPUESTO
     WHERE TIMPU_CODIGO = I_IND_TIPO_IVA_COMPRA
       AND TIMPU_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_TIPO_IVA_DESC := NULL;
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Tipo de impuesto inexistente!.',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002, 'Tipo de impuesto inexistente!.');
  END PP_VALIDAR_TIPO_IMPU;

  PROCEDURE PP_VALIDAR_TOTAL(I_IMPU_PORCENTAJE          IN NUMBER,
                             I_IMPU_PORC_BASE_IMPONIBLE IN NUMBER,
                             I_DETA_CANT                IN NUMBER,
                             I_PREC_UNIT                IN NUMBER,
                             I_MON_DEC_IMP              IN NUMBER,
                             O_TOTAL                    IN OUT NUMBER,
                             O_EXENTO                   IN OUT NUMBER,
                             IO_IVA                     IN OUT NUMBER,
                             IO_GRAVADO                 IN OUT NUMBER) IS

    PID NUMBER; --PORCENTAJE DEL IVA DIRECTO SOBRE EL PRECIO DE VENTA
    PG  NUMBER; --PORCENTAJE GRAVADO
    PE  NUMBER; --PORCENTAJE EXENTO
  BEGIN

    IF NVL(I_IMPU_PORCENTAJE, 0) > 0 THEN
      --HALLAR PORCENTAJES
      PID := (I_IMPU_PORC_BASE_IMPONIBLE / 100) * (I_IMPU_PORCENTAJE / 100) * 100;
      PG  := I_IMPU_PORC_BASE_IMPONIBLE;
      PE  := 100 - PG;

      --RESTAR EL DESCUENTO DEL TOTAL

      O_TOTAL := ROUND(NVL(I_DETA_CANT, 1) * I_PREC_UNIT, I_MON_DEC_IMP);

      IF NVL(IO_IVA, 0) = 0 THEN
        IO_IVA := ROUND(PID / (PID + 100) * O_TOTAL, I_MON_DEC_IMP);
      END IF;
      IF NVL(IO_GRAVADO, 0) = 0 THEN
        IO_GRAVADO := ROUND(PG / (PID + 100) * O_TOTAL, I_MON_DEC_IMP);
      END IF;
      O_EXENTO := ROUND(PE / (PID + 100) * O_TOTAL, I_MON_DEC_IMP);

      O_EXENTO   := NVL(O_EXENTO, 0);
      IO_IVA     := NVL(IO_IVA, 0);
      IO_GRAVADO := NVL(IO_GRAVADO, 0);
    ELSE
      O_EXENTO   := NVL(O_TOTAL, 0);
      IO_IVA     := 0;
      IO_GRAVADO := 0;

    END IF;

  END PP_VALIDAR_TOTAL;

  PROCEDURE PP_VALIDAR_GRAVADO(I_OPCION          IN VARCHAR2,
                               I_IMPU_PORCENTAJE IN NUMBER,
                               I_MON_DEC_IMP     IN NUMBER,
                               IO_GRAVADO        IN OUT NUMBER,
                               IO_IVA            IN OUT NUMBER,
                               IO_EXENTO         IN OUT NUMBER,
                               IO_TOTAL          IN OUT NUMBER) IS
    V_PORC_IMPU NUMBER := I_IMPU_PORCENTAJE;
  BEGIN

    IF I_OPCION = 'M' THEN
      IF IO_GRAVADO < 0 THEN
        IO_GRAVADO := ROUND(ABS(IO_GRAVADO) / ((V_PORC_IMPU + 100) / 100),
                            I_MON_DEC_IMP);
        IO_IVA     := IO_TOTAL - IO_GRAVADO;
      ELSE
        IF IO_EXENTO > 0 THEN
          IO_IVA := 0;
        ELSE
          IF NVL(IO_IVA, 0) = 0 THEN
            IO_IVA := IO_TOTAL - IO_GRAVADO;
          END IF;
        END IF;
      END IF;

    ELSE
      --GASTOS
      IF IO_GRAVADO < 0 THEN
        IF NVL(IO_IVA, 0) = 0 THEN
          IO_IVA := ROUND(ABS(IO_GRAVADO) /
                          ((V_PORC_IMPU + 100) / V_PORC_IMPU),
                          I_MON_DEC_IMP);
        END IF;

        IO_GRAVADO := ROUND(ABS(IO_GRAVADO) - IO_IVA, I_MON_DEC_IMP);

      ELSE
        IF IO_EXENTO > 0 THEN
          IO_IVA := 0;
        ELSE
          IF NVL(IO_IVA, 0) = 0 THEN
            IO_IVA := ROUND((IO_GRAVADO * V_PORC_IMPU) / 100, I_MON_DEC_IMP);
          END IF;
        END IF;
      END IF;
    END IF;

    IO_TOTAL := NVL(IO_GRAVADO, 0) + NVL(IO_IVA, 0) + NVL(IO_EXENTO, 0);

    IF IO_EXENTO > 0 THEN
      IO_IVA     := 0;
      IO_GRAVADO := 0;
      IF I_OPCION = 'G' THEN
        IO_TOTAL := IO_EXENTO;
      END IF;
    END IF;

  END PP_VALIDAR_GRAVADO;

  PROCEDURE PP_BUSCAR_IMPUESTO_OT(I_EMPRESA                  IN NUMBER,
                                  I_OT_IMPU                  IN GEN_IMPUESTO.IMPU_CODIGO%TYPE,
                                  O_IMPU_PORCENTAJE          OUT GEN_IMPUESTO.IMPU_PORCENTAJE%TYPE,
                                  O_IMPU_PORC_BASE_IMPONIBLE OUT GEN_IMPUESTO.IMPU_PORC_BASE_IMPONIBLE%TYPE) IS

  BEGIN

    SELECT IMPU_PORCENTAJE, IMPU_PORC_BASE_IMPONIBLE
      INTO O_IMPU_PORCENTAJE, O_IMPU_PORC_BASE_IMPONIBLE
      FROM GEN_IMPUESTO
     WHERE IMPU_CODIGO = I_OT_IMPU
       AND IMPU_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;

  END PP_BUSCAR_IMPUESTO_OT;

  PROCEDURE PP_BUSCAR_IMPUESTO_ARTICULO(I_EMPRESA                  IN NUMBER,
                                        I_ART_IMPU                 IN GEN_IMPUESTO.IMPU_CODIGO%TYPE,
                                        O_IMPU_PORCENTAJE          OUT GEN_IMPUESTO.IMPU_PORCENTAJE%TYPE,
                                        O_IMPU_PORC_BASE_IMPONIBLE OUT GEN_IMPUESTO.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                                        O_IMPU_INCLUIDO            OUT GEN_IMPUESTO.IMPU_INCLUIDO%TYPE) IS
    V_IMPU_PORCENTAJE NUMBER;
  BEGIN

    SELECT IMPU_PORCENTAJE, IMPU_INCLUIDO, IMPU_PORC_BASE_IMPONIBLE
      INTO V_IMPU_PORCENTAJE, O_IMPU_INCLUIDO, O_IMPU_PORC_BASE_IMPONIBLE
      FROM GEN_IMPUESTO
     WHERE IMPU_CODIGO = I_ART_IMPU
       AND IMPU_EMPR = I_EMPRESA;

    IF O_IMPU_PORCENTAJE IS NULL THEN
      O_IMPU_PORCENTAJE := V_IMPU_PORCENTAJE;
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_IMPU_PORCENTAJE := NULL;
      O_IMPU_INCLUIDO   := NULL;
      RAISE_APPLICATION_ERROR(-20002,
                              'Impuesto inexistente para este articulo o servicio!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'ERROR: ' || SQLERRM);
  END PP_BUSCAR_IMPUESTO_ARTICULO;

  PROCEDURE PP_VALIDAR_ART_EMPRESA(I_EMPRESA  IN NUMBER,
                                   I_DETA_ART IN STK_ARTICULO_EMPRESA.AREM_ART%TYPE) IS
    V_VARIABLE VARCHAR2(1);
  BEGIN
    SELECT 'X'
      INTO V_VARIABLE
      FROM STK_ARTICULO_EMPRESA
     WHERE AREM_EMPR = I_EMPRESA
       AND AREM_ART = I_DETA_ART;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'El articulo no esta habilitado para esta empresa!.');
  END PP_VALIDAR_ART_EMPRESA;

  PROCEDURE PP_EXHIBIR_DESC_ART(I_EMPRESA                  IN NUMBER,
                                I_DETA_ART                 IN STK_ARTICULO.ART_CODIGO%TYPE,
                                O_ART_DESC_ABREV           OUT STK_ARTICULO.ART_DESC_ABREV%TYPE,
                                O_ART_DESC                 OUT STK_ARTICULO.ART_DESC%TYPE,
                                O_ART_IMPU                 OUT STK_ARTICULO.ART_IMPU%TYPE,
                                O_ART_TIPO_COMISION        OUT STK_ARTICULO.ART_TIPO_COMISION%TYPE,
                                O_IMPU_PORCENTAJE          OUT GEN_IMPUESTO.IMPU_PORCENTAJE%TYPE,
                                O_IMPU_PORC_BASE_IMPONIBLE OUT GEN_IMPUESTO.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                                O_IMPU_INCLUIDO            OUT GEN_IMPUESTO.IMPU_INCLUIDO%TYPE) IS
    ---  O_CTL_SERIE                OUT STK_ARTICULO.ART_CONTROL_SERIE%TYPE) IS --'13/09/2019' NO REFIERE A NINGUN CAMPO EN APEX "PLS-00306: n?mero o tipos de argumentos err?neos al llamar a 'PP_EXHIBIR_DESC_ART'"

    V_ART_EST            STK_ARTICULO.ART_EST%TYPE;
    V_ART_INCLUYE_COMPRA VARCHAR2(1);

  BEGIN
    SELECT ART_EST,
           ART_DESC_ABREV,
           ART_DESC,
           ART_IMPU,
           ART_TIPO_COMISION,
           NVL(ART_IND_EXC_COMPRA, 'N')
    -- NVL(ART_CONTROL_SERIE, 'N')
      INTO V_ART_EST,
           O_ART_DESC_ABREV,
           O_ART_DESC,
           O_ART_IMPU,
           O_ART_TIPO_COMISION,
           V_ART_INCLUYE_COMPRA
    --O_CTL_SERIE
      FROM STK_ARTICULO
     WHERE ART_CODIGO = I_DETA_ART
       AND ART_TIPO <> 2
       AND ART_EMPR = I_EMPRESA;

    IF V_ART_INCLUYE_COMPRA = 'S' then
      RAISE_APPLICATION_ERROR(-20023,
                              'El articulo no esta incluido para la compra');
    end if;

    IF V_ART_EST = 'I' THEN
      RAISE_APPLICATION_ERROR(-20002, 'Articulo inactivo!.');
    END IF;

    PP_VALIDAR_ART_EMPRESA(I_EMPRESA  => I_EMPRESA,
                           I_DETA_ART => I_DETA_ART);

    PP_BUSCAR_IMPUESTO_ARTICULO(I_EMPRESA                  => I_EMPRESA,
                                I_ART_IMPU                 => O_ART_IMPU,
                                O_IMPU_PORCENTAJE          => O_IMPU_PORCENTAJE,
                                O_IMPU_PORC_BASE_IMPONIBLE => O_IMPU_PORC_BASE_IMPONIBLE,
                                O_IMPU_INCLUIDO            => O_IMPU_INCLUIDO);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_ART_DESC_ABREV := NULL;
      O_ART_DESC       := NULL;
      RAISE_APPLICATION_ERROR(-20002, 'Articulo inexistente!');
    WHEN INVALID_NUMBER THEN
      O_ART_DESC_ABREV := NULL;
      O_ART_DESC       := NULL;
      RAISE_APPLICATION_ERROR(-20002, 'Articulo incorrecto!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'ERROR: ' || SQLERRM);
  END PP_EXHIBIR_DESC_ART;

  PROCEDURE PP_VALIDAR_COMI001_TMP(I_OPCION                   IN COMI001_DET_TMP.OPCION%TYPE,
                                   I_CONCEPTO                 IN COMI001_DET_TMP.CONCEPTO%TYPE,
                                   I_OT                       IN COMI001_DET_TMP.OT%TYPE,
                                   I_DCON_CUENTA              IN COMI001_DET_TMP.DCON_CUENTA%TYPE,
                                   I_DCON_CANAL               IN COMI001_DET_TMP.DCON_CANAL%TYPE,
                                   I_DCON_DIV_CANAL           IN COMI001_DET_TMP.DCON_DIV_CANAL%TYPE,
                                   I_NRO_IMPORTACION          IN COMI001_DET_TMP.NRO_IMPORTACION%TYPE,
                                   I_CANT                     IN COMI001_DET_TMP.CANT%TYPE,
                                   I_KM_ACTUAL                IN COMI001_DET_TMP.KM_ACTUAL%TYPE,
                                   I_PREC_UNIT                IN COMI001_DET_TMP.PREC_UNIT%TYPE,
                                   I_OBS                      IN COMI001_DET_TMP.OBS%TYPE,
                                   I_IND_TIPO_IVA_COMPRA      IN COMI001_DET_TMP.IND_TIPO_IVA_COMPRA%TYPE,
                                   I_PC_DCTO                  IN COMI001_DET_TMP.PC_DCTO%TYPE,
                                   I_IMPU_PORC_BASE_IMPONIBLE IN COMI001_DET_TMP.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                                   I_IMPU_PORCENTAJE          IN COMI001_DET_TMP.IMPU_PORCENTAJE%TYPE,
                                   I_TOTAL                    IN COMI001_DET_TMP.TOTAL%TYPE,
                                   I_EXENTO                   IN COMI001_DET_TMP.EXENTO%TYPE,
                                   I_GRAVADO                  IN COMI001_DET_TMP.GRAVADO%TYPE,
                                   I_IVA                      IN COMI001_DET_TMP.IVA%TYPE,
                                   I_SESSION_ID               IN COMI001_DET_TMP.SESSION_ID%TYPE,
                                   I_USUARIO                  IN COMI001_DET_TMP.USUARIO%TYPE,
                                   I_TIMBRADO                 IN COMI001_DET_TMP.TIMBRADO%TYPE,
                                   I_DESC_LARGA               IN COMI001_DET_TMP.DESC_LARGA%TYPE,
                                   I_CONT_DESC                IN COMI001_DET_TMP.CONT_DESC%TYPE,
                                   I_ART                      IN COMI001_DET_TMP.ART%TYPE) IS
  BEGIN

    IF NVL(I_TOTAL, 0) = 0 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'El total debe tener valor' || I_TOTAL);
    END IF;
    IF I_OBS IS NULL AND GEN_DEVUELVE_USER != 'LARISA' THEN
      --EXCEPION PARA CEDEC
      RAISE_APPLICATION_ERROR(-20002, 'Digite la observacion');
    END IF;
    --IF NVL(I_IMPU_PORCENTAJE, 0) = 0 THEN--COMENTADO POR APERALTA 25/05/2018 POR QUE TAMBIEN DEBE PERMITIR EXENTO
    --  RAISE_APPLICATION_ERROR(-20002, 'El impuesto debe tener valor');
    --  END IF;
    IF NVL(I_OPCION, '-') = '-' THEN
      RAISE_APPLICATION_ERROR(-20002, 'Debe seleccionar una opcion');
    END IF;

    IF I_OPCION = 'M' AND NVL(I_ART, 0) = 0 THEN
      --MERCADERIA
      RAISE_APPLICATION_ERROR(-20002, 'Debe seleccionar un articulo');
    ELSIF I_OPCION = 'G' AND I_CONCEPTO IS NULL THEN
      --GASTO
      RAISE_APPLICATION_ERROR(-20002, 'Debe seleccionar un concepto');
    ELSIF I_OPCION = 'O' AND I_OT IS NULL THEN
      --ORDEN DE TRABAJO
      RAISE_APPLICATION_ERROR(-20002,
                              'Debe seleccionar una orden de trabajo');
    ELSIF I_OPCION = 'A' THEN
      --ACTIVO FIJO
      RAISE_APPLICATION_ERROR(-20002,
                              'No esta integrado con el sistema de activo fijo!.');
    END IF;

  END PP_VALIDAR_COMI001_TMP;

  PROCEDURE PP_GUARDAR_COMI001_TMP(I_OPCION                   IN COMI001_DET_TMP.OPCION%TYPE,
                                   I_CONCEPTO                 IN COMI001_DET_TMP.CONCEPTO%TYPE,
                                   I_OT                       IN COMI001_DET_TMP.OT%TYPE,
                                   I_DCON_CUENTA              IN COMI001_DET_TMP.DCON_CUENTA%TYPE,
                                   I_DCON_CANAL               IN COMI001_DET_TMP.DCON_CANAL%TYPE,
                                   I_DCON_DIV_CANAL           IN COMI001_DET_TMP.DCON_DIV_CANAL%TYPE,
                                   I_NRO_IMPORTACION          IN COMI001_DET_TMP.NRO_IMPORTACION%TYPE,
                                   I_CANT                     IN COMI001_DET_TMP.CANT%TYPE,
                                   I_KM_ACTUAL                IN COMI001_DET_TMP.KM_ACTUAL%TYPE,
                                   I_PREC_UNIT                IN COMI001_DET_TMP.PREC_UNIT%TYPE,
                                   I_OBS                      IN COMI001_DET_TMP.OBS%TYPE,
                                   I_IND_TIPO_IVA_COMPRA      IN COMI001_DET_TMP.IND_TIPO_IVA_COMPRA%TYPE,
                                   I_PC_DCTO                  IN COMI001_DET_TMP.PC_DCTO%TYPE,
                                   I_IMPU_PORC_BASE_IMPONIBLE IN COMI001_DET_TMP.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                                   I_IMPU_PORCENTAJE          IN COMI001_DET_TMP.IMPU_PORCENTAJE%TYPE,
                                   I_TOTAL                    IN COMI001_DET_TMP.TOTAL%TYPE,
                                   I_EXENTO                   IN COMI001_DET_TMP.EXENTO%TYPE,
                                   I_GRAVADO                  IN COMI001_DET_TMP.GRAVADO%TYPE,
                                   I_IVA                      IN COMI001_DET_TMP.IVA%TYPE,
                                   I_SESSION_ID               IN COMI001_DET_TMP.SESSION_ID%TYPE,
                                   I_USUARIO                  IN COMI001_DET_TMP.USUARIO%TYPE,
                                   I_TIMBRADO                 IN COMI001_DET_TMP.TIMBRADO%TYPE,
                                   I_DESC_LARGA               IN COMI001_DET_TMP.DESC_LARGA%TYPE,
                                   I_CONT_DESC                IN COMI001_DET_TMP.CONT_DESC%TYPE,
                                   I_ART                      IN COMI001_DET_TMP.ART%TYPE,
                                   I_DCON_CLAVE_IMP           IN COMI001_DET_TMP.DCON_CLAVE_IMP%TYPE,
                                   I_EMPRESA                  IN NUMBER,
                                   I_NRO_ITEM                 IN COMI001_DET_TMP.NRO_ITEM%TYPE,
                                   I_IMP_AFECTA_COSTO         IN COMI001_DET_TMP.IMP_AFECTA_COSTO%TYPE,
                                   I_IND_ORDEN_COMPRA         IN VARCHAR2 DEFAULT NULL,
                                   I_CANT_FAC_ANT             IN NUMBER,
                                   I_IND_VIATICO              IN COMI001_DET_TMP.IND_RESPONSABLE_VIATICO%TYPE) IS
    ----**
    V_NRO_ITEM         NUMBER := 0;
    V_CTA              NUMBER;
    V_CONCEPTO         NUMBER;
    V_CTA_DESC         VARCHAR2(100);
    V_IMP_AFECTA_COSTO VARCHAR2(100);
    V_CANTIDAD_AUX     NUMBER;
    V_CALCULO_IVA NUMBER;
  BEGIN

    BEGIN
      SELECT FCON_CLAVE, FCON_DESC
        INTO V_CONCEPTO, V_CTA_DESC
        FROM FIN_CONCEPTO T
       WHERE FCON_CODIGO = I_CONCEPTO
         AND FCON_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_CONCEPTO := NULL;
    END;

    IF I_CONCEPTO IS NOT NULL AND I_DCON_CUENTA IS NULL THEN

      RAISE_APPLICATION_ERROR(-20002,
                              'Ingrese un concepto con cuenta Contable!');
    END IF;

    IF I_NRO_ITEM IS NOT NULL AND NVL(I_IND_ORDEN_COMPRA, 'N') = 'S' AND
       I_OPCION = 'M' THEN
      BEGIN
        SELECT A.CANT
          INTO V_CANTIDAD_AUX
          FROM COMI001_DET_TMP A
         WHERE SESSION_ID = I_SESSION_ID
           AND A.NRO_ITEM = I_NRO_ITEM
           AND USUARIO = I_USUARIO
           AND TRUNC(FECHA) = TRUNC(SYSDATE);
        IF V_CANTIDAD_AUX <> NVL(I_CANT, 1) THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'No esta permitido Modificar la Cantidad!');
        END IF;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;
    END IF;

    PP_VALIDAR_COMI001_TMP(I_OPCION                   => I_OPCION,
                           I_CONCEPTO                 => I_CONCEPTO,
                           I_OT                       => I_OT,
                           I_DCON_CUENTA              => I_DCON_CUENTA,
                           I_DCON_CANAL               => I_DCON_CANAL,
                           I_DCON_DIV_CANAL           => I_DCON_DIV_CANAL,
                           I_NRO_IMPORTACION          => I_NRO_IMPORTACION,
                           I_CANT                     => I_CANT,
                           I_KM_ACTUAL                => I_KM_ACTUAL,
                           I_PREC_UNIT                => I_PREC_UNIT,
                           I_OBS                      => I_OBS,
                           I_IND_TIPO_IVA_COMPRA      => I_IND_TIPO_IVA_COMPRA,
                           I_PC_DCTO                  => I_PC_DCTO,
                           I_IMPU_PORC_BASE_IMPONIBLE => I_IMPU_PORC_BASE_IMPONIBLE,
                           I_IMPU_PORCENTAJE          => I_IMPU_PORCENTAJE,
                           I_TOTAL                    => I_TOTAL,
                           I_EXENTO                   => I_EXENTO,
                           I_GRAVADO                  => I_GRAVADO,
                           I_IVA                      => I_IVA,
                           I_SESSION_ID               => I_SESSION_ID,
                           I_USUARIO                  => I_USUARIO,
                           I_TIMBRADO                 => I_TIMBRADO,
                           I_DESC_LARGA               => I_DESC_LARGA,
                           I_CONT_DESC                => I_CONT_DESC,
                           I_ART                      => I_ART);

    IF I_NRO_IMPORTACION IS NULL THEN
      V_IMP_AFECTA_COSTO := 'N';
    ELSE
      V_IMP_AFECTA_COSTO := I_IMP_AFECTA_COSTO;
    END IF;
    IF I_NRO_ITEM IS NULL THEN
      SELECT COUNT(1) + 1
        INTO V_NRO_ITEM
        FROM COMI001_DET_TMP
       WHERE SESSION_ID = I_SESSION_ID
         AND TIMBRADO = I_TIMBRADO
         AND USUARIO = I_USUARIO
         AND TRUNC(FECHA) = TRUNC(SYSDATE);
    ELSE
      V_NRO_ITEM := I_NRO_ITEM;

      DELETE COMI001_DET_TMP
       WHERE SESSION_ID = I_SESSION_ID
         AND TIMBRADO = I_TIMBRADO
         AND USUARIO = I_USUARIO
         AND TRUNC(FECHA) = TRUNC(SYSDATE)
         AND NRO_ITEM = I_NRO_ITEM;
    END IF;

    BEGIN
      SELECT CTAC_CLAVE
        INTO V_CTA
        FROM CNT_CUENTA
       WHERE CTAC_NRO = I_DCON_CUENTA
         AND CTAC_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_CTA := NULL;
    END;
    
       IF I_EXENTO >0 AND  I_GRAVADO >0 THEN
      RAISE_APPLICATION_ERROR (-20001, 'No puede tener valor en el excento y en la grabada al mismo tiempo');
    
    END IF;
    
   /* IF I_IMPU_PORCENTAJE  = 10 THEN
      V_CALCULO_IVA := ROUND((I_GRAVADO*I_IMPU_PORCENTAJE)/100,V('P1313_MON_DEC_IMP') );
      IF V_CALCULO_IVA<> I_IVA THEN
         RAISE_APPLICATION_ERROR (-20001, 'El importe del iva no corresponde');
      END IF;
        
   ELSIF I_IMPU_PORCENTAJE  = 5 THEN
       V_CALCULO_IVA :=ROUND((I_GRAVADO*I_IMPU_PORCENTAJE)/100,V('P1313_MON_DEC_IMP') );
     IF V_CALCULO_IVA<> I_IVA THEN
         RAISE_APPLICATION_ERROR (-20001, 'El importe del iva no corresponde');
      END IF;
    END IF; 
    */
    
    
    INSERT INTO COMI001_DET_TMP
      (NRO_ITEM,
       OPCION,
       CONCEPTO,
       OT,
       DCON_CUENTA,
       DCON_CANAL,
       DCON_DIV_CANAL,
       NRO_IMPORTACION,
       CANT,
       KM_ACTUAL,
       PREC_UNIT,
       OBS,
       IND_TIPO_IVA_COMPRA,
       PC_DCTO,
       IMPU_PORC_BASE_IMPONIBLE,
       IMPU_PORCENTAJE,
       TOTAL,
       EXENTO,
       GRAVADO,
       IVA,
       SESSION_ID,
       USUARIO,
       FECHA,
       TIMBRADO,
       DESC_LARGA,
       CONT_DESC,
       ART,
       DCON_CLAVE_IMP,
       CLAVE_CTACO,
       CLAVE_CONCEPTO,
       IMP_AFECTA_COSTO,
       CANT_FAC_ANT,
       IND_RESPONSABLE_VIATICO) ----**
    VALUES
      (V_NRO_ITEM,
       I_OPCION,
       I_CONCEPTO,
       I_OT,
       I_DCON_CUENTA,
       I_DCON_CANAL,
       I_DCON_DIV_CANAL,
       I_NRO_IMPORTACION,
       I_CANT,
       I_KM_ACTUAL,
       I_PREC_UNIT,
       I_OBS,
       I_IND_TIPO_IVA_COMPRA,
       I_PC_DCTO,
       I_IMPU_PORC_BASE_IMPONIBLE,
       I_IMPU_PORCENTAJE,
       I_TOTAL,
       I_EXENTO,
       I_GRAVADO,
       I_IVA,
       I_SESSION_ID,
       I_USUARIO,
       SYSDATE,
       I_TIMBRADO,
       I_DESC_LARGA,
       I_CONT_DESC,
       I_ART,
       I_DCON_CLAVE_IMP,
       V_CTA,
       V_CONCEPTO,
       I_IMP_AFECTA_COSTO,
       I_CANT_FAC_ANT,
       I_IND_VIATICO); ----*
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Error en PP_GUARDAR_COMI001_TMP' || SQLCODE ||
                              SQLERRM);
  END PP_GUARDAR_COMI001_TMP;

  PROCEDURE PP_VALIDAR_ENCABEZADO(I_DOCU_TIPO_MOV         IN NUMBER,
                                  I_DOCU_FEC_OPER         IN DATE,
                                  I_DOCU_NRO_DOC_FORMAT   IN VARCHAR2,
                                  I_DOCU_PROV             IN NUMBER,
                                  I_DOC_TIMBRADO          IN NUMBER,
                                  I_S_CTA_BCO             IN NUMBER,
                                  I_DOCU_MON              IN NUMBER,
                                  I_DOCU_DEP_ORIG         IN NUMBER,
                                  I_EMPRESA               IN NUMBER,
                                  I_USER                  IN VARCHAR2,
                                  I_DOCU_FEC_EMIS         IN DATE,
                                  I_CONF_PER_ACT_INI      IN DATE,
                                  I_CONF_PER_SGTE_FIN     IN DATE,
                                  I_CONF_MES_ACT          IN DATE,
                                  I_CONF_IND_INTEGRAR_PRD IN VARCHAR2,
                                  I_P_MON_US              IN NUMBER,
                                  I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                  I_ORDEN_COMPRA          IN VARCHAR2, --NUMBER,
                                  I_ORCOM_SUC             IN NUMBER,
                                  I_RETENCION_100         IN VARCHAR2,
                                  I_DOCU_EXEN_NETO_MON    IN NUMBER,
                                  I_DOCU_IVA_MON          IN NUMBER,
                                  I_TOT_DOC               IN NUMBER) IS
    V_NRO_ITEM NUMBER := 0;
    V_TEMPORAL NUMBER;
  BEGIN

    IF I_DOCU_TIPO_MOV IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Debe seleccionar un tipo de movimiento');
    END IF;

    IF I_DOCU_FEC_EMIS IS NULL THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe seleccionar la fecha de emision',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
    END IF;

    IF I_DOCU_NRO_DOC_FORMAT IS NULL THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Diligencie el numero del documento',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
    END IF;
    IF I_S_CTA_BCO IS NULL AND I_DOCU_TIPO_MOV != 2 THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe seleccionar un banco',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
    END IF;

    IF I_DOCU_MON IS NULL THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe seleccionar una moneda',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
    END IF;

    IF I_DOCU_IVA_MON < 0 THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'IVA no puede ser negativo!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
    END IF;
    IF I_TOT_DOC < 1 THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'El monto esta mal o falta darle click al boton calcular.',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
    END IF;

    BEGIN

      IF I_DOCU_FEC_EMIS NOT BETWEEN I_CONF_PER_ACT_INI AND
         I_CONF_PER_SGTE_FIN THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Fecha debe estar comprendida en el rango de: ' ||
                                                   TO_CHAR(I_CONF_PER_ACT_INI,
                                                           'DD/MM/YYYY') ||
                                                   ' a: ' ||
                                                   TO_CHAR(I_CONF_PER_SGTE_FIN,
                                                           'DD/MM/YYYY'),
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;

      IF I_DOCU_FEC_EMIS NOT BETWEEN I_CONF_MES_ACT AND
         LAST_DAY(I_CONF_MES_ACT) AND I_CONF_IND_INTEGRAR_PRD = 'S' THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Fecha debe estar comprendida en el rango de: ' ||
                                                   TO_CHAR(I_CONF_MES_ACT,
                                                           'DD/MM/YY') ||
                                                   ' a: ' ||
                                                   TO_CHAR(LAST_DAY(I_CONF_MES_ACT),
                                                           'DD/MM/YY'),
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;

      FACI039.PL_VALIDAR_HAB_MES_FIN(P_FECHA   => I_DOCU_FEC_EMIS,
                                     P_EMPRESA => I_EMPRESA,
                                     P_USUARIO => I_USER);

      IF I_CONF_IND_INTEGRAR_STK = 'S' THEN
        FACI039.PL_VALIDAR_HAB_MES_STK(P_FECHA   => I_DOCU_FEC_EMIS,
                                       P_EMPRESA => I_EMPRESA,
                                       P_USUARIO => I_USER);
      END IF;
      BEGIN
        V_TEMPORAL := GEN_COT_TIPO_MOV(p_empresa => I_empresa,
                            p_moneda => I_DOCU_MON,
                            p_tipo_mov => I_DOCU_TIPO_MOV,
                            p_fecha => TO_DATE(I_DOCU_FEC_EMIS,'DD/MM/YYYY'));
              /* FACI039.FP_COTIZACION(P_MONEDA      => I_P_MON_US,
                                            P_DOC_FEC_DOC => TO_DATE(I_DOCU_FEC_EMIS,
                                                                     'DD/MM/YYYY'),
                                            P_EMPRESA     => I_EMPRESA);*/
      EXCEPTION
        WHEN OTHERS THEN
          /*
          APEX_ERROR.ADD_ERROR(P_MESSAGE          => SQLERRM,
                               P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
                               */
          RAISE_APPLICATION_ERROR(-20003,
                                  'Error en PP_VALIDAR_ENCABEZADO' ||
                                  SQLCODE || '-' || SQLERRM);
      END;
    END;

    BEGIN
      IF I_DOCU_FEC_OPER < I_DOCU_FEC_EMIS THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'La fecha de operacion debe ser una fecha posterior a la del documento!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);

      END IF;

      IF I_DOCU_FEC_OPER NOT BETWEEN I_CONF_PER_ACT_INI AND
         I_CONF_PER_SGTE_FIN THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Fecha debe estar comprendida en el rango de: ' ||
                                                   TO_CHAR(I_CONF_PER_ACT_INI,
                                                           'DD/MM/YY') ||
                                                   ' a: ' ||
                                                   TO_CHAR(I_CONF_PER_SGTE_FIN,
                                                           'DD/MM/YY') ||
                                                   ', seg.sist.FIN!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;

      FACI039.PL_VALIDAR_HAB_MES_FIN(P_FECHA   => I_DOCU_FEC_OPER,
                                     P_EMPRESA => I_EMPRESA,
                                     P_USUARIO => I_USER);

      IF I_CONF_IND_INTEGRAR_STK = 'S' THEN
        FACI039.PL_VALIDAR_HAB_MES_STK(P_FECHA   => I_DOCU_FEC_OPER,
                                       P_EMPRESA => I_EMPRESA,
                                       P_USUARIO => I_USER);
      END IF;
    END;

    BEGIN
      IF I_DOCU_TIPO_MOV = 7 THEN
        --AUTOFACTURAS
        FACI039.PL_VAL_DOC_TIMBRADO(I_NRO_DOC   => I_DOCU_NRO_DOC_FORMAT,
                                    I_CLASE_DOC => 8,
                                    I_FECHA     => I_DOCU_FEC_EMIS,
                                    O_TIMBRADO  => V_TEMPORAL,
                                    I_EMPRESA   => I_EMPRESA);
      END IF;
    END;

    BEGIN

      IF I_ORDEN_COMPRA IS NOT NULL THEN
        IF I_ORCOM_SUC IS NULL THEN
          APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe ingresar sucursal de la Orden de Compra',
                               P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        ELSE
          --RAISE_APPLICATION_ERROR(-20010,I_ORDEN_COMPRA);
          SELECT COUNT(1)
            INTO V_TEMPORAL
            FROM STK_ORDEN_COMPRA OCOM, STK_DEPOSITO DEP, GEN_MONEDA MON
           WHERE OCOM.OCOM_EMPR = I_EMPRESA
             AND OCOM.OCOM_EMPR = MON.MON_EMPR
             AND OCOM.OCOM_NRO in
                 (SELECT REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA, ',', ':'),
                                       '[^:]+',
                                       1,
                                       LEVEL) ORDEN_COMPRA
                    FROM DUAL
                  CONNECT BY REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA, ',', ':'),
                                           '[^:]+',
                                           1,
                                           LEVEL) IS NOT NULL)
                ---= I_ORDEN_COMPRA--------------------lv 23/06/2020
             AND OCOM.OCOM_MON = MON.MON_CODIGO
             AND OCOM.OCOM_DEPOSITO = DEP.DEP_CODIGO(+)
             AND OCOM.OCOM_SUC = DEP.DEP_SUC(+)
             AND OCOM.OCOM_EMPR = DEP.DEP_EMPR(+)
             AND OCOM.OCOM_ESTADO IN ('P', 'C');
          IF V_TEMPORAL = 0 THEN
            APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No existe la Orden de compra o aun no ha sido Verificado',
                                 P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          END IF;
          DECLARE
            V_CANT_ART     NUMBER;
            V_ESTADO_ORDEN VARCHAR2(4);
          BEGIN
            SELECT COUNT(*)
              INTO V_CANT_ART
              FROM STK_ORDEN_COMPRA ORD, STK_ORDEN_COMPRA_DET ORDET
             WHERE ORD.OCOM_EMPR = I_EMPRESA
               AND ORD.OCOM_NRO in
                   (SELECT REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA, ',', ':'),
                                         '[^:]+',
                                         1,
                                         LEVEL) ORDEN_COMPRA
                      FROM DUAL
                    CONNECT BY REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA,
                                                     ',',
                                                     ':'),
                                             '[^:]+',
                                             1,
                                             LEVEL) IS NOT NULL)
                  --= I_ORDEN_COMPRA
               AND ORD.OCOM_EMPR = ORDET.OCOMD_EMPR
               AND ORD.OCOM_CLAVE = ORDET.OCOMD_CLAVE_OCOM
               AND ORDET.OCOMD_ART IS NOT NULL; -------------------lv 23/06/2020

            SELECT distinct wm_concat(ORD.OCOM_ESTADO)
              INTO V_ESTADO_ORDEN
              FROM STK_ORDEN_COMPRA ORD
             WHERE ORD.OCOM_EMPR = I_EMPRESA
               AND ORD.OCOM_NRO in
                   (SELECT REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA, ',', ':'),
                                         '[^:]+',
                                         1,
                                         LEVEL) ORDEN_COMPRA
                      FROM DUAL
                    CONNECT BY REGEXP_SUBSTR(REPLACE(I_ORDEN_COMPRA,
                                                     ',',
                                                     ':'),
                                             '[^:]+',
                                             1,
                                             LEVEL) IS NOT NULL);
            -- = I_ORDEN_COMPRA;

            /* IF V_CANT_ART > 0 AND V_ESTADO_ORDEN = 'P' THEN
              RAISE_APPLICATION_ERROR(-20003,
                                      'La orden contiene articulos y no se encuentra la entrada');
            END IF;*/ ----LV

          END;

        END IF;
      else
        null;-- 25/07/2022 8:44:25 @PabloACespedes \(^-^)/ NO USAR EN CAGRO, PEDIDO UGO SAWASKY
        
       /* IF GEN_DEVUELVE_USER NOT IN ('MAREK', 'YYEGROS') AND I_EMPRESA = 1 then
          
          --EXCEPCION SOLICITADA POR EL SE?OR BILLIE, 30-11-2018
          
          IF I_DOCU_TIPO_MOV <> 7 THEN
            IF I_DOCU_MON = 1 AND I_TOT_DOC > '1000000' THEN
              APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Es necesario una orden de compra para este documento',
                                   P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
            END IF;
            IF I_DOCU_MON = 2 AND I_TOT_DOC > '180' THEN
              APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Es necesario una orden de compra para este documento',
                                   P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
            END IF;
          END IF;
        END IF;*/
      END IF;

    END;
    BEGIN
      IF I_RETENCION_100 = 'S' AND I_DOCU_EXEN_NETO_MON = 0 THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'El monto exento debe ser mayor a 0(cero) para proveedores del exterior!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
    END;
    /* EXCEPTION
    WHEN OTHERS THEN
      INSERT INTO TABLE_M VALUES ('ERROR:', '', '');*/
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Error en PP_VALIDAR_ENCABEZADO' || SQLCODE ||
                              SQLERRM);

  END PP_VALIDAR_ENCABEZADO;

  PROCEDURE PP_FEC_PROX_VTO(I_IND_CHEQUE_DIF IN VARCHAR2,
                            I_DOCU_FEC_EMIS  IN DATE,
                            IO_FEC_PRIM_VTO  OUT DATE,
                            I_PLAZO_PAGO     IN NUMBER DEFAULT NULL,
                            I_EMPRESA        IN NUMBER DEFAULT NULL,
                            I_TIPO_MOV       IN NUMBER DEFAULT NULL) IS
  BEGIN

    --raise_application_error (-20001,I_PLAZO_PAGO);
    IF I_IND_CHEQUE_DIF <> 'S' THEN
      IO_FEC_PRIM_VTO := I_DOCU_FEC_EMIS;
      --:BCHEMIT_ENC.S_FEC_PRIM_VTO := TO_CHAR(:BDOC.DOCU_FEC_EMIS,'DD-MM-YYYY');
    ELSE
      IF I_EMPRESA = 1 AND I_TIPO_MOV = 2 THEN
        IF IO_FEC_PRIM_VTO IS NULL THEN
          --LIZ VILLA
          IF I_PLAZO_PAGO IS NOT NULL THEN
            BEGIN
              SELECT MAX(FECHA) --MIN(FECHA)
                INTO IO_FEC_PRIM_VTO
                FROM (SELECT TO_DATE(I_DOCU_FEC_EMIS) + ROWNUM FECHA,
                             TO_CHAR(TO_DATE(I_DOCU_FEC_EMIS) + ROWNUM,
                                     'DAY') AS DIA
                        FROM DUAL
                      CONNECT BY LEVEL <= (SELECT TRUNC(TO_DATE(I_DOCU_FEC_EMIS) +
                                                        I_PLAZO_PAGO -
                                                        TO_DATE(I_DOCU_FEC_EMIS))
                                             FROM DUAL))
               WHERE DIA LIKE '%VIERNES%'
               GROUP BY DIA;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                IO_FEC_PRIM_VTO := I_DOCU_FEC_EMIS + I_PLAZO_PAGO; --13/02/2021
            END;
          ELSE
            -- IO_FEC_PRIM_VTO := I_DOCU_FEC_EMIS + 30;
            SELECT MAX(FECHA) --MIN(FECHA)
              INTO IO_FEC_PRIM_VTO
              FROM (SELECT TO_DATE(I_DOCU_FEC_EMIS) + ROWNUM FECHA,
                           TO_CHAR(TO_DATE(I_DOCU_FEC_EMIS) + ROWNUM, 'DAY') AS DIA
                      FROM DUAL
                    CONNECT BY LEVEL <= (SELECT TRUNC(TO_DATE(I_DOCU_FEC_EMIS) + 30 -
                                                      TO_DATE(I_DOCU_FEC_EMIS))
                                           FROM DUAL))
             WHERE DIA LIKE '%VIERNES%'
             GROUP BY DIA;
          END IF;

        ELSE
          IO_FEC_PRIM_VTO := I_DOCU_FEC_EMIS + 30;
        END IF;
        --:BCHEMIT_ENC.S_FEC_PRIM_VTO := TO_CHAR(:BCHEMIT_ENC.FEC_PRIM_VTO,'DD-MM-YYYY');
        --IO_FEC_PRIM_VTO := I_DOCU_FEC_EMIS;
      END IF;
    END IF;
  exception
    when others then

      raise_application_error(-20001,
                              'Error en PP_FEC_PROX_VTO - ' || SQLCODE ||
                              ' -ERROR- ' || SQLERRM);

  END PP_FEC_PROX_VTO;

  PROCEDURE PP_VALIDAR_FEC_VTO(I_IND_CHEQUE_DIF IN VARCHAR2,
                               I_FEC_PRIM_VTO   IN DATE,
                               I_DOCU_FEC_EMIS  IN DATE) IS
    V_FECHA DATE;
  BEGIN
    --SI LA CUENTA BANCARIA NO ES DE CHEQUES DE PAGO DIFERIDO,
    --LA FECHA NO PUEDE SER DISTINTA A LA FECHA DEL DOCUMENTO.
    IF I_IND_CHEQUE_DIF = 'S' THEN
      IF I_FEC_PRIM_VTO IS NULL THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No puede ser nulo!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
      IF I_FEC_PRIM_VTO < I_DOCU_FEC_EMIS THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe ser mayor o igual a la fecha del documento: ' ||
                                                   TO_CHAR(I_DOCU_FEC_EMIS,
                                                           'DD-MM-YYYY'),
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
    ELSE
      IF I_FEC_PRIM_VTO IS NULL THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'No puede ser nulo!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
      IF I_FEC_PRIM_VTO <> I_DOCU_FEC_EMIS THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe ser igual a la fecha del documento: ' ||
                                                   TO_CHAR(I_DOCU_FEC_EMIS,
                                                           'DD-MM-YYYY'),
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
    END IF;
    V_FECHA := ADD_MONTHS(I_DOCU_FEC_EMIS, 48);
    /* IF :BCHEMIT.CH_EMIT_FEC_VTO1 > V_FECHA THEN
          APEX_ERROR.ADD_ERROR (P_MESSAGE          => 'Asegurese que la fecha de vencimiento del cheque es la correcta!.',
                                P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION );
    END IF;*/

  END PP_VALIDAR_FEC_VTO;

  PROCEDURE PP_ADICIONAR_CHEQUE(I_CUO_FEC_VTO  IN DATE,
                                I_CUO_IMP_MON  IN NUMBER,
                                I_SERIE        IN VARCHAR2,
                                I_NRO_CHEQUE   IN NUMBER,
                                I_BENEFICIARIO IN VARCHAR2,
                                I_BANCO        IN NUMBER) IS
  BEGIN
    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUE_COMI001') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'CHEQUE_COMI001');
    END IF;
    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'CHEQUE_COMI001',
                               P_C001            => I_SERIE,
                               P_C002            => I_BENEFICIARIO,
                               P_N001            => I_CUO_IMP_MON,
                               P_N002            => I_NRO_CHEQUE,
                               P_N003            => I_BANCO,
                               P_D001            => I_CUO_FEC_VTO);

  END PP_ADICIONAR_CHEQUE;

  PROCEDURE PP_CARGAR_CHEQUE(I_CTA_BCO_DIA  IN NUMBER,
                             I_EMPRESA      IN NUMBER,
                             I_CTA_BCO      IN NUMBER,
                             O_PROX_CH      OUT NUMBER,
                             O_CHEQUE_MENOR OUT NUMBER, --FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MENOR%TYPE,
                             O_CHEQUE_MAYOR OUT NUMBER) IS
    --FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MAYOR%TYPE) IS
    V_BANCO NUMBER;
  BEGIN

    IF I_CTA_BCO_DIA IS NULL THEN

      SELECT TO_CHAR(NVL(TO_NUMBER(CTA_ULT_NRO_CHEQUE), 0)) --, NVL(TO_NUMBER(CTA_NRO_CHEQUE_MENOR),1), NVL(TO_NUMBER(CTA_NRO_CHEQUE_MAYOR),9999999999999)--, CTA_BCO
        INTO O_PROX_CH --, O_CHEQUE_MENOR, O_CHEQUE_MAYOR--, V_BANCO
        FROM FIN_CUENTA_BANCARIA
       WHERE CTA_EMPR = I_EMPRESA
         AND CTA_CODIGO = I_CTA_BCO;
    ELSE
      SELECT TO_CHAR(NVL(TO_NUMBER(CTA_ULT_NRO_CHEQUE), 0)) --, NVL(TO_NUMBER(CTA_NRO_CHEQUE_MENOR),1), NVL(TO_NUMBER(CTA_NRO_CHEQUE_MAYOR),9999999999999)--, CTA_BCO
        INTO O_PROX_CH --, O_CHEQUE_MENOR, O_CHEQUE_MAYOR--, V_BANCO
        FROM FIN_CUENTA_BANCARIA
       WHERE CTA_EMPR = I_EMPRESA
         AND CTA_CODIGO = I_CTA_BCO_DIA;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002, 'Cuenta Inexistente!.');
  END PP_CARGAR_CHEQUE;

  PROCEDURE PP_GENERAR_CHEQUES(I_CANT_CHEQUES       IN NUMBER,
                               I_FEC_PRIM_VTO       IN DATE,
                               I_TIPO_VENCIMIENTO   IN VARCHAR2,
                               I_DIAS_ENTRE_CHEQUES IN NUMBER,
                               I_MON_DEC_IMP        IN NUMBER,
                               I_TOTAL_IMP          IN NUMBER,
                               I_BENEFICIARIO       IN VARCHAR2,
                               I_IND_CHEQUE_DIF     IN VARCHAR2,
                               I_CTA_BCO_DIA        IN NUMBER,
                               I_EMPRESA            IN NUMBER,
                               I_CTA_BCO            IN NUMBER,
                               I_PAGO_BANCO         IN VARCHAR2,
                               I_BANCO_CHEQUE       IN NUMBER) IS
  BEGIN
    --VALIDAR CANTIDAD DE CHEQUES SELECCIONADA
    IF NVL(I_CANT_CHEQUES, 0) < 1 THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe ingresar la cantidad de cheques que desea generar!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002,
                              'Debe ingresar la cantidad de cheques que desea generar!');
    END IF;
    --VALIDAR FECHA DEL PRIMER VENCIMIENTO
    IF I_FEC_PRIM_VTO IS NULL THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe ingresar la fecha del primer vencimiento!',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      RAISE_APPLICATION_ERROR(-20002,
                              'Debe ingresar la fecha del primer vencimiento!');
    END IF;
    --VALIDAR TIPO DE VENCIMIENTO
    IF I_CANT_CHEQUES > 1 THEN
      IF NVL(I_TIPO_VENCIMIENTO, ' ') NOT IN ('F', 'V') THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Tipo de vencimiento debe ser F=Fijo, V=Variable!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20002,
                                'Tipo de vencimiento debe ser F=Fijo, V=Variable!');
      END IF;
    END IF;
    --VALIDAR LOS DIAS ENTRE UNA CUOTA Y LA SIGUIENTE
    --SOLO SI S_TIPO_VENCIMIENTO = 'V' (VARIABLE)
    --Y SI LA CANTIDAD DE CHEQUES ES MAYOR QUE 1
    IF I_CANT_CHEQUES > 1 AND I_TIPO_VENCIMIENTO = 'V' THEN
      IF I_DIAS_ENTRE_CHEQUES IS NULL THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe ingresar los dias entre un cheques y el otro!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
      IF I_DIAS_ENTRE_CHEQUES <= 0 THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Los dias entre cheques debe ser un numero > que cero!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
    END IF;

    DECLARE
      V_FECHA            DATE := I_FEC_PRIM_VTO;
      V_CUO_IMP          NUMBER := ROUND(I_TOTAL_IMP / I_CANT_CHEQUES,
                                         I_MON_DEC_IMP);
      V_TOT_CUO_IMP      NUMBER := 0;
      V_CH_EMIT_SERIE    VARCHAR2(1);
      V_CH_EMIT_NRO      NUMBER;
      V_CH_EMIT_IMPORTE  NUMBER;
      V_EMIT_FEC_VTO1    DATE;
      V_CH_EMIT_FEC_VTO1 DATE;
      V_CHEQUE_MENOR     FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MENOR%TYPE;
      V_CHEQUE_MAYOR     FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MAYOR%TYPE;
      V_PROX_CH          NUMBER;
    BEGIN

      IF I_PAGO_BANCO <> 'S' THEN
        PP_CARGAR_CHEQUE(I_CTA_BCO_DIA  => I_CTA_BCO_DIA,
                         I_EMPRESA      => I_EMPRESA,
                         I_CTA_BCO      => I_CTA_BCO,
                         O_PROX_CH      => V_PROX_CH,
                         O_CHEQUE_MENOR => V_CHEQUE_MENOR,
                         O_CHEQUE_MAYOR => V_CHEQUE_MAYOR);
      END IF;

      FOR I IN 1 .. I_CANT_CHEQUES LOOP
        V_CH_EMIT_SERIE := 'A';
        V_CH_EMIT_NRO   := V_PROX_CH + I;

        V_CH_EMIT_IMPORTE  := V_CUO_IMP;
        V_EMIT_FEC_VTO1    := V_FECHA;
        V_CH_EMIT_FEC_VTO1 := TO_CHAR(V_FECHA, 'DD-MM-YYYY');
        --V_BENEFICIARIO :=  I_BENEFICIARIO;

        IF I_IND_CHEQUE_DIF = 'S' THEN
          IF I_TIPO_VENCIMIENTO = 'V' THEN
            IF I > 1 THEN
              V_FECHA := V_FECHA + I_DIAS_ENTRE_CHEQUES;
            END IF;
          ELSE
            V_FECHA := ADD_MONTHS(I_FEC_PRIM_VTO, I);
          END IF;
        ELSE
          V_FECHA := I_FEC_PRIM_VTO;
        END IF;
        V_TOT_CUO_IMP := V_TOT_CUO_IMP + V_CUO_IMP;
        IF I >= I_CANT_CHEQUES THEN
          --AJUSTAR LA DIFERENCIA POR REDONDEO A LA ULTIMA CUOTA;
          V_CH_EMIT_IMPORTE := V_CUO_IMP + (I_TOTAL_IMP - V_TOT_CUO_IMP);
        END IF;
        PP_ADICIONAR_CHEQUE(I_CUO_FEC_VTO  => V_FECHA,
                            I_CUO_IMP_MON  => V_CH_EMIT_IMPORTE,
                            I_SERIE        => V_CH_EMIT_SERIE,
                            I_NRO_CHEQUE   => V_CH_EMIT_NRO,
                            I_BENEFICIARIO => I_BENEFICIARIO,
                            I_BANCO        => I_BANCO_CHEQUE);
      END LOOP;

    END;
  END PP_GENERAR_CHEQUES;

  PROCEDURE PP_UPDATE_CHEQUES(I_CUO_FEC_VTO  IN DATE,
                              I_CUO_IMP_MON  IN NUMBER,
                              I_SERIE        IN VARCHAR2,
                              I_NRO_CHEQUE   IN NUMBER,
                              I_BENEFICIARIO IN VARCHAR2,
                              I_BANCO        IN NUMBER,
                              I_SEQ          IN NUMBER) IS

  BEGIN
    APEX_COLLECTION.UPDATE_MEMBER(P_COLLECTION_NAME => 'CHEQUE_COMI001',
                                  P_SEQ             => I_SEQ,
                                  P_C001            => I_SERIE,
                                  P_C002            => I_BENEFICIARIO,
                                  P_N001            => I_CUO_IMP_MON,
                                  P_N002            => I_NRO_CHEQUE,
                                  P_N003            => I_BANCO,
                                  P_D001            => I_CUO_FEC_VTO);
  END PP_UPDATE_CHEQUES;

  PROCEDURE PP_ADICIONAR_CUOTA(I_CUO_FEC_VTO IN DATE,
                               I_CUO_IMP_MON IN NUMBER) IS
  BEGIN
    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CUOTA_COMI001') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'CUOTA_COMI001');
    END IF;
    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'CUOTA_COMI001',
                               P_N001            => I_CUO_IMP_MON,
                               P_D001            => I_CUO_FEC_VTO);

  END PP_ADICIONAR_CUOTA;

  PROCEDURE PP_GENERAR_CUOTA(I_FEC_PRIM_VTO      IN DATE,
                             I_FEC_OPER          IN DATE,
                             I_TOTAL             IN NUMBER,
                             I_OP_CUOTA          IN VARCHAR2,
                             I_CANT_CUOTAS       IN NUMBER,
                             I_TIPO_VENCIMIENTO  IN VARCHAR2,
                             I_DIAS_ENTRE_CUOTAS IN NUMBER,
                             I_MON_DEC_IMP       IN NUMBER,
                             I_PLAZO_PAGO        IN VARCHAR2,
                             I_EMPRESA           IN NUMBER, ---LV
                             I_PROV_PLAZO        IN NUMBER,
                             I_FEC_EMI           IN DATE,
                             I_TIPO_MOV          IN NUMBER) IS
    L_VC_ARR2 APEX_APPLICATION_GLOBAL.VC_ARR2;
  BEGIN

    IF I_OP_CUOTA = 'CUOTA' THEN

      --VALIDAR CANTIDAD DE CUOTAS SELECCIONADA
      IF NVL(I_CANT_CUOTAS, 0) < 1 THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Debe ingresar la cantidad de cuotas que desea generar!');
      END IF;
      --VALIDAR FECHA DEL PRIMER VENCIMIENTO
      IF I_FEC_PRIM_VTO IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Debe ingresar la fecha del primer vencimiento!');
      END IF;
      --VALIDAR FECHA DEL PRIMER VENCIMIENTO, PARA QUE EL VENCIMIENTO DE LA CUOTA NO SEA MENOR A LA FECHA ACTUAL. 06/09/2019
      /*  IF I_FEC_PRIM_VTO < TO_DATE(SYSDATE, 'DD/MM/YYYY') THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'La fecha de vencimiento de la cuota, no puede ser menor a la fecha actual!');

      END IF;*/
      IF I_EMPRESA = 1 AND I_TIPO_MOV = 2 THEN
        --  RAISE_APPLICATION_ERROR(-20002,I_EMPRESA);
        IF I_PROV_PLAZO IS NOT NULL THEN
          IF I_FEC_PRIM_VTO > I_FEC_EMI + I_PROV_PLAZO THEN
            RAISE_APPLICATION_ERROR(-20002,
                                    'El vencimiento de la cuota, no puede ser mayor que al plazo de pago del proveedor');

          END IF;
        ELSE
          IF I_FEC_PRIM_VTO > I_FEC_EMI + 30 THEN
            RAISE_APPLICATION_ERROR(-20002,
                                    'El vencimiento de la cuota, no puede ser mayor que al plazo de pago del proveedor');

          END IF;

        END IF;
      END IF;

      --VALIDAR TIPO DE VENCIMIENTO
      IF I_CANT_CUOTAS > 1 THEN
        IF NVL(I_TIPO_VENCIMIENTO, ' ') NOT IN ('F', 'V') THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Tipo de vencimiento debe ser F=Fijo, V=Variable!');
        END IF;
      END IF;
      --VALIDAR LOS DIAS ENTRE UNA CUOTA Y LA SIGUIENTE
      --SOLO SI S_TIPO_VENCIMIENTO = 'V' (VARIABLE)
      --Y SI LA CANTIDAD DE CUOTAS ES MAYOR QUE 1
      IF I_CANT_CUOTAS > 1 AND I_TIPO_VENCIMIENTO = 'V' THEN
        IF I_DIAS_ENTRE_CUOTAS IS NULL THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Debe ingresar los dias entre una cuota y la otra!');
        END IF;
        IF I_DIAS_ENTRE_CUOTAS <= 0 THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Los dias entre cuotas debe ser un numero > que cero!');
        END IF;
      END IF;
      -- raise_application_error(-20001, I_FEC_PRIM_VTO||'-'||I_TOTAL||'-'||I_CANT_CUOTAS);
      DECLARE
        I             NUMBER;
        V_FECHA       DATE := I_FEC_PRIM_VTO;
        V_CUO_IMP     NUMBER := ROUND(I_TOTAL / I_CANT_CUOTAS,
                                      I_MON_DEC_IMP);
        V_TOT_CUO_IMP NUMBER := 0;
      BEGIN

        FOR I IN 1 .. I_CANT_CUOTAS LOOP
          IF I_TIPO_VENCIMIENTO = 'V' THEN
            V_FECHA := V_FECHA + I_DIAS_ENTRE_CUOTAS;
          ELSE
            -- V_FECHA := ADD_MONTHS(I_FEC_PRIM_VTO, I);
            V_FECHA := I_FEC_PRIM_VTO;
          END IF;
          V_TOT_CUO_IMP := V_TOT_CUO_IMP + V_CUO_IMP;
          IF I >= I_CANT_CUOTAS THEN
            --AJUSTAR LA DIFERENCIA POR REDONDEO A LA ULTIMA CUOTA;
            V_CUO_IMP := V_CUO_IMP + (I_TOTAL - V_TOT_CUO_IMP);
          END IF;
          PP_ADICIONAR_CUOTA(I_CUO_FEC_VTO => V_FECHA,
                             I_CUO_IMP_MON => V_CUO_IMP);
        END LOOP;

      END;
    ELSE
      IF I_EMPRESA = 1 AND I_TIPO_MOV = 2 THEN
        IF I_PROV_PLAZO IS NOT NULL THEN
          IF I_PLAZO_PAGO > I_PROV_PLAZO THEN
            RAISE_APPLICATION_ERROR(-20002,
                                    'El plazo no puede ser mayor el plazo de pago del proveedor, que es de :' ||
                                    I_PLAZO_PAGO || ' d?as');
          END IF;
        ELSE
          IF I_PLAZO_PAGO > 30 THEN
            RAISE_APPLICATION_ERROR(-20002,
                                    'El plazo no puede ser mayor que: 30 d?as');

          END IF;
        END IF;
      END IF;
      --DESGLOSA EL PLAZO
      L_VC_ARR2 := APEX_UTIL.STRING_TO_TABLE(P_STRING    => I_PLAZO_PAGO,
                                             P_SEPARATOR => '/');

      --GENERA LOS VENCIMIENTOS A PARTIR DE LA FECHA DE OPERACION
      --AL IR AL ULTIMO REGISTRO SE VA UNA MAS ABAJO
      --DE LO YA CARGADO, POR ESO LO BORRAMOS
      DECLARE
        V_FECHA       DATE := I_FEC_OPER;
        V_CUO_IMP     NUMBER := ROUND(I_TOTAL / L_VC_ARR2.COUNT,
                                      I_MON_DEC_IMP);
        V_TOT_CUO_IMP NUMBER := 0;

      BEGIN

        FOR Z IN 1 .. L_VC_ARR2.COUNT LOOP
          V_TOT_CUO_IMP := V_TOT_CUO_IMP + V_CUO_IMP;
          IF Z >= L_VC_ARR2.COUNT THEN
            V_CUO_IMP := V_CUO_IMP + (I_TOTAL - V_TOT_CUO_IMP);
          END IF;
          PP_ADICIONAR_CUOTA(I_CUO_FEC_VTO => V_FECHA + L_VC_ARR2(Z),
                             I_CUO_IMP_MON => V_CUO_IMP);
        END LOOP;

      END;
    END IF;
  END PP_GENERAR_CUOTA;
  PROCEDURE PP_BUSCAR_ORDEN_COMPRA_DET(I_OCOM_CLAVE    IN VARCHAR2, ---LV
                                       I_EMPRESA       IN NUMBER,
                                       I_DOCU_MON      IN NUMBER,
                                       I_USUARIO       IN VARCHAR2,
                                       I_TIMBRADO      IN NUMBER,
                                       I_MON_DEC_IMP   IN NUMBER,
                                       I_SESSION_ID    IN NUMBER,
                                       I_REC_NRO_ORDEN IN NUMBER,
                                       I_NRO_DOCUMENTO IN NUMBER) IS
    ---------------LV
    V_OBSER               VARCHAR2(500);
    V_TIPO                VARCHAR2(1);
    V_TOTAL               NUMBER := 0;
    V_BASE_IMP            NUMBER := 0;
    V_PORCE_IVA           NUMBER := 0;
    V_GRAVADA             NUMBER := 0;
    V_IVA                 NUMBER := 0;
    V_EXENTO              NUMBER := 0;
    V_ITEM                NUMBER := 0;
    V_CONCEPTO            NUMBER;
    V_CTACO               NUMBER;
    V_DCON_CUENTA         NUMBER;
    V_CONT_DESC           VARCHAR2(200);
    V_OT_ART              STK_ARTICULO.ART_COD_ALFANUMERICO%TYPE;
    V_CON_CLAVE           NUMBER;
    V_CLAVE_ORDEN_COMPRA  NUMBER;
    V_CANT_ENTRADA        NUMBER; --VARIABLE PARA RECALCULAR IMPORTES
    V_UNIT_EXENTO         NUMBER; --VARIABLE PARA RECALCULAR IMPORTES
    V_UNIT_GRAVADA        NUMBER; --VARIABLE PARA RECALCULAR IMPORTES
    V_UNIT_IVA            NUMBER; --VARIABLE PARA RECALCULAR IMPORTES
    V_IND_CAMBIAR_TOTALES VARCHAR2(2); --VARIABLE PARA RECALCULAR IMPORTES
    V_TOT_GRAV_10         NUMBER := 0; --VARIABLE PARA RECALCULAR IMPORTES
    V_TOT_GRAV_5          NUMBER := 0; --VARIABLE PARA RECALCULAR IMPORTES
    V_TOT_EXENTO          NUMBER := 0; --VARIABLE PARA RECALCULAR IMPORTES
    V_TOT_IVA             NUMBER := 0; --VARIABLE PARA RECALCULAR IMPORTES
    V_CANT                NUMBER := 0;
    V_PREC_UNIT           NUMBER := 0;
    V_CANT_ENTR_COUNT     NUMBER;

    V_REC_NRO_ORDEN NUMBER;

    /*Modificado por ODURE el parametro "PRC.CANAL OCOMD_CANAL" para que pueda aceptar los canales
    de la modificacion del  8-2-55 (orden de compras)
    */
    CURSOR V_ORDEN_COMP_DET IS
      SELECT OCOMD.OCOMD_CLAVE_OCOM,
             OCOMD.OCOMD_NRO_ITEM,
             OCOMD.OCOMD_ART,
             OCOMD.OCOMD_CANTIDAD,
             NVL(PRC.CANAL, OCOMD.OCOMD_CANAL_BETA) OCOMD_CANAL,--PRC.CANAL OCOMD_CANAL,--ODURE
             NULL OCOMD_DIV_CANAL,
             OCOMD.OCOMD_CLAVE_CONCEPTO,
             ART.ART_COD_ALFANUMERICO,
             ART.ART_UNID_MED,
             FCON.FCON_DESC,
             IMP.IMPU_PORCENTAJE,
             IMP.IMPU_PORC_BASE_IMPONIBLE,
             ROUND(OCOMD.OCOMD_EXEN_LOC * PORC / 100, I_MON_DEC_IMP) OCOMD_EXEN_LOC,
             ROUND(OCOMD.OCOMD_EXEN_MON * PORC / 100, I_MON_DEC_IMP) OCOMD_EXEN_MON,
             ROUND(OCOMD.OCOMD_GRAV_LOC * PORC / 100, I_MON_DEC_IMP) OCOMD_GRAV_LOC,
             ROUND(OCOMD.OCOMD_GRAV_MON * PORC / 100, I_MON_DEC_IMP) OCOMD_GRAV_MON,
             ROUND(OCOMD.OCOMD_IVA_LOC * PORC / 100, I_MON_DEC_IMP) OCOMD_IVA_LOC,
             ROUND(OCOMD.OCOMD_IVA_MON * PORC / 100, I_MON_DEC_IMP) OCOMD_IVA_MON,
             ROUND(OCOMD.OCOMD_BASE_IMP * PORC / 100, I_MON_DEC_IMP) OCOMD_BASE_IMP,
             OCOMD.OCOMD_TIMP,
             OCOMD.OCOMD_PORC_IVA,
             UPPER(OCOMD.OCOMD_OBS) OBS,
             ROUND(DECODE(OCOMD.OCOMD_PORC_IVA,
                          5,
                          DECODE(OCOMD.OCOMD_GRAV_LOC -
                                 SUM(SDD.DETA_IMP_NETO_LOC),
                                 '',
                                 OCOMD.OCOMD_GRAV_LOC,
                                 OCOMD.OCOMD_GRAV_LOC -
                                 SUM(SDD.DETA_IMP_NETO_LOC))) * PORC / 100,
                   I_MON_DEC_IMP) GRAV5,
             ROUND(DECODE(OCOMD.OCOMD_PORC_IVA,
                          10,
                          DECODE(OCOMD.OCOMD_GRAV_LOC -
                                 SUM(SDD.DETA_IMP_NETO_LOC),
                                 '',
                                 OCOMD.OCOMD_GRAV_LOC,
                                 OCOMD.OCOMD_GRAV_LOC -
                                 SUM(SDD.DETA_IMP_NETO_LOC))) * PORC / 100,
                   I_MON_DEC_IMP) GRAV10,
             ROUND(DECODE(OCOMD.OCOMD_PORC_IVA,
                          5,
                          DECODE(OCOMD.OCOMD_GRAV_MON -
                                 SUM(SDD.DETA_IMP_NETO_MON),
                                 '',
                                 OCOMD.OCOMD_GRAV_MON,
                                 OCOMD.OCOMD_GRAV_MON -
                                 SUM(SDD.DETA_IMP_NETO_MON))) * PORC / 100,
                   I_MON_DEC_IMP) GRAV_MON_5,
             ROUND(DECODE(OCOMD.OCOMD_PORC_IVA,
                          10,
                          DECODE(OCOMD.OCOMD_GRAV_MON -
                                 SUM(SDD.DETA_IMP_NETO_MON),
                                 '',
                                 OCOMD.OCOMD_GRAV_MON,
                                 OCOMD.OCOMD_GRAV_MON -
                                 SUM(SDD.DETA_IMP_NETO_MON))) * PORC / 100,
                   I_MON_DEC_IMP) GRAV_MON_10,
             OCOMD.OCOMD_CANTIDAD - NVL(SUM(SDD.DETA_CANT), 0) SALDO,
             STK_COMP_DOC_CONCEPTO(OCOMD.OCOMD_CLAVE_OCOM,
                                   OCOMD.OCOMD_NRO_ITEM,
                                   I_EMPRESA) NOCONCEPTO,
             PRC.PORC,
             OCOMD.OCOMD_KM_ACTUAL ---ESTE 02/01/2020
        FROM STK_ORDEN_COMPRA_DET OCOMD,
             STK_DOCUMENTO_DET    SDD,
             STK_ARTICULO         ART,
             GEN_IMPUESTO         IMP,
             FIN_CONCEPTO         FCON,
             COM_COMI001_OC       PRC,
             GEN_MONEDA           MN
       WHERE (OCOMD.OCOMD_CLAVE_OCOM = SDD.DETA_OCOMD_CLAVE(+) AND
             OCOMD.OCOMD_NRO_ITEM = SDD.DETA_OCOMD_NRO_ITEM(+) AND
             OCOMD.OCOMD_EMPR = SDD.DETA_EMPR(+))
         AND (OCOMD.OCOMD_CLAVE_OCOM = PRC.OCOMD_CLAVE_OCOM(+) AND
             OCOMD.OCOMD_NRO_ITEM = PRC.OCOMD_NRO_ITEM(+))
         AND OCOMD.OCOMD_CLAVE_OCOM IN
             (SELECT REGEXP_SUBSTR(REPLACE(I_OCOM_CLAVE, ',', ':'),
                                   '[^:]+',
                                   1,
                                   LEVEL) ORDEN_CLAVE
                FROM DUAL
              CONNECT BY REGEXP_SUBSTR(REPLACE(I_OCOM_CLAVE, ',', ':'),
                                       '[^:]+',
                                       1,
                                       LEVEL) IS NOT NULL) --= I_ORDEN_COMPRA
            --= I_OCOM_CLAVE            lv 23/06/2020
         AND OCOMD.OCOMD_EMPR = I_EMPRESA
         AND OCOMD.OCOMD_ART = ART.ART_CODIGO(+)
         AND OCOMD.OCOMD_EMPR = ART.ART_EMPR(+)
         AND ART.ART_IMPU = IMP.IMPU_CODIGO(+)
         AND ART.ART_EMPR = IMP.IMPU_EMPR(+)
         AND FCON.FCON_CLAVE(+) = OCOMD.OCOMD_CLAVE_CONCEPTO
         AND FCON.FCON_EMPR(+) = OCOMD.OCOMD_EMPR
         AND OCOMD.OCOMD_EMPR = MN.MON_EMPR
       GROUP BY OCOMD.OCOMD_ART,
                OCOMD.OCOMD_CANTIDAD,
                OCOMD.OCOMD_CLAVE_OCOM,
                OCOMD.OCOMD_NRO_ITEM,
                NVL(PRC.CANAL, OCOMD.OCOMD_CANAL_BETA),--PRC.CANAL,--ODURE
                PRC.PORC,
                OCOMD.OCOMD_CLAVE_CONCEPTO,
                ART.ART_COD_ALFANUMERICO,
                ART.ART_UNID_MED,
                IMP.IMPU_PORCENTAJE,
                FCON.FCON_DESC,
                IMP.IMPU_PORC_BASE_IMPONIBLE,
                OCOMD.OCOMD_EXEN_LOC,
                OCOMD.OCOMD_EXEN_MON,
                OCOMD.OCOMD_GRAV_LOC,
                OCOMD.OCOMD_GRAV_MON,
                OCOMD.OCOMD_IVA_LOC,
                OCOMD.OCOMD_IVA_MON,
                OCOMD.OCOMD_BASE_IMP,
                OCOMD.OCOMD_TIMP,
                OCOMD.OCOMD_PORC_IVA,
                OCOMD.OCOMD_OBS,
                OCOMD.OCOMD_KM_ACTUAL ---- ESTE 02/01/2020
       ORDER BY OCOMD.OCOMD_NRO_ITEM, NVL(PRC.CANAL, OCOMD.OCOMD_CANAL_BETA);--PRC.CANAL; --ODURE

  BEGIN
    FOR REG IN V_ORDEN_COMP_DET LOOP
      V_CANT_ENTR_COUNT := NULL; --
      IF REG.OCOMD_ART IS NOT NULL THEN
        BEGIN

          SELECT SUM(E.ENTMERDET_CANT)
            INTO V_CANT_ENTR_COUNT
            FROM STK_ENTRADA_MERC_DET E
           WHERE ENTMERDET_ORDEN = REG.OCOMD_CLAVE_OCOM
             AND ENTMERDET_ITEM = REG.OCOMD_NRO_ITEM
             AND ENTMERDET_EMPR = I_EMPRESA;
          --   RAISE_APPLICATION_ERROR(-20001,'PASA POR AQUI');

        EXCEPTION
          WHEN OTHERS THEN
            V_CANT_ENTR_COUNT := NULL;
        END;
      END IF;

      IF V_CANT_ENTR_COUNT > 0 OR V_CANT_ENTR_COUNT IS NULL THEN
        -- CREATE_RECORD;
        V_ITEM := V_ITEM + 1;
        --:BDET.DETA_NRO_ITEM                             := TO_NUMBER(:SYSTEM.CURSOR_RECORD);
        IF NVL(I_DOCU_MON, '') = 1 THEN
          V_EXENTO  := REG.OCOMD_EXEN_LOC;
          V_GRAVADA := REG.OCOMD_GRAV_LOC;
          V_IVA     := REG.OCOMD_IVA_LOC;
        ELSE
          V_EXENTO  := REG.OCOMD_EXEN_MON;
          V_GRAVADA := REG.OCOMD_GRAV_MON;
          V_IVA     := REG.OCOMD_IVA_MON;
        END IF;

        V_TOTAL := V_EXENTO + V_GRAVADA + V_IVA;

        IF REG.OCOMD_CLAVE_CONCEPTO IS NOT NULL THEN

          BEGIN
            SELECT FCON_CODIGO, FCON_CLAVE_CTACO, FCON_CLAVE
              INTO V_CONCEPTO, V_CTACO, V_CON_CLAVE
              FROM FIN_CONCEPTO T
             WHERE FCON_CLAVE = REG.OCOMD_CLAVE_CONCEPTO
               AND FCON_EMPR = I_EMPRESA;
          EXCEPTION
            WHEN OTHERS THEN
              raise_application_error(-20001,
                                      'No se ha encontrado ning?n concepto. Verifique el detalle de la orden ' ||
                                      SQLCODE || ' -ERROR- ' || SQLERRM);
          END;

          PP_TRAER_CUENTA_CONTABLE(I_EMPRESA     => I_EMPRESA,
                                   I_CONCEPTO    => V_CONCEPTO,
                                   I_CLAVE_CTACO => V_CTACO,
                                   O_DCON_CUENTA => V_DCON_CUENTA,
                                   O_CONT_DESC   => V_CONT_DESC);

          INSERT INTO COMI001_DET_TMP
            (NRO_ITEM,
             OPCION,
             CONCEPTO,
             OT,
             DCON_CUENTA,
             DCON_CANAL,
             DCON_DIV_CANAL,
             NRO_IMPORTACION,
             CANT,
             KM_ACTUAL,
             PREC_UNIT,
             OBS,
             IND_TIPO_IVA_COMPRA,
             PC_DCTO,
             IMPU_PORC_BASE_IMPONIBLE,
             IMPU_PORCENTAJE,
             TOTAL,
             EXENTO,
             GRAVADO,
             IVA,
             SESSION_ID,
             USUARIO,
             FECHA,
             TIMBRADO,
             DESC_LARGA,
             CONT_DESC,
             ART,
             CLAVE_CTACO,
             CLAVE_CONCEPTO,
             OCOMD_NRO_ITEM,
             PORC_ORDEN_COM,
             ORDEN_COMP_CLAVE,
             ORDEN_COMP_ITEM)
          VALUES
            (V_ITEM,
             'G',
             V_CONCEPTO,
             NULL,
             V_DCON_CUENTA,
             REG.OCOMD_CANAL,
             REG.OCOMD_DIV_CANAL,
             NULL,
             REG.OCOMD_CANTIDAD, --1,
             REG.OCOMD_KM_ACTUAL, --NULL,02/01/2020
             NULL,
             REG.OBS,
             1,
             0,
             REG.IMPU_PORC_BASE_IMPONIBLE,
             REG.OCOMD_PORC_IVA,
             V_TOTAL,
             V_EXENTO,
             V_GRAVADA,
             V_IVA,
             I_SESSION_ID,
             I_USUARIO,
             SYSDATE,
             I_TIMBRADO,
             NULL,
             REG.FCON_DESC,
             NULL,
             V_CTACO,
             V_CON_CLAVE,
             REG.OCOMD_NRO_ITEM,
             REG.PORC,
             REG.OCOMD_CLAVE_OCOM,
             REG.OCOMD_NRO_ITEM);

        ELSE

          V_CANT_ENTRADA := 0;
          V_PREC_UNIT    := V_TOTAL / REG.OCOMD_CANTIDAD;
          --- RAISE_APPLICATION_ERROR(-20001,I_REC_NRO_ORDEN);
          -- RAISE_APPLICATION_ERROR(-20001,REG.OCOMD_NRO_ITEM);
          BEGIN

            ------------------------------------------------lv 23/06/2020
            SELECT T.ENTMER_NUM_ENTR
              INTO V_REC_NRO_ORDEN
              FROM STK_ENTRADA_MERC T
             WHERE T.ENTMER_CLAVE_ORDEN = REG.OCOMD_CLAVE_OCOM
               AND T.ENTMER_NUM_DOC_FIN = I_NRO_DOCUMENTO
               AND T.ENTMER_EMPR = I_EMPRESA;

            SELECT SUM(E.ENTMERDET_CANT)
              INTO V_CANT_ENTRADA
              FROM STK_ENTRADA_MERC_DET E
             WHERE ENTMERDET_ORDEN = REG.OCOMD_CLAVE_OCOM
               AND ENTMERDET_ITEM = REG.OCOMD_NRO_ITEM
               AND E.ENTMERDET_NUM = V_REC_NRO_ORDEN
               AND ENTMERDET_EMPR = I_EMPRESA;

          EXCEPTION
            WHEN OTHERS THEN
              V_CANT_ENTRADA := 0;
          END;

          SELECT ART_CODIGO
            INTO V_OT_ART
            FROM STK_ARTICULO T
           WHERE ART_CODIGO = REG.OCOMD_ART
             AND ART_EMPR = I_EMPRESA;

          IF V_CANT_ENTRADA > 0 THEN
            V_IND_CAMBIAR_TOTALES := 'S';

            V_CANT := V_CANT_ENTRADA;

            IF REG.OCOMD_PORC_IVA = 10 THEN
              --SI ES IVA 10
              V_UNIT_IVA     := ROUND((V_PREC_UNIT * V_CANT_ENTRADA) / 11,
                                      I_MON_DEC_IMP);
              V_UNIT_GRAVADA := (V_PREC_UNIT * V_CANT_ENTRADA) - V_UNIT_IVA;
              V_UNIT_EXENTO  := 0;
            ELSIF REG.OCOMD_PORC_IVA = 5 THEN
              --SI ES IVA 5
              V_UNIT_IVA     := ROUND((V_PREC_UNIT * V_CANT_ENTRADA) / 21,
                                      I_MON_DEC_IMP);
              V_UNIT_GRAVADA := (V_PREC_UNIT * V_CANT_ENTRADA) - V_UNIT_IVA;
              V_UNIT_EXENTO  := 0;
            ELSIF REG.OCOMD_PORC_IVA = 0 THEN
              --EXENTO
              V_UNIT_EXENTO  := (V_PREC_UNIT * V_CANT_ENTRADA);
              V_UNIT_IVA     := 0;
              V_UNIT_GRAVADA := 0;

            END IF;

            V_IVA     := V_UNIT_IVA;
            V_GRAVADA := V_UNIT_GRAVADA;
            V_TOTAL   := V_PREC_UNIT * V_CANT_ENTRADA;
            V_EXENTO  := V_UNIT_EXENTO;

            INSERT INTO COMI001_DET_TMP
              (NRO_ITEM,
               OPCION,
               CONCEPTO,
               OT,
               DCON_CUENTA,
               DCON_CANAL,
               DCON_DIV_CANAL,
               NRO_IMPORTACION,
               CANT,
               KM_ACTUAL,
               PREC_UNIT,
               OBS,
               IND_TIPO_IVA_COMPRA,
               PC_DCTO,
               IMPU_PORC_BASE_IMPONIBLE,
               IMPU_PORCENTAJE,
               TOTAL,
               EXENTO,
               GRAVADO,
               IVA,
               SESSION_ID,
               USUARIO,
               FECHA,
               TIMBRADO,
               DESC_LARGA,
               CONT_DESC,
               ART,
               ORDEN_COMP_CLAVE,
               ORDEN_COMP_ITEM)
            VALUES
              (V_ITEM,
               'M',
               V_CONCEPTO,
               NULL,
               V_DCON_CUENTA,
               REG.OCOMD_CANAL,
               REG.OCOMD_DIV_CANAL,
               NULL,
               V_CANT,
               REG.OCOMD_KM_ACTUAL, ---02/01/2020  NULL,
               V_PREC_UNIT,
               REG.OBS,
               1,
               NULL,
               REG.IMPU_PORC_BASE_IMPONIBLE,
               REG.OCOMD_PORC_IVA,
               V_TOTAL,
               V_EXENTO,
               V_GRAVADA,
               V_IVA,
               I_SESSION_ID,
               I_USUARIO,
               SYSDATE,
               I_TIMBRADO,
               NULL,
               REG.FCON_DESC,
               V_OT_ART,
               REG.OCOMD_CLAVE_OCOM,
               REG.OCOMD_NRO_ITEM);
          ELSE
            NULL;
          END IF;

        END IF;
      END IF;
    END LOOP;
    --FIRST_RECORD;
    --GO_BLOCK('BPIE');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'Error en PP_BUSCAR_ORDEN_COMPRA_DET' ||
                              SQLCODE || SQLERRM);
  END PP_BUSCAR_ORDEN_COMPRA_DET;

  PROCEDURE PP_VALIDAR_IMPORTES(I_APP_SESSION        IN NUMBER,
                                I_USUARIO            IN VARCHAR2,
                                I_TIMBRADO           IN NUMBER,
                                I_DOCU_EXEN_NETO_MON IN NUMBER,
                                I_DOCU_GRAV_NETO_MON IN NUMBER,
                                I_DOCU_IVA_MON       IN NUMBER,
                                I_DOCU_IVA_LOC       IN NUMBER) IS
    V_TOT_EXENTO  NUMBER := 0;
    V_TOT_GRAVADO NUMBER := 0;
    V_TOT_IVA     NUMBER := 0;
    V_TOT_TOTAL   NUMBER := 0;
  BEGIN

   IF V('P_EMPRESA') = 1 THEN
    SELECT ROUND(SUM(TOTAL), nvl(getItem('P1313__MON_DEC_AUX'), 2)),
           ROUND(SUM(EXENTO), nvl(getItem('P1313__MON_DEC_AUX'), 2)),
           ROUND(SUM(GRAVADO), nvl(getItem('P1313__MON_DEC_AUX'), 2)),
          ROUND( SUM(IVA), nvl(getItem('P1313__MON_DEC_AUX'), 2))
      INTO V_TOT_TOTAL, V_TOT_EXENTO, V_TOT_GRAVADO, V_TOT_IVA
      FROM COMI001_DET_TMP
     WHERE SESSION_ID = I_APP_SESSION
       AND USUARIO = I_USUARIO
       AND TRUNC(FECHA) = TRUNC(SYSDATE)
       AND TIMBRADO = I_TIMBRADO;

       ELSE
        SELECT ROUND(SUM(TOTAL), nvl(getItem('P1313__MON_DEC_AUX'),4)),
           ROUND(SUM(EXENTO), nvl(getItem('P1313__MON_DEC_AUX'), 4)),
           ROUND(SUM(GRAVADO), nvl(getItem('P1313__MON_DEC_AUX'), 4)),
          ROUND( SUM(IVA), nvl(getItem('P1313__MON_DEC_AUX'), 4))
      INTO V_TOT_TOTAL, V_TOT_EXENTO, V_TOT_GRAVADO, V_TOT_IVA
      FROM COMI001_DET_TMP
     WHERE SESSION_ID = I_APP_SESSION
       AND USUARIO = I_USUARIO
       AND TRUNC(FECHA) = TRUNC(SYSDATE)
       AND TIMBRADO = I_TIMBRADO;
END IF;
    IF I_DOCU_EXEN_NETO_MON IS NOT NULL AND
       V_TOT_EXENTO <> I_DOCU_EXEN_NETO_MON THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Diferencia entre total exento y detalle por: ' ||
                              TO_CHAR(I_DOCU_EXEN_NETO_MON - V_TOT_EXENTO));
    END IF;

    IF I_DOCU_GRAV_NETO_MON IS NOT NULL AND
       V_TOT_GRAVADO <> I_DOCU_GRAV_NETO_MON THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Diferencia entre total gravado y detalle por: ' ||
                              TO_CHAR(I_DOCU_GRAV_NETO_MON - V_TOT_GRAVADO));

    END IF;

    IF I_DOCU_IVA_MON IS NOT NULL AND V_TOT_IVA <> I_DOCU_IVA_MON THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Diferencia entre total IVA y detalle por: ' ||
                              TO_CHAR(I_DOCU_IVA_MON - V_TOT_IVA));
    END IF;

    --EL SIGUIENTE IF SE DA CUANDO INGRESA UN IMPORTE POSITIVO EN
    --GRAVADO MON, DEJA EN 0 IVA MON, NAVEGA POR LOS IMPORTES LOC
    --Y CUANDO PASA POR GRAVADO LOC SE LE ASIGNA UN IMPORTE A IVA LOC,
    --POR LO TANTO IVA MON=0 E IVA LOC<>0 Y ESO NO PUEDE SER

    IF (NVL(I_DOCU_IVA_MON, 0) > 0 AND NVL(I_DOCU_IVA_LOC, 0) <= 0) OR
       (NVL(I_DOCU_IVA_MON, 0) <= 0 AND NVL(I_DOCU_IVA_LOC, 0) > 0) THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'IVA incorrecto entre ImporteMoneda e ImporteLocal!');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'PP_VALIDAR_IMPORTES' || SQLCODE || SQLERRM);
  END PP_VALIDAR_IMPORTES;

  PROCEDURE PP_VALIDAR_OT_REPETIDA(I_APP_SESSION IN NUMBER,
                                   I_USUARIO     IN VARCHAR2,
                                   I_TIMBRADO    IN NUMBER) IS
    V_OT       NUMBER;
    V_REGISTRO INTEGER;
  BEGIN

    SELECT COUNT(1), OT
      INTO V_REGISTRO, V_OT
      FROM COMI001_DET_TMP
     WHERE SESSION_ID = I_APP_SESSION
       AND USUARIO = I_USUARIO
       AND TRUNC(FECHA) = TRUNC(SYSDATE)
       AND TIMBRADO = I_TIMBRADO
       AND OPCION = 'O'
     GROUP BY OT
    HAVING COUNT(1) > 1;

    IF V_REGISTRO > 0 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Existen ordenes de trabajo  identicas. Las ordenes de trabajo no pueden repetirse');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END PP_VALIDAR_OT_REPETIDA;

  PROCEDURE PP_VALIDAR_TOTAL_CUOTAS(I_DOCU_TIPO_MOV      IN NUMBER,
                                    I_CONF_FACT_CR_REC   IN NUMBER,
                                    I_CONF_NOTA_CR_REC   IN NUMBER,
                                    I_S_CREDITO          IN VARCHAR2,
                                    I_DOCU_EXEN_NETO_MON IN NUMBER,
                                    I_DOCU_GRAV_NETO_MON IN NUMBER,
                                    I_DOCU_IVA_MON       IN NUMBER) IS
    V_TOT_CUOTA     NUMBER := 0;
    V_TOT_DOCUMENTO NUMBER;
  BEGIN
    V_TOT_DOCUMENTO := I_DOCU_EXEN_NETO_MON + I_DOCU_GRAV_NETO_MON +
                       I_DOCU_IVA_MON;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CUOTA_COMI001') THEN
      IF (I_DOCU_TIPO_MOV = I_CONF_FACT_CR_REC OR
         (I_DOCU_TIPO_MOV = I_CONF_NOTA_CR_REC AND I_S_CREDITO = 'S')) THEN
        SELECT SUM(N001)
          INTO V_TOT_CUOTA
          FROM APEX_COLLECTIONS
         WHERE COLLECTION_NAME = 'CUOTA_COMI001';

        IF V_TOT_CUOTA <> V_TOT_DOCUMENTO THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'La suma de las cuotas debe ser igual ' ||
                                  'al total : ' || TO_CHAR(V_TOT_DOCUMENTO));
        END IF;
      END IF;
    ELSE
      RAISE_APPLICATION_ERROR(-20002,
                              'La suma de las cuotas debe ser igual ' ||
                              'al total : ' || TO_CHAR(V_TOT_DOCUMENTO));
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'PP_VALIDAR_TOTAL_CUOTAS' || SQLCODE ||
                              SQLERRM);
  END PP_VALIDAR_TOTAL_CUOTAS;

  PROCEDURE PP_VALIDAR_INTEGRACION(I_CONF_IND_INTEGRAR_PRD IN VARCHAR2,
                                   I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                   I_CONF_IND_INTEGRAR_ACT IN VARCHAR2,
                                   I_DOCU_DEP_ORIG         IN NUMBER,
                                   I_DOC_SERIE             IN VARCHAR2,
                                   I_APP_SESSION           IN NUMBER,
                                   I_USUARIO               IN VARCHAR2,
                                   I_TIMBRADO              IN NUMBER) IS
    CURSOR CU_DETALLE IS
      SELECT OPCION
        FROM COMI001_DET_TMP
       WHERE SESSION_ID = I_APP_SESSION
         AND USUARIO = I_USUARIO
         AND TRUNC(FECHA) = TRUNC(SYSDATE)
         AND TIMBRADO = I_TIMBRADO;
  BEGIN

    FOR REG IN CU_DETALLE LOOP
      IF REG.OPCION = 'O' AND I_CONF_IND_INTEGRAR_PRD = 'N' THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'No puede haber servicios para produccion, porque el sistema de compras no esta habilitado para actualizar produccion!');
      END IF;

      IF REG.OPCION = 'M' THEN
        IF I_CONF_IND_INTEGRAR_STK = 'N' THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'No puede haber mercaderias, porque el sistema de compras no esta habilitado para actualizar stock!');
        END IF;
        IF I_DOCU_DEP_ORIG IS NULL THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Para ingresar articulos de stock, el deposito no puede quedar en blanco!.');
        END IF;
      END IF;

      IF REG.OPCION = 'A' THEN
        IF I_CONF_IND_INTEGRAR_ACT = 'N' THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'No puede haber bienes de uso, porque el sistema de compras no esta habilitado para actualizar activo fijo!');
        END IF;
        IF I_DOC_SERIE IS NULL THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Para ingresar articulos de activo fijo, la serie del comprobante no puede quedar en blanco!.');
        END IF;
      END IF;

    END LOOP;
  END PP_VALIDAR_INTEGRACION;

  PROCEDURE PP_ESTABL_VARIABLES_BDET(I_TASA               IN NUMBER,
                                     I_CANT_DECIMALES_LOC IN NUMBER,
                                     I_TIMBRADO           IN NUMBER,
                                     I_USUARIO            IN VARCHAR2,
                                     I_APP_SESSION        IN NUMBER,
                                     I_DOCU_IVA_LOC       IN NUMBER,
                                     I_DOCU_EXEN_NETO_LOC IN NUMBER,
                                     I_DOCU_GRAV_NETO_LOC IN NUMBER) IS
    V_IMP_NETO_LOC_EXEN     NUMBER := 0;
    V_IMP_NETO_LOC_GRAV     NUMBER := 0;
    V_TOT_IMP_NETO_LOC_EXEN NUMBER := 0;
    V_TOT_IMP_NETO_LOC_GRAV NUMBER := 0;
    V_TOT_IVA_LOC           NUMBER := 0;
    V_DIF_IMP_NETO_LOC_EXEN NUMBER := 0;
    V_DIF_IMP_NETO_LOC_GRAV NUMBER := 0;
    V_DIF_IVA_LOC           NUMBER := 0;
    BDET_DETA_IMP_NETO_MON  NUMBER;
    BDET_S_GRAVADO_LOC      NUMBER;
    BDET_S_GRAVADO_10_LOC   NUMBER;
    BDET_S_GRAVADO_5_LOC    NUMBER;
    BDET_DETA_IMP_NETO_LOC  NUMBER;
    BDET_DETA_IMPU          VARCHAR2(1);
    BDET_DETA_IVA_MON       NUMBER;
    BDET_DETA_IVA_LOC       NUMBER;
    BDET_IVA_5_LOC          NUMBER;
    BDET_IVA_10_LOC         NUMBER;

    CURSOR CU_DETALLE IS
      SELECT NRO_ITEM,
             OPCION,
             CONCEPTO,
             OT,
             DCON_CUENTA,
             DCON_CANAL,
             DCON_DIV_CANAL,
             NRO_IMPORTACION,
             CANT,
             KM_ACTUAL,
             PREC_UNIT,
             OBS,
             IND_TIPO_IVA_COMPRA,
             PC_DCTO,
             IMPU_PORC_BASE_IMPONIBLE,
             IMPU_PORCENTAJE,
             TOTAL,
             EXENTO,
             GRAVADO,
             IVA,
             SESSION_ID,
             USUARIO,
             FECHA,
             DESC_LARGA,
             CONT_DESC,
             ART,
             TIMBRADO,
             OT_MON,
             OT_MON_COT,
             OT_MON_SIM,
             OT_CLAVE,
             DCON_CLAVE_IMP,
             OCOM_CLAVE,
             OCOMD_NRO_ITEM,
             DETA_IMP_NETO_LOC,
             DETA_IMP_NETO_MON,
             DETA_IMPU,
             DETA_IVA_LOC,
             DETA_IVA_MON,
             IVA_10_LOC,
             IVA_5_LOC,
             ROWID
        FROM COMI001_DET_TMP
       WHERE SESSION_ID = I_APP_SESSION
         AND USUARIO = I_USUARIO
         AND TRUNC(FECHA) = TRUNC(SYSDATE)
         AND TIMBRADO = I_TIMBRADO;
  BEGIN

    FOR REG IN CU_DETALLE LOOP
      --:BDET.DETA_EMPR := :PARAMETER.P_EMPRESA;
      --:BDET.DETA_IMP_NETO_MON
      BDET_DETA_IMP_NETO_MON := (REG.EXENTO + REG.GRAVADO);

      V_IMP_NETO_LOC_EXEN := ROUND((REG.EXENTO * I_TASA),
                                   I_CANT_DECIMALES_LOC);
      V_IMP_NETO_LOC_GRAV := ROUND((REG.GRAVADO * I_TASA),
                                   I_CANT_DECIMALES_LOC);

      BDET_S_GRAVADO_LOC := V_IMP_NETO_LOC_GRAV;

      IF REG.IMPU_PORCENTAJE = 10 THEN
        BDET_S_GRAVADO_10_LOC := V_IMP_NETO_LOC_GRAV;
      ELSIF REG.IMPU_PORCENTAJE = 5 THEN
        BDET_S_GRAVADO_5_LOC := V_IMP_NETO_LOC_GRAV;
      END IF;

      --:BDET.DETA_IMP_NETO_LOC
      BDET_DETA_IMP_NETO_LOC := V_IMP_NETO_LOC_EXEN + V_IMP_NETO_LOC_GRAV;

      IF REG.EXENTO > 0 THEN
        V_TOT_IMP_NETO_LOC_EXEN := V_TOT_IMP_NETO_LOC_EXEN +
                                   V_IMP_NETO_LOC_EXEN;
      END IF;

      IF REG.GRAVADO > 0 THEN
        V_TOT_IMP_NETO_LOC_GRAV := V_TOT_IMP_NETO_LOC_GRAV +
                                   V_IMP_NETO_LOC_GRAV;
      END IF;
      --:BDET.DETA_IMPU
      IF REG.GRAVADO > 0 THEN
        BDET_DETA_IMPU := 'S';
      ELSE
        BDET_DETA_IMPU := 'N';
      END IF;

      IF REG.IVA > 0 THEN
        BDET_DETA_IVA_MON := REG.IVA;
        BDET_DETA_IVA_LOC := ROUND((REG.IVA * I_TASA), I_CANT_DECIMALES_LOC);
      ELSE
        BDET_DETA_IVA_MON := 0;
        BDET_DETA_IVA_LOC := 0;
      END IF;

      IF REG.IMPU_PORCENTAJE = 10 THEN
        BDET_IVA_10_LOC := BDET_DETA_IVA_LOC;
      ELSIF REG.IMPU_PORCENTAJE = 5 THEN
        BDET_IVA_5_LOC := BDET_DETA_IVA_LOC;
      END IF;

      V_TOT_IVA_LOC := V_TOT_IVA_LOC + BDET_DETA_IVA_LOC;

      UPDATE COMI001_DET_TMP
         SET DETA_IMP_NETO_LOC = BDET_DETA_IMP_NETO_LOC,
             DETA_IMP_NETO_MON = BDET_DETA_IMP_NETO_MON,
             DETA_IMPU         = BDET_DETA_IMPU,
             DETA_IVA_LOC      = BDET_DETA_IVA_LOC,
             DETA_IVA_MON      = BDET_DETA_IVA_MON,
             IVA_10_LOC        = BDET_IVA_10_LOC,
             IVA_5_LOC         = BDET_IVA_5_LOC
       WHERE ROWID = REG.ROWID;
    END LOOP;

    -- HALLAR LA DIFERENCIA DE IVA LOCAL ENTRE ENCABEZADO Y DETALLE
    V_DIF_IVA_LOC := (I_DOCU_IVA_LOC - V_TOT_IVA_LOC);

    -- HALLAR LA DIFERENCIA DE EXENTO LOCAL ENTRE ENCAB. Y DETALLE
    V_DIF_IMP_NETO_LOC_EXEN := I_DOCU_EXEN_NETO_LOC -
                               V_TOT_IMP_NETO_LOC_EXEN;

    --HALLAR LA DIFERENCIA DE GRAVADO LOCAL ENTRE ENCAB. Y DETALLE
    V_DIF_IMP_NETO_LOC_GRAV := I_DOCU_GRAV_NETO_LOC -
                               V_TOT_IMP_NETO_LOC_GRAV;

    -- SI HAY DIFERENCIA ENTONCES ASIGNAR LA DIFERENCIA AL PRIMER
    --    DETALLE QUE CUMPLE CON LA CONDICION.
    IF V_DIF_IVA_LOC <> 0 OR V_DIF_IMP_NETO_LOC_EXEN <> 0 OR
       V_DIF_IMP_NETO_LOC_GRAV <> 0 THEN
      BDET_DETA_IMP_NETO_LOC := 0;
      BDET_S_GRAVADO_10_LOC  := 0;
      BDET_S_GRAVADO_5_LOC   := 0;
      BDET_DETA_IVA_LOC      := 0;
      FOR REG IN CU_DETALLE LOOP
        IF REG.EXENTO > 0 AND V_DIF_IMP_NETO_LOC_EXEN <> 0 THEN
          BDET_DETA_IMP_NETO_LOC  := BDET_DETA_IMP_NETO_LOC +
                                     V_DIF_IMP_NETO_LOC_EXEN;
          V_DIF_IMP_NETO_LOC_EXEN := 0; -- PARA QUE LA DIF. SE AJUSTE SOLO EN EL 1ER.REG.CON IMP.EXENTO
        END IF;

        IF REG.GRAVADO > 0 AND V_DIF_IMP_NETO_LOC_GRAV <> 0 THEN
          BDET_DETA_IMP_NETO_LOC  := BDET_DETA_IMP_NETO_LOC +
                                     V_DIF_IMP_NETO_LOC_GRAV;
          V_DIF_IMP_NETO_LOC_GRAV := 0; -- PARA QUE LA DIFERENCIA SE AJUST SOLO EN EL PRIMER REG.CON IMP.GRAV

          IF REG.IMPU_PORCENTAJE = 10 THEN
            BDET_S_GRAVADO_10_LOC := V_IMP_NETO_LOC_GRAV;
          ELSE
            BDET_S_GRAVADO_5_LOC := V_IMP_NETO_LOC_GRAV;
          END IF;

        END IF;

        IF REG.DETA_IVA_LOC > 0 AND V_DIF_IVA_LOC <> 0 THEN
          BDET_DETA_IVA_LOC := BDET_DETA_IVA_LOC + V_DIF_IVA_LOC;
          V_DIF_IVA_LOC     := 0; -- PARA QUE LA DIF. SE AJUSTE SOLO EN EL 1ER.REG.CON IVA
          IF REG.IMPU_PORCENTAJE = 10 THEN
            BDET_IVA_10_LOC := REG.DETA_IVA_LOC;
          ELSE
            BDET_IVA_5_LOC := REG.DETA_IVA_LOC;
          END IF;
        END IF;

      /*IF  :SYSTEM.LAST_RECORD = 'TRUE' OR
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   (V_DIF_IMP_NETO_LOC_EXEN = 0 AND V_DIF_IMP_NETO_LOC_GRAV = 0 AND V_DIF_IVA_LOC = 0) THEN
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 EXIT;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              END IF;*/

      END LOOP;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'PP_ESTABL_VARIABLES_BDET' || SQLCODE ||
                              SQLERRM);

  END PP_ESTABL_VARIABLES_BDET;

  /*PROCEDURE PP_VALIDAR_OT_IMP_LIM_COSTO(I_EMPRESA                IN NUMBER,
                                        I_DOCU_FEC_EMIS          IN DATE,
                                        I_APP_SESSION            IN NUMBER,
                                        I_USUARIO                IN VARCHAR2,
                                        I_TIMBRADO               IN NUMBER,
                                        I_P_MON_LOC              IN NUMBER,
                                        I_P_MON_US               IN NUMBER,
                                        I_P_CANT_DECIMALES_US    IN NUMBER,
                                        I_P_CANT_DECIMALES_LOC   IN NUMBER,
                                        I_DETA_IMP_NETO_LOC      IN NUMBER,
                                        I_OT_MON_COT             IN NUMBER) IS
    V_CARGOS_SOL NUMBER := 0; --TOTAL DE CARGOS QUE LE SUMA ESTE GASTO A LA OT
    V_US_COT NUMBER;
    V_MON_OT_COT NUMBER;
    V_OT_LIM_COSTO NUMBER := 0; --LIMITE DE COSTO DE OT
    V_OT_LIM_GASTO NUMBER := 0; --LIMITE DE COSTO DE OT
    MAX_DISPONIBLE_COSTO NUMBER := 0; --IMPORTE MAXIMO QUE SE PUEDE CARGAR A LA OT EN MATERIALES
    MAX_DISPONIBLE_GASTO NUMBER := 0; --IMPORTE MAXIMO QUE SE PUEDE CARGAR A LA OT EN MANO DE OBRA
    V_CLAVE_OT NUMBER; --CLAVE DE ORDEN DE TRABAJO
      CURSOR CU_DETALLE IS
    SELECT OPCION, OT, OT_MON, OT_MON_COT, OT_MON_SIM
    FROM COMI001_DET_TMP
    WHERE SESSION_ID = I_APP_SESSION
    AND USUARIO      = I_USUARIO
    AND TRUNC(FECHA) = TRUNC(SYSDATE)
    AND TIMBRADO     = I_TIMBRADO;
  BEGIN
      V_US_COT := FP_COTIZACION( P_MONEDA        => GENERAL.FL_MON_US(I_EMPRESA),
                                 P_DOC_FEC_DOC   => I_DOCU_FEC_EMIS,
                                 P_EMPRESA       => I_EMPRESA);

    FOR REG IN CU_DETALLE LOOP
      IF REG.OPCION = 'O' THEN
          PRD_LIM_EXCEDIDO(REG.OT_CLAVE,
                           REG.OT_MON,
                           I_P_MON_LOC,
                           I_P_MON_US,
                           I_P_CANT_DECIMALES_US,
                           I_P_CANT_DECIMALES_LOC,
                           V_US_COT,
                           REG.OT_MON_COT,
                           V_OT_LIM_COSTO,
                           MAX_DISPONIBLE_COSTO,
                           I_EMPRESA);--DEVULEVE EL MAXIMO QUE SE DISPNONE DE MANO DE OBRA

            --PASAR CARGOS A MONEDA DE LA OT
            V_CARGOS_SOL := ROUND((I_DETA_IMP_NETO_LOC / I_OT_MON_COT),I_P_CANT_DECIMALES_US);

  --VERIFICA SI EL GASTO DISPONIBLE ES MENOR AL GASTO QUE SE QUIERE INGRESAR AHORA
          IF V_OT_LIM_COSTO <> 0 THEN
                IF MAX_DISPONIBLE_COSTO < V_CARGOS_SOL THEN
                    RAISE_APPLICATION_ERROR(-20001,'OT numero ='||REG.OT||'. Limite de Costo OT: '||REG.OT_MON_SIM||TO_CHAR(V_OT_LIM_COSTO,'999G999G990D99')||' Excedido; Maximo Disponible : '||REG.OT_MON_SIM||TO_CHAR(MAX_DISPONIBLE_COSTO,'999G999G990D99'));
                END IF;
          END IF;

      END IF;
    END LOOP;
  END PP_VALIDAR_OT_IMP_LIM_COSTO;*/

  PROCEDURE PL_GRABAR_ULT_NRO(I_NRO_DOC   IN NUMBER,
                              I_TIPO_MOV  IN NUMBER,
                              I_IMPRESORA IN NUMBER,
                              I_EMPRESA   IN NUMBER) IS
  BEGIN

    IF I_TIPO_MOV IN (9, 10) THEN
      --FACTURAS
      --GEN_EXEC('UPDATE GEN_IMPRESORA SET IMP_ULT_FACT = '||I_NRO_DOC||' WHERE IMP_EMPR = '||I_EMPRESA||' AND IMP_CODIGO='||I_IMPRESORA);
      UPDATE GEN_IMPRESORA
         SET IMP_ULT_FACT = I_NRO_DOC
       WHERE IMP_EMPR = I_EMPRESA
         AND IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR');
    END IF;

    IF I_TIPO_MOV IN (16) THEN
      --NOTAS DE CREDITO.
      --GEN_EXEC('UPDATE GEN_IMPRESORA SET IMP_ULT_NOTA_CREDITO = '||I_NRO_DOC||' WHERE IMP_EMPR = '||I_EMPRESA||' AND IMP_CODIGO='||I_IMPRESORA);
      UPDATE GEN_IMPRESORA
         SET IMP_ULT_NOTA_CREDITO = I_NRO_DOC
       WHERE IMP_EMPR = I_EMPRESA
         AND IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR');
    END IF;

    IF I_TIPO_MOV IN (23) THEN
      --RETENCIONES.
      --GEN_EXEC('UPDATE GEN_IMPRESORA SET IMP_ULT_RETENCION = '||I_NRO_DOC||' WHERE IMP_EMPR = '||I_EMPRESA||' AND IMP_CODIGO='||I_IMPRESORA);
      UPDATE GEN_IMPRESORA
         SET IMP_ULT_RETENCION = I_NRO_DOC
       WHERE IMP_EMPR = I_EMPRESA
         AND IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR');
    END IF;

    IF I_TIPO_MOV = 7 THEN
      --AUTOFACTURA
      --GEN_EXEC('UPDATE GEN_IMPRESORA SET IMP_ULT_FACT_COMPRA = '||I_NRO_DOC||' WHERE IMP_EMPR = '||I_EMPRESA||' AND IMP_CODIGO='||I_IMPRESORA);
      UPDATE GEN_IMPRESORA
         SET IMP_ULT_FACT_COMPRA = I_NRO_DOC
       WHERE IMP_EMPR = I_EMPRESA
         AND IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR');
    END IF;

  END PL_GRABAR_ULT_NRO;

  PROCEDURE PP_ACTUALIZAR_DOCUMENTOS(APP_SESSION             IN NUMBER,
                                     APP_USER                IN VARCHAR2,
                                     I_S_TIMBRADO            IN NUMBER,
                                     I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                     I_DOCU_FEC_EMIS         IN DATE,
                                     I_CONF_PER_ACT_INI      IN DATE,
                                     I_CONF_PER_SGTE_FIN     IN DATE,
                                     I_CONF_IND_INTEGRAR_ACT IN VARCHAR2,
                                     I_CONF_IND_INTEGRAR_PRD IN VARCHAR2,
                                     I_DOC_CLAVE_STK         IN STK_DOCUMENTO.DOCU_CLAVE%TYPE, --ES EL MISMO GENERADO POR COMI001.PP_ACTUALIZAR_DOCUMENTO_FIN  O_DOC_CLAVE_STK
                                     P_EMPRESA               IN STK_DOCUMENTO.DOCU_EMPR%TYPE,
                                     I_DOCU_CODIGO_OPER      IN STK_DOCUMENTO.DOCU_CODIGO_OPER%TYPE,
                                     I_DOCU_NRO_DOC          IN STK_DOCUMENTO.DOCU_NRO_DOC%TYPE,
                                     I_DOC_TIMBRADO          IN STK_DOCUMENTO.DOCU_TIMBRADO%TYPE,
                                     P_SUCURSAL              IN STK_DOCUMENTO.DOCU_SUC_ORIG%TYPE,
                                     I_DOCU_DEP_ORIG         IN STK_DOCUMENTO.DOCU_DEP_ORIG%TYPE,
                                     I_DOCU_MON              IN STK_DOCUMENTO.DOCU_MON%TYPE,
                                     I_DOCU_PROV             IN STK_DOCUMENTO.DOCU_PROV%TYPE,
                                     I_DOC_CLI_NOM           IN STK_DOCUMENTO.DOCU_CLI_NOM%TYPE,
                                     I_DOCU_TIPO_MOV         IN STK_DOCUMENTO.DOCU_TIPO_MOV%TYPE,
                                     I_DOCU_OBS              IN STK_DOCUMENTO.DOCU_OBS%TYPE,
                                     I_DOC_OPERADOR          IN STK_DOCUMENTO.DOCU_OPERADOR%TYPE,
                                     I_DOCU_GRAV_NETO_MON    IN STK_DOCUMENTO.DOCU_GRAV_NETO_MON%TYPE,
                                     I_DOCU_GRAV_NETO_LOC    IN STK_DOCUMENTO.DOCU_GRAV_NETO_LOC%TYPE,
                                     I_DOCU_EXEN_NETO_MON    IN STK_DOCUMENTO.DOCU_EXEN_NETO_MON%TYPE,
                                     I_DOCU_EXEN_NETO_LOC    IN STK_DOCUMENTO.DOCU_EXEN_NETO_LOC%TYPE,
                                     I_DOCU_IVA_MON          IN STK_DOCUMENTO.DOCU_IVA_MON%TYPE,
                                     I_DOCU_IVA_LOC          IN STK_DOCUMENTO.DOCU_IVA_LOC%TYPE,
                                     I_P_TABLAS              IN VARCHAR2,
                                     I_CLAVE_TMP             IN NUMBER DEFAULT NULL,
                                     I_TIPO_DOC_PRO_CLI      IN NUMBER) IS
    V_RECORD            NUMBER;
    V_SEQ               NUMBER := 0;
    V_COD_OPERACION_STK NUMBER;
    V_COT_TASA          NUMBER;
  BEGIN

    IF I_DOCU_TIPO_MOV IN (1, 2) THEN
      V_COD_OPERACION_STK := 1;
    ELSIF I_DOCU_TIPO_MOV IN (14) THEN
      V_COD_OPERACION_STK := 2;
    END IF;



   /* BEGIN
      --HACE LA VALIDACION CUANDO LA MONEDA ES 1?
      SELECT TRUNC(COT_TASA)
        INTO V_COT_TASA
        FROM STK_COTIZACION
       WHERE COT_FEC = I_DOCU_FEC_EMIS
         AND COT_MON = 2
         AND COT_EMPR = P_EMPRESA;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'Primero debe ingresar la cotizacion del dia para la moneda ' ||
                                TO_CHAR(I_DOCU_MON) || '!');
    END;*/

     V_COT_TASA:=  GEN_COT_TIPO_MOV(p_empresa => P_empresa,
                                  p_moneda => 2,---I_DOCU_MON,---lv 29/01/2021
                                  p_tipo_mov => I_DOCU_TIPO_MOV,
                                  p_fecha => I_DOCU_FEC_EMIS);






    PP_ACTUALIZAR_DOCUMENTO_STK(I_DOC_CLAVE_STK      => I_DOC_CLAVE_STK,
                                P_EMPRESA            => P_EMPRESA,
                                I_DOCU_CODIGO_OPER   => I_DOCU_CODIGO_OPER,
                                I_DOCU_NRO_DOC       => I_DOCU_NRO_DOC,
                                I_DOC_TIMBRADO       => I_DOC_TIMBRADO,
                                P_SUCURSAL           => P_SUCURSAL,
                                I_DOCU_DEP_ORIG      => I_DOCU_DEP_ORIG,
                                I_DOCU_MON           => I_DOCU_MON,
                                I_DOCU_PROV          => I_DOCU_PROV,
                                I_DOC_CLI_NOM        => I_DOC_CLI_NOM,
                                I_DOCU_FEC_EMIS      => I_DOCU_FEC_EMIS,
                                I_DOCU_TIPO_MOV      => I_DOCU_TIPO_MOV,
                                I_DOCU_OBS           => I_DOCU_OBS,
                                I_DOC_OPERADOR       => I_DOC_OPERADOR,
                                I_DOCU_GRAV_NETO_MON => I_DOCU_GRAV_NETO_MON,
                                I_DOCU_GRAV_NETO_LOC => I_DOCU_GRAV_NETO_LOC,
                                I_DOCU_EXEN_NETO_MON => I_DOCU_EXEN_NETO_MON,
                                I_DOCU_EXEN_NETO_LOC => I_DOCU_EXEN_NETO_LOC,
                                I_DOCU_IVA_MON       => I_DOCU_IVA_MON,
                                I_DOCU_IVA_LOC       => I_DOCU_IVA_LOC,
                                I_DOCU_TASA_US       => V_COT_TASA,
                                I_P_TABLAS           => I_P_TABLAS,
                                I_CLAVE_TMP          => I_CLAVE_TMP,
                                I_TIPO_DOC_PRO_CLI   => I_TIPO_DOC_PRO_CLI);

    FOR REG IN (SELECT NRO_ITEM,
                       OPCION,
                       CONCEPTO,
                       OT,
                       DCON_CUENTA,
                       DCON_CANAL,
                       DCON_DIV_CANAL,
                       NRO_IMPORTACION,
                       CANT,
                       KM_ACTUAL,
                       PREC_UNIT,
                       (OBS || '-' || DESC_LARGA || '-' || CONT_DESC) OBS,
                       DESC_LARGA,
                       OBS OBS_TXT,
                       IND_TIPO_IVA_COMPRA,
                       PC_DCTO,
                       IMPU_PORC_BASE_IMPONIBLE,
                       IMPU_PORCENTAJE,
                       TOTAL,
                       EXENTO,
                       GRAVADO,
                       IVA,
                       ART,
                       DCON_CLAVE_IMP,
                       OCOM_CLAVE,
                       OCOMD_NRO_ITEM,
                       DECODE(I_DOCU_MON,
                              2,
                              ROUND(((EXENTO + GRAVADO) * V_COT_TASA), 0),
                              (EXENTO + GRAVADO)) DETA_IMP_NETO_LOC,
                       (EXENTO + GRAVADO) DETA_IMP_NETO_MON,
                       DETA_IMPU,
                       DECODE(I_DOCU_MON,
                              2,
                              ROUND(((IVA) * V_COT_TASA), 0),
                              (IVA)) DETA_IVA_LOC,
                       IVA DETA_IVA_MON,
                       IVA_10_LOC,
                       IVA_5_LOC,
                       ORDEN_COMP_CLAVE, ---lv
                       ORDEN_COMP_ITEM ---lv
                  FROM COMI001_DET_TMP
                 WHERE SESSION_ID = APP_SESSION
                   AND USUARIO = APP_USER
                   AND TIMBRADO = I_S_TIMBRADO) LOOP

      IF REG.OPCION = 'M' AND I_CONF_IND_INTEGRAR_STK = 'S' AND
         I_DOCU_FEC_EMIS BETWEEN I_CONF_PER_ACT_INI AND I_CONF_PER_SGTE_FIN THEN

        V_SEQ := V_SEQ + 1;

        PP_ACTUALIZAR_DOC_DET_STK(I_DOCU_CLAVE      => I_DOC_CLAVE_STK,
                                  SEQ               => V_SEQ,
                                  DETA_ART          => REG.ART,
                                  P_EMPRESA         => P_EMPRESA,
                                  DETA_CANT         => REG.CANT,
                                  DETA_IMP_NETO_LOC => REG.DETA_IMP_NETO_LOC,
                                  DETA_IMP_NETO_MON => REG.DETA_IMP_NETO_MON,
                                  DETA_IMPU         => REG.DETA_IMPU,
                                  DETA_IVA_LOC      => REG.DETA_IVA_LOC,
                                  DETA_IVA_MON      => REG.DETA_IVA_MON,
                                  OCOM_CLAVE        => REG.OCOM_CLAVE,
                                  SEQ_OCOMD         => REG.OCOMD_NRO_ITEM,
                                  I_P_TABLAS        => I_P_TABLAS,
                                  I_CLAVE_TMP       => I_CLAVE_TMP,
                                  ORD_COMP_CLAVE    => REG.ORDEN_COMP_CLAVE, -------------LV
                                  ORD_COMP_ITEM     => REG.ORDEN_COMP_ITEM); -------------LV

      ELSIF REG.OPCION = 'A' AND I_CONF_IND_INTEGRAR_ACT = 'S' THEN
        --PP_ACTUALIZAR_ACT;
        NULL;
      ELSIF REG.OPCION = 'O' AND I_CONF_IND_INTEGRAR_PRD = 'S' THEN
        --PP_ACTUALIZAR_PRD;
        NULL;
      END IF;

    END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'PP_ACTUALIZAR_DOCUMENTOS' || SQLCODE ||
                              SQLERRM);
  END PP_ACTUALIZAR_DOCUMENTOS;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_APP_SESSION           IN NUMBER,
                                   I_USUARIO               IN VARCHAR2,
                                   I_TIMBRADO              IN NUMBER,
                                   I_CONF_IND_INTEGRAR_PRD IN VARCHAR2,
                                   I_DOCU_TIPO_MOV         IN NUMBER,
                                   I_CONF_FACT_CR_REC      IN NUMBER,
                                   I_CONF_NOTA_CR_REC      IN NUMBER,
                                   I_S_CREDITO             IN VARCHAR2,
                                   I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                   I_DOCU_DEP_ORIG         IN NUMBER,
                                   I_DOC_SERIE             IN VARCHAR2,
                                   I_EMPRESA               IN NUMBER,
                                   I_P_MON_LOC             IN NUMBER,
                                   I_P_MON_US              IN NUMBER,
                                   I_P_CANT_DECIMALES_US   IN NUMBER,
                                   I_P_CANT_DECIMALES_LOC  IN NUMBER,
                                   --I_DETA_IMP_NETO_LOC      IN NUMBER,
                                   --I_OT_MON_COT             IN NUMBER,
                                   I_DOCU_FEC_EMIS          IN DATE,
                                   I_TOT_MON                IN NUMBER,
                                   I_CONF_IND_INTEGRAR_ACT  IN VARCHAR2,
                                   I_SUCURSAL               IN FIN_DOCUMENTO.DOC_SUC%TYPE,
                                   I_DOCU_NRO_DOC           IN FIN_DOCUMENTO.DOC_NRO_DOC%TYPE,
                                   I_DOCU_MON               IN FIN_DOCUMENTO.DOC_MON%TYPE,
                                   I_DOCU_PROV              IN FIN_DOCUMENTO.DOC_PROV%TYPE,
                                   I_DOCU_CLI               IN FIN_DOCUMENTO.DOC_CLI%TYPE,
                                   I_DOCU_PROV_NOM          IN FIN_DOCUMENTO.DOC_CLI_NOM%TYPE,
                                   I_DOCU_PROV_RUC          IN FIN_DOCUMENTO.DOC_CLI_RUC%TYPE,
                                   I_S_TELEF                IN FIN_DOCUMENTO.DOC_CLI_TEL%TYPE,
                                   I_S_DIRECCION            IN FIN_DOCUMENTO.DOC_CLI_DIR%TYPE,
                                   I_DOC_RUC_DV             IN FIN_DOCUMENTO.DOC_RUC_DV%TYPE,
                                   I_DOC_DV                 IN FIN_DOCUMENTO.DOC_DV%TYPE,
                                   I_DOC_TIMBRADO           IN FIN_DOCUMENTO.DOC_TIMBRADO%TYPE,
                                   I_OCOM_CLAVE             IN VARCHAR2, --IN FIN_DOCUMENTO.DOC_ORDEN_COMPRA%TYPE,
                                   I_DOCU_FEC_OPER          IN FIN_DOCUMENTO.DOC_FEC_OPER%TYPE,
                                   I_DOCU_GRAV_NETO_LOC     IN FIN_DOCUMENTO.DOC_NETO_GRAV_LOC%TYPE,
                                   I_DOCU_GRAV_NETO_MON     IN FIN_DOCUMENTO.DOC_NETO_GRAV_MON%TYPE,
                                   I_DOCU_EXEN_NETO_LOC     IN FIN_DOCUMENTO.DOC_NETO_EXEN_LOC%TYPE,
                                   I_DOCU_EXEN_NETO_MON     IN FIN_DOCUMENTO.DOC_NETO_EXEN_MON%TYPE,
                                   I_DOCU_IVA_LOC           IN FIN_DOCUMENTO.DOC_IVA_LOC%TYPE,
                                   I_DOCU_IVA_MON           IN FIN_DOCUMENTO.DOC_IVA_MON%TYPE,
                                   I_DOCU_OBS               IN FIN_DOCUMENTO.DOC_OBS%TYPE,
                                   I_DOC_OPERADOR           IN FIN_DOCUMENTO.DOC_OPERADOR%TYPE,
                                   I_DOC_GRAV_5_MON         IN FIN_DOCUMENTO.DOC_GRAV_5_MON%TYPE,
                                   I_DOC_GRAV_5_LOC         IN FIN_DOCUMENTO.DOC_GRAV_5_LOC%TYPE,
                                   I_DOC_GRAV_10_MON        IN FIN_DOCUMENTO.DOC_GRAV_10_MON%TYPE,
                                   I_DOC_GRAV_10_LOC        IN FIN_DOCUMENTO.DOC_GRAV_10_LOC%TYPE,
                                   I_DOC_IVA_5_MON          IN FIN_DOCUMENTO.DOC_IVA_5_MON%TYPE,
                                   I_DOC_IVA_5_LOC          IN FIN_DOCUMENTO.DOC_IVA_5_LOC%TYPE,
                                   I_DOC_IVA_10_MON         IN FIN_DOCUMENTO.DOC_IVA_10_MON%TYPE,
                                   I_DOC_IVA_10_LOC         IN FIN_DOCUMENTO.DOC_IVA_10_LOC%TYPE,
                                   I_S_CTA_BCO              IN FIN_DOCUMENTO.DOC_CTA_BCO%TYPE,
                                   I_CONF_NOTA_DB_EMIT_PROV IN FIN_CONFIGURACION.CONF_NOTA_DB_EMIT_PROV%TYPE,
                                   I_CREDITO                IN VARCHAR2,
                                   O_W_FLAG_COMMIT          OUT VARCHAR2,
                                   I_TASA                   IN NUMBER,
                                   P_OPER                   IN VARCHAR2,
                                   O_P_WHERE_DCON           OUT VARCHAR2,
                                   I_PAGO_BANCO             IN VARCHAR2,
                                   I_TMOV_TIPO_SALDO        IN VARCHAR2,
                                   I_P_BANCO                IN VARCHAR2,
                                   I_CONF_FACT_COMPRA       IN NUMBER,
                                   I_P_TABLAS               IN VARCHAR2,
                                   I_DOC_CLI_NOM            IN VARCHAR2,
                                   I_CONF_PER_ACT_INI       IN DATE,
                                   I_CONF_PER_SGTE_FIN      IN DATE,
                                   O_DOC_CLAVE              OUT NUMBER,
                                   O_DOC_CLAVE_STK          OUT NUMBER,
                                   I_RETEN_MON              IN NUMBER,
                                   I_RETEN_LOC              IN NUMBER,
                                   I_NRO_RETENCION          IN VARCHAR2,
                                   I_CONF_TMOV_RETENCION    IN NUMBER,
                                   I_RETENCION_100          IN VARCHAR2,
                                   I_TIPO_DOC_PRO_CLI       IN NUMBER) IS

    V_MESSAGE VARCHAR2(100);
    V_ALERT   NUMBER;
    --V_IMPRESORA TEXT_IO.FILE_TYPE;
    V_PATH_IMPRESORA VARCHAR2(100) := NULL;
    IMPRESORANOREGISTRADA EXCEPTION;
    PRAGMA EXCEPTION_INIT(IMPRESORANOREGISTRADA, -302000);
    SALIR EXCEPTION;
    V_DOC_CLAVE            FIN_DOCUMENTO.DOC_CLAVE%TYPE;
    V_DOC_CLAVE_STK        FIN_DOCUMENTO.DOC_CLAVE_STK%TYPE;
    V_CODIGO_OPERACION_STK NUMBER;
  BEGIN

  --- raise_application_error(-20001,I_TIPO_DOC_PRO_CLI);
   IF I_TASA IS NULL OR I_TASA = 0 THEN
      raise_application_error(-20001,'La tasa no puede se nulo. Comuniquese con Informatica');
   END IF;

    IF I_CONF_IND_INTEGRAR_PRD = 'S' THEN
      PP_VALIDAR_OT_REPETIDA(I_APP_SESSION => I_APP_SESSION,
                             I_USUARIO     => I_USUARIO,
                             I_TIMBRADO    => I_TIMBRADO);
    END IF;

    IF I_DOCU_TIPO_MOV IN (1, 2, 7) THEN
      V_CODIGO_OPERACION_STK := 1; --COMPRA DE MERCADERIAS
    ELSIF I_DOCU_TIPO_MOV IN (14) THEN
      V_CODIGO_OPERACION_STK := 2; --DEVOLUCION DE COMPRA
    END IF;

    --Hubieron casos de facturas que ingresaban sin el cod. proveedor, para detectar cuando se produzcan. 19/11/2020
    IF I_DOCU_TIPO_MOV IN (1, 2, 7) AND I_DOCU_PROV IS NULL THEN
      raise_application_error(-20001,
                              'C?digo de proveedor no puede ser nulo. Comuniquese con Inform?tica');
    END IF;

    --17-06-2002 - MSCL - A PEDIDO DE CENTURY SYSTEMS S.R.L.
    --SE ELIMINA LA VALIDACION DE ARTICULOS REPETIDOS. YA QUE ELLOS
    --NECESITAN PODER CARGAR EL MISMO ARTICULO CON DIFERENTE PRECIO.

    PP_VALIDAR_IMPORTES(I_APP_SESSION        => I_APP_SESSION,
                        I_USUARIO            => I_USUARIO,
                        I_TIMBRADO           => I_TIMBRADO,
                        I_DOCU_EXEN_NETO_MON => I_DOCU_EXEN_NETO_MON,
                        I_DOCU_GRAV_NETO_MON => I_DOCU_GRAV_NETO_MON,
                        I_DOCU_IVA_MON       => I_DOCU_IVA_MON,
                        I_DOCU_IVA_LOC       => I_DOCU_IVA_LOC); --VER SI SUMA DE DETALLES COINCIDE CON TOTALES

    IF I_DOCU_TIPO_MOV = 2 THEN
      PP_VALIDAR_TOTAL_CUOTAS(I_DOCU_TIPO_MOV      => I_DOCU_TIPO_MOV,
                              I_CONF_FACT_CR_REC   => I_CONF_FACT_CR_REC,
                              I_CONF_NOTA_CR_REC   => I_CONF_NOTA_CR_REC,
                              I_S_CREDITO          => I_S_CREDITO,
                              I_DOCU_EXEN_NETO_MON => I_DOCU_EXEN_NETO_MON,
                              I_DOCU_GRAV_NETO_MON => I_DOCU_GRAV_NETO_MON,
                              I_DOCU_IVA_MON       => I_DOCU_IVA_MON);
    END IF;
    --PP_RECALCULAR_DETALLES; --PUEDE SER QUE SE HAYA CAMBIADO LA MONEDA SI
    --O LA TASA EN EL ENCABEZADO Y ESO AFECTA
    --A DETALLES

    PP_VALIDAR_INTEGRACION(I_CONF_IND_INTEGRAR_PRD => I_CONF_IND_INTEGRAR_PRD,
                           I_CONF_IND_INTEGRAR_STK => I_CONF_IND_INTEGRAR_STK,
                           I_CONF_IND_INTEGRAR_ACT => I_CONF_IND_INTEGRAR_ACT,
                           I_DOCU_DEP_ORIG         => I_DOCU_DEP_ORIG,
                           I_DOC_SERIE             => I_DOC_SERIE,
                           I_APP_SESSION           => I_APP_SESSION,
                           I_USUARIO               => I_USUARIO,
                           I_TIMBRADO              => I_TIMBRADO); --VER SI LOS ITEMS INGRESADOS CORRESPONDEN

    -- A SISTEMAS QUE ESTAN INTEGRADOS Y
    -- QUE LOS CAMPOS NECESARIOS PARA LOS
    -- SISTEMAS QUE AFECTA NO ESTEN NULOS.

    PP_ESTABL_VARIABLES_BDET(I_TASA               => I_TASA,
                             I_CANT_DECIMALES_LOC => I_P_CANT_DECIMALES_LOC,
                             I_TIMBRADO           => I_TIMBRADO,
                             I_USUARIO            => I_USUARIO,
                             I_APP_SESSION        => I_APP_SESSION,
                             I_DOCU_IVA_LOC       => I_DOCU_IVA_LOC,
                             I_DOCU_EXEN_NETO_LOC => I_DOCU_EXEN_NETO_LOC,
                             I_DOCU_GRAV_NETO_LOC => I_DOCU_GRAV_NETO_LOC); -- MOVER DATOS A CAMPOS DEL BLOQUE :BDET  Y CONVERTIR A ENTEROS LOS IMPORTES
    --raise_application_Error(-20010,I_OCOM_CLAVE);

    PP_ACTUALIZAR_DOCUMENTO_FIN(I_EMPRESA               => I_EMPRESA,
                                I_SUCURSAL              => I_SUCURSAL,
                                I_DOCU_NRO_DOC          => I_DOCU_NRO_DOC,
                                I_DOCU_MON              => I_DOCU_MON,
                                I_DOCU_PROV             => I_DOCU_PROV,
                                I_DOCU_CLI              => I_DOCU_CLI,
                                I_DOCU_PROV_NOM         => I_DOCU_PROV_NOM,
                                I_DOCU_PROV_RUC         => I_DOCU_PROV_RUC,
                                I_S_TELEF               => I_S_TELEF,
                                I_S_DIRECCION           => I_S_DIRECCION,
                                I_DOC_RUC_DV            => I_DOC_RUC_DV,
                                I_DOC_DV                => I_DOC_DV,
                                I_DOC_TIMBRADO          => I_DOC_TIMBRADO,
                                I_OCOM_CLAVE            => I_OCOM_CLAVE,
                                I_DOCU_FEC_OPER         => I_DOCU_FEC_OPER,
                                I_DOCU_FEC_EMIS         => I_DOCU_FEC_EMIS,
                                I_DOCU_GRAV_NETO_LOC    => I_DOCU_GRAV_NETO_LOC,
                                I_DOCU_GRAV_NETO_MON    => I_DOCU_GRAV_NETO_MON,
                                I_DOCU_EXEN_NETO_LOC    => I_DOCU_EXEN_NETO_LOC,
                                I_DOCU_EXEN_NETO_MON    => I_DOCU_EXEN_NETO_MON,
                                I_DOCU_IVA_LOC          => I_DOCU_IVA_LOC,
                                I_DOCU_IVA_MON          => I_DOCU_IVA_MON,
                                I_DOCU_OBS              => I_DOCU_OBS,
                                I_DOC_OPERADOR          => I_DOC_OPERADOR,
                                I_DOC_GRAV_5_MON        => I_DOC_GRAV_5_MON,
                                I_DOC_GRAV_5_LOC        => I_DOC_GRAV_5_LOC,
                                I_DOC_GRAV_10_MON       => I_DOC_GRAV_10_MON,
                                I_DOC_GRAV_10_LOC       => I_DOC_GRAV_10_LOC,
                                I_DOC_IVA_5_MON         => I_DOC_IVA_5_MON,
                                I_DOC_IVA_5_LOC         => I_DOC_IVA_5_LOC,
                                I_DOC_IVA_10_MON        => I_DOC_IVA_10_MON,
                                I_DOC_IVA_10_LOC        => I_DOC_IVA_10_LOC,
                                I_S_CTA_BCO             => I_S_CTA_BCO,
                                I_DOCU_TIPO_MOV         => I_DOCU_TIPO_MOV,
                                I_DOCU_DEP_ORIG         => I_DOCU_DEP_ORIG,
                                O_DOC_CLAVE             => V_DOC_CLAVE,
                                O_DOC_CLAVE_STK         => V_DOC_CLAVE_STK,
                                I_P_TABLAS              => I_P_TABLAS,
                                I_CONF_IND_INTEGRAR_STK => I_CONF_IND_INTEGRAR_STK,
                                I_TIPO_DOC_PRO_CLI      => I_TIPO_DOC_PRO_CLI);

    --SI ES UNA NOTA DEBITO EMIT A PROV SE GRABA UNA SOLA CUOTA
    IF I_DOCU_TIPO_MOV = I_CONF_NOTA_DB_EMIT_PROV THEN
      --O_S_CUO_FEC_VTO := I_DOCU_FEC_OPER;
      --O_CUO_FEC_VTO   := I_DOCU_FEC_OPER;
      --I_CUO_IMP_MON   := I_TOT_MON;
      FOR REG IN (SELECT SEQ_ID,
                         N001 IMPORTE,
                         CASE
                           WHEN I_DOCU_MON = 1 THEN
                            N001
                           ELSE
                            ROUND(N001 * I_TASA, 0)
                         END IMPORTE_LOC,
                         D001 VENCIMIENTO
                    FROM APEX_COLLECTIONS
                   WHERE COLLECTION_NAME = 'CUOTA_COMI001') LOOP

        PP_ACTUALIZAR_CUOTAS(I_CLAVE_FIN => V_DOC_CLAVE,
                             I_FEC_VTO   => REG.VENCIMIENTO,
                             I_IMP_MON   => REG.IMPORTE,
                             I_IMP_LOC   => REG.IMPORTE_LOC,
                             I_EMPR      => I_EMPRESA,
                             I_P_TABLAS  => I_P_TABLAS);
      END LOOP;
    END IF;
    --ACTUALIZAR CUOTAS SOLO SI EXISTEN CUOTAS PARA EL DOCUMENTO
    IF (I_DOCU_TIPO_MOV = I_CONF_FACT_CR_REC OR
       (I_DOCU_TIPO_MOV = I_CONF_NOTA_CR_REC AND I_CREDITO = 'S')) THEN
      FOR REG IN (SELECT SEQ_ID,
                         N001 IMPORTE,
                         CASE
                           WHEN I_DOCU_MON = 1 THEN
                            N001
                           ELSE
                            ROUND(N001 * I_TASA, 0)
                         END IMPORTE_LOC,
                         D001 VENCIMIENTO
                    FROM APEX_COLLECTIONS
                   WHERE COLLECTION_NAME = 'CUOTA_COMI001') LOOP

        PP_ACTUALIZAR_CUOTAS(I_CLAVE_FIN => V_DOC_CLAVE,
                             I_FEC_VTO   => REG.VENCIMIENTO,
                             I_IMP_MON   => REG.IMPORTE,
                             I_IMP_LOC   => REG.IMPORTE_LOC,
                             I_EMPR      => I_EMPRESA,
                             I_P_TABLAS  => I_P_TABLAS);
      END LOOP;
    END IF;

    O_W_FLAG_COMMIT := 'SI';
    PP_ACTUALIZAR_DOCUMENTOS( --I_OPCION                 => ,
                             APP_SESSION             => I_APP_SESSION,
                             APP_USER                => I_USUARIO,
                             I_S_TIMBRADO            => I_TIMBRADO,
                             I_CONF_IND_INTEGRAR_STK => I_CONF_IND_INTEGRAR_STK,
                             I_DOCU_FEC_EMIS         => I_DOCU_FEC_EMIS,
                             I_CONF_PER_ACT_INI      => I_CONF_PER_ACT_INI,
                             I_CONF_PER_SGTE_FIN     => I_CONF_PER_SGTE_FIN,
                             I_CONF_IND_INTEGRAR_ACT => I_CONF_IND_INTEGRAR_ACT,
                             I_CONF_IND_INTEGRAR_PRD => I_CONF_IND_INTEGRAR_PRD,
                             I_DOC_CLAVE_STK         => V_DOC_CLAVE_STK, --ES EL MISMO GENERADO POR COMI001.PP_ACTUALIZAR_DOCUMENTO_FIN  O_DOC_CLAVE_STK
                             P_EMPRESA               => I_EMPRESA,
                             I_DOCU_CODIGO_OPER      => V_CODIGO_OPERACION_STK, --CODIGO DE LA OPERACIN EN STOCK
                             I_DOCU_NRO_DOC          => I_DOCU_NRO_DOC,
                             I_DOC_TIMBRADO          => I_DOC_TIMBRADO,
                             P_SUCURSAL              => I_SUCURSAL,
                             I_DOCU_DEP_ORIG         => I_DOCU_DEP_ORIG,
                             I_DOCU_MON              => I_DOCU_MON,
                             I_DOCU_PROV             => I_DOCU_PROV,
                             I_DOC_CLI_NOM           => I_DOC_CLI_NOM,
                             I_DOCU_TIPO_MOV         => I_DOCU_TIPO_MOV,
                             I_DOCU_OBS              => I_DOCU_OBS,
                             I_DOC_OPERADOR          => I_DOC_OPERADOR,
                             I_DOCU_GRAV_NETO_MON    => I_DOCU_GRAV_NETO_MON,
                             I_DOCU_GRAV_NETO_LOC    => I_DOCU_GRAV_NETO_LOC,
                             I_DOCU_EXEN_NETO_MON    => I_DOCU_EXEN_NETO_MON,
                             I_DOCU_EXEN_NETO_LOC    => I_DOCU_EXEN_NETO_LOC,
                             I_DOCU_IVA_MON          => I_DOCU_IVA_MON,
                             I_DOCU_IVA_LOC          => I_DOCU_IVA_LOC,
                             I_P_TABLAS              => I_P_TABLAS,
                             I_CLAVE_TMP             => V_DOC_CLAVE,
                             I_TIPO_DOC_PRO_CLI      => I_TIPO_DOC_PRO_CLI);

    PP_ACTUALIZAR_DOC_CONCEPTO(APP_SESSION      => I_APP_SESSION,
                               APP_USER         => I_USUARIO,
                               P1387_S_TIMBRADO => I_TIMBRADO,
                               P_OPER           => P_OPER,
                               V_DOC_CLAVE      => V_DOC_CLAVE,
                               V_TASA           => I_TASA,
                               P_EMPRESA        => I_EMPRESA,
                               O_P_WHERE_DCON   => O_P_WHERE_DCON,
                               I_P_TABLAS       => I_P_TABLAS,
                               I_CLAVE_TMP      => V_DOC_CLAVE,
                               I_FECHA_DOC      => I_DOCU_FEC_EMIS,
                               P_PROVEEDOR      => I_DOCU_PROV);
    IF I_CONF_IND_INTEGRAR_STK = 'S' THEN
      --PP_CANCELAR_PEDIDOS;**
      NULL;
    END IF;

    IF I_PAGO_BANCO = 'S' THEN
      IF I_TMOV_TIPO_SALDO = 'C' THEN
        IF I_P_BANCO IS NOT NULL THEN
          FOR REG IN (SELECT SEQ_ID,
                             C001   SERIE,
                             C002   BENEFICIARIO,
                             N001   CUO_IMP_MON,
                             N002   NRO_CHEQUE,
                             D001   I_CUO_FEC_VTO,
                             N003   BANCO
                        FROM APEX_COLLECTIONS
                       WHERE COLLECTION_NAME = 'CHEQUE_COMI001') LOOP
            PP_INSERTAR_CH_EMIT(W_CLAVE           => NULL, --**
                                S_CH_EMIT_SERIE   => REG.SERIE,
                                S_CH_EMIT_NRO     => REG.NRO_CHEQUE,
                                CH_EMIT_FEC_VTO1  => REG.I_CUO_FEC_VTO,
                                S_CH_EMIT_IMPORTE => REG.CUO_IMP_MON,
                                DOC_CLAVE         => V_DOC_CLAVE, --**
                                S_BENEFICIARIO    => REG.BENEFICIARIO,
                                P_EMPRESA         => I_EMPRESA);

            PP_ACT_CTA_BAN(S_CH_EMIT_NRO => REG.NRO_CHEQUE,
                           P_EMPRESA     => I_EMPRESA,
                           S_CTA_BCO     => I_S_CTA_BCO,
                           S_BANCO       => REG.BANCO --BBANCO.S_BANCO
                           );
          END LOOP;
        END IF;
      END IF;
    END IF;

    IF I_PAGO_BANCO = 'S' THEN
      FOR REG IN (SELECT DISTINCT C002 BENEFICIARIO,
                                  SUM(N001) CUO_IMP_MON,
                                  N002 NRO_CHEQUE,
                                  N003 BANCO
                    FROM APEX_COLLECTIONS
                   WHERE COLLECTION_NAME = 'CHEQUE_COMI001'
                   GROUP BY C002, N002, N003) LOOP
        PP_ACTUALIZA_TRANS(S_CTA_BCO      => I_S_CTA_BCO,
                           S_BANCO        => REG.BANCO,
                           P_EMPRESA      => I_EMPRESA,
                           P_SUCURSAL     => I_SUCURSAL,
                           S_CH_EMIT_NRO  => REG.NRO_CHEQUE,
                           S_MON          => I_DOCU_MON, --BBANCO.S_MON
                           DOC_FEC_OPER   => I_DOCU_FEC_OPER,
                           S_TOTAL_IMP    => REG.CUO_IMP_MON, --BPIE2.S_TOTAL_IMP
                           S_TASA         => I_TASA,
                           S_BENEFICIARIO => REG.BENEFICIARIO,
                           DOC_TIMBRADO   => I_DOC_TIMBRADO);
      END LOOP;
    END IF;

    O_W_FLAG_COMMIT := 'SI';
    --PP_ACTUALIZAR_RUC_PROV;**

    IF I_DOCU_TIPO_MOV IN (I_CONF_FACT_COMPRA) THEN
      PL_GRABAR_ULT_NRO(I_NRO_DOC   => I_DOCU_NRO_DOC,
                        I_TIPO_MOV  => I_DOCU_TIPO_MOV,
                        I_IMPRESORA => NULL,
                        I_EMPRESA   => I_EMPRESA);
      --PL_GRABAR_ULT_NRO(:BDOC.DOCU_NRO_DOC,:BDOC.DOCU_TIPO_MOV,:PARAMETER.P_IMPRESORA,I_EMPRESA);
    END IF;

    /*-----------------EL TIPO DE MOV 7 TAMBIEN DEBE GUARDAR IMAGEN PEDIDO SR. FRANZ 10/09/2019--------------------*/

    IF I_DOCU_TIPO_MOV IN (16) THEN
      -- NO PONER MAS EL TM 7 AQUI. POR FAVOR

      PP_CARGAR_DOC_IMG(P_EMPRESA          => I_EMPRESA,
                        P_SUCURSAL         => I_SUCURSAL,
                        DOC_TIMBRADO       => I_DOC_TIMBRADO, --:BDOC_FIN.DOC_TIMBRADO
                        DOC_NRO_DOC        => I_DOCU_NRO_DOC, --:BDOC_FIN.DOC_NRO_DOC
                        DOC_PROV           => I_DOCU_PROV, --:BDOC_FIN.DOC_PROV
                        DOC_FEC_DOC        => I_DOCU_FEC_EMIS, --:BDOC_FIN.DOC_FEC_DOC
                        DOC_TIPO_MOV       => I_DOCU_TIPO_MOV, --:BDOC_FIN.DOC_TIPO_MOV
                        DOC_MON            => I_DOCU_MON, --:BDOC_FIN.DOC_MON
                        DOC_GRAV_10_MON    => I_DOC_GRAV_10_MON, --:BDOC.DOC_GRAV_10_MON
                        DOC_GRAV_5_MON     => I_DOC_IVA_5_MON, --:BDOC.DOC_GRAV_5_MON
                        DOCU_EXEN_NETO_MON => I_DOCU_EXEN_NETO_MON, --:BDOC.DOCU_EXEN_NETO_MON
                        S_TOT_MON          => I_TOT_MON, --:BDOC.S_TOT_MON
                        DOC_CLAVE          => V_DOC_CLAVE, --:BDOC_FIN.DOC_CLAVE
                        S_CTA_BCO          => I_S_CTA_BCO, --:BDOC.S_CTA_BCO
                        V_FAC_IMAGEN_BLOB  => NULL,
                        V_FAC_MODIFICADO   => NULL);
    ELSE
      FOR REG IN (SELECT BLOB001 IMAGEN
                    FROM APEX_COLLECTIONS
                   WHERE COLLECTION_NAME = 'IMAGEN_COMI001') LOOP

        PP_CARGAR_DOC_IMG(P_EMPRESA          => I_EMPRESA,
                          P_SUCURSAL         => I_SUCURSAL,
                          DOC_TIMBRADO       => I_DOC_TIMBRADO, --:BDOC_FIN.DOC_TIMBRADO
                          DOC_NRO_DOC        => I_DOCU_NRO_DOC, --:BDOC_FIN.DOC_NRO_DOC
                          DOC_PROV           => I_DOCU_PROV, --:BDOC_FIN.DOC_PROV
                          DOC_FEC_DOC        => I_DOCU_FEC_EMIS, --:BDOC_FIN.DOC_FEC_DOC
                          DOC_TIPO_MOV       => I_DOCU_TIPO_MOV, --:BDOC_FIN.DOC_TIPO_MOV
                          DOC_MON            => I_DOCU_MON, --:BDOC_FIN.DOC_MON
                          DOC_GRAV_10_MON    => I_DOC_GRAV_10_MON, --:BDOC.DOC_GRAV_10_MON
                          DOC_GRAV_5_MON     => I_DOC_IVA_5_MON, --:BDOC.DOC_GRAV_5_MON
                          DOCU_EXEN_NETO_MON => I_DOCU_EXEN_NETO_MON, --:BDOC.DOCU_EXEN_NETO_MON
                          S_TOT_MON          => I_TOT_MON, --:BDOC.S_TOT_MON
                          DOC_CLAVE          => V_DOC_CLAVE, --:BDOC_FIN.DOC_CLAVE
                          S_CTA_BCO          => I_S_CTA_BCO, --:BDOC.S_CTA_BCO
                          V_FAC_IMAGEN_BLOB  => REG.IMAGEN,
                          V_FAC_MODIFICADO   => NULL);
      END LOOP;

    END IF;

    IF NVL(I_RETEN_MON, 0) > 0 THEN

      PP_ACTUALIZAR_DOC_RETEN(I_EMPRESA             => I_EMPRESA,
                              I_SUCURSAL            => I_SUCURSAL,
                              I_S_NRO_RETENCION     => I_NRO_RETENCION,
                              I_S_TIMBRADO          => I_DOC_TIMBRADO,
                              DOCU_MON              => I_DOCU_MON,
                              DOCU_PROV             => I_DOCU_PROV,
                              DOCU_CLI              => I_DOCU_CLI,
                              DOCU_PROV_NOM         => I_DOCU_PROV_NOM,
                              DOCU_PROV_RUC         => I_DOCU_PROV_RUC,
                              S_TELEF               => I_S_TELEF,
                              S_DIRECCION           => I_S_DIRECCION,
                              DOCU_FEC_OPER         => I_DOCU_FEC_OPER,
                              DOCU_FEC_EMIS         => I_DOCU_FEC_EMIS,
                              I_NUMERO_DOC          => I_DOCU_NRO_DOC,
                              S_RETEN_LOC           => I_RETEN_LOC,
                              S_RETEN_MON           => I_RETEN_MON,
                              DOCU_OBS              => I_DOCU_OBS,
                              I_DOC_OPERADOR        => I_DOC_OPERADOR,
                              I_S_CTA_BCO           => I_S_CTA_BCO,
                              I_DOC_CLAVE_COMPRA    => V_DOC_CLAVE, --DATO DE LA FACTURA DE COMPRA
                              I_CONF_TMOV_RETENCION => I_CONF_TMOV_RETENCION,
                              I_S_RETENCION_100     => I_RETENCION_100,
                              I_P_TABLAS            => I_P_TABLAS,
                              I_P_IMPRESORA         => NULL,
                              I_TIPO_DOC_PRO_CLI    => I_TIPO_DOC_PRO_CLI);
    END IF;

    IF I_P_TABLAS = 'T' AND I_EMPRESA = 1 THEN
      UPDATE FIN_DOCUMENTO_COMI015_TEMP T
         SET T.DOC_FEC_GRAB = SYSDATE
       WHERE T.DOC_CLAVE = V_DOC_CLAVE
         AND T.DOC_EMPR = I_EMPRESA;
    END IF;

    IF I_OCOM_CLAVE IS NOT NULL THEN

      BEGIN
        ---------------------------LV 23/06/2020
        UPDATE STK_ENTRADA_MERC A
           SET --A.ENTMER_NUM_DOC_FIN   = I_OCOM_CLAVE ---- ESTA PARTE LE COMENTO YA QUE NECESITO QUE NO SE MODIFIQUE EL NRO DE
               A.ENTMER_CLAVE_DOC_FIN = V_DOC_CLAVE ----FACTURA QUE SE LE COLOCA AL PRINCIPIO, DE ESA MANERA PUEDO RELACIONAR LA ENTRADA CON EL NRO DE FACTURA
         WHERE A.ENTMER_CLAVE_ORDEN IN
               (SELECT REGEXP_SUBSTR(REPLACE(I_OCOM_CLAVE, ',', ':'),
                                     '[^:]+',
                                     1,
                                     LEVEL) CLAVE_COMPRA
                  FROM DUAL
                CONNECT BY REGEXP_SUBSTR(REPLACE(I_OCOM_CLAVE, ',', ':'),
                                         '[^:]+',
                                         1,
                                         LEVEL) IS NOT NULL) --= I_ORDEN_COMPRA

              -- I_OCOM_CLAVE
           AND A.ENTMER_EMPR = I_EMPRESA
           AND A.ENTMER_NUM_DOC_FIN = I_DOCU_NRO_DOC; ----LV PARA QUE MODIFIQUE SOLO LA ENTRADA QUE SE ULITLIZA

      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Hubo un error al actualizar la Entrada de Mercancia,Avise al Admin!');
      END;

      BEGIN
        UPDATE STK_ORDEN_COMPRA A
           SET A.OCOM_OPER_FINIQ = I_USUARIO, A.OCOM_FEC_FINIQ = SYSDATE
          --- ,  A.OCOM_ESTADO  = 'F'
         WHERE A.OCOM_CLAVE in
               (SELECT REGEXP_SUBSTR(REPLACE(I_OCOM_CLAVE, ',', ':'),
                                     '[^:]+',
                                     1,
                                     LEVEL) CLAVE_COMPRA
                  FROM DUAL
                CONNECT BY REGEXP_SUBSTR(REPLACE(I_OCOM_CLAVE, ',', ':'),
                                         '[^:]+',
                                         1,
                                         LEVEL) IS NOT NULL) --= I_ORDEN_COMPRA
              --= I_OCOM_CLAVE
           AND A.OCOM_EMPR = I_EMPRESA;

      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Hubo un error al actualizar el estado de la orden de compra,Avise al Admin!');
      END;

    END IF;

    O_DOC_CLAVE     := V_DOC_CLAVE;
    O_DOC_CLAVE_STK := V_DOC_CLAVE_STK;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'PP_ACTUALIZAR_REGISTRO' || SQLCODE ||
                              SQLERRM);
  END PP_ACTUALIZAR_REGISTRO;

  PROCEDURE PP_VALIDAR_NRO_IMPORTACION(I_FCON_IND_CLAVE_IMPORTACION IN VARCHAR2,
                                       I_NRO_IMPORTACION            IN NUMBER,
                                       I_EMPRESA                    IN NUMBER,
                                       O_DCON_CLAVE_IMP             OUT IMP_IMPORTACION.IMP_CLAVE%TYPE) IS
    SALIR EXCEPTION;
  BEGIN
    IF NVL(I_FCON_IND_CLAVE_IMPORTACION, 'N') = 'N' THEN
      IF I_NRO_IMPORTACION IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Numero de importacion debe quedar en blanco para este concepto!');
      ELSE
        RAISE SALIR;
      END IF;
    ELSE
      IF I_NRO_IMPORTACION IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Nro. importacion no puede ser nulo para este concepto!');
      END IF;
    END IF;

    -- VALIDAR SI EXISTE LA IMPORTACION
    DECLARE
      V_NRO_DESPACHO VARCHAR2(10);
      SALIR EXCEPTION;
    BEGIN
      SELECT IMP_CLAVE_DESP, IMP_CLAVE
        INTO V_NRO_DESPACHO, O_DCON_CLAVE_IMP
        FROM IMP_IMPORTACION
       WHERE IMP_EMPR = I_EMPRESA
         AND IMP_NRO = I_NRO_IMPORTACION;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Numero de importacion inexistente!');
      WHEN SALIR THEN
        NULL;
    END;
  EXCEPTION
    WHEN SALIR THEN
      NULL;
  END PP_VALIDAR_NRO_IMPORTACION;

  PROCEDURE PP_MOSTRAR_CANAL(P_EMPRESA        IN NUMBER,
                             I_DCON_CANAL     IN NUMBER,
                             O_DCON_DIV_CANAL OUT NUMBER) IS
    V_CAN_DESC FAC_CANAL_VENTA.CAN_DESC%TYPE;
  BEGIN
    SELECT CANB_DESC
      INTO V_CAN_DESC
      FROM FAC_CANAL_VENTA_BETA
     WHERE CANB_CODIGO = I_DCON_CANAL
       AND CANB_EMPR = P_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN

      O_DCON_DIV_CANAL := NULL;

    --  PL_EXHIBIR_ERROR('Canal Inexistente!');
  END PP_MOSTRAR_CANAL;

  PROCEDURE PP_MOSTRAR_DIV_CANAL(P_EMPRESA        IN NUMBER,
                                 I_DCON_CANAL     IN NUMBER,
                                 I_DCON_DIV_CANAL IN NUMBER) IS

    V_DIV_DESC FAC_DIV_CANAL.DIV_DESC%TYPE;
  BEGIN
    SELECT DIV_DESC
      INTO V_DIV_DESC
      FROM FAC_DIV_CANAL
     WHERE DIV_CANAL = I_DCON_CANAL
       AND DIV_CODIGO = I_DCON_DIV_CANAL
       AND DIV_EMPR = P_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DIV_DESC := NULL;
      --PL_EXHIBIR_ERROR('Division de Canal Inexistente!');
  END PP_MOSTRAR_DIV_CANAL;

  PROCEDURE PP_TERMINAR_PROCESO(I_SESSION_ID IN COMI001_DET_TMP.SESSION_ID%TYPE,
                                I_USUARIO    IN COMI001_DET_TMP.USUARIO%TYPE,
                                I_TIMBRADO   IN COMI001_DET_TMP.TIMBRADO%TYPE) IS
  BEGIN
    DELETE COMI001_DET_TMP
     WHERE SESSION_ID = I_SESSION_ID
       AND TIMBRADO = I_TIMBRADO
       AND USUARIO = I_USUARIO
       AND TRUNC(FECHA) = TRUNC(SYSDATE);

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CUOTA_COMI001') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'CUOTA_COMI001');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_LINEA') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_LINEA');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_SUBCONCEPTO') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_SUBCONCEPTO');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUE_COMI001') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'CHEQUE_COMI001');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'IMAGEN_COMI001') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'IMAGEN_COMI001');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DET_SERIES') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DET_SERIES');
    END IF;
  END PP_TERMINAR_PROCESO;

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_FIN(I_EMPRESA               IN FIN_DOCUMENTO.DOC_EMPR%TYPE,
                                        I_SUCURSAL              IN FIN_DOCUMENTO.DOC_SUC%TYPE,
                                        I_DOCU_NRO_DOC          IN FIN_DOCUMENTO.DOC_NRO_DOC%TYPE,
                                        I_DOCU_MON              IN FIN_DOCUMENTO.DOC_MON%TYPE,
                                        I_DOCU_PROV             IN FIN_DOCUMENTO.DOC_PROV%TYPE,
                                        I_DOCU_CLI              IN FIN_DOCUMENTO.DOC_CLI%TYPE,
                                        I_DOCU_PROV_NOM         IN FIN_DOCUMENTO.DOC_CLI_NOM%TYPE,
                                        I_DOCU_PROV_RUC         IN FIN_DOCUMENTO.DOC_CLI_RUC%TYPE,
                                        I_S_TELEF               IN FIN_DOCUMENTO.DOC_CLI_TEL%TYPE,
                                        I_S_DIRECCION           IN FIN_DOCUMENTO.DOC_CLI_DIR%TYPE,
                                        I_DOC_RUC_DV            IN FIN_DOCUMENTO.DOC_RUC_DV%TYPE,
                                        I_DOC_DV                IN FIN_DOCUMENTO.DOC_DV%TYPE,
                                        I_DOC_TIMBRADO          IN FIN_DOCUMENTO.DOC_TIMBRADO%TYPE,
                                        I_OCOM_CLAVE            IN VARCHAR2,
                                        I_DOCU_FEC_OPER         IN FIN_DOCUMENTO.DOC_FEC_OPER%TYPE,
                                        I_DOCU_FEC_EMIS         IN FIN_DOCUMENTO.DOC_FEC_DOC%TYPE,
                                        I_DOCU_GRAV_NETO_LOC    IN FIN_DOCUMENTO.DOC_NETO_GRAV_LOC%TYPE,
                                        I_DOCU_GRAV_NETO_MON    IN FIN_DOCUMENTO.DOC_NETO_GRAV_MON%TYPE,
                                        I_DOCU_EXEN_NETO_LOC    IN FIN_DOCUMENTO.DOC_NETO_EXEN_LOC%TYPE,
                                        I_DOCU_EXEN_NETO_MON    IN FIN_DOCUMENTO.DOC_NETO_EXEN_MON%TYPE,
                                        I_DOCU_IVA_LOC          IN FIN_DOCUMENTO.DOC_IVA_LOC%TYPE,
                                        I_DOCU_IVA_MON          IN FIN_DOCUMENTO.DOC_IVA_MON%TYPE,
                                        I_DOCU_OBS              IN FIN_DOCUMENTO.DOC_OBS%TYPE,
                                        I_DOC_OPERADOR          IN FIN_DOCUMENTO.DOC_OPERADOR%TYPE,
                                        I_DOC_GRAV_5_MON        IN FIN_DOCUMENTO.DOC_GRAV_5_MON%TYPE,
                                        I_DOC_GRAV_5_LOC        IN FIN_DOCUMENTO.DOC_GRAV_5_LOC%TYPE,
                                        I_DOC_GRAV_10_MON       IN FIN_DOCUMENTO.DOC_GRAV_10_MON%TYPE,
                                        I_DOC_GRAV_10_LOC       IN FIN_DOCUMENTO.DOC_GRAV_10_LOC%TYPE,
                                        I_DOC_IVA_5_MON         IN FIN_DOCUMENTO.DOC_IVA_5_MON%TYPE,
                                        I_DOC_IVA_5_LOC         IN FIN_DOCUMENTO.DOC_IVA_5_LOC%TYPE,
                                        I_DOC_IVA_10_MON        IN FIN_DOCUMENTO.DOC_IVA_10_MON%TYPE,
                                        I_DOC_IVA_10_LOC        IN FIN_DOCUMENTO.DOC_IVA_10_LOC%TYPE,
                                        I_S_CTA_BCO             IN FIN_DOCUMENTO.DOC_CTA_BCO%TYPE,
                                        I_DOCU_TIPO_MOV         IN FIN_DOCUMENTO.DOC_TIPO_MOV%TYPE,
                                        I_DOCU_DEP_ORIG         IN STK_DOCUMENTO.DOCU_DEP_ORIG%TYPE,
                                        O_DOC_CLAVE             OUT FIN_DOCUMENTO.DOC_CLAVE%TYPE,
                                        O_DOC_CLAVE_STK         OUT FIN_DOCUMENTO.DOC_CLAVE_STK%TYPE,
                                        I_P_TABLAS              IN VARCHAR2,
                                        I_CLAVE_TMP             IN NUMBER DEFAULT NULL,
                                        I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                        I_TIPO_DOC_PRO_CLI      IN FIN_DOCUMENTO.DOC_TIPO_DOC_CLI_PROV%TYPE) IS

    V_IND_CUOTA      VARCHAR2(1);
    V_DOC_TIPO_SALDO VARCHAR2(1);
    V_USER           VARCHAR2(20);
    V_TABLA          VARCHAR2(2);
  BEGIN

    IF USER = 'APEX_PUBLIC_USER' THEN
      V_USER := SUBSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'),
                       INSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'), ':') + 1);
    ELSE
      V_USER := USER;
    END IF;

    O_DOC_CLAVE := FIN_SEQ_DOC_NEXTVAL;

    IF I_DOCU_DEP_ORIG IS NOT null THEN
      O_DOC_CLAVE_STK := STK_SEQ_DOCU_NEXTVAL;
    END IF;

    IF I_S_CTA_BCO IS NULL THEN
      V_IND_CUOTA := 'S';
    ELSE
      V_IND_CUOTA := 'N';
    END IF;

    SELECT TMOV_TIPO
      INTO V_DOC_TIPO_SALDO
      FROM GEN_TIPO_MOV
     WHERE TMOV_CODIGO = I_DOCU_TIPO_MOV
       AND TMOV_EMPR = I_EMPRESA;

    BEGIN
      -- CALL THE PROCEDURE
      COM_DOC_RECIBIDOS_TABLAS.INSERTAR_DOCUMENTO_FIN(V_TABLA              => I_P_TABLAS,
                                                      V_DOC_CLAVE          => O_DOC_CLAVE,
                                                      V_DOC_EMPR           => I_EMPRESA,
                                                      V_DOC_CTA_BCO        => I_S_CTA_BCO,
                                                      V_DOC_SUC            => I_SUCURSAL,
                                                      V_DOC_TIPO_MOV       => I_DOCU_TIPO_MOV,
                                                      V_DOC_NRO_DOC        => I_DOCU_NRO_DOC,
                                                      V_DOC_TIPO_SALDO     => V_DOC_TIPO_SALDO,
                                                      V_DOC_MON            => I_DOCU_MON,
                                                      V_DOC_PROV           => I_DOCU_PROV,
                                                      V_DOC_CLI            => I_DOCU_CLI,
                                                      V_DOC_CLI_NOM        => I_DOCU_PROV_NOM,
                                                      V_DOC_CLI_DIR        => I_S_DIRECCION,
                                                      V_DOC_CLI_RUC        => I_DOCU_PROV_RUC,
                                                      V_DOC_CLI_TEL        => I_S_TELEF,
                                                      V_DOC_FEC_OPER       => I_DOCU_FEC_OPER,
                                                      V_DOC_FEC_DOC        => I_DOCU_FEC_EMIS,
                                                      V_DOC_BRUTO_EXEN_LOC => I_DOCU_EXEN_NETO_LOC,
                                                      V_DOC_BRUTO_EXEN_MON => I_DOCU_EXEN_NETO_MON,
                                                      V_DOC_BRUTO_GRAV_LOC => I_DOCU_GRAV_NETO_LOC,
                                                      V_DOC_BRUTO_GRAV_MON => I_DOCU_GRAV_NETO_MON,
                                                      V_DOC_NETO_EXEN_LOC  => I_DOCU_EXEN_NETO_LOC,
                                                      V_DOC_NETO_EXEN_MON  => I_DOCU_EXEN_NETO_MON,
                                                      V_DOC_NETO_GRAV_LOC  => I_DOCU_GRAV_NETO_LOC,
                                                      V_DOC_NETO_GRAV_MON  => I_DOCU_GRAV_NETO_MON,
                                                      V_DOC_IVA_LOC        => I_DOCU_IVA_LOC,
                                                      V_DOC_IVA_MON        => I_DOCU_IVA_MON,
                                                      V_DOC_OBS            => I_DOCU_OBS,
                                                      V_DOC_CLAVE_STK      => O_DOC_CLAVE_STK,
                                                      V_DOC_IND_CUOTA      => V_IND_CUOTA,
                                                      V_DOC_LOGIN          => V_USER,
                                                      V_DOC_FEC_GRAB       => SYSDATE,
                                                      V_DOC_SIST           => 'COM',
                                                      V_DOC_SISTEMA_AUX    => 'COMI001',
                                                      V_DOC_OPERADOR       => I_DOC_OPERADOR,
                                                      V_DOC_IVA_10_LOC     => I_DOC_IVA_10_LOC,
                                                      V_DOC_IVA_10_MON     => I_DOC_IVA_10_MON,
                                                      V_DOC_IVA_5_LOC      => I_DOC_IVA_5_LOC,
                                                      V_DOC_IVA_5_MON      => I_DOC_IVA_5_MON,
                                                      V_DOC_GRAV_10_LOC    => I_DOC_GRAV_10_LOC,
                                                      V_DOC_GRAV_10_MON    => I_DOC_GRAV_10_MON,
                                                      V_DOC_GRAV_5_MON     => I_DOC_GRAV_5_MON,
                                                      V_DOC_GRAV_5_LOC     => I_DOC_GRAV_5_LOC,
                                                      V_DOC_TIMBRADO       => I_DOC_TIMBRADO,
                                                      V_DOC_RUC_DV         => I_DOC_RUC_DV,
                                                      V_DOC_DV             => I_DOC_DV,
                                                      --V_DOC_ORDEN_COMPRA   => I_OCOM_CLAVE,
                                                      V_CLAVE_TMP          => O_DOC_CLAVE,
                                                      V_TIPO_DOC_PRO_CLI   => I_TIPO_DOC_PRO_CLI,
                                                      V_TIPO_FACTURA       => V('P1313_DOCU_TIPO_FAC'));
    END;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_eRROR(-20001,
                              'Error en PP_ACTUALIZAR_DOCUMENTO_FIN ' ||
                              SQLERRM);
  END PP_ACTUALIZAR_DOCUMENTO_FIN;

  PROCEDURE PP_ACTUALIZAR_DOC_RETEN(I_EMPRESA             IN FIN_DOCUMENTO.DOC_EMPR%TYPE,
                                    I_SUCURSAL            IN FIN_DOCUMENTO.DOC_SUC%TYPE,
                                    I_S_NRO_RETENCION     IN FIN_DOCUMENTO.DOC_NRO_DOC%TYPE,
                                    I_S_TIMBRADO          IN FIN_DOCUMENTO.DOC_TIMBRADO%TYPE,
                                    DOCU_MON              IN FIN_DOCUMENTO.DOC_MON%TYPE,
                                    DOCU_PROV             IN FIN_DOCUMENTO.DOC_PROV%TYPE,
                                    DOCU_CLI              IN FIN_DOCUMENTO.DOC_CLI%TYPE,
                                    DOCU_PROV_NOM         IN FIN_DOCUMENTO.DOC_CLI_NOM%TYPE,
                                    DOCU_PROV_RUC         IN FIN_DOCUMENTO.DOC_CLI_RUC%TYPE,
                                    S_TELEF               IN FIN_DOCUMENTO.DOC_CLI_TEL%TYPE,
                                    S_DIRECCION           IN FIN_DOCUMENTO.DOC_CLI_DIR%TYPE,
                                    DOCU_FEC_OPER         IN FIN_DOCUMENTO.DOC_FEC_OPER%TYPE,
                                    DOCU_FEC_EMIS         IN FIN_DOCUMENTO.DOC_FEC_DOC%TYPE,
                                    S_RETEN_LOC           IN FIN_DOCUMENTO.DOC_NETO_EXEN_LOC%TYPE,
                                    S_RETEN_MON           IN FIN_DOCUMENTO.DOC_NETO_EXEN_MON%TYPE,
                                    DOCU_OBS              IN FIN_DOCUMENTO.DOC_OBS%TYPE,
                                    I_DOC_OPERADOR        IN FIN_DOCUMENTO.DOC_OPERADOR%TYPE,
                                    I_S_CTA_BCO           IN FIN_DOCUMENTO.DOC_CTA_BCO%TYPE,
                                    I_NUMERO_DOC          IN FIN_DOCUMENTO.DOC_NRO_DOC%TYPE,
                                    I_DOC_CLAVE_COMPRA    IN FIN_DOCUMENTO.DOC_CLAVE_PADRE%TYPE, --DATO DE LA FACTURA DE COMPRA
                                    I_CONF_TMOV_RETENCION IN FIN_CONFIGURACION.CONF_TMOV_RETENCION%TYPE,
                                    I_S_RETENCION_100     IN VARCHAR2,
                                    I_P_TABLAS            IN VARCHAR2,
                                    I_P_IMPRESORA         IN GEN_IMPRESORA.IMP_CODIGO%TYPE,
                                    I_TIPO_DOC_PRO_CLI    IN FIN_DOCUMENTO.DOC_TIPO_DOC_CLI_PROV%TYPE) IS
    V_DOC_CLAVE      NUMBER;
    V_DOC_TIPO_SALDO VARCHAR2(1);
    V_PROV_RUC_DV    NUMBER;
    V_PORC_RET       NUMBER;
    V_USER           VARCHAR2(20);
    V_RETEN_MON      NUMBER;
    V_RETEN_LOC      NUMBER;

  BEGIN
    V_DOC_CLAVE := FIN_SEQ_DOC_NEXTVAL;

    V_USER := NVL(SUBSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'),
                         INSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'), ':') + 1),
                  USER);

    SELECT TMOV_TIPO
      INTO V_DOC_TIPO_SALDO
      FROM GEN_TIPO_MOV
     WHERE TMOV_CODIGO = I_CONF_TMOV_RETENCION
       AND TMOV_EMPR = I_EMPRESA;

    FINI003.PP_MONTO_RETENCION(I_EMPRESA       => I_EMPRESA,
                               I_CLAVE_DOC     => I_DOC_CLAVE_COMPRA,
                               O_MONTO_RET_MON => V_RETEN_MON,
                               O_MONTO_RET_LOC => V_RETEN_LOC,
                               I_P_TABLA       => I_P_TABLAS,
                               I_FEC_RET       => DOCU_FEC_EMIS);

    /*RAISE_APPLICATION_ERROR(-20000,
    'I_DOC_CLAVE_COMPRA = '||I_DOC_CLAVE_COMPRA||' V_RETEN_MON = ' || V_RETEN_MON ||
    '  V_RETEN_LOC=' || V_RETEN_LOC);*/
    IF DOCU_MON = 2 THEN
      V_RETEN_MON := ROUND(V_RETEN_MON, 2); --MONEDA EXTRANJERA ES REDONDEADA
    ELSE
      V_RETEN_LOC := ROUND(V_RETEN_LOC, 0);
    END IF;

    BEGIN
      COM_DOC_RECIBIDOS_TABLAS.INSERTAR_DOCUMENTO_FIN_RET(V_TABLA              => I_P_TABLAS,
                                                          V_DOC_CLAVE          => V_DOC_CLAVE,
                                                          V_DOC_EMPR           => I_EMPRESA,
                                                          V_DOC_CTA_BCO        => I_S_CTA_BCO,
                                                          V_DOC_SUC            => I_SUCURSAL,
                                                          V_DOC_TIPO_MOV       => I_CONF_TMOV_RETENCION,
                                                          V_DOC_NRO_DOC        => I_S_NRO_RETENCION,
                                                          V_DOC_TIPO_SALDO     => V_DOC_TIPO_SALDO,
                                                          V_DOC_MON            => DOCU_MON,
                                                          V_DOC_PROV           => DOCU_PROV,
                                                          V_DOC_CLI            => DOCU_CLI,
                                                          V_DOC_CLI_NOM        => DOCU_PROV_NOM,
                                                          V_DOC_CLI_DIR        => S_DIRECCION,
                                                          V_DOC_CLI_RUC        => DOCU_PROV_RUC,
                                                          V_DOC_CLI_TEL        => S_TELEF,
                                                          V_DOC_FEC_OPER       => DOCU_FEC_OPER,
                                                          V_DOC_FEC_DOC        => DOCU_FEC_EMIS,
                                                          V_DOC_BRUTO_GRAV_LOC => 0,
                                                          V_DOC_BRUTO_GRAV_MON => 0,
                                                          V_DOC_NETO_GRAV_LOC  => 0,
                                                          V_DOC_NETO_GRAV_MON  => 0,
                                                          V_DOC_BRUTO_EXEN_LOC => V_RETEN_LOC,
                                                          V_DOC_BRUTO_EXEN_MON => V_RETEN_MON,
                                                          V_DOC_NETO_EXEN_LOC  => V_RETEN_LOC,
                                                          V_DOC_NETO_EXEN_MON  => V_RETEN_MON,
                                                          V_DOC_OBS            => DOCU_OBS,
                                                          V_DOC_CLAVE_PADRE    => I_DOC_CLAVE_COMPRA,
                                                          V_DOC_LOGIN          => V_USER,
                                                          V_DOC_FEC_GRAB       => SYSDATE,
                                                          V_DOC_SIST           => 'COM',
                                                          V_DOC_OPERADOR       => I_DOC_OPERADOR,
                                                          V_DOC_TIMBRADO       => I_S_TIMBRADO,
                                                          V_TIPO_DOC_PRO_CLI   => I_TIPO_DOC_PRO_CLI,
                                                          V_TIPO_FACTURA       => V('P1313_DOCU_TIPO_FAC'));

    END;

    DECLARE
      V_SUC_DESC VARCHAR2(20);
      V_CTO      NUMBER;
      V_CTA      NUMBER;
    BEGIN
      IF I_SUCURSAL = 1 THEN
        V_SUC_DESC := 'CENTRAL';
      ELSIF I_SUCURSAL = 2 THEN
        V_SUC_DESC := 'ASUNCION';
      ELSIF I_SUCURSAL = 3 THEN
        V_SUC_DESC := 'CONCEPCION';
      ELSIF I_SUCURSAL = 4 THEN
        V_SUC_DESC := 'LOMA';
      ELSIF I_SUCURSAL = 6 THEN
        V_SUC_DESC := 'SANTAROSA';
      ELSIF I_SUCURSAL = 7 THEN
        V_SUC_DESC := 'PEDRO_JUAN';
      ELSIF I_SUCURSAL = 8 THEN
        V_SUC_DESC := 'MISIONES';
      ELSIF I_SUCURSAL = 9 THEN
        --Esto es algo temporal, porque todavia no se creo el concepto para la suc9. 28/02/2020
        V_SUC_DESC := 'MISIONES';
      ELSIF I_SUCURSAL = 10 THEN
         V_SUC_DESC := 'CAACUPE';
      ELSIF I_SUCURSAL = 11 THEN
         V_SUC_DESC := 'CDE';
      END IF;

      GEN_EXEC_SELECT('SELECT CONF_CONC_RETEN_' || V_SUC_DESC ||
                      ' FROM FIN_CONFIGURACION WHERE CONF_EMPR=' ||
                      I_EMPRESA,
                      V_CTO);

      SELECT FCON_CLAVE_CTACO
        INTO V_CTA
        FROM FIN_CONCEPTO
       WHERE FCON_CLAVE = V_CTO
         AND FCON_EMPR = I_EMPRESA;
      BEGIN
        COM_DOC_RECIBIDOS_TABLAS.INSERTAR_DOC_CONCEPTO_RET(V_TABLA               => I_P_TABLAS,
                                                           V_DCON_CLAVE_DOC      => V_DOC_CLAVE,
                                                           V_DCON_ITEM           => 1,
                                                           V_DCON_CLAVE_CONCEPTO => V_CTO,
                                                           V_DCON_CLAVE_CTACO    => V_CTA,
                                                           V_DCON_TIPO_SALDO     => 'D',
                                                           V_DCON_EXEN_LOC       => V_RETEN_LOC,
                                                           V_DCON_EXEN_MON       => V_RETEN_MON,
                                                           V_DCON_GRAV_LOC       => 0,
                                                           V_DCON_GRAV_MON       => 0,
                                                           V_DCON_IVA_LOC        => 0,
                                                           V_DCON_IVA_MON        => 0,
                                                           V_DCON_OBS            => 'Ret. IVA NRO. ' ||
                                                           I_S_NRO_RETENCION,
                                                           V_DCON_EMPR           => I_EMPRESA);

      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20000,
                                  'ERROR AL INSERTAR CONCEPTO DE LA RETENCION');
      END;
    END;

    SELECT PROV_RUC_DV
      INTO V_PROV_RUC_DV
      FROM FIN_PROVEEDOR
     WHERE PROV_CODIGO = DOCU_PROV
       AND PROV_EMPR = I_EMPRESA;

    IF I_S_RETENCION_100 = 'S' THEN
      V_PORC_RET := 100;
    ELSE
      V_PORC_RET := 30;
    END IF;

    COM_DOC_RECIBIDOS_TABLAS.INSERTAR_FIN_RETENCION(V_TABLA                     => I_P_TABLAS,
                                                    V_RET_DOC_NRO               => I_NUMERO_DOC,
                                                    V_RET_DOC_FEC_DOC           => TO_DATE(DOCU_FEC_EMIS,
                                                                                           'dd/mm/yyyy'),
                                                    V_RET_CONTRIBUYENTE         => DOCU_PROV_NOM,
                                                    V_RET_TIPO_ID_CONTRIBUYENTE => 'RUC',
                                                    V_RET_ID_CONTRIBUYENTE      => V_PROV_RUC_DV,
                                                    V_RET_TOTAL                 => V_RETEN_LOC,
                                                    V_RET_ESTADO                => 'P',
                                                    V_RET_USER_EMIT             => V_USER,
                                                    V_RET_FEC_CONF              => NULL,
                                                    V_RET_USER_CONF             => NULL,
                                                    V_RET_DOC_CLAVE             => I_DOC_CLAVE_COMPRA,
                                                    V_RET_RET_CLAVE             => V_DOC_CLAVE,
                                                    V_RET_FECHA                 => DOCU_FEC_EMIS,
                                                    V_RET_JSON                  => NULL,
                                                    V_RET_FEC_GRAB              => SYSDATE,
                                                    V_RET_TIPO                  => 'I',
                                                    V_RET_PORCENTAJE            => V_PORC_RET,
                                                    V_RET_EMPR                  => I_EMPRESA);

    UPDATE GEN_IMPRESORA
       SET IMP_ULT_RETENCION = I_S_NRO_RETENCION
     WHERE IMP_CODIGO = I_P_IMPRESORA
       AND IMP_EMPR = I_EMPRESA;
  exception
    when others then

      raise_application_error(-20001,
                              'Error en PP_ACTUALIZAR_DOC_RETEN - ' ||
                              SQLCODE || ' -ERROR- ' || SQLERRM);

  END PP_ACTUALIZAR_DOC_RETEN;

  PROCEDURE PP_ACTUALIZAR_DOCUMENTO_STK(I_DOC_CLAVE_STK    IN STK_DOCUMENTO.DOCU_CLAVE%TYPE, --ES EL MISMO GENERADO POR COMI001.PP_ACTUALIZAR_DOCUMENTO_FIN  O_DOC_CLAVE_STK
                                        P_EMPRESA          IN STK_DOCUMENTO.DOCU_EMPR%TYPE,
                                        I_DOCU_CODIGO_OPER IN STK_DOCUMENTO.DOCU_CODIGO_OPER%TYPE,
                                        I_DOCU_NRO_DOC     IN STK_DOCUMENTO.DOCU_NRO_DOC%TYPE,
                                        I_DOC_TIMBRADO     IN STK_DOCUMENTO.DOCU_TIMBRADO%TYPE,
                                        P_SUCURSAL         IN STK_DOCUMENTO.DOCU_SUC_ORIG%TYPE,
                                        I_DOCU_DEP_ORIG    IN STK_DOCUMENTO.DOCU_DEP_ORIG%TYPE,
                                        I_DOCU_MON         IN STK_DOCUMENTO.DOCU_MON%TYPE,
                                        I_DOCU_PROV        IN STK_DOCUMENTO.DOCU_PROV%TYPE,
                                        I_DOC_CLI_NOM      IN STK_DOCUMENTO.DOCU_CLI_NOM%TYPE,
                                        I_DOCU_FEC_EMIS    IN STK_DOCUMENTO.DOCU_FEC_EMIS%TYPE,
                                        I_DOCU_TIPO_MOV    IN STK_DOCUMENTO.DOCU_TIPO_MOV%TYPE,
                                        --                                       I_DOC_IND_CUOTA      IN STK_DOCUMENTO.DOCU_CLAVE%TYPE,
                                        I_DOCU_OBS           IN STK_DOCUMENTO.DOCU_OBS%TYPE,
                                        I_DOC_OPERADOR       IN STK_DOCUMENTO.DOCU_OPERADOR%TYPE,
                                        I_DOCU_GRAV_NETO_MON IN STK_DOCUMENTO.DOCU_GRAV_NETO_MON%TYPE,
                                        I_DOCU_GRAV_NETO_LOC IN STK_DOCUMENTO.DOCU_GRAV_NETO_LOC%TYPE,
                                        I_DOCU_EXEN_NETO_MON IN STK_DOCUMENTO.DOCU_EXEN_NETO_MON%TYPE,
                                        I_DOCU_EXEN_NETO_LOC IN STK_DOCUMENTO.DOCU_EXEN_NETO_LOC%TYPE,
                                        I_DOCU_IVA_MON       IN STK_DOCUMENTO.DOCU_IVA_MON%TYPE,
                                        I_DOCU_IVA_LOC       IN STK_DOCUMENTO.DOCU_IVA_LOC%TYPE,
                                        I_DOCU_TASA_US       IN STK_DOCUMENTO.DOCU_TASA_US%TYPE,
                                        I_P_TABLAS           IN VARCHAR2,
                                        I_CLAVE_TMP          IN NUMBER DEFAULT NULL,
                                        I_TIPO_DOC_PRO_CLI   in NUMBER) IS
    SALIR EXCEPTION;
    V_USER VARCHAR2(20);
    -- V_COT_TASA NUMBER;
  BEGIN

    IF USER = 'APEX_PUBLIC_USER' THEN
      V_USER := SUBSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'),
                       INSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'), ':') + 1);
    ELSE
      V_USER := USER;
    END IF;

    IF I_DOC_CLAVE_STK IS NULL THEN
      RAISE SALIR;
    END IF;
    -- CALL THE PROCEDURE
    COM_DOC_RECIBIDOS_TABLAS.INSERTAR_DOCUMENTO_STK(V_TABLA                  => I_P_TABLAS,
                                                    V_DOCU_CLAVE             => I_DOC_CLAVE_STK,
                                                    V_DOCU_EMPR              => P_EMPRESA,
                                                    V_DOCU_CODIGO_OPER       => I_DOCU_CODIGO_OPER,
                                                    V_DOCU_NRO_DOC           => I_DOCU_NRO_DOC,
                                                    V_DOCU_SUC_ORIG          => P_SUCURSAL,
                                                    V_DOCU_DEP_ORIG          => I_DOCU_DEP_ORIG,
                                                    V_DOCU_SUC_DEST          => NULL,
                                                    V_DOCU_DEP_DEST          => NULL,
                                                    V_DOCU_MON               => I_DOCU_MON,
                                                    V_DOCU_PROV              => I_DOCU_PROV,
                                                    V_DOCU_CLI               => NULL,
                                                    V_DOCU_CLI_NOM           => I_DOC_CLI_NOM,
                                                    V_DOCU_CLI_RUC           => NULL,
                                                    V_DOCU_LEGAJO            => NULL,
                                                    V_DOCU_DPTO              => NULL,
                                                    V_DOCU_SECCION           => NULL,
                                                    V_DOCU_FEC_EMIS          => I_DOCU_FEC_EMIS,
                                                    V_DOCU_TIPO_MOV          => I_DOCU_TIPO_MOV,
                                                    V_DOCU_GRAV_NETO_LOC     => I_DOCU_GRAV_NETO_LOC,
                                                    V_DOCU_GRAV_NETO_MON     => I_DOCU_GRAV_NETO_MON,
                                                    V_DOCU_EXEN_NETO_LOC     => I_DOCU_EXEN_NETO_LOC,
                                                    V_DOCU_EXEN_NETO_MON     => I_DOCU_EXEN_NETO_MON,
                                                    V_DOCU_GRAV_BRUTO_LOC    => I_DOCU_GRAV_NETO_LOC,
                                                    V_DOCU_GRAV_BRUTO_MON    => I_DOCU_GRAV_NETO_MON,
                                                    V_DOCU_EXEN_BRUTO_LOC    => I_DOCU_EXEN_NETO_LOC,
                                                    V_DOCU_EXEN_BRUTO_MON    => I_DOCU_EXEN_NETO_MON,
                                                    V_DOCU_IVA_LOC           => I_DOCU_IVA_LOC,
                                                    V_DOCU_IVA_MON           => I_DOCU_IVA_MON,
                                                    V_DOCU_TASA_US           => I_DOCU_TASA_US,
                                                    V_DOCU_IND_CUOTA         => NULL,
                                                    V_DOCU_IND_CONSIGNACION  => NULL,
                                                    V_DOCU_OBS               => I_DOCU_OBS,
                                                    V_DOCU_CLAVE_PADRE       => NULL,
                                                    V_DOCU_NRO_LISTADO_AUD   => NULL,
                                                    V_DOCU_LOGIN             => V_USER,
                                                    V_DOCU_FEC_GRAB          => SYSDATE,
                                                    V_DOCU_SIST              => 'COM',
                                                    V_DOCU_OPERADOR          => I_DOC_OPERADOR,
                                                    V_DOCU_NRO_PED           => NULL,
                                                    V_DOCU_PORC_UTIL         => NULL,
                                                    V_DOCU_SERIE             => NULL,
                                                    V_DOCU_FORM              => 'COMI001',
                                                    V_DOCU_RCONDUCT_COD      => NULL,
                                                    V_DOCU_RTRANSP_COD       => NULL,
                                                    V_DOCU_RMAR_VEH_COD      => NULL,
                                                    V_DOCU_RCONDUCT_NOMB     => NULL,
                                                    V_DOCU_RCONDUCT_CI       => NULL,
                                                    V_DOCU_RCONDUCT_DIR      => NULL,
                                                    V_DOCU_PRE_COMPRA        => NULL,
                                                    V_DOCU_CLAVE_COMPRA      => NULL,
                                                    V_DOCU_DESTINO_USO       => NULL,
                                                    V_DOCU_CAMION            => NULL,
                                                    V_DOCU_IND_ORD_CARGA     => NULL,
                                                    V_DOCU_AUTORIZADO        => NULL,
                                                    V_DOCU_DEST_REPAR        => NULL,
                                                    V_DOCU_EST_TRASLADO      => NULL,
                                                    V_DOCU_OCARGA_LONDON     => NULL,
                                                    V_DOCU_MOT_NCR           => NULL,
                                                    V_DOCU_TIMBRADO          => I_DOC_TIMBRADO,
                                                    V_DOCU_TIPO_TRASLADO     => NULL,
                                                    V_DOCU_CLAVE_FIN         => NULL,
                                                    V_DOCU_FEC_FIN_TRANSLADO => NULL,
                                                    V_DOCU_KM_RECORRIDO      => NULL,
                                                    V_DOCU_VEH_MARCA         => NULL,
                                                    V_DOCU_VEH_CHAPA         => NULL,
                                                    V_DOCU_CLAVE_STOPES      => NULL,
                                                    V_DOCU_FEC_OPER          => NULL,
                                                    V_DOCU_NRO_DESPACHO      => NULL,
                                                    V_DOCU_CANAL             => NULL,
                                                    V_DOCU_CLI_HOLDING       => NULL,
                                                    V_DOCU_DEVOL_REPROC      => NULL,
                                                    V_DOCU_CARRETA_CHAPA     => NULL,
                                                    V_DOCU_PROF_PROV         => NULL,
                                                    V_DOCU_FINCLAVE_FLETE    => NULL,
                                                    V_DOCU_CLAVE_FAC_REM     => NULL,
                                                    V_CLAVE_TMP              => I_CLAVE_TMP,
                                                    V_TIPO_DOC_PRO_CLI       => I_TIPO_DOC_PRO_CLI,
                                                    V_TIPO_FACTURA           => V('P1313_DOCU_TIPO_FAC'));

  EXCEPTION
    WHEN SALIR THEN
      NULL;
  END;

  PROCEDURE PP_ACTUALIZAR_CUOTAS(I_CLAVE_FIN IN NUMBER,
                                 I_FEC_VTO   IN DATE,
                                 I_IMP_MON   IN NUMBER,
                                 I_IMP_LOC   IN NUMBER,
                                 I_EMPR      IN NUMBER,
                                 I_P_TABLAS  IN VARCHAR2) IS

  BEGIN
    COM_DOC_RECIBIDOS_TABLAS.INSERTAR_CUOTAS(V_TABLA         => I_P_TABLAS,
                                             V_CUO_CLAVE_DOC => I_CLAVE_FIN,
                                             V_CUO_FEC_VTO   => I_FEC_VTO,
                                             V_CUO_IMP_LOC   => I_IMP_LOC,
                                             V_CUO_IMP_MON   => I_IMP_MON,
                                             V_CUO_EMPR      => I_EMPR);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20003,
                              SQLERRM || ' ERROR AL INSERTAR FIN_CUOTA');
  END;

  PROCEDURE PP_ACTUALIZAR_DOC_DET_STK(I_DOCU_CLAVE      IN NUMBER,
                                      SEQ               IN NUMBER,
                                      DETA_ART          IN NUMBER,
                                      P_EMPRESA         IN NUMBER,
                                      DETA_CANT         IN NUMBER,
                                      DETA_IMP_NETO_LOC IN NUMBER,
                                      DETA_IMP_NETO_MON IN NUMBER,
                                      DETA_IMPU         IN VARCHAR2,
                                      DETA_IVA_LOC      IN NUMBER,
                                      DETA_IVA_MON      IN NUMBER,
                                      OCOM_CLAVE        IN NUMBER,
                                      SEQ_OCOMD         IN NUMBER,
                                      I_P_TABLAS        IN VARCHAR2,
                                      I_CLAVE_TMP       IN NUMBER DEFAULT NULL,
                                      ORD_COMP_CLAVE    IN NUMBER,
                                      ORD_COMP_ITEM     IN NUMBER) IS
  BEGIN

    COM_DOC_RECIBIDOS_TABLAS.INSERTAR_DOC_DET_STK(V_TABLA               => I_P_TABLAS,
                                                  V_DETA_CLAVE_DOC      => I_DOCU_CLAVE,
                                                  V_DETA_NRO_ITEM       => SEQ,
                                                  V_DETA_ART            => DETA_ART,
                                                  V_DETA_EMPR           => P_EMPRESA,
                                                  V_DETA_NRO_REM        => NULL,
                                                  V_DETA_CANT           => DETA_CANT,
                                                  V_DETA_IMP_NETO_LOC   => DETA_IMP_NETO_LOC,
                                                  V_DETA_IMP_NETO_MON   => DETA_IMP_NETO_MON,
                                                  V_DETA_IMPU           => DETA_IMPU,
                                                  V_DETA_IVA_LOC        => DETA_IVA_LOC,
                                                  V_DETA_IVA_MON        => DETA_IVA_MON,
                                                  V_DETA_PORC_DTO       => NULL,
                                                  V_DETA_IMP_BRUTO_LOC  => DETA_IMP_NETO_LOC,
                                                  V_DETA_IMP_BRUTO_MON  => DETA_IMP_NETO_MON,
                                                  V_DETA_CANT_REM       => NULL,
                                                  V_DETA_CANT_FACT      => NULL,
                                                  V_DETA_PERIODO        => NULL,
                                                  V_DETA_DESGLOZAR      => NULL,
                                                  V_DETA_ART_ENT        => NULL,
                                                  V_DETA_CLAVE_ENT_PROD => NULL,
                                                  V_DETA_NRO_FORMULA    => NULL,
                                                  V_DETA_FEC_PROC_COSTO => NULL,
                                                  V_DETA_PORC_NO_DESG   => NULL,
                                                  V_DETA_DESTINO_USO    => NULL,
                                                  V_DETA_OCOMD_CLAVE    => ORD_COMP_CLAVE, --OCOM_CLAVE,
                                                  V_DETA_OCOMD_NRO_ITEM => ORD_COMP_ITEM, --SEQ_OCOMD, POR SI SON DOS ORDENES DE COMPRA
                                                  V_DETA_NRO_LOTE       => NULL,
                                                  V_DETA_CANT_SALKG     => NULL,
                                                  V_DETA_CANT_ENTKG     => NULL,
                                                  V_DETA_MOT_NCR        => NULL,
                                                  V_DETA_CLAVE_CONCEPTO => NULL,
                                                  V_DETA_CLAVE_CANAL    => NULL,
                                                  V_DETA_PERIODO_OPER   => NULL,
                                                  V_CLAVE_TMP           => I_CLAVE_TMP);
  END;

  PROCEDURE PP_ACT_CTA_BAN(S_CH_EMIT_NRO IN NUMBER,
                           P_EMPRESA     IN NUMBER,
                           S_CTA_BCO     IN NUMBER,
                           S_BANCO       IN NUMBER --BBANCO.S_BANCO

                           ) IS
  BEGIN

    UPDATE FIN_CUENTA_BANCARIA
       SET CTA_ULT_NRO_CHEQUE = S_CH_EMIT_NRO
     WHERE CTA_EMPR = P_EMPRESA
       AND CTA_CODIGO = NVL(S_BANCO, S_CTA_BCO);

  END;

  PROCEDURE PP_ACTUALIZA_TRANS(S_CTA_BCO      IN NUMBER,
                               S_BANCO        IN NUMBER,
                               P_EMPRESA      IN NUMBER,
                               P_SUCURSAL     IN NUMBER,
                               S_CH_EMIT_NRO  IN NUMBER,
                               S_MON          IN NUMBER, --BBANCO.S_MON
                               DOC_FEC_OPER   IN DATE,
                               S_TOTAL_IMP    IN NUMBER, --BPIE2.S_TOTAL_IMP
                               S_TASA         IN NUMBER,
                               S_BENEFICIARIO IN VARCHAR2,
                               DOC_TIMBRADO   IN NUMBER) IS

    V_CLAVE       NUMBER(14);
    V_CLAVE_PADRE NUMBER(14);
    V_IMPO_LOC    NUMBER(20, 4);
    V_IMPO_MON    NUMBER(20, 4);
    V_USER        VARCHAR2(20);
  BEGIN

    --EN SISTEMA NO SE USO "COM", SE USO "FIN" PARA PODER BORRAR DESDE EL 2,3,30

    V_CLAVE       := FIN_SEQ_DOC_NEXTVAL;
    V_CLAVE_PADRE := V_CLAVE;

    IF S_TASA <> 1 THEN
      V_IMPO_LOC := S_TOTAL_IMP * S_TASA;
      V_IMPO_MON := S_TOTAL_IMP;
    ELSE
      V_IMPO_LOC := S_TOTAL_IMP;
      V_IMPO_MON := S_TOTAL_IMP;
    END IF;

    IF USER = 'APEX_PUBLIC_USER' THEN
      V_USER := SUBSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'),
                       INSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'), ':') + 1);
    ELSE
      V_USER := USER;
    END IF;

    INSERT INTO FIN_DOCUMENTO
      (DOC_CLAVE,
       DOC_EMPR,
       DOC_CTA_BCO,
       DOC_SUC,
       DOC_TIPO_MOV,
       DOC_NRO_DOC,
       DOC_TIPO_SALDO,
       DOC_MON,
       DOC_FEC_OPER,
       DOC_FEC_DOC,
       DOC_BRUTO_EXEN_LOC,
       DOC_BRUTO_EXEN_MON,
       DOC_BRUTO_GRAV_LOC,
       DOC_BRUTO_GRAV_MON,
       DOC_NETO_EXEN_LOC,
       DOC_NETO_EXEN_MON,
       DOC_NETO_GRAV_LOC,
       DOC_NETO_GRAV_MON,
       DOC_IVA_LOC,
       DOC_IVA_MON,
       DOC_BASE_IMPON_LOC,
       DOC_BASE_IMPON_MON,
       DOC_CLAVE_PADRE,
       DOC_LOGIN,
       DOC_FEC_GRAB,
       DOC_SIST,
       DOC_OPERADOR,
       DOC_TASA,
       DOC_IND_CANC_PMO,
       DOC_OBS,
       DOC_TIMBRADO,
       DOC_SISTEMA_AUX)
    VALUES
      (V_CLAVE,
       P_EMPRESA,
       S_CTA_BCO,
       P_SUCURSAL,
       12,
       S_CH_EMIT_NRO,
       'D',
       S_MON,
       DOC_FEC_OPER,
       DOC_FEC_OPER,
       0,
       0,
       0,
       0,
       V_IMPO_LOC,
       V_IMPO_MON,
       0,
       0,
       0,
       0,
       0,
       0,
       NULL,
       V_USER,
       SYSDATE,
       'FIN',
       '2',
       S_TASA,
       'N',
       S_BENEFICIARIO,
       DOC_TIMBRADO,
       'COMI001');

    INSERT INTO FIN_DOC_CONCEPTO
      (DCON_CLAVE_DOC,
       DCON_ITEM,
       DCON_CLAVE_CONCEPTO,
       DCON_CLAVE_CTACO,
       DCON_TIPO_SALDO,
       DCON_EXEN_LOC,
       DCON_EXEN_MON,
       DCON_GRAV_LOC,
       DCON_GRAV_MON,
       DCON_IVA_LOC,
       DCON_IVA_MON,
       DCON_EMPR)
    VALUES
      (V_CLAVE,
       1,
       1120,
       20,
       'D',
       V_IMPO_LOC,
       V_IMPO_MON,
       0,
       0,
       0,
       0,
       P_EMPRESA);

    V_CLAVE := FIN_SEQ_DOC_NEXTVAL;

    INSERT INTO FIN_DOCUMENTO
      (DOC_CLAVE,
       DOC_EMPR,
       DOC_CTA_BCO,
       DOC_SUC,
       DOC_TIPO_MOV,
       DOC_NRO_DOC,
       DOC_TIPO_SALDO,
       DOC_MON,
       DOC_FEC_OPER,
       DOC_FEC_DOC,
       DOC_BRUTO_EXEN_LOC,
       DOC_BRUTO_EXEN_MON,
       DOC_BRUTO_GRAV_LOC,
       DOC_BRUTO_GRAV_MON,
       DOC_NETO_EXEN_LOC,
       DOC_NETO_EXEN_MON,
       DOC_NETO_GRAV_LOC,
       DOC_NETO_GRAV_MON,
       DOC_IVA_LOC,
       DOC_IVA_MON,
       DOC_BASE_IMPON_LOC,
       DOC_BASE_IMPON_MON,
       DOC_CLAVE_PADRE,
       DOC_LOGIN,
       DOC_FEC_GRAB,
       DOC_SIST,
       DOC_OPERADOR,
       DOC_TASA,
       DOC_IND_CANC_PMO,
       DOC_OBS,
       DOC_TIMBRADO,
       DOC_SISTEMA_AUX)
    VALUES
      (V_CLAVE,
       P_EMPRESA,
       S_BANCO,
       P_SUCURSAL,
       13,
       S_CH_EMIT_NRO,
       'C',
       S_MON,
       DOC_FEC_OPER,
       DOC_FEC_OPER,
       0,
       0,
       0,
       0,
       V_IMPO_LOC,
       V_IMPO_MON,
       0,
       0,
       0,
       0,
       0,
       0,
       V_CLAVE_PADRE,
       V_USER,
       SYSDATE,
       'FIN',
       '2',
       S_TASA,
       'N',
       S_BENEFICIARIO,
       DOC_TIMBRADO,
       'COMI001');

    INSERT INTO FIN_DOC_CONCEPTO
      (DCON_CLAVE_DOC,
       DCON_ITEM,
       DCON_CLAVE_CONCEPTO,
       DCON_CLAVE_CTACO,
       DCON_TIPO_SALDO,
       DCON_EXEN_LOC,
       DCON_EXEN_MON,
       DCON_GRAV_LOC,
       DCON_GRAV_MON,
       DCON_IVA_LOC,
       DCON_IVA_MON,
       DCON_EMPR)
    VALUES
      (V_CLAVE,
       1,
       877,
       20,
       'C',
       V_IMPO_LOC,
       V_IMPO_MON,
       0,
       0,
       0,
       0,
       P_EMPRESA);

  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20000,
                              'Error al insertar la transferencia entre cajas');

  END;

  PROCEDURE PP_INSERTAR_CH_EMIT(W_CLAVE           IN NUMBER,
                                S_CH_EMIT_SERIE   IN VARCHAR2,
                                S_CH_EMIT_NRO     IN NUMBER,
                                CH_EMIT_FEC_VTO1  IN DATE,
                                S_CH_EMIT_IMPORTE IN NUMBER,
                                DOC_CLAVE         IN NUMBER,
                                S_BENEFICIARIO    IN VARCHAR2,
                                P_EMPRESA         IN NUMBER) IS

  BEGIN
    INSERT INTO FIN_CHEQUE_EMIT
      (CH_EMIT_CLAVE,
       CH_EMIT_SERIE,
       CH_EMIT_NRO,
       CH_EMIT_FEC_VTO,
       CH_EMIT_IMPORTE,
       CH_EMIT_CLAVE_FIN,
       CH_EMIT_BENEFICIARIO,
       CH_EMIT_EMPR,
       CH_EMIT_CLAVE_FIN_CAN)
    VALUES
      (W_CLAVE,
       S_CH_EMIT_SERIE,
       S_CH_EMIT_NRO,
       CH_EMIT_FEC_VTO1,
       S_CH_EMIT_IMPORTE,
       DOC_CLAVE,
       S_BENEFICIARIO,
       P_EMPRESA,
       DOC_CLAVE);

  END;

  PROCEDURE PP_CARGAR_DOC_IMG(P_EMPRESA          IN NUMBER,
                              P_SUCURSAL         IN NUMBER,
                              DOC_TIMBRADO       IN NUMBER, --:BDOC_FIN.DOC_TIMBRADO
                              DOC_NRO_DOC        IN NUMBER, --:BDOC_FIN.DOC_NRO_DOC
                              DOC_PROV           IN NUMBER, --:BDOC_FIN.DOC_PROV
                              DOC_FEC_DOC        IN DATE, --:BDOC_FIN.DOC_FEC_DOC
                              DOC_TIPO_MOV       IN NUMBER, --:BDOC_FIN.DOC_TIPO_MOV
                              DOC_MON            IN NUMBER, --:BDOC_FIN.DOC_MON
                              DOC_GRAV_10_MON    IN NUMBER, --:BDOC.DOC_GRAV_10_MON
                              DOC_GRAV_5_MON     IN NUMBER, --:BDOC.DOC_GRAV_5_MON
                              DOCU_EXEN_NETO_MON IN NUMBER, --:BDOC.DOCU_EXEN_NETO_MON
                              S_TOT_MON          IN NUMBER, --:BDOC.S_TOT_MON
                              DOC_CLAVE          IN NUMBER, --:BDOC_FIN.DOC_CLAVE
                              S_CTA_BCO          IN NUMBER, --:BDOC.S_CTA_BCO
                              V_FAC_IMAGEN_BLOB  IN BLOB,
                              V_FAC_MODIFICADO   IN VARCHAR2) IS
    V_USER      VARCHAR2(20);
    V_FAC_CLAVE NUMBER;
  BEGIN

    IF USER = 'APEX_PUBLIC_USER' THEN
      V_USER := SUBSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'),
                       INSTR(SYS_CONTEXT('USERENV', 'CLIENT_INFO'), ':') + 1);
    ELSE
      V_USER := USER;
    END IF;

    V_FAC_CLAVE := COM_SEQ_FAC_REC_NEXTVAL;

    INSERT INTO COM_FACTURA_REC
      (FAC_CLAVE,
       FAC_EMPR,
       FAC_SUC,
       FAC_NRO_TIMBRADO,
       FAC_NRO_DOC,
       FAC_PROV,
       FAC_FECHA,
       FAC_TIPO_MOV,
       FAC_MON,
       FAC_TOT_GR10_II,
       FAC_TOT_GR05_II,
       FAC_TOT_EXEN,
       FAC_TOT_MON,
       FAC_CLAVE_DOC_FIN,
       FAC_LOGIN,
       FAC_CTA_BCO_P,
       FAC_TIPO_IMAGEN,
       FAC_LOGIN_CONF_IM,
       FAC_VER_CONT,
       FAC_TIPO_FAC)
    VALUES
      (V_FAC_CLAVE,
       P_EMPRESA,
       P_SUCURSAL,
       DOC_TIMBRADO,
       DOC_NRO_DOC,
       DOC_PROV,
       DOC_FEC_DOC,
       DOC_TIPO_MOV,
       DOC_MON,
       DOC_GRAV_10_MON,
       DOC_GRAV_5_MON,
       DOCU_EXEN_NETO_MON,
       S_TOT_MON,
       DOC_CLAVE,
       V_USER,
       S_CTA_BCO,
       'C',
       V_USER,
       'N',
        V('P1313_DOCU_TIPO_FAC'));
    IF V_FAC_IMAGEN_BLOB IS NOT null then
      INSERT INTO COM_FACTURA_IMAGEN
        (FAC_CLAVE,
         FAC_ITEM,
         FAC_IMAGEN_BLOB,
         FAC_LOR,
         FAC_MODIFICADO,
         FAC_EMPR)
      VALUES
        (V_FAC_CLAVE,
         1,
         V_FAC_IMAGEN_BLOB,
         '10101',
         V_FAC_MODIFICADO,
         P_EMPRESA);
      
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'COM_FACTURA_REC' || SQLCODE || SQLERRM);
  END;

  PROCEDURE PP_ACTUALIZAR_DOC_CONCEPTO(APP_SESSION      IN NUMBER,
                                       APP_USER         IN VARCHAR2,
                                       P1387_S_TIMBRADO IN NUMBER,
                                       P_OPER           IN VARCHAR2,
                                       V_DOC_CLAVE      IN NUMBER,
                                       V_TASA           IN NUMBER,
                                       P_EMPRESA        IN NUMBER,
                                       O_P_WHERE_DCON   OUT VARCHAR2,
                                       I_P_TABLAS       IN VARCHAR2,
                                       I_CLAVE_TMP      IN NUMBER DEFAULT NULL,
                                       I_FECHA_DOC      IN DATE,
                                       P_PROVEEDOR      IN NUMBER) IS
    -----**

    CURSOR C IS
      SELECT NRO_ITEM,
             OPCION,
             CONCEPTO,
             OT,
             DCON_CUENTA,
             DCON_CANAL,
             DCON_DIV_CANAL,
             NRO_IMPORTACION,
             CANT,
             KM_ACTUAL,
             PREC_UNIT,
             (OBS || '-' || DESC_LARGA || '-' || CONT_DESC) OBS,
             (SELECT T.FCON_DESC
                FROM FIN_CONCEPTO T
               WHERE T.FCON_CLAVE = CLAVE_CONCEPTO
                 AND T.FCON_EMPR = P_EMPRESA) DESC_LARGA,
             OBS OBS_TXT,
             IND_TIPO_IVA_COMPRA,
             PC_DCTO,
             IMPU_PORC_BASE_IMPONIBLE,
             IMPU_PORCENTAJE,
             TOTAL,
             EXENTO,
             GRAVADO,
             IVA,
             ART,
             DCON_CLAVE_IMP,
             OCOM_CLAVE,
             OCOMD_NRO_ITEM,
             CLAVE_CTACO,
             CLAVE_CONCEPTO,
             IMP_AFECTA_COSTO,
             CANT_FAC_ANT,
             IND_RESPONSABLE_VIATICO
        FROM COMI001_DET_TMP
       WHERE SESSION_ID = APP_SESSION
         AND USUARIO = APP_USER
         AND TIMBRADO = P1387_S_TIMBRADO;

    V_ITEM                    NUMBER := 0;
    V_CONCEPTO                NUMBER; --CLAVE DEL CONCEPTO DE (M) MERCADER?A, DE (G) GASTO, DE (A) ACTIVO FIJO,DE (O) ORDENES DE TRABAJO
    V_CTACO                   NUMBER; --CLAVE DE LA CUENTA CONTABLE DEL V_CONCEPTO
    V_CONC_IMPU               NUMBER; --CLAVE DEL CONCEPTO PARA EL IMPUESTO 10%
    V_CTACO_IMPU              NUMBER; --CLAVE DE LA CUENTA CONTABLE DEL V_CONC_IMPU
    V_CONC_IMPU_5             NUMBER; --CLAVE DEL CONCEPTO PARA EL IMPUESTO 10%
    V_CTACO_IMPU_5            NUMBER; --CLAVE DE LA CUENTA CONTABLE DEL V_CONC_IMPU_5
    V_PORC_IVA_DET            NUMBER;
    V_TIPO_SALDO              VARCHAR2(1); --'D' = D?BITO (PARA LAS COMPRAS), --'C' = CR?DITO (PARA LAS DEVOLUCIONES)
    V_EXENTO_LOC              NUMBER;
    V_GRAVADO_LOC             NUMBER;
    V_IVA_LOC                 NUMBER;
    V_CLAVE_IMP               NUMBER;
    V_IND_TIPO_IVA            NUMBER(1);
    V_OCOMD_NRO_ITEM          NUMBER;
    V_OCOMD_CLAVE             NUMBER;
    V_DCON_TIPO_SALDO         VARCHAR2(1);
    V_DCON_CANT_COMB          NUMBER;
    V_DCON_KM_ACTUAL          NUMBER;
    V_DCON_CLAVE_CONCEPTO     NUMBER;
    V_DCON_CLAVE_CTACO        NUMBER;
    V_DCON_PORC_IVA           NUMBER;
    V_CONF_IND_INTEGRAR_STK   VARCHAR2(1);
    V_CONF_IND_INTEGRAR_PRD   VARCHAR2(1);
    V_CONF_IND_INTEGRAR_ACT   VARCHAR2(1);
    V_CONF_IND_CTACO_STK_CLAS VARCHAR2(1);
    V_CONF_CONC_MERC          NUMBER;
    V_CONF_CONC_OT            NUMBER;
    V_CONF_CONC_ACT           NUMBER;
    V_CONF_CONC_IMPU          NUMBER;
    V_CONF_CONC_IMPU_5        NUMBER;
    V_CONF_CONC_DEV_MERC      NUMBER;
    V_CONF_CONC_DEV_OT        NUMBER;
    V_CONF_CONC_DEV_IMPU      NUMBER;
    V_CONF_CONC_DEV_IMPU_5    NUMBER;
    X_CTACO_IMPU              NUMBER;
    X_CTACO_IMPU_5            NUMBER;
    X_CTACO_DEV_IMPU          NUMBER;
    X_CTACO_DEV_IMPU_5        NUMBER;

    V_KM_OBL VARCHAR2(1); ---- SI EL KM ES OBLIGATORIO Y SI ES ORDEN DE CARGA

  BEGIN
    -- PARA QUE IMPRIMA LOS GASTOS.
    O_P_WHERE_DCON := ' AND DCON_ITEM IN (0';

    SELECT CONF_IND_INTEGRAR_STK,
           CONF_IND_INTEGRAR_PRD,
           CONF_IND_INTEGRAR_ACT,
           CONF_CONC_MERC,
           CONF_CONC_OT,
           CONF_CONC_ACT,
           CONF_CONC_IMPU,
           CONF_CONC_IMPU_5,
           CONF_CONC_DEV_MERC,
           CONF_CONC_DEV_OT,
           CONF_CONC_DEV_IMPU,
           CONF_CONC_DEV_IMPU_5,
           CONF_IND_CTACO_STK_CLAS
      INTO V_CONF_IND_INTEGRAR_STK,
           V_CONF_IND_INTEGRAR_PRD,
           V_CONF_IND_INTEGRAR_ACT,
           V_CONF_CONC_MERC,
           V_CONF_CONC_OT,
           V_CONF_CONC_ACT,
           V_CONF_CONC_IMPU,
           V_CONF_CONC_IMPU_5,
           V_CONF_CONC_DEV_MERC,
           V_CONF_CONC_DEV_OT,
           V_CONF_CONC_DEV_IMPU,
           V_CONF_CONC_DEV_IMPU_5,
           V_CONF_IND_CTACO_STK_CLAS
      FROM COM_CONFIGURACION
     WHERE CONF_EMPR = P_EMPRESA;

    PP_BUSCAR_CTACO(I_CONCEPTO                => V_CONF_CONC_DEV_IMPU,
                    IO_CUENTA                 => X_CTACO_DEV_IMPU,
                    I_EMPRESA                 => P_EMPRESA,
                    I_OPCION                  => NULL,
                    I_CONF_IND_CTACO_STK_CLAS => V_CONF_IND_CTACO_STK_CLAS,
                    I_CONF_CONC_DEV_IMPU      => V_CONF_CONC_DEV_IMPU,
                    I_CONF_CONC_IMPU          => V_CONF_CONC_IMPU,
                    I_DETA_ART                => NULL,
                    I_ART_DESC                => NULL);

    PP_BUSCAR_CTACO(I_CONCEPTO                => V_CONF_CONC_DEV_IMPU_5,
                    IO_CUENTA                 => X_CTACO_DEV_IMPU_5,
                    I_EMPRESA                 => P_EMPRESA,
                    I_OPCION                  => NULL,
                    I_CONF_IND_CTACO_STK_CLAS => V_CONF_IND_CTACO_STK_CLAS,
                    I_CONF_CONC_DEV_IMPU      => V_CONF_CONC_DEV_IMPU,
                    I_CONF_CONC_IMPU          => V_CONF_CONC_IMPU,
                    I_DETA_ART                => NULL,
                    I_ART_DESC                => NULL);

    PP_BUSCAR_CTACO(I_CONCEPTO                => V_CONF_CONC_IMPU,
                    IO_CUENTA                 => X_CTACO_IMPU,
                    I_EMPRESA                 => P_EMPRESA,
                    I_OPCION                  => NULL,
                    I_CONF_IND_CTACO_STK_CLAS => V_CONF_IND_CTACO_STK_CLAS,
                    I_CONF_CONC_DEV_IMPU      => V_CONF_CONC_DEV_IMPU,
                    I_CONF_CONC_IMPU          => V_CONF_CONC_IMPU,
                    I_DETA_ART                => NULL,
                    I_ART_DESC                => NULL);

    PP_BUSCAR_CTACO(I_CONCEPTO                => V_CONF_CONC_IMPU_5,
                    IO_CUENTA                 => X_CTACO_IMPU_5,
                    I_EMPRESA                 => P_EMPRESA,
                    I_OPCION                  => NULL,
                    I_CONF_IND_CTACO_STK_CLAS => V_CONF_IND_CTACO_STK_CLAS,
                    I_CONF_CONC_DEV_IMPU      => V_CONF_CONC_DEV_IMPU,
                    I_CONF_CONC_IMPU          => V_CONF_CONC_IMPU,
                    I_DETA_ART                => NULL,
                    I_ART_DESC                => NULL);

    --SE ASIGNAN LA CLAVE DE CONCEPTO DE IMPUESTO, Y LA CTA.CONTABLE
    --DE DICHO CONCEPTO
    IF P_OPER = 'COMPRA' THEN
      V_TIPO_SALDO   := 'C';
      V_CONC_IMPU    := V_CONF_CONC_IMPU;
      V_CTACO_IMPU   := X_CTACO_IMPU;
      V_CONC_IMPU_5  := V_CONF_CONC_IMPU_5;
      V_CTACO_IMPU_5 := X_CTACO_IMPU_5;
    ELSE
      V_TIPO_SALDO   := 'D';
      V_CONC_IMPU    := V_CONF_CONC_DEV_IMPU;
      V_CTACO_IMPU   := X_CTACO_DEV_IMPU;
      V_CONC_IMPU_5  := V_CONF_CONC_DEV_IMPU_5;
      V_CTACO_IMPU_5 := X_CTACO_DEV_IMPU_5;
    END IF;

    --RECORRE CADA UNO DE LOS REGISTROS DEL DETALLE
    FOR V IN C LOOP

      V_CLAVE_IMP := NULL;

      IF V.OPCION = 'M' THEN
        IF P_OPER = 'COMPRA' THEN
          V_CONCEPTO       := V_CONF_CONC_MERC;
          V_OCOMD_CLAVE    := V.OCOM_CLAVE;
          V_OCOMD_NRO_ITEM := V.OCOMD_NRO_ITEM;
        ELSE
          V_CONCEPTO := V_CONF_CONC_DEV_MERC;
        END IF;
        PP_BUSCAR_CTACO(I_CONCEPTO                => V_CONCEPTO,
                        IO_CUENTA                 => V_CTACO,
                        I_EMPRESA                 => P_EMPRESA,
                        I_OPCION                  => V.OPCION,
                        I_CONF_IND_CTACO_STK_CLAS => V_CONF_IND_CTACO_STK_CLAS,
                        I_CONF_CONC_DEV_IMPU      => V_CONF_CONC_DEV_IMPU,
                        I_CONF_CONC_IMPU          => V_CONF_CONC_IMPU,
                        I_DETA_ART                => V.ART,
                        I_ART_DESC                => NULL);

      ELSIF V.OPCION = 'O' THEN
        IF P_OPER = 'COMPRA' THEN
          V_CONCEPTO := V_CONF_CONC_OT;
        ELSE
          V_CONCEPTO := V_CONF_CONC_DEV_OT;
        END IF;
        PP_BUSCAR_CTACO(I_CONCEPTO                => V_CONCEPTO,
                        IO_CUENTA                 => V_CTACO,
                        I_EMPRESA                 => P_EMPRESA,
                        I_OPCION                  => V.OPCION,
                        I_CONF_IND_CTACO_STK_CLAS => V_CONF_IND_CTACO_STK_CLAS,
                        I_CONF_CONC_DEV_IMPU      => V_CONF_CONC_DEV_IMPU,
                        I_CONF_CONC_IMPU          => V_CONF_CONC_IMPU,
                        I_DETA_ART                => NULL,
                        I_ART_DESC                => NULL);

      ELSIF V.OPCION = 'A' THEN
        V_CONCEPTO := V_CONF_CONC_ACT;
        PP_BUSCAR_CTACO(I_CONCEPTO                => V_CONCEPTO,
                        IO_CUENTA                 => V_CTACO,
                        I_EMPRESA                 => P_EMPRESA,
                        I_OPCION                  => V.OPCION,
                        I_CONF_IND_CTACO_STK_CLAS => V_CONF_IND_CTACO_STK_CLAS,
                        I_CONF_CONC_DEV_IMPU      => V_CONF_CONC_DEV_IMPU,
                        I_CONF_CONC_IMPU          => V_CONF_CONC_IMPU,
                        I_DETA_ART                => NULL,
                        I_ART_DESC                => NULL);

      ELSIF V.OPCION = 'G' THEN

       IF V.CLAVE_CTACO IS NULL THEN
          RAISE_APPLICATION_ERROR(-20001, 'La cuenta contable no puede ser nula');

       END IF;
        V_CONCEPTO       := V.CLAVE_CONCEPTO; --CONCEPTO;
        V_CTACO          := V.CLAVE_CTACO; --DCON_CUENTA;
        V_CLAVE_IMP      := V.DCON_CLAVE_IMP;
        V_OCOMD_CLAVE    := V.OCOM_CLAVE;
        V_OCOMD_NRO_ITEM := V.OCOMD_NRO_ITEM;
      END IF;

      V_PORC_IVA_DET := V.IMPU_PORCENTAJE;

      V_EXENTO_LOC   := ROUND(V.EXENTO * NVL(V_TASA, 1), 0);
      V_GRAVADO_LOC  := ROUND(V.GRAVADO * NVL(V_TASA, 1), 0);
      V_IVA_LOC      := ROUND(V.IVA * NVL(V_TASA, 1), 0);
      V_IND_TIPO_IVA := V.IND_TIPO_IVA_COMPRA;

      IF P_OPER = 'COMPRA' THEN
        V_DCON_TIPO_SALDO := 'C';
      ELSE
        V_DCON_TIPO_SALDO := 'D';
      END IF;

      IF V.OPCION = 'G' AND V.DESC_LARGA LIKE 'MOVIL%COMB%LUBRIC%' THEN
        V_DCON_CANT_COMB := V.CANT;
        V_DCON_KM_ACTUAL := V.KM_ACTUAL;
      END IF;

      ------------------EN LA ORDEN DE CARGA SE INSERTA EL KM RECORRIDO, NO TIENE NINGUNA VALIDACION, POR ESO ---***
      ---VERIFICAMOS ANTES DE GUARDAR..
      --raise_application_error(-20010,V.DESC_LARGA );
      IF V.OPCION = 'G' AND P_EMPRESA = 1 AND
         V.DESC_LARGA LIKE '%MOV%COMB%' THEN

        V_DCON_CANT_COMB := V.CANT;
        V_DCON_KM_ACTUAL := V.KM_ACTUAL; ----------***estos
        BEGIN
   --  RAISE_APPLICATION_ERROR(-20002,'I');
          -- CAMBIO JB 21/05/2021

         /* SELECT A.RHA_VEH_KM_OBLIG
            INTO V_KM_OBL
            FROM STK_VEHICULO_HILAGRO A
           WHERE A.RHA_VEH_EMPR = P_EMPRESA
             AND A.RHA_VEH_COD =
             AND a.rha_veh_suc <> 2;*/

            SELECT B.RMAR_VEH_KM_OBLIG
            INTO V_KM_OBL
           FROM STK_REMI_VEHICULO B
            WHERE B.RMAR_EMPR = P_EMPRESA
              AND B.RMAR_VEH_COD =  (SELECT FCON_MOVIL
                    FROM FIN_CONCEPTO T
                   WHERE FCON_EMPR = P_EMPRESA
                     AND UPPER(FCON_DESC) LIKE '%MOV%COMB%'
                     AND FCON_CLAVE = V.CLAVE_CONCEPTO) --AND FCON_CODIGO = P_CONCEPTO)
             AND B.RMAR_SUC <> 2;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            V_KM_OBL := 'N';
        END;

        IF V_KM_OBL = 'S' THEN
          PP_VALIDAR_KM_OBLI(P_EMPRESA     => P_EMPRESA,
                             P_CONCEPTO    => V.CLAVE_CONCEPTO,
                             P_CANT_LITROS => V_DCON_CANT_COMB,
                             P_KM_REC      => V_DCON_KM_ACTUAL,
                             P_OPCION      => 'G',
                             P_FECHA_DOC   => I_FECHA_DOC,
                             P_FAC_ANT     => V.CANT_FAC_ANT,
                             P_PROVEEDOR   => P_PROVEEDOR);

        END IF;

      END IF;

      ------------------------------------------------------------------------------------------------------------------***

      V_ITEM := V_ITEM + 1;

      IF V.OPCION = 'G' THEN
        DECLARE
          CURSOR C_LINEA IS
            SELECT SEQ_ID SEQ
              FROM APEX_COLLECTIONS
             WHERE COLLECTION_NAME = 'DET_LINEA'
               AND C003 = V.NRO_ITEM;

        BEGIN
          FOR R IN C_LINEA LOOP
            APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DET_LINEA',
                                                    P_SEQ             => R.SEQ,
                                                    P_ATTR_NUMBER     => 3,
                                                    P_ATTR_VALUE      => V_ITEM);

          END LOOP;

        END;
      END IF;
      --------aca podes ingresar el campo responsable
      COM_DOC_RECIBIDOS_TABLAS.INSERTAR_DOC_CONCEPTO(V_TABLA                    => I_P_TABLAS,
                                                     V_DCON_CLAVE_DOC           => V_DOC_CLAVE,
                                                     V_DCON_ITEM                => V_ITEM,
                                                     V_DCON_CLAVE_CONCEPTO      => V_CONCEPTO,
                                                     V_DCON_CLAVE_CTACO         => V_CTACO,
                                                     V_DCON_TIPO_SALDO          => V_DCON_TIPO_SALDO,
                                                     V_DCON_EXEN_LOC            => NVL(V_EXENTO_LOC,
                                                                                       0),
                                                     V_DCON_EXEN_MON            => NVL(V.EXENTO,
                                                                                       0),
                                                     V_DCON_GRAV_LOC            => NVL(V_GRAVADO_LOC,
                                                                                       0),
                                                     V_DCON_GRAV_MON            => NVL(V.GRAVADO,
                                                                                       0),
                                                     V_DCON_IVA_LOC             => 0,
                                                     V_DCON_IVA_MON             => 0,
                                                     V_DCON_CLAVE_IMP           => V_CLAVE_IMP,
                                                     V_DCON_IND_TIPO_IVA_COMPRA => V_IND_TIPO_IVA,
                                                     V_DCON_OBS                 => V.OBS_TXT,
                                                     V_DCON_PORC_IVA            => V_PORC_IVA_DET,
                                                     V_DCON_IND_IMAGRO          => NULL,
                                                     V_DCON_CANAL               => NULL,
                                                     V_DCON_DIV_CANAL           => V.DCON_DIV_CANAL,
                                                     V_DCON_CANT_COMB           => V_DCON_CANT_COMB,
                                                     V_DCON_KM_ACTUAL           => V_DCON_KM_ACTUAL,
                                                     V_DCON_OCOMD_CLAVE         => V_OCOMD_CLAVE,
                                                     V_DCON_OCOMD_NRO_ITEM      => V_OCOMD_NRO_ITEM,
                                                     V_DCON_EMPR                => P_EMPRESA,
                                                     V_DCON_OCOMD_PORC          => NULL,
                                                     V_DCON_IMP_AFECTA_COSTO    => V.IMP_AFECTA_COSTO,
                                                     V_CLAVE_TMP                => I_CLAVE_TMP,
                                                     V_DCON_CANAL_BETA          => V.DCON_CANAL,
                                                     V_DCON_IND_VIATICO         => V.IND_RESPONSABLE_VIATICO);

      ----
      COM_DOC_RECIBIDOS_TABLAS.INSERTAR_LINEA_TMP(I_CLAVE_TMP,
                                                  V_ITEM,
                                                  P_EMPRESA);
  
      --RAISE_APPLICATION_ERROR(-20002,'I');
 
      IF V.OPCION = 'G' THEN
        -- SE VAN AGREGANDO LOS NUMEROS DE ITEM DE LOS CONCEPTOS DE GASTOS
        -- PARA DESPUES ENVIAR AL REPORT Y QUE IMPRIMA.
        O_P_WHERE_DCON := O_P_WHERE_DCON || ',' || TO_CHAR(V_ITEM);
      END IF;
      -- CONCEPTO DE IMPUESTO.
      IF V.IVA <> 0 THEN

        IF V_PORC_IVA_DET = 10 THEN
          V_DCON_CLAVE_CONCEPTO := V_CONC_IMPU;
          V_DCON_CLAVE_CTACO    := V_CTACO_IMPU;
          V_DCON_PORC_IVA       := V_PORC_IVA_DET;
        ELSE
          V_DCON_CLAVE_CONCEPTO := V_CONC_IMPU_5;
          V_DCON_CLAVE_CTACO    := V_CTACO_IMPU_5;
          V_DCON_PORC_IVA       := V_PORC_IVA_DET;
        END IF;

        V_ITEM := V_ITEM + 1;
        --  RAISE_APPLICATION_ERROR(-20002,'I');
        --                                  V_IVA_LOC||' iva_mon '||           V.IVA);
        
        -- RAISE_APPLICATION_ERROR(-20002,'I');

        COM_DOC_RECIBIDOS_TABLAS.INSERTAR_DOC_CONCEPTO(V_TABLA                    => I_P_TABLAS,
                                                       V_DCON_CLAVE_DOC           => V_DOC_CLAVE,
                                                       V_DCON_ITEM                => V_ITEM,
                                                       V_DCON_CLAVE_CONCEPTO      => V_DCON_CLAVE_CONCEPTO,
                                                       V_DCON_CLAVE_CTACO         => V_DCON_CLAVE_CTACO,
                                                       V_DCON_TIPO_SALDO          => V_TIPO_SALDO,
                                                       V_DCON_EXEN_LOC            => 0,
                                                       V_DCON_EXEN_MON            => 0,
                                                       V_DCON_GRAV_LOC            => 0,
                                                       V_DCON_GRAV_MON            => 0,
                                                       V_DCON_IVA_LOC             => V_IVA_LOC,
                                                       V_DCON_IVA_MON             => V.IVA,
                                                       V_DCON_CLAVE_IMP           => NULL,
                                                       V_DCON_IND_TIPO_IVA_COMPRA => V_IND_TIPO_IVA,
                                                       V_DCON_OBS                 => V.OBS_TXT,
                                                       V_DCON_PORC_IVA            => V_DCON_PORC_IVA,
                                                       V_DCON_IND_IMAGRO          => NULL,
                                                       V_DCON_CANAL               => NULL,
                                                       V_DCON_DIV_CANAL           => NULL,
                                                       V_DCON_CANT_COMB           => NULL,
                                                       V_DCON_KM_ACTUAL           => NULL,
                                                       V_DCON_OCOMD_CLAVE         => V_OCOMD_CLAVE,
                                                       V_DCON_OCOMD_NRO_ITEM      => V_OCOMD_NRO_ITEM,
                                                       V_DCON_EMPR                => P_EMPRESA,
                                                       V_DCON_OCOMD_PORC          => NULL,
                                                       V_DCON_IMP_AFECTA_COSTO    => V.IMP_AFECTA_COSTO,
                                                       V_CLAVE_TMP                => I_CLAVE_TMP,
                                                       V_DCON_IND_VIATICO         => V.IND_RESPONSABLE_VIATICO);
                                                       

      END IF;

    END LOOP;

    O_P_WHERE_DCON := O_P_WHERE_DCON || ')';
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'PP_ACTUALIZAR_DOC_CONCEPTO' || SQLCODE ||
                              SQLERRM);
  END;

  PROCEDURE PP_GUARDAR_REGISTRO(I_DOCU_TIPO_MOV IN NUMBER,
                                I_P_OPER        IN VARCHAR2,
                                I_CTA_BCO       IN NUMBER,
                                I_BANCO         IN NUMBER,
                                --I_TOT_CHEQUE              IN NUMBER,
                                I_TOT_MON               IN NUMBER,
                                I_RETEN_MON             IN NUMBER,
                                I_EMPRESA               IN NUMBER,
                                I_USUARIO               IN VARCHAR2,
                                I_TMOV_TIPO_SALDO       IN VARCHAR2,
                                I_DOCU_PROV             IN NUMBER,
                                I_DOC_TIMBRADO          IN NUMBER,
                                I_DOCU_NRO_DOC          IN NUMBER,
                                I_CTA_DESC              IN VARCHAR2,
                                I_APP_SESSION           IN NUMBER,
                                I_TIMBRADO              IN NUMBER,
                                I_CONF_IND_INTEGRAR_PRD IN VARCHAR2,
                                I_CONF_FACT_CR_REC      IN NUMBER,
                                I_CONF_NOTA_CR_REC      IN NUMBER,
                                I_S_CREDITO             IN VARCHAR2,
                                I_CONF_IND_INTEGRAR_STK IN VARCHAR2,
                                I_DOCU_DEP_ORIG         IN NUMBER,
                                I_DOC_SERIE             IN VARCHAR2,
                                I_P_MON_LOC             IN NUMBER,
                                I_P_MON_US              IN NUMBER,
                                I_P_CANT_DECIMALES_US   IN NUMBER,
                                I_P_CANT_DECIMALES_LOC  IN NUMBER,
                                --I_DETA_IMP_NETO_LOC       IN NUMBER,
                                --I_OT_MON_COT              IN NUMBER,
                                I_DOCU_FEC_EMIS          IN DATE,
                                I_CONF_IND_INTEGRAR_ACT  IN VARCHAR2,
                                I_SUCURSAL               IN FIN_DOCUMENTO.DOC_SUC%TYPE,
                                I_DOCU_MON               IN FIN_DOCUMENTO.DOC_MON%TYPE,
                                I_DOCU_CLI               IN FIN_DOCUMENTO.DOC_CLI%TYPE,
                                I_DOCU_PROV_NOM          IN FIN_DOCUMENTO.DOC_CLI_NOM%TYPE,
                                I_DOCU_PROV_RUC          IN FIN_DOCUMENTO.DOC_CLI_RUC%TYPE,
                                I_S_TELEF                IN FIN_DOCUMENTO.DOC_CLI_TEL%TYPE,
                                I_S_DIRECCION            IN FIN_DOCUMENTO.DOC_CLI_DIR%TYPE,
                                I_DOC_RUC_DV             IN FIN_DOCUMENTO.DOC_RUC_DV%TYPE,
                                I_DOC_DV                 IN FIN_DOCUMENTO.DOC_DV%TYPE,
                                I_OCOM_CLAVE             IN VARCHAR2, -- FIN_DOCUMENTO.DOC_ORDEN_COMPRA%TYPE,
                                I_DOCU_FEC_OPER          IN FIN_DOCUMENTO.DOC_FEC_OPER%TYPE,
                                I_DOCU_GRAV_NETO_LOC     IN FIN_DOCUMENTO.DOC_NETO_GRAV_LOC%TYPE,
                                I_DOCU_GRAV_NETO_MON     IN FIN_DOCUMENTO.DOC_NETO_GRAV_MON%TYPE,
                                I_DOCU_EXEN_NETO_LOC     IN FIN_DOCUMENTO.DOC_NETO_EXEN_LOC%TYPE,
                                I_DOCU_EXEN_NETO_MON     IN FIN_DOCUMENTO.DOC_NETO_EXEN_MON%TYPE,
                                I_DOCU_IVA_LOC           IN FIN_DOCUMENTO.DOC_IVA_LOC%TYPE,
                                I_DOCU_IVA_MON           IN FIN_DOCUMENTO.DOC_IVA_MON%TYPE,
                                I_DOCU_OBS               IN FIN_DOCUMENTO.DOC_OBS%TYPE,
                                I_DOC_OPERADOR           IN FIN_DOCUMENTO.DOC_OPERADOR%TYPE,
                                I_DOC_GRAV_5_MON         IN FIN_DOCUMENTO.DOC_GRAV_5_MON%TYPE,
                                I_DOC_GRAV_5_LOC         IN FIN_DOCUMENTO.DOC_GRAV_5_LOC%TYPE,
                                I_DOC_GRAV_10_MON        IN FIN_DOCUMENTO.DOC_GRAV_10_MON%TYPE,
                                I_DOC_GRAV_10_LOC        IN FIN_DOCUMENTO.DOC_GRAV_10_LOC%TYPE,
                                I_DOC_IVA_5_MON          IN FIN_DOCUMENTO.DOC_IVA_5_MON%TYPE,
                                I_DOC_IVA_5_LOC          IN FIN_DOCUMENTO.DOC_IVA_5_LOC%TYPE,
                                I_DOC_IVA_10_MON         IN FIN_DOCUMENTO.DOC_IVA_10_MON%TYPE,
                                I_DOC_IVA_10_LOC         IN FIN_DOCUMENTO.DOC_IVA_10_LOC%TYPE,
                                I_S_CTA_BCO              IN FIN_DOCUMENTO.DOC_CTA_BCO%TYPE,
                                I_CONF_NOTA_DB_EMIT_PROV IN FIN_CONFIGURACION.CONF_NOTA_DB_EMIT_PROV%TYPE,
                                I_CREDITO                IN VARCHAR2,
                                O_W_FLAG_COMMIT          OUT VARCHAR2,
                                I_TASA                   IN NUMBER,
                                O_P_WHERE_DCON           OUT VARCHAR2,
                                I_PAGO_BANCO             IN VARCHAR2,
                                I_P_BANCO                IN VARCHAR2,
                                I_CONF_FACT_COMPRA       IN NUMBER,
                                I_P_TABLAS               IN VARCHAR2,
                                I_DOC_CLI_NOM            IN VARCHAR2,
                                I_CONF_PER_ACT_INI       IN DATE,
                                I_CONF_PER_SGTE_FIN      IN DATE,
                                O_DOC_CLAVE              OUT NUMBER,
                                O_DOC_CLAVE_STK          OUT NUMBER,
                                I_RETEN_LOC              IN NUMBER,
                                I_NRO_RETENCION          IN VARCHAR2,
                                I_CONF_TMOV_RETENCION    IN NUMBER,
                                I_RETENCION_100          IN VARCHAR2) IS
    V_CANT_IMAGEN        NUMBER;
    V_TOT_CHEQUE         NUMBER;
    V_SALARIO_MIN        NUMBER;
    V_TOTAL_AUTO_FAC     NUMBER;
    V_MONTO_ACT          NUMBER;
    V_TOTAL_AUT_TEMP     NUMBER;
    V_TOTAL_AUTO_FACTURA NUMBER;
    TOTAL_AUTO_FAC_ANHO  NUMBER;
    V_TIPO_DOC           NUMBER;
    
    V_RUC_DV             VARCHAR2(100);
    V_DV                 VARCHAR2(100);
  BEGIN

    SELECT PROV_DOC_TIPO, 
           P.PROV_RUC_DV,  
           CASE WHEN PROV_DOC_TIPO = 2 THEN
                     P.PROV_DV
                 ELSE
                  NULL
                  
              END 
      INTO V_TIPO_DOC, V_RUC_DV, V_DV 
      FROM FIN_PROVEEDOR P
     WHERE PROV_CODIGO = I_DOCU_PROV
       AND PROV_EMPR = I_EMPRESA
       AND PROV_EST_PROV = 'A';

       IF V_TIPO_DOC  IS NULL AND I_EMPRESA IN (1,2) THEN
        RAISE_APPLICATION_ERROR (-20001,'!FAVOR, CONFIGURAR EL TIPO DE DOCUMENTO DEL PROVEEDOR ANTES DE CONTINUAR- PROG 2-1-25!');


       END IF;
       
     IF V_TIPO_DOC = 2 AND V_DV IS NULL THEN
        RAISE_APPLICATION_ERROR (-20001,'!FAVOR, FALTA CORREGIR EL RUC DEL PROVEEDOR - PROG 2-1-25!');

     END IF;
----RAISE_APPLICATION_ERROR (-20001,V_TIPO_DOC);
  IF I_EMPRESA = 1 THEN
   ---Validacion solicitada por DAVID MORALES 05/06/2021    --ERDM
    BEGIN
      -- CALL THE PROCEDURE
      PP_VALIDAR_DOC_EXIST(I_DOCU_NRO_DOC  => I_DOCU_NRO_DOC,
                           I_EMPRESA       => I_EMPRESA,
                           I_DOC_TIMBRADO  => I_DOC_TIMBRADO,
                           I_DOCU_PROV     => I_DOCU_PROV,
                           I_DOCU_TIPO_MOV => I_DOCU_TIPO_MOV);
    END;
   -----------
   END IF;

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUE_COMI001') THEN
      BEGIN
        SELECT SUM(N001)
          INTO V_TOT_CHEQUE
          FROM APEX_COLLECTIONS
         WHERE COLLECTION_NAME = 'CHEQUE_COMI001';
      EXCEPTION
        WHEN OTHERS THEN
          V_TOT_CHEQUE := 0;
      END;
    ELSE
      V_TOT_CHEQUE := 0;
    END IF;

    IF I_DOCU_TIPO_MOV IN (7, 31) THEN

      IF I_EMPRESA != 3 THEN
        IF I_P_OPER = 'COMPRA' THEN
          IF I_CTA_BCO IS NOT NULL THEN
            IF I_BANCO IS NOT NULL THEN

              IF NVL(V_TOT_CHEQUE, 0) > (I_TOT_MON - NVL(I_RETEN_MON, 0)) OR
                 NVL(V_TOT_CHEQUE, 0) < (I_TOT_MON - NVL(I_RETEN_MON, 0)) THEN
                RAISE_APPLICATION_ERROR(-20002,
                                        'La sumatoria de los cheques debe ser igual al monto del documento!.');
              END IF;

              IF V_TOT_CHEQUE = 0 OR V_TOT_CHEQUE IS NULL THEN
                RAISE_APPLICATION_ERROR(-20002,
                                        'Debe cargar los datos del/los cheque/s!.');
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;

      IF I_CTA_BCO IS NOT NULL THEN
        FACI039.PL_VALIDAR_OPCTA(P_CTA       => I_CTA_BCO,
                                 P_EMPRESA   => I_EMPRESA,
                                 P_LOGIN     => I_USUARIO,
                                 P_CTA_DESC  => I_CTA_DESC,
                                 P_OPERACION => I_TMOV_TIPO_SALDO,
                                 P_PROGRAMA  => 'COMI001');
      END IF;

      IF I_DOCU_PROV IS NOT NULL THEN
        PP_VALIDAR_DOC_EXIST(I_DOCU_NRO_DOC  => I_DOCU_NRO_DOC,
                             I_EMPRESA       => I_EMPRESA,
                             I_DOC_TIMBRADO  => I_DOC_TIMBRADO,
                             I_DOCU_PROV     => I_DOCU_PROV,
                             I_DOCU_TIPO_MOV => I_DOCU_TIPO_MOV);
      END IF;

      /**** ---LIMITAR AUTOFACTURAS EN UN MISMO MES NO PUEDE SUPERAR UN SUELDO MINIMO POR PERSONA '10/09/2019'-----*****/
      IF I_DOCU_TIPO_MOV = 7 AND I_EMPRESA = 1 THEN
        
       IF I_DOCU_GRAV_NETO_MON > 0 THEN
         RAISE_APPLICATION_ERROR (-20001, 'El Tipo de movimiento es exento!');
       END IF;
        SELECT CONF_SALARIO_MIN_VIG
          INTO V_SALARIO_MIN
          FROM PER_CONFIGURACION T
         WHERE CONF_EMPR = I_EMPRESA;

        ---PRIMERAMENTE REVISA SI AUN NO HA ALCANZADO LOS 6 SALARIOS MINIMOS ANUALES

        SELECT NVL(SUM(DOC_SALDO_LOC), 0)
          INTO TOTAL_AUTO_FAC_ANHO
          FROM FIN_DOCUMENTO
         WHERE DOC_TIPO_MOV = 7
           AND DOC_EMPR = I_EMPRESA
           AND DOC_PROV = I_DOCU_PROV
           AND TO_CHAR(DOC_FEC_DOC, 'yyyy') =
               TO_CHAR(TO_DATE(I_DOCU_FEC_EMIS), 'YYYY');

        ---SI HA ALCANZADO UN SALARIO MINIMO MENSUAL

        SELECT NVL(SUM(DOC_SALDO_LOC), 0)
          INTO V_TOTAL_AUTO_FAC
          FROM FIN_DOCUMENTO
         WHERE DOC_PROV = I_DOCU_PROV
           AND DOC_EMPR = I_EMPRESA
           AND DOC_TIPO_MOV = 7
           AND TO_CHAR(DOC_FEC_DOC, 'mm/yyyy') =
               TO_CHAR(TO_DATE(I_DOCU_FEC_EMIS), 'mm/yyyy');

        SELECT NVL(SUM(DOC_NETO_EXEN_LOC + DOC_NETO_GRAV_LOC + DOC_IVA_LOC),
                   0)
          INTO V_TOTAL_AUT_TEMP
          FROM FIN_DOCUMENTO_COMI015_TEMP
         WHERE DOC_PROV = I_DOCU_PROV
           AND DOC_EMPR = I_EMPRESA
           AND DOC_TIPO_MOV = 7
           AND COMI005_ESTADO IS NULL
           AND TO_CHAR(DOC_FEC_DOC, 'mm/yyyy') =
               TO_CHAR(TO_DATE(I_DOCU_FEC_EMIS), 'mm/yyyy');

        V_TOTAL_AUTO_FACTURA := V_TOTAL_AUTO_FAC + V_TOTAL_AUT_TEMP;

        IF TOTAL_AUTO_FAC_ANHO >= V_SALARIO_MIN * 6 THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'El proveedor alcanzo el limite para autofacturas del anho!.');
        ELSIF TOTAL_AUTO_FAC_ANHO + V_TOTAL_AUT_TEMP >= V_SALARIO_MIN * 6 THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'El proveedor alcanzo el limite para autofacturas del anho, y aun faltan algunos pendientes de aprobacion!.');
        END IF;

        IF V_TOTAL_AUTO_FAC >= V_SALARIO_MIN THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'El proveedor alcanzo el limite para autofacturas del mes!.');
        ELSIF V_TOTAL_AUTO_FACTURA >= V_SALARIO_MIN THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'El proveedor alcanzo el limite para autofacturas del mes, aun faltan pendientes de aprobacion!.');

        ELSIF (V_TOTAL_AUTO_FACTURA + (I_TOT_MON - NVL(I_RETEN_MON, 0))) >
              V_SALARIO_MIN THEN
          V_MONTO_ACT := (V_TOTAL_AUTO_FAC +
                         (I_TOT_MON - NVL(I_RETEN_MON, 0))) - V_SALARIO_MIN;

          RAISE_APPLICATION_ERROR(-20002,
                                  'La suma de autofacturas del mes, mas el total del documento
                                        supera el limite de autofacturas permitidas por mes!, por gs.' ||
                                  V_MONTO_ACT);
        END IF;

        BEGIN
          SELECT COUNT(1)
            INTO V_CANT_IMAGEN
            FROM APEX_COLLECTIONS
           WHERE COLLECTION_NAME = 'IMAGEN_COMI001';
        EXCEPTION
          WHEN OTHERS THEN
            V_CANT_IMAGEN := 0;
        END;

        IF V_CANT_IMAGEN = 0 AND I_EMPRESA = 1 THEN

          RAISE_APPLICATION_ERROR(-20002,
                                  'Es obligatorio el escaneo del documento');
        END IF;

        IF NVL(I_DOC_TIMBRADO, 0) = 0 AND I_EMPRESA = 1 THEN
          --Por alguna extra?a razon, a veces inserta null el timbrado con el tm 7. 15/04/2021
          raise_application_error(-20001,
                                  'El valor del timbrado es 0. Comuniquese con informatica');
        END IF;
      END IF;
      -------------------------------------------------HASTA AQUI '10/09/2019'

     -----VERFICAMOS EL NRO DE DOCUMENTO DEL PROVEEDOR


  




      PP_ACTUALIZAR_REGISTRO(I_APP_SESSION           => I_APP_SESSION,
                             I_USUARIO               => I_USUARIO,
                             I_TIMBRADO              => I_TIMBRADO,
                             I_CONF_IND_INTEGRAR_PRD => I_CONF_IND_INTEGRAR_PRD,
                             I_DOCU_TIPO_MOV         => I_DOCU_TIPO_MOV,
                             I_CONF_FACT_CR_REC      => I_CONF_FACT_CR_REC,
                             I_CONF_NOTA_CR_REC      => I_CONF_NOTA_CR_REC,
                             I_S_CREDITO             => I_S_CREDITO,
                             I_CONF_IND_INTEGRAR_STK => I_CONF_IND_INTEGRAR_STK,
                             I_DOCU_DEP_ORIG         => I_DOCU_DEP_ORIG,
                             I_DOC_SERIE             => I_DOC_SERIE,
                             I_EMPRESA               => I_EMPRESA,
                             I_P_MON_LOC             => I_P_MON_LOC,
                             I_P_MON_US              => I_P_MON_US,
                             I_P_CANT_DECIMALES_US   => I_P_CANT_DECIMALES_US,
                             I_P_CANT_DECIMALES_LOC  => I_P_CANT_DECIMALES_LOC,
                             --I_DETA_IMP_NETO_LOC      => I_DETA_IMP_NETO_LOC,
                             --I_OT_MON_COT             => I_OT_MON_COT,
                             I_DOCU_FEC_EMIS          => I_DOCU_FEC_EMIS,
                             I_TOT_MON                => I_TOT_MON,
                             I_CONF_IND_INTEGRAR_ACT  => I_CONF_IND_INTEGRAR_ACT,
                             I_SUCURSAL               => I_SUCURSAL,
                             I_DOCU_NRO_DOC           => I_DOCU_NRO_DOC,
                             I_DOCU_MON               => I_DOCU_MON,
                             I_DOCU_PROV              => I_DOCU_PROV,
                             I_DOCU_CLI               => I_DOCU_CLI,
                             I_DOCU_PROV_NOM          => I_DOCU_PROV_NOM,
                             I_DOCU_PROV_RUC          => I_DOCU_PROV_RUC,
                             I_S_TELEF                => I_S_TELEF,
                             I_S_DIRECCION            => I_S_DIRECCION,
                             I_DOC_RUC_DV             => I_DOC_RUC_DV,
                             I_DOC_DV                 => I_DOC_DV,
                             I_DOC_TIMBRADO           => I_DOC_TIMBRADO,
                             I_OCOM_CLAVE             => I_OCOM_CLAVE,
                             I_DOCU_FEC_OPER          => I_DOCU_FEC_OPER,
                             I_DOCU_GRAV_NETO_LOC     => NVL(I_DOCU_GRAV_NETO_LOC,
                                                             0),
                             I_DOCU_GRAV_NETO_MON     => NVL(I_DOCU_GRAV_NETO_MON,
                                                             0),
                             I_DOCU_EXEN_NETO_LOC     => NVL(I_DOCU_EXEN_NETO_LOC,
                                                             0),
                             I_DOCU_EXEN_NETO_MON     => NVL(I_DOCU_EXEN_NETO_MON,
                                                             0),
                             I_DOCU_IVA_LOC           => NVL(I_DOCU_IVA_LOC,
                                                             0),
                             I_DOCU_IVA_MON           => NVL(I_DOCU_IVA_MON,
                                                             0),
                             I_DOCU_OBS               => I_DOCU_OBS,
                             I_DOC_OPERADOR           => I_DOC_OPERADOR,
                             I_DOC_GRAV_5_MON         => NVL(I_DOC_GRAV_5_MON,
                                                             0),
                             I_DOC_GRAV_5_LOC         => NVL(I_DOC_GRAV_5_LOC,
                                                             0),
                             I_DOC_GRAV_10_MON        => NVL(I_DOC_GRAV_10_MON,
                                                             0),
                             I_DOC_GRAV_10_LOC        => NVL(I_DOC_GRAV_10_LOC,
                                                             0),
                             I_DOC_IVA_5_MON          => NVL(I_DOC_IVA_5_MON,
                                                             0),
                             I_DOC_IVA_5_LOC          => NVL(I_DOC_IVA_5_LOC,
                                                             0),
                             I_DOC_IVA_10_MON         => NVL(I_DOC_IVA_10_MON,
                                                             0),
                             I_DOC_IVA_10_LOC         => NVL(I_DOC_IVA_10_LOC,
                                                             0),
                             I_S_CTA_BCO              => I_S_CTA_BCO,
                             I_CONF_NOTA_DB_EMIT_PROV => I_CONF_NOTA_DB_EMIT_PROV,
                             I_CREDITO                => I_CREDITO,
                             O_W_FLAG_COMMIT          => O_W_FLAG_COMMIT,
                             I_TASA                   => I_TASA,
                             P_OPER                   => I_P_OPER,
                             O_P_WHERE_DCON           => O_P_WHERE_DCON,
                             I_PAGO_BANCO             => I_PAGO_BANCO,
                             I_TMOV_TIPO_SALDO        => I_TMOV_TIPO_SALDO,
                             I_P_BANCO                => I_P_BANCO,
                             I_CONF_FACT_COMPRA       => I_CONF_FACT_COMPRA,
                             I_P_TABLAS               => I_P_TABLAS,
                             I_DOC_CLI_NOM            => I_DOC_CLI_NOM,
                             I_CONF_PER_ACT_INI       => I_CONF_PER_ACT_INI,
                             I_CONF_PER_SGTE_FIN      => I_CONF_PER_SGTE_FIN,
                             O_DOC_CLAVE              => O_DOC_CLAVE,
                             O_DOC_CLAVE_STK          => O_DOC_CLAVE_STK,
                             I_RETEN_MON              => I_RETEN_MON,
                             I_RETEN_LOC              => I_RETEN_LOC,
                             I_NRO_RETENCION          => I_NRO_RETENCION,
                             I_CONF_TMOV_RETENCION    => I_CONF_TMOV_RETENCION,
                             I_RETENCION_100          => I_RETENCION_100,
                             I_TIPO_DOC_PRO_CLI       => V_TIPO_DOC);

    ELSE
      BEGIN
        SELECT COUNT(1)
          INTO V_CANT_IMAGEN
          FROM APEX_COLLECTIONS
         WHERE COLLECTION_NAME = 'IMAGEN_COMI001';
      EXCEPTION
        WHEN OTHERS THEN
          V_CANT_IMAGEN := 0;
      END;

      IF V_CANT_IMAGEN = 0 AND I_EMPRESA <> 2 THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Es obligatorio el escaneo del documento');

      ELSE
        IF I_EMPRESA != 3 THEN
          --SOLO CUANDO ES CEDEC
          IF I_P_OPER = 'COMPRA' THEN
            IF I_CTA_BCO IS NOT NULL THEN
              IF I_BANCO IS NOT NULL THEN
               null;

               IF NVL(V_TOT_CHEQUE, 0) > (I_TOT_MON - NVL(I_RETEN_MON, 0)) OR
                   NVL(V_TOT_CHEQUE, 0) < (I_TOT_MON - NVL(I_RETEN_MON, 0)) THEN
                  RAISE_APPLICATION_ERROR(-20002,
                                          'La sumatoria de los cheques debe ser igual al monto del documento!.');
                END IF;

                IF V_TOT_CHEQUE = 0 OR V_TOT_CHEQUE IS NULL THEN
                  RAISE_APPLICATION_ERROR(-20002,
                                          'Debe cargar los datos del/los cheque/s!.');
                END IF;

              END IF;
            END IF;
          END IF;
        END IF; --SOLO CUANDO ES CEDEC
        IF I_CTA_BCO IS NOT NULL THEN
          FACI039.PL_VALIDAR_OPCTA(P_CTA       => I_CTA_BCO,
                                   P_EMPRESA   => I_EMPRESA,
                                   P_LOGIN     => I_USUARIO,
                                   P_CTA_DESC  => I_CTA_DESC,
                                   P_OPERACION => I_TMOV_TIPO_SALDO,
                                   P_PROGRAMA  => 'COMI001');

        END IF;

        IF I_DOCU_PROV IS NOT NULL THEN
          PP_VALIDAR_DOC_EXIST(I_DOCU_NRO_DOC  => I_DOCU_NRO_DOC,
                               I_EMPRESA       => I_EMPRESA,
                               I_DOC_TIMBRADO  => I_DOC_TIMBRADO,
                               I_DOCU_PROV     => I_DOCU_PROV,
                               I_DOCU_TIPO_MOV => I_DOCU_TIPO_MOV);
        END IF;

        PP_ACTUALIZAR_REGISTRO(I_APP_SESSION           => I_APP_SESSION,
                               I_USUARIO               => I_USUARIO,
                               I_TIMBRADO              => I_TIMBRADO,
                               I_CONF_IND_INTEGRAR_PRD => I_CONF_IND_INTEGRAR_PRD,
                               I_DOCU_TIPO_MOV         => I_DOCU_TIPO_MOV,
                               I_CONF_FACT_CR_REC      => I_CONF_FACT_CR_REC,
                               I_CONF_NOTA_CR_REC      => I_CONF_NOTA_CR_REC,
                               I_S_CREDITO             => I_S_CREDITO,
                               I_CONF_IND_INTEGRAR_STK => I_CONF_IND_INTEGRAR_STK,
                               I_DOCU_DEP_ORIG         => I_DOCU_DEP_ORIG,
                               I_DOC_SERIE             => I_DOC_SERIE,
                               I_EMPRESA               => I_EMPRESA,
                               I_P_MON_LOC             => I_P_MON_LOC,
                               I_P_MON_US              => I_P_MON_US,
                               I_P_CANT_DECIMALES_US   => I_P_CANT_DECIMALES_US,
                               I_P_CANT_DECIMALES_LOC  => I_P_CANT_DECIMALES_LOC,
                               --I_DETA_IMP_NETO_LOC      => I_DETA_IMP_NETO_LOC,
                               --I_OT_MON_COT             => I_OT_MON_COT,
                               I_DOCU_FEC_EMIS          => I_DOCU_FEC_EMIS,
                               I_TOT_MON                => I_TOT_MON,
                               I_CONF_IND_INTEGRAR_ACT  => I_CONF_IND_INTEGRAR_ACT,
                               I_SUCURSAL               => I_SUCURSAL,
                               I_DOCU_NRO_DOC           => I_DOCU_NRO_DOC,
                               I_DOCU_MON               => I_DOCU_MON,
                               I_DOCU_PROV              => I_DOCU_PROV,
                               I_DOCU_CLI               => I_DOCU_CLI,
                               I_DOCU_PROV_NOM          => I_DOCU_PROV_NOM,
                               I_DOCU_PROV_RUC          => I_DOCU_PROV_RUC,
                               I_S_TELEF                => I_S_TELEF,
                               I_S_DIRECCION            => I_S_DIRECCION,
                               I_DOC_RUC_DV             => V_RUC_DV,---I_DOC_RUC_DV, V_RUC_DV, V_DV 
                               I_DOC_DV                 => V_DV,---I_DOC_DV,
                               I_DOC_TIMBRADO           => I_DOC_TIMBRADO,
                               I_OCOM_CLAVE             => I_OCOM_CLAVE,
                               I_DOCU_FEC_OPER          => I_DOCU_FEC_OPER,
                               I_DOCU_GRAV_NETO_LOC     => NVL(I_DOCU_GRAV_NETO_LOC,
                                                               0),
                               I_DOCU_GRAV_NETO_MON     => NVL(I_DOCU_GRAV_NETO_MON,
                                                               0),
                               I_DOCU_EXEN_NETO_LOC     => NVL(I_DOCU_EXEN_NETO_LOC,
                                                               0),
                               I_DOCU_EXEN_NETO_MON     => NVL(I_DOCU_EXEN_NETO_MON,
                                                               0),
                               I_DOCU_IVA_LOC           => NVL(I_DOCU_IVA_LOC,
                                                               0),
                               I_DOCU_IVA_MON           => NVL(I_DOCU_IVA_MON,
                                                               0),
                               I_DOCU_OBS               => I_DOCU_OBS,
                               I_DOC_OPERADOR           => I_DOC_OPERADOR,
                               I_DOC_GRAV_5_MON         => NVL(I_DOC_GRAV_5_MON,
                                                               0),
                               I_DOC_GRAV_5_LOC         => NVL(I_DOC_GRAV_5_LOC,
                                                               0),
                               I_DOC_GRAV_10_MON        => NVL(I_DOC_GRAV_10_MON,
                                                               0),
                               I_DOC_GRAV_10_LOC        => NVL(I_DOC_GRAV_10_LOC,
                                                               0),
                               I_DOC_IVA_5_MON          => NVL(I_DOC_IVA_5_MON,
                                                               0),
                               I_DOC_IVA_5_LOC          => NVL(I_DOC_IVA_5_LOC,
                                                               0),
                               I_DOC_IVA_10_MON         => NVL(I_DOC_IVA_10_MON,
                                                               0),
                               I_DOC_IVA_10_LOC         => NVL(I_DOC_IVA_10_LOC,
                                                               0),
                               I_S_CTA_BCO              => I_S_CTA_BCO,
                               I_CONF_NOTA_DB_EMIT_PROV => I_CONF_NOTA_DB_EMIT_PROV,
                               I_CREDITO                => I_CREDITO,
                               O_W_FLAG_COMMIT          => O_W_FLAG_COMMIT,
                               I_TASA                   => I_TASA,
                               P_OPER                   => I_P_OPER,
                               O_P_WHERE_DCON           => O_P_WHERE_DCON,
                               I_PAGO_BANCO             => I_PAGO_BANCO,
                               I_TMOV_TIPO_SALDO        => I_TMOV_TIPO_SALDO,
                               I_P_BANCO                => I_P_BANCO,
                               I_CONF_FACT_COMPRA       => I_CONF_FACT_COMPRA,
                               I_P_TABLAS               => I_P_TABLAS,
                               I_DOC_CLI_NOM            => I_DOC_CLI_NOM,
                               I_CONF_PER_ACT_INI       => I_CONF_PER_ACT_INI,
                               I_CONF_PER_SGTE_FIN      => I_CONF_PER_SGTE_FIN,
                               O_DOC_CLAVE              => O_DOC_CLAVE,
                               O_DOC_CLAVE_STK          => O_DOC_CLAVE_STK,
                               I_RETEN_MON              => I_RETEN_MON,
                               I_RETEN_LOC              => I_RETEN_LOC,
                               I_NRO_RETENCION          => I_NRO_RETENCION,
                               I_CONF_TMOV_RETENCION    => I_CONF_TMOV_RETENCION,
                               I_RETENCION_100          => I_RETENCION_100,
                               I_TIPO_DOC_PRO_CLI       => V_TIPO_DOC);

      END IF;

    END IF;
    PP_TERMINAR_PROCESO(I_SESSION_ID => I_APP_SESSION,
                        I_USUARIO    => I_USUARIO,
                        I_TIMBRADO   => I_TIMBRADO);
    IF I_DOCU_TIPO_MOV IN (1, 2, 14) THEN
      BEGIN

        UPDATE FIN_PROVEEDOR A
           SET A.PROV_TIMBRADO = I_DOC_TIMBRADO
         WHERE A.PROV_CODIGO = I_DOCU_PROV
           AND PROV_EMPR = I_EMPRESA;

      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001,
                                  'PP_GUARDAR_REGISTRO_TIMBRADO' || SQLCODE ||
                                  SQLERRM);
      END;

    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'PP_GUARDAR_REGISTRO' || SQLERRM);
  END PP_GUARDAR_REGISTRO;

  PROCEDURE PP_CALCULAR_VALORES(I_CANT_DECIMALES_LOC     IN NUMBER,
                                I_S_TASA                 IN NUMBER,
                                I_DOCU_EXEN_NETO_MON     IN NUMBER,
                                I_S_RETENCION_100        IN VARCHAR2,
                                I_DOCU_TIPO_MOV          IN NUMBER,
                                I_W_MON_DEC_IMP          IN NUMBER,
                                I_DOC_GRAV_10_MON        IN OUT NUMBER,
                                I_DOC_GRAV_10_LOC        IN OUT NUMBER,
                                I_DOC_IVA_10_MON         OUT NUMBER,
                                I_S_RETENCION            IN VARCHAR2,
                                I_MON_DEC_IMP            IN NUMBER,
                                P_EMPRESA                IN NUMBER,
                                I_DOCU_PROV              IN NUMBER,
                                I_S_DOCU_FEC_EMIS        IN DATE,
                                O_DOC_NETO_EXEN_LOC      OUT NUMBER,
                                O_DOCU_EXEN_NETO_LOC     OUT NUMBER,
                                O_DOC_GRAV_5_LOC         OUT NUMBER,
                                O_DOC_GRAV_5_MON         IN OUT NUMBER,
                                O_DOC_IVA_5_MON          OUT NUMBER,
                                O_DOC_IVA_5_LOC          OUT NUMBER,
                                O_DOCU_GRAV_NETO_MON     OUT NUMBER,
                                O_DOCU_GRAV_NETO_LOC     OUT NUMBER,
                                O_DOCU_IVA_MON           IN OUT NUMBER,
                                O_DOCU_IVA_LOC           IN OUT NUMBER,
                                O_DOC_IVA_10_LOC         OUT NUMBER,
                                O_S_RETEN_MON            OUT NUMBER,
                                O_S_RETEN_LOC            OUT NUMBER,
                                O_S_NRO_RETENCION_FORMAT OUT VARCHAR2,
                                O_S_NRO_RETENCION        OUT GEN_IMPRESORA.IMP_ULT_RETENCION%TYPE,
                                O_S_TOT_MON              OUT NUMBER,
                                O_S_TOT_LOC              OUT NUMBER,
                                O_S_PAGO                 OUT NUMBER) IS
    V_DIFERENCIA NUMBER := 0;

    V_RET_IVA_5 NUMBER;
    V_RET_IVA_10 NUMBER;
    V_TOT_MON_5 NUMBER:=0;
    V_TOT_MON_10 NUMBER:=0;
    V_GRAV_LOC_5 NUMBER:=0;
    V_IVA_LOC_5 NUMBER:=0;
    V_GRAV_LOC_10 NUMBER:=0;
    V_IVA_LOC_10 NUMBER:=0;
  BEGIN

    I_DOC_IVA_10_MON := 0;

    IF I_DOCU_EXEN_NETO_MON < 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'No puede ser negativo!');
    END IF;
    IF I_S_RETENCION_100 = 'S' AND I_DOCU_EXEN_NETO_MON = 0 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'El monto exento debe ser mayor a 0(cero) para proveedores del exterior!');
    END IF;
    O_DOC_NETO_EXEN_LOC  := ROUND((NVL(I_DOCU_EXEN_NETO_MON, 0) * I_S_TASA),
                                  I_CANT_DECIMALES_LOC);
    O_DOCU_EXEN_NETO_LOC := ROUND((NVL(I_DOCU_EXEN_NETO_MON, 0) * I_S_TASA),
                                  I_CANT_DECIMALES_LOC);

    IF O_DOC_GRAV_5_MON < 0 THEN
     /* O_DOC_IVA_5_MON  := ROUND((O_DOC_GRAV_5_MON * (-1)) -
                                ((O_DOC_GRAV_5_MON * (-1)) /
                                ((5 + 100) / 100)),
                                I_W_MON_DEC_IMP);
      O_DOC_GRAV_5_MON := ROUND(((O_DOC_GRAV_5_MON * (-1)) /
                                ((5 + 100) / 100)),
                                I_W_MON_DEC_IMP);*/

       O_DOC_IVA_5_MON  := ROUND((O_DOC_GRAV_5_MON * (-1))/((100 + 5)/5),I_W_MON_DEC_IMP);
       O_DOC_GRAV_5_MON := ROUND(((O_DOC_GRAV_5_MON * (-1))- NVL(O_DOC_IVA_5_MON,0)),I_W_MON_DEC_IMP);
       V_TOT_MON_5:=(NVL(O_DOC_GRAV_5_MON,0)+NVL(O_DOC_IVA_5_MON,0))*I_S_TASA;
    ELSE
      O_DOC_IVA_5_MON := ROUND(((O_DOC_GRAV_5_MON * NVL(5, 0)) / 100),I_W_MON_DEC_IMP);
      V_TOT_MON_5:=(NVL(O_DOC_GRAV_5_MON,0)+NVL(O_DOC_IVA_5_MON,0))*I_S_TASA;
    END IF;

    O_DOCU_GRAV_NETO_MON := NVL(O_DOC_GRAV_5_MON, 0) +
                            NVL(I_DOC_GRAV_10_MON, 0);

    /*O_DOC_GRAV_5_LOC := ROUND(NVL(O_DOC_GRAV_5_MON, 0) * NVL(I_S_TASA, 1),
                              I_CANT_DECIMALES_LOC);*/

      ---MVERA 17/12/2021 CAMBIOS DE FORMULA PARA LA EXTRACION DE IVA Y GRAVADA
    V_IVA_LOC_5:=ROUND(V_TOT_MON_5/((100 + 5)/5),I_CANT_DECIMALES_LOC);
    V_GRAV_LOC_5:=ROUND(NVL(V_TOT_MON_5,0)-NVL(V_IVA_LOC_5,0));
    O_DOC_GRAV_5_LOC :=V_GRAV_LOC_5;


    IF I_DOC_GRAV_10_MON IS NULL THEN
      I_DOC_GRAV_10_MON := 0;
    END IF;
    IF I_DOC_GRAV_10_MON < 0 THEN

     /* i_DOC_IVA_10_MON  := ROUND((I_DOC_GRAV_10_MON * (-1)) -
                                 ((I_DOC_GRAV_10_MON * (-1)) /
                                 ((10 + 100) / 100)),
                                 I_W_MON_DEC_IMP);
      I_DOC_GRAV_10_MON := ROUND(((I_DOC_GRAV_10_MON * (-1)) /
                                 ((10 + 100) / 100)),
                                 I_W_MON_DEC_IMP);*/

      I_DOC_IVA_10_MON  := ROUND(((I_DOC_GRAV_10_MON*(-1))/((100 + 10)/10)),I_W_MON_DEC_IMP);
      I_DOC_GRAV_10_MON := ROUND((I_DOC_GRAV_10_MON*(-1) - I_DOC_IVA_10_MON),I_W_MON_DEC_IMP);
      V_TOT_MON_10:=(NVL(I_DOC_GRAV_10_MON,0)+NVL(I_DOC_IVA_10_MON,0))*I_S_TASA;
    ELSE

       I_DOC_IVA_10_MON := ROUND(((I_DOC_GRAV_10_MON * 10) / 100),I_W_MON_DEC_IMP);
       V_TOT_MON_10:=(NVL(I_DOC_GRAV_10_MON,0)+NVL(I_DOC_IVA_10_MON,0))*I_S_TASA;
    END IF;
    ---mvera 17/12/2021 cambio de formula de extracion de gravaba e iva
     V_IVA_LOC_10:=ROUND(V_TOT_MON_10/((100 + 10)/10),I_CANT_DECIMALES_LOC);
     V_GRAV_LOC_10:=ROUND(NVL(V_TOT_MON_10,0)-NVL(V_IVA_LOC_10,0));
     I_DOC_GRAV_10_LOC :=V_GRAV_LOC_10;


    -- raise_application_error(-20001,V_IVA_LOC_10);
    /*I_DOC_GRAV_10_LOC    := ROUND((NVL(I_DOC_GRAV_10_MON, 0) * I_S_TASA),
                                  I_CANT_DECIMALES_LOC);*/



    O_DOCU_GRAV_NETO_LOC := NVL(O_DOC_GRAV_5_LOC, 0) +
                            NVL(I_DOC_GRAV_10_LOC, 0);
    O_DOCU_GRAV_NETO_MON := NVL(O_DOC_GRAV_5_MON, 0) +
                            NVL(I_DOC_GRAV_10_MON, 0);

    IF NVL(O_DOCU_IVA_MON, 0) = 0 THEN
      O_DOCU_IVA_MON := NVL(O_DOC_IVA_5_MON, 0) + NVL(I_DOC_IVA_10_MON, 0);

    END IF;

    O_S_RETEN_MON    := 0;
    V_DIFERENCIA     := NVL(O_DOCU_IVA_MON, 0) -
                        (NVL(O_DOC_IVA_5_MON, 0) + NVL(I_DOC_IVA_10_MON, 0));
    I_DOC_IVA_10_MON := NVL(I_DOC_IVA_10_MON, 0) + V_DIFERENCIA;

    IF O_DOCU_IVA_MON < 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'No puede ser negativo!');
    END IF;

    /*O_DOC_IVA_5_LOC := ROUND((NVL(O_DOC_GRAV_5_LOC, 0) * 5 / 100),
                             I_CANT_DECIMALES_LOC);*/

    O_DOC_IVA_5_LOC := ROUND(nvl(V_IVA_LOC_5,0), I_CANT_DECIMALES_LOC);



    --O_DOC_IVA_10_LOC := TRUNC((NVL(I_DOC_GRAV_10_LOC, 0) * 10 / 100));
    O_DOC_IVA_10_LOC:=TRUNC(NVL(V_IVA_LOC_10, 0));


    O_DOCU_IVA_LOC := round(NVL(V_IVA_LOC_5, 0) + NVL(V_IVA_LOC_10, 0),0);

    IF I_DOCU_TIPO_MOV IS NOT NULL THEN
      O_S_TOT_MON := NVL(I_DOCU_EXEN_NETO_MON, 0) +
                     NVL(O_DOCU_GRAV_NETO_MON, 0) + NVL(O_DOCU_IVA_MON, 0);
      O_S_TOT_LOC := NVL(O_DOCU_EXEN_NETO_LOC, 0) +
                     NVL(O_DOCU_GRAV_NETO_LOC, 0) + NVL(O_DOCU_IVA_LOC, 0);
    END IF;

    IF I_DOCU_TIPO_MOV = 1 THEN
      IF I_S_RETENCION = 'S' THEN
        IF I_S_RETENCION_100 = 'S' THEN
          O_S_RETEN_MON := ROUND((I_DOCU_EXEN_NETO_MON) / 11, I_MON_DEC_IMP);
          O_S_RETEN_LOC := ROUND(NVL(O_S_RETEN_MON, 0) * NVL(I_S_TASA, 1),
                                 I_CANT_DECIMALES_LOC);
        ELSE
          IF FIN_RETENER_IVA(P_MONTO_ACTUAL => O_DOCU_GRAV_NETO_LOC,
                             P_SUMA         => 'S',
                             P_PROVEEDOR    => I_DOCU_PROV,
                             P_MES_ANHO     => TO_CHAR(TO_DATE(I_S_DOCU_FEC_EMIS,
                                                               'dd/mm/yyyy'),
                                                       'mm/yyyy'),
                             P_DOC_CLAVE    => NULL,
                             P_EMPRESA      => P_EMPRESA) = 'S' THEN
            O_S_RETEN_MON := 0;
            O_S_RETEN_LOC := 0;

      /*    11/10/2021 LV, PEDIDO DEL SR JUAN BRASA
          configurar en proveedores porcentaje de retencion del IVA
          y que este a su vez cuando este cargado deje sin efecto
          las demas configuraciones para retencion*/

            /*
                SELECT NVL(A.PROV_RET_PROC_5, 30) / 100 RET_IVA_5,
                       NVL(A.PROV_RET_PROC_10, 70) / 100 RET_IVA_10
                  INTO V_RET_IVA_5,V_RET_IVA_10
                  FROM FIN_PROVEEDOR A
                 WHERE PROV_EMPR = P_EMPRESA
                   AND PROV_CODIGO = I_DOCU_PROV;*/


            -----***** IVA 10% CALCULA 70%
            IF NVL(O_DOC_IVA_10_LOC, 0) > 0 THEN
             O_S_RETEN_LOC := O_S_RETEN_LOC +
                               ROUND(O_DOC_IVA_10_LOC * 0.7, I_CANT_DECIMALES_LOC);
            /*
                O_S_RETEN_LOC := O_S_RETEN_LOC +
                               ROUND(O_DOC_IVA_10_LOC * V_RET_IVA_10, I_MON_DEC_IMP);  */
            END IF;

            IF NVL(I_DOC_IVA_10_MON, 0) > 0 THEN
              O_S_RETEN_MON := O_S_RETEN_MON +
                               ROUND(I_DOC_IVA_10_MON * 0.7, I_MON_DEC_IMP);
           /*    O_S_RETEN_MON := O_S_RETEN_MON +
                               ROUND(I_DOC_IVA_10_MON * V_RET_IVA_10, I_MON_DEC_IMP); */

            END IF;

            -----***** IVA 5% CALCULA 30%

            IF NVL(O_DOC_IVA_5_MON, 0) > 0 THEN
             O_S_RETEN_MON := O_S_RETEN_MON +
                               ROUND(O_DOC_IVA_5_MON * 0.3, I_MON_DEC_IMP);
          /*    O_S_RETEN_MON := O_S_RETEN_MON +
                               ROUND(O_DOC_IVA_5_MON *V_RET_IVA_5, I_MON_DEC_IMP);   */
            END IF;

            IF NVL(O_DOC_IVA_5_LOC, 0) > 0 THEN
              O_S_RETEN_LOC := O_S_RETEN_LOC +
                               ROUND(O_DOC_IVA_5_LOC * 0.3, I_CANT_DECIMALES_LOC);

             /*  O_S_RETEN_LOC := O_S_RETEN_LOC +
                               ROUND(O_DOC_IVA_5_LOC * V_RET_IVA_5, I_MON_DEC_IMP);  */
            END IF;

          END IF;
        END IF;
        COMI001.PP_BUSCAR_NRO_RETENCION(I_EMPRESA         => P_EMPRESA,
                                        O_S_NRO_RETENCION => O_S_NRO_RETENCION);

        O_S_NRO_RETENCION_FORMAT := FP_FORMATO_NRO_FAC(O_S_NRO_RETENCION);
      END IF;
    END IF;
    O_S_PAGO := O_S_TOT_MON - O_S_RETEN_MON;

    IF O_DOCU_IVA_LOC IS NULL THEN
      O_DOCU_IVA_LOC := 0;
    END IF;

    IF O_S_RETEN_LOC IS NULL THEN
      O_S_RETEN_LOC := 0;
    END IF;
    --

    /* POR SI ANTES YA SE HABIA INGRESADO ALGUNOS IMPORTES */
    /* REDONDEAR MONEDA EXTRANJERA A LA CANTIDAD DE DECIMALES */
    /* QUE LE CORRESPONDE YA QUE PUDO CAMBIARSE DE MONEDA */
    O_S_PAGO := ROUND(O_S_PAGO, I_MON_DEC_IMP);

    O_S_TOT_MON := ROUND(O_S_TOT_MON, I_MON_DEC_IMP);

    O_DOCU_GRAV_NETO_MON := ROUND(O_DOCU_GRAV_NETO_MON, I_MON_DEC_IMP);

    O_DOC_GRAV_5_MON := ROUND(O_DOC_GRAV_5_MON, I_MON_DEC_IMP);

    I_DOC_GRAV_10_MON := ROUND(I_DOC_GRAV_10_MON, I_MON_DEC_IMP);

    O_DOCU_IVA_MON := ROUND(O_DOCU_IVA_MON, I_MON_DEC_IMP);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'PP_CALCULAR_VALORES' || SQLCODE || SQLERRM);
  END PP_CALCULAR_VALORES;

  PROCEDURE PP_EDITAR_ITEM(I_NRO_ITEM                 IN COMI001_DET_TMP.NRO_ITEM%TYPE,
                           I_SESSION_ID               IN COMI001_DET_TMP.SESSION_ID%TYPE,
                           I_USUARIO                  IN COMI001_DET_TMP.USUARIO%TYPE,
                           I_TIMBRADO                 IN COMI001_DET_TMP.TIMBRADO%TYPE,
                           O_OPCION                   OUT COMI001_DET_TMP.OPCION%TYPE,
                           O_CONCEPTO                 OUT COMI001_DET_TMP.CONCEPTO%TYPE,
                           O_OT                       OUT COMI001_DET_TMP.OT%TYPE,
                           O_DCON_CUENTA              OUT COMI001_DET_TMP.DCON_CUENTA%TYPE,
                           O_DCON_CANAL               OUT COMI001_DET_TMP.DCON_CANAL%TYPE,
                           O_DCON_DIV_CANAL           OUT COMI001_DET_TMP.DCON_DIV_CANAL%TYPE,
                           O_NRO_IMPORTACION          OUT COMI001_DET_TMP.NRO_IMPORTACION%TYPE,
                           O_CANT                     OUT COMI001_DET_TMP.CANT%TYPE,
                           O_KM_ACTUAL                OUT COMI001_DET_TMP.KM_ACTUAL%TYPE,
                           O_PREC_UNIT                OUT COMI001_DET_TMP.PREC_UNIT%TYPE,
                           O_OBS                      OUT COMI001_DET_TMP.OBS%TYPE,
                           O_IND_TIPO_IVA_COMPRA      OUT COMI001_DET_TMP.IND_TIPO_IVA_COMPRA%TYPE,
                           O_PC_DCTO                  OUT COMI001_DET_TMP.PC_DCTO%TYPE,
                           O_IMPU_PORC_BASE_IMPONIBLE OUT COMI001_DET_TMP.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                           O_IMPU_PORCENTAJE          OUT COMI001_DET_TMP.IMPU_PORCENTAJE%TYPE,
                           O_TOTAL                    OUT COMI001_DET_TMP.TOTAL%TYPE,
                           O_EXENTO                   OUT COMI001_DET_TMP.EXENTO%TYPE,
                           O_GRAVADO                  OUT COMI001_DET_TMP.GRAVADO%TYPE,
                           O_IVA                      OUT COMI001_DET_TMP.IVA%TYPE,
                           O_DESC_LARGA               OUT COMI001_DET_TMP.DESC_LARGA%TYPE,
                           O_CONT_DESC                OUT COMI001_DET_TMP.CONT_DESC%TYPE,
                           O_ART                      OUT COMI001_DET_TMP.ART%TYPE,
                           O_OT_MON                   OUT COMI001_DET_TMP.OT_MON%TYPE,
                           O_OT_MON_COT               OUT COMI001_DET_TMP.OT_MON_COT%TYPE,
                           O_OT_MON_SIM               OUT COMI001_DET_TMP.OT_MON_SIM%TYPE,
                           O_OT_CLAVE                 OUT COMI001_DET_TMP.OT_CLAVE%TYPE,
                           O_DCON_CLAVE_IMP           OUT COMI001_DET_TMP.DCON_CLAVE_IMP%TYPE,
                           O_OCOM_CLAVE               OUT COMI001_DET_TMP.OCOM_CLAVE%TYPE,
                           O_OCOMD_NRO_ITEM           OUT COMI001_DET_TMP.OCOMD_NRO_ITEM%TYPE,
                           O_DETA_IMP_NETO_LOC        OUT COMI001_DET_TMP.DETA_IMP_NETO_LOC%TYPE,
                           O_DETA_IMP_NETO_MON        OUT COMI001_DET_TMP.DETA_IMP_NETO_MON%TYPE,
                           O_DETA_IMPU                OUT COMI001_DET_TMP.DETA_IMPU%TYPE,
                           O_DETA_IVA_LOC             OUT COMI001_DET_TMP.DETA_IVA_LOC%TYPE,
                           O_DETA_IVA_MON             OUT COMI001_DET_TMP.DETA_IVA_MON%TYPE,
                           O_IVA_10_LOC               OUT COMI001_DET_TMP.IVA_10_LOC%TYPE,
                           O_IVA_5_LOC                OUT COMI001_DET_TMP.IVA_5_LOC%TYPE,
                           O_CLAVE_CTACO              OUT COMI001_DET_TMP.CLAVE_CTACO%TYPE,
                           O_CLAVE_CONCEPTO           OUT COMI001_DET_TMP.CLAVE_CONCEPTO%TYPE,
                           O_IMP_AFECTA_COSTO         OUT COMI001_DET_TMP.IMP_AFECTA_COSTO%TYPE,
                           O_KM_FAC_ANT               OUT COMI001_DET_TMP.CANT_FAC_ANT%TYPE) IS
  BEGIN

    SELECT OPCION,
           CONCEPTO,
           OT,
           DCON_CUENTA,
           DCON_CANAL,
           DCON_DIV_CANAL,
           NRO_IMPORTACION,
           CANT,
           KM_ACTUAL,
           PREC_UNIT,
           OBS,
           IND_TIPO_IVA_COMPRA,
           PC_DCTO,
           IMPU_PORC_BASE_IMPONIBLE,
           IMPU_PORCENTAJE,
           TOTAL,
           EXENTO,
           GRAVADO,
           IVA,
           DESC_LARGA,
           CONT_DESC,
           ART,
           OT_MON,
           OT_MON_COT,
           OT_MON_SIM,
           OT_CLAVE,
           DCON_CLAVE_IMP,
           OCOM_CLAVE,
           OCOMD_NRO_ITEM,
           DETA_IMP_NETO_LOC,
           DETA_IMP_NETO_MON,
           DETA_IMPU,
           DETA_IVA_LOC,
           DETA_IVA_MON,
           IVA_10_LOC,
           IVA_5_LOC,
           CLAVE_CTACO,
           CLAVE_CONCEPTO,
           IMP_AFECTA_COSTO,
           CANT_FAC_ANT
      INTO O_OPCION,
           O_CONCEPTO,
           O_OT,
           O_DCON_CUENTA,
           O_DCON_CANAL,
           O_DCON_DIV_CANAL,
           O_NRO_IMPORTACION,
           O_CANT,
           O_KM_ACTUAL,
           O_PREC_UNIT,
           O_OBS,
           O_IND_TIPO_IVA_COMPRA,
           O_PC_DCTO,
           O_IMPU_PORC_BASE_IMPONIBLE,
           O_IMPU_PORCENTAJE,
           O_TOTAL,
           O_EXENTO,
           O_GRAVADO,
           O_IVA,
           O_DESC_LARGA,
           O_CONT_DESC,
           O_ART,
           O_OT_MON,
           O_OT_MON_COT,
           O_OT_MON_SIM,
           O_OT_CLAVE,
           O_DCON_CLAVE_IMP,
           O_OCOM_CLAVE,
           O_OCOMD_NRO_ITEM,
           O_DETA_IMP_NETO_LOC,
           O_DETA_IMP_NETO_MON,
           O_DETA_IMPU,
           O_DETA_IVA_LOC,
           O_DETA_IVA_MON,
           O_IVA_10_LOC,
           O_IVA_5_LOC,
           O_CLAVE_CTACO,
           O_CLAVE_CONCEPTO,
           O_IMP_AFECTA_COSTO,
           O_KM_FAC_ANT
      FROM COMI001_DET_TMP
     WHERE SESSION_ID = I_SESSION_ID
       AND TIMBRADO = I_TIMBRADO
       AND USUARIO = I_USUARIO
       AND TRUNC(FECHA) = TRUNC(SYSDATE)
       AND NRO_ITEM = I_NRO_ITEM;

  EXCEPTION
    WHEN OTHERS THEN
      O_OPCION                   := NULL;
      O_CONCEPTO                 := NULL;
      O_OT                       := NULL;
      O_DCON_CUENTA              := NULL;
      O_DCON_CANAL               := NULL;
      O_DCON_DIV_CANAL           := NULL;
      O_NRO_IMPORTACION          := NULL;
      O_CANT                     := NULL;
      O_KM_ACTUAL                := NULL;
      O_PREC_UNIT                := NULL;
      O_OBS                      := NULL;
      O_IND_TIPO_IVA_COMPRA      := NULL;
      O_PC_DCTO                  := NULL;
      O_IMPU_PORC_BASE_IMPONIBLE := NULL;
      O_IMPU_PORCENTAJE          := NULL;
      O_TOTAL                    := NULL;
      O_EXENTO                   := NULL;
      O_GRAVADO                  := NULL;
      O_IVA                      := NULL;
      O_DESC_LARGA               := NULL;
      O_CONT_DESC                := NULL;
      O_ART                      := NULL;
      O_OT_MON                   := NULL;
      O_OT_MON_COT               := NULL;
      O_OT_MON_SIM               := NULL;
      O_OT_CLAVE                 := NULL;
      O_DCON_CLAVE_IMP           := NULL;
      O_OCOM_CLAVE               := NULL;
      O_OCOMD_NRO_ITEM           := NULL;
      O_DETA_IMP_NETO_LOC        := NULL;
      O_DETA_IMP_NETO_MON        := NULL;
      O_DETA_IMPU                := NULL;
      O_DETA_IVA_LOC             := NULL;
      O_DETA_IVA_MON             := NULL;
      O_IVA_10_LOC               := NULL;
      O_IVA_5_LOC                := NULL;
      O_CLAVE_CTACO              := NULL;
      O_CLAVE_CONCEPTO           := NULL;
  END PP_EDITAR_ITEM;

  PROCEDURE PP_GUARDAR_COMI001_TMP_CANAL(I_OPCION                   IN COMI001_DET_TMP.OPCION%TYPE,
                                         I_CONCEPTO                 IN COMI001_DET_TMP.CONCEPTO%TYPE,
                                         I_OT                       IN COMI001_DET_TMP.OT%TYPE,
                                         I_DCON_CUENTA              IN COMI001_DET_TMP.DCON_CUENTA%TYPE,
                                         I_DCON_CANAL               IN COMI001_DET_TMP.DCON_CANAL%TYPE,
                                         I_DCON_DIV_CANAL           IN COMI001_DET_TMP.DCON_DIV_CANAL%TYPE,
                                         I_NRO_IMPORTACION          IN COMI001_DET_TMP.NRO_IMPORTACION%TYPE,
                                         I_CANT                     IN COMI001_DET_TMP.CANT%TYPE,
                                         I_KM_ACTUAL                IN COMI001_DET_TMP.KM_ACTUAL%TYPE,
                                         I_PREC_UNIT                IN COMI001_DET_TMP.PREC_UNIT%TYPE,
                                         I_OBS                      IN COMI001_DET_TMP.OBS%TYPE,
                                         I_IND_TIPO_IVA_COMPRA      IN COMI001_DET_TMP.IND_TIPO_IVA_COMPRA%TYPE,
                                         I_PC_DCTO                  IN COMI001_DET_TMP.PC_DCTO%TYPE,
                                         I_IMPU_PORC_BASE_IMPONIBLE IN COMI001_DET_TMP.IMPU_PORC_BASE_IMPONIBLE%TYPE,
                                         I_IMPU_PORCENTAJE          IN COMI001_DET_TMP.IMPU_PORCENTAJE%TYPE,
                                         I_TOTAL                    IN COMI001_DET_TMP.TOTAL%TYPE,
                                         I_EXENTO                   IN COMI001_DET_TMP.EXENTO%TYPE,
                                         I_GRAVADO                  IN COMI001_DET_TMP.GRAVADO%TYPE,
                                         I_IVA                      IN COMI001_DET_TMP.IVA%TYPE,
                                         I_SESSION_ID               IN COMI001_DET_TMP.SESSION_ID%TYPE,
                                         I_USUARIO                  IN COMI001_DET_TMP.USUARIO%TYPE,
                                         I_TIMBRADO                 IN COMI001_DET_TMP.TIMBRADO%TYPE,
                                         I_DESC_LARGA               IN COMI001_DET_TMP.DESC_LARGA%TYPE,
                                         I_CONT_DESC                IN COMI001_DET_TMP.CONT_DESC%TYPE,
                                         I_ART                      IN COMI001_DET_TMP.ART%TYPE,
                                         I_DCON_CLAVE_IMP           IN COMI001_DET_TMP.DCON_CLAVE_IMP%TYPE,
                                         I_EMPRESA                  IN NUMBER,
                                         I_NRO_ITEM                 IN COMI001_DET_TMP.NRO_ITEM%TYPE,
                                         I_IMP_AFECTA_COSTO         IN COMI001_DET_TMP.IMP_AFECTA_COSTO%TYPE,
                                         I_IND_ORDEN_COMPRA         IN VARCHAR2 DEFAULT NULL,
                                         I_CANAL1                   IN NUMBER,
                                         I_CANAL2                   IN NUMBER,
                                         I_CANAL3                   IN NUMBER,
                                         I_CANAL4                   IN NUMBER,
                                         I_CANAL5                   IN NUMBER,
                                         I_CANAL6                   IN NUMBER,
                                         I_CANAL7                   IN NUMBER,
                                         I_CANAL8                   IN NUMBER,
                                         I_CANAL9                   IN NUMBER,
                                         I_CANAL12                  IN NUMBER,
                                         I_FAC_ANTERIOR             IN NUMBER,
                                         I_IND_VIATICO              IN COMI001_DET_TMP.IND_RESPONSABLE_VIATICO%TYPE DEFAULT NULL) IS
    ----SIRVE PARA LA PARTE DE KM

    TYPE A_CANALES IS RECORD(
      TOTAL   NUMBER,
      GRAVADO NUMBER,
      IVA     NUMBER,
      EXCENTO NUMBER);
    TYPE T_CANAL IS TABLE OF A_CANALES INDEX BY BINARY_INTEGER;
    V_CANAL T_CANAL;

    VAR_TOTAL  NUMBER;
    VAR_IVA    NUMBER;
    VAR_INDICE NUMBER;

    --ODURE
    VAR_AJ_TOTAL   NUMBER :=0;
    VAR_AJ_IVA     NUMBER :=0;
    VAR_AJ_GRAVADO NUMBER :=0;
    VAR_FLAG       NUMBER :=0;
    --
  BEGIN
    --Modificado por ODURE para a?adir ajuste a los valores de total, gravado e iva

    IF NVL(I_CANAL1, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL1) / 100);
      V_CANAL(1).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=1;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --

      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(1).IVA := VAR_IVA;
        V_CANAL(1).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(1).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;

    IF NVL(I_CANAL2, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL2) / 100);
      V_CANAL(2).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=2;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(2).IVA := VAR_IVA;
        V_CANAL(2).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(2).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;

    IF NVL(I_CANAL3, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL3) / 100);
      V_CANAL(3).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=3;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(3).IVA := VAR_IVA;
        V_CANAL(3).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(3).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;

    IF NVL(I_CANAL4, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL4) / 100);
      V_CANAL(4).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=4;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(4).IVA := VAR_IVA;
        V_CANAL(4).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(4).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;

    IF NVL(I_CANAL5, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL5) / 100);
      V_CANAL(5).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=5;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(5).IVA := VAR_IVA;
        V_CANAL(5).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(5).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;
    ------MVERA
    IF NVL(I_CANAL6, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL6) / 100);
      V_CANAL(6).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=6;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(6).IVA := VAR_IVA;
        V_CANAL(6).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(6).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;

    IF NVL(I_CANAL7, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL7) / 100);
      V_CANAL(7).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=7;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(7).IVA := VAR_IVA;
        V_CANAL(7).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(7).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;

    IF NVL(I_CANAL8, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL8) / 100);
      V_CANAL(8).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=8;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(8).IVA := VAR_IVA;
        V_CANAL(8).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(8).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;

    ------------

    IF NVL(I_CANAL9, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL9) / 100);
      V_CANAL(9).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=9;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(9).IVA := VAR_IVA;
        V_CANAL(9).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(9).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;


    IF NVL(I_CANAL12, 0) > 0 THEN
      VAR_TOTAL := ROUND((I_TOTAL * I_CANAL12) / 100);
      V_CANAL(12).TOTAL := VAR_TOTAL;

      --ODURE
      VAR_FLAG:=12;
      VAR_AJ_TOTAL:=VAR_AJ_TOTAL+ VAR_TOTAL;
      --
      IF I_IMPU_PORCENTAJE <> 0 THEN
        VAR_IVA := ROUND((VAR_TOTAL * I_IMPU_PORCENTAJE) /
                         (100 + I_IMPU_PORCENTAJE));
        V_CANAL(12).IVA := VAR_IVA;
        V_CANAL(12).GRAVADO := VAR_TOTAL - VAR_IVA;

        --ODURE
        VAR_AJ_IVA     := VAR_AJ_IVA+VAR_IVA;
        VAR_AJ_GRAVADO := VAR_AJ_GRAVADO+(VAR_TOTAL - VAR_IVA);
        --
      ELSE
        V_CANAL(12).EXCENTO := VAR_TOTAL;
      END IF;
    END IF;

    --ODURE

--  RAISE_APPLICATION_ERROR(-20005,'TOTAL: '||I_TOTAL||' V_TOTAL'||VAR_AJ_TOTAL||' FLAG: '||V_CANAL(VAR_FLAG).TOTAL);
    IF (I_TOTAL-VAR_AJ_TOTAL) > 0 THEN
      V_CANAL(VAR_FLAG).TOTAL := V_CANAL(VAR_FLAG).TOTAL+(I_TOTAL-VAR_AJ_TOTAL);
    ELSIF (I_TOTAL-VAR_AJ_TOTAL) < 0 THEN
      V_CANAL(VAR_FLAG).TOTAL := V_CANAL(VAR_FLAG).TOTAL-ABS(I_TOTAL-VAR_AJ_TOTAL);
    END IF;

    IF (I_IVA-VAR_AJ_IVA) >0 THEN
      V_CANAL(VAR_FLAG).IVA := V_CANAL(VAR_FLAG).IVA+(I_IVA-VAR_AJ_IVA);

    ELSIF (I_IVA-VAR_AJ_IVA) <0 THEN
      V_CANAL(VAR_FLAG).IVA := V_CANAL(VAR_FLAG).IVA-ABS(I_IVA-VAR_AJ_IVA);
    END IF;

    IF (I_GRAVADO-VAR_AJ_GRAVADO) >0 THEN
      V_CANAL(VAR_FLAG).GRAVADO := V_CANAL(VAR_FLAG).GRAVADO+(I_GRAVADO-VAR_AJ_GRAVADO);
    ELSIF (I_GRAVADO-VAR_AJ_GRAVADO) <0 THEN
      V_CANAL(VAR_FLAG).GRAVADO := V_CANAL(VAR_FLAG).GRAVADO-ABS(I_GRAVADO-VAR_AJ_GRAVADO);
    END IF;

    --

    VAR_INDICE := V_CANAL.FIRST;

    WHILE (VAR_INDICE IS NOT NULL) LOOP
      COMI001.PP_GUARDAR_COMI001_TMP(I_OPCION                   => I_OPCION,
                                     I_CONCEPTO                 => I_CONCEPTO,
                                     I_OT                       => I_OT,
                                     I_DCON_CUENTA              => I_DCON_CUENTA,
                                     I_DCON_CANAL               => VAR_INDICE,
                                     I_DCON_DIV_CANAL           => I_DCON_DIV_CANAL,
                                     I_NRO_IMPORTACION          => I_NRO_IMPORTACION,
                                     I_CANT                     => I_CANT,
                                     I_KM_ACTUAL                => I_KM_ACTUAL,
                                     I_PREC_UNIT                => I_PREC_UNIT,
                                     I_OBS                      => I_OBS,
                                     I_IND_TIPO_IVA_COMPRA      => I_IND_TIPO_IVA_COMPRA,
                                     I_PC_DCTO                  => I_PC_DCTO,
                                     I_IMPU_PORC_BASE_IMPONIBLE => I_IMPU_PORC_BASE_IMPONIBLE,
                                     I_IMPU_PORCENTAJE          => I_IMPU_PORCENTAJE,
                                     I_TOTAL                    => V_CANAL(VAR_INDICE)
                                                                   .TOTAL,
                                     I_EXENTO                   => V_CANAL(VAR_INDICE)
                                                                   .EXCENTO,
                                     I_GRAVADO                  => V_CANAL(VAR_INDICE)
                                                                   .GRAVADO,
                                     I_IVA                      => V_CANAL(VAR_INDICE).IVA,
                                     I_SESSION_ID               => I_SESSION_ID,
                                     I_USUARIO                  => I_USUARIO,
                                     I_TIMBRADO                 => I_TIMBRADO,
                                     I_DESC_LARGA               => I_DESC_LARGA,
                                     I_CONT_DESC                => I_CONT_DESC,
                                     I_ART                      => I_ART,
                                     I_DCON_CLAVE_IMP           => I_DCON_CLAVE_IMP,
                                     I_EMPRESA                  => I_EMPRESA,
                                     I_NRO_ITEM                 => I_NRO_ITEM,
                                     I_IMP_AFECTA_COSTO         => I_IMP_AFECTA_COSTO,
                                     I_IND_ORDEN_COMPRA         => I_IND_ORDEN_COMPRA,
                                     I_CANT_FAC_ANT             => I_FAC_ANTERIOR,
                                     I_IND_VIATICO              => I_IND_VIATICO); ---*
      VAR_INDICE := V_CANAL.NEXT(VAR_INDICE);
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'PP_GUARDAR_COMI001_TMP_CANAL' || SQLCODE ||
                              SQLERRM);
  END PP_GUARDAR_COMI001_TMP_CANAL;

  PROCEDURE PP_VALIDAR_KM_OBLI(P_EMPRESA     NUMBER,
                               P_CONCEPTO    NUMBER,
                               P_CANT_LITROS NUMBER,
                               P_KM_REC      NUMBER,
                               P_OPCION      VARCHAR2,
                               P_FECHA_DOC   DATE,
                               P_FAC_ANT     NUMBER,
                               P_PROVEEDOR   NUMBER) IS

    V_KM_OBL        VARCHAR2(1);
    V_KM_PROMEDIO   NUMBER;
    V_KM_RECORRIDO1 NUMBER;
    V_KM_RECORRIDO2 NUMBER;
    V_FECHA_MAX     DATE;
    V_FECHA_MIN     DATE;
    V_VEHICULO      NUMBER;
    V_KM_RANGO      NUMBER;
    V_KM_VARIABLE   NUMBER;
    V_KM_FAC_ANT    NUMBER;

  BEGIN

    IF P_OPCION = 'G' AND P_EMPRESA = 1 AND P_PROVEEDOR <> 4364 THEN
      BEGIN
        -- CAMBIO JB 01/04/2021
        /*SELECT A.RHA_VEH_KM_OBLIG, A.RHA_VEH_KM_CAP, A.RHA_VEH_COD
          INTO V_KM_OBL, V_KM_PROMEDIO, V_VEHICULO
          FROM STK_VEHICULO_HILAGRO A
         WHERE A.RHA_VEH_EMPR = P_EMPRESA
           AND RHA_VEH_COD =*/

       SELECT A.RMAR_VEH_KM_OBLIG, A.RMAR_VEH_KM_CAP, A.RMAR_VEH_COD
          INTO V_KM_OBL, V_KM_PROMEDIO, V_VEHICULO
          FROM STK_REMI_VEHICULO A
         WHERE A.RMAR_EMPR = P_EMPRESA
           AND RMAR_VEH_COD = (SELECT FCON_MOVIL
                                FROM FIN_CONCEPTO T
                               WHERE FCON_EMPR = P_EMPRESA
                                 AND UPPER(FCON_DESC) LIKE '%MOV%COMB%'
                                 AND FCON_CLAVE = P_CONCEPTO); --AND FCON_CODIGO = P_CONCEPTO)
        --  AND RHA_VEH_SUC <> 2; --- POR EL MOMENTO LOS VEHICULOS DE LA SUCURSAL 2 VAN A ESTAR EXCLUIDAS HASTA NUEVO AVISO

        IF V_KM_PROMEDIO IS NULL THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Falta configurar el km del vehiculo en el programa 1-1-275');
        END IF;
        IF V_KM_OBL = 'S' THEN
          IF P_CANT_LITROS IS NULL OR P_CANT_LITROS = 1 or
             P_CANT_LITROS <= 0 THEN
            RAISE_APPLICATION_ERROR(-20002,
                                    'Debe ingresar la cantidad de litros');
          END IF;
          IF P_KM_REC IS NULL THEN
            RAISE_APPLICATION_ERROR(-20002,
                                    'Debe ingresar los km recorridos');
          ELSE
            ---BUSCA LA FECHA MAXIMA, MENOR A LA FECHA DEL  P_FECHA_DOC

            SELECT MAX(D.DOC_FEC_DOC)
              INTO V_FECHA_MAX
              FROM FIN_DOCUMENTO D, FIN_DOC_CONCEPTO E
             WHERE DOC_EMPR = P_EMPRESA
               AND E.DCON_CLAVE_DOC = D.DOC_CLAVE
               AND E.DCON_EMPR = D.DOC_EMPR
               AND D.DOC_TIPO_MOV IN (1, 2)
               AND E.DCON_KM_ACTUAL IS NOT NULL
               AND E.DCON_CLAVE_CONCEPTO = P_CONCEPTO
               AND D.DOC_FEC_DOC <= P_FECHA_DOC;

            IF V_FECHA_MAX IS NOT NULL THEN
              SELECT MAX(DCON_KM_ACTUAL)
                INTO V_KM_RECORRIDO1
                FROM FIN_DOCUMENTO D, FIN_DOC_CONCEPTO E
               WHERE DOC_EMPR = P_EMPRESA
                 AND E.DCON_CLAVE_DOC = D.DOC_CLAVE
                 AND E.DCON_EMPR = D.DOC_EMPR
                 AND D.DOC_TIPO_MOV IN (1, 2)
                 AND E.DCON_KM_ACTUAL IS NOT NULL
                 AND E.DCON_CLAVE_CONCEPTO = P_CONCEPTO
                 AND D.DOC_FEC_DOC = V_FECHA_MAX;
              -- GROUP BY DCON_KM_ACTUAL;
            ELSE
              V_KM_RECORRIDO1 := 0;
            END IF;
            ---BUSCA LA FECHA MINIMA, MAYOR  A LA FECHA DEL  P_FECHA_DOC

            SELECT MAX(D.DOC_FEC_DOC)
              INTO V_FECHA_MIN
              FROM FIN_DOCUMENTO D, FIN_DOC_CONCEPTO E
             WHERE DOC_EMPR = P_EMPRESA
               AND E.DCON_CLAVE_DOC = D.DOC_CLAVE
               AND E.DCON_EMPR = D.DOC_EMPR
               AND D.DOC_TIPO_MOV IN (1, 2)
               AND E.DCON_KM_ACTUAL IS NOT NULL
               AND E.DCON_CLAVE_CONCEPTO = P_CONCEPTO
               AND D.DOC_FEC_DOC >= P_FECHA_DOC;

            IF V_FECHA_MIN IS NOT NULL THEN
              /*     SELECT MAX(DCON_KM_ACTUAL)
               INTO V_KM_RECORRIDO2
               FROM FIN_DOCUMENTO D, FIN_DOC_CONCEPTO E
              WHERE DOC_EMPR = P_EMPRESA
                AND E.DCON_CLAVE_DOC = D.DOC_CLAVE
                AND E.DCON_EMPR = D.DOC_EMPR
                AND D.DOC_TIPO_MOV IN (1, 2)
                AND E.DCON_KM_ACTUAL IS NOT NULL
                AND E.DCON_CLAVE_CONCEPTO = P_CONCEPTO
                AND D.DOC_FEC_DOC = V_FECHA_MIN;*/
              -- GROUP BY DCON_KM_ACTUAL;
              V_KM_RECORRIDO2 := 0;
            ELSE
              V_KM_RECORRIDO2 := 0;
            END IF;

            IF P_KM_REC <= V_KM_RECORRIDO1 THEN
              RAISE_APPLICATION_ERROR(-20002,
                                      'El km actual no puede ser menor al km recodido de la fecha anterior, Fecha: ' ||
                                      V_FECHA_MAX || ', Km: ' ||
                                      TO_CHAR(V_KM_RECORRIDO1,
                                              '999G999G999G999') ||
                                      ' Movil ' || V_VEHICULO);

            ELSIF P_FAC_ANT IS NOT NULL AND V_KM_RECORRIDO2 = 0 THEN
              IF P_FAC_ANT > 10 THEN
                RAISE_APPLICATION_ERROR(-20002,
                                        'El limite de facturas anteriores es 10');
              ELSE
                V_KM_FAC_ANT := V_KM_PROMEDIO * P_FAC_ANT;
                V_KM_RANGO   := V_KM_FAC_ANT + V_KM_RECORRIDO1;
                
                
                IF P_KM_REC > V_KM_RANGO THEN
                  
                  RAISE_APPLICATION_ERROR(-20002,
                                          'El km actual no puede ser mayor a ' ||
                                          TO_CHAR(V_KM_RANGO,
                                                  '999G999G999G999') ||
                                          'km, Movil ' || V_VEHICULO);
                END IF;
              END IF;
            ELSIF P_KM_REC > V_KM_PROMEDIO + V_KM_RECORRIDO1 AND
                  V_KM_RECORRIDO2 = 0 THEN
                  
   --RAISE_APPLICATION_ERROR(-20002,P_KM_REC||' '||V_KM_PROMEDIO||' '||V_KM_RECORRIDO1||' '||V_KM_RECORRIDO2);
              V_KM_RANGO := V_KM_PROMEDIO + V_KM_RECORRIDO1;
              
              RAISE_APPLICATION_ERROR(-20002,
                                      'El km actual no puede ser mayor a ' ||
                                      TO_CHAR(V_KM_RANGO, '999G999G999G999') ||
                                      'km, Movil ' || V_VEHICULO);

              /*ELSIF V_KM_RECORRIDO2 > 0 AND  P_KM_REC >= V_KM_RECORRIDO2 THEN

              RAISE_APPLICATION_ERROR(-20002,
                                        'El km actual no puede ser mayor o igual a '||V_KM_RECORRIDO2||' km, recorrido en fecha '|| V_FECHA_MIN);    */
            END IF;
          END IF;
        END IF;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;
    ELSIF P_OPCION = 'G' AND P_EMPRESA = 1 AND P_PROVEEDOR = 4364 THEN
      --Para este proveedor, debe validar la cantidad de litros. Pedido de Sandra Brizuela, ticket 28554
      DECLARE
      V_CONTA NUMBER;
      BEGIN
      SELECT COUNT(1)
      INTO V_CONTA
      FROM FIN_CONCEPTO A
      WHERE A.FCON_CLAVE = P_CONCEPTO
      AND A.FCON_EMPR = P_EMPRESA
      AND A.FCON_MOVIL IS NOT NULL;



      IF (P_CANT_LITROS IS NULL OR P_CANT_LITROS = 1 or P_CANT_LITROS <= 0) AND V_CONTA > 0 THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Debe ingresar la cantidad de litros');
      END IF;
    END;
    END IF;
  END PP_VALIDAR_KM_OBLI;

END COMI001;
/
