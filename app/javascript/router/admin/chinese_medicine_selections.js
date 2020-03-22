import Index from '../../components/admin/chinese_medicine_selections/Index'
import Form from '../../components/admin/chinese_medicine_selections/Form'
export default [
  {path: '/admin/chinese_medicine_selections', component: Index, name: 'chinese_medicine_selections'},
  {path: '/admin/chinese_medicine_selections/new', component: Form, name: 'new_chinese_medicine_selections'},
  {path: '/admin/chinese_medicine_selections/:id/edit', component: Form, name: 'edit_chinese_medicine_selections'},
]
