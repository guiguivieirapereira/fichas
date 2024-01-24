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
	id = recebe("id")
	data_entrega = recebe("data_entrega")

	call obrigatorio("data entrega", data_entrega)

	if len(data_entrega) = 0 then
		data_entrega = " null "
	elseif isdate(data_entrega) then
		data_entrega = " STR_TO_DATE('"&data_entrega&"','%d/%m/%Y') "
	else
		erro = 1
		msg = msg &"\nData entrega inválida!"
	end if

    if erro = 0 then
        objConn.execute("update "&prefixo&"entrega set data_entrega = "&data_entrega&" where id = '"&id&"'")
        objConn.execute("update "&prefixo&"pessoa set dt_entrega = "&data_entrega&" where id in(select id_pessoa from "&prefixo&"entrega_pessoa where id_entrega = '"&id&"')")
%>
	    <script type="text/javascript">
            {
				alert('Entrega salva com sucesso!');
                parent.location.href = 'entrega.asp?id=<%=id%>';
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