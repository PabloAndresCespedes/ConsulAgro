select tmov_desc, tmov_codigo
from gen_tipo_mov
where tmov_empr=:parameter.p_empresa
and tmov_codigo in
(
:bconf.conf_recibo_cncr_emit,
:bconf.conf_recibo_cncr_rec,
:BCONF.CONF_RECIBO_CNCR_REC_H,
:bconf.conf_recibo_cadcli_emit,
:bconf.conf_recibo_cadpro_rec
)
order by 1
