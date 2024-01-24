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
            border-top: 2px dashed #000;
        }
    </style>
</head>
<body>
<%
    opendb()

    id = recebe("id")

	set objrs = objConn.execute("select p.*, i.nome as indicacao from "&prefixo&"pessoa p left outer join "&prefixo&"pessoa i on i.id = p.id_indicacao where p.id = '"&id&"'")
    if not objrs.eof then
%>
        <table class="table table-bordered ficha">
            <tbody>
                <tr>
                    <th class="text-center">LEI ELEITORAL: 9504/97 RESOLUÇÃO Nª 23.610/2019</th>
                    <th class="text-center" style="font-size:16px;">Gegê Marreco</th>
                    <th class="text-center">Nº 14789</th>
                    <th class="text-center">PTB</th>
                </tr>
            </tbody>
        </table>
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th style="width:100px; border-top:0;">Indicação</th>
                    <td colspan="5" style="border-top:0;">
                        <strong>Código <%=objrs("id_indicacao")%>:</strong> <%=objrs("indicacao")%>
                    </td>
                </tr>
                <tr>
                    <th style="width:100px;">Indicado</th>
                    <td colspan="5">
                        <strong>Código <%=objrs("id")%>:</strong> <%=objrs("nome")%>
                    </td>
                </tr>
                <tr>
                    <th rowspan="2" style="width:100px;">Endereço</th>
                    <td colspan="2">
                        <strong>Rua:</strong> <%=objrs("rua")%>
                    </td>
                    <td style="width:100px;">
                        <strong>Nº:</strong> <%=objrs("numero")%>
                    </td>
                    <td colspan="2">
                        <strong>Bairro:</strong> <%=objrs("bairro")%>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <strong>Cidade:</strong> <%=objrs("cidade")%>
                    </td>
                </tr>
                <tr>
                    <th style="width:100px;">Nº fichas</th>
                    <td style="width:100px;"><%=objrs("num_fichas")%></td>
                    <td>
                        <strong>Zona</strong>
                    </td>
                    <td><%=objrs("zona")%></td>
                    <td>
                        <strong>Seção</strong>
                    </td>
                    <td><%=objrs("secao")%></td>
                </tr>
                <tr>
                    <th style="width:100px;">Telefone 1</th>
                    <td colspan="2"><%=objrs("telefone1")%></td>
                    <td>
                        <strong>Telefone 2</strong>
                    </td>
                    <td colspan="2"><%=objrs("telefone2")%></td>
                </tr>
                <tr>
                    <th style="width:100px;">E-mail</th>
                    <td colspan="5"><%=objrs("email")%></td>
                </tr>
            </tbody>
        </table>
        <table class="table table-bordered" style="margin-bottom:30px">
            <tbody>
                <tr>
                    <td colspan="5" class="text-center"><strong>AUTORIZAÇÃO</strong></td>
                </tr>
                <tr>
                    <th colspan="5" class="text-center" style="border-top:0;">ORDEM DE SERVIÇO</th>
                </tr>
                <tr>
                    <th>Citru</th>
                    <th>Banner</th>
                    <th>Material</th>
                    <th>Reunião</th>
                    <th rowspan="2" style="width:400px;">
                        OBS<br />
                        <%=objrs("observacao")%>
                    </th>
                </tr>
                <tr>
                    <td class="text-center"><% if objrs("citru") = "1" then : response.write "X" : else : response.write "&nbsp;" : end if %></td>
                    <td class="text-center"><% if objrs("banner") = "1" then : response.write "X" : else : response.write "&nbsp;" : end if %></td>
                    <td class="text-center"><% if objrs("material") = "1" then : response.write "X" : else : response.write "&nbsp;" : end if %></td>
                    <td class="text-center"><% if objrs("reuniao") = "1" then : response.write "X" : else : response.write "&nbsp;" : end if %></td>
                </tr>
                <tr>
                    <td colspan="5"><strong>Assinatura</strong></td>
                </tr>
            </tbody>
        </table>
<%
    end if
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