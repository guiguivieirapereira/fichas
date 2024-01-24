<!--#include file="conexao.asp"-->
<%
	opendb()

    senha = replace(recebe("senha"),"'","")
	nova = replace(recebe("nova"),"'","")
	cnova = replace(recebe("cnova"),"'","")

	set objrs = objConn.execute("select * from "&prefixo&"usuario where id = "&session("idusuario")&" and senha = '"&senha&"'")
	select case objrs.eof
		case objrs.eof <> objrs.bof
			if nova = cnova then
				objConn.execute("update "&prefixo&"usuario set senha = '"&nova&"' where id = "&session("idusuario"))
%>
				<script type="text/javascript">
					{
						alert('Senha alterada com sucesso!');
						parent.location.href = 'altera_senha.asp';
					}
				</script>
<%
			else
%>
				<script type="text/javascript">
					{
						alert('A confirmação da senha está incorreta!');
					}
				</script>
<%
			end if
		case else
%>
			<script type="text/javascript">
				{
					alert('Senha atual inválida!');
				}
			</script>
<%
	end select

	closedb()
%>