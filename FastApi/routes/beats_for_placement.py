import os
import eyed3
import tempfile
import io
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

# Get Cover From mp3 file
@router.get("/cover/{song}")  # , dependencies=[Depends(api_key_auth)])
async def get_song_cover(song: str):
    audio = eyed3.load(os.getcwd()+"/BeatsForPlacement/"+song)
    if audio is not None and audio.tag is not None:
         if audio.tag and audio.tag.images:
             image_data = audio.tag.images[0].image_data
             image = io.BytesIO(image_data)
             with tempfile.NamedTemporaryFile(delete=False, suffix=".png") as f:
                   f.write(image.getvalue())
                   temp_file_path = f.name
                   return FileResponse(temp_file_path, media_type="image/jpeg",  filename="image.png")
    return HTTPException(status_code=404, detail="Song not found")



def get_songs_json():
    return os.listdir(os.getcwd()+"/BeatsForPlacement")
