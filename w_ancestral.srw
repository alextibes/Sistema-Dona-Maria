HA$PBExportHeader$w_ancestral.srw
$PBExportComments$Tela ancestral de todas as telas do sistema
forward
global type w_ancestral from window
end type
end forward

global type w_ancestral from window
string tag = "uo"
integer width = 4755
integer height = 1980
boolean titlebar = true
string title = "Dona Maria"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "Imagens\Principal.ico"
boolean center = true
end type
global w_ancestral w_ancestral

type variables
Boolean Utiliza_Resize

Long il_MinWidth = 3639, il_MinHeight = 1904

Private Long il_OldWidth, il_OldHeight
Private Boolean ib_Resize = True

n_Resize inv_Resize

Constant Long IL_BORDERVAR = 45
end variables

forward prototypes
public subroutine of_resize ()
public subroutine of_resizemanual ()
end prototypes

public subroutine of_resize ();
If This.Height < il_MinHeight Then
	This.Height = il_MinHeight
End If

If This.Width < il_MinWidth Then
	This.Width = il_MinWidth
End If

This.SetRedraw(False)

inv_Resize.of_Resize(This, il_oldWidth, il_OldHeight, This.Width, This.Height)
Post of_ResizeManual()

This.SetRedraw(True)

ib_Resize = True
end subroutine

public subroutine of_resizemanual ();
end subroutine

on w_ancestral.create
end on

on w_ancestral.destroy
end on

event resize;If Utiliza_Resize Then
	If ib_Resize Then
		ib_Resize = False
		if This.Visible Then
			of_Resize()
		Else
			Post of_Resize()
		End If
	End If
End If
end event

event open;
If Utiliza_Resize Then
	inv_Resize = Create n_Resize
	il_OldWidth = This.Width
	il_Oldheight = This.height
End If
end event

