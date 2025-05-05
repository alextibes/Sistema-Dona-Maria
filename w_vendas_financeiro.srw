HA$PBExportHeader$w_vendas_financeiro.srw
forward
global type w_vendas_financeiro from w_ancestral
end type
type st_troco from u_statictext within w_vendas_financeiro
end type
type cb_cancelar from u_commandbutton within w_vendas_financeiro
end type
type cb_ok from u_commandbutton within w_vendas_financeiro
end type
type st_total from u_statictext within w_vendas_financeiro
end type
type st_4 from u_statictext within w_vendas_financeiro
end type
type st_3 from u_statictext within w_vendas_financeiro
end type
type st_venda from u_statictext within w_vendas_financeiro
end type
type st_1 from u_statictext within w_vendas_financeiro
end type
type em_desconto from u_editmask within w_vendas_financeiro
end type
type dw_pagamento from u_datawindow within w_vendas_financeiro
end type
type gb_1 from u_groupbox within w_vendas_financeiro
end type
type gb_troco from u_groupbox within w_vendas_financeiro
end type
type gb_3 from u_groupbox within w_vendas_financeiro
end type
end forward

global type w_vendas_financeiro from w_ancestral
integer width = 2229
integer height = 1753
string title = "Forma de pagamento da venda"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
st_troco st_troco
cb_cancelar cb_cancelar
cb_ok cb_ok
st_total st_total
st_4 st_4
st_3 st_3
st_venda st_venda
st_1 st_1
em_desconto em_desconto
dw_pagamento dw_pagamento
gb_1 gb_1
gb_troco gb_troco
gb_3 gb_3
end type
global w_vendas_financeiro w_vendas_financeiro

type variables

Private:
	Decimal{2} ide_TotalVenda //Total da Venda  sem desconto
	Decimal{2} ide_TotalLiquido //Total da venda menos o desconto
	
	u_DataWindow idw_Financeiros
	
	s_Valores ist_Retorno
end variables

forward prototypes
public subroutine of_calcular_troco ()
public subroutine of_receber ()
end prototypes

public subroutine of_calcular_troco ();Decimal{2} lde_Recebido, lde_Troco

lde_Recebido = Dec(dw_Pagamento.Object.Comp_Total[1])
lde_Troco = lde_Recebido - ide_TotalLiquido

st_Troco.Text = String (lde_troco, ' ###,###.00')

If lde_Troco >= 0 Then 
	gb_Troco.text = ' Troco '
	st_Troco.TextColor = RGB(0,0,255)
Else
	gb_Troco.Text = ' Receber '
	st_Troco.TextColor = RGB(255,0,0)
End If
	
end subroutine

public subroutine of_receber ();
//Valida se os valores batem, alimenta o que precisa e encerra a tela
Decimal{2} lde_Saldo
Long ll_for, ll_Row

lde_Saldo = Dec(dw_Pagamento.Object.Comp_Total[1]) - ide_TotalLiquido

If lde_Saldo < 0 Then
	MessageBox(gs_Sistema, 'Aten$$HEX2$$e700e300$$ENDHEX$$o! ~r~rExistem valores pendentes para receber. Verifique!', StopSign!)
	Return	
End If

idw_Financeiros.Reset()
For ll_For = 1 To dw_Pagamento.RowCount()
	If dw_Pagamento.GetItemDecimal(ll_For, 'valor') > 0 Then
		ll_Row = idw_Financeiros.InsertRow(0)
		idw_Financeiros.SetItem(ll_Row, 'id_forma_pagamento', dw_Pagamento.GetItemNumber(ll_For, 'id_forma_pagamento'))
		idw_Financeiros.SetItem(ll_Row, 'valor_recebido', dw_Pagamento.GetItemDecimal(ll_For, 'valor'))
	End If	
Next

ist_Retorno.Boolean[1] = True
ist_Retorno.Decimal[1] = Dec(em_Desconto.Text)

Close(this)
end subroutine

on w_vendas_financeiro.create
int iCurrent
call super::create
this.st_troco=create st_troco
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.st_total=create st_total
this.st_4=create st_4
this.st_3=create st_3
this.st_venda=create st_venda
this.st_1=create st_1
this.em_desconto=create em_desconto
this.dw_pagamento=create dw_pagamento
this.gb_1=create gb_1
this.gb_troco=create gb_troco
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_troco
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_total
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_venda
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_desconto
this.Control[iCurrent+10]=this.dw_pagamento
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_troco
this.Control[iCurrent+13]=this.gb_3
end on

