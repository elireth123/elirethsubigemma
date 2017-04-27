<html>
<head>
<?php
include_once ("classes/setup.php");
if (isset ($_POST["RE_pj"]))
{
        $MyQuery="insert into RE_Atributos (RE_pj, RE_Fisico, RE_Destreza, RE_Inteligencia, RE_Percepcion, RE_Mana, RE_Vida, RE_Iniciativa, RE_Defensa) values ( '" . $_POST["RE_pj"] . "', " .
            $_POST["RE_FIS"] . ", ".
            $_POST["RE_DES"] . ", ".
                $_POST["RE_INT"] . ", ".
                $_POST["RE_PER"] . ", ".
                $_POST["RE_MAN"] . ", ".
                $_POST["RE_VID"] . ", ".
                $_POST["RE_INI"] . ", ".
                $_POST["RE_DEF"] . ");";
        $db_chars->doQuery($MyQuery);
}
?>
</head>
<body>
<form name=F_Form id=F_Form method=post>
<table width=50%>
<tr><td align=right>Player:</td><td align=left colspan=7>
<input name=RE_pj id=RE_pj></td></tr>
<tr><td align=center colspan=8 >VALORES DE COMBATE </td></tr>
<tr>
<td width=20% align=right>Vida:</td><td align=left><input size=2 id=RE_VID name=RE_VID></td>
<td width=20% align=right>Man&aacute;:</td><td align=left><input size=2 id=RE_MAN name=RE_MAN></td>
<td width=20% align=right>Iniciativa:</td><td align=left><input size=2 id=RE_INI name=RE_INI></td>
<td width=20% align=right>Defensa:</td><td align=left><input size=2 id=RE_DEF name=RE_DEF></td>
</tr>
<tr><td align=center colspan=8 >ATRIBUTOS</td></tr>
<tr>
<td width=20% align=right>F&iacute;sico:</td><td align=left><input size=2 id=RE_FIS name=RE_FIS></td>
<td width=20% align=right>Destreza:</td><td align=left><input size=2 id=RE_DES name=RE_DES></td>
<td width=20% align=right>Intelig&eacute;ncia:</td><td align=left><input size=2 id=RE_INT name=RE_INT></td>
<td width=20% align=right>Percepci&oacute;n:</td><td align=left><input size=2 id=RE_PER name=RE_PER></td>
</tr>
</table>
<HR>
<input type=submit value='Guardar'>
</form>
</body>
