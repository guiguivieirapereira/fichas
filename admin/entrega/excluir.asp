<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>
<body>
<!--#include file="../conexao.asp"-->
<%
	opendb()

    id = recebe("id")

	objConn.execute("update "&prefixo&"entrega set ativo = 0 where id = '"&id&"'")

    closedb()
%>
	<script type="text/javascript">
        {
			alert('Entrega excluída com sucesso!');
			parent.location.href = 'entregas.asp';
        }
    </script>
</body>
</html>