<template>
  <div id="app">
    <p>{{ testField }}</p>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>タイトル</th>
          <th>作成日時</th>
          <th>更新日時</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="task in tasks">
          <td>{{ task.id }}</td>
          <td>{{ task.title }}</td>
          <td>{{ task.createdAt }}</td>
          <td>{{ task.updatedAt }}</td>
        </tr>
      </tbody>
    </table>
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
