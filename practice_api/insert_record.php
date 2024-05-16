<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["user_name"]))
{
    $user_name=$_POST["user_name"];
}
else return;
if(isset($_POST["user_email"]))
{
    $user_email=$_POST["user_email"];
}
else return;
if(isset($_POST["user_password"]))
{
    $user_password=$_POST["user_password"];
}
else return;
if(isset($_POST["user_company"]))
{
    $user_company=$_POST["user_company"];
}
else return;

$query="INSERT INTO `user_table`(`user_name`, `user_email`, `user_password`, `user_company`) VALUES ('$user_name','$user_email','$user_password','$user_company')";
$exe=mysqli_query($con,$query);
$arr=[];
if($exe)
{
    $arr["success"]="true";
}
else
{
    $arr["success"]="false";
}
print(json_encode($arr));
?>  

