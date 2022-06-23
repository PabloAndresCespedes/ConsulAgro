PROCEDURE PP_EJECUTAR_CONSULTA_CUO IS
-- OBS: se separaron los cursores para clientes y proveedores
-- por razones de performance. Antes de esto se tenía dos
-- cursores en vez de cuatro.
-- cursor para seleccionar notas de credito y adelantos de proveedores
CURSOR NCR_REC_CUR IS
SELECT DOC_NRO_DOC ,
DOC_FEC_DOC ,
DOC_SUC ,
CUO_FEC_VTO ,
CUO_IMP_MON ,
CUO_SALDO_MON ,
CUO_SALDO_LOC ,
CUO_CLAVE_DOC ,
DOC_MON ,
MON_DEC_IMP ,
MON_DEC_TASA ,
MON_SIMBOLO ,
MON_TASA_VTA

FROM GEN_MONEDA TM ,
FIN_DOCUMENTO FA ,
FIN_CUOTA CU

WHERE MON_CODIGO = DOC_MON
AND MON_EMPR = DOC_EMPR
AND DOC_EMPR = CUO_EMPR
AND DOC_CLAVE = CUO_CLAVE_DOC
AND DOC_EMPR = :PARAMETER.P_EMPRESA
AND DOC_PROV = :BDOC.S_CUENTA
AND DOC_FEC_DOC <= :BDOC.DOC_FEC_OPER -- porque no se puede cancelar un documento que todavía no se emitió y también crea problemas en DOC_SALDO_PER_ACT_LOC dejándolo negativo si se cancela un documento del periodo siguiente en el periodo actual.

AND ( -- /*
( :BDOC.DOC_TIPO_MOV = :BCONF.CONF_RECIBO_CNCR_REC
AND :BDOC.W_IND_ER = 'R'

AND DOC_TIPO_MOV IN (:BCONF.CONF_NOTA_CR_REC,
:BCONF.CONF_NOTA_DB_EMIT_PROV,
:BCONF.TMOV_NOTA_CR_REC_AJUSTE
)
)

OR --*/
( :BDOC.DOC_TIPO_MOV = :BCONF.CONF_RECIBO_CNCR_REC_H
AND DOC_TIPO_MOV IN (:BCONF.CONF_NOTA_CR_REC_H
)
)
-- /*
OR ( :BDOC.DOC_TIPO_MOV = :BCONF.CONF_RECIBO_CADPRO_REC
AND DOC_TIPO_MOV = :BCONF.CONF_ADELANTO_PRO
)
-- */
)

AND CUO_SALDO_MON > 0
AND (DOC_MON = :BDOC.DOC_MON OR :BDOC.DOC_MON IS NULL)
AND DOC_OPERADOR = :BDOC.DOC_OPERADOR


ORDER BY CUO_FEC_VTO, DOC_FEC_DOC, DOC_NRO_DOC;

-- cursor para seleccionar notas de credito y adelantos emitidos
CURSOR NCR_EMI_CUR IS
SELECT DOC_NRO_DOC, DOC_FEC_DOC, DOC_SUC, CUO_FEC_VTO,
CUO_IMP_MON, CUO_SALDO_MON, CUO_SALDO_LOC, CUO_CLAVE_DOC,
DOC_MON, MON_DEC_IMP, MON_DEC_TASA, MON_SIMBOLO, MON_TASA_VTA, DOC_CLAVE_SCLI
FROM GEN_MONEDA, FIN_DOCUMENTO, FIN_CUOTA
WHERE MON_CODIGO = DOC_MON
AND CUO_CLAVE_DOC = DOC_CLAVE
and doc_empr=mon_empr
and doc_empr=cuo_empr
AND DOC_EMPR = :PARAMETER.P_EMPRESA
AND DOC_FEC_DOC <= :BDOC.DOC_FEC_OPER --porque no se puede cancelar un documento que todavía no se emitió y también crea problemas en DOC_SALDO_PER_ACT_LOC dejándolo negativo si se cancela un documento del periodo siguiente en el periodo actual.
AND ((DOC_CLI = :BDOC.S_CUENTA
AND DOC_TIPO_MOV IN (:BCONF.CONF_NOTA_CR_EMIT,:BCONF.TMOV_NOTA_CR_EMIT_AJUSTE)
AND :BDOC.DOC_TIPO_MOV = :BCONF.CONF_RECIBO_CNCR_EMIT)
OR (DOC_CLI = :BDOC.S_CUENTA
AND DOC_TIPO_MOV = :BCONF.CONF_ADELANTO_CLI
AND :BDOC.DOC_TIPO_MOV = :BCONF.CONF_RECIBO_CADCLI_EMIT))
AND CUO_SALDO_MON > 0
AND (DOC_MON = :BDOC.DOC_MON OR :BDOC.DOC_MON IS NULL)
---AND DOC_OPERADOR = :BDOC.DOC_OPERADOR
ORDER BY CUO_FEC_VTO, DOC_FEC_DOC, DOC_NRO_DOC;

