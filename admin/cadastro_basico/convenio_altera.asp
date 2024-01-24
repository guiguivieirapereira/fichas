<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title></title>
</head>
<body>
<!--#include file="../conexao.asp"-->
<%
	opendb()

	erro = 0
    msg = ""
	id = recebe("id")
	nome = recebe("nome")
	tabela = recebe("tabela")
	titulo = recebe("titulo")

	ids = split(id, ", ")
	msg1 = ""
	msg2 = ""
	for i = 0 to ubound(ids)
		nome = recebe("nome"&ids(i))
		if len(nome) = 0 then
			erro = 1
			msg2 = "Preencha todos os campos nome!\n"
		end if
	next

    if erro = 0 then
		for i = 0 to ubound(ids)
			nome = recebe("nome"&ids(i))
	        set objrs = objconn.execute("select * from "&prefixo&tabela&" where nome = '"&nome&"' and ativo = 1 and id <> '"&ids(i)&"'")
	        if objrs.eof then
		        objConn.execute("update "&prefixo&tabela&" set nome = '"&nome&"' where id = "&ids(i)&"")
            end if
		next
%>
		<script type="text/javascript">
            {
                alert('Alteração efetuada com sucesso!');
                //parent.location.href = 'convenio1.asp?tabela=<%=tabela%>&titulo=<%=titulo%>';
            }
        </script>
<%
	else
%>
		<script type="text/javascript">
            {
                alert('<%=msg&msg1&msg2%>');
            }
        </script>
<%
	end if

    closedb()
%>
</body>
</html>