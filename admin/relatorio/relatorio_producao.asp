<!--#include file="../conexao.asp"-->
<%
	pasta = "../"
    opcaomenu = "relatorio"
    opcaosubmenu = "rel_producao"
	opendb()
%>
<!--#include file="../topo.asp"-->
	<script type="text/javascript">
        function relatorio() {
            //if (document.frm.id_pessoa.value.length > 0) {
                window.open('relatorio_producao2.asp?id_pessoa=' + document.frm.id_pessoa.value + '&data_inicial=' + document.frm.data_inicial.value + '&data_final=' + document.frm.data_final.value, 'rel_producao', 'width=900, height=600');
            //} else {
            //    alert('Selecione uma ficha!');
            //}
        }
    </script>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Relatórios</h1>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">Relatório de produção</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <form class="row" name="frm">
                                <div class="col-md-3 form-group">
                    	            <label>Ficha</label>
                                    <input type="text" name="pessoa" class="form-control input-sm" readonly <%=r%> style="background-color:#fff; cursor:default;" onclick="window.open('../pessoa/con_pessoa.asp?atribui=1', 'pessoa', 'width=1024, height=768, scrollbars=yes')" />
                                    <input type="hidden" name="id_pessoa" />
                                </div>
                                <div class="col-md-2 form-group">
                                    <label>Data inicial</label>
                                    <input type="text" class="form-control input-sm data" name="data_inicial" data-inputmask="'mask': '99/99/9999'" required>
                                </div>
                                <div class="col-md-2 form-group">
                                    <label>Data final</label>
                                    <input type="text" class="form-control input-sm data" name="data_final" data-inputmask="'mask': '99/99/9999'" required>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="relatorio()">Gerar relatório</button>
                                </div>
                            </form>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            <!-- /.col -->
            </div>
        <!-- /.row -->
        </section>
    <!-- /.content -->
    </div>
    <script type="text/javascript">
        function selPessoa(nome, id) {
            document.frm.pessoa.value = nome;
            document.frm.id_pessoa.value = id;
        }
    </script>
<!--#include file="../rodape.asp"-->
<%
	closedb()
%>