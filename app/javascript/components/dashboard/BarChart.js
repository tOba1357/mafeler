import { Bar } from 'vue-chartjs'

export default {
  extends: Bar,
  props: ['data', 'options'],
  watch: {
    data () {
      this.renderChart(this.data, this.options)
    },
    options () {
      this.renderChart(this.data, this.options)
    }
  },
  mounted () {
    this.renderChart(this.data, this.options)
  },
}
