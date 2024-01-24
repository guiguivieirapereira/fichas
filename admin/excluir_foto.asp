<!--#include file="conexao.asp"-->
<%
	opendb()

	id = recebe("id")

	objConn.execute("delete from "&prefixo&"foto where id = '"&id&"'")

	closedb()
%>
	<script type="text/javascript">
        {
            alert('Foto excluída com sucesso!');
			parent.location.reload();
        }
    </script>