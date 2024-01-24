<%
    Response.ContentType="application/vnd.ms-excel"
    response.AddHeader "content-disposition", "inline; filename=fichas.xls"
%>
<!--#include file="../conexao.asp"-->
<%
    opendb()
%>
    <table border="1">
        <thead>
            <tr>
				<th>ID</th>
				<th>Indicação</th>
				<th>Nível</th>
				<th>Nome</th>
				<th>E-mail</th>
				<th>Telefones</th>
				<th>Cep</th>
				<th>Logradouro</th>
				<th>Número</th>
				<th>Complemento</th>
				<th>Bairro</th>
				<th>Cidade</th>
				<th>Estado</th>
				<th>Número de fichas</th>
				<th>Zona</th>
				<th>Seção</th>
				<th>Serviços</th>
				<th>Observação</th>
                <th>Fichas preenchidas</th>
                <th>Fichas pendentes</th>
            </tr>
        </thead>
        <tbody>
    <%
        strq = "select p.*, i.nome as indicacao, ifnull(preenc.qtd, 0) as preenchidas, ifnull(pend.qtd, 0) as pendentes from "&prefixo&"pessoa p "&_
               " left outer join "&prefixo&"pessoa i on i.id = p.id_indicacao left outer join (select id_indicacao, count(id) as qtd from "&_
               " "&prefixo&"pessoa where ativo = 1 and (length(nome) = 0 or nome is null) group by id_indicacao) as pend on pend.id_indicacao = p.id "&_
               " left outer join (select id_indicacao, count(id) as qtd from "&prefixo&"pessoa where ativo = 1 and (length(nome) > 0 and nome is "&_
               " not null) group by id_indicacao) as preenc on preenc.id_indicacao = p.id where p.ativo = 1 and length(p.nome) > 0"
        set objrs = objConn.execute(strq)
		while not objrs.eof
    %>
            <tr>
                <td><%=objrs("id")%></td>
                <td><%=objrs("indicacao")%></td>
                <td><%=objrs("nivel")%></td>
                <td><%=objrs("nome")%></td>
                <td><%=objrs("email")%></td>
                <td><%=objrs("telefone1")&" "&objrs("telefone2")%></td>
                <td><%=objrs("cep")%></td>
                <td><%=objrs("rua")%></td>
                <td><%=objrs("numero")%></td>
                <td><%=objrs("complemento")%></td>
                <td><%=objrs("bairro")%></td>
                <td><%=objrs("cidade")%></td>
                <td><%=objrs("estado")%></td>
                <td><%=objrs("num_fichas")%></td>
                <td><%=objrs("zona")%></td>
                <td><%=objrs("secao")%></td>
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

                if objrs("reuniao") = "1" then
                    response.write separador&"Reunião"
                    separador = ", "
                end if
            %>
                </td>
                <td><%=objrs("observacao")%></td>
                <td><%=objrs("preenchidas")%></td>
                <td><%=objrs("pendentes")%></td>
            </tr>
    <%
			objrs.movenext
		wend
    %>
        </tbody>
    </table>
<%
    closedb()
%>