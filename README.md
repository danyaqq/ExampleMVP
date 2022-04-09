# Assembly

```swift
protocol AssemblyModuleBuilderProtocol {
    static func createHomeModule() -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyModuleBuilderProtocol {
    static func createHomeModule() -> UIViewController {
        let view = HomeViewController()
        let networkService = NetworkService()
        let presenter = HomePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
}
```

# Model

```swift
struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
```

# View

```swift
protocol HomeViewProtocol: AnyObject {
    func getAllPosts()
    func showErrorAlert(error: Error)
}

final class HomeViewController: UIViewController {
    
    //Properties
    var presenter: HomePresenterProtocol?
    
    //Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    
}

//MARK: - Setup views

extension HomeViewController {
    private func setupViews() {
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        title = "Posts"
    }
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.identifier,
            for: indexPath
        ) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: presenter?.posts?[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func getAllPosts() {
        tableView.reloadData()
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
```

# Presenter

```swift
protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol, networkService: NetworkService)
    var posts: [Post]? { get set }
    func getPosts()
    func goToDetail(post: Post?)
}

class HomePresenter: HomePresenterProtocol {
    
    //Properties
    weak var view: HomeViewProtocol?
    let networkService: NetworkServiceProtocol?
    var posts: [Post]?
    
    //Init
    required init(view: HomeViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        getPosts()
    }
    
    //Methods
    func getPosts() {
        networkService?.getPosts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                    self.view?.getAllPosts()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showErrorAlert(error: error)
                }
            }
        }
    }
    
    func goToDetail(post: Post?) {
        
    }
}
```
