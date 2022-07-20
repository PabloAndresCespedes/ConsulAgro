create or replace package PERI206 is

  -- Author  : PROGRAMACION9
  -- Created : 06/07/2020 11:37:45
  -- Purpose :

PROCEDURE PP_BUSCAR_EMPLEADO      (I_EMPLEADO_NOMBRE   OUT VARCHAR2,
                                   I_EMPL_CARGO        OUT NUMBER  ,
                                   I_EMPLEADO          IN  NUMBER  ,
                                   I_EMPRESA           IN  NUMBER  ,
                                   I_CHK_OC            OUT VARCHAR2);
PROCEDURE PP_BUSCAR_DOCUMENTO     (I_EMPLEADO          IN  NUMBER  ,
                                   I_EMPRESA           IN  NUMBER  ,
                                   I_NRODOC            IN  NUMBER  ,
                                   I_FECHA             IN  DATE    ,
                                   W_CLAVE             OUT NUMBER  );
PROCEDURE PP_CARGAR_PER_DOCUMENTO (I_EMPRESA           IN  NUMBER  ,
                                   W_CLAVE             IN  NUMBER  ,
                                   I_PDOC_QUINCENA     OUT NUMBER  ,
                                   I_PDOC_EMPLEADO     OUT NUMBER  ,
                                   I_PDOC_PERIODO      OUT NUMBER  ,
                                   I_PDOC_FEC          OUT DATE    ,
                                   I_PDOC_NRO_DOC      OUT NUMBER  ,
                                   I_PDOC_FEC_GRAB     OUT DATE    ,
                                   I_PDOC_LOGIN        OUT VARCHAR2,
                                   I_PDOC_CLAVE        OUT NUMBER  );
PROCEDURE PP_CARGAR_FIN_DOCUMENTO (I_EMPRESA           IN  NUMBER  ,
                                   W_CLAVE             IN  NUMBER  ,
                                   I_DOC_CTA_BCO       OUT NUMBER  ,
                                   I_DOC_TIPO_MOV      OUT NUMBER  ,
                                   I_DOC_NRO_DOC       OUT NUMBER  ,
                                   I_DOC_NETO_EXEN_MON OUT NUMBER  ,
                                   I_DOC_CLAVE         OUT NUMBER  );
PROCEDURE PP_ANUL_FACTURA_EMIT_MERMA(I_PDOC_CLAVE      IN  NUMBER  ,
                                   I_EMPRESA           IN  NUMBER  );
PROCEDURE PP_ANUL_CONSUMO_EMIT_MERMA(I_PDOC_CLAVE      IN  NUMBER  ,
                                   I_EMPRESA           IN  NUMBER  );
PROCEDURE PP_BORRA_DOCUMENTOS     (I_PDOC_CLAVE        IN  NUMBER  ,
                                   I_DOC_CLAVE         IN  NUMBER  ,
                                   I_EMPRESA           IN  NUMBER  );
PROCEDURE PP_VALIDAR_ANULAR_OP_CTA(V_CTA               IN  NUMBER  ,
                                   V_EMPR              IN  NUMBER  ,
                                   V_LOGIN             IN  VARCHAR2);
PROCEDURE PP_BORRAR_REGISTRO      (I_DOC_CTA_BCO       IN  NUMBER  ,
                                   I_EMPRESA           IN  NUMBER  ,
                                   W_CLAVE             IN  NUMBER  ,
                                   I_CHK_OC            IN  VARCHAR2,
                                   I_DOC_CLAVE         IN  NUMBER  ,
                                   I_NRODOC            IN  NUMBER  );

PROCEDURE PP_VALIDAR_PAGO_DOC     (I_NRODOC            IN  NUMBER  ,
                                   I_DOC_CLAVE         IN  NUMBER  ,
                                   I_EMPRESA           IN  NUMBER  );
