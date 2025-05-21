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

type variables

Private:
	DataStore ids_Acessos
end variables

forward prototypes
public subroutine of_permitir_acessos ()
public function boolean of_buscar_acessos (string as_modulo)
end prototypes

public subroutine of_permitir_acessos ();
//Permite ou bloqueia acessos de usu$$HEX1$$e100$$ENDHEX$$rios
m_menu lm_Menu
Integer li_For1, li_For2, li_Visiveis

lm_Menu = m_menu

For li_For1 = 1 To UpperBound(lm_Menu.Item)
	if lm_Menu.Item[li_For1].ClassName() = 'm_janelas' Then Continue
	li_Visiveis = 0
	
	if lm_Menu.Item[li_For1].Tag <> '' Then
		If of_Buscar_Acessos(lm_Menu.Item[li_For1].Tag) Then
			lm_Menu.Item[li_For1].Visible = True
			lm_Menu.Item[li_For1].ToolbarItemVisible = True
			li_Visiveis ++ //Se conta como visivel o submenu
		Else
			lm_Menu.Item[li_For1].Visible = False
			lm_Menu.Item[li_For1].ToolbarItemVisible = False
		End If
	End If
	
	For li_For2 = 1 To UpperBound(lm_Menu.Item[li_For1].Item)
		if lm_Menu.Item[li_For1].Item[li_For2].Tag <> '' Then
		
			If of_Buscar_Acessos(lm_Menu.Item[li_For1].Item[li_For2].Tag) Then
				lm_Menu.Item[li_For1].Item[li_For2].Visible = True
				lm_Menu.Item[li_For1].Item[li_For2].ToolbarItemVisible = True
				li_Visiveis ++ //Se conta como visivel o submenu
			Else
				lm_Menu.Item[li_For1].Item[li_For2].Visible = False
				lm_Menu.Item[li_For1].Item[li_For2].ToolbarItemVisible = False
			End If
		Else
			//Se n$$HEX1$$e300$$ENDHEX$$o for separador, conta como visivel o submenu
			if lm_Menu.Item[li_For1].Item[li_For2].Text <> '-' Then li_Visiveis ++
		End If
	Next
	
	If li_Visiveis = 0 Then
		//Se n$$HEX1$$e300$$ENDHEX$$o tem submenu visivel, oculta o menu
		lm_Menu.Item[li_For1].Visible = False
	Else
		lm_Menu.Item[li_For1].Visible = True
	End If
Next

Destroy(ids_Acessos)
end subroutine

public function boolean of_buscar_acessos (string as_modulo);Integer li_Find

//Cria a primeira vez a ds de acessos do usuario
If Not isValid(ids_Acessos) Then
	ids_Acessos = Create DataStore
	ids_Acessos.DataObject = 'd_usuario_modulos_acesso'
	ids_Acessos.SetTransObject(SQLCA)
	ids_Acessos.Retrieve(gl_idUsuarioLogado)
End If

If ids_Acessos.RowCount() > 0 Then
	//Procura pelo modulo para saber se est$$HEX2$$e1002000$$ENDHEX$$liberado para o usuario
	
	li_Find = ids_Acessos.Find('id_modulo = ' + as_Modulo, 1, ids_Acessos.RowCount())
	
	If li_Find > 0 Then
		//Se achou o m$$HEX1$$f300$$ENDHEX$$dulo, verifica se est$$HEX2$$e1002000$$ENDHEX$$habilitado
		If ids_Acessos.GetItemString(li_Find, 'permite_acessar') = '1' Then
			Return True
		Else
			Return False
		End If
	End If
End If

Return False
end function

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
of_Permitir_Acessos()
end event

event resize;call super::resize;if isValid(w_Fundo) Then
	w_Fundo.Height = This.Height - 400
	w_Fundo.Width = This.Width - 80
End If
end event

type mdi_1 from mdiclient within w_principal
long BackColor=268435456
end type

