HA$PBExportHeader$n_gravacao.sru
forward
global type n_gravacao from nonvisualobject
end type
end forward

global type n_gravacao from nonvisualobject
end type
global n_gravacao n_gravacao

type variables

Public:
	Constant Long #VENDA = 0
	Constant Long #MOVIMENTO = 1
	Constant Long #PRODUTO = 2
end variables

forward prototypes
public function boolean of_gravar (datawindow adw_salvar[])
public function boolean of_gravar (datawindow adw_salvar)
public subroutine of_rollback ()
public function boolean of_gravar (datawindow adw_salvar[], boolean ab_mostrar_msg)
public function boolean of_comitar (boolean ab_mostrar_msg)
public function long of_get_contador (long al_tipo)
end prototypes

public function boolean of_gravar (datawindow adw_salvar[]);Return of_Gravar(adw_Salvar, True)
end function

public function boolean of_gravar (datawindow adw_salvar);Return of_Gravar({adw_Salvar})
end function

public subroutine of_rollback ();//Fun$$HEX2$$e700e300$$ENDHEX$$o para desfazer as altera$$HEX2$$e700f500$$ENDHEX$$es

ROLLBACK USING SQLCA;
end subroutine

public function boolean of_gravar (datawindow adw_salvar[], boolean ab_mostrar_msg);Integer li_For, li_Ret

For li_For = 1 To UPPERBOUND(adw_Salvar) //Percorre Todas as dw que existem para gravar
	li_Ret = adw_Salvar[li_For].Update() //Grava a dw corrente
	
	If li_Ret = -1 Then
		Exit //Se deu erro na grava$$HEX2$$e700e300$$ENDHEX$$o, para de tentar gravar
	End If
Next

If li_Ret = 1 Then //Gravou comita e d$$HEX2$$e1002000$$ENDHEX$$a msg de sucesso
	Return of_Comitar(ab_mostrar_msg)
Else //N$$HEX1$$e300$$ENDHEX$$o gravou desfaz as altera$$HEX2$$e700f500$$ENDHEX$$es e d$$HEX2$$e1002000$$ENDHEX$$a msg de erro
	of_RollBack()
	Return False
End If
end function

public function boolean of_comitar (boolean ab_mostrar_msg);//Fun$$HEX2$$e700e300$$ENDHEX$$o para comitar as altera$$HEX2$$e700f500$$ENDHEX$$es de uma grava$$HEX2$$e700e300$$ENDHEX$$o

COMMIT USING SQLCA;

If SQLCA.SQLCode = -1 Then //Testa se ocorreu erro na transa$$HEX2$$e700e300$$ENDHEX$$o
	MessageBox('Falha ao gravar', SQLCA.SQLErrText, StopSign!) //Mostra a mensagem de Erro
	of_RollBack()
	Return False
Else
	If ab_Mostrar_Msg Then MessageBox(gs_Sistema, 'Dados gravados com sucesso!')
End If

Return True
end function

public function long of_get_contador (long al_tipo);Long ll_Retorno

Choose Case al_Tipo
	Case #MOVIMENTO
		select nextval('seq_id_movimento') Into :ll_Retorno from (select 1);
	Case #VENDA
		select nextval('seq_id_vendas') Into :ll_Retorno from (select 1);
	Case #PRODUTO
		select nextval('produto_grade_id_grade_seq') Into :ll_Retorno from (select 1);
	Case Else
		MessageBox(gs_Sistema, 'Aten$$HEX2$$e700e300$$ENDHEX$$o! ~r~r O contador ' + String(al_Tipo) + 'n$$HEX1$$e300$$ENDHEX$$o foi encontrado!')
		ll_Retorno = -1
End Choose

Return ll_Retorno
end function

on n_gravacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_gravacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