end PERI206;
/
CREATE OR REPLACE PACKAGE BODY PERI206 IS

  PROCEDURE PP_BUSCAR_EMPLEADO(I_EMPLEADO_NOMBRE OUT VARCHAR2,
                               I_EMPL_CARGO      OUT NUMBER,
                               I_EMPLEADO        IN NUMBER,
                               I_EMPRESA         IN NUMBER,
                               I_CHK_OC          OUT VARCHAR2) IS
  BEGIN

    IF I_EMPLEADO IS NOT NULL THEN
      SELECT EMPL_NOMBRE || ' ' || EMPL_APE, EMPL_CARGO
        INTO I_EMPLEADO_NOMBRE, I_EMPL_CARGO
        FROM PER_EMPLEADO
       WHERE EMPL_LEGAJO = I_EMPLEADO
         AND EMPL_EMPRESA = I_EMPRESA;

      IF I_EMPL_CARGO = 1 THEN
        I_CHK_OC := 'S';
      ELSE
        I_CHK_OC := 'N';
      END IF;
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'El empleado no puede ser nulo!');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002, 'Empleado No Existe!');

    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END PP_BUSCAR_EMPLEADO;

  PROCEDURE PP_BUSCAR_DOCUMENTO(I_EMPLEADO IN NUMBER,
                                I_EMPRESA  IN NUMBER,
                                I_NRODOC   IN NUMBER,
                                I_FECHA    IN DATE,
                                W_CLAVE    OUT NUMBER) IS
    V_CANT_DOC NUMBER; --CUANTOS DOCUMENTOS TIENEN LA MISMA FECHA, EL MISMO NUMERO Y ESTAN RELACIONADOS CON EL MISMO EMPLEADO
    -- V_CLAVE    NUMBER; --CLAVE DEL UNICO DOCUMENTO CON ESTAS CARACTERISTICAS
  BEGIN
    IF I_NRODOC IS NULL THEN
      RAISE_APPLICATION_ERROR(-20006,
                              'Debe ingresar el n?mero de documento!');
    ELSE
      SELECT COUNT(*)
        INTO V_CANT_DOC
        FROM PER_DOCUMENTO
       WHERE PDOC_EMPLEADO = I_EMPLEADO
         AND PDOC_FEC = I_FECHA
         AND PDOC_EMPR = I_EMPRESA
         AND PDOC_NRO_DOC = I_NRODOC;
      IF V_CANT_DOC = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Documento No Existe!');
      ELSIF V_CANT_DOC = 1 THEN
        BEGIN
          SELECT PDOC_CLAVE
            INTO W_CLAVE
            FROM PER_DOCUMENTO
           WHERE PDOC_EMPLEADO = I_EMPLEADO
             AND PDOC_FEC = I_FECHA
             AND PDOC_EMPR = I_EMPRESA
             AND PDOC_NRO_DOC = I_NRODOC;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Documento No Existe!');
        END;
        /*ELSE
        RAISE_APPLICATION_ERROR(-20005,
                                 'Existe mas de un documento con el mismo numero presione F9 y elija alguno de la lista.');*/
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END;

  PROCEDURE PP_CARGAR_PER_DOCUMENTO(I_EMPRESA       IN NUMBER,
                                    W_CLAVE         IN NUMBER,
                                    I_PDOC_QUINCENA OUT NUMBER,
                                    I_PDOC_EMPLEADO OUT NUMBER,
                                    I_PDOC_PERIODO  OUT NUMBER,
                                    I_PDOC_FEC      OUT DATE,
                                    I_PDOC_NRO_DOC  OUT NUMBER,
                                    I_PDOC_FEC_GRAB OUT DATE,
                                    I_PDOC_LOGIN    OUT VARCHAR2,
                                    I_PDOC_CLAVE    OUT NUMBER) IS
  BEGIN

    IF W_CLAVE IS NOT NULL THEN

      SELECT PDOC_QUINCENA,
             PDOC_EMPLEADO,
             PDOC_PERIODO,
             PDOC_FEC,
             PDOC_NRO_DOC,
             PDOC_FEC_GRAB,
             PDOC_LOGIN,
             NVL(PDOC_CLAVE_FIN,B.PDDET_CLAVE_FIN) DD
        INTO I_PDOC_QUINCENA,
             I_PDOC_EMPLEADO,
             I_PDOC_PERIODO,
             I_PDOC_FEC,
             I_PDOC_NRO_DOC,
             I_PDOC_FEC_GRAB,
             I_PDOC_LOGIN,
             I_PDOC_CLAVE
         FROM PER_DOCUMENTO A, PER_DOCUMENTO_DET B------------------------------------lv 09/04/2021
       WHERE A.PDOC_CLAVE = B.PDDET_CLAVE_DOC
         AND A.PDOC_EMPR = B.PDDET_EMPR
         AND PDOC_EMPR = I_EMPRESA
         AND PDOC_CLAVE = W_CLAVE
         group by 
          PDOC_QUINCENA,
             PDOC_EMPLEADO,
             PDOC_PERIODO,
             PDOC_FEC,
             PDOC_NRO_DOC,
             PDOC_FEC_GRAB,
             PDOC_LOGIN,
             NVL(PDOC_CLAVE_FIN,B.PDDET_CLAVE_FIN);

    ELSE
      I_PDOC_QUINCENA := NULL;
      I_PDOC_EMPLEADO := NULL;
      I_PDOC_PERIODO  := NULL;
      I_PDOC_FEC      := NULL;
      I_PDOC_NRO_DOC  := NULL;
      I_PDOC_FEC_GRAB := NULL;
      I_PDOC_LOGIN    := NULL;

    END IF;

    /*  BEGIN
      -- CALL THE PROCEDURE
      PERI206.PP_CARGAR_FIN_DOCUMENTO(I_EMPRESA           => I_EMPRESA,
                                      W_CLAVE             => I_PDOC_CLAVE,
                                      I_DOC_CTA_BCO       => I_DOC_CTA_BCO,
                                      I_DOC_TIPO_MOV      => I_DOC_TIPO_MOV,
                                      I_DOC_NRO_DOC       => I_DOC_NRO_DOC,
                                      I_DOC_NETO_EXEN_MON => I_DOC_NETO_EXEN_MON);
        END;
    */

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_PDOC_QUINCENA := NULL;
      I_PDOC_EMPLEADO := NULL;
      I_PDOC_PERIODO  := NULL;
      I_PDOC_FEC      := NULL;
      I_PDOC_NRO_DOC  := NULL;
      I_PDOC_FEC_GRAB := NULL;
      I_PDOC_LOGIN    := NULL;

    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END PP_CARGAR_PER_DOCUMENTO;

  PROCEDURE PP_CARGAR_FIN_DOCUMENTO(I_EMPRESA           IN NUMBER,
                                    W_CLAVE             IN NUMBER,
                                    I_DOC_CTA_BCO       OUT NUMBER,
                                    I_DOC_TIPO_MOV      OUT NUMBER,
                                    I_DOC_NRO_DOC       OUT NUMBER,
                                    I_DOC_NETO_EXEN_MON OUT NUMBER,
                                    I_DOC_CLAVE         OUT NUMBER) IS
  BEGIN

    IF W_CLAVE IS NOT NULL THEN

      SELECT DOC_CTA_BCO,
             DOC_TIPO_MOV,
             DOC_NRO_DOC,
             DOC_NETO_EXEN_MON,
             DOC_CLAVE
        INTO I_DOC_CTA_BCO,
             I_DOC_TIPO_MOV,
             I_DOC_NRO_DOC,
             I_DOC_NETO_EXEN_MON,
             I_DOC_CLAVE
        FROM FIN_DOCUMENTO
       WHERE DOC_CLAVE = W_CLAVE
         AND DOC_EMPR = I_EMPRESA;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      I_DOC_CTA_BCO       := NULL;
      I_DOC_TIPO_MOV      := NULL;
      I_DOC_NRO_DOC       := NULL;
      I_DOC_NETO_EXEN_MON := NULL;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);

  END;

  PROCEDURE PP_BORRA_DOCUMENTOS(I_PDOC_CLAVE IN NUMBER,
                                I_DOC_CLAVE  IN NUMBER,
                                I_EMPRESA    IN NUMBER) IS

    --
  BEGIN
    --
