-- Create table
create table STK_DOC_EXCEPTION
(
  nro_clave     NUMBER not null,
  motivo        VARCHAR2(255),
  identificador VARCHAR2(25) not null
)
tablespace DATOS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table STK_DOC_EXCEPTION
  is 'Se creo para no mostrar claves en casos especificos';
-- Add comments to the columns 
comment on column STK_DOC_EXCEPTION.nro_clave
  is 'Es la clave que no se querra mostrar o evitara';
comment on column STK_DOC_EXCEPTION.motivo
  is 'Motivo, donde se utiliza, etc';
comment on column STK_DOC_EXCEPTION.identificador
  is 'Necesario para no mezclar nro de claves iguales';
-- Create/Recreate primary, unique and foreign key constraints 
alter table STK_DOC_EXCEPTION
  add constraint STK_DOC_EXCEPTION_PK primary key (NRO_CLAVE, IDENTIFICADOR)
  using index 
  tablespace DATOS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
/
insert into stk_doc_exception(nro_clave,
                              motivo,
                              identificador)
                     values(55555430101, 'En el consumo comb se filtra para que no se vea', 'STK_DOCUMENTO');
/                     
insert into stk_doc_exception(nro_clave,
                              motivo,
                              identificador)
                     values(56632740101, 'En el consumo comb se filtra para que no se vea', 'STK_DOCUMENTO');
/
commit;
/
