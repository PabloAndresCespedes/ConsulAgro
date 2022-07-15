CREATE OR REPLACE TRIGGER "FIN_DOC_BE_IDU"
  BEFORE INSERT OR DELETE OR UPDATE OF DOC_EMPR, DOC_TIPO_SALDO, DOC_CTA_BCO, DOC_NETO_EXEN_MON, DOC_NETO_GRAV_MON, DOC_IVA_MON, DOC_NETO_EXEN_LOC, DOC_NETO_GRAV_LOC, DOC_IVA_LOC, DOC_FEC_OPER, DOC_FEC_DOC, DOC_CLI, DOC_MON, DOC_EST_CHEQUE, DOC_CHEQUE_CERTIF, DOC_TIPO_MOV, DOC_PROV ON FIN_DOCUMENTO
  REFERENCING OLD AS O NEW AS N
  FOR EACH ROW

DECLARE
  V_IND_TIENE_SALDO  GEN_TIPO_MOV.TMOV_IND_TIENE_SALDO%TYPE;
  V_IND_CTA_BCO_NULL GEN_TIPO_MOV.TMOV_IND_CTA_BCO_NULL%TYPE;
  V_CONF_FEC_LIM_MOD DATE;
  V_CONF_PER_ACT_FIN DATE;
  V_CLAVE            NUMBER;
  v_tasa              NUMBER;

  V_IND_IMPR NUMBER := 0;
