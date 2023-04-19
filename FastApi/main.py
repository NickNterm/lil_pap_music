import os
from fastapi import Body, Depends, FastAPI, HTTPException, UploadFile, File
from typing import Annotated
from fastapi.security import OAuth2PasswordBearer
from fastapi.middleware.cors import CORSMiddleware
from routes import album, collabs, beats_for_placement

#os.pardir
print(os.getcwd())
os.chdir("music_directory")

api_keys = [
    "F4g3UJNuHeO95X3LTN55gmcdTFa9sAm5Hbp6VOc6rL6RclMbrzNvENjLNzNUFbpYO0QMEXRr8WraNz4bWsHPDuY1g3L8SX2J5OBtNeLtkioGMTxlIWde5ltvyatoYUqR"
]


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


def api_key_auth(api_key: str = Depends(oauth2_scheme)):
    if api_key not in api_keys:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Forbidden"
        )



app = FastAPI()

origins = ["*"]


app.include_router(album.router, prefix="/albums", tags=["Albums"])
app.include_router(collabs.router, prefix="/collabs", tags=["Collabs"])
app.include_router(beats_for_placement.router, prefix="/beats_for_placement", tags=["Beats For Placement"])

app = CORSMiddleware(
    app=app,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# Create Album
# Add Song to Album
# Remove Song From Album
# Delete Album
# Change Album Name
# Change Song Name
# Change Album Cover

