import Index from '../components/fitbit_activities/Index.vue'
import Show from '../components/fitbit_activities/Show.vue'

export default [
  {path: '/fitbit/activities', component: Index, name: 'fitbit_activities'},
  {path: '/fitbit/activities/:id', component: Show, name: 'show_fitbit_activity'},
]

