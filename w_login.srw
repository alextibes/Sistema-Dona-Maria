HA$PBExportHeader$w_login.srw
forward
global type w_login from w_ancestral
end type
type st_1 from u_statictext within w_login
end type
type sle_senha from u_singlelineedit within w_login
end type
type sle_login from u_singlelineedit within w_login
end type
type st_login from u_statictext within w_login
end type
type st_senha from u_statictext within w_login
end type
type st_logo from u_statictext within w_login
end type
end forward

global type w_login from w_ancestral
integer width = 1420
integer height = 1055
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowtype windowtype = popup!
st_1 st_1
sle_senha sle_senha
sle_login sle_login
st_login st_login
st_senha st_senha
st_logo st_logo
end type
global w_login w_login

forward prototypes
public function boolean of_validar_login ()
private subroutine of_logar ()
private subroutine of_cancelar ()
end prototypes

public function boolean of_validar_login ();String ls_Login, ls_Senha, ls_Usuario, ls_SQL
Long ll_idUsuario
Boolean lb_FlagInativo

ls_Login = Trim(sle_Login.Text)
ls_Senha = Trim(sle_Senha.Text)

If ls_Login = '' Then
	sle_Login.SetFocus()
	MessageBox(gs_Sistema, 'Por favor informe o "Login" para acessar.')
	Return False
End If

If ls_Senha = '' Then
	sle_Senha.SetFocus()
	MessageBox(gs_Sistema, 'Por favor informe a "Senha" para acessar.')
	Return False
End If

//Faz o select no banco para verificar se o usu$$HEX1$$e100$$ENDHEX$$rio existe, est$$HEX2$$e1002000$$ENDHEX$$ativo e se a senha informada confere com o cadastro
SELECT 
	ID_USUARIO, FLAG_INATIVO, NOME
INTO
	:ll_idUsuario, :lb_FlagInativo, :ls_Usuario
FROM
	USUARIO
WHERE
	UPPER(LOGIN) = :ls_Login AND SENHA = crypt(:ls_Senha, senha)
USING SQLCA;


If f_Null(ll_idUsuario, 0) > 0 Then
	If lb_FlagInativo Then
		MessageBox(gs_Sistema, 'O login informado est$$HEX2$$e1002000$$ENDHEX$$inativo no seu cadastro.')
		Return False
	End If
Else
	MessageBox(gs_Sistema, 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado nenhum registro para o login e senha informados.')
	Return False
End If

INSERT INTO session_data ("current_user") VALUES (:ls_Usuario);
COMMIT USING SQLCA;

select "current_user" into :ls_sql from  session_data;

gl_idUsuarioLogado = ll_idUsuario //Seta o usu$$HEX1$$e100$$ENDHEX$$rio que acessou o sistema

Return True
end function

private subroutine of_logar ();//Fun$$HEX2$$e700e300$$ENDHEX$$o para entrar no sistema

RegistrySet('HKEY_CURRENT_USER\SOFTWARE\DonaMaria', 'Login', RegString!, sle_Login.Text)

Open(w_Principal)
Close(This)
end subroutine

private subroutine of_cancelar ();
Halt Close //Termina a aplica$$HEX2$$e700e300$$ENDHEX$$o
end subroutine

on w_login.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_senha=create sle_senha
this.sle_login=create sle_login
this.st_login=create st_login
this.st_senha=create st_senha
this.st_logo=create st_logo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_senha
this.Control[iCurrent+3]=this.sle_login
this.Control[iCurrent+4]=this.st_login
this.Control[iCurrent+5]=this.st_senha
this.Control[iCurrent+6]=this.st_logo
end on

on w_login.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_senha)
destroy(this.sle_login)
destroy(this.st_login)
destroy(this.st_senha)
destroy(this.st_logo)
end on

event open;call super::open;RegistryGet("HKEY_CURRENT_USER\SOFTWARE\DonaMaria", "LOGIN", RegString!, sle_Login.Text)
end event

event key;call super::key;
IF Key = KeyEnter! Then
	if of_Validar_Login() Then
		of_Logar()
	End If
End If

If Key = KeyEscape! Then
	of_Cancelar()
End If
end event

type st_1 from u_statictext within w_login
integer y = 217
integer width = 1427
integer height = 187
integer textsize = -25
long textcolor = 128
string text = "Artigos Religiosos"
alignment alignment = center!
end type

type sle_senha from u_singlelineedit within w_login
integer x = 69
integer y = 835
integer width = 1297
integer taborder = 10
boolean password = true
end type

type sle_login from u_singlelineedit within w_login
integer x = 69
integer y = 618
integer width = 1297
integer taborder = 20
textcase textcase = upper!
end type

event losefocus;call super::losefocus;sle_senha.SetFocus()
end event

type st_login from u_statictext within w_login
integer x = 69
integer y = 548
integer width = 237
string text = "Login"
end type

type st_senha from u_statictext within w_login
integer x = 69
integer y = 771
integer width = 443
string text = "Senha"
end type

type st_logo from u_statictext within w_login
integer width = 1423
integer height = 234
integer textsize = -42
integer weight = 700
long textcolor = 128
string text = "Dona Maria"
alignment alignment = center!
end type

