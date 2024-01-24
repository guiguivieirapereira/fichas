<!--#include file="../conexao.asp"-->
<%
	pasta = "../"
    opcaomenu = "usuarios"
	opendb()
%>
<!--#include file="../topo.asp"-->
<%
	nome = ""
	login = ""
	senha = ""
	acao = "Cadastrar"
	id = recebe("id")
	if len(id) > 0 then
		set objrs = objConn.execute("select * from "&prefixo&"usuario where id = "&id)
		if not objrs.eof then
			acao = "Alterar"
			nome = objrs("nome")
			login = objrs("login")
			email = objrs("email")
			senha = objrs("senha")
		end if
	end if
%>
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
                            <h3 class="box-title"><%=acao%> usuário</h3>
                        </div>
                        <!-- /.box-header -->
                        <form action="cad_usuario2.asp" method="post" name="frmcad" target="cadastro">
                            <input type="hidden" name="id" value="<%=id%>">
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-3 form-group">
                                        <label>Nome</label>
                                        <input type="text" class="form-control" name="nome" value="<%=nome%>" maxlength="50" <%=r%> />
                                    </div>
                                    <div class="col-md-2 form-group">
                                        <label>Login</label>
                                        <input type="text" class="form-control" name="login" value="<%=login%>" maxlength="20" <%=r%> />
                                    </div>
                                    <div class="col-md-3 form-group">
                                        <label>E-mail</label>
                                        <input type="email" class="form-control" name="email" value="<%=email%>" maxlength="50" <%=r%> />
                                    </div>
                                    <div class="col-md-2 form-group">
                                        <label>Senha</label>
                                        <input type="password" class="form-control" name="senha" value="<%=senha%>" maxlength="20" <%=r%> />
                                    </div>
                                    <div class="col-md-2 form-group">
                                        <label>Confirme a senha</label>
                                        <input type="password" class="form-control" name="csenha" value="<%=senha%>" maxlength="20" <%=r%> />
                                    </div>
                                </div>
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary"><%=acao%></button>
							<% if len(id) > 0 then %>
                                <a href="cad_permissao.asp?id=<%=id%>" class="btn btn-primary">Gerenciar permissões</a>
                                <button type="button" class="btn btn-danger" onclick="excluir()">Excluir</button>
							<% end if %>
                            </div>
                            <!-- /.box-body -->
                        </form>
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
	function exclui() {
		if (confirm('Tem certeza que deseja excluir este usuário?')) {
			cadastro.location.href = 'excluir.asp?id=<%=id%>';
		}
	}
</script>
<%
	closedb()
%>