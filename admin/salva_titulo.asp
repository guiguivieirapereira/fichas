<!--#include file="conexao.asp"-->
<%
	opendb()

	id = recebe("id")
	titulo = recebe("titulo")

	objConn.execute("update "&prefixo&"foto set titulo = '"&titulo&"' where id = '"&id&"'")

	closedb()
%>
	<script type="text/javascript">
        {
            alert('T�tulo salvo com sucesso.');
        }
    </script>