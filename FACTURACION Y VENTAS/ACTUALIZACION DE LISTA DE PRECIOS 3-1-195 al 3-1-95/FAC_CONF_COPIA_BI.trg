create or replace trigger FAC_CONF_COPIA_BI
  before insert or update
  on FAC_CONF_COPIA_LISTA_PRECIO 
  for each row
begin  
  -- asigna PK
  if inserting then
    :new.id := nvl(:new.id, fac_conf_list_precio.nextval);    
  end if;
  
  -- valida que no se copie en el mismo lugar
  if :new.lista_origen_nro = :new.lista_destino_nro then
     Raise_application_error(-20000, 'La lista de Origen no puede ser igual a la lista de Destino');
  end if;
  
  -- obtiene el usuario APEX o el de la BD
  :new.user_login := nvl(sys_context('APEX$SESSION','APP_USER'),user);
  
end FAC_CONF_COPIA_BI;
/
