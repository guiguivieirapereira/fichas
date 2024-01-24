<!--#include file="../conexao.asp"-->
<%
	pasta = "../"

    opcaomenu = "cadastros_b"
	tabela = recebe("tabela")
	titulo = recebe("titulo")
    opcaosubmenu = tabela

	opendb()
%>
<!--#include file="../topo.asp"-->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Cadastros básicos</h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title"><%=titulo%></h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <form action="convenio_cadastra.asp" method="post" name="frmcad" target="diversos">
                                <input type="hidden" name="tabela" value="<%=tabela%>">
                                <input type="hidden" name="titulo" value="<%=titulo%>">
                                <div class="row">
                                    <div class="form-group">
                                        <div class="col-md-3">
                                            <label>Nome</label>
                                            <input type="text" class="form-control" name="nome" maxlength="50">
                                        </div>
                                        <div class="col-md-2">
                                            <label>&nbsp;</label><br />
                                            <button type="submit" class="btn btn-primary">Cadastrar</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <br />
                            <div class="row">
                                <div class="col-md-6">
						    <%
                                set objrs = objConn.execute("select * from "&prefixo&tabela&" where ativo = 1 order by nome")
							    if not objrs.eof then
                            %>
                                    <form name="frm<%=objrs("id")%>" action="convenio_altera.asp" method="post" target="diversos">
                                        <input type="hidden" name="tabela" value="<%=tabela%>">
                                        <input type="hidden" name="titulo" value="<%=titulo%>">
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr class="active">
                                                	    <th>Nome</th>
                                                        <th style="width:80px;">&nbsp;</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                            <%
                                                cont = 1
								                while not objrs.eof
                                            %>
                                                    <tr>
                                                        <td>
                                                            <input type="hidden" name="id" value="<%=objrs("id")%>">
                                                            <input type="text" class="form-control input-sm" name="nome<%=objrs("id")%>" value="<%=objrs("nome")%>" maxlength="50">
                                                        </td>
                                                        <td><button type="button" class="btn btn-danger btn-sm" onclick="diversos.location.href='convenio_excluir.asp?id_tabela=<%=objrs("id")%>&tabela=<%=tabela%>&titulo=<%=titulo%>'">Excluir</button></td>
                                                    </tr>
						                    <%
									                cont = cont + 1
                                                    objrs.movenext
                                                wend
						                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Salvar alterações</button>
                                    </form>
                            <%	
							    end if
						    %>
                                </div>
                            </div>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            <!-- /.col -->
            </div>
        <!-- /.row -->
            <div class="row">
                <iframe class="col-md-10" name="diversos" src="about:blank" frameborder="0" height="100" scrolling="no"></iframe>
            </div>
        </section>
    <!-- /.content -->
    </div>
<!--#include file="../rodape.asp"-->
<%
	closedb()
%>