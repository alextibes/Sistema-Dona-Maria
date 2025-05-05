HA$PBExportHeader$u_datawindow.sru
forward
global type u_datawindow from datawindow
end type
end forward

global type u_datawindow from datawindow
string tag = "uo"
integer width = 687
integer height = 401
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global u_datawindow u_datawindow

type variables

Boolean Destacar_Linha_Selecionada

Boolean	Horizontal_Center, Vertical_Center, Horizontal_Resize, Vertical_Resize, Fixo_Direita, Fixo_Abaixo

s_Resize ist_Control
end variables

forward prototypes
public subroutine of_storeresizeparms ()
public function s_resize of_getresizeparms ()
public function integer find (string as_find)
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

public function integer find (string as_find);Return This.Find(as_Find, 1, This.RowCount())
end function

on u_datawindow.create
end on

on u_datawindow.destroy
end on

event rowfocuschanged;
If Destacar_Linha_Selecionada Then
	This.SelectRow(0, False)
	This.SelectRow(CurrentRow, True)
End If
end event

event retrieveend;
If Destacar_Linha_Selecionada Then
	If RowCount > 0 Then
		This.SelectRow(0, False)
		This.SelectRow(1, True)
	End If
End If
end event

event constructor;of_StoreResizeParms()
end event

event losefocus;This.AcceptText()
end event

