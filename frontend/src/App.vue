<template>
  <div id="app">
    <div class="container">
      <header class="header">
        <h1>Quản Lý Sinh Viên</h1>
      </header>

      <div class="content">
        <div class="form-section">
          <h2>{{ editingStudent ? 'Cập nhật' : 'Thêm mới' }} Sinh Viên</h2>
          <form @submit.prevent="saveStudent" class="student-form">
            <div class="form-group">
              <label>Mã Sinh Viên *</label>
              <input
                v-model="form.student_code"
                type="text"
                required
                placeholder="VD: SV001"
                :disabled="editingStudent"
              />
            </div>

            <div class="form-group">
              <label>Họ và Tên *</label>
              <input
                v-model="form.full_name"
                type="text"
                required
                placeholder="VD: Nguyễn Văn An"
              />
            </div>

            <div class="form-group">
              <label>Email</label>
              <input
                v-model="form.email"
                type="email"
                placeholder="VD: nguyenvanan@example.com"
              />
            </div>

            <div class="form-group">
              <label>Số Điện Thoại</label>
              <input
                v-model="form.phone"
                type="tel"
                placeholder="VD: 0912345678"
              />
            </div>

            <div class="form-group">
              <label>Ngày Sinh</label>
              <input
                v-model="form.date_of_birth"
                type="date"
              />
            </div>

            <div class="form-group">
              <label>Lớp</label>
              <input
                v-model="form.class_name"
                type="text"
                placeholder="VD: CNTT2020A"
              />
            </div>

            <div class="form-actions">
              <button type="submit" class="btn btn-primary">
                {{ editingStudent ? 'Cập nhật' : 'Thêm mới' }}
              </button>
              <button
                v-if="editingStudent"
                type="button"
                @click="cancelEdit"
                class="btn btn-secondary"
              >
                Hủy
              </button>
            </div>
          </form>
        </div>

        <div class="list-section">
          <h2>Danh Sách Sinh Viên ({{ students.length }})</h2>
          
          <div v-if="loading" class="loading">Đang tải...</div>
          <div v-else-if="error" class="error">{{ error }}</div>
          <div v-else-if="students.length === 0" class="empty">
            Chưa có sinh viên nào. Hãy thêm sinh viên đầu tiên!
          </div>
          <table v-else class="students-table">
            <thead>
              <tr>
                <th>Mã SV</th>
                <th>Họ và Tên</th>
                <th>Email</th>
                <th>Điện Thoại</th>
                <th>Ngày Sinh</th>
                <th>Lớp</th>
                <th>Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="student in students" :key="student.id">
                <td>{{ student.student_code }}</td>
                <td>{{ student.full_name }}</td>
                <td>{{ student.email || '-' }}</td>
                <td>{{ student.phone || '-' }}</td>
                <td>{{ formatDate(student.date_of_birth) }}</td>
                <td>{{ student.class_name || '-' }}</td>
                <td>
                  <button
                    @click="editStudent(student)"
                    class="btn btn-small btn-edit"
                  >
                    Sửa
                  </button>
                  <button
                    @click="deleteStudent(student.id)"
                    class="btn btn-small btn-delete"
                  >
                    Xóa
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

const API_URL = process.env.VUE_APP_API_URL || 'http://localhost:8000/api'

