import Vue from 'vue'
import {sync} from 'vuex-router-sync'
import store from '../store'
import router from '../router'

require('bootstrap')
require('../utils/rollbar')


axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')
axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest';

router.beforeEach((to, from, next) => {
  if (!to.matched.some(record => record.meta.noRequireLoggedIn)) {
    if (!store.getters['authentication/loggedIn']) {
      next({
        path: '/login',
        query: {redirect: to.fullPath}
      })
      return
    }
    if (!store.getters['authentication/profileSaved']) {
      const redirectPath = '/users/edit'
      if (to.path !== redirectPath) {
        next({path: '/users/edit'})
        return
      }
    }
  }
  next()
})

router.afterEach((to) => {
  if (ENV === 'production') {
    // same as views/layouts/_ga.html.slim
    const GA_TRACKING_ID = 'UA-129003776-1'
    gtag('config', GA_TRACKING_ID, {'page_path': to.path});
  }
})
sync(store, router)

document.addEventListener('DOMContentLoaded', () => {
  axios.interceptors.response.use(
    (response) => {
      // FIXME: bad integration
      if (response.data && response.data.alert_warnings) {
        store.commit('setAlertWarnings', response.data.alert_warnings)
      }
      return response
    },
    (error) => {
      switch (error.response.status) {
        case 400:
          store.commit('setError', error.response.data)
          break
        case 401:
          router.push({name: 'login'})
          break
        default:
          store.commit('setError', 'エラーが発生しました。')
      }
      store.commit('setLoading', false)
      window.scrollTo(0, 0)
      return Promise.reject(error)
    }
  )

  store.dispatch('init').finally(() => {
    new Vue({
      data: {
        loading: false,
        error: null
      },
      router,
      store
    }).$mount('#app')
  })
})
