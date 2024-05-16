<?php
include("dbconnection.php"); // Bao gồm tập tin dbconnection.php một lần
$con = dbconnection(); // Sử dụng hàm dbconnection() đã được định nghĩa

$query = "SELECT `user_id`, `user_name`, `user_email`, `user_password`, `user_company` FROM `user_table`";
$exe = mysqli_query($con, $query);
$arr = [];
while ($row = mysqli_fetch_array($exe)) {
    $arr[] = $row;
}
print(json_encode($arr));
?>

