HA$PBExportHeader$w_cadastro_fornecedores.srw
forward
global type w_cadastro_fornecedores from w_ancestral_cadastro
end type
end forward

global type w_cadastro_fornecedores from w_ancestral_cadastro
string title = "Cadastro de Fornecedores"
string icon = "Imagens\fornecedor.ico"
end type
global w_cadastro_fornecedores w_cadastro_fornecedores

forward prototypes
protected subroutine of_filtrar ()
protected function boolean of_validar_gravacao ()
protected function long of_codigo_principal ()
end prototypes

protected subroutine of_filtrar ();String ls_SQLOriginal, ls_Where

ls_SQLOriginal = idw_Resultado.GetSQLSelect()

If f_Null(idw_Filtro.GetItemNumber(1, 'idfornecedor'), 0) > 0 Then
	ls_Where += ' AND IDFORNECEDOR = ' + String(idw_Filtro.GetItemNumber(1, 'idfornecedor'))
End If

If idw_Filtro.GetItemString(1, 'flaginativo') = 'F' Then
	ls_Where += " AND FLAGINATIVO = 'F' "
Else
	ls_Where += " AND FLAGINATIVO = 'T' "
End If

If Trim(f_Null(idw_Filtro.GetItemString(1, 'nome'), '')) <> '' Then
	ls_Where += " AND (UPPER(NOME) LIKE '%" + Upper(idw_Filtro.GetItemString(1, 'nome')) + "%') "
End If

//Seta o SQL com os filtros
idw_Resultado.SetSQLSelect(ls_SQLOriginal + ls_Where)
//Executa o retrive para carregar do banco
idw_Resultado.Retrieve()
//Volta o SQL Original
idw_Resultado.SetSQLSelect(ls_SQLOriginal)
end subroutine

protected function boolean of_validar_gravacao ();String ls_Nome, ls_Erro, ls_Senha, ls_Login

idw_Cadastro.AcceptText() //For$$HEX1$$e700$$ENDHEX$$a os valores a serem aceitos pela dw

ls_Nome = Trim(f_Null(idw_Cadastro.GetItemString(1, 'nome'), ''))

If Len(ls_Nome) = 0 Then
	ls_Erro = 'O Campo "Nome" n$$HEX1$$e300$$ENDHEX$$o foi preenchido.~r'
	idw_Cadastro.SetColumn('nome')
	idw_Cadastro.SetFocus()
End If

if ls_Erro <> '' Then
	MessageBox(gs_Sistema, 'Existem campos que precisam de sua aten$$HEX2$$e700e300$$ENDHEX$$o:~r~r' + ls_Erro + 'Verifique!')
	Return False
End If

//Atualiza a data da ultima altera$$HEX2$$e700e300$$ENDHEX$$o
idw_Cadastro.SetItem(1, 'dataalteracao', Now())

Return True
end function

protected function long of_codigo_principal ();Return idw_Resultado.GetItemNumber(idw_Resultado.GetRow(), 'id_fornecedor')
end function

on w_cadastro_fornecedores.create
call super::create
end on

on w_cadastro_fornecedores.destroy
call super::destroy
end on

type cb_sair from w_ancestral_cadastro`cb_sair within w_cadastro_fornecedores
end type

type tab_principal from w_ancestral_cadastro`tab_principal within w_cadastro_fornecedores
end type

type tabpage_pesquisa from w_ancestral_cadastro`tabpage_pesquisa within tab_principal
end type

type cb_limpar from w_ancestral_cadastro`cb_limpar within tabpage_pesquisa
end type

type cb_pesquisar from w_ancestral_cadastro`cb_pesquisar within tabpage_pesquisa
end type

type dw_resultado from w_ancestral_cadastro`dw_resultado within tabpage_pesquisa
string dataobject = "d_fornecedores_resultado"
end type

type dw_filtro from w_ancestral_cadastro`dw_filtro within tabpage_pesquisa
string dataobject = "d_fornecedores_filtro"
end type

type cb_editar from w_ancestral_cadastro`cb_editar within tabpage_pesquisa
end type

type cb_incluir from w_ancestral_cadastro`cb_incluir within tabpage_pesquisa
end type

type gb_resultado from w_ancestral_cadastro`gb_resultado within tabpage_pesquisa
end type

type gb_filtro from w_ancestral_cadastro`gb_filtro within tabpage_pesquisa
end type

type tabpage_cadastro from w_ancestral_cadastro`tabpage_cadastro within tab_principal
end type

type cb_cancelar from w_ancestral_cadastro`cb_cancelar within tabpage_cadastro
end type

type cb_gravar from w_ancestral_cadastro`cb_gravar within tabpage_cadastro
end type

type dw_cadastro from w_ancestral_cadastro`dw_cadastro within tabpage_cadastro
string dataobject = "d_fornecedores_cadastro"
end type

type gb_cadastro from w_ancestral_cadastro`gb_cadastro within tabpage_cadastro
end type

