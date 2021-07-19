from fastapi import FastAPI


app = FastAPI()


@app.get('/python/health')
async def health_check():
    return {'status': 'Python Healthy'}
