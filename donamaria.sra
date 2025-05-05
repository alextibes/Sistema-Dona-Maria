HA$PBExportHeader$donamaria.sra
$PBExportComments$Generated Application Object
forward
global type donamaria from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_Sistema = 'Dona Maria' //Nome do sistema vis$$HEX1$$ed00$$ENDHEX$$vel ao projeto inteiro
Long gl_idUsuarioLogado //Guarda o usu$$HEX1$$e100$$ENDHEX$$rio que logou no sistema

n_Gravacao gn_Gravacao
end variables
global type donamaria from application
string appname = "donamaria"
end type
global donamaria donamaria

type prototypes
FUNCTION boolean sndPlaySoundA (string SoundName, uint Flags) alias for "sndPlaySoundA;ANSI" LIBRARY "WINMM.DLL"
end prototypes
on donamaria.create
appname="donamaria"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on donamaria.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// Conecta com o banco
// Profile DMODBC
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=DMODBC;UID=postgres;PWD=donamaria'"
CONNECT USING SQLCA;

IF SQLCA.SQLCode < 0 Then  MessageBox("Erro de conex$$HEX1$$e300$$ENDHEX$$o", SQLCA.SQLErrText)

gn_Gravacao = Create n_Gravacao

open(w_Login)
end event

