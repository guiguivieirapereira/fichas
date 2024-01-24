<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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

    erro = 0
    msg = ""
	id_entrega = recebe("id_entrega")
	id_pessoa = recebe("id_pessoa")

	if len(id_pessoa) = 0 then
		erro = 1
		msg = msg&"Selecione pelo menos uma ficha para marcar como entregue!\n"
	end if

    if erro = 0 then
        pessoas = split(id_pessoa, ", ")

        for i = 0 to ubound(pessoas)
            objConn.execute("update "&prefixo&"entrega_pessoa set entregue = 1, data_entrega = now() where id_entrega = '"&id_entrega&"' and id_pessoa = '"&pessoas(i)&"'")
            objConn.execute("update "&prefixo&"pessoa set dt_entrega = now() where id = '"&pessoas(i)&"'")
        next
%>
	    <script type="text/javascript">
            {
				alert('Ficha(s) marcada(s) como entegue com sucesso!');
                parent.location.href = 'entrega.asp?id=<%=id_entrega%>';
            }
        </script>
<%
	else
%>
	    <script type="text/javascript">
            {
                alert('<%=msg%>');
            }
        </script>
<%
	end if

	closedb()
%>
</body>
</html>