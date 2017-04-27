<html>
<head>
<?php
include_once ("classes/setup.php");
if (isset ($_POST["RE_NumHab"]))
{
        $db_chars->doQuery($MyQuery);
        for ($LoopVar=0 ; $LoopVar < $_POST["RE_NumHab"]; $LoopVar++)
        {
           $IdxRE_Nom = sprintf ("RE_ID%d", $LoopVar);
           $IdxRE_Val = sprintf ("RE_Nom%d", $LoopVar);
           $IdxRE_Efe = sprintf ("RE_Efe%d", $LoopVar);
           $IdxRE_Atr = sprintf ("RE_Atr%d", $LoopVar);
           $IdxRE_Cod = sprintf ("RE_Cod%d", $LoopVar);
           $IdxRE_Man = sprintf ("RE_Man%d", $LoopVar);
           $MyQuery_t = "update RE_Habilidades_pj set RE_Nombre = '". $_POST[$IdxRE_Val] . "'," .
                                                     "RE_Efecto = '". $_POST[$IdxRE_Val] . "'," .
                                                     "RE_Atributo = '". $_POST[$IdxRE_Efe] . "'," .
                                                     "RE_Code = '". $_POST[$IdxRE_Cod] . "'," .
                                                     "RE_Mana = ". $_POST[$IdxRE_Man] .
                        " where RE_ID = " . $_POST[$IdxRE_Nom] .";";
           $db_chars->doQuery($MyQuery_t);
        }
        if (isset($_POST["RE_IDX"]) && $_POST["RE_IDX"] != ""   )
        {
           $MyQuery="insert into RE_Habilidades ( RE_ID, RE_Nombre, RE_Efecto, RE_Atributo, RE_Code, RE_Mana ) values (" .
               $_POST["RE_IDX"] . ", '" .
               $_POST["RE_NomX"] ."', '" .
               $_POST["RE_EfeX"] ."', '" .
               $_POST["RE_AtrX"] ."', '" .
               $_POST["RE_CodX"] ."', " .
               $_POST["RE_ManX"] . ");";
           $db_chars->doQuery($MyQuery);
        }
}
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
print_r($MyQuery_t)
?>
</pre>
<form name=F_Form id=F_Form method=post>
<input type=hidden name=RE_NumHab id=RE_NumHab value='<?php echo $RE_NumHab; ?>'>
<table>
<tr><td align=center colspan=4 >HABILIDADES</td></tr>
<tr bgcolor=#FFCC55>
<td align=left>Denominaci&oacute;n</td><td align=left>Valor</td>
<td align=left>Efecto</td><td align=left>Atributo</td>
</tr>
<?php
foreach ($CHab_pj as $MyKey => $MyValue)
{
   $MyIdx=$MyValue["RE_ID"];
   echo "<tr><td align=left>";
   echo "<input type=hidden id=RE_ID" . $MyKey ." name=RE_ID" . $MyKey ." value='" . $MyIdx . "'>";
   echo "<input readonly size=30 id=RE_Nom" . $MyKey ." name=RE_Nom" . $MyKey ." value='" . $CHab[$MyIdx]["RE_Nombre"] . "'></td>";
   echo "<td align=left>";
   echo "<input size=2 id=RE_Val" . $MyKey ." name=RE_Val" . $MyKey ." value='" . $MyValue["RE_Valor"] . "'></td>";
   echo "<td align=left>";
   echo "<input readonly size=50 id=RE_Efe" . $MyKey ." name=RE_Efe" . $MyKey ." value='" . $CHab[$MyIdx]["RE_Efecto"] . "'></td>";
   echo "<td align=left>";
   echo "<input readonly size=20 id=RE_Atr" . $MyKey ." name=RE_Atr" . $MyKey ." value='" . $CHab[$MyIdx]["RE_Atributo"] . "'></td></tr>\n";
}
?>
<tr bgcolor=#CCCCFF><td align=left>
<select id=RE_NomX name=RE_NomX onchange="HabCh(this)">
<option selected value=''></option>
<?php
foreach($CHab as $MyKey => $MyValue)
{
   echo "<option value=".$MyKey.">".$MyValue["RE_Nombre"]."</option>\n";
}
?>
</select>
<td align=left>
<input value='0' size=2 id=RE_ValX name=RE_ValX ></td>
<td align=left>
<input value='' size=50 id=RE_EfeX name=RE_EfeX ></td>
<td align=left>
<input value='' size=20 id=RE_AtrX name=RE_AtrX ></td></tr>
</table>
<HR>
<input type=submit value='Guardar'>
</form>
</body>
</html>
