<img width="1526" height="890" alt="image" src="https://github.com/user-attachments/assets/5e0d7356-7610-479f-8eb2-74b1b3a66c1e" />
Here is a short and clear README file for your GitHub repository, based on the code you've provided.

---

Journali 📓

`Journali` is a simple, elegant journaling application for iOS built entirely with SwiftUI. It features a custom dark-mode UI with neumorphic design elements and follows the MVVM architecture for a clean and scalable codebase.
✨ Features

CRUD Operations: Create, read, and delete journal entries.

Bookmarking: Mark and unmark your favorite entries.

Sorting: Sort your journal list by entry date or bookmark status.

Search:A simple search bar to filter entries by title or body content.

Custom UI: A fully custom dark-mode interface, including:

    * Neumorphic buttons and search bar.
    
    * Custom-designed journal cards.
    
    * A custom confirmation dialog for deleting entries.
    
    * A custom alert for discarding unsaved changes.
    
Splash Screen: A simple animated splash screen on launch.

 🏗️ Architecture

This project strictly follows the **MVVM (Model-View-ViewModel)** design pattern.

Model (`JournalEntry.swift`):

    * A simple `struct` that defines the data structure for a journal entry.

* **ViewModel (`JournalViewModel.swift`):**
  
    * An `ObservableObject` class that acts as the "brain" of the app.
    * 
    * Manages the array of `journalEntries`.
    * 
    * Contains all business logic for adding, deleting, sorting, and filtering entries.
    * 
    * Handles the `searchText` and provides the `filteredEntries` to the view.
    * 

* **View (All other SwiftUI files):**

    * Responsible *only* for displaying the UI.
      
    * Reads its state directly from the `JournalViewModel`.
      
    * Calls functions on the ViewModel (e.g., `viewModel.addJournal(...)`) to perform actions.
      
    * `ContentView` (the splash screen) is the entry point that creates and owns the `JournalViewModel` using `@StateObject`.
      