on w_vendas_financeiro.destroy
call super::destroy
destroy(this.st_troco)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.st_total)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_venda)
destroy(this.st_1)
destroy(this.em_desconto)
destroy(this.dw_pagamento)
destroy(this.gb_1)
destroy(this.gb_troco)
destroy(this.gb_3)
end on

event open;call super::open;s_Valores lst_Receber

dw_Pagamento.SetTransObject(SQLCA)
dw_Pagamento.Retrieve()

lst_Receber = Message.PowerObjectParm

ide_TotalVenda = lst_Receber.Decimal[1]
ide_TotalLiquido = ide_TotalVenda

st_Venda.Text = String(ide_TotalVenda)
st_Total.Text = String(ide_TotalVenda)

idw_Financeiros = lst_Receber.PowerObj[1]

ist_Retorno.Boolean[1] = False
end event

event close;call super::close;CloseWithReturn(This, ist_Retorno)
end event

type st_troco from u_statictext within w_vendas_financeiro
integer x = 1168
integer y = 120
integer width = 962
integer height = 157
integer textsize = -22
integer weight = 700
string text = "0,00"
alignment alignment = right!
end type

type cb_cancelar from u_commandbutton within w_vendas_financeiro
integer x = 31
integer y = 1559
integer taborder = 40
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_ok from u_commandbutton within w_vendas_financeiro
integer x = 1755
integer y = 1559
integer taborder = 30
string text = "&OK"
end type

event clicked;call super::clicked;of_Receber()
end event

type st_total from u_statictext within w_vendas_financeiro
integer x = 462
integer y = 247
integer width = 527
integer height = 70
integer textsize = -12
integer weight = 700
string text = "0,00"
alignment alignment = right!
end type

type st_4 from u_statictext within w_vendas_financeiro
integer x = 57
integer y = 247
string text = "Total"
end type

type st_3 from u_statictext within w_vendas_financeiro
integer x = 69
integer y = 150
string text = "Desconto"
end type

type st_venda from u_statictext within w_vendas_financeiro
integer x = 477
integer y = 73
integer width = 511
integer height = 77
string text = "0,00"
alignment alignment = right!
end type

type st_1 from u_statictext within w_vendas_financeiro
integer x = 65
integer y = 73
integer width = 427
string text = "Valor da Venda"
end type

type em_desconto from u_editmask within w_vendas_financeiro
integer x = 679
integer y = 150
integer width = 313
integer height = 83
integer taborder = 20
string text = "0,00"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modified;call super::modified;Decimal{2} lde_Desconto

lde_Desconto = Dec(This.Text)

ide_TotalLiquido = ide_TotalVenda - lde_Desconto
st_Total.Text = String(ide_TotalLiquido, '###,###.00')

of_Calcular_Troco()
end event

type dw_pagamento from u_datawindow within w_vendas_financeiro
integer x = 53
integer y = 447
integer width = 2045
integer height = 1069
integer taborder = 20
string dataobject = "d_vendas_forma_pagamento"
end type

event itemchanged;call super::itemchanged;This.accepttext()

of_Calcular_Troco()
end event

event doubleclicked;call super::doubleclicked;
If Row < 0 Then Return

If dwo.Name = 'valor' Then
	This.SetItem(row, 'valor', ide_TotalLiquido)
	This.AcceptText()
	of_Calcular_Troco()
End If
end event

event losefocus;call super::losefocus;This.AcceptText()
end event

type gb_1 from u_groupbox within w_vendas_financeiro
integer x = 23
integer y = 364
integer width = 2141
integer height = 1175
integer taborder = 10
string text = " Selecione a forma de pagamento "
end type

type gb_troco from u_groupbox within w_vendas_financeiro
integer x = 1133
integer y = 10
integer width = 1023
integer height = 327
integer taborder = 10
string text = " Troco "
end type

type gb_3 from u_groupbox within w_vendas_financeiro
integer x = 27
integer y = 10
integer width = 1069
integer height = 327
integer taborder = 10
string text = " Total "
end type

