import pandas as pd

train_data = pd.read_csv('train.csv')
test_data = pd.read_csv('test.csv')
titanic_data = pd.concat([train_data, test_data], ignore_index=True)
print("Первые 10 записей:")
print(titanic_data.head(10))
print("\nРазмерность данных:", titanic_data.shape)
print("\nКоличество пустых значений в каждом столбце:")
for column in titanic_data.columns:
    null_count = titanic_data[column].isnull().sum()
    print(f"{column}: {null_count}")
print("\nТипы данных:")
print(titanic_data.dtypes)
titanic_data = titanic_data.drop(
    columns=["PassengerId", "Name", "SibSp", "Parch", "Ticket", "Fare", "Cabin", "Embarked"], axis=1)
median_age = titanic_data['Age'].median()
titanic_data['Age'].fillna(median_age, inplace=True)
isMale = []
isFemale = []
for sex in titanic_data["Sex"].values:
    gender = (0 if sex == 'male' else 1)
    isMale.append(1 - gender)
    isFemale.append(gender)
titanic_data["isMale"] = isMale
titanic_data["isFemale"] = isMale
titanic_data.drop(columns=["Sex"], axis=1)
print("\nОбновленные данные:")
print(titanic_data.head())