BEGIN

  IF :N.DOC_EMPR = 2 OR :O.DOC_EMPR = 2 THEN
    ------------INICIA TAGRO
    DECLARE
      V_IND_TIENE_SALDO  GEN_TIPO_MOV.TMOV_IND_TIENE_SALDO%TYPE;
      V_IND_CTA_BCO_NULL GEN_TIPO_MOV.TMOV_IND_CTA_BCO_NULL%TYPE;
      V_CONF_FEC_LIM_MOD DATE;
      V_CONF_PER_ACT_FIN DATE;
      V_LOC              NUMBER;
      V_MON              NUMBER;
      V_CANT_FACT        NUMBER;
      V_FECHA            DATE;
    BEGIN

      IF INSERTING THEN

        :N.DOC_FEC_GRAB := SYSDATE;

        /*   SELECT TO_DATE(TO_CHAR(:N.DOC_FEC_DOC, 'DD/MM') || '/' ||
                      TO_CHAR(TO_DATE(EXTRACT(YEAR FROM to_date(:N.DOC_FEC_DOC,
                                                      'dd/mm/yy')),
                                      'YY'),
                              'YYYY'),
                      'DD/MM/YYYY')
         INTO V_FECHA
         FROM dual;
        :N.DOC_FEC_DOC := V_FECHA;*/
        ------------------------------------------------------------------------------------------
        IF :N.DOC_TIPO_MOV = 31 AND :N.DOC_PRODUCTO_ACO IS NOT NULL AND
           :N.DOC_LINEA_CREDITO IS NULL THEN
          RAISE_APPLICATION_ERROR(-20000,
                                  'Error al registrar el Anticipo [TM31] - Debe tener linea de credito asignada!');
        END IF;
        ------------------------------------------------------------------------------------------
        IF :N.DOC_TIPO_MOV = 31 AND :N.DOC_PLAN_PAGO IS NOT NULL THEN
          UPDATE FIN_PLANIFICACION_PAGO PL
             SET PL.PLPA_IND_PAGADO   = 'S',
                 PL.PLPA_DESEMBOLSADO = PL.PLPA_DESEMBOLSADO +
                                        (:N.DOC_NETO_EXEN_MON +
                                        :N.DOC_NETO_GRAV_MON +
                                        NVL(:N.DOC_IVA_MON, 0))
           WHERE PL.PLPA_CLAVE = :N.DOC_PLAN_PAGO
             AND PL.PLPA_EMPR = 2;
        END IF;
        ------------------------------------------------------------------------------------------
        IF :N.DOC_TIPO_MOV IN (09, -- CO_FIN.CONF_FACT_CO_EMIT,
                               10, -- CO_FIN.CONF_FACT_CR_EMIT,
                               15, -- CO_FIN.CONF_NOTA_DB_EMIT,
                               56, -- CO_FIN.CONF_NOTA_DB_EMIT_PROV,
                               46, -- CO_FIN.CONF_FACT_CR_EMIT_AJUSTE,
                               42, -- CO_FIN.CONF_TMOV_ORDEN_COMPRA,
                               ----------------------------------------------------
                               14, -- CO_FIN.CONF_NOTA_CR_REC,
                               44, -- CO_FIN.CONF_NOTA_CR_REC_AJUSTE,
                               31 -- CO_FIN.CONF_ADELANTO_PRO
                               ----------------------------------------------------
                               ) THEN
          --=======================================================================
          IF :N.DOC_CONC_CRED IS NULL THEN

            IF :N.DOC_TIPO_MOV = 31 THEN
              :N.DOC_CONC_CRED := 1; -- EFECTIVO
            ELSE
              IF :N.DOC_LINEA_NEGOCIO IS NOT NULL THEN
                SELECT NVL(LN.LIN_CONC_CREDITO, 4)
                  INTO :N.DOC_CONC_CRED
                  FROM FAC_LINEA_NEGOCIO LN
                 WHERE LN.LIN_CODIGO = :N.DOC_LINEA_NEGOCIO
                   AND LN.LIN_EMPR = 2;
              ELSE
                :N.DOC_CONC_CRED := 4; -- OTROS
              END IF;
            END IF;

          END IF;
          --=======================================================================
          IF :N.DOC_PRODUCTO_ACO IS NOT NULL AND
             :N.DOC_TIPO_CREDITO IS NULL THEN
            :N.DOC_TIPO_CREDITO := 1; -- CREDITO COSECHA..
          END IF;
          --=======================================================================
        END IF;
        ------------------------------------------------------------------------------------------

        -- Actualizar los saldos en FIN_SAL_CTA_BCO

        IF :N.DOC_CTA_BCO IS NOT NULL THEN
          FIN_ACT_CTA_BCO(:N.DOC_EMPR,
                          'I',
                          :N.DOC_TIPO_SALDO,
                          :N.DOC_CTA_BCO,
                          (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                          :N.DOC_IVA_MON),
                          (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                          :N.DOC_IVA_LOC),
                          :N.DOC_FEC_OPER,
                          :N.DOC_FEC_DOC,
                          :N.DOC_MON);
        END IF;

        -- Actualizar los saldos en FIN_CLI_EMPRESA

        IF :N.DOC_TIPO_MOV IS NULL THEN
          RAISE_APPLICATION_ERROR(-20000, :N.DOC_CLAVE);
        END IF;

        FIN_ACT_CLEM(:N.DOC_EMPR,
                     'I',
                     :N.DOC_TIPO_MOV,
                     :N.DOC_CTA_BCO,
                     :N.DOC_CLI,
                     :N.DOC_MON,
                     :N.DOC_FEC_DOC,
                     :N.DOC_EST_CHEQUE,
                     :N.DOC_CHEQUE_CERTIF,
                     (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                     :N.DOC_IVA_LOC),
                     (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                     :N.DOC_IVA_MON));

        -- Actualizar los saldos de operacion del cliente en FIN_CLI_EMPRESA
        -- esto solamente se hace al insertar, lastimosamente al borrar ya
        -- quedan los datos, porque no se puede saber lo que habia antes

        FIN_ACT_CLEM_OPER(:N.DOC_EMPR,
                          'I',
                          :N.DOC_TIPO_MOV,
                          :N.DOC_FEC_DOC,
                          :N.DOC_CLI,
                          :N.DOC_MON,
                          (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                          :N.DOC_IVA_LOC),
                          (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                          :N.DOC_IVA_MON));

        -- Actualizar los saldos en FIN_PROV_EMPRESA
        FIN_ACT_PREM(:N.DOC_EMPR,
                     'I',
                     :N.DOC_TIPO_MOV,
                     :N.DOC_CTA_BCO,
                     :N.DOC_PROV,
                     :N.DOC_MON,
                     :N.DOC_FEC_DOC,
                     (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                     :N.DOC_IVA_LOC),
                     (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                     :N.DOC_IVA_MON));

        -- Actualizar el saldo de FIN_DOCUMENTO.21/08/1998.Luis Fedriani
        -- No se puede hacer en un procedimiento, porque perdemos el ':N'

        SELECT TMOV_IND_TIENE_SALDO, TMOV_IND_CTA_BCO_NULL
          INTO V_IND_TIENE_SALDO, V_IND_CTA_BCO_NULL
          FROM GEN_TIPO_MOV
         WHERE TMOV_CODIGO = :N.DOC_TIPO_MOV
           AND TMOV_EMPR = 2;
        SELECT CONF_FEC_LIM_MOD, CONF_PER_ACT_FIN
          INTO V_CONF_FEC_LIM_MOD, V_CONF_PER_ACT_FIN
          FROM FIN_CONFIGURACION
         WHERE CONF_EMPR = 2;

        IF V_IND_TIENE_SALDO = 'S' AND
           (:N.DOC_CTA_BCO IS NULL OR V_IND_CTA_BCO_NULL = 'N') THEN
           IF :N.DOC_TIPO_MOV <> 1 THEN --PUESTO PORQUE NO CALCULABA CORRECTAMENTE EL SALDO SI EL DOC. GENERABA RETENCION
          :N.DOC_SALDO_LOC     := NVL(:N.DOC_NETO_EXEN_LOC, 0) +
                                  NVL(:N.DOC_NETO_GRAV_LOC, 0) +
                                  NVL(:N.DOC_IVA_LOC, 0);
          :N.DOC_SALDO_MON     := NVL(:N.DOC_NETO_EXEN_MON, 0) +
                                  NVL(:N.DOC_NETO_GRAV_MON, 0) +
                                  NVL(:N.DOC_IVA_MON, 0);
           END IF;
          :N.DOC_SALDO_INI_MON := NVL(:N.DOC_NETO_EXEN_MON, 0) +
                                  NVL(:N.DOC_NETO_GRAV_MON, 0) +
                                  NVL(:N.DOC_IVA_MON, 0);
          IF :N.DOC_FEC_DOC BETWEEN V_CONF_FEC_LIM_MOD AND
             V_CONF_PER_ACT_FIN THEN
            :N.DOC_SALDO_PER_ACT_LOC := :N.DOC_SALDO_LOC;
            :N.DOC_SALDO_PER_ACT_MON := :N.DOC_SALDO_MON;
          ELSE
            :N.DOC_SALDO_PER_ACT_LOC := 0;
            :N.DOC_SALDO_PER_ACT_MON := 0;
          END IF;
        END IF;
        /*COMENTO EL CODIGO DE NUEVO POR QUE AL FINAL TODOS LOS TM:26 DEBE DE TENER SALDO 25/04/2020*/
        /*  IF :N.DOC_TIPO_MOV = 26 AND :N.DOC_EMPR = 2 THEN
          BEGIN
            FOR X IN (SELECT C.FCON_IND_CLAVE_IMPORTACION
                        FROM FIN_DOC_CONCEPTO_TMP T, FIN_CONCEPTO C
                       WHERE T.DCON_CLAVE_CONCEPTO = C.FCON_CLAVE
                         AND T.DCON_EMPR = C.FCON_EMPR
                         AND T.DCON_CLAVE_DOC = :N.DOC_CLAVE) LOOP
              IF X.FCON_IND_CLAVE_IMPORTACION = 'S' THEN
                V_IND_IMPR := V_IND_IMPR + 1;
              END IF;
            END LOOP;
            IF V_IND_IMPR = 0 THEN
              :N.DOC_SALDO_LOC         := 0;
              :N.DOC_SALDO_MON         := 0;
              :N.DOC_SALDO_INI_MON     := 0;
              :N.DOC_SALDO_PER_ACT_LOC := 0;
              :N.DOC_SALDO_PER_ACT_MON := 0;
            END IF;
          EXCEPTION
            WHEN OTHERS THEN
              NULL;
          END;
        END IF;*/

        --LAS AUTOFACTURAS QUE TENGAN BANCO, NO DEBEN GENERAR SALDOS
        IF :N.DOC_TIPO_MOV = 7 AND :N.DOC_EMPR = 2 AND
           :N.DOC_CTA_BCO IS NOT NULL THEN
          :N.DOC_SALDO_LOC         := 0;
          :N.DOC_SALDO_MON         := 0;
          :N.DOC_SALDO_INI_MON     := 0;
          :N.DOC_SALDO_PER_ACT_LOC := 0;
          :N.DOC_SALDO_PER_ACT_MON := 0;
        END IF;
      ELSIF DELETING Then
   --VERIFICAR SI EL DOC. TIENE REGISTRO EN EL DETALLE DE LA LIQUIDACION YA QUE SE ESTi?? PUDIENDO ANULAR 
        --DOCUMENTOS IGUAL LIQUIDADOS
        DECLARE
          V_LIQ_NUMERO VARCHAR2(32767);
        BEGIN
          SELECT WM_CONCAT(B.LIQ_NUMERO)LIQ_NUMERO
            INTO V_LIQ_NUMERO
            FROM FIN_LIQUID_CUENTA_DET A, FIN_LIQUID_CUENTA B
           WHERE A.LIQD_CLAVE_DOC = :O.DOC_CLAVE
             AND A.LIQD_EMPR = 2
             AND (NVL(A.LIQD_MONTO_CAN_M, 0) > 0 OR NVL(A.LIQD_MONTO_CAN_L, 0) > 0)
                
             AND A.LIQD_CLAVE = B.LIQ_CLAVE
             AND A.LIQD_EMPR = B.LIQ_EMPR;
        
          IF V_LIQ_NUMERO IS NOT NULL THEN
          
            RAISE_APPLICATION_ERROR(-20001,
                                    'Favor primero anular la liquidacion numero : ' ||
                                    V_LIQ_NUMERO ||
                                    ' luego anular el documento.');
          
          END IF;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
        END;
      
        ------------------------------------------------------------------------------------------------------------------------------------

        ------------------------------------------------------------------------------------------------------------------------------------
        IF :O.DOC_TIPO_MOV = 31 AND :O.DOC_PLAN_PAGO IS NOT NULL THEN

          UPDATE FIN_PLANIFICACION_PAGO PL
             SET PL.PLPA_IND_PAGADO   = 'N',
                 PL.PLPA_DESEMBOLSADO = PL.PLPA_DESEMBOLSADO -
                                        (:O.DOC_NETO_EXEN_MON +
                                        :O.DOC_NETO_GRAV_MON +
                                        NVL(:O.DOC_IVA_MON, 0))
           WHERE PL.PLPA_CLAVE = :O.DOC_PLAN_PAGO
             AND PL.PLPA_EMPR = :O.DOC_EMPR;

        END IF;
        ------------------------------------------------------------------------------------------------------------------------------------
        -- Insertar en la tabla de auditoria de documentos
        INSERT INTO FIN_AUD_DOCUMENTO
          (ADOC_CLAVE,
           ADOC_EMPR,
           ADOC_CTA_BCO,
           ADOC_TIPO_MOV,
           ADOC_TIPO_SALDO,
           ADOC_NRO_DOC,
           ADOC_SUC,
           ADOC_DPTO,
           ADOC_MON,
           ADOC_PROV,
           ADOC_CLI,
           ADOC_LEGAJO,
           ADOC_CLI_NOM,
           ADOC_CLI_DIR,
           ADOC_CLI_TEL,
           ADOC_CLI_RUC,
           ADOC_NRO_CHEQ,
           ADOC_BCO_CHEQUE,
           ADOC_EST_CHEQUE,
           ADOC_FEC_DEP_CHEQUE,
           ADOC_NRO_DOC_DEP,
           ADOC_CHEQUE_CERTIF,
           ADOC_FEC_OPER,
           ADOC_FEC_DOC,
           ADOC_FEC_CHEQUE,
           ADOC_BRUTO_GRAV_LOC,
           ADOC_BRUTO_GRAV_MON,
           ADOC_BRUTO_EXEN_LOC,
           ADOC_BRUTO_EXEN_MON,
           ADOC_NETO_GRAV_LOC,
           ADOC_NETO_GRAV_MON,
           ADOC_NETO_EXEN_LOC,
           ADOC_NETO_EXEN_MON,
           ADOC_IVA_LOC,
           ADOC_IVA_MON,
           ADOC_BASE_IMPON_LOC,
           ADOC_BASE_IMPON_MON,
           ADOC_SALDO_LOC,
           ADOC_SALDO_MON,
           ADOC_OBS,
           ADOC_FEC_ANUL,
           ADOC_LOGIN_ANUL,
           ADOC_LOGIN,
           ADOC_FEC_GRAB,
           ADOC_SIST,
           ADOC_OPERADOR,
           ADOC_COBRADOR,
           ADOC_CLAVE_LIQUID,
           ADOC_OPER_LIQUID,
           ADOC_PORC_INTERES,
           ADOC_LINEA_NEGOCIO,
           ADOC_CATEG_ANTICIPO,
           ADOC_TIPO_FEC_INT,
           ADOC_CATEG_COM,
           ADOC_CTACO,
           ADOC_TIMBRADO,
           ADOC_REMISION,
           ADOC_TIMBRADO_REM,
           ADOC_CLAVE_REM)
        VALUES
          (:O.DOC_CLAVE,
           :O.DOC_EMPR,
           :O.DOC_CTA_BCO,
           :O.DOC_TIPO_MOV,
           :O.DOC_TIPO_SALDO,
           :O.DOC_NRO_DOC,
           :O.DOC_SUC,
           :O.DOC_DPTO,
           :O.DOC_MON,
           :O.DOC_PROV,
           :O.DOC_CLI,
           :O.DOC_LEGAJO,
           :O.DOC_CLI_NOM,
           :O.DOC_CLI_DIR,
           :O.DOC_CLI_TEL,
           :O.DOC_CLI_RUC,
           :O.DOC_NRO_CHEQUE,
           :O.DOC_BCO_CHEQUE,
           :O.DOC_EST_CHEQUE,
           :O.DOC_FEC_DEP_CHEQUE,
           :O.DOC_NRO_DOC_DEP,
           :O.DOC_CHEQUE_CERTIF,
           :O.DOC_FEC_OPER,
           :O.DOC_FEC_DOC,
           :O.DOC_FEC_CHEQUE,
           :O.DOC_BRUTO_GRAV_LOC,
           :O.DOC_BRUTO_GRAV_MON,
           :O.DOC_BRUTO_EXEN_LOC,
           :O.DOC_BRUTO_EXEN_MON,
           :O.DOC_NETO_GRAV_LOC,
           :O.DOC_NETO_GRAV_MON,
           :O.DOC_NETO_EXEN_LOC,
           :O.DOC_NETO_EXEN_MON,
           :O.DOC_IVA_LOC,
           :O.DOC_IVA_MON,
           :O.DOC_BASE_IMPON_LOC,
           :O.DOC_BASE_IMPON_MON,
           :O.DOC_SALDO_LOC,
           :O.DOC_SALDO_MON,
           :O.DOC_OBS,
           SYSDATE,
           SUBSTR(GEN_DEVUELVE_USER, 1, 8),
           :O.DOC_LOGIN,
           :O.DOC_FEC_GRAB,
           :O.DOC_SIST,
           :O.DOC_OPERADOR,
           :O.DOC_COBRADOR,
           :O.DOC_CLAVE_LIQUID,
           :O.DOC_OPER_LIQUID,
           :O.DOC_PORC_INTERES,
           :O.DOC_LINEA_NEGOCIO,
           :O.DOC_CATEG_ANTICIPO,
           :O.DOC_TIPO_FEC_INT,
           :O.DOC_CATEG_COM,
           :O.DOC_CTACO,
           :O.DOC_NRO_TIMBRADO,

           :O.DOC_REMISION,
           :O.DOC_TIMBRADO_REM,
           :O.DOC_CLAVE_REM);

        --PARA DOCUMENTOS AULADOS
        if :O.DOC_EMPR = 2 then
          INSERT INTO FIN_DOC_ANULADO
            (ANUL_TIPO_MOV,
             ANUL_NRO_DOC,
             ANUL_EMPR,
             ANUL_SUC,
             ANUL_CLI_PROV,
             ANUL_FEC_DOC,
             ANUL_MOTIVO,
             ANUL_OBS,
             ANUL_NRO_TIMBRADO)
          VALUES
            (:O.DOC_TIPO_MOV,
             :O.DOC_NRO_DOC,
             :O.DOC_EMPR,
             :O.DOC_SUC,
            nvl(:O.DOC_CLI,:O.DOC_PROV),
             :O.DOC_FEC_DOC,
             NULL,
             :O.DOC_OBS,
             :O.DOC_NRO_TIMBRADO);
        end if;

        --Eliminar Registro de Pagare
        FIN_ACT_PAGARE(:O.DOC_CLAVE, :O.DOC_EMPR);

        -- Actualizar los saldos en FIN_SAL_CTA_BCO
        IF :O.DOC_CTA_BCO IS NOT NULL THEN
          FIN_ACT_CTA_BCO(:O.DOC_EMPR,
                          'D',
                          :O.DOC_TIPO_SALDO,
                          :O.DOC_CTA_BCO,
                          (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                          :O.DOC_IVA_MON),
                          (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                          :O.DOC_IVA_LOC),
                          :O.DOC_FEC_OPER,
                          :O.DOC_FEC_DOC,
                          :O.DOC_MON);
        END IF;

        -- Actualizar los saldos en FIN_CLI_EMPRESA
        FIN_ACT_CLEM(:O.DOC_EMPR,
                     'D',
                     :O.DOC_TIPO_MOV,
                     :O.DOC_CTA_BCO,
                     :O.DOC_CLI,
                     :O.DOC_MON,
                     :O.DOC_FEC_DOC,
                     :O.DOC_EST_CHEQUE,
                     :O.DOC_CHEQUE_CERTIF,
                     (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                     :O.DOC_IVA_LOC),
                     (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                     :O.DOC_IVA_MON));

        -- Actualizar los saldos en FIN_PROV_EMPRESA
        FIN_ACT_PREM(:O.DOC_EMPR,
                     'D',
                     :O.DOC_TIPO_MOV,
                     :O.DOC_CTA_BCO,
                     :O.DOC_PROV,
                     :O.DOC_MON,
                     :O.DOC_FEC_DOC,
                     (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                     :O.DOC_IVA_LOC),
                     (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                     :O.DOC_IVA_MON));

        --Para el modulo de transporte
        UPDATE TRA_ORDEN_CARGA C
           SET C.OCA_CLAVE_FIN_PAGO = NULL
         WHERE C.OCA_CLAVE_FIN_PAGO = :O.DOC_CLAVE
           AND C.OCA_EMPR = :O.DOC_EMPR;
        UPDATE TRA_OCARGA_PROD O
           SET O.OCP_CLAVE_COBRO = NULL
         WHERE O.OCP_CLAVE_COBRO = :O.DOC_CLAVE
           AND O.OCP_EMPR = :O.DOC_EMPR;

        --Revertir Registros para Facturas de Canon de Monsanto.
        Update fin_monsanto_factura m Set
        m.fact_estado='P',
        m.fact_clave_liq=Null
        Where m.fact_empr=:O.DOC_EMPR
        And m.fact_clave_liq=:O.DOC_CLAVE;



        --Anular retenciones emitidas para TESAKA en FIN_RETENION_IVA.
        IF :O.DOC_TIPO_MOV IN (23, 62, 64) THEN
          DELETE FROM FIN_RETENCION
           WHERE RET_RET_CLAVE = :O.DOC_CLAVE
             AND RET_EMPR = :O.DOC_EMPR;
        END IF;
        --ACTUALIZAR DESVINCULA EL DOCUMENTO DE UN PRE-CARGA DE COMBUSTIBLE EN GASTOS
        UPDATE STK_PRE_DOCUMENTO
           SET PRED_CLAVE_DOC = NULL
         WHERE PRED_CLAVE_DOC = :O.DOC_CLAVE
           AND PRED_EMPR = :O.DOC_EMPR;
        --Anular documentos de compras recosteadas.
        DELETE FROM FIN_COMPRA_GASTO
         WHERE GACO_CLAVE_FIN = :O.DOC_CLAVE
           AND GACO_EMPR = :O.DOC_EMPR;
        --Anular asientos contables dependientes del documento de Finanzas actual.
        DELETE FROM CNT_ASIENTO_DET
         WHERE ASID_EMPR = :O.DOC_EMPR
           AND ASID_CLAVE_ASI IN
               (SELECT ASI_CLAVE
                  FROM CNT_ASIENTO
                 WHERE ASI_EMPR = :O.DOC_EMPR
                   AND ASI_FIN_CLAVE = :O.DOC_CLAVE);
        DELETE FROM CNT_ASIENTO
         WHERE ASI_EMPR = :O.DOC_EMPR
           AND ASI_FIN_CLAVE = :O.DOC_CLAVE;

        --------------------
        ----DE LOS TEMPORALES
        IF :O.DOC_TIPO_MOV IN (1, 2, 80, 81, 26) THEN
          DELETE FROM STK_DOCUMENTO_DET_TMP A
           WHERE A.DETA_CLAVE_TMP = :O.DOC_CLAVE
             AND A.DETA_EMPR = :O.DOC_EMPR;
          DELETE FROM STK_DOCUMENTO_TMP B
           WHERE B.DOCU_CLAVE_TMP = :O.DOC_CLAVE
             AND B.DOCU_EMPR = :O.DOC_EMPR;
          DELETE FROM COM_DOCUMENTO_DET_TMP
           WHERE DETC_CLAVE_TMP = :O.DOC_CLAVE
             AND DETC_EMPR = :O.DOC_EMPR;
          DELETE FROM STK_ART_SERIE_TMP
           WHERE SER_CLAVE_TMP = :O.DOC_CLAVE
             AND SER_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_PAGO_TMP C
           WHERE C.PAG_CLAVE_TMP = :O.DOC_CLAVE
             AND C.PAG_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_CUOTA_TMP D
           WHERE D.CUO_CLAVE_DOC = :O.DOC_CLAVE
             AND D.CUO_EMPR = :O.DOC_EMPR;
          DELETE FROM ACO_FIJACION_TMP E
           WHERE E.FIJ_CLAVE_TMP = :O.DOC_CLAVE
             AND E.FIJ_EMPR = :O.DOC_EMPR;
          DELETE FROM ACO_DOCUMENTO_TMP F
           WHERE F.DOC_CLAVE_TMP = :O.DOC_CLAVE
             AND F.DOC_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_DOC_LINEA_NEG_TMP G
           WHERE G.DOCL_CLAVE = :O.DOC_CLAVE
             AND G.DOCL_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_RETENCION_TMP H
           WHERE H.RET_CLAVE_TMP = :O.DOC_CLAVE
             AND H.RET_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_CHEQUE_DOCUMENTO_TMP G
           WHERE G.CHDO_CLAVE_DOC = :O.DOC_CLAVE
             AND G.CHDO_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_PAGARE_FORMA_PAGO_TMP M
           WHERE M.PFP_DOC_CLAVE = :O.DOC_CLAVE
             AND M.PFP_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_CHEQUE_TMP I
           WHERE I.CHEQ_CLAVE IN
                 (SELECT CHDO_CLAVE_CHEQ
                    FROM FIN_CHEQUE_DOCUMENTO_TMP
                   WHERE CHDO_CLAVE_DOC = :O.DOC_CLAVE
                     AND CHDO_EMPR = :O.DOC_EMPR)
             AND I.CHEQ_EMPR = :O.DOC_EMPR;
          DELETE FROM CNT_DOC_ESTADO_APROB J
           WHERE J.DOCESTA_CLAVE_DOC = :O.DOC_CLAVE
             AND J.DOCESTA_EMPR = :O.DOC_EMPR;
          DELETE FROM FAC_DOCUMENTO_DET_TMP
           WHERE DET_CLAVE_TMP = :O.DOC_CLAVE
             AND DET_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_DOC_CONCEPTO_TMP
           WHERE DCON_CLAVE_TMP = :O.DOC_CLAVE
             AND DCON_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_DOCUMENTO_TMP
           WHERE DOC_CLAVE_TMP = :O.DOC_CLAVE
             AND DOC_EMPR = :O.DOC_EMPR;
          -- DELETE FROM tra_orden_carga_tmp WHERE clave_tmp = :O.doc_clave and empr = :o.doc_empr;
          DELETE FROM TRA_OCARGA_PROD_TMP
           WHERE OCP_CLAVE_TMP = :O.DOC_CLAVE
             AND OCP_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_COMPRA_OC_COMB_TMP
           WHERE CLAVE_TMP = :O.DOC_CLAVE
             AND CLAVE_EMPR = :O.DOC_EMPR;
          DELETE FROM TAL_OT_ARTICULO_TMP E
           WHERE E.TAR_CLAVE_TMP = :O.DOC_CLAVE
             AND E.TAR_EMPR = :O.DOC_EMPR;
          DELETE FROM FIN_FAC_NC_TMP 
            WHERE CLAVE_TMP = :O.DOC_CLAVE
            AND EMPR =   :O.DOC_EMPR;
          UPDATE COM_FACTURA_REC
             SET FAC_CLAVE_DOC_FIN = NULL, FAC_VER_CONT = 'N'
           WHERE FAC_CLAVE_DOC_FIN = :O.DOC_CLAVE
             AND FAC_EMPR = :O.DOC_EMPR;
        END IF;
        IF :O.DOC_TIPO_MOV in (9, 10) THEN
          BEGIN
            UPDATE FAC_PRESUPUESTO T
               SET T.FPRE_ESTADO = 'P', T.FPRE_CLAVE_DOC = NULL
             WHERE T.FPRE_CLAVE_DOC = :O.DOC_CLAVE
               AND T.FPRE_EMPR = :O.DOC_EMPR;

          EXCEPTION
            WHEN OTHERS THEN
              raise_application_error(-20010,
                                      'Error al anular relacion con presupuesto');
          END;
        END IF;
        
         IF :O.DOC_TIPO_MOV in (16) THEN
          BEGIN
            UPDATE STK_DOCUMENTO T
               SET T.DOCU_CLAVE_FIN_NC = NULL 
             WHERE T.DOCU_CLAVE_FIN_NC = :O.DOC_CLAVE
               AND T.DOCU_EMPR = :O.DOC_EMPR;

          EXCEPTION
            WHEN OTHERS THEN
              raise_application_error(-20010,
                                      'Error al anular relacion con presupuesto');
          END;
        END IF;
        ------------------

      ELSE
        -- Si se modifica el documento

        IF :O.DOC_EMPR <> :N.DOC_EMPR OR
           :O.DOC_TIPO_SALDO <> :N.DOC_TIPO_SALDO OR
           NVL(:O.DOC_CTA_BCO, 0) <> NVL(:N.DOC_CTA_BCO, 0) OR
           :O.DOC_NETO_EXEN_MON <> :N.DOC_NETO_EXEN_MON OR
           :O.DOC_NETO_GRAV_MON <> :N.DOC_NETO_GRAV_MON OR
           NVL(:O.DOC_IVA_MON, 0) <> NVL(:N.DOC_IVA_MON, 0) OR
           :O.DOC_NETO_EXEN_LOC <> :N.DOC_NETO_EXEN_LOC OR
           :O.DOC_NETO_GRAV_LOC <> :N.DOC_NETO_GRAV_LOC OR
           NVL(:O.DOC_IVA_LOC, 0) <> NVL(:N.DOC_IVA_LOC, 0) THEN
          -- simular una eliminacion de un comprobante con los datos originales
          IF :O.DOC_CTA_BCO IS NOT NULL THEN
            FIN_ACT_CTA_BCO(:O.DOC_EMPR,
                            'D',
                            :O.DOC_TIPO_SALDO,
                            :O.DOC_CTA_BCO,
                            (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                            :O.DOC_IVA_MON),
                            (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                            :O.DOC_IVA_LOC),
                            :O.DOC_FEC_OPER,
                            :O.DOC_FEC_DOC,
                            :O.DOC_MON);
          END IF;
          -- simular una insersion de un documento con los datos nuevos
          IF :N.DOC_CTA_BCO IS NOT NULL THEN
            FIN_ACT_CTA_BCO(:N.DOC_EMPR,
                            'I',
                            :N.DOC_TIPO_SALDO,
                            :N.DOC_CTA_BCO,
                            (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                            :N.DOC_IVA_MON),
                            (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                            :N.DOC_IVA_LOC),
                            :N.DOC_FEC_OPER,
                            :N.DOC_FEC_DOC,
                            :N.DOC_MON);
          END IF;

        END IF;

        -- Actualizar los saldos en FIN_CLI_EMPRESA
        IF :O.DOC_EMPR <> :N.DOC_EMPR OR :O.DOC_TIPO_MOV <> :N.DOC_TIPO_MOV OR
           NVL(:O.DOC_CTA_BCO, 0) <> NVL(:N.DOC_CTA_BCO, 0) OR
           NVL(:O.DOC_CLI, 0) <> NVL(:N.DOC_CLI, 0) OR
           :O.DOC_MON <> :N.DOC_MON OR :O.DOC_FEC_DOC <> :N.DOC_FEC_DOC OR
           :O.DOC_NETO_EXEN_MON <> :N.DOC_NETO_EXEN_MON OR
           :O.DOC_NETO_GRAV_MON <> :N.DOC_NETO_GRAV_MON OR
           NVL(:O.DOC_IVA_MON, 0) <> NVL(:N.DOC_IVA_MON, 0) OR
           :O.DOC_NETO_EXEN_LOC <> :N.DOC_NETO_EXEN_LOC OR
           :O.DOC_NETO_GRAV_LOC <> :N.DOC_NETO_GRAV_LOC OR
           NVL(:O.DOC_IVA_LOC, 0) <> NVL(:N.DOC_IVA_LOC, 0) THEN

          -- simular una eliminacion de un documento con los datos originales
          FIN_ACT_CLEM(:O.DOC_EMPR,
                       'D',
                       :O.DOC_TIPO_MOV,
                       :O.DOC_CTA_BCO,
                       :O.DOC_CLI,
                       :O.DOC_MON,
                       :O.DOC_FEC_DOC,
                       :O.DOC_EST_CHEQUE,
                       :O.DOC_CHEQUE_CERTIF,
                       (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                       :O.DOC_IVA_LOC),
                       (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                       :O.DOC_IVA_MON));

          -- simular una insersion de un documento con los datos nuevos
          FIN_ACT_CLEM(:N.DOC_EMPR,
                       'I',
                       :N.DOC_TIPO_MOV,
                       :N.DOC_CTA_BCO,
                       :N.DOC_CLI,
                       :N.DOC_MON,
                       :N.DOC_FEC_DOC,
                       :N.DOC_EST_CHEQUE,
                       :N.DOC_CHEQUE_CERTIF,
                       (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                       :N.DOC_IVA_LOC),
                       (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                       :N.DOC_IVA_MON));
        END IF;

        IF :O.DOC_EMPR <> :N.DOC_EMPR OR :O.DOC_TIPO_MOV <> :N.DOC_TIPO_MOV OR
           NVL(:O.DOC_CTA_BCO, 0) <> NVL(:N.DOC_CTA_BCO, 0) OR
           NVL(:O.DOC_PROV, 0) <> NVL(:N.DOC_PROV, 0) OR
           :O.DOC_MON <> :N.DOC_MON OR :O.DOC_FEC_DOC <> :N.DOC_FEC_DOC OR
           :O.DOC_NETO_EXEN_MON <> :N.DOC_NETO_EXEN_MON OR
           :O.DOC_NETO_GRAV_MON <> :N.DOC_NETO_GRAV_MON OR
           NVL(:O.DOC_IVA_MON, 0) <> NVL(:N.DOC_IVA_MON, 0) OR
           :O.DOC_NETO_EXEN_LOC <> :N.DOC_NETO_EXEN_LOC OR
           :O.DOC_NETO_GRAV_LOC <> :N.DOC_NETO_GRAV_LOC OR
           NVL(:O.DOC_IVA_LOC, 0) <> NVL(:N.DOC_IVA_LOC, 0) THEN

          -- simular una eliminacion de un documento con los datos originales
          FIN_ACT_PREM(:O.DOC_EMPR,
                       'D',
                       :O.DOC_TIPO_MOV,
                       :O.DOC_CTA_BCO,
                       :O.DOC_PROV,
                       :O.DOC_MON,
                       :O.DOC_FEC_DOC,
                       (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                       :O.DOC_IVA_LOC),
                       (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                       :O.DOC_IVA_MON));
          -- simular una insercion de un documento con los datos originales
          FIN_ACT_PREM(:N.DOC_EMPR,
                       'I',
                       :N.DOC_TIPO_MOV,
                       :N.DOC_CTA_BCO,
                       :N.DOC_PROV,
                       :N.DOC_MON,
                       :N.DOC_FEC_DOC,
                       (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                       :N.DOC_IVA_LOC),
                       (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                       :N.DOC_IVA_MON));
        END IF;

        --ACTUALIZAR NROS DE DOCUMENTOS CON RETENCIONES
        IF :O.DOC_TIPO_MOV IN (1, 2) THEN
          UPDATE FIN_RETENCION
             SET RET_DOC_NRO = :N.DOC_NRO_DOC
           WHERE RET_DOC_CLAVE = :O.DOC_CLAVE
             AND RET_EMPR = :O.DOC_EMPR;
        END IF;
      END IF;

    END;

    --------------------------------TERMINA TAGRO
  ELSE
    IF INSERTING THEN
      GENERAL.PL_VALIDAR_HAB_MES_FIN(FECHA   => :N.DOC_FEC_DOC,
                                     EMPRESA => :N.DOC_EMPR,
                                     USUARIO => GEN_DEVUELVE_USER);
    ELSE
      IF :N.DOC_TIPO_SALDO <> :O.DOC_TIPO_SALDO OR
         :N.DOC_CTA_BCO <> :O.DOC_CTA_BCO OR
         :N.DOC_NETO_EXEN_MON <> :O.DOC_NETO_EXEN_MON OR
         :N.DOC_NETO_GRAV_MON <> :O.DOC_NETO_GRAV_MON OR
         :N.DOC_IVA_MON <> :O.DOC_IVA_MON OR
         :N.DOC_FEC_OPER <> :O.DOC_FEC_OPER OR
         :N.DOC_FEC_DOC <> :O.DOC_FEC_DOC OR :N.DOC_CLI <> :O.DOC_CLI OR
         :N.DOC_MON <> :O.DOC_MON OR :N.DOC_EST_CHEQUE <> :O.DOC_EST_CHEQUE OR
         :N.DOC_CHEQUE_CERTIF <> :O.DOC_CHEQUE_CERTIF OR
         :N.DOC_TIPO_MOV <> :O.DOC_TIPO_MOV OR :N.DOC_PROV <> :O.DOC_PROV OR
         :N.DOC_TIMBRADO <> :O.DOC_TIMBRADO THEN
        --para que se pueda cambiar el nro del recibo por que  segun BILLIE eso llega tarde
        GENERAL.PL_VALIDAR_HAB_MES_FIN(FECHA   => :O.DOC_FEC_DOC,
                                       EMPRESA => :O.DOC_EMPR,
                                       USUARIO => GEN_DEVUELVE_USER);

      END IF;
    END IF;

    -- END IF;

    IF DELETING THEN
      V_CLAVE := 10000 + :O.DOC_EMPR * 100 + 1;
    ELSE
      V_CLAVE := 10000 + :N.DOC_EMPR * 100 + 1;
    END IF;

    IF INSERTING THEN
      V_CLAVE := :N.DOC_CLAVE;
      --Hacer solo en la base de datos donde se origino el registro..
      IF GEN_PACK_SUC.SUC_ORIG(V_CLAVE) = GEN_PACK_SUC.GEN_CONF_SUC THEN
        IF :N.DOC_TIPO_MOV IN (9, 10, 16) AND :N.DOC_SUC_VTA IS NULL THEN
          DECLARE
            V_SUC_VEND NUMBER;
          BEGIN
            IF :N.DOC_LEGAJO IS NOT NULL THEN
              SELECT MAX(VE.VEND_SUC_VTA)
                INTO V_SUC_VEND
                FROM FAC_VENDEDOR VE
               WHERE VE.VEND_LEGAJO = :N.DOC_LEGAJO
                 AND VE.VEND_EMPR = :N.DOC_EMPR;
            END IF;
            :N.DOC_SUC_VTA := NVL(V_SUC_VEND, :N.DOC_SUC);
          END;
        END IF;
      END IF;
      
      IF :N.DOC_CTA_BCO_FCON IS NOT NULL THEN
          DECLARE
             W_MON NUMBER;
          BEGIN   
           
            SELECT CTA_MON
              INTO W_MON
              FROM FIN_CUENTA_BANCARIA
             WHERE CTA_EMPR = :N.DOC_EMPR
               AND CTA_CODIGO = :N.DOC_CTA_BCO_FCON;
            --
            
                IF :N.DOC_MON <> W_MON THEN
                  
                  RAISE_APPLICATION_ERROR(-20111,
                                              'La moneda del documento no coincide con la moneda de la caja/bco'||:N.DOC_CTA_BCO_FCON||W_MON);    
                                              
                END IF;
     
          END;  
       END IF;
      
      IF :N.DOC_CTA_BCO IS NOT NULL THEN
      
  
        FIN_ACT_CTA_BCO(:N.DOC_EMPR,
                        'I',
                        :N.DOC_TIPO_SALDO,
                        :N.DOC_CTA_BCO,
                        (NVL(:N.DOC_NETO_EXEN_MON, 0) +
                        NVL(:N.DOC_NETO_GRAV_MON, 0) +
                        NVL(:N.DOC_IVA_MON, 0)),
                        (NVL(:N.DOC_NETO_EXEN_LOC, 0) +
                        NVL(:N.DOC_NETO_GRAV_LOC, 0) +
                        NVL(:N.DOC_IVA_LOC, 0)),
                        :N.DOC_FEC_OPER,
                        :N.DOC_FEC_DOC,
                        :N.DOC_MON);
                        
                        
           
    
      END IF;

      -- Actualizar los saldos en FIN_CLI_EMPRESA
      FIN_ACT_CLEM(:N.DOC_EMPR,
                   'I',
                   :N.DOC_TIPO_MOV,
                   :N.DOC_CTA_BCO,
                   :N.DOC_CLI,
                   :N.DOC_MON,
                   :N.DOC_FEC_DOC,
                   :N.DOC_EST_CHEQUE,
                   :N.DOC_CHEQUE_CERTIF,
                   (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                   :N.DOC_IVA_LOC),
                   (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                   :N.DOC_IVA_MON));

      -- Actualizar los saldos de operacion del cliente en FIN_CLI_EMPRESA
      -- esto solamente se hace al insertar, lastimosamente al borrar ya
      -- quedan los datos, porque no se puede saber lo que habia antes
      FIN_ACT_CLEM_OPER(:N.DOC_EMPR,
                        'I',
                        :N.DOC_TIPO_MOV,
                        :N.DOC_FEC_DOC,
                        :N.DOC_CLI,
                        :N.DOC_MON,
                        (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                        :N.DOC_IVA_LOC),
                        (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                        :N.DOC_IVA_MON));

      -- Actualizar los saldos en FIN_PROV_EMPRESA

      FIN_ACT_PREM(:N.DOC_EMPR,
                   'I',
                   :N.DOC_TIPO_MOV,
                   :N.DOC_CTA_BCO,
                   :N.DOC_PROV,
                   :N.DOC_MON,
                   :N.DOC_FEC_DOC,
                   (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC) +
                   :N.DOC_IVA_LOC,
                   (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON) +
                   :N.DOC_IVA_MON);


      -- Actualizar el saldo de FIN_DOCUMENTO.21/08/1998.Luis Fedriani
      -- No se puede hacer en un procedimiento, porque perdemos el ':N'
      SELECT TMOV_IND_TIENE_SALDO, TMOV_IND_CTA_BCO_NULL
        INTO V_IND_TIENE_SALDO, V_IND_CTA_BCO_NULL
        FROM GEN_TIPO_MOV
       WHERE TMOV_CODIGO = :N.DOC_TIPO_MOV
         AND TMOV_EMPR = :N.DOC_EMPR;
      SELECT CONF_FEC_LIM_MOD, CONF_PER_ACT_FIN
        INTO V_CONF_FEC_LIM_MOD, V_CONF_PER_ACT_FIN
        FROM FIN_CONFIGURACION
       WHERE CONF_EMPR = :N.DOC_EMPR;

      IF :N.DOC_CTA_BCO IS NOT NULL THEN
        IF :N.DOC_TIPO_MOV IN (9, 10, 18, 35, 9, 20, 8, 29, 42) THEN
          :N.DOC_CODIGO_TEFE := 2;
        END IF;
      END IF;
            
                  
      --EL 4-4-02: calcular la tasa de la operacion
      --MSCL 05-04-2002: tener en cuenta divisor cero
      IF :N.DOC_TIPO_MOV NOT IN (27,28) then
        -- 15/07/2022 8:05:38 @PabloACespedes \(^-^)/
        -- comprueba que sea mayor a 0 la moneda extranjera, para evitar error de divisor por 0
        if (NVL(:N.DOC_NETO_EXEN_MON, 0) +
                NVL(:N.DOC_NETO_GRAV_MON, 0) +
                NVL(:N.DOC_IVA_MON, 0)) > 0 
        then
          :N.DOC_TASA := (NVL(:N.DOC_NETO_EXEN_LOC, 0) +
                         NVL(:N.DOC_NETO_GRAV_LOC, 0) +
                         NVL(:N.DOC_IVA_LOC, 0)) /
                         (NVL(:N.DOC_NETO_EXEN_MON, 0) +
                         NVL(:N.DOC_NETO_GRAV_MON, 0) +
                         NVL(:N.DOC_IVA_MON, 0));
        else 
          :N.DOC_TASA := 1;
        end if;
      ELSE
       :N.DOC_TASA := 1;             
      END IF;
                       
           
  /*
     IF (NVL(:N.DOC_NETO_EXEN_MON, 0) + NVL(:N.DOC_NETO_GRAV_MON, 0) +
         NVL(:N.DOC_IVA_MON, 0)) = 0 THEN
        :N.DOC_TASA := 1;
      ELSE
        v_tasa :=  (NVL(:N.DOC_NETO_EXEN_LOC, 0) +
                       NVL(:N.DOC_NETO_GRAV_LOC, 0) +
                       NVL(:N.DOC_IVA_LOC, 0)) /
                       (NVL(:N.DOC_NETO_EXEN_MON, 0) +
                       NVL(:N.DOC_NETO_GRAV_MON, 0) +
                       NVL(:N.DOC_IVA_MON, 0));
               
         
        :N.DOC_TASA := (NVL(:N.DOC_NETO_EXEN_LOC, 0) +
                       NVL(:N.DOC_NETO_GRAV_LOC, 0) +
                       NVL(:N.DOC_IVA_LOC, 0)) /
                       (NVL(:N.DOC_NETO_EXEN_MON, 0) +
                       NVL(:N.DOC_NETO_GRAV_MON, 0) +
                       NVL(:N.DOC_IVA_MON, 0));

      END IF;
*/      
      --
      IF ((V_IND_TIENE_SALDO = 'S' AND :N.DOC_CTA_BCO IS NULL OR
         V_IND_CTA_BCO_NULL = 'N') OR
         (:N.DOC_TIPO_MOV = 9 AND :N.DOC_CTA_BCO IS NULL)) AND
         :N.DOC_TIPO_MOV <> 6 THEN
        :N.DOC_SALDO_LOC     := NVL(:N.DOC_NETO_EXEN_LOC, 0) +
                                NVL(:N.DOC_NETO_GRAV_LOC, 0) +
                                NVL(:N.DOC_IVA_LOC, 0);
        :N.DOC_SALDO_MON     := NVL(:N.DOC_NETO_EXEN_MON, 0) +
                                NVL(:N.DOC_NETO_GRAV_MON, 0) +
                                NVL(:N.DOC_IVA_MON, 0);
        :N.DOC_SALDO_INI_MON := NVL(:N.DOC_NETO_EXEN_MON, 0) +
                                NVL(:N.DOC_NETO_GRAV_MON, 0) +
                                NVL(:N.DOC_IVA_MON, 0);
        IF :N.DOC_FEC_DOC BETWEEN V_CONF_FEC_LIM_MOD AND V_CONF_PER_ACT_FIN THEN
          :N.DOC_SALDO_PER_ACT_LOC := :N.DOC_SALDO_LOC;
          :N.DOC_SALDO_PER_ACT_MON := :N.DOC_SALDO_MON;
        ELSE
          :N.DOC_SALDO_PER_ACT_LOC := 0;
          :N.DOC_SALDO_PER_ACT_MON := 0;
        END IF;
      END IF;

    ELSIF DELETING THEN

      -- Insertar en la tabla de auditoria de documentos
      INSERT INTO FIN_AUD_DOCUMENTO
        (ADOC_CLAVE,
         ADOC_EMPR,
         ADOC_CTA_BCO,
         ADOC_TIPO_MOV,
         ADOC_TIPO_SALDO,
         ADOC_NRO_DOC,
         ADOC_SUC,
         ADOC_DPTO,
         ADOC_MON,
         ADOC_PROV,
         ADOC_CLI,
         ADOC_LEGAJO,
         ADOC_CLI_NOM,
         ADOC_CLI_DIR,
         ADOC_CLI_TEL,
         ADOC_CLI_RUC,
         ADOC_NRO_CHEQ,
         ADOC_BCO_CHEQUE,
         ADOC_EST_CHEQUE,
         ADOC_FEC_DEP_CHEQUE,
         ADOC_NRO_DOC_DEP,
         ADOC_CHEQUE_CERTIF,
         ADOC_FEC_OPER,
         ADOC_FEC_DOC,
         ADOC_FEC_CHEQUE,
         ADOC_BRUTO_GRAV_LOC,
         ADOC_BRUTO_GRAV_MON,
         ADOC_BRUTO_EXEN_LOC,
         ADOC_BRUTO_EXEN_MON,
         ADOC_NETO_GRAV_LOC,
         ADOC_NETO_GRAV_MON,
         ADOC_NETO_EXEN_LOC,
         ADOC_NETO_EXEN_MON,
         ADOC_IVA_LOC,
         ADOC_IVA_MON,
         ADOC_BASE_IMPON_LOC,
         ADOC_BASE_IMPON_MON,
         ADOC_SALDO_LOC,
         ADOC_SALDO_MON,
         ADOC_OBS,
         ADOC_FEC_ANUL,
         ADOC_LOGIN_ANUL,
         ADOC_LOGIN,
         ADOC_FEC_GRAB,
         ADOC_SIST,
         ADOC_OPERADOR,
         ADOC_COBRADOR,
         ADOC_TIMBRADO,
         ADOC_TIPO_OPERACION)
      VALUES
        (:O.DOC_CLAVE,
         :O.DOC_EMPR,
         :O.DOC_CTA_BCO,
         :O.DOC_TIPO_MOV,
         :O.DOC_TIPO_SALDO,
         :O.DOC_NRO_DOC,
         :O.DOC_SUC,
         :O.DOC_DPTO,
         :O.DOC_MON,
         :O.DOC_PROV,
         :O.DOC_CLI,
         :O.DOC_LEGAJO,
         :O.DOC_CLI_NOM,
         :O.DOC_CLI_DIR,
         :O.DOC_CLI_TEL,
         :O.DOC_CLI_RUC,
         :O.DOC_NRO_CHEQUE,
         :O.DOC_BCO_CHEQUE,
         :O.DOC_EST_CHEQUE,
         :O.DOC_FEC_DEP_CHEQUE,
         :O.DOC_NRO_DOC_DEP,
         :O.DOC_CHEQUE_CERTIF,
         :O.DOC_FEC_OPER,
         :O.DOC_FEC_DOC,
         :O.DOC_FEC_CHEQUE,
         :O.DOC_BRUTO_GRAV_LOC,
         :O.DOC_BRUTO_GRAV_MON,
         :O.DOC_BRUTO_EXEN_LOC,
         :O.DOC_BRUTO_EXEN_MON,
         :O.DOC_NETO_GRAV_LOC,
         :O.DOC_NETO_GRAV_MON,
         :O.DOC_NETO_EXEN_LOC,
         :O.DOC_NETO_EXEN_MON,
         :O.DOC_IVA_LOC,
         :O.DOC_IVA_MON,
         :O.DOC_BASE_IMPON_LOC,
         :O.DOC_BASE_IMPON_MON,
         :O.DOC_SALDO_LOC,
         :O.DOC_SALDO_MON,
         :O.DOC_OBS,
         SYSDATE,
         --SUBSTR(USER, 1, 8),
         GEN_DEVUELVE_USER,
         :O.DOC_LOGIN,
         :O.DOC_FEC_GRAB,
         :O.DOC_SIST,
         :O.DOC_OPERADOR,
         :O.DOC_COBRADOR,
         :O.DOC_TIMBRADO,
         'ELIMINADOS');

      -- Actualizar los saldos en FIN_SAL_CTA_BCO
      IF :O.DOC_CTA_BCO IS NOT NULL THEN
        FIN_ACT_CTA_BCO(:O.DOC_EMPR,
                        'D',
                        :O.DOC_TIPO_SALDO,
                        :O.DOC_CTA_BCO,
                        (NVL(:O.DOC_NETO_EXEN_MON, 0) +
                        NVL(:O.DOC_NETO_GRAV_MON, 0) +
                        NVL(:O.DOC_IVA_MON, 0)),
                        (NVL(:O.DOC_NETO_EXEN_LOC, 0) +
                        NVL(:O.DOC_NETO_GRAV_LOC, 0) +
                        NVL(:O.DOC_IVA_LOC, 0)),
                        :O.DOC_FEC_OPER,
                        :O.DOC_FEC_DOC,
                        :O.DOC_MON);
      END IF;

      IF :O.DOC_CLI IS NOT NULL THEN
        -- Actualizar los saldos en FIN_CLI_EMPRESA
        FIN_ACT_CLEM(:O.DOC_EMPR,
                     'D',
                     :O.DOC_TIPO_MOV,
                     :O.DOC_CTA_BCO,
                     :O.DOC_CLI,
                     :O.DOC_MON,
                     :O.DOC_FEC_DOC,
                     :O.DOC_EST_CHEQUE,
                     :O.DOC_CHEQUE_CERTIF,
                     (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                     :O.DOC_IVA_LOC),
                     (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                     :O.DOC_IVA_MON));
      END IF;
      IF :O.DOC_PROV IS NOT NULL THEN
        -- Actualizar los saldos en FIN_PROV_EMPRESA
        FIN_ACT_PREM(:O.DOC_EMPR,
                     'D',
                     :O.DOC_TIPO_MOV,
                     :O.DOC_CTA_BCO,
                     :O.DOC_PROV,
                     :O.DOC_MON,
                     :O.DOC_FEC_DOC,
                     (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                     :O.DOC_IVA_LOC),
                     (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                     :O.DOC_IVA_MON));

      END IF;
      --Anular retenciones emitidas para TESAKA en FIN_RETENION_IVA.
      IF :O.DOC_TIPO_MOV IN (61, 62, 64) THEN
        DELETE FROM FIN_RETENCION
         WHERE RET_RET_CLAVE = :O.DOC_CLAVE
           AND RET_EMPR = :O.DOC_EMPR;
      END IF;

      IF :O.DOC_TIPO_MOV = 12 THEN
        DELETE FIN_DOCUMENTO_FINI002 D
         WHERE D.DOC_CLAVE_DEP = :O.DOC_CLAVE
           AND D.DOC_EMPR = :O.DOC_EMPR;
      END IF;

      ----- anular las Recibos cast, que al eliminar el mov 6 anule directo los recibos de cast-------*LV
      IF :O.DOC_TIPO_MOV = 6 AND :O.DOC_CTA_BCO = 258 THEN
        BEGIN
          UPDATE CAST_RECIBO T
             SET T.REC_ESTADO = 'A'
           WHERE T.REC_DOC_CLAVE = :O.DOC_CLAVE
             AND T.REC_EMPR = :O.DOC_EMPR;

        EXCEPTION
          WHEN OTHERS THEN
            raise_application_error(-20010, 'Error al anular recibo cast');
        END;
      END IF;
      ------------------------------------------------------------------------------------------------**LV

    ELSE
      -- Si se modifica el documento

      -- Actualizar los saldos en FIN_SAL_CTA_BCO
      IF :O.DOC_EMPR <> :N.DOC_EMPR OR
         :O.DOC_TIPO_SALDO <> :N.DOC_TIPO_SALDO OR
         NVL(:O.DOC_CTA_BCO, 0) <> NVL(:N.DOC_CTA_BCO, 0) OR
         :O.DOC_NETO_EXEN_MON <> :N.DOC_NETO_EXEN_MON OR
         :O.DOC_NETO_GRAV_MON <> :N.DOC_NETO_GRAV_MON OR
         NVL(:O.DOC_IVA_MON, 0) <> NVL(:N.DOC_IVA_MON, 0) OR
         :O.DOC_NETO_EXEN_LOC <> :N.DOC_NETO_EXEN_LOC OR
         :O.DOC_NETO_GRAV_LOC <> :N.DOC_NETO_GRAV_LOC OR
         NVL(:O.DOC_IVA_LOC, 0) <> NVL(:N.DOC_IVA_LOC, 0) THEN
        -- simular una eliminacion de un comprobante con los datos originales
        IF :O.DOC_CTA_BCO IS NOT NULL THEN
          FIN_ACT_CTA_BCO(:O.DOC_EMPR,
                          'D',
                          :O.DOC_TIPO_SALDO,
                          :O.DOC_CTA_BCO,
                          (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                          :O.DOC_IVA_MON),
                          (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                          :O.DOC_IVA_LOC),
                          :O.DOC_FEC_OPER,
                          :O.DOC_FEC_DOC,
                          :O.DOC_MON);
        END IF;
        -- simular una insersion de un documento con los datos nuevos
        IF :N.DOC_CTA_BCO IS NOT NULL THEN
          FIN_ACT_CTA_BCO(:N.DOC_EMPR,
                          'I',
                          :N.DOC_TIPO_SALDO,
                          :N.DOC_CTA_BCO,
                          (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                          :N.DOC_IVA_MON),
                          (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                          :N.DOC_IVA_LOC),
                          :N.DOC_FEC_OPER,
                          :N.DOC_FEC_DOC,
                          :N.DOC_MON);
        END IF;
      END IF;

      -- Actualizar los saldos en FIN_CLI_EMPRESA
      IF :O.DOC_EMPR <> :N.DOC_EMPR OR :O.DOC_TIPO_MOV <> :N.DOC_TIPO_MOV OR
         NVL(:O.DOC_CTA_BCO, 0) <> NVL(:N.DOC_CTA_BCO, 0) OR
         NVL(:O.DOC_CLI, 0) <> NVL(:N.DOC_CLI, 0) OR
         :O.DOC_MON <> :N.DOC_MON OR :O.DOC_FEC_DOC <> :N.DOC_FEC_DOC OR
         :O.DOC_NETO_EXEN_MON <> :N.DOC_NETO_EXEN_MON OR
         :O.DOC_NETO_GRAV_MON <> :N.DOC_NETO_GRAV_MON OR
         NVL(:O.DOC_IVA_MON, 0) <> NVL(:N.DOC_IVA_MON, 0) OR
         :O.DOC_NETO_EXEN_LOC <> :N.DOC_NETO_EXEN_LOC OR
         :O.DOC_NETO_GRAV_LOC <> :N.DOC_NETO_GRAV_LOC OR
         NVL(:O.DOC_IVA_LOC, 0) <> NVL(:N.DOC_IVA_LOC, 0) THEN
        -- simular una eliminacion de un documento con los datos originales
        FIN_ACT_CLEM(:O.DOC_EMPR,
                     'D',
                     :O.DOC_TIPO_MOV,
                     :O.DOC_CTA_BCO,
                     :O.DOC_CLI,
                     :O.DOC_MON,
                     :O.DOC_FEC_DOC,
                     :O.DOC_EST_CHEQUE,
                     :O.DOC_CHEQUE_CERTIF,
                     (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                     :O.DOC_IVA_LOC),
                     (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                     :O.DOC_IVA_MON));
        -- simular una insersion de un documento con los datos nuevos
        FIN_ACT_CLEM(:N.DOC_EMPR,
                     'I',
                     :N.DOC_TIPO_MOV,
                     :N.DOC_CTA_BCO,
                     :N.DOC_CLI,
                     :N.DOC_MON,
                     :N.DOC_FEC_DOC,
                     :N.DOC_EST_CHEQUE,
                     :N.DOC_CHEQUE_CERTIF,
                     (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                     :N.DOC_IVA_LOC),
                     (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                     :N.DOC_IVA_MON));
      END IF;

      IF :O.DOC_EMPR <> :N.DOC_EMPR OR :O.DOC_TIPO_MOV <> :N.DOC_TIPO_MOV OR
         NVL(:O.DOC_CTA_BCO, 0) <> NVL(:N.DOC_CTA_BCO, 0) OR
         NVL(:O.DOC_PROV, 0) <> NVL(:N.DOC_PROV, 0) OR
         :O.DOC_MON <> :N.DOC_MON OR :O.DOC_FEC_DOC <> :N.DOC_FEC_DOC OR
         :O.DOC_NETO_EXEN_MON <> :N.DOC_NETO_EXEN_MON OR
         :O.DOC_NETO_GRAV_MON <> :N.DOC_NETO_GRAV_MON OR
         NVL(:O.DOC_IVA_MON, 0) <> NVL(:N.DOC_IVA_MON, 0) OR
         :O.DOC_NETO_EXEN_LOC <> :N.DOC_NETO_EXEN_LOC OR
         :O.DOC_NETO_GRAV_LOC <> :N.DOC_NETO_GRAV_LOC OR
         NVL(:O.DOC_IVA_LOC, 0) <> NVL(:N.DOC_IVA_LOC, 0) THEN
        -- simular una eliminacion de un documento con los datos originales
        FIN_ACT_PREM(:O.DOC_EMPR,
                     'D',
                     :O.DOC_TIPO_MOV,
                     :O.DOC_CTA_BCO,
                     :O.DOC_PROV,
                     :O.DOC_MON,
                     :O.DOC_FEC_DOC,
                     (:O.DOC_NETO_EXEN_LOC + :O.DOC_NETO_GRAV_LOC +
                     :O.DOC_IVA_LOC),
                     (:O.DOC_NETO_EXEN_MON + :O.DOC_NETO_GRAV_MON +
                     :O.DOC_IVA_MON));
        -- simular una insercion de un documento con los datos originales
        FIN_ACT_PREM(:N.DOC_EMPR,
                     'I',
                     :N.DOC_TIPO_MOV,
                     :N.DOC_CTA_BCO,
                     :N.DOC_PROV,
                     :N.DOC_MON,
                     :N.DOC_FEC_DOC,
                     (:N.DOC_NETO_EXEN_LOC + :N.DOC_NETO_GRAV_LOC +
                     :N.DOC_IVA_LOC),
                     (:N.DOC_NETO_EXEN_MON + :N.DOC_NETO_GRAV_MON +
                     :N.DOC_IVA_MON));
      END IF;

      IF :O.DOC_TIPO_MOV = 9 AND :N.DOC_TIPO_MOV = 10 THEN
        GEN_ACT_AUD_TABLA('FIN_DOCUMENTO',
                          'DOC_TIPO_MOV',
                          :O.ROWID,
                          TO_CHAR(:O.DOC_TIPO_MOV),
                          TO_CHAR(:N.DOC_TIPO_MOV),
                          :N.DOC_CLAVE);
      END IF;

    END IF;
  END IF;
/*EXCEPTION 
  WHEN OTHERS THEN
    raise_application_error(-20001,'Problemas en : FIN_DOC_BE_IDU');*/
END;
/
