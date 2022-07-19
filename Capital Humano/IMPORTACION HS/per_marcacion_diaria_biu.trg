create or replace trigger per_marcacion_diaria_biu
  before insert or update
  on PER_MARCACION_DIARIA 
  for each row
begin
  -- 19/07/2022 13:13:51 @PabloACespedes \(^-^)/
  -- trunca la fecha de marcacion
  :new.marc_fecha := trunc(:new.marc_fecha);
end per_marcacion_diaria_biu;
/
