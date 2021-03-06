//
//  TopNewsViewController.swift
//  News App
//
//  Created by Ammy Pandey on 24/07/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class TopNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let indicator = UIActivityIndicatorView()
    
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.frame = CGRect(x: 50, y: 200, width: 50, height: 20)
        view.addSubview(indicator)
        self.indicator.hidesWhenStopped = true
        
        
        fetchArticles()
    }
    
    
        func fetchArticles() {
            let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=techradar&sortBy=top&apiKey=7128c0bb961741b99d59fbb69011f3fc")!)
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
                //error
                if error != nil {
                    print ("Error: \(String(describing: error))")
                    return
                }
                
                self.articles = [Article]()
                // get json data
                do{
                    //store json data in new constant
                    
                    let json =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                   // print (json!)
                    
                    if let articleJson = json["articles"] as? [[String: AnyObject]] {
                        for jsonArticle in articleJson {
                            let article = Article()
                            if let title = jsonArticle["title"] as? String, let author = jsonArticle["author"] as? String, let desc = jsonArticle["description"] as? String, let url = jsonArticle["url"] as? String, let urlToImage = jsonArticle["urlToImage"] as? String{
                                
                                article.author = author
                                article.desc = desc
                                article.headline = title
                                article.imageUrl = urlToImage
                                article.url = url
                            }
                            self.articles?.append(article)
                            self.indicator.startAnimating()
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                         self.tableView.reloadData()
                    }
                   
                    
                }catch{
                    print("Error Caught \(error)")
                }
                
            }
            task.resume()
        }
        
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebController
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: true, completion: nil)
    }

    //cell config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // declaring custom cell with refrence to TableViewCell.swift
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
       // cell.titleLbl.text = "this is test"
        
        cell.titleLbl.text = self.articles?[indexPath.item].headline
        cell.discriptionLbl.text = self.articles?[indexPath.item].desc
        cell.author.text = self.articles?[indexPath.item].author
        cell.newsImg.downloadImg(from: (self.articles?[indexPath.item].imageUrl)!)
        return cell
    }
    

}

extension UIImageView {
    func downloadImg(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}















