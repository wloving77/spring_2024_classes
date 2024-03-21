
/* ASYNCHRONOUS FUNCTIONS: */

// function to submit the post request to the backend, the corresponding addRequest post endpoint there finishes it.
async function addRequest() {

  if(!validateInput()){
    return false;
  }

  const requestInfo = getFormState();
  const url = "http://localhost:3000/addRequest";


  try {

    const response = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type":"application/json",
      },
      body: JSON.stringify(requestInfo)
    });

    console.log(requestInfo);
  

    if(response.ok) {
      console.log("Request Successfully Submitted");
    } else {
      console.error("HTTP Error", response.status);
    }

  }
  catch(error) {

    console.error(`Error during post in addRequest: ${error}`);
    alert("Unknown Error Occured in addRequest, Please Try Again");

  }

  //reload the page
  location.href="http://localhost:8080";

}

// function that runs on page load and populates the requests table 
function populateRequestsTable() {

  const url = "http://localhost:3000/allRequests";

  fetch(url)
  .then(response => response.json())
  .then(data => {
      const requestsBody = document.getElementById('requests-body');

      data.forEach(request => {
          const row = document.createElement('tr');
          row.id = `request-${request.reqId}`; // Set the id attribute to allow for updating
          row.innerHTML = `
              <td>${request.reqId}</td>
              <td>${request.reqDate.split("T")[0]}</td>
              <td>${request.roomNumber}</td>
              <td>${request.reqBy}</td>
              <td>${request.repairDesc}</td>
              <td>${request.reqPriority}</td>
              <td><button onclick="prepareRequestUpdate(${request.reqId})">Update</button></td>
              <td><button onclick="deleteRequest(${request.reqId})">Delete</button></td>
          `;
          requestsBody.appendChild(row);
      });
  })
  .catch(error => console.error('Error fetching data:', error));

}

//populates the form fields with the request logic to prepare for an update.
async function prepareRequestUpdate(reqId) {

  let request = document.getElementById(`request-${reqId}`);

  request = parseRequestToJson(request);

  let reqIdElement = document.getElementById("reqId");
  let reqDate = document.getElementById("reqDate");
  let roomNumber = document.getElementById("roomNumber");
  let reqBy = document.getElementById("reqBy");
  let repairDesc = document.getElementById("repairDesc");
  let priorityOption = document.getElementById("priorityOption");

  reqIdElement.value = request['reqId'];
  reqDate.value = request['reqDate'].split('T')[0];
  roomNumber.value = request['roomNumber'];
  reqBy.value = request['reqBy'];
  repairDesc.value = request['repairDesc'];
  priorityOption.value = request['reqPriority'];

}

// function to finish updating a request from the requests table.
async function updateRequest() {

  if(!validateInput()){
    return false;
  }

  const url = "http://localhost:3000/updateRequest";

  let reqId = document.getElementById("reqId");
  let reqDate = document.getElementById("reqDate");
  let roomNumber = document.getElementById("roomNumber");
  let reqBy = document.getElementById("reqBy");
  let repairDesc = document.getElementById("repairDesc");
  let priorityOption = document.getElementById("priorityOption");


  const requestInfo = {
    "reqId":reqId.value,
    "reqDate": reqDate.value,
    "roomNumber":roomNumber.value,
    "reqBy":reqBy.value,
    "repairDesc":repairDesc.value,
    "reqPriority":priorityOption.value,
  };


  try {

    const response = await fetch(url, {
      method: "PUT",
      headers: {
        "Content-Type":"application/json"
      },
      body: JSON.stringify(requestInfo)
    });

    if(response.ok) {
      console.log("Request Successfully Updated");
    } else {
      console.error("HTTP Error", response.status);
    }


  } catch (error) {

    console.error(`Error during post in updateRequest: ${error}`);
    alert("Unknown Error Occured in updateRequest, Please Try Again");

  }

  location.href = "http://localhost:8080";

}

// function to delete a request from the requests table
async function deleteRequest(reqId) {

  const url = "http://localhost:3000/deleteRequest";

  const payload = {
    "reqId": reqId
  };

  try {

    const response = await fetch(url, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(payload)
    });

    if (response.ok) {
      console.log("Maintenance Request Successfully Deleted");
    } else {
      console.error("HTTP Error", response.status);
    }

  } catch(error) {

    console.error(`Error during post in deleteRequest: ${error}`);
    alert("Unknown Error Occured in deleteRequest, Please Try Again");

  }

  location.href="http://localhost:8080";

}

/* SYNCHRONOUS FUNCTIONS: */

//checks that all input fields are filled correctly.
function validateInput() {

  var requestedDate = document.getElementById('reqDate').value;
    var datePattern = /^\d{4}-\d{1,2}-\d{1,2}$/; // yyyy-mm-dd
    if (!datePattern.test(requestedDate)) {
      alert("Please enter the requested date in the format yyyy-mm-dd.");
      return false;
    }
  
    var roomNo = document.getElementById('roomNumber').value.trim();
    if (roomNo === "") {
      alert("Please enter a room number.");
      return false;
    }
  
    var requestedBy = document.getElementById('reqBy').value.trim();
    if (requestedBy === "") {
      alert("Please enter your name in the 'Requested by' field.");
      return false;
    }
  
    var requestDesc = document.getElementById('repairDesc').value.trim();
    if (requestDesc === "") {
      alert("Please enter a description of the work or repair.");
      return false;
    }
  
    var priority = document.getElementById('priorityOption').value;
    if (priority === "") {
      alert("Please select a priority for the request.");
      return false;
    }
  
    return true;
}

//returns a dictionary object with all of the form values with correct names etc
function getFormState() {

  let reqId = document.getElementById("reqId");
  let reqDate = document.getElementById("reqDate");
  let roomNumber = document.getElementById("roomNumber");
  let reqBy = document.getElementById("reqBy");
  let repairDesc = document.getElementById("repairDesc");
  let priorityOption = document.getElementById("priorityOption");

  const requestInfo = {
    "reqId":reqId.value,
    "reqDate": reqDate.value,
    "roomNumber":roomNumber.value,
    "reqBy":reqBy.value,
    "repairDesc":repairDesc.value,
    "reqPriority":priorityOption.value,
  };

  return requestInfo;

}

function clearForm() {

  let reqId = document.getElementById("reqId");
  let reqDate = document.getElementById("reqDate");
  let roomNumber = document.getElementById("roomNumber");
  let reqBy = document.getElementById("reqBy");
  let repairDesc = document.getElementById("repairDesc");
  let priorityOption = document.getElementById("priorityOption");

  reqId.value = "N/A";
  reqDate.value = "";
  roomNumber.value = "";
  reqBy.value = "";
  repairDesc.value = "";
  priorityOption.value = "";

}

//helper function that just converts the html <tr> containing the request into a nice usable json object.
function parseRequestToJson(trElement) {

  const keys = ["reqId", "reqDate", "roomNumber", "reqBy", "repairDesc", "reqPriority"];

  let data = {};

  const tdElements = trElement.querySelectorAll('td');

  tdElements.forEach((td, index) => {
      if (index < keys.length) { // Ensure we don't include the button <td>s
          data[keys[index]] = td.textContent;
      }
  });

  return data;

}