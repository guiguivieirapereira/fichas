<!--#include file="../conexao.asp"-->
<%
	pasta = "../"
    opcaomenu = "usuarios"
	opendb()
%>
<!--#include file="../topo.asp"-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Usuários&nbsp;&nbsp;
                <a href="cad_usuario.asp" class="btn btn-success btn-sm"><span class="fa fa-plus"></span> &nbsp;Adicionar novo</a>
            </h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">Buscar usuário</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table class="table table-bordered table-striped data-table" data-colunas="" data-order='[[ 0, "desc" ]]'>
                                <thead>
                                    <tr>
										<th>Nome</th>
                                        <th>Login</th>
                                        <th>E-mail</th>
                                    </tr>
                                </thead>
                                <tbody>
							<%
								set objrs = objCOnn.execute("select * from "&prefixo&"usuario where ativo = 1 "&filtroModulo)
                                while not objrs.eof
                            %>
                                    <tr style="cursor:pointer;" onclick="parent.location.href='cad_usuario.asp?id=<%=objrs("id")%>'">
                                        <td><%=objrs("nome")%></td>
                                        <td><%=objrs("login")%></td>
                                        <td><%=objrs("email")%></td>
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