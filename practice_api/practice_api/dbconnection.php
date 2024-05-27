<?php
function dbconnection()
{
    $con=mysqli_connect("localhost","root","","drink_company");
    return $con;
}
?>