<!--#include file="../conexao.asp"-->
<%
	opendb()

	set objrs = objConn.execute("select email, login, senha from "&prefixo&"usuario where email in(select email from "&prefixo&"recuperasenha)")
    if not objrs.eof then
		htm = "Segue seu login e sua senha cadastrados no sistema de administração do seu site: <br /><br />Login: "&objrs("login")&"<br />Senha: "&objrs("senha")

		sDestinatario = objrs("email")
		sRemetente = ""
		sResponder = ""
		sAssunto = "Login e senha do sistema de administração do seu site"

		Set objCDOSYSMail1 = Server.CreateObject("CDO.Message")
		Set objCDOSYSCon1 = Server.CreateObject ("CDO.Configuration")
		objCDOSYSCon1.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
		objCDOSYSCon1.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport")= 25
		objCDOSYSCon1.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
		objCDOSYSCon1.Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
		objCDOSYSCon1.Fields.update

		Set objCDOSYSMail1.Configuration = objCDOSYSCon1

		objCDOSYSMail1.From = sRemetente
		objCDOSYSMail1.To = sDestinatario
		objCDOSYSMail1.ReplyTo = sDestinatario
		objCDOSYSMail1.Subject = sAssunto
		objCDOSYSMail1.htmlBody = htm
		objCDOSYSMail1.Send
%>
	    <script type="text/javascript">
            {
                alert('Login e senha enviados para o e-mail cadastrado!');
            }
        </script>
<%
    end if

	closedb()
%>