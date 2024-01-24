<!--#include file="../conexao.asp"-->
<%
	opendb()

	pasta = "../"
    opcaomenu = "pessoas"
%>
<!--#include file="../topo.asp"-->
<%
	acao = "Cadastrar"
	id = recebe("id")

	if len(id) > 0 then
		set objrs = objConn.execute("select * from "&prefixo&"pessoa where id = "&id&" and id_indicacao = '"&session("id_pessoa")&"'")
		if not objrs.eof then
			acao = "Alterar"
            nivel = objrs("nivel")
			nome = objrs("nome")
			cep = objrs("cep")
			rua = objrs("rua")
			numero = objrs("numero")
			complemento = objrs("complemento")
			bairro = objrs("bairro")
			cidade = objrs("cidade")
			estado = objrs("estado")
            num_fichas = objrs("num_fichas")
            zona = objrs("zona")
            secao = objrs("secao")
			telefone1 = objrs("telefone1")
			telefone2 = objrs("telefone2")
			email = objrs("email")
			citru = objrs("citru")
			banner = objrs("banner")
			material = objrs("material")
			reuniao = objrs("reuniao")
            observacao = objrs("observacao")
			senha = objrs("senha")
        else
%>
            <script type="text/javascript">
                {
                    alert('Navegação incorreta!');
                    location.href = 'con_pessoa.asp';
                }
            </script>
<%
            response.end
		end if
	end if	
