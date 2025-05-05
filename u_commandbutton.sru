HA$PBExportHeader$u_commandbutton.sru
forward
global type u_commandbutton from commandbutton
end type
end forward

global type u_commandbutton from commandbutton
string tag = "uo"
integer width = 401
integer height = 114
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "OK"
end type
global u_commandbutton u_commandbutton

type variables
Boolean	Horizontal_Center, Vertical_Center, Horizontal_Resize, Vertical_Resize, Fixo_Direita, Fixo_Abaixo

s_Resize ist_Control
end variables

forward prototypes
public function s_resize of_getresizeparms ()
public subroutine of_storeresizeparms ()
end prototypes

public function s_resize of_getresizeparms ();Return ist_Control
end function

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

on u_commandbutton.create
end on

on u_commandbutton.destroy
end on

event constructor;
of_StoreResizeParms()
end event

