from fastapi import   APIRouter

router = APIRouter()

@router.get("/")
async def read_root():
    return {"note": "Bring heat to the beat"}
