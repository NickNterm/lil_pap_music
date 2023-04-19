var base_url = "http://127.0.0.1:8000/";
window.onload = async function () {
  const fileSelector = document.getElementById("addFileInput");
  fileSelector.addEventListener("change", (event) => {
    console.log("File selected");
    const fileList = event.target.files[0];
    var data = new FormData();
    console.log(fileList);
    data.append("song", fileList);
    var apiUrl = base_url + "beats_for_placement/songs/add/";
    fetch(apiUrl, {
      method: "POST",
      body: data,
    }).then((response) => {
      if (response.status != 200) {
        alert("Error adding song");
      } else {
        window.location.reload();
      }
    });
  });

  var songs = await fetch(base_url + "beats_for_placement/songs").then(
    (response) => {
      if (response.status == 200) {
        return response.json();
      } else {
        alert("Error getting songs");
      }
    }
  );
  console.log(songs);

  var table = document.getElementById("songs_table_body");
  for (var i = 0; i < songs.length; i++) {
    let audio = new Audio(base_url + "beats_for_placement/songs/" + songs[i]);
    audio.onloadedmetadata = function () {
      console.log(audio);
      var row = table.insertRow(0);
      var cell1 = row.insertCell(0);
      var cell2 = row.insertCell(1);
      var cell3 = row.insertCell(2);
      var cell4 = row.insertCell(3); // get seconds and covert to minutes:seconds

      var minutes = Math.floor(audio.duration / 60);
      var seconds = Math.floor(audio.duration % 60);
      if (seconds < 10) {
        seconds = "0" + seconds;
      }
      cell2.innerHTML = minutes + ":" + seconds;

      var name = audio.currentSrc.split("/").pop().replaceAll("%20", " ");
      cell1.innerHTML = name;
      console.log(name);
      cell3.innerHTML =
        '<button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editSongModal" onclick="renameSongButton(\'' +
        name +
        "')\">Rename</button>";
      cell4.innerHTML =
        '<button type="button" class="btn btn-danger"data-bs-toggle="modal" data-bs-target="#deleteSongModal" onclick="deleteSongButton(\'' +
        name +
        "')\">Delete</button>";
    };

    // Add some text to the new cells:
  }
};
function updateName(name) {
  var newName = document.getElementById("editSongNameInput").value;
  var apiUrl =
    base_url + "beats_for_placement/songs/rename/" + name + "/" + newName;
  fetch(apiUrl, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
  }).then((response) => {
    if (response.status != 200) {
      alert("Error renaming song");
    } else {
      window.location.reload();
    }
  });
}
function deleteSong(name) {
  var apiUrl = base_url + "beats_for_placement/songs/remove/" + name;
  fetch(apiUrl, {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json",
    },
  }).then((response) => {
    if (response.status != 200) {
      alert("Error deleting song");
    } else {
      window.location.reload();
    }
  });
}

function renameSongButton(name) {
  document.getElementById("editSongNameInput").value = name;
  document.getElementById("editSongNameButton").onclick = function () {
    updateName(name);
  };
}
function deleteSongButton(name) {
  document.getElementById("deleteSongButton").onclick = function () {
    deleteSong(name);
  };
}
