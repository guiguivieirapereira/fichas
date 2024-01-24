<%
    Response.ContentType="application/vnd.ms-excel"
    response.AddHeader "content-disposition", "inline; filename=fichas_sem_material.xls"
%>
<!--#include file="../conexao.asp"-->
<%
    opendb()
%>
    <table border="1">
        <thead>
            <tr>
				<th>ID</th>
				<th>Indica��o</th>
				<th>N�vel</th>
				<th>Nome</th>
				<th>E-mail</th>
				<th>Telefones</th>
				<th>Cep</th>
				<th>Logradouro</th>
				<th>N�mero</th>
				<th>Complemento</th>
				<th>Bairro</th>
				<th>Cidade</th>
				<th>Estado</th>
				<th>N�mero de fichas</th>
				<th>Zona</th>
				<th>Se��o</th>
				<th>Servi�os</th>
				<th>Observa��o</th>
            </tr>
        </thead>
        <tbody>
    <%
        strq = "select p.*, i.nome as indicacao from "&prefixo&"pessoa p left outer join "&prefixo&"pessoa i on i.id = p.id_indicacao where "&_
               " p.ativo = 1 and length(p.nome) > 0 and p.citru = 0 and p.banner = 0 and p.material = 0 and p.reuniao = 0 "
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
                    response.write separador&"Reuni�o"
                    separador = ", "
                end if
            %>
                </td>
                <td><%=objrs("observacao")%></td>
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