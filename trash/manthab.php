<html>
<head>
<?php
include_once ("classes/setup.php");
$RE_NumHab=0;
$CHab=array();
$db_chars->doQuery("select RE_ID, RE_Nombre, RE_Efecto, RE_Atributo, RE_Code, RE_Mana from RE_Habilidades;");
while ($MyRow=$db_chars->NextRow())
{
   $TmpArr=array();
   $TmpArr["RE_Nombre"] = $MyRow["RE_Nombre"];
   $TmpArr["RE_Efecto"] = $MyRow["RE_Efecto"];
   $TmpArr["RE_Atributo"] = $MyRow["RE_Atributo"];
   $TmpArr["RE_Code"] = $MyRow["RE_Code"];
   $TmpArr["RE_Mana"] = $MyRow["RE_Mana"];
   $CHab[$MyRow["RE_ID"]]=$TmpArr;
   $RE_NumHab++;
}  

?>
</script>
</head>
<body>
<pre>
<?php
// print_r($CHab)
?>
</pre>
<form name=F_Form id=F_Form method=post>
<input type=hidden name=RE_NumHab id=RE_NumHab value='<?php echo $RE_NumHab; ?>'>
<table>
<tr><td align=center colspan=6 >HABILIDADES</td></tr>
<tr bgcolor=#FFCC55>
<td align=left>Identificador</td>
<td align=left>Denominaci&oacute;n</td>
<td align=left>Efecto</td>
<td align=left>Atributo</td>
<td align=left>Code(N/A)</td>
<td align=left>Coste de Mana</td>
</tr>
<?php
foreach ($CHab as $MyKey => $MyValue)
{
   echo "<tr>";
   echo "<td align=left><input size = 2 id=RE_ID" . $MyKey ." name=RE_ID" . $MyKey ." value='" . $MyKey . "'></td>";
   echo "<td align=left><input size=30 id=RE_Nom" . $MyKey ." name=RE_Nom" . $MyKey ." value='" . $MyValue["RE_Nombre"] . "'></td>";
   echo "<td align=left><input size=50 id=RE_Efe" . $MyKey ." name=RE_Efe" . $MyKey ." value='" . $MyValue["RE_Efecto"] . "'></td>";
   echo "<td align=left><input size=20 id=RE_Atr" . $MyKey ." name=RE_Atr" . $MyKey ." value='" . $MyValue["RE_Atributo"] . "'></td>";
   echo "<td align=left><input readonly size=10 id=RE_Cod" . $MyKey ." name=RE_Cod" . $MyKey ." value='" . $MyValue["RE_Code"] . "'></td>";
   echo "<td align=left><input size=2 id=RE_Man" . $MyKey ." name=RE_Man" . $MyKey ." value='" . $MyValue["RE_Mana"] . "'></td>";
   echo "</tr>\n";
}
?>
<tr bgcolor=#CCCCFF>
<td align=left><input size=2 id=RE_IDX name=RE_IDX size=2></td>
<td align=left><input size=30 id=RE_NomX name=RE_NomX ></td>
<td align=left><input size=50 id=RE_EfeX name=RE_EfeX ></td>
<td align=left><input size=20 id=RE_AtrX name=RE_AtrX ></td>
<td align=left><input size=10 id=RE_CodX name=RE_CodX ></td>
<td align=left><input size=2 id=RE_ManX name=RE_ManX ></td>
</tr>
</table>
<HR>
<input type=submit value='Guardar'>
</form>
</body>
</html>
