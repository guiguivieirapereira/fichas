<%
    Response.ContentType="application/vnd.ms-excel"
    response.AddHeader "content-disposition", "inline; filename=envios_pendentes.xls"
%>
<!--#include file="../conexao.asp"-->
<%
    opendb()

    busca = recebe("busca")
    rua = recebe("rua")
    bairro = recebe("bairro")
%>
    <table border="1">
        <thead>
            <tr>
				<th>ID</th>
				<th>Nome</th>
				<th>Endereço</th>
				<th>Número</th>
				<th>Complemento</th>
				<th>Bairro</th>
				<th>Telefone</th>
                <th>Material</th>
            </tr>
        </thead>
        <tbody>
    <%
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
        set objrs = objConn.execute(strq)
		while not objrs.eof
    %>
            <tr>
                <td><%=objrs("id")%></td>
                <td><%=objrs("nome")%></td>
                <td><%=objrs("rua")%></td>
                <td><%=objrs("numero")%></td>
                <td><%=objrs("complemento")%></td>
                <td><%=objrs("bairro")%></td>
                <td><%=objrs("telefone1")%></td>
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
    </table>
<%
    closedb()
%>