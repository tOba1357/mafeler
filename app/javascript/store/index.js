import Vue from 'vue'
import Vuex from 'vuex'
import common from './modules/common'
import authentication from './modules/authentication'
import udis from './modules/udis'
import chinese_medicine_constitutions from './modules/chinese_medicine_constitutions'

Vue.use(Vuex)

const actions = {
  init({dispatch}) {
    return dispatch('authentication/loadLoggedIn')
      .then((response) => {
        if(response.data.logged_in) {
          return Promise.all([
            dispatch('authentication/loadFitbitConnected'),
            dispatch('authentication/loadProfileSaved'),
            dispatch('authentication/loadHealthPlanetConnected'),
            dispatch('udis/loadUDIs'),
            dispatch('chinese_medicine_constitutions/loadConstitutions'),
          ])
        }
        return Promise.resolve()
      })
  }
}

export default new Vuex.Store({
  actions,
  modules: {
    authentication,
    udis,
    common,
    chinese_medicine_constitutions,
  }
})

