//
//  HomeContentCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/28.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class HomeContentCell: UITableViewCell{

    var titiArr:[String] = ["扫一扫","进场登记","质量","安全","公告通知","新闻","培训","随手拍","农民工工资","拌合站","预应力张拉","压浆"]
    var imgArr:[String] = ["wd_home_scan_01","wd_home_scan_02","wd_home_scan_03","wd_home_scan_04","wd_home_scan_05","wd_home_scan_06","wd_home_scan_07","wd_home_scan_08","wd_home_scan_09","wd_home_scan_10","wd_home_scan_11","wd_home_scan_12","wd_home_scan_14","wd_home_scan_13","icon_zijinjihua","icon_nongmingongzi","icon_jiekuanshenpibiao","icon_signin","wd_home_scan_15","wd_home_scan_12_1","wd_home_scan_21","wd_home_scan_20"]
    // 父控制器 weak 修饰,防止循环引用
    private weak var parentViewController : UIViewController?
    // 滑动偏移量
    private var startOffSetX : CGFloat = 0
    private let ContentCellID = "ContentCellID"

    private lazy var layout : UICollectionViewFlowLayout = {
        // 创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW/5, height: kScreenW/4)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
//        layout.scrollDirection = .horizontal
        return layout
    }()
    // collectionView 容器
    private lazy var collectionView : UICollectionView = { [weak self] in
        
        // 创建 UICollectionView
      let collectionView = UICollectionView(frame:CGRect(x:0, y: 10, width: kScreenW, height: 300), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate =  self
        collectionView.alwaysBounceVertical = false;  // 垂直
        collectionView.alwaysBounceHorizontal = false;   // 水平
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(collectionView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

}
extension HomeContentCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titiArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath) as! HomeCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.nameLab.text = titiArr[indexPath.row] as String
        cell.btnImg.image = UIImage(named: imgArr[indexPath.row])
        return cell
        
    }
    //每个分区的内边距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(20, 20, 20, 20);
//
//    }
    //最小 item 间距
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10;
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotiRefreshHomeItem), object: self, userInfo: ["index":indexPath.row])
    }
    
    //item 的尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        return CGSize(width: kScreenW/4, height: kScreenW/4)
//    }
    //每个分区区头尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//          return CGSize (width: ScreenWidth, height: 40)
//    }
    
    
}
