<!--#include file="conexao.asp"-->
<%
	opendb()

	id = recebe("id")

	objConn.execute("delete from "&prefixo&"foto where id = '"&id&"'")

	closedb()
%>
	<script type="text/javascript">
        {
            alert('Foto exclu�da com sucesso!');
			parent.location.reload();
        }
    </script>