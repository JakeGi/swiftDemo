//
//  HelpViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/15.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class HelpViewController: PubBaseViewController {

    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width:kScreenW, height: kScreenH - 64), style: UITableViewStyle.grouped)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "帮助"
        self.view.addSubview(tableView)
    }

}
extension HelpViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "下载"
        case 1:
            cell.textLabel?.text = "注意事项"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MessageHeadView
        return nil
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = DownloadViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = NotesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
   
}
