import Index from '../components/fitbit_heart_rates/Index.vue'
import Show from '../components/fitbit_heart_rates/Show.vue'

export default [
  {path: '/fitbit/heart_rates', component: Index, name: 'fitbit_heart_rates'},
  {path: '/fitbit/heart_rates/:id', component: Show, name: 'show_fitbit_heart_rate'},
]

