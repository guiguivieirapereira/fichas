<!--#include file="../conexao.asp"-->
<%
	opendb()

	pasta = "../"
    opcaomenu = "entrega"
    opcaosubmenu = "lista_entrega"
%>
<!--#include file="../topo.asp"-->
<%
	acao = "Cadastrar"
	id = recebe("id")

	if len(id) > 0 then
		set objrs = objConn.execute("select * from "&prefixo&"entrega where id = "&id&"")
		if not objrs.eof then
			acao = "Alterar"
            id_motoqueiro = objrs("id_motoqueiro")
			data_entrega = objrs("data_entrega")
			datahora = objrs("datahora")

            if len(id_motoqueiro) > 0 then
                set objrsI = objConn.execute("select nome from "&prefixo&"motoqueiro where id = '"&id_motoqueiro&"'")
                if not objrsI.eof then
                    motoqueiro = objrsI("nome")
                end if
            end if
		end if
	end if	
%>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper <% if len(recebe("atribui")) > 0 then : response.write "atribui" : end if %>">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Entrega</h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">Detalhes entrega</h3>
                        </div>
                        <!-- /.box-header -->
                        <form action="salva_entrega.asp" method="post" name="frmcad" target="cadastro">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="atribui" value="<%=recebe("atribui")%>">
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-3 form-group">
                                        <label>Data</label>
                                        <input type="text" class="form-control" value="<%=datahora%>" readonly>
                                    </div>
                                    <div class="col-md-3 form-group">
                                        <label>Motoqueiro</label>
                                        <input type="text" class="form-control" value="<%=motoqueiro%>" readonly>
                                    </div>
                                    <!--<div class="col-md-2 form-group">
                                        <label>Data entrega</label>
                                        <input type="text" class="form-control data" name="data_entrega" value="<%=data_entrega%>" />
                                    </div>-->
                                </div>
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary"><%=acao%></button>
						<%
                            if len(id) > 0 then
                        %>
                                <!--<button type="button" class="btn btn-info" onclick="window.open('imprimir.asp?id=<%=id%>', 'imprimir', 'width=800, height=500');">Imprimir</button>-->
                                <button type="button" class="btn btn-danger" onclick="exclui();">Excluir</button>
						<%
                            end if
                        %>
                            </div>
                            <!-- /.box-body -->
                        </form>
                    </div>
                    <!-- /.box -->
                </div>
            <!-- /.col -->
            </div>
        <!-- /.row -->
        <% if len(id) > 0 then %>
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">Fichas</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <form action="marca-entregue.asp" target="cadastro">
                                <input type="hidden" name="id_entrega" value="<%=id%>" />
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr class="active">
                                                <th>&nbsp;</th>
										        <th>ID</th>
										        <th>Nome</th>
										        <th>Endereço</th>
										        <th>Bairro</th>
                                                <th>Material</th>
                                            </tr>
                                        </thead>
                                        <tbody>
							        <%
                                        entrega_pendente = 0

                                        strq = "select p.*, ep.entregue from "&prefixo&"pessoa p join "&prefixo&"entrega_pessoa ep on ep.id_pessoa = p.id where p.ativo = 1 "&_
                                                " and ep.id_entrega = '"&id&"'"
                                        set objrs = objCOnn.execute(strq)
		                                while not objrs.eof
                                    %>
                                            <tr>
                                                <td class="text-center">
                                            <%
                                                if objrs("entregue") = "1" then
                                                    response.write "Entregue"
                                                else
                                                    entrega_pendente = 1
                                                    response.write "<input type=""checkbox"" name=""id_pessoa"" value="""&objrs("id")&""" />"
                                                end if
                                            %>
                                                </td>
                                                <td><%=objrs("id")%></td>
                                                <td><%=objrs("nome")%></td>
                                                <td><%=objrs("rua")%></td>
                                                <td><%=objrs("bairro")%></td>
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
                                            </tr>
                                    <%
                                	        objrs.movenext
								        wend
                                    %>
                                        </tbody>
                                <%
                                    if entrega_pendente = 1 then
                                %>
                                        <tfoot>
                                            <tr class="active">
                                                <td colspan="6" class="text-right">
                                                    <button type="submit" class="btn btn-primary btn-sm">Marca como entregue</button>
                                                </td>
                                            </tr>
                                        </tfoot>
                                <%
                                    end if
                                %>
                                    </table>
                                </div>
                            </form>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            <!-- /.col -->
            </div>
        <% end if %>
            <div class="row">
                <iframe class="col-md-10" name="cadastro" src="about:blank" frameborder="0" height="100" scrolling="no"></iframe>
            </div>
        </section>
    <!-- /.content -->
    </div>
<!--#include file="../rodape.asp"-->
<script type="text/javascript">
	function exclui() {
		if (confirm('Tem certeza que deseja excluir esta entrega?')) {
			cadastro.location.href = 'excluir.asp?id=<%=id%>';
		}
	}
</script>
<%
	closedb()
%>