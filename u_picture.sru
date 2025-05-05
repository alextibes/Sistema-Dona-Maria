HA$PBExportHeader$u_picture.sru
forward
global type u_picture from picture
end type
end forward

global type u_picture from picture
string tag = "uo"
integer width = 328
integer height = 174
boolean focusrectangle = false
end type
global u_picture u_picture

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

on u_picture.create
end on

on u_picture.destroy
end on

event constructor;of_StoreResizeParms()
end event

