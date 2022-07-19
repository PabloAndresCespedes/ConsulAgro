create or replace trigger BI_CNT_CUENTA
  before insert
  on CNT_CUENTA 
  for each row
    /*
      Author  : @PabloACespedes \(^-^)/
      Created : 19/07/2022 10:42:55
      asigna PK en caso que sea nulo
    */
begin
  if :new.ctac_clave is null then
    :new.ctac_clave := SEQ_CNT_CUENTA.NEXTVAL;
  end if;
end BI_CNT_CUENTA;
/
