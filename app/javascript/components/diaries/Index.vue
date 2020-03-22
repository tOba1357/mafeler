<template>
  <div>
    <h1>
      Diary
      <router-link class="btn btn-primary" :to="{name: 'new_diary'}">作成</router-link>
    </h1>
    <div class="table-responsive">
      <table class="table table-hover diary-table">
        <thead>
        <tr>
          <th>date</th>
          <th>condition</th>
          <th>note</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="diary in diaries">
          <th>{{diary.date}}</th>
          <td align="center">
            <DegreeIcon v-if="diary.condition" :type="diary.condition" :size="30"></DegreeIcon>
          </td>
          <th><p class="note font-weight-light m-0">{{diary.note}}</p></th>
          <td>
            <div class="btn-group">
              <router-link class="btn btn-info btn-sm" :to="{name: 'show_diary', params: {date: diary.date}}">詳細
              </router-link>
              <router-link class="btn btn-warning btn-sm" :to="{name: 'edit_diary', params: {date: diary.date}}">編集
              </router-link>
              <button type="button" class="btn btn-danger btn-sm" @click="deleteDiary(diary)">削除
              </button>
            </div>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    <pagination :total-page="totalPage" :current-page="page" :to="{name: 'diaries'}" v-if="diaries.length > 0"></pagination>
  </div>
</template>

<script>
  import base from '../base'
  import DegreeIcon from '../common/DegreeIcon.vue'
  import Pagination from '../common/Pagination.vue'

  export default {
    extends: base,
    data: function () {
      return {
        diaries: [],
        page: 1,
        totalPage: null
      }
    },
    methods: {
      init: function () {
        this.loadDiaries()
      },
      loadDiaries: function () {
        const query = this.$route.query
        let path = '/diaries'
        if (query) {
          path = '/diaries?' + Object.keys(query).map((key) => {
            return `${key}=${query[key]}`
          }).join('&')
        }
        axios.get(path)
          .then((response) => {
            const data = response.data
            this.diaries = data.diaries
            this.page = parseInt(data.page)
            this.totalPage = data.total_page
            window.scrollTo(0, 0)
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
      deleteDiary: function (diary) {
        if (window.confirm('削除してもよろしいですか？')) {
          this.setLoading(false)
          axios.delete(`/diaries/${diary.date}`)
            .then(() => this.loadDiaries())
            .catch((error) => console.error(error))
        }
      },
    },
    components: {DegreeIcon, Pagination}
  }
</script>

<style lang="scss" scoped>
  .diary-table {
    .hr {
      height: 30px;
    }
    .note {
      white-space: pre-line;
      height: 45px;
      overflow: hidden;
    }
  }
</style>
