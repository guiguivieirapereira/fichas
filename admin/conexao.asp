<%
'response.write request.ServerVariables("SCRIPT_NAME")
'response.end
if (len(session("idusuario")) = 0 or isempty(session("idusuario"))) and login <> "1" then
%>
	<script type="text/javascript">
		{
			alert('Você não está logado corretamente');
            parent.location.href = 'http://uniaofazaficha.com.br/admin/';
		}
	</script>
<%
	response.End()
end if

dim objCOnn,objCOnn2, erro, msg
erro = 0
msg = ""
prefixo = ""
pastaupload = Request.ServerVariables("APPL_PHYSICAL_PATH")
dominio = "http://uniaofazaficha.com.br/"

Session.LCID = 1046

sub opendb()
	if not(isobject(objConn)) then
		Set objConn = Server.createobject("adodb.connection")
		strConnection="DRIVER={MySQL ODBC 3.51 Driver};SERVER=localhost;PORT=3306;DATABASE=sitefox_uniao;USER=sitefox_uniao;PASSWORD=;OPTION=3;"
		objCOnn.open strConnection
	end if
end sub

sub closedb()
	if isobject(objConn) then
		objConn.close
		set objConn = nothing
	end if
end sub

function recebe(var)
	recebe = replace(trim(request(var)),"'","''")
end function

sub obrigatorio(nome, valor)
	if len(valor) = 0 or isnull(valor) then
		erro = 1
		msg = msg &"O campo "&nome&" é obrigatório!\n"
		'response.write msg&"<BR><BR>"
	end if
end sub

sub validanumero(nome, valor)
    if len(valor) > 0 and not isnumeric(valor) then
        erro = 1
        msg = msg &"O campo "&nome&" deve ser numérico!\n"
        'response.write msg&"<BR><BR>"
    end if
end sub

function retiraletra(var)
	if len(var) > 0 and not isnull(var) then
			temp = ""
			for i=1 to len(var)
				if isnumeric(left(var,1)) then
					temp = temp&left(var,1)
				end if
				var = right(var, len(var)-1)
			next
			var = temp
		else
			var = ""
		end if
		retiraletra = var
end function

function permissao(id)
    set objrsPer = objConn.execute("select * from "&prefixo&"permissao_usuario where id_usuario = "&session("idusuario")&" and id_permissao = "&id)
	if objrsPer.eof then
		permissao = false
        pgravacao = 0
	else
		permissao = true
        pgravacao = objrsPer("gravacao")
	end if
end function

function acento(palavra)
	if len(palavra) > 0 and not(isnull(palavra)) then
		palavra = replace(lcase(palavra),"á","a")
		palavra = replace(lcase(palavra),"à","a")
		palavra = replace(lcase(palavra),"ã","a")
		palavra = replace(lcase(palavra),"â","a")
		palavra = replace(lcase(palavra),"é","e")
		palavra = replace(lcase(palavra),"è","e")
		palavra = replace(lcase(palavra),"ê","e")
		palavra = replace(lcase(palavra),"í","i")
		palavra = replace(lcase(palavra),"ì","i")
		palavra = replace(lcase(palavra),"î","i")
		palavra = replace(lcase(palavra),"ó","o")
		palavra = replace(lcase(palavra),"ò","o")
		palavra = replace(lcase(palavra),"ô","o")
		palavra = replace(lcase(palavra),"õ","o")
		palavra = replace(lcase(palavra),"ú","u")
		palavra = replace(lcase(palavra),"ù","u")
		palavra = replace(lcase(palavra),"û","u")
		palavra = replace(lcase(palavra),"ç","c")
	end if
	acento = palavra
end function

sub add_historico(id_tabela, codigo, campo, antigo, novo)
	campo = replace(campo, "'","")
	antigo = replace(antigo, "'","")
	novo = replace(novo, "'","")
	strq = "insert into historico(id_tabela, codigo, campo, antes, depois, data, id_usuario) values ('"&id_tabela&"', '"&codigo&"', '"&campo&"', '"&antigo&"', "&_
		   " '"&novo&"', getdate(), '"&session("idusuario")&"')"
	'response.write strq
	'response.End()
	objConn.execute(strq)
end sub

sub historico_alteracao(tabela, codigo, tipo, campo, de, para)
	objConn.execute("insert into "&prefixo&"historico_alteracao(id_usuario, tabela, codigo, tipo, campo, de, para, datahora) values('"&session("idusuario")&"', '"&tabela&"', '"&codigo&"', '"&tipo&"', '"&campo&"', '"&de&"', '"&para&"', getdate())")
end sub

sub mostra_historico_alteracao(tabela, codigo)
	strq = "select h.*, u.nome, t.nome as tipo from "&prefixo&"historico_alteracao h join "&prefixo&"usuario u on u.id = h.id_usuario join "&prefixo&"historico_tipo t on t.id = h.tipo where h.tabela = '"&tabela&"' "
	if len(codigo) > 0 then
		strq = strq&" and h.codigo = '"&codigo&"'"
	end if
	strq = strq&" order by h.datahora"
    set objrsH = objConn.execute(strq)
    if not objrsH.eof then
