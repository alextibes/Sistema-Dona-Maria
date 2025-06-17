HA$PBExportHeader$w_rel_vendas_analitico.srw
forward
global type w_rel_vendas_analitico from w_ancestral_relatorio
end type
end forward

global type w_rel_vendas_analitico from w_ancestral_relatorio
string title = "Vendas por produtos"
end type
global w_rel_vendas_analitico w_rel_vendas_analitico

forward prototypes
public subroutine of_gerar_relatorio ()
end prototypes

public subroutine of_gerar_relatorio ();Date ld_Inicial, ld_Final

ld_Inicial = dw_Filtro.GetItemDate(1, 'datainicial')
ld_Final = dw_Filtro.GetItemDate(1, 'datafinal')

dw_resultado.Retrieve(ld_Inicial, ld_Final)
end subroutine

on w_rel_vendas_analitico.create
call super::create
end on

on w_rel_vendas_analitico.destroy
call super::destroy
end on

event open;call super::open;dw_Filtro.SetItem(1, 'datainicial', Today())
dw_Filtro.SetItem(1, 'datafinal', Today())
end event

type cb_gerar from w_ancestral_relatorio`cb_gerar within w_rel_vendas_analitico
end type

type dw_resultado from w_ancestral_relatorio`dw_resultado within w_rel_vendas_analitico
string dataobject = "d_rel_vendas_analitico"
end type

type dw_filtro from w_ancestral_relatorio`dw_filtro within w_rel_vendas_analitico
string dataobject = "d_rel_filtro_datas"
end type

type gb_1 from w_ancestral_relatorio`gb_1 within w_rel_vendas_analitico
end type

type gb_2 from w_ancestral_relatorio`gb_2 within w_rel_vendas_analitico
end type

