HA$PBExportHeader$w_logs.srw
forward
global type w_logs from w_ancestral
end type
type cb_1 from u_commandbutton within w_logs
end type
type dw_filtro from u_datawindow within w_logs
end type
type dw_resultado from u_datawindow within w_logs
end type
type gb_1 from u_groupbox within w_logs
end type
type gb_2 from u_groupbox within w_logs
end type
end forward

global type w_logs from w_ancestral
integer width = 4270
integer height = 2047
string title = "Logs de Auditoria"
string icon = "Imagens\auditoria.ico"
cb_1 cb_1
dw_filtro dw_filtro
dw_resultado dw_resultado
gb_1 gb_1
gb_2 gb_2
end type
global w_logs w_logs

forward prototypes
public subroutine of_filtrar ()
end prototypes

public subroutine of_filtrar ();Date ld_Inicial, ld_Final

ld_Inicial = dw_Filtro.GetItemDate(1, 'datainicial')
ld_Final = dw_Filtro.GetItemDate(1, 'datafinal')

dw_resultado.Retrieve(ld_Inicial, ld_Final)
end subroutine

on w_logs.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_filtro=create dw_filtro
this.dw_resultado=create dw_resultado
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_filtro
this.Control[iCurrent+3]=this.dw_resultado
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_2
end on

on w_logs.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_filtro)
destroy(this.dw_resultado)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;dw_filtro.settransobject(SQLCA)
dw_filtro.insertrow(0)
dw_resultado.settransobject(SQLCA)
end event

type cb_1 from u_commandbutton within w_logs
integer x = 3767
integer y = 107
integer taborder = 30
string text = "Filtrar"
boolean fixo_direita = true
end type

event clicked;call super::clicked;of_Filtrar()
end event

type dw_filtro from u_datawindow within w_logs
integer x = 53
integer y = 120
integer width = 3133
integer height = 177
integer taborder = 20
string dataobject = "d_filtro_logs"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type dw_resultado from u_datawindow within w_logs
integer x = 61
integer y = 417
integer width = 4110
integer height = 1486
integer taborder = 30
string dataobject = "d_logs"
boolean destacar_linha_selecionada = true
boolean horizontal_resize = true
boolean vertical_resize = true
end type

type gb_1 from u_groupbox within w_logs
integer x = 23
integer width = 4182
integer height = 344
integer taborder = 10
string text = " Filtros "
boolean horizontal_resize = true
end type

type gb_2 from u_groupbox within w_logs
integer x = 23
integer y = 344
integer width = 4182
integer height = 1586
integer taborder = 20
string text = " Resultado "
boolean horizontal_resize = true
boolean vertical_resize = true
end type

