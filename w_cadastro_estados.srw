HA$PBExportHeader$w_cadastro_estados.srw
forward
global type w_cadastro_estados from w_ancestral_cadastro
end type
end forward

global type w_cadastro_estados from w_ancestral_cadastro
integer width = 2526
string title = "Cadastro de Estados"
string icon = "Imagens\globe.ico"
end type
global w_cadastro_estados w_cadastro_estados

forward prototypes
protected subroutine of_filtrar ()
protected function boolean of_validar_gravacao ()
protected function long of_codigo_principal ()
end prototypes

protected subroutine of_filtrar ();String ls_SQLOriginal, ls_Where

ls_SQLOriginal = idw_Resultado.GetSQLSelect()

If f_Null(idw_Filtro.GetItemNumber(1, 'idestado'), 0) > 0 Then
	ls_Where += ' AND IDESTADO = ' + String(idw_Filtro.GetItemNumber(1, 'idestado'))
End If

If Trim(f_Null(idw_Filtro.GetItemString(1, 'estado'), '')) <> '' Then
	ls_Where += " AND (UPPER(ESTADO) LIKE '%" + Upper(idw_Filtro.GetItemString(1, 'estado')) + "%') "
End If

If Trim(f_Null(idw_Filtro.GetItemString(1, 'regiao'), '')) <> '' Then
	ls_Where += " AND (UPPER(REGIAO) LIKE '%" + Upper(idw_Filtro.GetItemString(1, 'regiao')) + "%') "
End If

If Trim(f_Null(idw_Filtro.GetItemString(1, 'pais'), '')) <> '' Then
	ls_Where += " AND (UPPER(PAIS) LIKE '%" + Upper(idw_Filtro.GetItemString(1, 'pais')) + "%') "
End If

//Seta o SQL com os filtros
idw_Resultado.SetSQLSelect(ls_SQLOriginal + ls_Where)
//Executa o retrive para carregar do banco
idw_Resultado.Retrieve()
//Volta o SQL Original
idw_Resultado.SetSQLSelect(ls_SQLOriginal)
end subroutine

protected function boolean of_validar_gravacao ();String ls_Estado, ls_Erro

idw_Cadastro.AcceptText() //For$$HEX1$$e700$$ENDHEX$$a os valores a serem aceitos pela dw

ls_Estado = Trim(f_Null(idw_Cadastro.GetItemString(1, 'estado'), ''))

If Len(ls_Estado) = 0 Then
	ls_Erro = 'O Campo "Estado" n$$HEX1$$e300$$ENDHEX$$o foi preenchido.~r'
	idw_Cadastro.SetColumn("estado")
	idw_Cadastro.SetFocus()
End If

if ls_Erro <> '' Then
	MessageBox(gs_Sistema, 'Existem campos que precisam de sua aten$$HEX2$$e700e300$$ENDHEX$$o:~r~r' + ls_Erro + 'Verifique!')
	Return False
End If

Return True
end function

protected function long of_codigo_principal ();Return idw_Resultado.GetItemNumber(idw_Resultado.GetRow(), 'idestado')
end function

on w_cadastro_estados.create
call super::create
end on

on w_cadastro_estados.destroy
call super::destroy
end on

type cb_sair from w_ancestral_cadastro`cb_sair within w_cadastro_estados
integer x = 2065
end type

type tab_principal from w_ancestral_cadastro`tab_principal within w_cadastro_estados
integer width = 2503
end type

type tabpage_pesquisa from w_ancestral_cadastro`tabpage_pesquisa within tab_principal
integer width = 2473
end type

type cb_limpar from w_ancestral_cadastro`cb_limpar within tabpage_pesquisa
integer x = 1992
end type

type cb_pesquisar from w_ancestral_cadastro`cb_pesquisar within tabpage_pesquisa
integer x = 1992
end type

type dw_resultado from w_ancestral_cadastro`dw_resultado within tabpage_pesquisa
integer width = 2358
string dataobject = "d_estados_resultado"
end type

type dw_filtro from w_ancestral_cadastro`dw_filtro within tabpage_pesquisa
integer width = 1900
string dataobject = "d_estados_filtro"
end type

type cb_editar from w_ancestral_cadastro`cb_editar within tabpage_pesquisa
end type

type cb_incluir from w_ancestral_cadastro`cb_incluir within tabpage_pesquisa
end type

type gb_resultado from w_ancestral_cadastro`gb_resultado within tabpage_pesquisa
integer width = 2431
end type

type gb_filtro from w_ancestral_cadastro`gb_filtro within tabpage_pesquisa
integer width = 2431
end type

type tabpage_cadastro from w_ancestral_cadastro`tabpage_cadastro within tab_principal
integer width = 2473
end type

type cb_cancelar from w_ancestral_cadastro`cb_cancelar within tabpage_cadastro
end type

type cb_gravar from w_ancestral_cadastro`cb_gravar within tabpage_cadastro
end type

type dw_cadastro from w_ancestral_cadastro`dw_cadastro within tabpage_cadastro
integer width = 2358
string dataobject = "d_estados_cadastro"
end type

type gb_cadastro from w_ancestral_cadastro`gb_cadastro within tabpage_cadastro
integer width = 2439
end type

