<template lang="pug">
  div
    h1 Diary {{$route.params.date ? $route.params.date : ''}}
    .form-group
      label Date
      datepicker(:bootstrap-styling="true" v-model="data.date" format="yyyy-MM-dd")
    .form-group
      label 食欲
      degree-radio-group(v-model="data.appetite")
    .form-group
      label やる気
      degree-radio-group(v-model="data.motivation")
    .form-group
      label 体調
      degree-radio-group(v-model="data.condition")
    .form-group(v-for="udi in udis")
      label {{udi.name}}
      input.form-control(type="number" v-model="udiValues[udi.name]")
    .form-group
      label note
      textarea.form-control(rows="4" v-model="data.note")
    button.btn.btn-primary(type="button" @click="submit") Submit
</template>

<script>
  import DegreeRadioGroup from '../common/DegreeRadioGroup.vue'
  import Datepicker from 'vuejs-datepicker';
  import base from '../base'
  import {mapState} from 'vuex'

  const INIT_DATA = {
    date: moment().format('YYYY-MM-DD'),
    appetite: '',
    motivation: '',
    condition: '',
    note: '',
  }

  export default {
    extends: base,
    data() {
      return {
        data: _.cloneDeep(INIT_DATA),
        udiValues: {}
      }
    },
    computed: {
      ...mapState('udis', ['udis'])
    },
    methods: {
      init() {
        if (this.$route.params.date) {
          axios.get(`/diaries/${this.$route.params.date}`)
            .then((response) => {
              this.setFormData(response.data)
              this.setLoading(false)
            })
            .catch((error) => console.error(error))
        } else {
          _.assign(this.data, _.cloneDeep(INIT_DATA))
          this.udiValues = this.udis.reduce((obj, udi) => {
            obj[udi.name] = ''
            return obj
          }, {})
          this.setLoading(false)
        }
      },
      setFormData(diary) {
        const date = moment(diary.date).format('YYYY-MM-DD')
        this.data = {
          date: date,
          appetite: diary.appetite,
          motivation: diary.motivation,
          condition: diary.condition,
          note: diary.note,
        }
        const udiValues = diary.user_defined_item_values
        this.udiValues = this.udis.reduce((obj, udi) => {
          const udiValue = udiValues.find((v) => v.user_defined_item_id === udi.id)
          obj[udi.name] = udiValue ? udiValue.value : ''
          return obj
        }, {})
      },
      submit() {
        this.setLoading(true)
        const paramDate = this.$route.params.date
        const {date, appetite, motivation, condition, note} = this.data
        const params = {
          diary: {
            date: date,
            appetite: appetite,
            motivation: motivation,
            condition: condition,
            note: note,
          },
          udi_values: this.udiValues
        }
        let promise = null
        if (paramDate) {
          promise = axios.put(`/diaries/${paramDate}`, params)
        } else {
          promise = axios.post(`/diaries/`, params)
        }
        promise
          .then((response) => {
            this.$router.push({name: 'show_diary', params: {date: response.data.date}})
          })
      }
    },
    components: {
      DegreeRadioGroup,
      Datepicker
    }
  }
</script>
