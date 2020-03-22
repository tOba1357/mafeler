import Index from '../components/user_defined_items/Index.vue'
import New from '../components/user_defined_items/Form.vue'
import Edit from '../components/user_defined_items/Form.vue'

export default [
  {path: '/user_defined_items', component: Index, name: 'udis'},
  {path: '/user_defined_items/new', component: New, name: 'new_udi'},
  {path: '/user_defined_items/:id/edit', component: Edit, name: 'edit_udi'},
]
