<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title></title>
</head>
<body>
<%
	login = "1"
%>
<!--#include file="conexao.asp"-->
<%
	opendb()

	email = recebe("email")
	senha = recebe("senha")

	if len(email) = 0 or isnull(email) then
%>
		<script type="text/javascript">
            {
                alert('É necessário informar o e-mail!');
            }
        </script>
<%
		response.end
	end if

	if len(senha) = 0 or isnull(senha) then
%>
		<script type="text/javascript">
            {
                alert('É necessário informar a senha!');
            }
        </script>
<%
		response.end
	end if

	set objrs = objConn.execute("select * from "&prefixo&"pessoa where email = '"&email&"' and senha = '"&senha&"' and ativo = 1 and length(email) > 0 and length(senha) > 0")
	if not objrs.eof then
		session("id_pessoa") = objrs("id")
		session("nome_pessoa") = objrs("nome")
        session("nivel_pessoa") = objrs("nivel")
%>
		<script type="text/javascript">
			{
				parent.location.href = 'home.asp';	
			}
		</script>
<%
	else
%>
		<script type="text/javascript">
            {
                alert('E-mail ou senha inválidos!');
            }
        </script>
<%
	end if

	closedb()
%>
</body>
</html>