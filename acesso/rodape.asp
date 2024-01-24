        <!-- Main Footer -->
        <!--<footer class="main-footer">
            <div class="pull-right hidden-xs">
                Anything you want
            </div>
            <strong>Copyright &copy; 2016 <a href="#">Company</a>.</strong> All rights reserved.
        </footer>-->
        <div class="control-sidebar-bg"></div>
        <iframe src="<%=pasta%>atualiza_sessao.asp" name="atualiza_sessao" width="0" height="0" frameborder="0"></iframe>
    </div>
    <div class="modal fade" id="modalHistorico" tabindex="-1" role="dialog" aria-labelledby="modalHistoricoLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modalHistoricoLabel">Histórico</h4>
                </div>
                <div class="modal-body" id="infos-historico">

                </div>
            </div>
        </div>
    </div>
    <!-- ./wrapper -->
    <!-- jQuery 3 -->
    <script src="<%=pasta%>../admin/assets/bower_components/jquery/dist/jquery.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="<%=pasta%>../admin/assets/bower_components/jquery-ui/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script type="text/javascript">
      $.widget.bridge('uibutton', $.ui.button);
    </script>
    <!-- Bootstrap 3.3.7 -->
    <script src="<%=pasta%>../admin/assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- daterangepicker -->
    <script src="<%=pasta%>../admin/assets/bower_components/moment/min/moment.min.js"></script>
    <script src="<%=pasta%>../admin/assets/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- datepicker -->
    <script src="<%=pasta%>../admin/assets/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <script src="<%=pasta%>../admin/assets/bower_components/bootstrap-datepicker/dist/locales/bootstrap-datepicker.pt-BR.min.js"></script>
    <!-- Autosize -->
    <script src="<%=pasta%>../admin/assets/bower_components/autosize/dist/autosize.min.js"></script>
    <!-- Dropzone.js -->
    <script src="<%=pasta%>../admin/assets/bower_components/dropzone/dist/min/dropzone.min.js"></script>
    <!-- DataTables -->
    <script src="<%=pasta%>../admin/assets/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="<%=pasta%>../admin/assets/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <!-- Slimscroll -->
    <script src="<%=pasta%>../admin/assets/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="<%=pasta%>../admin/assets/bower_components/fastclick/lib/fastclick.js"></script>
    <!-- jquery.inputmask -->
    <script src="<%=pasta%>../admin/assets/bower_components/inputmask/dist/min/jquery.inputmask.bundle.min.js" charset="utf-8"></script>
    <!-- Select2 -->
    <script src="<%=pasta%>../admin/assets/bower_components/select2/dist/js/select2.full.min.js"></script>
    <script src="<%=pasta%>../admin/assets/bower_components/select2/dist/js/i18n/pt-BR.js"></script>
    <!-- AdminLTE App -->
    <script src="<%=pasta%>../admin/assets/dist/js/adminlte.min.js"></script>

    <script type="text/javascript">
        function ver_historico(tabela, id) {
            $.ajax({
                url: '<%=pasta%>ver_historico.asp?tabela=' + tabela + '&id=' + id,
                type: "GET",
                dataType: 'html',
                beforeSend: function (jqXHR) {
                    jqXHR.overrideMimeType('text/html;charset=iso-8859-1');
                },
                success: function (data) {
                    $('#infos-historico').html(data);
                    $('#modalHistorico').modal('show');
                },
                error: function (jqXHR, textStatus, errorThrown) {

                }
            });
        }

        function ver_historico_alteracao(tabela, id) {
            $.ajax({
                url: '<%=pasta%>ver_historico_alteracao.asp?tabela=' + tabela + '&id=' + id,
                type: "GET",
                dataType: 'html',
                beforeSend: function (jqXHR) {
                    jqXHR.overrideMimeType('text/html;charset=iso-8859-1');
                },
                success: function (data) {
                    $('#infos-historico').html(data);
                    $('#modalHistorico').modal('show');
                },
                error: function (jqXHR, textStatus, errorThrown) {

                }
            });
        }
    </script>

	<!-- jquery.inputmask -->
    <script type="text/javascript">
        $(document).ready(function () {
            $(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });

            $(":input").inputmask();

            if ($('input.telefone').length) {
                $("input.telefone").each(function () {
                    if ($(this).inputmask('unmaskedvalue') !== null) {
                        if ($(this).inputmask('unmaskedvalue').length > 10) {
                            $(this).inputmask("(99) 99999-999[9]");
                        } else {
                            $(this).inputmask("(99) 9999-9999[9]");
                        }
                    }
                });
            }

            if ($('input.cpf_cnpj').length) {
                var cpf_cnpj = $("input.cpf_cnpj").inputmask('unmaskedvalue');
                if (cpf_cnpj != null) {
                    if (cpf_cnpj.length > 11) {
                        $("input.cpf_cnpj").inputmask("99.999.999/999[9]-[9][9]");
                    } else {
                        $("input.cpf_cnpj").inputmask("999.999.999-99[9][9][9]");
                    }
                }
            }
        });

        jQuery("input.telefone").inputmask("(99) 9999-9999[9]").keyup(function (event) {
            var target, phone, element;
            target = (event.currentTarget) ? event.currentTarget : event.srcElement;
            phone = target.value.replace(/\D/g, '');
            element = $(target);
            element.inputmask('unmaskedvalue');
            if (phone.length > 10) {
                element.inputmask("(99) 99999-999[9]");
            } else {
                element.inputmask("(99) 9999-9999[9]");
            }
        });

        jQuery("input.cpf_cnpj").inputmask("99.999.999/999[9]-[9][9]").keyup(function (event) {
            var target, cpf_cnpj, element;
            target = (event.currentTarget) ? event.currentTarget : event.srcElement;
            cpf_cnpj = target.value.replace(/\D/g, '');
            element = $(target);
            element.inputmask('unmaskedvalue');
            if (cpf_cnpj.length > 11) {
                element.inputmask("99.999.999/999[9]-[9][9]");
            } else {
                element.inputmask("999.999.999-99[9][9][9]");
            }
        });

        $('.data').datepicker({
            format: "dd/mm/yyyy",
            language: "pt-BR",
            autoclose: true,
        })
    </script>
    <!-- /jquery.inputmask -->

    <!-- Select2 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $(".select2_single").select2({
                placeholder: "Select a state",
                allowClear: true
            });
            $(".select2_group").select2({});
            $(".select2_multiple").select2({
                language: "pt-BR"
            });
        });
    </script>
    <!-- /Select2 -->

    <!-- Autosize -->
    <script type="text/javascript">
        $(document).ready(function () {
            autosize($('.resizable_textarea'));
        });
    </script>
    <!-- /Autosize -->

