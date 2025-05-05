HA$PBExportHeader$w_vendas.srw
forward
global type w_vendas from w_ancestral
end type
type dw_impressao from u_datawindow within w_vendas
end type
type dw_financeiro from u_datawindow within w_vendas
end type
type cb_pagamento from u_commandbutton within w_vendas
end type
type dw_vendas from u_datawindow within w_vendas
end type
type pb_localizar from u_picturebutton within w_vendas
end type
type dw_produtos from u_datawindow within w_vendas
end type
type sle_pesquisa from u_singlelineedit within w_vendas
end type
type gb_1 from u_groupbox within w_vendas
end type
type gb_2 from u_groupbox within w_vendas
end type
end forward

global type w_vendas from w_ancestral
integer width = 4797
integer height = 2187
string title = "Vendas"
string icon = "Imagens\vendas.ico"
boolean utiliza_resize = true
dw_impressao dw_impressao
dw_financeiro dw_financeiro
cb_pagamento cb_pagamento
dw_vendas dw_vendas
pb_localizar pb_localizar
dw_produtos dw_produtos
sle_pesquisa sle_pesquisa
gb_1 gb_1
gb_2 gb_2
end type
global w_vendas w_vendas

type variables

end variables

forward prototypes
public subroutine of_pesquisar ()
public subroutine of_adicionar_produto (ref s_valores ast_recebe)
public subroutine of_finalizar_venda ()
public subroutine of_limpar ()
public subroutine of_imprimir_venda (long al_idvenda)
end prototypes

public subroutine of_pesquisar ();//Criado para fazer a consulta dos produtos
String ls_Pesquisa
s_Valores lst_Recebe

ls_Pesquisa = Trim(sle_pesquisa.text)

openWithParm(w_pesquisa_produtos_venda, ls_Pesquisa)

lst_Recebe = Message.PowerObjectParm

If lst_Recebe.Boolean[1] Then
	of_Adicionar_Produto(Ref lst_Recebe)
End If

sle_pesquisa.text = ''
sle_Pesquisa.SetFocus()
end subroutine

public subroutine of_adicionar_produto (ref s_valores ast_recebe);Long ll_Row, ll_Find

ll_find = dw_Produtos.Find('id_grade = ' + String(ast_Recebe.Long[2]), 1, dw_Produtos.RowCount())

If ll_Find = 0 Then
	ll_Row = dw_Produtos.InsertRow(0)
	dw_Produtos.SetItem(ll_Row, 'descricao_cupom', ast_Recebe.String[1])
	dw_Produtos.SetItem(ll_Row, 'id_produto', ast_Recebe.Long[1])
	dw_Produtos.SetItem(ll_Row, 'id_grade', ast_Recebe.Long[2])
	dw_Produtos.SetItem(ll_Row, 'valor_unitario', ast_Recebe.Decimal[1])
	dw_Produtos.SetItem(ll_Row, 'quantidade', 1)
	dw_Produtos.SetItem(ll_Row, 'valor_total', ast_Recebe.Decimal[1])
ElseIF ll_Find > 0 Then
	dw_Produtos.SetItem(ll_Find, 'quantidade', dw_Produtos.GetItemNumber(ll_Find, 'quantidade') + 1)
	dw_Produtos.SetItem(ll_Find, 'valor_total', dw_Produtos.GetItemNumber(ll_Find, 'quantidade')  * dw_Produtos.GetItemDecimal(ll_Find, 'valor_unitario') )
End If

sndPlaySoundA('C:\Sistema Dona Maria\Imagens\Beep.wav', 1)

//lst_Recebe.String[1] = dw_Resultado.GetItemString(ll_Row, 'descricao_cupom')
//lst_Recebe.Long[1] = dw_Resultado.GetItemNumber(ll_Row, 'id_produto')
//lst_Recebe.Long[2] = dw_Resultado.GetItemNumber(ll_Row, 'id_grade')
//lst_Recebe.Decimal[1] = dw_Resultado.GetItemDecimal(ll_Row, 'valor_venda')
end subroutine

public subroutine of_finalizar_venda ();Long ll_idMovimento, ll_idVenda
Long ll_For
Boolean lb_Retorno

