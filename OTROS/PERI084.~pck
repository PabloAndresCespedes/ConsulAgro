CREATE OR REPLACE PACKAGE PERI084 AS


  PROCEDURE  FP_VERIFICAR_NRO_SOL            (V_EMPRESA       IN       NUMBER,
                                              V_NRO_SOL       IN       NUMBER);

    PROCEDURE  FP_TRAER_ESTADOS_SOL          (V_EMPRESA           IN       NUMBER,
                                              V_NRO_SOL           IN       NUMBER,
                                              V_ESTADO           OUT     VARCHAR2,
                                              V_OPERADOR_IN       IN     VARCHAR2,
                                              V_FECHA_IN          IN         DATE,
                                              V_OPERADOR         OUT     VARCHAR2,
                                              V_FECHA            OUT         DATE,
                                              V_OBSER            OUT     VARCHAR2,
                                              V_OBSER_SOL        OUT     VARCHAR2,
                                              V_NIVEL_URGENCIA   OUT     VARCHAR2,
                                              V_ACCION           OUT     VARCHAR2,
                                              V_TIPO_SELECCION   OUT     VARCHAR2,
                                              V_TIPO_CONTRATAC   OUT     VARCHAR2);


    PROCEDURE  PP_GUARDAR_ESTADO_SOL         (V_EMPRESA       IN       NUMBER,
                                              V_NRO_SOL       IN       NUMBER,
                                              V_ESTADO        IN     VARCHAR2,
                                              V_OPERADOR      IN     VARCHAR2,
                                              V_FECHA         IN         DATE,
                                              V_OBSER         IN     VARCHAR2,
                                              V_NIVEL_URGE    IN     VARCHAR2);

 PROCEDURE PP_GUARDAR_ESTADO_FINAL(V_EMPRESA IN NUMBER,
                                    V_NRO_SOL IN NUMBER,
                                    V_ESTADO  IN VARCHAR2,
                                    V_FEC_CIERRE IN DATE,
                                    V_VAC_CUBIERTA IN NUMBER default null,
                                    V_ENCARGADO IN VARCHAR  default null);


 -- 11/07/2022 14:46:04 @PabloACespedes \(^-^)/
 -- obtiene el cargo del operador, en funcion al usuario logueado
 function get_cargo_operador(
   in_empresa in number  
 )return number;
  
 END PERI084;
