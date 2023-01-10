//
//  GroceriesVC.swift
//  Wuhu
//
//  Created by Abdulqadar on 11/02/2020.
//  Copyright © 2020 Abdul Qadar. All rights reserved.
//

import UIKit

class GroceriesVC: BaseVC {

    @IBOutlet weak var groceryTable: UITableView!
    @IBOutlet weak var no: UILabel!
    
    var data = [VoucherData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewSetup()
        voucherStatus()
    }
    
    func voucherStatus(){
          
          var parameters : [String: Any]
          parameters = [
              "type"              : "active",
          ]
          
          print(parameters)
          self.showLoader()
          UserHandler.voucherActive(params: parameters as NSDictionary, success: { (successResponse) in
              self.stopAnimating()
              if successResponse.status == true {
                Applicationevents.postInfo(string: "myissued_vouchers")
                  self.data = successResponse.data
                if self.data.count == 0 {
                    self.no.isHidden = false
                }
                  self.groceryTable.reloadData()
              }else  {
//                  self.showSwiftMessage(title: AlertTitle.warning, message: successResponse.message!, type: "error")
              }
          }) { (error) in
              self.stopAnimating()
              self.showSwiftMessage(title: AlertTitle.warning, message: (error?.message)!, type: "error")
          }
      }

}

extension GroceriesVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableViewSetup()  {
        groceryTable.dataSource = self
        groceryTable.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groceryTable.dequeueReusableCell(withIdentifier: "GroceryCell", for: indexPath) as! GroceryCell
//        if indexPath.row == 0{
//            cell.logo.image = UIImage(imageLiteralResourceName: "shoprite")
//        }else if indexPath.row == 1{
//            cell.logo.image = UIImage(imageLiteralResourceName: "checkers")
//        }else if indexPath.row == 2{
//            cell.logo.image = UIImage(imageLiteralResourceName: "hyper")
//        }else if indexPath.row == 3{
//            cell.logo.image = UIImage(imageLiteralResourceName: "usave")
//        }else if indexPath.row == 4{
//            cell.logo.image = UIImage(imageLiteralResourceName: "wool")
//        }else if indexPath.row == 5{
//            cell.logo.image = UIImage(imageLiteralResourceName: "maker")
//        }else if indexPath.row == 6{
//            cell.logo.image = UIImage(imageLiteralResourceName: "dis")
//        }else if indexPath.row == 7{
//            cell.logo.image = UIImage(imageLiteralResourceName: "pickpay")
//        }else if indexPath.row == 8{
//            cell.logo.image = UIImage(imageLiteralResourceName: "click")
//        }else if indexPath.row == 9{
//            cell.isHidden = true
//        }
        let imgUrl = URL(string: data[indexPath.row].attachmentUrl)
        cell.logo.sd_setImage(with: imgUrl, placeholderImage:UIImage(named: "placeholder"))
        cell.name.text = data[indexPath.row].voucherName
        cell.date.text = "Expired: "+self.convertDate(date: data[indexPath.row].voucherEndDate, desireFormat: "dd MMM yyyy")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objToBeSent = data[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: objToBeSent)
        
    }
}





class GroceryCell: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