%>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr class="active">
                        <th>Datahora</th>
                        <th>Usu&aacute;rio</th>
                        <th>Tipo</th>
                        <th>Campo</th>
                        <th>De</th>
                        <th>Para</th>
                    </tr>
                </thead>
                <tbody>
            <%
                while not objrsH.eof
					campo = objrsH("campo")
					if tabela = "consulta" then
						if objrsH("tipo_hist") = 2 then
							n = ""
							if objrsH("campo") = 1 then
								n = 2
							elseif objrsH("campo") = 2 then
								n = 7
							elseif objrsH("campo") = 2 then
								n = 14
							end if
							campo = "Lembrete de "&n&" dias"
						end if
					end if
            %>
                    <tr>
                        <td style="vertical-align:inherit;"><%=objrsH("datahora")%></td>
                        <td style="vertical-align:inherit;"><%=objrsH("nome")%></td>
                        <td style="vertical-align:inherit;"><%=objrsH("tipo")%></td>
                        <td style="vertical-align:inherit;"><%=campo%></td>
                        <td style="vertical-align:inherit;"><%=objrsH("de")%></td>
                        <td style="vertical-align:inherit;"><%=objrsH("para")%></td>
                    </tr>
            <%
                    objrsH.movenext
                wend
            %>
                </tbody>
            </table>
        </div>
<%
    end if
end sub

sub historico(tabela, codigo, tipo)
	objConn.execute("insert into "&prefixo&"historico(id_usuario, tabela, codigo, tipo, datahora) values('"&session("idusuario")&"', '"&tabela&"', '"&codigo&"', '"&tipo&"', getdate())")
end sub

sub mostra_historico(tabela, codigo, tipo)
    strq = "select h.datahora, u.nome, ht.nome as tipo from "&prefixo&"historico h join "&prefixo&"historico_tipo ht on ht.id = h.tipo join "&prefixo&"usuario u on u.id = h.id_usuario where "&_
           " h.tabela = '"&tabela&"' "
    if len(codigo) > 0 then
        strq = strq&" and h.codigo = '"&codigo&"'"
    end if
    if len(tipo) > 0 then
        strq = strq&" and h.tipo in("&tipo&")"
    end if
    strq = strq&" order by h.datahora"
    set objrsH = objConn.execute(strq)
    if not objrsH.eof then
%>
        <div class="col-md-6 col-sm-6 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Controle de acesso</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                        <!--<li><a class="close-link"><i class="fa fa-close"></i></a></li>-->
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <div class="row">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="active">
                                        <th>Datahora</th>
                                        <th>Usuário</th>
                                        <th>Tipo</th>
                                    </tr>
                                </thead>
                                <tbody>
                            <%
                                while not objrsH.eof
                            %>
                                    <tr>
                                        <td style="vertical-align:inherit;"><%=objrsH("datahora")%></td>
                                        <td style="vertical-align:inherit;"><%=objrsH("nome")%></td>
                                        <td style="vertical-align:inherit;"><%=objrsH("tipo")%></td>
                                    </tr>
                            <%
                                    objrsH.movenext
                                wend
                            %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<%
    end if
end sub

function validaCPF(cpf)
    if len(cpf) = 11 then
	    Dim Numero1(11)
	    RecebeCPF = cpf
	    s = ""
	    for x = 1 to len(RecebeCPF)
		    ch = mid(RecebeCPF, x, 1)
		    if asc(ch) >= 48 and asc(ch) <= 57 then
			    s = s&ch
		    end if
	    next
	    RecebeCPF = s

	    if len(RecebeCPF) <> 11 then
		    erro = 1
		    msg = msg&"CPF inválido!\n"
	    elseif RecebeCPF = "00000000000" or RecebeCPF = "11111111111" then
		    erro = 1
		    msg = msg&"CPF inválido!\n"
	    else
		    Numero1(1) = Cint(Mid(RecebeCPF,1,1))
		    Numero1(2) = Cint(Mid(RecebeCPF,2,1))
		    Numero1(3) = Cint(Mid(RecebeCPF,3,1))
		    Numero1(4) = Cint(Mid(RecebeCPF,4,1))
		    Numero1(5) = Cint(Mid(RecebeCPF,5,1))
		    Numero1(6) = CInt(Mid(RecebeCPF,6,1))
		    Numero1(7) = Cint(Mid(RecebeCPF,7,1))
		    Numero1(8) = Cint(Mid(RecebeCPF,8,1))
		    Numero1(9) = Cint(Mid(RecebeCPF,9,1))
		    Numero1(10) = Cint(Mid(RecebeCPF,10,1))
		    Numero1(11) = Cint(Mid(RecebeCPF,11,1))

		    soma = 10 * Numero1(1) + 9 * Numero1(2) + 8 * Numero1(3) + 7 * numero1(4) + 6 * numero1(5) + 5 * numero1(6) + 4 * numero1(7) + 3 * numero1(8) + 2 * numero1(9)
		    soma = soma - (11 * (int(soma / 11)))

		    if soma = 0 or soma = 1 then
			    resultado1 = 0
		    else
			    resultado1 = 11 - soma
		    end if

		    if resultado1 = numero1(10) then
			    soma = numero1(1) * 11 + numero1(2) * 10 + numero1(3) * 9 + numero1(4) * 8 + numero1(5) * 7 + numero1(6) * 6 + numero1(7) * 5 + numero1(8) * 4 + numero1(9) * 3 + numero1(10) * 2
			    soma = soma - (11 * (int(soma / 11)))

			    if soma = 0 or soma = 1 then
				    resultado2 = 0
			    else
				    resultado2 = 11 - soma
			    end if

			    if resultado2 = numero1(11) then

			    else
				    erro = 1
				    msg = msg&"CPF inválido!\n"
			    end if
		    else
			    erro = 1
			    msg = msg&"CPF inválido!\n"
		    end if
	    end if
    else
	    erro = 1
	    msg = msg&"CPF inválido!\n"
    end if
end function
%>