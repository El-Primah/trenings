## 🎓 **Тренинг: "Jupyter для ML-разработки и анализа данных"**

### **Цель тренинга:**
- Эффективно использовать Jupyter для ML-проектов.
- Структурировать ML-ноутбуки.
- Работать с данными, обучать и валидировать модели в Jupyter.
- Интегрировать ML-ноутбуки в CI/CD.
- Понимать, как использовать Jupyter в MLops-пайплайнах.

#### Полезные ссылки
 - Статья по CI/CD в MLops
    - https://habr.com/ru/companies/kuper/articles/845312

---

## 🔢 **Общая структура (40 часов)**

| День | Тема | Основные задачи |
|------|------|-----------------|
| 1 | Введение в Jupyter для ML | Установка, структура ноутбука, EDA, визуализация |
| 2 | ML-библиотеки в Jupyter | Pandas, sklearn, numpy, matplotlib, seaborn |
| 3 | ML-пайплайн в ноутбуке | Загрузка данных → EDA → обучение → оценка |
| 4 | Воспроизводимость и рефакторинг | Параметры, функции, papermill |
| 5 | Работа с реальными данными | Работа с CSV, SQL, JSON |
| 6 | Docker для ML-окружения | Сборка образа с ML-библиотеками |
| 7 | JupyterHub для ML-команды | Настройка, запуск пользовательских ML-окружений |
| 8 | CI/CD для ML-ноутбуков | Запуск ноутбука в пайплайне, проверка ошибок |
| 9 | ML-инференс в ноутбуке | Загрузка модели, предсказания, метрики |
| 10 | Финальный проект | ML-ноутбук → Docker → JupyterHub → CI/CD |

---

## 📚 **Детализация по дням**

---

### **День 1: Введение в Jupyter для ML**

**Задачи:**
1. Установить Jupyter, JupyterLab.
2. Создать ноутбук: загрузить датасет `titanic` из `seaborn`.
3. Провести простой EDA: `df.info()`, `df.describe()`, визуализировать распределение `Age`, `Survived`.
4. Понять структуру `.ipynb` и как устроены ячейки.

**Пример кода:**
```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

df = sns.load_dataset('titanic')
df.head()
df.info()
sns.histplot(data=df, x='age', hue='survived')
plt.show()
```

**Полезные замечания:**
- Ячейки позволяют экспериментировать с данными и быстро проверять гипотезы.
- Markdown удобен для описания гипотез, выводов и документирования.

---

### **День 2: ML-библиотеки в Jupyter**

**Задачи:**
1. Подключить `scikit-learn`, `pandas`, `numpy`, `matplotlib`.
2. Подготовить данные: заполнить пропуски, закодировать категориальные признаки.
3. Обучить простую модель (например, `LogisticRegression`).
4. Оценить метрики: `accuracy`, `classification_report`.

**Пример кода:**
```python
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report

df.dropna(inplace=True)
X = df[['pclass', 'sex', 'age']]
y = df['survived']
X = pd.get_dummies(X, drop_first=True)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = LogisticRegression()
model.fit(X_train, y_train)

y_pred = model.predict(X_test)
print(classification_report(y_test, y_pred))
```

**Полезные замечания:**
- В ноутбуке удобно визуализировать результаты обучения и сразу видеть, что происходит.
- Важно использовать `random_state` для воспроизводимости.

---

### **День 3: ML-пайплайн в ноутбуке**

**Задачи:**
1. Собрать полный ML-пайплайн: загрузка → предобработка → обучение → оценка → визуализация.
2. Использовать `Pipeline` из `sklearn` для чистоты кода.
3. Построить confusion matrix и ROC-кривую.

**Пример кода:**
```python
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay

pipe = Pipeline([
    ('scaler', StandardScaler()),
    ('classifier', RandomForestClassifier())
])

pipe.fit(X_train, y_train)
y_pred = pipe.predict(X_test)

cm = confusion_matrix(y_test, y_pred)
disp = ConfusionMatrixDisplay(confusion_matrix=cm)
disp.plot()
plt.show()
```

**Полезные замечания:**
- Ноутбуки позволяют быстро прототипировать, но не всегда подходят для продакшена.
- Используйте `Pipeline` — это чисто, читаемо и помогает избежать утечки данных.

---

### **День 4: Воспроизводимость и рефакторинг**

**Задачи:**
1. Вынести ML-логику в `.py` файлы (например, `preprocessing.py`, `train.py`).
2. Импортировать функции в ноутбук.
3. Использовать `papermill` для запуска ноутбука с параметрами (например, `test_size`).

