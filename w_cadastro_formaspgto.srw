HA$PBExportHeader$w_cadastro_formaspgto.srw
forward
global type w_cadastro_formaspgto from w_ancestral_cadastro
end type
end forward

global type w_cadastro_formaspgto from w_ancestral_cadastro
integer width = 2255
string title = "Cadastro de Formas de Pagamento"
string icon = "Imagens\pagamento.ico"
long il_minwidth = 2187
long il_minheight = 2003
end type
global w_cadastro_formaspgto w_cadastro_formaspgto

forward prototypes
protected subroutine of_filtrar ()
protected function boolean of_validar_gravacao ()
protected function long of_codigo_principal ()
end prototypes

protected subroutine of_filtrar ();String ls_SQLOriginal, ls_Where

ls_SQLOriginal = idw_Resultado.GetSQLSelect()

If f_Null(idw_Filtro.GetItemNumber(1, 'id_forma_pagamento'), 0) > 0 Then
	ls_Where += ' AND ID_FORMA_PAGAMENTO = ' + String(idw_Filtro.GetItemNumber(1, 'id_forma_pagamento'))
End If

If Trim(f_Null(idw_Filtro.GetItemString(1, 'descricao'), '')) <> '' Then
	ls_Where += " AND (UPPER(DESCRICAO) LIKE '%" + Upper(idw_Filtro.GetItemString(1, 'descricao')) + "%') "
End If

//Seta o SQL com os filtros
idw_Resultado.SetSQLSelect(ls_SQLOriginal + ls_Where)
//Executa o retrive para carregar do banco
idw_Resultado.Retrieve()
//Volta o SQL Original
idw_Resultado.SetSQLSelect(ls_SQLOriginal)
end subroutine

protected function boolean of_validar_gravacao ();String ls_Descricao, ls_Erro

idw_Cadastro.AcceptText() //For$$HEX1$$e700$$ENDHEX$$a os valores a serem aceitos pela dw

ls_Descricao = Trim(f_Null(idw_Cadastro.GetItemString(1, 'descricao'), ''))

If Len(ls_Descricao) = 0 Then
	ls_Erro = 'O Campo "Descri$$HEX2$$e700e300$$ENDHEX$$o" n$$HEX1$$e300$$ENDHEX$$o foi preenchido.~r'
	idw_Cadastro.SetColumn("descricao")
	idw_Cadastro.SetFocus()
End If

if ls_Erro <> '' Then
	MessageBox(gs_Sistema, 'Existem campos que precisam de sua aten$$HEX2$$e700e300$$ENDHEX$$o:~r~r' + ls_Erro + 'Verifique!')
	Return False
End If

idw_Cadastro.SetItem(1, 'atualizado_em', now())

If f_Null(idw_Cadastro.GetItemNumber(1, 'id_forma_pagamento'), 0) = 0 Then
	idw_Cadastro.SetItem(1, 'criado_em', now())
End If

Return True
end function

protected function long of_codigo_principal ();Return idw_Resultado.GetItemNumber(idw_Resultado.GetRow(), 'id_forma_pagamento')
end function

on w_cadastro_formaspgto.create
call super::create
end on

on w_cadastro_formaspgto.destroy
call super::destroy
end on

type cb_sair from w_ancestral_cadastro`cb_sair within w_cadastro_formaspgto
integer x = 1755
end type

type tab_principal from w_ancestral_cadastro`tab_principal within w_cadastro_formaspgto
integer width = 2194
end type

type tabpage_pesquisa from w_ancestral_cadastro`tabpage_pesquisa within tab_principal
integer width = 2164
end type

type cb_limpar from w_ancestral_cadastro`cb_limpar within tabpage_pesquisa
integer x = 1683
end type

type cb_pesquisar from w_ancestral_cadastro`cb_pesquisar within tabpage_pesquisa
integer x = 1683
end type

type dw_resultado from w_ancestral_cadastro`dw_resultado within tabpage_pesquisa
integer width = 2049
string dataobject = "d_formaspgto_resultado"
end type

type dw_filtro from w_ancestral_cadastro`dw_filtro within tabpage_pesquisa
integer width = 2049
string dataobject = "d_formaspgto_filtro"
end type

type cb_editar from w_ancestral_cadastro`cb_editar within tabpage_pesquisa
end type

type cb_incluir from w_ancestral_cadastro`cb_incluir within tabpage_pesquisa
end type

type gb_resultado from w_ancestral_cadastro`gb_resultado within tabpage_pesquisa
integer width = 2122
end type

type gb_filtro from w_ancestral_cadastro`gb_filtro within tabpage_pesquisa
integer width = 2122
end type

type tabpage_cadastro from w_ancestral_cadastro`tabpage_cadastro within tab_principal
integer width = 2164
end type

type cb_cancelar from w_ancestral_cadastro`cb_cancelar within tabpage_cadastro
end type

type cb_gravar from w_ancestral_cadastro`cb_gravar within tabpage_cadastro
end type

type dw_cadastro from w_ancestral_cadastro`dw_cadastro within tabpage_cadastro
integer width = 2030
string dataobject = "d_formaspgto_cadastro"
end type

type gb_cadastro from w_ancestral_cadastro`gb_cadastro within tabpage_cadastro
integer width = 2126
end type

