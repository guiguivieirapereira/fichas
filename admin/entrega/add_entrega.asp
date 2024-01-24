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
	id_pessoa = recebe("id_pessoa")
	id_motoqueiro = recebe("id_motoqueiro")

	call obrigatorio("motoqueiro", id_motoqueiro)

	if len(id_pessoa) = 0 then
		erro = 1
		msg = msg&"Selecione pelo menos uma ficha para fazer a entrega!\n"
	end if

    if erro = 0 then
        objConn.execute("insert into "&prefixo&"entrega(id_motoqueiro, datahora) values('"&id_motoqueiro&"', now())")
		set objrs = objCOnn.execute("select id from "&prefixo&"entrega where id_motoqueiro = '"&id_motoqueiro&"' and data_entrega is null and ativo = 1 order by id desc")
		if not objrs.eof then
            objConn.execute("insert into "&prefixo&"entrega_pessoa(id_entrega, id_pessoa) select '"&objrs("id")&"', id from "&prefixo&"pessoa where id in("&id_pessoa&")")
            objConn.execute("update "&prefixo&"pessoa set dt_envio = now() where id in("&id_pessoa&")")
%>
	        <script type="text/javascript">
                {
					alert('Entrega cadastrada com sucesso!');
                    parent.location.href = 'entrega.asp?id=<%=objrs("id")%>';
                }
            </script>
<%
		else
%>
	        <script type="text/javascript">
                {
                    alert('Erro ao buscar dados do cadastro!');
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