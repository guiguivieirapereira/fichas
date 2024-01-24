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

	login = recebe("login")
	senha = recebe("senha")

	if len(login) = 0 or isnull(login) then
%>
		<script type="text/javascript">
            {
                alert('É necessário informar o login!');
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

	set objrs = objConn.execute("select * from "&prefixo&"usuario where login = '"&replace(login,"'","''")&"' and senha = '"&replace(senha,"'","''")&"' and ativo = 1")
	if not objrs.eof then
		session("idusuario") = objrs("id")
		session("loginusuario") = login
		session("nomeusuario") = objrs("nome")
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
                alert('Login ou senha inválidos!');
            }
        </script>
<%
	end if

	closedb()
%>
</body>
</html>