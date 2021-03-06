create or replace trigger bi_per_marcacion_diaria
  before insert
  on PER_MARCACION_DIARIA 
  for each row
declare
  co_empr_consultagro constant number := 1;
begin
  :new.marc_empr       := nvl(:new.marc_empr, co_empr_consultagro);
  :new.marc_fecha_grab := nvl(:new.marc_fecha_grab, current_date);
end bi_per_marcacion_diaria;
/
