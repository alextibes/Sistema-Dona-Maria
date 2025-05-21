HA$PBExportHeader$w_permissoes_modulos_usuarios.srw
forward
global type w_permissoes_modulos_usuarios from w_ancestral
end type
type dw_acessos from u_datawindow within w_permissoes_modulos_usuarios
end type
type st_usuario from u_statictext within w_permissoes_modulos_usuarios
end type
type cb_fechar from u_commandbutton within w_permissoes_modulos_usuarios
end type
type cb_aplicar from u_commandbutton within w_permissoes_modulos_usuarios
end type
type gb_1 from u_groupbox within w_permissoes_modulos_usuarios
end type
type gb_2 from u_groupbox within w_permissoes_modulos_usuarios
end type
end forward

global type w_permissoes_modulos_usuarios from w_ancestral
integer width = 2263
integer height = 1873
string title = "Acesso aos m$$HEX1$$f300$$ENDHEX$$dulos"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_acessos dw_acessos
st_usuario st_usuario
cb_fechar cb_fechar
cb_aplicar cb_aplicar
gb_1 gb_1
gb_2 gb_2
end type
global w_permissoes_modulos_usuarios w_permissoes_modulos_usuarios

type variables
Private:
	Long il_idUsuario
end variables

on w_permissoes_modulos_usuarios.create
int iCurrent
call super::create
this.dw_acessos=create dw_acessos
this.st_usuario=create st_usuario
this.cb_fechar=create cb_fechar
this.cb_aplicar=create cb_aplicar
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_acessos
this.Control[iCurrent+2]=this.st_usuario
this.Control[iCurrent+3]=this.cb_fechar
this.Control[iCurrent+4]=this.cb_aplicar
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
end on

on w_permissoes_modulos_usuarios.destroy
call super::destroy
destroy(this.dw_acessos)
destroy(this.st_usuario)
destroy(this.cb_fechar)
destroy(this.cb_aplicar)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;s_Valores lst_Receber
String ls_Senha

lst_Receber = Message.PowerObjectParm

il_idUsuario = lst_Receber.Long[1]
st_Usuario.text = String(il_idUsuario) + ' - ' + lst_Receber.String[1]

dw_Acessos.SetTransObject(SQLCA)
dw_Acessos.Retrieve(il_idUsuario)
end event

event closequery;call super::closequery;If dw_Acessos.ModifiedCount() > 0 Then
	If MessageBox(gs_Sistema, 'Deseja realmente fechar sem salvar? ~rSe continuar as altera$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o perdidas!', Question!, YesNo!, 2) = 2 Then
		Return 2
	End If
End If
end event

type dw_acessos from u_datawindow within w_permissoes_modulos_usuarios
integer x = 88
integer y = 357
integer width = 2091
integer height = 1222
integer taborder = 20
string dataobject = "d_acessos"
end type

type st_usuario from u_statictext within w_permissoes_modulos_usuarios
integer x = 118
integer y = 107
integer width = 1958
integer height = 73
end type

type cb_fechar from u_commandbutton within w_permissoes_modulos_usuarios
integer x = 1820
integer y = 1653
integer taborder = 30
string text = "&Fechar"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_aplicar from u_commandbutton within w_permissoes_modulos_usuarios
integer x = 38
integer y = 1653
integer taborder = 20
string text = "Aplicar"
end type

event clicked;call super::clicked;Integer li_For, li_Row
DataStore lds_Acessos, lds_Acessos_Del

dw_Acessos.AcceptText()

lds_Acessos = CREATE DataStore
lds_Acessos.DataObject = 'd_usuario_modulos_acesso'
lds_Acessos.SetTransObject(SQLCA)

//Limpa a tabela de permiss$$HEX1$$f500$$ENDHEX$$es antes de Inserir as novas, s$$HEX2$$f3002000$$ENDHEX$$comita na mesma transa$$HEX2$$e700e300$$ENDHEX$$o.
DELETE FROM usuario_modulos_acesso WHERE ID_USUARIO = :il_idUsuario USING SQLCA;

For li_For = 1 To dw_Acessos.RowCount()
	If dw_Acessos.GetItemString(li_For, 'permite_acessar') = '1' Then
		li_Row = lds_Acessos.InsertRow(0)
		lds_Acessos.SetItem(li_Row, 'id_modulo', dw_Acessos.GetItemNumber(li_For, 'id_modulo'))
		lds_Acessos.SetItem(li_Row, 'id_usuario', il_idUsuario)
		lds_Acessos.SetItem(li_Row, 'permite_acessar', '1')
	End If
Next

gn_Gravacao.of_Gravar({lds_Acessos})

if il_idUsuario = gl_idUsuarioLogado Then
	w_Principal.of_Permitir_Acessos()
End If

dw_Acessos.Retrieve(il_idUsuario)
end event

type gb_1 from u_groupbox within w_permissoes_modulos_usuarios
integer x = 38
integer y = 257
integer width = 2183
integer height = 1366
integer taborder = 10
string text = " M$$HEX1$$f300$$ENDHEX$$dulos "
end type

type gb_2 from u_groupbox within w_permissoes_modulos_usuarios
integer x = 38
integer y = 20
integer width = 2183
integer height = 214
integer taborder = 10
string text = "Usu$$HEX1$$e100$$ENDHEX$$rio "
end type

