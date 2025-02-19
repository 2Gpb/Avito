# TestTaskAvito

### Описание проекта:
Проект включает постраничную загрузку товаров, удобный поиск с возможностью фильтрации, кэширование изображений для быстрой загрузки, а также плавный shimmer-эффект при подгрузке данных. 
Реализовано сохранение истории поисковых запросов, обработка empty-state при отсутствии товаров или ошибке загрузки, детальная карточка товара и удобный список покупок
с возможностью сохранять, удалять и делиться товарами.. Кроме того, предусмотрена поддержка тестов для обеспечения стабильности и надежности приложения.

### Дизайн
[Макет в Figma](https://www.figma.com/design/XO8gGlwIRKt8AhTk6Tbdje/Test-task-Avito?node-id=0-1&t=up2szI7Bw4SPyM5g-1)

### Архитектура:
**SVIP (VIPER):**

- View – Отображает интерфейс и взаимодействует с пользователем.
- Interactor – Бизнес-логика приложения.
- Presenter – Подготовка данных для пользовательского интерфейса и реализация Router'a.
- Router – Управление переходами между экранами.
- Worker – Обработка данных и сетевых запросов.

Более подробно об архитектурном шаблоне: [Статья](https://habr.com/ru/companies/wildberries/articles/798275/)


### Технологии

- Swift
- UIKit | UIView+Pin
- URLSession
- UserDefaults | CoreData
- NSCache
- XCTest

### Функционал:
**1. Экран поиска (выдача товаров) ✅** 
- Список товаров с постраничной загрузкой
- Отображение товаров в виде плитки (2 товара в ряду)
- Возможность фильтровать товары по категории или ценовому диапазону
- Поиск по тексту с сохранением 7 последних неповторяющихся запросов
- Empty-state при отсутствии товаров и Error-state при ошибке загрузки
- Shimmer-эффект при загрузке фото
- Переход на карточку товара

**2. Карточка товара ✅**
- Отображение изображения, заголовка, описания, цены и категории
- Placeholder при ошибке загрузки изображения
- Возможность добавить товар в список покупок
- Возможность перехода в список покупок 
- Возможность увеличить/уменьшить количество товара
- Возможность поделиться товаром
- Возврат на экран поиска

**3. Список покупок ✅**
- Отображение добавленных товаров с картинками, ценами и количеством
- Возможность изменить количество товара или удалить его
- Сохранение списка покупок между сессиями (персистентность)
- Возможность очистить весь список
- Синхронизация состояния с экраном поиска и карточками товаров
- Функция «поделиться» списком покупок в мессенджере или заметках
- Переход на карточку товара

### Тестирование

**Проект содержит XCTest-тесты**

- Реализованы Unit-тесты для бизнес-логики отдельных модулей

### Запуск проекта
1. ```git clone git@github.com:2Gpb/TestTaskAvito.git```
2. Открыть TestTaskAvito.xcodeproj в Xcode
3. Запустить проект


# Visual
<img src="https://github.com/user-attachments/assets/9affd266-587f-4bca-ade6-71addb38e9e6" width="358.33"/>
<img src="https://github.com/user-attachments/assets/61ed71e2-ed86-4863-82b8-c645853458c4" width="358.33"/>
<img src="https://github.com/user-attachments/assets/6e6c9f41-7bd4-4944-9b72-0cb19f551adf" width="358.33"/>
<img src="https://github.com/user-attachments/assets/932c78f0-0393-4015-b6a5-85cd0e0c0e46" width="358.33"/>
<img src="https://github.com/user-attachments/assets/813c030f-a768-426f-aefe-e9ac83bc420a" width="358.33"/>
<img src="https://github.com/user-attachments/assets/c6add688-0514-410e-85e1-c7a1c229bb24" width="358.33"/>
<img src="https://github.com/user-attachments/assets/8707e50e-689f-4e67-8579-e09e9f0f6b91" width="358.33"/>
<img src="https://github.com/user-attachments/assets/58170c31-32f6-4325-8f4e-f132f014c4ae" width="358.33"/>
<img src="https://github.com/user-attachments/assets/e69893b9-06fc-4d05-a408-69da60392b6c" width="358.33"/>
<img src="https://github.com/user-attachments/assets/f9936564-d925-449b-b06e-aa6726b034f7" width="358.33"/>

![Запись экрана 2025-02-19 в 11 45 22](https://github.com/user-attachments/assets/26cb66d5-edeb-4f7e-ae4c-38768280ba6c)
![Запись экрана 2025-02-19 в 12 01 31](https://github.com/user-attachments/assets/58a09591-070f-4503-9122-36ad5a831fbd)


