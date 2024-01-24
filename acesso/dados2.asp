<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>
<body>
<!--#include file="conexao.asp"-->
<%
	opendb()

    erro = 0
    msg = ""
	id = session("id_pessoa")
	nome = recebe("nome")
	cep = recebe("cep")
	rua = recebe("rua")
	numero = recebe("numero")
	complemento = recebe("complemento")
	bairro = recebe("bairro")
	cidade = recebe("cidade")
	estado = recebe("estado")
    num_fichas = recebe("num_fichas")
    zona = recebe("zona")
    secao = recebe("secao")
	telefone1 = recebe("telefone1")
	telefone2 = recebe("telefone2")
	email = recebe("email")
	citru = recebe("citru")
	banner = recebe("banner")
	material = recebe("material")
	reuniao = recebe("reuniao")
    observacao = recebe("observacao")

	call obrigatorio("nome", nome)
	call obrigatorio("email", email)
	call obrigatorio("cep", cep)
	call obrigatorio("rua", rua)
	call obrigatorio("número", numero)
	call obrigatorio("bairro", bairro)
	call obrigatorio("cidade", cidade)
	call obrigatorio("estado", estado)
	call obrigatorio("zona", zona)
	call obrigatorio("secao", secao)

	if len(email) > 0 then
	    strq = "select * from "&prefixo&"pessoa where email = '"&email&"' and ativo = 1 "
	    if len(id) > 0 then
		    strq = strq &" and id <> '"&id&"'"
	    end if
	    set objrs = objCOnn.execute(strq)
	    if not objrs.eof then
		    erro = 1
		    msg = msg&"Este e-mail já se encontra cadastrado!\n"
	    end if
	end if

	if len(nome) > 0 and len(zona) > 0 and len(secao) > 0 then
	    set objrs = objCOnn.execute("select * from "&prefixo&"pessoa where nome = '"&email&"' and zona = '"&zona&"' and secao = '"&secao&"' and ativo = 1 and id <> '"&id&"'")
	    if not objrs.eof then
		    erro = 1
		    msg = msg&"Uma ficha com esse nome, zona e seção já se encontra cadastrada!\n"
	    end if
	end if

	if erro = 0 then
		if len(id) > 0 then
			strq = "update "&prefixo&"pessoa set nome='"&nome&"', cep='"&cep&"', rua='"&rua&"', numero='"&numero&"', complemento='"&complemento&"', bairro='"&bairro&"', "&_
                   " cidade='"&cidade&"', estado='"&estado&"', num_fichas='"&num_fichas&"', zona='"&zona&"', secao='"&secao&"', telefone1='"&telefone1&"', "&_
                   " telefone2='"&telefone2&"', email='"&email&"', citru='"&citru&"', banner='"&banner&"', material='"&material&"', reuniao='"&reuniao&"', "&_
                   " observacao='"&observacao&"' where id = "&id&""
            objConn.execute(strq)

            session("nome_pessoa") = nome
%>
	        <script type="text/javascript">
				{
					alert('Dados alterados com sucesso!');
					parent.location.href = 'dados.asp';
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