//Pega os contadores necessarios
ll_idMovimento = gn_Gravacao.of_get_Contador(gn_Gravacao.#MOVIMENTO)
ll_idVenda = gn_Gravacao.of_get_Contador(gn_Gravacao.#VENDA)

//Atribuir os contadores
dw_Vendas.SetItem(1, 'id_venda', ll_idVenda)
dw_Vendas.SetItem(1, 'id_usuario', gl_idUsuarioLogado)
dw_Vendas.SetItem(1, 'data_hora_movimentacao', now())
dw_Vendas.SetItem(1, 'id_movimento', ll_idMovimento)

For ll_For = 1 To dw_Produtos.RowCount()
	dw_Produtos.SetItem(ll_For, 'id_venda', ll_idVenda)
	dw_Produtos.SetItem(ll_For, 'id_movimento', ll_idMovimento)
Next

For ll_For = 1 To dw_Financeiro.RowCount()
	dw_Financeiro.SetItem(ll_For, 'id_venda', ll_idVenda)
	dw_Financeiro.SetItem(ll_For, 'id_movimento', ll_idMovimento)
Next

//Gravar
lb_Retorno = gn_Gravacao.of_Gravar({dw_Vendas, dw_Produtos, dw_Financeiro}, False)

If Not lb_Retorno Then //Se gravou corretamente volta para a aba de pesquisa e atualiza a pesquisa
	MessageBox(gs_Sistema, 'Ocorreram problemas durante a grava$$HEX2$$e700e300$$ENDHEX$$o da nota. Verifique!', StopSign!)
	Return
End If

//Imprimir
of_Imprimir_Venda(ll_idVenda)

of_Limpar()
end subroutine

public subroutine of_limpar ();//Reseta a tela para iniciar uma nova venda

This.SetRedraw(False)
dw_Vendas.Reset()
dw_Financeiro.Reset()
dw_Produtos.Reset()

dw_Vendas.InsertRow(0)
dw_Vendas.SetItem(1, 'id_vendedor', gl_idUsuarioLogado)

dw_Impressao.Reset()

This.SetRedraw(True)
end subroutine

public subroutine of_imprimir_venda (long al_idvenda);//Faz a impress$$HEX1$$e300$$ENDHEX$$o da venda

If MessageBox(gs_Sistema, 'Deseja imprimir a nota de venda?', Question!, YesNo!, 1) = 2 Then Return

dw_impressao.Retrieve(al_idVenda)
dw_Impressao.Print()

end subroutine

on w_vendas.create
int iCurrent
call super::create
this.dw_impressao=create dw_impressao
this.dw_financeiro=create dw_financeiro
this.cb_pagamento=create cb_pagamento
this.dw_vendas=create dw_vendas
this.pb_localizar=create pb_localizar
this.dw_produtos=create dw_produtos
this.sle_pesquisa=create sle_pesquisa
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_impressao
this.Control[iCurrent+2]=this.dw_financeiro
this.Control[iCurrent+3]=this.cb_pagamento
this.Control[iCurrent+4]=this.dw_vendas
this.Control[iCurrent+5]=this.pb_localizar
this.Control[iCurrent+6]=this.dw_produtos
this.Control[iCurrent+7]=this.sle_pesquisa
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_vendas.destroy
call super::destroy
destroy(this.dw_impressao)
destroy(this.dw_financeiro)
destroy(this.cb_pagamento)
destroy(this.dw_vendas)
destroy(this.pb_localizar)
destroy(this.dw_produtos)
destroy(this.sle_pesquisa)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;
dw_Vendas.SetTransObject(SQLCA)
dw_Produtos.SetTransObject(SQLCA)
dw_Financeiro.SetTransObject(SQLCA)
dw_Impressao.SetTransObject(SQLCA)

dw_Vendas.InsertRow(0)

dw_Vendas.SetItem(1, 'id_vendedor', gl_idUsuarioLogado)
end event

event close;call super::close;if isValid(w_Fundo) Then //Quando fechar atualiza o grafico de vendas
	w_Fundo.of_Atualizar()
End If
end event

type dw_impressao from u_datawindow within w_vendas
string tag = ""
boolean visible = false
integer x = 557
integer y = 1062
integer width = 412
integer height = 104
integer taborder = 30
boolean titlebar = true
string title = "dw_impressao"
string dataobject = "d_impressao_vendas"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_financeiro from u_datawindow within w_vendas
string tag = ""
boolean visible = false
integer x = 550
integer y = 955
integer width = 836
integer height = 114
integer taborder = 20
boolean titlebar = true
string title = "dw_vendas_financeiros"
string dataobject = "d_vendas_financeiros"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type cb_pagamento from u_commandbutton within w_vendas
integer x = 3938
integer y = 1880
integer width = 740
integer taborder = 60
string text = "Pagamento"
boolean fixo_direita = true
boolean fixo_abaixo = true
end type

event clicked;call super::clicked;s_Valores lst_Enviar, lst_Retorno

lst_Enviar.Decimal[1] = dw_Produtos.Object.cmp_Total[1]
lst_Enviar.PowerObj[1] = dw_Financeiro

openWithParm(w_vendas_financeiro, lst_Enviar)

lst_Retorno = Message.PowerObjectParm

//Cancelou ent$$HEX1$$e300$$ENDHEX$$o para por aqui
if lst_Retorno.Boolean[1] = False Then Return

//Se n$$HEX1$$e300$$ENDHEX$$o cancelou segue o processo
dw_Vendas.SetItem(1, 'valor_desconto', lst_Retorno.Decimal[1])
dw_Vendas.SetItem(1, 'valor_total_bruto', dw_Produtos.Object.cmp_Total[1])
dw_Vendas.SetItem(1, 'valor_total_liquido', dw_Produtos.Object.cmp_Total[1] - lst_Retorno.Decimal[1])

of_Finalizar_Venda()
end event

type dw_vendas from u_datawindow within w_vendas
integer x = 46
integer y = 1840
integer width = 3465
integer height = 180
integer taborder = 60
string dataobject = "d_vendas"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean fixo_abaixo = true
end type

type pb_localizar from u_picturebutton within w_vendas
integer x = 2561
integer y = 110
integer width = 137
integer height = 114
integer taborder = 20
boolean default = true
boolean originalsize = false
string picturename = "Imagens\Localizar_32.jpg"
end type

event clicked;call super::clicked;of_pesquisar()
end event

type dw_produtos from u_datawindow within w_vendas
integer x = 80
integer y = 364
integer width = 4534
integer height = 1426
integer taborder = 40
string dataobject = "d_vendas_produtos"
boolean destacar_linha_selecionada = true
boolean horizontal_resize = true
boolean vertical_resize = true
end type

event itemchanged;call super::itemchanged;This.AcceptText()

if dwo.name = 'quantidade' Then
	If Long(data) < 1 Then
		data = '1'
		This.Post SetItem(row, 'quantidade', 1)
	End If
	This.SetItem(row, 'valor_total', Long(data) * This.GetItemDecimal(row, 'valor_unitario'))
ElseIf dwo.Name = 'valor_unitario' Then
	This.SetItem(row, 'valor_total', This.GetItemNumber(row, 'quantidade') * Dec(data))
End If
end event

event clicked;call super::clicked;
if Row < 0 Then Return

if dwo.name = 'btn_excluir' Then
	If MessageBox(gs_Sistema, 'Deseja realmente excluir o produto selecionado?', Question!, YesNo!, 2) = 1 Then
		This.DeleteRow(row)
	End If
End If
end event

event losefocus;call super::losefocus;This.AcceptText()
end event

type sle_pesquisa from u_singlelineedit within w_vendas
integer x = 57
integer y = 120
integer width = 2496
integer height = 93
integer taborder = 10
end type

event getfocus;call super::getfocus;pb_localizar.Default = True
end event

type gb_1 from u_groupbox within w_vendas
integer x = 27
integer y = 40
integer width = 4656
integer height = 224
string text = " Produto / C$$HEX1$$f300$$ENDHEX$$digo de barras "
boolean horizontal_resize = true
end type

type gb_2 from u_groupbox within w_vendas
integer x = 31
integer y = 274
integer width = 4644
integer height = 1549
string text = " Produtos "
boolean horizontal_resize = true
boolean vertical_resize = true
end type

