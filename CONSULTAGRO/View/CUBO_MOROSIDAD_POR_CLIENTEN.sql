CREATE OR REPLACE VIEW CUBO_MOROSIDAD_POR_CLIENTEN AS
SELECT SUCURSAL,
       CODIGO_VENDEDOR,
       VENDEDORASIGNADO,
       ZONA,
       CLIENTE_CODIGO,
       CLIENTE_NOMBRE,
       CLIENTE_TELEFONO,
       HOLDING_CODIGO,
       SUP_COBRADOR,
       SUPERVISOR_NOMBRE,
       CLI_COBRADOR,
       NOMBRE_COBRADOR,
       HOLDING_DESCRIPCION,
       CONDICION_CLI,
       FACTURAS_PENDIENTES_PER,
       FACTURAS_PENDIENTES,
       CLIENTE_CONTACTO,
       CANT_EXCEPCIONES,
       SUM(MAYOR90) MAYOR90,
       SUM(ENTRE61Y90) ENTRE61Y90,
       SUM(ENTRE31Y60) ENTRE31Y60,
       SUM(ENTRE0Y30) ENTRE0Y30,
       SUM(AVENCER) AVENCER,
       SUM(ENTRE1Y15) ENTRE1Y15,
       SUM(ENTRE16Y30) ENTRE16Y30,
       SUM(SALDO) SALDO,
       LINEA_CREDITO,
       CASE
         WHEN NVL(HOL_LIMITE_CRED, 0) - SUM(SALDO) - NVL(CHEQUES,0) > 0 THEN
          NVL(HOL_LIMITE_CRED, 0) - SUM(SALDO) - NVL(CHEQUES,0)
         ELSE
          0
       END LINEA_DISPONIBLE,
       CHEQUES,
       PAGO_HACE_1_SEMANA,
       PAGO_HACE_2_SEMANA,
       PAGO_HACE_3_SEMANA,
       PAGO_HACE_4_SEMANA,
       CLI_OBS,
       CLI_CATEGORIA,
       OBS_FACTURA,
       SUM(INTERES) INTERESES,
       OBS,
       CANAL_CLI CANAL_CLI,
       IMPRIMIR_PAGARE,
       CLI_RAMO,
       HOLDING,
       CHEQUES_RECHAZADOS,
       NUMERO_SEMANA ,
       PLAZO_PAGO  ,
       PLAZO_CHEQ ,
       CAST(SC_NRO as varchar2(4000)) sc_nro,
       CAST(SC_ESTADO as varchar2(4000)) SC_ESTADO
  FROM CUBO_MOROSIDAD_POR_CLIENTEN_PR
  GROUP BY SUCURSAL,
       CODIGO_VENDEDOR,
       VENDEDORASIGNADO,
       ZONA,
       CLIENTE_CODIGO,
       CLIENTE_NOMBRE,
       CLIENTE_TELEFONO,
       HOLDING_CODIGO,
       SUP_COBRADOR,
       SUPERVISOR_NOMBRE,
       CLI_COBRADOR,
       NOMBRE_COBRADOR,
       HOLDING_DESCRIPCION,
       CONDICION_CLI,
       FACTURAS_PENDIENTES_PER,
       FACTURAS_PENDIENTES,
       CLIENTE_CONTACTO,
       CANT_EXCEPCIONES,
       LINEA_CREDITO,
       CHEQUES,
       PAGO_HACE_1_SEMANA,
       PAGO_HACE_2_SEMANA,
       PAGO_HACE_3_SEMANA,
       PAGO_HACE_4_SEMANA,
       CLI_OBS,
       CLI_CATEGORIA,
       OBS_FACTURA,
       OBS,
       CANAL_CLI,
       IMPRIMIR_PAGARE,
       CLI_RAMO,
       HOLDING,
       CHEQUES_RECHAZADOS,
       NUMERO_SEMANA,
       HOL_LIMITE_CRED ,
       PLAZO_PAGO  ,
       PLAZO_CHEQ  ,
       CAST(SC_NRO as varchar2(4000))  ,
       CAST(SC_ESTADO as varchar2(4000));