import axios from "axios"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "followButton" ]

  follow(event) {
    event.preventDefault()
    // /users/:id/follow(.:format)
    let user=this.followButtonTarget.dataset.user

    axios.post(`/users/${user}/follow`)
         .then(function(response){
           console.log(response.data)
         })
         .catch(function(error){
          console.log(error)
         })
    console.log(user)
  }
}
