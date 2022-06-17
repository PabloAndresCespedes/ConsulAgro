update gen_programa g
set g.prog_app = 25
where g.prog_nombre_formulario in('COMM201', 'COMM001');
commit;
/
