<template>
  <div>
    <h1>{{date}} Diary</h1>
    <div class="table-responsive">
      <table class="table table-bordered table-hover diary-table">
        <tbody>
        <tr>
          <th>id</th>
          <td>{{id}}</td>
        </tr>
        <tr>
          <th>食欲</th>
          <td>
            <degree-icon v-if="appetite" :type="appetite" :size="20"></degree-icon>
          </td>
        </tr>
        <tr>
          <th>やる気</th>
          <td>
            <degree-icon v-if="motivation" :type="motivation" :size="20"></degree-icon>
          </td>
        </tr>
        <tr>
          <th>体調</th>
          <td>
            <degree-icon v-if="condition" :type="condition" :size="20"></degree-icon>
          </td>
        </tr>
        <tr v-for="udi in udis">
          <th>{{udi.name}}</th>
          <td>{{findUdiValue(udi)}}</td>
        </tr>
        <tr>
          <th>note</th>
          <td class="note">{{note}}</td>
        </tr>
        </tbody>
      </table>
    </div>
    <div class="btn-group">
      <router-link class="btn btn-warning btn-sm" :to="{name: 'edit_diary', params: {date: date}}">編集
      </router-link>
      <button type="button" class="btn btn-danger btn-sm" @click="deleteDiary()">削除</button>
    </div>
  </div>
</template>

<script>
  import base from '../base'
  import {mapState} from 'vuex'
  import DegreeIcon from '../common/DegreeIcon.vue'

  export default {
    components: {DegreeIcon},
    extends: base,
    data: function () {
      return {
        id: '',
        date: '',
        appetite: '',
        motivation: '',
        condition: '',
        note: '',
        udiValues: []
      }
    },
    computed: {
      ...mapState('udis', ['udis'])
    },
    methods: {
      init: function () {
        axios.get(`/diaries/${this.$route.params.date}`)
          .then((response) => {
            const data = response.data
            Object.assign(this, {
              id: data.id,
              date: data.date,
              appetite: data.appetite,
              motivation: data.motivation,
              condition: data.condition,
              note: data.note,
              udiValues: data.user_defined_item_values
            })
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
      deleteDiary: function () {
        if (window.confirm('削除してもよろしいですか？')) {
          this.setLoading(false)
          axios.delete(`/diaries/${this.id}`)
            .then(() => this.$router.push({name: 'diaries'}))
            .catch((error) => console.error(error))
        }
      },
      findUdiValue(udi) {
        const udiValue = this.udiValues.find((v) => v.user_defined_item_id === udi.id)
        return udiValue ? udiValue.value : null
      }
    }
  }
</script>

<style lang="scss" scoped>
  .diary-table {
    tr {
      height:  40px;
    }

    .note {
      white-space: pre-line;
    }
  }
</style>
