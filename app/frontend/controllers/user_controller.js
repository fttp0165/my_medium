import axios from "axios"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "followButton","bookmark" ]

  follow(event) {
    event.preventDefault()
    // /users/:id/follow(.:format)
    let user=this.followButtonTarget.dataset.user
    let button=this.followButtonTarget
    axios.post(`/api/users/${user}/follow`)
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
  }
  bookmark(event){
    event.preventDefault()
    let link=event.currentTarget
    let slug=link.dataset.slug
    let icon=this.bookmarkTarget
    axios.post(`/api/stories/${slug}/bookmark`)
         .then(function(response){
           console.log(response.data)
           switch(response.data.status){
             case 'Bookmarked':
              icon.classList.add('fas')
              icon.classList.remove('far')
             break;
             case 'UnBookmarked':
              icon.classList.add('far')
              icon.classList.remove('fas')
             break;
           }
         })
         .catch(function(error){
           console.log(error)
         })
  }

}
