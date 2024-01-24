<!--#include file="../conexao.asp"-->
<%
    opendb()

	pasta = "../"
    opcaomenu = "entrega"
    opcaosubmenu = "aguardando_envio"
    busca = recebe("busca")
    rua = recebe("rua")
    bairro = recebe("bairro")
%>
<!--#include file="../topo.asp"-->
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
                        <div class="box-header">
                            <h3 class="box-title">Aguardando envio</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <form method="post" class="row" name="frm">
                            	<input type="hidden" name="atribui" value="<%=recebe("atribui")%>" />
                                <div class="col-md-3 form-group">
                    	            <label>Pesquisar</label>
                                    <input type="text" class="form-control input-sm" name="busca" value="<%=busca%>" maxlength="50">
                                </div>
                                <div class="col-md-2 form-group">
                    	            <label>Rua</label>
                                    <input type="text" class="form-control input-sm" name="rua" value="<%=rua%>" maxlength="100">
                                </div>
                                <div class="col-md-2 form-group">
                    	            <label>Bairro</label>
                                    <input type="text" class="form-control input-sm" name="bairro" value="<%=bairro%>" maxlength="50">
                                </div>
                                <div class="col-md-2">
                                    <label>&nbsp;</label><br />
                                    <button type="submit" class="btn btn-primary btn-sm">Filtrar</button>
                                </div>
                                <div class="col-md-2 col-md-offset-1 text-right">
                                    <a href="aguardando_envio-exportar.asp?busca=<%=busca%>&rua=<%=rua%>&bairro=<%=bairro%>" class="btn btn-info btn-sm" target="_blank">Exportar envios pendentes</a>
                                </div>
                            </form>
                            <br />
                            <form action="add_entrega.asp" target="cadastro">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th class="text-center"><input type="checkbox" class="checkAll" /></th>
										    <th>ID</th>
										    <th>Nome</th>
										    <th>Endereço</th>
										    <th>Bairro</th>
                                            <th>Material</th>
                                        </tr>
                                    </thead>
                                    <tbody>
							    <%
                                    r_por_pagina = 25
                                    quantpaginas = 0

                                    strq = "select * from "&prefixo&"pessoa where ativo = 1 and (citru = 1 or banner = 1 or material = 1) and id not in(select ep.id_pessoa from "&_
                                           " "&prefixo&"entrega_pessoa ep join "&prefixo&"entrega e on e.id = ep.id_entrega where e.ativo = 1)"

                                    if len(busca) > 0 then
                                        strq = strq&" and (nome like '%"&busca&"%' or rua like '%"&busca&"%' or bairro like '%"&busca&"%' "
                                        if isnumeric(busca) then
                                            strq = strq&" or id = "&busca
                                        end if
                                        strq = strq&")"
                                    end if

                                    if len(rua) > 0 then
                                        strq = strq&" and rua like '%"&rua&"%' "
                                    end if

                                    if len(bairro) > 0 then
                                        strq = strq&" and bairro like '%"&bairro&"%' "
                                    end if

                                    strq = strq&" order by bairro "

	                                pagina = recebe("pagina")
	                                if pagina = "" then
		                                pagina = 1
		                                controlenav = 1
	                                else
		                                intCurrentPage = CInt(Request("CurrentPage"))
	                                end if

	                                intPageSize = r_por_pagina
	                                Set objrs = Server.CreateObject("ADODB.Recordset")
	                                Set objrs.ActiveConnection = objConn
	                                objrs.CursorLocation = 3
	                                objrs.CursorType = 3
	                                objrs.LockType = 1
	                                objrs.PageSize = intPageSize
	                                objrs.Open strq

	                                if not objrs.eof then
		                                quant = objrs.recordcount
		                                quantpaginas = objrs.PageCount
		                                contP = 0
		                                objrs.AbsolutePage = pagina

		                                while not objrs.eof and contP < intPageSize
                                %>
                                            <tr>
                                                <td class="text-center">
                                                    <input type="checkbox" name="id_pessoa" value="<%=objrs("id")%>" />
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
                                            contP = contP + 1
                                	        objrs.movenext
								        wend
                                    else
                                %>
                                        <tr>
                                            <td colspan="6" class="text-center">Nenhum registro encontrado</td>
                                        </tr>
                                <%
	                                end if
                                %>
                                    </tbody>
                            <%
                                if quantpaginas > 0 then
                            %>
                                    <tfoot>
                                        <tr class="active">
                                            <td colspan="6">
                                                <div class="row">
                                                    <div class="col-md-3 col-md-offset-7">
                                                        <label>Motoqueiro</label>
                                                        <select class="form-control" name="id_motoqueiro">
                                                            <option value=""></option>
                                                    <%
                                                        set objrsM = objConn.execute("select * from "&prefixo&"motoqueiro where ativo = 1 order by nome")
                                                        while not objrsM.eof
                                                    %>
                                                            <option value="<%=objrsM("id")%>"><%=objrsM("nome")%></option>
                                                    <%
                                                            objrsM.movenext
                                                        wend
                                                    %>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label>&nbsp;</label><br />
                                                        <button type="submit" class="btn btn-primary">Cadastrar entrega</button>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tfoot>
                            <%
                                end if
                            %>
                                </table>
                            </form>
                    <%
		                if quantpaginas > 1 then
                            primeira = 0
                            inicio = 1
                            fim = quantpaginas

                            if quantpaginas > 9 then
                                limite = 2
                                primeira = 1
                                inicio = pagina - limite
                                fim = pagina + limite

                                if cint(pagina) <= cint(limite) then
                                    primeira = 0
                                    inicio = 1
                                    fim = pagina + limite
                                end if

                                if cint(pagina) = cint(quantpaginas) then
                                    inicio = quantpaginas - limite
                                    fim = quantpaginas
                                end if

                                if pagina - limite = 2 then
                                    inicio = 1
                                end if

                                if pagina + limite = quantpaginas - 1 then
                                    fim = quantpaginas
                                end if
                            end if

                            filtros = "atribui="&recebe("atribui")&"&busca="&busca
                    %>
                            <div class="col-md-12 text-right">
                                <nav>
                                    <ul class="pagination">
                                <%
                                    if pagina > 1 then
                                %>
                                        <li>
                                            <a aria-label="Previous" href="?pagina=<%=pagina-1%>&<%=filtros%>"><i class="fa fa-angle-left"></i></a>
                                        </li>
                                <%
                                    end if

                                    for i = inicio to fim
                                        if primeira = 1 and cint(i) <> 1 then
                                %>
                                            <li>
                                                <a href="?pagina=1&<%=filtros%>">1</a>
                                            </li>
                                            <li><a>...</a></li>
                                <%
                                        end if
                                    
                                        if cint(pagina) = cint(i) then
                                %>
                                            <li class="active">
                                                <a><%=i%></a>
                                            </li>
                                <%
                                        else
                                %>
                                            <li>
                                                <a href="?pagina=<%=i%>&<%=filtros%>"><%=i%></a>
                                            </li>
                                <%
						                end if
                                        primeira = 0
                                        p_final = i
					                next

                                    if p_final <> quantpaginas then
                                %>
                                        <li><a>...</a></li>
                                        <li>
                                            <a href="?pagina=<%=quantpaginas%>&<%=filtros%>"><%=quantpaginas%></a>
                                        </li>
                                <%
                                    end if

                                    if cint(pagina) < cint(quantpaginas) then
                                %>
                                        <li>
                                            <a aria-label="Next" href="?pagina=<%=pagina+1%>&<%=filtros%>"><i class="fa fa-angle-right"></i></a>
                                        </li>
                                <%
                                    end if
                                %>
                                    </ul>
                                </nav>
                            </div>
                    <%
		                end if
                    %>
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
<script type="text/javascript">
    $('.checkAll').click(function () {
        if (this.checked == true)
            $('input[name=id_pessoa]').prop('checked', true);
        else
            $('input[name=id_pessoa]').prop('checked', false);
    });
</script>
<%
	closedb()
%>