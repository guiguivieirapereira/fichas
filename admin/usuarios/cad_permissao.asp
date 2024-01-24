<!--#include file="../conexao.asp"-->
<%
	pasta = "../"
	opcaomenu = "usuarios"
	opendb()
%>
<!--#include file="../topo.asp"-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Usuários</h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">Cadastro de permissão</h3>
                        </div>
                        <!-- /.box-header -->
                    <%
	                    id = recebe("id")

	                    if len(id) = 0 then
                            response.write "<p>Erro ao receber parametros!</p>"
	                    else
		                    set objrs = objConn.execute("select * from "&prefixo&"usuario where id = "&id&"")
		                    if not objrs.eof then
                    %>
                                <form method="post" action="cad_permissao2.asp" target="cadastro">
                                    <div class="box-body">
                                        <p><label>Usuário:</label> <%=objrs("nome")%></p>
                                        <div class="row">
                                            <div class="col-md-12 form-group">
                                                <input type="hidden" name="id_usuario" value="<%=id%>">
                                                <p><label>Permissões</label></p>
                                            <%
                                                strq = "select p.*, ifnull(pu.id_permissao, 0) as leitura, ifnull(pu.gravacao, 2) as gravacao from "&prefixo&"permissao p left join (select * from "&_
                                                       " "&prefixo&"permissao_usuario where id_usuario = '"&id&"' or id_usuario is null) as pu on pu.id_permissao = p.id order by p.nome"
                                                set objrs = objConn.execute(strq)
                                                while not objrs.eof
                                                    checkedL = ""
                                                    checkedG = ""
                                                    if objrs("leitura") > "0" then
                                                        checkedL = "checked"
                                                    end if

                                                    if objrs("gravacao") = "1" then
                                                        checkedG = "checked"
                                                    end if
                                            %>
                                                    <div class="clearfix" style="padding-bottom:10px;">
                                                        <label><%=objrs("nome")%></label>
                                                        <div class="clearfix"></div>
                                                    <% if objrs("tipo") = 1 then %>
                                                        <label class="checkbox-inline">
                                                            <input type="checkbox" class="p_leitura" name="id_permissao" data-id="<%=objrs("id")%>" value="<%=objrs("id")%>" <%=checkedL%>> Leitura
                                                        </label>
                                                        <label class="checkbox-inline">
                                                            <input type="checkbox" class="p_gravacao" name="gravacao<%=objrs("id")%>" data-id="<%=objrs("id")%>" value="1" <%=checkedG%>> Gravação
                                                        </label>
                                                    <% else %>
                                                        <label class="checkbox-inline">
                                                            <input type="checkbox" name="id_permissao" data-id="<%=objrs("id")%>" value="<%=objrs("id")%>" <%=checkedL%>> Permitir
                                                        </label>
                                                    <% end if %>
                                                    </div>
                                            <%
                                                    objrs.movenext
                                                wend
                                            %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-footer">
                                        <button type="submit" class="btn btn-primary">Alterar permissões</button>
                                    </div>
                                </form>
                    <%
		                    else
			                    response.write "<p>Erro ao buscar dados do usuário!</p>"
		                    end if
	                    end if
                    %>
                    </div>
                    <!-- /.box -->
                </div>
            <!-- /.col -->
            </div>
        <!-- /.row -->
            <div class="row">
                <iframe class="col-md-10" name="cadastro" src="about:blank" frameborder="0" height="100" scrolling="no"></iframe>
            </div>
        </section>
    <!-- /.content -->
    </div>
<!--#include file="../rodape.asp"-->
<script type="text/javascript">
    $('.p_leitura').click(function () {
        var id = $(this).attr('data-id');

        if ($(this).prop('checked') == false) {
            $('.p_gravacao[data-id="' + id + '"]').prop('checked', false);
        }
    })

    $('.p_gravacao').click(function () {
        var id = $(this).attr('data-id');

        if ($(this).prop('checked') == true) {
            $('.p_leitura[data-id="' + id + '"]').prop('checked', true);
        }
    })
</script>
<%
	closedb()
%>