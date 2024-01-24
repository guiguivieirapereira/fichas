    <div class="row">
        <div class="col-xs-12">
            <div class="">
                <div class="box-header with-border">
                    <h3 class="box-title">Indicados</h3>
                </div>
                <!-- /.box-header -->
                <div class="row" style="padding-top:10px;">
                    <div class="col-md-12">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
									<th>ID</th>
									<th>Indicação</th>
									<th>Número</th>
									<th>Nome</th>
									<th>E-mail</th>
                                </tr>
                            </thead>
                            <tbody>
						<%
                            strq = "select p.*, i.nome as indicacao from "&prefixo&"pessoa p left outer join "&prefixo&"pessoa i on i.id = p.id_indicacao where p.ativo = 1 "&_
                                   " and p.id_indicacao = '"&id&"' "
                            set objrs = objCOnn.execute(strq)
                            while not objrs.eof
                        %>
                                <tr>
                                    <td><%=objrs("id")%></td>
                                    <td><%=objrs("indicacao")%></td>
                                    <td><%=objrs("num")%></td>
                                    <td><%=objrs("nome")%></td>
                                    <td><%=objrs("email")%></td>
                                </tr>
                        <%
                                objrs.movenext
							wend
                        %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- /.box -->
        </div>
    </div>