<% if len(ordenaData) > 0 then %>
    <script type="text/javascript">
        $(document).ready(function () {
            $.extend($.fn.dataTableExt.oSort, {
                "longdatetime-pre": function (a) {
                    if (a == '') {
                        return 0;
                    }
                    var ukDatea1 = a.substring(0, 2);
                    var ukDatea2 = a.substring(3, 5);
                    var ukDatea3 = a.substring(6, 10);
                    var ukDatea4 = a.substring(11, 13);
                    var ukDatea5 = a.substring(14, 16);
                    var ukDatea6 = a.substring(17, 19);

                    return (ukDatea3 + ukDatea2 + ukDatea1 + ukDatea4 + ukDatea5 + ukDatea6) * 1;
                },

                "longdatetime-asc": function (a, b) {
                    return ((a < b) ? -1 : ((a > b) ? 1 : 0));
                },

                "longdatetime-desc": function (a, b) {
                    return ((a < b) ? 1 : ((a > b) ? -1 : 0));
                },
            });
        });
    </script>
<% end if %>

    <script type="text/javascript">
        $(function () {
            $('.data-table').DataTable({
                <%=ordenaData%>
                "language": {
                    "url": "https://cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese-Brasil.json"
                },
                initComplete: function() {
                    var colunas = $(this).attr('data-colunas');
                    this.api().columns(colunas).every(function() {
                        var column = this;
                        var select = $('<select class="form-control" style="font-weight:normal;"><option value=""></option></select>')
                            .appendTo($(column.footer()))
                            .on('change', function() {
                                var val = $.fn.dataTable.util.escapeRegex(
                                    $(this).val()
                                );

                                column
                                    .search(val ? '^' + val + '$' : '', true, false)
                                    .draw();
                            });
                        column.data().unique().sort().each(function(d, j) {
                            if (d != "") {
                                select.append('<option value="' + d + '">' + d + '</option>')
                            }
                        });
                    });
                },
            });
        });
    </script>
</body>
</html>