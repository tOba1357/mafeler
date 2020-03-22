import Vue from 'vue'
import VueRouter from 'vue-router'
import dashboard from './dashboard'
import users from './users'
import diaries from './diaries'
import fitbit_sleeps from './fitbit_sleeps'
import fitbit_heart_rates from './fitbit_heart_rates'
import fitbit_activities from './fitbit_activities'
import sessions from './sessions'
import settings from './settings'
import udis from './udis'
import chinese_medicine_diagnosis from './chinese_medicine_diagnosis'
import admin from './admin'
import health_planet_innerscans from './health_planet_innerscans'

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  routes: [
    {path: '/', redirect: '/login'},
    ...dashboard,
    ...users,
    ...diaries,
    ...fitbit_sleeps,
    ...fitbit_heart_rates,
    ...fitbit_activities,
    ...sessions,
    ...settings,
    ...udis,
    ...chinese_medicine_diagnosis,
    ...admin,
    ...health_planet_innerscans,
  ]
})
