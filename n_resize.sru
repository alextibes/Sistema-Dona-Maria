HA$PBExportHeader$n_resize.sru
$PBExportComments$components.pbl
forward
global type n_resize from nonvisualobject
end type
end forward

global type n_resize from nonvisualobject
end type
global n_resize n_resize

type variables
Protected Long il_VBorder, il_HBorder

Constant Long VBORDER = 50
Constant Long HBORDER = 150

u_UserObject iuo_ConfigAncestor
end variables

forward prototypes
public subroutine of_resizeobject (ref s_resize ast_control, long al_oldwidth, long al_oldheight, long al_newwidth, long al_newheight)
public subroutine of_resizetab (ref tab at_tab, long al_oldwidth, long al_oldheight, long al_newwidth, long al_newheight)
public subroutine of_settabborderdefault (tab at_tab, long al_newwidth, long al_newheight)
public subroutine of_getcontrol (powerobject apo_container, ref windowobject awo_control[])
public subroutine of_resize (powerobject apo_container, long al_oldwidth, long al_oldheight, long al_newwidth, long al_newheight)
end prototypes

public subroutine of_resizeobject (ref s_resize ast_control, long al_oldwidth, long al_oldheight, long al_newwidth, long al_newheight);String ls_err
try 
	If ast_Control.Horizontal_Resize Then
		If ast_Control.Horizontal_Center Then
			ast_Control.Control.Width = ast_Control.Width + (al_NewWidth - al_OldWidth) / 2
		Else
			ast_Control.Control.Width = ast_Control.Width + al_NewWidth - al_OldWidth
		End If
	End If
	
	If ast_Control.Vertical_Resize Then
		If ast_Control.Vertical_Center Then
			ast_Control.Control.Height = ast_Control.Height + (al_NewHeight - al_OldHeight) / 2
		Else
			ast_Control.Control.Height = ast_Control.Height + al_NewHeight - al_OldHeight
		End If
	End If
	
	If ast_Control.Fixo_Direita Then
		If ast_Control.Horizontal_Center Then
			ast_Control.Control.X = ast_Control.X + (al_NewWidth - al_OldWidth) / 2
		Else
			ast_Control.Control.X = ast_Control.X + al_NewWidth - al_OldWidth
		End If
	End If
	
	If ast_Control.Fixo_Abaixo Then
		If ast_Control.Vertical_Center Then
			ast_Control.Control.Y = ast_Control.Y + (al_NewHeight - al_OldHeight) / 2
		Else
			ast_Control.Control.Y = ast_Control.Y + al_NewHeight - al_OldHeight
		End If
	End If
CATCH (runtimeerror er) 
	ls_err = 'Err'			
FINALLY   
	if ls_err = 'Err'	then
	end if
END TRY  
end subroutine

public subroutine of_resizetab (ref tab at_tab, long al_oldwidth, long al_oldheight, long al_newwidth, long al_newheight);Long ll_For, ll_For2
Long ll_TamanhoDataWindow, ll_TamanhoObjeto
Boolean lb_ComponenteMaiorQueTabPage = False
String ls_err

try 
	If IsValid(at_Tab) Then 
		UserObject luo_TabPage
		Tab lt_Tab
		s_Resize lst_Control
		
		Choose Case at_Tab.Tag
			Case 'RES'
				of_SetTabBorderDefault(at_Tab, al_NewWidth, al_NewHeight)
			Case 'uo'
				lst_Control = at_Tab.Dynamic of_GetResizeParms()
				of_ResizeObject(lst_Control, al_OldWidth, al_OldHeight, al_NewWidth, al_NewHeight)
		End Choose
			
		For ll_For = 1 to UpperBound(at_Tab.Control)
			luo_TabPage = at_Tab.Control[ll_For]
						
			For ll_For2 = 1 to UpperBound(luo_TabPage.Control)
				if isvalid(luo_TabPage.Control[ll_For2]) then
					If luo_TabPage.Control[ll_For2].TypeOf() = Tab! Then					
						lt_Tab = luo_TabPage.Control[ll_For2]
						of_ResizeTab(lt_Tab, al_OldWidth, al_OldHeight, al_NewWidth, al_NewHeight)
					Else
						If luo_TabPage.Control[ll_For2].tag = 'uo' Then
							lst_Control = luo_TabPage.Control[ll_For2].Dynamic of_GetResizeParms()
							of_ResizeObject(lst_Control, al_OldWidth, al_OldHeight, al_NewWidth, al_NewHeight)
						End If
					End If
				end if 
			Next
		Next
	End If
CATCH (runtimeerror er) 
	ls_err = 'Err'			
FINALLY   
	if ls_err = 'Err'	then
	end if
END TRY  
end subroutine

public subroutine of_settabborderdefault (tab at_tab, long al_newwidth, long al_newheight);//Em casos de tab dentro de tab, aumenta a distancia da borda entre cada tab e a janela.
//criando uma borda entre a tab de fora e a de dentro.
il_VBorder += VBORDER
il_HBorder += HBORDER
if isvalid(at_tab) then
	at_Tab.Width  = al_NewWidth - at_Tab.X - il_VBorder
	at_Tab.Height = al_NewHeight - at_Tab.Y - il_HBorder
end if 
end subroutine

public subroutine of_getcontrol (powerobject apo_container, ref windowobject awo_control[]);If isvalid(apo_Container) Then
	Choose Case apo_Container.TypeOf() 
		Case Window!
			Window lw_Container
			lw_Container = apo_Container
			awo_Control = lw_Container.Control
		Case Userobject!
			UserObject luo_Container
			luo_Container = apo_Container
			iuo_ConfigAncestor = luo_Container
			awo_Control = luo_Container.Control	
		Case Else

	End Choose
End If
end subroutine

public subroutine of_resize (powerobject apo_container, long al_oldwidth, long al_oldheight, long al_newwidth, long al_newheight);Long ll_For
WindowObject lwo_Control[]
String ls_err = ''

try
	Tab lt_Tab
	s_Resize lst_Control	
	of_GetControl(apo_Container, lwo_Control)
	
	//Zera as bordas para refazer os c$$HEX1$$e100$$ENDHEX$$lculos posteriormente
	il_VBorder = 0
	il_HBorder = 0
	
	For ll_For = 1 to UpperBound(lwo_Control)
		//#83035 - evitar GPF
		If isValid(lwo_Control[ll_For]) Then 
			If lwo_Control[ll_For].TypeOf() = Tab! Then
				lt_Tab = lwo_Control[ll_For]
				of_ResizeTab(lt_Tab, al_OldWidth, al_OldHeight, al_NewWidth, al_NewHeight)
			Else
				If lwo_Control[ll_For].Tag = 'uo' Then
					lst_Control = lwo_Control[ll_For].Dynamic of_GetResizeParms()
					of_ResizeObject(lst_Control, al_OldWidth, al_OldHeight, al_NewWidth, al_NewHeight)
				End If
			End If
		End if
	Next
CATCH (runtimeerror er) 
	ls_err = 'Err'			
FINALLY   
	if ls_err = 'Err'	then
	end if
END TRY
end subroutine

on n_resize.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_resize.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

