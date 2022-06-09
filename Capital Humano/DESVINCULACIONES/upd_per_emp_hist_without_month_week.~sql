update per_empleado_hist p
set p.mes    = coalesce(p.mes, to_char(p.empl_fec_salida, 'MM')),
    p.semana = coalesce(p.semana, to_char(p.empl_fec_salida, 'IW'))
where p.empl_fec_salida is not null
and  (p.semana is null or p.mes is null)
and  p.empl_situacion = 'I'; 