%>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper <% if len(recebe("atribui")) > 0 then : response.write "atribui" : end if %>">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Fichas</h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <!-- Custom Tabs -->
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab_1" data-toggle="tab" aria-expanded="true">Ficha</a></li>
                        <% if len(id) > 0 then %>
                            <li><a href="#tab_2" data-toggle="tab" aria-expanded="false">Indicados</a></li>
                        <% end if %>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab_1">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="">
                                            <div class="box-header with-border">
                                                <h3 class="box-title"><%=acao%> ficha</h3>
                                            </div>
                                            <!-- /.box-header -->
                                            <form action="cad_pessoa2.asp" method="post" name="frmcad" target="cadastro">
                                                <input type="hidden" name="id" value="<%=id%>">
                                                <input type="hidden" name="atribui" value="<%=recebe("atribui")%>">
                                                <div class="box-body">
                                                    <div class="row">
                                                <%
                                                    if len(id) > 0 then
                                                %>
                                                        <div class="col-md-2 form-group">
                                                            <label>Nível</label>
                                                            <input type="text" class="form-control" name="nivel" value="<%=nivel%>" readonly>
                                                        </div>
                                                <%
                                                    end if
                                                %>
                                                        <div class="col-md-3 form-group">
                                                            <label>Nome</label>
                                                            <input type="text" class="form-control" name="nome" value="<%=nome%>" maxlength="100">
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Cep</label>
                                                            <input type="text" class="form-control" name="cep" value="<%=cep%>" onchange="preencheEndereco(this.value)" maxlength="9" />
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Logradouro</label>
                                                            <input type="text" class="form-control" name="rua" id="rua" value="<%=rua%>" maxlength="100" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Número</label>
                                                            <input type="text" class="form-control" name="numero" value="<%=numero%>" />
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Complemento</label>
                                                            <input type="text" class="form-control" name="complemento" value="<%=complemento%>" maxlength="100" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Bairro</label>
                                                            <input type="text" class="form-control" name="bairro" id="bairro" value="<%=bairro%>" maxlength="50" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Estado</label>
                                                            <input type="text" class="form-control" name="estado" id="estado" value="<%=estado%>" maxlength="2" />
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Cidade</label>
                                                            <input type="text" class="form-control" name="cidade" id="cidade" value="<%=cidade%>" maxlength="50" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Número de ficas</label>
                                                            <input type="text" class="form-control" name="num_fichas" value="<%=num_fichas%>" />
                                                            <input type="hidden" name="num_fichas_ant" value="<%=num_fichas%>" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Zona</label>
                                                            <input type="text" class="form-control" name="zona" value="<%=zona%>" maxlength="10" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Seção</label>
                                                            <input type="text" class="form-control" name="secao" value="<%=secao%>" maxlength="10" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Telefones</label>
                                                            <input type="tel" class="form-control telefone" name="telefone1" value="<%=telefone1%>" maxlength="20" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>&nbsp;</label>
                                                            <input type="tel" class="form-control telefone" name="telefone2" value="<%=telefone2%>" maxlength="20" />
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>E-mail</label>
                                                            <input type="text" class="form-control" name="email" value="<%=email%>" maxlength="50" />
                                                        </div>
                                                        <div class="col-md-4 form-group">
                                                            <label>Serviços</label>
                                                            <div>
                                                                <label class="checkbox-inline">
                                                                    <input type="checkbox" name="citru" value="1" <% if citru = "1" then : response.write "checked" : end if %> /> Citru
                                                                </label>
                                                                <label class="checkbox-inline">
                                                                    <input type="checkbox" name="banner" value="1" <% if banner = "1" then : response.write "checked" : end if %> /> Banner
                                                                </label>
                                                                <label class="checkbox-inline">
                                                                    <input type="checkbox" name="material" value="1" <% if material = "1" then : response.write "checked" : end if %> /> Material
                                                                </label>
                                                                <label class="checkbox-inline">
                                                                    <input type="checkbox" name="reuniao" value="1" <% if reuniao = "1" then : response.write "checked" : end if %> /> Reunião
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Senha</label>
                                                            <input type="password" class="form-control" name="senha" value="<%=senha%>" />
                                                        </div>
                                                        <div class="col-md-2 form-group">
                                                            <label>Confirme a senha</label>
                                                            <input type="password" class="form-control" name="csenha" value="<%=senha%>" />
                                                        </div>
                                                        <div class="col-md-12 form-group">
                                                            <label>Observação</label>
                                                            <textarea class="form-control resizable_textarea" name="observacao" rows="1" style="resize:none;"><%=observacao%></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="box-footer">
                                                    <button type="submit" class="btn btn-primary"><%=acao%></button>
						                    <%
                                                if len(id) > 0 then
                                                    if len(recebe("atribui")) > 0 then
                                            %>
                                                        <button type="button" class="btn btn-primary" onclick="javascript:parent.opener.selPessoa('<%=nome%>','<%=id%>');parent.window.close()">Selecionar</button>
                                            <%
                                                    end if
                                            %>
                                                    <!--<button type="button" class="btn btn-danger" onclick="exclui()">Excluir</button>-->
						                    <%
                                                end if
                                            %>
                                                </div>
                                                <!-- /.box-body -->
                                            </form>
                                        </div>
                                        <!-- /.box -->
                                    </div>
                                <!-- /.col -->
                                </div>
                            <!-- /.row -->
                            </div>
                        <% if len(id) > 0 then %>
                            <div class="tab-pane" id="tab_2">
                                <!--#include file="indicados.asp"-->
                            </div>
                        <% end if %>
                        </div>
                    </div>
                    <!-- nav-tabs-custom -->
                </div>
            <!-- /.col -->
            </div>
        <!-- /.row -->
        <% if len(id) > 0 then %>
        <% end if %>
            <div class="row">
                <iframe class="col-md-10" name="cadastro" src="about:blank" frameborder="0" height="100" scrolling="no"></iframe>
            </div>
        </section>
    <!-- /.content -->
    </div>
<!--#include file="../rodape.asp"-->
<script type="text/javascript">
	function exclui() {
		if (confirm('Tem certeza que deseja excluir esta ficha?')) {
			cadastro.location.href = 'excluir.asp?id=<%=id%>';
		}
	}

    function preencheEndereco(cep) {
		$.ajax({
		    url: 'https://api.postmon.com.br/v1/cep/'+cep,
		    dataType: 'json',
		    success: function (data) {
                $(data).each(function (i, obj) {
                    console.log(obj);
		            $('#rua').val(obj.logradouro);
		            $('#bairro').val(obj.bairro);
		            $('#estado').val(obj.estado);
		            $('#cidade').val(obj.cidade);
		        });
		    },
		    error: function (data) {
		        $('#rua').val('');
		        $('#bairro').val('');
		        $('#estado').val('');
		        $('#cidade').val('');
		    }
		});
    }
</script>
<%
	closedb()
%>