CREATE OR REPLACE TRIGGER FIN_EMPL_PROV_CLIENTE
  BEFORE INSERT OR UPDATE ON PER_EMPLEADO
  REFERENCING OLD AS O NEW AS N
  FOR EACH ROW
DECLARE
  V_PROV_CODIGO NUMBER;
  W_DUMMY       VARCHAR2(1);
  DV            number;
  V_MAX_PROV    NUMBER;
  V_CLIENTE     NUMBER;
  V_COD_HOLDING NUMBER;
  V_TIPO_DOC    NUMBER;
  v_existe      number;
  v_cod_prov number;
BEGIN

  IF :N.EMPL_EMPRESA = 1 and :O.EMPL_LEGAJO IS NULL THEN
    IF :N.EMPL_DOC_IDENT IS NOT NULL THEN --NVL(:N.EMPL_SITUACION,'I') = 'A' THEN
      -----BUSCAR SI YA EXISTE UN PROVEEDOR, YA LO HACE EN EMPLEADOS, PERO ES PARA CONFIRMAR----
   
    
    SELECT COUNT(PROV_CODIGO)
         INTO v_existe
          FROM FIN_PROVEEDOR a
         WHERE a.prov_ruc = to_char(:N.EMPL_DOC_IDENT)
           AND PROV_EMPR =:N.EMPL_EMPRESA;
  
   IF v_existe > 0 THEN
     
    SELECT PROV_CODIGO
         INTO v_cod_prov
          FROM FIN_PROVEEDOR a
         WHERE a.prov_ruc = to_char(:N.EMPL_DOC_IDENT)
           AND PROV_EMPR =:N.EMPL_EMPRESA;
        
    
    if  v_cod_prov    = :N.EMPL_CODIGO_PROV   then
       null;
       else
         
         RAISE_APPLICATION_ERROR (-20001, 'EL EMPLEADO YA CUENTA CON UN CODIGO PROVEEDOR');
    end if;
           
  --- RAISE_APPLICATION_ERROR (-20001, 'EL EMPLEADO YA CUENTA CON UN CODIGO PROVEEDOR');
   
   else
  
  
     BEGIN
        SELECT PROV_CODIGO
          INTO V_PROV_CODIGO
          FROM FIN_PROVEEDOR
         WHERE PROV_CODIGO = :N.EMPL_CODIGO_PROV
           AND PROV_EMPR = :N.EMPL_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          V_PROV_CODIGO := NULL;
      END;
    
      BEGIN
        SELECT 'X'
          INTO W_DUMMY
          FROM FIN_PROV_EMPRESA
         WHERE PREM_PROV = :N.EMPL_CODIGO_PROV
           AND PREM_MON = 1
           AND PREM_EMPR = :N.EMPL_EMPRESA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          W_DUMMY := NULL;
      END;
    
      ---CALCULAR DV -----
      IF :N.EMPL_DOC_IDENT IS NOT NULL THEN
        DV := NULL;----PA_CALCULAR_DV_11_A(LTRIM(RTRIM(:N.EMPL_DOC_IDENT)));
      ELSE
        DV := NULL;
      END IF;
      
      
   IF  :N.EMPL_NACIONALIDAD = 1 THEN
       V_TIPO_DOC := 1; 
    ELSE
       V_TIPO_DOC := 4;
    
    END IF;
    
      IF V_PROV_CODIGO IS NULL THEN
       -- RAISE_APPLICATION_ERROR(-20010,:O.EMPL_CODIGO_PROV );
        --07/09/2020
        --No reconoce el procedimiento del gen_codigo_libre en el trigger.
        SELECT MAX(NVL(FP.PROV_CODIGO,1))+ 1 INTO V_MAX_PROV FROM FIN_PROVEEDOR FP WHERE FP.PROV_EMPR = :N.EMPL_EMPRESA;
       -- :N.EMPL_CODIGO_PROV := gen_codigo_libre('EMPL_CODIGO_PROV','PER_EMPLEADO',V_DESDE, :N.EMPL_CODIGO_PROV, 'EMPL_EMPRESA', 1); 
        :N.EMPL_CODIGO_PROV := V_MAX_PROV;
        INSERT INTO FIN_PROVEEDOR
          (PROV_CODIGO,
           PROV_PAIS,
           PROV_RAZON_SOCIAL,
           PROV_DIR,
           PROV_TEL,
           PROV_RUC,
           PROV_EST_PROV,
           PROV_TIPO,
           PROV_CELULAR,
           PROV_LUGAR_ORIGEN_REPLICA,
           PROV_TIMBRADO,
           PROV_DV,
           PROV_RUC_DV,
           PROV_IND_RETENCION,
           PROV_CTA_CONTABLE,
           PROV_EMPR,
           PROV_DOC_TIPO)
        VALUES
          (:N.EMPL_CODIGO_PROV,
           :N.EMPL_NACIONALIDAD,
           :N.EMPL_NOMBRE || ' ' || :N.EMPL_APE,
           :N.EMPL_DIR,
           :N.EMPL_TEL,
           :N.EMPL_DOC_IDENT || '-' || DV,
           'A',
           10, --FIN_TIPO_PROVEEDOR: Empleados
           :N.EMPL_TEL,
           10101,
           NULL,
           DV,
           :N.EMPL_DOC_IDENT,
           'S',
           93, -- Cta Cont: proveedores
           :N.EMPL_EMPRESA,
           V_TIPO_DOC);
           
         --  :N.EMPL_CODIGO_PROV
        INSERT INTO FIN_PROV_EMPRESA
          (PREM_EMPR,
           PREM_PROV,
           PREM_MON,
           PREM_FEC_PRI_OPER,
           PREM_FEC_ULT_OPER,
           PREM_IMP_MAY_OPER_LOC,
           PREM_IMP_MAY_OPER_MON,
           PREM_FEC_MAY_OPER,
           PREM_DB_PER_ACT_LOC,
           PREM_DB_PER_ACT_MON,
           PREM_CR_PER_ACT_LOC,
           PREM_CR_PER_ACT_MON,
           PREM_DB_PER_SGTE_LOC,
           PREM_DB_PER_SGTE_MON,
           PREM_CR_PER_SGTE_LOC,
           PREM_CR_PER_SGTE_MON,
           PREM_SALDO_ANT_LOC,
           PREM_SALDO_ANT_MON,
           PREM_SALDO_ACT_LOC,
           PREM_SALDO_ACT_MON,
           PREM_FEC_GRAB,
           PREM_LUGAR_ORIGEN_REPLICA)
        VALUES
          (:N.EMPL_EMPRESA,
           :N.EMPL_CODIGO_PROV,
           1,
           SYSDATE,
           SYSDATE,
           0,
           0,
           SYSDATE,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           SYSDATE,
           10101);
      END IF;
    
      IF V_PROV_CODIGO IS NOT NULL AND W_DUMMY IS NULL THEN
        INSERT INTO FIN_PROV_EMPRESA
          (PREM_EMPR,
           PREM_PROV,
           PREM_MON,
           PREM_FEC_PRI_OPER,
           PREM_FEC_ULT_OPER,
           PREM_IMP_MAY_OPER_LOC,
           PREM_IMP_MAY_OPER_MON,
           PREM_FEC_MAY_OPER,
           PREM_DB_PER_ACT_LOC,
           PREM_DB_PER_ACT_MON,
           PREM_CR_PER_ACT_LOC,
           PREM_CR_PER_ACT_MON,
           PREM_DB_PER_SGTE_LOC,
           PREM_DB_PER_SGTE_MON,
           PREM_CR_PER_SGTE_LOC,
           PREM_CR_PER_SGTE_MON,
           PREM_SALDO_ANT_LOC,
           PREM_SALDO_ANT_MON,
           PREM_SALDO_ACT_LOC,
           PREM_SALDO_ACT_MON,
           PREM_FEC_GRAB,
           PREM_LUGAR_ORIGEN_REPLICA
           )
        VALUES
          (:N.EMPL_EMPRESA,
           :N.EMPL_CODIGO_PROV,
           1,
           SYSDATE,
           SYSDATE,
           0,
           0,
           SYSDATE,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           0,
           SYSDATE,
           10101);
      END IF;
 
    
    end if;


    
    SELECT COUNT(*)
    INTO V_CLIENTE
     FROM FIN_CLIENTE
   WHERE CLI_CODIGO = :N.EMPL_COD_CLIENTE
     AND CLI_EMPR  = :N.EMPL_EMPRESA;
           
           
   IF V_CLIENTE =0 THEN    
     
   
     BEGIN
  -- CALL THE FUNCTION
       V_COD_HOLDING:= FINM001.FP_GENERA_HOLDING(P_EMPRESA => :N.EMPL_EMPRESA,
                                             P_CLI_NOM => :N.EMPL_NOMBRE || ' ' || :N.EMPL_APE);
      END; 
       --- :N.EMPL_COD_CLIENTE := V_CLIENTE;               
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
         CLI_PAIS,
         CLI_ZONA,
         CLI_COD_EMPL_EMPR_ORIG,
         CLI_EMPR,
         CLI_DOC_IDENT_PROPIETARIO,
         CLI_RAMO,
         CLI_FEC_INGRESO,
         CLI_FEC_ACTUALIZACION,
         --CLI_DIR_PARTICULAR,
         CLI_TEL_PARTICULAR,
         CLI_SEXO,
         CLI_FEC_INGRESO_CLI,
         CLI_PERSONA,
         CLI_OBS_FACT,
         CLI_PERSONERIA,
         CLI_CANAL,
         CLI_CANAL_BETA,
         CLI_VENDEDOR,
         CLI_CIUDAD,
         CLI_COD_FICHA_HOLDING,
         CLI_SUCURSAL,
         CLI_TEL_SMS,
         cli_doc_tipo)
      VALUES
        (:N.EMPL_COD_CLIENTE,
         :N.EMPL_NOMBRE || ' ' || :N.EMPL_APE,
         NVL(:N.EMPL_DIR, '.'),
         NVL(:N.EMPL_TEL, '.'),
         NVL(:N.EMPL_DOC_IDENT|| '-' || DV, '.'),
         1, -- general
         'A',
         1,--gs
         0,
         'N',
         0,
         GEN_LUGAR_ORIGEN,
         :N.EMPL_DOC_IDENT,
         DV,
         1,
         38,
         NULL,
         :N.EMPL_EMPRESA,
         :N.EMPL_DOC_IDENT,
         32,
         SYSDATE,
         SYSDATE,
         ---NVL(:N.EMPL_DIR, '.'),
         NVL(:N.EMPL_TEL, '.'),
         :N.EMPL_SEXO,
         SYSDATE,
        NULL,---------------------------CODIGO PERSONA
        'EFECTIVO',
         1,
         3,
         13,
         60,--decode(:N.EMPL_SUCURSAL,2,357,60),@PabloACespedes Vendedor Empleado recepcion
         5, -- caaguazu me imagino
         V_COD_HOLDING,
         :N.EMPL_SUCURSAL,
         :N.EMPL_TEL,
         V_TIPO_DOC);
   
   END IF;

   END IF;
    
    
    
    
  ELSE
   null;
  END if;
  
END FIN_EMPL_PROV_CLIENTE;
/