-- cursor para seleccionar facturas y ND recibidas
CURSOR FACT_REC_CUR IS
SELECT DOC_NRO_DOC,
DOC_FEC_DOC,
DOC_SUC,
CUO_FEC_VTO,
CUO_IMP_MON,
CUO_SALDO_MON,
CUO_SALDO_LOC,
CUO_CLAVE_DOC,
DOC_MON,
MON_DEC_IMP,
MON_DEC_TASA,
MON_SIMBOLO,
MON_TASA_VTA

FROM GEN_MONEDA,
FIN_DOCUMENTO,
FIN_CUOTA

WHERE MON_EMPR = DOC_EMPR
AND MON_CODIGO = DOC_MON
AND DOC_EMPR = CUO_EMPR
AND DOC_CLAVE = CUO_CLAVE_DOC
AND DOC_EMPR = :PARAMETER.P_EMPRESA
AND DOC_PROV = :BDOC.S_CUENTA
AND DOC_FEC_DOC <= :BDOC.DOC_FEC_OPER --porque no se puede cancelar un documento que todavía no se emitió y también crea problemas en DOC_SALDO_PER_ACT_LOC dejándolo negativo si se cancela un documento del periodo siguiente en el periodo actual.

AND (
(
DOC_TIPO_MOV IN
(
:BCONF.CONF_NOTA_DB_REC,
:BCONF.CONF_FACT_CR_REC,
:BCONF.TMOV_DESPACHO,
:BCONF.TMOV_FACT_CR_REC_AJUSTE
)
AND :BDOC.W_IND_ER = 'R'
AND :BDOC.DOC_TIPO_MOV NOT IN(:CONF_RECIBO_CNCR_REC_H)
)
OR
(
DOC_TIPO_MOV IN
(
:BCONF.CONF_FACT_CR_REC_H ,
:BCONF.CONF_FACT_CO_REC_H ,
:BCONF.CONF_FACT_COMPRA_H ,
:BCONF.CONF_NOTA_DB_REC_H
)
AND :BDOC.W_IND_ER = 'R'
AND :BDOC.DOC_TIPO_MOV IN (:CONF_RECIBO_CNCR_REC_H)
)
)

AND CUO_SALDO_MON > 0
AND (DOC_MON = :BDOC.DOC_MON OR :BDOC.DOC_MON IS NULL)
AND DOC_OPERADOR = :BDOC.DOC_OPERADOR
ORDER BY CUO_FEC_VTO, DOC_FEC_DOC, DOC_NRO_DOC;

-- cursor para seleccionar facturas, ND emitidas y OrdenesDeCompras
CURSOR FACT_EMI_CUR IS
SELECT DOC_NRO_DOC, DOC_FEC_DOC, DOC_SUC, CUO_FEC_VTO,
CUO_IMP_MON, CUO_SALDO_MON, CUO_SALDO_LOC, CUO_CLAVE_DOC,
DOC_MON, MON_DEC_IMP, MON_DEC_TASA, MON_SIMBOLO, MON_TASA_VTA, DOC_CLAVE_SCLI
FROM GEN_MONEDA, FIN_DOCUMENTO, FIN_CUOTA
WHERE MON_CODIGO = DOC_MON
AND CUO_CLAVE_DOC = DOC_CLAVE
and doc_empr=mon_empr
and doc_empr=cuo_empr
AND DOC_EMPR = :PARAMETER.P_EMPRESA
AND DOC_FEC_DOC <= :BDOC.DOC_FEC_OPER --porque no se puede cancelar un documento que todavía no se emitió y también crea problemas en DOC_SALDO_PER_ACT_LOC dejándolo negativo si se cancela un documento del periodo siguiente en el periodo actual.
AND ((DOC_CLI = :BDOC.S_CUENTA
AND DOC_TIPO_MOV IN
(:BCONF.CONF_NOTA_DB_EMIT,
:BCONF.CONF_TMOV_ORDEN_COMPRA,
:BCONF.CONF_FACT_CR_EMIT,
:BCONF.TMOV_FACT_CR_EMIT_AJUSTE)
AND :BDOC.W_IND_ER = 'E'))
AND CUO_SALDO_MON > 0
AND (DOC_MON = :BDOC.DOC_MON OR :BDOC.DOC_MON IS NULL)
--- AND DOC_OPERADOR = :BDOC.DOC_OPERADOR
ORDER BY CUO_FEC_VTO, DOC_FEC_DOC, DOC_NRO_DOC;



