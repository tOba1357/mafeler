import { Line } from 'vue-chartjs'

export default {
  name: 'LineChart',
  extends: Line,
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
