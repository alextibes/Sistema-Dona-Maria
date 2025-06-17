HA$PBExportHeader$w_relatorios_lista.srw
forward
global type w_relatorios_lista from w_ancestral
end type
type shl_1 from u_statichyperlink within w_relatorios_lista
end type
type st_descricao from u_statictext within w_relatorios_lista
end type
type shl_venda_dia from u_statichyperlink within w_relatorios_lista
end type
type gb_1 from u_groupbox within w_relatorios_lista
end type
type gb_2 from u_groupbox within w_relatorios_lista
end type
end forward

global type w_relatorios_lista from w_ancestral
integer width = 1792
integer height = 1732
string title = "Lista de Relat$$HEX1$$f300$$ENDHEX$$rios"
boolean utiliza_resize = true
shl_1 shl_1
st_descricao st_descricao
shl_venda_dia shl_venda_dia
gb_1 gb_1
gb_2 gb_2
end type
global w_relatorios_lista w_relatorios_lista

on w_relatorios_lista.create
int iCurrent
call super::create
this.shl_1=create shl_1
this.st_descricao=create st_descricao
this.shl_venda_dia=create shl_venda_dia
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.shl_1
this.Control[iCurrent+2]=this.st_descricao
this.Control[iCurrent+3]=this.shl_venda_dia
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_2
end on

on w_relatorios_lista.destroy
call super::destroy
destroy(this.shl_1)
destroy(this.st_descricao)
destroy(this.shl_venda_dia)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type shl_1 from u_statichyperlink within w_relatorios_lista
event ue_mouse pbm_mousemove
integer x = 123
integer y = 212
integer width = 933
string text = "2 - Vendas por produtos"
end type

event ue_mouse;st_descricao.text = 'Exibe os produtos e quantidades vendidas.'
end event

event clicked;call super::clicked;openSheet(w_rel_vendas_analitico, w_Principal, 0, Layered!)
end event

type st_descricao from u_statictext within w_relatorios_lista
integer x = 105
integer y = 1396
integer width = 1545
integer height = 128
string text = ""
boolean horizontal_resize = true
boolean vertical_resize = true
end type

type shl_venda_dia from u_statichyperlink within w_relatorios_lista
event ue_mouse pbm_mousemove
integer x = 123
integer y = 128
integer width = 933
string text = "1 - Total por dia"
end type

event ue_mouse;st_descricao.text = 'Exibe as vendas de um per$$HEX1$$ed00$$ENDHEX$$odo totalizado por dia.'
end event

event clicked;call super::clicked;openSheet(w_rel_vendas, w_Principal, 0, Layered!)
end event

type gb_1 from u_groupbox within w_relatorios_lista
event ue_mouse pbm_mousemove
integer x = 50
integer y = 28
integer width = 1650
integer height = 1280
integer taborder = 10
string text = " Relat$$HEX1$$f300$$ENDHEX$$rios de Vendas "
end type

event ue_mouse;st_descricao.text = ''
end event

type gb_2 from u_groupbox within w_relatorios_lista
integer x = 50
integer y = 1312
integer width = 1650
integer height = 236
integer taborder = 20
string text = " Descri$$HEX2$$e700e300$$ENDHEX$$o do Relat$$HEX1$$f300$$ENDHEX$$rio "
boolean horizontal_resize = true
boolean vertical_resize = true
end type

