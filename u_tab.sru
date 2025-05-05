HA$PBExportHeader$u_tab.sru
forward
global type u_tab from tab
end type
type tabpage_pesquisa from userobject within u_tab
end type
type tabpage_pesquisa from userobject within u_tab
end type
type tabpage_cadastro from userobject within u_tab
end type
type tabpage_cadastro from userobject within u_tab
end type
end forward

global type u_tab from tab
integer width = 2305
integer height = 1055
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_pesquisa tabpage_pesquisa
tabpage_cadastro tabpage_cadastro
end type
global u_tab u_tab

on u_tab.create
this.tabpage_pesquisa=create tabpage_pesquisa
this.tabpage_cadastro=create tabpage_cadastro
this.Control[]={this.tabpage_pesquisa,&
this.tabpage_cadastro}
end on

on u_tab.destroy
destroy(this.tabpage_pesquisa)
destroy(this.tabpage_cadastro)
end on

type tabpage_pesquisa from userobject within u_tab
integer x = 15
integer y = 93
integer width = 2274
integer height = 948
long backcolor = 67108864
string text = "Pesquisa"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_cadastro from userobject within u_tab
integer x = 15
integer y = 93
integer width = 2274
integer height = 948
long backcolor = 67108864
string text = "Cadastro"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