/
CREATE OR REPLACE PACKAGE BODY PERI084 AS

  PROCEDURE FP_VERIFICAR_NRO_SOL(V_EMPRESA IN NUMBER, V_NRO_SOL IN NUMBER) AS
    V_NRO_RET NUMBER;
  BEGIN

    SELECT SOL.SOLPER_CLAVE
      INTO V_NRO_RET
      FROM PER_SOLICITUD_PERSONAL SOL
     WHERE SOL.SOLPER_EMPR = V_EMPRESA
       AND SOL.SOLPER_CLAVE = V_NRO_SOL;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001,
                              'No se encuentra el nro de Solicitud');
  END FP_VERIFICAR_NRO_SOL;

  PROCEDURE FP_TRAER_ESTADOS_SOL(V_EMPRESA        IN NUMBER,
                                 V_NRO_SOL        IN NUMBER,
                                 V_ESTADO         OUT VARCHAR2,
                                 V_OPERADOR_IN    IN VARCHAR2,
                                 V_FECHA_IN       IN DATE,
                                 V_OPERADOR       OUT VARCHAR2,
                                 V_FECHA          OUT DATE,
                                 V_OBSER          OUT VARCHAR2,
                                 V_OBSER_SOL      OUT VARCHAR2,
                                 V_NIVEL_URGENCIA OUT VARCHAR2,
                                 V_ACCION         OUT VARCHAR2,
                                 V_TIPO_SELECCION OUT VARCHAR2,
                                 V_TIPO_CONTRATAC OUT VARCHAR2) AS
    V_CARGAR_OPERADOR VARCHAR2(20);
    V_CARGAR_FECHA    DATE;
  BEGIN

    SELECT PS.SOLPER_FECHA_APROB,
           PS.SOLPER_OPERADOR_APROB,
           PS.SOLPER_ESTADO_APROB,
           PS.SOLPER_OBSER_APROB,
           PS.SOLPER_OBSER_SOL,
           PS.SOLPER_NIVEL_URGENCIA,
           DECODE(SOLPER_TIPO_SELEC, 'PR', 'Programada', 'AN', 'Anticipada'),
           DECODE(SOLPER_TIPO_CONTRATACION,
                  'PR',
                  'Programada',
                  'DR',
                  'Directa')
      INTO V_CARGAR_FECHA,
           V_CARGAR_OPERADOR,
           V_ESTADO,
           V_OBSER,
           V_OBSER_SOL,
           V_NIVEL_URGENCIA,
           V_TIPO_SELECCION,
           V_TIPO_CONTRATAC
      FROM PER_SOLICITUD_PERSONAL PS
     WHERE PS.SOLPER_CLAVE = V_NRO_SOL
       AND PS.SOLPER_EMPR = V_EMPRESA;

    IF V_CARGAR_OPERADOR IS NOT NULL THEN
      V_OPERADOR := V_CARGAR_OPERADOR;
    ELSE
      V_OPERADOR := V_OPERADOR_IN;
    END IF;

    IF V_CARGAR_FECHA IS NOT NULL THEN
      V_FECHA := V_CARGAR_FECHA;
    ELSE
      V_FECHA := V_FECHA_IN;
    END IF;

    V_ACCION := V_ESTADO;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ACCION := 'P';
  END FP_TRAER_ESTADOS_SOL;

  PROCEDURE PP_GUARDAR_ESTADO_SOL(V_EMPRESA    IN NUMBER,
                                  V_NRO_SOL    IN NUMBER,
                                  V_ESTADO     IN VARCHAR2,
                                  V_OPERADOR   IN VARCHAR2,
                                  V_FECHA      IN DATE,
                                  V_OBSER      IN VARCHAR2,
                                  V_NIVEL_URGE IN VARCHAR2) AS
    V_ESTADO_GRAL   VARCHAR2(2);
    --V_TIP_SELECCION VARCHAR2(2);
    --V_OPERADOR_SOL  VARCHAR(20);
    V_TIPO_DOTACION  VARCHAR2(10);
    V_TIPO_CONTRATO  VARCHAR2(10);
    V_OPER_APROBACION NUMBER;
    V_CARGO_OPERADOR NUMBER;
    V_CARGO_SOL NUMBER;
    V_CARGO_DESCRIPCION VARCHAR2(60);
    V_AREA_SOL NUMBER;

  BEGIN

  ------------------------------SOLAMENTE SI ES DE NIVEL GERENCIA PUEDEN APROBAR O RECHAZAR UNA SOLICITUD
   --10/09/2020 SOLAMENTE EL GERENTE GENERAL PUEDE APROBAR EN EL CASO DE AUMENTO DE PLANTEL
      SELECT PS.SOLPER_CARGO,PS.SOLPER_TIPO_DOTAC, SOLPER_TIPO_CONT, PS.SOLPER_AREA
      INTO  V_CARGO_SOL, V_TIPO_DOTACION, V_TIPO_CONTRATO,V_AREA_SOL
      FROM PER_SOLICITUD_PERSONAL PS
     WHERE PS.SOLPER_CLAVE = V_NRO_SOL
       AND PS.SOLPER_EMPR = V_EMPRESA;




            BEGIN
                  SELECT PCA2.CARDPP_CLAVE, PCA2.CARDPP_DESC
                    INTO V_OPER_APROBACION, V_CARGO_DESCRIPCION
                    FROM PER_NIVEL_CARGO_ORGANI T2,PER_CARGO_DPP PCA2,PER_NIVEL_ORGANI PN2
                   WHERE T2.PERNICA_EMPR        = V_EMPRESA
                     AND T2.PERNICA_CARGO       = V_CARGO_SOL
                     AND PN2.NIVORG_NIVEL       = 2
                     AND T2.PERNICA_EMPR        = PCA2.CARDPP_EMPR
                     AND T2.PERNICA_CARGO_DEP   = PCA2.CARDPP_CLAVE
                     AND PCA2.CARDPP_EMPR       = PN2.NIVORG_EMPR
                     AND PCA2.CARDPP_NIV_ORGANI = PN2.NIVORG_CLAVE;

            EXCEPTION
              WHEN NO_DATA_FOUND THEN
               BEGIN
                 SELECT PCA2.CARDPP_CLAVE, PCA2.CARDPP_DESC
                    INTO V_OPER_APROBACION, V_CARGO_DESCRIPCION
                    FROM PER_NIVEL_CARGO_ORGANI T2,PER_CARGO_DPP PCA2,PER_NIVEL_ORGANI PN2
                   WHERE T2.PERNICA_EMPR        = V_EMPRESA
                     AND T2.PERNICA_CARGO       = V_CARGO_SOL
                     AND PN2.NIVORG_NIVEL       = 1
                     AND T2.PERNICA_EMPR        = PCA2.CARDPP_EMPR
                     AND T2.PERNICA_CARGO_DEP   = PCA2.CARDPP_CLAVE
                     AND PCA2.CARDPP_EMPR       = PN2.NIVORG_EMPR
                     AND PCA2.CARDPP_NIV_ORGANI = PN2.NIVORG_CLAVE;
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                   RAISE_APPLICATION_ERROR (-20001, 'AVISE AL ADMINISTRADOR');
                  END;

    END;


  ------------------------------EL CARGO
  IF V_ESTADO  = 'P' THEN
     RAISE_APPLICATION_ERROR (-20001, 'El estado no puede ser pendiente');
  
  END IF; 
  begin        
       V_CARGO_OPERADOR := get_cargo_operador(in_empresa => v_empresa);
                                     
       IF V_CARGO_OPERADOR =  110 AND v_empresa =2 THEN
         RAISE_APPLICATION_ERROR (-20001, 'Solo el gerente puede aprobar la solicitud');
       END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       RAISE_APPLICATION_ERROR (-20001, 'Su operador no esta configurado en la ficha de empleado, favor avisar a Capital Humano');      
  end;
  
 IF V_CARGO_OPERADOR  = 151 AND V_EMPRESA = 1 then -- gerente general en hilagro
   IF V_ESTADO = 'P' THEN
                  V_ESTADO_GRAL := 'EE';
                ELSIF V_ESTADO = 'R' THEN
                  V_ESTADO_GRAL := 'R';
                ELSIF V_ESTADO = 'C' THEN
                  V_ESTADO_GRAL := 'P';
                END IF;

                UPDATE PER_SOLICITUD_PERSONAL PS
                   SET PS.SOLPER_ESTADO_APROB   = V_ESTADO,
                       PS.SOLPER_OPERADOR_APROB = V_OPERADOR,
                       PS.SOLPER_FECHA_APROB    = V_FECHA,
                       PS.SOLPER_OBSER_APROB    = V_OBSER,
                       PS.SOLPER_NIVEL_URGENCIA = V_NIVEL_URGE,
                       PS.SOLPER_ESTADO_FINAL   = V_ESTADO_GRAL
                 WHERE PS.SOLPER_CLAVE = V_NRO_SOL
                   AND PS.SOLPER_EMPR = V_EMPRESA;
   
 
 
 ELSE
   IF V_EMPRESA = 1 AND V_CARGO_OPERADOR NOT IN (1, 22,79,138,150, 151,152,260) AND  V_TIPO_CONTRATO = 'IN' THEN
     RAISE_APPLICATION_ERROR (-20001, 'La aprobacion debe pasar por Gerencia');
   END IF;
       
  IF V_EMPRESA = 1 THEN
    IF V_TIPO_DOTACION = 'IN' AND V_CARGO_OPERADOR = 151 AND V_TIPO_CONTRATO = 'IN' then -- gerente general

                IF V_ESTADO = 'P' THEN
                  V_ESTADO_GRAL := 'EE';
                ELSIF V_ESTADO = 'R' THEN
                  V_ESTADO_GRAL := 'R';
                ELSIF V_ESTADO = 'C' THEN
                  V_ESTADO_GRAL := 'P';
                END IF;

                UPDATE PER_SOLICITUD_PERSONAL PS
                   SET PS.SOLPER_ESTADO_APROB   = V_ESTADO,
                       PS.SOLPER_OPERADOR_APROB = V_OPERADOR,
                       PS.SOLPER_FECHA_APROB    = V_FECHA,
                       PS.SOLPER_OBSER_APROB    = V_OBSER,
                       PS.SOLPER_NIVEL_URGENCIA = V_NIVEL_URGE,
                       PS.SOLPER_ESTADO_FINAL   = V_ESTADO_GRAL
                 WHERE PS.SOLPER_CLAVE = V_NRO_SOL
                   AND PS.SOLPER_EMPR = V_EMPRESA;
   ELSIF V_TIPO_DOTACION = 'IN' AND V_TIPO_CONTRATO = 'IN'  AND V_CARGO_OPERADOR <> 151 THEN

        RAISE_APPLICATION_ERROR (-20001, 'La aprobacion debe pasar por Gerencia General');

   ELSIF V_TIPO_DOTACION = 'IN'  AND V_CARGO_OPERADOR = V_OPER_APROBACION AND V_TIPO_CONTRATO = 'TE' THEN
       
     
            IF V_ESTADO = 'P' THEN
                V_ESTADO_GRAL := 'EE';
              ELSIF V_ESTADO = 'R' THEN
                V_ESTADO_GRAL := 'R';
              ELSIF V_ESTADO = 'C' THEN
                V_ESTADO_GRAL := 'P';
              END IF;

              UPDATE PER_SOLICITUD_PERSONAL PS
                 SET PS.SOLPER_ESTADO_APROB   = V_ESTADO,
                     PS.SOLPER_OPERADOR_APROB = V_OPERADOR,
                     PS.SOLPER_FECHA_APROB    = V_FECHA,
                     PS.SOLPER_OBSER_APROB    = V_OBSER,
                     PS.SOLPER_NIVEL_URGENCIA = V_NIVEL_URGE,
                     PS.SOLPER_ESTADO_FINAL   = V_ESTADO_GRAL
               WHERE PS.SOLPER_CLAVE = V_NRO_SOL
                   AND PS.SOLPER_EMPR = V_EMPRESA;

     ELSIF V_TIPO_DOTACION <> 'IN' AND V_CARGO_OPERADOR = V_OPER_APROBACION THEN --Excepcion


                IF V_ESTADO = 'P' THEN
                  V_ESTADO_GRAL := 'EE';
                ELSIF V_ESTADO = 'R' THEN
                  V_ESTADO_GRAL := 'R';
                ELSIF V_ESTADO = 'C' THEN
                  V_ESTADO_GRAL := 'P';
                END IF;

                UPDATE PER_SOLICITUD_PERSONAL PS
                   SET PS.SOLPER_ESTADO_APROB   = V_ESTADO,
                       PS.SOLPER_OPERADOR_APROB = V_OPERADOR,
                       PS.SOLPER_FECHA_APROB    = V_FECHA,
                       PS.SOLPER_OBSER_APROB    = V_OBSER,
                       PS.SOLPER_NIVEL_URGENCIA = V_NIVEL_URGE,
                       PS.SOLPER_ESTADO_FINAL   = V_ESTADO_GRAL
                 WHERE PS.SOLPER_CLAVE = V_NRO_SOL
                   AND PS.SOLPER_EMPR = V_EMPRESA;




      ELSE
          RAISE_APPLICATION_ERROR (-20001, 'La aprobacion debe pasar por: '||V_CARGO_DESCRIPCION);
     END IF;

  else --> otras empresas que no son HILAGRO (1)
        
        IF GEN_DEVUELVE_USER in ('BILLIEH','RROMERO','FRANCIS' )THEN
          NULL;
        ELSIF V_CARGO_OPERADOR = 110  THEN
          NULL;
        else
          /*
            Author  : @PabloACespedes \(^-^)/
            Created : 11/07/2022 13:27:45
            busca el nivel del operador dentro del organigrama empresarial
            en caso que sea el nivel 1 puede realizar el cambio,
            en futuro se_puede colocar una configuracion para que ciertos
            niveles lo puedan aprobar
          */
          <<valida_nivel_cargo_dpp>>
          declare
            l_puede_aprobar number;
          begin
            select distinct 1 into l_puede_aprobar
            from per_cargo_dpp p
            where p.cardpp_empr      = V_EMPRESA
            and   p.cardpp_clave     = V_CARGO_OPERADOR
            and   p.cardpp_niv_organi= 1 -- nivel top del organigrama, aqui se_puede jugar, agregar un rango para la proxima
            ;
            
          exception
            when no_data_found then
              RAISE_APPLICATION_ERROR (-20001, 'La aprobacion debe pasar por Gerencia General');
          end valida_nivel_cargo_dpp;
        END IF;
                IF V_ESTADO = 'P' THEN
                  V_ESTADO_GRAL := 'EE';
                ELSIF V_ESTADO = 'R' THEN
                  V_ESTADO_GRAL := 'R';
                ELSIF V_ESTADO = 'C' THEN
                  V_ESTADO_GRAL := 'P';
                END IF;

                UPDATE PER_SOLICITUD_PERSONAL PS
                   SET PS.SOLPER_ESTADO_APROB   = V_ESTADO,
                       PS.SOLPER_OPERADOR_APROB = V_OPERADOR,
                       PS.SOLPER_FECHA_APROB    = V_FECHA,
                       PS.SOLPER_OBSER_APROB    = V_OBSER,
                       PS.SOLPER_NIVEL_URGENCIA = V_NIVEL_URGE,
                       PS.SOLPER_ESTADO_FINAL   = V_ESTADO_GRAL
                 WHERE PS.SOLPER_CLAVE = V_NRO_SOL
                   AND PS.SOLPER_EMPR = V_EMPRESA;
       END IF;
 END IF;
  END PP_GUARDAR_ESTADO_SOL;

 PROCEDURE PP_GUARDAR_ESTADO_FINAL(V_EMPRESA IN NUMBER,
                                    V_NRO_SOL IN NUMBER,
                                    V_ESTADO  IN VARCHAR2,
                                    V_FEC_CIERRE IN DATE,
                                    V_VAC_CUBIERTA IN NUMBER default null,
                                    V_ENCARGADO IN VARCHAR  default null) AS

