<?php
include("dbconnection.php"); // Bao gồm tập tin dbconnection.php một lần
$con = dbconnection(); // Sử dụng hàm dbconnection() đã được định nghĩa

if(isset($_POST["MaDaiLy"]))
{
    $MaDaiLy=$_POST["MaDaiLy"];
}
else return;

$query = "DELETE FROM `daily` WHERE `MaDaiLy`='$MaDaiLy'";
$exe = mysqli_query($con, $query);
$arr = [];
while ($row = mysqli_fetch_array($exe)) {
    $arr[] = $row;
}
print(json_encode($arr));
?>