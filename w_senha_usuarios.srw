HA$PBExportHeader$w_senha_usuarios.srw
forward
global type w_senha_usuarios from w_ancestral
end type
type cb_1 from u_commandbutton within w_senha_usuarios
end type
type st_3 from u_statictext within w_senha_usuarios
end type
type st_2 from u_statictext within w_senha_usuarios
end type
type st_1 from u_statictext within w_senha_usuarios
end type
type sle_confirma from u_singlelineedit within w_senha_usuarios
end type
type sle_nova from u_singlelineedit within w_senha_usuarios
end type
type sle_antiga from u_singlelineedit within w_senha_usuarios
end type
type gb_senha from u_groupbox within w_senha_usuarios
end type
type cb_cancelar from u_commandbutton within w_senha_usuarios
end type
end forward

global type w_senha_usuarios from w_ancestral
integer width = 1652
integer height = 1012
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
string icon = "Imagens\usuario.ico"
cb_1 cb_1
st_3 st_3
st_2 st_2
st_1 st_1
sle_confirma sle_confirma
sle_nova sle_nova
sle_antiga sle_antiga
gb_senha gb_senha
cb_cancelar cb_cancelar
end type
global w_senha_usuarios w_senha_usuarios

type variables

Private:
	Long il_idUsuario
	String is_Nome
end variables

forward prototypes
public function boolean of_validar ()
public subroutine of_gravar ()
end prototypes

public function boolean of_validar ();Integer li_Count
String ls_SenhaAtual, ls_Nova, ls_Confirmar

ls_Nova = Trim(sle_Nova.Text)
ls_Confirmar = Trim(sle_Confirma.Text)

If ls_Nova = '' OR ls_Confirmar = '' Then
	MessageBox(gs_Sistema, '$$HEX2$$c9002000$$ENDHEX$$necess$$HEX1$$e100$$ENDHEX$$rio informar os campos "Nova senha" e "Confirme nova senha"!')
	Return False
End If

If ls_Nova <> ls_Confirmar Then
	MessageBox(gs_Sistema, 'A nova senha e a confirma$$HEX2$$e700e300$$ENDHEX$$o devem estar iguais. Tente novamente!')
	sle_Nova.Text = ''
	sle_Confirma.Text = ''
	sle_Nova.SetFocus()
	Return False
End If

If sle_Antiga.Enabled Then
	
	ls_SenhaAtual = Trim(sle_Antiga.Text)
	
	select count(1) into :li_Count from usuario where id_usuario = :il_idUsuario and senha = crypt(:ls_SenhaAtual, senha);

	If li_Count = 0 Then
		MessageBox(gs_Sistema, 'A Senha atual deve ser informada corretamente.')
		sle_Antiga.SetFocus()
		Return False
	End If
End If

Return True
end function

public subroutine of_gravar ();//Grava a senha nova para o usu$$HEX1$$e100$$ENDHEX$$rio
String ls_Senha

ls_Senha = Trim(sle_Nova.Text)

UPDATE USUARIO set senha = crypt(:ls_Senha, gen_salt('bf')) Where id_usuario = :il_idUsuario;

If gn_Gravacao.of_Comitar(False) Then
	MessageBox(gs_Sistema, 'A senha foi alterada com sucesso!')
	Close(This)
End If
end subroutine

on w_senha_usuarios.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_confirma=create sle_confirma
this.sle_nova=create sle_nova
this.sle_antiga=create sle_antiga
this.gb_senha=create gb_senha
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_confirma
this.Control[iCurrent+6]=this.sle_nova
this.Control[iCurrent+7]=this.sle_antiga
this.Control[iCurrent+8]=this.gb_senha
this.Control[iCurrent+9]=this.cb_cancelar
end on

on w_senha_usuarios.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_confirma)
destroy(this.sle_nova)
destroy(this.sle_antiga)
destroy(this.gb_senha)
destroy(this.cb_cancelar)
end on

event open;call super::open;
s_Valores lst_Receber
String ls_Senha

lst_Receber = Message.PowerObjectParm

is_Nome = lst_Receber.String[1]
il_idUsuario = lst_Receber.Long[1]

Select senha into :ls_Senha From usuario where id_usuario = :il_idUsuario;

If ls_Senha = '' or isNull(ls_Senha) Then
	sle_antiga.enabled = false
End If
end event

type cb_1 from u_commandbutton within w_senha_usuarios
integer x = 31
integer y = 815
integer taborder = 40
string text = "Alterar"
end type

event clicked;call super::clicked;If of_Validar() Then
	of_Gravar()
End If
end event

type st_3 from u_statictext within w_senha_usuarios
integer x = 195
integer y = 544
integer width = 1194
string text = "confirme a nova senha"
end type

type st_2 from u_statictext within w_senha_usuarios
integer x = 195
integer y = 351
integer width = 1194
string text = "Nova senha"
end type

type st_1 from u_statictext within w_senha_usuarios
integer x = 195
integer y = 154
integer width = 1194
string text = "Senha atual"
end type

type sle_confirma from u_singlelineedit within w_senha_usuarios
integer x = 195
integer y = 614
integer width = 1194
integer taborder = 30
boolean password = true
end type

type sle_nova from u_singlelineedit within w_senha_usuarios
integer x = 195
integer y = 421
integer width = 1194
integer taborder = 20
boolean password = true
end type

type sle_antiga from u_singlelineedit within w_senha_usuarios
integer x = 191
integer y = 217
integer width = 1194
integer taborder = 10
boolean password = true
end type

type gb_senha from u_groupbox within w_senha_usuarios
integer x = 31
integer y = 20
integer width = 1595
integer height = 778
string text = " Alterar senha: "
end type

type cb_cancelar from u_commandbutton within w_senha_usuarios
integer x = 1225
integer y = 811
integer taborder = 50
string text = "Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;close(parent)
end event

