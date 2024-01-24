<!DOCTYPE html>
<html>
    <head>
        <meta charset="iso-8859-1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>União faz a ficha</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.7 -->
        <link rel="stylesheet" href="<%=pasta%>../admin/assets/bower_components/bootstrap/dist/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <script src="https://kit.fontawesome.com/fdd9919b02.js"></script>
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">-->
        <!-- Dropzone.js -->
        <link rel="stylesheet" href="<%=pasta%>../admin/assets/bower_components/dropzone/dist/min/dropzone.min.css">
        <!-- DataTables -->
        <link rel="stylesheet" href="<%=pasta%>../admin/assets/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
        <!-- Date Picker -->
        <link rel="stylesheet" href="<%=pasta%>../admin/assets/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
        <!-- Daterange picker -->
        <link rel="stylesheet" href="<%=pasta%>../admin/assets/bower_components/bootstrap-daterangepicker/daterangepicker.css">
        <!-- Select2 -->
        <link href="<%=pasta%>../admin/assets/bower_components/select2/dist/css/select2.min.css" rel="stylesheet">
        <!-- Theme style -->
        <link rel="stylesheet" href="<%=pasta%>../admin/assets/dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="<%=pasta%>../admin/assets/dist/css/skins/skin-green-light.min.css">
        <link rel="stylesheet" href="<%=pasta%>../admin/assets/dist/css/custom.css">
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <!-- Google Font -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
        <style>
            .main-header > .logo, .navbar-custom-menu {
                display: none;
            }
            .main-sidebar {
                padding-top: 50px;
            }
            .fixed .content-wrapper, .fixed .right-side {
                padding-top: 50px;
            }
            .skin-green-light .main-header .navbar {
                background-color: #333;
            }
            .skin-green-light .main-header .navbar .sidebar-toggle:hover {
                background-color: #333;
            }
            @media (min-width: 992px) {
                .main-header {
                    display: none;
                }
                .main-sidebar {
                    padding-top: 0;
                }
                .fixed .content-wrapper, .fixed .right-side {
                    padding-top: 0;
                }
            }
        </style>
    </head>
    <body class="hold-transition skin-green-light sidebar-mini fixed">
        <div class="wrapper">
            <!-- Main Header -->
            <header class="main-header">
                <!-- Logo -->
                <a href="<%=pasta%>home.asp" class="logo">
                    <!-- mini logo for sidebar mini 50x50 pixels -->
                    <span class="logo-mini"><b>A</b>DM</span>
                    <!-- logo for regular state and mobile devices -->
                    <span class="logo-lg"><b>Admin</b>LTE</span>
                </a>
                <!-- Header Navbar -->
                <nav class="navbar navbar-static-top" role="navigation">
                    <!-- Sidebar toggle button-->
                    <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                        <span class="sr-only">Toggle navigation</span>
                    </a>
                    <!-- Navbar Right Menu -->
                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">
                            <!-- User Account Menu -->
                            <li class="dropdown user user-menu">
                                <!-- Menu Toggle Button -->
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <!-- The user image in the navbar-->
                                    <img src="<%=pasta%>../admin/assets/dist/img/user.png" class="user-image" alt="User Image">
                                    <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                    <span class="hidden-xs"><%=session("nome_pessoa")%></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <!-- The user image in the menu -->
                                    <li class="user-header">
                                        <img src="<%=pasta%>../admin/assets/dist/img/user.png" class="img-circle" alt="User Image">
                                        <p>
                                            <%=session("nome_pessoa")%>
                                            <small></small>
                                        </p>
                                    </li>
                                    <!-- Menu Footer-->
                                    <li class="user-footer">
                                        <div class="pull-left">
                                            <a href="<%=pasta%>altera_senha.asp" class="btn btn-default btn-flat">Alterar senha</a>
                                        </div>
                                        <div class="pull-right">
                                            <a href="<%=pasta%>logout.asp" class="btn btn-default btn-flat">Sair</a>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
            <aside class="main-sidebar <% if len(recebe("atribui")) > 0 then : response.write "hidden" : end if %>">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel (optional) -->
                    <!--<div class="user-panel">
                        <div class="pull-left image">
                            <img src="<%=pasta%>../admin/assets/dist/img/user.png" class="img-circle" alt="User Image">
                        </div>
                        <div class="pull-left info">
                            <p><%=session("nome_pessoa")%></p>
                        </div>
                    </div>-->
                    <!-- Sidebar Menu -->
                    <ul class="sidebar-menu" data-widget="tree">
                        <li class="user user-menu">
                            <a>
                                <!-- The user image in the navbar-->
                                <img src="<%=pasta%>../admin/assets/dist/img/user.png" class="user-image" alt="User Image">
                                <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                <span class="hidden-xs"><%=session("nome_pessoa")%></span>
                            </a>
                        </li>
                        <li class="header">MENU</li>
                        <li <% if opcaomenu = "dados" then : response.write "class=""active""" : end if %>>
                            <a href="<%=pasta%>dados.asp"><i class="fas fa-user"></i> <span>Dados</span></a>
                        </li>
                        <li <% if opcaomenu = "ficha" then : response.write "class=""active""" : end if %>>
                            <a href="<%=pasta%>pessoa/con_pessoa.asp"><i class="far fa-calendar-alt"></i> <span>Fichas</span></a>
                        </li>
                        <li <% if opcaomenu = "altera_senha" then : response.write "class=""active""" : end if %>>
                            <a href="<%=pasta%>altera_senha.asp"><i class="fas fa-lock"></i> <span>Alterar senha</span></a>
                        </li>
                        <li>
                            <a href="<%=pasta%>logout.asp"><i class="fas fa-times"></i> <span>Sair</span></a>
                        </li>
                    </ul>
                    <!-- /.sidebar-menu -->
                </section>
                <!-- /.sidebar -->
            </aside>