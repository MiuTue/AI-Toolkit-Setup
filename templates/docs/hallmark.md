# Hallmark trong AI Setup Toolkit

- Nguồn: https://github.com/Nutlope/hallmark
- Phiên bản: 2.0.0
- Commit: 7ec868225c6caa040558c321ee0fefa0e73f83a8
- Ngày tích hợp: 2026-10-27
- Giấy phép: MIT, giữ tại `.agents/skills/hallmark/LICENSE`.

Cache tại `templates/.agents/skills/hallmark/` chứa nguyên thư mục `skills/hallmark/` của upstream, gồm cả ảnh theme và fixtures. Không cần tải repo hay chạy npm khi cài skill từ toolkit. Scripts tạo ảnh có thể dùng dịch vụ bên ngoài khi được gọi; toolkit không tự chạy chúng hoặc cài hooks.

Khi cập nhật, thay toàn bộ cache bằng thư mục skill của commit upstream mới, giữ giấy phép và cập nhật commit/phiên bản trong tài liệu. Kiểm tra trước khi phát hành:

```bash
node templates/.agents/skills/hallmark/scripts/install.mjs --codex --dry-run
python3 -m unittest discover -s tests
bash -n setup.sh
```

Lệnh dry-run kiểm tra references và themes, không cài skill vào tài khoản hiện tại. Với dự án đã cài, sao lưu các tùy chỉnh và chuyển thư mục Hallmark cũ ra ngoài thư mục skills trước khi chạy lại `ai-setup skill hallmark`; toolkit giữ nguyên skill đã tồn tại.
