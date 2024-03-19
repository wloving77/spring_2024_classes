<?php



function addRequests($db, $reqDate, $roomNumber, $reqBy, $repairDesc, $reqPriority)
{

    try {
        $sql = "INSERT INTO requests (reqDate, roomNumber, reqBy, repairDesc, reqPriority) VALUES (?,?,?,?,?)";
        $stmt = $db->prepare($sql);

        $stmt->execute([$reqDate, $roomNumber, $reqBy, $repairDesc, $reqPriority]);

    } catch (PDOException $e) {

        error_log("Error in DB");

        throw $e;

    } catch (Exception $e){

        error_log("Error in AddRequests");
    
        throw $e;

    }

}

function getAllRequests($db)
{

    try {

        $sql = "SELECT * FROM requests";

        $stmt = $db->query($sql);

        $allRequests = $stmt->fetchAll();

        return $allRequests;

    }  catch (PDOException $e) {

        error_log("Error in DB");

        throw $e;

    } catch (Exception $e){
    
        error_log("Error in getAllRequests");

        throw $e;
        
    }


}

//returns a request based on the request ID, assumed to be unique.
function getRequestById($db, $reqId)  
{
    
    $sql = "SELECT * FROM requests where reqId = $id";

    $stmt = $db -> query($sql);

    $request = $stmt->fetchAll();

    return $request;


}

function updateRequest($reqId, $reqDate, $roomNumber, $reqBy, $repairDesc, $reqPriority)
{


}

function deleteRequest($reqId)
{

    
}


//db params:
$username = 'wloving77';
$password = '1234';
$host = 'db';
$port = '3306';
$dbname = 'potd5';   
$dsn = "mysql:host=$host;dbname=$dbname";

//db instantiated for any of the requests:
$db = new PDO($dsn, $username, $password);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    //prepare post variables:
    $reqDate = $_POST['requestedDate'] ?? null; 
    $roomNumber = $_POST['roomNo'] ?? null;
    $reqBy = $_POST['requestedBy'] ?? null;
    $repairDesc = $_POST['requestDesc'] ?? null;
    $reqPriority = $_POST['priority_option'] ?? null;

    try {
        addRequests($db, $reqDate, $roomNumber, $reqBy, $repairDesc, $reqPriority);
    } catch (Exception $e) {
        error_log("Issue inserting into db");
        throw $e;
    }

    header("Location: request.php");
    exit;


} else if ($_SERVER['REQUEST_METHOD'] == "GET") {

    $allRequests = getAllRequests($db);

    header('Content-Type: application/json');
    echo json_encode($allRequests);
    exit; 
} else if ($_SERVER['REQUEST_METHOD'] == "PUT") {

}


?>