FECHA DATE;
v_estado1 VARCHAR2(1);
l_puede_aprobar number; 
  BEGIN
   
       SELECT nvl(PS.SOLPER_ESTADO_APROB,'P')
        INTO v_estado1
      FROM PER_SOLICITUD_PERSONAL PS
     WHERE PS.SOLPER_CLAVE = V_NRO_SOL
       AND PS.SOLPER_EMPR = V_EMPRESA;
      
       
       IF v_estado1 <> 'C' THEN
        RAISE_APPLICATION_ERROR (-20001,'La Solicitud no ha sido confirmada' );
     END IF;
     
     <<validate_level_operator>>
     begin
      select distinct 1 into l_puede_aprobar
      from per_cargo_dpp p
      where p.cardpp_empr      = V_EMPRESA
      and   p.cardpp_clave     = get_cargo_operador(in_empresa => v_empresa)
      and   p.cardpp_niv_organi= 1 -- nivel top del organigrama, aqui se_puede jugar, agregar un rango para la proxima
      ;
     exception
       when others then
         l_puede_aprobar := 0;
     end validate_level_operator;
     
    if l_puede_aprobar <> 1 and V_ENCARGADO IS not null and gen_devuelve_user not in ('RROMERO', 'CROMAN','ESTEBANF','MANUELC','LIZAG')THEN
      RAISE_APPLICATION_ERROR (-20001, 'No esta habilitado para asignar encargado');
    END IF;
     
   IF V_ESTADO IN ('F','A') AND V_FEC_CIERRE IS NULL  THEN
     RAISE_APPLICATION_ERROR (-20001,'La fecha no puede quedar vacia' );
     
   END IF;

   IF V_ESTADO IN ('F')  and V_EMPRESA = 2 THEN
     
   
    
      
     
       
      IF  V_FEC_CIERRE IS NULL THEN 
          RAISE_APPLICATION_ERROR (-20001,'La fecha no puede quedar vacia' );
      END IF;
      IF V_VAC_CUBIERTA IS NULL  THEN
     RAISE_APPLICATION_ERROR (-20001,'La vacancia cubierta no puede quedar vacia' );
      END IF;
      
   END IF; 
   FECHA := V_FEC_CIERRE;
   IF V_ESTADO NOT IN ('F','A') THEN
       FECHA := NULL;
       ----V_VAC_CUBIERTA := NULL;
   END IF;

    UPDATE PER_SOLICITUD_PERSONAL PS
       SET PS.SOLPER_ESTADO_FINAL = V_ESTADO,
           PS.SOLPER_FECHA_CIERRE = FECHA,---V_FEC_CIERRE,
           PS.SOLPER_VAC_CUBIERTA = V_VAC_CUBIERTA,
           SOLPER_ENCARGADO = V_ENCARGADO
     WHERE PS.SOLPER_CLAVE = V_NRO_SOL
       AND PS.SOLPER_EMPR = V_EMPRESA;

  END PP_GUARDAR_ESTADO_FINAL;

 function get_cargo_operador(
   in_empresa in number  
 )return number is
 l_r number;
 co_user constant varchar2(255) := gen_devuelve_user;
 begin
    if general.is_external_operator(in_user => co_user) then
       l_r := general.get_position_operator(in_empresa => in_empresa, in_operator => general.get_external_operator_id(in_user => co_user));
       
       if l_r is null then
         Raise_application_error(-20000, 'Pkc.PERI084 (get_cargo_operador). Es necesario definir el Cargo del Operador Externo el programa 99-1-310');
       end if;
    else
      select t.empl_cargo
      into l_r
      from per_empleado t
      inner join gen_operador o on ( o.oper_codigo = t.empl_cod_operador )
      where t.empl_empresa = in_empresa
      and t.empl_situacion = 'A'
      and o.oper_login = co_user;
    end if;
     
    return l_r;
 exception
   when no_data_found then
     Raise_application_error(-20000, 'El operador no posee un legajo activo / O no es operador externo');
 end get_cargo_operador;
 
END PERI084;
/
