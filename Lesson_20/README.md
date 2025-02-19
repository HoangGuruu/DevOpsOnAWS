![Alt text](../Banner.png)

# 3.2 Use Git 
## Tóm tắt lệnh thường dùng hằng ngày
```sh
git config --list
git clone <repository-url>  
git status                  # Kiểm tra trạng thái
git add .                   # Thêm file vào staging
git commit -m "Message"     # Commit thay đổi
git pull origin <branch>    # Lấy code mới nhất từ remote
git push origin <branch>    # Đẩy code lên remote
git checkout <branch-name>  # Chuyển sang nhánh 
git checkout -b <branch>    # Tạo và chuyển sang nhánh mới
git merge <branch>          # Hợp nhánh
git fetch                   # Lấy thông tin từ remote (không merge)
git log                     # Check log 
git branch -d <branch-name> # Xóa nhánh đã merge
git push origin --delete develop # push thay doi 
git branch -D <branch-name> # Xóa nhánh chưa merge
```