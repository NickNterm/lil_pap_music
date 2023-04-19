import os
from fastapi import  UploadFile, APIRouter, HTTPException
from fastapi.responses import FileResponse


router = APIRouter()


# Get Songs
@router.get("/songs")  # , dependencies=[Depends(api_key_auth)])
def get_songs():
    return get_songs_json()

# Add Song
@router.post("/songs/add")  # , dependencies=[Depends(api_key_auth)])
def add_song(song: UploadFile):
    open(os.getcwd()+"/Collabs/"+song.filename, "wb").write(song.file.read())
    return get_songs_json()

# Remove Song
@router.delete("/songs/remove/{song}")  # , dependencies=[Depends(api_key_auth)])
def remove_song(song: str):
    for file in os.listdir(os.getcwd()+"/Collabs"):
        if file.split("~")[1] == song:
           os.remove(os.getcwd() +"/Collabs/"+file)
    return get_songs_json()

# Rename Song
@router.put("/songs/rename/{song}/{newName}")  # , dependencies=[Depends(api_key_auth)])
def change_song_name(song: str, newName: str):
    for file in os.listdir(os.getcwd()+"/Collabs"):
        if file.split("~")[1] == song:
            os.rename(os.getcwd()+"/Collabs/"+file, os.getcwd()+"/Collabs/"+newName)
    return get_songs_json()

# Get Song File
@router.get("/songs/{song}")  # , dependencies=[Depends(api_key_auth)])
def get_song(song: str):
    for file in os.listdir(os.getcwd()+"/Collabs"):
        if file.split("~")[1] == song:
            return FileResponse(os.getcwd()+"/Collabs/"+file)
    return HTTPException(status_code=404, detail="Song not found") 


def get_songs_json():
    songs = []
    for song in os.listdir(os.getcwd()+"/Collabs"):
        songs.append({"name": song.split("~")[1], "collab": song.split("~")[0].split("&")})
    return songs
