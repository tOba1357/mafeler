import Form from '../components/diaries/Form.vue'
import Index from '../components/diaries/Index.vue'
import Show from '../components/diaries/Show.vue'
export default [
  {path: '/diaries', component: Index, name: 'diaries'},
  {path: '/diaries/new', component: Form, name: 'new_diary'},
  {path: '/diaries/:date/edit', component: Form, name: 'edit_diary'},
  {path: '/diaries/:date', component: Show, name: 'show_diary'},
]
