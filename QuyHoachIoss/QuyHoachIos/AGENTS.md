# Core Agent Guidelines: Spec Kit & Karpathy Principles

Mọi tác vụ lập trình và phát triển phần mềm trong dự án BẮT BUỘC tuân thủ 2 bộ nguyên tắc cốt lõi: **Spec Kit (Spec-Driven Development)** và **Karpathy Guidelines**.

---

## 1. Spec Kit (Spec-Driven Development)
1. **Spec First, Code Second**:
   - Trước khi viết code hoặc thay đổi lớn, phải phân tích rõ ràng yêu cầu (Functional & Non-functional Requirements) và thiết kế kỹ thuật (Architecture, Data Models, API interface).
   - Xác định rõ kế hoạch thực thi từng bước (Execution Plan).
2. **Deterministic Acceptance Criteria**:
   - Mỗi tính năng phải có tiêu chuẩn nghiệm thu và kiểm thử rõ ràng trước khi triển khai.
3. **Traceability**:
   - Mọi đoạn mã thêm mới hoặc thay đổi phải truy ngược được về mục tiêu đã thống nhất trong spec.

---

## 2. Karpathy Guidelines (Quy Chuẩn Code Của Andrej Karpathy)
1. **Think Before Coding**:
   - Nêu rõ các giả định (Assumptions). Nếu có điểm chưa rõ hoặc nhiều hướng giải quyết, trình bày phương án rõ ràng thay vì tự ý chọn ngầm.
2. **Simplicity First (Tối Giản Hóa)**:
   - Viết lượng code tối thiểu để giải quyết vấn đề.
   - Không tự ý thêm tính năng, không tạo abstraction thừa cho code chỉ dùng một lần.
   - Không over-engineering. Nếu viết 200 dòng mà có thể tối giản còn 50 dòng thì phải tối giản.
3. **Surgical Changes (Sửa Đổi Chính Xác)**:
   - Chỉ chỉnh sửa đúng phần code cần thiết. Không tự ý sửa đổi style, format hoặc code xung quanh không liên quan.
   - Dọn dẹp sạch sẽ những biến/hàm do chính mình làm thừa, không xóa code cũ nếu không được yêu cầu.
4. **Goal-Driven Execution**:
   - Định nghĩa tiêu chí thành công cụ thể và kiểm thử đối chiếu đến khi đạt chuẩn hoàn toàn.
