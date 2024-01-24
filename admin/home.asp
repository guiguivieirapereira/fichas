<!--#include file="conexao.asp"-->
<%
	opendb()

    opcaomenu = "inicial"
%>
<!--#include file="topo.asp"-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Início</h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
        <%
            if permissao(1) then
        %>
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-body">
                            <div class="row">
                        <%
                            strq = "select count(id) as qtd, nivel from "&prefixo&"pessoa where ativo = 1 and (id_indicacao is null or id_indicacao = 0 or id_indicacao "&_
                                   " in(select id from "&prefixo&"pessoa where ativo = 1)) group by nivel order by nivel"
                            set objrs = objConn.execute(strq)
                            if not objrs.eof then
                        %>
                                <div class="col-md-4">
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th colspan="2" class="text-center">Total de pessoas cadastradas por nível</th>
                                                </tr>
                                                <tr class="active">
                                                    <th>Nível</th>
                                                    <th>Quantidade</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                        <%
                                            total = 0
                                            while not objrs.eof
                                        %>
                                                <tr>
                                                    <td><%=objrs("nivel")%></td>
                                                    <td><%=objrs("qtd")%></td>
                                                </tr>
                                        <%
                                                total = total + cint(objrs("qtd"))
                                                objrs.movenext
                                            wend
                                        %>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th class="text-right">Total</th>
                                                    <td><%=total%></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                        <%
                            end if

                            strq = "select count(p.id) as qtd from "&prefixo&"pessoa p left outer join "&prefixo&"pessoa i on i.id = p.id_indicacao where p.ativo = 1 "&_
                                   " and (length(p.nome) = 0 or p.nome is null) and i.ativo = 1"
                            set objrs = objConn.execute(strq)
                            if not objrs.eof then
                        %>
                                <div class="col-md-4">
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Total de fichas pendentes</th>
                                                </tr>
                                                <tr class="active">
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><%=objrs("qtd")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                        <%
                            end if

                            strq = "select count(id) as qtd from "&prefixo&"pessoa where ativo = 1 and (citru = 1 or banner = 1 or material = 1) and id not in(select "&_
                                   " ep.id_pessoa from "&prefixo&"entrega_pessoa ep join "&prefixo&"entrega e on e.id = ep.id_entrega where e.ativo = 1)"
                            set objrs = objConn.execute(strq)
                            if not objrs.eof then
                        %>
                                <div class="col-md-4">
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Total de fichas aguardando envio</th>
                                                </tr>
                                                <tr class="active">
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><%=objrs("qtd")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                        <%
                            end if
                        %>
                            </div>
                        </div>
                    </div>
                </div>
        <%
            end if
        %>
            </div>
            <!-- /.row -->
        </section>
    <!-- /.content -->
    </div>
<!--#include file="rodape.asp"-->
<%
	closedb()
%>