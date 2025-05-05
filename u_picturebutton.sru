HA$PBExportHeader$u_picturebutton.sru
forward
global type u_picturebutton from picturebutton
end type
end forward

global type u_picturebutton from picturebutton
integer width = 382
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
alignment htextalign = left!
end type
global u_picturebutton u_picturebutton

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

on u_picturebutton.create
end on

on u_picturebutton.destroy
end on

event constructor;of_StoreResizeParms()
end event

