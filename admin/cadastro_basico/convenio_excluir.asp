<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> </title>
</head>
<body>
<!--#include file="../conexao.asp"-->
<%
	opendb()

	id_convenio = recebe("id_tabela")
	tabela = recebe("tabela")
	titulo = recebe("titulo")

	if len(id_convenio) > 0 then
		objConn.execute("update "&prefixo&tabela&" set ativo = 0 where id = "&id_convenio&"")
%>
		<script type="text/javascript">
			{
				alert('Exclusão efetuada com sucesso!');
				parent.location.reload();
			}
		</script>
<%
	end if

    closedb()
%>
</body>
</html>