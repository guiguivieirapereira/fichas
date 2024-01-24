<!--#include file="conexao.asp"-->
<%
	opendb()

    opcaomenu = "alterar_senha"
%>
<!--#include file="topo.asp"-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Alterar senha</h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">Alterar senha</h3>
                        </div>
                        <!-- /.box-header -->
                        <form action="altera_senha2.asp" method="post" name="frmcad" target="cadastro">
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-2 form-group">
                                        <label>Senha atual</label>
                                        <input type="password" class="form-control" name="senha" maxlength="15" required>
                                    </div>
                                    <div class="col-md-2 form-group">
                                        <label>Nova senha</label>
                                        <input type="password" class="form-control" name="nova" maxlength="15" required>
                                    </div>
                                    <div class="col-md-2 form-group">
                                        <label>Confirme a senha</label>
                                        <input type="password" class="form-control" name="cnova" maxlength="15" required>
                                    </div>
                                </div>
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">Salvar</button>
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
<!--#include file="rodape.asp"-->