BEGIN
-- Cargar las cuotas de las notas de credito y adelantos
-- de cliente/proveedor al bloque BCNCR



GO_BLOCK('BCNCR');
first_record;
break;
IF :BDOC.W_IND_ER = 'R' THEN
-- PL_EXHIBIR_MENSAJE('NCR_REC_CUR');
FOR RCUO IN NCR_REC_CUR LOOP

:BCNCR.DOC_NRO_DOC := RCUO.DOC_NRO_DOC;
:BCNCR.DOC_FEC_DOC := RCUO.DOC_FEC_DOC;
:BCNCR.DOC_SUC := RCUO.DOC_SUC;
:BCNCR.CUO_FEC_VTO := RCUO.CUO_FEC_VTO;
:BCNCR.CUO_IMP_MON := RCUO.CUO_IMP_MON;
:BCNCR.CUO_SALDO_MON := RCUO.CUO_SALDO_MON;
:BCNCR.CUO_SALDO_LOC := RCUO.CUO_SALDO_LOC;
:BCNCR.CUO_CLAVE_DOC := RCUO.CUO_CLAVE_DOC;
:BCNCR.W_MON := RCUO.DOC_MON;
:BCNCR.W_MON_DEC_IMP := RCUO.MON_DEC_IMP;
:BCNCR.W_MON_DEC_TASA:= 4;
:BCNCR.S_MON_SIMBOLO := RCUO.MON_SIMBOLO;
if :BCNCR.W_MON=:parameter.p_mon_loc then
:BCNCR.S_TASA := 1;
else
:BCNCR.S_TASA := fin_buscar_cotizacion_fec(:BDOC.DOC_FEC_OPER,2,:parameter.p_empresa);--RCUO.MON_TASA_VTA;
end if;
:BCNCR.S_LOC_SIMBOLO := :PARAMETER.P_LOC_SIMBOLO;
NEXT_RECORD;
END LOOP;
ELSE
FOR RCUO IN NCR_EMI_CUR LOOP
:BCNCR.DOC_NRO_DOC := RCUO.DOC_NRO_DOC;
:BCNCR.DOC_FEC_DOC := RCUO.DOC_FEC_DOC;
:BCNCR.DOC_SUC := RCUO.DOC_SUC;
:BCNCR.CUO_FEC_VTO := RCUO.CUO_FEC_VTO;
:BCNCR.CUO_IMP_MON := RCUO.CUO_IMP_MON;
:BCNCR.CUO_SALDO_MON := RCUO.CUO_SALDO_MON;
:BCNCR.CUO_SALDO_LOC := RCUO.CUO_SALDO_LOC;
:BCNCR.CUO_CLAVE_DOC := RCUO.CUO_CLAVE_DOC;
:BCNCR.W_MON := RCUO.DOC_MON;
:BCNCR.W_MON_DEC_IMP := RCUO.MON_DEC_IMP;
:BCNCR.W_MON_DEC_TASA:= 4;
:BCNCR.S_MON_SIMBOLO := RCUO.MON_SIMBOLO;
if :BCNCR.W_MON=:parameter.p_mon_loc then
:BCNCR.S_TASA := 1;
else
:BCNCR.S_TASA := fin_buscar_cotizacion_fec(:BDOC.DOC_FEC_OPER,2,:parameter.p_empresa);--RCUO.MON_TASA_VTA;
end if;
:BCNCR.S_LOC_SIMBOLO := :PARAMETER.P_LOC_SIMBOLO;
:BCNCR.DOC_CLAVE_SCLI := RCUO.DOC_CLAVE_SCLI;
NEXT_RECORD;
END LOOP;
END IF;



