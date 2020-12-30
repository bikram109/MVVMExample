//
//  PersonFollowingCell.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 12/28/20.
//

import UIKit

protocol personFollowingCellDelegate:AnyObject {
    func personFollowingTableVieCell(_ cell:PersonFollowingCell, didtap viewModel: PersonFollowingViewModel)
}

class PersonFollowingCell: UITableViewCell {
    
    static let identifier = "person"
    
    var delegage:personFollowingCellDelegate?
    var viewModel:PersonFollowingViewModel?
    
    private let userImage:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()

    private let userName: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()

     let name:UILabel = {
        let label = UILabel()
        return label
    }()

    private let follow:UIButton = {
        let button = UIButton()
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:"person")
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(name)
        contentView.addSubview(follow)
        follow.addTarget(self, action:#selector(followTap), for: .touchUpInside)

    }
    @objc func followTap(){
        guard  let viewModel = viewModel else{
            return
        }
        var newViewModel = viewModel
        newViewModel.following = !viewModel.following
        delegage?.personFollowingTableVieCell(self,
                                              didtap: newViewModel)
        prepareForReuse()
        configure(with: newViewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func layoutSubviews() {
        super.layoutSubviews()
        let imagesize = contentView.frame.size.height - 10
        userImage.frame = CGRect(x: 5, y: 5, width: imagesize, height: imagesize)
        name.frame = CGRect(x: imagesize + 10, y: 0, width: contentView.frame.size.width - imagesize, height: contentView.frame.size.height / 2)
        userName.frame = CGRect(x: imagesize + 10, y: contentView.frame.size.height / 2, width: contentView.frame.size.width - imagesize, height: contentView.frame.size.height / 2)
        follow.frame = CGRect(x: contentView.frame.size.width - 120, y: 10, width: 110, height: contentView.frame.size.height - 20)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
    }
    
    func configure (with viewModel:PersonFollowingViewModel){
        
        self.viewModel = viewModel
        name.text = viewModel.name
        userName.text = viewModel.userName
        userImage.image = viewModel.userImage
        
        if viewModel.following{
            follow.setTitle("unfollow", for: .normal)
            follow.setTitleColor(.black, for: .normal)
            follow.backgroundColor = .white
        }else{
            follow.setTitle("follow", for: .normal)
            follow.setTitleColor(.blue, for: .normal)
            follow.backgroundColor = .red
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        userName.text = nil
        follow.setTitle(nil, for: .normal)
        imageView?.image = nil
    }

}
