<html>
<head>
<?php
include_once ("classes/setup.php");
if (isset ($_POST["RE_pj"]))
{
	$MyQuery="update RE_Atributos set RE_Fisico = " . $_POST["RE_FIS"] . ", ".
	    "RE_Destreza = " . $_POST["RE_DES"] . ", ".
		"RE_Inteligencia = " . $_POST["RE_INT"] . ", ".
		"RE_Percepcion = " . $_POST["RE_PER"] . ", ".
		"RE_Mana = " . $_POST["RE_MAN"] . ", ".
		"RE_Vida = " . $_POST["RE_VID"] . ", ".
		"RE_Iniciativa = " . $_POST["RE_INI"] . ", ".
		"RE_Defensa = " . $_POST["RE_DEF"] . " where RE_pj ='". $_POST["RE_pj"] ."';";
	$db_chars->doQuery($MyQuery);
	for ($LoopVar=0 ; $LoopVar < $_POST["RE_NumHab_pj"]; $LoopVar++)
	{
	   $IdxRE_Nom = sprintf ("RE_ID%d", $LoopVar);
	   $IdxRE_Val = sprintf ("RE_Val%d", $LoopVar);
           $MyQuery_t = "update RE_Habilidades_pj set RE_Valor = ". $_POST[$IdxRE_Val] . 
                      " where RE_pj = '" . $_POST["RE_pj"] .
                      "' and RE_ID = " . $_POST[$IdxRE_Nom] .";";
           $db_chars->doQuery($MyQuery_t);
	}	 
        if (isset($_POST["RE_NomX"]) && $_POST["RE_NomX"] != ""	)
	{
	   $MyQuery="insert into RE_Habilidades_pj ( RE_pj, RE_ID, RE_Valor ) values ('" . 
	       $_POST["RE_pj"] . "', " .
	       $_POST["RE_NomX"] .", " .
	       $_POST["RE_ValX"] . ");";
	   $db_chars->doQuery($MyQuery);
	}
}

$CHab=array();
$CHab_pj=array();
$RE_pj=isset($_GET["Player"])?$_GET["Player"]:"";
$RE_Fis="";
$RE_Des="";
$RE_Int="";
$RE_Per="";
$RE_Vid="";
$RE_Man="";
$RE_Ini="";
$RE_Def="";
$RE_NumHab = 0;
$RE_NumHab_pj = 0;
$PFound = false;
if ($RE_pj != "")
{
   $db_chars->doQuery("select RE_Fisico, RE_Destreza, RE_Inteligencia, RE_Percepcion, RE_Mana, RE_Vida, RE_Iniciativa, RE_Defensa from RE_Atributos where RE_pj ='".$RE_pj."';");
   while ($MyRow=$db_chars->NextRow())
   {
      $RE_Fis=$MyRow["RE_Fisico"];
      $RE_Des=$MyRow["RE_Destreza"];
      $RE_Int=$MyRow["RE_Inteligencia"];
      $RE_Per=$MyRow["RE_Percepcion"];
      $RE_Vid=$MyRow["RE_Vida"];
      $RE_Man=$MyRow["RE_Mana"];
      $RE_Ini=$MyRow["RE_Iniciativa"];
      $RE_Def=$MyRow["RE_Defensa"];	   
      $PFound=true;
   }	   
   echo "<script>\n";
   echo "var REH_Nombre = new Array();\n";
   echo "var REH_Efecto = new Array();\n";
   echo "var REH_Atributo = new Array();\n";
   $db_chars->doQuery("select RE_ID, RE_Nombre, RE_Efecto, RE_Atributo, RE_Code from RE_Habilidades;");
   while ($MyRow=$db_chars->NextRow())
   {
      $TmpArr=array();
      $TmpArr["RE_Nombre"] = $MyRow["RE_Nombre"];
      $TmpArr["RE_Efecto"] = $MyRow["RE_Efecto"];
      $TmpArr["RE_Atributo"] = $MyRow["RE_Atributo"];
      $TmpArr["RE_Code"] = $MyRow["RE_Code"];
      $CHab[$MyRow["RE_ID"]]=$TmpArr;
      $RE_NumHab++;
      echo "REH_Nombre[". $MyRow["RE_ID"] ."]='".$MyRow["RE_Nombre"]."';\n";
      echo "REH_Efecto[". $MyRow["RE_ID"] ."]='".$MyRow["RE_Efecto"]."';\n";
      echo "REH_Atributo[". $MyRow["RE_ID"] ."]='".$MyRow["RE_Atributo"]."';\n";
   }  
   echo "</script>\n";
   $db_chars->doQuery("select RE_ID, RE_Valor from RE_Habilidades_pj where RE_pj ='".$RE_pj."';");
   while ($MyRow=$db_chars->NextRow())
   {
      $TmpArr2=array();
      $TmpArr2["RE_ID"] = $MyRow["RE_ID"];
      $TmpArr2["RE_Valor"] = $MyRow["RE_Valor"];
      $CHab_pj[]=$TmpArr2;
      $RE_NumHab_pj++;
   }
}
else
	echo ("<script>\ndocument.location='nouveaupj.php';\n</script>\n");

if (!$PFound)
	die("Player not found!!");

?>
<script>
function HabCh(MyObj)
{
   var MyEfe = document.getElementById ("RE_EfeX");
   MyEfe.value = REH_Efecto[MyObj.value]; 
   var MyAtr = document.getElementById ("RE_AtrX");
   MyAtr.value = REH_Atributo[MyObj.value]; 
}
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
<input type=hidden name=RE_NumHab_pj id=RE_NumHab_pj value='<?php echo $RE_NumHab_pj; ?>'>
<table width=50%>
<tr><td align=right>Player:</td><td align=left colspan=7>
<input readonly name=RE_pj id=RE_pj value='<?php echo $RE_pj; ?>'></td></tr>
<tr><td align=center colspan=8 >VALORES DE COMBATE </td></tr>
<tr>
<td width=20% align=right>Vida:</td><td align=left><input size=2 id=RE_VID name=RE_VID value='<?php echo $RE_Vid;?>'></td>
<td width=20% align=right>Man&aacute;:</td><td align=left><input size=2 id=RE_MAN name=RE_MAN value='<?php echo $RE_Man;?>'></td>
<td width=20% align=right>Iniciativa:</td><td align=left><input size=2 id=RE_INI name=RE_INI value='<?php echo $RE_Ini;?>'></td>
<td width=20% align=right>Defensa:</td><td align=left><input size=2 id=RE_DEF name=RE_DEF value='<?php echo $RE_Def;?>'></td>
</tr>
<tr><td align=center colspan=8 >ATRIBUTOS</td></tr>
<tr>
<td width=20% align=right>F&iacute;sico:</td><td align=left><input size=2 id=RE_FIS name=RE_FIS value='<?php echo $RE_Fis;?>'></td>
<td width=20% align=right>Destreza:</td><td align=left><input size=2 id=RE_DES name=RE_DES value='<?php echo $RE_Des;?>'></td>
<td width=20% align=right>Intelig&eacute;ncia:</td><td align=left><input size=2 id=RE_INT name=RE_INT value='<?php echo $RE_Int;?>'></td>
<td width=20% align=right>Percepci&oacute;n:</td><td align=left><input size=2 id=RE_PER name=RE_PER value='<?php echo $RE_Per;?>'></td>
</tr>
</table>
<br>
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