FIRST_RECORD;
IF :BCNCR.CUO_CLAVE_DOC IS NULL THEN
GO_ITEM('BDOC.S_CUENTA');
PL_EXHIBIR_ERROR('No existen notas de credito ni adelantos pendientes a la fecha: '||:BDOC.S_DOC_FEC_OPER||' !');
END IF;



-- cargar las cuotas de facturas credito y notas debito
-- al bloque BCFACT
GO_BLOCK('BCFACT');
first_record;
--
IF :BDOC.W_IND_ER = 'R' THEN
FOR RCUO IN FACT_REC_CUR LOOP
:BCFACT.DOC_NRO_DOC := RCUO.DOC_NRO_DOC;
:BCFACT.DOC_FEC_DOC := RCUO.DOC_FEC_DOC;
:BCFACT.DOC_SUC := RCUO.DOC_SUC;
:BCFACT.CUO_FEC_VTO := RCUO.CUO_FEC_VTO;
:BCFACT.CUO_IMP_MON := RCUO.CUO_IMP_MON;
:BCFACT.CUO_SALDO_MON := RCUO.CUO_SALDO_MON;
:BCFACT.CUO_SALDO_LOC := RCUO.CUO_SALDO_LOC;
:BCFACT.CUO_CLAVE_DOC := RCUO.CUO_CLAVE_DOC;
:BCFACT.W_MON := RCUO.DOC_MON;
:BCFACT.W_MON_DEC_IMP := RCUO.MON_DEC_IMP;
:BCFACT.W_MON_DEC_TASA:= 4;
:BCFACT.S_MON_SIMBOLO := RCUO.MON_SIMBOLO;
if :BCFACT.W_MON = :parameter.p_mon_loc then
:BCFACT.S_TASA := 1;
else
:BCFACT.S_TASA := fin_buscar_cotizacion_fec(:BDOC.DOC_FEC_OPER,2,:parameter.p_empresa);--RCUO.MON_TASA_VTA;
end if;
:BCFACT.S_LOC_SIMBOLO := :PARAMETER.P_LOC_SIMBOLO;
NEXT_RECORD;
END LOOP;
ELSE
FOR RCUO IN FACT_EMI_CUR LOOP
:BCFACT.DOC_NRO_DOC := RCUO.DOC_NRO_DOC;
:BCFACT.DOC_FEC_DOC := RCUO.DOC_FEC_DOC;
:BCFACT.DOC_SUC := RCUO.DOC_SUC;
:BCFACT.CUO_FEC_VTO := RCUO.CUO_FEC_VTO;
:BCFACT.CUO_IMP_MON := RCUO.CUO_IMP_MON;
:BCFACT.CUO_SALDO_MON := RCUO.CUO_SALDO_MON;
:BCFACT.CUO_SALDO_LOC := RCUO.CUO_SALDO_LOC;
:BCFACT.CUO_CLAVE_DOC := RCUO.CUO_CLAVE_DOC;
:BCFACT.W_MON := RCUO.DOC_MON;
:BCFACT.W_MON_DEC_IMP := RCUO.MON_DEC_IMP;
:BCFACT.W_MON_DEC_TASA:= 4;
:BCFACT.S_MON_SIMBOLO := RCUO.MON_SIMBOLO;
if :BCFACT.W_MON = :parameter.p_mon_loc then
:BCFACT.S_TASA := 1;
else

:BCFACT.S_TASA := fin_buscar_cotizacion_fec(:BDOC.DOC_FEC_OPER,2,:parameter.p_empresa);--RCUO.MON_TASA_VTA;
end if;
:BCFACT.S_LOC_SIMBOLO := :PARAMETER.P_LOC_SIMBOLO;
:BCFACT.FDOC_CLAVE_SCLI := RCUO.DOC_CLAVE_SCLI;
NEXT_RECORD;
END LOOP;
END IF;
--
FIRST_RECORD;
/*
IF :BCFACT.CUO_CLAVE_DOC IS NULL THEN
GO_ITEM('BDOC.S_CUENTA');
PL_EXHIBIR_ERROR('No existen documentos pendientes a la fecha: '||:BDOC.S_DOC_FEC_OPER||' !');
END IF;
*/
GO_BLOCK('BCNCR');
FIRST_RECORD;



END;