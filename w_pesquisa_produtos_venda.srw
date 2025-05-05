HA$PBExportHeader$w_pesquisa_produtos_venda.srw
forward
global type w_pesquisa_produtos_venda from w_ancestral
end type
type dw_resultado from u_datawindow within w_pesquisa_produtos_venda
end type
type sle_filtro from u_singlelineedit within w_pesquisa_produtos_venda
end type
type cb_pesquisar from u_commandbutton within w_pesquisa_produtos_venda
end type
type cb_cancelar from u_commandbutton within w_pesquisa_produtos_venda
end type
type cb_selecionar from u_commandbutton within w_pesquisa_produtos_venda
end type
type gb_1 from u_groupbox within w_pesquisa_produtos_venda
end type
type gb_2 from u_groupbox within w_pesquisa_produtos_venda
end type
end forward

global type w_pesquisa_produtos_venda from w_ancestral
integer width = 3034
integer height = 1960
string title = "Pesquisa de produtos"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
string icon = "Imagens\Localizar.ico"
dw_resultado dw_resultado
sle_filtro sle_filtro
cb_pesquisar cb_pesquisar
cb_cancelar cb_cancelar
cb_selecionar cb_selecionar
gb_1 gb_1
gb_2 gb_2
end type
global w_pesquisa_produtos_venda w_pesquisa_produtos_venda

type variables

Private s_Valores ist_Return
end variables

forward prototypes
public subroutine of_pesquisar ()
public subroutine of_selecionar ()
end prototypes

public subroutine of_pesquisar ();String ls_Descricao
Long ll_idGrade
Decimal lde_CodBarras

ls_Descricao = Trim(sle_filtro.Text)

If ls_Descricao = '' Then
	MessageBox(gs_Sistema, 'Informe um valor para filtrar os produtos')
	Return
End If

If IsNumber(ls_Descricao) Then
	If Len(ls_Descricao) > 6 Then //C$$HEX1$$f300$$ENDHEX$$digo de Barras
		lde_CodBarras = Dec(ls_Descricao)
	Else //C$$HEX1$$f300$$ENDHEX$$digo da grade
		ll_idGrade = Long(ls_Descricao)
	End If
	ls_Descricao = ''
End If

dw_Resultado.Retrieve(ll_idGrade, ls_Descricao, lde_CodBarras)

cb_Selecionar.Default = True
dw_Resultado.SetFocus()
end subroutine

public subroutine of_selecionar ();
Long ll_Row

ll_Row = dw_Resultado.GetRow()

if dw_Resultado.RowCount() > 0 AND ll_Row > 0 Then
	ist_Return.Boolean[1] = True
	ist_Return.String[1] = dw_Resultado.GetItemString(ll_Row, 'descricao_cupom')
	ist_Return.Long[1] = dw_Resultado.GetItemNumber(ll_Row, 'id_produto')
	ist_Return.Long[2] = dw_Resultado.GetItemNumber(ll_Row, 'id_grade')
	ist_Return.Decimal[1] = dw_Resultado.GetItemDecimal(ll_Row, 'valor_venda')
	
	Close(This)
Else
	MessageBox(gs_Sistema, 'Selecione um produto!')
End If
end subroutine

on w_pesquisa_produtos_venda.create
int iCurrent
call super::create
this.dw_resultado=create dw_resultado
this.sle_filtro=create sle_filtro
this.cb_pesquisar=create cb_pesquisar
this.cb_cancelar=create cb_cancelar
this.cb_selecionar=create cb_selecionar
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_resultado
this.Control[iCurrent+2]=this.sle_filtro
this.Control[iCurrent+3]=this.cb_pesquisar
this.Control[iCurrent+4]=this.cb_cancelar
this.Control[iCurrent+5]=this.cb_selecionar
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_pesquisa_produtos_venda.destroy
call super::destroy
destroy(this.dw_resultado)
destroy(this.sle_filtro)
destroy(this.cb_pesquisar)
destroy(this.cb_cancelar)
destroy(this.cb_selecionar)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;String ls_Pesquisa

dw_Resultado.SetTransObject(SQLCA)

ls_Pesquisa = Message.StringParm

ist_Return.Boolean[1] = False

If ls_Pesquisa <> '' Then
	sle_Filtro.Text = ls_Pesquisa
	of_Pesquisar()
	
	If dw_Resultado.RowCount() = 1 Then
		of_Selecionar()
	End If
End If
end event

event close;call super::close;CloseWithReturn(This, ist_Return)
end event

type dw_resultado from u_datawindow within w_pesquisa_produtos_venda
integer x = 73
integer y = 364
integer width = 2889
integer height = 1319
integer taborder = 30
string dataobject = "d_pesquisa_produtos_venda"
boolean destacar_linha_selecionada = true
end type

event doubleclicked;call super::doubleclicked;of_Selecionar()
end event

type sle_filtro from u_singlelineedit within w_pesquisa_produtos_venda
integer x = 73
integer y = 117
integer width = 2294
integer taborder = 10
end type

type cb_pesquisar from u_commandbutton within w_pesquisa_produtos_venda
integer x = 2568
integer y = 117
integer taborder = 20
string text = "Pesquisar"
boolean default = true
end type

event clicked;call super::clicked;of_Pesquisar()
end event

type cb_cancelar from u_commandbutton within w_pesquisa_produtos_venda
integer x = 34
integer y = 1746
integer taborder = 50
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_selecionar from u_commandbutton within w_pesquisa_produtos_venda
integer x = 2568
integer y = 1746
integer taborder = 40
string text = "&Selecionar"
end type

event clicked;call super::clicked;of_selecionar()
end event

type gb_1 from u_groupbox within w_pesquisa_produtos_venda
integer x = 34
integer y = 27
integer width = 2958
integer height = 247
string text = " Filtrar (C$$HEX1$$f300$$ENDHEX$$digo, Descri$$HEX2$$e700e300$$ENDHEX$$o ou C$$HEX1$$f300$$ENDHEX$$digo de Barras) "
end type

type gb_2 from u_groupbox within w_pesquisa_produtos_venda
integer x = 34
integer y = 287
integer width = 2958
integer height = 1439
string text = " Resultado "
end type

