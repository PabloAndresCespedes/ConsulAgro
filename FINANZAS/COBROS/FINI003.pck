CREATE OR REPLACE PACKAGE FINI003 AS
  /******************************************************************************
     NAME:       FINI003
     PURPOSE:

     REVISIONS:
     VER        DATE        AUTHOR           DESCRIPTION
     ---------  ----------  ---------------  ------------------------------------
     1.0        18/01/2018      MONICA GODOY       1. CREATED THIS PACKAGE.
  ******************************************************************************/

  FUNCTION VERIFICAR_DOC_RETENCION(P_EMPRESA   IN NUMBER,
                                   P_DOC_CLAVE IN NUMBER) RETURN VARCHAR2;

  PROCEDURE PP_CARGAR_DATOS(I_EMPRESA                    IN NUMBER,
                            I_SUCURSAL                   IN NUMBER,
                            O_PAGO_BANCO                 OUT VARCHAR2,
                            O_COBRADOR                   OUT VARCHAR2,
                            O_P_MON_US                   OUT GEN_CONFIGURACION.CONF_MON_US%TYPE,
                            O_P_MON_LOC                  OUT GEN_CONFIGURACION.CONF_MON_LOC%TYPE,
                            O_P_IND_OPERADOR             OUT GEN_CONFIGURACION.CONF_IND_OPERADOR%TYPE,
                            O_P_CONFIGURACION            OUT GEN_CONFIGURACION.CONF_FORMATO_FACTURA%TYPE,
                            O_CONF_RECIBO_PAGO_EMIT      OUT FIN_CONFIGURACION.CONF_RECIBO_PAGO_EMIT%TYPE,
                            O_CONF_RECIBO_PAGO_REC       OUT FIN_CONFIGURACION.CONF_RECIBO_PAGO_REC%TYPE,
                            O_CONF_NOTA_CR_EMIT          OUT FIN_CONFIGURACION.CONF_NOTA_CR_EMIT%TYPE,
                            O_CONF_NOTA_CR_REC           OUT FIN_CONFIGURACION.CONF_NOTA_CR_REC%TYPE,
                            O_CONF_FACT_CR_EMIT          OUT FIN_CONFIGURACION.CONF_FACT_CR_EMIT%TYPE,
                            O_CONF_FACT_CR_REC           OUT FIN_CONFIGURACION.CONF_FACT_CR_REC%TYPE,
                            O_CONF_NOTA_DB_EMIT          OUT FIN_CONFIGURACION.CONF_NOTA_DB_EMIT%TYPE,
                            O_CONF_NOTA_DB_REC           OUT FIN_CONFIGURACION.CONF_NOTA_DB_REC%TYPE,
                            O_CONF_CONCEPTO_COBRO        OUT FIN_CONFIGURACION.CONF_CONCEPTO_COBRO%TYPE,
                            O_CONF_CONCEPTO_PAGO         OUT FIN_CONFIGURACION.CONF_CONCEPTO_PAGO%TYPE,
                            O_CONF_CONC_PAGO_NC          OUT FIN_CONFIGURACION.CONF_CONC_PAGO_NC%TYPE,
                            O_CONF_TMOV_PAGO_NC          OUT FIN_CONFIGURACION.CONF_TMOV_PAGO_NC%TYPE,
                            O_CONF_TMOV_DEVOL_ADEL_CLI   OUT FIN_CONFIGURACION.CONF_TMOV_DEVOL_ADEL_CLI%TYPE,
                            O_CONF_CONC_CADCLI           OUT FIN_CONFIGURACION.CONF_CONC_CADCLI%TYPE,
                            O_CONF_ADELANTO_CLI          OUT FIN_CONFIGURACION.CONF_ADELANTO_CLI%TYPE,
                            O_CONF_TMOV_DEVOL_ADEL_PRO   OUT FIN_CONFIGURACION.CONF_TMOV_DEVOL_ADEL_PRO%TYPE,
                            O_CONF_CONC_CADPRO           OUT FIN_CONFIGURACION.CONF_CONC_CADPRO%TYPE,
                            O_CONF_ADELANTO_PRO          OUT FIN_CONFIGURACION.CONF_ADELANTO_PRO%TYPE,
                            O_CONF_CONC_PAGO_NC_REC      OUT FIN_CONFIGURACION.CONF_CONC_PAGO_NC_REC%TYPE,
                            O_CONF_TMOV_PAGO_NC_REC      OUT FIN_CONFIGURACION.CONF_TMOV_PAGO_NC_REC%TYPE,
                            O_CONF_TMOV_ORDEN_COMPRA     OUT FIN_CONFIGURACION.CONF_TMOV_ORDEN_COMPRA%TYPE,
                            O_CONF_CONC_ORDEN_COMPRA     OUT FIN_CONFIGURACION.CONF_CONC_ORDEN_COMPRA%TYPE,
                            O_CONF_TMOV_RETENCION        OUT FIN_CONFIGURACION.CONF_TMOV_RETENCION%TYPE,
                            O_CONF_CONC_RETEN_CENTRAL    OUT FIN_CONFIGURACION.CONF_CONC_RETEN_CENTRAL%TYPE,
                            O_CONF_CONC_RETEN_ASUNCION   OUT FIN_CONFIGURACION.CONF_CONC_RETEN_ASUNCION%TYPE,
                            O_CONF_CONC_RETEN_LOMA       OUT FIN_CONFIGURACION.CONF_CONC_RETEN_LOMA%TYPE,
                            O_CONF_SUELDO_MINIMO         OUT FIN_CONFIGURACION.CONF_SUELDO_MINIMO%TYPE,
                            O_CONF_FACT_CO_REC           OUT FIN_CONFIGURACION.CONF_FACT_CO_REC%TYPE,
                            O_CONF_FACT_COMPRA           OUT FIN_CONFIGURACION.CONF_FACT_COMPRA%TYPE,
                            O_CONF_CONC_RETEN_CONCEPCION OUT FIN_CONFIGURACION.CONF_CONC_RETEN_CONCEPCION%TYPE,
                            O_CONF_CONC_RETEN_SANTAROSA  OUT FIN_CONFIGURACION.CONF_CONC_RETEN_SANTAROSA%TYPE,
                            O_CONF_TMOV_IMPORTACION      OUT GEN_TIPO_MOV.TMOV_CODIGO%TYPE,
                            O_CONF_TMOV_DESPACHO         OUT GEN_TIPO_MOV.TMOV_CODIGO%TYPE,
                            O_P_EMPR_RUC                 OUT GEN_EMPRESA.EMPR_RUC%TYPE,
                            O_LOCALIDAD                  OUT GEN_SUCURSAL.SUC_LOCALIDAD%TYPE,
                            O_TMOV_FACT_CR_REC_AJUSTE    OUT NUMBER,
                            O_TMOV_FACT_CR_EMIT_AJUSTE   OUT NUMBER,
                            O_TIMBRADO                   OUT NUMBER,
                            O_MODO                       OUT VARCHAR2,
                            O_CANT_DECIMALES_LOC         OUT NUMBER);

  PROCEDURE PP_VERIFICAR_NOTACRED(P_EMPRESA     IN NUMBER,
                                  P_PROVEEDOR   IN NUMBER,
                                  P_CLAVE_DOC   IN NUMBER,
                                  P_EXENTO_LOC  IN OUT NUMBER,
                                  P_EXENTO_MON  IN OUT NUMBER,
                                  P_GRAVADO_LOC IN OUT NUMBER,
                                  P_GRAVADO_MON IN OUT NUMBER,
                                  P_IVA_LOC     IN OUT NUMBER,
                                  P_IVA_MON     IN OUT NUMBER);

  PROCEDURE PP_TRAER_DESC_TMOV(I_DOC_TIPO_MOV             IN NUMBER,
                               I_EMPRESA                  IN NUMBER,
                               I_CONF_RECIBO_PAGO_EMIT    IN NUMBER,
                               I_CONF_RECIBO_PAGO_REC     IN NUMBER,
                               I_CONF_TMOV_PAGO_NC        IN NUMBER,
                               I_CONF_TMOV_PAGO_NC_REC    IN NUMBER,
                               I_CONF_TMOV_DEVOL_ADEL_CLI IN NUMBER,
                               I_CONF_TMOV_DEVOL_ADEL_PRO IN NUMBER,
                               O_TMOV_DESC                OUT VARCHAR2,
                               O_DOC_TIPO_SALDO           OUT VARCHAR2,
                               O_W_IND_ER                 OUT VARCHAR2,
                               O_TMOV_CTA_CONT            OUT NUMBER,
                               O_S_ETIQUETA               OUT VARCHAR2,
                               O_S_HOLDING                OUT NUMBER);

  PROCEDURE PP_VALIDAR_CTA_BANCO(I_DOC_CTA_BCO          IN NUMBER,
                                 I_EMPRESA              IN NUMBER,
                                 I_USUARIO              IN VARCHAR2,
                                 I_P_MON_LOC            IN NUMBER,
                                 I_DOC_FEC_DOC          IN DATE,
                                 I_DOC_TIPO_MOV         IN NUMBER,
                                 I_CONF_RECIBO_PAGO_REC IN NUMBER,
                                 IO_CTA_BCO_DIA         IN OUT NUMBER,
                                 I_DOC_TIPO_SALDO       IN VARCHAR2,
                                 I_DOC_FEC_OPER         IN DATE,
                                 I_PAGO_BANCO           IN VARCHAR2,
                                 O_BCO_DESC             OUT VARCHAR2,
                                 O_CTA_DESC             OUT VARCHAR2,
                                 O_DOC_MON              OUT NUMBER,
                                 O_MON_DESC             OUT VARCHAR2,
                                 --O_P_CTA_BCO_DIA           OUT NUMBER,
                                 O_CTA_CHEQ_DIF_RESPALDO OUT NUMBER,
                                 O_CTA_NOT_TRAN_RESPALDO OUT NUMBER,
                                 O_W_MON_DEC_IMP         OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                 O_W_MON_DEC_TASA        OUT GEN_MONEDA.MON_DEC_TASA%TYPE,
                                 O_P_MON_SIMBOLO         OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                 O_TASA_OFIC             OUT NUMBER,
                                 O_P_PROX_CH             OUT VARCHAR2,
                                 O_P_CHEQUE_MENOR        OUT FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MENOR%TYPE,
                                 O_P_CHEQUE_MAYOR        OUT FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MAYOR%TYPE,
                                 O_P_BANCO               OUT FIN_CUENTA_BANCARIA.CTA_BCO%TYPE,
                                 O_P_IND_CHEQUE_DIF      OUT VARCHAR2,
                                 O_ENABLE_CHEQUES        OUT VARCHAR2,
                                 O_ENABLE_IMP_CHEQUE     OUT VARCHAR2,
                                 O_ENABLE_CHEQPAG        OUT VARCHAR2,
                                 O_S_IMP_CHEQUE          OUT VARCHAR2,
                                 O_P_CTA_DESC            OUT VARCHAR2);

  PROCEDURE PP_TRAER_DESC_HOLDING(I_EMPRESA            IN NUMBER,
                                  I_S_HOLDING          IN NUMBER,
                                  O_S_DOC_HOLDING_DESC OUT FIN_FICHA_HOLDING.HOL_DESC%TYPE,
                                  O_S_CLI_RUC          OUT VARCHAR2);

  PROCEDURE PP_TRAER_DESC_PROV(I_EMPRESA         IN NUMBER,
                               I_W_CUENTA        IN NUMBER,
                               I_DOC_MON         IN NUMBER,
                               O_DOC_PROV        OUT VARCHAR2,
                               O_S_DOC_CLI_NOM   OUT VARCHAR2,
                               O_P_PROV_RUC      OUT VARCHAR2,
                               O_S_CLI_RUC       OUT VARCHAR2,
                               O_W_IND_RETENCION OUT VARCHAR2,
                               O_S_MOTIVO_BLOCK  OUT VARCHAR2);

  PROCEDURE PP_TRAER_DESC_CLI(I_W_CUENTA            IN NUMBER,
                              I_EMPRESA             IN NUMBER,
                              I_P_CONFIGURACION     IN VARCHAR2,
                              O_DOC_CLI             OUT FIN_CLIENTE.CLI_CODIGO%TYPE,
                              O_S_DOC_CLI_NOM       OUT FIN_CLIENTE.CLI_NOM%TYPE,
                              O_P_CLI_RUC           OUT FIN_CLIENTE.CLI_RUC%TYPE,
                              O_S_CLI_RUC           OUT FIN_CLIENTE.CLI_RUC%TYPE,
                              O_IND_CLI_FUNCIONARIO OUT VARCHAR2);

  PROCEDURE PP_EJECUTAR_CONSULTA_CUO(I_EMPRESA                  IN NUMBER,
                                     I_DOC_MON                  IN NUMBER,
                                     I_DOC_OPERADOR             IN NUMBER,
                                     I_W_CUENTA                 IN NUMBER,
                                     I_CONF_RECIBO_PAGO_EMIT    IN NUMBER,
                                     I_DOC_TIPO_MOV             IN NUMBER,
                                     I_CONF_FACT_CR_EMIT        IN NUMBER,
                                     I_CONF_NOTA_DB_EMIT        IN NUMBER,
                                     I_CONF_TMOV_ORDEN_COMPRA   IN NUMBER,
                                     I_TMOV_FACT_CR_EMIT_AJUSTE IN NUMBER,
                                     I_CONF_TMOV_PAGO_NC        IN NUMBER,
                                     I_CONF_NOTA_CR_EMIT        IN NUMBER,
                                     I_CONF_TMOV_DEVOL_ADEL_CLI IN NUMBER,
                                     I_CONF_ADELANTO_CLI        IN NUMBER,
                                     I_CONF_ADELANTO_PRO        IN NUMBER,
                                     I_CONF_TMOV_DEVOL_ADEL_PRO IN NUMBER,
                                     I_CONF_TMOV_PAGO_NC_REC    IN NUMBER,
                                     I_CONF_TMOV_IMPORTACION    IN NUMBER,
                                     I_CONF_NOTA_CR_REC         IN NUMBER,
                                     I_CONF_FACT_CR_REC         IN NUMBER,
                                     I_TMOV_FACT_CR_REC_AJUSTE  IN NUMBER,
                                     I_CONF_NOTA_DB_REC         IN NUMBER,
                                     I_CONF_TMOV_DESPACHO       IN NUMBER,
                                     I_CONF_RECIBO_PAGO_REC     IN NUMBER,
                                     I_S_HOLDING                IN NUMBER,
                                     I_W_IND_ER                 IN VARCHAR2,
                                     I_ORDENADO_POR             IN VARCHAR2,
                                     O_S_RETEN_MON              OUT NUMBER,
                                     O_S_RETEN_LOC              OUT NUMBER);

  PROCEDURE PP_ACTUALIZAR_COL(I_SEQ_ID   IN NUMBER,
                              I_IMP_PAGO IN NUMBER,
                              I_IND_PAGO IN VARCHAR2);

  PROCEDURE PP_ACTUALIZAR_TOTAL_DIF(I_DOC_NETO_EXEN_MON IN NUMBER,
                                    O_SUM_PAGO          OUT NUMBER,
                                    O_DIF_PAGO          OUT NUMBER);

  PROCEDURE PP_GUARDAR_TARJETA(I_TARJ_NRO_TARJETA IN VARCHAR2,
                               I_TARJ_TARJETA     IN NUMBER,
                               I_TARJ_FEC_VTO     IN DATE,
                               I_TARJ_IMP_LOC     IN NUMBER,
                               in_origen          in varchar2 := null);

  PROCEDURE PP_GUARDAR_CHEQUE(I_CHEQ_BCO           IN NUMBER,
                              I_CHEQ_SERIE         IN VARCHAR2,
                              I_CHEQ_NRO           IN VARCHAR2,
                              I_CHEQ_MON           IN NUMBER,
                              I_CHEQ_FEC_DEPOSITAR IN DATE,
                              I_IMPORTE            IN NUMBER,
                              I_TASA               IN NUMBER,
                              I_CHEQ_IMPORTE_LOC   IN NUMBER,
                              I_CHEQ_NRO_CTA_CHEQ  IN VARCHAR2,
                              I_TITULAR            IN VARCHAR2,
                              I_ITEM               IN NUMBER);

  PROCEDURE PP_VALIDA_PBANCO(I_BANCO                 IN NUMBER,
                             I_EMPRESA               IN NUMBER,
                             O_S_BANCO_DESC          OUT VARCHAR2,
                             O_S_MON                 OUT NUMBER,
                             O_P_BANCO               OUT NUMBER,
                             O_P_CTA_BCO_DIA         OUT NUMBER,
                             O_CTA_CHEQ_DIF_RESPALDO OUT NUMBER,
                             O_P_PROX_CH             OUT VARCHAR2,
                             O_P_CHEQUE_MENOR        OUT NUMBER,
                             O_P_CHEQUE_MAYOR        OUT NUMBER);

  PROCEDURE PP_VALIDAR_AD_CHEQUES(I_CANT_CUOTAS       IN NUMBER,
                                  P_TIPO_VENCIMIENTO  IN VARCHAR2,
                                  P_DIAS_ENTRE_CUOTAS IN NUMBER);

  PROCEDURE PP_GENERAR_CHEQUES(I_FEC_PRIM_VTO         IN DATE,
                               I_S_TOTAL_IMP          IN NUMBER,
                               I_S_CANT_CHEQUES       IN NUMBER,
                               I_W_MON_DEC_IMP        IN NUMBER,
                               I_P_PAGO_BANCO         IN VARCHAR2,
                               I_P_CTA_BCO_DIA        IN NUMBER,
                               I_EMPRESA              IN NUMBER,
                               I_DOC_CTA_BCO          IN NUMBER,
                               I_M_BENEFICIARIO_INI   IN VARCHAR2,
                               I_P_IND_CHEQUE_DIF     IN VARCHAR2,
                               I_S_TIPO_VENCIMIENTO   IN VARCHAR2,
                               I_S_DIAS_ENTRE_CHEQUES IN NUMBER,
                               O_P_PROX_CH            OUT VARCHAR2,
                               O_P_CHEQUE_MENOR       OUT NUMBER,
                               O_P_CHEQUE_MAYOR       OUT NUMBER);

  PROCEDURE PP_VALIDAR_CHQ_FP(I_W_CHEQ_BCO         IN NUMBER,
                              I_CHEQ_SERIE         IN VARCHAR2,
                              I_CHEQ_NRO           IN VARCHAR2,
                              I_CHEQ_MON           IN NUMBER,
                              I_TASA               IN NUMBER,
                              I_CHEQ_FEC_DEPOSITAR IN DATE,
                              I_IMPORTE            IN NUMBER,
                              I_CHEQ_IMPORTE_LOC   IN NUMBER,
                              I_CHEQ_NRO_CTA_CHEQ  IN VARCHAR2,
                              I_TITULAR            IN VARCHAR2,
                              I_P_MON_LOC          IN NUMBER);

  PROCEDURE PP_VALIDAR_TJ_FP(I_W_TARJ_TARJETA     IN NUMBER,
                             I_TARJ_NRO_TARJETA   IN VARCHAR2,
                             I_TARJ_FEC_VTO       IN DATE,
                             I_TARJ_IMP_LOC       IN NUMBER,
                             I_P_FEC_INIC_SISTEMA IN DATE,
                             I_P_FEC_FIN_SISTEMA  IN DATE,
                             I_FEC_DOC            IN DATE);

  PROCEDURE PP_GUARDAR(I_DOC_TIPO_SALDO             IN VARCHAR2,
                       I_P_BANCO                    IN NUMBER,
                       I_DOC_CTA_BCO                IN NUMBER,
                       I_EMPRESA                    IN NUMBER,
                       I_USUARIO                    IN VARCHAR2,
                       I_P_CTA_DESC                 IN VARCHAR2,
                       I_HOLDING                    IN NUMBER,
                       I_S_TASA_OFIC                IN NUMBER,
                       I_P_CANT_DECIMALES_LOC       IN NUMBER,
                       I_CONF_CONCEPTO_COBRO        IN NUMBER,
                       I_SUCURSAL                   IN NUMBER,
                       I_DOC_NRO_DOC                IN NUMBER,
                       I_DOC_MON                    IN NUMBER,
                       I_DOC_FEC_OPER               IN DATE,
                       I_DOC_FEC_DOC                IN DATE,
                       I_DOC_OPERADOR               IN NUMBER,
                       I_DOC_SERIE                  IN VARCHAR2,
                       I_W_CUENTA                   IN NUMBER,
                       I_DOC_CLI_NOM                IN VARCHAR2,
                       I_P_IND_CHEQUE_DIF           IN VARCHAR2,
                       I_P_PAGO_BANCO               IN VARCHAR2,
                       I_P_CTA_BCO_DIA              IN NUMBER,
                       I_AUX_TASA_DOC               IN NUMBER,
                       I_AUX_CONF_COD_EXTRACCION    IN NUMBER,
                       I_AUX_NRO_DOC                IN NUMBER,
                       I_AUX_DOC_MON                IN NUMBER,
                       I_AUX_TIPO_MOV               IN NUMBER,
                       I_AUX_CLAVE_DOC              IN NUMBER,
                       I_AUX_CONF_CONC_TC_INGRESO   IN NUMBER,
                       I_AUX_CONF_CTA_TC_INGRESO    IN NUMBER,
                       I_CTA_CHEQ_DIF_RESPALDO      IN NUMBER,
                       I_TOTAL_IMP                  IN NUMBER,
                       I_PROGRAMA                   IN VARCHAR2,
                       I_DOC_NETO_EXEN_LOC          IN NUMBER,
                       I_DOC_NETO_EXEN_MON          IN NUMBER,
                       I_DOC_TIPO_MOV               IN NUMBER,
                       I_S_RETEN_MON                IN NUMBER,
                       I_ACT_IMPRESORA              IN VARCHAR2,
                       I_W_IND_RETENCION            IN VARCHAR2,
                       I_NRO_RETENCION              IN NUMBER,
                       I_S_ACT_IMPRESORA            IN VARCHAR2,
                       I_CTA_NOT_TRAN_RESPALDO      IN NUMBER,
                       I_AUX_CONF_CONC_CH_INGRESO   IN NUMBER,
                       I_AUX_CONF_CTA_CH_INGRESO    IN NUMBER,
                       I_AUX_FEC_DOC                IN DATE,
                       I_AUX_CONF_COD_DEPOSITO      IN NUMBER,
                       I_AUX_CLI_NOM                IN VARCHAR2,
                       I_AUX_CLI_CODIGO             IN NUMBER,
                       I_AUX_CONF_CONC_CH_RESP      IN NUMBER,
                       I_AUX_CONF_CTA_CH_RESP       IN NUMBER,
                       I_TIMBRADO                   IN NUMBER,
                       I_DOC_PROV                   IN NUMBER,
                       I_FEC_INIC_SISTEMA           IN DATE,
                       I_FEC_FIN_SISTEMA            IN DATE,
                       I_W_MON_DEC_IMP              IN NUMBER,
                       I_DOC_OBS                    IN VARCHAR2,
                       I_CONF_TMOV_RETENCION        IN NUMBER,
                       I_CONF_CONC_RETEN_CENTRAL    IN NUMBER,
                       I_CONF_CONC_RETEN_ASUNCION   IN NUMBER,
                       I_CONF_CONC_RETEN_CONCEPCION IN NUMBER,
                       I_CONF_CONC_RETEN_LOMA       IN NUMBER,
                       I_CONF_CONC_RETEN_SANTAROSA  IN NUMBER,
                       I_P_MON_LOC                  IN NUMBER,
                       I_DOC_CLAVE                  IN NUMBER,
                       O_MENSAJE                    OUT VARCHAR2,
                       I_IND_PRESTAMO               IN VARCHAR2,
                       I_IND_CLI_ADELANTO           IN VARCHAR2,
                       P_CLAVE_URL                  OUT VARCHAR2,
                       P_CLAVE_IMP                  OUT NUMBER);

  PROCEDURE PP_VALIDAR(I_DOC_TIPO_SALDO    IN VARCHAR2,
                       I_P_BANCO           IN NUMBER,
                       I_AUX_IMP_LOC       IN NUMBER,
                       I_CUO_SUM_PAGO      IN NUMBER,
                       I_S_RETEN_MON       IN NUMBER,
                       I_DOC_NETO_EXEN_MON IN NUMBER,
                       I_DOC_TIPO_MOV      IN NUMBER,
                       I_EMPRESA           IN NUMBER);

  PROCEDURE PP_FORMA_PAGO(TIPOMOV                     IN NUMBER,
                          NRODOC                      IN NUMBER,
                          FECDOC                      IN DATE,
                          CTABCO                      IN NUMBER,
                          MONEDA                      IN NUMBER,
                          CLAVEDOC                    IN NUMBER,
                          CLIENTE                     IN NUMBER,
                          CLINOM                      IN VARCHAR2,
                          TASA                        IN NUMBER,
                          I_EMPRESA                   IN NUMBER,
                          I_S_TASA_OFIC               IN NUMBER,
                          I_P_MON_LOC                 IN NUMBER,
                          I_DOC_NETO_EXEN_MON         IN NUMBER,
                          I_DOC_NETO_GRAV_MON         IN NUMBER,
                          I_DOC_IVA_MON               IN NUMBER,
                          I_DOC_NETO_EXEN_LOC         IN NUMBER,
                          I_DOC_NETO_GRAV_LOC         IN NUMBER,
                          I_DOC_IVA_LOC               IN NUMBER,
                          O_BAUX_TIPO_MOV             OUT NUMBER,
                          O_BAUX_NRO_DOC              OUT NUMBER,
                          O_BAUX_FEC_DOC              OUT DATE,
                          O_BAUX_CTA_BCO              OUT NUMBER,
                          O_BAUX_DOC_MON              OUT NUMBER,
                          O_BAUX_IMP_MON              OUT NUMBER,
                          O_BAUX_IMP_LOC              OUT NUMBER,
                          O_BAUX_CLI_CODIGO           OUT NUMBER,
                          O_BAUX_CLI_NOM              OUT VARCHAR2,
                          O_BAUX_CLAVE_DOC            OUT NUMBER,
                          O_BAUX_TASA_DOC             OUT NUMBER,
                          O_BAUX_CONF_COD_EXTRACCION  OUT FIN_CONFIGURACION.CONF_COD_EXTRACCION%TYPE,
                          O_BAUX_CONF_COD_DEPOSITO    OUT FIN_CONFIGURACION.CONF_COD_DEP%TYPE,
                          O_BAUX_CONF_CONC_TC_INGRESO OUT FIN_CONFIGURACION.CONF_CONC_TC_INGRESO%TYPE,
                          O_BAUX_CONF_CTA_TC_INGRESO  OUT FIN_CONCEPTO.FCON_CLAVE_CTACO%TYPE,
                          O_BAUX_CONF_CONC_CH_INGRESO OUT FIN_CONCEPTO.FCON_CLAVE%TYPE,
                          O_BAUX_CONF_CTA_CH_INGRESO  OUT FIN_CONCEPTO.FCON_CLAVE_CTACO%TYPE,
                          O_BAUX_CONF_CONC_CH_RESP    OUT FIN_CONCEPTO.FCON_CLAVE%TYPE,
                          O_BAUX_CONF_CTA_CH_RESP     OUT FIN_CONCEPTO.FCON_CLAVE_CTACO%TYPE);

  PROCEDURE PP_BUSCAR_NRO_FACTURA(I_EMPRESA     IN NUMBER,
                                  O_DOC_NRO_DOC OUT NUMBER);

  PROCEDURE PP_TERMINAR_PROCESO;

  PROCEDURE PP_VERIFICAR_COMPROB(I_DOC_TIPO_MOV         IN NUMBER,
                                 I_CONF_RECIBO_PAGO_REC IN NUMBER,
                                 I_P_PROX_CH            IN NUMBER,
                                 I_P_CHEQUE_MENOR       IN NUMBER,
                                 I_P_CHEQUE_MAYOR       IN NUMBER,
                                 P_EMPRESA              IN NUMBER,
                                 IO_DOC_NRO_DOC         IN OUT NUMBER,
                                 O_CONFIRMAR            OUT VARCHAR2);

  PROCEDURE PP_VERIFICAR_MONTO_PAGO(P_EMPRESA     IN NUMBER,
                                    P_PROVEEDOR   NUMBER,
                                    P_MONEDA      NUMBER,
                                    O_S_RETEN_MON OUT NUMBER,
                                    O_S_PAGO      OUT NUMBER);

  PROCEDURE PP_BUSCAR_NRO_RETENCION(P_EMPRESA         IN NUMBER,
                                    O_S_NRO_RETENCION OUT NUMBER);

  PROCEDURE PP_GNRA_REC_AUT(I_EMPRESA      IN NUMBER,
                            I_SUCURSAL     IN NUMBER,
                            I_DOC_CTA_BCO  IN NUMBER,
                            I_DOC_CLAVE    IN NUMBER,
                            I_CUO_VTO      IN DATE,
                            I_DOC_FEC_DOC  IN DATE,
                            I_DOC_FEC_OPER IN DATE,
                            I_DOC_NRO_DOC  IN NUMBER,
                            I_TASA         IN NUMBER,
                            I_DOC_TIPO_MOV IN NUMBER,
                            I_MONTO_PAGO   IN NUMBER DEFAULT NULL,
                            I_DOC_OBS      IN VARCHAR2 DEFAULT NULL,
                            O_CLAVE_REC    OUT NUMBER);

  PROCEDURE PP_DAR_BAJA_FACT_CRED_EMPL(I_EMPRESA IN NUMBER,
                                       I_CLIENTE IN NUMBER DEFAULT NULL,
                                       I_CLAVE_VTO  IN VARCHAR2 DEFAULT NULL);

  PROCEDURE PP_GRAR_ADEL_PROV(I_EMPRESA             IN NUMBER,
                              I_TASA                IN NUMBER,
                              I_DCON_CLAVE_CONCEPTO IN NUMBER,
                              I_MONTO_PAGO          IN NUMBER DEFAULT NULL,
                              C_DOC                 IN FIN_DOCUMENTO%ROWTYPE DEFAULT NULL,
                              C_CUO                 IN FIN_CUOTA%ROWTYPE DEFAULT NULL,
                              O_CLAVE_FIN           OUT NUMBER,
                              I_CLAVE_RECIBO        IN NUMBER);

  PROCEDURE PP_INS_PER_DOC(I_EMPRESA           IN NUMBER,
                           I_TIPO_MOV          IN NUMBER,
                           I_PDOC_CLAVE        IN NUMBER,
                           I_PDOC_QUINCENA     IN NUMBER,
                           I_PDOC_EMPLEADO     IN NUMBER,
                           I_PDOC_FEC          IN DATE,
                           I_PDOC_NRO_DOC      IN NUMBER,
                           I_PDOC_FEC_GRAB     IN DATE,
                           I_PDOC_LOGIN        IN VARCHAR2,
                           I_PDOC_FORM         IN VARCHAR2,
                           I_PDOC_PERIODO      IN NUMBER,
                           I_PDOC_CLAVE_FIN    IN NUMBER,
                           I_PDOC_NRO_ITEM     IN NUMBER,
                           I_PDOC_CONCEPTO     IN NUMBER,
                           I_PDOC_IMPORTE      IN NUMBER,
                           I_PDOC_IMPORTE_LOC  IN NUMBER,
                           I_PDOC_MON          IN NUMBER,
                           I_PDOC_DEPARTAMENTO IN NUMBER);

  FUNCTION FP_PER_DOC_CLAVE(I_EMPRESA IN NUMBER) RETURN NUMBER;

  PROCEDURE PP_MONTO_RETENCION(I_EMPRESA       IN NUMBER,
                               I_CLAVE_DOC     IN NUMBER,
                               O_MONTO_RET_MON OUT NUMBER,
                               O_MONTO_RET_LOC OUT NUMBER,
                               I_P_TABLA       IN VARCHAR2 DEFAULT 'D',
                               I_FEC_RET       IN DATE DEFAULT SYSDATE);

  function CF_TEXTO (MONEDA IN NUMBER,
                     IMPORTE_RECIBO IN NUMBER,
                     MON_SIMBOLO IN VARCHAR2) return Char;
END FINI003;
/
CREATE OR REPLACE PACKAGE BODY FINI003 AS
  /******************************************************************************
     NAME:       FINI003
     PURPOSE:

     REVISIONS:
     VER        DATE        AUTHOR           DESCRIPTION
     ---------  ----------  ---------------  ------------------------------------
     1.0        18/01/2018      MONICA GODOY       1. CREATED THIS PACKAGE BODY.
  ******************************************************************************/

  FUNCTION VERIFICAR_DOC_RETENCION(P_EMPRESA   IN NUMBER,
                                   P_DOC_CLAVE IN NUMBER) RETURN VARCHAR2 IS
    V_EXISTE_PAGO NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(*)
        INTO V_EXISTE_PAGO ---SI EXISTE PAGOS SIGNIFICA QUE YA EXISTEN RETENCIONES
        FROM FIN_UNION_PAGO P, FIN_DOCUMENTO D
       WHERE P.PAG_CLAVE_DOC = P_DOC_CLAVE
         AND PAG_EMPR = P_EMPRESA
         AND PAG_CLAVE_PAGO = DOC_CLAVE
         AND PAG_EMPR = DOC_EMPR
         AND DOC_TIPO_MOV = 19;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_EXISTE_PAGO := 0;
    END;

    IF V_EXISTE_PAGO > 0 THEN
      RETURN 'S';
    ELSE
      RETURN 'N';
    END IF;

  END;

  PROCEDURE PP_CARGAR_DATOS(I_EMPRESA                    IN NUMBER,
                            I_SUCURSAL                   IN NUMBER,
                            O_PAGO_BANCO                 OUT VARCHAR2,
                            O_COBRADOR                   OUT VARCHAR2,
                            O_P_MON_US                   OUT GEN_CONFIGURACION.CONF_MON_US%TYPE,
                            O_P_MON_LOC                  OUT GEN_CONFIGURACION.CONF_MON_LOC%TYPE,
                            O_P_IND_OPERADOR             OUT GEN_CONFIGURACION.CONF_IND_OPERADOR%TYPE,
                            O_P_CONFIGURACION            OUT GEN_CONFIGURACION.CONF_FORMATO_FACTURA%TYPE,
                            O_CONF_RECIBO_PAGO_EMIT      OUT FIN_CONFIGURACION.CONF_RECIBO_PAGO_EMIT%TYPE,
                            O_CONF_RECIBO_PAGO_REC       OUT FIN_CONFIGURACION.CONF_RECIBO_PAGO_REC%TYPE,
                            O_CONF_NOTA_CR_EMIT          OUT FIN_CONFIGURACION.CONF_NOTA_CR_EMIT%TYPE,
                            O_CONF_NOTA_CR_REC           OUT FIN_CONFIGURACION.CONF_NOTA_CR_REC%TYPE,
                            O_CONF_FACT_CR_EMIT          OUT FIN_CONFIGURACION.CONF_FACT_CR_EMIT%TYPE,
                            O_CONF_FACT_CR_REC           OUT FIN_CONFIGURACION.CONF_FACT_CR_REC%TYPE,
                            O_CONF_NOTA_DB_EMIT          OUT FIN_CONFIGURACION.CONF_NOTA_DB_EMIT%TYPE,
                            O_CONF_NOTA_DB_REC           OUT FIN_CONFIGURACION.CONF_NOTA_DB_REC%TYPE,
                            O_CONF_CONCEPTO_COBRO        OUT FIN_CONFIGURACION.CONF_CONCEPTO_COBRO%TYPE,
                            O_CONF_CONCEPTO_PAGO         OUT FIN_CONFIGURACION.CONF_CONCEPTO_PAGO%TYPE,
                            O_CONF_CONC_PAGO_NC          OUT FIN_CONFIGURACION.CONF_CONC_PAGO_NC%TYPE,
                            O_CONF_TMOV_PAGO_NC          OUT FIN_CONFIGURACION.CONF_TMOV_PAGO_NC%TYPE,
                            O_CONF_TMOV_DEVOL_ADEL_CLI   OUT FIN_CONFIGURACION.CONF_TMOV_DEVOL_ADEL_CLI%TYPE,
                            O_CONF_CONC_CADCLI           OUT FIN_CONFIGURACION.CONF_CONC_CADCLI%TYPE,
                            O_CONF_ADELANTO_CLI          OUT FIN_CONFIGURACION.CONF_ADELANTO_CLI%TYPE,
                            O_CONF_TMOV_DEVOL_ADEL_PRO   OUT FIN_CONFIGURACION.CONF_TMOV_DEVOL_ADEL_PRO%TYPE,
                            O_CONF_CONC_CADPRO           OUT FIN_CONFIGURACION.CONF_CONC_CADPRO%TYPE,
                            O_CONF_ADELANTO_PRO          OUT FIN_CONFIGURACION.CONF_ADELANTO_PRO%TYPE,
                            O_CONF_CONC_PAGO_NC_REC      OUT FIN_CONFIGURACION.CONF_CONC_PAGO_NC_REC%TYPE,
                            O_CONF_TMOV_PAGO_NC_REC      OUT FIN_CONFIGURACION.CONF_TMOV_PAGO_NC_REC%TYPE,
                            O_CONF_TMOV_ORDEN_COMPRA     OUT FIN_CONFIGURACION.CONF_TMOV_ORDEN_COMPRA%TYPE,
                            O_CONF_CONC_ORDEN_COMPRA     OUT FIN_CONFIGURACION.CONF_CONC_ORDEN_COMPRA%TYPE,
                            O_CONF_TMOV_RETENCION        OUT FIN_CONFIGURACION.CONF_TMOV_RETENCION%TYPE,
                            O_CONF_CONC_RETEN_CENTRAL    OUT FIN_CONFIGURACION.CONF_CONC_RETEN_CENTRAL%TYPE,
                            O_CONF_CONC_RETEN_ASUNCION   OUT FIN_CONFIGURACION.CONF_CONC_RETEN_ASUNCION%TYPE,
                            O_CONF_CONC_RETEN_LOMA       OUT FIN_CONFIGURACION.CONF_CONC_RETEN_LOMA%TYPE,
                            O_CONF_SUELDO_MINIMO         OUT FIN_CONFIGURACION.CONF_SUELDO_MINIMO%TYPE,
                            O_CONF_FACT_CO_REC           OUT FIN_CONFIGURACION.CONF_FACT_CO_REC%TYPE,
                            O_CONF_FACT_COMPRA           OUT FIN_CONFIGURACION.CONF_FACT_COMPRA%TYPE,
                            O_CONF_CONC_RETEN_CONCEPCION OUT FIN_CONFIGURACION.CONF_CONC_RETEN_CONCEPCION%TYPE,
                            O_CONF_CONC_RETEN_SANTAROSA  OUT FIN_CONFIGURACION.CONF_CONC_RETEN_SANTAROSA%TYPE,
                            O_CONF_TMOV_IMPORTACION      OUT GEN_TIPO_MOV.TMOV_CODIGO%TYPE,
                            O_CONF_TMOV_DESPACHO         OUT GEN_TIPO_MOV.TMOV_CODIGO%TYPE,
                            O_P_EMPR_RUC                 OUT GEN_EMPRESA.EMPR_RUC%TYPE,
                            O_LOCALIDAD                  OUT GEN_SUCURSAL.SUC_LOCALIDAD%TYPE,
                            O_TMOV_FACT_CR_REC_AJUSTE    OUT NUMBER,
                            O_TMOV_FACT_CR_EMIT_AJUSTE   OUT NUMBER,
                            O_TIMBRADO                   OUT NUMBER,
                            O_MODO                       OUT VARCHAR2,
                            O_CANT_DECIMALES_LOC         OUT NUMBER) IS
    V_TIPO_FORM_RECIBO VARCHAR2(1);
  BEGIN

    O_PAGO_BANCO := 'N';

    O_COBRADOR := 'Cobrador :';
    BEGIN
      SELECT CONF_MON_US,
             CONF_MON_LOC,
             CONF_IND_OPERADOR,
             CONF_FORMATO_FACTURA
        INTO O_P_MON_US, O_P_MON_LOC, O_P_IND_OPERADOR, O_P_CONFIGURACION
        FROM GEN_CONFIGURACION
       WHERE CONF_EMPR = I_EMPRESA;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'No fue cargada la tabla de configuracion general de sistemas!.');
    END;

    O_CANT_DECIMALES_LOC := GENERAL.FL_MON_DEC_IMP(O_P_MON_LOC, (I_EMPRESA));

    SELECT CONF_RECIBO_PAGO_EMIT,
           CONF_RECIBO_PAGO_REC,
           CONF_NOTA_CR_EMIT,
           CONF_NOTA_CR_REC,
           CONF_FACT_CR_EMIT,
           CONF_FACT_CR_REC,
           CONF_NOTA_DB_EMIT,
           CONF_NOTA_DB_REC,
           CONF_CONCEPTO_COBRO,
           CONF_CONCEPTO_PAGO,
           CONF_CONC_PAGO_NC,
           CONF_TMOV_PAGO_NC,
           CONF_TMOV_DEVOL_ADEL_CLI,
           CONF_CONC_CADCLI,
           CONF_ADELANTO_CLI,
           CONF_TMOV_DEVOL_ADEL_PRO,
           CONF_CONC_CADPRO,
           CONF_ADELANTO_PRO,
           CONF_CONC_PAGO_NC_REC,
           CONF_TMOV_PAGO_NC_REC,
           CONF_TMOV_ORDEN_COMPRA,
           CONF_CONC_ORDEN_COMPRA,
           CONF_TMOV_RETENCION,
           CONF_CONC_RETEN_CENTRAL,
           CONF_CONC_RETEN_ASUNCION,
           CONF_CONC_RETEN_LOMA,
           CONF_SUELDO_MINIMO,
           CONF_FACT_CO_REC,
           CONF_FACT_COMPRA,
           CONF_CONC_RETEN_CONCEPCION,
           CONF_CONC_RETEN_SANTAROSA
      INTO O_CONF_RECIBO_PAGO_EMIT,
           O_CONF_RECIBO_PAGO_REC,
           O_CONF_NOTA_CR_EMIT,
           O_CONF_NOTA_CR_REC,
           O_CONF_FACT_CR_EMIT,
           O_CONF_FACT_CR_REC,
           O_CONF_NOTA_DB_EMIT,
           O_CONF_NOTA_DB_REC,
           O_CONF_CONCEPTO_COBRO,
           O_CONF_CONCEPTO_PAGO,
           O_CONF_CONC_PAGO_NC,
           O_CONF_TMOV_PAGO_NC,
           O_CONF_TMOV_DEVOL_ADEL_CLI,
           O_CONF_CONC_CADCLI,
           O_CONF_ADELANTO_CLI,
           O_CONF_TMOV_DEVOL_ADEL_PRO,
           O_CONF_CONC_CADPRO,
           O_CONF_ADELANTO_PRO,
           O_CONF_CONC_PAGO_NC_REC,
           O_CONF_TMOV_PAGO_NC_REC,
           O_CONF_TMOV_ORDEN_COMPRA,
           O_CONF_CONC_ORDEN_COMPRA,
           O_CONF_TMOV_RETENCION,
           O_CONF_CONC_RETEN_CENTRAL,
           O_CONF_CONC_RETEN_ASUNCION,
           O_CONF_CONC_RETEN_LOMA,
           O_CONF_SUELDO_MINIMO,
           O_CONF_FACT_CO_REC,
           O_CONF_FACT_COMPRA,
           O_CONF_CONC_RETEN_CONCEPCION,
           O_CONF_CONC_RETEN_SANTAROSA
      FROM FIN_CONFIGURACION
     WHERE CONF_EMPR = I_EMPRESA;
    IF I_EMPRESA = 1 THEN
      IF O_CONF_TMOV_RETENCION IS NULL OR O_CONF_CONC_RETEN_CENTRAL IS NULL OR
         O_CONF_CONC_RETEN_ASUNCION IS NULL OR
         O_CONF_CONC_RETEN_LOMA IS NULL OR NVL(O_CONF_SUELDO_MINIMO, 0) = 0 THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Debe definir todos los Indicadores para Retenciones a Pagar. Fijese en FINM008 - Configuracion del Sistema');
      END IF;
    END IF;
    BEGIN
      SELECT TMOV_CODIGO
        INTO O_CONF_TMOV_IMPORTACION
        FROM GEN_TIPO_MOV
       WHERE TMOV_DESC LIKE 'IMPORTACION'
         AND TMOV_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Tipo de movimiento para IMPORTACION no existe!.');
    END;

    BEGIN
      SELECT TMOV_CODIGO
        INTO O_CONF_TMOV_DESPACHO
        FROM GEN_TIPO_MOV
       WHERE TMOV_DESC LIKE 'DESPACHO'
         AND TMOV_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Tipo de movimiento para DESPACHO no existe!.');
    END;

    --

    SELECT EMPR_RUC
      INTO O_P_EMPR_RUC
      FROM GEN_EMPRESA
     WHERE EMPR_CODIGO = I_EMPRESA;

    SELECT SUC_LOCALIDAD
      INTO O_LOCALIDAD
      FROM GEN_SUCURSAL
     WHERE SUC_EMPR = I_EMPRESA
       AND SUC_CODIGO = I_SUCURSAL;

    IF O_CONF_CONC_PAGO_NC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Falta configurar el concepto de pago de nota de credito emitida!');
    END IF;
    IF O_CONF_TMOV_PAGO_NC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Falta configurar el tipo de mov. de pago de nota de credito emitida!');
    END IF;

    IF O_CONF_CONC_PAGO_NC_REC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Falta configurar el concepto de pago de nota de credito recibida!');
    END IF;
    IF O_CONF_TMOV_PAGO_NC_REC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Falta configurar el tipo de mov. de pago de nota de credito recibida!');
    END IF;

    --BUSCAR EL TIPO DE MOVIMIENTO FACT.CRED.REC.AJUSTE
    O_TMOV_FACT_CR_REC_AJUSTE  := GENERAL.FL_TIPO_MOV('FACT.CRED.REC.AJUSTE',
                                                      I_EMPRESA); --43; --
    O_TMOV_FACT_CR_EMIT_AJUSTE := GENERAL.FL_TIPO_MOV('FACT.CRED.EMIT.AJUS.',
                                                      I_EMPRESA); --43; --

    --SET_ITEM_PROPERTY('BHCOB.COB_CLAVE',VISIBLE,PROPERTY_FALSE);
    ----------------------------------------------------------------------------------------------------------------
    O_TIMBRADO := 11223651; --NRO DE TIMBRADO SIN VENCIMIENTO FIJO PARA RETENCIONES DE HILAGRO POR PARTE DE LA SET.
    ----------------------------------------------------------------------------------------------------------------
    BEGIN
      SELECT IMP_TIPO_FORM_RECIBO
        INTO V_TIPO_FORM_RECIBO
        FROM GEN_IMPRESORA
       WHERE IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR')
         AND IMP_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'No esta registrada la IP del usuario');
      WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Su IP esta relacionada con mas de una impresora. Avise a Informatica');
    END;

    IF V_TIPO_FORM_RECIBO = ('M') THEN
      O_MODO := 'M';
    ELSE
      O_MODO := 'C';

    END IF;
    --RECUPERANDO LOS DATOS DE LA EMPRESA, SUCURSAL, IMPRESORA Y EL TIPO DE DOCUMENTO, SI ES AUTOIMPRESOR O NO. A = AUTOIMPRESOR, P = PREIMPRESO

  END;

  PROCEDURE PP_VERIFICAR_NOTACRED(P_EMPRESA     IN NUMBER,
                                  P_PROVEEDOR   IN NUMBER,
                                  P_CLAVE_DOC   IN NUMBER,
                                  P_EXENTO_LOC  IN OUT NUMBER,
                                  P_EXENTO_MON  IN OUT NUMBER,
                                  P_GRAVADO_LOC IN OUT NUMBER,
                                  P_GRAVADO_MON IN OUT NUMBER,
                                  P_IVA_LOC     IN OUT NUMBER,
                                  P_IVA_MON     IN OUT NUMBER) IS

    /*============ESTE CURSOR SIRVE PARA TRAER CLAVE PADRE DEL TMOV 30, Y ESA CLAVE ES DEL TMOV 21============*/
    CURSOR C_PADRE_REC_NOTCRED IS
      SELECT K.DOC_CLAVE_PADRE CLAVE_PADRE
        FROM FIN_DOCUMENTO I, FIN_CUOTA Y, FIN_PAGO G, FIN_DOCUMENTO K
       WHERE (Y.CUO_FEC_VTO = G.PAG_FEC_VTO(+) AND
             Y.CUO_CLAVE_DOC = G.PAG_CLAVE_DOC(+) AND
             Y.CUO_EMPR = G.PAG_EMPR(+))
         AND (I.DOC_CLAVE = Y.CUO_CLAVE_DOC)
         AND (I.DOC_EMPR = Y.CUO_EMPR)
         AND K.DOC_CLAVE(+) = G.PAG_CLAVE_PAGO
         AND K.DOC_EMPR(+) = G.PAG_EMPR
         AND I.DOC_CLAVE = P_CLAVE_DOC
         AND K.DOC_EMPR = I.DOC_EMPR
         AND I.DOC_EMPR = P_EMPRESA
         AND I.DOC_PROV = P_PROVEEDOR
         AND K.DOC_TIPO_MOV = 30;

    CURSOR C_NOT_CRED(CLAVE IN NUMBER) IS
      SELECT DISTINCT (CUO_CLAVE_DOC) CLAVE,
                      DOC_NETO_EXEN_MON,
                      DOC_NETO_EXEN_LOC,
                      DOC_NETO_GRAV_MON,
                      DOC_NETO_GRAV_LOC,
                      DOC_IVA_LOC,
                      DOC_IVA_MON
        FROM FIN_DOCUMENTO, FIN_PAGO, FIN_CUOTA
       WHERE PAG_CLAVE_PAGO = CLAVE
         AND DOC_CLAVE = CUO_CLAVE_DOC
         AND CUO_FEC_VTO = PAG_FEC_VTO
         AND CUO_CLAVE_DOC = PAG_CLAVE_DOC
         AND DOC_EMPR = P_EMPRESA
         AND DOC_EMPR = CUO_EMPR
         AND DOC_EMPR = PAG_EMPR;

    V_EXEN_MON NUMBER := 0;
    V_EXEN_LOC NUMBER := 0;
    V_GRAV_MON NUMBER := 0;
    V_GRAV_LOC NUMBER := 0;
    V_IV_MON   NUMBER := 0;
    V_IV_LOC   NUMBER := 0;
  BEGIN
    FOR RP IN C_PADRE_REC_NOTCRED LOOP
      FOR R IN C_NOT_CRED(RP.CLAVE_PADRE) LOOP
        V_EXEN_MON := V_EXEN_MON + R.DOC_NETO_EXEN_MON;
        V_EXEN_LOC := V_EXEN_LOC + R.DOC_NETO_EXEN_LOC;
        V_GRAV_MON := V_GRAV_MON + R.DOC_NETO_GRAV_MON;
        V_GRAV_LOC := V_GRAV_LOC + R.DOC_NETO_GRAV_LOC;
        V_IV_MON   := V_IV_MON + R.DOC_IVA_MON;
        V_IV_LOC   := V_IV_LOC + R.DOC_IVA_LOC;
      END LOOP;
    END LOOP;
    P_EXENTO_MON  := V_EXEN_MON;
    P_EXENTO_LOC  := V_EXEN_LOC;
    P_GRAVADO_MON := V_GRAV_MON;
    P_GRAVADO_LOC := V_GRAV_LOC;
    P_IVA_MON     := V_IV_MON;
    P_IVA_LOC     := V_IV_LOC;
  END;

  PROCEDURE PP_TRAER_DESC_TMOV(I_DOC_TIPO_MOV             IN NUMBER,
                               I_EMPRESA                  IN NUMBER,
                               I_CONF_RECIBO_PAGO_EMIT    IN NUMBER,
                               I_CONF_RECIBO_PAGO_REC     IN NUMBER,
                               I_CONF_TMOV_PAGO_NC        IN NUMBER,
                               I_CONF_TMOV_PAGO_NC_REC    IN NUMBER,
                               I_CONF_TMOV_DEVOL_ADEL_CLI IN NUMBER,
                               I_CONF_TMOV_DEVOL_ADEL_PRO IN NUMBER,
                               O_TMOV_DESC                OUT VARCHAR2,
                               O_DOC_TIPO_SALDO           OUT VARCHAR2,
                               O_W_IND_ER                 OUT VARCHAR2,
                               O_TMOV_CTA_CONT            OUT NUMBER,
                               O_S_ETIQUETA               OUT VARCHAR2,
                               O_S_HOLDING                OUT NUMBER) IS
  BEGIN
    IF I_DOC_TIPO_MOV IN (I_CONF_RECIBO_PAGO_EMIT,
                          I_CONF_RECIBO_PAGO_REC,
                          I_CONF_TMOV_PAGO_NC,
                          I_CONF_TMOV_PAGO_NC_REC,
                          I_CONF_TMOV_DEVOL_ADEL_CLI,
                          I_CONF_TMOV_DEVOL_ADEL_PRO) AND
       I_DOC_TIPO_MOV IS NOT NULL THEN
      SELECT TMOV_DESC, TMOV_TIPO, TMOV_IND_ER, ETC_CLAVE_CTACO
        INTO O_TMOV_DESC, O_DOC_TIPO_SALDO, O_W_IND_ER, O_TMOV_CTA_CONT
        FROM GEN_TIPO_MOV, GEN_EMP_TMOV_CTACO
       WHERE TMOV_CODIGO = ETC_TIPO_MOV(+)
         AND ETC_EMPR(+) = I_EMPRESA
         AND TMOV_EMPR = I_EMPRESA
         AND TMOV_CODIGO = I_DOC_TIPO_MOV;
      --

      --SET_ITEM_PROPERTY('bdoc.s_holding',ENABLED,PROPERTY_FALSE);

      IF O_W_IND_ER = 'R' THEN
        O_S_ETIQUETA := 'Proveedor :';
        O_S_HOLDING  := NULL;
      ELSE
        O_S_ETIQUETA := 'Cliente :';

      END IF;
      --
      IF O_TMOV_CTA_CONT IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'Falta definir CUENTA CONTABLE' ||
                                ' para este tipo de movimiento con GENM026!');
      END IF;
    ELSE
      O_TMOV_DESC      := NULL;
      O_DOC_TIPO_SALDO := NULL;
      O_W_IND_ER       := NULL;
      RAISE_APPLICATION_ERROR(-20001,
                              'Opcion no valida - Ingrese ' ||
                              TO_CHAR(I_CONF_RECIBO_PAGO_EMIT) || ', ' ||
                              TO_CHAR(I_CONF_RECIBO_PAGO_REC) || ', ' ||
                              TO_CHAR(I_CONF_TMOV_PAGO_NC) || ', ' ||
                              TO_CHAR(I_CONF_TMOV_DEVOL_ADEL_CLI) || ', ' ||
                              TO_CHAR(I_CONF_TMOV_DEVOL_ADEL_PRO) || ', ' ||
                              TO_CHAR(I_CONF_TMOV_PAGO_NC_REC) || '!');
    END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_TMOV_DESC      := NULL;
      O_TMOV_CTA_CONT  := NULL;
      O_DOC_TIPO_SALDO := NULL;
      O_W_IND_ER       := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'Tipo de movimiento inexistente!');
  END PP_TRAER_DESC_TMOV;

  PROCEDURE PP_TRAER_DESC_MONE(I_DOC_MON        IN NUMBER,
                               I_EMPRESA        IN NUMBER,
                               I_P_MON_LOC      IN NUMBER,
                               I_DOC_FEC_DOC    IN DATE,
                               O_MON_DESC       OUT GEN_MONEDA.MON_DESC%TYPE,
                               O_W_MON_DEC_IMP  OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                               O_W_MON_DEC_TASA OUT GEN_MONEDA.MON_DEC_TASA%TYPE,
                               O_P_MON_SIMBOLO  OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                               O_TASA_OFIC      OUT NUMBER) IS

  BEGIN
    IF I_DOC_MON IS NOT NULL THEN
      SELECT MON_DESC, MON_DEC_IMP, MON_DEC_TASA, MON_SIMBOLO
        INTO O_MON_DESC, O_W_MON_DEC_IMP, O_W_MON_DEC_TASA, O_P_MON_SIMBOLO
        FROM GEN_MONEDA
       WHERE MON_CODIGO = I_DOC_MON
         AND MON_EMPR = I_EMPRESA;

      IF I_DOC_MON = I_P_MON_LOC THEN
        O_TASA_OFIC := 1;
      ELSE
        O_TASA_OFIC := FACI039.FP_COTIZACION(P_MONEDA      => I_DOC_MON,
                                             P_DOC_FEC_DOC => I_DOC_FEC_DOC,
                                             P_EMPRESA     => I_EMPRESA);

      END IF;

    END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_MON_DESC  := NULL;
      O_TASA_OFIC := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'Moneda inexistente!');
  END PP_TRAER_DESC_MONE;

  PROCEDURE PP_CARGAR_CHEQUE(I_CTA_BCO_DIA    IN NUMBER,
                             I_EMPRESA        IN NUMBER,
                             I_DOC_CTA_BCO    IN NUMBER,
                             O_P_PROX_CH      OUT VARCHAR2,
                             O_P_CHEQUE_MENOR OUT FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MENOR%TYPE,
                             O_P_CHEQUE_MAYOR OUT FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MAYOR%TYPE) IS
    V_BANCO NUMBER;
  BEGIN
    IF I_CTA_BCO_DIA IS NULL THEN
      SELECT TO_CHAR(NVL(TO_NUMBER(CTA_ULT_NRO_CHEQUE), 0)),
             NVL(TO_NUMBER(CTA_NRO_CHEQUE_MENOR), 1),
             NVL(TO_NUMBER(CTA_NRO_CHEQUE_MAYOR), 9999999999999),
             CTA_BCO
        INTO O_P_PROX_CH, O_P_CHEQUE_MENOR, O_P_CHEQUE_MAYOR, V_BANCO
        FROM FIN_CUENTA_BANCARIA
       WHERE CTA_EMPR = I_EMPRESA
         AND CTA_CODIGO = I_DOC_CTA_BCO;
    ELSE
      SELECT TO_CHAR(NVL(TO_NUMBER(CTA_ULT_NRO_CHEQUE), 0)),
             NVL(TO_NUMBER(CTA_NRO_CHEQUE_MENOR), 1),
             NVL(TO_NUMBER(CTA_NRO_CHEQUE_MAYOR), 9999999999999),
             CTA_BCO
        INTO O_P_PROX_CH, O_P_CHEQUE_MENOR, O_P_CHEQUE_MAYOR, V_BANCO
        FROM FIN_CUENTA_BANCARIA
       WHERE CTA_EMPR = I_EMPRESA
         AND CTA_CODIGO = I_CTA_BCO_DIA;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cuenta Inexistente!.');
  END PP_CARGAR_CHEQUE;

  PROCEDURE PP_VERIF_EXIST_CTA_BANC(I_EMPRESA              IN NUMBER,
                                    I_DOC_CTA_BCO          IN NUMBER,
                                    I_USUARIO              IN VARCHAR2,
                                    I_P_MON_LOC            IN NUMBER,
                                    I_DOC_FEC_DOC          IN DATE,
                                    I_DOC_TIPO_MOV         IN NUMBER,
                                    I_CONF_RECIBO_PAGO_REC IN NUMBER,
                                    IO_CTA_BCO_DIA         IN OUT NUMBER,
                                    I_DOC_TIPO_SALDO       IN VARCHAR2,
                                    I_PAGO_BANCO           IN VARCHAR2,
                                    --O_DOC_CTA_BCO,
                                    O_BCO_DESC OUT VARCHAR2,
                                    O_CTA_DESC OUT VARCHAR2,
                                    O_DOC_MON  OUT NUMBER,
                                    O_MON_DESC OUT VARCHAR2,
                                    O_P_BANCO  OUT NUMBER,
                                    --O_P_CTA_BCO_DIA           OUT NUMBER,
                                    O_CTA_CHEQ_DIF_RESPALDO OUT NUMBER,
                                    O_CTA_NOT_TRAN_RESPALDO OUT NUMBER,
                                    --O_MON_DESC        OUT GEN_MONEDA.O_MON_DESC%TYPE,
                                    O_W_MON_DEC_IMP  OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                    O_W_MON_DEC_TASA OUT GEN_MONEDA.MON_DEC_TASA%TYPE,
                                    O_P_MON_SIMBOLO  OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                    O_TASA_OFIC      OUT NUMBER,
                                    O_P_PROX_CH      OUT VARCHAR2,
                                    O_P_CHEQUE_MENOR OUT FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MENOR%TYPE,
                                    O_P_CHEQUE_MAYOR OUT FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MAYOR%TYPE,
                                    O_P_CTA_DESC     OUT VARCHAR2) IS
  BEGIN
    IF I_DOC_CTA_BCO IS NOT NULL THEN
      SELECT --CTA_CODIGO,
       BCO_DESC,
       CTA_DESC,
       CTA_MON,
       MON_DESC,
       CTA_BCO,
       CTA_BCO_DIA,
       CTA_CHEQ_DIF_RESPALDO,
       CTA_NOT_TRAN_RESPALDO
        INTO --O_DOC_CTA_BCO,
             O_BCO_DESC,
             O_CTA_DESC,
             O_DOC_MON,
             O_MON_DESC,
             O_P_BANCO,
             IO_CTA_BCO_DIA,
             O_CTA_CHEQ_DIF_RESPALDO,
             O_CTA_NOT_TRAN_RESPALDO
        FROM FIN_CUENTA_BANCARIA, FIN_BANCO, GEN_MONEDA
       WHERE CTA_BCO = BCO_CODIGO(+)
         AND CTA_MON = MON_CODIGO(+)
         AND CTA_CODIGO = I_DOC_CTA_BCO
         AND CTA_EMPR = I_EMPRESA
         AND CTA_EMPR = BCO_EMPR(+)
         AND CTA_EMPR = MON_EMPR(+);
      --
      O_P_CTA_DESC := O_CTA_DESC;
      IF O_P_CTA_DESC IS NULL THEN
        O_P_CTA_DESC := O_BCO_DESC;
      END IF;
      FACI039.PL_VALIDAR_OPCTA(P_CTA       => I_DOC_CTA_BCO,
                               P_EMPRESA   => I_EMPRESA,
                               P_LOGIN     => I_USUARIO,
                               P_CTA_DESC  => O_P_CTA_DESC,
                               P_OPERACION => I_DOC_TIPO_SALDO,
                               P_PROGRAMA  => 'FINI003');

      PP_TRAER_DESC_MONE(I_DOC_MON        => O_DOC_MON,
                         I_EMPRESA        => I_EMPRESA,
                         I_P_MON_LOC      => I_P_MON_LOC,
                         I_DOC_FEC_DOC    => I_DOC_FEC_DOC,
                         O_MON_DESC       => O_MON_DESC,
                         O_W_MON_DEC_IMP  => O_W_MON_DEC_IMP,
                         O_W_MON_DEC_TASA => O_W_MON_DEC_TASA,
                         O_P_MON_SIMBOLO  => O_P_MON_SIMBOLO,
                         O_TASA_OFIC      => O_TASA_OFIC);
      --PP_ESTABLECER_FORMATO;
    END IF;

    IF I_DOC_TIPO_MOV = I_CONF_RECIBO_PAGO_REC THEN
      --PARA SUGERIR COMO NUMERO DE DOCUMENTO EL PROX NRO DE CHEQUE
      IF I_PAGO_BANCO <> 'S' THEN
        PP_CARGAR_CHEQUE(I_CTA_BCO_DIA    => IO_CTA_BCO_DIA,
                         I_EMPRESA        => I_EMPRESA,
                         I_DOC_CTA_BCO    => I_DOC_CTA_BCO,
                         O_P_PROX_CH      => O_P_PROX_CH,
                         O_P_CHEQUE_MENOR => O_P_CHEQUE_MENOR,
                         O_P_CHEQUE_MAYOR => O_P_CHEQUE_MAYOR);
      END IF;
    END IF;

    ---LENNARD
    /*  IF :BDOC.BCO_DESC IS NULL AND :BDOC.DOC_TIPO_MOV=19 THEN
          SET_ITEM_PROPERTY('BPIE.CHEQPAG',ENABLED,PROPERTY_FALSE);
       SET_ITEM_PROPERTY('BPIE.CHEQPAG',NAVIGABLE,PROPERTY_FALSE);
    END IF;  */

    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cuenta bancaria inexistente!');
  END PP_VERIF_EXIST_CTA_BANC;

  PROCEDURE PP_CTA_CHEQ_EMIT_DIF(I_EMPRESA           IN NUMBER,
                                 I_DOC_CTA_BCO       IN NUMBER,
                                 I_DOC_TIPO_SALDO    IN VARCHAR2,
                                 I_DOC_TIPO_MOV      IN NUMBER,
                                 O_P_BANCO           OUT FIN_CUENTA_BANCARIA.CTA_BCO%TYPE,
                                 O_P_IND_CHEQUE_DIF  OUT VARCHAR2,
                                 O_ENABLE_CHEQUES    OUT VARCHAR2,
                                 O_ENABLE_IMP_CHEQUE OUT VARCHAR2,
                                 O_ENABLE_CHEQPAG    OUT VARCHAR2,
                                 O_S_IMP_CHEQUE      OUT VARCHAR2) IS
    V_BANCO NUMBER;
  BEGIN
    SELECT CTA_BCO, CTA_BCO, NVL(CTA_IND_CHEQ_DIF, 'N')
      INTO V_BANCO, O_P_BANCO, O_P_IND_CHEQUE_DIF
      FROM FIN_CUENTA_BANCARIA
     WHERE CTA_EMPR = I_EMPRESA
       AND CTA_CODIGO = I_DOC_CTA_BCO;
    --RAISE_aPPLICATION_ERROR (-20001,V_BANCO);
    IF I_DOC_TIPO_SALDO = 'C' THEN

      IF V_BANCO IS NOT NULL THEN
        O_ENABLE_CHEQUES := 'TRUE';
        --SET_ITEM_PROPERTY('BPIE.CHEQUES',ENABLED, PROPERTY_TRUE);
        --SET_ITEM_PROPERTY('BPIE.CHEQUES',NAVIGABLE, PROPERTY_TRUE);
        --LENNARD
        O_ENABLE_IMP_CHEQUE := 'TRUE';
        --SET_ITEM_PROPERTY('BDOC.S_IMP_CHEQUE',ENABLED, PROPERTY_TRUE);
        --SET_ITEM_PROPERTY('BDOC.S_IMP_CHEQUE',NAVIGABLE, PROPERTY_TRUE);
      ELSE
        --LENNARD1
        IF I_DOC_TIPO_MOV <> 19 THEN
          O_ENABLE_CHEQPAG := 'FALSE';
        END IF;
        O_ENABLE_CHEQUES   := 'FALSE';
        O_P_IND_CHEQUE_DIF := NULL;
        O_S_IMP_CHEQUE     := 'N';
      END IF;
    END IF;

  END PP_CTA_CHEQ_EMIT_DIF;

  PROCEDURE PP_VER_CHEQ_EMIT(I_DOC_TIPO_MOV      IN NUMBER,
                             I_DOC_TIPO_SALDO    IN VARCHAR2,
                             I_P_BANCO           IN NUMBER,
                             O_ENABLE_IMP_CHEQUE OUT VARCHAR2,
                             O_ENABLE_CHEQUE     OUT VARCHAR2,
                             O_ENABLE_CHEQPAG    OUT VARCHAR2) IS
  BEGIN
    /*SET_ITEM_PROPERTY('BPIE.CHEQUES',ENABLED,PROPERTY_FALSE);
    SET_ITEM_PROPERTY('BPIE.CHEQUES',NAVIGABLE,PROPERTY_FALSE);*/
    --O_ENABLE_CHEQUE := 'FALSE';
    --LENNARD1
    IF I_DOC_TIPO_MOV <> 19 THEN
      O_ENABLE_CHEQPAG := 'FALSE';
      /*SET_ITEM_PROPERTY('BPIE.CHEQPAG',ENABLED,PROPERTY_FALSE);
      SET_ITEM_PROPERTY('BPIE.CHEQPAG',NAVIGABLE,PROPERTY_FALSE);*/

    END IF;

    --LLEGAMOS HASTA AQUI PORQUE NO ES FACT.CRED.EMIT NI REC.
    --SI TIPO DE SALDO INDICA SALIDA DE DINERO, ES DECIR HACEMOS COMPRAS, PAGOS, ETC.
    IF I_DOC_TIPO_SALDO = 'C' THEN
      IF I_P_BANCO IS NOT NULL THEN
        O_ENABLE_IMP_CHEQUE := 'TRUE';
        O_ENABLE_CHEQUE     := 'TRUE';
        --LENNARD
        /*SET_ITEM_PROPERTY('BDOC.S_IMP_CHEQUE',ENABLED, PROPERTY_TRUE);
        SET_ITEM_PROPERTY('BDOC.S_IMP_CHEQUE',NAVIGABLE, PROPERTY_TRUE);
          SET_ITEM_PROPERTY('BPIE.CHEQUES',ENABLED,PROPERTY_TRUE);
          SET_ITEM_PROPERTY('BPIE.CHEQUES',NAVIGABLE,PROPERTY_TRUE);*/
      ELSE
        --LENNARD1
        IF I_DOC_TIPO_MOV <> 19 THEN
          O_ENABLE_CHEQPAG := 'FALSE';
          --SET_ITEM_PROPERTY('BPIE.CHEQPAG',ENABLED,PROPERTY_FALSE);
          --SET_ITEM_PROPERTY('BPIE.CHEQPAG',NAVIGABLE,PROPERTY_FALSE);

        END IF;
        O_ENABLE_CHEQUE := 'FALSE';
        /*SET_ITEM_PROPERTY('BPIE.CHEQUES',ENABLED,PROPERTY_FALSE);
        SET_ITEM_PROPERTY('BPIE.CHEQUES',NAVIGABLE,PROPERTY_FALSE);*/
      END IF;
    END IF;
  END PP_VER_CHEQ_EMIT;

  PROCEDURE PP_VALIDAR_CTA_BANCO(I_DOC_CTA_BCO          IN NUMBER,
                                 I_EMPRESA              IN NUMBER,
                                 I_USUARIO              IN VARCHAR2,
                                 I_P_MON_LOC            IN NUMBER,
                                 I_DOC_FEC_DOC          IN DATE,
                                 I_DOC_TIPO_MOV         IN NUMBER,
                                 I_CONF_RECIBO_PAGO_REC IN NUMBER,
                                 IO_CTA_BCO_DIA         IN OUT NUMBER,
                                 I_DOC_TIPO_SALDO       IN VARCHAR2,
                                 I_DOC_FEC_OPER         IN DATE,
                                 I_PAGO_BANCO           IN VARCHAR2,
                                 O_BCO_DESC             OUT VARCHAR2,
                                 O_CTA_DESC             OUT VARCHAR2,
                                 O_DOC_MON              OUT NUMBER,
                                 O_MON_DESC             OUT VARCHAR2,
                                 --O_P_CTA_BCO_DIA           OUT NUMBER,
                                 O_CTA_CHEQ_DIF_RESPALDO OUT NUMBER,
                                 O_CTA_NOT_TRAN_RESPALDO OUT NUMBER,
                                 O_W_MON_DEC_IMP         OUT GEN_MONEDA.MON_DEC_IMP%TYPE,
                                 O_W_MON_DEC_TASA        OUT GEN_MONEDA.MON_DEC_TASA%TYPE,
                                 O_P_MON_SIMBOLO         OUT GEN_MONEDA.MON_SIMBOLO%TYPE,
                                 O_TASA_OFIC             OUT NUMBER,
                                 O_P_PROX_CH             OUT VARCHAR2,
                                 O_P_CHEQUE_MENOR        OUT FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MENOR%TYPE,
                                 O_P_CHEQUE_MAYOR        OUT FIN_CUENTA_BANCARIA.CTA_NRO_CHEQUE_MAYOR%TYPE,
                                 O_P_BANCO               OUT FIN_CUENTA_BANCARIA.CTA_BCO%TYPE,
                                 O_P_IND_CHEQUE_DIF      OUT VARCHAR2,
                                 O_ENABLE_CHEQUES        OUT VARCHAR2,
                                 O_ENABLE_IMP_CHEQUE     OUT VARCHAR2,
                                 O_ENABLE_CHEQPAG        OUT VARCHAR2,
                                 O_S_IMP_CHEQUE          OUT VARCHAR2,
                                 O_P_CTA_DESC            OUT VARCHAR2) IS
  BEGIN
    IF I_DOC_CTA_BCO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'No puede ser nulo!');
    END IF;
    PP_VERIF_EXIST_CTA_BANC(I_EMPRESA              => I_EMPRESA,
                            I_DOC_CTA_BCO          => I_DOC_CTA_BCO,
                            I_USUARIO              => I_USUARIO,
                            I_P_MON_LOC            => I_P_MON_LOC,
                            I_DOC_FEC_DOC          => I_DOC_FEC_DOC,
                            I_DOC_TIPO_MOV         => I_DOC_TIPO_MOV,
                            I_CONF_RECIBO_PAGO_REC => I_CONF_RECIBO_PAGO_REC,
                            IO_CTA_BCO_DIA         => IO_CTA_BCO_DIA,
                            I_DOC_TIPO_SALDO       => I_DOC_TIPO_SALDO,
                            I_PAGO_BANCO           => I_PAGO_BANCO,
                            O_BCO_DESC             => O_BCO_DESC,
                            O_CTA_DESC             => O_CTA_DESC,
                            O_DOC_MON              => O_DOC_MON,
                            O_MON_DESC             => O_MON_DESC,
                            O_P_BANCO              => O_P_BANCO,
                            --O_P_CTA_BCO_DIA           => O_P_CTA_BCO_DIA,
                            O_CTA_CHEQ_DIF_RESPALDO => O_CTA_CHEQ_DIF_RESPALDO,
                            O_CTA_NOT_TRAN_RESPALDO => O_CTA_NOT_TRAN_RESPALDO,
                            O_W_MON_DEC_IMP         => O_W_MON_DEC_IMP,
                            O_W_MON_DEC_TASA        => O_W_MON_DEC_TASA,
                            O_P_MON_SIMBOLO         => O_P_MON_SIMBOLO,
                            O_TASA_OFIC             => O_TASA_OFIC,
                            O_P_PROX_CH             => O_P_PROX_CH,
                            O_P_CHEQUE_MENOR        => O_P_CHEQUE_MENOR,
                            O_P_CHEQUE_MAYOR        => O_P_CHEQUE_MAYOR,
                            O_P_CTA_DESC            => O_P_CTA_DESC);

    PP_CTA_CHEQ_EMIT_DIF(I_EMPRESA           => I_EMPRESA,
                         I_DOC_CTA_BCO       => I_DOC_CTA_BCO,
                         I_DOC_TIPO_SALDO    => I_DOC_TIPO_SALDO,
                         I_DOC_TIPO_MOV      => I_DOC_TIPO_MOV,
                         O_P_BANCO           => O_P_BANCO,
                         O_P_IND_CHEQUE_DIF  => O_P_IND_CHEQUE_DIF,
                         O_ENABLE_CHEQUES    => O_ENABLE_CHEQUES,
                         O_ENABLE_IMP_CHEQUE => O_ENABLE_IMP_CHEQUE,
                         O_ENABLE_CHEQPAG    => O_ENABLE_CHEQPAG,
                         O_S_IMP_CHEQUE      => O_S_IMP_CHEQUE);

    PP_VER_CHEQ_EMIT(I_DOC_TIPO_MOV      => I_DOC_TIPO_MOV,
                     I_DOC_TIPO_SALDO    => I_DOC_TIPO_SALDO,
                     I_P_BANCO           => O_P_BANCO,
                     O_ENABLE_IMP_CHEQUE => O_ENABLE_IMP_CHEQUE,
                     O_ENABLE_CHEQUE     => O_ENABLE_CHEQUES,
                     O_ENABLE_CHEQPAG    => O_ENABLE_CHEQPAG);

    /*IF I_DOC_MON = I_P_MON_LOC THEN
      -- SI ES MONEDA LOCAL
      SET_ITEM_PROPERTY('BDOC.S_TASA_OFIC',ENABLED,PROPERTY_FALSE);
    ELSE
      SET_ITEM_PROPERTY('BDOC.S_TASA_OFIC',ENABLED,PROPERTY_TRUE);
      SET_ITEM_PROPERTY('BDOC.S_TASA_OFIC',NAVIGABLE,PROPERTY_TRUE);
    END IF;*/

    FACI039.PP_VAL_CTA_BCO_MES_ACTUAL(P_FECHA   => I_DOC_FEC_OPER,
                                      P_CTA_BCO => I_DOC_CTA_BCO,
                                      P_EMPRESA => I_EMPRESA,
                                      P_USUARIO => I_USUARIO);
  END PP_VALIDAR_CTA_BANCO;

  PROCEDURE PP_VALIDAR_RUC_HOLDING(I_EMPRESA   IN NUMBER,
                                   I_S_HOLDING IN NUMBER,
                                   O_S_CLI_RUC OUT VARCHAR2) IS
    RUC CHAR(15);
  BEGIN
    SELECT C.CLI_RUC
      INTO RUC
      FROM FIN_CLIENTE C
     WHERE C.CLI_COD_FICHA_HOLDING = I_S_HOLDING
       AND C.CLI_EMPR = I_EMPRESA
     GROUP BY C.CLI_RUC;
    O_S_CLI_RUC := RUC;
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'No se puede realizar un Cobro o Pago a un Holding con clientes que tengan RUC distintos');
  END PP_VALIDAR_RUC_HOLDING;

  PROCEDURE PP_TRAER_DESC_HOLDING(I_EMPRESA            IN NUMBER,
                                  I_S_HOLDING          IN NUMBER,
                                  O_S_DOC_HOLDING_DESC OUT FIN_FICHA_HOLDING.HOL_DESC%TYPE,
                                  O_S_CLI_RUC          OUT VARCHAR2) IS

  BEGIN
    SELECT HOL_DESC
      INTO O_S_DOC_HOLDING_DESC
      FROM FIN_FICHA_HOLDING
     WHERE HOL_CODIGO = I_S_HOLDING
       AND HOL_EMPR = I_EMPRESA;

    PP_VALIDAR_RUC_HOLDING(I_EMPRESA   => I_EMPRESA,
                           I_S_HOLDING => I_S_HOLDING,
                           O_S_CLI_RUC => O_S_CLI_RUC);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_S_DOC_HOLDING_DESC := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'Holding inexistente!');
  END PP_TRAER_DESC_HOLDING;

  PROCEDURE PP_TRAER_DESC_PROV(I_EMPRESA         IN NUMBER,
                               I_W_CUENTA        IN NUMBER,
                               I_DOC_MON         IN NUMBER,
                               O_DOC_PROV        OUT VARCHAR2,
                               O_S_DOC_CLI_NOM   OUT VARCHAR2,
                               O_P_PROV_RUC      OUT VARCHAR2,
                               O_S_CLI_RUC       OUT VARCHAR2,
                               O_W_IND_RETENCION OUT VARCHAR2,
                               O_S_MOTIVO_BLOCK  OUT VARCHAR2) IS
    /* REVISADO EL 4/12/96 POR EITEL */

    V_BLOCK CHAR;
  BEGIN
    SELECT PROV_CODIGO,
           PROV_RAZON_SOCIAL,
           PROV_RUC,
           PROV_RUC,
           NVL(PROV_IND_RETENCION, 'S'),
           PROV_BLOQUEAR_PAGO,
           PROV_MOTIVO_BLOCK
      INTO O_DOC_PROV,
           O_S_DOC_CLI_NOM,
           O_P_PROV_RUC,
           O_S_CLI_RUC,
           O_W_IND_RETENCION,
           V_BLOCK,
           O_S_MOTIVO_BLOCK
      FROM FIN_PROVEEDOR, FIN_PROV_EMPRESA
     WHERE PREM_EMPR = I_EMPRESA
       AND PREM_EMPR = PROV_EMPR
       AND PROV_EMPR = PREM_EMPR
       AND PROV_CODIGO = PREM_PROV
       AND PREM_PROV = I_W_CUENTA
       AND PREM_MON = I_DOC_MON;

    -- INCLUIDO EL 01/06/2017, PARA QUE NO PERMITA PAGOS A LOS PROVEEDORES QUE ESTAN MARCADOS COMO BLOQUEADOS.

    IF V_BLOCK = 'S' THEN
      --SET_ITEM_PROPERTY('BDOC.S_MOTIVO_BLOCK',VISIBLE,PROPERTY_TRUE);
      RAISE_APPLICATION_ERROR(-20001,
                              'El proveedor esta bloqueado para pagos');
    ELSE
      NULL;
      --SET_ITEM_PROPERTY('BDOC.S_MOTIVO_BLOCK',VISIBLE,PROPERTY_FALSE);
    END IF;

    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_S_DOC_CLI_NOM := NULL;
      RAISE_APPLICATION_ERROR(-20001,
                              'Proveedor inexistente y/o falta habilitar en el 2-1-30!');
  END PP_TRAER_DESC_PROV;

  PROCEDURE PP_TRAER_DESC_CLI(I_W_CUENTA            IN NUMBER,
                              I_EMPRESA             IN NUMBER,
                              I_P_CONFIGURACION     IN VARCHAR2,
                              O_DOC_CLI             OUT FIN_CLIENTE.CLI_CODIGO%TYPE,
                              O_S_DOC_CLI_NOM       OUT FIN_CLIENTE.CLI_NOM%TYPE,
                              O_P_CLI_RUC           OUT FIN_CLIENTE.CLI_RUC%TYPE,
                              O_S_CLI_RUC           OUT FIN_CLIENTE.CLI_RUC%TYPE,
                              O_IND_CLI_FUNCIONARIO OUT VARCHAR2) IS
    /* REVISADO EL 10/07/00 POR MALE */

    V_PROFESION NUMBER;
  BEGIN
    SELECT CLI_CODIGO, CLI_NOM, CLI_RUC, CLI_RUC, CLI_PROFESION
      INTO O_DOC_CLI,
           O_S_DOC_CLI_NOM,
           O_P_CLI_RUC,
           O_S_CLI_RUC,
           V_PROFESION
      FROM FIN_CLIENTE
     WHERE CLI_CODIGO = I_W_CUENTA
       AND CLI_EMPR = I_EMPRESA;
    /*FECHA = 01/11/2001 - A PEDIDO DE CASA CENTRO NO SE PODRAN FACTIURAR CLIENTES
    QUE NO TENGAN DATOS EN PROFESION - SOLO CUANDO EL FORMATO DE IMPRESION DE LA
    FACTURA SEA CCENTRO */
    IF I_P_CONFIGURACION = 'CCENTRO' THEN
      IF V_PROFESION IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'Debe cargar la Profesion del Cliente, en el Programa Finm001 - Clientes!.');
      END IF;
    END IF;
    ------===========VERIFICAR SI EL CLIENTE ES EMPLEADO
    DECLARE
      MARC_EMPL NUMBER;
    BEGIN

      SELECT COUNT(*)
        INTO MARC_EMPL
        FROM PER_EMPLEADO P
       WHERE P.EMPL_COD_CLIENTE = I_W_CUENTA
         AND P.EMPL_EMPRESA = I_EMPRESA
         AND P.EMPL_SITUACION = 'A';

      IF MARC_EMPL > 0 THEN
        O_IND_CLI_FUNCIONARIO := 'S';
      ELSE
        O_IND_CLI_FUNCIONARIO := 'N';
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        O_IND_CLI_FUNCIONARIO := 'N';
    END;
    --==================================================

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_S_DOC_CLI_NOM := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'Cliente inexistente!');
  END PP_TRAER_DESC_CLI;

  PROCEDURE PP_EJECUTAR_CONSULTA_CUO(I_EMPRESA                  IN NUMBER,
                                     I_DOC_MON                  IN NUMBER,
                                     I_DOC_OPERADOR             IN NUMBER,
                                     I_W_CUENTA                 IN NUMBER,
                                     I_CONF_RECIBO_PAGO_EMIT    IN NUMBER,
                                     I_DOC_TIPO_MOV             IN NUMBER,
                                     I_CONF_FACT_CR_EMIT        IN NUMBER,
                                     I_CONF_NOTA_DB_EMIT        IN NUMBER,
                                     I_CONF_TMOV_ORDEN_COMPRA   IN NUMBER,
                                     I_TMOV_FACT_CR_EMIT_AJUSTE IN NUMBER,
                                     I_CONF_TMOV_PAGO_NC        IN NUMBER,
                                     I_CONF_NOTA_CR_EMIT        IN NUMBER,
                                     I_CONF_TMOV_DEVOL_ADEL_CLI IN NUMBER,
                                     I_CONF_ADELANTO_CLI        IN NUMBER,
                                     I_CONF_ADELANTO_PRO        IN NUMBER,
                                     I_CONF_TMOV_DEVOL_ADEL_PRO IN NUMBER,
                                     I_CONF_TMOV_PAGO_NC_REC    IN NUMBER,
                                     I_CONF_TMOV_IMPORTACION    IN NUMBER,
                                     I_CONF_NOTA_CR_REC         IN NUMBER,
                                     I_CONF_FACT_CR_REC         IN NUMBER,
                                     I_TMOV_FACT_CR_REC_AJUSTE  IN NUMBER,
                                     I_CONF_NOTA_DB_REC         IN NUMBER,
                                     I_CONF_TMOV_DESPACHO       IN NUMBER,
                                     I_CONF_RECIBO_PAGO_REC     IN NUMBER,
                                     I_S_HOLDING                IN NUMBER,
                                     I_W_IND_ER                 IN VARCHAR2,
                                     I_ORDENADO_POR             IN VARCHAR2,
                                     --I_DOC_NETO_EXEN_MON        IN NUMBER,
                                     O_S_RETEN_MON OUT NUMBER,
                                     O_S_RETEN_LOC OUT NUMBER) IS

    V_NUM_REG NUMBER;

    --CURSOR PARA CLIENTES
    CURSOR CLI_VTO_CUR IS
      SELECT DOC_NRO_DOC,
             DOC_FEC_DOC,
             CUO_FEC_VTO,
             DOC_OBS,
             CUO_IMP_MON,
             CUO_SALDO_MON,
             CUO_CLAVE_DOC,
             CUO_NRO_PAGARE,
             DOC_CANT_PAGARE
        FROM FIN_DOCUMENTO,
             FIN_CUOTA,
             (SELECT DOC_CLAVE_PADRE PADRE_DOC, DOC_EMPR PADRE_EMPRESA
                FROM FIN_DOCUMENTO D
               WHERE D.DOC_TIPO_MOV IN (47, 48)
                 AND D.DOC_EMPR = 1) ANUL,
             (SELECT T.NPDR_CLAVE_DOC NEG_CLAVE, NPDR_EMPR NEG_EMPR
                FROM FIN_NEG_PREST_DOC_REL T) NEG_PREST

       WHERE CUO_EMPR = I_EMPRESA
         AND CUO_EMPR = DOC_EMPR
         AND CUO_CLAVE_DOC = DOC_CLAVE
         AND DOC_MON = I_DOC_MON
         AND DOC_CLAVE = ANUL.PADRE_DOC(+)
         AND DOC_EMPR = ANUL.PADRE_EMPRESA(+)
         AND ANUL.PADRE_EMPRESA IS NULL

         AND DOC_CLAVE = NEG_PREST.NEG_CLAVE(+)
         AND DOC_EMPR = NEG_PREST.NEG_EMPR(+)
         AND NEG_PREST.NEG_CLAVE IS NULL

         AND DOC_EMPR = I_EMPRESA
         AND DOC_OPERADOR = I_DOC_OPERADOR
         AND ((DOC_CLI = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_RECIBO_PAGO_EMIT AND
             DOC_TIPO_MOV IN
             (I_CONF_FACT_CR_EMIT,
                I_CONF_NOTA_DB_EMIT,
                I_CONF_TMOV_ORDEN_COMPRA,
                I_TMOV_FACT_CR_EMIT_AJUSTE)) OR
             (DOC_CLI = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_TMOV_PAGO_NC AND
             DOC_TIPO_MOV = I_CONF_NOTA_CR_EMIT) OR
             (DOC_CLI = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_TMOV_DEVOL_ADEL_CLI AND
             DOC_TIPO_MOV = I_CONF_ADELANTO_CLI))
         AND CUO_SALDO_MON > 0
       ORDER BY CUO_FEC_VTO, DOC_FEC_DOC, DOC_NRO_DOC;

    CURSOR CLI_DOC_CUR IS
      SELECT DOC_NRO_DOC,
             DOC_FEC_DOC,
             CUO_FEC_VTO,
             DOC_OBS,
             CUO_IMP_MON,
             CUO_SALDO_MON,
             CUO_CLAVE_DOC,
             CUO_NRO_PAGARE,
             DOC_CANT_PAGARE
        FROM FIN_DOCUMENTO,
             FIN_CUOTA,
             (SELECT DOC_CLAVE_PADRE PADRE_DOC, DOC_EMPR PADRE_EMPRESA
                FROM FIN_DOCUMENTO D
               WHERE D.DOC_TIPO_MOV IN (47, 48)
                 AND D.DOC_EMPR = 1) ANUL,
             (SELECT T.NPDR_CLAVE_DOC NEG_CLAVE, NPDR_EMPR NEG_EMPR
                FROM FIN_NEG_PREST_DOC_REL T) NEG_PREST
       WHERE CUO_EMPR = I_EMPRESA
         AND CUO_EMPR = DOC_EMPR
            --AND FIN_FACT_ANUL(DOC_CLAVE) = 'N'
         AND DOC_CLAVE = ANUL.PADRE_DOC(+)
         AND DOC_EMPR = ANUL.PADRE_EMPRESA(+)
         AND ANUL.PADRE_EMPRESA IS NULL
         AND DOC_CLAVE = ANUL.PADRE_DOC(+)
         AND DOC_EMPR = ANUL.PADRE_EMPRESA(+)
         AND ANUL.PADRE_EMPRESA IS NULL

         AND DOC_CLAVE = NEG_PREST.NEG_CLAVE(+)
         AND DOC_EMPR = NEG_PREST.NEG_EMPR(+)
         AND NEG_PREST.NEG_CLAVE IS NULL

         AND CUO_CLAVE_DOC = DOC_CLAVE
         AND DOC_MON = I_DOC_MON
         AND DOC_EMPR = I_EMPRESA
         AND DOC_OPERADOR = I_DOC_OPERADOR
         AND ((DOC_CLI = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_RECIBO_PAGO_EMIT AND
             DOC_TIPO_MOV IN
             (I_CONF_FACT_CR_EMIT,
                I_CONF_NOTA_DB_EMIT,
                I_CONF_TMOV_ORDEN_COMPRA,
                I_TMOV_FACT_CR_EMIT_AJUSTE))

             OR (DOC_CLI = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_TMOV_PAGO_NC AND
             DOC_TIPO_MOV = I_CONF_NOTA_CR_EMIT)

             OR (DOC_CLI = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_TMOV_DEVOL_ADEL_CLI AND
             DOC_TIPO_MOV = I_CONF_ADELANTO_CLI))
         AND CUO_SALDO_MON > 0
       ORDER BY DOC_NRO_DOC;

    --CURSOR PARA CLIENTES HOLDINGS
    CURSOR CLI_HOLDING_DOC_CUR IS
      SELECT DOC_NRO_DOC,
             DOC_FEC_DOC,
             CUO_FEC_VTO,
             DOC_OBS,
             CUO_IMP_MON,
             CUO_SALDO_MON,
             CUO_CLAVE_DOC,
             CUO_NRO_PAGARE,
             DOC_CANT_PAGARE,
             DOC_CLI,
             DOC_CLI_NOM,
             DOC_CLI_RUC
        FROM FIN_DOCUMENTO,
             FIN_CUOTA,
             (SELECT DOC_CLAVE_PADRE PADRE_DOC, DOC_EMPR PADRE_EMPRESA
                FROM FIN_DOCUMENTO D
               WHERE D.DOC_TIPO_MOV IN (47, 48)
                 AND D.DOC_EMPR = 1) ANUL,
             (SELECT T.NPDR_CLAVE_DOC NEG_CLAVE, NPDR_EMPR NEG_EMPR
                FROM FIN_NEG_PREST_DOC_REL T) NEG_PREST
       WHERE CUO_EMPR = I_EMPRESA
         AND CUO_EMPR = DOC_EMPR
         AND CUO_CLAVE_DOC = DOC_CLAVE
         AND DOC_MON = I_DOC_MON
            --AND FIN_FACT_ANUL(DOC_CLAVE) = 'N'

         AND DOC_CLAVE = NEG_PREST.NEG_CLAVE(+)
         AND DOC_EMPR = NEG_PREST.NEG_EMPR(+)
         AND NEG_PREST.NEG_CLAVE IS NULL

         AND DOC_CLAVE = ANUL.PADRE_DOC(+)
         AND DOC_EMPR = ANUL.PADRE_EMPRESA(+)
         AND ANUL.PADRE_EMPRESA IS NULL
         AND DOC_EMPR = I_EMPRESA
         AND DOC_OPERADOR = I_DOC_OPERADOR
         AND ((DOC_CLI IN (SELECT CLI_CODIGO
                             FROM FIN_CLIENTE
                            WHERE CLI_COD_FICHA_HOLDING = I_S_HOLDING
                              AND CLI_EMPR = I_EMPRESA) --:BDOC.W_CUENTA--PARA TRAER LOS HOLDING
             AND I_DOC_TIPO_MOV = I_CONF_RECIBO_PAGO_EMIT AND
             DOC_TIPO_MOV IN
             (I_CONF_FACT_CR_EMIT,
                I_CONF_NOTA_DB_EMIT,
                I_CONF_TMOV_ORDEN_COMPRA,
                I_TMOV_FACT_CR_EMIT_AJUSTE))

             OR (DOC_CLI IN (SELECT CLI_CODIGO
                                FROM FIN_CLIENTE
                               WHERE CLI_COD_FICHA_HOLDING = I_S_HOLDING
                                 AND CLI_EMPR = I_EMPRESA) --:BDOC.W_CUENTA--PARA TRAER LOS HOLDING
             AND I_DOC_TIPO_MOV = I_CONF_TMOV_PAGO_NC AND
             DOC_TIPO_MOV = I_CONF_NOTA_CR_EMIT)

             OR (DOC_CLI IN (SELECT CLI_CODIGO
                                FROM FIN_CLIENTE
                               WHERE CLI_COD_FICHA_HOLDING = I_S_HOLDING
                                 AND CLI_EMPR = I_EMPRESA) --:BDOC.W_CUENTA--PARA TRAER LOS HOLDING
             AND I_DOC_TIPO_MOV = I_CONF_TMOV_DEVOL_ADEL_CLI AND
             DOC_TIPO_MOV = I_CONF_ADELANTO_CLI))
         AND CUO_SALDO_MON > 0
       ORDER BY DOC_NRO_DOC;

    CURSOR CLI_HOLDING_VTO_CUR IS

      SELECT DOC_NRO_DOC,
             DOC_FEC_DOC,
             CUO_FEC_VTO,
             DOC_OBS,
             CUO_IMP_MON,
             CUO_SALDO_MON,
             CUO_CLAVE_DOC,
             CUO_NRO_PAGARE,
             DOC_CANT_PAGARE,
             DOC_CLI,
             DOC_CLI_NOM,
             DOC_CLI_RUC
        FROM FIN_DOCUMENTO,
             FIN_CUOTA,
             (SELECT DOC_CLAVE_PADRE PADRE_DOC, DOC_EMPR PADRE_EMPRESA
                FROM FIN_DOCUMENTO D
               WHERE D.DOC_TIPO_MOV IN (47, 48)
                 AND D.DOC_EMPR = I_EMPRESA) ANUL,
             (SELECT T.NPDR_CLAVE_DOC NEG_CLAVE, NPDR_EMPR NEG_EMPR
                FROM FIN_NEG_PREST_DOC_REL T) NEG_PREST
       WHERE CUO_EMPR = I_EMPRESA
         AND CUO_EMPR = DOC_EMPR
            --AND FIN_FACT_ANUL(DOC_CLAVE) = 'N'
         AND DOC_CLAVE = ANUL.PADRE_DOC(+)
         AND DOC_EMPR = ANUL.PADRE_EMPRESA(+)
         AND ANUL.PADRE_EMPRESA IS NULL

         AND DOC_CLAVE = NEG_PREST.NEG_CLAVE(+)
         AND DOC_EMPR = NEG_PREST.NEG_EMPR(+)
         AND NEG_PREST.NEG_CLAVE IS NULL

         AND CUO_CLAVE_DOC = DOC_CLAVE
         AND DOC_MON = I_DOC_MON
         AND DOC_EMPR = I_EMPRESA
         AND DOC_OPERADOR = I_DOC_OPERADOR
         AND ((DOC_CLI IN (SELECT CLI_CODIGO
                             FROM FIN_CLIENTE
                            WHERE CLI_COD_FICHA_HOLDING = I_S_HOLDING
                              AND CLI_EMPR = I_EMPRESA) --:BDOC.W_CUENTA--PARA TRAER LOS HOLDING
             AND I_DOC_TIPO_MOV = I_CONF_RECIBO_PAGO_EMIT AND
             DOC_TIPO_MOV IN
             (I_CONF_FACT_CR_EMIT,
                I_CONF_NOTA_DB_EMIT,
                I_CONF_TMOV_ORDEN_COMPRA,
                I_TMOV_FACT_CR_EMIT_AJUSTE)) OR
             (DOC_CLI IN (SELECT CLI_CODIGO
                             FROM FIN_CLIENTE
                            WHERE CLI_COD_FICHA_HOLDING = I_S_HOLDING
                              AND CLI_EMPR = I_EMPRESA) --:BDOC.W_CUENTA--PARA TRAER LOS HOLDING
             AND I_DOC_TIPO_MOV = I_CONF_TMOV_PAGO_NC AND
             DOC_TIPO_MOV = I_CONF_NOTA_CR_EMIT) OR
             (DOC_CLI IN (SELECT CLI_CODIGO
                             FROM FIN_CLIENTE
                            WHERE CLI_COD_FICHA_HOLDING = I_S_HOLDING
                              AND CLI_EMPR = I_EMPRESA) --:BDOC.W_CUENTA--PARA TRAER LOS HOLDING
             AND I_DOC_TIPO_MOV = I_CONF_TMOV_DEVOL_ADEL_CLI AND
             DOC_TIPO_MOV = I_CONF_ADELANTO_CLI))
         AND CUO_SALDO_MON > 0
       ORDER BY CUO_FEC_VTO, DOC_FEC_DOC, DOC_NRO_DOC;

    --------------------------------------------------------------------------------------------------------

    --CURSOR PARA PROVEEDORES
    CURSOR PROV_VTO_CUR IS
      SELECT DOC_NRO_DOC,
             DOC_FEC_DOC,
             CUO_FEC_VTO,
             DOC_OBS,
             CUO_IMP_MON,
             CUO_SALDO_MON,
             CUO_CLAVE_DOC,
             CUO_NRO_PAGARE,
             DOC_CANT_PAGARE,
             DOC_CLAVE_RETENCION,
             (NVL(DOC_NETO_GRAV_MON, 0)) GRAVADO,
             (NVL(DOC_NETO_GRAV_MON, 0) * NVL(DOC_TASA, 1)) GRAVADO_LOC,
             (NVL(DOC_NETO_EXEN_MON, 0)) EXENTO,
             (NVL(DOC_NETO_EXEN_MON, 0) * NVL(DOC_TASA, 1)) EXENTO_LOC,
             (NVL(DOC_IVA_MON, 0)) IVA,
             (NVL(DOC_IVA_MON, 0) * NVL(DOC_TASA, 1)) IVA_LOC
        FROM FIN_DOCUMENTO,
             FIN_CUOTA,
             (SELECT DOC_CLAVE_PADRE PADRE_DOC, DOC_EMPR PADRE_EMPRESA
                FROM FIN_DOCUMENTO D
               WHERE D.DOC_TIPO_MOV IN (47, 48)
                 AND D.DOC_EMPR = I_EMPRESA) ANUL,
             (SELECT T.NPDR_CLAVE_DOC NEG_CLAVE, NPDR_EMPR NEG_EMPR
                FROM FIN_NEG_PREST_DOC_REL T) NEG_PREST
       WHERE CUO_EMPR = I_EMPRESA
         AND CUO_EMPR = DOC_EMPR
         AND CUO_CLAVE_DOC = DOC_CLAVE
         AND DOC_MON = I_DOC_MON
            --AND FIN_FACT_ANUL(DOC_CLAVE) = 'N'
         AND DOC_CLAVE = ANUL.PADRE_DOC(+)
         AND DOC_EMPR = ANUL.PADRE_EMPRESA(+)
         AND ANUL.PADRE_EMPRESA IS NULL

         AND DOC_CLAVE = NEG_PREST.NEG_CLAVE(+)
         AND DOC_EMPR = NEG_PREST.NEG_EMPR(+)
         AND NEG_PREST.NEG_CLAVE IS NULL

         AND DOC_EMPR = I_EMPRESA
         AND DOC_OPERADOR = I_DOC_OPERADOR
         AND ((DOC_PROV = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_RECIBO_PAGO_REC AND
             DOC_TIPO_MOV IN (I_CONF_FACT_CR_REC,
                                I_TMOV_FACT_CR_REC_AJUSTE,
                                I_CONF_NOTA_DB_REC,
                                I_CONF_TMOV_DESPACHO,
                                I_CONF_TMOV_IMPORTACION)) OR
             (DOC_PROV = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_TMOV_PAGO_NC_REC AND
             DOC_TIPO_MOV IN (I_CONF_NOTA_CR_REC, 44)) OR
             (DOC_PROV = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_TMOV_DEVOL_ADEL_PRO AND
             DOC_TIPO_MOV IN (I_CONF_ADELANTO_PRO, 81)))
         AND CUO_SALDO_MON > 0
       ORDER BY CUO_FEC_VTO, DOC_FEC_DOC, DOC_NRO_DOC;

    CURSOR PROV_DOC_CUR IS
      SELECT DOC_NRO_DOC,
             DOC_FEC_DOC,
             CUO_FEC_VTO,
             DOC_OBS,
             CUO_IMP_MON,
             CUO_SALDO_MON,
             CUO_CLAVE_DOC,
             CUO_NRO_PAGARE,
             DOC_CANT_PAGARE,
             DOC_CLAVE_RETENCION,
             (NVL(DOC_NETO_GRAV_MON, 0)) GRAVADO,
             (NVL(DOC_NETO_GRAV_MON, 0) * NVL(DOC_TASA, 1)) GRAVADO_LOC,
             (NVL(DOC_NETO_EXEN_MON, 0)) EXENTO,
             (NVL(DOC_NETO_EXEN_MON, 0) * NVL(DOC_TASA, 1)) EXENTO_LOC,
             (NVL(DOC_IVA_MON, 0)) IVA,
             (NVL(DOC_IVA_MON, 0) * NVL(DOC_TASA, 1)) IVA_LOC
        FROM FIN_DOCUMENTO,
             FIN_CUOTA,
             (SELECT DOC_CLAVE_PADRE PADRE_DOC, DOC_EMPR PADRE_EMPRESA
                FROM FIN_DOCUMENTO D
               WHERE D.DOC_TIPO_MOV IN (47, 48)
                 AND D.DOC_EMPR = I_EMPRESA) ANUL,
             (SELECT T.NPDR_CLAVE_DOC NEG_CLAVE, NPDR_EMPR NEG_EMPR
                FROM FIN_NEG_PREST_DOC_REL T) NEG_PREST
       WHERE CUO_EMPR = I_EMPRESA
         AND CUO_EMPR = DOC_EMPR
         AND CUO_CLAVE_DOC = DOC_CLAVE
         AND DOC_MON = I_DOC_MON
         AND DOC_EMPR = I_EMPRESA
         AND DOC_CLAVE = ANUL.PADRE_DOC(+)
         AND DOC_EMPR = ANUL.PADRE_EMPRESA(+)
         AND ANUL.PADRE_EMPRESA IS NULL

         AND DOC_CLAVE = NEG_PREST.NEG_CLAVE(+)
         AND DOC_EMPR = NEG_PREST.NEG_EMPR(+)
         AND NEG_PREST.NEG_CLAVE IS NULL

         AND DOC_OPERADOR = I_DOC_OPERADOR
         AND ((DOC_PROV = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_RECIBO_PAGO_REC AND
             DOC_TIPO_MOV IN (I_CONF_FACT_CR_REC,
                                I_TMOV_FACT_CR_REC_AJUSTE,
                                I_CONF_NOTA_DB_REC,
                                I_CONF_TMOV_DESPACHO,
                                I_CONF_TMOV_IMPORTACION)) OR
             (DOC_PROV = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_TMOV_PAGO_NC_REC AND
             DOC_TIPO_MOV IN (I_CONF_NOTA_CR_REC, 44)) OR
             (DOC_PROV = I_W_CUENTA AND
             I_DOC_TIPO_MOV = I_CONF_TMOV_DEVOL_ADEL_PRO AND
             DOC_TIPO_MOV IN (I_CONF_ADELANTO_PRO, 81)))
         AND CUO_SALDO_MON > 0
       ORDER BY DOC_NRO_DOC;
  BEGIN

    --- raise_application_error (-20001,I_CONF_NOTA_CR_EMIT);

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_FINI003') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_FINI003');
    END IF;

    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_FINI003') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_FINI003');
    END IF;

    O_S_RETEN_MON := null;
    O_S_RETEN_LOC := NULL;

    IF I_W_IND_ER = 'R' THEN
      IF I_ORDENADO_POR = 'FACTURA' THEN

        FOR RCUO IN PROV_DOC_CUR LOOP

          APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                     P_C001            => RCUO.DOC_NRO_DOC,
                                     P_D001            => RCUO.DOC_FEC_DOC,
                                     P_D002            => RCUO.CUO_FEC_VTO,
                                     P_C002            => RCUO.DOC_OBS,
                                     P_N001            => RCUO.CUO_IMP_MON,
                                     P_N002            => RCUO.CUO_SALDO_MON,
                                     P_C003            => RCUO.CUO_CLAVE_DOC,
                                     P_C004            => RCUO.CUO_NRO_PAGARE,
                                     P_C005            => RCUO.DOC_CANT_PAGARE,
                                     P_C006            => RCUO.DOC_CLAVE_RETENCION,
                                     P_N003            => RCUO.GRAVADO,
                                     P_N004            => RCUO.GRAVADO_LOC,
                                     P_N005            => RCUO.EXENTO,
                                     P_C007            => RCUO.EXENTO_LOC,
                                     P_C008            => RCUO.IVA,
                                     P_C009            => RCUO.IVA_LOC,
                                     P_C010            => 0);

        END LOOP;
      ELSE
        FOR RCUO IN PROV_VTO_CUR LOOP

          APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                     P_C001            => RCUO.DOC_NRO_DOC,
                                     P_D001            => RCUO.DOC_FEC_DOC,
                                     P_D002            => RCUO.CUO_FEC_VTO,
                                     P_C002            => RCUO.DOC_OBS,
                                     P_N001            => RCUO.CUO_IMP_MON,
                                     P_N002            => RCUO.CUO_SALDO_MON,
                                     P_C003            => RCUO.CUO_CLAVE_DOC,
                                     P_C004            => RCUO.CUO_NRO_PAGARE,
                                     P_C005            => RCUO.DOC_CANT_PAGARE,
                                     P_C006            => RCUO.DOC_CLAVE_RETENCION,
                                     P_N003            => RCUO.GRAVADO,
                                     P_N004            => RCUO.GRAVADO_LOC,
                                     P_N005            => RCUO.EXENTO,
                                     P_C007            => RCUO.EXENTO_LOC,
                                     P_C008            => RCUO.IVA,
                                     P_C009            => RCUO.IVA_LOC,
                                     P_C010            => 0);

        END LOOP;

      END IF;

      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                 P_C001            => NULL,
                                 P_D001            => NULL,
                                 P_D002            => NULL,
                                 P_C002            => '----------FIN DE DOCUMENTOS-------',
                                 P_N001            => NULL,
                                 P_N002            => NULL,
                                 P_C003            => NULL,
                                 P_C004            => NULL,
                                 P_C005            => NULL,
                                 P_C006            => NULL,
                                 P_N003            => NULL,
                                 P_N004            => NULL,
                                 P_N005            => NULL,
                                 P_C007            => NULL,
                                 P_C008            => NULL,
                                 P_C009            => NULL,
                                 P_C010            => 0);

    ELSE

      IF I_S_HOLDING IS NOT NULL THEN
        --HOLDING
        IF I_ORDENADO_POR = 'FACTURA' THEN
          FOR RCUO IN CLI_HOLDING_DOC_CUR LOOP

            APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                       P_C001            => RCUO.DOC_NRO_DOC,
                                       P_D001            => RCUO.DOC_FEC_DOC,
                                       P_D002            => RCUO.CUO_FEC_VTO,
                                       P_C002            => RCUO.DOC_OBS,
                                       P_N001            => RCUO.CUO_IMP_MON,
                                       P_N002            => RCUO.CUO_SALDO_MON,
                                       P_C003            => RCUO.CUO_CLAVE_DOC,
                                       P_C004            => RCUO.CUO_NRO_PAGARE,
                                       P_C005            => RCUO.DOC_CANT_PAGARE,
                                       P_C006            => RCUO.DOC_CLI_NOM,
                                       P_N003            => RCUO.DOC_CLI,
                                       P_C007            => RCUO.DOC_CLI_RUC,
                                       P_C010            => 0);

          END LOOP;
        ELSE

          FOR RCUO IN CLI_HOLDING_VTO_CUR LOOP

            APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                       P_C001            => RCUO.DOC_NRO_DOC,
                                       P_D001            => RCUO.DOC_FEC_DOC,
                                       P_D002            => RCUO.CUO_FEC_VTO,
                                       P_C002            => RCUO.DOC_OBS,
                                       P_N001            => RCUO.CUO_IMP_MON,
                                       P_N002            => RCUO.CUO_SALDO_MON,
                                       P_C003            => RCUO.CUO_CLAVE_DOC,
                                       P_C004            => RCUO.CUO_NRO_PAGARE,
                                       P_C005            => RCUO.DOC_CANT_PAGARE,
                                       P_C006            => RCUO.DOC_CLI_NOM,
                                       P_N003            => RCUO.DOC_CLI,
                                       P_C007            => RCUO.DOC_CLI_RUC,
                                       P_C010            => 0);

          END LOOP;
        END IF;

        APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                   P_C001            => NULL,
                                   P_D001            => NULL,
                                   P_D002            => NULL,
                                   P_C002            => '----------FIN DE DOCUMENTOS-------',
                                   P_N001            => NULL,
                                   P_N002            => NULL,
                                   P_C003            => NULL,
                                   P_C004            => NULL,
                                   P_C005            => NULL,
                                   P_C006            => NULL,
                                   P_N003            => NULL,
                                   P_C007            => NULL,
                                   P_C010            => 0);

      ELSE
        --CLIENTES

        IF I_ORDENADO_POR = 'FACTURA' THEN
          FOR RCUO IN CLI_DOC_CUR LOOP

            APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                       P_C001            => RCUO.DOC_NRO_DOC,
                                       P_D001            => RCUO.DOC_FEC_DOC,
                                       P_D002            => RCUO.CUO_FEC_VTO,
                                       P_C002            => RCUO.DOC_OBS,
                                       P_N001            => RCUO.CUO_IMP_MON,
                                       P_N002            => RCUO.CUO_SALDO_MON,
                                       P_C003            => RCUO.CUO_CLAVE_DOC,
                                       P_C004            => RCUO.CUO_NRO_PAGARE,
                                       P_C005            => RCUO.DOC_CANT_PAGARE,
                                       P_C010            => 0);

          END LOOP;
        ELSE
          FOR RCUO IN CLI_VTO_CUR LOOP

            APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                       P_C001            => RCUO.DOC_NRO_DOC,
                                       P_D001            => RCUO.DOC_FEC_DOC,
                                       P_D002            => RCUO.CUO_FEC_VTO,
                                       P_C002            => RCUO.DOC_OBS,
                                       P_N001            => RCUO.CUO_IMP_MON,
                                       P_N002            => RCUO.CUO_SALDO_MON,
                                       P_C003            => RCUO.CUO_CLAVE_DOC,
                                       P_C004            => RCUO.CUO_NRO_PAGARE,
                                       P_C005            => RCUO.DOC_CANT_PAGARE,
                                       P_C010            => 0);

          END LOOP;
        END IF;

        APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                   P_C001            => NULL,
                                   P_D001            => NULL,
                                   P_D002            => NULL,
                                   P_C002            => '----------FIN DE DOCUMENTOS-------',
                                   P_N001            => NULL,
                                   P_N002            => NULL,
                                   P_C003            => NULL,
                                   P_C004            => NULL,
                                   P_C005            => NULL,
                                   P_C006            => NULL,
                                   P_N003            => NULL,
                                   P_C007            => NULL,
                                   P_C010            => 0);

      END IF;
    END IF;
    --
    SELECT COUNT(1)
      INTO V_NUM_REG
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'DETALLE_FINI003';
    /*IF V_NUM_REG = 0 THEN
       RAISE_APPLICATION_ERROR(-20002,'No existen comprobantes pendientes!');
    END IF;*/
  END PP_EJECUTAR_CONSULTA_CUO;

  PROCEDURE PP_ACTUALIZAR_COL(I_SEQ_ID   IN NUMBER,
                              I_IMP_PAGO IN NUMBER,
                              I_IND_PAGO IN VARCHAR2) IS
  BEGIN

    APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                            P_SEQ             => I_SEQ_ID,
                                            P_ATTR_NUMBER     => 10,
                                            P_ATTR_VALUE      => I_IMP_PAGO); --TO_NUMBER(I_IMP_PAGO));

    APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                            P_SEQ             => I_SEQ_ID,
                                            P_ATTR_NUMBER     => 11,
                                            P_ATTR_VALUE      => I_IND_PAGO); --TO_NUMBER(I_IMP_PAGO));

  END PP_ACTUALIZAR_COL;

  PROCEDURE PP_ACTUALIZAR_TOTAL_DIF(I_DOC_NETO_EXEN_MON IN NUMBER,
                                    O_SUM_PAGO          OUT NUMBER,
                                    O_DIF_PAGO          OUT NUMBER) IS
  BEGIN
    SELECT SUM(C010) S_IMP_PAGO
      INTO O_SUM_PAGO
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'DETALLE_FINI003';

    O_DIF_PAGO := I_DOC_NETO_EXEN_MON - O_SUM_PAGO;

  END PP_ACTUALIZAR_TOTAL_DIF;

  PROCEDURE PP_HOLDING_RECIBO(I_S_TASA_OFIC          IN NUMBER,
                              I_P_CANT_DECIMALES_LOC IN NUMBER,
                              I_CONF_CONCEPTO_COBRO  IN NUMBER,
                              I_EMPRESA              IN NUMBER,
                              I_DOC_CTA_BCO          IN NUMBER,
                              I_SUCURSAL             IN NUMBER,
                              I_DOC_NRO_DOC          IN NUMBER,
                              I_DOC_MON              IN NUMBER,
                              I_DOC_FEC_OPER         IN DATE,
                              I_DOC_FEC_DOC          IN DATE,
                              I_USUARIO              IN VARCHAR2,
                              I_DOC_OPERADOR         IN NUMBER,
                              I_DOC_SERIE            IN VARCHAR2,
                              I_S_ACT_IMPRESORA      IN VARCHAR2,
                              P_CLAVE_RECIBOS        OUT VARCHAR2) IS

    --V_CLIENTE             NUMBER;
    V_SUM_CUO_LOC         NUMBER := 0;
    V_SUM_CUO_MON         NUMBER := 0;
    V_DCON_CLAVE_CONCEPTO NUMBER := I_CONF_CONCEPTO_COBRO;
    V_DCON_CLAVE_CTACO    NUMBER;
    V_DCON_TIPO_SALDO     CHAR;
    --V_TOT_IMP_PAGO_LOC    NUMBER := 0;
    --V_DIFERENCIA          NUMBER := 0;
    V_COB_CLAVE      NUMBER;
    V_CLAVE_PADRE    NUMBER;
    V_CLAVE_IMPRIMIR VARCHAR2(2000);
    V_COB_NRO_DOC    NUMBER := I_DOC_NRO_DOC;
    V_SUMAR_ITEM     NUMBER := 0;
  BEGIN
--RAISE_APPLICATION_ERROR(-20002, I_CONF_CONCEPTO_COBRO);
    --DISTINGUIR LOS CLIENTES.

    DELETE FROM FIN_FINI003_TEMP;

    FOR REG IN (SELECT SEQ_ID,
                       C001   DOC_NRO_DOC,
                       D001   DOC_FEC_DOC,
                       D002   CUO_FEC_VTO,
                       C002   DOC_OBS,
                       N001   CUO_IMP_MON,
                       N002   CUO_SALDO_MON,
                       C010   S_IMP_PAGO,
                       C003   CUO_CLAVE_DOC,
                       N003   DOC_CLI,
                       N004   DOC_CLI_RUC
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'DETALLE_FINI003') LOOP
      IF REG.S_IMP_PAGO != 0 THEN
        INSERT INTO FIN_FINI003_TEMP
          (FINI003_CLI, FINI003_CLAVE_CUO, FINI003_VTO_CUO, FINI003_IMP)
        VALUES
          (REG.DOC_CLI, REG.CUO_CLAVE_DOC, REG.CUO_FEC_VTO, REG.S_IMP_PAGO);
      END IF;
    END LOOP;

    FOR V IN (SELECT FINI003_CLI, SUM(FINI003_IMP) SUM_IMPORTE
                FROM FIN_FINI003_TEMP
               GROUP BY FINI003_CLI) LOOP
      -- CABECERA

      V_SUMAR_ITEM := V_SUMAR_ITEM + 1;

      V_COB_CLAVE   := FIN_SEQ_DOC_NEXTVAL;

      V_SUM_CUO_LOC := ROUND(V.SUM_IMPORTE * I_S_TASA_OFIC,
                             I_P_CANT_DECIMALES_LOC);
      V_SUM_CUO_MON := V.SUM_IMPORTE;

      V_CLAVE_IMPRIMIR := V_CLAVE_IMPRIMIR || ';' || V_COB_CLAVE;

      INSERT INTO FIN_DOCUMENTO
        (DOC_CLAVE,
         DOC_EMPR,
         DOC_CTA_BCO,
         DOC_SUC,
         DOC_TIPO_MOV,
         DOC_NRO_DOC,
         DOC_TIPO_SALDO,
         DOC_MON,
         DOC_CLI,
         DOC_CLI_NOM,
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
         DOC_LOGIN,
         DOC_FEC_GRAB,
         DOC_SIST,
         DOC_OPERADOR,
         DOC_COBRADOR,
         DOC_SERIE,
         DOC_TASA,
         DOC_CLAVE_PADRE)
      VALUES
        (V_COB_CLAVE,
         I_EMPRESA,
         I_DOC_CTA_BCO,
         I_SUCURSAL,
         6,
         V_COB_NRO_DOC,
         'D',
         I_DOC_MON,
         V.FINI003_CLI,
         '',
         I_DOC_FEC_OPER,
         I_DOC_FEC_DOC,
         V_SUM_CUO_LOC,
         V_SUM_CUO_MON,
         0,
         0,
         V_SUM_CUO_LOC,
         V_SUM_CUO_MON,
         0,
         0,
         0,
         0,
         0,
         0,
         I_USUARIO,
         SYSDATE,
         'FIN',
         I_DOC_OPERADOR,
         NULL,
         I_DOC_SERIE,
         I_S_TASA_OFIC,
         V_CLAVE_PADRE);

      IF V_CLAVE_PADRE IS NULL THEN
        V_CLAVE_PADRE := V_COB_CLAVE;
      END IF;

      -------------------------------------
      --**    FIN_DOC_CONCEPTO  **--
      -------------------------------------
      SELECT FCON_CLAVE_CTACO, FCON_TIPO_SALDO
        INTO V_DCON_CLAVE_CTACO, V_DCON_TIPO_SALDO
        FROM FIN_CONCEPTO
       WHERE FCON_CLAVE = V_DCON_CLAVE_CONCEPTO
         AND FCON_EMPR = I_EMPRESA;

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
        (V_COB_CLAVE,
         1,
         V_DCON_CLAVE_CONCEPTO,
         V_DCON_CLAVE_CTACO,
         V_DCON_TIPO_SALDO,
         V_SUM_CUO_LOC,
         V_SUM_CUO_MON,
         0,
         0,
         0,
         0,
         I_EMPRESA);

      --DETALLES

      FOR REG IN (SELECT SEQ_ID,
                         C001   DOC_NRO_DOC,
                         D001   DOC_FEC_DOC,
                         D002   CUO_FEC_VTO,
                         C002   DOC_OBS,
                         N001   CUO_IMP_MON,
                         N002   CUO_SALDO_MON,
                         C010   S_IMP_PAGO,
                         C003   CUO_CLAVE_DOC,
                         N003   DOC_CLI,
                         N004   DOC_CLI_RUC
                    FROM APEX_COLLECTIONS
                   WHERE COLLECTION_NAME = 'DETALLE_FINI003') LOOP
        IF REG.S_IMP_PAGO != 0 AND V.FINI003_CLI = REG.DOC_CLI THEN

          V_SUM_CUO_LOC := ROUND(REG.S_IMP_PAGO * I_S_TASA_OFIC,
                                 I_P_CANT_DECIMALES_LOC);
          V_SUM_CUO_MON := REG.S_IMP_PAGO;

          INSERT INTO FIN_PAGO
            (PAG_CLAVE_DOC,
             PAG_FEC_VTO,
             PAG_CLAVE_PAGO,
             PAG_FEC_PAGO,
             PAG_IMP_LOC,
             PAG_IMP_MON,
             PAG_LOGIN,
             PAG_FEC_GRAB,
             PAG_SIST,
             PAG_EMPR)
          VALUES
            (REG.CUO_CLAVE_DOC,
             REG.CUO_FEC_VTO,
             V_COB_CLAVE,
             I_DOC_FEC_OPER, ---REG.DOC_FEC_DOC,
             V_SUM_CUO_LOC,
             V_SUM_CUO_MON,
             I_USUARIO,
             SYSDATE,
             'FIN',
             I_EMPRESA);

        END IF;
      END LOOP;

      IF I_S_ACT_IMPRESORA = 'S' THEN
        UPDATE GEN_IMPRESORA
           SET IMP_ULT_REC_PAGO_EMIT = V_COB_NRO_DOC
         WHERE IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR') --IMP_CODIGO = :PARAMETER.P_IMPRESORA
           AND IMP_EMPR = I_EMPRESA;
      END IF;

      V_COB_NRO_DOC :=  I_DOC_NRO_DOC + V_SUMAR_ITEM;
    END LOOP;

    COMMIT;

    --------------------------------------------------------------------------------
    P_CLAVE_RECIBOS := SUBSTRC(V_CLAVE_IMPRIMIR, 2, 2000);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20002, 'Error inesperado');

  END PP_HOLDING_RECIBO;

  PROCEDURE PP_GUARDAR_TARJETA(I_TARJ_NRO_TARJETA IN VARCHAR2,
                               I_TARJ_TARJETA     IN NUMBER,
                               I_TARJ_FEC_VTO     IN DATE,
                               I_TARJ_IMP_LOC     IN NUMBER,
                               in_origen          in varchar2 := null) IS
  BEGIN

    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TARJETA_FINI003') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'TARJETA_FINI003');
    END IF;

    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'TARJETA_FINI003',
                               P_C001            => I_TARJ_NRO_TARJETA,
                               p_c002            => in_origen,
                               P_D001            => I_TARJ_FEC_VTO,
                               P_N001            => I_TARJ_TARJETA,
                               P_N002            => I_TARJ_IMP_LOC);
  END PP_GUARDAR_TARJETA;

  PROCEDURE PP_GUARDAR_CHEQUE(I_CHEQ_BCO           IN NUMBER,
                              I_CHEQ_SERIE         IN VARCHAR2,
                              I_CHEQ_NRO           IN VARCHAR2,
                              I_CHEQ_MON           IN NUMBER,
                              I_CHEQ_FEC_DEPOSITAR IN DATE,
                              I_IMPORTE            IN NUMBER,
                              I_TASA               IN NUMBER,
                              I_CHEQ_IMPORTE_LOC   IN NUMBER,
                              I_CHEQ_NRO_CTA_CHEQ  IN VARCHAR2,
                              I_TITULAR            IN VARCHAR2,
                              I_ITEM               IN NUMBER) IS
  BEGIN

    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUES_FINI003') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'CHEQUES_FINI003');
    END IF;

    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'CHEQUES_FINI003',
                               P_C001            => I_CHEQ_SERIE,
                               P_C002            => I_CHEQ_NRO,
                               P_C003            => I_CHEQ_NRO_CTA_CHEQ,
                               P_C004            => I_TITULAR,
                               P_D001            => I_CHEQ_FEC_DEPOSITAR,
                               P_N001            => I_CHEQ_BCO,
                               P_N002            => I_CHEQ_MON,
                               P_N003            => I_IMPORTE,
                               P_N004            => I_TASA,
                               P_N005            => I_CHEQ_IMPORTE_LOC);
  END PP_GUARDAR_CHEQUE;

  PROCEDURE PP_VALIDA_PBANCO(I_BANCO                 IN NUMBER,
                             I_EMPRESA               IN NUMBER,
                             O_S_BANCO_DESC          OUT VARCHAR2,
                             O_S_MON                 OUT NUMBER,
                             O_P_BANCO               OUT NUMBER,
                             O_P_CTA_BCO_DIA         OUT NUMBER,
                             O_CTA_CHEQ_DIF_RESPALDO OUT NUMBER,
                             O_P_PROX_CH             OUT VARCHAR2,
                             O_P_CHEQUE_MENOR        OUT NUMBER,
                             O_P_CHEQUE_MAYOR        OUT NUMBER) IS
  BEGIN
    IF I_BANCO IS NOT NULL THEN
      SELECT BCO_DESC,
             CTA_MON,
             CTA_CODIGO, /* CTA_CODIGO POR CTA_BCO */
             CTA_BCO_DIA,
             CTA_CHEQ_DIF_RESPALDO
        INTO O_S_BANCO_DESC,
             O_S_MON,
             O_P_BANCO,
             O_P_CTA_BCO_DIA,
             O_CTA_CHEQ_DIF_RESPALDO
        FROM FIN_CUENTA_BANCARIA, FIN_BANCO
       WHERE CTA_BCO = BCO_CODIGO(+)
         AND CTA_CODIGO = I_BANCO
         AND CTA_EMPR = I_EMPRESA
         AND CTA_EMPR = BCO_EMPR(+);
    END IF;

    SELECT TO_CHAR(NVL(TO_NUMBER(CTA_ULT_NRO_CHEQUE), 0)),
           NVL(TO_NUMBER(CTA_NRO_CHEQUE_MENOR), 1),
           NVL(TO_NUMBER(CTA_NRO_CHEQUE_MAYOR), 9999999999999)
      INTO O_P_PROX_CH, O_P_CHEQUE_MENOR, O_P_CHEQUE_MAYOR
      FROM FIN_CUENTA_BANCARIA
     WHERE CTA_EMPR = I_EMPRESA
       AND CTA_CODIGO = I_BANCO;

    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002, 'Cuenta bancaria inexistente!');
  END PP_VALIDA_PBANCO;

  PROCEDURE PP_VALIDAR_AD_CHEQUES(I_CANT_CUOTAS       IN NUMBER,
                                  P_TIPO_VENCIMIENTO  IN VARCHAR2,
                                  P_DIAS_ENTRE_CUOTAS IN NUMBER) IS
  BEGIN

    IF I_CANT_CUOTAS > 1 AND P_TIPO_VENCIMIENTO = 'V' THEN
      IF P_DIAS_ENTRE_CUOTAS IS NULL THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Debe ingresar los dias entre una cuota y la otra!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
      IF NVL(P_DIAS_ENTRE_CUOTAS, 0) <= 0 THEN
        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Los dias entre cuotas debe ser un numero > que cero!',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
      END IF;
    END IF;
  END PP_VALIDAR_AD_CHEQUES;

  PROCEDURE PP_GUARDAR_CHEQUE_AUT(I_CHEQ_BCO           IN NUMBER,
                                  I_CHEQ_SERIE         IN VARCHAR2,
                                  I_CHEQ_NRO           IN VARCHAR2,
                                  I_CHEQ_FEC_DEPOSITAR IN DATE,
                                  I_IMPORTE            IN NUMBER,
                                  I_BENEFICIARIO       IN VARCHAR2) IS
  BEGIN

    IF NOT
        APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUE_AUT_FINI003') THEN
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'CHEQUE_AUT_FINI003');
    END IF;

    APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'CHEQUE_AUT_FINI003',
                               P_C001            => I_CHEQ_SERIE,
                               P_C002            => I_CHEQ_NRO,
                               P_C003            => I_BENEFICIARIO,
                               P_D001            => I_CHEQ_FEC_DEPOSITAR,
                               P_N001            => I_CHEQ_BCO,
                               P_N002            => I_IMPORTE);
  END PP_GUARDAR_CHEQUE_AUT;

  PROCEDURE PP_CARGAR_CHEQUE(I_P_CTA_BCO_DIA  IN NUMBER,
                             I_EMPRESA        IN NUMBER,
                             I_DOC_CTA_BCO    IN NUMBER,
                             O_P_PROX_CH      OUT VARCHAR2,
                             O_P_CHEQUE_MENOR OUT NUMBER,
                             O_P_CHEQUE_MAYOR OUT NUMBER) IS
    V_BANCO NUMBER;
  BEGIN
    IF I_P_CTA_BCO_DIA IS NULL THEN
      SELECT TO_CHAR(NVL(TO_NUMBER(CTA_ULT_NRO_CHEQUE), 0)),
             NVL(TO_NUMBER(CTA_NRO_CHEQUE_MENOR), 1),
             NVL(TO_NUMBER(CTA_NRO_CHEQUE_MAYOR), 9999999999999),
             CTA_BCO
        INTO O_P_PROX_CH, O_P_CHEQUE_MENOR, O_P_CHEQUE_MAYOR, V_BANCO
        FROM FIN_CUENTA_BANCARIA
       WHERE CTA_EMPR = I_EMPRESA
         AND CTA_CODIGO = I_DOC_CTA_BCO;
    ELSE
      SELECT TO_CHAR(NVL(TO_NUMBER(CTA_ULT_NRO_CHEQUE), 0)),
             NVL(TO_NUMBER(CTA_NRO_CHEQUE_MENOR), 1),
             NVL(TO_NUMBER(CTA_NRO_CHEQUE_MAYOR), 9999999999999),
             CTA_BCO
        INTO O_P_PROX_CH, O_P_CHEQUE_MENOR, O_P_CHEQUE_MAYOR, V_BANCO
        FROM FIN_CUENTA_BANCARIA
       WHERE CTA_EMPR = I_EMPRESA
         AND CTA_CODIGO = I_P_CTA_BCO_DIA;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002, 'Cuenta Inexistente!.');
  END PP_CARGAR_CHEQUE;

  PROCEDURE PP_GENERAR_CHEQUES(I_FEC_PRIM_VTO         IN DATE,
                               I_S_TOTAL_IMP          IN NUMBER,
                               I_S_CANT_CHEQUES       IN NUMBER,
                               I_W_MON_DEC_IMP        IN NUMBER,
                               I_P_PAGO_BANCO         IN VARCHAR2,
                               I_P_CTA_BCO_DIA        IN NUMBER,
                               I_EMPRESA              IN NUMBER,
                               I_DOC_CTA_BCO          IN NUMBER,
                               I_M_BENEFICIARIO_INI   IN VARCHAR2,
                               I_P_IND_CHEQUE_DIF     IN VARCHAR2,
                               I_S_TIPO_VENCIMIENTO   IN VARCHAR2,
                               I_S_DIAS_ENTRE_CHEQUES IN NUMBER,
                               O_P_PROX_CH            OUT VARCHAR2,
                               O_P_CHEQUE_MENOR       OUT NUMBER,
                               O_P_CHEQUE_MAYOR       OUT NUMBER) IS
    V_FECHA            DATE := I_FEC_PRIM_VTO;
    V_CUO_IMP          NUMBER := ROUND(I_S_TOTAL_IMP / I_S_CANT_CHEQUES,
                                       I_W_MON_DEC_IMP);
    V_TOT_CUO_IMP      NUMBER := 0;
    V_CH_EMIT_SERIE    VARCHAR2(1);
    V_CH_EMIT_NRO      NUMBER;
    V_CH_EMIT_IMPORTE  NUMBER;
    V_CH_EMIT_FEC_VTO1 DATE;
    V_BENEFICIARIO     VARCHAR2(200);
  BEGIN
    -- RAISE_APPLICATION_ERROR (-20001, I_P_PAGO_BANCO);
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUE_AUT_FINI003') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'CHEQUE_AUT_FINI003');
    END IF;

    IF I_P_PAGO_BANCO <> 'S' THEN
      PP_CARGAR_CHEQUE(I_P_CTA_BCO_DIA  => I_P_CTA_BCO_DIA,
                       I_EMPRESA        => I_EMPRESA,
                       I_DOC_CTA_BCO    => I_DOC_CTA_BCO,
                       O_P_PROX_CH      => O_P_PROX_CH,
                       O_P_CHEQUE_MENOR => O_P_CHEQUE_MENOR,
                       O_P_CHEQUE_MAYOR => O_P_CHEQUE_MAYOR);
    END IF;

    FOR I IN 1 .. I_S_CANT_CHEQUES LOOP
      V_CH_EMIT_SERIE    := 'A';
      V_CH_EMIT_NRO      := O_P_PROX_CH + I;
      V_CH_EMIT_IMPORTE  := V_CUO_IMP;
      V_CH_EMIT_FEC_VTO1 := V_FECHA;
      V_BENEFICIARIO     := I_M_BENEFICIARIO_INI;

      IF I_P_IND_CHEQUE_DIF = 'S' THEN
        IF I_S_TIPO_VENCIMIENTO = 'V' THEN
          V_FECHA := V_FECHA + I_S_DIAS_ENTRE_CHEQUES;
        ELSE
          V_FECHA := ADD_MONTHS(I_FEC_PRIM_VTO, I);
        END IF;
      ELSE
        V_FECHA := I_FEC_PRIM_VTO;
      END IF;
      V_TOT_CUO_IMP := V_TOT_CUO_IMP + V_CUO_IMP;
      --AJUSTAR LA DIFERENCIA POR REDONDEO A LA ULTIMA CUOTA;
      IF I >= I_S_CANT_CHEQUES THEN
        V_CH_EMIT_IMPORTE := V_CH_EMIT_IMPORTE +
                             (I_S_TOTAL_IMP - V_TOT_CUO_IMP);
      END IF;

      PP_GUARDAR_CHEQUE_AUT(I_CHEQ_BCO           => I_DOC_CTA_BCO,
                            I_CHEQ_SERIE         => V_CH_EMIT_SERIE,
                            I_CHEQ_NRO           => V_CH_EMIT_NRO,
                            I_CHEQ_FEC_DEPOSITAR => V_FECHA,
                            I_IMPORTE            => V_CH_EMIT_IMPORTE,
                            I_BENEFICIARIO       => V_BENEFICIARIO);
    END LOOP;

  END PP_GENERAR_CHEQUES;

  PROCEDURE PP_VALIDAR_CHQ_FP(I_W_CHEQ_BCO         IN NUMBER,
                              I_CHEQ_SERIE         IN VARCHAR2,
                              I_CHEQ_NRO           IN VARCHAR2,
                              I_CHEQ_MON           IN NUMBER,
                              I_TASA               IN NUMBER,
                              I_CHEQ_FEC_DEPOSITAR IN DATE,
                              I_IMPORTE            IN NUMBER,
                              I_CHEQ_IMPORTE_LOC   IN NUMBER,
                              I_CHEQ_NRO_CTA_CHEQ  IN VARCHAR2,
                              I_TITULAR            IN VARCHAR2,
                              I_P_MON_LOC          IN NUMBER) IS
  BEGIN
    IF I_W_CHEQ_BCO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Banco no puede ser nulo!');
    END IF;
    IF I_CHEQ_SERIE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Serie no puede ser nulo!');
    END IF;
    IF I_CHEQ_NRO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Numero de cheque no puede ser nulo!');
    END IF;
    IF I_CHEQ_MON IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Moneda no puede ser nulo!');
    END IF;
    IF I_TASA IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Tasa no puede ser nulo!');
    END IF;
    IF I_CHEQ_FEC_DEPOSITAR IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Fecha a depositar no puede ser nulo!');
    END IF;
    IF I_IMPORTE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Importe no puede ser nulo!');
    END IF;
    IF I_CHEQ_IMPORTE_LOC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Importe Loc no puede ser nulo!');
    END IF;
    IF I_CHEQ_NRO_CTA_CHEQ IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Nro Cta no puede ser nulo!');
    END IF;
    IF I_TITULAR IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Titular no puede ser nulo!');
    END IF;

    IF I_CHEQ_MON = I_P_MON_LOC AND I_TASA <> 1 THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'La tasa debe ser 1 cuando la moneda del cheque es igual a la moneda local.');
    END IF;
    --I_CHEQ_IMPORTE_LOC := ROUND(I_IMPORTE * :P17_TASA,:P97_CANT_DECIMALES_LOC);
  END PP_VALIDAR_CHQ_FP;

  PROCEDURE PP_VALIDAR_TJ_FP(I_W_TARJ_TARJETA     IN NUMBER,
                             I_TARJ_NRO_TARJETA   IN VARCHAR2,
                             I_TARJ_FEC_VTO       IN DATE,
                             I_TARJ_IMP_LOC       IN NUMBER,
                             I_P_FEC_INIC_SISTEMA IN DATE,
                             I_P_FEC_FIN_SISTEMA  IN DATE,
                             I_FEC_DOC            IN DATE) IS
  BEGIN
    IF I_W_TARJ_TARJETA IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Tarjeta no puede ser nulo!');
    END IF;

    --
    IF I_TARJ_FEC_VTO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Fecha Vto no puede ser nulo!');
    END IF;
    IF NOT I_TARJ_FEC_VTO BETWEEN I_P_FEC_INIC_SISTEMA AND
       I_P_FEC_FIN_SISTEMA THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'La fecha debe estar comprendida entre el ' ||
                              TO_CHAR(I_P_FEC_INIC_SISTEMA) || ' y el ' ||
                              TO_CHAR(I_P_FEC_FIN_SISTEMA));
    END IF;

    --FECHA DE VTO NO DEBE SER MENOR A LA DEL DOCUMENTO
    IF I_TARJ_FEC_VTO < I_FEC_DOC THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Fecha de vencimiento no puede ser menor que la fecha del documento.');
    END IF;

    -- NI MAYOR A RENDICION+30
    IF I_TARJ_FEC_VTO > (I_FEC_DOC + 30) THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Fecha de vencimiento no puede mas de 30 dias despues de la rendicion.');
    END IF;
    --
    IF I_TARJ_IMP_LOC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'No puede quedar en blanco!');
    END IF;

    IF I_TARJ_IMP_LOC <= 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'Debe ser mayor que cero!');
    END IF;
  END PP_VALIDAR_TJ_FP;

  PROCEDURE PP_ACTUALIZAR_PAG(I_USUARIO              IN VARCHAR2,
                              I_PROGRAMA             IN VARCHAR2,
                              I_EMPRESA              IN NUMBER,
                              I_DOC_CLAVE            IN NUMBER,
                              I_TASA_OFIC            IN NUMBER,
                              I_P_CANT_DECIMALES_LOC IN NUMBER,
                              I_DOC_NETO_EXEN_LOC    IN NUMBER,
                              I_DOC_FEC_DOC          IN DATE) IS
    -- REVISADO EL 24/02/98 POR EITEL
    -- SE AGREGO LA PARTE QUE ASIGNA LA DIFERENCIA, EN MONEDA LOCAL
    -- ENTRE EL ENCABEZADO Y LOS DETALLES, AL 1ER. REG.DE PAGO.
    -- PARA ELLO SE UTILIZA UN TOTALIZADOR QUE LUEGO SE COMPARA CON EL
    -- TOTAL DEL ENCABEZADO.

    V_TOT_IMP_PAGO_LOC NUMBER := 0;
    V_DIFERENCIA       NUMBER := 0;
    V_IMP_PAGO_LOC     NUMBER;
  BEGIN
    FOR REG IN (SELECT SEQ_ID,
                       C001   DOC_NRO_DOC,
                       D001   DOC_FEC_DOC,
                       D002   CUO_FEC_VTO,
                       C002   DOC_OBS,
                       N001   CUO_IMP_MON,
                       N002   CUO_SALDO_MON,
                       C010   S_IMP_PAGO
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'DETALLE_FINI003') LOOP
      IF REG.S_IMP_PAGO != 0 THEN
        V_IMP_PAGO_LOC     := ROUND(REG.S_IMP_PAGO * I_TASA_OFIC,
                                    I_P_CANT_DECIMALES_LOC);
        V_TOT_IMP_PAGO_LOC := V_TOT_IMP_PAGO_LOC + V_IMP_PAGO_LOC;
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                                P_SEQ             => REG.SEQ_ID,
                                                P_ATTR_NUMBER     => 11,
                                                P_ATTR_VALUE      => V_IMP_PAGO_LOC);
      END IF;
    END LOOP;
    --CALCULAR LA DIFERENCIA ENTRE ENCABEZADO LOC Y DETALLES LOC
    V_DIFERENCIA := I_DOC_NETO_EXEN_LOC - V_TOT_IMP_PAGO_LOC;
    --ASIGNAR LA DIFERENCIA AL PRIMER REGISTRO MARCADO
    FOR REG IN (SELECT SEQ_ID,
                       C001   DOC_NRO_DOC,
                       D001   DOC_FEC_DOC,
                       D002   CUO_FEC_VTO,
                       C002   DOC_OBS,
                       N001   CUO_IMP_MON,
                       N002   CUO_SALDO_MON,
                       C010   S_IMP_PAGO,
                       C011   IMP_PAGO_LOC
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'DETALLE_FINI003') LOOP
      IF REG.S_IMP_PAGO != 0 AND REG.SEQ_ID = 1 THEN
        APEX_COLLECTION.UPDATE_MEMBER_ATTRIBUTE(P_COLLECTION_NAME => 'DETALLE_FINI003',
                                                P_SEQ             => REG.SEQ_ID,
                                                P_ATTR_NUMBER     => 11,
                                                P_ATTR_VALUE      => REG.IMP_PAGO_LOC +
                                                                     V_DIFERENCIA);
      END IF;
    END LOOP;
    --

    FOR REG IN (SELECT SEQ_ID,
                       C001   DOC_NRO_DOC,
                       D001   DOC_FEC_DOC,
                       D002   CUO_FEC_VTO,
                       C002   DOC_OBS,
                       N001   CUO_IMP_MON,
                       N002   CUO_SALDO_MON,
                       C003   CUO_CLAVE_DOC,
                       C004   CUO_NRO_PAGARE,
                       C005   DOC_CANT_PAGARE,
                       C006   DOC_CLAVE_RETENCION,
                       N003   GRAVADO,
                       N004   GRAVADO_LOC,
                       N005   EXENTO,
                       C007   EXENTO_LOC,
                       C008   IVA,
                       C009   IVA_LOC,
                       C010   S_IMP_PAGO,
                       C011   IMP_PAGO_LOC
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'DETALLE_FINI003') LOOP

      IF REG.S_IMP_PAGO != 0 THEN
        INSERT INTO FIN_PAGO
          (PAG_CLAVE_DOC,
           PAG_FEC_VTO,
           PAG_CLAVE_PAGO,
           PAG_FEC_PAGO,
           PAG_IMP_LOC,
           PAG_IMP_MON,
           PAG_LOGIN,
           PAG_FEC_GRAB,
           PAG_SIST,
           PAG_EMPR)
        VALUES
          (REG.CUO_CLAVE_DOC,
           REG.CUO_FEC_VTO,
           I_DOC_CLAVE,
           I_DOC_FEC_DOC,
           REG.IMP_PAGO_LOC,
           REG.S_IMP_PAGO,
           I_USUARIO,
           SYSDATE,
           SUBSTR(I_PROGRAMA, 1, 3),
           I_EMPRESA);
      END IF;
    END LOOP;

  END PP_ACTUALIZAR_PAG;

  PROCEDURE PP_INSERTAR_CH_EMIT(I_EMPRESA          IN NUMBER,
                                I_DOC_CLAVE        IN NUMBER,
                                I_P_IND_CHEQUE_DIF IN VARCHAR2) IS
    W_CLAVE                 NUMBER;
    V_CH_EMIT_CLAVE_FIN_CAN NUMBER;
  BEGIN
    FOR REG IN (SELECT SEQ_ID,
                       C001   CHEQ_SERIE,
                       C002   CHEQ_NRO,
                       C003   BENEFICIARIO,
                       D001   CHEQ_FEC_DEPOSITAR,
                       N001   CHEQ_BCO,
                       N002   IMPORTE
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'CHEQUE_AUT_FINI003') LOOP

      W_CLAVE := FIN_SEQ_CH_EMIT_NEXTVAL;
      IF NVL(I_P_IND_CHEQUE_DIF, 'N') <> 'S' THEN
        V_CH_EMIT_CLAVE_FIN_CAN := I_DOC_CLAVE;
      ELSE
        V_CH_EMIT_CLAVE_FIN_CAN := NULL;
      END IF;

      INSERT INTO FIN_CHEQUE_EMIT
        (CH_EMIT_BENEFICIARIO,
         CH_EMIT_CLAVE,
         CH_EMIT_CLAVE_FIN,
         CH_EMIT_CLAVE_FIN_CAN,
         CH_EMIT_EMPR,
         CH_EMIT_FEC_VTO,
         CH_EMIT_IMPORTE,
         CH_EMIT_NRO,
         CH_EMIT_SERIE)
      VALUES
        (REG.BENEFICIARIO,
         W_CLAVE,
         I_DOC_CLAVE,
         V_CH_EMIT_CLAVE_FIN_CAN,
         I_EMPRESA,
         REG.CHEQ_FEC_DEPOSITAR,
         REG.IMPORTE,
         REG.CHEQ_NRO,
         REG.CHEQ_SERIE);
    END LOOP;
  END PP_INSERTAR_CH_EMIT;

  PROCEDURE PP_ACT_CTA_BAN(I_P_PAGO_BANCO  IN VARCHAR2,
                           I_EMPRESA       IN NUMBER,
                           I_P_CTA_BCO_DIA IN NUMBER,
                           I_DOC_CTA_BCO   IN NUMBER) IS
    V_ULTIMO   NUMBER;
    V_CHEQ_NRO FIN_CUENTA_BANCARIA.CTA_ULT_NRO_CHEQUE%TYPE;
    V_BANCO    NUMBER;
  BEGIN
    SELECT MAX(SEQ_ID)
      INTO V_ULTIMO
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'CHEQUE_AUT_FINI003';

    SELECT C002 CHEQ_NRO, N001 CHEQ_BCO
      INTO V_CHEQ_NRO, V_BANCO
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'CHEQUE_AUT_FINI003'
       AND SEQ_ID = V_ULTIMO;

    IF I_P_PAGO_BANCO = 'S' THEN
      UPDATE FIN_CUENTA_BANCARIA
         SET CTA_ULT_NRO_CHEQUE = V_CHEQ_NRO
       WHERE CTA_EMPR = I_EMPRESA
         AND CTA_CODIGO = V_BANCO;
      COMMIT;
    ELSE

      IF I_P_CTA_BCO_DIA IS NULL THEN
        UPDATE FIN_CUENTA_BANCARIA
           SET CTA_ULT_NRO_CHEQUE = V_CHEQ_NRO
         WHERE CTA_EMPR = I_EMPRESA
           AND CTA_CODIGO = I_DOC_CTA_BCO;
        COMMIT;
      ELSE
        UPDATE FIN_CUENTA_BANCARIA
           SET CTA_ULT_NRO_CHEQUE = V_CHEQ_NRO
         WHERE CTA_EMPR = I_EMPRESA
           AND CTA_CODIGO = I_P_CTA_BCO_DIA;
        COMMIT;
      END IF;
    END IF;
  END PP_ACT_CTA_BAN;

  PROCEDURE PP_ACTUALIZAR_TARJ_CHEQ_1(I_EMPRESA                  IN NUMBER,
                                      I_DOC_MON                  IN NUMBER,
                                      I_P_CANT_DECIMALES_LOC     IN NUMBER,
                                      I_AUX_TASA_DOC             IN NUMBER,
                                      I_AUX_CONF_COD_EXTRACCION  IN NUMBER,
                                      I_AUX_NRO_DOC              IN NUMBER,
                                      I_AUX_DOC_MON              IN NUMBER,
                                      I_DOC_FEC_OPER             IN DATE,
                                      I_DOC_FEC_DOC              IN DATE,
                                      I_AUX_TIPO_MOV             IN NUMBER,
                                      I_AUX_CLAVE_DOC            IN NUMBER,
                                      I_USUARIO                  IN VARCHAR2,
                                      I_AUX_CONF_CONC_TC_INGRESO IN NUMBER,
                                      I_AUX_CONF_CTA_TC_INGRESO  IN NUMBER,
                                      I_SUCURSAL                 IN NUMBER,
                                      I_CTA_CHEQ_DIF_RESPALDO    IN NUMBER,
                                      I_CTA_NOT_TRAN_RESPALDO    IN NUMBER,
                                      I_AUX_CONF_CONC_CH_INGRESO IN NUMBER,
                                      I_AUX_CONF_CTA_CH_INGRESO  IN NUMBER,
                                      I_DOC_CTA_BCO              IN NUMBER,
                                      I_DOC_CLAVE                IN NUMBER,
                                      I_AUX_FEC_DOC              IN DATE,
                                      I_AUX_CONF_COD_DEPOSITO    IN NUMBER,
                                      I_AUX_CLI_NOM              IN VARCHAR2,
                                      I_AUX_CLI_CODIGO           IN NUMBER,
                                      I_AUX_CONF_CONC_CH_RESP    IN NUMBER,
                                      I_AUX_CONF_CTA_CH_RESP     IN NUMBER) IS
    V_CLAVE_FIN NUMBER;
    --V_CLAVE_FIN_CHEQDIF   NUMBER;
    VCLAVECHEQ NUMBER;
    VIMPMON    NUMBER;
    VIMPLOC    NUMBER;
    --VIMPCHEQDIFLOC        NUMBER;
    VREG                  NUMBER := 0;
    MON_DEC_IMP           NUMBER;
    V_CLAVE_CH_RESP       NUMBER;
    V_CLAVE_NOT_TRAS_RESP NUMBER;
    V_NOT_TRAS            CHAR(1);
    V_CONCEP              NUMBER;
    V_CUENTA_C            NUMBER;
    V_SUM_TJ              NUMBER;
    V_SUM_CHEQUES         NUMBER;
    l_origen varchar2(100);
  BEGIN
    SELECT SUM(N002)
      INTO V_SUM_TJ
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'TARJETA_FINI003';

    SELECT SUM(N005)
      INTO V_SUM_CHEQUES
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'CHEQUES_FINI003';

    IF NVL(V_SUM_TJ, 0) > 0 OR NVL(V_SUM_CHEQUES, 0) > 0 THEN
      BEGIN
        SELECT MON_DEC_IMP
          INTO MON_DEC_IMP
          FROM GEN_MONEDA
         WHERE MON_CODIGO = I_DOC_MON
           AND MON_EMPR = I_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Error de integridad referencial: Moneda del documento no existe.');
      END;
      --SOLO SI EXISTEN TARJETAS O CHEQUES

      -- EL TIPO DE PAGO CON TARJETA NO ESTA IMPLEMENTADO

        IF NVL(V_SUM_TJ, 0) > 0 THEN
          VIMPLOC     := ROUND(NVL(V_SUM_TJ, 0), I_P_CANT_DECIMALES_LOC);
          VIMPMON     := ROUND(VIMPLOC / I_AUX_TASA_DOC, MON_DEC_IMP);
          V_CLAVE_FIN := FIN_SEQ_DOC_NEXTVAL; --OBTENER LA CLAVE DEL NUEVO DOCUMENTO

          --FIN_DOCUMENTO
          INSERT INTO FIN_DOCUMENTO
            (DOC_CLAVE,
             DOC_EMPR,
             DOC_SUC,
             DOC_CTA_BCO,
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
             DOC_OBS,
             DOC_CLAVE_PADRE,
             DOC_LOGIN,
             DOC_FEC_GRAB,
             DOC_SIST,
             DOC_SERIE)
          VALUES
            (V_CLAVE_FIN,
             I_EMPRESA,
             I_SUCURSAL,
             I_DOC_CTA_BCO,
             13,--I_AUX_CONF_COD_EXTRACCION, --COD_EXTRACCION
             I_AUX_NRO_DOC,
             'C',
             I_AUX_DOC_MON,
             I_DOC_FEC_OPER,
             I_DOC_FEC_DOC,
             VIMPLOC,
             VIMPMON,
             0,
             0,
             VIMPLOC,
             VIMPMON,
             0,
             0,
             0,
             0,
             'Tarjetas/Cheques.Doc.' || I_AUX_NRO_DOC || ',Tipo:' ||
             I_AUX_TIPO_MOV,
             I_AUX_CLAVE_DOC,
             I_USUARIO,
             SYSDATE,
             'FIN',
             NULL);
          --===========================================================
          --TARJETAS

          --FIN_DOC_CONCEPTO
          VREG := VREG + 1;
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
             DCON_EMPR)
          VALUES
            (V_CLAVE_FIN,
             VREG,
             I_AUX_CONF_CONC_TC_INGRESO,
             I_AUX_CONF_CTA_TC_INGRESO,
             'C',
             ROUND(V_SUM_TJ / I_AUX_TASA_DOC, MON_DEC_IMP),
             V_SUM_TJ,
             0,
             0,
             0,
             0,
             I_EMPRESA);

          --FIN_TC_CUPON
          FOR REG IN (SELECT SEQ_ID,
                             C001   TARJ_NRO_TARJETA,
                             c002   origen,
                             D001   TARJ_FEC_VTO,
                             N001   TARJ_TARJETA,
                             N002   TARJ_IMP_LOC
                        FROM APEX_COLLECTIONS
                       WHERE COLLECTION_NAME = 'TARJETA_FINI003') LOOP
            INSERT INTO FIN_TC_CUPON
              (CUP_TARJETA,
               CUP_NRO_TARJETA,
               CUP_FEC_VTO,
               CUP_IMP_LOC,
               CUP_ORIGEN,
               CUP_CLAVE_FIN,
               CUP_NRO_CAJA,
               CUP_NRO_Z,
               CUP_EMPR,
               cup_tarj_origen)
            VALUES
              (REG.TARJ_TARJETA,
               REG.TARJ_NRO_TARJETA,
               REG.TARJ_FEC_VTO,
               REG.TARJ_IMP_LOC,
               'CJ',
               V_CLAVE_FIN,
               NULL,
               NULL,
               I_EMPRESA,
               reg.origen);
          END LOOP;
        END IF;
  
      --===========================================================
      --CHEQUES
      IF NVL(V_SUM_CHEQUES, 0) > 0 THEN

        VIMPLOC := 0;
        --VIMPCHEQDIFLOC := 0;
        VIMPMON := 0;
        --FIN_CHEQUE

        FOR REG IN (SELECT SEQ_ID,
                           C001   CHEQ_SERIE,
                           C002   CHEQ_NRO,
                           C003   CHEQ_NRO_CTA_CHEQ,
                           C004   TITULAR,
                           D001   CHEQ_FEC_DEPOSITAR,
                           N001   CHEQ_BCO,
                           N002   CHEQ_MON,
                           N003   IMPORTE,
                           N004   TASA,
                           N005   CHEQ_IMPORTE_LOC
                      FROM APEX_COLLECTIONS
                     WHERE COLLECTION_NAME = 'CHEQUES_FINI003') LOOP

          BEGIN
            SELECT BCO_NOT_TRANSF
              INTO V_NOT_TRAS
              FROM FIN_BANCO
             WHERE BCO_CODIGO = REG.CHEQ_BCO
               AND BCO_EMPR = I_EMPRESA;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              V_NOT_TRAS := 'N';
            WHEN OTHERS THEN
              V_NOT_TRAS := 'N';
          END;
          IF V_NOT_TRAS = 'S' AND I_CTA_NOT_TRAN_RESPALDO IS NOT NULL THEN
            V_CONCEP   := 1728;
            V_CUENTA_C := 2648;
          ELSE
            V_CONCEP   := I_AUX_CONF_CONC_CH_INGRESO;
            V_CUENTA_C := I_AUX_CONF_CTA_CH_INGRESO;
          END IF;

          V_CLAVE_FIN := FIN_SEQ_DOC_NEXTVAL; --OBTENER LA CLAVE DEL NUEVO DOCUMENTO
          VIMPLOC     := ROUND(NVL(REG.CHEQ_IMPORTE_LOC, 0),
                               I_P_CANT_DECIMALES_LOC);
          VIMPMON     := ROUND(VIMPLOC / REG.TASA, MON_DEC_IMP);
          --FIN_DOCUMENTO

          INSERT INTO FIN_DOCUMENTO
            (DOC_CLAVE,
             DOC_EMPR,
             DOC_SUC,
             DOC_CTA_BCO,
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
             DOC_OBS,
             /*DOC_CLAVE_PADRE,*/
             DOC_LOGIN,
             DOC_FEC_GRAB,
             DOC_SIST,
             DOC_SERIE,
             DOC_REC_COB)
          VALUES
            (V_CLAVE_FIN,
             I_EMPRESA,
             I_SUCURSAL,
             I_DOC_CTA_BCO,
             NVL(I_AUX_CONF_COD_EXTRACCION, 13),
             REG.CHEQ_NRO /*:BAUX.NRO_DOC*/,
             'C',
             REG.CHEQ_MON,
             --:BAUX.FEC_DOC, :BAUX.FEC_DOC,
             I_DOC_FEC_OPER,
             I_DOC_FEC_DOC,
             VIMPLOC,
             VIMPMON,
             0,
             0,
             VIMPLOC,
             VIMPMON,
             0,
             0,
             0,
             0,
             'Cheq.Nro' || REG.CHEQ_NRO || ',Rec.Nro:' || I_AUX_NRO_DOC /*:BAUX.TIPO_MOV*/,
             /*:BAUX.CLAVE_DOC,*/
             I_USUARIO,
             SYSDATE,
             'FIN',
             NULL,
             I_DOC_CLAVE);

          --===========================================================

          --FIN_DOC_CONCEPTO
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
             DCON_EMPR)
          VALUES
            (V_CLAVE_FIN,
             1,
             V_CONCEP,
             V_CUENTA_C,
             'C',
             VIMPMON,
             VIMPLOC,
             0,
             0,
             0,
             0,
             I_EMPRESA);

          VCLAVECHEQ := FIN_SEQ_CHEQUE_NEXTVAL;

          INSERT INTO FIN_CHEQUE
            (CHEQ_CLAVE,
             CHEQ_EMPR,
             CHEQ_SERIE,
             CHEQ_NRO,
             CHEQ_SUC,
             CHEQ_BCO,
             CHEQ_MON,
             CHEQ_CLI,
             CHEQ_CLI_NOM,
             CHEQ_TITULAR,
             CHEQ_FEC_EMIS,
             CHEQ_FEC_DEPOSITAR,
             CHEQ_IMPORTE,
             CHEQ_IMPORTE_LOC,
             CHEQ_SITUACION,
             CHEQ_FEC_GRAB,
             CHEQ_LOGIN,
             CHEQ_NRO_CTA_CHEQ)
          VALUES
            (VCLAVECHEQ,
             I_EMPRESA,
             REG.CHEQ_SERIE,
             REG.CHEQ_NRO,
             I_SUCURSAL,
             REG.CHEQ_BCO,
             REG.CHEQ_MON,
             I_AUX_CLI_CODIGO,
             I_AUX_CLI_NOM,
             REG.TITULAR,
             I_AUX_FEC_DOC,
             REG.CHEQ_FEC_DEPOSITAR,
             REG.IMPORTE,
             REG.CHEQ_IMPORTE_LOC,
             'I',
             SYSDATE,
             I_USUARIO,
             REG.CHEQ_NRO_CTA_CHEQ);

          --INSERTAR EN LA TABLA QUE RELACIONA FIN_CHEQUE CON FIN_DOCUMENTO
          INSERT INTO FIN_CHEQUE_DOCUMENTO
            (CHDO_CLAVE_DOC, CHDO_CLAVE_CHEQ, CHDO_EMPR)
          VALUES
            (V_CLAVE_FIN, VCLAVECHEQ, I_EMPRESA);
          /*===========================================================================*/
          /*===========================================================================*/
          ---INCLUIDO EL 11-07-2016 PARA QUE LOS CHEQUES MARCADOS COMO NOTA DE TRANSFERENCIA SE
          ---CARGUEN EN LA CAJA DE RESPALDO DE ESTAS CAJAS.
          /*===========================================================================*/
          /*===========================================================================*/

          IF V_NOT_TRAS = 'S' AND I_CTA_NOT_TRAN_RESPALDO IS NOT NULL THEN
            V_CLAVE_NOT_TRAS_RESP := FIN_SEQ_DOC_NEXTVAL;
            --FIN_DOCUMENTO
            INSERT INTO FIN_DOCUMENTO
              (DOC_CLAVE,
               DOC_EMPR,
               DOC_SUC,
               DOC_CTA_BCO,
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
               DOC_OBS,
               DOC_CLAVE_PADRE,
               DOC_LOGIN,
               DOC_FEC_GRAB,
               DOC_SIST,
               DOC_SERIE,
               DOC_REC_COB)
            VALUES
              (V_CLAVE_NOT_TRAS_RESP,
               I_EMPRESA,
               I_SUCURSAL,
               I_CTA_NOT_TRAN_RESPALDO,
               I_AUX_CONF_COD_DEPOSITO,
               REG.CHEQ_NRO /*:BAUX.NRO_DOC*/,
               'D',
               I_AUX_DOC_MON,
               --:BAUX.FEC_DOC, :BAUX.FEC_DOC,
               I_DOC_FEC_OPER,
               I_DOC_FEC_DOC,
               VIMPLOC,
               VIMPMON,
               0,
               0,
               VIMPLOC,
               VIMPMON,
               0,
               0,
               0,
               0,
               'Cheq.Nro' || REG.CHEQ_NRO || ',Rec.Nro:' || I_AUX_NRO_DOC,
               V_CLAVE_FIN /*:BAUX.CLAVE_DOC*/,
               I_USUARIO,
               SYSDATE,
               'FIN',
               NULL,
               NULL);
            --===========================================================
            --FIN_DOC_CONCEPTO
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
               DCON_EMPR)
            VALUES
              (V_CLAVE_NOT_TRAS_RESP,
               1,
               1728,
               2648,
               'D',
               VIMPMON,
               VIMPLOC,
               0,
               0,
               0,
               0,
               I_EMPRESA);
            --INSERTAR EN LA TABLA QUE RELACIONA FIN_CHEQUE CON FIN_DOCUMENTO
            INSERT INTO FIN_CHEQUE_DOCU_RESP
              (CHDO_CLAVE_DOC, CHDO_CLAVE_CHEQ, CHDO_EMPR)
            VALUES
              (V_CLAVE_NOT_TRAS_RESP, VCLAVECHEQ, I_EMPRESA);
          ELSE

            IF I_CTA_CHEQ_DIF_RESPALDO IS NULL THEN
              RAISE_APPLICATION_ERROR(-20002,
                                      'La caja no cuenta con una auxiliar par cheques diferidos');
            END IF;

            V_CLAVE_CH_RESP := FIN_SEQ_DOC_NEXTVAL;
            --FIN_DOCUMENTO
            INSERT INTO FIN_DOCUMENTO
              (DOC_CLAVE,
               DOC_EMPR,
               DOC_SUC,
               DOC_CTA_BCO,
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
               DOC_OBS,
               DOC_CLAVE_PADRE,
               DOC_LOGIN,
               DOC_FEC_GRAB,
               DOC_SIST,
               DOC_SERIE,
               DOC_REC_COB)
            VALUES
              (V_CLAVE_CH_RESP,
               I_EMPRESA,
               I_SUCURSAL,
               I_CTA_CHEQ_DIF_RESPALDO,
               I_AUX_CONF_COD_DEPOSITO,
               REG.CHEQ_NRO /*:BAUX.NRO_DOC*/,
               'D',
               I_AUX_DOC_MON,
               --:BAUX.FEC_DOC, :BAUX.FEC_DOC,
               I_DOC_FEC_OPER,
               I_DOC_FEC_DOC,
               VIMPLOC,
               VIMPMON,
               0,
               0,
               VIMPLOC,
               VIMPMON,
               0,
               0,
               0,
               0,
               'Cheq.Nro' || REG.CHEQ_NRO || ',Rec.Nro:' || I_AUX_NRO_DOC,
               V_CLAVE_FIN /*:BAUX.CLAVE_DOC*/,
               I_USUARIO,
               SYSDATE,
               'FIN',
               NULL,
               NULL);
            --===========================================================
            --FIN_DOC_CONCEPTO
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
               DCON_EMPR)
            VALUES
              (V_CLAVE_CH_RESP,
               1,
               I_AUX_CONF_CONC_CH_RESP,
               I_AUX_CONF_CTA_CH_RESP,
               'D',
               VIMPMON,
               VIMPLOC,
               0,
               0,
               0,
               0,
               I_EMPRESA);
            --INSERTAR EN LA TABLA QUE RELACIONA FIN_CHEQUE CON FIN_DOCUMENTO
            INSERT INTO FIN_CHEQUE_DOCU_RESP
              (CHDO_CLAVE_DOC, CHDO_CLAVE_CHEQ, CHDO_EMPR)
            VALUES
              (V_CLAVE_CH_RESP, VCLAVECHEQ, I_EMPRESA);
          END IF;
          /*===========================================================================*/
        /*===========================================================================*/
        END LOOP;
      END IF;
    END IF;
  END PP_ACTUALIZAR_TARJ_CHEQ_1;

  PROCEDURE PP_UNLOCK_IMPRESORA(I_EMPRESA     IN NUMBER,
                                I_DOC_NRO_DOC IN GEN_IMPRESORA.IMP_ULT_REC_PAGO_EMIT%TYPE) IS
  BEGIN

    UPDATE GEN_IMPRESORA
       SET IMP_ULT_REC_PAGO_EMIT = I_DOC_NRO_DOC
     WHERE IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR') --IMP_CODIGO = :PARAMETER.P_IMPRESORA
       AND IMP_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'No se puede desbloquar la impresora!.');
  END PP_UNLOCK_IMPRESORA;

  PROCEDURE PP_ACTUALIZA_TRANS(I_EMPRESA      IN NUMBER,
                               I_SUCURSAL     IN NUMBER,
                               I_TASA_OFIC    IN NUMBER,
                               I_TOTAL_IMP    IN NUMBER,
                               I_PROGRAMA     IN VARCHAR2,
                               I_USUARIO      IN VARCHAR2,
                               I_S_MON        IN NUMBER,
                               I_DOC_FEC_OPER IN DATE,
                               I_DOC_CTA_BCO  IN NUMBER) IS
    V_CLAVE_DEP NUMBER(14);
    V_CLAVE_EXT NUMBER(14);
    --V_CLAVE_PADRE NUMBER(14);
    V_IMPO_LOC NUMBER(20, 4);
    V_IMPO_MON NUMBER(20, 4);
    V_OPAUX    CHAR(1);
  BEGIN

    V_CLAVE_DEP := FIN_SEQ_DOC_NEXTVAL;
    V_CLAVE_EXT := FIN_SEQ_DOC_NEXTVAL;

    IF I_TASA_OFIC <> 1 THEN
      V_IMPO_LOC := I_TOTAL_IMP * I_TASA_OFIC;
      V_IMPO_MON := I_TOTAL_IMP;
    ELSE
      V_IMPO_LOC := I_TOTAL_IMP;
      V_IMPO_MON := I_TOTAL_IMP;
    END IF;

    V_OPAUX := 'S';

    FOR REG IN (SELECT SEQ_ID,
                       C001   CHEQ_SERIE,
                       C002   CHEQ_NRO,
                       C003   BENEFICIARIO,
                       D001   CHEQ_FEC_DEPOSITAR,
                       N001   CHEQ_BCO,
                       N002   IMPORTE
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'CHEQUE_AUT_FINI003') LOOP
      INSERT INTO FIN_DOCUMENTO_FINI002
        (DOC_CLAVE_DEP,
         DOC_CTA_BCO_DEP,
         DOC_TIPO_SALDO_DEP,
         DOC_NRO_DOC_DEP,
         DOC_SUC_DEP,
         DOC_FEC_OPER_DEP,
         DOC_FEC_DOC_DEP,
         DOC_MON_DEP,
         DOC_NETO_EXEN_LOC_DEP,
         DOC_NETO_EXEN_MON_DEP,
         DOC_OBS_DEP,
         DOC_LOGIN_DEP,
         DOC_FEC_GRAB_DEP,
         DOC_SIST_DEP,
         DCON_CLAVE_CONCEPTO_DEP,
         DCON_TIPO_SALDO_DEP,
         DOC_CLAVE_EXT,
         DOC_CTA_BCO_EXT,
         DOC_TIPO_SALDO_EXT,
         DOC_MON_EXT,
         DOC_NETO_EXEN_LOC_EXT,
         DOC_NETO_EXEN_MON_EXT,
         DCON_CLAVE_CONCEPTO_EXT,
         DCON_TIPO_SALDO_EXT,
         DCON_CLAVE_CTACO_EXT,
         FINI002_ESTADO,
         FINI002_TRANS_OPAUX,
         DOC_EMPR)
      VALUES
        (V_CLAVE_DEP,
         I_DOC_CTA_BCO,
         'D',
         REG.CHEQ_NRO,
         I_SUCURSAL,
         I_DOC_FEC_OPER,
         I_DOC_FEC_OPER,
         I_S_MON,
         V_IMPO_LOC,
         V_IMPO_MON,
         REG.BENEFICIARIO,
         I_USUARIO,
         SYSDATE,
         SUBSTR(I_PROGRAMA, 1, 3),
         1120,
         'D',
         V_CLAVE_EXT,
         REG.CHEQ_BCO,
         'C',
         I_S_MON,
         V_IMPO_LOC,
         V_IMPO_MON,
         877,
         'C',
         20,
         'P',
         V_OPAUX,
         I_EMPRESA);
    END LOOP;
    COMMIT;

  END PP_ACTUALIZA_TRANS;

  PROCEDURE PP_VERIFICAR_NOTACRED(PROV          IN NUMBER,
                                  CLAVE_DOC     IN NUMBER,
                                  I_EMPRESA     IN NUMBER,
                                  V_EXENTO_LOC  IN OUT NUMBER,
                                  V_EXENTO_MON  IN OUT NUMBER,
                                  V_GRAVADO_LOC IN OUT NUMBER,
                                  V_GRAVADO_MON IN OUT NUMBER,
                                  V_IVA_LOC     IN OUT NUMBER,
                                  V_IVA_MON     IN OUT NUMBER) IS

    /*============ESTE CURSOR SIRVE PARA TRAER CLAVE PADRE DEL TMOV 30, Y ESA CLAVE ES DEL TMOV 21============*/
    CURSOR C_PADRE_REC_NOTCRED IS
      SELECT K.DOC_CLAVE_PADRE CLAVE_PADRE
        FROM FIN_DOCUMENTO I, FIN_CUOTA Y, FIN_PAGO G, FIN_DOCUMENTO K
       WHERE I.DOC_EMPR = I_EMPRESA
         AND K.DOC_EMPR(+) = G.PAG_EMPR
         AND Y.CUO_EMPR = G.PAG_EMPR(+)
         AND (Y.CUO_FEC_VTO = G.PAG_FEC_VTO(+) AND
             Y.CUO_CLAVE_DOC = G.PAG_CLAVE_DOC(+))
         AND (I.DOC_CLAVE = Y.CUO_CLAVE_DOC)
         AND K.DOC_CLAVE(+) = G.PAG_CLAVE_PAGO
         AND I.DOC_CLAVE = CLAVE_DOC
         AND I.DOC_PROV = PROV
         AND K.DOC_TIPO_MOV = 30;

    CURSOR C_NOT_CRED(CLAVE IN NUMBER) IS
      SELECT DISTINCT (CUO_CLAVE_DOC) CLAVE,
                      DOC_NETO_EXEN_MON,
                      DOC_NETO_EXEN_LOC,
                      DOC_NETO_GRAV_MON,
                      DOC_NETO_GRAV_LOC,
                      DOC_IVA_LOC,
                      DOC_IVA_MON
        FROM FIN_DOCUMENTO, FIN_PAGO, FIN_CUOTA
       WHERE PAG_EMPR = I_EMPRESA
         AND PAG_EMPR = DOC_EMPR
         AND DOC_EMPR = CUO_EMPR
         AND PAG_CLAVE_PAGO = CLAVE
         AND DOC_CLAVE = CUO_CLAVE_DOC
         AND CUO_FEC_VTO = PAG_FEC_VTO
         AND CUO_CLAVE_DOC = PAG_CLAVE_DOC;

    V_EXEN_MON NUMBER := 0;
    V_EXEN_LOC NUMBER := 0;
    V_GRAV_MON NUMBER := 0;
    V_GRAV_LOC NUMBER := 0;
    V_IV_MON   NUMBER := 0;
    V_IV_LOC   NUMBER := 0;

    V_PORC_IVA NUMBER := 0;
    V_PAGO_MON NUMBER := 0;
    V_PAGO_LOC NUMBER := 0;

  BEGIN

    FOR RP IN C_PADRE_REC_NOTCRED LOOP
      FOR R IN C_NOT_CRED(RP.CLAVE_PADRE) LOOP

        SELECT SUM(PAG_IMP_MON) PAG_IMP_MON, SUM(PAG_IMP_LOC) PAG_IMP_LOC
          INTO V_PAGO_MON, V_PAGO_LOC
          FROM FIN_PAGO
         WHERE PAG_CLAVE_DOC = CLAVE_DOC
           AND PAG_EMPR = I_EMPRESA
           AND PAG_CLAVE_PAGO =
               (SELECT DOC_CLAVE
                  FROM FIN_DOCUMENTO
                 WHERE DOC_CLAVE_PADRE = RP.CLAVE_PADRE
                   AND DOC_EMPR = I_EMPRESA);

        IF (R.DOC_IVA_MON <> 0 AND R.DOC_NETO_GRAV_MON <> 0) THEN
          V_PORC_IVA := ROUND((R.DOC_IVA_MON / R.DOC_NETO_GRAV_MON) * 100,
                              0);
        END IF;

        IF NVL(R.DOC_NETO_EXEN_MON, 0) > 0 THEN
          V_EXEN_MON := V_EXEN_MON + V_PAGO_MON;
          V_EXEN_LOC := V_EXEN_LOC + V_PAGO_LOC;
        ELSE
          V_GRAV_MON := ROUND(V_GRAV_MON +
                              ((V_PAGO_MON) / ((100 + V_PORC_IVA) / 100)),
                              0);
          V_GRAV_LOC := ROUND(V_GRAV_LOC +
                              ((V_PAGO_LOC) / ((100 + V_PORC_IVA) / 100)),
                              0);
          V_IV_MON   := ROUND(V_IV_MON + ((V_PAGO_MON) /
                              ((100 + V_PORC_IVA) / V_PORC_IVA)),
                              0);
          V_IV_LOC   := ROUND(V_IV_LOC + ((V_PAGO_LOC) /
                              ((100 + V_PORC_IVA) / V_PORC_IVA)),
                              0);
        END IF;

      END LOOP;
    END LOOP;

    V_EXENTO_MON  := V_EXEN_MON;
    V_EXENTO_LOC  := V_EXEN_LOC;
    V_GRAVADO_MON := V_GRAV_MON;
    V_GRAVADO_LOC := V_GRAV_LOC;
    V_IVA_MON     := V_IV_MON;
    V_IVA_LOC     := V_IV_LOC;
  END PP_VERIFICAR_NOTACRED;

  PROCEDURE PP_ACTUALIZAR_DOC_RETEN(I_W_IND_RETENCION            IN VARCHAR2,
                                    I_NRO_RETENCION              IN NUMBER,
                                    I_EMPRESA                    IN NUMBER,
                                    I_W_CUENTA                   IN NUMBER,
                                    I_DOC_FEC_DOC                IN DATE,
                                    I_DOC_FEC_OPER               IN DATE,
                                    I_SUCURSAL                   IN NUMBER,
                                    I_TIMBRADO                   IN NUMBER,
                                    I_DOC_PROV                   IN NUMBER,
                                    I_FEC_INIC_SISTEMA           IN DATE,
                                    I_P_FEC_FIN_SISTEMA          IN DATE,
                                    I_W_MON_DEC_IMP              IN NUMBER,
                                    I_DOC_OBS                    IN VARCHAR2,
                                    I_USUARIO                    IN VARCHAR2,
                                    I_PROGRAMA                   IN VARCHAR2,
                                    I_DOC_OPERADOR               IN NUMBER,
                                    I_DOC_CTA_BCO                IN NUMBER,
                                    I_DOC_CLAVE                  IN NUMBER,
                                    I_CONF_TMOV_RETENCION        IN NUMBER,
                                    I_CONF_CONC_RETEN_CENTRAL    IN NUMBER,
                                    I_CONF_CONC_RETEN_ASUNCION   IN NUMBER,
                                    I_CONF_CONC_RETEN_CONCEPCION IN NUMBER,
                                    I_CONF_CONC_RETEN_LOMA       IN NUMBER,
                                    I_CONF_CONC_RETEN_SANTAROSA  IN NUMBER,
                                    I_DOC_CLI_NOM                IN VARCHAR2,
                                    I_P_MON_LOC                  IN NUMBER,
                                    I_DOC_MON                    IN NUMBER,
                                    I_DOC_TASA                   IN NUMBER) IS
    --V_DOCU_TOT_MON      NUMBER;
    --V_DOCU_TOT_LOC      NUMBER;
    V_NRO_RET_TEMP NUMBER := I_NRO_RETENCION;
    --V_FACTURA_RETENIDA  NUMBER;
    --V_TOTAL_FACTURA_LOC NUMBER;
    --V_TOTAL_FACTURA_MON NUMBER;

    --V_NCR_EXEN_LOC       NUMBER := 0;
    --V_NCR_EXEN_MON       NUMBER := 0;
    --V_NCR_GRAV_MON       NUMBER := 0;
    --V_NCR_GRAV_LOC       NUMBER := 0;
    --V_NCR_IVA_MON        NUMBER := 0;
    --V_NCR_IVA_LOC        NUMBER := 0;
    --V_TOTAL_IVA_LOC      NUMBER := 0;
    --V_TOTAL_IVA_MON      NUMBER := 0;
    --V_FECHA_MAX          DATE;
    --V_DOC_MON            NUMBER;
    V_PROV_RUC_DV NUMBER;
    --V_SUM_GRAB_ACUMULADO NUMBER;
    --V_FEC_DOC_ANTERIOR   DATE;
    --V_REG                NUMBER;

    V_BRET_DOC_DOC_CLAVE          FIN_DOCUMENTO.DOC_CLAVE%TYPE;
    V_BRET_DOC_DOC_EMPR           FIN_DOCUMENTO.DOC_EMPR%TYPE;
    V_BRET_DOC_DOC_SUC            FIN_DOCUMENTO.DOC_SUC%TYPE;
    V_BRET_DOC_DOC_NRO_DOC        FIN_DOCUMENTO.DOC_NRO_DOC%TYPE;
    V_BRET_DOC_DOC_TIMBRADO       FIN_DOCUMENTO.DOC_TIMBRADO%TYPE;
    V_BRET_DOC_DOC_MON            FIN_DOCUMENTO.DOC_MON%TYPE;
    V_BRET_DOC_DOC_PROV           FIN_DOCUMENTO.DOC_PROV%TYPE;
    V_BRET_DOC_DOC_FEC_OPER       FIN_DOCUMENTO.DOC_FEC_OPER%TYPE;
    V_BRET_DOC_DOC_FEC_DOC        FIN_DOCUMENTO.DOC_FEC_DOC%TYPE;
    V_BRET_DOC_DOC_NETO_GRAV_LOC  FIN_DOCUMENTO.DOC_NETO_GRAV_LOC%TYPE;
    V_BRET_DOC_DOC_NETO_GRAV_MON  FIN_DOCUMENTO.DOC_NETO_GRAV_MON%TYPE;
    V_BRET_DOC_DOC_NETO_EXEN_LOC  FIN_DOCUMENTO.DOC_NETO_EXEN_LOC%TYPE;
    V_BRET_DOC_DOC_NETO_EXEN_MON  FIN_DOCUMENTO.DOC_NETO_EXEN_MON%TYPE;
    V_BRET_DOC_DOC_BRUTO_GRAV_LOC FIN_DOCUMENTO.DOC_BRUTO_GRAV_LOC%TYPE;
    V_BRET_DOC_DOC_BRUTO_GRAV_MON FIN_DOCUMENTO.DOC_BRUTO_GRAV_MON%TYPE;
    V_BRET_DOC_DOC_BRUTO_EXEN_LOC FIN_DOCUMENTO.DOC_BRUTO_EXEN_LOC%TYPE;
    V_BRET_DOC_DOC_BRUTO_EXEN_MON FIN_DOCUMENTO.DOC_BRUTO_EXEN_MON%TYPE;
    V_BRET_DOC_DOC_IVA_LOC        FIN_DOCUMENTO.DOC_IVA_LOC%TYPE;
    V_BRET_DOC_DOC_IVA_MON        FIN_DOCUMENTO.DOC_IVA_MON%TYPE;
    V_BRET_DOC_DOC_OBS            FIN_DOCUMENTO.DOC_OBS%TYPE;
    V_BRET_DOC_DOC_LOGIN          FIN_DOCUMENTO.DOC_LOGIN%TYPE;
    V_BRET_DOC_DOC_FEC_GRAB       FIN_DOCUMENTO.DOC_FEC_GRAB%TYPE;
    V_BRET_DOC_DOC_SIST           FIN_DOCUMENTO.DOC_SIST%TYPE;
    V_BRET_DOC_DOC_OPERADOR       FIN_DOCUMENTO.DOC_OPERADOR%TYPE;
    V_BRET_DOC_DOC_GRAV_5_MON     FIN_DOCUMENTO.DOC_GRAV_5_MON%TYPE;
    V_BRET_DOC_DOC_GRAV_5_LOC     FIN_DOCUMENTO.DOC_GRAV_5_LOC%TYPE;
    V_BRET_DOC_DOC_GRAV_10_MON    FIN_DOCUMENTO.DOC_GRAV_10_MON%TYPE;
    V_BRET_DOC_DOC_GRAV_10_LOC    FIN_DOCUMENTO.DOC_GRAV_10_LOC%TYPE;
    V_BRET_DOC_DOC_IVA_5_MON      FIN_DOCUMENTO.DOC_IVA_5_MON%TYPE;
    V_BRET_DOC_DOC_IVA_5_LOC      FIN_DOCUMENTO.DOC_IVA_5_LOC%TYPE;
    V_BRET_DOC_DOC_IVA_10_MON     FIN_DOCUMENTO.DOC_IVA_10_MON%TYPE;
    V_BRET_DOC_DOC_IVA_10_LOC     FIN_DOCUMENTO.DOC_IVA_10_LOC%TYPE;
    V_BRET_DOC_DOC_CTA_BCO        FIN_DOCUMENTO.DOC_CTA_BCO%TYPE;
    V_BRET_DOC_DOC_IND_CUOTA      FIN_DOCUMENTO.DOC_IND_CUOTA%TYPE;
    V_BRET_DOC_DOC_SALDO_LOC      FIN_DOCUMENTO.DOC_SALDO_LOC%TYPE;
    V_BRET_DOC_DOC_SALDO_MON      FIN_DOCUMENTO.DOC_SALDO_MON%TYPE;
    V_BRET_DOC_SALDO_PER_ACT_LOC  FIN_DOCUMENTO.DOC_SALDO_PER_ACT_LOC%TYPE;
    V_BRET_DOC_SALDO_PER_ACT_MON  FIN_DOCUMENTO.DOC_SALDO_PER_ACT_MON%TYPE;
    V_BRET_DOC_DOC_CLAVE_PADRE    FIN_DOCUMENTO.DOC_CLAVE_PADRE%TYPE;
    V_BRET_DOC_DOC_TIPO_MOV       FIN_DOCUMENTO.DOC_TIPO_MOV%TYPE;
    V_BRET_DOC_DOC_TIPO_SALDO     FIN_DOCUMENTO.DOC_TIPO_SALDO%TYPE;
    V_BRET_DOC_DOC_TASA           FIN_DOCUMENTO.DOC_TASA%TYPE;
    V_BRET_DOC_DOC_TIMBRADO       FIN_DOCUMENTO.DOC_TIMBRADO%TYPE;

    V_BRET_DCON_CLAVE_DOC      FIN_DOC_CONCEPTO.DCON_CLAVE_DOC%TYPE;
    V_BRET_DCON_ITEM           FIN_DOC_CONCEPTO.DCON_ITEM%TYPE;
    V_BRET_DCON_CLAVE_CONCEPTO FIN_DOC_CONCEPTO.DCON_CLAVE_CONCEPTO%TYPE;
    V_BRET_DCON_CLAVE_CTACO    FIN_DOC_CONCEPTO.DCON_CLAVE_CTACO%TYPE;
    V_BRET_DCON_EMPR           FIN_DOC_CONCEPTO.DCON_EMPR%TYPE;
    V_BRET_DCON_TIPO_SALDO     FIN_DOC_CONCEPTO.DCON_TIPO_SALDO%TYPE;
    V_BRET_DCON_EXEN_LOC       FIN_DOC_CONCEPTO.DCON_EXEN_LOC%TYPE;
    V_BRET_DCON_EXEN_MON       FIN_DOC_CONCEPTO.DCON_EXEN_MON%TYPE;
    V_BRET_DCON_GRAV_LOC       FIN_DOC_CONCEPTO.DCON_GRAV_LOC%TYPE;
    V_BRET_DCON_GRAV_MON       FIN_DOC_CONCEPTO.DCON_GRAV_MON%TYPE;
    V_BRET_DCON_IVA_LOC        FIN_DOC_CONCEPTO.DCON_IVA_LOC%TYPE;
    V_BRET_DCON_IVA_MON        FIN_DOC_CONCEPTO.DCON_IVA_MON%TYPE;
    V_BRET_DCON_OBS            FIN_DOC_CONCEPTO.DCON_OBS%TYPE;
    V_CONF_CONC_RETEN_CAACUPE  NUMBER;
    V_CONF_CONC_RETEN_CDE      NUMBER;
    CURSOR RETENCIONES IS
      SELECT N001 RET_CLAVE_RETENCION, --CLAVE NUEVA PARA LA RETENCION
             N002 RET_IMPORTE_MON,
             N003 RET_IMPORTE_LOC,
             N004 RET_MONEDA,
             N005 RET_PROVEEDOR,
             C001 RET_CLAVE_FAC,
             C002 RET_EMPRESA,
             D001 RET_FECHA_FAC,
             C003 RET_NRO_FAC

        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'DETALLE_RETEN_FINI003'
         AND N002 > 0;

  BEGIN

    --   IF NVL(I_W_IND_RETENCION, 'N') = 'S' THEN
    FOR R IN RETENCIONES LOOP


 if I_DOC_MON  = 2 and I_DOC_TASA <= 1 then
    RAISE_APPLICATION_ERROR (-20001, 'ERROR AL INSERTAR RET, TASA NO PUEDE SER IGUAL A 1');
 end if;
      V_BRET_DOC_DOC_FEC_DOC  := I_DOC_FEC_DOC;
      V_BRET_DOC_DOC_FEC_OPER := I_DOC_FEC_OPER;
      V_BRET_DOC_DOC_SUC      := I_SUCURSAL;
      V_BRET_DOC_DOC_PROV     := I_DOC_PROV;
      V_BRET_DOC_DOC_MON      := I_DOC_MON;
      V_BRET_DOC_DOC_NRO_DOC  := V_NRO_RET_TEMP;
      --V_BRET_DOC_DOC_TIMBRADO        :=I_TIMBRADO;
      V_BRET_DOC_DOC_TASA := I_DOC_TASA;

      V_BRET_DOC_DOC_NETO_GRAV_LOC  := 0;
      V_BRET_DOC_DOC_NETO_GRAV_MON  := 0;
      V_BRET_DOC_DOC_NETO_EXEN_LOC  := R.RET_IMPORTE_LOC;
      V_BRET_DOC_DOC_NETO_EXEN_MON  := R.RET_IMPORTE_MON;
      V_BRET_DOC_DOC_BRUTO_GRAV_LOC := 0;
      V_BRET_DOC_DOC_BRUTO_GRAV_MON := 0;
      V_BRET_DOC_DOC_BRUTO_EXEN_LOC := R.RET_IMPORTE_LOC;
      V_BRET_DOC_DOC_BRUTO_EXEN_MON := R.RET_IMPORTE_MON;
      V_BRET_DOC_DOC_IVA_LOC        := 0;
      V_BRET_DOC_DOC_IVA_MON        := 0;
      V_BRET_DOC_DOC_OBS            := I_DOC_OBS;
      V_BRET_DOC_DOC_LOGIN          := I_USUARIO;
      V_BRET_DOC_DOC_FEC_GRAB       := SYSDATE;
      V_BRET_DOC_DOC_SIST           := SUBSTR(I_PROGRAMA, 1, 3);
      V_BRET_DOC_DOC_OPERADOR       := I_DOC_OPERADOR;

      V_BRET_DOC_DOC_GRAV_5_MON  := 0;
      V_BRET_DOC_DOC_GRAV_5_LOC  := 0;
      V_BRET_DOC_DOC_GRAV_10_MON := 0;
      V_BRET_DOC_DOC_GRAV_10_LOC := 0;

      V_BRET_DOC_DOC_IVA_5_MON  := 0;
      V_BRET_DOC_DOC_IVA_5_LOC  := 0;
      V_BRET_DOC_DOC_IVA_10_MON := 0;
      V_BRET_DOC_DOC_IVA_10_LOC := 0;

      V_BRET_DOC_DOC_CTA_BCO       := I_DOC_CTA_BCO;
      V_BRET_DOC_DOC_IND_CUOTA     := NULL;
      V_BRET_DOC_DOC_SALDO_LOC     := 0;
      V_BRET_DOC_DOC_SALDO_MON     := 0;
      V_BRET_DOC_SALDO_PER_ACT_LOC := 0;
      V_BRET_DOC_SALDO_PER_ACT_MON := 0;
      V_BRET_DOC_DOC_CLAVE_PADRE   := I_DOC_CLAVE;
      V_BRET_DOC_DOC_TIPO_MOV      := I_CONF_TMOV_RETENCION;
      V_BRET_DOC_DOC_EMPR          := I_EMPRESA;

      -- ACTUALIZAR DOC_FIN.DOC_TIPO_SALDO
      BEGIN
        SELECT TMOV_TIPO
          INTO V_BRET_DOC_DOC_TIPO_SALDO
          FROM GEN_TIPO_MOV
         WHERE TMOV_CODIGO = V_BRET_DOC_DOC_TIPO_MOV
           AND TMOV_EMPR = I_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Tipo de documento inexistente: ' ||
                                  TO_CHAR(V_BRET_DOC_DOC_TIPO_MOV));
      END;
      --=========================================================================================

      INSERT INTO FIN_DOCUMENTO
        (DOC_CLAVE,
         DOC_EMPR,
         DOC_SUC,
         DOC_NRO_DOC,
         DOC_TIMBRADO,
         DOC_MON,
         DOC_PROV,
         DOC_FEC_OPER,
         DOC_FEC_DOC,
         DOC_NETO_GRAV_LOC,
         DOC_NETO_GRAV_MON,
         DOC_NETO_EXEN_LOC,
         DOC_NETO_EXEN_MON,
         DOC_BRUTO_GRAV_LOC,
         DOC_BRUTO_GRAV_MON,
         DOC_BRUTO_EXEN_LOC,
         DOC_BRUTO_EXEN_MON,
         DOC_IVA_LOC,
         DOC_IVA_MON,
         DOC_OBS,
         DOC_LOGIN,
         DOC_FEC_GRAB,
         DOC_SIST,
         DOC_OPERADOR,
         DOC_GRAV_5_MON,
         DOC_GRAV_5_LOC,
         DOC_GRAV_10_MON,
         DOC_GRAV_10_LOC,
         DOC_IVA_5_MON,
         DOC_IVA_5_LOC,
         DOC_IVA_10_MON,
         DOC_IVA_10_LOC,
         DOC_CTACO,
         DOC_IND_CUOTA,
         DOC_SALDO_LOC,
         DOC_SALDO_MON,
         DOC_SALDO_PER_ACT_LOC,
         DOC_SALDO_PER_ACT_MON,
         DOC_CLAVE_PADRE,
         DOC_TIPO_MOV,
         DOC_TIPO_SALDO,
         DOC_TASA,
         DOC_CTA_BCO)
      VALUES
        (R.RET_CLAVE_RETENCION, --LA CLAVE YA FUE CALCULADA ANTES DE CARGAR A LA COLECCION
         V_BRET_DOC_DOC_EMPR,
         V_BRET_DOC_DOC_SUC,
         V_BRET_DOC_DOC_NRO_DOC,
         I_TIMBRADO,
         V_BRET_DOC_DOC_MON,
         V_BRET_DOC_DOC_PROV,
         V_BRET_DOC_DOC_FEC_OPER,
         V_BRET_DOC_DOC_FEC_DOC,
         V_BRET_DOC_DOC_NETO_GRAV_LOC,
         V_BRET_DOC_DOC_NETO_GRAV_MON,
         V_BRET_DOC_DOC_NETO_EXEN_LOC,
         V_BRET_DOC_DOC_NETO_EXEN_MON,
         V_BRET_DOC_DOC_BRUTO_GRAV_LOC,
         V_BRET_DOC_DOC_BRUTO_GRAV_MON,
         V_BRET_DOC_DOC_BRUTO_EXEN_LOC,
         V_BRET_DOC_DOC_BRUTO_EXEN_MON,
         V_BRET_DOC_DOC_IVA_LOC,
         V_BRET_DOC_DOC_IVA_MON,
         V_BRET_DOC_DOC_OBS,
         V_BRET_DOC_DOC_LOGIN,
         V_BRET_DOC_DOC_FEC_GRAB,
         V_BRET_DOC_DOC_SIST,
         V_BRET_DOC_DOC_OPERADOR,
         V_BRET_DOC_DOC_GRAV_5_MON,
         V_BRET_DOC_DOC_GRAV_5_LOC,
         V_BRET_DOC_DOC_GRAV_10_MON,
         V_BRET_DOC_DOC_GRAV_10_LOC,
         V_BRET_DOC_DOC_IVA_5_MON,
         V_BRET_DOC_DOC_IVA_5_LOC,
         V_BRET_DOC_DOC_IVA_10_MON,
         V_BRET_DOC_DOC_IVA_10_LOC,
         NULL,
         V_BRET_DOC_DOC_IND_CUOTA,
         V_BRET_DOC_DOC_SALDO_LOC,
         V_BRET_DOC_DOC_SALDO_MON,
         V_BRET_DOC_SALDO_PER_ACT_LOC,
         V_BRET_DOC_SALDO_PER_ACT_MON,
         V_BRET_DOC_DOC_CLAVE_PADRE,
         V_BRET_DOC_DOC_TIPO_MOV,
         V_BRET_DOC_DOC_TIPO_SALDO,
         V_BRET_DOC_DOC_TASA,
         V_BRET_DOC_DOC_CTA_BCO);
      --=========================================================================================
      --    GO_BLOCK('BRET_DCONC');
      --                          CREATE_RECORD;
      V_BRET_DCON_CLAVE_DOC := V_BRET_DOC_DOC_CLAVE;
      V_BRET_DCON_ITEM      := 1;

      SELECT A.CONF_CONC_RETEN_CAACUPE, A.CONF_CONC_RETEN_CDE
        INTO V_CONF_CONC_RETEN_CAACUPE, V_CONF_CONC_RETEN_CDE
        FROM FIN_CONFIGURACION A
       WHERE A.CONF_EMPR = I_EMPRESA;

      IF I_SUCURSAL = 1 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := I_CONF_CONC_RETEN_CENTRAL;
      ELSIF I_SUCURSAL = 2 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := I_CONF_CONC_RETEN_ASUNCION;
      ELSIF I_SUCURSAL = 3 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := I_CONF_CONC_RETEN_CONCEPCION;
      ELSIF I_SUCURSAL = 4 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := I_CONF_CONC_RETEN_LOMA;
      ELSIF I_SUCURSAL = 6 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := I_CONF_CONC_RETEN_SANTAROSA;
      ELSIF I_SUCURSAL = 7 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := 2163;
      ELSIF I_SUCURSAL = 9 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := 2243; --Se usa la configuraci?n de Misiones para las retenciones de Encarnacion, mientras se crea el concepto. 23/03/2020

      ELSIF I_SUCURSAL = 10 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := V_CONF_CONC_RETEN_CAACUPE;
      ELSIF I_SUCURSAL = 11 THEN
        V_BRET_DCON_CLAVE_CONCEPTO := V_CONF_CONC_RETEN_CDE;
      END IF;
      DECLARE
      BEGIN
        SELECT FCON_CLAVE_CTACO
          INTO V_BRET_DCON_CLAVE_CTACO
          FROM FIN_CONCEPTO
         WHERE FCON_CLAVE = V_BRET_DCON_CLAVE_CONCEPTO
           AND FCON_EMPR = I_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      V_BRET_DCON_EMPR       := I_EMPRESA;
      V_BRET_DCON_TIPO_SALDO := 'D';
      V_BRET_DCON_EXEN_LOC   := R.RET_IMPORTE_LOC;
      V_BRET_DCON_EXEN_MON   := R.RET_IMPORTE_MON;
      V_BRET_DCON_GRAV_LOC   := 0;
      V_BRET_DCON_GRAV_MON   := 0;
      V_BRET_DCON_IVA_LOC    := 0;
      V_BRET_DCON_IVA_MON    := 0;
      V_BRET_DCON_OBS        := 'Ret. a Pagar:  ' || R.RET_IMPORTE_MON;
      --***
      
   --  RAISE_APPLICATION_ERROR(-20002,V_BRET_DCON_CLAVE_CONCEPTO );
      INSERT INTO FIN_DOC_CONCEPTO
        (DCON_CLAVE_DOC,
         DCON_ITEM,
         DCON_CLAVE_CONCEPTO,
         DCON_CLAVE_CTACO,
         DCON_EMPR,
         DCON_TIPO_SALDO,
         DCON_EXEN_LOC,
         DCON_EXEN_MON,
         DCON_GRAV_LOC,
         DCON_GRAV_MON,
         DCON_IVA_LOC,
         DCON_IVA_MON,
         DCON_OBS)
      VALUES
        (R.RET_CLAVE_RETENCION,
         V_BRET_DCON_ITEM,
         V_BRET_DCON_CLAVE_CONCEPTO,
         V_BRET_DCON_CLAVE_CTACO,
         V_BRET_DCON_EMPR,
         V_BRET_DCON_TIPO_SALDO,
         V_BRET_DCON_EXEN_LOC,
         V_BRET_DCON_EXEN_MON,
         V_BRET_DCON_GRAV_LOC,
         V_BRET_DCON_GRAV_MON,
         V_BRET_DCON_IVA_LOC,
         V_BRET_DCON_IVA_MON,
         V_BRET_DCON_OBS);
--RAISE_APPLICATION_ERROR(-20002,V_BRET_DCON_CLAVE_CONCEPTO );
      --***
      DECLARE
      BEGIN
        UPDATE GEN_IMPRESORA
           SET IMP_ULT_RETENCION = I_NRO_RETENCION
         WHERE IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR') --IMP_CODIGO = :PARAMETER.P_IMPRESORA
           AND IMP_EMPR = I_EMPRESA;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;

      UPDATE FIN_DOCUMENTO
         SET DOC_CLAVE_RETENCION = R.RET_CLAVE_RETENCION
       WHERE DOC_CLAVE = R.RET_CLAVE_FAC
         AND DOC_EMPR = I_EMPRESA;
      UPDATE FIN_CUOTA
         SET CUO_CLAVE_RETENCION = R.RET_CLAVE_RETENCION
       WHERE CUO_CLAVE_DOC = R.RET_CLAVE_FAC
         AND CUO_EMPR = I_EMPRESA;

      BEGIN
        SELECT PROV_RUC_DV
          INTO V_PROV_RUC_DV
          FROM FIN_PROVEEDOR
         WHERE PROV_CODIGO = V_BRET_DOC_DOC_PROV
           AND PROV_EMPR = I_EMPRESA;
      EXCEPTION
        WHEN OTHERS THEN
          V_PROV_RUC_DV := 0;
      END;

      ------------------------------------------------------------------------------------------------------------------------
      --GRABAR REGISTRO PARA ENVIAR A LA SET A TRAVES DEL TESAKA.
      ------------------------------------------------------------------------------------------------------------------------
      IF V_PROV_RUC_DV = '99999901' THEN
        --VALIDAR RUC PARA NO DOMICILIADOS.
        V_PROV_RUC_DV := 0;
      END IF;
      INSERT INTO FIN_RETENCION
        (RET_DOC_NRO,
         RET_DOC_FEC_DOC,
         RET_CONTRIBUYENTE,
         RET_TIPO_ID_CONTRIBUYENTE,
         RET_ID_CONTRIBUYENTE,
         RET_TOTAL,
         RET_ESTADO,
         RET_USER_EMIT,
         RET_FEC_CONF,
         RET_USER_CONF,
         RET_DOC_CLAVE,
         RET_RET_CLAVE,
         RET_FECHA,
         RET_TIPO,
         RET_PORCENTAJE,
         RET_EMPR)
      VALUES
        (R.RET_NRO_FAC,
         TO_DATE(R.RET_FECHA_FAC, 'dd/mm/yyyy'),
         I_DOC_CLI_NOM,
         'RUC',
         V_PROV_RUC_DV,
         R.RET_IMPORTE_LOC,
         'P',
         I_USUARIO,
         NULL,
         NULL,
         R.RET_CLAVE_FAC,
         R.RET_CLAVE_RETENCION,
         V_BRET_DOC_DOC_FEC_DOC,
         'I',
         30,
         I_EMPRESA);
      ------------------------------------------------------------------------------------------------------------------------
    --  COMMIT;

    END LOOP;

  END PP_ACTUALIZAR_DOC_RETEN;

  PROCEDURE PP_ACTUALIZAR_REGISTRO(I_HOLDING                  IN NUMBER,
                                   I_S_TASA_OFIC              IN NUMBER,
                                   I_P_CANT_DECIMALES_LOC     IN NUMBER,
                                   I_CONF_CONCEPTO_COBRO      IN NUMBER,
                                   I_EMPRESA                  IN NUMBER,
                                   I_DOC_CTA_BCO              IN NUMBER,
                                   I_SUCURSAL                 IN NUMBER,
                                   I_DOC_NRO_DOC              IN NUMBER,
                                   I_DOC_MON                  IN NUMBER,
                                   I_DOC_FEC_OPER             IN DATE,
                                   I_DOC_FEC_DOC              IN DATE,
                                   I_USUARIO                  IN VARCHAR2,
                                   I_DOC_OPERADOR             IN NUMBER,
                                   I_DOC_SERIE                IN VARCHAR2,
                                   I_W_CUENTA                 IN NUMBER,
                                   I_DOC_CLI_NOM              IN VARCHAR2,
                                   I_P_IND_CHEQUE_DIF         IN VARCHAR2,
                                   I_P_PAGO_BANCO             IN VARCHAR2,
                                   I_P_CTA_BCO_DIA            IN NUMBER,
                                   I_AUX_TASA_DOC             IN NUMBER,
                                   I_AUX_CONF_COD_EXTRACCION  IN NUMBER,
                                   I_AUX_NRO_DOC              IN NUMBER,
                                   I_AUX_DOC_MON              IN NUMBER,
                                   I_AUX_TIPO_MOV             IN NUMBER,
                                   I_AUX_CLAVE_DOC            IN NUMBER,
                                   I_AUX_CONF_CONC_TC_INGRESO IN NUMBER,
                                   I_AUX_CONF_CTA_TC_INGRESO  IN NUMBER,
                                   I_CTA_CHEQ_DIF_RESPALDO    IN NUMBER,
                                   I_TOTAL_IMP                IN NUMBER,
                                   I_PROGRAMA                 IN VARCHAR2,
                                   I_DOC_NETO_EXEN_LOC        IN NUMBER,
                                   I_DOC_NETO_EXEN_MON        IN NUMBER,
                                   I_DOC_TIPO_SALDO           IN VARCHAR2,
                                   I_DOC_TIPO_MOV             IN NUMBER,
                                   I_S_RETEN_MON              IN NUMBER,
                                   I_ACT_IMPRESORA            IN VARCHAR2,
                                   I_W_IND_RETENCION          IN VARCHAR2,
                                   I_P_BANCO                  IN NUMBER,
                                   I_NRO_RETENCION            IN NUMBER,
                                   --I_S_ACT_IMPRESORA          IN VARCHAR2,
                                   I_CTA_NOT_TRAN_RESPALDO      IN NUMBER,
                                   I_AUX_CONF_CONC_CH_INGRESO   IN NUMBER,
                                   I_AUX_CONF_CTA_CH_INGRESO    IN NUMBER,
                                   I_AUX_FEC_DOC                IN DATE,
                                   I_AUX_CONF_COD_DEPOSITO      IN NUMBER,
                                   I_AUX_CLI_NOM                IN VARCHAR2,
                                   I_AUX_CLI_CODIGO             IN NUMBER,
                                   I_AUX_CONF_CONC_CH_RESP      IN NUMBER,
                                   I_AUX_CONF_CTA_CH_RESP       IN NUMBER,
                                   I_TIMBRADO                   IN NUMBER,
                                   I_DOC_PROV                   IN NUMBER,
                                   I_FEC_INIC_SISTEMA           IN DATE,
                                   I_FEC_FIN_SISTEMA            IN DATE,
                                   I_W_MON_DEC_IMP              IN NUMBER,
                                   I_DOC_OBS                    IN VARCHAR2,
                                   I_CONF_TMOV_RETENCION        IN NUMBER,
                                   I_CONF_CONC_RETEN_CENTRAL    IN NUMBER,
                                   I_CONF_CONC_RETEN_ASUNCION   IN NUMBER,
                                   I_CONF_CONC_RETEN_CONCEPCION IN NUMBER,
                                   I_CONF_CONC_RETEN_LOMA       IN NUMBER,
                                   I_CONF_CONC_RETEN_SANTAROSA  IN NUMBER,
                                   I_P_MON_LOC                  IN NUMBER,
                                   I_DOC_CLAVE                  IN NUMBER,
                                   O_MENSAJE                    OUT VARCHAR2,
                                   I_IND_PRESTAMO_BANCARIO      IN VARCHAR2 DEFAULT NULL,
                                   I_IND_CLI_ADELANTO           IN VARCHAR2,
                                   P_CLAVE_URL                  OUT VARCHAR2,
                                   P_CLAVE_IMP                  OUT NUMBER) IS

    --V_ALERT NUMBER;
    --V_PATH_IMPRESORA VARCHAR2(50) := NULL;
    IMPRESORANOREGISTRADA EXCEPTION;
    PRAGMA EXCEPTION_INIT(IMPRESORANOREGISTRADA, -302000);
    SALIR EXCEPTION;
    --V_REG_CHEQUES              NUMBER;
    V_DOC_CLAVE                NUMBER := I_DOC_CLAVE;
    V_CONF_RECIBO_PAGO_REC     NUMBER;
    V_DCON_CLAVE_CONCEPTO      NUMBER;
    V_DCON_CLAVE_CTACO         NUMBER;
    V_DCON_TIPO_SALDO          VARCHAR2(1);
    V_CONF_CONCEPTO_PAGO       NUMBER;
    V_CONF_RECIBO_PAGO_EMIT    NUMBER;
    V_CONF_CONCEPTO_COBRO      NUMBER;
    V_CONF_TMOV_PAGO_NC        NUMBER;
    V_CONF_CONC_PAGO_NC        NUMBER;
    V_CONF_TMOV_PAGO_NC_REC    NUMBER;
    V_CONF_CONC_PAGO_NC_REC    NUMBER;
    V_CONF_TMOV_DEVOL_ADEL_CLI NUMBER;
    V_CONF_CONC_CADCLI         NUMBER;
    V_CONF_TMOV_DEVOL_ADEL_PRO NUMBER;
    V_CONF_CONC_CADPRO         NUMBER;
    V_PARAMETROS               VARCHAR2(600);
    V_IDENTIFICADOR            VARCHAR2(2) := '&'; --SE UTILIZA PARA QUE AL COMPILAR NO LO TOME COMO PARAMETROS
    V_CONF_COD_EXTRACCION      NUMBER;
    V_CONF_COD_DEPOSITO        NUMBER;
    V_CONF_CONC_TC_INGRESO     NUMBER;
    V_CONF_CTA_TC_INGRESO      NUMBER;
    V_CONF_CONC_CH_INGRESO     NUMBER;
    V_CONF_CTA_CH_INGRESO      NUMBER;
    V_CONF_CONC_CH_RESP        NUMBER;
    V_CONF_CTA_CH_RESP         NUMBER;
    V_CLAVE_IMPRIMIR           VARCHAR2(2000);
    V_REPORTE                  VARCHAR(30) := 'FINI003_REC_AI';

  BEGIN

    SELECT CONF_RECIBO_PAGO_REC,
           CONF_CONCEPTO_PAGO,
           CONF_RECIBO_PAGO_EMIT,
           CONF_CONCEPTO_COBRO,
           CONF_TMOV_PAGO_NC,
           CONF_CONC_PAGO_NC,
           CONF_TMOV_PAGO_NC_REC,
           CONF_CONC_PAGO_NC_REC,
           CONF_TMOV_DEVOL_ADEL_CLI,
           CONF_CONC_CADCLI,
           CONF_TMOV_DEVOL_ADEL_PRO,
           CONF_CONC_CADPRO
      INTO V_CONF_RECIBO_PAGO_REC,
           V_CONF_CONCEPTO_PAGO,
           V_CONF_RECIBO_PAGO_EMIT,
           V_CONF_CONCEPTO_COBRO,
           V_CONF_TMOV_PAGO_NC,
           V_CONF_CONC_PAGO_NC,
           V_CONF_TMOV_PAGO_NC_REC,
           V_CONF_CONC_PAGO_NC_REC,
           V_CONF_TMOV_DEVOL_ADEL_CLI,
           V_CONF_CONC_CADCLI,
           V_CONF_TMOV_DEVOL_ADEL_PRO,
           V_CONF_CONC_CADPRO
      FROM FIN_CONFIGURACION
     WHERE CONF_EMPR = I_EMPRESA;




    --APLICAR LOS CONCEPTOS CORRESPONDIENTES
    IF I_DOC_TIPO_MOV = V_CONF_RECIBO_PAGO_EMIT THEN
      V_DCON_CLAVE_CONCEPTO := V_CONF_CONCEPTO_COBRO;

    ELSIF I_DOC_TIPO_MOV = V_CONF_RECIBO_PAGO_REC AND
          NVL(I_IND_PRESTAMO_BANCARIO, 'N') = 'N' THEN
      V_DCON_CLAVE_CONCEPTO := V_CONF_CONCEPTO_PAGO;

    ELSIF I_DOC_TIPO_MOV = V_CONF_RECIBO_PAGO_REC AND
          NVL(I_IND_PRESTAMO_BANCARIO, 'N') = 'S' THEN
      V_DCON_CLAVE_CONCEPTO := 1236;

    ELSIF I_DOC_TIPO_MOV = V_CONF_TMOV_PAGO_NC THEN
      V_DCON_CLAVE_CONCEPTO := V_CONF_CONC_PAGO_NC;

    ELSIF I_DOC_TIPO_MOV = V_CONF_TMOV_PAGO_NC_REC THEN
      V_DCON_CLAVE_CONCEPTO := V_CONF_CONC_PAGO_NC_REC;

    ELSIF I_DOC_TIPO_MOV = V_CONF_TMOV_DEVOL_ADEL_CLI THEN
      V_DCON_CLAVE_CONCEPTO := V_CONF_CONC_CADCLI;

    ELSIF I_DOC_TIPO_MOV = V_CONF_TMOV_DEVOL_ADEL_PRO THEN
      V_DCON_CLAVE_CONCEPTO := V_CONF_CONC_CADPRO;
    END IF;

 --  RAISE_APPLICATION_ERROR(-20002,I_HOLDING);
    --================================================

    ---BUSCAR CTA CONTABLE
    BEGIN
      SELECT FCON_CLAVE_CTACO, FCON_TIPO_SALDO
        INTO V_DCON_CLAVE_CTACO, V_DCON_TIPO_SALDO
        FROM FIN_CONCEPTO
       WHERE FCON_CLAVE = V_DCON_CLAVE_CONCEPTO
         AND FCON_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Error al Buscar la cuenta Contable del concepto!!, tipo_mov:' ||
                                I_DOC_TIPO_MOV);
    END;

    --========================================

    SELECT CONF_COD_EXTRACCION, CONF_COD_DEP, CONF_CONC_TC_INGRESO
      INTO V_CONF_COD_EXTRACCION,
           V_CONF_COD_DEPOSITO,
           V_CONF_CONC_TC_INGRESO
      FROM FIN_CONFIGURACION
     WHERE CONF_EMPR = I_EMPRESA;

    SELECT FCON_CLAVE_CTACO
      INTO V_CONF_CTA_TC_INGRESO
      FROM FIN_CONCEPTO
     WHERE FCON_CLAVE = V_CONF_CONC_TC_INGRESO
       AND FCON_EMPR = I_EMPRESA;

    IF I_EMPRESA = 1 THEN
      BEGIN
        SELECT FCON_CLAVE, FCON_CLAVE_CTACO
          INTO V_CONF_CONC_CH_INGRESO, V_CONF_CTA_CH_INGRESO
          FROM FIN_CONCEPTO
         WHERE FCON_DESC = 'CHEQUES(CR)'
           AND FCON_TIPO_SALDO = 'C'
           AND FCON_EMPR = I_EMPRESA;
      EXCEPTION
        when no_data_found then
          RAISE_APPLICATION_ERROR(-20002,
                                  'Primero debe crear un concepto tipo CREDITO, con la descripcion: "CHEQUES(CR)"');
        when too_many_rows then
          RAISE_APPLICATION_ERROR(-20002,
                                  'No puede existir mas de un concepto tipo CREDITO con la descripci?n: "CHEQUES(CR)"');
      END;

      BEGIN
        SELECT FCON_CLAVE, FCON_CLAVE_CTACO
          INTO V_CONF_CONC_CH_RESP, V_CONF_CTA_CH_RESP
          FROM FIN_CONCEPTO
         WHERE FCON_DESC = 'CHEQUES DIF RESP(DB)'
           AND FCON_TIPO_SALDO = 'D'
           AND FCON_EMPR = I_EMPRESA;

      EXCEPTION
        when no_data_found then
          RAISE_APPLICATION_ERROR(-20002,
                                  'Primero debe crear un concepto tipo CREDITO, con la descripcion: "CHEQUES DIF RESP(DB)"');
        when too_many_rows then
          RAISE_APPLICATION_ERROR(-20002,
                                  'No puede existir mas de un concepto tipo CREDITO con la descripci?n: "CHEQUES DIF RESP(DB)"');
      END;
    END IF;

    IF I_HOLDING IS NOT NULL THEN
      --COBROS POR HOLDING
      PP_HOLDING_RECIBO(I_S_TASA_OFIC          => I_S_TASA_OFIC,
                        I_P_CANT_DECIMALES_LOC => I_P_CANT_DECIMALES_LOC,
                        I_CONF_CONCEPTO_COBRO  => I_CONF_CONCEPTO_COBRO,
                        I_EMPRESA              => I_EMPRESA,
                        I_DOC_CTA_BCO          => I_DOC_CTA_BCO,
                        I_SUCURSAL             => I_SUCURSAL,
                        I_DOC_NRO_DOC          => I_DOC_NRO_DOC,
                        I_DOC_MON              => I_DOC_MON,
                        I_DOC_FEC_OPER         => I_DOC_FEC_OPER,
                        I_DOC_FEC_DOC          => I_DOC_FEC_DOC,
                        I_USUARIO              => I_USUARIO,
                        I_DOC_OPERADOR         => I_DOC_OPERADOR,
                        I_DOC_SERIE            => I_DOC_SERIE,
                        I_S_ACT_IMPRESORA      => I_ACT_IMPRESORA,
                        P_CLAVE_RECIBOS        => P_CLAVE_URL);

    ELSE
      --OTROS MOVIMIENTOS

      --ESTO ES PARA LOS CHEQUES ADELANTADOS
      FOR REG IN (SELECT SEQ_ID,
                         C001   CHEQ_SERIE,
                         C002   CHEQ_NRO,
                         C003   CHEQ_NRO_CTA_CHEQ,
                         C004   TITULAR,
                         D001   CHEQ_FEC_DEPOSITAR,
                         N001   CHEQ_BCO,
                         N002   CHEQ_MON,
                         N003   IMPORTE,
                         N004   TASA,
                         N005   CHEQ_IMPORTE_LOC
                    FROM APEX_COLLECTIONS
                   WHERE COLLECTION_NAME = 'CHEQUES_FINI003') LOOP
        IF REG.CHEQ_NRO IS NOT NULL AND I_DOC_TIPO_MOV NOT IN (6, 33) THEN

          INSERT INTO FIN_CHEQUE
            (CHEQ_CLAVE,
             CHEQ_EMPR,
             CHEQ_SERIE,
             CHEQ_NRO,
             CHEQ_SUC,
             CHEQ_BCO,
             CHEQ_MON,
             CHEQ_CLI,
             CHEQ_CLI_NOM,
             CHEQ_TITULAR,
             CHEQ_FEC_DEPOSITAR,
             CHEQ_IMPORTE,
             CHEQ_FEC_GRAB,
             CHEQ_LOGIN,
             CHEQ_NRO_CTA_CHEQ,
             CHEQ_IMPORTE_LOC,
             CHEQ_FEC_EMIS,
             CHEQ_SITUACION)
          VALUES
            (SEQ_FIN_CHEQUE.NEXTVAL,
             I_EMPRESA,
             REG.CHEQ_SERIE,
             REG.CHEQ_NRO,
             I_SUCURSAL,
             REG.CHEQ_BCO,
             REG.CHEQ_MON,
             I_W_CUENTA,
             I_DOC_CLI_NOM,
             REG.TITULAR,
             REG.CHEQ_FEC_DEPOSITAR,
             REG.IMPORTE,
             SYSDATE,
             I_USUARIO,
             REG.CHEQ_NRO_CTA_CHEQ,
             REG.CHEQ_IMPORTE_LOC,
             I_DOC_FEC_DOC,
             'I');

        END IF;
      END LOOP;
      --

      IF V_DOC_CLAVE IS NULL THEN
        V_DOC_CLAVE := FIN_SEQ_DOC_NEXTVAL;
      END IF;

      INSERT INTO FIN_DOCUMENTO
        (DOC_CLAVE,
         DOC_EMPR,
         DOC_SUC,
         DOC_CTA_BCO,
         DOC_TIPO_SALDO,
         DOC_NRO_DOC,
         DOC_MON,
         DOC_TIPO_MOV,
         DOC_CLI,
         DOC_PROV,
         DOC_FEC_DOC,
         DOC_FEC_OPER,
         DOC_NETO_EXEN_LOC,
         DOC_NETO_EXEN_MON,
         DOC_BRUTO_EXEN_LOC,
         DOC_BRUTO_EXEN_MON,
         DOC_BRUTO_GRAV_LOC,
         DOC_BRUTO_GRAV_MON,
         DOC_NETO_GRAV_LOC,
         DOC_NETO_GRAV_MON,
         DOC_IVA_LOC,
         DOC_IVA_MON,
         DOC_LOGIN,
         DOC_FEC_GRAB,
         DOC_SIST,
         DOC_OPERADOR,
         DOC_CLI_NOM,
         DOC_SISTEMA_AUX,
         DOC_TASA,
         DOC_OBS,
         DOC_SERIE) ---,
      -- DOC_SALDO_PER_ACT_LOC,
      -- DOC_SALDO_PER_ACT_MON)----lv
      VALUES
        (V_DOC_CLAVE,
         I_EMPRESA,
         I_SUCURSAL,
         I_DOC_CTA_BCO,
         I_DOC_TIPO_SALDO,
         I_DOC_NRO_DOC,
         I_DOC_MON,
         I_DOC_TIPO_MOV,
         I_AUX_CLI_CODIGO,
         I_DOC_PROV,
         I_DOC_FEC_DOC,
         I_DOC_FEC_OPER,
         I_DOC_NETO_EXEN_LOC,
         I_DOC_NETO_EXEN_MON,
         I_DOC_NETO_EXEN_LOC,
         I_DOC_NETO_EXEN_MON,
         0,
         0,
         0,
         0,
         0,
         0,
         I_USUARIO,
         SYSDATE,
         SUBSTR(I_PROGRAMA, 1, 3),
         I_DOC_OPERADOR,
         I_DOC_CLI_NOM,
         'FINI003',
         I_S_TASA_OFIC,
         UPPER(I_DOC_OBS),
         I_DOC_SERIE);

      ---RAISE_APPLICATION_ERROR(-20002,V_DCON_CLAVE_CONCEPTO);

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
        (V_DOC_CLAVE,
         1,
         V_DCON_CLAVE_CONCEPTO,
         V_DCON_CLAVE_CTACO,
         V_DCON_TIPO_SALDO,
         I_DOC_NETO_EXEN_LOC,
         I_DOC_NETO_EXEN_MON,
         0,
         0,
         0,
         0,
         I_EMPRESA);


      PP_ACTUALIZAR_PAG(I_USUARIO              => I_USUARIO,
                        I_PROGRAMA             => I_PROGRAMA,
                        I_EMPRESA              => I_EMPRESA,
                        I_DOC_CLAVE            => V_DOC_CLAVE,
                        I_TASA_OFIC            => I_S_TASA_OFIC,
                        I_P_CANT_DECIMALES_LOC => I_P_CANT_DECIMALES_LOC,
                        I_DOC_NETO_EXEN_LOC    => I_DOC_NETO_EXEN_LOC,
                        I_DOC_FEC_DOC          => I_DOC_FEC_DOC);

      -- SI EL TIPO DE SALDO = 'C' IMPLICA QUE SE HACE UN PAGO.
      -- SI :PARAMETER.P_BANCO ES NO NULO IMPLICA QUE EL PAGO SE REALIZO
      -- CON CHEQUE DE ESE BANCO.

      IF I_DOC_TIPO_SALDO = 'C' THEN

        IF I_P_BANCO IS NOT NULL THEN
          IF I_DOC_TIPO_MOV = 19 THEN
            PP_INSERTAR_CH_EMIT(I_EMPRESA          => I_EMPRESA,
                                I_DOC_CLAVE        => V_DOC_CLAVE,
                                I_P_IND_CHEQUE_DIF => I_P_IND_CHEQUE_DIF);

            PP_ACT_CTA_BAN(I_P_PAGO_BANCO  => I_P_PAGO_BANCO,
                           I_EMPRESA       => I_EMPRESA,
                           I_P_CTA_BCO_DIA => I_P_CTA_BCO_DIA,
                           I_DOC_CTA_BCO   => I_DOC_CTA_BCO);
          END IF;
        END IF;
      END IF;

      --  PP_VALIDAR_TOTALES_CHEQTARJ; INCLUIDO EN VALIDACION
      -- PP_VALIDAR_CHEQUE_DUPLICADO;

     
      PP_ACTUALIZAR_TARJ_CHEQ_1(I_EMPRESA                  => I_EMPRESA,
                                I_DOC_MON                  => I_DOC_MON,
                                I_P_CANT_DECIMALES_LOC     => I_P_CANT_DECIMALES_LOC,
                                I_AUX_TASA_DOC             => I_S_TASA_OFIC,
                                I_AUX_CONF_COD_EXTRACCION  => V_CONF_COD_EXTRACCION,
                                I_AUX_NRO_DOC              => I_DOC_NRO_DOC,
                                I_AUX_DOC_MON              => I_DOC_MON,
                                I_DOC_FEC_OPER             => I_DOC_FEC_OPER,
                                I_DOC_FEC_DOC              => I_DOC_FEC_DOC,
                                I_AUX_TIPO_MOV             => I_AUX_TIPO_MOV,
                                I_AUX_CLAVE_DOC            => I_AUX_CLAVE_DOC,
                                I_USUARIO                  => I_USUARIO,
                                I_AUX_CONF_CONC_TC_INGRESO => V_CONF_CONC_TC_INGRESO,
                                I_AUX_CONF_CTA_TC_INGRESO  => V_CONF_CTA_CH_INGRESO,
                                I_SUCURSAL                 => I_SUCURSAL,
                                I_CTA_CHEQ_DIF_RESPALDO    => I_CTA_CHEQ_DIF_RESPALDO,
                                I_CTA_NOT_TRAN_RESPALDO    => I_CTA_NOT_TRAN_RESPALDO, --
                                I_AUX_CONF_CONC_CH_INGRESO => V_CONF_CONC_CH_INGRESO,
                                I_AUX_CONF_CTA_CH_INGRESO  => I_AUX_CONF_CTA_CH_INGRESO,
                                I_DOC_CTA_BCO              => I_DOC_CTA_BCO,
                                I_DOC_CLAVE                => V_DOC_CLAVE,
                                I_AUX_FEC_DOC              => I_DOC_FEC_DOC,
                                I_AUX_CONF_COD_DEPOSITO    => V_CONF_COD_DEPOSITO,
                                I_AUX_CLI_NOM              => I_AUX_CLI_NOM,
                                I_AUX_CLI_CODIGO           => I_AUX_CLI_CODIGO,
                                I_AUX_CONF_CONC_CH_RESP    => V_CONF_CONC_CH_RESP,
                                I_AUX_CONF_CTA_CH_RESP     => V_CONF_CTA_CH_RESP);

      IF I_DOC_TIPO_MOV = 6 AND I_ACT_IMPRESORA = 'S' THEN
        PP_UNLOCK_IMPRESORA(I_EMPRESA     => I_EMPRESA,
                            I_DOC_NRO_DOC => I_DOC_NRO_DOC);
      END IF;

      --ACTUALIZA LOS MOVIMIENTOS 12 Y 13 QUE SE AGREGARON

      IF I_P_PAGO_BANCO = 'S' AND I_EMPRESA NOT BETWEEN 5 AND 17 THEN
        PP_ACTUALIZA_TRANS(I_EMPRESA      => I_EMPRESA,
                           I_SUCURSAL     => I_SUCURSAL,
                           I_TASA_OFIC    => I_S_TASA_OFIC,
                           I_TOTAL_IMP    => I_TOTAL_IMP,
                           I_PROGRAMA     => I_PROGRAMA,
                           I_USUARIO      => I_USUARIO,
                           I_S_MON        => I_DOC_MON,
                           I_DOC_FEC_OPER => I_DOC_FEC_OPER,
                           I_DOC_CTA_BCO  => I_DOC_CTA_BCO);
      END IF;
      --

      IF NVL(I_S_RETEN_MON, 0) > 0 THEN
        
     --  raise_application_error(-20001,'MN');
        PP_ACTUALIZAR_DOC_RETEN(I_W_IND_RETENCION            => I_W_IND_RETENCION,
                                I_NRO_RETENCION              => I_NRO_RETENCION,
                                I_EMPRESA                    => I_EMPRESA,
                                I_W_CUENTA                   => I_W_CUENTA,
                                I_DOC_FEC_DOC                => I_DOC_FEC_DOC,
                                I_DOC_FEC_OPER               => I_DOC_FEC_OPER,
                                I_SUCURSAL                   => I_SUCURSAL,
                                I_TIMBRADO                   => I_TIMBRADO,
                                I_DOC_PROV                   => I_DOC_PROV,
                                I_FEC_INIC_SISTEMA           => I_FEC_INIC_SISTEMA,
                                I_P_FEC_FIN_SISTEMA          => I_FEC_FIN_SISTEMA,
                                I_W_MON_DEC_IMP              => I_W_MON_DEC_IMP,
                                I_DOC_OBS                    => I_DOC_OBS,
                                I_USUARIO                    => I_USUARIO,
                                I_PROGRAMA                   => I_PROGRAMA,
                                I_DOC_OPERADOR               => I_DOC_OPERADOR,
                                I_DOC_CTA_BCO                => I_DOC_CTA_BCO,
                                I_DOC_CLAVE                  => V_DOC_CLAVE,
                                I_CONF_TMOV_RETENCION        => I_CONF_TMOV_RETENCION,
                                I_CONF_CONC_RETEN_CENTRAL    => I_CONF_CONC_RETEN_CENTRAL,
                                I_CONF_CONC_RETEN_ASUNCION   => I_CONF_CONC_RETEN_ASUNCION,
                                I_CONF_CONC_RETEN_CONCEPCION => I_CONF_CONC_RETEN_CONCEPCION,
                                I_CONF_CONC_RETEN_LOMA       => I_CONF_CONC_RETEN_LOMA,
                                I_CONF_CONC_RETEN_SANTAROSA  => I_CONF_CONC_RETEN_SANTAROSA,
                                I_DOC_CLI_NOM                => I_DOC_CLI_NOM,
                                I_P_MON_LOC                  => I_P_MON_LOC,
                                I_DOC_MON                    => I_DOC_MON,
                                I_DOC_TASA                   => I_AUX_TASA_DOC);

      END IF;

      IF NVL(I_S_RETEN_MON, 0) <> 0 THEN
        O_MENSAJE := 'Se han emitido retenciones para exportar al SET-TESAKA!';
      END IF;
      V_CLAVE_IMPRIMIR := V_DOC_CLAVE;
    END IF;

    IF I_DOC_TIPO_MOV = V_CONF_RECIBO_PAGO_EMIT AND
       I_IND_CLI_ADELANTO = 'S' AND I_SUCURSAL = 1 THEN
      PER_COBRO_CUOTAS_EMPL_FAC(V_COD_CLIENTE => I_W_CUENTA,
                                V_EMPRESA     => I_EMPRESA,
                                V_FECHA_DOC   => I_DOC_FEC_DOC,
                                V_IMPORTE     => I_DOC_NETO_EXEN_LOC,
                                V_OBS         => UPPER(I_DOC_OBS ||
                                                       '  Recib. N?  ' ||
                                                       I_DOC_NRO_DOC),
                                V_USER        => I_USUARIO,
                                I_CTA_BCO     => I_DOC_CTA_BCO);

    END IF;
    P_CLAVE_IMP := V_DOC_CLAVE;

    BEGIN
      IF I_W_CUENTA IS NOT NULL THEN
        -- CONCATENAR LOS PARAMETROS PARA LLAMAR EL REPORTE EN JASPER
        V_PARAMETROS := 'P_FORMATO=' || APEX_UTIL.URL_ENCODE('pdf');
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_EMPRESA=' ||
                        (I_EMPRESA);
        V_PARAMETROS := V_PARAMETROS || V_IDENTIFICADOR || 'P_DOC_CLAVE=' ||
                        V_DOC_CLAVE;

        DELETE FROM GEN_PARAMETROS_REPORT
         WHERE USUARIO = gen_devuelve_user();
        commit;
        INSERT INTO GEN_PARAMETROS_REPORT
          (PARAMETROS, USUARIO, NOMBRE_REPORTE, FORMATO_SALIDA)
        VALUES
          (V_PARAMETROS, I_USUARIO, V_REPORTE, 'pdf');

      END IF;

      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
   --

  EXCEPTION
    WHEN IMPRESORANOREGISTRADA THEN
      O_MENSAJE := 'No se puede encontrar la siguiente impresora:';
    WHEN SALIR THEN
      NULL;
  END PP_ACTUALIZAR_REGISTRO;

  PROCEDURE PP_GUARDAR(I_DOC_TIPO_SALDO             IN VARCHAR2,
                       I_P_BANCO                    IN NUMBER,
                       I_DOC_CTA_BCO                IN NUMBER,
                       I_EMPRESA                    IN NUMBER,
                       I_USUARIO                    IN VARCHAR2,
                       I_P_CTA_DESC                 IN VARCHAR2,
                       I_HOLDING                    IN NUMBER,
                       I_S_TASA_OFIC                IN NUMBER,
                       I_P_CANT_DECIMALES_LOC       IN NUMBER,
                       I_CONF_CONCEPTO_COBRO        IN NUMBER,
                       I_SUCURSAL                   IN NUMBER,
                       I_DOC_NRO_DOC                IN NUMBER,
                       I_DOC_MON                    IN NUMBER,
                       I_DOC_FEC_OPER               IN DATE,
                       I_DOC_FEC_DOC                IN DATE,
                       I_DOC_OPERADOR               IN NUMBER,
                       I_DOC_SERIE                  IN VARCHAR2,
                       I_W_CUENTA                   IN NUMBER,
                       I_DOC_CLI_NOM                IN VARCHAR2,
                       I_P_IND_CHEQUE_DIF           IN VARCHAR2,
                       I_P_PAGO_BANCO               IN VARCHAR2,
                       I_P_CTA_BCO_DIA              IN NUMBER,
                       I_AUX_TASA_DOC               IN NUMBER,
                       I_AUX_CONF_COD_EXTRACCION    IN NUMBER,
                       I_AUX_NRO_DOC                IN NUMBER,
                       I_AUX_DOC_MON                IN NUMBER,
                       I_AUX_TIPO_MOV               IN NUMBER,
                       I_AUX_CLAVE_DOC              IN NUMBER,
                       I_AUX_CONF_CONC_TC_INGRESO   IN NUMBER,
                       I_AUX_CONF_CTA_TC_INGRESO    IN NUMBER,
                       I_CTA_CHEQ_DIF_RESPALDO      IN NUMBER,
                       I_TOTAL_IMP                  IN NUMBER,
                       I_PROGRAMA                   IN VARCHAR2,
                       I_DOC_NETO_EXEN_LOC          IN NUMBER,
                       I_DOC_NETO_EXEN_MON          IN NUMBER,
                       I_DOC_TIPO_MOV               IN NUMBER,
                       I_S_RETEN_MON                IN NUMBER,
                       I_ACT_IMPRESORA              IN VARCHAR2,
                       I_W_IND_RETENCION            IN VARCHAR2,
                       I_NRO_RETENCION              IN NUMBER,
                       I_S_ACT_IMPRESORA            IN VARCHAR2,
                       I_CTA_NOT_TRAN_RESPALDO      IN NUMBER,
                       I_AUX_CONF_CONC_CH_INGRESO   IN NUMBER,
                       I_AUX_CONF_CTA_CH_INGRESO    IN NUMBER,
                       I_AUX_FEC_DOC                IN DATE,
                       I_AUX_CONF_COD_DEPOSITO      IN NUMBER,
                       I_AUX_CLI_NOM                IN VARCHAR2,
                       I_AUX_CLI_CODIGO             IN NUMBER,
                       I_AUX_CONF_CONC_CH_RESP      IN NUMBER,
                       I_AUX_CONF_CTA_CH_RESP       IN NUMBER,
                       I_TIMBRADO                   IN NUMBER,
                       I_DOC_PROV                   IN NUMBER,
                       I_FEC_INIC_SISTEMA           IN DATE,
                       I_FEC_FIN_SISTEMA            IN DATE,
                       I_W_MON_DEC_IMP              IN NUMBER,
                       I_DOC_OBS                    IN VARCHAR2,
                       I_CONF_TMOV_RETENCION        IN NUMBER,
                       I_CONF_CONC_RETEN_CENTRAL    IN NUMBER,
                       I_CONF_CONC_RETEN_ASUNCION   IN NUMBER,
                       I_CONF_CONC_RETEN_CONCEPCION IN NUMBER,
                       I_CONF_CONC_RETEN_LOMA       IN NUMBER,
                       I_CONF_CONC_RETEN_SANTAROSA  IN NUMBER,
                       I_P_MON_LOC                  IN NUMBER,
                       I_DOC_CLAVE                  IN NUMBER,
                       O_MENSAJE                    OUT VARCHAR2,
                       I_IND_PRESTAMO               IN VARCHAR2,
                       I_IND_CLI_ADELANTO           IN VARCHAR2,
                       P_CLAVE_URL                  OUT VARCHAR2,
                       P_CLAVE_IMP                  OUT NUMBER) IS
  BEGIN



    FACI039.PL_VALIDAR_OPCTA(P_CTA       => I_DOC_CTA_BCO,
                             P_EMPRESA   => I_EMPRESA,
                             P_LOGIN     => I_USUARIO,
                             P_CTA_DESC  => I_P_CTA_DESC,
                             P_OPERACION => I_DOC_TIPO_SALDO,
                             P_PROGRAMA  => 'FIN003');

    PP_ACTUALIZAR_REGISTRO(I_HOLDING                    => I_HOLDING,
                           I_S_TASA_OFIC                => I_S_TASA_OFIC,
                           I_P_CANT_DECIMALES_LOC       => I_P_CANT_DECIMALES_LOC,
                           I_CONF_CONCEPTO_COBRO        => I_CONF_CONCEPTO_COBRO,
                           I_EMPRESA                    => I_EMPRESA,
                           I_DOC_CTA_BCO                => I_DOC_CTA_BCO,
                           I_SUCURSAL                   => I_SUCURSAL,
                           I_DOC_NRO_DOC                => I_DOC_NRO_DOC,
                           I_DOC_MON                    => I_DOC_MON,
                           I_DOC_FEC_OPER               => I_DOC_FEC_OPER,
                           I_DOC_FEC_DOC                => I_DOC_FEC_DOC,
                           I_USUARIO                    => I_USUARIO,
                           I_DOC_OPERADOR               => I_DOC_OPERADOR,
                           I_DOC_SERIE                  => I_DOC_SERIE,
                           I_W_CUENTA                   => I_W_CUENTA,
                           I_DOC_CLI_NOM                => I_DOC_CLI_NOM,
                           I_P_IND_CHEQUE_DIF           => I_P_IND_CHEQUE_DIF,
                           I_P_PAGO_BANCO               => I_P_PAGO_BANCO,
                           I_P_CTA_BCO_DIA              => I_P_CTA_BCO_DIA,
                           I_AUX_TASA_DOC               => I_AUX_TASA_DOC,
                           I_AUX_CONF_COD_EXTRACCION    => I_AUX_CONF_COD_EXTRACCION,
                           I_AUX_NRO_DOC                => I_AUX_NRO_DOC,
                           I_AUX_DOC_MON                => I_AUX_DOC_MON,
                           I_AUX_TIPO_MOV               => I_AUX_TIPO_MOV,
                           I_AUX_CLAVE_DOC              => I_AUX_CLAVE_DOC,
                           I_AUX_CONF_CONC_TC_INGRESO   => I_AUX_CONF_CONC_TC_INGRESO,
                           I_AUX_CONF_CTA_TC_INGRESO    => I_AUX_CONF_CTA_TC_INGRESO,
                           I_CTA_CHEQ_DIF_RESPALDO      => I_CTA_CHEQ_DIF_RESPALDO,
                           I_TOTAL_IMP                  => I_TOTAL_IMP,
                           I_PROGRAMA                   => I_PROGRAMA,
                           I_DOC_NETO_EXEN_LOC          => I_DOC_NETO_EXEN_LOC,
                           I_DOC_NETO_EXEN_MON          => I_DOC_NETO_EXEN_MON,
                           I_DOC_TIPO_SALDO             => I_DOC_TIPO_SALDO,
                           I_DOC_TIPO_MOV               => I_DOC_TIPO_MOV,
                           I_S_RETEN_MON                => I_S_RETEN_MON,
                           I_ACT_IMPRESORA              => I_ACT_IMPRESORA,
                           I_W_IND_RETENCION            => I_W_IND_RETENCION,
                           I_P_BANCO                    => I_P_BANCO,
                           I_NRO_RETENCION              => I_NRO_RETENCION,
                           I_CTA_NOT_TRAN_RESPALDO      => I_CTA_NOT_TRAN_RESPALDO,
                           I_AUX_CONF_CONC_CH_INGRESO   => I_AUX_CONF_CONC_CH_INGRESO,
                           I_AUX_CONF_CTA_CH_INGRESO    => I_AUX_CONF_CTA_CH_INGRESO,
                           I_AUX_FEC_DOC                => I_AUX_FEC_DOC,
                           I_AUX_CONF_COD_DEPOSITO      => I_AUX_CONF_COD_DEPOSITO,
                           I_AUX_CLI_NOM                => I_AUX_CLI_NOM,
                           I_AUX_CLI_CODIGO             => I_AUX_CLI_CODIGO,
                           I_AUX_CONF_CONC_CH_RESP      => I_AUX_CONF_CONC_CH_RESP,
                           I_AUX_CONF_CTA_CH_RESP       => I_AUX_CONF_CTA_CH_RESP,
                           I_TIMBRADO                   => I_TIMBRADO,
                           I_DOC_PROV                   => I_DOC_PROV,
                           I_FEC_INIC_SISTEMA           => I_FEC_INIC_SISTEMA,
                           I_FEC_FIN_SISTEMA            => I_FEC_FIN_SISTEMA,
                           I_W_MON_DEC_IMP              => I_W_MON_DEC_IMP,
                           I_DOC_OBS                    => I_DOC_OBS,
                           I_CONF_TMOV_RETENCION        => I_CONF_TMOV_RETENCION,
                           I_CONF_CONC_RETEN_CENTRAL    => I_CONF_CONC_RETEN_CENTRAL,
                           I_CONF_CONC_RETEN_ASUNCION   => I_CONF_CONC_RETEN_ASUNCION,
                           I_CONF_CONC_RETEN_CONCEPCION => I_CONF_CONC_RETEN_CONCEPCION,
                           I_CONF_CONC_RETEN_LOMA       => I_CONF_CONC_RETEN_LOMA,
                           I_CONF_CONC_RETEN_SANTAROSA  => I_CONF_CONC_RETEN_SANTAROSA,
                           I_P_MON_LOC                  => I_P_MON_LOC,
                           I_DOC_CLAVE                  => I_DOC_CLAVE,
                           O_MENSAJE                    => O_MENSAJE,
                           I_IND_CLI_ADELANTO           => I_IND_CLI_ADELANTO,
                           P_CLAVE_URL                  => P_CLAVE_URL,
                           P_CLAVE_IMP                  => P_CLAVE_IMP);

  END PP_GUARDAR;

  PROCEDURE PP_VALIDAR_TOTALES_CHEQTARJ(I_AUX_IMP_LOC IN NUMBER) IS
    V_TOTAL       NUMBER;
    V_SUM_TJ      NUMBER;
    V_SUM_CHEQUES NUMBER;
  BEGIN
    SELECT SUM(N002)
      INTO V_SUM_TJ
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'TARJETA_FINI003';

    SELECT SUM(N005)
      INTO V_SUM_CHEQUES
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'CHEQUES_FINI003';
    --TOTAL DE TARJETAS + TOTAL DE CHEQUES NO PUEDEN SER MAYORES AL TOTAL EN MONEDA LOCAL
    --DEL DOCUMENTO
    V_TOTAL := NVL(V_SUM_TJ, 0) + NVL(V_SUM_CHEQUES, 0);
    IF (NVL(V_SUM_TJ, 0) + NVL(V_SUM_CHEQUES, 0)) > I_AUX_IMP_LOC THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'La suma del total de tarjeras + el total de cheques es mayor que el importe de pago.',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
    END IF;

  END PP_VALIDAR_TOTALES_CHEQTARJ;

  PROCEDURE PP_VALIDAR_CHEQUE_DUPLICADO IS
    VREGISTRO NUMBER;
    VBANCO    NUMBER;
    VSERIE    VARCHAR2(2);
    VNUMERO   NUMBER;
  BEGIN
    FOR REG IN (SELECT SEQ_ID,
                       C001   CHEQ_SERIE,
                       C002   CHEQ_NRO,
                       C003   CHEQ_NRO_CTA_CHEQ,
                       C004   TITULAR,
                       D001   CHEQ_FEC_DEPOSITAR,
                       N001   CHEQ_BCO,
                       N002   CHEQ_MON,
                       N003   IMPORTE,
                       N004   TASA,
                       N005   CHEQ_IMPORTE_LOC
                  FROM APEX_COLLECTIONS
                 WHERE COLLECTION_NAME = 'CHEQUES_FINI003') LOOP
      VREGISTRO := REG.SEQ_ID;
      VBANCO    := REG.CHEQ_BCO;
      VSERIE    := REG.CHEQ_SERIE;
      VNUMERO   := REG.CHEQ_NRO;
      FOR REG IN (SELECT SEQ_ID,
                         C001   CHEQ_SERIE,
                         C002   CHEQ_NRO,
                         C003   CHEQ_NRO_CTA_CHEQ,
                         C004   TITULAR,
                         D001   CHEQ_FEC_DEPOSITAR,
                         N001   CHEQ_BCO,
                         N002   CHEQ_MON,
                         N003   IMPORTE,
                         N004   TASA,
                         N005   CHEQ_IMPORTE_LOC
                    FROM APEX_COLLECTIONS
                   WHERE COLLECTION_NAME = 'CHEQUES_FINI003') LOOP
        IF REG.SEQ_ID <> VREGISTRO THEN
          IF VBANCO = REG.CHEQ_BCO AND VSERIE = REG.CHEQ_SERIE AND
             VNUMERO = REG.CHEQ_NRO THEN
            APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Cheque duplicado!',
                                 P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          END IF;
        END IF;
      END LOOP;
    END LOOP;

  END PP_VALIDAR_CHEQUE_DUPLICADO;

  PROCEDURE PP_VALIDAR(I_DOC_TIPO_SALDO    IN VARCHAR2,
                       I_P_BANCO           IN NUMBER,
                       I_AUX_IMP_LOC       IN NUMBER,
                       I_CUO_SUM_PAGO      IN NUMBER,
                       I_S_RETEN_MON       IN NUMBER,
                       I_DOC_NETO_EXEN_MON IN NUMBER,
                       I_DOC_TIPO_MOV      IN NUMBER,
                       I_EMPRESA           IN NUMBER) IS
    V_SUM_CHEQ_AUT  NUMBER;
    V_NUM_REGISTROS NUMBER;
    V_SUM_PAGO      NUMBER;
  BEGIN

    SELECT COUNT(1)
      INTO V_NUM_REGISTROS
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'DETALLE_FINI003'
       AND C010 < 0;

    FOR C IN (SELECT SEQ_ID,
                     C001   DOC_NRO_DOC,
                     D001   DOC_FEC_DOC,
                     D002   CUO_FEC_VTO,
                     C002   DOC_OBS,
                     N001   CUO_IMP_MON,
                     N002   CUO_SALDO_MON,
                     C010   S_IMP_PAGO,
                     C003   CUO_CLAVE_DOC,
                     N003   DOC_CLI,
                     N004   DOC_CLI_RUC
                FROM APEX_COLLECTIONS
               WHERE COLLECTION_NAME = 'DETALLE_FINI003'
               AND NVL(C010,0) <> 0) LOOP

      IF C.S_IMP_PAGO < 0 THEN

        APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'Los pagos no pueden quedar en negativo',
                             P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
        RAISE_APPLICATION_ERROR(-20010,
                                'Los pagos no pueden quedar en negativo');
      END IF;

      DECLARE
        V_EXIST NUMBER;
      BEGIN
        SELECT T.FOP_NRO
          INTO V_EXIST
          FROM FIN_ORDEN_PAGO_DET T
         WHERE FOP_CLAVE_DOC = C.CUO_CLAVE_DOC
           AND T.FOP_FEC_VTO = C.CUO_FEC_VTO
           AND T.FOP_EMPR = I_EMPRESA;

        RAISE_APPLICATION_ERROR(-20010,
                                'La factura nro.' || C.DOC_NRO_DOC ||
                                ' ya esta agendada en la orden ' || V_EXIST ||
                                ' Comuniquese con el encargado de pagos');
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20010,
                                  'La factura ya esta agendada en una orden, comuniquese con el encargado de pagos.');
      END VALIDAR_ORDEN_PAGO;
    END LOOP;

    SELECT SUM(C010) S_IMP_PAGO
      INTO V_SUM_PAGO
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'DETALLE_FINI003';

    IF V_SUM_PAGO != I_DOC_NETO_EXEN_MON THEN
      APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'La sumatoria de los pagos debe ser igual al monto del documento!.',
                           P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);

    END IF;

    IF I_DOC_TIPO_SALDO = 'C' THEN

      IF I_P_BANCO IS NOT NULL THEN
        IF I_DOC_TIPO_MOV = 19 THEN

          SELECT SUM(N002) IMPORTE
            INTO V_SUM_CHEQ_AUT
            FROM APEX_COLLECTIONS
           WHERE COLLECTION_NAME = 'CHEQUE_AUT_FINI003';

          IF NVL(V_SUM_CHEQ_AUT, 0) <>
             (I_CUO_SUM_PAGO - NVL(I_S_RETEN_MON, 0)) THEN
            APEX_ERROR.ADD_ERROR(P_MESSAGE          => 'La sumatoria de los cheques debe ser igual al monto del documento!.fff' ||
                                                       I_P_BANCO,
                                 P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION);
          END IF;
        END IF;
      END IF;
    END IF;

    PP_VALIDAR_TOTALES_CHEQTARJ(I_AUX_IMP_LOC => I_AUX_IMP_LOC);
    PP_VALIDAR_CHEQUE_DUPLICADO;

  END PP_VALIDAR;

  PROCEDURE PP_FORMA_PAGO(TIPOMOV  IN NUMBER,
                          NRODOC   IN NUMBER,
                          FECDOC   IN DATE,
                          CTABCO   IN NUMBER,
                          MONEDA   IN NUMBER,
                          CLAVEDOC IN NUMBER,
                          --IMPMON  IN NUMBER, IMPLOC   IN NUMBER,
                          CLIENTE                     IN NUMBER,
                          CLINOM                      IN VARCHAR2,
                          TASA                        IN NUMBER,
                          I_EMPRESA                   IN NUMBER,
                          I_S_TASA_OFIC               IN NUMBER,
                          I_P_MON_LOC                 IN NUMBER,
                          I_DOC_NETO_EXEN_MON         IN NUMBER,
                          I_DOC_NETO_GRAV_MON         IN NUMBER,
                          I_DOC_IVA_MON               IN NUMBER,
                          I_DOC_NETO_EXEN_LOC         IN NUMBER,
                          I_DOC_NETO_GRAV_LOC         IN NUMBER,
                          I_DOC_IVA_LOC               IN NUMBER,
                          O_BAUX_TIPO_MOV             OUT NUMBER,
                          O_BAUX_NRO_DOC              OUT NUMBER,
                          O_BAUX_FEC_DOC              OUT DATE,
                          O_BAUX_CTA_BCO              OUT NUMBER,
                          O_BAUX_DOC_MON              OUT NUMBER,
                          O_BAUX_IMP_MON              OUT NUMBER,
                          O_BAUX_IMP_LOC              OUT NUMBER,
                          O_BAUX_CLI_CODIGO           OUT NUMBER,
                          O_BAUX_CLI_NOM              OUT VARCHAR2,
                          O_BAUX_CLAVE_DOC            OUT NUMBER,
                          O_BAUX_TASA_DOC             OUT NUMBER,
                          O_BAUX_CONF_COD_EXTRACCION  OUT FIN_CONFIGURACION.CONF_COD_EXTRACCION%TYPE,
                          O_BAUX_CONF_COD_DEPOSITO    OUT FIN_CONFIGURACION.CONF_COD_DEP%TYPE,
                          O_BAUX_CONF_CONC_TC_INGRESO OUT FIN_CONFIGURACION.CONF_CONC_TC_INGRESO%TYPE,
                          O_BAUX_CONF_CTA_TC_INGRESO  OUT FIN_CONCEPTO.FCON_CLAVE_CTACO%TYPE,
                          O_BAUX_CONF_CONC_CH_INGRESO OUT FIN_CONCEPTO.FCON_CLAVE%TYPE,
                          O_BAUX_CONF_CTA_CH_INGRESO  OUT FIN_CONCEPTO.FCON_CLAVE_CTACO%TYPE,
                          O_BAUX_CONF_CONC_CH_RESP    OUT FIN_CONCEPTO.FCON_CLAVE%TYPE,
                          O_BAUX_CONF_CTA_CH_RESP     OUT FIN_CONCEPTO.FCON_CLAVE_CTACO%TYPE) IS
    IMPMON NUMBER; --IMPORTE EN MONEDA DEL DOCUMENTO
    IMPLOC NUMBER; --IMPORTE EN MONEDA LOCAL
  BEGIN
    IMPMON := NVL(I_DOC_NETO_EXEN_MON, 0) + NVL(I_DOC_NETO_GRAV_MON, 0) +
              NVL(I_DOC_IVA_MON, 0);
    IMPLOC := NVL(I_DOC_NETO_EXEN_LOC, 0) + NVL(I_DOC_NETO_GRAV_LOC, 0) +
              NVL(I_DOC_IVA_LOC, 0);

    IF MONEDA = I_P_MON_LOC THEN
      IMPLOC := I_DOC_NETO_EXEN_LOC;
      IMPMON := I_DOC_NETO_EXEN_MON;
    ELSE
      IMPLOC := I_DOC_NETO_EXEN_LOC * I_S_TASA_OFIC;
      IMPMON := I_DOC_NETO_EXEN_MON;

    END IF;
    --
    O_BAUX_TIPO_MOV   := TIPOMOV;
    O_BAUX_NRO_DOC    := NRODOC;
    O_BAUX_FEC_DOC    := FECDOC;
    O_BAUX_CTA_BCO    := CTABCO;
    O_BAUX_DOC_MON    := MONEDA;
    O_BAUX_IMP_MON    := IMPMON;
    O_BAUX_IMP_LOC    := IMPLOC;
    O_BAUX_CLI_CODIGO := CLIENTE;
    O_BAUX_CLI_NOM    := CLINOM;
    O_BAUX_CLAVE_DOC  := CLAVEDOC;
    O_BAUX_TASA_DOC   := TASA; /*ESTE CAMPO ES OPCIO    NAL. ES PARA QUE EL DOCUMENTO DE
                                                                                                                                                                                                                                                                           EXTRACCION SEA HIJO DEL DOCUMENTO DE PAGO*/
    SELECT CONF_COD_EXTRACCION, CONF_COD_DEP, CONF_CONC_TC_INGRESO
      INTO O_BAUX_CONF_COD_EXTRACCION,
           O_BAUX_CONF_COD_DEPOSITO,
           O_BAUX_CONF_CONC_TC_INGRESO
      FROM FIN_CONFIGURACION
     WHERE CONF_EMPR = I_EMPRESA;

    IF O_BAUX_CONF_COD_EXTRACCION IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Falta configurar el tipo de mov. de extraccion bancaria!');
    END IF;

    IF O_BAUX_CONF_CONC_TC_INGRESO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'Falta configurar el concepto de ingreso de tarjetas de credito!');
    END IF;

    --SELECCIONAR LA CUENTA CONTABLE DEL CONCEPTO DE TARJETA DE CREDITO "Ingreso"
    BEGIN
      SELECT FCON_CLAVE_CTACO
        INTO O_BAUX_CONF_CTA_TC_INGRESO
        FROM FIN_CONCEPTO
       WHERE FCON_CLAVE = O_BAUX_CONF_CONC_TC_INGRESO
         AND FCON_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'No existe el concepto: ' ||
                                O_BAUX_CONF_CONC_TC_INGRESO ||
                                ' o falta asignarle la cuenta contable de tarjetas de credito a cobrar!');
    END;

    --BUSCAR CONCEPTO PARA CHEQUES A DEPOSITAR
    BEGIN
      SELECT FCON_CLAVE, FCON_CLAVE_CTACO
        INTO O_BAUX_CONF_CONC_CH_INGRESO, O_BAUX_CONF_CTA_CH_INGRESO
        FROM FIN_CONCEPTO
       WHERE FCON_DESC = 'CHEQUES(CR)'
         AND FCON_TIPO_SALDO = 'C'
         AND FCON_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Primero debe crear un concepto tipo CREDITO, con la descripcion: "CHEQUES(CR)"');
      WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'No puede existir mas de un concepto tipo CREDITO con la descripcion: "CHEQUES(CR)"');
    END;
    --
    IF O_BAUX_CONF_CTA_CH_INGRESO IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'No existe el concepto: ' ||
                              O_BAUX_CONF_CONC_CH_INGRESO ||
                              ' o falta asignarle la cuenta contable de cheques a depositar!');
    END IF;
    --
    --BUSCAR CONCEPTO PARA CHEQUES A DEPOSITAR
    BEGIN
      SELECT FCON_CLAVE, FCON_CLAVE_CTACO
        INTO O_BAUX_CONF_CONC_CH_RESP, O_BAUX_CONF_CTA_CH_RESP
        FROM FIN_CONCEPTO
       WHERE FCON_DESC = 'CHEQUES DIF RESP(DB)'
         AND FCON_TIPO_SALDO = 'D'
         AND FCON_EMPR = I_EMPRESA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Primero debe crear un concepto tipo CREDITO, con la descripcion: "CHEQUES DIF RESP(DB)"');
      WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'No puede existir mas de un concepto tipo CREDITO con la descripcion: "CHEQUES DIF RESP(DB)"');
    END;
    --
    IF O_BAUX_CONF_CTA_CH_RESP IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002,
                              'No existe el concepto: ' ||
                              O_BAUX_CONF_CONC_CH_RESP ||
                              ' o falta asignarle la cuenta contable de cheques a depositar!');
    END IF;
  END PP_FORMA_PAGO;

  PROCEDURE PP_BUSCAR_NRO_FACTURA(I_EMPRESA     IN NUMBER,
                                  O_DOC_NRO_DOC OUT NUMBER) IS

  BEGIN

    SELECT NVL(IMP_ULT_REC_PAGO_EMIT, 0) + 1
      INTO O_DOC_NRO_DOC
      FROM GEN_IMPRESORA
     WHERE IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR') --IMP_CODIGO = :PARAMETER.P_IMPRESORA
       AND IMP_EMPR = I_EMPRESA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002, 'Primero debe registrar su IP');
  END PP_BUSCAR_NRO_FACTURA;

  PROCEDURE PP_TERMINAR_PROCESO IS
  BEGIN

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_FINI003') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_FINI003');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'TARJETA_FINI003') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'TARJETA_FINI003');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUE_AUT_FINI003') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'CHEQUE_AUT_FINI003');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'CHEQUES_FINI003') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'CHEQUES_FINI003');
    END IF;
    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003');
    END IF;

  END PP_TERMINAR_PROCESO;

  PROCEDURE PP_CTRL_DOC_ANUL(P_TIPO_MOV  IN NUMBER,
                             P_NRO_DOC   IN NUMBER,
                             P_EMPRESA   IN NUMBER,
                             O_CONFIRMAR OUT VARCHAR2) IS
  BEGIN
    IF FIN_CTRL_NUM_ANUL(P_TIPO_MOV, P_NRO_DOC, P_EMPRESA) = P_NRO_DOC THEN
      O_CONFIRMAR := 'El Nro de documento ha sido utilizada y anulada. Desea reutilizar la misma numeracion?';
      /*        IF FP_CONFIRMAR_SI_NO('El Nro de documento ha sido utilizada y anulada. Desea reutilizar la misma numeracion?') = 'NO'  THEN
            RAISE_APPLICATION_ERROR(-20002,'Ingrese manualmente el proximo Nro a utilizar!');
      END IF;*/
    END IF;

  END PP_CTRL_DOC_ANUL;

  PROCEDURE PP_VERIFICAR_COMPROB(I_DOC_TIPO_MOV         IN NUMBER,
                                 I_CONF_RECIBO_PAGO_REC IN NUMBER,
                                 I_P_PROX_CH            IN NUMBER,
                                 I_P_CHEQUE_MENOR       IN NUMBER,
                                 I_P_CHEQUE_MAYOR       IN NUMBER,
                                 P_EMPRESA              IN NUMBER,
                                 IO_DOC_NRO_DOC         IN OUT NUMBER,
                                 O_CONFIRMAR            OUT VARCHAR2) IS
  BEGIN

    IF IO_DOC_NRO_DOC IS NULL THEN
      IF I_DOC_TIPO_MOV = I_CONF_RECIBO_PAGO_REC THEN
        --PARA SUGERIR COMO NUMERO DE DOCUMENTO EL PROX NRO DE CHEQUE
        IF NOT (I_P_PROX_CH + 1) BETWEEN I_P_CHEQUE_MENOR AND
           I_P_CHEQUE_MAYOR THEN
          RAISE_APPLICATION_ERROR(-20002,
                                  'Para asignar como numero de documento el numero del proximo cheque:' ||
                                  TO_CHAR(I_P_PROX_CH + 1) ||
                                  ', este debe estar en el rango definido en FINM006. Cheque Menor = ' ||
                                  I_P_CHEQUE_MENOR || ' y Cheque Mayor = ' ||
                                  I_P_CHEQUE_MAYOR);
        END IF;
        IO_DOC_NRO_DOC := I_P_PROX_CH + 1;
      ELSE
        RAISE_APPLICATION_ERROR(-20002, 'No puede ser nulo!');
      END IF;
    END IF;
    PP_CTRL_DOC_ANUL(P_TIPO_MOV  => I_DOC_TIPO_MOV,
                     P_NRO_DOC   => IO_DOC_NRO_DOC,
                     P_EMPRESA   => P_EMPRESA,
                     O_CONFIRMAR => O_CONFIRMAR);

    IF I_DOC_TIPO_MOV = 6 AND IO_DOC_NRO_DOC IS NULL THEN
      PP_BUSCAR_NRO_FACTURA(I_EMPRESA     => P_EMPRESA,
                            O_DOC_NRO_DOC => IO_DOC_NRO_DOC);
    END IF;

  END PP_VERIFICAR_COMPROB;

  PROCEDURE PP_BUSCAR_NRO_RETENCION(P_EMPRESA         IN NUMBER,
                                    O_S_NRO_RETENCION OUT NUMBER) IS
  BEGIN
    SELECT NVL(IMP_ULT_RETENCION, 0) + 1
      INTO O_S_NRO_RETENCION
      FROM GEN_IMPRESORA
     WHERE IMPR_IP = OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR') --IMP_CODIGO = :PARAMETER.P_IMPRESORA
       AND IMP_EMPR = P_EMPRESA;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      O_S_NRO_RETENCION := 1;
  END PP_BUSCAR_NRO_RETENCION;

  PROCEDURE PP_VERIFICAR_MONTO_PAGO(P_EMPRESA     IN NUMBER,
                                    P_PROVEEDOR   NUMBER,
                                    P_MONEDA      NUMBER,
                                    O_S_RETEN_MON OUT NUMBER,
                                    O_S_PAGO      OUT NUMBER) IS
    V_TOTAL_PAGO NUMBER := 0;
    --V_CONT                NUMBER := 1;
    --V_REG                 NUMBER;
    --V_CLAVE_ANT           NUMBER;
    V_MONTO_RETENCION NUMBER := 0;
    --V_TRANS_SIN_IVA       NUMBER := 0;
    --V_TOTAL_IVA           NUMBER := 0;
    V_NCR_EXEN_LOC        NUMBER := 0;
    V_NCR_EXEN_MON        NUMBER := 0;
    V_NCR_GRAV_MON        NUMBER := 0;
    V_NCR_GRAV_LOC        NUMBER := 0;
    V_NCR_IVA_MON         NUMBER := 0;
    V_NCR_IVA_LOC         NUMBER := 0;
    V_TOTA_AUX            NUMBER := 0;
    V_SUM_GRAB_ACUMULADO  NUMBER := 0;
    V_TOTAL_RETENCION_MON NUMBER := 0;
    V_TOTAL_RETENCION_LOC NUMBER := 0;
    V_CLAVE_RETENCION     NUMBER := 0;
    --V_IMPORTE_MON         NUMBER := 0;
    --V_IMPORTE_LOC         NUMBER := 0;
    V_ACUM_IMP_PAGO NUMBER := 0;

    V_RET_DOC_NETO_GRAV_MON   NUMBER := 0;
    V_RET_DOC_IVA_MON         NUMBER := 0;
    V_RET_DOC_NETO_GRAV_LOC   NUMBER := 0;
    V_RET_DOC_IVA_LOC         NUMBER := 0;
    V_RET_DOC_NETO_EXEN_MON   NUMBER := 0;
    V_RET_DOC_NETO_EXEN_LOC   NUMBER := 0;
    V_RET_DOC_CLAVE_RETENCION NUMBER := 0;
    V_RET_DOC_NRO_DOC         NUMBER := 0;
    V_IND_PROV_RETENCION      VARCHAR2(1);
    V_MON_CANT_DEC            NUMBER;
    CURSOR DETALLE_PAG IS
      SELECT SEQ_ID,
             C001   DOC_NRO_DOC,
             D001   DOC_FEC_DOC,
             D002   CUO_FEC_VTO,
             C002   DOC_OBS,
             N001   CUO_IMP_MON,
             N002   CUO_SALDO_MON,
             C003   CUO_CLAVE_DOC,
             C004   CUO_NRO_PAGARE,
             C005   DOC_CANT_PAGARE,
             C006   DOC_CLAVE_RETENCION,
             N003   GRAVADO,
             N004   GRAVADO_LOC,
             N005   EXENTO,
             C007   EXENTO_LOC,
             C008   IVA,
             C009   IVA_LOC,
             C010   S_IMP_PAGO
        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'DETALLE_FINI003'
         AND NVL(C010, 0) > 0
         ;

    CURSOR DETALLE_PAG_DET(MES_FACTURA VARCHAR2, CLAVE_ACTUAL IN NUMBER) IS
      SELECT SEQ_ID,
             C001   DOC_NRO_DOC,
             D001   DOC_FEC_DOC,
             D002   CUO_FEC_VTO,
             C002   DOC_OBS,
             N001   CUO_IMP_MON,
             N002   CUO_SALDO_MON,
             C003   CUO_CLAVE_DOC,
             C004   CUO_NRO_PAGARE,
             C005   DOC_CANT_PAGARE,
             C006   DOC_CLAVE_RETENCION,
             N003   GRAVADO,
             N004   GRAVADO_LOC,
             N005   EXENTO,
             C007   EXENTO_LOC,
             C008   IVA,
             C009   IVA_LOC,
             C010   S_IMP_PAGO
        FROM APEX_COLLECTIONS
       WHERE COLLECTION_NAME = 'DETALLE_FINI003'
         AND NVL(C010, 0) > 0
         AND (TO_CHAR(D001, 'MM/YYYY') = MES_FACTURA AND
             C003 NOT IN (CLAVE_ACTUAL));

  BEGIN

       -- raise_application_error(-20001,'S');
    BEGIN
      SELECT MON_DEC_IMP
        INTO V_MON_CANT_DEC
        FROM GEN_MONEDA
       WHERE MON_CODIGO = P_MONEDA
         AND MON_EMPR = P_EMPRESA;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'Falta agregar la cant. de decimales de la moneda!');
    END;

    BEGIN
      SELECT NVL(P.PROV_IND_RETENCION, 'S') /*REVISAR SI AL PROVEEDOR SE LE PUEDE RETENER SU IVA */
        INTO V_IND_PROV_RETENCION
        FROM FIN_PROVEEDOR P
       WHERE P.PROV_EMPR = P_EMPRESA
         AND P.PROV_CODIGO = P_PROVEEDOR;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    IF APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003') THEN
      APEX_COLLECTION.DELETE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003');
    END IF;

    FOR R IN DETALLE_PAG LOOP
                             --         
      V_SUM_GRAB_ACUMULADO := 0; --PONER E CERO

      IF VERIFICAR_DOC_RETENCION(P_EMPRESA, R.CUO_CLAVE_DOC) = 'N' AND
         V_IND_PROV_RETENCION = 'S' THEN
 
        ---   RAISE_APPLICATION_ERROR(-20010,R.CUO_CLAVE_DOC||'  -  '||V_IND_PROV_RETENCION);
        --SI AUN NO POSEE RETENCION Y AL PROVEEDOR SE LE PUEDE RETENER SU IVA QUE SE SIGA CON EL PROCESO
        --raise_application_error(-20001,TO_CHAR(R.DOC_FEC_DOC, 'MM/YYYY')||R.CUO_CLAVE_DOC);
        FOR R_ACUM IN DETALLE_PAG_DET(TO_CHAR(R.DOC_FEC_DOC, 'MM/YYYY'),
                                      R.CUO_CLAVE_DOC) LOOP
                             -- raise_application_error(-20001,'X'||R_ACUM.CUO_CLAVE_DOC||' - '||R_ACUM.DOC_FEC_DOC);        
          PP_VERIFICAR_NOTACRED(PROV          => P_PROVEEDOR,
                                CLAVE_DOC     => R_ACUM.CUO_CLAVE_DOC,
                                I_EMPRESA     => P_EMPRESA,
                                V_EXENTO_LOC  => V_NCR_EXEN_LOC,
                                V_EXENTO_MON  => V_NCR_EXEN_MON,
                                V_GRAVADO_LOC => V_NCR_GRAV_LOC,
                                V_GRAVADO_MON => V_NCR_GRAV_MON,
                                V_IVA_LOC     => V_NCR_IVA_LOC,
                                V_IVA_MON     => V_NCR_IVA_MON);

          V_SUM_GRAB_ACUMULADO := V_SUM_GRAB_ACUMULADO +
                                  (R.GRAVADO_LOC - V_NCR_GRAV_LOC);
        END LOOP;

        PP_VERIFICAR_NOTACRED(PROV          => P_PROVEEDOR,
                              CLAVE_DOC     => R.CUO_CLAVE_DOC,
                              I_EMPRESA     => P_EMPRESA,
                              V_EXENTO_LOC  => V_NCR_EXEN_LOC,
                              V_EXENTO_MON  => V_NCR_EXEN_MON,
                              V_GRAVADO_LOC => V_NCR_GRAV_LOC,
                              V_GRAVADO_MON => V_NCR_GRAV_MON,
                              V_IVA_LOC     => V_NCR_IVA_LOC,
                              V_IVA_MON     => V_NCR_IVA_MON);

        V_RET_DOC_NETO_GRAV_MON   := R.GRAVADO - V_NCR_GRAV_MON;
        V_RET_DOC_IVA_MON         := R.IVA - V_NCR_IVA_MON;
        V_RET_DOC_NETO_GRAV_LOC   := R.GRAVADO_LOC - V_NCR_GRAV_LOC;
        V_RET_DOC_IVA_LOC         := R.IVA_LOC - V_NCR_IVA_LOC;
        V_RET_DOC_NETO_EXEN_MON   := R.EXENTO - V_NCR_EXEN_MON;
        V_RET_DOC_NETO_EXEN_LOC   := R.EXENTO_LOC - V_NCR_EXEN_LOC;
        V_RET_DOC_CLAVE_RETENCION := R.DOC_CLAVE_RETENCION;
        V_RET_DOC_NRO_DOC         := R.DOC_NRO_DOC;
        V_TOTAL_PAGO              := V_TOTAL_PAGO +
                                     NVL(V_RET_DOC_NETO_GRAV_LOC, 0);

        ---  RAISE_APPLICATION_ERROR(-20010,R.CUO_CLAVE_DOC||'  -  '||V_SUM_GRAB_ACUMULADO||V_TOTAL_PAGO );

--raise_application_error(-20001, V_SUM_GRAB_ACUMULADO||' - '||V_TOTAL_PAGO||' - '||P_PROVEEDOR||' - '||R.CUO_CLAVE_DOC);
        IF FIN_RETENER_IVA_FINI003(V_SUM_GRAB_ACUMULADO, --FUNCION PARA SABER SI SE DEBE DE RETENER EL IVA O NO
                                   V_TOTAL_PAGO,
                                   'N',
                                   P_PROVEEDOR,
                                   TO_CHAR(R.DOC_FEC_DOC, 'MM/YYYY'),
                                   R.CUO_CLAVE_DOC,
                                   'FINI003_WEB',
                                   P_EMPRESA) = 'S' AND
           R.DOC_CLAVE_RETENCION IS NULL THEN
           
          /*  IF P_MONEDA = 1 THEN
              -- ACUMULAR EL TOTAL DE LA RETENCION PARA LUEGO RESTAR DEL PAGO
              V_MONTO_RETENCION := ROUND((NVL(V_MONTO_RETENCION, 0) +
                                         (V_RET_DOC_IVA_LOC * (30 / 100))),
                                         V_MON_CANT_DEC);
            ELSE
              V_MONTO_RETENCION := ROUND((NVL(V_MONTO_RETENCION, 0) +
                                         (V_RET_DOC_IVA_MON * (30 / 100))),
                                         V_MON_CANT_DEC);
            END IF;
          */
          /* V_TOTAL_RETENCION_MON := ROUND((NVL(V_RET_DOC_IVA_MON, 0) *
                                         (30 / 100)),
                                         V_MON_CANT_DEC); --MONEDA EXTRANJERA ES REDONDEADA
          V_TOTAL_RETENCION_LOC := ROUND((V_RET_DOC_IVA_LOC * (30 / 100)),
                                         0); --MONEDA LOCAL ES 0 POR DEFAULT
                                         */
          /*  PP_MONTO_RETENCION(I_EMPRESA       => P_EMPRESA,
                             I_CLAVE_DOC     => R.CUO_CLAVE_DOC,
                             O_MONTO_RET_MON => V_TOTAL_RETENCION_MON,
                             O_MONTO_RET_LOC => V_TOTAL_RETENCION_LOC,
                             I_P_TABLA       => 'D');
          V_MONTO_RETENCION := V_MONTO_RETENCION+V_TOTAL_RETENCION_MON;
          RAISE_APPLICATION_ERROR(-20010,R.CUO_CLAVE_DOC||'  -  '||V_TOTAL_RETENCION_MON);




          V_TOTAL_RETENCION_MON := ROUND(V_TOTAL_RETENCION_MON,
                                         V_MON_CANT_DEC); --MONEDA EXTRANJERA ES REDONDEADA
          V_TOTAL_RETENCION_LOC := ROUND(V_TOTAL_RETENCION_LOC, 0); --MONEDA LOCAL ES 0 POR DEFAULT

          V_CLAVE_RETENCION := FIN_SEQ_DOC_NEXTVAL; --ESTA CLAVE ES LA NUEVA CLAVE PARA LA RETENCION

          IF NOT
              APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003') THEN
            APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003');
          END IF;
          ---CARGAR LOS DATOS DE LA RETENCION A LA COLECCION PARA LUEGO PROCEDER A LA INSERCION
          --RAISE_APPLICATION_ERROR(-20002,
          --                          'IMPORTES: '||V_TOTAL_RETENCION_MON||' - '|| V_TOTAL_RETENCION_LOC);

          APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003',
                                     P_N001            => V_CLAVE_RETENCION, --CLAVE NUEVA PARA LA RETENCION
                                     P_N002            => V_TOTAL_RETENCION_MON,
                                     P_N003            => V_TOTAL_RETENCION_LOC,
                                     P_N004            => P_MONEDA,
                                     P_N005            => P_PROVEEDOR,
                                     P_C001            => R.CUO_CLAVE_DOC, --CLAVE DE LA FACTURA A RETENER
                                     P_C002            => P_EMPRESA,
                                     P_D001            => R.DOC_FEC_DOC,
                                     P_C003            => R.DOC_NRO_DOC);*/

          V_TOTA_AUX   := V_TOTA_AUX + V_TOTAL_PAGO;
          V_TOTAL_PAGO := 0;
        ELSE
          V_TOTAL_PAGO            := 0;
          V_RET_DOC_NETO_GRAV_MON := 0;
          V_RET_DOC_IVA_MON       := 0;
          V_RET_DOC_NETO_GRAV_LOC := 0;
          V_RET_DOC_IVA_LOC       := 0;
          V_RET_DOC_NETO_EXEN_MON := 0;
          V_RET_DOC_NETO_EXEN_LOC := 0;

        END IF;

      END IF;

      V_ACUM_IMP_PAGO := V_ACUM_IMP_PAGO + R.S_IMP_PAGO; --ACUMULAR EL IMPORTE DE PAGO

    END LOOP;
    --    raise_application_error(-20001,'N');
    --------------------------PARA LO QUE ES RETENCION EN CENTURY REALIZA TOTALMENTE APARTE
    V_TOTAL_PAGO := V_TOTA_AUX;
      --raise_application_error(-20001,'N');
    IF V_TOTAL_PAGO > 0 THEN
      FOR R IN DETALLE_PAG LOOP
        IF R.DOC_CLAVE_RETENCION IS NULL THEN
          PP_MONTO_RETENCION(I_EMPRESA       => P_EMPRESA,
                             I_CLAVE_DOC     => R.CUO_CLAVE_DOC,
                             O_MONTO_RET_MON => V_TOTAL_RETENCION_MON,
                             O_MONTO_RET_LOC => V_TOTAL_RETENCION_LOC,
                             I_P_TABLA       => 'D');        
          V_MONTO_RETENCION := V_MONTO_RETENCION + V_TOTAL_RETENCION_MON;
          -- RAISE_APPLICATION_ERROR(-20010,R.CUO_CLAVE_DOC||'  -  '||V_TOTAL_RETENCION_MON);

          V_TOTAL_RETENCION_MON := ROUND(V_TOTAL_RETENCION_MON,
                                         V_MON_CANT_DEC); --MONEDA EXTRANJERA ES REDONDEADA
          V_TOTAL_RETENCION_LOC := ROUND(V_TOTAL_RETENCION_LOC, 0); --MONEDA LOCAL ES 0 POR DEFAULT

          V_CLAVE_RETENCION := FIN_SEQ_DOC_NEXTVAL; --ESTA CLAVE ES LA NUEVA CLAVE PARA LA RETENCION

          IF NOT
              APEX_COLLECTION.COLLECTION_EXISTS(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003') THEN
            APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003');
          END IF;
          ---CARGAR LOS DATOS DE LA RETENCION A LA COLECCION PARA LUEGO PROCEDER A LA INSERCION
          --RAISE_APPLICATION_ERROR(-20002,
          --                          'IMPORTES: '||V_TOTAL_RETENCION_MON||' - '|| V_TOTAL_RETENCION_LOC);

          APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'DETALLE_RETEN_FINI003',
                                     P_N001            => V_CLAVE_RETENCION, --CLAVE NUEVA PARA LA RETENCION
                                     P_N002            => V_TOTAL_RETENCION_MON,
                                     P_N003            => V_TOTAL_RETENCION_LOC,
                                     P_N004            => P_MONEDA,
                                     P_N005            => P_PROVEEDOR,
                                     P_C001            => R.CUO_CLAVE_DOC, --CLAVE DE LA FACTURA A RETENER
                                     P_C002            => P_EMPRESA,
                                     P_D001            => R.DOC_FEC_DOC,
                                     P_C003            => R.DOC_NRO_DOC);

        END IF;
      --raise_application_error(-20001,'R'||V_MONTO_RETENCION);
      END LOOP;

    END IF;

    --V_TOTAL_PAGO  := 0;
    
                     
    V_TOTAL_PAGO  := V_ACUM_IMP_PAGO - NVL(V_MONTO_RETENCION, 0); --ESTE ES EL TOTAL A PAGAR
    O_S_RETEN_MON := V_MONTO_RETENCION;
    O_S_PAGO      := V_TOTAL_PAGO;

    ---  RAISE_APPLICATION_ERROR(-20020,V_TOTAL_RETENCION_MON);
  END PP_VERIFICAR_MONTO_PAGO;

  PROCEDURE PP_GNRA_REC_AUT(I_EMPRESA      IN NUMBER,
                            I_SUCURSAL     IN NUMBER,
                            I_DOC_CTA_BCO  IN NUMBER,
                            I_DOC_CLAVE    IN NUMBER,
                            I_CUO_VTO      IN DATE,
                            I_DOC_FEC_DOC  IN DATE,
                            I_DOC_FEC_OPER IN DATE,
                            I_DOC_NRO_DOC  IN NUMBER,
                            I_TASA         IN NUMBER,
                            I_DOC_TIPO_MOV IN NUMBER,
                            I_MONTO_PAGO   IN NUMBER DEFAULT NULL,
                            I_DOC_OBS      IN VARCHAR2 DEFAULT NULL,
                            O_CLAVE_REC    OUT NUMBER) AS

    CURSOR CUR_DOC IS
      SELECT *
        FROM FIN_DOCUMENTO, FIN_CUOTA
       WHERE CUO_EMPR = DOC_EMPR
         AND CUO_CLAVE_DOC = DOC_CLAVE
         AND DOC_EMPR = I_EMPRESA
         AND CUO_CLAVE_DOC = I_DOC_CLAVE
         AND CUO_FEC_VTO = I_CUO_VTO
         AND CUO_SALDO_MON > 0;

    V_DOC_CLAVE           NUMBER;
    V_DOC_NETO_EXEN_LOC   NUMBER;
    V_DOC_NETO_EXEN_MON   NUMBER;
    V_DCON_CLAVE_CONCEPTO NUMBER;
    V_CONF                FIN_CONFIGURACION%ROWTYPE;
    V_DCON                FIN_CONCEPTO%ROWTYPE;
    V_TMOV                GEN_TIPO_MOV%ROWTYPE;
  BEGIN

    SELECT *
      INTO V_CONF
      FROM FIN_CONFIGURACION T
     WHERE CONF_EMPR = I_EMPRESA;

    FOR C IN CUR_DOC LOOP

      IF I_DOC_TIPO_MOV = V_CONF.CONF_RECIBO_PAGO_EMIT THEN
        V_DCON_CLAVE_CONCEPTO := V_CONF.CONF_CONCEPTO_COBRO;

      ELSIF I_DOC_TIPO_MOV = V_CONF.CONF_RECIBO_PAGO_REC THEN
        V_DCON_CLAVE_CONCEPTO := V_CONF.CONF_CONCEPTO_PAGO;

      ELSIF I_DOC_TIPO_MOV = V_CONF.CONF_TMOV_PAGO_NC THEN
        V_DCON_CLAVE_CONCEPTO := V_CONF.CONF_CONC_PAGO_NC;

      ELSIF I_DOC_TIPO_MOV = V_CONF.CONF_TMOV_PAGO_NC_REC THEN
        V_DCON_CLAVE_CONCEPTO := V_CONF.CONF_CONC_PAGO_NC_REC;

      ELSIF I_DOC_TIPO_MOV = V_CONF.CONF_TMOV_DEVOL_ADEL_CLI THEN
        V_DCON_CLAVE_CONCEPTO := V_CONF.CONF_CONC_CADCLI;

      ELSIF I_DOC_TIPO_MOV = V_CONF.CONF_TMOV_DEVOL_ADEL_PRO THEN
        V_DCON_CLAVE_CONCEPTO := V_CONF.CONF_CONC_CADPRO;
      END IF;

      SELECT *
        INTO V_TMOV
        FROM GEN_TIPO_MOV T
       WHERE TMOV_CODIGO = I_DOC_TIPO_MOV
         AND TMOV_EMPR = I_EMPRESA;

      V_DOC_NETO_EXEN_LOC := NVL(I_MONTO_PAGO, C.DOC_NETO_EXEN_MON) *
                             I_TASA;
      V_DOC_NETO_EXEN_MON := NVL(I_MONTO_PAGO, C.DOC_NETO_EXEN_MON);

      V_DOC_CLAVE := FIN_SEQ_DOC_NEXTVAL;

      INSERT INTO FIN_DOCUMENTO
        (DOC_CLAVE,
         DOC_EMPR,
         DOC_SUC,
         DOC_CTA_BCO,
         DOC_TIPO_SALDO,
         DOC_NRO_DOC,
         DOC_MON,
         DOC_TIPO_MOV,
         DOC_CLI,
         DOC_PROV,
         DOC_FEC_DOC,
         DOC_FEC_OPER,
         DOC_NETO_EXEN_LOC,
         DOC_NETO_EXEN_MON,
         DOC_BRUTO_EXEN_LOC,
         DOC_BRUTO_EXEN_MON,
         DOC_BRUTO_GRAV_LOC,
         DOC_BRUTO_GRAV_MON,
         DOC_NETO_GRAV_LOC,
         DOC_NETO_GRAV_MON,
         DOC_IVA_LOC,
         DOC_IVA_MON,
         DOC_LOGIN,
         DOC_FEC_GRAB,
         DOC_SIST,
         DOC_OPERADOR,
         DOC_CLI_NOM,
         DOC_SISTEMA_AUX,
         DOC_TASA,
         DOC_OBS)
      VALUES
        (V_DOC_CLAVE,
         I_EMPRESA,
         I_SUCURSAL,
         I_DOC_CTA_BCO,
         V_TMOV.TMOV_TIPO,
         I_DOC_NRO_DOC,
         C.DOC_MON,
         V_TMOV.TMOV_CODIGO,
         C.DOC_CLI,
         C.DOC_PROV,
         I_DOC_FEC_DOC,
         I_DOC_FEC_OPER,
         V_DOC_NETO_EXEN_LOC,
         V_DOC_NETO_EXEN_MON,
         V_DOC_NETO_EXEN_LOC,
         V_DOC_NETO_EXEN_MON,
         0,
         0,
         0,
         0,
         0,
         0,
         GEN_DEVUELVE_USER,
         SYSDATE,
         'FIN',
         C.DOC_OPERADOR,
         C.DOC_CLI_NOM,
         'FINI003',
         I_TASA,
         UPPER(I_DOC_OBS));

      SELECT *
        INTO V_DCON
        FROM FIN_CONCEPTO T
       WHERE T.FCON_CLAVE = V_DCON_CLAVE_CONCEPTO
         AND T.FCON_EMPR = I_EMPRESA;
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
        (V_DOC_CLAVE,
         1,
         V_DCON.FCON_CLAVE,
         V_DCON.FCON_CLAVE_CTACO,
         V_DCON.FCON_TIPO_SALDO,
         V_DOC_NETO_EXEN_LOC,
         V_DOC_NETO_EXEN_MON,
         0,
         0,
         0,
         0,
         I_EMPRESA);

      INSERT INTO FIN_PAGO
        (PAG_CLAVE_DOC,
         PAG_FEC_VTO,
         PAG_CLAVE_PAGO,
         PAG_FEC_PAGO,
         PAG_IMP_LOC,
         PAG_IMP_MON,
         PAG_LOGIN,
         PAG_FEC_GRAB,
         PAG_SIST,
         PAG_EMPR)
      VALUES
        (C.CUO_CLAVE_DOC,
         C.CUO_FEC_VTO,
         V_DOC_CLAVE,
         I_DOC_FEC_OPER,
         V_DOC_NETO_EXEN_LOC,
         V_DOC_NETO_EXEN_MON,
         GEN_DEVUELVE_USER,
         SYSDATE,
         'FIN',
         I_EMPRESA);

    END LOOP;
    O_CLAVE_REC := V_DOC_CLAVE;

  END PP_GNRA_REC_AUT;

  PROCEDURE PP_DAR_BAJA_FACT_CRED_EMPL(I_EMPRESA    IN NUMBER,
                                       I_CLIENTE    IN NUMBER DEFAULT NULL,
                                       I_CLAVE_VTO  IN VARCHAR2 DEFAULT NULL) IS

    CURSOR CUR_VENCIDOS IS
      SELECT C.*,
             D.*,
             E.EMPL_LEGAJO,
             E.EMPL_CODIGO_PROV,
             E.EMPL_NOMBRE,
             E.EMPL_APE,
             E.EMPL_DEPARTAMENTO,
             E.EMPL_SUCURSAL
        FROM FIN_DOCUMENTO D, FIN_CUOTA C, FIN_CLIENTE CL, PER_EMPLEADO E
       WHERE CUO_EMPR = DOC_EMPR
         AND CUO_CLAVE_DOC = DOC_CLAVE
         AND DOC_EMPR = I_EMPRESA
         AND DOC_CLI = CL.CLI_CODIGO
         AND DOC_EMPR = CL.CLI_EMPR
         AND DOC_MON = 1
            /*   AND EMPL_FORMA_PAGO IN (1,2,5)
            AND C.CUO_FEC_VTO < SYSDATE + 7
            AND TO_CHAR(C.CUO_FEC_VTO,'MM/YYYY')= TO_CHAR(SYSDATE,'MM/YYYY')*/
            ------------------------------------------------------------LV06/06/2021
         AND (EMPL_FORMA_PAGO IN (1, 2, 5) OR EMPL_SUCURSAL = 2)
         AND CASE
               WHEN I_CLIENTE IS NULL THEN
                CASE
                  WHEN C.CUO_FEC_VTO < SYSDATE + 7 THEN
                   1
                  ELSE
                   0
                END
               WHEN I_CLIENTE IS NOT NULL THEN
                1
             END = 1
         AND CASE
               WHEN I_CLIENTE IS NULL THEN
                CASE
                  WHEN TO_CHAR(C.CUO_FEC_VTO, 'MM/YYYY') <=
                       TO_CHAR(SYSDATE, 'MM/YYYY') THEN
                   1
                  ELSE
                   0
                END
               WHEN I_CLIENTE IS NOT NULL THEN
                1
             END = 1
         AND (CLI_CODIGO = I_CLIENTE OR I_CLIENTE IS NULL)
         ----------------LV 16/08/2021
          AND (CUO_CLAVE_DOC||'-'||TO_CHAR(CUO_FEC_VTO,'DD/MM/YYYY')  =I_CLAVE_VTO OR I_CLAVE_VTO  IS NULL )
            ---------------------------------------------------------------LV

            -- AND DOC_CLI = 97051
            -- AND CL.CLI_RAMO = 32

         AND DOC_TIPO_MOV = 10

            --  AND E.EMPL_SUCURSAL <> 2
         and decode(E.EMPL_COD_CLIENTE,10093,6158,E.EMPL_COD_CLIENTE) = CL.CLI_CODIGO
         --AND E.EMPL_COD_CLIENTE = CL.CLI_CODIGO
         AND E.EMPL_EMPRESA = CL.CLI_EMPR
         AND E.EMPL_SITUACION = 'A'

         AND CUO_SALDO_MON > 0
         AND D.DOC_CLAVE NOT IN
             (SELECT A.DOC_CLAVE
                FROM FIN_DOCUMENTO A -----------------LV 11/02/2021
               WHERE DOC_EMPR = 1
                 AND A.DOC_CLI = CL.CLI_CODIGO
                 AND A.DOC_TIPO_MOV = 47);

    V_COD_SUCURSAL        NUMBER;
    V_OBS                 VARCHAR2(100); ----------------------este estaba como 45
    V_DCON_CLAVE_CONCEPTO NUMBER;
    V_DOC_CTA_BCO         NUMBER;
    V_NRO_REC             NUMBER;
    V_COTIZACION          NUMBER;
    V_TASA                NUMBER;
    V_CLAVE_PER_DOC       NUMBER;
    C_DOC                 FIN_DOCUMENTO%ROWTYPE;
    C_CUO                 FIN_CUOTA%ROWTYPE;
    O_CLAVE_FIN           NUMBER;
    V_PER_PERIODO         NUMBER;
    V_TM_ADEL_PROV        NUMBER;
    DESTINATARIO          VARCHAR2(600);
    COPIA                 VARCHAR2(600);
    OCULTA                VARCHAR2(150);

    V_CLAVE_RECIBO NUMBER;
  BEGIN
    SELECT T.CO_PARA, T.CO_CC, T.CO_CCO
      INTO DESTINATARIO, COPIA, OCULTA
      FROM GEN_CORREOS T
     WHERE T.CO_ACCION = 'Error_Cobro';

    /*SELECT FACI039.FP_COTIZACION(P_MONEDA      => 2,
                               P_DOC_FEC_DOC => TRUNC(SYSDATE),
                               P_EMPRESA     => I_EMPRESA)
    INTO V_COTIZACION
    FROM DUAL;*/

    /*SELECT T.CONF_PERI_ACT
     INTO V_PER_PERIODO
     FROM PER_CONFIGURACION T
    WHERE T.CONF_EMPR = I_EMPRESA;*/

    BEGIN
      SELECT T.CONF_PERI_ACT
        INTO V_PER_PERIODO
        FROM PER_CONFIGURACION T, PER_PERIODO A
       WHERE T.CONF_EMPR = I_EMPRESA
         AND T.CONF_PERI_ACT = A.PERI_CODIGO
         AND T.CONF_EMPR = A.PERI_EMPR
         AND TO_CHAR(A.PERI_FEC_INI, 'MM/YYYY') =
             TO_CHAR(SYSDATE, 'MM/YYYY');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        SELECT T.CONF_PERI_SGTE
          INTO V_PER_PERIODO
          FROM PER_CONFIGURACION T, PER_PERIODO A
         WHERE T.CONF_EMPR = I_EMPRESA
           AND T.CONF_PERI_SGTE = A.PERI_CODIGO
           AND T.CONF_EMPR = A.PERI_EMPR
           AND TO_CHAR(A.PERI_FEC_INI, 'MM/YYYY') =
               TO_CHAR(SYSDATE, 'MM/YYYY');

    END;

    -- DBMS_OUTPUT.PUT_LINE('0.2');
    ---**** VARIABLES GLOBALES

    V_TM_ADEL_PROV := 31;

    -- DBMS_OUTPUT.PUT_LINE('0.3');
    FOR C IN CUR_VENCIDOS LOOP
      IF C.EMPL_SUCURSAL = 2 THEN
        V_COD_SUCURSAL := 2;
        V_DOC_CTA_BCO  := 65; -- CAJA QUE USABA EDUARDO
      ELSE
        V_DOC_CTA_BCO  := 128; -- CAJA QUE USABA EDUARDO
        V_COD_SUCURSAL := 1;
      END IF;

      --   DBMS_OUTPUT.PUT_LINE('1');
      ----****** ASIGNAR VALORES A VARIABLES
      V_OBS := c.doc_obs; ---- 'Cobro Autom.'; ------lv necesito la observacion para el recibo
      -- V_NRO_REC       := TO_NUMBER(TO_CHAR(SYSDATE, 'DDMMYYYY'));

      V_NRO_REC := FP_NRO_DOC_ADELANTO(I_EMPRESA   => I_EMPRESA,
                                       I_FECHA_DOC => SYSDATE);

      V_CLAVE_PER_DOC := FINI003.FP_PER_DOC_CLAVE(I_EMPRESA => I_EMPRESA);

      IF C.DOC_MON = 1 THEN
        V_TASA := 1;
      ELSE
        V_TASA := V_COTIZACION;
      END IF;

      -- DBMS_OUTPUT.PUT_LINE('2');
      ----***** VARIABLES PARA GENERAR ADELANTOS

      C_DOC.DOC_TIPO_MOV := V_TM_ADEL_PROV;
      C_DOC.DOC_SUC      := V_COD_SUCURSAL;
      C_DOC.DOC_CTA_BCO  := V_DOC_CTA_BCO;
      C_DOC.DOC_NRO_DOC  := V_NRO_REC;
      C_DOC.DOC_MON      := C.DOC_MON;
      C_DOC.DOC_PROV     := C.EMPL_CODIGO_PROV;
      C_DOC.DOC_FEC_DOC  := TRUNC(SYSDATE);
      C_DOC.DOC_FEC_OPER := TRUNC(SYSDATE);
      C_DOC.DOC_CLI_NOM  := C.DOC_CLI_NOM;
      C_DOC.DOC_EMPLEADO := C.EMPL_LEGAJO;
      C_DOC.DOC_TASA     := V_TASA;
      C_DOC.DOC_OBS      := V_OBS;

      /* 'Cobro Autom. COBRO  RECIB. N : ' || V_NRO_REC || ' ' ||
                              SUBSTR(C.EMPL_NOMBRE, 0, 10) ||
                              SUBSTR(C.EMPL_APE, 0, 10);
      */
      V_DCON_CLAVE_CONCEPTO := 67; --EGRESOS VARIOS

      IF FP_RETORNA_CANT_DIA_HABIL(I_FECHA_INI => TRUNC(SYSDATE),
                                   I_FECHA_FIN => TRUNC(LAST_DAY(SYSDATE)),
                                   I_EMPRESA   => I_EMPRESA) >= 2 THEN
        C_CUO.CUO_FEC_VTO := LAST_DAY(SYSDATE);
      ELSE
        C_CUO.CUO_FEC_VTO := ADD_MONTHS(LAST_DAY(SYSDATE), 1);
      END IF;

      ---*****

      BEGIN

        --   DBMS_OUTPUT.PUT_LINE('genera recibo');

        FINI003.PP_GNRA_REC_AUT(I_EMPRESA      => I_EMPRESA,
                                I_SUCURSAL     => V_COD_SUCURSAL,
                                I_DOC_CTA_BCO  => V_DOC_CTA_BCO,
                                I_DOC_CLAVE    => C.CUO_CLAVE_DOC,
                                I_CUO_VTO      => C.CUO_FEC_VTO,
                                I_DOC_FEC_DOC  => TRUNC(SYSDATE),
                                I_DOC_FEC_OPER => TRUNC(SYSDATE),
                                I_DOC_NRO_DOC  => V_NRO_REC,
                                I_TASA         => V_TASA,
                                I_DOC_TIPO_MOV => 6,
                                I_MONTO_PAGO   => C.CUO_SALDO_MON,
                                I_DOC_OBS      => V_OBS,
                                O_CLAVE_REC    => V_CLAVE_RECIBO);
      END;


 if V_CLAVE_RECIBO is not null then
      BEGIN

        ---   DBMS_OUTPUT.PUT_LINE('genera adelanto');
        -- CALL THE PROCEDURE
        FINI003.PP_GRAR_ADEL_PROV(I_EMPRESA             => I_EMPRESA,
                                  I_TASA                => V_TASA,
                                  I_DCON_CLAVE_CONCEPTO => V_DCON_CLAVE_CONCEPTO,
                                  I_MONTO_PAGO          => C.CUO_SALDO_MON,
                                  C_DOC                 => C_DOC,
                                  C_CUO                 => C_CUO,
                                  O_CLAVE_FIN           => O_CLAVE_FIN,
                                  I_CLAVE_RECIBO        => V_CLAVE_RECIBO); -----------------LV 11/02/2021
      END;

      BEGIN
        ---DBMS_OUTPUT.PUT_LINE('genera registro per documento');

        FINI003.PP_INS_PER_DOC(I_EMPRESA           => I_EMPRESA,
                               I_TIPO_MOV          => V_TM_ADEL_PROV, ---ADELANTO A PROVEEDOR
                               I_PDOC_CLAVE        => V_CLAVE_PER_DOC,
                               I_PDOC_QUINCENA     => 2,
                               I_PDOC_EMPLEADO     => C.EMPL_LEGAJO,
                               I_PDOC_FEC          => TRUNC(SYSDATE),
                               I_PDOC_NRO_DOC      => V_NRO_REC,
                               I_PDOC_FEC_GRAB     => SYSDATE,
                               I_PDOC_LOGIN        => GEN_DEVUELVE_USER,
                               I_PDOC_FORM         => 'PERI005',
                               I_PDOC_PERIODO      => V_PER_PERIODO,
                               I_PDOC_CLAVE_FIN    => O_CLAVE_FIN,
                               I_PDOC_NRO_ITEM     => 1,
                               I_PDOC_CONCEPTO     => 1, -- 1=ADELANTOS(+)
                               I_PDOC_IMPORTE      => C.CUO_SALDO_MON,
                               I_PDOC_IMPORTE_LOC  => C.CUO_SALDO_MON *
                                                      V_TASA,
                               I_PDOC_MON          => C.DOC_MON,
                               I_PDOC_DEPARTAMENTO => C.EMPL_DEPARTAMENTO);

      END;
   END IF;
      COMMIT;
      ---    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END LOOP;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      IF DESTINATARIO IS NOT NULL THEN
      -- CALL THE PROCEDURE
      SEND_EMAIL(P_SENDER     => 'NOREPLY',
                 P_RECIPIENTS => DESTINATARIO,
                 P_CC         => COPIA,
                 P_BCC        => OCULTA,
                 P_SUBJECT    => 'ERROR EN PROCESO DE COBRO',
                 P_MESSAGE    => 'Error al dar de baja facturas credito de empleados en el paq: fini003 PP_DAR_BAJA_FACT_CRED_EMPL favor revisar' ||
                                 SQLERRM,
                 P_MIME_TYPE  => 'text/html');
      END IF;

      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END PP_DAR_BAJA_FACT_CRED_EMPL;

  PROCEDURE PP_GRAR_ADEL_PROV(I_EMPRESA             IN NUMBER,
                              I_TASA                IN NUMBER,
                              I_DCON_CLAVE_CONCEPTO IN NUMBER,
                              I_MONTO_PAGO          IN NUMBER DEFAULT NULL,
                              C_DOC                 IN FIN_DOCUMENTO%ROWTYPE DEFAULT NULL,
                              C_CUO                 IN FIN_CUOTA%ROWTYPE DEFAULT NULL,
                              O_CLAVE_FIN           OUT NUMBER,
                              I_CLAVE_RECIBO        IN NUMBER) IS

    --V_ITEM      NUMBER := 1;
    V_DOC_CLAVE NUMBER;

    V_DOC_NETO_EXEN_LOC  NUMBER;
    V_DOC_NETO_EXEN_MON  NUMBER;
    V_DOC_BRUTO_EXEN_LOC NUMBER;
    V_DOC_BRUTO_EXEN_MON NUMBER;
    V_DOC_BRUTO_GRAV_LOC NUMBER;
    V_DOC_BRUTO_GRAV_MON NUMBER;
    V_DOC_NETO_GRAV_LOC  NUMBER;
    V_DOC_NETO_GRAV_MON  NUMBER;
    V_DOC_IVA_LOC        NUMBER;
    V_DOC_IVA_MON        NUMBER;
    --V_DCON_CLAVE_CONCEPTO NUMBER;
    V_CLAVE_IMG NUMBER;
    --V_CONF                FIN_CONFIGURACION%ROWTYPE;
    V_DCON FIN_CONCEPTO%ROWTYPE;
    V_TMOV GEN_TIPO_MOV%ROWTYPE;

  BEGIN

    V_DOC_NETO_EXEN_LOC := NVL(I_MONTO_PAGO, C_DOC.DOC_NETO_EXEN_MON) *
                           I_TASA;
    V_DOC_NETO_EXEN_MON := NVL(I_MONTO_PAGO, C_DOC.DOC_NETO_EXEN_MON);

    V_DOC_BRUTO_EXEN_LOC := NVL(I_MONTO_PAGO, C_DOC.DOC_NETO_EXEN_MON) *
                            I_TASA;
    V_DOC_BRUTO_EXEN_MON := NVL(I_MONTO_PAGO, C_DOC.DOC_NETO_EXEN_MON);

    V_DOC_BRUTO_GRAV_LOC := NVL(C_DOC.DOC_BRUTO_GRAV_LOC, 0) * I_TASA;
    V_DOC_BRUTO_GRAV_MON := NVL(C_DOC.DOC_BRUTO_GRAV_MON, 0);

    V_DOC_NETO_GRAV_LOC := NVL(C_DOC.DOC_NETO_GRAV_LOC, 0) * I_TASA;
    V_DOC_NETO_GRAV_MON := NVL(C_DOC.DOC_NETO_GRAV_LOC, 0);

    V_DOC_IVA_LOC := NVL(C_DOC.DOC_IVA_LOC, 0) * I_TASA;
    V_DOC_IVA_MON := NVL(C_DOC.DOC_IVA_MON, 0);

    SELECT *
      INTO V_TMOV
      FROM GEN_TIPO_MOV T
     WHERE TMOV_CODIGO = C_DOC.DOC_TIPO_MOV
       AND TMOV_EMPR = I_EMPRESA;

    V_DOC_CLAVE := FIN_SEQ_DOC_NEXTVAL;

    INSERT INTO FIN_DOCUMENTO
      (DOC_CLAVE,
       DOC_EMPR,
       DOC_SUC,
       DOC_CTA_BCO,
       DOC_TIPO_SALDO,
       DOC_NRO_DOC,
       DOC_MON,
       DOC_TIPO_MOV,
       DOC_CLI,
       DOC_PROV,
       DOC_FEC_DOC,
       DOC_FEC_OPER,
       DOC_NETO_EXEN_LOC,
       DOC_NETO_EXEN_MON,
       DOC_BRUTO_EXEN_LOC,
       DOC_BRUTO_EXEN_MON,
       DOC_BRUTO_GRAV_LOC,
       DOC_BRUTO_GRAV_MON,
       DOC_NETO_GRAV_LOC,
       DOC_NETO_GRAV_MON,
       DOC_IVA_LOC,
       DOC_IVA_MON,
       DOC_LOGIN,
       DOC_FEC_GRAB,
       DOC_SIST,
       DOC_OPERADOR,
       DOC_CLI_NOM,
       DOC_SISTEMA_AUX,
       DOC_TASA,
       DOC_OBS,
       DOC_EMPLEADO,
       DOC_CLAVE_PADRE_ORIG)
    VALUES
      (V_DOC_CLAVE,
       I_EMPRESA,
       C_DOC.DOC_SUC,
       C_DOC.DOC_CTA_BCO,
       V_TMOV.TMOV_TIPO,
       C_DOC.DOC_NRO_DOC,
       C_DOC.DOC_MON,
       V_TMOV.TMOV_CODIGO,
       C_DOC.DOC_CLI,
       C_DOC.DOC_PROV,
       C_DOC.DOC_FEC_DOC,
       C_DOC.DOC_FEC_OPER,
       V_DOC_NETO_EXEN_LOC,
       V_DOC_NETO_EXEN_MON,
       V_DOC_BRUTO_EXEN_LOC,
       V_DOC_BRUTO_EXEN_MON,
       V_DOC_BRUTO_GRAV_LOC,
       V_DOC_BRUTO_GRAV_MON,
       V_DOC_NETO_GRAV_LOC,
       V_DOC_NETO_GRAV_MON,
       V_DOC_IVA_LOC,
       V_DOC_IVA_MON,
       GEN_DEVUELVE_USER,
       SYSDATE,
       'FIN',
       2,
       C_DOC.DOC_CLI_NOM,
       'FINI003',
       C_DOC.DOC_TASA,
       UPPER(C_DOC.DOC_OBS),
       C_DOC.DOC_EMPLEADO,
       I_CLAVE_RECIBO);

    SELECT *
      INTO V_DCON
      FROM FIN_CONCEPTO T
     WHERE T.FCON_CLAVE = I_DCON_CLAVE_CONCEPTO
       AND T.FCON_EMPR = I_EMPRESA;

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
       DCON_OBS,
       DCON_EMPR)
    VALUES
      (V_DOC_CLAVE,
       1,
       V_DCON.FCON_CLAVE,
       V_DCON.FCON_CLAVE_CTACO,
       V_DCON.FCON_TIPO_SALDO,
       V_DOC_NETO_EXEN_LOC,
       V_DOC_NETO_EXEN_MON,
       V_DOC_NETO_GRAV_LOC,
       V_DOC_NETO_GRAV_MON,
       V_DOC_IVA_LOC,
       V_DOC_IVA_MON,
       UPPER(C_DOC.DOC_OBS),
       I_EMPRESA);

    INSERT INTO FIN_CUOTA
      (CUO_CLAVE_DOC, CUO_FEC_VTO, CUO_IMP_LOC, CUO_IMP_MON, CUO_EMPR)
    VALUES
      (V_DOC_CLAVE,
       NVL(C_CUO.CUO_FEC_VTO, TRUNC(SYSDATE + 5)),
       V_DOC_NETO_EXEN_LOC,
       V_DOC_NETO_EXEN_MON,
       I_EMPRESA);

    V_CLAVE_IMG := COM_SEQ_FAC_REC_NEXTVAL;

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
       FAC_VER_CONT)
    VALUES
      (V_CLAVE_IMG,
       I_EMPRESA,
       C_DOC.DOC_SUC,
       NULL,
       C_DOC.DOC_NRO_DOC,
       C_DOC.DOC_PROV,
       C_DOC.DOC_FEC_DOC,
       C_DOC.DOC_TIPO_MOV,
       C_DOC.DOC_MON,
       0,
       0,
       V_DOC_NETO_EXEN_MON,
       V_DOC_NETO_EXEN_MON,
       V_DOC_CLAVE,
       GEN_DEVUELVE_USER,
       C_DOC.DOC_CTA_BCO,
       'C',
       GEN_DEVUELVE_USER,
       'N');

    INSERT INTO COM_FACTURA_IMAGEN
      (FAC_CLAVE, FAC_ITEM, FAC_LOR, FAC_EMPR)
    VALUES
      (V_CLAVE_IMG, 1, 10101, I_EMPRESA);

    O_CLAVE_FIN := V_DOC_CLAVE;

  END PP_GRAR_ADEL_PROV;

  PROCEDURE PP_INS_PER_DOC(I_EMPRESA           IN NUMBER,
                           I_TIPO_MOV          IN NUMBER,
                           I_PDOC_CLAVE        IN NUMBER,
                           I_PDOC_QUINCENA     IN NUMBER,
                           I_PDOC_EMPLEADO     IN NUMBER,
                           I_PDOC_FEC          IN DATE,
                           I_PDOC_NRO_DOC      IN NUMBER,
                           I_PDOC_FEC_GRAB     IN DATE,
                           I_PDOC_LOGIN        IN VARCHAR2,
                           I_PDOC_FORM         IN VARCHAR2,
                           I_PDOC_PERIODO      IN NUMBER,
                           I_PDOC_CLAVE_FIN    IN NUMBER,
                           I_PDOC_NRO_ITEM     IN NUMBER,
                           I_PDOC_CONCEPTO     IN NUMBER,
                           I_PDOC_IMPORTE      IN NUMBER,
                           I_PDOC_IMPORTE_LOC  IN NUMBER,
                           I_PDOC_MON          IN NUMBER,
                           I_PDOC_DEPARTAMENTO IN NUMBER) IS
  BEGIN

    /*IF I_TIPO_MOV = 31 AND I_EMPRESA = 1 THEN

      INSERT INTO PER_DOCUMENTO_ADEL_TEMP
        (PDOC_CLAVE,
         PDOC_QUINCENA,
         PDOC_EMPLEADO,
         PDOC_FEC,
         PDOC_NRO_DOC,
         PDOC_FEC_GRAB,
         PDOC_LOGIN,
         PDOC_FORM,
         PDOC_PERIODO,
         PDOC_CLAVE_FIN,
         PDOC_MON,
         PDOC_DEPARTAMENTO,
         PDOC_EMPR)
      VALUES
        (I_PDOC_CLAVE,
         I_PDOC_QUINCENA,
         I_PDOC_EMPLEADO,
         I_PDOC_FEC,
         I_PDOC_NRO_DOC,
         I_PDOC_FEC_GRAB,
         I_PDOC_LOGIN,
         I_PDOC_FORM,
         I_PDOC_PERIODO,
         I_PDOC_CLAVE_FIN,
         I_PDOC_MON,
         I_PDOC_DEPARTAMENTO,
         I_EMPRESA);

      INSERT INTO PER_DOCUMENTO_DET_ADEL_TEMP
        (PDDET_CLAVE_DOC,
         PDDET_ITEM,
         PDDET_CLAVE_CONCEPTO,
         PDDET_IMP,
         PDDET_IMP_LOC,
         PDDET_EMPR)
      VALUES
        (I_PDOC_CLAVE,
         I_PDOC_NRO_ITEM,
         I_PDOC_CONCEPTO,
         I_PDOC_IMPORTE,
         I_PDOC_IMPORTE_LOC,
         I_EMPRESA);
    ELSE*/

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
       PDOC_CLAVE_FIN,
       PDOC_MON,
       PDOC_DEPARTAMENTO,
       PDOC_EMPR)
    VALUES
      (I_PDOC_CLAVE,
       I_PDOC_QUINCENA,
       I_PDOC_EMPLEADO,
       I_PDOC_FEC,
       I_PDOC_NRO_DOC,
       I_PDOC_FEC_GRAB,
       I_PDOC_LOGIN,
       I_PDOC_FORM,
       I_PDOC_PERIODO,
       I_PDOC_CLAVE_FIN,
       I_PDOC_MON,
       I_PDOC_DEPARTAMENTO,
       I_EMPRESA);

    INSERT INTO PER_DOCUMENTO_DET
      (PDDET_CLAVE_DOC,
       PDDET_ITEM,
       PDDET_CLAVE_CONCEPTO,
       PDDET_IMP,
       PDDET_IMP_LOC,
       PDDET_EMPR)
    VALUES
      (I_PDOC_CLAVE,
       I_PDOC_NRO_ITEM,
       I_PDOC_CONCEPTO,
       I_PDOC_IMPORTE,
       I_PDOC_IMPORTE_LOC,
       I_EMPRESA);

    --   END IF;
  END PP_INS_PER_DOC;

  FUNCTION FP_PER_DOC_CLAVE(I_EMPRESA IN NUMBER) RETURN NUMBER IS
    V_CLAVE NUMBER;
  BEGIN
    SELECT MAX(DOC_MAX)
      INTO V_CLAVE
      FROM (SELECT NVL(MAX(PDOC_CLAVE), 0) + 1 DOC_MAX
              FROM PER_DOCUMENTO
             WHERE PDOC_EMPR = I_EMPRESA
            UNION ALL
            SELECT NVL(MAX(PDOC_CLAVE), 0) + 1 DOC_MAX
              FROM PER_DOCUMENTO_ADEL_TEMP
             WHERE PDOC_EMPR = I_EMPRESA);

    RETURN V_CLAVE;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 1;
  END FP_PER_DOC_CLAVE;

  PROCEDURE PP_MONTO_RETENCION(I_EMPRESA       IN NUMBER,
                               I_CLAVE_DOC     IN NUMBER,
                               O_MONTO_RET_MON OUT NUMBER,
                               O_MONTO_RET_LOC OUT NUMBER,
                               I_P_TABLA       IN VARCHAR2 DEFAULT 'D',
                               I_FEC_RET       IN DATE DEFAULT SYSDATE) AS

    CURSOR CUR_DOC_FIN(P_CLAVE_FIN IN NUMBER) IS
      SELECT 1 CANTIDAD,
             NVL(DCON_PORC_IVA, 0) PORC_IVA,
             DECODE(NVL(DCON_PORC_IVA, 0),
                    0,
                    SUM(DCON_EXEN_MON + DCON_GRAV_MON + DCON_IVA_MON),
                    SUM(DCON_GRAV_MON + DCON_IVA_MON)) TOTAL,
             DECODE(NVL(DCON_PORC_IVA, 0),
                    0,
                    'Ventas Exentas',
                    DECODE(NVL(DCON_PORC_IVA, 0),
                           5,
                           'Ventas al 5%',
                           'Ventas al 10%')) DESCRIPCION
        FROM FIN_DOC_CONCEPTO
       WHERE DCON_CLAVE_DOC = P_CLAVE_FIN
         AND DCON_EMPR = I_EMPRESA
       GROUP BY DCON_PORC_IVA;

    CURSOR CUR_DOC_TEMP(P_CLAVE_FIN IN NUMBER) IS
      SELECT 1 CANTIDAD,
             NVL(DCON_PORC_IVA, 0) PORC_IVA,
             DECODE(NVL(DCON_PORC_IVA, 0),
                    0,
                    SUM(DCON_EXEN_MON + DCON_GRAV_MON + DCON_IVA_MON),
                    SUM(DCON_GRAV_MON + DCON_IVA_MON)) TOTAL,
             DECODE(NVL(DCON_PORC_IVA, 0),
                    0,
                    'Ventas Exentas',
                    DECODE(NVL(DCON_PORC_IVA, 0),
                           5,
                           'Ventas al 5%',
                           'Ventas al 10%')) DESCRIPCION
        FROM FIN_DOC_CONCEPTO_COMI015_TEMP
       WHERE DCON_CLAVE_DOC = P_CLAVE_FIN
         AND DCON_EMPR = I_EMPRESA
       GROUP BY DCON_PORC_IVA;

    --VARIABLES
    V_PROVEEDOR     NUMBER;
    V_GRANO_O_PRIM  NUMBER;
    V_NC_ITEM       NUMBER;
    V_TOTAL_FACT    NUMBER;
    V_TOTAL_FACT_NC NUMBER;
    V_PORC_ITEM     NUMBER;
    V_IVA_FACT      NUMBER;
    V_RETE_PORC     NUMBER;
    V_RETE_TOTAL    NUMBER := 0;
    V_TOTA_IVA      NUMBER := 0;
    V_IVA_PORC      NUMBER;
    V_DOC_MON       NUMBER;
    V_COTIZACION    NUMBER;
    V_MON_DEC       NUMBER;
    V_IVA_5_CANT    NUMBER;

  BEGIN

    IF NVL(I_P_TABLA, 'D') = 'D' THEN

      SELECT DOC_PROV,
             (DOC_NETO_EXEN_MON + DOC_NETO_GRAV_MON + DOC_IVA_MON) TOTAL_FACT,
             DOC_IVA_MON IVA,
             DOC_MON
        INTO V_PROVEEDOR, V_TOTAL_FACT, V_IVA_FACT, V_DOC_MON
        FROM FIN_DOCUMENTO
       WHERE DOC_CLAVE = I_CLAVE_DOC
         AND DOC_EMPR = I_EMPRESA;

      SELECT COUNT(*) CANT
        INTO V_IVA_5_CANT
        FROM FIN_DOC_CONCEPTO C
       WHERE DCON_CLAVE_DOC = I_CLAVE_DOC
         AND DCON_EMPR = I_EMPRESA
         AND C.DCON_PORC_IVA = 5;

      IF V_IVA_5_CANT > 0 THEN
        SELECT COUNT(*)
          INTO V_GRANO_O_PRIM
          FROM STK_DOCUMENTO_DET D, STK_ARTICULO SA
         WHERE D.DETA_ART = SA.ART_CODIGO
           AND D.DETA_EMPR = SA.ART_EMPR
           AND NVL(SA.ART_IND_DER_PRIM, 'N') = 'S'
           AND (DETA_CLAVE_DOC, DETA_EMPR) IN
               (SELECT DOC_CLAVE_STK, DOC_EMPR
                  FROM FIN_DOCUMENTO
                 WHERE DOC_CLAVE = I_CLAVE_DOC
                   AND DOC_EMPR = I_EMPRESA)
           AND DETA_EMPR = I_EMPRESA;
      END IF;

      V_NC_ITEM := NVL(FIN_NC_FACTURA_REC(P_CLAVE     => I_CLAVE_DOC,
                                          P_PROVEEDOR => V_PROVEEDOR,
                                          P_EMPRESA   => I_EMPRESA),
                       0);

      V_TOTAL_FACT_NC := V_TOTAL_FACT - V_NC_ITEM;

      FOR FIN IN CUR_DOC_FIN(I_CLAVE_DOC) LOOP

        IF FIN.PORC_IVA = 5 THEN
          IF V_GRANO_O_PRIM > 0 THEN
            V_RETE_PORC := 0.1;
          ELSE
            V_RETE_PORC := 0.3;
          END IF;
          V_IVA_PORC := 21;
        ELSIF FIN.PORC_IVA = 10 THEN
          IF I_EMPRESA = 1 THEN
            V_RETE_PORC := 0.7;
          ELSE
            V_RETE_PORC := 0.3;
          END IF;
          V_IVA_PORC := 11;
        ELSE
          V_IVA_PORC  := 1;
          V_RETE_PORC := 0;
        END IF;

        V_PORC_ITEM  := ((FIN.CANTIDAD * FIN.TOTAL) / V_TOTAL_FACT) * 100; --PORCENTAJE
        V_TOTA_IVA   := ROUND((V_PORC_ITEM * V_TOTAL_FACT_NC) / 100) /
                        V_IVA_PORC;
        V_RETE_TOTAL := V_RETE_TOTAL + (V_TOTA_IVA * V_RETE_PORC);
      END LOOP;

    ELSE

      SELECT DOC_PROV,
             (DOC_NETO_EXEN_MON + DOC_NETO_GRAV_MON + DOC_IVA_MON) TOTAL_FACT,
             DOC_IVA_MON IVA,
             DOC_MON
        INTO V_PROVEEDOR, V_TOTAL_FACT, V_IVA_FACT, V_DOC_MON
        FROM FIN_DOCUMENTO_COMI015_TEMP
       WHERE DOC_CLAVE = I_CLAVE_DOC
         AND DOC_EMPR = I_EMPRESA;

      SELECT COUNT(*) CANT
        INTO V_IVA_5_CANT
        FROM FIN_DOC_CONCEPTO_COMI015_TEMP C
       WHERE DCON_CLAVE_DOC = I_CLAVE_DOC
         AND DCON_EMPR = I_EMPRESA
         AND C.DCON_PORC_IVA = 5;

      IF V_IVA_5_CANT > 0 THEN
        SELECT COUNT(*)
          INTO V_GRANO_O_PRIM
          FROM STK_DOCUMENTO_DET_COMI015_TEMP D, STK_ARTICULO SA
         WHERE D.DETA_ART = SA.ART_CODIGO
           AND D.DETA_EMPR = SA.ART_EMPR
           AND NVL(SA.ART_IND_DER_PRIM, 'N') = 'S'
           AND (DETA_CLAVE_DOC, DETA_EMPR) IN
               (SELECT DOC_CLAVE_STK, DOC_EMPR
                  FROM FIN_DOCUMENTO_COMI015_TEMP
                 WHERE DOC_CLAVE = I_CLAVE_DOC
                   AND DOC_EMPR = I_EMPRESA)
           AND DETA_EMPR = I_EMPRESA;
      END IF;

      V_NC_ITEM := 0;

      V_TOTAL_FACT_NC := V_TOTAL_FACT - V_NC_ITEM;

      FOR FIN IN CUR_DOC_TEMP(I_CLAVE_DOC) LOOP

        IF FIN.PORC_IVA = 5 THEN
          IF V_GRANO_O_PRIM > 0 THEN
            V_RETE_PORC := 0.1;
          ELSE
            V_RETE_PORC := 0.3;
          END IF;
          V_IVA_PORC := 21;
        ELSIF FIN.PORC_IVA = 10 THEN
          IF I_EMPRESA = 1 THEN
            V_RETE_PORC := 0.7;
          ELSE
            V_RETE_PORC := 0.3;
          END IF;
          V_IVA_PORC := 11;
        ELSE
          V_IVA_PORC  := 1;
          V_RETE_PORC := 0;
        END IF;

        V_PORC_ITEM  := ((FIN.CANTIDAD * FIN.TOTAL) / V_TOTAL_FACT) * 100; --PORCENTAJE
        V_TOTA_IVA   := ROUND((V_PORC_ITEM * V_TOTAL_FACT_NC) / 100) /
                        V_IVA_PORC;
        V_RETE_TOTAL := V_RETE_TOTAL + (V_TOTA_IVA * V_RETE_PORC);
      END LOOP;
    END IF;

    SELECT G.MON_DEC_IMP
      INTO V_MON_DEC
      FROM GEN_MONEDA G
     WHERE G.MON_CODIGO = V_DOC_MON
       AND G.MON_EMPR = I_EMPRESA;

    IF V_DOC_MON <> 1 THEN---lv 09/03/2022

    /*
      V_COTIZACION := FACI039.FP_COTIZACION(P_MONEDA      => V_DOC_MON,
                                            P_DOC_FEC_DOC => TRUNC(SYSDATE),
                                            P_EMPRESA     => I_EMPRESA);*/


         V_COTIZACION := ROUND(GEN_COT_TIPO_MOV(I_EMPRESA,V_DOC_MON,23, nvl(I_FEC_RET,TRUNC(SYSDATE))  ));

    ELSE
      V_COTIZACION := 1;
    END IF;


    IF NVL(V_COTIZACION,0) <= 1 AND V_DOC_MON <> 1 THEN
      RAISE_APPLICATION_ERROR (-20001,'Error en la cotizacion favor avisar al departamento de informatica');

    END IF;
    O_MONTO_RET_MON := ROUND(V_RETE_TOTAL, V_MON_DEC);
    O_MONTO_RET_LOC := ROUND(V_RETE_TOTAL * V_COTIZACION, V_MON_DEC);

  END PP_MONTO_RETENCION;


  function CF_TEXTO (MONEDA IN NUMBER,
                     IMPORTE_RECIBO IN NUMBER,
                     MON_SIMBOLO IN VARCHAR2) return Char is
    V_TEXTO VARCHAR2 (1500);
    begin
      V_TEXTO:='La suma de '||MON_SIMBOLO||': '||general.fp_conv_nro_txt(v_numero => IMPORTE_RECIBO,
                                                                          v_moneda => MONEDA)||'-.';

      RETURN V_TEXTO;
end;

END FINI003;
/
