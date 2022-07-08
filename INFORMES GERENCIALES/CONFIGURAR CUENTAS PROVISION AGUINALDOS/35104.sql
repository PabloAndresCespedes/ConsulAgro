CREATE OR REPLACE PACKAGE SIGM016 IS
  PROCEDURE PP_PROV_AGUINALDO(P_PROV_AGUINALDO IN CNT_CONF_PROV_AGUINALDO%ROWTYPE,
                              P_OPER           IN VARCHAR2);
                              
  /*
    Author  : @PabloACespedes \(^-^)/
    Created : 08/07/2022 11:41:51
    El CRUD afecta CNT_CONF_PROV_AGUINALDO 
    se_crea de forma individual, por fallos en el rowtype de la 
    grilla interactiva APEX, es llamado fila por fila y lo guarda
    Param: @in_action >> C || U || D : Estandar APEX,
      - C: Create
      - U: Update
      - D: Delete
  */
  procedure crud_prov(
   in_empresa number,
   in_action  varchar2,
   in_centro_costo number,
   in_nro_prov     number,
   in_nro_cuenta   number,
   in_item         number   
  );
                          
END SIGM016;
/
CREATE OR REPLACE PACKAGE BODY SIGM016 IS

  PROCEDURE PP_PROV_AGUINALDO(P_PROV_AGUINALDO IN CNT_CONF_PROV_AGUINALDO%ROWTYPE,
                              P_OPER           IN VARCHAR2) AS
  
  BEGIN
  
    UPDATE CNT_CONF_PROV_AGUINALDO
    
       SET PROVA_ITEM        = P_PROV_AGUINALDO.PROVA_ITEM,
           PROVA_EMPR        = P_PROV_AGUINALDO.PROVA_EMPR,
           PROVA_CUENTA_PROV = P_PROV_AGUINALDO.PROVA_CUENTA_PROV,
           PROVA_CUENTA      = P_PROV_AGUINALDO.PROVA_CUENTA
     WHERE PROVA_CCOSTO = P_PROV_AGUINALDO.PROVA_CCOSTO
     AND PROVA_ITEM = P_PROV_AGUINALDO.PROVA_ITEM
     AND PROVA_EMPR = P_PROV_AGUINALDO.PROVA_EMPR;
  
    IF SQL%ROWCOUNT = 0 THEN
  
      INSERT INTO CNT_CONF_PROV_AGUINALDO
        (PROVA_CCOSTO,
         PROVA_CUENTA_PROV,
         PROVA_ITEM,
         PROVA_CUENTA,
         PROVA_EMPR)
      VALUES
        (P_PROV_AGUINALDO.PROVA_CCOSTO,
         P_PROV_AGUINALDO.PROVA_CUENTA_PROV,
         P_PROV_AGUINALDO.PROVA_ITEM,
         P_PROV_AGUINALDO.PROVA_CUENTA,
         P_PROV_AGUINALDO.PROVA_EMPR);
    
    END IF;
  
    IF P_OPER = 'D' THEN

      DELETE CNT_CONF_PROV_AGUINALDO
       WHERE PROVA_CUENTA = P_PROV_AGUINALDO.PROVA_CUENTA
         AND PROVA_CCOSTO = P_PROV_AGUINALDO.PROVA_CCOSTO
         AND PROVA_ITEM = P_PROV_AGUINALDO.PROVA_ITEM
         AND PROVA_EMPR = P_PROV_AGUINALDO.PROVA_EMPR;
    
    END IF;
  END;

  procedure crud_prov(
   in_empresa number,
   in_action  varchar2,
   in_centro_costo number,
   in_nro_prov     number,
   in_nro_cuenta   number,
   in_item         number   
  )as
  co_create constant varchar2(1 char) := 'C';
  co_update constant varchar2(1 char) := 'U';
  co_delete constant varchar2(1 char) := 'D';
  
  l_clave_cuenta      number;
  l_clave_cuenta_prov number;
  l_item_new          number;
  
  e_clave_not_found      exception;
  e_clave_prov_not_found exception;
  begin
    <<get_cuenta>>
    begin
     select c.ctac_clave
     into l_clave_cuenta
     from cnt_cuenta c
     where c.ctac_empr = in_empresa
     and   c.ctac_nro  = in_nro_cuenta;
    exception
      when no_data_found then 
        raise e_clave_not_found;
    end get_cuenta;
     
    <<get_cuenta_prov>>
    begin
      select  t.ctac_clave
      into l_clave_cuenta_prov 
      from cnt_cuenta t
      where t.ctac_nro = in_nro_prov
      and t.ctac_empr  = in_empresa;
    exception
      when no_data_found then
        raise e_clave_prov_not_found;
    end get_cuenta_prov; 
      
    <<c_actions>>
    case
      when in_action = co_create then
        <<get_number_item>>
        begin
         select nvl(max(cn.prova_item), 0) + 1 
         into   l_item_new
         from cnt_conf_prov_aguinaldo cn
         where  cn.prova_ccosto = in_centro_costo
         and cn.prova_empr      = in_empresa;
        exception
          when OTHERS then
             l_item_new := 1;
        end get_number_item;
        
        insert into cnt_conf_prov_aguinaldo
        (prova_ccosto,
         prova_cuenta_prov,
         prova_item,
         prova_cuenta,
         prova_empr
         )
        values
        (in_centro_costo,
         l_clave_cuenta_prov,
         l_item_new,
         l_clave_cuenta,
         in_empresa
        );
      when in_action = co_update then
        update cnt_conf_prov_aguinaldo
        set prova_cuenta_prov = l_clave_cuenta_prov,
            prova_cuenta      = l_clave_cuenta
        where prova_ccosto = in_centro_costo
        and prova_item     = in_item
        and prova_empr     = in_empresa;
      when in_action = co_delete then
         delete cnt_conf_prov_aguinaldo
         where prova_cuenta = l_clave_cuenta
         and   prova_ccosto = in_centro_costo
         and   prova_item   = in_item
         and   prova_empr   = in_empresa;
      else
        raise_application_error(-20000, 'Acci'||chr(243)||'n no v'||chr(225)||'lida. '||in_action);
    end case c_actions;
  exception
    when e_clave_not_found then
      Raise_application_error(-20000, 'No se encuentra la clave de la cuenta Nro. '||in_nro_cuenta||' Empresa: '||in_empresa);
    when e_clave_prov_not_found then
      Raise_application_error(-20000, 'No se encuentra la clave de la cuenta Nro. '||in_nro_prov||' Empresa: '||in_empresa);
  end crud_prov;
END SIGM016;
/