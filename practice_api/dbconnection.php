<?php
function dbconnection()
{
    $con=mysqli_connect("localhost","root","","cong_ty_nuoc_giai_khat");
    return $con;
}
?>