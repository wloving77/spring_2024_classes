
//checks that all input fields are filled correctly.
function validateInput() {

  var requestedDate = document.getElementById('requestedDate').value;
    var datePattern = /^\d{4}-\d{1,2}-\d{1,2}$/; // yyyy-mm-dd
    if (!datePattern.test(requestedDate)) {
      alert("Please enter the requested date in the format yyyy-mm-dd.");
      return false;
    }
  
    var roomNo = document.getElementById('roomNo').value.trim();
    if (roomNo === "") {
      alert("Please enter a room number.");
      return false;
    }
  
    var requestedBy = document.getElementById('requestedBy').value.trim();
    if (requestedBy === "") {
      alert("Please enter your name in the 'Requested by' field.");
      return false;
    }
  
    var requestDesc = document.getElementById('requestDesc').value.trim();
    if (requestDesc === "") {
      alert("Please enter a description of the work or repair.");
      return false;
    }
  
    var priority = document.getElementById('priority_option').value;
    if (priority === "") {
      alert("Please select a priority for the request.");
      return false;
    }
  
    return true;
  }

  
function populateRequestsTable() {

  fetch('request-db.php')
  .then(response => response.json())
  .then(data => {
      const requestsBody = document.getElementById('requests-body');

      data.forEach(request => {
          const row = document.createElement('tr');
          row.id = `request-${request.reqId}`; // Set the id attribute to allow for updating
          row.innerHTML = `
              <td>${request.reqId}</td>
              <td>${request.reqDate}</td>
              <td>${request.roomNumber}</td>
              <td>${request.reqBy}</td>
              <td>${request.repairDesc}</td>
              <td>${request.reqPriority}</td>
              <td><button onclick="prepareRequestUpdate(${request.reqId})">Update</button></td>
              <td><button onclick="prepareRequestDelete(${request.reqId})">Delete</button></td>
          `;
          requestsBody.appendChild(row);
      });
  })
  .catch(error => console.error('Error fetching data:', error));

}

async function prepareRequestUpdate(reqId) {

  let request = document.getElementById(`request-${reqId}`);

  request = parseRequestToJson(request);

  console.log(request);

  let requestId = document.getElementById("hiddenRequestId");
  let requestedDate = document.getElementById("requestedDate");
  let roomNo = document.getElementById("roomNo");
  let requestedBy = document.getElementById("requestedBy");
  let requestDesc = document.getElementById("requestDesc");
  let priorityOption = document.getElementById("priority_option");

  requestId.value = request['reqId'];
  requestedDate.value = request['reqDate'];
  roomNo.value = request['roomNumber'];
  requestedBy.value = request['reqBy'];
  requestDesc.value = request['repairDesc'];
  priorityOption.value = request['reqPriority'];


}

async function updateRequest() {

  const url = "./request-db.php";

  let requestId = document.getElementById("hiddenRequestId");
  let requestedDate = document.getElementById("requestedDate");
  let roomNo = document.getElementById("roomNo");
  let requestedBy = document.getElementById("requestedBy");
  let requestDesc = document.getElementById("requestDesc");
  let priorityOption = document.getElementById("priority_option");


  const requestInfo = {
    "reqId":requestId.value,
    "reqDate": requestedDate.value,
    "roomNumber":roomNo.value,
    "reqBy":requestedBy.value,
    "reqDesc":requestDesc.value,
    "reqPriority":priorityOption.value,
  };

  console.log(requestInfo);

  try {
    const response = await fetch (url, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(requestInfo)
    });

    console.log(response);

  } catch(error) {

      alert("This record either doesn't exist yet or there was a server side problem");
      console.error(error);

  }




}

function prepareRequestDelete(reqId) {

  let request = document.getElementById(`request-${reqId}`);



  console.log(request);


}

function deleteRecord(reqId) {

  return;

}


//helper function that just converts the html <tr> containing the request into a nice usable json object.
function parseRequestToJson(trElement) {

  const keys = ["reqId", "reqDate", "roomNumber", "reqBy", "repairDesc", "reqPriority"];

  let data = {};

  const tdElements = trElement.querySelectorAll('td');

  // Note: We are skipping the last two <td> elements as they contain buttons, not data
  tdElements.forEach((td, index) => {
      if (index < keys.length) { // Ensure we don't include the button <td>s
          data[keys[index]] = td.textContent;
      }
  });

  return data;

}