<?php
    /**** WARNING *****/
    /* Put the correct values in the URI's fields */
    include_once "database.php";
    define("DB_WORLD", "(user):(password):(host):(port):(database)");
    define("DB_CHARACTERS", "(user):(password):(host):(port):(database)");
    $db_world=new database( DB_WORLD );
    $db_chars=new database( DB_CHARACTERS );
?>
