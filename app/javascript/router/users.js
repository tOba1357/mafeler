import Show from '../components/users/Show.vue'
import Edit from '../components/users/Form.vue'

export default [
  {path: '/users', component: Show, name: 'show_user'},
  {path: '/users/edit', component: Edit, name: 'edit_user'},
]
