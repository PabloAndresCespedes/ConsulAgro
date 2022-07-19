CREATE OR REPLACE VIEW PERI052_V AS
SELECT PER."FECHA",
       PER."SUCURSAL",
       PER."ORDEN_CONCEPTOS",
       PER."CONCEPTO",
       PER."NOMBRE",
       PER."IMPORTE",
       PER."EMPL_LEGAJO",
       PER."EMPL_FORMA_PAGO",
       PER."EMPL_DEPARTAMENTO",
       PER."EMPL_NRO_CTA",
       PER."EMPL_EMPRESA",
       PER."CLAVE_FINANZAS",
       CTA_CODIGO              COD_CAJA,
       CTA_DESC                CAJA,
       EMPL_BCO_PAGO,
       pcon_clave cod_concepto
  FROM (select per_documento.pdoc_fec fecha,
               e.empl_sucursal sucursal,
               per_concepto.pcon_orden orden_conceptos,
               per_concepto.pcon_clave,
               per_concepto.pcon_desc concepto,
               e.empl_nombre || ' ' || e.empl_ape nombre,
               round(decode(per_concepto.pcon_ind_dbcr,
                            'C',
                            per_documento_det.pddet_imp,
                            -per_documento_det.pddet_imp)) importe,
               empl_legajo,
               CASE WHEN empl_forma_pago =5 AND EMPL_EMPRESA=1 THEN --PARA QUE MENSUAL Y AMH SEAN IGUALES
               2
               ELSE
                 empl_forma_pago END
                empl_forma_pago,
               empl_departamento,
               TRIM(E.EMPL_NRO_CTA) EMPL_NRO_CTA,
               EMPL_EMPRESA,
               NVL(PDOC_CLAVE_FIN, PDDET_CLAVE_FIN) CLAVE_FINANZAS,
               EMPL_BCO_PAGO
          from per_documento,
               per_documento_det,
               per_concepto,
               per_empleado e
         WHERE PER_DOCUMENTO_DET.PDDET_CLAVE_CONCEPTO =
               PER_CONCEPTO.PCON_CLAVE
           AND PER_DOCUMENTO_DET.PDDET_EMPR = PER_CONCEPTO.PCON_EMPR

           AND PER_DOCUMENTO.PDOC_EMPR != 2 -- @PabloACespedes 19/07/2022 17.00hs
           AND PER_DOCUMENTO.PDOC_CLAVE = PER_DOCUMENTO_DET.PDDET_CLAVE_DOC
           AND PER_DOCUMENTO.PDOC_EMPR = PER_DOCUMENTO_DET.PDDET_EMPR

           AND PER_DOCUMENTO.PDOC_EMPLEADO = E.EMPL_LEGAJO
           AND PER_DOCUMENTO.PDOC_EMPR = E.EMPL_EMPRESA
          -- and empl_situacion='A'
          --  AND EMPL_BCO_PAGO=3
           AND EMPL_FORMA_PAGO IN (1,2,5,3)
          -- AND PCON_CANCELADO_POR_CONC IS NULL
           ) PER,
       fin_documento f,
       FIN_CUENTA_BANCARIA G
 WHERE CLAVE_FINANZAS = DOC_CLAVE(+)
   AND EMPL_EMPRESA = DOC_EMPR(+)
   AND DOC_CTA_BCO = CTA_CODIGO(+)
   AND DOC_EMPR = CTA_EMPR(+)
;
