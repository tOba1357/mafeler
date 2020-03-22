import Index from '../components/health_planet_innerscans/Index.vue'
import Show from '../components/health_planet_innerscans/Show.vue'

export default [
  {path: '/health_planet/innerscans', component: Index, name: 'health_planet_innerscans'},
  {path: '/health_planet/innerscans/:id', component: Show, name: 'show_health_planet_innerscan'},
]
