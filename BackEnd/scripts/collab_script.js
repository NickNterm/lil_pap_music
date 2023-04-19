var base_url = "http://127.0.0.1:8000/";
window.onload = async function () {
  const fileSelector = document.getElementById("addFileInput");
  fileSelector.addEventListener("change", (event) => {
    console.log("File selected");
    var fileList = event.target.files[0];
    fileList.name = "Lil Pap~" + fileList.name;
    fileList = new File([fileList], "Lil Pap~" + fileList.name, {
      type: fileList.type,
    });
    console.log(fileList);
    var data = new FormData();
    data.append("song", fileList);
    var apiUrl = base_url + "collabs/songs/add/";
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

  var songs = await fetch(base_url + "collabs/songs").then((response) => {
    if (response.status == 200) {
      return response.json();
    } else {
      alert("Error getting songs");
    }
  });
  console.log(songs);

  var table = document.getElementById("songs_table_body");
  for (var i = 0; i < songs.length; i++) {
    let audio = new Audio(base_url + "collabs/songs/" + songs[i].name);
    audio.onloadedmetadata = function () {
      console.log(audio);
      var row = table.insertRow(0);
      var cell1 = row.insertCell(0);
      var cell2 = row.insertCell(1);
      var cell3 = row.insertCell(2);
      var cell4 = row.insertCell(3); // get seconds and covert to minutes:seconds
      var cell5 = row.insertCell(4);

      var minutes = Math.floor(audio.duration / 60);
      var seconds = Math.floor(audio.duration % 60);
      if (seconds < 10) {
        seconds = "0" + seconds;
      }
      cell3.innerHTML = minutes + ":" + seconds;

      var name = audio.currentSrc.split("/").pop().replaceAll("%20", " ");
      cell1.innerHTML = name;
      for (var i = 0; i < songs.length; i++) {
        if (songs[i].name == name) {
          cell2.innerHTML = songs[i].collab.join(", ");
          var realName = songs[i].collab.join("&") + "~" + name;
        }
      }
      cell4.innerHTML =
        '<button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editSongModal" onclick="renameSongButton(\'' +
        realName +
        "')\">Rename</button>";
      cell5.innerHTML =
        '<button type="button" class="btn btn-danger"data-bs-toggle="modal" data-bs-target="#deleteSongModal" onclick="deleteSongButton(\'' +
        name +
        "')\">Delete</button>";
    };

    // Add some text to the new cells:
  }
};

function renameSongButton(name) {
  document.getElementById("editSongNameInput").value = name.split("~")[1];
  document.getElementById("editSongCollabInput").value = name
    .split("~")[0]
    .split("&")
    .join(", ");
  document.getElementById("editSongNameButton").onclick = function () {
    updateName(name.split("~")[1]);
  };
}

function deleteSongButton(name) {
  document.getElementById("deleteSongButton").onclick = function () {
    deleteSong(name);
  };
}

function updateName(name) {
  var newName = document.getElementById("editSongNameInput").value;
  var collabs = document.getElementById("editSongCollabInput").value;
  collabname = collabs.split(", ").join("&");
  var newFinalName = collabname + "~" + newName;
  var apiUrl = base_url + "collabs/songs/rename/" + name + "/" + newFinalName;
  fetch(apiUrl, {
    method: "PUT",
  })
    .then((response) => {
      if (response.status != 200) {
        alert("Error renaming song");
      } else {
        window.location.reload();
      }
    })
    .catch((error) => {
      console.log(error);
    });
}

function deleteSong(name) {
  var apiUrl = base_url + "collabs/songs/remove/" + name;
  fetch(apiUrl, {
    method: "DELETE",
  })
    .then((response) => {
      if (response.status != 200) {
        alert("Error deleting song");
      } else {
        window.location.reload();
      }
    })
    .catch((error) => {
      console.log(error);
    });
}
