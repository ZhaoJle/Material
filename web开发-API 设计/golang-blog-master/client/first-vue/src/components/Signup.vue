<template>
  <div id="signup">
    <p>
      <input id="username" type="text" placeholder="用户名" v-model="usr"></input>
    </p>
    <p>
      <input id="password" type="text" placeholder="密码" v-model="psw"></input>
    </p>
    <p>
      <button v-on:click="post()">SIGN UP</button>
    </p>
    <p>
      <router-link to="/">Back</router-link>
    </p>
  </div>
</template>

<script>
export default {
  name: 'Signup',
  data: function(){
    return {
      usr: "",
      psw: ""
    };
  },
  methods: {
    post: function() {
      this.$http.post("http://localhost:8080/register", 
        {
          username:this.usr, 
          password:this.psw
        },
        {
          withCredentials:true
        }
        ).then(
        function(res) {
          if(res.ok){
            if(res.data == "Create a account\n") {
              this.$router.push({path:'/'});
            }
            else{
              alert(res.data);
            }
          }
        },
        function(res) {
          alert(res.data);
        });
    }
  }
}
</script>
