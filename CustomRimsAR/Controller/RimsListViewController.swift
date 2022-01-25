//
//  RimsListViewController.swift
//  CustomRimsAR
//
//  Created by Robert Vesa on 24.01.2022.
//
import UIKit
import Firebase

class RimsListViewController: UIViewController {
    @IBOutlet weak var rimsTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var rims: [Rim] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        rimsTableView.delegate = self
        rimsTableView.dataSource = self
        
        rimsTableView.register(UINib(nibName: "RimCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadRimsList()
    }
    
    func loadRimsList(){
        db.collection("rims").addSnapshotListener{ (querySnapshot, error) in

                self.rims = []

                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let rimName = data["name"] as? String,
                               let rimLink = data["link"] as? String,
                               let rimPrice = data["price"] as? Double,
                               let rimImage = data["imageName"] as? String {
                                let newRim = Rim(name: rimName, link: rimLink, price: rimPrice, imageName: rimImage)
                                self.rims.append(newRim)

                                DispatchQueue.main.async {
                                    self.rimsTableView.reloadData()
                                    let indexPath = IndexPath(row: self.rims.count - 1, section: 0)
                                    self.rimsTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }
                    }
                }
            }
    }

    
    
    
}

extension RimsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rim = rims[indexPath.row]
        
        let cell = rimsTableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! RimCell
        cell.rimName.text = rim.name
        cell.price.text = String(format:"%.2f", rim.price) + "$"
        cell.rimImage.image = UIImage(named: rim.imageName)
        return cell
    }
}

//extension RimsListViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "rimScanSegue", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! ImageViewController
//        vc.rimName = "pateu"
//    }
//}
