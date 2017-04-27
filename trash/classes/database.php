<?php
        class Database
        {
                var $types = array(
                        'INCREMENT' => 'INTEGER AUTO_INCREMENT',
                        'STRING' => 'VARCHAR',
                        'NOW' => 'unix_timestamp()',
                        'TEXT' => 'TEXT',
                        'BOOLEAN' => 'BOOL',
                        'INTEGER' => 'INTEGER',
                        'NUMBER' => 'DOUBLE',
                        'ARRAY' => 'VARCHAR(0)'
                );

                var $db_link=NULL;
                var $db_result=NULL;

                function Database($MyUrl) {
                        $UrlData = explode ( ":", $MyUrl );
                        $DBUser=$UrlData[0];
                        $DBPwd=$UrlData[1];
                        $DBHost=$UrlData[2];
                        $DBPort=$UrlData[3];
                        $DBase=$UrlData[4];

                        if($DBPort)
                           $DBHost="$DBHost:$DBPort";
                        $this->db_link=mysqli_connect($DBHost, $DBUser, $DBPwd);
                        if(!$this->db_link)
                           $this->showError("Unable to connect to server");

                        if(!mysqli_select_db($this->db_link,$DBase))
                           $this->showError("Unable to open database");
                }

                function describeError() {

                        return mysqli_error($this->db_link);
                }

                function doQuery($sqlQuery) {

                        if(is_resource($this->db_result))
                           mysqli_free_result($this->db_result);
                        $this->db_result=mysqli_query($this->db_link, $sqlQuery);
                        return $this->db_result;
                }


                function getNumFields() {
                        if (!is_resource($this->db_result))
                                return -1;
                        else
                                return mysqli_num_fields($this->db_result);
                }

                function getNumRows() {
                        if (!is_resource($this->db_result))
                                return -1;
                        else
                                return mysqli_num_rows ($this->db_result);
                }
                function getFieldName ( $index ) {
                        if (!is_resource($this->db_result))
                                return NULL;
                        else
                                return mysqli_field_name($this->db_result,$index);
                }

                function auto() {

                        return mysqli_insert_id($this->db_link);
                }

                function nextRow() {

                        return mysqli_fetch_assoc($this->db_result);
                }

                function numRows() {

                        return mysql_num_rows($this->db_result);
                }

                function numAffRows() {

                        return mysql_affected_rows($this->db_result);
                }

                function now() {

                        if(!$this->query("SELECT unix_timestamp(now()) AS now")) {

                                $this->showError("Unable to get current time");
                                return NULL;
                        }

                        $result=$this->nextRow();
                        return $result["now"];
                }

                function escape($value) {

                        return mysql_real_escape_string($value, $this->db_link);
                }
        }
?>
