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
    var taskelement: TaskElement?
    
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
        return (self.taskelement?.genres.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as? MyTableViewCell else { return UITableViewCell() }
        let item = taskelement?.genres[indexPath.row]
        cell.lbl1.text = "\(item?.id ?? 0)"
        cell.lbl2.text = item?.name
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
            
            APIManager.shared.load(urlRequest: request, type: TaskElement.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.taskelement = response
                    self.tableView.reloadData()
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}
    