export default {
  name: 'App',
  data() {
    return {
      students: [],
      loading: false,
      error: null,
      editingStudent: null,
      form: {
        student_code: '',
        full_name: '',
        email: '',
        phone: '',
        date_of_birth: '',
        class_name: ''
      }
    }
  },
  mounted() {
    this.fetchStudents()
  },
  methods: {
    async fetchStudents() {
      this.loading = true
      this.error = null
      try {
        const response = await axios.get(`${API_URL}/students`)
        this.students = response.data
      } catch (error) {
        this.error = 'Không thể tải danh sách sinh viên: ' + (error.message || 'Lỗi không xác định')
        console.error('Error fetching students:', error)
      } finally {
        this.loading = false
      }
    },
    async saveStudent() {
      try {
        if (this.editingStudent) {
          await axios.put(`${API_URL}/students/${this.editingStudent.id}`, this.form)
        } else {
          await axios.post(`${API_URL}/students`, this.form)
        }
        this.resetForm()
        this.fetchStudents()
      } catch (error) {
        alert('Lỗi: ' + (error.response?.data?.message || error.message))
        console.error('Error saving student:', error)
      }
    },
    editStudent(student) {
      this.editingStudent = student
      this.form = {
        student_code: student.student_code,
        full_name: student.full_name,
        email: student.email || '',
        phone: student.phone || '',
        date_of_birth: student.date_of_birth || '',
        class_name: student.class_name || ''
      }
      window.scrollTo({ top: 0, behavior: 'smooth' })
    },
    cancelEdit() {
      this.editingStudent = null
      this.resetForm()
    },
    async deleteStudent(id) {
      if (!confirm('Bạn có chắc chắn muốn xóa sinh viên này?')) {
        return
      }
      try {
        await axios.delete(`${API_URL}/students/${id}`)
        this.fetchStudents()
      } catch (error) {
        alert('Lỗi khi xóa sinh viên: ' + (error.response?.data?.message || error.message))
        console.error('Error deleting student:', error)
      }
    },
    resetForm() {
      this.form = {
        student_code: '',
        full_name: '',
        email: '',
        phone: '',
        date_of_birth: '',
        class_name: ''
      }
      this.editingStudent = null
    },
    formatDate(date) {
      if (!date) return '-'
      return new Date(date).toLocaleDateString('vi-VN')
    }
  }
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  padding: 20px;
}

#app {
  max-width: 1400px;
  margin: 0 auto;
}

.container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 30px;
  text-align: center;
}

.header h1 {
  font-size: 2.5em;
  font-weight: 600;
}

.content {
  padding: 30px;
  display: grid;
  grid-template-columns: 1fr 1.5fr;
  gap: 30px;
}

.form-section,
.list-section {
  background: #f8f9fa;
  padding: 25px;
  border-radius: 8px;
}

.form-section h2,
.list-section h2 {
  color: #333;
  margin-bottom: 20px;
  font-size: 1.5em;
}

.student-form {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.form-group {
  display: flex;
  flex-direction: column;
}

.form-group label {
  font-weight: 600;
  margin-bottom: 5px;
  color: #555;
}

.form-group input {
  padding: 10px;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.3s;
}

.form-group input:focus {
  outline: none;
  border-color: #667eea;
}

.form-group input:disabled {
  background: #e9ecef;
  cursor: not-allowed;
}

.form-actions {
  display: flex;
  gap: 10px;
  margin-top: 10px;
}

.btn {
  padding: 12px 24px;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.btn-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.btn-secondary {
  background: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background: #5a6268;
}

.btn-small {
  padding: 6px 12px;
  font-size: 14px;
  margin: 0 3px;
}

.btn-edit {
  background: #17a2b8;
  color: white;
}

.btn-edit:hover {
  background: #138496;
}

.btn-delete {
  background: #dc3545;
  color: white;
}

.btn-delete:hover {
  background: #c82333;
}

.students-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: 8px;
  overflow: hidden;
}

.students-table thead {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.students-table th,
.students-table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

.students-table tbody tr:hover {
  background: #f8f9fa;
}

.loading,
.error,
.empty {
  text-align: center;
  padding: 40px;
  color: #666;
  font-size: 18px;
}

.error {
  color: #dc3545;
}

@media (max-width: 1024px) {
  .content {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .students-table {
    font-size: 12px;
  }
  
  .students-table th,
  .students-table td {
    padding: 8px;
  }
  
  .header h1 {
    font-size: 1.8em;
  }
}
</style>

