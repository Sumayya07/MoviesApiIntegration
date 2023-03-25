//
//  ViewController.swift
//  ApiIntegration
//
//  Created by Sumayya Siddiqui on 23/03/23.
//

import UIKit
import Reachability
import MBProgressHUD

class ViewController: UIViewController {
    
    var reachability : Reachability?
    var taskelement: [TaskElement] = []
    
//    var taskelement: [Genre] = []
//    var genres: [Genre] = []
    
   

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesApi()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskelement.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as? MyTableViewCell else { return UITableViewCell() }
        let item = taskelement[indexPath.row]
//        cell.lbl1.text = "\(item.id)"
//        cell.lbl2.text = item.name
        return cell

    }
    
    
    
}


extension ViewController {
    func moviesApi() -> Void {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.movieApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    if error == nil && data != nil {
                        
                        let httpResponse = response as? HTTPURLResponse
                        print(httpResponse?.statusCode ?? 0)
                        
        

                        if httpResponse?.statusCode == 200 {
                            let loginResponse = try? JSONDecoder().decode([TaskElement].self, from: data!)
                            
                           
//                            let filterData = loginResponse?.filter({$0.mediaType == .image})
//                            print("loginResponse data >>> ", loginResponse)
//                            print("filtered data >>> ", filterData)
//
//                            self.taskelement = filterData ?? []
                            self.tableView.reloadData()
                        }
                    }
                    
                    
                }
            }
            dataTask.resume()
            
            //        else {
            //            self.SimpleAlert(withTitle: "", message: "Please Check your Internet")
            //        }
        }
    }
}
    
