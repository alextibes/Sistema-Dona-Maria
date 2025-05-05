HA$PBExportHeader$w_principal.srw
forward
global type w_principal from w_ancestral
end type
type mdi_1 from mdiclient within w_principal
end type
end forward

global type w_principal from w_ancestral
integer width = 1332
integer height = 928
string title = "Dona Maria Artigos Religiosos"
string menuname = "m_menu"
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
mdi_1 mdi_1
end type
global w_principal w_principal

on w_principal.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.mdi_1=create mdi_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
end on

on w_principal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;call super::open;openSheet(w_fundo, w_principal, 0, layered!)
end event

event resize;call super::resize;if isValid(w_Fundo) Then
	w_Fundo.Height = This.Height - 400
	w_Fundo.Width = This.Width - 80
End If
end event

type mdi_1 from mdiclient within w_principal
long BackColor=268435456
end type

