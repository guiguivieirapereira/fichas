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
	nivel = recebe("nivel")
	nome = recebe("nome")
	cep = recebe("cep")
	rua = recebe("rua")
	numero = recebe("numero")
	complemento = recebe("complemento")
	bairro = recebe("bairro")
	cidade = recebe("cidade")
	estado = recebe("estado")
    num_fichas = recebe("num_fichas")
    num_fichas_ant = recebe("num_fichas_ant")
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
	senha = recebe("senha")
	csenha = recebe("csenha")

	call obrigatorio("nome", nome)
	call obrigatorio("cep", cep)
	call obrigatorio("rua", rua)
	call obrigatorio("número", numero)
	call obrigatorio("bairro", bairro)
	call obrigatorio("cidade", cidade)
	call obrigatorio("estado", estado)
	call obrigatorio("zona", zona)
	call obrigatorio("secao", secao)

    if not isnumeric(num_fichas) then
        num_fichas = 0
    end if

	if len(nome) > 0 and len(cep) > 0 and len(rua) > 0 and len(numero) > 0 and len(bairro) > 0 and len(cidade) > 0 and len(estado) > 0 then
	    strq = "select * from "&prefixo&"pessoa where nome = '"&nome&"' and cep = '"&cep&"' and rua = '"&rua&"' and numero = '"&numero&"' and bairro = '"&bairro&"' and "&_
               " cidade = '"&cidade&"' and estado = '"&estado&"' and ativo = 1 "
	    if len(id) > 0 then
		    strq = strq &" and id <> '"&id&"'"
	    end if
	    set objrs = objCOnn.execute(strq)
	    if not objrs.eof then
		    erro = 1
		    msg = msg&"Uma ficha já foi cadastrada com esse nome e endereço!\n"
	    end if
	end if

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
	    strq = "select * from "&prefixo&"pessoa where nome = '"&email&"' and zona = '"&zona&"' and secao = '"&secao&"' and ativo = 1 "
	    if len(id) > 0 then
		    strq = strq &" and id <> '"&id&"'"
	    end if
	    set objrs = objCOnn.execute(strq)
	    if not objrs.eof then
		    erro = 1
		    msg = msg&"Uma ficha com esse nome, zona e seção já se encontra cadastrada!\n"
	    end if
	end if

	if len(senha) > 0 then
		if len(senha) < 3 then
			erro = 1
			msg = msg&"A senha deve ter no mínimo 3 caracteres!\n"
		elseif senha <> csenha then
			erro = 1
			msg = msg&"A confirmação da senha está incorreta!\n"
		end if
	end if

    if erro = 0 then
		if len(id) > 0 then
			strq = "update "&prefixo&"pessoa set nome='"&nome&"', cep='"&cep&"', rua='"&rua&"', numero='"&numero&"', complemento='"&complemento&"', bairro='"&bairro&"', "&_
                   " cidade='"&cidade&"', estado='"&estado&"', num_fichas='"&num_fichas&"', zona='"&zona&"', secao='"&secao&"', telefone1='"&telefone1&"', "&_
                   " telefone2='"&telefone2&"', email='"&email&"', citru='"&citru&"', banner='"&banner&"', material='"&material&"', reuniao='"&reuniao&"', "&_
                   " observacao='"&observacao&"', senha='"&senha&"' where id = "&id&""
            objConn.execute(strq)

            if len(num_fichas) > 0 then
                if cint(num_fichas) <> cint(num_fichas_ant) then
                    for i = cint(num_fichas_ant) + 1 to cint(num_fichas)
                        objConn.execute("insert into "&prefixo&"pessoa(id_indicacao, nivel, num, datahora) values('"&id&"', "&nivel&" + 1, '"&i&"', now())")
                    next
                end if
            end if
%>
	        <script type="text/javascript">
				{
					alert('Ficha alterada com sucesso!');
					parent.location.href = 'cad_pessoa.asp?id=<%=id%>&atribui=<%=recebe("atribui")%>';
				}
			</script>
<%
		else
            strq = "insert into "&prefixo&"pessoa(id_indicacao, nivel, nome, cep, rua, numero, complemento, bairro, cidade, estado, num_fichas, zona, secao, telefone1, telefone2, "&_
                   " email, citru, banner, material, reuniao, observacao, senha, datahora) values('"&session("id_pessoa")&"', "&session("nivel_pessoa")&" + 1, '"&nome&"', '"&cep&"', '"&rua&"', '"&numero&"', "&_
                   " '"&complemento&"', '"&bairro&"', '"&cidade&"', '"&estado&"', '"&num_fichas&"', '"&zona&"', '"&secao&"', '"&telefone1&"', '"&telefone2&"', '"&email&"', "&_
                   " '"&citru&"', '"&banner&"', '"&material&"', '"&reuniao&"', '"&observacao&"', '"&senha&"', now())"
			objConn.execute(strq)
			set objrs = objCOnn.execute("select id, nivel from "&prefixo&"pessoa where nome = '"&nome&"' and email = '"&email&"' and ativo = 1 order by id desc")
			if not objrs.eof then
                for i = 1 to num_fichas
                    objConn.execute("insert into "&prefixo&"pessoa(id_indicacao, nivel, num, datahora) values('"&objrs("id")&"', "&nivel&" + 1, '"&i&"', now())")
                next
%>
	            <script type="text/javascript">
                    {
						alert('Ficha cadastrada com sucesso!');
                        parent.location.href = 'cad_pessoa.asp?id=<%=objrs("id")%>&atribui=<%=recebe("atribui")%>';
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