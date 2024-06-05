<?php
include("dbconnection.php"); // Bao gồm tập tin dbconnection.php một lần
$con = dbconnection(); // Sử dụng hàm dbconnection() đã được định nghĩa

if(isset($_POST["MaPhanXuong"]))
{
    $MaPhanXuong=$_POST["MaPhanXuong"];
}
else return;

$query = "DELETE FROM `xuongsanxuat` WHERE `MaPhanXuong`='$MaPhanXuong'";
$exe = mysqli_query($con, $query);
$arr = [];
while ($row = mysqli_fetch_array($exe)) {
    $arr[] = $row;
}
print(json_encode($arr));
?>