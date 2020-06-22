const state = {
  loggedIn: null,
  fitbitConnected: null,
  fitbitSubscribed: null,
  profileSaved: null,
  healthPlanetConnected: null,
}

const getters = {
  loggedIn: state => state.loggedIn,
  profileSaved: state => state.profileSaved,
}

const actions = {
  loadLoggedIn({commit}) {
    return axios.get('/sessions').then((response) => {
      const isLoggedIn = response.data.logged_in
      commit('setLoggedIn', isLoggedIn)
      return response
    })
  },
  loadFitbitConnected({commit}) {
    return axios.get('/fitbit').then((response) => {
      commit('setFitbitConnected', response.data.fitbit_connected)
      commit('setFitbitSubscribed', response.data.fitbit_subscribed)
      return response
    })
  },
  loadProfileSaved({commit}) {
    return axios.get('/users/saved').then((response) => {
      commit('setProfileSaved', response.data.profile_saved)
      return response
    })
  },
  loadHealthPlanetConnected({commit}) {
    return axios.get('/health_planet').then((response) => {
      commit('setHealthPlanetConnected', response.data)
      return response
    })
  },
}

const mutations = {
  setLoggedIn(state, payload) {
    state.loggedIn = payload
  },
  setFitbitConnected(state, payload) {
    state.fitbitConnected = payload
  },
  setFitbitSubscribed(state, payload) {
    state.fitbitSubscribed = payload
  },
  setProfileSaved(state, payload) {
    state.profileSaved = payload
  },
  setHealthPlanetConnected(state, payload) {
    state.healthPlanetConnected = payload
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

