var base_url = "http://127.0.0.1:8000/";
window.onload = async function () {
  albumData = window.sessionStorage.getItem("album");
  const fileSelector = document.getElementById("addFileInput");
  fileSelector.addEventListener("change", (event) => {
    const fileList = event.target.files[0];
    var data = new FormData();
    console.log(fileList);
    data.append("song", fileList);
    var apiUrl = base_url + "albums/songs/add/" + albumData.title;
    fetch(apiUrl, {
      method: "PUT",
      body: data,
    }).then((response) => {
      if (response.status != 200) {
        alert("Error adding song");
      } else {
        window.location.reload();
      }
    });
  });
  console.log(albumData);
  await fetch(base_url + "albums/")
    .then((response) => {
      if (response.status == 200) {
        return response.json();
      } else {
        alert("Error getting albums");
      }
    })
    .then((data) => {
      for (var i = 0; i < data.Albums.length; i++) {
        if (data.Albums[i].title == albumData) {
          albumData = data.Albums[i];
          return;
        }
      }
    });
  let albumname = document.getElementById("album_title");
  let albumcover = document.getElementById("album_cover");
  let albumcovermodal = document.getElementById("albumImage");
  let albumnamemodal = document.getElementById("AlbumInputName");
  let albumsongcount = document.getElementById("album_song_count");
  albumname.innerHTML = albumData.title;
  albumnamemodal.value = albumData.title;
  albumsongcount.innerHTML = albumData.songs.length + " Songs";
  fetch(base_url + "albums/cover/" + albumData.title)
    .then((response) => {
      if (response.status == 200) {
        return response.blob();
      } else {
        albumcovermodal.src = "assets/Album.png";
        albumcover.src = "assets/Album.png";
      }
    })
    .then((data) => {
      // document.getElementById("AlbumImageInput").file =
      //   URL.createObjectURL(data);
      albumcovermodal.src = URL.createObjectURL(data);
      albumcover.src = URL.createObjectURL(data);
    });
  var table = document.getElementById("songs_table_body");
  for (var i = 0; i < albumData.songs.length; i++) {
    let audio = new Audio(
      base_url + "albums/songs/" + albumData.title + "/" + albumData.songs[i]
    );
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

function loadFile(event) {
  let file = event.target.files[0];
  let reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = function () {
    let image = document.getElementById("albumImage");
    image.src = reader.result;
  };
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

function updateAlbum() {
  var data = new FormData();
  var file = document.getElementById("AlbumImageInput").files[0];
  var newName = document.getElementById("AlbumInputName").value;
  if (file != undefined) {
    data.append("cover", file);
  } else {
    data = null;
  }
  console.log(data);
  var apiUrl = base_url + "albums/update/" + albumData.title + "/" + newName;
  fetch(apiUrl, {
    method: "PUT",
    body: data,
  }).then((response) => {
    if (response.status != 200) {
      alert("Error updating album");
    } else {
      window.sessionStorage.setItem("album", newName);
      window.location.reload();
    }
  });
}

function updateAlbumName() {
  var newName = document.getElementById("AlbumInputName").value;
  fetch(base_url + "albums/rename/" + albumData.title + "/" + newName, {
    method: "PUT",
  }).then((response) => {
    if (response.status == 200) {
      window.location.reload();
    } else {
      alert("Error renaming album");
    }
  });
}

function updateName(name) {
  var newName = document.getElementById("editSongNameInput").value;
  fetch(
    base_url +
      "albums/songs/rename/" +
      albumData.title +
      "/" +
      name +
      "/" +
      newName,
    {
      method: "PUT",
    }
  ).then((response) => {
    if (response.status == 200) {
      window.location.reload();
    } else {
      alert("Error renaming song");
    }
  });
}

function deleteSong(name) {
  fetch(base_url + "albums/songs/remove/" + albumData.title + "/" + name, {
    method: "DELETE",
  }).then((response) => {
    if (response.status == 200) {
      window.location.reload();
    } else {
      alert("Error deleting song");
    }
  });
}

function deleteAlbum() {
  fetch(base_url + "albums/delete/" + albumData.title, {
    method: "DELETE",
  }).then((response) => {
    if (response.status == 200) {
      window.location.href = "albums_page.html";
    } else {
      alert("Error deleting album");
    }
  });
}
