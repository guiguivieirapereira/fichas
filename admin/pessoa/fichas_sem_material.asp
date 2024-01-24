<!--#include file="../conexao.asp"-->
<%
    opendb()

	pasta = "../"
    opcaomenu = "fichas_sem_material"
    busca = recebe("busca")
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
                            <h3 class="box-title">Fichas sem material</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <form method="post" class="row" name="frm">
                            	<input type="hidden" name="atribui" value="<%=recebe("atribui")%>" />
                                <div class="col-md-3 form-group">
                    	            <label>Pesquisar</label>
                                    <input type="text" class="form-control input-sm" name="busca" value="<%=busca%>" maxlength="50">
                                </div>
                                <div class="col-md-2">
                                    <label>&nbsp;</label><br />
                                    <button type="submit" class="btn btn-primary btn-sm">Filtrar</button>
                                </div>
                                <div class="col-md-2 col-md-offset-5 text-right">
                                    <a href="fichas_sem_material-exportar.asp" class="btn btn-info btn-sm" target="_blank">Exportar fichas</a>
                                </div>
                            </form>
                            <br />
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
										<th>ID</th>
										<th>Indicação</th>
										<th>Nível</th>
										<th>Nome</th>
										<th>E-mail</th>
                                    </tr>
                                </thead>
                                <tbody>
							<%
                                r_por_pagina = 25
                                quantpaginas = 0

                                strq = "select p.*, i.nome as indicacao from "&prefixo&"pessoa p left outer join "&prefixo&"pessoa i on i.id = p.id_indicacao where "&_
                                       " p.ativo = 1 and length(p.nome) > 0 and p.citru = 0 and p.banner = 0 and p.material = 0 and p.reuniao = 0 "

                                if len(busca) > 0 then
                                    strq = strq&" and (p.nome like '%"&busca&"%' or i.nome like '%"&busca&"%' "
                                    if isnumeric(busca) then
                                        strq = strq&" or p.id = "&busca
                                    end if
                                    strq = strq&")"
                                end if

                                if len(id_indicacao) > 0 then
                                    strq = strq&" and p.id_indicacao = "&id_indicacao
                                end if

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
                                        <tr style="cursor:pointer;">
                                            <td><%=objrs("id")%></td>
                                            <td onclick="parent.location.href='cad_pessoa.asp?id=<%=objrs("id")%>&atribui=<%=recebe("atribui")%>'"><%=objrs("indicacao")%></td>
                                            <td onclick="parent.location.href='cad_pessoa.asp?id=<%=objrs("id")%>&atribui=<%=recebe("atribui")%>'"><%=objrs("nivel")%></td>
                                            <td onclick="parent.location.href='cad_pessoa.asp?id=<%=objrs("id")%>&atribui=<%=recebe("atribui")%>'"><%=objrs("nome")%></td>
                                            <td onclick="parent.location.href='cad_pessoa.asp?id=<%=objrs("id")%>&atribui=<%=recebe("atribui")%>'"><%=objrs("email")%></td>
                                        </tr>
                            <%
                                        contP = contP + 1
                                	    objrs.movenext
								    wend
                                else
                            %>
                                    <tr>
                                        <td colspan="5" class="text-center">Nenhum registro encontrado</td>
                                    </tr>
                            <%
	                            end if
                            %>
                                </tbody>
                            </table>
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
        </section>
    <!-- /.content -->
    </div>
<!--#include file="../rodape.asp"-->
<%
	closedb()
%>