# CurrencyFairCodeChallenge
For a better experience, the App should run on an iPhone X. As I believe it was't the purpose of the challenge to design it for any kind of device. 
 
### Architecture
For the architecture, I chose MVVM, DI and Navigator Pattern. The app is modularized in layers, following Clean Architecture guidelines, and therefore divided, from higher to lower, into:

- UserInterface
- BusinessUseCases
- Repository
- Domain

By DI containers, I manage to inject the dependencies each component needs and abstract the code from initialization. The App module sets the root view controller as the User Interface module initial view controller. It needs to know no more about the UI. User Interface Container is responsible for dealing with the initiazation of the components of each scene.

Navigations are extracted to components called Navigators to remove boilerplate code from View Controller. This would prove useful for complex navigations such as custom transitions.

### Unit and UI Testing
The architecture allows to Unit Test the different components of the App. I have coded a handful of tests as an example. My intention was not to have a 100% coverage or to test all classes available. In a normal situation, I would have tested the BusinessUseCases module as well.

### GitFlow
The repository follows GitFlow Guidlines: branches come from master, are merged in develop and finally develop is merged into master.

### Thir party libraries
I have chosen three well-known libraries that prove useful for the matter of this challenge as well as any other production App. In fact, I have used myself these frameworks in Production environment. 

- Alamofire: It simplifies HTTP requests and responses. By adding a custom url session configuration to the its session manager, I manage to cache requests to avoid unnecessary consumption of data.
- Kingfisher: Very handy when it comes to retrieving images from the Internet and more importantly caching these images.
- Mockingjay: Just for test purposes, it allows to stub and mock responses for the repository module tests.

### Requirements
This implementation I believe has the basics that were asked for the challenge:
- UI: UICollectionView with a FlowLayout. By calculating the size of the cell, I manage to display them in a 2 column grid. As the cells are reused by the collection view, the memory is managed efficiently.
- Network layer: the images are successfully fetched from the suggested API.
- Parsing: both requests are parsed into the specified domain. For the purpose of simplicity, I chose to retrieve the images for every id that I got in the first search call. Ideally, I would have manage requests from another component to avoid a heavy load of requests. Nonetheless, this is tricky and takes time and I believe was out of the scope of the challenge.
- Unit Tests: Some have been written although I'm concerned the don't cover all the code.
- Language: Swift
- Version control: GitHub

Regarding the nice to have:
- Infinite scrolling: Achieved by the DataStorePager class
- Offline mode: Kingfisher caches the images. By using a custom url session with Alamofire, the API responses are cached.
- Caching: custom url session with Alamofire
- Tap an image and open it full screen: navigation to a new scene by a modal transition (navigator pattern used).
- App Transport Security Support: added in the App's info.plist for the domain "api.flickr.com" and its subdomains
- Certificate pinning: same as the previous one
