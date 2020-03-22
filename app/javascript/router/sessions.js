import Form from '../components/sessions/Form.vue'

export default [
  {path: '/login', component: Form, name: 'login', meta: {noRequireLoggedIn: true}}
]
