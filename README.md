# PluggableDataSourceDemoApp

A demo iOS app showing how to use **protocol-oriented design** in Swift to build flexible, pluggable data sources.  
Instead of inheritance knots, this app composes tiny pieces: protocols, wrappers, and sources that can be swapped with one line.

---

## ✨ Features

- **Protocols first**
  - `DataSource` → one-shot load
  - `PagedDataSource` → paginated load
- **Sources**
  - `NetworkPostsSource` — fetch from JSONPlaceholder API
  - `LocalPostsSource` — load bundled JSON (`posts.json`)
  - `MockPostsSource` — fast, predictable for previews/tests
  - `PagedNetworkPostsSource` — API paging
- **Wrappers (decorators)**
  - `LoggingDataSource` — logs count & duration
  - `CachingDataSource` — async-safe, dedupes concurrent calls
  - `RetryDataSource` — retry transient network errors
- **UI**
  - `PostListView` — one-shot load
  - `PagedPostListView` — “Load more” paging
 
## 🚀 Getting Started

1. **Clone the repo**
   ```bash
   git clone https://github.com/himalidev/PluggableDataSourceDemoApp.git
   cd PluggableDataSourceDemoApp
