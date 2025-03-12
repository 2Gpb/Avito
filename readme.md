# Avito

### Project Description:
The project includes paginated product loading, a convenient search with filtering capabilities, image caching for fast loading, and a smooth shimmer effect when loading data.  
It implements search query history saving, empty-state handling when no products are available or in case of a loading error, a detailed product card, and a user-friendly shopping list  
with the ability to save, delete, and share products. Additionally, test support is provided to ensure the stability and reliability of the application.

### Design
[Figma Prototype](https://www.figma.com/design/XO8gGlwIRKt8AhTk6Tbdje/Test-task-Avito?node-id=0-1&t=up2szI7Bw4SPyM5g-1)

### Architecture:
**SVIP (VIPER):**

- **View** – Displays the interface and interacts with the user.
- **Interactor** – Contains the business logic of the application.
- **Presenter** – Prepares data for the user interface and implements the Router.
- **Router** – Manages screen transitions.
- **Worker** – Handles data processing and network requests.

More details about the architectural pattern: [Article](https://habr.com/ru/companies/wildberries/articles/798275/)

### Technologies

- Swift
- UIKit | UIView+Pin
- URLSession
- UserDefaults | CoreData
- NSCache
- XCTest

### Functionality:
**1. Search Screen (Product Listing) ✅**  
- Paginated product list  
- Grid view display (2 products per row)  
- Ability to filter products by category or price range  
- Text search with the last 7 unique queries saved  
- Empty-state when no products are available and error-state for loading failures  
- Shimmer effect when loading images  
- Navigation to the product card  

**2. Product Card ✅**  
- Displays image, title, description, price, and category  
- Placeholder in case of image loading failure  
- Ability to add the product to the shopping list  
- Navigation to the shopping list  
- Ability to increase/decrease product quantity  
- Ability to share the product  
- Return to the search screen  

**3. Shopping List ✅**  
- Displays added products with images, prices, and quantities  
- Ability to change the quantity or remove a product  
- Persistent shopping list across sessions  
- Option to clear the entire list  
- State synchronization with the search screen and product cards  
- "Share" function to send the shopping list via messenger or notes  
- Navigation to the product card  

### Testing  

**The project includes XCTest tests**  

- Unit tests implemented for business logic in separate modules  

### Running the Project  
1. ```git clone git@github.com:2Gpb/TestTaskAvito.git```  
2. Open **TestTaskAvito.xcodeproj** in Xcode  
3. Run the project  


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


