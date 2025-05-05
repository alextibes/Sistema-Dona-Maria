HA$PBExportHeader$w_cadastro_produtos.srw
forward
global type w_cadastro_produtos from w_ancestral_cadastro
end type
type dw_grade from u_datawindow within tabpage_cadastro
end type
type cb_incluir_grade from u_commandbutton within tabpage_cadastro
end type
end forward

global type w_cadastro_produtos from w_ancestral_cadastro
string title = "Cadastro de Produtos"
string icon = "Imagens\produto.ico"
end type
global w_cadastro_produtos w_cadastro_produtos

type variables

Private:
	u_DataWindow idw_Grade
end variables

forward prototypes
protected subroutine of_incluir ()
protected subroutine of_gravar ()
protected function boolean of_validar_gravacao ()
protected subroutine of_filtrar ()
protected function long of_codigo_principal ()
protected subroutine of_editar ()
end prototypes

protected subroutine of_incluir ();//Fun$$HEX2$$e700e300$$ENDHEX$$o para inserir registro na aba de cadastro

idw_Cadastro.Reset()
idw_Cadastro.InsertRow(0)
idw_Grade.Reset()
idw_Grade.InsertRow(0)
Tab_Principal.TabPage_Cadastro.Enabled = True
Tab_Principal.SelectTab(2)
end subroutine

protected subroutine of_gravar ();//Fun$$HEX2$$e700e300$$ENDHEX$$o que chama a grava$$HEX2$$e700e300$$ENDHEX$$o passando a dw de cadastro que deve ser gravada
Boolean lb_Retorno
Long ll_Find, ll_idProduto

