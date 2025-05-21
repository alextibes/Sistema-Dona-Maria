HA$PBExportHeader$w_fundo.srw
forward
global type w_fundo from w_ancestral
end type
type dw_vendas from u_datawindow within w_fundo
end type
type p_fundo from u_picture within w_fundo
end type
end forward

global type w_fundo from w_ancestral
integer width = 2908
integer height = 1723
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowtype windowtype = popup!
string icon = ""
boolean center = false
boolean utiliza_resize = true
dw_vendas dw_vendas
p_fundo p_fundo
end type
global w_fundo w_fundo

type variables
Private:
	Boolean ib_Expandido
	Long il_OldX, il_OldY
end variables

forward prototypes
public subroutine of_resizemanual ()
public subroutine of_atualizar ()
end prototypes

public subroutine of_resizemanual ();//p_fundo.Width = This.Width
//p_Fundo.Height = This.Height
end subroutine

public subroutine of_atualizar ();dw_vendas.Retrieve()
end subroutine

on w_fundo.create
int iCurrent
call super::create
this.dw_vendas=create dw_vendas
this.p_fundo=create p_fundo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_vendas
this.Control[iCurrent+2]=this.p_fundo
end on

on w_fundo.destroy
call super::destroy
destroy(this.dw_vendas)
destroy(this.p_fundo)
end on

event open;call super::open;dw_vendas.SetTransObject(SQLCA)
of_Atualizar()
end event

type dw_vendas from u_datawindow within w_fundo
integer x = 1519
integer y = 872
integer width = 1362
integer height = 845
integer taborder = 10
string dataobject = "dw_graph_vendas"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = StyleBox!
boolean fixo_direita = true
boolean fixo_abaixo = true
end type

event doubleclicked;call super::doubleclicked;
If ib_Expandido Then
	ib_Expandido = False
	
	This.X = il_oldx
	This.y = il_OldY
	
	This.Width = 1362
	This.Height = 845
	
Else
	This.Width = Parent.Width
	This.Height = Parent.Height
	
	il_oldx = This.x
	il_OldY = This.y
	
	This.X = 0
	This.y = 0
	
	ib_Expandido = True
End If
end event

type p_fundo from u_picture within w_fundo
integer width = 2912
integer height = 1726
string picturename = "Imagens\Fundo.jpg"
boolean horizontal_resize = true
boolean vertical_resize = true
end type

