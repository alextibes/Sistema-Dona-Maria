HA$PBExportHeader$w_cadastro_usuarios.srw
forward
global type w_cadastro_usuarios from w_ancestral_cadastro
end type
type cb_senha from u_commandbutton within tabpage_cadastro
end type
end forward

global type w_cadastro_usuarios from w_ancestral_cadastro
string title = "Cadastro de Usu$$HEX1$$e100$$ENDHEX$$rios"
string icon = "Imagens\usuario.ico"
end type
global w_cadastro_usuarios w_cadastro_usuarios

forward prototypes
protected subroutine of_filtrar ()
protected function boolean of_validar_gravacao ()
protected function long of_codigo_principal ()
end prototypes

protected subroutine of_filtrar ();String ls_SQLOriginal, ls_Where

ls_SQLOriginal = idw_Resultado.GetSQLSelect()

If f_Null(idw_Filtro.GetItemNumber(1, 'idusuario'), 0) > 0 Then
	ls_Where += ' AND ID_USUARIO = ' + String(idw_Filtro.GetItemNumber(1, 'id_usuario'))
End If

ls_Where += " AND FLAG_INATIVO = " + idw_Filtro.GetItemString(1, 'flag_inativo')

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
ls_Login = Trim(f_Null(idw_Cadastro.GetItemString(1, 'login'), ''))

If Len(ls_Nome) = 0 Then
	ls_Erro = 'O Campo "Nome" n$$HEX1$$e300$$ENDHEX$$o foi preenchido.~r'
End If

If Len(ls_Login) = 0 Then
	ls_Erro += 'O Campo "Login" n$$HEX1$$e300$$ENDHEX$$o foi preenchido.~r'
End If

if ls_Erro <> '' Then
	MessageBox(gs_Sistema, 'Existem campos que precisam de sua aten$$HEX2$$e700e300$$ENDHEX$$o:~r~r' + ls_Erro + 'Verifique!')
	Return False
End If

//Atualiza a data da ultima altera$$HEX2$$e700e300$$ENDHEX$$o
idw_Cadastro.SetItem(1, 'data_alteracao', Now())

Return True
end function

protected function long of_codigo_principal ();Return idw_Resultado.GetItemNumber(idw_Resultado.GetRow(), 'id_usuario')
end function

on w_cadastro_usuarios.create
int iCurrent
call super::create
end on

on w_cadastro_usuarios.destroy
call super::destroy
end on

type cb_sair from w_ancestral_cadastro`cb_sair within w_cadastro_usuarios
end type

type tab_principal from w_ancestral_cadastro`tab_principal within w_cadastro_usuarios
end type

type tabpage_pesquisa from w_ancestral_cadastro`tabpage_pesquisa within tab_principal
end type

type cb_limpar from w_ancestral_cadastro`cb_limpar within tabpage_pesquisa
end type

type cb_pesquisar from w_ancestral_cadastro`cb_pesquisar within tabpage_pesquisa
end type

type dw_resultado from w_ancestral_cadastro`dw_resultado within tabpage_pesquisa
string dataobject = "d_usuarios_resultado"
end type

type dw_filtro from w_ancestral_cadastro`dw_filtro within tabpage_pesquisa
string dataobject = "d_usuarios_filtro"
boolean livescroll = false
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
cb_senha cb_senha
end type

on tabpage_cadastro.create
this.cb_senha=create cb_senha
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_senha
end on

on tabpage_cadastro.destroy
call super::destroy
destroy(this.cb_senha)
end on

type cb_cancelar from w_ancestral_cadastro`cb_cancelar within tabpage_cadastro
end type

type cb_gravar from w_ancestral_cadastro`cb_gravar within tabpage_cadastro
end type

type dw_cadastro from w_ancestral_cadastro`dw_cadastro within tabpage_cadastro
string dataobject = "d_usuarios_cadastro"
end type

type gb_cadastro from w_ancestral_cadastro`gb_cadastro within tabpage_cadastro
end type

type cb_senha from u_commandbutton within tabpage_cadastro
integer x = 2171
integer y = 568
integer width = 691
integer height = 104
integer taborder = 50
boolean bringtotop = true
string text = "Alterar a senha"
end type

event clicked;call super::clicked;s_Valores lst_Enviar

lst_Enviar.String[1] = dw_cadastro.GetItemString(1, 'nome')
lst_Enviar.Long[1] = dw_cadastro.GetItemNumber(1, 'id_usuario')

openWithParm(w_senha_usuarios, lst_Enviar)
end event

