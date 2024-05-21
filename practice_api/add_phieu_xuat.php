<?php
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["MaPhieu"]))
{
    $MaPhieu=$_POST["MaPhieu"];
}
else return;
if(isset($_POST["MaDaiLy"]))
{
    $MaDaiLy=$_POST["MaDaiLy"];
}
else return;
if(isset($_POST["TenNguoiNhan"]))
{
    $TenNguoiNhan=$_POST["TenNguoiNhan"];
}
else return;
if(isset($_POST["NgayXuat"]))
{
    $NgayXuat=$_POST["NgayXuat"];
}
else return;
if(isset($_POST["ChuKyViet"]))
{
    $ChuKyViet=$_POST["ChuKyViet"];
}
else return;
if(isset($_POST["ChuKyNhan"]))
{
    $ChuKyNhan=$_POST["ChuKyNhan"];
}
else return;
if(isset($_POST["ChuKyTruongDonVi"]))
{
    $ChuKyTruongDonVi=$_POST["ChuKyTruongDonVi"];
}
else return;
if(isset($_POST["NgayCapMinistry"]))
{
    $NgayCapMinistry=$_POST["NgayCapMinistry"];
}
else return;
if(isset($_POST["SoGiayChungNhan"]))
{
    $SoGiayChungNhan=$_POST["SoGiayChungNhan"];
}
else return;



$query="INSERT INTO `phieuxuathang`(`MaPhieu`, `MaDaiLy`, `TenNguoiNhan`, `NgayXuat`, `ChuKyViet`, `ChuKyNhan`, `ChuKyTruongDonVi`, `NgayCapMinistry`, `SoGiayChungNhan`) VALUES ('$MaPhieu','$MaDaiLy','$TenNguoiNhan','$NgayXuat','$ChuKyViet','$ChuKyNhan','$ChuKyTruongDonVi','$NgayCapMinistry','$SoGiayChungNhan')";
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