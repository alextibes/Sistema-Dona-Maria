HA$PBExportHeader$w_ancestral_cadastro.srw
forward
global type w_ancestral_cadastro from w_ancestral
end type
type cb_sair from u_commandbutton within w_ancestral_cadastro
end type
type tab_principal from tab within w_ancestral_cadastro
end type
type tabpage_pesquisa from userobject within tab_principal
end type
type cb_limpar from u_commandbutton within tabpage_pesquisa
end type
type cb_pesquisar from u_commandbutton within tabpage_pesquisa
end type
type dw_resultado from u_datawindow within tabpage_pesquisa
end type
type dw_filtro from u_datawindow within tabpage_pesquisa
end type
type cb_editar from u_commandbutton within tabpage_pesquisa
end type
type cb_incluir from u_commandbutton within tabpage_pesquisa
end type
type gb_resultado from u_groupbox within tabpage_pesquisa
end type
type gb_filtro from u_groupbox within tabpage_pesquisa
end type
type tabpage_pesquisa from userobject within tab_principal
cb_limpar cb_limpar
cb_pesquisar cb_pesquisar
dw_resultado dw_resultado
dw_filtro dw_filtro
cb_editar cb_editar
cb_incluir cb_incluir
gb_resultado gb_resultado
gb_filtro gb_filtro
end type
type tabpage_cadastro from userobject within tab_principal
end type
type cb_cancelar from u_commandbutton within tabpage_cadastro
end type
type cb_gravar from u_commandbutton within tabpage_cadastro
end type
type dw_cadastro from u_datawindow within tabpage_cadastro
end type
type gb_cadastro from u_groupbox within tabpage_cadastro
end type
type tabpage_cadastro from userobject within tab_principal
cb_cancelar cb_cancelar
cb_gravar cb_gravar
dw_cadastro dw_cadastro
gb_cadastro gb_cadastro
end type
type tab_principal from tab within w_ancestral_cadastro
tabpage_pesquisa tabpage_pesquisa
tabpage_cadastro tabpage_cadastro
end type
end forward

global type w_ancestral_cadastro from w_ancestral
integer width = 4179
integer height = 2090
boolean utiliza_resize = true
cb_sair cb_sair
tab_principal tab_principal
end type
global w_ancestral_cadastro w_ancestral_cadastro

type variables

Protected:
	u_DataWindow idw_Cadastro, idw_Filtro, idw_Resultado
end variables

forward prototypes
protected subroutine of_limpar ()
protected function boolean of_validar_filtros ()
protected subroutine of_filtrar ()
protected subroutine of_cancelar ()
protected function boolean of_validar_gravacao ()
protected subroutine of_gravar ()
protected subroutine of_incluir ()
protected subroutine of_editar ()
protected function long of_codigo_principal ()
end prototypes

protected subroutine of_limpar ();//Fun$$HEX2$$e700e300$$ENDHEX$$o criada para limpar os filtros da tela

idw_Filtro.DeleteRow(1)
idw_Filtro.InsertRow(0)
end subroutine

protected function boolean of_validar_filtros ();//Monta a valida$$HEX2$$e700e300$$ENDHEX$$o dos filtros preenchidos na tela filha

idw_Filtro.AcceptText()

Return True
end function

protected subroutine of_filtrar ();//Monta a estrutura de pesquisa nas telas filhas


end subroutine

protected subroutine of_cancelar ();//Cancela uma altera$$HEX2$$e700e300$$ENDHEX$$o de cadastro

If MessageBox(gs_Sistema, 'Deseja realmente cancelar a(s) altera$$HEX2$$e700e300$$ENDHEX$$o($$HEX1$$f500$$ENDHEX$$es)? ~rEsta a$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o poder$$HEX2$$e1002000$$ENDHEX$$ser desfeita.', Question!, YesNo!, 2) = 1 Then
	Tab_Principal.SelectTab(1)
	Tab_Principal.TabPage_Cadastro.Enabled = False
	idw_Cadastro.Reset()
End If
end subroutine

protected function boolean of_validar_gravacao ();//Fun$$HEX2$$e700e300$$ENDHEX$$o para ser preenchida na tela filho que deve fazer as valida$$HEX2$$e700f500$$ENDHEX$$es antes de gravar



Return True
end function

protected subroutine of_gravar ();//Fun$$HEX2$$e700e300$$ENDHEX$$o que chama a grava$$HEX2$$e700e300$$ENDHEX$$o passando a dw de cadastro que deve ser gravada
Boolean lb_Retorno
n_Gravacao ln_Gravacao

ln_Gravacao = CREATE n_Gravacao

lb_Retorno = ln_Gravacao.of_Gravar(Ref idw_Cadastro)

