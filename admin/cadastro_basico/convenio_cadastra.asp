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
	nome = recebe("nome")
	tabela = recebe("tabela")
	titulo = recebe("titulo")

    call obrigatorio("nome", nome)

	if erro = 0 then
        set objrs = objconn.execute("select * from "&prefixo&tabela&" where nome = '"&nome&"' and ativo = 1")
        if objrs.eof then
            objConn.execute("insert into "&prefixo&tabela&"(nome) values('"&nome&"')")
%>
		    <script type="text/javascript">
                {
                    alert('<%=titulo%> cadastrado(a) com sucesso!');
                    parent.location.href = 'convenio1.asp?tabela=<%=tabela%>&titulo=<%=titulo%>';
                }
            </script>
<%
        else
%>
		    <script type="text/javascript">
                {
                    parent.frmcad.nome.focus();
                    alert('Este(a) <%=titulo%> já encontra-se cadastrado(a)!');
                }
            </script>
<%
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