//Valida se $$HEX2$$e9002000$$ENDHEX$$um produto novo
If isNull(idw_Cadastro.GetItemNumber(1, 'id_produto')) Then
	ll_idProduto = gn_Gravacao.of_get_Contador(gn_Gravacao.#PRODUTO)
	idw_Cadastro.SetItem(1, 'id_produto', ll_idProduto)
Else
	ll_idProduto = idw_Cadastro.GetItemNumber(1, 'id_produto')
End If

Do
	ll_Find = idw_Grade.Find('isnull(id_produto)')
	if ll_Find > 0 Then
		idw_Grade.SetItem(ll_Find, 'id_produto', ll_idProduto)
	End If
Loop While ll_Find > 0

lb_Retorno = gn_Gravacao.of_Gravar({idw_Cadastro, idw_Grade})

If lb_Retorno Then //Se gravou corretamente volta para a aba de pesquisa e atualiza a pesquisa
	if of_Validar_Filtros() Then
		of_Filtrar()
	End If
	Tab_Principal.SelectTab(1)
	Tab_Principal.TabPage_Cadastro.Enabled = False
	idw_Cadastro.Reset()
	idw_Grade.Reset()
End If
end subroutine

protected function boolean of_validar_gravacao ();Long ll_Find

idw_Grade.AcceptText()
idw_Cadastro.AcceptText()

IF f_Null(idw_Cadastro.GetItemString(1, 'descricao'), '') = '' Then
	idw_Cadastro.SetColumn('descricao')
	idw_Cadastro.SetRow(1)
	idw_Cadastro.SetFocus()
		
	MessageBox(gs_Sistema, 'Informe a descri$$HEX2$$e700e300$$ENDHEX$$o do Produto principal.', StopSign!)
	Return False
End If

Do
	ll_Find = idw_Grade.Find("subdescricao = '' OR isnull(subdescricao) ")
	if ll_Find > 0 Then
		idw_Grade.SetColumn('subdescricao')
		idw_Grade.SetRow(ll_Find)
		idw_Grade.SetFocus()
		
		MessageBox(gs_Sistema, 'Informe a descri$$HEX2$$e700e300$$ENDHEX$$o da Grade do Produto.', StopSign!)
		Return False
	End If
Loop While ll_Find > 0




Return True
end function

protected subroutine of_filtrar ();String ls_SQLOriginal, ls_Where

ls_SQLOriginal = idw_Resultado.GetSQLSelect()

If f_Null(idw_Filtro.GetItemNumber(1, 'id_produto'), 0) > 0 Then
	ls_Where += ' AND ID_PRODUTO = ' + String(idw_Filtro.GetItemNumber(1, 'id_produto'))
End If

If Trim(f_Null(idw_Filtro.GetItemString(1, 'descricao'), '')) <> '' Then
	ls_Where += " AND (UPPER(DESCRICAO) LIKE '%" + Upper(idw_Filtro.GetItemString(1, 'descricao')) + "%') "
	ls_Where += " OR (UPPER(SUBDESCRICAO) LIKE '%" + Upper(idw_Filtro.GetItemString(1, 'descricao')) + "%') "
End If

ls_Where += " AND FLAG_INATIVO = '" + idw_Filtro.GetItemString(1, 'flag_inativo') + "' "

//Seta o SQL com os filtros
idw_Resultado.SetSQLSelect(ls_SQLOriginal + ls_Where)
//Executa o retrive para carregar do banco
idw_Resultado.Retrieve()
//Volta o SQL Original
idw_Resultado.SetSQLSelect(ls_SQLOriginal)
end subroutine

protected function long of_codigo_principal ();Return idw_Resultado.GetItemNumber(idw_Resultado.GetRow(), 'id_produto')
end function

protected subroutine of_editar ();//Fun$$HEX2$$e700e300$$ENDHEX$$o criada para alterar um cadastro, deve ser implementada pelas telas filhas desta a of_Get_Codigo_principal
Long ll_idCodigo
Integer li_Ret

If idw_Resultado.RowCount() = 0 Then
	MessageBox(gs_Sistema, 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX2$$e1002000$$ENDHEX$$registro para editar.')
	Return
End If

ll_idCodigo = of_Codigo_Principal()

If ll_idCodigo > 0 Then
	li_Ret = idw_Cadastro.Retrieve(ll_idCodigo)
	idw_Grade.Retrieve(ll_idCodigo)
	
	if li_Ret = 1 Then
		Tab_Principal.TabPage_Cadastro.Enabled = True
		Tab_Principal.SelectTab(2)
	Else
		MessageBox(gs_Sistema, 'Nenhum registro foi encontrado!')
		idw_Cadastro.Reset()
		idw_Grade.Reset()
	End If
End If
end subroutine

on w_cadastro_produtos.create
int iCurrent
call super::create
end on

on w_cadastro_produtos.destroy
call super::destroy
end on

event open;call super::open;
idw_Grade = Tab_Principal.TabPage_Cadastro.dw_Grade

idw_Grade.SetTransObject(SQLCA)
end event

type cb_sair from w_ancestral_cadastro`cb_sair within w_cadastro_produtos
end type

type tab_principal from w_ancestral_cadastro`tab_principal within w_cadastro_produtos
end type

type tabpage_pesquisa from w_ancestral_cadastro`tabpage_pesquisa within tab_principal
end type

type cb_limpar from w_ancestral_cadastro`cb_limpar within tabpage_pesquisa
end type

type cb_pesquisar from w_ancestral_cadastro`cb_pesquisar within tabpage_pesquisa
end type

type dw_resultado from w_ancestral_cadastro`dw_resultado within tabpage_pesquisa
string dataobject = "d_produtos_resultado"
end type

type dw_filtro from w_ancestral_cadastro`dw_filtro within tabpage_pesquisa
string dataobject = "d_produtos_filtro"
end type

type cb_editar from w_ancestral_cadastro`cb_editar within tabpage_pesquisa
end type

type cb_incluir from w_ancestral_cadastro`cb_incluir within tabpage_pesquisa
end type

type gb_resultado from w_ancestral_cadastro`gb_resultado within tabpage_pesquisa
end type

type gb_filtro from w_ancestral_cadastro`gb_filtro within tabpage_pesquisa
end type

type tabpage_cadastro from w_ancestral_cadastro`tabpage_cadastro within tab_principal
dw_grade dw_grade
cb_incluir_grade cb_incluir_grade
end type

on tabpage_cadastro.create
this.dw_grade=create dw_grade
this.cb_incluir_grade=create cb_incluir_grade
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_grade
this.Control[iCurrent+2]=this.cb_incluir_grade
end on

on tabpage_cadastro.destroy
call super::destroy
destroy(this.dw_grade)
destroy(this.cb_incluir_grade)
end on

type cb_cancelar from w_ancestral_cadastro`cb_cancelar within tabpage_cadastro
integer x = 920
integer taborder = 50
end type

type cb_gravar from w_ancestral_cadastro`cb_gravar within tabpage_cadastro
integer x = 481
integer taborder = 40
end type

type dw_cadastro from w_ancestral_cadastro`dw_cadastro within tabpage_cadastro
integer height = 541
integer taborder = 10
string dataobject = "d_produtos_cadastro"
boolean vertical_resize = false
end type

event dw_cadastro::itemchanged;call super::itemchanged;Long ll_For

If dwo.Name = 'descricao' Then
	For ll_For = 1 to idw_Grade.RowCount()
		idw_Grade.SetItem(ll_For, 'descricao_cupom', data + ' ' + idw_Grade.GetItemString(ll_For, 'subdescricao'))
	Next
End If
end event

type gb_cadastro from w_ancestral_cadastro`gb_cadastro within tabpage_cadastro
end type

type dw_grade from u_datawindow within tabpage_cadastro
integer x = 46
integer y = 648
integer width = 3950
integer height = 992
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_produtos_grades_cadastro"
boolean destacar_linha_selecionada = true
boolean horizontal_resize = true
boolean vertical_resize = true
end type

event itemchanged;call super::itemchanged;Long ll_Linha, ll_idGrade
Decimal lde_CodBarra, lde_Null
String ls_Descricao

If dwo.Name = 'subdescricao' Then
	ll_Linha = This.GetRow()
	
	If ll_Linha > 0 Then
		This.SetItem(ll_Linha, 'descricao_cupom', idw_Cadastro.GetItemString(1, 'descricao') + ' ' + data)
	End If
End If

if dwo.name = 'codigo_barras' Then
	
	lde_CodBarra = Dec(data)
	ll_idGrade = This.GetItemNumber(This.GetRow(), 'id_grade')
	
	SELECT ID_GRADE || ' - ' || DESCRICAO || ' ' || SUBDESCRICAO as DESCRICAO
	INTO :ls_Descricao
	FROM PRODUTO_GRADE PG inner join PRODUTO P on (PG.id_produto = P.id_produto )
	WHERE codigo_barras = :lde_CodBarra AND id_Grade <> :ll_idGrade
	USING SQLCA;
	
	If ls_Descricao <> '' Then
		SetNull(lde_Null)
		MessageBox(gs_Sistema, 'O c$$HEX1$$f300$$ENDHEX$$digo de barras (' + data + ') j$$HEX2$$e1002000$$ENDHEX$$est$$HEX2$$e1002000$$ENDHEX$$cadastrado para o produto "' + &
		ls_Descricao + '"', StopSign!)
		This.Post SetItem(row, 'codigo_barras', lde_Null)
	End If
	
End If
end event

type cb_incluir_grade from u_commandbutton within tabpage_cadastro
integer x = 19
integer y = 1693
integer width = 439
integer taborder = 30
boolean bringtotop = true
string text = "Incluir Grade"
boolean fixo_abaixo = true
end type

event clicked;call super::clicked;Long ll_Row

ll_Row = idw_Grade.InsertRow(0)
idw_Grade.SetItem(ll_Row, 'id_produto', idw_Cadastro.GetItemNumber(1, 'id_produto'))
idw_Grade.SetRow(ll_Row)
idw_Grade.SetColumn('subdescricao')
idw_Grade.SetFocus()
end event