If lb_Retorno Then //Se gravou corretamente volta para a aba de pesquisa e atualiza a pesquisa
	if of_Validar_Filtros() Then
		of_Filtrar()
	End If
	Tab_Principal.SelectTab(1)
	Tab_Principal.TabPage_Cadastro.Enabled = False
	idw_Cadastro.Reset()
End If
end subroutine

protected subroutine of_incluir ();//Fun$$HEX2$$e700e300$$ENDHEX$$o para inserir registro na aba de cadastro

idw_Cadastro.Reset()
idw_Cadastro.InsertRow(0)
Tab_Principal.TabPage_Cadastro.Enabled = True
Tab_Principal.SelectTab(2)
end subroutine

protected subroutine of_editar ();//Fun$$HEX2$$e700e300$$ENDHEX$$o criada para alterar um cadastro, deve ser implementada pelas telas filhas desta a of_Get_Codigo_principal
Long ll_idCodigo
Integer li_Ret

If idw_Resultado.RowCount() = 0 Then
	MessageBox(gs_Sistema, 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX2$$e1002000$$ENDHEX$$registro para editar.')
	Return
End If

ll_idCodigo = of_Codigo_Principal()

If ll_idCodigo > 0 Then
	li_Ret = idw_Cadastro.Retrieve(ll_idCodigo)
	
	if li_Ret = 1 Then
		Tab_Principal.TabPage_Cadastro.Enabled = True
		Tab_Principal.SelectTab(2)
	Else
		MessageBox(gs_Sistema, 'Nenhum registro foi encontrado!')
		idw_Cadastro.Reset()
	End If
End If
end subroutine

protected function long of_codigo_principal ();//Fun$$HEX2$$e700e300$$ENDHEX$$o criada para retornar para a of_Editar o n$$HEX1$$fa00$$ENDHEX$$mero de um cadastro, deve ser implementada pelas telas filhas desta tela
Return 0
end function

on w_ancestral_cadastro.create
int iCurrent
call super::create
this.cb_sair=create cb_sair
this.tab_principal=create tab_principal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_sair
this.Control[iCurrent+2]=this.tab_principal
end on

on w_ancestral_cadastro.destroy
call super::destroy
destroy(this.cb_sair)
destroy(this.tab_principal)
end on

event open;call super::open;//Usado para inicializar e chamada na abertura da tela
idw_Cadastro = Tab_Principal.TabPage_Cadastro.dw_Cadastro
idw_Filtro = Tab_Principal.TabPage_Pesquisa.dw_Filtro
idw_Resultado = Tab_Principal.TabPage_Pesquisa.dw_Resultado

//Faz as conex$$HEX1$$f500$$ENDHEX$$es com o banco
idw_Filtro.SetTransObject(SQLCA)
idw_Resultado.SetTransObject(SQLCA)
idw_Cadastro.SetTransObject(SQLCA)

//Insere a primeira linha da dw de filtros
idw_Filtro.InsertRow(0)
end event

type cb_sair from u_commandbutton within w_ancestral_cadastro
integer x = 3656
integer y = 1806
integer taborder = 20
string text = "&Sair"
boolean fixo_direita = true
boolean fixo_abaixo = true
end type

event clicked;call super::clicked;Close(Parent)
end event

type tab_principal from tab within w_ancestral_cadastro
string tag = "RES"
integer width = 4095
integer height = 1953
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_pesquisa tabpage_pesquisa
tabpage_cadastro tabpage_cadastro
end type

on tab_principal.create
this.tabpage_pesquisa=create tabpage_pesquisa
this.tabpage_cadastro=create tabpage_cadastro
this.Control[]={this.tabpage_pesquisa,&
this.tabpage_cadastro}
end on

on tab_principal.destroy
destroy(this.tabpage_pesquisa)
destroy(this.tabpage_cadastro)
end on

type tabpage_pesquisa from userobject within tab_principal
string tag = "RES"
integer x = 15
integer y = 104
integer width = 4064
integer height = 1837
long backcolor = 67108864
string text = "Pesquisa"
long tabtextcolor = 33554432
string picturename = "Imagens\Localizar.ico"
long picturemaskcolor = 536870912
cb_limpar cb_limpar
cb_pesquisar cb_pesquisar
dw_resultado dw_resultado
dw_filtro dw_filtro
cb_editar cb_editar
cb_incluir cb_incluir
gb_resultado gb_resultado
gb_filtro gb_filtro
end type

on tabpage_pesquisa.create
this.cb_limpar=create cb_limpar
this.cb_pesquisar=create cb_pesquisar
this.dw_resultado=create dw_resultado
this.dw_filtro=create dw_filtro
this.cb_editar=create cb_editar
this.cb_incluir=create cb_incluir
this.gb_resultado=create gb_resultado
this.gb_filtro=create gb_filtro
this.Control[]={this.cb_limpar,&
this.cb_pesquisar,&
this.dw_resultado,&
this.dw_filtro,&
this.cb_editar,&
this.cb_incluir,&
this.gb_resultado,&
this.gb_filtro}
end on

on tabpage_pesquisa.destroy
destroy(this.cb_limpar)
destroy(this.cb_pesquisar)
destroy(this.dw_resultado)
destroy(this.dw_filtro)
destroy(this.cb_editar)
destroy(this.cb_incluir)
destroy(this.gb_resultado)
destroy(this.gb_filtro)
end on

type cb_limpar from u_commandbutton within tabpage_pesquisa
integer x = 3583
integer y = 80
integer taborder = 30
string text = "&Limpar"
boolean fixo_direita = true
end type

event clicked;call super::clicked;of_Limpar()
end event

type cb_pesquisar from u_commandbutton within tabpage_pesquisa
integer x = 3583
integer y = 194
integer taborder = 20
string text = "&Pesquisar"
boolean fixo_direita = true
end type

event clicked;call super::clicked;if of_Validar_Filtros() Then
	of_Filtrar()
End If
end event

type dw_resultado from u_datawindow within tabpage_pesquisa
integer x = 53
integer y = 447
integer width = 3950
integer height = 1199
integer taborder = 40
boolean destacar_linha_selecionada = true
boolean horizontal_resize = true
boolean vertical_resize = true
end type

event doubleclicked;call super::doubleclicked;of_Editar()
end event

type dw_filtro from u_datawindow within tabpage_pesquisa
integer x = 53
integer y = 80
integer width = 3492
integer height = 224
integer taborder = 10
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;Tab_Principal.TabPage_Pesquisa.cb_pesquisar.Default = true
end event

event losefocus;call super::losefocus;Tab_Principal.TabPage_Pesquisa.cb_pesquisar.Default = False
end event

type cb_editar from u_commandbutton within tabpage_pesquisa
integer x = 458
integer y = 1696
integer taborder = 60
string text = "&Editar"
boolean fixo_abaixo = true
end type

event clicked;call super::clicked;of_Editar()
end event

type cb_incluir from u_commandbutton within tabpage_pesquisa
integer x = 19
integer y = 1696
integer taborder = 50
string text = "&Incluir"
boolean fixo_abaixo = true
end type

event clicked;call super::clicked;of_incluir()
end event

type gb_resultado from u_groupbox within tabpage_pesquisa
integer x = 19
integer y = 367
integer width = 4022
integer height = 1312
string text = " Registros "
boolean horizontal_resize = true
boolean vertical_resize = true
end type

type gb_filtro from u_groupbox within tabpage_pesquisa
integer x = 19
integer width = 4022
integer height = 351
string text = " Filtros  "
boolean horizontal_resize = true
end type

type tabpage_cadastro from userobject within tab_principal
string tag = "RES"
integer x = 15
integer y = 104
integer width = 4064
integer height = 1837
boolean enabled = false
long backcolor = 67108864
string text = "Cadastro"
long tabtextcolor = 33554432
string picturename = "Imagens\cadastro.ico"
long picturemaskcolor = 536870912
cb_cancelar cb_cancelar
cb_gravar cb_gravar
dw_cadastro dw_cadastro
gb_cadastro gb_cadastro
end type

on tabpage_cadastro.create
this.cb_cancelar=create cb_cancelar
this.cb_gravar=create cb_gravar
this.dw_cadastro=create dw_cadastro
this.gb_cadastro=create gb_cadastro
this.Control[]={this.cb_cancelar,&
this.cb_gravar,&
this.dw_cadastro,&
this.gb_cadastro}
end on

on tabpage_cadastro.destroy
destroy(this.cb_cancelar)
destroy(this.cb_gravar)
destroy(this.dw_cadastro)
destroy(this.gb_cadastro)
end on

type cb_cancelar from u_commandbutton within tabpage_cadastro
integer x = 458
integer y = 1696
integer taborder = 40
string text = "&Cancelar"
boolean fixo_abaixo = true
end type

event clicked;call super::clicked;of_Cancelar()
end event

type cb_gravar from u_commandbutton within tabpage_cadastro
integer x = 19
integer y = 1696
integer taborder = 30
string text = "&Gravar"
boolean fixo_abaixo = true
end type

event clicked;call super::clicked;if of_Validar_Gravacao() Then
	of_Gravar()
End If
end event

type dw_cadastro from u_datawindow within tabpage_cadastro
integer x = 53
integer y = 97
integer width = 3931
integer height = 1536
integer taborder = 20
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean horizontal_resize = true
boolean vertical_resize = true
end type

type gb_cadastro from u_groupbox within tabpage_cadastro
integer x = 19
integer y = 17
integer width = 4026
integer height = 1663
string text = "Cadastro "
boolean horizontal_resize = true
boolean vertical_resize = true
end type

