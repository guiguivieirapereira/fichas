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
	nome = recebe("nome")
	login = recebe("login")
	email = recebe("email")
	senha = recebe("senha")
	csenha = recebe("csenha")

	call obrigatorio("nome", nome)
	call obrigatorio("login", login)
	'call obrigatorio("e-mail", email)
	call obrigatorio("senha", senha)
	
	if senha <> csenha then
		msg = msg&"A confirmação da senha é inválida!\n"
		erro = 1
	end if

	strq = "select * from "&prefixo&"usuario where login = '"&login&"' and ativo = 1"
	if len(id) > 0 then
		strq = strq &" and id <> "&id
	end if
	set objrsValida = objConn.execute(strq)
	if not objrsValida.eof then
		msg = msg&"Este login já se encontra cadastrado para outro usuário!\n"
		erro = 1
	end if

	strq = "select * from "&prefixo&"usuario where email = '"&email&"' and ativo = 1"
	if len(id) > 0 then
		strq = strq &" and id <> "&id
	end if
	set objrsValida = objConn.execute(strq)
	if not objrsValida.eof then
		msg = msg&"Este e-mail já se encontra cadastrado para outro usuário!\n"
		erro = 1
	end if

	if erro = 0 then
		if len(id) > 0 then
			objConn.execute("update "&prefixo&"usuario set nome='"&nome&"', login='"&login&"', email='"&email&"', senha='"&senha&"' where id = "&id&"")
%>
	        <script type="text/javascript">
				{
					alert('Usuário alterado com sucesso!');
					parent.location.href = 'cad_usuario.asp?id=<%=id%>';
				}
			</script>
<%
		else
			objConn.execute("insert into "&prefixo&"usuario(nome, login, email, senha) values('"&nome&"', '"&login&"', '"&email&"', '"&senha&"')")
			set objrs = objCOnn.execute("select id from "&prefixo&"usuario where login = '"&login&"' and ativo = 1 order by id desc")
			if objrs.eof then
%>
	            <script type="text/javascript">
                    {
                        alert('Erro ao buscar dados do cadastro!');
                    }
                </script>
<%
			else
%>
	            <script type="text/javascript">
                    {
						alert('Usuário cadastrado com sucesso!');
						parent.location.href = 'cad_usuario.asp?id=<%=objrs("id")%>';
                    }
                </script>
<%
			end if
		end if
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