**Пример кода (`preprocessing.py`):**
```python
def preprocess_data(df):
    df = df.dropna()
    X = df[['pclass', 'sex', 'age']]
    y = df['survived']
    X = pd.get_dummies(X, drop_first=True)
    return X, y
```

**Пример запуска через `papermill`:**
```bash
papermill notebook.ipynb output.ipynb -p test_size 0.3
```

**Полезные замечания:**
- Ноутбуки — это исследование, но рефакторинг в `.py` помогает перейти к продакшену.
- `papermill` — отличный инструмент для параметризации и автоматизации ноутбуков.

---

### **День 5: Работа с реальными данными**

**Задачи:**
1. Подключиться к CSV, JSON и PostgreSQL из ноутбука.
2. Сделать EDA и обучить модель на данных из БД.
3. Сохранить результаты предсказаний в CSV.

**Пример кода (PostgreSQL):**
```python
import sqlalchemy

engine = sqlalchemy.create_engine('postgresql://user:password@localhost:5432/ml_db')
df = pd.read_sql('SELECT * FROM customer_data', con=engine)
```

**Полезные замечания:**
- Не храните пароли в коде! Используйте переменные окружения.
- Работа с БД из ноутбука — удобно для анализа и подготовки данных.

---

### **День 6: Docker для ML-окружения**

**Задачи:**
1. Написать `Dockerfile` с Python, pandas, sklearn, jupyter.
2. Собрать образ и запустить контейнер с ноутбуком.
3. Проверить, что ML-библиотеки работают.

**Пример `Dockerfile`:**
```Dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"]
```

**Полезные замечания:**
- Docker помогает избежать проблем с зависимостями и окружением.
- Контейнеры с Jupyter удобны для командной разработки.

---

### **День 7: JupyterHub для ML-команды**

**Задачи:**
1. Установить JupyterHub с Docker Compose.
2. Запустить JupyterHub с кастомным ML-образом.
3. Зайти под разными пользователями, проверить, что окружение общее.

**Пример `docker-compose.yml`:**
```yaml
version: '3'
services:
  jupyterhub:
    image: jupyterhub/jupyterhub
    command: jupyterhub -f /srv/jupyterhub/jupyterhub_config.py
    ports:
      - "8000:8000"
    volumes:
      - ./jupyterhub_config.py:/srv/jupyterhub/jupyterhub_config.py
```

**Полезные замечания:**
- JupyterHub позволяет каждому пользователю иметь изолированное окружение.
- Удобно для команд, где каждый работает над своими ML-ноутбуками.

---

### **День 8: CI/CD для ML-ноутбуков**

**Задачи:**
1. Настроить CI/CD (например, GitLab CI).
2. Добавить шаг: запуск ноутбука через `papermill`.
3. Проверить, что ячейки не содержат ошибок.

**Пример `.gitlab-ci.yml`:**
```yaml
test-notebook:
  image: python:3.9
  script:
    - pip install papermill jupyter
    - papermill input_notebook.ipynb output_notebook.ipynb
```

**Полезные замечания:**
- CI/CD позволяет проверять ML-ноутбуки на воспроизводимость и ошибки.
- Автоматизированные проверки — важная часть MLops.

---

### **День 9: ML-инференс в ноутбуке**

**Задачи:**
1. Загрузить обученную модель (например, через `joblib`).
2. Сделать предсказания на новых данных.
3. Рассчитать метрики на новых данных, визуализировать.

**Пример кода:**
```python
import joblib

model = joblib.load('model.pkl')
new_data = pd.read_csv('new_data.csv')
predictions = model.predict(new_data)
```

**Полезные замечания:**
- Ноутбуки удобны для отладки и тестирования инференса.
- Храните модели отдельно от ноутбуков.

---

### **День 10: Финальный проект**

**Задачи:**
1. Создать ML-ноутбук: EDA → обучение модели → сохранение → инференс.
2. Собрать Docker-образ с ML-библиотеками.
3. Запустить ноутбук в JupyterHub.
4. Настроить CI/CD, который проверяет выполнение ноутбука.

**Полезные замечания:**
- Это интеграционный проект: покрывает все аспекты ML-разработки в Jupyter.
- Результат — готовый шаблон для ML-проектов в вашей команде.

---

## 📁 **Примерная структура репозитория:**
```
ml-jupyter-training/
├── day1-eda/
├── day2-modeling/
├── day3-pipeline/
├── day4-refactoring/
├── day5-database/
├── day6-docker/
├── day7-jupyterhub/
├── day8-cicd/
├── day9-inference/
├── day10-project/
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
├── models/
│   └── model.pkl
├── data/
│   └── titanic.csv
└── requirements.txt
```
