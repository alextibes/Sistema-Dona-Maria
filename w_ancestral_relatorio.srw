HA$PBExportHeader$w_ancestral_relatorio.srw
forward
global type w_ancestral_relatorio from w_ancestral
end type
type cb_gerar from u_commandbutton within w_ancestral_relatorio
end type
type dw_resultado from u_datawindow within w_ancestral_relatorio
end type
type dw_filtro from u_datawindow within w_ancestral_relatorio
end type
type gb_1 from u_groupbox within w_ancestral_relatorio
end type
type gb_2 from u_groupbox within w_ancestral_relatorio
end type
end forward

global type w_ancestral_relatorio from w_ancestral
integer width = 2618
integer height = 1780
string title = "Relat$$HEX1$$f300$$ENDHEX$$rios"
boolean utiliza_resize = true
cb_gerar cb_gerar
dw_resultado dw_resultado
dw_filtro dw_filtro
gb_1 gb_1
gb_2 gb_2
end type
global w_ancestral_relatorio w_ancestral_relatorio

forward prototypes
public function boolean of_validar_filtros ()
public subroutine of_gerar_relatorio ()
end prototypes

public function boolean of_validar_filtros ();//Validar nas telas filhas se houver necessidade

Return True
end function

public subroutine of_gerar_relatorio ();//Mudar nos filhos se houver necessidade
dw_Resultado.Retrieve()
end subroutine

on w_ancestral_relatorio.create
int iCurrent
call super::create
this.cb_gerar=create cb_gerar
this.dw_resultado=create dw_resultado
this.dw_filtro=create dw_filtro
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
this.Control[iCurrent+2]=this.dw_resultado
this.Control[iCurrent+3]=this.dw_filtro
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_2
end on

on w_ancestral_relatorio.destroy
call super::destroy
destroy(this.cb_gerar)
destroy(this.dw_resultado)
destroy(this.dw_filtro)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;dw_Resultado.SetTransObject(SQLCA)
dw_Filtro.InsertRow(0)
end event

type cb_gerar from u_commandbutton within w_ancestral_relatorio
integer x = 2049
integer y = 110
integer width = 469
integer taborder = 30
string text = "Gerar Relat$$HEX1$$f300$$ENDHEX$$rio"
boolean fixo_direita = true
end type

event clicked;call super::clicked;if of_Validar_Filtros() Then
	of_Gerar_Relatorio()
End If
end event

type dw_resultado from u_datawindow within w_ancestral_relatorio
integer x = 65
integer y = 361
integer width = 2435
integer height = 1262
integer taborder = 20
boolean horizontal_resize = true
boolean vertical_resize = true
end type

type dw_filtro from u_datawindow within w_ancestral_relatorio
integer x = 53
integer y = 87
integer width = 1973
integer height = 147
integer taborder = 20
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean horizontal_resize = true
end type

type gb_1 from u_groupbox within w_ancestral_relatorio
integer x = 23
integer y = 280
integer width = 2530
integer height = 1379
integer taborder = 10
string text = " Resultado "
boolean horizontal_resize = true
boolean vertical_resize = true
end type

type gb_2 from u_groupbox within w_ancestral_relatorio
integer x = 15
integer y = 23
integer width = 2530
integer height = 244
integer taborder = 10
string text = " Filtros "
boolean horizontal_resize = true
end type

