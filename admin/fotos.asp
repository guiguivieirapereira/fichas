<!--#include file="conexao.asp"-->
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="iso-8859-1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title></title>
        <!-- Bootstrap -->
        <link href="<%=pasta%>assets/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
        <!-- Custom Theme Style -->
        <link href="<%=pasta%>assets/css/custom.css" rel="stylesheet">
		<script type="text/javascript">
            function submete(a)
            {
                document.f.action = a;
                document.f.submit();
            }
        </script>
        <style>
			body {
				background-color: #fff;
			}
		</style>
    </head>
    <body>
        <div class="col-md-12">
    <%
        opendb()

        galeria = recebe("galeria")
        codigo = recebe("id")
        set objrs = objConn.execute("select id, foto, titulo from "&prefixo&"foto where id_galeria = '"&galeria&"' and codigo = '"&codigo&"' order by id")
        if not objrs.eof then
    %>
            <form class="form-horizontal" action="" method="post" name="f">
                <input type="hidden" name="galeria" value="<%=galeria%>">
                <input type="hidden" name="codigo" value="<%=codigo%>">
                <div class="form-group">
    <%
                quebra = 1
                i = 0
                while not objrs.eof
                    id = objrs("id")
                    foto = objrs("foto")
                    titulo = objrs("titulo")
                    if quebra = 5 then
                        response.write "</div><div class='form-group'>"
                        quebra = 1
                    end if
    %>
                    <div class="col-xs-6 col-sm-3 col-lg-3">
                        <input type="hidden" name="id<%=i%>" value="<%=id%>">
                        <div class="text-center">
                            <input type="checkbox" name="excluir<%=i%>" value="<%=id%>">
                        </div>
                        <img class="img-responsive center-block" src="<%=dominio&foto%>" style="max-height:100px; padding-bottom:10px;">
                        <input type="text" class="form-control" maxlength="100" name="titulo<%=i%>" value="<%=titulo%>" placeholder="Título">
                        <input type="text" class="form-control" maxlength="100" name="link<%=i%>" placeholder="Link" value="<%=dominio&foto%>" style="margin-top:5px;">
                    </div>
    <%
                    quebra = quebra + 1
                    i = i + 1
                    objrs.movenext
                wend
    %>
                </div>
                <div class="text-center">
                    <button type="button" class="btn btn-dark" onclick="submete('cad_titulo.asp')">Salvar títulos</button>&nbsp;&nbsp;&nbsp;
                    <button type="button" class="btn btn-dark" onclick="submete('excluir_fotos.asp')">Excluir selecionadas</button>
                </div>
                <input type="hidden" name="quant" value="<%=i%>">
            </form>
    <%
        else
            response.write  "<BR>Nenhuma foto foi encontrada!"
        end if

		closedb()
    %>
        </div>
    </body>
</html>