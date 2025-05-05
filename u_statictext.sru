HA$PBExportHeader$u_statictext.sru
forward
global type u_statictext from statictext
end type
end forward

global type u_statictext from statictext
integer width = 401
integer height = 63
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type
global u_statictext u_statictext

type variables
Boolean	Horizontal_Center, Vertical_Center, Horizontal_Resize, Vertical_Resize, Fixo_Direita, Fixo_Abaixo

s_Resize ist_Control
end variables
forward prototypes
public subroutine of_storeresizeparms ()
public function s_resize of_getresizeparms ()
end prototypes

public subroutine of_storeresizeparms ();ist_Control.Control = This
ist_Control.Horizontal_Center = Horizontal_Center
ist_Control.Vertical_Center = Vertical_Center
ist_Control.Horizontal_Resize = Horizontal_Resize
ist_Control.Vertical_Resize = Vertical_Resize
ist_Control.Fixo_Direita = Fixo_Direita
ist_Control.Fixo_Abaixo = Fixo_Abaixo
ist_Control.X = This.X
ist_Control.Y = This.Y
ist_Control.Height = This.Height
ist_Control.Width = This.Width
end subroutine

public function s_resize of_getresizeparms ();Return ist_Control
end function

on u_statictext.create
end on

on u_statictext.destroy
end on

event constructor;of_StoreResizeParms()
end event

