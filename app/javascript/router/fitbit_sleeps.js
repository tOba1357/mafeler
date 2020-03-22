import Index from '../components/fitbit_sleeps/Index.vue'
import Show from '../components/fitbit_sleeps/Show.vue'

export default [
  {path: '/fitbit/sleeps', component: Index, name: 'fitbit_sleeps'},
  {path: '/fitbit/sleeps/:id', component: Show, name: 'show_fitbit_sleep'},
]

