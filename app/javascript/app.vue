<template>
  <div id="app">
    <p>{{ testField }}</p>
    <ul>
      <li v-for="task in tasks">
        {{ task }}
      </li>
    </ul>
    <input v-model="title">
    <button v-on:click="handleClick">
      タスク登録
    </button>
  </div>
</template>

<script>
import gql from "graphql-tag"

export default {
  data: function () {
    return {
      message: "Hello Vue!",
      title: "",
    }
  },
  apollo: {
    testField: gql`query {
      testField
    }`,
    tasks: gql`query {
      tasks {
        id
        title
        createdAt
        updatedAt
      }
    }`,
  },
  methods: {
    async handleClick() {
      const result = await this.$apollo.mutate({
        mutation: gql`mutation ($title: String!) {
          createTask(
            input: {
              title: $title
            }
          ) {
            task {
              id
              title
              createdAt
              updatedAt
            }
          }
        }`,
        variables: {
          title: this.title
        }
      }).then((data) => {
        console.log(data)
        this.tasks.push(data.data.createTask.task)
      }).catch((error) => {
        console.error(error)
      })
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
