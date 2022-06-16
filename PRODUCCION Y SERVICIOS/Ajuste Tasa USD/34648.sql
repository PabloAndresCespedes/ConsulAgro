CREATE OR REPLACE TRIGGER "STK_DOC_BE_ID"
  BEFORE INSERT OR DELETE ON STK_DOCUMENTO
  REFERENCING OLD AS O NEW AS N
  FOR EACH ROW

BEGIN

  IF /*UPPER(USER) NOT LIKE '%APEX%' AND*/
   :N.DOCU_EMPR = 1 OR :O.DOCU_EMPR = 1 THEN
    IF INSERTING THEN
       IF gen_devuelve_user <> 'ADCS' THEN
      GENERAL.PL_VALIDAR_HAB_MES_STK(FECHA   => :N.DOCU_FEC_EMIS,
                                     EMPRESA => :N.DOCU_EMPR,
                                     USUARIO => GEN_DEVUELVE_USER);
                                     
        end if;                             
      IF :N.DOCU_FEC_OPER IS NULL THEN
        :N.DOCU_FEC_OPER := :N.DOCU_FEC_EMIS;
      END IF;
    
      /* Declare
        --Sincronizar codigo de vendedor de Fin_Documento con Stk_Documento.
        v_vendedor Number;
      BEGIN
        BEGIN
          Select doc_legajo
            Into v_vendedor
            From fin_documento
           Where doc_empr = :N.docu_empr
             And doc_clave_stk = :N.Docu_clave;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            v_vendedor := NULL;
        End;
      
        --:N.docu_legajo:=v_vendedor;
      END;*/
    
    ELSE
       IF gen_devuelve_user <> 'ADCS' THEN
      GENERAL.PL_VALIDAR_HAB_MES_STK(FECHA   => :O.DOCU_FEC_EMIS,
                                     EMPRESA => :O.DOCU_EMPR,
                                     USUARIO => GEN_DEVUELVE_USER);
                                     
       end if;                              
    END IF;
  END IF;
  --No se puede modificar el valor de esta columna en este evento del trigger. 17/12/2020
  IF NOT (DELETING) THEN
    IF :N.DOCU_FEC_OPER IS NULL THEN
      :N.DOCU_FEC_OPER := :N.DOCU_FEC_EMIS;
    END IF;
  END IF;

  IF DELETING THEN
  
    INSERT INTO STK_AUD_DOCUMENTO
      (ADOCU_CLAVE,
       ADOCU_CODIGO_OPER,
       ADOCU_NRO_DOC,
       ADOCU_EMPR,
       ADOCU_SUC_ORIG,
       ADOCU_DEP_ORIG,
       ADOCU_SUC_DEST,
       ADOCU_DEP_DEST,
       ADOCU_MON,
       ADOCU_PROV,
       ADOCU_CLI,
       ADOCU_LEGAJO,
       ADOCU_DPTO,
       ADOCU_SECCION,
       ADOCU_FEC_EMIS,
       ADOCU_TIPO_MOV,
       ADOCU_GRAV_NETO_LOC,
       ADOCU_GRAV_NETO_MON,
       ADOCU_EXEN_NETO_LOC,
       ADOCU_EXEN_NETO_MON,
       ADOCU_GRAV_BRUTO_LOC,
       ADOCU_GRAV_BRUTO_MON,
       ADOCU_EXEN_BRUTO_LOC,
       ADOCU_EXEN_BRUTO_MON,
       ADOCU_IVA_LOC,
       ADOCU_IVA_MON,
       ADOCU_OBS,
       ADOCU_FEC_ANUL,
       ADOCU_LOGIN_ANUL)
    VALUES
      (:O.DOCU_CLAVE,
       :O.DOCU_CODIGO_OPER,
       :O.DOCU_NRO_DOC,
       :O.DOCU_EMPR,
       :O.DOCU_SUC_ORIG,
       :O.DOCU_DEP_ORIG,
       :O.DOCU_SUC_DEST,
       :O.DOCU_DEP_DEST,
       :O.DOCU_MON,
       :O.DOCU_PROV,
       :O.DOCU_CLI,
       :O.DOCU_LEGAJO,
       :O.DOCU_DPTO,
       :O.DOCU_SECCION,
       :O.DOCU_FEC_EMIS,
       :O.DOCU_TIPO_MOV,
       :O.DOCU_GRAV_NETO_LOC,
       :O.DOCU_GRAV_NETO_MON,
       :O.DOCU_EXEN_NETO_LOC,
       :O.DOCU_EXEN_NETO_MON,
       :O.DOCU_GRAV_BRUTO_LOC,
       :O.DOCU_GRAV_BRUTO_MON,
       :O.DOCU_EXEN_BRUTO_LOC,
       :O.DOCU_EXEN_BRUTO_MON,
       :O.DOCU_IVA_LOC,
       :O.DOCU_IVA_MON,
       :O.DOCU_OBS,
       SYSDATE,
       SUBSTR(USER, 1, 8));
  
    DECLARE
      V_REMISION VARCHAR2(32767);
      V_OCA_INS  NUMBER;
    BEGIN
    
      --Pedido de Florian, cuando se elimine la remisii??n, elimine tambii??n los datos de la OC. 02/12/2020
      SELECT P.FOCD_CLAVE
        INTO V_OCA_INS
        FROM FAC_OCI_DET P
       WHERE P.FOCD_CLAVE_FACTURA = :O.DOCU_CLAVE
         AND P.FOCD_EMPR = 2
         AND ROWNUM = 1;
      --Eliminar detalle.
      DELETE FROM FAC_OCI_DET P
       WHERE P.FOCD_CLAVE = V_OCA_INS
         AND P.FOCD_EMPR = 2;
      DELETE FROM FAC_ORDEN_CARGA_INS PP
       WHERE PP.FOCI_CLAVE = V_OCA_INS
         AND PP.FOCI_EMPR = 2;
    
      SELECT REM_CLAVE
        INTO V_REMISION
        FROM STK_REMISION O
       WHERE O.REM_DOCU_CLAVE_STK = :O.DOCU_CLAVE
         AND REM_EMPR = :O.DOCU_EMPR;
    
      DELETE FROM STK_REMISION_DET G
       WHERE G.DETR_CLAVE_REM IN (V_REMISION)
         AND G.DETR_EMPR = :O.DOCU_EMPR;
    
      DELETE FROM STK_REMISION Z
       WHERE Z.REM_CLAVE IN (V_REMISION)
         AND Z.REM_EMPR = :O.DOCU_EMPR;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
      WHEN TOO_MANY_ROWS THEN
        FOR V IN (SELECT REM_CLAVE
                    FROM STK_REMISION O
                   WHERE O.REM_DOCU_CLAVE_STK = :O.DOCU_CLAVE
                     AND REM_EMPR = :O.DOCU_EMPR) LOOP
          DELETE FROM STK_REMISION_DET G
           WHERE G.DETR_CLAVE_REM IN (V.REM_CLAVE)
             AND G.DETR_EMPR = :O.DOCU_EMPR;
        
          DELETE FROM STK_REMISION Z
           WHERE Z.REM_CLAVE IN (V.REM_CLAVE)
             AND Z.REM_EMPR = :O.DOCU_EMPR;
        
        END LOOP;
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'ERROR AL BORRAR REMISION ASOCIADO' ||
                                'Clave:' || :O.DOCU_CLAVE || 'Remision:' ||
                                V_REMISION || SQLCODE || '-' || SQLERRM);
    END;
    --Anular asientos contables dependientes del documento de Stock actual.
  
    DELETE FROM CNT_ASIENTO_DET
     WHERE ASID_EMPR = :O.DOCU_EMPR
       AND ASID_CLAVE_ASI IN
           (SELECT ASI_CLAVE
              FROM CNT_ASIENTO
             WHERE ASI_EMPR = :O.DOCU_EMPR
               AND ASI_STK_CLAVE = :O.DOCU_CLAVE);
    DELETE FROM CNT_ASIENTO
     WHERE ASI_EMPR = :O.DOCU_EMPR
       AND ASI_STK_CLAVE = :O.DOCU_CLAVE;
  
    --Anulaci??n de producci??n productos x conceptos.
    DELETE FROM PRD_PRODUCTO_EN_PROCESO_DET DD
     WHERE DD.PEPD_EMPR = :O.DOCU_EMPR
       AND PEPD_CONCEPTO IN
           (SELECT PEP_CONCEPTO
              FROM PRD_PRODUCTO_EN_PROCESO P
             WHERE P.PEP_EMPR = :O.DOCU_EMPR
               AND P.PEP_CLAVE_STK = :O.DOCU_CLAVE);
    DELETE FROM PRD_PRODUCTO_EN_PROCESO P
     WHERE P.PEP_EMPR = :O.DOCU_EMPR
       AND P.PEP_CLAVE_STK = :O.DOCU_CLAVE;
       
  ELSIF INSERTING THEN
    IF :N.DOCU_FEC_OPER IS NULL THEN
      :N.DOCU_FEC_OPER := TO_DATE(NVL(:N.DOCU_FEC_EMIS, SYSDATE),
                                  'DD/MM/YYYY');
    END IF;
    
    -- 16/06/2022 7:47:57 @PabloACespedes \(^-^)/
    -- Evalua la tasa en USD del dia
    :n.docu_tasa_us := gen_cot_tipo_oper(
                         P_EMPRESA   => 1, --> HILAGRO
                         P_MONEDA    => 2, --> USD
                         P_TIPO_OPER => :n.docu_codigo_oper,
                         P_FECHA     => :n.docu_fec_emis
                         );
  
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000,
                            'Error en el trigger  STK_DOC_BE_ID' || SQLCODE || '-' ||
                            SQLERRM);
END;
/
