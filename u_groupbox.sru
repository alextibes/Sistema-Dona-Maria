HA$PBExportHeader$u_groupbox.sru
forward
global type u_groupbox from groupbox
end type
end forward

global type u_groupbox from groupbox
string tag = "uo"
integer width = 481
integer height = 401
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = " Texto "
end type
global u_groupbox u_groupbox

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

on u_groupbox.create
end on

on u_groupbox.destroy
end on

event constructor;of_StoreResizeParms()
end event

