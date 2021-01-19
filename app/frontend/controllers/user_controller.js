import axios from "axios"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "followButton" ]

  follow(event) {
    event.preventDefault()
    // /users/:id/follow(.:format)
    let user=this.followButtonTarget.dataset.user
    let button=this.followButtonTarget
    axios.post(`/users/${user}/follow`)
         .then(function(response){
           let status=response.data.status
           switch(status){
             case 'sign_in_first':
                alert('你必須先登入')
                break
             default:
              button.innerHTML=status
            }
           console.log(response.data)
         })
         .catch(function(error){
          console.log(error)
         })
    console.log(user)
  }
}
