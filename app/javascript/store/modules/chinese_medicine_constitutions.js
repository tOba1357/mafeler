const state = {constitutions: []}

const getters = {
  findConstitutions: state => (id) => {
     return state.constitutions.find((constitution) => constitution.id === id)
  }
}

const actions = {
  loadConstitutions({commit}) {
    return axios.get('/chinese_medicine_constitutions').then(res => {
      commit('setConstitutions', res.data)
      return res
    })
  }
}

const mutations = {
  setConstitutions(state, payload) {
    state.constitutions = payload
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
