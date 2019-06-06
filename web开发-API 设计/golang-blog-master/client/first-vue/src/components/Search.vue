<template>
  <div id="example-1">
    <div id="title">
      <p>
        <router-link to="/">Sign in</router-link>
      </p>
      <p>
        <router-link to="/Signup">Sign up</router-link>
      </p>
    </div>
    <div>
      <button id="prev" v-on:click="prevPage()">prev</button>
      <input id="search" placeholder="搜索" v-model="content"></input>
      <button v-on:click="get()">Search</button>
      <button id="next" v-on:click="nextPage()">next</button>
    </div>
    <div id="con">
      <textarea v-model="msg" rows="30" cols="100"></textarea>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Search',
  data: function() {
    return {
      msg: "",
      content: "",
      pages: 1,
      contentTag: "",
      currentPage: 1
    };
  },
  methods: {
    get: function() {
      var flag = /^([a-z]{1,10}((\/[0-9]*)|(\/\?page\=\d)))?$/.test(this.content);
      if(!flag) {
        alert("input error");
        return;
      }
      //console.log("login:",$cookies.get("LogInUser"));
      this.$http.get("http://localhost:8080/api/" + this.content).then(
        function(res) {
          if(res.ok) {
            this.msg = JSON.stringify(res.data, null, 4);
          }
        }, function() {
          alert("error");
        });

      if(this.content != ""){
        this.getPages();
      }
    },

    getPages: function() {
      this.contentTag = this.content.split("/")[0];
      this.$http.get("http://localhost:8080/api/" + this.contentTag + "/pages").then(
        function(res) {
          this.pages = Math.ceil(parseInt(res.data)/5);
          this.currentPage = this.content.indexOf("=") != -1? parseInt(this.content.split("=")[1]) : 1;
        }, function() {
          alert("Error: can not get number of page!");
        });
    },

    prevPage: function() {
      var nowP = this.currentPage-1 >= 1? this.currentPage-1 : 1;
      this.currentPage = nowP;
      this.$http.get("http://localhost:8080/api/" + this.contentTag + "/?page=" + nowP).then(
        function(res) {
          this.msg = JSON.stringify(res.data, null, 4);
          console.log("Page: ", this.currentPage, "/", this.pages);
        }, function() {
          alert("Error: no prev page!");
        });
    },

    nextPage: function() {
      var nowP = this.currentPage+1 <= this.pages? this.currentPage+1 : this.pages;
      this.currentPage = nowP;
      this.$http.get("http://localhost:8080/api/" + this.contentTag + "/?page=" + nowP).then(
        function(res) {
          this.msg = JSON.stringify(res.data, null, 4);
          console.log("Page: ", this.currentPage, "/", this.pages);
        }, function() {
          alert("Error: no next page!");
        });
    }
  }
}
</script>

<style>
#con {
  margin-top: 10px;
}
</style>