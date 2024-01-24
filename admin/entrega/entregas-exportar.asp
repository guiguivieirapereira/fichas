<%
    Response.ContentType="application/vnd.ms-excel"
    response.AddHeader "content-disposition", "inline; filename=entregas.xls"
%>
<!--#include file="../conexao.asp"-->
<%
    opendb()
%>
    <table border="1">
        <thead>
            <tr>
				<th>ID</th>
				<th>Data</th>
				<th>Motoqueiro</th>
				<th>Total</th>
				<th>Entregues</th>
				<th>Pendentes</th>
            </tr>
        </thead>
        <tbody>
    <%
        strq = "select e.*, m.nome as motoqueiro, ifnull(ep.total, 0) as total, ifnull(ep_e.entregues, 0) as entregues from "&prefixo&"entrega e join "&_
               " "&prefixo&"motoqueiro m on m.id = e.id_motoqueiro join(select count(id) as total, id_entrega from "&prefixo&"entrega_pessoa group by "&_
               " id_entrega) as ep on ep.id_entrega = e.id left outer join(select count(id) as entregues, id_entrega from "&prefixo&"entrega_pessoa "&_
               " where entregue = 1 group by id_entrega) as ep_e on ep_e.id_entrega = e.id where e.ativo = 1 "
        set objrs = objConn.execute(strq)
		while not objrs.eof
            pendentes = cint(objrs("total")) - cint(objrs("entregues"))
    %>
            <tr>
                <td><%=objrs("id")%></td>
                <td><%=objrs("datahora")%></td>
                <td><%=objrs("motoqueiro")%></td>
                <td><%=objrs("total")%></td>
                <td><%=objrs("entregues")%></td>
                <td><%=pendentes%></td>
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