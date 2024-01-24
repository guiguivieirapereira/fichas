<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>
<body>
<!--#include file="../conexao.asp"-->
<%
	opendb()

	id_usuario = recebe("id_usuario")
	id_permissao = recebe("id_permissao")

	ids = split(id_permissao, ", ")

    objConn.execute("delete from "&prefixo&"permissao_usuario where id_usuario = '"&id_usuario&"'")

	for i = 0 to ubound(ids)
		gravacao = recebe("gravacao"&ids(i))

        if len(gravacao) > 0 then
            gravacao = 1
        else
            gravacao = 0
        end if

        objConn.execute("insert into "&prefixo&"permissao_usuario(id_permissao, id_usuario, gravacao) values('"&ids(i)&"', '"&id_usuario&"', '"&gravacao&"')")
	next

	closedb()
%>
	<script type="text/javascript">
        {
            alert('Permissões do usuário alteradas com sucesso!');
            //parent.location.href = 'cad_permissao.asp?id=<%=id_usuario%>';
        }
	</script>
</body>
</html>