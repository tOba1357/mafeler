<template>
  <nav class="paginationWrapper">
    <ul class="pagination">
      <li v-for="page in pageArray" class="page-item" :class="{active: page === currentPage}">
        <router-link class="page-link" :to="path(page)" v-if="typeof page === 'number'">{{page}}</router-link>
        <a class="page-link" v-else>{{page}}</a>
      </li>
    </ul>
  </nav>
</template>

<script>
  export default {
    props: {
      totalPage: {
        type: Number,
        required: true
      },
      currentPage: {
        type: Number,
        required: true
      },
      to: {
        type: Object,
        required: true
      }
    },
    computed: {
      pageArray: function () {
        const current = this.currentPage
        let array = [1, this.totalPage, current - 1, current, current + 1]
        array = array.sort((a, b) => {return a - b})
        array = array.filter((i) => i >= 1 && i <= this.totalPage)
          .reduce((prev, i) => {
            if (prev.indexOf(i) < 0) {
              prev.push(i)
            }
            return prev
          }, [])
        const result = [...array]
        for(let i = 1, prevPage = array[0]; i < array.length; i++) {
          if(array[i] - prevPage > 1) {
            const index = result.indexOf(array[i])
            result.splice(index, 0, '...')
          }
          prevPage = array[i]
        }
        return result;
      }
    },
    methods: {
      path: function (page) {
        const to = Object.assign({}, this.to)
        if (to.query) {
          to.query.page = page
        } else {
          to.query = {page}
        }
        return to
      }
    }
  }
</script>

<style lang="scss" scoped>
  .paginationWrapper {
    display: flex;
    width: 100%;
    align-items: center;
    justify-content: center;
  }
</style>
