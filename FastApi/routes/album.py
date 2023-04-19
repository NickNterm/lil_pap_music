import os
import shutil
from fastapi import  HTTPException, UploadFile, APIRouter, File
from fastapi.responses import FileResponse


router = APIRouter()

# Get Albums
@router.get("/")  # , dependencies=[Depends(api_key_auth)])
def get_albums():
    return get_albums_json()

# Create Album
@router.post("/create/{album}")  # , dependencies=[Depends(api_key_auth)])
def create_album(album: str, cover: UploadFile):
    os.mkdir(os.getcwd()+"/Albums/"+album)
    open(os.getcwd()+"/Albums/"+album+"/cover."+ cover.filename.split(".")[-1], "wb").write(cover.file.read())
    return get_albums_json()

# Add Song
@router.put("/songs/add/{album}")  # , dependencies=[Depends(api_key_auth)])
def add_song(album: str, song: UploadFile):
    open(os.getcwd()+"/Albums/"+album+"/"+song.filename, "wb").write(song.file.read())
    return get_albums_json()

# Remove Song
@router.delete("/songs/remove/{album}/{song}")  # , dependencies=[Depends(api_key_auth)])
def remove_song(album: str, song: str):
    os.remove(os.getcwd()+"/Albums/"+album+"/"+song)
    return get_albums_json()

# Delete Album
@router.delete("/delete/{album}")  # , dependencies=[Depends(api_key_auth)])
def delete_album(album: str):
    shutil.rmtree(os.getcwd()+"/Albums/"+album)
    return get_albums_json()

# Update Album
@router.put("/update/{album}/{newName}")  # , dependencies=[Depends(api_key_auth)])
def change_album_name(album: str, newName: str, cover: UploadFile = File(None)):
    print("i am here")
    print(cover)
    if(cover != None):
        open(os.getcwd()+"/Albums/"+album+"/cover."+ cover.filename.split(".")[-1], "wb").write(cover.file.read())
    os.rename(os.getcwd()+"/Albums/"+album, os.getcwd()+"/Albums/"+newName)
    return get_albums_json()

# Rename Song
@router.put("/songs/rename/{album}/{song}/{newName}")  # , dependencies=[Depends(api_key_auth)])
def change_song_name(album: str, song: str, newName: str):
    os.rename(os.getcwd()+"/Albums/"+album+"/"+song, os.getcwd()+"/Albums/"+album+"/"+newName)
    return get_albums_json()

# Get Album Cover
@router.get("/cover/{album}")  # , dependencies=[Depends(api_key_auth)])
def get_album_cover(album: str):
    for file in os.listdir(os.getcwd()+"/Albums/"+album):
        if(file.split(".")[0] == "cover"):
            return FileResponse(os.getcwd()+"/Albums/"+album+"/"+file)
    return HTTPException(status_code=404, detail="Album cover not found")

# Get Album Song
@router.get("/songs/{album}/{song}")  # , dependencies=[Depends(api_key_auth)])
def get_album_songs(album: str, song: str):
    return FileResponse(os.getcwd()+"/Albums/"+album+"/"+song)



def get_albums_json():
    albumTitles = os.listdir(os.getcwd()+"/Albums")
    songs = []
    for title in albumTitles:
        songs.append(os.listdir(os.getcwd()+"/Albums/"+title))
    for i in range(len(songs)):
        for j in range(len(songs[i])):
            print(songs[i][j])
            if(songs[i][j].split(".")[0] == "cover"):
                songs[i].pop(j)
                break;
    
    albums = []
    for i in range(len(albumTitles)):
        albums.append({"title": albumTitles[i], "songs": songs[i]})
    return {"Albums": albums}
