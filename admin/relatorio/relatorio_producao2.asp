<!--#include file="../conexao.asp"-->
<%
	opendb()

    pasta = "../"
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="iso-8859-1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>União Faz a Ficha</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="<%=pasta%>assets/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/fdd9919b02.js"></script>
    <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">-->
    <!-- Theme style -->
    <link rel="stylesheet" href="<%=pasta%>assets/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="<%=pasta%>assets/dist/css/skins/skin-green-light.min.css">
    <link rel="stylesheet" href="<%=pasta%>assets/dist/css/custom.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition skin-green-light sidebar-mini fixed">
    <div class="">
        <div class="col-xs-12">
            <h2 class="text-center">Relatório de produção</h2>
    <%
        id_pessoa = recebe("id_pessoa")
        data_inicial = recebe("data_inicial")
        data_final = recebe("data_final")

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

        set objrs = objCOnn.execute(strq)
        if not objrs.eof then
    %>
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
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
            </div>
            <p>
                <a href="relatorio_producao-exportar.asp?id_pessoa=<%=id_pessoa%>&data_inicial=<%=data_inicial%>&data_final=<%=data_final%>" class="btn btn-info btn-sm" target="_blank">Exportar</a>
            </p>
    <%
        else
    %>
            <h4>Nada encontrado referente a sua busca.</h4>
    <%
        end if
    %>
    	</div>
    </div>
    <script type="text/javascript">
	    {
		    window.focus();
	    }
    </script>
</body>
</html>
<% 
	closedb()
%>