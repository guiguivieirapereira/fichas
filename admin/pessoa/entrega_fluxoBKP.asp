<!--#include file="../conexao.asp"-->
<%
    opendb()

	pasta = "../"
    opcaomenu = "fluxo_entrega"
%>
<!--#include file="../topo.asp"-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper <% if len(recebe("atribui")) > 0 then : response.write "atribui" : end if %>">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Fichas</h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">Aguardando envio</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table class="table table-bordered table-striped data-table">
                                <thead>
                                    <tr>
										<th>ID</th>
										<th>Nome</th>
										<th>E-mail</th>
                                        <th>Serviços</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody>
							<%
                                set objrs = objCOnn.execute("select * from "&prefixo&"pessoa where ativo = 1 and (citru = 1 or banner = 1 or material = 1) and posicao_entrega = 0")
                                while not objrs.eof
                            %>
                                    <tr style="cursor:pointer;">
                                        <td><%=objrs("id")%></td>
                                        <td><%=objrs("nome")%></td>
                                        <td><%=objrs("email")%></td>
                                        <td>
                                    <%
                                        separador = ""

                                        if objrs("citru") = "1" then
                                            response.write separador&"Citru"
                                            separador = ", "
                                        end if

                                        if objrs("banner") = "1" then
                                            response.write separador&"Banner"
                                            separador = ", "
                                        end if

                                        if objrs("material") = "1" then
                                            response.write separador&"Material"
                                            separador = ", "
                                        end if
                                    %>
                                        </td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="cadastro.location.href='entrega_posicao.asp?id=<%=objrs("id")%>&posicao_entrega=1'">Saiu para entrega</button>
                                        </td>
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
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">Saiu para entrega</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table class="table table-bordered table-striped data-table">
                                <thead>
                                    <tr>
										<th>ID</th>
										<th>Nome</th>
										<th>E-mail</th>
                                        <th>Serviços</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody>
							<%
                                set objrs = objCOnn.execute("select * from "&prefixo&"pessoa where ativo = 1 and (citru = 1 or banner = 1 or material = 1) and posicao_entrega = 1")
                                while not objrs.eof
                            %>
                                    <tr style="cursor:pointer;">
                                        <td><%=objrs("id")%></td>
                                        <td><%=objrs("nome")%></td>
                                        <td><%=objrs("email")%></td>
                                        <td>
                                    <%
                                        separador = ""

                                        if objrs("citru") = "1" then
                                            response.write separador&"Citru"
                                            separador = ", "
                                        end if

                                        if objrs("banner") = "1" then
                                            response.write separador&"Banner"
                                            separador = ", "
                                        end if

                                        if objrs("material") = "1" then
                                            response.write separador&"Material"
                                            separador = ", "
                                        end if
                                    %>
                                        </td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="cadastro.location.href='entrega_posicao.asp?id=<%=objrs("id")%>&posicao_entrega=2'">Entregue</button>
                                        </td>
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
            <div class="row">
                <iframe class="col-md-10" name="cadastro" src="about:blank" frameborder="0" height="100" scrolling="no"></iframe>
            </div>
        </section>
    <!-- /.content -->
    </div>
<!--#include file="../rodape.asp"-->
<%
	closedb()
%>