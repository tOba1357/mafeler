const state = {
  udis: []
}

const getters = {
  udi: (state) => (id) => {
    return state.udis.find((udi) => udi.id === id)
  }
}

const actions = {
  loadUDIs({commit}) {
    return axios.get('/user_defined_items').then((response) => {
      commit('setUDIs', response.data)
      return response
    })
  },
  saveUDI({commit}, udi) {
    return axios.post('/user_defined_items', udi).then((response) => {
      commit('addUDI', response.data)
      return response
    })
  },
  updateUDI({commit}, udi) {
    return axios.put(`/user_defined_items/${udi.id}`, udi).then((response) => {
      commit('updateUDI', response.data)
      return response
    })
  },
  deleteUDI({commit}, udi) {
    return axios.delete(`/user_defined_items/${udi.id}`).then((response) => {
      commit('removeUDI', response.data)
      return response
    })
  },
}

const mutations = {
  setUDIs(state, payload) {
    state.udis = payload
  },
  addUDI(state, payload) {
    state.udis = _.concat([payload], state.udis)
  },
  updateUDI(state, payload) {
    const index = _.findIndex(state.udis, (udi) => udi.id === payload.id)
    const copied = _.clone(state.udis)
    copied[index] = payload
    state.udis = copied
  },
  removeUDI(state, payload) {
    state.udis = state.udis.filter((udi) => udi.id !== payload.id)
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
