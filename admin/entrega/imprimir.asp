<!--#include file="../conexao.asp"-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="iso-8859-1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>União faz a ficha</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="../assets/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <style>
        table td, table th {
            vertical-align: inherit;
        }
        .table {
            margin-bottom: 0;
        }
        .table + .table {
            border-top: 0;
        }
        .ficha {
            padding-top: 30px;
            padding-bottom: 30px;
        }
        .table-bordered > tbody > tr > td, .table-bordered > tbody > tr > th, 
        .table-bordered > tfoot > tr > td, .table-bordered > tfoot > tr > th, 
        .table-bordered > thead > tr > td, .table-bordered > thead > tr > th {
            border: 1px solid #000;
        }
        hr {
            margin: 30px 0;
            border: 1px dashed #000;
        }
    </style>
</head>
<body>
<%
    opendb()

    id = recebe("id")
    primeiro = 1

	cont = 0 
    strq = "select * from "&prefixo&"pessoa where id in(select id_pessoa from "&prefixo&"entrega_pessoa where id_entrega = '"&id&"') order by bairro, rua, cast(numero as SIGNED)"
    set objrs = objCOnn.execute(strq)
    while not objrs.eof
		cont = cont + 1

        if primeiro = 0 then
            response.write "<hr />"
        end if

        endereco = objrs("rua")&", "&objrs("numero")
        if len(objrs("complemento")) > 0 then
            endereco = endereco&" - "&objrs("complemento")
        end if
        endereco = endereco&" - "&objrs("bairro")&" - "&objrs("cidade")&"/"&objrs("estado")
%>
        <table class="table table-bordered ficha">
            <thead>
                <tr>
                    <th colspan="3" class="text-center">Código <%=objrs("id")%></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="3">
                        <strong>Nome:</strong> <%=objrs("nome")%> -  <strong>Telefone:</strong> <%=objrs("telefone1")%><br />
                        <strong>Endereco:</strong> <%=endereco%><br />
                        <strong>Material:</strong>
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
                <tr>
                    <td colspan="2">
                        <strong>Assinatura</strong>
                        <br /><br />
                    </td>
                    <td colspan="1">
                        <strong>CNPJ</strong>
                        <br /><br />
                    </td>
                </tr>
            </tbody>
        </table>
<%
		if cont = 3 then
%>
			<div style="page-break-before: always;"></div>
<%
			cont = 0 
		end if

        primeiro = 0
        objrs.movenext
    wend
%>
    <!-- jQuery 3 -->
    <script src="../assets/bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.3.7 -->
    <script src="../assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
</body>
</html>
<%
	closedb()
%>