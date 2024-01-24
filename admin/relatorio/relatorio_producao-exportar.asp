<%
    Response.ContentType="application/vnd.ms-excel"
    response.AddHeader "content-disposition", "inline; filename=relatorio_producao.xls"
%>
<!--#include file="../conexao.asp"-->
<%
    opendb()

    id_pessoa = recebe("id_pessoa")
    data_inicial = recebe("data_inicial")
    data_final = recebe("data_final")
%>
    <table border="1">
        <thead>
            <tr>
			    <th>ID</th>
			    <th>Indicação</th>
			    <th>Nível</th>
			    <th>Nome</th>
			    <th>Endereço</th>
			    <th>Telefone</th>
                <th>Fichas preenchidas</th>
                <th>Fichas pendentes</th>
            </tr>
        </thead>
        <tbody>
    <%
        strq = "select p.*, i.nome as indicacao, ifnull(preenc.qtd, 0) as preenchidas, ifnull(pend.qtd, 0) as pendentes from "&prefixo&"pessoa p left outer join "&_
               " "&prefixo&"pessoa i on i.id = p.id_indicacao left outer join (select id_indicacao, count(id) as qtd from "&prefixo&"pessoa where ativo = 1 and "&_
               " (length(nome) = 0 or nome is null) group by id_indicacao) as pend on pend.id_indicacao = p.id left outer join (select id_indicacao, count(id) as qtd "&_
               " from "&prefixo&"pessoa where ativo = 1 and (length(nome) > 0 and nome is not null) group by id_indicacao) as preenc on preenc.id_indicacao = p.id where "&_
               " p.ativo = 1 and length(p.nome) > 0 and p.num_fichas > 0 "

        if len(id_pessoa) > 0 then
		    strq = strq&" and p.id = '"&id_pessoa&"' "
	    end if

	    if len(data_inicial) > 0 then
            if len(data_final) > 0 then
		        strq = strq&" and date_format(p.datahora, '%Y-%m-%d') between str_to_date('"&cdate(data_inicial)&"', '%d/%m/%Y') and str_to_date('"&cdate(data_final)&"', '%d/%m/%Y') "
            else
		        strq = strq&" and date_format(p.datahora, '%Y-%m-%d') between str_to_date('"&cdate(data_inicial)&"', '%d/%m/%Y') and str_to_date('"&cdate(data_inicial)&"', '%d/%m/%Y') "
            end if
	    end if

        set objrs = objConn.execute(strq)
		while not objrs.eof
            telefones = objrs("telefone1")

            if len(objrs("telefone2")) > 0 then
                telefones = telefones&" | "&objrs("telefone2")
            end if

            endereco = objrs("rua")&", "&objrs("numero")

            if len(objrs("complemento")) > 0 then
                endereco = endereco&" - "&objrs("complemento")
            end if

            endereco = endereco&", "&objrs("bairro")&" - "&objrs("cidade")&"/"&objrs("estado")&" - "&objrs("cep")
    %>
			<tr>
                <td><%=objrs("id")%></td>
                <td><%=objrs("indicacao")%></td>
                <td><%=objrs("nivel")%></td>
                <td><%=objrs("nome")%></td>
                <td><%=endereco%></td>
                <td><%=telefones%></td>
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