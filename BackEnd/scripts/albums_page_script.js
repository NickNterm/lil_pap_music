var base_url = "http://130.185.234.70:3339/";
var albumsData = [];

getAlbums();

function openAlbum(albumName) {
  let album = albumsData.find((album) => album.title == albumName);
  window.sessionStorage.setItem("album", album.title);
  console.log(window.localStorage);
  window.location.href = "album_page.html";
}

function loadFile(event) {
  let file = event.target.files[0];
  let reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = function () {
    let image = document.getElementById("albumImage");
    image.src = reader.result;
  };
}

function addAlbum() {
  let name = document.getElementById("AlbumInputName").value;
  let file = document.getElementById("AlbumImageInput").files[0];
  if (file == undefined) {
    console.log("No file selected");
  }
  var data = new FormData();
  data.append("cover", file);
  var apiUrl = base_url + "albums/create/" + name;
  fetch(apiUrl, {
    method: "POST",
    body: data,
  })
    .then((response) => {
      return response.json();
    })
    .then((json) => {
      console.log(json);
      updateAlbumFromData(json);
    })
    .catch((error) => {
      console.log("test");
      console.log(error);
    });
}

function getAlbums() {
  var apiUrl = base_url + "albums/";
  fetch(apiUrl)
    .then((response) => {
      return response.json();
    })
    .then((json) => {
      updateAlbumFromData(json);
    });
}

function updateAlbumFromData(json) {
  let grid = document.getElementById("album_grid");
  let data;
  while (grid.firstChild) {
    grid.removeChild(grid.firstChild);
  }

  albumsData = [];
  for (data in json.Albums) {
    data = json.Albums[data];
    albumsData.push(data);

    var apiUrl = base_url + "albums/";
    let grid = document.getElementById("album_grid");
    let album = document.createElement("a");
    let albumImage = document.createElement("img");
    let albumName = document.createElement("p");
    album.setAttribute("id", "album_element");
    album.setAttribute("onclick", "openAlbum('" + data.title + "')");
    albumName.innerHTML = data.title;
    album.appendChild(albumImage);
    album.appendChild(albumName);
    grid.appendChild(album);
    fetch(apiUrl + "cover/" + data.title)
      .then((response) => {
        console.log(response);
        if (response.status == 200) {
          return response.blob();
        } else {
          albumImage.src = "assets/Album.png";
        }
      })
      .then((data) => {
        albumImage.src = URL.createObjectURL(data);
      });
  }
  console.log(albumsData.length);
}