-------------------------borrar_pago
    /*DELETE FROM FIN_DOC_CONCEPTO F
       WHERE F.DCON_CLAVE_DOC = (select t.pag_clave_pago from FIN_PAGO t
                                  where t.pag_clave_doc = I_DOC_CLAVE
                                  and   t.pag_empr = I_EMPRESA
                                  )
         AND DCON_EMPR = I_EMPRESA;
         

      DELETE FROM FIN_PAGO F
       WHERE F.pag_clave_doc = I_DOC_CLAVE
         AND PAG_EMPR = I_EMPRESA;
 
      DELETE FIN_DOCUMENTO
     WHERE DOC_CLAVE = (select t.pag_clave_pago from FIN_PAGO t
                                  where t.pag_clave_doc = I_DOC_CLAVE
                                  and   t.pag_empr = I_EMPRESA
                                  )
       AND DOC_EMPR = I_EMPRESA;*/
 -------------------------
    --
    DELETE FROM PER_DOCUMENTO_DET P
     WHERE P.PDDET_CLAVE_DOC = I_PDOC_CLAVE
       AND P.PDDET_EMPR = I_EMPRESA;
    --

    --

    --

    --
    DELETE PER_DOCUMENTO
     WHERE PDOC_CLAVE = I_PDOC_CLAVE
       AND PDOC_EMPR = I_EMPRESA;
    BEGIN
      --

     DELETE FROM FIN_DOC_LINEA_NEGOCIO FN------------------------------------lv 09/04/2021
         WHERE DOCL_CLAVE = I_DOC_CLAVE
           AND DOCL_EMPR = I_EMPRESA;

      DELETE FROM FIN_DOC_CONCEPTO F
       WHERE F.DCON_CLAVE_DOC = I_DOC_CLAVE
         AND DCON_EMPR = I_EMPRESA;

      DELETE FROM FIN_CUOTA F
       WHERE F.CUO_CLAVE_DOC = I_DOC_CLAVE
         AND CUO_EMPR = I_EMPRESA;

      DELETE FROM FIN_PAGO F
       WHERE F.PAG_CLAVE_PAGO = I_DOC_CLAVE
         AND PAG_EMPR = I_EMPRESA;
         
         
         
         
         

    END;

    DELETE FIN_DOCUMENTO
     WHERE DOC_CLAVE = I_DOC_CLAVE
       AND DOC_EMPR = I_EMPRESA;
  END;

  PROCEDURE PP_BORRAR_REGISTRO(I_DOC_CTA_BCO IN NUMBER,
                               I_EMPRESA     IN NUMBER,
                               W_CLAVE       IN NUMBER,
                               I_CHK_OC      IN VARCHAR2,
                               I_DOC_CLAVE   IN NUMBER,
                               I_NRODOC      IN NUMBER) IS
    SALIR EXCEPTION;

  BEGIN

    IF I_DOC_CTA_BCO IS NOT NULL THEN
      PP_VALIDAR_ANULAR_OP_CTA(I_DOC_CTA_BCO, I_EMPRESA, GEN_DEVUELVE_USER);
    END IF;

    IF I_EMPRESA = 2 THEN
      IF I_CHK_OC = 'S' THEN
        UPDATE TRA_ORDEN_CARGA O
           SET O.OCA_CLAVE_PER_PAGO = NULL
         WHERE O.OCA_CLAVE_PER_PAGO = W_CLAVE
           AND O.OCA_EMPR = I_EMPRESA;
        --POST;
      END IF;
      ----------------------------------------------------------------------------------------
      -- SI HAY FACTURA EMITIDA ASOCIADA A LA LIQUIDACI?N DE SALARIO GENERADA DESDE TRAI005..
      -- ELIMINAR LA FACTURA ASOCIADA..
      PP_ANUL_FACTURA_EMIT_MERMA(W_CLAVE, I_EMPRESA);
      ---==================================================================================
      -- SI HAY CONSUMO INTERNO EMITIDO ASOCIADO A LA LIQUIDACI?N DE SALARIO, GENERADO DESDE TRAI005..
      -- ELIMINAR EL CONSUMO ASOCIADO..
      PP_ANUL_CONSUMO_EMIT_MERMA(W_CLAVE, I_EMPRESA);
      
      ---==================================================================================
      /*GO_BLOCK('PER_DOCUMENTO');
      DELETE_RECORD;
      POST;
RAISE_APPLICATION_ERROR(-20001, SQLERRM);
      GO_BLOCK('FIN_DOCUMENTO');
      DELETE_RECORD;
      COMMIT_FORM;*/

    END IF;
 --   IF I_EMPRESA != 2 THEN---LV TAMBIEN UQE MUESTRE PA LAS DEMAS EMPRESAS EL ERROR
      BEGIN
        -- CALL THE PROCEDURE
        PERI206.PP_VALIDAR_PAGO_DOC(I_NRODOC    => I_NRODOC,
                                    I_DOC_CLAVE => I_DOC_CLAVE,
                                    I_EMPRESA   => I_EMPRESA);
                                    
      END;
   -- END IF;

    BEGIN
      -- RAISE_APPLICATION_ERROR(-20001,I_DOC_CLAVE);
      -- CALL THE PROCEDURE
      PERI206.PP_BORRA_DOCUMENTOS(I_PDOC_CLAVE => W_CLAVE,
                                  I_DOC_CLAVE  => I_DOC_CLAVE,
                                  I_EMPRESA    => I_EMPRESA);
                                 
    END;

  EXCEPTION
    WHEN SALIR THEN
      NULL;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END;

  PROCEDURE PP_ANUL_FACTURA_EMIT_MERMA(I_PDOC_CLAVE IN NUMBER,
                                       I_EMPRESA    IN NUMBER) IS
  BEGIN
    FOR R IN (SELECT DOC_CLAVE, DOC_CLAVE_STK
                FROM FIN_DOCUMENTO DO
               WHERE DOC_CLAVE_LIQ_CHOFER = I_PDOC_CLAVE
                 AND DOC_TIPO_MOV = 9
                 AND DOC_EMPR = I_EMPRESA) LOOP
      -----
      FOR X IN (SELECT OCA_CLAVE
                  FROM TRA_ORDEN_CARGA OC
                 WHERE OC.OCA_CLAVE_FAC_DCTO = R.DOC_CLAVE
                   AND OC.OCA_EMPR = I_EMPRESA) LOOP
        UPDATE TRA_OCARGA_PROD
           SET OCP_PESO_DCTO_FLETE = NULL,
               OCP_LUGAR_ORIGEN    = GEN_LUGAR_ORIGEN
         WHERE OCP_CODIGO = X.OCA_CLAVE
           AND OCP_EMPR = I_EMPRESA;
      END LOOP;
      -----
      UPDATE TRA_ORDEN_CARGA OC
         SET OC.OCA_CLAVE_FAC_DCTO = NULL,
             OCA_ITEM_FAC_DCTO     = NULL,
             OCA_PESO_DCTO         = NULL,
             OCA_PRECIO_DCTO       = NULL,
             OCA_PORC_LIM_VAR_P    = NULL,
             OCA_LUGAR_ORIGEN      = GEN_LUGAR_ORIGEN
       WHERE OC.OCA_CLAVE_FAC_DCTO = R.DOC_CLAVE
         AND OC.OCA_EMPR = I_EMPRESA;
      -----
      DELETE FROM STK_DOCUMENTO_DET DE
       WHERE DETA_CLAVE_DOC = R.DOC_CLAVE_STK
         AND DETA_EMPR = I_EMPRESA;
      DELETE FROM STK_DOCUMENTO DO
       WHERE DOCU_CLAVE = R.DOC_CLAVE_STK
         AND DOCU_EMPR = I_EMPRESA;
      -----
      DELETE FROM FAC_DOCUMENTO_DET DE
       WHERE DET_CLAVE_DOC = R.DOC_CLAVE
         AND DET_EMPR = I_EMPRESA;

         DELETE FROM FIN_DOC_LINEA_NEGOCIO FN
         WHERE DOCL_CLAVE = R.DOC_CLAVE
           AND DOCL_EMPR = I_EMPRESA;------------------------------------lv 09/04/2021

      DELETE FROM FIN_DOC_CONCEPTO
       WHERE DCON_CLAVE_DOC = R.DOC_CLAVE
         AND DCON_EMPR = I_EMPRESA;

      DELETE FROM FIN_CUOTA
       WHERE CUO_CLAVE_DOC = R.DOC_CLAVE
         AND CUO_EMPR = I_EMPRESA;

      DELETE FROM FIN_DOCUMENTO
       WHERE DOC_CLAVE = R.DOC_CLAVE
         AND DOC_EMPR = I_EMPRESA;
      -----
    END LOOP;
  END;

  PROCEDURE PP_ANUL_CONSUMO_EMIT_MERMA(I_PDOC_CLAVE IN NUMBER,
                                       I_EMPRESA    IN NUMBER) IS
  BEGIN
    FOR R IN (SELECT DOCU_CLAVE
                FROM STK_DOCUMENTO DO
               WHERE DOCU_CLAVE_LIQ_TRA = I_PDOC_CLAVE
                 AND DOCU_CODIGO_OPER = 10
                 AND DOCU_EMPR = I_EMPRESA) LOOP
      -----
      FOR X IN (SELECT OCA_CLAVE
                  FROM TRA_ORDEN_CARGA OC
                 WHERE OC.OCA_CLAVE_CONSUM_STK = R.DOCU_CLAVE
                   AND OC.OCA_EMPR = I_EMPRESA) LOOP
        UPDATE TRA_OCARGA_PROD
           SET OCP_PESO_DCTO_FLETE = NULL,
               OCP_LUGAR_ORIGEN    = GEN_LUGAR_ORIGEN
         WHERE OCP_CODIGO = X.OCA_CLAVE
           AND OCP_EMPR = I_EMPRESA;
      END LOOP;
      -----
      UPDATE TRA_ORDEN_CARGA OC
         SET OC.OCA_CLAVE_CONSUM_STK = NULL,
             OCA_ITEM_CONSUM_STK     = NULL,
             OCA_PESO_DCTO           = NULL,
             OCA_PRECIO_DCTO         = NULL,
             OCA_PORC_LIM_VAR_P      = NULL,
             OCA_LUGAR_ORIGEN        = GEN_LUGAR_ORIGEN
       WHERE OC.OCA_CLAVE_CONSUM_STK = R.DOCU_CLAVE
         AND OC.OCA_EMPR = I_EMPRESA;
      -----
      DELETE FROM STK_DOCUMENTO_DET DE
       WHERE DETA_CLAVE_DOC = R.DOCU_CLAVE
         AND DETA_EMPR = I_EMPRESA;
      DELETE FROM STK_DOCUMENTO DO
       WHERE DOCU_CLAVE = R.DOCU_CLAVE
         AND DOCU_EMPR = I_EMPRESA;
      -----
    END LOOP;
  END;

  PROCEDURE PP_VALIDAR_ANULAR_OP_CTA(V_CTA   IN NUMBER,
                                     V_EMPR  IN NUMBER,
                                     V_LOGIN IN VARCHAR2) IS
    V_ANULAR   VARCHAR2(1);
    V_CTA_DESC VARCHAR2(60);
  BEGIN
    SELECT OP_CTA_ANULAR, CTA_DESC
      INTO V_ANULAR, V_CTA_DESC
      FROM GEN_OPERADOR,
           FIN_OPER_CTA_BCO,
           FIN_CUENTA_BANCARIA,
           GEN_OPERADOR_EMPRESA
     WHERE OPER_CODIGO = OP_CTA_OPER
       AND OPEM_OPER = OPER_CODIGO
       AND OPEM_EMPR = OP_CTA_EMPR
       AND OP_CTA_EMPR = CTA_EMPR
       AND OP_CTA_CTA_CODIGO = CTA_CODIGO
       AND OPER_LOGIN = V_LOGIN
       AND OP_CTA_EMPR = V_EMPR
       AND OP_CTA_CTA_CODIGO = V_CTA;

    IF V_ANULAR = 'N' THEN
      RAISE_APPLICATION_ERROR(-20008,
                              'No tiene permiso para ANULAR este documento. La Caja/Bco ' ||
                              V_CTA_DESC || ' puede que no le pertenezca!!');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20009,
                              'No tiene permiso para ANULAR este documento. La Caja/Bco ' ||
                              V_CTA_DESC || ' puede que no le pertenezca!!');
  END;

  PROCEDURE PP_VALIDAR_PAGO_DOC(I_NRODOC    IN NUMBER,
                                I_DOC_CLAVE IN NUMBER,
                                I_EMPRESA   IN NUMBER) IS
    V_EXISTENCIA_PAGO NUMBER;
    V_CLAVE           NUMBER;
    V_CLAVE_PAGO      NUMBER;
    V_TM              NUMBER;
    V_NUMERO_DOC      NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_EXISTENCIA_PAGO
      FROM FIN_DOCUMENTO F
     WHERE F.DOC_CLAVE IN (SELECT FP.PAG_CLAVE_DOC
                             FROM FIN_PAGO FP
                            WHERE FP.PAG_EMPR = I_EMPRESA)
       AND DOC_EMPR = I_EMPRESA
       AND DOC_CLAVE = I_DOC_CLAVE;

    IF V_EXISTENCIA_PAGO > 0 and I_EMPRESA <> 2 THEN

      SELECT FP.PAG_CLAVE_DOC
        INTO V_CLAVE_PAGO
        FROM FIN_PAGO FP
       WHERE FP.PAG_EMPR = I_EMPRESA
         AND FP.PAG_CLAVE_DOC = I_DOC_CLAVE;
      SELECT F.DOC_CLAVE, F.DOC_TIPO_MOV, F.DOC_NRO_DOC
        INTO V_CLAVE, V_TM, V_NUMERO_DOC
        FROM FIN_DOCUMENTO F
       WHERE F.DOC_CLAVE = V_CLAVE_PAGO;
      RAISE_APPLICATION_ERROR(-20010,
                              'El documento ' || I_NRODOC ||
                              ' Ya tiene un pago registrado' || ' Clave:' ||
                              V_CLAVE || ' Nro. Doc. ' || V_NUMERO_DOC ||
                              ' TM: ' || V_TM);
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --PL_EXHIBIR_ERROR('No tiene permiso para ANULAR este documento. La Caja/Bco '||V_CTA_DESC||' puede que no le pertenezca!!');
      NULL;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20011,
                              'Error en pp_validar_pago_doc' || SQLCODE || '-' ||
                              SQLERRM);
  END;

END PERI206;
/
