HA$PBExportHeader$w_cadastro_embalagens.srw
forward
global type w_cadastro_embalagens from w_ancestral_cadastro
end type
end forward

global type w_cadastro_embalagens from w_ancestral_cadastro
integer width = 3385
string title = "Cadastro de Embalagens"
string icon = "Imagens\embalagem.ico"
end type
global w_cadastro_embalagens w_cadastro_embalagens

forward prototypes
protected function boolean of_validar_gravacao ()
protected subroutine of_filtrar ()
protected function long of_codigo_principal ()
end prototypes

protected function boolean of_validar_gravacao ();String ls_Descricao, ls_Sigla, ls_Erro

idw_Cadastro.AcceptText() //For$$HEX1$$e700$$ENDHEX$$a os valores a serem aceitos pela dw

ls_Descricao = Trim(f_Null(idw_Cadastro.GetItemString(1, 'descricao'), ''))
ls_Sigla = Trim(f_Null(idw_Cadastro.GetItemString(1, 'abreviacao'), ''))

If Len(ls_Descricao) = 0 Then
	ls_Erro = 'O Campo "Descri$$HEX2$$e700e300$$ENDHEX$$o" n$$HEX1$$e300$$ENDHEX$$o foi preenchido.~r'
	idw_Cadastro.SetColumn("descricao")
	idw_Cadastro.SetFocus()
End If

If Len(ls_Sigla) = 0 Then
	ls_Erro = 'O Campo "Abrica$$HEX2$$e700e300$$ENDHEX$$o" n$$HEX1$$e300$$ENDHEX$$o foi preenchido.~r'
	idw_Cadastro.SetColumn("abreviacao")
	idw_Cadastro.SetFocus()
End If

if ls_Erro <> '' Then
	MessageBox(gs_Sistema, 'Existem campos que precisam de sua aten$$HEX2$$e700e300$$ENDHEX$$o:~r~r' + ls_Erro + 'Verifique!')
	Return False
End If

Return True
end function

protected subroutine of_filtrar ();String ls_SQLOriginal, ls_Where

ls_SQLOriginal = idw_Resultado.GetSQLSelect()

If f_Null(idw_Filtro.GetItemNumber(1, 'id_embalagem'), 0) > 0 Then
	ls_Where += ' AND ID_EMBALAGEM = ' + String(idw_Filtro.GetItemNumber(1, 'id_embalagem'))
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

protected function long of_codigo_principal ();Return idw_Resultado.GetItemNumber(idw_Resultado.GetRow(), 'id_embalagem')
end function

on w_cadastro_embalagens.create
call super::create
end on

on w_cadastro_embalagens.destroy
call super::destroy
end on

type cb_sair from w_ancestral_cadastro`cb_sair within w_cadastro_embalagens
integer x = 2858
end type

type tab_principal from w_ancestral_cadastro`tab_principal within w_cadastro_embalagens
integer width = 3335
end type

type tabpage_pesquisa from w_ancestral_cadastro`tabpage_pesquisa within tab_principal
integer width = 3305
end type

type cb_limpar from w_ancestral_cadastro`cb_limpar within tabpage_pesquisa
integer x = 2786
end type

type cb_pesquisar from w_ancestral_cadastro`cb_pesquisar within tabpage_pesquisa
integer x = 2786
end type

type dw_resultado from w_ancestral_cadastro`dw_resultado within tabpage_pesquisa
integer width = 3194
string dataobject = "d_embalagens_resultado"
end type

type dw_filtro from w_ancestral_cadastro`dw_filtro within tabpage_pesquisa
integer width = 2736
string dataobject = "d_embalagens_filtro"
end type

type cb_editar from w_ancestral_cadastro`cb_editar within tabpage_pesquisa
end type

type cb_incluir from w_ancestral_cadastro`cb_incluir within tabpage_pesquisa
end type

type gb_resultado from w_ancestral_cadastro`gb_resultado within tabpage_pesquisa
integer width = 3267
end type

type gb_filtro from w_ancestral_cadastro`gb_filtro within tabpage_pesquisa
integer width = 3270
end type

type tabpage_cadastro from w_ancestral_cadastro`tabpage_cadastro within tab_principal
integer width = 3305
end type

type cb_cancelar from w_ancestral_cadastro`cb_cancelar within tabpage_cadastro
end type

type cb_gravar from w_ancestral_cadastro`cb_gravar within tabpage_cadastro
end type

type dw_cadastro from w_ancestral_cadastro`dw_cadastro within tabpage_cadastro
integer width = 3164
string dataobject = "d_embalagens_cadastro"
end type

type gb_cadastro from w_ancestral_cadastro`gb_cadastro within tabpage_cadastro
integer width = 3259
end type

