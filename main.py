import wikipedia
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class ArticleInput(BaseModel):
    name: str
    sent_num: int


class Article(BaseModel):
    name: str
    content: str


class Articles(BaseModel):
    names: list[str]


@app.get('/{path}', response_model=Articles)
def get_name(path: str):
    try:
        return Articles(names=wikipedia.search(path)[:10])
    except:
        return Articles(names=[])


@app.get('/article/{name}', response_model=Article)
def get_article(name: str, sentence_cnt: int):
    try:
        return Article(name=name, content=wikipedia.summary(name, sentences=sentence_cnt))
    except:
        return Article(name=name, content="Не найдено")


@app.post("/", response_model=Article)
def create_article(article_input: ArticleInput):
    try:
        return Article(name=article_input.name,
                       content=wikipedia.summary(article_input.name, sentences=article_input.sent_num))
    except:
        return Article(name=article_input.name, content="Не найдено")
