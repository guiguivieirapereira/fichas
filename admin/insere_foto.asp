<!--#include file="conexao.asp"-->
<%
	id = recebe("id")
	galeria = recebe("galeria")
	novalargura = recebe("nlargura")
	if len(novalargura) = 0 then
		novalargura = "1000"
	end if

	path = Server.MapPath("fotos\temp\")&"\"
	Path2 = Server.MapPath("fotos\")&"\"

	SET Upload = Server.CreateObject("Dundas.Upload.2")
	Upload.UseUniqueNames = False
	Upload.Save(Path)

	For Each File in Upload.Files
        nome = Upload.GetFileName(File.OriginalPath)
	next

	nome1 = acento(nome)
	nomenovo = nome1
	nomenovo = replace(nomenovo," ","-")
	nomenovo = replace(nomenovo,"---","-")
	nomenovo = replace(nomenovo,"'","")

	opendb()

	strq = "select * from "&prefixo&"foto where foto = 'fotos/"&nomenovo&"'"
	set objrs = objCOnn.execute(strq)
	if not objrs.eof then
		tempo = time
		tempo = replace(tempo,":","-")
		nomenovo = tempo&"-"&nomenovo
	end if

	Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	If Fso.FileExists(path &nome) Then
		Set anexo = FSO.GetFile(path &nome)
		fso.copyfile path &nome, path2 &nomenovo
		anexo.delete
	end if

	ArquivoNome = "fotos/"&nomenovo
	strqinsert = " insert into "&prefixo&"foto(codigo, id_galeria, foto) values('"&id&"','"&galeria&"', '"&ArquivoNome&"')"
	'response.write strqinsert
	objConn.execute(strqInsert)

	closedb()
	Set Upload = Nothing
%>