<?php
include("dbconnection.php"); // Bao gồm tập tin dbconnection.php một lần
$con = dbconnection(); // Sử dụng hàm dbconnection() đã được định nghĩa

$query = "SELECT `uid`, `uname`, `uemail`, `upassword`, `ucompany` FROM `user_table`";
$exe = mysqli_query($con, $query);
$arr = [];
while ($row = mysqli_fetch_array($exe)) {
    $arr[] = $row;
}
print(json_encode($arr));
?>

