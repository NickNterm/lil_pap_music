import os
from fastapi import  UploadFile, APIRouter
from fastapi.responses import FileResponse


router = APIRouter()


# Get Songs
@router.get("/songs")  # , dependencies=[Depends(api_key_auth)])
def get_songs():
    return get_songs_json()

# Add Song
@router.post("/songs/add")  # , dependencies=[Depends(api_key_auth)])
def add_song(song: UploadFile):
    open(os.getcwd()+"/BeatsForPlacement/"+song.filename, "wb").write(song.file.read())
    return get_songs_json()

# Remove Song
@router.delete("/songs/remove/{song}")  # , dependencies=[Depends(api_key_auth)])
def remove_song(song: str):
    os.remove(os.getcwd()+"/BeatsForPlacement/"+song)
    return get_songs_json()

# Rename Song
@router.put("/songs/rename/{song}/{newName}")  # , dependencies=[Depends(api_key_auth)])
def change_song_name(song: str, newName: str):
    os.rename(os.getcwd()+"/BeatsForPlacement/"+song, os.getcwd()+"/BeatsForPlacement/"+newName)
    return get_songs_json()

# Get Song File
@router.get("/songs/{song}")  # , dependencies=[Depends(api_key_auth)])
def get_song(song: str):
    return FileResponse(os.getcwd()+"/BeatsForPlacement/"+song)


def get_songs_json():
    return os.listdir(os.getcwd()+"/BeatsForPlacement")
