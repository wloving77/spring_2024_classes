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

function prepareRequestUpdate(reqId) {

  let request = document.getElementById(`request-${reqId}`);

  console.log(request);

  return;

}

function prepareRequestDelete(reqId) {

  let request = document.getElementById(`request-${reqId}`);

  console.log(request);


}

function deleteRecord(reqId) {

  return;

}