<!--#include file="../conexao.asp"-->
<%
    opendb()

	pasta = "../"
    opcaomenu = "pessoas"
%>
<!--#include file="../topo.asp"-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper <% if len(recebe("atribui")) > 0 then : response.write "atribui" : end if %>">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Fichas&nbsp;&nbsp;
                <a href="cad_pessoa.asp?atribui=<%=recebe("atribui")%>" class="btn btn-success btn-sm"><span class="fa fa-plus"></span> &nbsp;Adicionar nova</a>
            </h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">Fichas que você indicou</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table class="table table-bordered table-striped data-table">
                                <thead>
                                    <tr>
										<th>ID</th>
										<th>Número</th>
										<th>Nome</th>
										<th>E-mail</th>
                                    <% if len(recebe("atribui")) > 0 then %>
                                        <th>&nbsp;</th>
                                    <% end if %>
                                    </tr>
                                </thead>
                                <tbody>
							<%
                                set objrs = objCOnn.execute("select * from "&prefixo&"pessoa where ativo = 1 and id_indicacao = '"&session("id_pessoa")&"'")
                                while not objrs.eof
                            %>
                                    <tr style="cursor:pointer;">
                                        <td><%=objrs("id")%></td>
                                        <td onclick="parent.location.href='cad_pessoa.asp?id=<%=objrs("id")%>&atribui=<%=recebe("atribui")%>'"><%=objrs("num")%></td>
                                        <td onclick="parent.location.href='cad_pessoa.asp?id=<%=objrs("id")%>&atribui=<%=recebe("atribui")%>'"><%=objrs("nome")%></td>
                                        <td onclick="parent.location.href='cad_pessoa.asp?id=<%=objrs("id")%>&atribui=<%=recebe("atribui")%>'"><%=objrs("email")%></td>
                                    <% if len(recebe("atribui")) > 0 then %>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="javascript:parent.opener.selPessoa('<%=objrs("nome")%>','<%=objrs("id")%>');parent.window.close()">Selecionar</button>
                                        </td>
                                    <% end if %>
                                    </tr>
                            <%
                                	objrs.movenext
								wend
                            %>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            <!-- /.col -->
            </div>
        <!-- /.row -->
        </section>
    <!-- /.content -->
    </div>
<!--#include file="../rodape.asp"-->
<%
	closedb()
%>