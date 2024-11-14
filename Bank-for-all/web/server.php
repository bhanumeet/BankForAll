
<?php
/* Attempt MySQL server connection. Assuming you are running MySQL
server with default setting (user 'root' with no password) */
$db = mysqli_connect("sql313.epizy.com", "epiz_26180241	", "8UVqLt7m7qW", "epiz_26180241_members");

// Check connection
if($db === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}

// Escape user inputs for security
$fname = mysqli_real_escape_string($db, $_REQUEST['fname']);
$lname = mysqli_real_escape_string($db, $_REQUEST['lname']);
$phone = mysqli_real_escape_string($db, $_REQUEST['phone']);
$gender = mysqli_real_escape_string($db, $_REQUEST['gender']);
$email = mysqli_real_escape_string($db, $_REQUEST['email']);
$add1 = mysqli_real_escape_string($db, $_REQUEST['add1']);
$add2 = mysqli_real_escape_string($db, $_REQUEST['add2']);
$city = mysqli_real_escape_string($db, $_REQUEST['city']);
$zip = mysqli_real_escape_string($db, $_REQUEST['zip']);
$state = mysqli_real_escape_string($db, $_REQUEST['state']);

// Attempt insert query execution
$sql = "INSERT INTO user_table (fname, lname,phone,gender,email,add1,add2,city,zip,state) VALUES ('$fname', '$lname','$phone','$gender','$email','$add1','$add2','$city','$zip','$state')";
if(mysqli_query($db, $sql)){
	?>
	<script type="text/javascript">
		alert("<?php echo $fname;?> <?php echo $lname;?> you have successfully registered");
	</script>
		<?php
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($db);
}

// Close connection
mysqli_close($db);
header('location: index.php');
?>
